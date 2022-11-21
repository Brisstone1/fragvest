import 'package:flutter/material.dart';
import 'package:fragvest_mobile/viewModel/base_view_model.dart';
import 'package:provider/provider.dart';

class BaseViewBuilder<T extends BaseViewModel> extends StatefulWidget {
  final T model;
  final Widget child;
  final Function(T model) initState;
  final Widget Function(T model, Widget child) builder;
  final Function(T model) dispose;

  const BaseViewBuilder({
    Key key,
    this.child,
    this.dispose,
    this.initState,
    @required this.builder,
    @required this.model,
  }) : super(key: key);

  @override
  _BaseViewBuilderState<T> createState() => _BaseViewBuilderState<T>();
}

class _BaseViewBuilderState<T extends BaseViewModel>
    extends State<BaseViewBuilder<T>> {
  @override
  void initState() {
    if (widget.initState != null)
      // SchedulerBinding.instance.addPostFrameCallback(
      //   (_) =>
      widget.initState(widget.model);
    // );
    super.initState();
  }

  dispose() {
    if (widget.dispose != null) {
      widget.dispose(widget.model);
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<T>.value(
      value: widget.model,
      child: Consumer<T>(
        builder: (BuildContext context, value, Widget child) {
          return widget.builder(value, child);
        },
        child: widget.child,
      ),
    );
  }
}
