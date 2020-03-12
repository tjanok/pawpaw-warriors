extends KinematicBody2D
export(int) var speed

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var postionWeWant = position;
var velocity = Vector2();
var currentSpeed = 0;
var usingPhys = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	if(usingPhys == true):
		get_node("../PlayerPhysics").add_force(Vector2(5,5),Vector2(5,5))
		#$RigidBody2D2.applied_force = Vector2(0*delta,0)
		position = get_node("../PlayerPhysics").position
		rotation = get_node("../PlayerPhysics").rotation;
		return
# Called every frame. 'delta' is the elapsed time since the previous frame.
	var currentPos = position;
	var targetPos = postionWeWant;
	
	var distance = currentPos.distance_to(targetPos)
	var direction = ( targetPos - currentPos ).normalized()
	
	#print(distance)
	
	currentSpeed += 5 * delta

	
	velocity.x = direction.x * currentSpeed
	velocity.y = direction.y * currentSpeed
	
	if distance > 10:
		#position.x += velocity.x
		#position.y += velocity.y
		var collision = move_and_collide(velocity,false)
		if( collision ):
			print("WTF");
	else:
		currentSpeed = 0
	
	# keep phys world update
	get_node("../PlayerPhysics").position = position

func explode():
	usingPhys = true
	
func _input(event):
	# Mouse in viewport coordinates
	if event is InputEventMouseButton:
		postionWeWant = event.position
		if( event.button_index == BUTTON_RIGHT ):
			explode()
