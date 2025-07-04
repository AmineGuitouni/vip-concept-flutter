import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:localboss/features/ai/viewModels/ai_settings.dart';
import 'package:provider/provider.dart';

class AiSettings extends StatefulWidget {
  const AiSettings({super.key});

  @override
  State<AiSettings> createState() => _AiSettingsState();
}

class _AiSettingsState extends State<AiSettings> {
  AiSettingsProvider? currentProvider;
  TextEditingController textController = TextEditingController();
  @override
  void initState() {
    textController.text = Provider.of<AiSettingsProvider>(context, listen: false).customOptions;
    super.initState();
  }

  @override
  void dispose(){
    currentProvider?.setCustomOptions(textController.text);
    currentProvider?.saveToDB();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AiSettingsProvider>(builder: (context, value, child) {
      currentProvider = value;
      
      return Container(
        height: 600 - MediaQuery.of(context).viewInsets.bottom / 2,
        width: double.maxFinite,
        padding: const EdgeInsets.all(24.0),
        margin: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Icon(Ionicons.arrow_back),
                      ),
                      const SizedBox(
                        width: 50,
                      ),
                      const Text("AI Settings",
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(Ionicons.help))
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                height: 500,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Tone of voice",
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold)),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text("Professional",
                            style: TextStyle(fontSize: 18)),
                            Expanded(
                              child: Slider(
                                  value: value.value1,
                                  onChanged: value.changeValue1,
                                  divisions: 5),
                            ),
                            const Text("Casual",
                                style: TextStyle(fontSize: 18)),
                          ]),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text("Reversed",
                                style: TextStyle(fontSize: 18)),
                            Expanded(
                              child: Slider(
                                  value: value.value2,
                                  onChanged: value.changeValue2,
                                  divisions: 5),
                            ),
                            const Text("Enthus", style: TextStyle(fontSize: 18))
                          ]),
                      Divider(
                        color: Colors.grey[700],
                        height: 60,
                      ),
                      Text("Use of emojis: ${value.useEmojis ? "Yes" : "No"}",
                          style: const TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold)),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text("${value.useEmojis ? "Yes" : "No"} Emojis",
                              style: const TextStyle(fontSize: 18)),
                          const SizedBox(
                            width: 10,
                          ),
                          Switch(
                              value: value.useEmojis,
                              onChanged: value.toggleEmojis)
                        ],
                      ),
                      Divider(
                        color: Colors.grey[700],
                        height: 60,
                      ),
                      const Text("Response length",
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold)),
                      Column(
                        children: [
                          ListTile(
                            title: const Text('Short'),
                            leading: Radio<String>(
                              value: "short",
                              groupValue: value.responseLength,
                              onChanged: (String? newValue) {
                                if (newValue != null) {
                                  value.toggleResponseLength(newValue);
                                }
                              },
                            ),
                          ),
                          ListTile(
                            title: const Text('Medium'),
                            leading: Radio<String>(
                              value: "medium",
                              groupValue: value.responseLength,
                              onChanged: (String? newValue) {
                                if (newValue != null) {
                                  value.toggleResponseLength(newValue);
                                }
                              },
                            ),
                          ),
                          ListTile(
                            title: const Text('Long'),
                            leading: Radio<String>(
                              value: "long",
                              groupValue: value.responseLength,
                              onChanged: (String? newValue) {
                                if (newValue != null) {
                                  value.toggleResponseLength(newValue);
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                      Divider(
                        color: Colors.grey[700],
                        height: 60,
                      ),
                      const Text("Custom Instructions",
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold)),
                      const SizedBox(
                        height: 10,
                      ),
                      TextField(
                        minLines: 3,
                        maxLines: 7,
                        controller: textController,
                        decoration: InputDecoration(
                            hintText:
                                "Add custom instructions for the AI to follow...",
                            border: OutlineInputBorder()),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ElevatedButton(
                            onPressed: value.saveToDB,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 20,
                              ),
                              child: const Row(
                                children: [
                                  Icon(Ionicons.save),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text("Save Instructions",
                                      style: TextStyle(
                                        fontSize: 18,
                                      ))
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
