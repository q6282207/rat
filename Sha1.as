﻿package 
{
    public class Sha1 
    {

        public static const HEX_FORMAT_LOWERCASE:uint = 0;
        public static const HEX_FORMAT_UPPERCASE:uint = 1;
        public static const BASE64_PAD_CHARACTER_DEFAULT_COMPLIANCE:String = "";
        public static const BASE64_PAD_CHARACTER_RFC_COMPLIANCE:String = "=";
        public static const BITS_PER_CHAR_ASCII:uint = 8;
        public static const BITS_PER_CHAR_UNICODE:uint = 8;
        public static var hexcase:uint = 0;
        public static var b64pad:String = "";
        public static var chrsz:uint = 8;

        public static function hex_sha1(_arg_1:String):String
        {
            return (binb2hex(core_sha1(str2binb(_arg_1), (_arg_1.length * chrsz))));
        }
        public static function core_sha1(_arg_1:Array, _arg_2:Number):Array
        {
            var _local_10:Number;
            var _local_11:Number;
            var _local_12:Number;
            var _local_13:Number;
            var _local_14:Number;
            var _local_15:Number;
            var _local_16:Number;
            _arg_1[(_arg_2 >> 5)] = (_arg_1[(_arg_2 >> 5)] | (128 << (24 - (_arg_2 % 32))));
            _arg_1[((((_arg_2 + 64) >> 9) << 4) + 15)] = _arg_2;
            var _local_3:Array = new Array(80);
            var _local_4:Number = Tools.decode_uint(2577979855);
            var _local_5:Number = Tools.decode_uint(287330631);
            var _local_6:Number = Tools.decode_uint(1716987440);
            var _local_7:Number = Tools.decode_uint(4007636664);
            var _local_8:Number = Tools.decode_uint(1027545918);
            var _local_9:Number = 0;
            while (_local_9 < _arg_1.length)
            {
                _local_10 = _local_4;
                _local_11 = _local_5;
                _local_12 = _local_6;
                _local_13 = _local_7;
                _local_14 = _local_8;
                _local_15 = 0;
                while (_local_15 < 80)
                {
                    if (_local_15 < 16)
                    {
                        _local_3[_local_15] = _arg_1[(_local_9 + _local_15)];
                    } else
                    {
                        _local_3[_local_15] = rol((((_local_3[(_local_15 - 3)] ^ _local_3[(_local_15 - 8)]) ^ _local_3[(_local_15 - 14)]) ^ _local_3[(_local_15 - 16)]), 1);
                    };
                    _local_16 = safe_add(safe_add(rol(_local_4, 5), sha1_ft(_local_15, _local_5, _local_6, _local_7)), safe_add(safe_add(_local_8, _local_3[_local_15]), sha1_kt(_local_15)));
                    _local_8 = _local_7;
                    _local_7 = _local_6;
                    _local_6 = rol(_local_5, 30);
                    _local_5 = _local_4;
                    _local_4 = _local_16;
                    _local_15++;
                };
                _local_4 = safe_add(_local_4, _local_10);
                _local_5 = safe_add(_local_5, _local_11);
                _local_6 = safe_add(_local_6, _local_12);
                _local_7 = safe_add(_local_7, _local_13);
                _local_8 = safe_add(_local_8, _local_14);
                _local_9 = (_local_9 + 16);
            };
            return ([_local_4, _local_5, _local_6, _local_7, _local_8]);
        }
        public static function sha1_ft(_arg_1:Number, _arg_2:Number, _arg_3:Number, _arg_4:Number):Number
        {
            if (_arg_1 < 20)
            {
                return (((_arg_2 & _arg_3) | (~(_arg_2) & _arg_4)));
            };
            if (_arg_1 < 40)
            {
                return (((_arg_2 ^ _arg_3) ^ _arg_4));
            };
            if (_arg_1 < 60)
            {
                return ((((_arg_2 & _arg_3) | (_arg_2 & _arg_4)) | (_arg_3 & _arg_4)));
            };
            return (((_arg_2 ^ _arg_3) ^ _arg_4));
        }
        public static function sha1_kt(_arg_1:Number):Number
        {
            return ((((_arg_1)<20) ? Tools.decode_uint(2758771543) : (((_arg_1)<40) ? Tools.decode_uint(2419331439) : (((_arg_1)<60) ? Tools.decode_uint(1911965202) : Tools.decode_uint(881802008)))));
        }
        public static function safe_add(_arg_1:Number, _arg_2:Number):Number
        {
            var _local_3:Number = ((_arg_1 & 0xFFFF) + (_arg_2 & 0xFFFF));
            var _local_4:Number = (((_arg_1 >> 16) + (_arg_2 >> 16)) + (_local_3 >> 16));
            return (((_local_4 << 16) | (_local_3 & 0xFFFF)));
        }
        public static function rol(_arg_1:Number, _arg_2:Number):Number
        {
            return (((_arg_1 << _arg_2) | (_arg_1 >>> (32 - _arg_2))));
        }
        public static function str2binb(_arg_1:String):Array
        {
            var _local_2:Array = new Array();
            var _local_3:Number = ((1 << chrsz) - 1);
            var _local_4:Number = 0;
            while (_local_4 < (_arg_1.length * chrsz))
            {
                _local_2[(_local_4 >> 5)] = (_local_2[(_local_4 >> 5)] | ((_arg_1.charCodeAt((_local_4 / chrsz)) & _local_3) << ((32 - chrsz) - (_local_4 % 32))));
                _local_4 = (_local_4 + chrsz);
            };
            return (_local_2);
        }
        public static function binb2hex(_arg_1:Array):String
        {
            var _local_2:String = ((hexcase) ? "0123456789ABCDEF" : "0123456789abcdef");
            var _local_3 = "";
            var _local_4:Number = 0;
            while (_local_4 < (_arg_1.length * 4))
            {
                _local_3 = (_local_3 + (_local_2.charAt(((_arg_1[(_local_4 >> 2)] >> (((3 - (_local_4 % 4)) * 8) + 4)) & 15)) + _local_2.charAt(((_arg_1[(_local_4 >> 2)] >> ((3 - (_local_4 % 4)) * 8)) & 15))));
                _local_4++;
            };
            return (_local_3);
        }

    }
}