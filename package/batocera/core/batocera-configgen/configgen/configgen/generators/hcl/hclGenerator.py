from __future__ import annotations

import os
from typing import TYPE_CHECKING

from ... import Command, controllersConfig
from ...batoceraPaths import ROMS
from ...utils.logger import get_logger
from ..Generator import Generator

if TYPE_CHECKING:
    from ...types import HotkeysContext

eslog = get_logger(__name__)

class HclGenerator(Generator):

    def getHotkeysContext(self) -> HotkeysContext:
        return {
            "name": "hcl",
            "keys": { "exit": ["KEY_LEFTALT", "KEY_F4"] }
        }

    def generate(self, system, rom, playersControllers, metadata, guns, wheels, gameResolution):
        try:
            os.chdir(ROMS / "hcl" / "data" / "map")
            os.chdir(ROMS / "hcl")
        except:
            eslog.error("ERROR: Game assets not installed. You can get them from the Batocera Content Downloader.")
        commandArray = ["hcl", "-d"]

        return Command.Command(
            array=commandArray,
            env={
                'SDL_GAMECONTROLLERCONFIG': controllersConfig.generateSdlGameControllerConfig(playersControllers)
            })
