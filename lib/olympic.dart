import 'package:flutter/material.dart';

class OlympicBoxing extends StatefulWidget {
  const OlympicBoxing({Key? key}) : super(key: key);

  @override
  State<OlympicBoxing> createState() => _OlympicBoxingState();
}

class _OlympicBoxingState extends State<OlympicBoxing> {
  var round = 0;
  var sumRedScore = 0;
  var sumBlueScore = 0;
  var redScore = [];
  var blueScore = [];
  var isRedWin = false;
  var isBlueWin = false;

  Widget _buildResetButton() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(3.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.black,
            padding: EdgeInsets.all(15),
          ),
          onPressed: () => _haddleClickedButton(0),
          child: Icon(
            Icons.clear,
            size: 30,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  void _haddleClickedButton(int cl) {
    if (round < 3) {
      round++;
      if (cl == 0xFFA00000) {
        sumRedScore += 10;
        sumBlueScore += 9;
        redScore.add(10);
        blueScore.add(9);
      } else {
        sumRedScore += 9;
        sumBlueScore += 10;
        redScore.add(9);
        blueScore.add(10);
      }
      if (round >= 3) {
        if (sumRedScore > sumBlueScore)
          isRedWin = true;
        else
          isBlueWin = true;
      }
    } else {
      isRedWin = false;
      isBlueWin = false;
      sumBlueScore = 0;
      sumRedScore = 0;
      redScore = [];
      blueScore = [];
      round = 0;
    }
    setState(() {});
  }

  Widget _buildWinnerButton(int cl) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(3.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Color(cl),
            padding: EdgeInsets.all(15),

          ),
          onPressed: () => _haddleClickedButton(cl),
          child: Icon(
            Icons.person,
            size: 30,
          ),
        ),
      ),
    );
  }

  Widget _buildRedBlueLine(int cl) {
    return Expanded(
      child: Container(
        color: Color(cl),
        height: 5,
      ),
    );
  }

  Widget _buildScoreBoard(String header, int red, int blue) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text(header /*'ROUND ${r + 1}'*/),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              red.toString() /*redScore[r].toString()*/,
              style: TextStyle(fontSize: 30),
            ),
            Text(
              blue.toString() /*blueScore[r].toString()*/,
              style: TextStyle(fontSize: 30),
            ),
          ],
        ),
        Divider(
          thickness: 1.5,
        ),
      ],
    );
  }

  Widget _buildTeamInfo(
      String name, String flag, String nation, int cl, var isWin) {
    return Padding(
      padding: const EdgeInsets.only(top: 3, bottom: 3),
      child: Row(
        children: [
          Expanded(
            child: Row(
              children: [
                Icon(
                  Icons.person,
                  size: 72,
                  color: Color(
                    cl,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 8.0, bottom: 8.0, right: 8.0),
                          child: Image.asset(
                            flag,
                            width: 40,
                          ),
                        ),
                        Text(
                          nation,
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                    Text(name),
                  ],
                )
              ],
            ),
          ),
          if (isWin)
            Icon(
              Icons.check,
              color: Colors.green,
              size: 35,
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('OLYMPIC BOXING SCORING'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'images/logo.png',
                  width: 250,
                ),
              ],
            ),
          ),
          Container(
            color: Colors.black,
            height: 23,
            child: Row(
              children: [
                Expanded(
                  child: Center(
                    child: Text(
                      'Women\'s Light(57-60kg) Semi-final',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          _buildTeamInfo('HARRINGTON Kellie Anne', 'images/flag_ireland.png',
              'IRELAND', 0xFFA00000, isRedWin),
          _buildTeamInfo('SEESONDEE Sudaporn', 'images/flag_thailand.png',
              'THAILAND', 0xFF0000A0, isBlueWin),
          SizedBox(
            height: 5,
          ),
          Row(
            children: [
              _buildRedBlueLine(0xFFA00000),
              _buildRedBlueLine(0xFF0000A0),
            ],
          ),
          SizedBox(
            height: 7,
          ),
          Expanded(
            child: Column(
              children: [
                for (var r = 0; r < round; r++)
                  _buildScoreBoard('ROUND ${r + 1}', redScore[r], blueScore[r]),
                if (round >= 3)
                  _buildScoreBoard('TOTAL', sumRedScore, sumBlueScore),
              ],
            ),
          ),
          Row(
            children: [
              if (round < 3) _buildWinnerButton(0xFFA00000),
              if (round < 3) _buildWinnerButton(0xFF0000A0),
              if (round >= 3) _buildResetButton(),
            ],
          )
        ],
      ),
    );
  }
}
