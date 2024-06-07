import 'package:flutter/material.dart';
import 'package:sub_items_field/sub_items_field/sub_item_value_model.dart';

class SubItemsField<T> extends StatefulWidget {
  const SubItemsField({
    required this.label,
    required this.controller,
    required this.onSubmit,
    super.key,
  });

  final String label;
  final TextEditingController controller;
  final Function(SubitemValueModel<T> value) onSubmit;

  @override
  State<SubItemsField<T>> createState() => _SubItemsFieldState<T>();
}

class _SubItemsFieldState<T> extends State<SubItemsField<T>> {
  List<TextEditingController> subItemsController = [];
  late String label;
  late SubitemValueModel<T> subitemValueModel;

  @override
  void initState() {
    label = widget.label;
    subitemValueModel = SubitemValueModel<T>.initial();
    super.initState();
  }

  @override
  void dispose() {
    for (TextEditingController controller in subItemsController) {
      controller.dispose();
    }
    super.dispose();
  }

  void updateSubitemValueModel() {
    subitemValueModel = subitemValueModel.copyWith(
      subValues:
          subItemsController.map((controller) => controller.text as T).toList(),
      mainValue: widget.controller.text as T,
    );
    widget.onSubmit(subitemValueModel);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: widget.controller,
                  decoration: InputDecoration(label: Text(widget.label)),
                  onChanged: (value) {
                    updateSubitemValueModel();
                  },
                ),
              ),
              const SizedBox(width: 10),
              _buildButton(
                context,
                onTap: () {
                  setState(() {
                    subItemsController.add(TextEditingController());
                  });
                  updateSubitemValueModel();
                },
              ),
            ],
          ),
          const SizedBox(height: 10),
          if (subItemsController.isNotEmpty)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: subItemsController
                  .asMap()
                  .entries
                  .map(
                    (map) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Row(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.6,
                            child: TextFormField(
                              decoration: InputDecoration(
                                suffixIcon: InkWell(
                                  onTap: () {
                                    setState(() {
                                      subItemsController.removeAt(map.key);
                                    });
                                    updateSubitemValueModel();
                                  },
                                  child: Icon(
                                    Icons.delete,
                                    color: Colors.grey.withOpacity(0.5),
                                  ),
                                ),
                              ),
                              controller: subItemsController[map.key],
                              onChanged: (value) {
                                updateSubitemValueModel();
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                  .toList(),
            ),
        ],
      ),
    );
  }

  Widget _buildButton(BuildContext context, {required Function() onTap}) {
    return InkWell(
      onTap: () => onTap.call(),
      child: Container(
        decoration:
            const BoxDecoration(color: Colors.blue, shape: BoxShape.circle),
        child: const Padding(
          padding: EdgeInsets.all(4.0),
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
