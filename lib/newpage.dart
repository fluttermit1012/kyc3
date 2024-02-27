import 'package:flutter/material.dart';

class AddNominee extends StatefulWidget {
  @override
  _AddNomineeState createState() => _AddNomineeState();
}

class _AddNomineeState extends State<AddNominee> {
  List<int> count = [1];
  String error = '';

  void handleClick() {
    if (count.length < 3) {
      setState(() {
        count.add(count.last + 1);
        error = '';
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.green,
            content: Text('Nominee $count added'),
            duration: Duration(seconds: 2),
          ),
        );
      });
     
    } else {
      
      setState(() {
        error = 'Maximum three nominees allowed!';
      });
    }
  }

  void handleClose() {
    setState(() {
      count.removeLast();
      error = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Add Nominee', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ElevatedButton(
                onPressed: handleClick,
                child: Row(
                  children: [
                    Icon(Icons.add),
                    Text('Add More Nominee'),
                  ],
                ),
              ),
              if (error.isNotEmpty) Text(error, style: TextStyle(color: Colors.red)),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: count.map((number) {
                    return Card(
                      elevation: 2,
                      margin: EdgeInsets.symmetric(vertical: 8),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (number != 1)
                              Align(
                                alignment: Alignment.centerRight,
                                child: IconButton(
                                  onPressed: handleClose,
                                  icon: Icon(Icons.close, color: Colors.red),
                                ),
                              ),
                            TextFormField(
                              decoration: InputDecoration(labelText: 'Name Of Nominee: $number'),
                              onChanged: (value) {
                                // Handle Name Of Nominee change
                              },
                            ),
                            TextFormField(
                              decoration: InputDecoration(labelText: 'Share of each Nominee in(%):'),
                              onChanged: (value) {
                                // Handle Share of each Nominee change
                              },
                            ),
                            DropdownButtonFormField<String>(
                              decoration: InputDecoration(labelText: 'Relation With Applicant:'),
                              value: 'Other', // Set default value or handle it based on your logic
                              onChanged: (value) {
                                // Handle Relation With Applicant change
                              },
                              items: [
                                'Other',
                                'Father',
                                'Mother',
                                'Son',
                                'Husband',
                                'Wife',
                                'Daughter',
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                             TextFormField(
                              decoration: InputDecoration(labelText: 'Name Of Nominee: $number'),
                              onChanged: (value) {
                                // Handle Name Of Nominee change
                              },
                            ),
                             DropdownButtonFormField<String>(
                              decoration: InputDecoration(labelText: 'Relation With Applicant:'),
                              value: 'Other', // Set default value or handle it based on your logic
                              onChanged: (value) {
                                // Handle Relation With Applicant change
                              },
                              items: [
                                'Other',
                                'Father',
                                'Mother',
                                'Son',
                                'Husband',
                                'Wife',
                                'Daughter',
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                             TextFormField(
                              decoration: InputDecoration(labelText: 'Name Of Nominee: $number'),
                              onChanged: (value) {
                                // Handle Name Of Nominee change
                              },
                            ),
                             DropdownButtonFormField<String>(
                              decoration: InputDecoration(labelText: 'Relation With Applicant:'),
                              value: 'Other', // Set default value or handle it based on your logic
                              onChanged: (value) {
                                // Handle Relation With Applicant change
                              },
                              items: [
                                'Other',
                                'Father',
                                'Mother',
                                'Son',
                                'Husband',
                                'Wife',
                                'Daughter',
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                             TextFormField(
                              decoration: InputDecoration(labelText: 'Name Of Nominee: $number'),
                              onChanged: (value) {
                                // Handle Name Of Nominee change
                              },
                            ),
                             TextFormField(
                              decoration: InputDecoration(labelText: 'Name Of Nominee: $number'),
                              onChanged: (value) {
                                // Handle Name Of Nominee change
                              },
                            ),
                             DropdownButtonFormField<String>(
                              decoration: InputDecoration(labelText: 'Relation With Applicant:'),
                              value: 'Other', // Set default value or handle it based on your logic
                              onChanged: (value) {
                                // Handle Relation With Applicant change
                              },
                              items: [
                                'Other',
                                'Father',
                                'Mother',
                                'Son',
                                'Husband',
                                'Wife',
                                'Daughter',
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                             TextFormField(
                              decoration: InputDecoration(labelText: 'Name Of Nominee: $number'),
                              onChanged: (value) {
                                // Handle Name Of Nominee change
                              },
                            ),
                             DropdownButtonFormField<String>(
                              decoration: InputDecoration(labelText: 'Relation With Applicant:'),
                              value: 'Other', // Set default value or handle it based on your logic
                              onChanged: (value) {
                                // Handle Relation With Applicant change
                              },
                              items: [
                                'Other',
                                'Father',
                                'Mother',
                                'Son',
                                'Husband',
                                'Wife',
                                'Daughter',
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                             TextFormField(
                              decoration: InputDecoration(labelText: 'Name Of Nominee: $number'),
                              onChanged: (value) {
                                // Handle Name Of Nominee change
                              },
                            ),
                             DropdownButtonFormField<String>(
                              decoration: InputDecoration(labelText: 'Relation With Applicant:'),
                              value: 'Other', // Set default value or handle it based on your logic
                              onChanged: (value) {
                                // Handle Relation With Applicant change
                              },
                              items: [
                                'Other',
                                'Father',
                                'Mother',
                                'Son',
                                'Husband',
                                'Wife',
                                'Daughter',
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                             TextFormField(
                              decoration: InputDecoration(labelText: 'Name Of Nominee: $number'),
                              onChanged: (value) {
                                // Handle Name Of Nominee change
                              },
                            ),
                             TextFormField(
                              decoration: InputDecoration(labelText: 'Name Of Nominee: $number'),
                              onChanged: (value) {
                                // Handle Name Of Nominee change
                              },
                            ),
                             DropdownButtonFormField<String>(
                              decoration: InputDecoration(labelText: 'Relation With Applicant:'),
                              value: 'Other', // Set default value or handle it based on your logic
                              onChanged: (value) {
                                // Handle Relation With Applicant change
                              },
                              items: [
                                'Other',
                                'Father',
                                'Mother',
                                'Son',
                                'Husband',
                                'Wife',
                                'Daughter',
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                             TextFormField(
                              decoration: InputDecoration(labelText: 'Name Of Nominee: $number'),
                              onChanged: (value) {
                                // Handle Name Of Nominee change
                              },
                            ),
                            // ... Continue with other form fields
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

