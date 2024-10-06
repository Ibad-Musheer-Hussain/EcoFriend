import 'package:flutter/material.dart';

void showPackagingDialog(BuildContext context, List<String> packagingTextList) {
  Map<String, String> additionalTextMap = {
    'Eco-friendly packaging':
        'This packaging is made from 100% recyclable materials.',
    'plastic':
        'The specific type of plastic is not defined and is most probably not widely recyclable. Use plastic packaging products only when necessary.',
    'PET':
        "Found in plastic bottles and are recycled in most countries. Using reusable glass or metal containers are preferrable",
    'PETE':
        "Found in plastic bottles and are recycled in most countries. Using reusable glass or metal containers are preferrable",
    "HPDE": "Thick plastic which could also be recycled",
    "PP": "Not all recycling facilities accept PP-5 plastics",
    "Lid": "Not all recycling facilities accept PP-5 plastics",
    'foam': "Not widely recyclable and ends up in landfills",
    'Aluminium': "Widely reusable and recyclable",
    'can': "Widely reusable and recyclable",
    "PVC": "PVC plastics are not recyclable",
    'glass': 'Reusable and recyclable but not durable.',
    'jar': 'Reusable and recyclable but not durable.',
    'metal': 'Recyclable and reusable when not mixed with impurities.',
    'paper': 'Biodegradable and used for packaging dry goods and recyclable.',
    'tetra':
        'Not recycled commonly as it requires specific machinery which are not widely used.',
  };

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        title: Text(
          'Package Information',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        content: packagingTextList.isNotEmpty
            ? SizedBox(
                width: double.maxFinite,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: packagingTextList.length,
                  itemBuilder: (BuildContext context, int index) {
                    String heading = packagingTextList[index];
                    String additionalText =
                        'No additional information available';

                    additionalTextMap.forEach((key, value) {
                      if (heading.toLowerCase().contains(key.toLowerCase())) {
                        additionalText = value;
                      }
                    });

                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            heading,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            additionalText,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              )
            : Text('No Packaging information available',
                style: TextStyle(fontSize: 16)),
        actions: <Widget>[
          TextButton(
            child: Text('Close'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
