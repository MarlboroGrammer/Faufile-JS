import 'package:flutter_app/data/rest_ds.dart';
import 'package:flutter_app/model/service.dart';


abstract class ServicesScreenContract {
  void onGetData(List<Service> service);
  void onDataError(String errorTxt);
}

class ServicesScreenPresenter {
  ServicesScreenContract _view;
  RestDatasource api = new RestDatasource();
  ServicesScreenPresenter(this._view);

  getServices() async{
    try {
      var services = await api.getServices();
      _view.onGetData(services);
    } on Exception catch(error) {
      _view.onDataError(error.toString());
    }
  }
}
