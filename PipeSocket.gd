extends PipelineComponent
class_name PipeSocket

export(NodePath)var _next;
export(NodePath)var _socketOwner;
var next : PipelineComponent setget setNext, getNext;
onready var socketOwner : PipelineComponent = get_node(_socketOwner);
func _ready():
	setNext(get_node(_next));

func setNext(newNext):
	if(next != null):
		#self.remove_child(next);
		#next.remove_child(self);
		next.onComponentDetached();
	next = newNext;
	if(next != null):
		#next.remove_child(self);
		#self.add_child(next);
		next.global_position = self.global_position;
		next.onComponentAttached(self);
	
func _process(delta):
	if(next != null):
		#next.remove_child(self);
		#self.add_child(next);
		next.global_position = self.global_position;
		next.onComponentAttached(self);
func getNext():
	if(next == null):
		return null;
	if("next" in next):
		return next.next;
	return next;
