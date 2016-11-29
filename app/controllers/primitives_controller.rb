class PrimitivesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :prim2poppy ]

  # HTTP REST API
  #--------------

  # Action name                         HTTP                                             JSON                                                                                                                              Example of answer

  # Start a primitive                   GET  /primitive/<prim>/start.json                {"robot": {"start_primitive": {"primitive": ""}}}                                                                                 {}
  # Stop a primitive                    GET  /primitive/<prim>/stop.json                 {"robot": {"stop_primitive": {"primitive": ""}}}                                                                                  {}
  # Pause a primitive                   GET  /primitive/<prim>/pause.json                {"robot": {"pause_primitive": {"primitive": ""}}}                                                                                 {}
  # Resume a primitive                  GET  /primitive/<prim>/resume.json               {"robot": {"resume_primitive": {"primitive": ""}}}                                                                                {}

  # Get the primitives list                     GET  /primitive/list.json                   {"robot": {"get_primitives_list": ""}}                                    {'primitives': ["stand_up", "sit", "head_tracking"]}
  # Get the running primitives list             GET  /primitive/running/list.json           {"robot": {"get_running_primitives_list": ""}}                            {'primitives': ["head_tracking"]}
  # Get the primitive properties list           GET  /primitive/<prim>/property/list.json   {"robot": {"get_primitive_properties_list": {"primitive": ""}}}           {"property": ["filter", "smooth"]}
  # Get a primitive property value              GET  /primitive/<prim>/property/            {"robot": {"get_primitive_property": {"primitive": "", "property": ""}}}  {"sin.amp": 30.0}
  # Set a primitive property value      POST /primitive/<prim>/property//value.json     {"robot": {"set_primitive_property": {"primitive": "", "property": "", "args": {"arg1": "val1", "arg2": "val2", "...": "..."}}}}   {}
  # Get the primitive methods list              GET  /primitive/<prim>/method/list.json     {"robot": {"get_primitive_methods_list": {"primitive": ""}}}              {"methods": ["get_tracked_faces", "start", "stop", "pause", "resume"]}
  # Call a method of a primitive                POST /primitive/<prim>/method/<meth>/args.json  {"robot": {"call_primitive_method": {"primitive": "", "method": "", "args": {"arg1": "val1", "arg2": "val2", "...": "..."}}}}

  def prim2poppy
    # params[:primitive]
    # params[:operation]
    #   prim = {"robot": {"#{params[:operation]}_primitive": {"primitive": ""}}}

    @p = PoppyApi.new
    @primitive = params[:primitive]
    @ans = call_prim_api
    respond_to do |format|
      format.js
    end
  end

  def list2poppy
    @p = PoppyApi.new
    @ans = call_list_api
    respond_to do |format|
      format.js
    end
  end

private

  def call_prim_api
    case @primitive
    when "init"
      @p.init(params[:operation])
    when "head"
      @p.head(params[:operation])
    when "dance"
      @p.dance(params[:operation])
    when "idle"
      @p.idle(params[:operation])
    else
      raise
    end
  end

  def call_list_api
    case params[:primitive]
    when "primitive"
      @p.primitive(params[:operation])
    when "running"
      @p.running(params[:operation])
    else
      raise
    end
  end
end
