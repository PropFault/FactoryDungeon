extends Node2D
class_name PipelineComponent
var connectedSocket;

func onComponentAttached(var socket):
	connectedSocket = socket;

func onComponentDetached():
	connectedSocket = null;
	
func isPipe():
	return false;
