require 'app/configuration'
module RubyAMF
  module Configuration
    ClassMappings.translate_case = true
    ParameterMappings.scaffolding = true

    ClassMappings.register(
      :actionscript  => 'Context',
      :ruby          => 'Context',
      :type          => 'active_record',
      :attributes    => ["id", "label", "created_at", "updated_at"])

    ClassMappings.register(
      :actionscript  => 'Task',
      :ruby          => 'Task',
      :type          => 'active_record',
      :attributes    => ["id", "label", "context_id", "created_at", "updated_at"])

  end
end