import 'package:flutter/widgets.dart';
import 'package:nations/bloc/nations_bloc.dart';

class NationsProvider extends InheritedWidget {
  final NationsBloc _bloc;

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  NationsProvider({ Key key, Widget child, NationsBloc bloc}) : this._bloc = bloc ?? new NationsBloc(),
    super(child: child, key: key);

  static NationsBloc of(BuildContext context) =>
        (context.inheritFromWidgetOfExactType(NationsProvider) as NationsProvider)
          ._bloc;
  
}