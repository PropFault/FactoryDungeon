extends Node2D
class_name PipelineComponent
var connectedSocket;

export(float, 0,9999.9) var maxVolume = 100.0;
var fluids:Dictionary;
var fluidTypes:Dictionary;
var volume:float setget _setVolume, getVolume;

func _setVolume(var volume):
	pass

func getVolume():
	if fluids == null:
		return 0;
	var sum = 0;
	for type in fluids:
		sum += fluids[type];
	return sum;
func onComponentAttached(var socket):
	connectedSocket = socket;

func onComponentDetached():
	connectedSocket = null;
	
func isPipe():
	return false;
