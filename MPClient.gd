extends Node

var actions : Directory;
var tick;

func registerAction(var identifier, var action):
	actions.insert(identifier, action);

func processPackage(var package):
	pass
