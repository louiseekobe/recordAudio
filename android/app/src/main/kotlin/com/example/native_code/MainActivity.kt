package com.example.native_code

import android.content.*
import android.media.AudioManager
import android.os.*
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
    /*  private val Battery_channel = "battery"
     private val Battery_Stream_channel = "batteryStream"
     private val Battery_Event_channel = "batteryEventChannel"
     private lateinit var channel: MethodChannel
     private lateinit var channelStream: MethodChannel
     private lateinit var eventChannel: EventChannel

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        //no stream method
        channel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, Battery_channel)

        //receive data from flutter

        channel.setMethodCallHandler {
           call,
           result -> if(call.method == "getBattery"){
               val arguments = call.arguments as Map<String, String>
             val name = arguments["name"]
             val batteryLevel = getBatteryLevel()
            result.success(batteryLevel)
         }else{
             result.success(0)
         }

        }


        //stream method
        channelStream = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, Battery_Stream_channel)

        //event channel
        eventChannel = EventChannel(flutterEngine.dartExecutor.binaryMessenger, Battery_Event_channel)

        eventChannel.setStreamHandler(MyStreamHandler(context))
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        //send data on flutter
        Handler(Looper.getMainLooper()).postDelayed({
             val batteryLevel = getAudioLouder()
             channelStream.invokeMethod("reportBatteryLevel", batteryLevel)
          }, 0);

    }


    private fun getAudioLouder(): Double{
        var audioLouder : Int = 0
        var audioManager = getSystemService(Context.AUDIO_SERVICE) as AudioManager
        return audioManager.getStreamVolume(AudioManager.STREAM_MUSIC).toDouble() /
                audioManager.getStreamMaxVolume(AudioManager.STREAM_MUSIC).toDouble()
    }


    //no stream method
    private fun getBatteryLevel():Int{
        val batteryLevel : Int
        if(Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP){
            val batteryManager = getSystemService(Context.BATTERY_SERVICE) as BatteryManager
            batteryLevel = batteryManager.getIntProperty(BatteryManager.BATTERY_PROPERTY_CAPACITY)
        }else{
            val intent = ContextWrapper(applicationContext).registerReceiver(null, IntentFilter())
            batteryLevel = intent!!.getIntExtra(BatteryManager.EXTRA_LEVEL, -1) * 100/intent.getIntExtra(BatteryManager.EXTRA_SCALE,-1)
        }
        return batteryLevel
    } */
}

/* class MyStreamHandler(private val context:Context): EventChannel.StreamHandler{
    private var receiver: BroadcastReceiver? = null
    override fun onCancel(arguments: Any?) {
        context.unregisterReceiver(receiver)
        receiver = null
    }

    override fun onListen(arguments: Any?, events: EventChannel.EventSink) {
        receiver = initReceiver(events)
        context.registerReceiver(receiver, IntentFilter(Intent.ACTION_BATTERY_CHANGED))
    }

    private fun initReceiver(events: EventChannel.EventSink): BroadcastReceiver{
        return object :BroadcastReceiver(){
            override fun onReceive(context: Context?, intent: Intent?) {
                val status = intent?.getIntExtra(BatteryManager.EXTRA_STATUS, -1)
                when(status){
                    BatteryManager.BATTERY_STATUS_CHARGING->events.success("battery is charging")
                    BatteryManager.BATTERY_STATUS_FULL->events.success("battery is full")
                    BatteryManager.BATTERY_STATUS_DISCHARGING->events.success("battery is discharging")
                }
            }
        }
    }
}

 */