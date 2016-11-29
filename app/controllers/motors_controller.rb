class MotorsController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :motor2poppy ]

  # HTTP REST API
  #--------------

  # Action name                  HTTP                                                          JSON                                                                                                                      Example of answer

  # Get the register value       GET /motor/<motor_name>/register/<register_name>              {"robot": {"get_register_value": {"motor": "", "register": ""}}}                                                          {"present_position": 30}
  # Set new value to a register  POST /motor/<motor_name>/register/<register_name>/value.json  {"robot": {"set_register_value": {"motor": "", "register": "", "value": {"arg1": "val1", "arg2": "val2", "...": "..."}}}  {}

  # Get the motors list                         GET /motor/list.json                        {"robot": {"get_motors_list": {"alias": "motors"}}}                       {'motors': ["l_elbow_y", "r_elbow_y", "r_knee_y", "head_y", "head_z"]}
  # Get the motors alias list                   GET /motor/alias/list.json                  {"robot": {"get_motors_alias": {}}}                                       {'alias': ["r_leg", "torso", "l_leg_sagitall"]}
  # Get the motors list of a specific alias     GET /motor/<alias>/list.json                {"robot": {"get_motors_list": {"alias": ""}}}                             {: ["l_elbow_y", "r_elbow_y", "r_knee_y", "head_y", "head_z"]}
  # Get the registers list of a specific motor  GET /motor/<motor_name>/register/list.json  {"robot": {"get_registers_list": {"motor": ""}}}                          {'registers': ["goal_speed", "compliant", "present_load", "id"]}

  def motor2poppy
    @m = PoppyApi.new
    call_motor_api
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

  def call_motor_api
    case params[:operation]
        when "get_register"
          @m.get_register(params[:motor], params[:arg])
        when "set_register"
         @m.set_register(params[:motor], params[:arg], params[:value])
        when "get_position"
          @m.get_register(params[:motor], "present_position")
        when "set_position"
         @m.set_register(params[:motor], "goal_position", params[:value])
        when "get_speed"
          @m.get_register(params[:motor], "present_speed")
        when "set_speed"
         @m.set_register(params[:motor], "goal_speed", params[:value])
        when "get_torque"
          @m.get_register(params[:motor], "present_load")
        when "set_torque"
         @m.set_register(params[:motor], "torque_limit", params[:value])
        else
          raise
      end
    end

  def call_list_api
    case params[:motor]
    when "motor"
      @m.list_motor
    when "alias"
      @m.list_alias
    else
      case params[:operation]
        when "list_alias_motors"
          @m.list_alias_motors(params[:motor])
        when "list_registers"
          @m.list_registers(params[:motor])
        else
          raise
      end
    end
  end
end
