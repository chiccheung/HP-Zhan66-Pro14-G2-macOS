//// battery
//
// In config ACPI, ACEL:_STA to XSTA
// Find:    5F535441 00A02D93
// Replace: 58535441 00A02D93
//
// In config ACPI, EC0: GACW to XACW
// Find:     25474143 57
// Replace:  25584143 57
//
// In config ACPI, EC0: GBAW to XBAW
// Find:     60144504 47424157
// Replace:  60144504 58424157
//
// In config ACPI, EC0: BTIF to XTIF
// Find:     14461242 544946
// Replace:  14461258 544946
//
// In config ACPI, EC0: BTST to XTST
// Find:     47164254 5354
// Replace:  47165854 5354
//
// In config ACPI, EC0: ITLB to XTLB
// Find:     4D044954 4C42
// Replace:  4D045854 4C42
//
// In config ACPI, EC0: GBTI to XBTI
// Find:     5F144542 47425449
// Replace:  5F144542 58425449
//
// In config ACPI, EC0: GBTC to XGBT
// Find:     42204742 5443
// Replace:  42205847 4254
//
// In config ACPI, EC0: SBTC to XSBT
// Find:     26534254 43
// Replace:  26585342 54
// In config ACPI, _TZ: GCGC to XGCG
// Find:     47434743 0808
// Replace:  58474347 0808
//
//
DefinitionBlock ("", "SSDT", 2, "hack", "BATT", 0x00000000)
{
    External (_SB_, DeviceObj)
    External (_SB_.BAT0, DeviceObj)
    External (_SB_.NBST, PkgObj)
    External (_SB_.NBTI, PkgObj)
    External (_SB_.NDBS, PkgObj)
    External (_SB_.PCI0.LPCB, DeviceObj)
    External (_SB_.PCI0.LPCB.EC0_, DeviceObj)
    External (_SB_.PCI0.LPCB.EC0_.BATN, FieldUnitObj)
    External (_SB_.PCI0.LPCB.EC0_.BATP, FieldUnitObj)
    External (_SB_.PCI0.LPCB.EC0_.BRCC, FieldUnitObj)
    External (_SB_.PCI0.LPCB.EC0_.BRCV, FieldUnitObj)
    External (_SB_.PCI0.LPCB.EC0_.BSEL, FieldUnitObj)
    External (_SB_.PCI0.LPCB.EC0_.BST_, FieldUnitObj)
    External (_SB_.PCI0.LPCB.EC0_.BSTA, MethodObj)    // 1 Arguments
    External (_SB_.PCI0.LPCB.EC0_.BTDR, MethodObj)    // 1 Arguments
    External (_SB_.PCI0.LPCB.EC0_.BTMX, MutexObj)
    External (_SB_.PCI0.LPCB.EC0_.ECMX, MutexObj)
    External (_SB_.PCI0.LPCB.EC0_.ECRG, IntObj)
    External (_SB_.PCI0.LPCB.EC0_.GACS, MethodObj)    // 0 Arguments
    External (_SB_.PCI0.LPCB.EC0_.GBMF, MethodObj)    // 0 Arguments
    External (_SB_.PCI0.LPCB.EC0_.GBSS, MethodObj)    // 2 Arguments
    External (_SB_.PCI0.LPCB.EC0_.GCTL, MethodObj)    // 1 Arguments
    External (_SB_.PCI0.LPCB.EC0_.GDCH, MethodObj)    // 1 Arguments
    External (_SB_.PCI0.LPCB.EC0_.GDNM, MethodObj)    // 1 Arguments
    External (_SB_.PCI0.LPCB.EC0_.IDIS, FieldUnitObj)
    External (_SB_.PCI0.LPCB.EC0_.INAC, FieldUnitObj)
    External (_SB_.PCI0.LPCB.EC0_.INCH, FieldUnitObj)
    External (_SB_.PCI0.LPCB.EC0_.LB1_, FieldUnitObj)
    External (_SB_.PCI0.LPCB.EC0_.LB2_, FieldUnitObj)
    External (_SB_.PCI0.LPCB.EC0_.NDCB, IntObj)
    External (_SB_.PCI0.LPCB.EC0_.NGBF, IntObj)
    External (_SB_.PCI0.LPCB.EC0_.NGBT, IntObj)
    External (_SB_.PCI0.LPCB.EC0_.NLB1, IntObj)
    External (_SB_.PCI0.LPCB.EC0_.NLB2, IntObj)
    External (_SB_.PCI0.LPCB.EC0_.NLO2, IntObj)
    External (_SB_.PCI0.LPCB.EC0_.PSSB, FieldUnitObj)
    External (_SB_.PCI0.ACEL, DeviceObj)
    External (_SB_.PCI0.ACEL.XSTA, MethodObj)    // 0 Arguments
    External (_TZ_.XGCG, MethodObj)    // 0 Arguments
    External (_SB_.PCI0.LPCB.EC0_.XACW, MethodObj) 
    External (_SB_.PCI0.LPCB.EC0_.XBAW, MethodObj) 
    External (_SB_.PCI0.LPCB.EC0_.XTIF, MethodObj)  
    External (_SB_.PCI0.LPCB.EC0_.XTST, MethodObj)   
    External (_SB_.PCI0.LPCB.EC0_.XTLB, MethodObj)    
    External (_SB_.PCI0.LPCB.EC0_.XBTI, MethodObj)    
    External (_SB_.PCI0.LPCB.EC0_.XGBT, MethodObj) 
    External (_SB_.PCI0.LPCB.EC0_.XSBT, MethodObj)
    
    

    Method (B1B2, 2, NotSerialized)
    {
        Return ((Arg0 | (Arg1 << 0x08)))
    }

    Scope (\_SB.PCI0.ACEL)
    {
        Method (_STA, 0, NotSerialized)  // _STA: Status
        {
            If (_OSI ("Darwin"))
            {
                Return (Zero)
            }
            Else
            {
                Return (XSTA ())
            }
        }
    }

    Scope (_SB.PCI0.LPCB.EC0)
    {
        OperationRegion (ECRM, EmbeddedControl, Zero, 0xFF)
        Field (ECRM, ByteAcc, NoLock, Preserve)
        {
            Offset (0x89), 
            B1DC,   8, 
            B2DC,   8, 
            Offset (0x8D), 
            B1FC,   8, 
            B2FC,   8, 
            B1TE,   8, 
            B2TE,   8, 
                ,   1, 
            Offset (0x92), 
            B1ME,   8, 
            B2ME,   8, 
            Offset (0x95), 
            B1DV,   8, 
            B2DV,   8, 
            B1CV,   8, 
            B2CV,   8, 
                ,   4, 
            Offset (0x9B), 
            B3TE,   8, 
            B4TE,   8, 
            B1PR,   8, 
            B2PR,   8, 
            B1CR,   8, 
            B2CR,   8, 
            B1RC,   8, 
            B2RC,   8, 
            B1CC,   8, 
            B2CC,   8, 
            B1PV,   8, 
            B2PV,   8, 
            B3CV,   8, 
            B4CV,   8, 
            B5CV,   8, 
            B6CV,   8, 
            B7CV,   8, 
            B8CV,   8, 
            Offset (0xAF), 
            B1AT,   8, 
            B2AT,   8, 
            Offset (0xB3), 
            M1AX,   8, 
            M2AX,   8, 
            Offset (0xB6), 
                ,   1, 
                ,   1, 
                ,   2, 
            Offset (0xB7), 
            B3ST,   8, 
            B4ST,   8, 
            Offset (0xC7), 
            Offset (0xC8), 
            Offset (0xC9), 
            B1SN,   8, 
            B2SN,   8, 
            B1DA,   8, 
            B2DA,   8, 
            Offset (0xD5), 
            Offset (0xD6), 
            Offset (0xD7), 
            Offset (0xD8), 
            Offset (0xD9), 
            Offset (0xDA), 
            Offset (0xDB), 
            Offset (0xDC), 
            Offset (0xDD), 
                ,   4, 
            Offset (0xDE), 
            Offset (0xE0), 
            C1BT,   8, 
            C2BT,   8, 
            Offset (0xF6), 
            Offset (0xF7), 
            Offset (0xF8), 
            Offset (0xF9), 
            A1CP,   8, 
            A2CP,   8
        }

        Method (GACW, 0, NotSerialized)
        {
            If (_OSI ("Darwin"))
            {
                Local0 = Zero
                Acquire (ECMX, 0xFFFF)
                If (\_SB.PCI0.LPCB.EC0.ECRG)
                {
                    Local0 = B1B2 (A1CP, A2CP)
                }

                Release (ECMX)
                Return (Local0)
            }
            Else
            {
                Return (\_SB.PCI0.LPCB.EC0.XACW())
            }
        }

        Method (GBAW, 0, NotSerialized)
        {
            If (_OSI ("Darwin"))
            {
                Local0 = Zero
                Acquire (ECMX, 0xFFFF)
                If (\_SB.PCI0.LPCB.EC0.ECRG)
                {
                    Local1 = B1B2 (B1DV, B2DV)
                    Local2 = B1B2 (B1DC, B2DC)
                    Local0 = (Local1 * Local2)
                    Divide (Local0, 0x000F4240, Local3, Local0)
                    If ((Local3 >= 0x0007A120))
                    {
                        Local0++
                    }
                }

                Release (ECMX)
                Return (Local0)
            }
            Else
            {
                Return (\_SB.PCI0.LPCB.EC0.XBAW())
            }
        }

        Method (BTIF, 1, Serialized)
        {
            If (_OSI ("Darwin"))
            {
                Local7 = (One << Arg0)
                BTDR (One)
                If ((BSTA (Local7) == 0x0F))
                {
                    Return (0xFF)
                }

                Acquire (BTMX, 0xFFFF)
                Local0 = \_SB.PCI0.LPCB.EC0.NGBF /* External reference */
                Release (BTMX)
                If (((Local0 & Local7) == Zero))
                {
                    Return (Zero)
                }

                NBST [Arg0] = \_SB.NDBS /* External reference */
                Acquire (BTMX, 0xFFFF)
                \_SB.PCI0.LPCB.EC0.NGBT |= Local7
                Release (BTMX)
                Acquire (ECMX, 0xFFFF)
                If (\_SB.PCI0.LPCB.EC0.ECRG)
                {
                    BSEL = Arg0
                    Local0 = B1B2 (B1FC, B2FC)
                    DerefOf (NBTI [Arg0]) [One] = Local0
                    DerefOf (NBTI [Arg0]) [0x02] = Local0
                    DerefOf (NBTI [Arg0]) [0x04] = B1B2 (B1DV, B2DV)
                    Local0 = (B1B2 (B1FC, B2FC) * NLB1) /* External reference */
                    Local4 = (Local0 / 0x64)
                    DerefOf (NBTI [Arg0]) [0x05] = Local4
                    Local0 = (B1B2 (B1FC, B2FC) * NLO2) /* External reference */
                    Local4 = (Local0 / 0x64)
                    DerefOf (NBTI [Arg0]) [0x06] = Local4
                    Local0 = B1B2 (B1SN, B2SN)
                    Local1 = B1B2 (B1DA, B2DA)
                }

                Release (ECMX)
                Local2 = GBSS (Local0, Local1)
                DerefOf (NBTI [Arg0]) [0x0A] = Local2
                Acquire (BTMX, 0xFFFF)
                \_SB.PCI0.LPCB.EC0.NGBF &= ~Local7
                Release (BTMX)
                Return (Zero)
            }
            Else
            {
                Return (\_SB.PCI0.LPCB.EC0.XTIF(Arg0))
            }
        }

        Method (BTST, 2, Serialized)
        {
            If (_OSI ("Darwin"))
            {
                Local7 = (One << Arg0)
                BTDR (One)
                If ((BSTA (Local7) == 0x0F))
                {
                    NBST [Arg0] = Package (0x04)
                        {
                            Zero, 
                            0xFFFFFFFF, 
                            0xFFFFFFFF, 
                            0xFFFFFFFF
                        }
                    Return (0xFF)
                }

                Acquire (BTMX, 0xFFFF)
                If (Arg1)
                {
                    \_SB.PCI0.LPCB.EC0.NGBT = 0xFF
                }

                Local0 = \_SB.PCI0.LPCB.EC0.NGBT /* External reference */
                Release (BTMX)
                If (((Local0 & Local7) == Zero))
                {
                    Return (Zero)
                }

                Acquire (ECMX, 0xFFFF)
                If (\_SB.PCI0.LPCB.EC0.ECRG)
                {
                    BSEL = Arg0
                    Local0 = \_SB.PCI0.LPCB.EC0.BST /* External reference */
                    Local3 = B1B2 (B1PR, B2PR)
                    DerefOf (NBST [Arg0]) [0x02] = B1B2 (B1RC, B2RC)
                    DerefOf (NBST [Arg0]) [0x03] = B1B2 (B1PV, B2PV)
                }

                Release (ECMX)
                If ((GACS () == One))
                {
                    Local0 &= 0xFFFFFFFFFFFFFFFE
                }
                Else
                {
                    Local0 &= 0xFFFFFFFFFFFFFFFD
                }

                If ((Local0 & One))
                {
                    Acquire (BTMX, 0xFFFF)
                    NDCB = Local7
                    Release (BTMX)
                }

                DerefOf (NBST [Arg0]) [Zero] = Local0
                If ((Local0 & One))
                {
                    If (((Local3 < 0x0190) || (Local3 > 0x1964)))
                    {
                        Local5 = DerefOf (DerefOf (NBST [Arg0]) [One])
                        If (((Local5 < 0x0190) || (Local5 > 0x1964)))
                        {
                            Local3 = 0x0D7A
                        }
                        Else
                        {
                            Local3 = Local5
                        }
                    }
                }
                ElseIf (((Local0 & 0x02) == Zero))
                {
                    Local3 = Zero
                }

                DerefOf (NBST [Arg0]) [One] = Local3
                Acquire (BTMX, 0xFFFF)
                \_SB.PCI0.LPCB.EC0.NGBT &= ~Local7
                Release (BTMX)
                Return (Zero)
            }
            Else
            {
                Return (\_SB.PCI0.LPCB.EC0.XTST(Arg0, Arg1))
            }
        }

        Method (ITLB, 0, NotSerialized)
        {
            If (_OSI ("Darwin"))
            {
                Local0 = (B1B2 (B1FC, B2FC) * NLB1) /* External reference */
                Local4 = (Local0 / 0x64)
                Divide ((Local4 + 0x09), 0x0A, Local0, Local1)
                Local0 = (B1B2 (B1FC, B2FC) * NLB2) /* External reference */
                Local4 = (Local0 / 0x64)
                Divide ((Local4 + 0x09), 0x0A, Local0, Local2)
                If (\_SB.PCI0.LPCB.EC0.ECRG)
                {
                    LB1 = Local1
                    LB2 = Local2
                }
            }
            Else
            {
                \_SB.PCI0.LPCB.EC0.XTLB()
            }
        }

        Method (GBTI, 1, NotSerialized)
        {
            If (_OSI ("Darwin"))
            {
                Debug = "Enter getbattinfo"
                Acquire (ECMX, 0xFFFF)
                If (\_SB.PCI0.LPCB.EC0.ECRG)
                {
                    If ((BATP & (One << Arg0)))
                    {
                        BSEL = Arg0
                        Local0 = Package (0x02)
                            {
                                Zero, 
                                Buffer (0x6B){}
                            }
                        DerefOf (Local0 [One]) [Zero] = B1B2 (B1DC, B2DC)
                        DerefOf (Local0 [One]) [One] = (B1B2 (B1DC, B2DC) >> 
                            0x08)
                        DerefOf (Local0 [One]) [0x02] = B1B2 (B1FC, B2FC)
                        DerefOf (Local0 [One]) [0x03] = (B1B2 (B1FC, B2FC) >> 
                            0x08)
                        DerefOf (Local0 [One]) [0x04] = B1B2 (B1RC, B2RC)
                        DerefOf (Local0 [One]) [0x05] = (B1B2 (B1RC, B2RC) >> 
                            0x08)
                        DerefOf (Local0 [One]) [0x06] = B1B2 (B1ME, B2ME)
                        DerefOf (Local0 [One]) [0x07] = (B1B2 (B1ME, B2ME) >> 
                            0x08)
                        DerefOf (Local0 [One]) [0x08] = B1B2 (B1CC, B2CC)
                        DerefOf (Local0 [One]) [0x09] = (B1B2 (B1CC, B2CC) >> 
                            0x08)
                        Local1 = B1B2 (C1BT, C2BT)
                        Local1 -= 0x0AAC
                        Divide (Local1, 0x0A, Local2, Local3)
                        DerefOf (Local0 [One]) [0x0A] = Local3
                        DerefOf (Local0 [One]) [0x0B] = (Local3 >> 0x08)
                        DerefOf (Local0 [One]) [0x0C] = B1B2 (B1PV, B2PV)
                        DerefOf (Local0 [One]) [0x0D] = (B1B2 (B1PV, B2PV) >> 
                            0x08)
                        Local1 = B1B2 (B1PR, B2PR)
                        If (Local1)
                        {
                            If ((B1B2 (B3ST, B4ST) & 0x40))
                            {
                                Local1 = (~Local1 + One)
                                Local1 &= 0xFFFF
                            }
                        }

                        DerefOf (Local0 [One]) [0x0E] = Local1
                        DerefOf (Local0 [One]) [0x0F] = (Local1 >> 0x08)
                        DerefOf (Local0 [One]) [0x10] = B1B2 (B1DV, B2DV)
                        DerefOf (Local0 [One]) [0x11] = (B1B2 (B1DV, B2DV) >> 
                            0x08)
                        DerefOf (Local0 [One]) [0x12] = B1B2 (B3ST, B4ST)
                        DerefOf (Local0 [One]) [0x13] = (B1B2 (B3ST, B4ST) >> 
                            0x08)
                        DerefOf (Local0 [One]) [0x14] = B1B2 (B1CV, B2CV)
                        DerefOf (Local0 [One]) [0x15] = (B1B2 (B1CV, B2CV) >> 
                            0x08)
                        DerefOf (Local0 [One]) [0x16] = B1B2 (B3CV, B4CV)
                        DerefOf (Local0 [One]) [0x17] = (B1B2 (B1CV, B2CV) >> 
                            0x08)
                        DerefOf (Local0 [One]) [0x18] = B1B2 (B5CV, B6CV)
                        DerefOf (Local0 [One]) [0x19] = (B1B2 (B5CV, B6CV) >> 
                            0x08)
                        DerefOf (Local0 [One]) [0x1A] = B1B2 (B7CV, B8CV)
                        DerefOf (Local0 [One]) [0x1B] = (B1B2 (B7CV, B8CV) >> 
                            0x08)
                        CreateField (DerefOf (Local0 [One]), 0xE0, 0x80, BTSN)
                        BTSN = GBSS (B1B2 (B1SN, B2SN), B1B2 (B1DA, B2DA))
                        Local1 = GBMF ()
                        Local2 = SizeOf (Local1)
                        CreateField (DerefOf (Local0 [One]), 0x0160, (Local2 * 0x08), BMAN)
                        BMAN = Local1
                        Local2 += 0x2C
                        CreateField (DerefOf (Local0 [One]), (Local2 * 0x08), 0x80, CLBL)
                        CLBL = GCTL (Zero)
                        Local2 += 0x11
                        CreateField (DerefOf (Local0 [One]), (Local2 * 0x08), 0x38, DNAM)
                        DNAM = GDNM (Zero)
                        Local2 += 0x07
                        CreateField (DerefOf (Local0 [One]), (Local2 * 0x08), 0x20, DCHE)
                        DCHE = GDCH (Zero)
                        Local2 += 0x04
                        CreateField (DerefOf (Local0 [One]), (Local2 * 0x08), 0x10, BMAC)
                        BMAC = Zero
                        Local2 += 0x02
                        CreateField (DerefOf (Local0 [One]), (Local2 * 0x08), 0x10, BMAD)
                        BMAD = B1B2 (B1DA, B2DA)
                        Local2 += 0x02
                        CreateField (DerefOf (Local0 [One]), (Local2 * 0x08), 0x10, BCCU)
                        BCCU = \_SB.PCI0.LPCB.EC0.BRCC /* External reference */
                        Local2 += 0x02
                        CreateField (DerefOf (Local0 [One]), (Local2 * 0x08), 0x10, BCVO)
                        BCVO = \_SB.PCI0.LPCB.EC0.BRCV /* External reference */
                        Local2 += 0x02
                        CreateField (DerefOf (Local0 [One]), (Local2 * 0x08), 0x10, BAVC)
                        Local1 = B1B2 (B1CR, B2CR)
                        If (Local1)
                        {
                            If ((B1B2 (B3ST, B4ST) & 0x40))
                            {
                                Local1 = (~Local1 + One)
                                Local1 &= 0xFFFF
                            }
                        }

                        BAVC = Local1
                        Local2 += 0x02
                        CreateField (DerefOf (Local0 [One]), (Local2 * 0x08), 0x10, RTTE)
                        RTTE = B1B2 (B1TE, B2TE)
                        Local2 += 0x02
                        CreateField (DerefOf (Local0 [One]), (Local2 * 0x08), 0x10, ATTE)
                        ATTE = B1B2 (B3TE, B4TE)
                        Local2 += 0x02
                        CreateField (DerefOf (Local0 [One]), (Local2 * 0x08), 0x10, ATTF)
                        ATTF = B1B2 (B1AT, B2AT)
                        Local2 += 0x02
                        CreateField (DerefOf (Local0 [One]), (Local2 * 0x08), 0x08, NOBS)
                        NOBS = \_SB.PCI0.LPCB.EC0.BATN /* External reference */
                    }
                    Else
                    {
                        Local0 = Package (0x01)
                            {
                                0x34
                            }
                    }
                }
                Else
                {
                    Local0 = Package (0x01)
                        {
                            0x0D
                        }
                }

                Release (ECMX)
                Return (Local0)
            }
            Else
            {
                Return (\_SB.PCI0.LPCB.EC0.XBTI(Arg0))
            }
        }

        Method (GBTC, 0, NotSerialized)
        {
            If (_OSI ("Darwin"))
            {
                Debug = "Enter GetBatteryControl"
                Acquire (ECMX, 0xFFFF)
                If (\_SB.PCI0.LPCB.EC0.ECRG)
                {
                    Local0 = Package (0x02)
                        {
                            Zero, 
                            Buffer (0x04){}
                        }
                    If ((BATP & One))
                    {
                        BSEL = Zero
                        DerefOf (Local0 [One]) [Zero] = Zero
                        If ((((INAC == Zero) && (INCH == Zero)) && (IDIS == Zero)))
                        {
                            DerefOf (Local0 [One]) [Zero] = Zero
                        }
                        ElseIf (((((INAC == Zero) && (INCH == 0x02)) && (
                            IDIS == One)) && (B1B2 (M1AX, M2AX) == Zero)))
                        {
                            DerefOf (Local0 [One]) [Zero] = One
                        }
                        ElseIf (((INAC == One) && (IDIS == 0x02)))
                        {
                            DerefOf (Local0 [One]) [Zero] = 0x02
                        }
                        ElseIf (((((INAC == Zero) && (INCH == 0x02)) && (
                            IDIS == One)) && (B1B2 (M1AX, M2AX) == 0xFA)))
                        {
                            DerefOf (Local0 [One]) [Zero] = 0x03
                        }
                        ElseIf (((INAC == Zero) && (INCH == 0x03)))
                        {
                            DerefOf (Local0 [One]) [Zero] = 0x04
                        }
                    }
                    Else
                    {
                        DerefOf (Local0 [One]) [Zero] = 0xFF
                    }

                    If ((BATP & 0x02))
                    {
                        BSEL = One
                        DerefOf (Local0 [One]) [One] = Zero
                        If ((((INAC == Zero) && (INCH == Zero)) && (IDIS == Zero)))
                        {
                            DerefOf (Local0 [One]) [One] = Zero
                        }
                        ElseIf (((((INAC == Zero) && (INCH == One)) && (
                            IDIS == 0x02)) && (B1B2 (M1AX, M2AX) == Zero)))
                        {
                            DerefOf (Local0 [One]) [One] = One
                        }
                        ElseIf (((INAC == One) && (IDIS == One)))
                        {
                            DerefOf (Local0 [One]) [One] = 0x02
                        }
                        ElseIf (((((INAC == Zero) && (INCH == One)) && (
                            IDIS == 0x02)) && (B1B2 (M1AX, M2AX) == 0xFA)))
                        {
                            DerefOf (Local0 [One]) [One] = 0x03
                        }
                        ElseIf (((INAC == Zero) && (INCH == 0x03)))
                        {
                            DerefOf (Local0 [One]) [One] = 0x04
                        }
                    }
                    Else
                    {
                        DerefOf (Local0 [One]) [One] = 0xFF
                    }
                }
                Else
                {
                    Local0 = Package (0x02)
                        {
                            0x35, 
                            Zero
                        }
                }

                Release (ECMX)
                Return (Local0)
            }
            Else
            {
                Return (\_SB.PCI0.LPCB.EC0.XGBT())
            }
        }

        Method (SBTC, 3, NotSerialized)
        {
            If (_OSI ("Darwin"))
            {
                Debug = "Enter SetBatteryControl"
                Debug = Arg0
                Debug = Arg1
                Debug = Arg2
                Acquire (ECMX, 0xFFFF)
                If (\_SB.PCI0.LPCB.EC0.ECRG)
                {
                    Local0 = Arg2
                    Debug = Local0
                    Local4 = Package (0x01)
                        {
                            0x06
                        }
                    Local1 = Zero
                    Local2 = Zero
                    Local1 = DerefOf (Local0 [Zero])
                    If ((Local1 == Zero))
                    {
                        Debug = "battery 0"
                        If ((BATP & One))
                        {
                            Local2 = DerefOf (Local0 [One])
                            If ((Local2 == Zero))
                            {
                                INCH = Zero
                                IDIS = Zero
                                INAC = Zero
                                B1B2 (M1AX, M2AX) = Zero
                                PSSB = One
                                Local4 = Package (0x01)
                                    {
                                        Zero
                                    }
                            }

                            If ((Local2 == One))
                            {
                                INAC = Zero
                                INCH = 0x02
                                IDIS = One
                                B1B2 (M1AX, M2AX) = Zero
                                PSSB = Zero
                                Local4 = Package (0x01)
                                    {
                                        Zero
                                    }
                            }

                            If ((Local2 == 0x02))
                            {
                                INAC = One
                                INCH = One
                                IDIS = 0x02
                                PSSB = Zero
                                Local4 = Package (0x01)
                                    {
                                        Zero
                                    }
                            }

                            If ((Local2 == 0x03))
                            {
                                INCH = 0x02
                                IDIS = One
                                INAC = Zero
                                B1B2 (M1AX, M2AX) = 0xFA
                                PSSB = Zero
                                Local4 = Package (0x01)
                                    {
                                        Zero
                                    }
                            }

                            If ((Local2 == 0x04))
                            {
                                B1B2 (M1AX, M2AX) = 0xFA
                                Local4 = Package (0x01)
                                    {
                                        Zero
                                    }
                            }

                            If ((Local2 == 0x05))
                            {
                                INAC = Zero
                                INCH = 0x03
                                Local4 = Package (0x01)
                                    {
                                        Zero
                                    }
                            }
                        }
                        Else
                        {
                            Local4 = Package (0x01)
                                {
                                    0x34
                                }
                        }
                    }

                    If ((Local1 == One))
                    {
                        If ((BATP & 0x02))
                        {
                            Debug = "battery 1"
                            Local2 = DerefOf (Local0 [One])
                            If ((Local2 == Zero))
                            {
                                INCH = Zero
                                IDIS = Zero
                                INAC = Zero
                                B1B2 (M1AX, M2AX) = Zero
                                PSSB = One
                                Local4 = Package (0x01)
                                    {
                                        Zero
                                    }
                            }

                            If ((Local2 == One))
                            {
                                INAC = Zero
                                INCH = One
                                IDIS = 0x02
                                B1B2 (M1AX, M2AX) = Zero
                                PSSB = Zero
                                Local4 = Package (0x01)
                                    {
                                        Zero
                                    }
                            }

                            If ((Local2 == 0x02))
                            {
                                INAC = One
                                INCH = 0x02
                                IDIS = One
                                PSSB = Zero
                                Local4 = Package (0x01)
                                    {
                                        Zero
                                    }
                            }

                            If ((Local2 == 0x03))
                            {
                                INCH = One
                                IDIS = 0x02
                                INAC = Zero
                                B1B2 (M1AX, M2AX) = 0xFA
                                PSSB = Zero
                                Local4 = Package (0x01)
                                    {
                                        Zero
                                    }
                            }

                            If ((Local2 == 0x04))
                            {
                                INCH = Zero
                                IDIS = Zero
                                INAC = Zero
                                Local4 = Package (0x01)
                                    {
                                        Zero
                                    }
                            }

                            If ((Local2 == 0x05))
                            {
                                INAC = Zero
                                INCH = 0x03
                                Local4 = Package (0x01)
                                    {
                                        Zero
                                    }
                            }
                        }
                        Else
                        {
                            Local4 = Package (0x01)
                                {
                                    0x34
                                }
                        }
                    }
                }

                Release (ECMX)
                Return (Local4)
            }
            Else
            {
                Return (\_SB.PCI0.LPCB.EC0.XSBT(Arg0, Arg1, Arg2))
            }
        }
    }

    Scope (_TZ)
    {
        Method (GCGC, 0, Serialized)
        {
            If (_OSI ("Darwin"))
            {
                Name (LTMP, Buffer (0x02){})
                If (\_SB.PCI0.LPCB.EC0.ECRG)
                {
                    Acquire (\_SB.PCI0.LPCB.EC0.ECMX, 0xFFFF)
                    LTMP = B1B2 (\_SB.PCI0.LPCB.EC0.B1PR, \_SB.PCI0.LPCB.EC0.B2PR)
                    Release (\_SB.PCI0.LPCB.EC0.ECMX)
                }

                Return (LTMP) /* \_TZ_.GCGC.LTMP */
            }
            Else
            {
                Return (\_TZ.XGCG ())
            }
        }
    }

}
