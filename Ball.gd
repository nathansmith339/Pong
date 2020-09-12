extends KinematicBody2D

var rng : RandomNumberGenerator

var velocity : Vector2
var radius = 8

func _enter_tree() -> void:
    add_to_group('ball')

func _ready() -> void:
    rng = RandomNumberGenerator.new()
    rng.randomize()

    $CollisionShape2D.shape.radius = radius

    reset_ball()

func _draw() -> void:
    draw_circle(Vector2.ZERO, radius, ColorN('white'))

func _physics_process(delta: float) -> void:
    var collision_info = move_and_collide(velocity * delta)
    if collision_info:
        if collision_info.collider.is_in_group('goals'):
            if collision_info.collider.name == 'Left':
                get_parent().score('enemy')
            else:
                get_parent().score('player')
            reset_ball()
        else:
            velocity = velocity.bounce(collision_info.normal)

func reset_ball() -> void:
    var vp_rect = get_viewport_rect().size
    position = vp_rect / 2

    set_initial_velocity()

func set_initial_velocity() -> void:
    var x = pow(-1, rng.randi_range(0, 1))
    var y = pow(-1, rng.randi_range(0, 1))
    var random_angle = deg2rad(rng.randi_range(0, 3))

    velocity = Vector2(x, y).rotated(random_angle) * 250
