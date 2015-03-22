﻿package 
{
    import flash.utils.ByteArray;

    public class Base64 
    {

        private static const BASE64_CHARS:String = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=";

        public static function Decode(_arg_1:String):String
        {
            var _local_2:ByteArray = DecodeToByteArray(_arg_1);
            return (_local_2.readUTFBytes(_local_2.length));
        }
        public static function DecodeToByteArray(_arg_1:String):ByteArray
        {
            var _local_6:uint;
            var _local_7:uint;
            var _local_2:ByteArray = new ByteArray();
            var _local_3:Array = new Array(4);
            var _local_4:Array = new Array(3);
            var _local_5:uint;
            while (_local_5 < _arg_1.length)
            {
                _local_6 = 0;
                while ((((_local_6 < 4)) && (((_local_5 + _local_6) < _arg_1.length))))
                {
                    _local_3[_local_6] = BASE64_CHARS.indexOf(_arg_1.charAt((_local_5 + _local_6)));
                    while ((((_local_3[_local_6] < 0)) && ((_local_5 < _arg_1.length))))
                    {
                        _local_5++;
                        _local_3[_local_6] = BASE64_CHARS.indexOf(_arg_1.charAt((_local_5 + _local_6)));
                    };
                    _local_6++;
                };
                _local_4[0] = ((_local_3[0] << 2) + ((_local_3[1] & 48) >> 4));
                _local_4[1] = (((_local_3[1] & 15) << 4) + ((_local_3[2] & 60) >> 2));
                _local_4[2] = (((_local_3[2] & 3) << 6) + _local_3[3]);
                _local_7 = 0;
                while (_local_7 < _local_4.length)
                {
                    if (_local_3[(_local_7 + 1)] == 64) break;
                    _local_2.writeByte(_local_4[_local_7]);
                    _local_7++;
                };
                _local_5 = (_local_5 + 4);
            };
            _local_2.position = 0;
            return (_local_2);
        }

    }
}