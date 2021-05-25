#!/usr/bin/env python
import rofi_menu
from subprocess import check_output, run
import csv, sys
from io import BytesIO, TextIOWrapper

class HamsterMenu(rofi_menu.Menu):
    prompt = "Hamster"
    allow_user_input = True

    async def pre_render(self, meta):
        await self.get_tasks()

    class InputItem(rofi_menu.Item):
        async def render(self, meta):
            raw_task = meta.session.get("text", None)
            if raw_task:
                return "New Task: {}".format(raw_task)
            return ""

        async def on_select(self, meta):
            run(["hamster", "add"]+meta.session['text'].split())
            return rofi_menu.Operation(rofi_menu.OP_EXIT)


    items = [InputItem()]

    async def on_user_input(self, meta):
        meta.session['text'] = meta.user_input
        return rofi_menu.Operation(rofi_menu.OP_REFRESH_MENU)

    async def get_tasks(self):
        fd = TextIOWrapper(BytesIO(check_output(["hamster", "export", "tsv"])))
        rd = csv.DictReader(fd, delimiter='\t')
        for row in rd:
            it = rofi_menu.Item("TEST: {row['start time']}")
            self.items.append(it)


if __name__ == "__main__":

    rofi_menu.run(HamsterMenu(), rofi_version="1.6", debug=True)
