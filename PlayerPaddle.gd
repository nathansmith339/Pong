extends KinematicBody2D

var speed : float = 200.0
var velocity : Vector2

var rect = Rect2(Vector2.ZERO, Vector2(10, 90))
var color = ColorN('white')

func _ready() -> void:
    $CollisionShape2D.shape.extents = rect.size / 2
    $CollisionShape2D.position = rect.size / 2

    var vp_rect = get_viewport_rect().size
#    rect = Rect2(Vector2.ZERO, Vector2(20, vp_rect.y / 2))
#    $CollisionShape2D.shape.extents = rect.size
    position = Vector2(20, vp_rect.y / 2)

func _draw() -> void:
    draw_rect(rect, color)

func _get_input() -> void:
    var direction = Vector2()
    velocity = Vector2()

    if Input.is_action_pressed('move_up'):
        direction = Vector2.UP
    if Input.is_action_pressed('move_down'):
        direction = Vector2.DOWN

    velocity = direction * speed

func _physics_process(delta: float) -> void:
    _get_input()
    move_and_collide(velocity * delta)
