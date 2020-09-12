extends Node2D

func _ready() -> void:
    var vp_rect = get_viewport_rect()

    $Top.position = Vector2(vp_rect.size.x / 2, 0)
    $Top/CollisionShape2D.shape.extents = Vector2(vp_rect.size.x, 2)

    $Bottom.position = Vector2(vp_rect.size.x / 2, vp_rect.size.y)
    $Bottom/CollisionShape2D.shape.extents = Vector2(vp_rect.size.x, 2)
