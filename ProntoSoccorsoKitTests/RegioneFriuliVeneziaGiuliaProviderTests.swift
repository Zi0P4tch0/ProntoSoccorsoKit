
import XCTest
@testable import ProntoSoccorsoKit

final class RegioneFriuliVeneziaGiuliaProviderTests: XCTestCase {

    var sut: RegioneFriuliVeneziaGiuliaProvider!

    override func setUp() {
        sut = RegioneFriuliVeneziaGiuliaProvider()
    }

    func test_parsing() throws {

        let html = """
            <div class="col-lg-4 col-md-6 col-sm-6 col-xs-12 prontosoccorso ng-scope" ng-repeat="PS in azi.ospedali | myFilter:psFilter">
                <h2 ng-bind="PS.descrizione" class="ps_title ng-binding">Pronto Soccorso Maggiore</h2>

                <!--
                            <div class="address-info" ng-if="PS.indirizzo != undefined && PS.comune != undefined && PS.indirizzo != ' ' && PS.comune != ' '">
                                <h3 class="address" ng-if="(PS.indirizzo.length + PS.comune.length) < 60">
                                    <span class="glyphicon glyphicon-home" aria-hidden="true"></span>
                                    <em><span ng-bind="PS.indirizzo"></span><span ng-if="PS.comune">, </span><span ng-bind="PS.comune"></span></em>
                                </h3>
                                <h3 class="address" ng-if="(PS.indirizzo.length + PS.comune.length) >= 60" tooltip-placement="top" tooltip="{{PS.indirizzo}}, {{PS.comune}}">
                                    <span class="glyphicon glyphicon-home" aria-hidden="true"></span>
                                    <em><span ng-bind="PS.indirizzo"></span><span ng-if="PS.comune">, </span><span ng-bind="PS.comune"></span></em>
                                </h3>
                            </div>
                            -->

                <!-- ngIf: PS.info && PS.info.length < 60 -->
                <!-- ngIf: PS.info && PS.info.length >= 60 -->
                <!-- ngIf: !PS.info -->
                <p class="bg-info-blank ng-binding ng-scope" ng-bind="PS.info" ng-if="!PS.info"></p>
                <!-- end ngIf: !PS.info -->

                <table class="table">
                    <thead>
                        <tr>
                            <th>Codice</th>
                            <th>Pazienti in trattamento</th>
                            <th>Pazienti in attesa</th>
                            <th>Tempo medio d’attesa</th>
                        </tr>
                    </thead>
                    <tbody>
                        <!-- ngRepeat: codice in PS.codiciColore | orderObjectBy:'priorita':false -->
                        <tr ng-class="codice.rgb" ng-repeat="codice in PS.codiciColore | orderObjectBy:'priorita':false" ng-class-fix="" class="ng-scope FF0000" style="background-color: rgb(255, 128, 108);">
                            <td ng-bind="codice.descrizione" class="ng-binding">Rosso</td>
                            <td ng-bind="codice.situazionePazienti.numeroPazientiInVisita" class="ng-binding">0</td>
                            <td ng-bind="codice.situazionePazienti.numeroPazientiInAttesa" class="ng-binding">0</td>
                            <td ng-bind="codice.situazionePazienti.mediaAttesa" class="ng-binding">00:00</td>
                        </tr>
                        <!-- end ngRepeat: codice in PS.codiciColore | orderObjectBy:'priorita':false -->
                        <tr ng-class="codice.rgb" ng-repeat="codice in PS.codiciColore | orderObjectBy:'priorita':false" ng-class-fix="" class="ng-scope FFFF00" style="background-color: rgb(255, 255, 0);">
                            <td ng-bind="codice.descrizione" class="ng-binding">Giallo</td>
                            <td ng-bind="codice.situazionePazienti.numeroPazientiInVisita" class="ng-binding">3</td>
                            <td ng-bind="codice.situazionePazienti.numeroPazientiInAttesa" class="ng-binding">0</td>
                            <td ng-bind="codice.situazionePazienti.mediaAttesa" class="ng-binding">00:16</td>
                        </tr>
                        <!-- end ngRepeat: codice in PS.codiciColore | orderObjectBy:'priorita':false -->
                        <tr ng-class="codice.rgb" ng-repeat="codice in PS.codiciColore | orderObjectBy:'priorita':false" ng-class-fix="" class="ng-scope 00FF00" style="background-color: rgb(80, 220, 120);">
                            <td ng-bind="codice.descrizione" class="ng-binding">Verde</td>
                            <td ng-bind="codice.situazionePazienti.numeroPazientiInVisita" class="ng-binding">8</td>
                            <td ng-bind="codice.situazionePazienti.numeroPazientiInAttesa" class="ng-binding">6</td>
                            <td ng-bind="codice.situazionePazienti.mediaAttesa" class="ng-binding">01:47</td>
                        </tr>
                        <!-- end ngRepeat: codice in PS.codiciColore | orderObjectBy:'priorita':false -->
                        <tr ng-class="codice.rgb" ng-repeat="codice in PS.codiciColore | orderObjectBy:'priorita':false" ng-class-fix="" class="ng-scope FFFFFF" style="background-color: rgb(255, 255, 255);">
                            <td ng-bind="codice.descrizione" class="ng-binding">Bianco</td>
                            <td ng-bind="codice.situazionePazienti.numeroPazientiInVisita" class="ng-binding">1</td>
                            <td ng-bind="codice.situazionePazienti.numeroPazientiInAttesa" class="ng-binding">6</td>
                            <td ng-bind="codice.situazionePazienti.mediaAttesa" class="ng-binding">02:51</td>
                        </tr>
                        <!-- end ngRepeat: codice in PS.codiciColore | orderObjectBy:'priorita':false -->
                    </tbody>
                    <tfoot>
                        <tr>
                            <td colspan="4" class="table_footer">Totale pazienti: <span ng-bind="PS.numeroPazienti" class="ng-binding">24</span></td>
                        </tr>
                    </tfoot>
                </table>
            </div>
        """

        let data = html.data(using: .utf8)!
        let result = try sut.mapper(data).first

        XCTAssertEqual(result?.name, "Pronto Soccorso Maggiore")
        XCTAssertEqual(result?.municipality, nil)
        XCTAssertEqual(result?.localHealthUnit, nil)
        XCTAssertEqual(result?.type, .generic)

        XCTAssertEqual(result?.waiting.reds, 0)
        XCTAssertEqual(result?.waiting.yellows, 0)
        XCTAssertEqual(result?.waiting.greens, 6)
        XCTAssertEqual(result?.waiting.whites, 6)
        XCTAssertEqual(result?.waiting.unassigned, nil)
        XCTAssertEqual(result?.waiting.count, nil)

        XCTAssertEqual(result?.inTreatment?.reds, 0)
        XCTAssertEqual(result?.inTreatment?.yellows, 3)
        XCTAssertEqual(result?.inTreatment?.greens, 8)
        XCTAssertEqual(result?.inTreatment?.whites, 1)
        XCTAssertEqual(result?.inTreatment?.unassigned, nil)
        XCTAssertEqual(result?.inTreatment?.count, nil)

        XCTAssertEqual(result?.inShortObservation, nil)

        XCTAssertEqual(result?.patientsWaitingForHospitalizationOrTransfer, nil)
        XCTAssertEqual(result?.totalPatients, 24)
    }

}
