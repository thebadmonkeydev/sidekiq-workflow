module Sidekiq
  module Workflow
    class Manager
      attr_accessor :definition

      def self.parse(workflow_definition)
        [].tap do |h|
          workflow_definition.each_with_index do |node, i|
            if node.is_a? Array
              h[i] = self.parse(node)
            else
              h[i] = Node.create({
                name: node,
                description: '',
                params: [],
                queued_ids: [],
                completed_ids: []
              }).id

            end

          end
        end
      end

      def self.execute(workflow)
        n = workflow.nodes.first

        if n.is_a? Array
          n.map do |id|
            node = Node.get(id)
            class_eval "#{node.name}.perform_async(['sidekiq-workflow', #{workflow.id}, #{node.id}])"
          end
        else
          node = Node.get(n)
          class_eval "#{node.name}.perform_async(['sidekiq-workflow', #{workflow.id}, #{node.id}])"
        end
      end
    end
  end
end
