import 'package:demo_frame/src/devices.dart';
import 'package:demo_frame/src/frame.dart';
import 'package:demo_frame/src/info/info.dart';
import 'package:demo_frame/src/theme.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    DeviceFrame.precache(context);
    Future.delayed(const Duration(seconds: 2));
    super.initState();
  }

  final GlobalKey screenKey = GlobalKey();
  List<DeviceInfo> allDevices = [
    Devices.ios.iPhone11,
    Devices.android.samsungNote10Plus,
  ];

  // @override
  // void initState() {
  //   this.precache(context);
  //   super.initState();
  // }
  //
  // Future<void> precache(BuildContext context) async {
  //   for (var device in _allDevices) {
  //     await precachePicture(
  //       StringPicture(SvgPicture.svgStringDecoder, device.svgFrame),
  //       context,
  //     );
  //   }
  // }

  bool isSwitched = false;

  // DeviceInfo device = allDevices[0];

  // void toggleSwitch(bool value) {
  //   if (isSwitched == false) {
  //     setState(() {
  //       isSwitched = true;
  //       device = allDevices[0];
  //     });
  //   } else {
  //     setState(() {
  //       isSwitched = false;
  //       device = _allDevices[1];
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final mediaQuery = MediaQuery.of(context);
    final color = theme.platform == TargetPlatform.iOS ? Colors.cyan : Colors.green;

    return DeviceFrameTheme(
      style: DeviceFrameStyle.light(),
      child: MaterialApp(
        title: 'Device Frame',
        theme: ThemeData(
          primarySwatch: Colors.purple,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: Scaffold(
          appBar: AppBar(
            title: Text('Device Frames'),
            actions: [],
          ),
          body: Column(
            children: [
              // Container(
              //     height: 30,
              //     alignment: Alignment.topLeft,
              //     child: Switch(
              //       onChanged: toggleSwitch,
              //       value: isSwitched,
              //       activeColor: Colors.blue,
              //       activeTrackColor: Colors.yellow,
              //       inactiveThumbColor: Colors.redAccent,
              //       inactiveTrackColor: Colors.orange,
              //     )),
              SizedBox(
                height: 10,
              ),
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Builder(
                    builder: (context) => Center(
                      child: DeviceFrame(
                        device: allDevices[0],
                        isFrameVisible: true,
                        orientation: Orientation.portrait,
                        screen: Container(
                            color: Colors.blue,
                            child: Container(
                              color: color.shade300,
                              padding: mediaQuery.padding,
                              child: Container(
                                color: color,
                                child: AnimatedPadding(
                                  duration: const Duration(milliseconds: 500),
                                  padding: EdgeInsets.only(bottom: mediaQuery.viewInsets.bottom),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text("${theme.platform}"),
                                      Text("Size: ${mediaQuery.size.width}x${mediaQuery.size.height}"),
                                      Text("PixelRatio: ${mediaQuery.devicePixelRatio}"),
                                      Text("Padding: ${mediaQuery.padding}"),
                                      Text("Insets: ${mediaQuery.viewInsets}"),
                                      Text("ViewPadding: ${mediaQuery.viewPadding}"),
                                    ],
                                  ),
                                ),
                              ),
                            )),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class FakeScreen extends StatefulWidget {
  const FakeScreen({Key? key}) : super(key: key);

  @override
  _FakeScreenState createState() => _FakeScreenState();
}

class _FakeScreenState extends State<FakeScreen> {
  bool isDelayEnded = false;

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2)).then(
      (value) => setState(
        () => isDelayEnded = true,
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final mediaQuery = MediaQuery.of(context);
    final color = theme.platform == TargetPlatform.iOS ? Colors.cyan : Colors.green;
    return Container(
      color: color.shade300,
      padding: mediaQuery.padding,
      child: Container(
        color: color,
        child: AnimatedPadding(
          duration: const Duration(milliseconds: 500),
          padding: EdgeInsets.only(bottom: mediaQuery.viewInsets.bottom),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("${theme.platform}"),
              Text("Size: ${mediaQuery.size.width}x${mediaQuery.size.height}"),
              Text("PixelRatio: ${mediaQuery.devicePixelRatio}"),
              Text("Padding: ${mediaQuery.padding}"),
              Text("Insets: ${mediaQuery.viewInsets}"),
              Text("ViewPadding: ${mediaQuery.viewPadding}"),
              if (isDelayEnded) Text("---"),
            ],
          ),
        ),
      ),
    );
  }
}
