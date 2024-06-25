import 'package:flutter_modular/flutter_modular.dart';
import 'package:nossos_pontos/components/points_modal.dart';
import 'package:nossos_pontos/pages/home_page.dart';

class AppModule extends Module {
  @override
  void binds(i) {}

  @override
  void routes(r) {
    Modular.setInitialRoute('/home');

    r.child('/home', child: (context) => HomePage());
    // r.child('/points_modal',
    //     child: (context) => PointsModal(
    //           controller: ar,
    //         ));
    r.child('/pointsModal',
        child: (_) => PointsModal(controller: r.args.data));
  }
}
