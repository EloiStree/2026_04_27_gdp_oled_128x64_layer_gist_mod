extends Node3D

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
        array, Vector2i(0, 2), "Global Transform3D         ", true, true
    )

    # === Extract transform data ===
    var transform: Transform3D = owner.global_transform if owner else Transform3D.IDENTITY
    
    var position: Vector3 = transform.origin
    var euler: Vector3 = transform.basis.get_euler()
    var quaternion: Quaternion = transform.basis.get_rotation_quaternion()
    
    # Direction (Forward)
    var forward: Vector3 = -transform.basis.z  # Godot uses -Z as forward

    # === Print with nice formatting (2 decimal places) ===
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


# Helper function to format Vector3 with 2 decimal places
func format_vec3(v: Vector3) -> String:
    return "%.1f, %.1f, %.1f" % [v.x, v.y, v.z]
