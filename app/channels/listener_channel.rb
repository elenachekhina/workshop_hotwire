class ListenerChannel < ActionCable::Channel::Base
  extend Turbo::Streams::Broadcasts, Turbo::Streams::StreamName
  include Turbo::Streams::StreamName::ClassMethods

  def subscribed
    stream_from self.verified_stream_name_from_params

    station = LiveStation.find(params[:id])

    station.add_listener!
    Turbo::StreamsChannel.broadcast_replace_to "station-#{station.id}-listeners", target: "player_listeners", content: broadcast_station(station)
  end

  def unsubscribed
    station = LiveStation.find(params[:id])

    station.add_listener!(-1)
    Turbo::StreamsChannel.broadcast_replace_to "station-#{station.id}-listeners", target: "player_listeners", content: broadcast_station(station)
  end

  private

  def broadcast_station(station)
    ApplicationController.renderer.render(
      partial: "player/listeners",
      locals: { station: station }
    )
  end
end


# In subscribed!!![:broadcast_update_later_to, :broadcast_before_later_to, :broadcast_after_later_to, :broadcast_append_later_to,
# :broadcast_prepend_later_to, :broadcast_render_to, :broadcast_render_later_to, :broadcast_stream_to, :broadcast_remove_to,
# :broadcast_action_to, :broadcast_replace_to, :broadcast_update_to, :broadcast_before_to, :broadcast_after_to, :broadcast_append_to,
# :broadcast_prepend_to, :broadcast_replace_later_to, :broadcast_action_later_to, :broadcast_invoke_to, :broadcast_invoke_later_to,
# :turbo_stream_invoke_tag, :turbo_stream_action_tag, :escape_once, :tag, :class_names, :content_tag, :token_list, :cdata_section,
# :safe_join, :to_sentence, :raw, :content_for, :provide, :capture, :content_for?, :with_output_buffer, :verified_stream_name,
# :signed_stream_name, :__callbacks, :action_methods, :_subscribe_callbacks, :_subscribe_callbacks=, :_unsubscribe_callbacks,
# :_unsubscribe_callbacks=, :periodic_timers, :rescue_handlers, :periodic_timers=, :rescue_handlers=, :periodic_timers?,
# :__callbacks=, :rescue_handlers?, :__callbacks?, :state_attr_accessor, :channel_state_attributes, :rescue_with_handler,
# :handler_for_rescue, :rescue_from, :serialize_broadcasting, :broadcast_to, :broadcasting_for, :channel_name, :periodically,
# :after_unsubscribe, :on_unsubscribe, :before_subscribe, :after_subscribe, :on_subscribe, :before_unsubscribe, :descendants,
# :set_callbacks, :skip_callback, :define_callbacks, :reset_callbacks, :set_callback, :normalize_callback_params, :__update_callbacks,
# :get_callbacks, :yaml_tag, :subclasses, :attached_object, :new, :allocate, :json_creatable?, :class_attribute, :superclass,
# :remove_possible_singleton_method, :deep_dup, :thread_mattr_reader, :thread_cattr_reader, :thread_mattr_writer, :thread_cattr_writer,
# :included_modules, :include?, :ancestors, :attr, :attr_reader, :attr_writer, :attr_accessor, :thread_cattr_accessor, :instance_methods,
# :public_instance_methods, :protected_instance_methods, :private_instance_methods, :undefined_instance_methods, :constants, :const_get,
# :const_set, :const_defined?, :const_source_location, :class_variables, :remove_class_variable, :class_variable_get, :class_variable_set,
# :class_variable_defined?, :public_constant, :<, :private_constant, :deprecate_constant, :>, :redefine_singleton_method, :singleton_class?,
# :module_parent_name, :silence_redefinition_of_method, :thread_mattr_accessor, :module_parent, :delegate_missing_to, :include, :refinements,
# :attr_internal_writer, :cattr_accessor, :deprecate, :attr_internal_reader, :anonymous?, :attr_internal_accessor, :attr_internal,
# :pretty_print_cycle, :module_exec, :class_exec, :module_eval, :class_eval, :redefine_method, :remove_method, :undef_method,
# :alias_method, :method_defined?, :public_method_defined?, :private_method_defined?, :protected_method_defined?, :public_class_method,
# :private_class_method, :method_visibility, :alias_attribute, :mattr_reader, :cattr_reader, :mattr_writer, :cattr_writer,
# :mattr_accessor, :<=>, :autoload, :autoload?, :<=, :>=, :==, :===, :remove_possible_method, :instance_method, :public_instance_method,
# :define_method, :freeze, :inspect, :const_missing, :pretty_print, :as_json, :prepend, :to_s, :rake_extension, :delegate, :name,
# :module_parents, :concerning, :concern, :require_dependency, :to_json, :instance_variable_names, :duplicable?, :to_param,
# :blank?, :present?, :to_query, :acts_like?, :with_options, :instance_values, :html_safe?, :presence, :with, :presence_in,
# :to_yaml, :in?, :pretty_print_inspect, :pretty_print_instance_variables, :try!, :try, :trap, :hash, :singleton_class, :dup,
# :itself, :methods, :singleton_methods, :protected_methods, :private_methods, :public_methods, :instance_variables,
# :instance_variable_get, :instance_variable_set, :instance_variable_defined?, :remove_instance_variable, :instance_of?,
# :kind_of?, :is_a?, :display, :pretty_inspect, :debugger, :public_send, :extend, :class, :clone, :tap, :frozen?, :yield_self,
# :then, :!~, :nil?, :eql?, :respond_to?, :public_method, :method, :singleton_method, :define_singleton_method, :object_id,
# :send, :to_enum, :enum_for, :gem, :!, :equal?, :__send__, :!=, :singleton_method_added, :instance_eval, :instance_exec, :__id__]