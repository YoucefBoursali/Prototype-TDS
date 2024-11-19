extends Polygon2D

@onready var collision_polygon: CollisionPolygon2D = $StaticBody2D/CollisionPolygon2D

func _ready() -> void:
	collision_polygon.polygon = polygon
