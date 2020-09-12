extends KinematicBody2D


var ball : KinematicBody2D
var target_y : float
var target_calculated = false
const RAY_LENGTH = 3000

var speed = 300

var rect = Rect2(Vector2.ZERO, Vector2(10, 90))
var color = ColorN('white')
var offset : float

func _ready() -> void:
    $CollisionShape2D.shape.extents = rect.size / 2
    $CollisionShape2D.position = rect.size / 2

    var vp_rect = get_viewport_rect().size
    offset = vp_rect.x - rect.size.x - (rect.size.x * 2)
    position = Vector2(offset, vp_rect.y / 2)

    ball = get_tree().get_nodes_in_group('ball')[0]

    set_physics_process(false)
    yield(get_tree().create_timer(0.5), 'timeout')
    set_physics_process(true)

func _draw() -> void:
    draw_rect(rect, color)

func _physics_process(delta: float) -> void:
    var dir = ball.velocity.normalized()

    if dir.x > 0:
        if target_calculated == true:
            position.y = clamp(target_y, 0, get_viewport_rect().size.y - 90)
        else:
            calculate_target()
    else:
        target_calculated = false

func calculate_target() -> void:
    get_parent().debug_draw_lines.clear()

    var from = ball.position
    var to = ball.position + ball.velocity.normalized() * RAY_LENGTH

    get_parent().debug_draw_lines.append([from, to])

    for _i in range(10):
        var space_state = get_world_2d().direct_space_state
        var result = space_state.intersect_ray(from, to, [], 2)
        var collider = result.get('collider')

        if is_instance_valid(collider):
            if collider.is_in_group('enemy_guard'):
                set_target_y(result.position.y)
                target_calculated = true
                return

            from = result.position - (Vector2.ONE * ball.radius)
            to = from + ball.velocity.bounce(result.normal.normalized()) * RAY_LENGTH
            get_parent().debug_draw_lines.append([from, to])
            get_parent().update()


func set_target_y(value : float) -> void:
    target_y = value - rect.size.y / 2
