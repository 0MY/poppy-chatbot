class PrimitivesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :prim2poppy ]
  # Todo Name                                HTTP                                            JSON                                                                                                                              Example of answer
  # N:   Get the primitives list             GET  /primitive/list.json                        {"robot": {"get_primitives_list": ""}}                                                                                            {'primitives': ["stand_up", "sit", "head_tracking"]}
  # O:   Get the running primitives list     GET  /primitive/running/list.json                {"robot": {"get_running_primitives_list": ""}}                                                                                    {'primitives': ["head_tracking"]}
  # O:   Start a primitive                   GET  /primitive/<prim>/start.json                {"robot": {"start_primitive": {"primitive": ""}}}                                                                                 {}
  # O:   Stop a primitive                    GET  /primitive/<prim>/stop.json                 {"robot": {"stop_primitive": {"primitive": ""}}}                                                                                  {}
  # O:   Pause a primitive                   GET  /primitive/<prim>/pause.json                {"robot": {"pause_primitive": {"primitive": ""}}}                                                                                 {}
  # O:   Resume a primitive                  GET  /primitive/<prim>/resume.json               {"robot": {"resume_primitive": {"primitive": ""}}}                                                                                {}
  # O:   Get the primitive properties list   GET  /primitive/<prim>/property/list.json        {"robot": {"get_primitive_properties_list": {"primitive": ""}}}                                                                   {"property": ["filter", "smooth"]}
  # 0:   Get a primitive property value      GET  /primitive/<prim>/property/                 {"robot": {"get_primitive_property": {"primitive": "", "property": ""}}}                                                          {"sin.amp": 30.0}
  # O:   Set a primitive property value      POST /primitive/<prim>/property//value.json     {"robot": {"set_primitive_property": {"primitive": "", "property": "", "args": {"arg1": "val1", "arg2": "val2", "...": "..."}}}}  {}
  # N:   Get the primitive methods list      GET  /primitive/<prim>/method/list.json          {"robot": {"get_primitive_methods_list": {"primitive": ""}}}                                                                      {"methods": ["get_tracked_faces", "start", "stop", "pause", "resume"]}
  # N:   Call a method of a primitive        POST /primitive/<prim>/method/<meth>/args.json  {"robot": {"call_primitive_method": {"primitive": "", "method": "", "args": {"arg1": "val1", "arg2": "val2", "...": "..."}}}}

  def prim2poppy
    # params[:primitive]
    # params[:operation]
    #   prim = {"robot": {"#{params[:operation]}_primitive": {"primitive": ""}}}

    @p = PoppyApi.new
    @ans = call_prim_api
    respond_to do |format|
      format.js
    end
  end

  def motor2poppy
    @m = PoppyApi.new
    call_motor_api
    respond_to do |format|
      format.js
    end
  end

private

  def call_prim_api
    case params[:primitive]
    when "init"
      @p.init(params[:operation])
    when "head"
      @p.head(params[:operation])
    when "dance"
      @p.dance(params[:operation])
    when "idle"
      @p.idle(params[:operation])
    when "primitive"
      @p.primitive(params[:operation])
    when "running"
      @p.running(params[:operation])
    else
      raise
    end
  end

  def call_motor_api
    case params[:operation]
    when "list"
      case params[:motor]
      when "motor"
        @m.list_motor
      when "alias"
        @m.list_alias
      else
        raise
      end
    when "list_alias_motors"
      @m.list_alias_motors(params[:motor])
    when "list_registers"
      @m.list_registers(params[:motor])
    when "register_value"
      @m.register_value(params[:motor])
    else
      raise
    end
  end
end
