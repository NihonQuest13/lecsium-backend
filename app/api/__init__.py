# backend/app/api/__init__.py

# On force Nuitka a voir les modules qu'il n'arrive pas a trouver
try:
    import sklearn.utils._cyutility
    import sklearn.neighbors._typedefs
    import sklearn.neighbors._quad_tree
    import sklearn.tree
    import sklearn.tree._utils
except ImportError:
    pass