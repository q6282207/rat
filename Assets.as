﻿package 
{
    import flash.utils.ByteArray;

    public class Assets 
    {

        public static const shader_class:Class = Assets_shader_class;

        public static function get_shader_bytes():ByteArray
        {
            return ((new shader_class() as ByteArray));
        }

    }
}