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
    # prim = {"robot": {"#{params[:operation]}_primitive": {"primitive": ""}}}

      p = PoppyApi.new
      p.danse("start")
      sleep(10)
      p.danse("stop")
  end

end
