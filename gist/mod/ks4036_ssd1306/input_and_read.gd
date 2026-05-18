# https://raw.githubusercontent.com/EloiStree/2026_04_27_gdp_oled_128x64_layer_gist_mod/refs/heads/main/gist/mod/ks4036_ssd1306/input_and_read.gd

extends Node3D

# TO COMMUNICATE WITH THE CAR through NodePath
@onread var car_input = "$%KS4036Input"
@onread var car_read = "$%KS4036Read"

"""
# TO COMMUNICATE WITH THE CAR throught static func
# READ INFO
SensorKs4036ReadSensors.get_instance()
func is_left_line_on() -> bool:
func is_right_line_on() -> bool:
func get_front_distance_in_meter() -> float:
func get_light_intensity_left() -> float:
func get_light_intensity_right() -> float:
func get_color_line_left() -> Color:
func get_color_line_right() -> Color:
func is_power_on() -> bool:
func get_global_position() -> Vector3:
func get_global_forward_direction() -> Vector3:
func get_global_quaternion() -> Quaternion:
func get_global_euler_rotation() -> Vector3:

# SEND INPUT INFO
SensorKs4036InputRelay.get_instance()
func set_input_with_array(input_joystick: Vector2) -> void:
func set_left_wheel_percent_11(percent: float) -> void:
func set_right_wheel_percent_11(percent: float) -> void:
func set_wheels_percent_11(left_percent: float, right_percent: float) -> void:
func set_wheels_motors(top_left: bool, top_right: bool, bottom_left: bool, bottom_right: bool) -> void:
func set_top_left_motor_button(set_motor_on: bool) -> void:
func set_top_right_motor_button(set_motor_on: bool) -> void:    
func set_down_left_motor_button(set_motor_on: bool) -> void:
func set_down_right_motor_button(set_motor_on: bool) -> void:
func set_color_led_front_left(color: Color) -> void:    
func set_color_led_front_right(color: Color) -> void:
func set_color_led_under_car(color_front_left: Color, color_front_right: Color, color_back_left: Color, color_back_right: Color) -> void:
"""

func append_layer(array: Array[bool]) -> void:
    # Clear or initialize pattern
    for i in range(8192):
        array[i] = (i % 7 == 0)
   
    # Set some solid areas
    for i in range(128 * 5):
        array[i] = true
   
    for i in range(128 * 10, 128 * 12):
        array[i] = true

    # Print header
    E13ScreenBuilderPrint6x8.print_text_6x8_at_lrtd(
        array, Vector2i(0, 2), "Global Value              ", true, true
    )

    # === Extract transform data ===
    var transform: Transform3D = global_transform

    var position: Vector3 = transform.origin
    var euler: Vector3 = transform.basis.get_euler()
    var quaternion: Quaternion = transform.basis.get_rotation_quaternion()
    
    # Direction (Forward)
    var forward: Vector3 = -transform.basis.z

    # === Print with nice formatting ===
    E13ScreenBuilderPrint6x8.print_text_6x8_at_lrtd(
        array, Vector2i(2, 20), "P:" + format_vec3(position), true, true
    )
    
    E13ScreenBuilderPrint6x8.print_text_6x8_at_lrtd(
        array, Vector2i(2, 28), "E: " + format_vec3(euler), true, true
    )
    
    E13ScreenBuilderPrint6x8.print_text_6x8_at_lrtd(
        array, Vector2i(2, 36), "D: " + format_vec3(forward), true, true
    )
    
    E13ScreenBuilderPrint6x8.print_text_6x8_at_lrtd(
        array, Vector2i(2, 44), "Q:" + str(quaternion), true, true
    )


func format_vec3(v: Vector3) -> String:
    return "%.1f, %.1f, %.1f" % [v.x, v.y, v.z]
