//// TPXX
//
// In config ACPI, TPD0:Return Zero in _STA
// Find:    4100A40A 0F14335F
// Replace: 4100A40A 0014335F
//
//
DefinitionBlock ("", "SSDT", 2, "ACDT", "I2C-TPXX", 0x00000000)
{
    External (_SB_.GNUM, MethodObj)
    External (_SB_.PCI0.HIDD, MethodObj)
    External (_SB_.PCI0.HIDG, IntObj)
    External (_SB_.PCI0.I2C1, DeviceObj)
    External (_SB_.PCI0.TP7D, MethodObj)
    External (_SB_.PCI0.TP7G, IntObj)
    External (_SB_.SHPO, MethodObj)
    External (_SB_.SRXO, MethodObj)
    External (_SB_.INUM, MethodObj)
    External (GPDI, FieldUnitObj)
    External (HPID, FieldUnitObj)
    External (SDM1, FieldUnitObj)
    External (OSYS, FieldUnitObj)

    Scope (_SB.PCI0.I2C1)
    {
        Device (TPD0)
        {
            Name (HID2, Zero)
            Name (SBFB, ResourceTemplate ()
            {
                I2cSerialBusV2 (0x002C, ControllerInitiated, 0x00061A80,
                    AddressingMode7Bit, "\\_SB.PCI0.I2C1",
                    0x00, ResourceConsumer, _Y42, Exclusive,
                    )
            })
            Name (SBFG, ResourceTemplate ()
            {
                GpioInt (Level, ActiveLow, ExclusiveAndWake, PullDefault, 0x0000,
                    "\\_SB.PCI0.GPI0", 0x00, ResourceConsumer, ,
                    )
                    {   // Pin list
                        0x0000
                    }
            })
            Name (SBFI, ResourceTemplate ()
            {
                Interrupt (ResourceConsumer, Level, ActiveLow, ExclusiveAndWake, ,, _Y43)
                {
                    0x00000000,
                }
            })
            CreateWordField (SBFB, \_SB.PCI0.I2C1.TPD0._Y42._ADR, BADR)  // _ADR: Address
            CreateDWordField (SBFB, \_SB.PCI0.I2C1.TPD0._Y42._SPE, SPED)  // _SPE: Speed
            CreateDWordField (SBFI, \_SB.PCI0.I2C1.TPD0._Y43._INT, INT2)  // _INT: Interrupts
            CreateWordField (SBFG, 0x17, INT1)
            Method (_INI, 0, NotSerialized)  // _INI: Initialize
            {
                If ((OSYS < 0x07DC))
                {
                    SRXO (GPDI, One)
                }

                INT1 = GNUM (GPDI)
                INT2 = INUM (GPDI)
                If ((SDM1 == Zero))
                {
                    SHPO (GPDI, One)
                }

                HID2 = 0x20
                BADR = 0x2C
                SPED = 0x00061A80
            }

            Method (_HID, 0, NotSerialized)  // _HID: Hardware ID
            {
                If (Zero)
                {
                    If ((HPID == 0x103C00B8))
                    {
                        Return ("SYNA3083")
                    }
                    ElseIf ((HPID == 0x103C00BB))
                    {
                        Return ("SYNA3082")
                    }
                    ElseIf ((HPID == 0x103C00BA))
                    {
                        Return ("SYNA3081")
                    }
                    Else
                    {
                        Return ("SYNA30FF")
                    }
                }
                ElseIf ((HPID == 0x103C00B8))
                {
                    Return ("SYNA309E")
                }
                ElseIf ((HPID == 0x103C00BB))
                {
                    Return ("SYNA309A")
                }
                ElseIf ((HPID == 0x103C00BA))
                {
                    Return ("SYNA309B")
                }
                Else
                {
                    Return ("SYNA309A")
                }
            }

            Name (_CID, "PNP0C50" /* HID Protocol Device (I2C bus) */)  // _CID: Compatible ID
            Name (_S0W, 0x03)  // _S0W: S0 Device Wake State
            Method (_DSM, 4, Serialized)  // _DSM: Device-Specific Method
            {
                If ((Arg0 == HIDG))
                {
                    Return (HIDD (Arg0, Arg1, Arg2, Arg3, HID2))
                }

                If ((Arg0 == TP7G))
                {
                    Return (TP7D (Arg0, Arg1, Arg2, Arg3, SBFB, SBFG))
                }

                Return (Buffer (One)
                {
                     0x00                                             // .
                })
            }

            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                If (_OSI ("Darwin"))
                {
                    Return (Zero)
                }
                Else
                {
                    Return (0x0F)
                }
            }

            Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
            {
                If ((OSYS < 0x07DC))
                {
                    Return (SBFI) /* \_SB_.PCI0.I2C1.TPD0.SBFI */
                }

                If ((SDM1 == Zero))
                {
                    Return (ConcatenateResTemplate (SBFB, SBFG))
                }

                Return (ConcatenateResTemplate (SBFB, SBFI))
            }
        }
        Device (TPXX)
        {
            Name (HID2, Zero)
            Name (SBFB, ResourceTemplate ()
            {
                I2cSerialBusV2 (0x002C, ControllerInitiated, 0x00061A80,
                    AddressingMode7Bit, "\\_SB.PCI0.I2C1",
                    0x00, ResourceConsumer, _Y00, Exclusive,
                    )
            })
            Name (SBFG, ResourceTemplate ()
            {
                GpioInt (Level, ActiveLow, ExclusiveAndWake, PullDefault, 0x0000,
                    "\\_SB.PCI0.GPI0", 0x00, ResourceConsumer, ,
                    )
                    {   // Pin list
                        0x0063
                    }
            })
            CreateWordField (SBFB, \_SB.PCI0.I2C1.TPXX._Y00._ADR, BADR)  // _ADR: Address
            CreateDWordField (SBFB, \_SB.PCI0.I2C1.TPXX._Y00._SPE, SPED)  // _SPE: Speed
            CreateWordField (SBFG, 0x17, INT1)
            Method (_INI, 0, NotSerialized)  // _INI: Initialize
            {
                INT1 = GNUM (GPDI)
                If ((SDM1 == Zero))
                {
                    SHPO (GPDI, One)
                }

                HID2 = 0x20
                BADR = 0x2C
                SPED = 0x00061A80
            }

            Method (_HID, 0, NotSerialized)  // _HID: Hardware ID
            {
                If (Zero)
                {
                    If ((HPID == 0x103C00B8))
                    {
                        Return ("SYNA3083")
                    }
                    ElseIf ((HPID == 0x103C00BB))
                    {
                        Return ("SYNA3082")
                    }
                    ElseIf ((HPID == 0x103C00BA))
                    {
                        Return ("SYNA3081")
                    }
                    Else
                    {
                        Return ("SYNA30FF")
                    }
                }
                ElseIf ((HPID == 0x103C00B8))
                {
                    Return ("SYNA309E")
                }
                ElseIf ((HPID == 0x103C00BB))
                {
                    Return ("SYNA309A")
                }
                ElseIf ((HPID == 0x103C00BA))
                {
                    Return ("SYNA309B")
                }
                Else
                {
                    Return ("SYNA309A")
                }
            }

            Name (_CID, "PNP0C50" /* HID Protocol Device (I2C bus) */)  // _CID: Compatible ID
            Name (_S0W, 0x03)  // _S0W: S0 Device Wake State
            Method (_DSM, 4, Serialized)  // _DSM: Device-Specific Method
            {
                If ((Arg0 == HIDG))
                {
                    Return (HIDD (Arg0, Arg1, Arg2, Arg3, HID2))
                }

                If ((Arg0 == TP7G))
                {
                    Return (TP7D (Arg0, Arg1, Arg2, Arg3, SBFB, SBFG))
                }

                Return (Buffer (One)
                {
                     0x00                                             // .
                })
            }

            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                If (_OSI ("Darwin"))
                {
                    Return (0x0F)
                }
                Else
                {
                    Return (Zero)
                }
            }

            Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
            {
                Return (ConcatenateResTemplate (SBFB, SBFG))
            }
        }
    }
}
