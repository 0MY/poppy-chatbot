require 'rest-client'

class PoppyApi

  def initialize
    @uri = "#{ENV["POPPY_WEB"]}"
  end

  def init(:operation)
    call_primitive("primitive/init_position",:operation)
  end

  def head(:operation)
    call_primitive("primitive/head_idle_motion",:operation)
  end

  def dance(:operation)
    call_primitive("primitive/dance_beat_motion",:operation)
  end

  def idle(:operation)
    call_primitive("primitive/upper_body_idle_motion",:operation)
  end

  def motor_list
    # GET /motor/list.json
    #   json: {"robot": {"get_motors_list": {"alias": "motors"}}}
    #   answer exemple: {'motors': ["l_elbow_y", "r_elbow_y", "r_knee_y", "head_y", "head_z"]}
    call_list("motor", "list")
  end

  def primitive_list
    # GET /primitive/list.json
    #   json: {"robot": {"get_primitives_list": ""}}
    #   answer exemple: {'primitives': ["stand_up", "sit", "head_tracking"]}
    call_list("primitive", "list")
  end


  def call_primitive(:move, :operation)
    uri = "#{@uri}/#{:move}/#{:operation}.json"
    response = RestClient.get uri
    # case response
    # when
    #   "OK"
    # else
    #   "KO"
    # end
  end

  def call_list(:target, :operation)
    uri = "#{@uri}/#{:target}/#{:operation}.json"
    response = RestClient.get uri
    raise
  end


  # POST /motor/<motor_name>/register/<register_name>/value.json
  #   json: {"robot": {"set_register_value": {"motor": "", "register": "", "value": {"arg1": "val1", "arg2": "val2", "...": "..."}}}
  #   answer exemple: {}
end


