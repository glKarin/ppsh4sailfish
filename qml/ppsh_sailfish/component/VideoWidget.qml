import QtQuick 2.0
import Sailfish.Silica 1.0
//import QtMobility.systeminfo 1.1
import QtMultimedia 5.6
import karin.ppsh 1.0

PPSHVideo {
	id: root;

	property int iBaseTime: 0;
	property Item control;
	signal endOfMedia;
	signal errorTriggered(int errno, string errstr);
	objectName: "idVideoWidget";
	
	headersEnabled: true;
	requestHeaders: [
		{
			name: "User-Agent",
			value: "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.84 Safari/537.36",
		},
		{
			name: "Referer",
			value: "https://www.bilibili.com",
		},
	];
	onErr: {
		if(error != PPSHMediaPlayer.NoError){
			root.errorTriggered(error, errorString);
			_Reset();
		}
	}
	onStatusChanged: {
		if(status == PPSHMediaPlayer.EndOfMedia)
		{
			root.seek(0);
			audio.pause();
			root.endOfMedia();
		}
	}
	//volume: (devinfo.voiceRingtoneVolume > 50 ? 50 : devinfo.voiceRingtoneVolume < 20 ? 20 : devinfo.voiceRingtoneVolume) / 100;
	focus: true
	Keys.onSpacePressed: _TogglePlaying();
	Keys.onLeftPressed: root.seek(position - 5000);
	Keys.onRightPressed: root.seek(position + 5000);
	/*
	onPlayingChanged: {
		screensaver.setScreenSaverDelayed(playing);
	}

	DeviceInfo {
		id: devinfo;
	}
	ScreenSaver{
		id: screensaver;
		//screenSaverDelayed: root.playing && !root.paused;
	}
	*/

 onPlaybackStateChanged: {
	 if(!audio.ava) return;
	 if(playbackState == PPSHMediaPlayer.PlayingState) 
	 {
		 audio.play();
		 //audio._Seek(root.position);
	 }
	 else if(playbackState == PPSHMediaPlayer.PausedState)
	 {
		 audio.pause();
		 //audio._Seek(root.position);
	 }
	 else if(playbackState == PPSHMediaPlayer.StoppedState) audio.stop();
 }

 PPSHAudio{
	 id: audio;
	 property bool loadDone: false;
	 property bool ava: audio.hasAudio && audio.source != "" && !root.hasAudio;
	 muted: root.muted;
	 volume: root.volume;
	 headersEnabled: true;
	 requestHeaders: [
		 {
			 name: "User-Agent",
			 value: "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.84 Safari/537.36",
		 },
		 {
			 name: "Referer",
			 value: "https://www.bilibili.com",
		 },
	 ];
	 function _Seek(pos)
	 {
		 if(audio.ava && root.iBaseTime + pos <= audio.duration)
		 {
			 audio.seek(root.iBaseTime + pos);
		 }
	 }
 }

 onPositionChanged: {
	 //audio._Seek(position);
 }

 function _SetFillMode(value)
 {
	 switch(value)
	 {
		 case 0:
		 fillMode = VideoOutput.Stretch;
		 break;
		 case 2:
		 fillMode = VideoOutput.PreserveAspectCrop;
		 break;
		 case 1:
		 default:
		 fillMode = VideoOutput.PreserveAspectFit;
		 break;
	 }
 }

 function _TogglePlaying(on)
 {
	 if(on === undefined) paused = !paused;
	 else
	 {
		 if(on) play();
		 else pause();
	 }
 }

 function _Stop()
 {
	 audio.stop();
	 audio._Seek(0);
	 stop();
	 root.seek(0);
 }

 function _Reset()
 {
	 _Stop();
	 audio.source = "";
	 source = "";
 }

 function _Seek(pos)
 {
	 root.seek(pos);
	 audio._Seek(pos);
 }

 function _Load(src, pos, audio_src)
 {
	 source = src;
	 if(source != "")
	 {
		 fillMode = VideoOutput.PreserveAspectFit;
		 if(audio_src)
		 {
			 audio.source = audio_src;
			 audio.play();
		 }
		 play();

		 if(pos && seekable) _Seek(pos);
	 }
 }

 function _SetPosition(pos)
 {
	 if(!seekable)
	 return;

	 if(source != "")
	 {
		 var p = pos === undefined ? 0 : pos;
		 _Seek(p);
	 }
 }

 function _SetPercent(per)
 {
	 if(!seekable)
	 return;

	 if(video.source != "")
	 {
		 var p = duration * per;
		 _Seek(p);
	 }
 }
}

