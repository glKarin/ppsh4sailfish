import QtQuick 2.0
import QtMultimedia 5.6
import karin.ppsh 1.0

Item {
	id: video
	property alias fillMode:            videoOut.fillMode
	property alias orientation:         videoOut.orientation
	property alias playbackState:        player.playbackState
	property alias autoLoad:        player.autoLoad
	property alias bufferProgress:  player.bufferProgress
	property alias duration:        player.duration
	property alias error:           player.error
	property alias errorString:     player.errorString
	property alias availability:    player.availability
	property alias hasAudio:        player.hasAudio
	property alias hasVideo:        player.hasVideo
	property alias metaData:        player.metaData;
	property alias muted:           player.muted
	property alias playbackRate:    player.playbackRate
	property alias position:        player.position
	//property alias audioRole:       player.audioRole
	property alias seekable:        player.seekable
	property alias source:          player.source
	//property alias playlist:        player.playlist
	property alias status:          player.status
	property alias volume:          player.volume
	property alias autoPlay:        player.autoPlay

	property alias headersEnabled: player.headersEnabled;
	property alias requestHeaders: player.requestHeaders;

	signal pauseed;
	signal stopped;
	signal played;
	// signal playing // ORI
	property bool playing: player.playbackState == PPSHMediaPlayer.PlayingState;
	property bool paused: false;

	onPausedChanged: {
		if(paused)
		{
			//if(player.playbackState != PPSHMediaPlayer.PausedState)
			{
				player.pause();
			}
		}
		else
		{
			//if(player.playbackState != PPSHMediaPlayer.PlayingState)
			{
				player.play();
			}
		}
	}

	signal err;

	onErrorChanged: {
		root.err();
	}

	VideoOutput {
		id: videoOut
		anchors.fill: video
		source: player
	}

	PPSHMediaPlayer {
		id: player
		onPaused:  video._Paused()
		onStopped: video._Stopped()
		onPlaying: video._Playing()
	}

	function _Paused()
	{
		paused = true;
		video.pauseed();
	}

	function _Stopped()
	{
		paused = false;
		video.stopped();
	}

	function _Playing()
	{
		paused = false;
		video.played();
	}

	function play() {
		player.play();
		paused = false;
	}

	function pause() {
		player.pause();
		paused = true;
	}

	function stop() {
		player.stop();
		paused = false;
	}

	function seek(offset) {
		player.seek(offset);
	}

	function supportedAudioRoles() {
		return player.supportedAudioRoles();
	}
}
