import importlib.util
from pathlib import Path
from typesafe_computer_use import macos

spec=importlib.util.spec_from_file_location('adapter',Path(__file__).with_name('native.py'))
adapter=importlib.util.module_from_spec(spec);spec.loader.exec_module(adapter)

def test_nested_swiftui_containers_keep_controls(monkeypatch):
    button={'role':'AXButton','label':'7','frame':(10,10,40,40),'children':[]}
    inner={'role':'AXGroup','label':'','frame':(0,0,200,200),'children':[button]}
    outer={'role':'AXGroup','label':'','frame':(0,0,200,200),'children':[inner]}
    def read():
        return macos.walk_actionable(outer,lambda n:n['children'],
            lambda n:macos.AxAttrs(n['role'],n['label'],n['frame']),
            lambda n:['AXPress'] if n['role']=='AXButton' else [],300,300)[0]
    assert not read(), 'fixture must reproduce the upstream pruning defect'
    monkeypatch.setattr(macos,'subtree_key',macos.subtree_key)
    adapter.install_ax_fix(macos)
    assert [n.label for n in read()]==['7']
