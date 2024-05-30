extends CanvasLayer

func _process(delta):
	$CanvasLayer/PointCount.text = "Coins: " + str.(Global.collectedPoints)
	
