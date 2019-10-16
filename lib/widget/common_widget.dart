import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: CircularProgressIndicator());
  }
}

class EmptyWidget extends StatelessWidget {
  final String message;

  EmptyWidget(this.message);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: 20),
          Align(
            alignment: Alignment.center,
            child: Image.asset('images/no-data.png'),
          ),
          Align(
            alignment: Alignment.center,
            child: Text(message, style: TextStyle(color: Colors.grey)),
          ),
          SizedBox(height: 20)
        ],
      ),
    );
  }
}
