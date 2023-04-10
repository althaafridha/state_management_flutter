import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Tab1Provider extends ChangeNotifier {
  String _textValue = '';

  String get textValue => _textValue;

  void setTextValue(String value) {
    _textValue = value;
    notifyListeners();
  }
}

class Tab2Provider with ChangeNotifier {
  int _selectedValue = 1;

  int get selectedValue => _selectedValue;

  set selectedValue(int value) {
    _selectedValue = value;
    notifyListeners();
  }

  void setSelectedValue(int value) {
    selectedValue = value;
  }
}

class TabBarViewPage extends StatefulWidget {
  const TabBarViewPage({Key? key});

  @override
  _TabBarViewPageState createState() => _TabBarViewPageState();
}

class _TabBarViewPageState extends State<TabBarViewPage>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController =
      TabController(length: 2, vsync: this);

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Tab1Provider>(
          create: (_) => Tab1Provider(),
        ),
        ChangeNotifierProvider<Tab2Provider>(
          create: (_) => Tab2Provider(),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text('TabBarView'),
          bottom: TabBar(
            controller: _tabController,
            tabs: const [
              Tab(text: 'Tab 1'),
              Tab(text: 'Tab 2'),
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: const [
            Tab1(),
            Tab2(),
          ],
        ),
      ),
    );
  }
}

class Tab1 extends StatelessWidget {
  const Tab1({Key? key});

  @override
  Widget build(BuildContext context) {
    return Consumer<Tab1Provider>(
      builder: (_, provider, __) {
        return Container(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                decoration: const InputDecoration(
                  hintText: 'Input Text',
                ),
                onChanged: (value) {
                  provider.setTextValue(value);
                },
              ),
              const SizedBox(height: 20.0),
              Text('Text Value: ${provider.textValue}'),
            ],
          ),
        );
      },
    );
  }
}

class Tab2 extends StatelessWidget {
  const Tab2({Key? key});

  @override
  Widget build(BuildContext context) {
    return Consumer<Tab2Provider>(
      builder: (_, provider, __) {
        return Container(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ListTile(
                title: const Text('Value 1'),
                leading: Radio(
                  value: 1,
                  groupValue: provider.selectedValue,
                  onChanged: (value) {
                    provider.setSelectedValue(value!);
                  },
                ),
              ),
              ListTile(
                title: const Text('Value 2'),
                leading: Radio(
                  value: 2,
                  groupValue: provider.selectedValue,
                  onChanged: (value) {
                    provider.setSelectedValue(value!);
                  },
                ),
              ),
              ListTile(
                title: const Text('Value 3'),
                leading: Radio(
                  value: 3,
                  groupValue: provider.selectedValue,
                  onChanged: (value) {
                    provider.setSelectedValue(value!);
                  },
                ),
              ),
              const SizedBox(height: 20.0),
              Text(
                'Selected value: ${provider.selectedValue}',
                style: const TextStyle(fontSize: 18.0),
              ),
            ],
          ),
        );
      },
    );
  }
}
