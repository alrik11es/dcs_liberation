from PySide2.QtWidgets import (
    QGridLayout,
    QGroupBox,
    QLabel,
    QSizePolicy,
    QVBoxLayout,
)

from game import Game
from game.data.weapons import Pylon
from gen.flights.flight import Flight
from qt_ui.windows.mission.flight.payload.QPylonEditor import QPylonEditor


class QLoadoutEditor(QGroupBox):
    def __init__(self, flight: Flight, game: Game) -> None:
        super().__init__("Use custom loadout")
        self.flight = flight
        self.game = game
        self.setCheckable(True)
        self.setChecked(flight.use_custom_loadout)

        self.toggled.connect(self.on_toggle)

        hboxLayout = QVBoxLayout(self)
        layout = QGridLayout(self)

        for i, pylon in enumerate(Pylon.iter_pylons(self.flight.unit_type)):
            label = QLabel(f"<b>{pylon.number}</b>")
            label.setSizePolicy(QSizePolicy(QSizePolicy.Fixed, QSizePolicy.Fixed))
            layout.addWidget(label, i, 0)
            layout.addWidget(QPylonEditor(game, flight, pylon), i, 1)

        hboxLayout.addLayout(layout)
        hboxLayout.addStretch()
        self.setLayout(hboxLayout)

        if not self.isChecked():
            for i in self.findChildren(QPylonEditor):
                i.default_loadout()

    def on_toggle(self):
        self.flight.use_custom_loadout = self.isChecked()
        if not self.isChecked():
            for i in self.findChildren(QPylonEditor):
                i.default_loadout()
