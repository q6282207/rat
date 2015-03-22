﻿package 
{
    import flash.utils.ByteArray;
    import flash.utils.*;

    public class Tools 
    {

        public static function GetUncompressString():String
        {
            var _local_1 = "u";
            _local_1 = (_local_1 + "n");
            _local_1 = (_local_1 + "c");
            _local_1 = (_local_1 + "o");
            _local_1 = (_local_1 + "m");
            _local_1 = (_local_1 + "p");
            _local_1 = (_local_1 + "r");
            _local_1 = (_local_1 + "e");
            _local_1 = (_local_1 + "s");
            return ((_local_1 + "s"));
        }
        public static function Hash32Shift(_arg_1:uint):uint
        {
            var _local_2:uint;
            _local_2 = (~(_arg_1) + (_arg_1 << 15));
            _local_2 = (_local_2 ^ (_local_2 >>> 12));
            _local_2 = (_local_2 + (_local_2 << 2));
            _local_2 = (_local_2 ^ (_local_2 >>> 4));
            _local_2 = (_local_2 * 2057);
            return ((_local_2 ^ (_local_2 >>> 16)));
        }
        public static function ToCStrByteArray(_arg_1:String):ByteArray
        {
            var _local_4:uint;
            var _local_2:ByteArray = new ByteArray();
            var _local_3:int;
            while (_local_3 < _arg_1.length)
            {
                _local_4 = uint(_arg_1.charCodeAt(_local_3));
                _local_2.writeByte(_local_4);
                _local_3++;
            };
            _local_2.position = 0;
            return (_local_2);
        }
        public static function AppendBytes(_arg_1:ByteArray, _arg_2:ByteArray):ByteArray
        {
            var _local_3:int;
            while (_local_3 < _arg_2.length)
            {
                _arg_1.writeByte(_arg_2[_local_3]);
                _local_3++;
            };
            return (_arg_1);
        }
        public static function GenerateRandomString(_arg_1:Number):String
        {
            var _local_2 = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
            var _local_3:Number = (_local_2.length - 1);
            var _local_4 = "";
            var _local_5:int;
            while (_local_5 < _arg_1)
            {
                _local_4 = (_local_4 + _local_2.charAt(Math.floor((Math.random() * _local_3))));
                _local_5++;
            };
            return (_local_4);
        }
        public static function CreateCStrBytesPattern(_arg_1:uint, _arg_2:int):ByteArray
        {
            var _local_3:ByteArray = new ByteArray();
            var _local_4:int;
            while (_local_4 < _arg_2)
            {
                _local_3.writeByte(_arg_1);
                _local_4++;
            };
            _local_3.position = 0;
            return (_local_3);
        }
        public static function ReplaceBytes(_arg_1:ByteArray, _arg_2:ByteArray, _arg_3:ByteArray):uint
        {
            if (_arg_2.length != _arg_3.length)
            {
                return (0xFFFFFFFF);
            };
            var _local_4:int = BytesIndexOf(_arg_1, _arg_2);
            if (_local_4 == -1)
            {
                return (_local_4);
            };
            if ((_local_4 + _arg_3.length) > _arg_1.length)
            {
                return (0xFFFFFFFF);
            };
            var _local_5:int;
            var _local_6:int = _local_4;
            while (_local_5 < _arg_3.length)
            {
                _arg_1[_local_6] = _arg_3[_local_5];
                _local_5++;
                _local_6++;
            };
            return (_local_4);
        }
        public static function ReplaceBytes2Uint(_arg_1:ByteArray, _arg_2:ByteArray, _arg_3:uint):void
        {
            if (_arg_2.length != 4)
            {
                return;
            };
            var _local_4:int = BytesIndexOf(_arg_1, _arg_2);
            if (_local_4 == -1)
            {
                return;
            };
            if ((_local_4 + 4) > _arg_1.length)
            {
                return;
            };
            var _local_5:int;
            var _local_6:int = _local_4;
            while (_local_5 < 4)
            {
                _arg_1[_local_6] = ((_arg_3 >> (_local_5 * 8)) & 0xFF);
                _local_5++;
                _local_6++;
            };
        }
        public static function BytesIndexOf(_arg_1:ByteArray, _arg_2:ByteArray):int
        {
            var _local_7:Boolean;
            var _local_8:int;
            var _local_3:int = -1;
            var _local_4:uint = _arg_1.position;
            var _local_5:uint = _arg_2.position;
            _arg_1.position = 0;
            var _local_6:int;
            while (_local_6 < _arg_1.length)
            {
                _arg_2.position = 0;
                _local_7 = true;
                _local_8 = 0;
                while (_local_8 < _arg_2.length)
                {
                    if ((_local_6 + _local_8) >= _arg_1.length)
                    {
                        return (_local_3);
                    };
                    if (_arg_1[(_local_6 + _local_8)] != _arg_2[_local_8])
                    {
                        _local_7 = false;
                        break;
                    };
                    _local_8++;
                };
                if (_local_7)
                {
                    _local_3 = _local_6;
                    break;
                };
                _local_6++;
            };
            _arg_1.position = _local_4;
            _arg_2.position = _local_5;
            return (_local_3);
        }
        public static function DecryptByteArray(_arg_1:ByteArray):ByteArray
        {
            var _local_2:ByteArray = new ByteArray();
            _local_2.writeMultiByte("oej8qtgwy0amcapt7kz9itbxc", "iso-8859-1");
            _local_2.position = 0;
            var _local_3:ByteArray = new ByteArray();
            var _local_4:int;
            var _local_5:int;
            var _local_6:int;
            var _local_7:int;
            var _local_8:int;
            var _local_9:int;
            var _local_10:int;
            _local_4 = 0;
            while (_local_4 < 0x0100)
            {
                _local_3.writeByte(_local_4);
                _local_4++;
            };
            _local_3.position = 0;
            _local_4 = 0;
            while (_local_4 < 0x0100)
            {
                _local_8 = ((((_local_2[_local_7] & 0xFF) + (_local_3[_local_4] & 0xFF)) + _local_8) & 0xFF);
                _local_10 = _local_3[_local_4];
                _local_3[_local_4] = _local_3[_local_8];
                _local_3[_local_8] = _local_10;
                _local_7 = ((_local_7 + 1) % _local_2.length);
                _local_4++;
            };
            _local_3.position = 0;
            _local_4 = 0;
            while (_local_4 < _arg_1.length)
            {
                _local_5 = ((_local_5 + 1) & 0xFF);
                _local_6 = (((_local_3[_local_5] & 0xFF) + _local_6) & 0xFF);
                _local_10 = _local_3[_local_5];
                _local_3[_local_5] = _local_3[_local_6];
                _local_3[_local_6] = _local_10;
                _local_9 = (((_local_3[_local_5] & 0xFF) + (_local_3[_local_6] & 0xFF)) & 0xFF);
                _arg_1[_local_4] = (_arg_1[_local_4] ^ _local_3[_local_9]);
                _local_4++;
            };
            return (_arg_1);
        }
        public static function decode_uint(_arg_1:uint):uint
        {
            var _local_2:uint = 4277009102;
            return ((_arg_1 ^ _local_2));
        }

    }
}