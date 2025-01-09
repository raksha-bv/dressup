extends AudioStreamPlayer

const level_music = preload("res://assets/sounds/game.mp3")
const place_cloth = preload("res://assets/sounds/place_item.mp3")
const win = preload("res://assets/sounds/win.mp3")
const game_over = preload("res://assets/sounds/game_over.mp3")


func _play_music(music: AudioStream, volume=0.0):
	if stream==music:
		return
		
	stream=music
	volume_db=volume
	self.stream.loop = true
	self.stream.loop_offset = 0.0
	play()
	
func play_music():
	_play_music(level_music)
	

	
func play_FX(stream: AudioStream, volume=0.0):
	var fx_player=AudioStreamPlayer.new()
	fx_player.stream=stream
	fx_player.name="FX_PLAYER"
	fx_player.volume_db=volume
	add_child(fx_player)
	fx_player.play()
	await fx_player.finished
	fx_player.queue_free()

func play_place():
	play_FX(place_cloth)
	
func play_win():
	play_FX(win)
	
	
	
func play_game_over():
	play_FX(game_over)
