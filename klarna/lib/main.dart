import 'package:flutter/material.dart';
import 'package:flutter_klarna_inapp_sdk/flutter_klarna_inapp_sdk.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final localeController = TextEditingController(text: "en-SE");
  final countryController = TextEditingController(text: "SE");
  final designController = TextEditingController(text: null);
  KlarnaPostPurchaseEnvironment? ppeEnvironment;

  final clientIdController = TextEditingController(text: "");
  final scopeController = TextEditingController(text: "read:consumer_order");
  final redirectUriController = TextEditingController(text: "");

  final operationTokenController = TextEditingController(text: "");

  KlarnaPostPurchaseExperience? ppe;

  @override
  void initState() {
    super.initState();
    initHybridSDK();
    initEventAndErrorCallbacks();
  }

  void initHybridSDK() async {
    print("init hybrid sdk<<<<<<<<<<");
    await KlarnaHybridSDK.initialize("https://api.playground.klarna.com/");
    print("hybrid sdk>>>>>>>>>>");
    await KlarnaHybridSDK.registerEventListener((event) {
      this._showToast(context, "KlarbaHybridSDK Event: $event");
    });
  }

  void initEventAndErrorCallbacks() async {
    KlarnaCallback.registerCallback((event) {
      _showToast(context, "eventtttt: $event");
    }, (error) {
      _showToast(context, "errorrrrr: $error");
    });
  }

  void ppeInitialize(BuildContext context) async {
    this.ppe = new KlarnaPostPurchaseExperience();
    print("localeeeee      ${localeController.text}");
    print("Purchase Country      ${countryController.text}");
    final KlarnaResult? result = await ppe?.initialize(
        localeController.text, countryController.text,
        design: designController.text, environment: ppeEnvironment);
    _showToast(context, "hyyyyy: ${result.toString()}");
  }

  void ppeAuthorizationRequest(BuildContext context) async {
    final KlarnaResult? result = await ppe?.authorizationRequest(
        clientIdController.text,
        scopeController.text,
        redirectUriController.text);
    _showToast(context, result.toString());
  }

  void ppeRenderOperation(BuildContext context) async {
    final KlarnaResult? result =
        await ppe?.renderOperation(operationTokenController.text);
    _showToast(context, result.toString());
  }

  void destroy(BuildContext context) async {
    await ppe?.destroy();
    _showToast(context, "Destroyed.");
  }

  void _showToast(BuildContext context, String text) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: Text(text),
        action: SnackBarAction(
            label: 'CLOSE', onPressed: scaffold.hideCurrentSnackBar),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Builder(builder: (BuildContext context) {
        return Scaffold(
            appBar: AppBar(
              title: Text('Flutter Klarna In-App SDK Example'),
            ),
            body: Builder(builder: (BuildContext context) {
              return SingleChildScrollView(
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: Theme.of(context).scaffoldBackgroundColor,
                        ),
                      ),
                    ),
                    Positioned.fill(
                      child: Opacity(
                        opacity: .25,
                        child: FittedBox(
                          fit: BoxFit.cover,
                          child: FlutterLogo(),
                        ),
                      ),
                    ),
                    Container(
                      child: Column(children: [
                        Container(
                          child: Column(
                            children: <Widget>[
                              Text(
                                "PostPurchaseExperience.initialize",
                                style: Theme.of(context).textTheme.subtitle1,
                              ),
                              TextFormField(
                                controller: localeController,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  labelText: "Locale",
                                ),
                              ),
                              TextFormField(
                                controller: countryController,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    labelText: 'Country'),
                              ),
                              TextFormField(
                                controller: designController,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    labelText: 'Design'),
                              ),
                              DropdownButton<KlarnaPostPurchaseEnvironment>(
                                value: ppeEnvironment,
                                icon: Icon(Icons.arrow_drop_down),
                                hint: Text("Post Purchase Environment"),
                                iconSize: 24,
                                elevation: 16,
                                onChanged:
                                    (KlarnaPostPurchaseEnvironment? newValue) {
                                  setState(() {
                                    ppeEnvironment = newValue;
                                  });
                                },
                                items: KlarnaPostPurchaseEnvironment.values.map<
                                        DropdownMenuItem<
                                            KlarnaPostPurchaseEnvironment>>(
                                    (KlarnaPostPurchaseEnvironment value) {
                                  return DropdownMenuItem<
                                      KlarnaPostPurchaseEnvironment>(
                                    value: value,
                                    child: Text(value.toString()),
                                  );
                                }).toList(),
                              ),
                              MaterialButton(
                                color: Theme.of(context).accentColor,
                                child: new Text("Initialize"),
                                onPressed: () => ppeInitialize(context),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          child: Column(
                            children: <Widget>[
                              Text(
                                "PostPurchaseExperience.authorizationRequest",
                                style: Theme.of(context).textTheme.subtitle1,
                              ),
                              TextFormField(
                                controller: clientIdController,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    labelText: "Client ID"),
                              ),
                              TextFormField(
                                controller: scopeController,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    labelText: 'Scope'),
                              ),
                              TextFormField(
                                controller: redirectUriController,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    labelText: 'Redirect URI'),
                              ),
                              MaterialButton(
                                color: Theme.of(context).accentColor,
                                child: new Text("Authorization Request"),
                                onPressed: () =>
                                    ppeAuthorizationRequest(context),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          child: Column(
                            children: <Widget>[
                              Text(
                                "PostPurchaseExperience.renderOperation",
                                style: Theme.of(context).textTheme.subtitle1,
                              ),
                              TextFormField(
                                controller: operationTokenController,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    labelText: "Operation Token"),
                              ),
                              MaterialButton(
                                color: Theme.of(context).accentColor,
                                child: new Text("Render Operation"),
                                onPressed: () => ppeRenderOperation(context),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          child: Column(
                            children: <Widget>[
                              Text(
                                "PostPurchaseExperience.destroy",
                                style: Theme.of(context).textTheme.subtitle1,
                              ),
                              MaterialButton(
                                color: Theme.of(context).accentColor,
                                child: new Text("Destroy"),
                                onPressed: () => destroy(context),
                              ),
                            ],
                          ),
                        )
                      ]),
                    )
                  ],
                ),
              );
            }));
      }),
    );
  }
}
