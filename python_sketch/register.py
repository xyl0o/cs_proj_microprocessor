#!/usr/bin/env python3

from util import twos_comp


class Register(int):

    _size = 32  # bits

    def __new__(cls, value, *args, **kwargs):
        trunc_value = int(f'{value:b}'[-cls._size:], base=2)
        return super(cls, cls).__new__(cls, trunc_value)

    def __str__(self):
        val = int(self)
        val = val + 2 ** self._size if val < 0 else val
        return f"{val:#b}"

    def __repr__(self):
        val = int(self)
        val = val + 2 ** self._size if val < 0 else val
        return f"Register({val:0>32b})"

    @property
    def signed(self):
        return twos_comp(int(self), self._size)

    # binary +
    def __add__(self, other):
        return self.__class__(super().__add__(other))
    def __radd__(self, other):
        return self.__class__(super().__radd__(other))

    # binary -
    def __sub__(self, other):
        return self.__class__(super().__sub__(other))
    def __rsub__(self, other):
        return self.__class__(super().__rsub__(other))

    # binary *
    def __mul__(self, other):
        return self.__class__(super().__mul__(other))
    def __rmul__(self, other):
        return self.__class__(super().__rmul__(other))

    # binary /
    def __truediv__(self, other):
        return self.__class__(super().__truediv__(other))
    def __rtruediv__(self, other):
        return self.__class__(super().__rtruediv__(other))

    # binary //
    def __floordiv__(self, other):
        return self.__class__(super().__floordiv__(other))
    def __rfloordiv__(self, other):
        return self.__class__(super().__rfloordiv__(other))

    # binary %
    def __mod__(self, other):
        return self.__class__(super().__mod__(other))
    def __rmod__(self, other):
        return self.__class__(super().__rmod__(other))

    # binary divmod()
    def __divmod__(self, other):
        return self.__class__(super().__divmod__(other))
    def __rdivmod__(self, other):
        return self.__class__(super().__rdivmod__(other))

    # binary pow(), **
    def __pow__(self, other):
        return self.__class__(super().__pow__(other))
    def __rpow__(self, other):
        return self.__class__(super().__rpow__(other))

    # binary <<
    def __lshift__(self, other):
        return self.__class__(super().__lshift__(other))
    def __rlshift__(self, other):
        return self.__class__(super().__rlshift__(other))

    # binary >>
    def __rshift__(self, other):
        return self.__class__(super().__rshift__(other))
    def __rrshift__(self, other):
        return self.__class__(super().__rrshift__(other))

    # binary &
    def __and__(self, other):
        return self.__class__(super().__and__(other))
    def __rand__(self, other):
        return self.__class__(super().__rand__(other))

    # binary ^
    def __xor__(self, other):
        return self.__class__(super().__xor__(other))
    def __rxor__(self, other):
        return self.__class__(super().__rxor__(other))

    # binary |
    def __or__(self, other):
        return self.__class__(super().__or__(other))
    def __ror__(self, other):
        return self.__class__(super().__ror__(other))

    # unary -
    def __neg__(self):
        return NotImplemented

    # unary +
    def __pos__(self):
        return NotImplemented

    # unary abs()
    def __abs__(self):
        return NotImplemented

    # unary ~
    def __invert__(self):
        return self.__class__(super().__invert__())

    def __bool__(self, other):
        return self.__class__(super().__bool__(other))

    # binary <
    def __lt__(self, other):
        return NotImplemented

    # binary <=
    def __le__(self, other):
        return NotImplemented

    # binary ==
    def __eq__(self, other):
        return NotImplemented

    # binary !=
    def __ne__(self, other):
        return NotImplemented

    # binary >
    def __gt__(self, other):
        return NotImplemented

    # binary >=
    def __ge__(self, other):
        return NotImplemented


# self[key]
# object.__getitem__(self, key)
#         if isinstance(subscript, slice):

# sel[key] = foo
# object.__setitem__(self, key, value)
#         if isinstance(subscript, slice):

# object.__reversed__(self)

# object.__len__(self)
