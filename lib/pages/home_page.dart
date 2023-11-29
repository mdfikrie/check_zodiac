import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController name = TextEditingController();
  var dateBirthDay = DateTime.now();
  var isCheck = false;
  var years = 0;
  var months = 0;
  var days = 0;
  var zodiac = "";

  @override
  void initState() {
    name = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    name.dispose();
    super.dispose();
  }

  void checkUmur() {
    DateTime currentDate = DateTime.now();

    years = currentDate.year - dateBirthDay.year;
    months = currentDate.month - dateBirthDay.month;
    days = currentDate.day - dateBirthDay.day;

    if (days < 0) {
      // Hari di bulan sebelumnya
      DateTime previousMonth =
          currentDate.subtract(Duration(days: currentDate.day));
      days = DateUtils.getDaysInMonth(previousMonth.year, previousMonth.month) +
          days;
      months--;
    }

    if (months < 0) {
      // Bulan di tahun sebelumnya
      months += 12;
      years--;
    }

    zodiac = getZodiacSign(dateBirthDay.day, dateBirthDay.month);
  }

  String getZodiacSign(int day, int month) {
    if ((month == 3 && day >= 21) || (month == 4 && day <= 19)) {
      return 'Aries';
    } else if ((month == 4 && day >= 20) || (month == 5 && day <= 20)) {
      return 'Taurus';
    } else if ((month == 5 && day >= 21) || (month == 6 && day <= 20)) {
      return 'Gemini';
    } else if ((month == 6 && day >= 21) || (month == 7 && day <= 22)) {
      return 'Cancer';
    } else if ((month == 7 && day >= 23) || (month == 8 && day <= 22)) {
      return 'Leo';
    } else if ((month == 8 && day >= 23) || (month == 9 && day <= 22)) {
      return 'Virgo';
    } else if ((month == 9 && day >= 23) || (month == 10 && day <= 22)) {
      return 'Libra';
    } else if ((month == 10 && day >= 23) || (month == 11 && day <= 21)) {
      return 'Scorpio';
    } else if ((month == 11 && day >= 22) || (month == 12 && day <= 21)) {
      return 'Sagittarius';
    } else if ((month == 12 && day >= 22) || (month == 1 && day <= 19)) {
      return 'Capricorn';
    } else if ((month == 1 && day >= 20) || (month == 2 && day <= 18)) {
      return 'Aquarius';
    } else if ((month == 2 && day >= 19) || (month == 3 && day <= 20)) {
      return 'Pisces';
    } else {
      return 'Unknown';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Check Zodiac"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Row(
              children: [
                const Text("Nama : "),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: SizedBox(
                    height: 50,
                    child: TextField(
                      controller: name,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                const Text("Tanggal Lahir : "),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      showDatePicker(
                        context: context,
                        initialDate: dateBirthDay,
                        firstDate: DateTime(1800, 8),
                        lastDate: DateTime(3000, 8),
                      ).then((value) {
                        if (value != null && value != dateBirthDay) {
                          dateBirthDay = value;
                        }
                      });
                    },
                    child: Container(
                      height: 50,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: Colors.grey),
                      ),
                      child:
                          Text("${DateFormat("d/M/y").format(dateBirthDay)}"),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    isCheck = true;
                    checkUmur();
                  });
                },
                child: const Text("Check Zodiac"),
              ),
            ),
            const SizedBox(height: 30),
            (isCheck == true)
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Hallo ${name.text},"),
                      const Text("Usia anda saat ini adalah:"),
                      Text("$years Tahun"),
                      Text("$months Bulan"),
                      Text("$days Hari"),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text("Bintang anda adalah"),
                      Text("$zodiac"),
                    ],
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
