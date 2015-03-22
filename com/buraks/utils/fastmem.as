﻿package com.buraks.utils
{
    import flash.utils.ByteArray;

    public class fastmem 
    {

        private static var _mem:ByteArray = null;

        public static function fastGetI32(_arg_1:int):int
        {
            return (((((_mem[(_arg_1 + 3)] << 24) | (_mem[(_arg_1 + 2)] << 16)) | (_mem[(_arg_1 + 1)] << 8)) | _mem[_arg_1]));
        }
        public static function fastSetI32(_arg_1:int, _arg_2:int):void
        {
            _mem[(_arg_2 + 3)] = ((_arg_1 >> 24) & 0xFF);
            _mem[(_arg_2 + 2)] = ((_arg_1 >> 16) & 0xFF);
            _mem[(_arg_2 + 1)] = ((_arg_1 >> 8) & 0xFF);
            _mem[_arg_2] = (_arg_1 & 0xFF);
        }

    }
}