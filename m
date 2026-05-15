Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012065.outbound.protection.outlook.com [52.101.48.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D39B3EEADE;
	Fri, 15 May 2026 22:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778882648; cv=fail; b=BmQO5jav4lIasc4mRSvWClIFnIKEYROMtTlIlVltJ/Ef/jBlEjt2ZZrzlpvTe3sOPaYvhdWveolYdEt+71tluuLyZrY0wQrzkGtCtjRvcUpo0HyEXAo1d6J0TmAAeq1gblVUCl1laEKpSgwylnaK6imy8nAbrhBbJTcGc5FC6t0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778882648; c=relaxed/simple;
	bh=0OT6cEEySTMBsVKjZ1t7exidqd037Ts0ISI/crjmk9I=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=a6Vq9Oyuq9k9RQR/wIBsq7FUphqlVABK2oPrw+hTFDYYjN9dsxv9ZJmxkTECyiLyXH+DPCq9cF0UKZY+KMeWdrf2GcFW8q0q6Q2/OFWTnGU53CIyUoP1fCidYxs4UMegPEuEuPhh7aueSGUNlJUZJL0DQ18Hp0KXoQtEfQJWl80=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QK9wi2mM; arc=fail smtp.client-ip=52.101.48.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QK9wi2mM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lu2JRRDas3FKshLZuP+VfJ0T0FRvNd9+1UV++smkqE5ApmqnXSSxdRJ6aIzArK1V84w+LIyRcDmW9Nptkh58oH2/n8tHwVBRAQbDatA/i7mDuFLQDP0TGatite2D+27670941MyGMIyxQr8FPFFlF8S8uKw2atmIrdRBwUIUslRlm6/bjGL4E7eOAowYs7XHVN/O7zDGUN0yfXV6FdXYt6kiKTIGW+UywuAQQp4Ov2yiNtZZua1DuoXxxDa6NVDOIJYH+Ai5nJpNnZjkZ0Z0h9tNT9s09TUAxQEgRW4sKWelFdjhc3PEqErqHmI0QO81f1HBXyulxKA26pi7uOphLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MsHZm3ngPSRp4ouFFYwsmS1HdffylYqTfJ5BkNx08mQ=;
 b=eFzC0oEypPo0PvD44N63fQyMAKv7R4S4PM5os9d8HiwS3FfdZtRFPn+2GPFUhLhvLfppKPbMICyiaCPMJ364IiQjbfbIXIxHYKyC4lg2lmeP1nr1UNwGxCGtxJfcc0XyH12NMBBN1fD7aCBjCSle1Xgpb7dsQycyJlqAEzXmfYIgOk3ia8fRXwySGPgbpZZYWypTpVUGEBH4039FqUValep5YwNAnaI4zmCgG3EbSrb2My7KrjVuXvoUVeHo2YwYeuAq4L39Ixt6L5n00o9c5ox1o66U3zXX2OWhEHk1MApQMOdbHd5/kHs4t8K7RXUoC8gCGCEDSwNEMwHabnQeOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MsHZm3ngPSRp4ouFFYwsmS1HdffylYqTfJ5BkNx08mQ=;
 b=QK9wi2mMXXf5E5KVJT6PjBWqhNPvquN59pklrQW5E5BzZ1ayxfeIGSzAcepjXxKpyadep3nta5Y4q/T07wwjJLeufDnfU1aKLdHuNhyT4CAQxZClJwQASSM1vqvWnD424Tc9wwDKO9zMmj87yLnYgSy+PThXYdjC91esE7F+GFGwv+jYBme18g9RhORpifirNtULMZTT+LmxchYYW5YHQLw/z4AfI49dT4brkOp9UG8ndooWqnLvy1klLSXXneecWs6CcbE3kHc8y2EQCOSPZiIBpeBK47Orrh9Vgh9+7vyVjo6UnzNuzlLijIINb01RVV5+x6xU8s2/h3iFm2v6aQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9411.namprd12.prod.outlook.com (2603:10b6:408:215::20)
 by IA0PR12MB7751.namprd12.prod.outlook.com (2603:10b6:208:430::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.20; Fri, 15 May
 2026 22:04:04 +0000
Received: from LV3PR12MB9411.namprd12.prod.outlook.com
 ([fe80::98b7:86de:b69:2a15]) by LV3PR12MB9411.namprd12.prod.outlook.com
 ([fe80::98b7:86de:b69:2a15%4]) with mapi id 15.20.9913.009; Fri, 15 May 2026
 22:04:04 +0000
From: Alex Williamson <alex.williamson@nvidia.com>
To: jrhilke@google.com
Cc: Alex Williamson <alex.williamson@nvidia.com>,
	Alex Williamson <alex@shazbot.org>,
	kvm <kvm@vger.kernel.org>,
	David Matlack <dmatlack@google.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH 0/8] selftests/vfio: igb: 82576 hardware compatibility
Date: Fri, 15 May 2026 16:03:07 -0600
Message-ID: <20260515220330.565792-1-alex.williamson@nvidia.com>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CY8PR19CA0009.namprd19.prod.outlook.com
 (2603:10b6:930:44::14) To LV3PR12MB9411.namprd12.prod.outlook.com
 (2603:10b6:408:215::20)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR12MB9411:EE_|IA0PR12MB7751:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ec6b122-a17f-490f-f0a1-08deb2cde09c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|18002099003|56012099003|11063799003;
X-Microsoft-Antispam-Message-Info:
	ZyN8tngcOjIkufm8vpqkKnPIYL237Te6J7gqwV52TAUj2zoH46oYHywe+g70UG1YDwuneAKABOWWJP1qK/3Om++ieDQ/JK2K5ZjU7i/cKD3AGSkIpbQ5PCHdXLwvkawXBRMIbqu3wM+4l9dOgn0zzcSx/37/6pgI+17XKPdsoQE1nEHzalMt3cNsz9QAQuOoAIwWhk2DPQxmC/hc+NzWx6VcsrBCsla1PS8QXDCCbIHq+5IDjRw//Gr7B8fjEVugVIhzLKYuyQbrmmws1Xzgjp/NU7mt483vZpFobJGf9sDBOEBS9FCOXezvzoujElvT0KadBitI/5JDNQ2GNbt0lX9R4Y9/fgUKW+l9zjM5kxXxsRE/dbSKV/xrURr4gnfubx99XbhMs9Jjr7NPsgACAOX68YsMEjwPbToT/GL9686lYkT8Gnkulxo8qqTdRfzEYIHIL+wBUxn/dSt5LeQ4LK2yGIKxm77YY/yHC6f0Xx3lcU1ad5EymERCj9PlMYL0zOzFqFc7sfJE4tJYBTpmHZqkWINLDqAviPpHVfbRIP/pw6SmnNTncVuKV+yjVsmdBRtcIX01KlqgiNmgGs1kSFV7N7gGgDeNdl7H6lfsfiTZJqcETskgbDvmGKTfzndwh0eS8iR9TtEoocDumiAhQtcNR50gtF8CSPImAr4/saaS/KOz5b6BzuBvqnADPy0r8rZEmRwCwMQKX/Ly+zVe4A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9411.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(18002099003)(56012099003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?l2ds2YZux/zQKr08iQ4JQYt0ySenFn2se9tN3OOwddChGa6DfBKIl5NLCFnT?=
 =?us-ascii?Q?w8sQp/pcXQWlVGFGLWc07ui/LD+J0FPl2NwJiJoaN0tTdljR1tXZOQ8djG/P?=
 =?us-ascii?Q?UUkb5n87DNLuIm8iwdWFTkFuO3gDeYgNh97w2mRisd22yAwv+sNPonLPvJHh?=
 =?us-ascii?Q?1LaGxG/cFg203utMjL2ovsVAPfbxPVE2ldnO9rDI1XhgEFz0B1hIt8XndukN?=
 =?us-ascii?Q?t3IjG/hbTCdgeogI42SLC20IZzspTFlhP++dYTFZ5dGlJgbVxOHdOLuz4/Tz?=
 =?us-ascii?Q?xG2AJ9aL1fUR6WyHwjgixfiESvK1glkdpRzpxSXEx67/CSKFdecpEM4EQAZ1?=
 =?us-ascii?Q?9I58orunkH0CaslwT7EyyQdvOiK6CoK9e1W/L2yqksONuVP2vry/ZWVlKCt0?=
 =?us-ascii?Q?Mk5HZ1DnHJAMYzR9peRwVetWOzRW9fIo1LoyPHBvIwor9sW2fq4oTXkdwO2G?=
 =?us-ascii?Q?1UG/XTOM0jktrG0IY+ePc6dlIdWqKyP8OpOP3YRnrbW+yMOg6VT+Vid6RE9D?=
 =?us-ascii?Q?bsPULNCqZqXgjYPPX1H7OUh2de8qSMfK/bjN+GJAT2F7XB7fPJEiPm/vkLrS?=
 =?us-ascii?Q?y4B0vMBYWHnMUXbMLZLIdtLT0r96uYAkI8yuWNrCzvs/PXG7gRntF5yLo5Wv?=
 =?us-ascii?Q?BF5+PdkBK8adiiSD0an3iNZ2NACIx17QHSUDKpTsw+4pZGIsT8zieRhYi1P8?=
 =?us-ascii?Q?BtsxPWE89dcTGVkmOgvKpMgWrJdyktC1nKYIN7LA6OCsAf8YVfguG9hnR3uJ?=
 =?us-ascii?Q?8S4PUazu3Lxu0lZyoN8efcVtvYXhhInf452fCw7k4c0yC29O1zbE/59qan7Q?=
 =?us-ascii?Q?vkx6c+qEbv9njOG4Oy1yZz4SWZFvO1lJ3KTVF+bzjiel+oiQolAEyBsuOt8/?=
 =?us-ascii?Q?7U3Aq9klhaCJcd6nIdc0Bx+yJYkl8oaXzL7M3B6svkTR8sgYa137y5Xe2q39?=
 =?us-ascii?Q?hIi2Wazmu17q/qaFKcbelBOR8jBaI3lHkTLiNQuk6vefvuip/rmEK7ptkMru?=
 =?us-ascii?Q?chKYlVCP8xxypUxFERj5jBZtnNdXCkkOWi9pMj6ovtW1dwyeWDY112VPy+ib?=
 =?us-ascii?Q?/iPgEvcSRFgHF5X0lKmHKpZ6mqdoPL2ypjwrCSgubgVZCV35XJqtRECaS07k?=
 =?us-ascii?Q?8uMxRsNztq5yfkUEgG3ReRlFeHCh/iCHDZjbeCUPc5yilWTFaWOBorTXlM76?=
 =?us-ascii?Q?omA8A9ZLzoZKgS4f3XtwlQ+6MmS5Nu4a+DM8HxQmkN0I3xUvKzE7pAMFHa36?=
 =?us-ascii?Q?G+3EQr0PW88t6zE6eTw/DWpBRKpN4TbxiKAvDK91EWNWLXo5+0qA7uGqqH/X?=
 =?us-ascii?Q?mO9c9RMIm8zmVh6I/okVaQD/mnGSmich4WfhxwBbuMPxNGxBIqqPEfYSbJ+D?=
 =?us-ascii?Q?6V8gEEDJR8PmgQlI5UbkvvKHVupPZ1V96k31LL0PO4GVJHWqKmnwsXfIWc7g?=
 =?us-ascii?Q?Ffv7E7/LsDOpUd1XY6wxHu9639WzBBDOALxkckTYjNgFPm3dAFylGtaSCAZF?=
 =?us-ascii?Q?RX3XrXwFeuzJcRWC0GRCJXWsvbGaTgwPeXXtbiz/iJaLmIEvcZG6vohzz9Az?=
 =?us-ascii?Q?Z1+5xOXrBAQqwmaml7NbSapVrqjAQ/7a3YlIQvYLjegBMjmltAcQ9xCMehQh?=
 =?us-ascii?Q?i7rNEv03OL8aeBkKMwUuHycq2xMbCWUbN5SoAYc0jWsaNcQOCYQPGo34Oaxa?=
 =?us-ascii?Q?/xSmYLJfdIYKs5YaB2YeuC4IkNC6BmaKs9+CL1SZiNPfAwk0m998/Z3Ts04f?=
 =?us-ascii?Q?effKSe7HTg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ec6b122-a17f-490f-f0a1-08deb2cde09c
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9411.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2026 22:04:04.0924
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XIduaA9tY/Vh4/nL7bGUnAv3q799pEheJEDbDQnb2jL0dN9QUP7xKX7SeYitGODERyli9MI745x6Pe4wq7U6mg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7751

This series is based on Josh Hilke's initial igb selftest driver
posted as:

  https://lore.kernel.org/all/20260511211839.2781731-1-jrhilke@google.com/

That posting validated the driver against QEMU's emulated igb only; it
has not been tested on physical 82576 hardware.  Real 82576 silicon
rejects several of the shortcuts the submitted driver relies on (MAC
loopback, legacy TX descriptors, read-to-clear EICR, autoneg-based
link bring-up, and an unbounded fault-recovery story), and adding
real-hardware coverage is the goal here.

Two of the patches add accommodations specifically for QEMU's emulated
igb (which does not implement PHY-register-0 bit 14 and does not drive
STATUS.LU from CTRL.SLU) so that Josh's "run selftests without
hardware" workflow continues to work.  One of these (RCTL.LBM_MAC)
deviates from datasheet 8.10.1 guidance; empirically the bit has no
observable effect on real 82576 because MAC loopback is not
implemented (3.5.6.2).  See patch 1 for both rationales.

  1) selftests/vfio: igb: Use PHY internal loopback on 82576

     Replace MAC-loopback-via-RCTL.LBM_MAC and PHY autonegotiation with
     PHY internal loopback per datasheet 3.5.6.3.1.  Force the MAC link
     state via CTRL.FRCSPD/FRCDPX/SLU since the descriptor engine
     otherwise waits for a real negotiated link.  Keep RCTL.LBM_MAC
     (deviates from 8.10.1 guidance but empirically inert on real
     hardware per 3.5.6.2) and prefix the loopback setup with a
     one-shot autoneg-restart PHY write (the next PHY write clears
     autoneg-enable before autoneg can start, so this is a no-op on
     real silicon); both are required by QEMU's emulation.  Drop the
     dead igb_read_phy() and its now-unused macros.

  2) selftests/vfio: igb: Use advanced TX and RX descriptors

     Program SRRCTL.DESCTYPE for advanced one-buffer receive
     descriptors (datasheet 7.1.5.2, 8.10.2) and build advanced TX data
     descriptors with DEXT/DTYP/IFCS/EOP/PAYLEN (7.2.2.3) rather than
     the simplified legacy format the submitted driver used.  Drop the
     unused legacy TX descriptor macros.

  3) selftests/vfio: igb: Program MSI-X interrupt routing

     Configure GPIE.Multiple_MSIX and GPIE.EIAME (Table 7-47), EIAC
     and EIAM for vector 0 (8.8.5, 8.8.6), and switch EICR clearing
     from read-to-clear to write-to-clear (7.3.4.2 / 8.8.5 forbid
     reading EICR while EIAC is programmed).

  4) selftests/vfio: igb: Extend memcpy completion timeout for line-rate
     hardware

     The submitted 1 ms cap is well below the 32 ms line-rate floor for
     a 4 MB transfer at 1 Gb/s.  Bump to ~200 ms (6x margin).

  5) selftests/vfio: igb: Disable PCIe completion timeout retries

     Clear GCR.Completion_Timeout_Resend (datasheet 8.6.1) so the
     intentional unmapped-IOVA tests do not generate an unbounded
     stream of retried reads on real hardware.

  6) selftests/vfio: Add vfio_pci_irq_reenable() helper

     New libvfio helper that re-issues VFIO_DEVICE_SET_IRQS against
     existing eventfds, for drivers that recover from
     VFIO_DEVICE_RESET without disturbing user-side eventfds (and any
     fd a test fixture may have cached).

  7) selftests/vfio: igb: Factor hardware programming into igb_hw_init()

     Pure refactor splitting igb_init() into a one-shot outer
     (region-size check, BAR map, CTRL.RST, IMC, vfio_pci_msix_enable)
     and a reusable inner that programs the registers CTRL.RST clears.

  8) selftests/vfio: igb: Recover after DMA-read faults

     Add igb_error_reset_and_reinit() and call it from
     igb_memcpy_wait() on completion timeout.  Datasheet 4.2.1.6.1
     describes CTRL.RST as the recovery mechanism, but empirically
     CTRL.RST alone leaves the descriptor engine wedged after a
     DMA-read fault; the 82576 advertises PCIe FLR (datasheet
     4.2.1.5.1) and VFIO_DEVICE_RESET drives it.

Testing:

  - Selftest builds clean at every commit (verified bisect-buildable).
  - QEMU emulated igb via vng on a host kernel built with VFIO and
    Intel IOMMU enabled: vfio_pci_driver_test 35/35 pass across all
    four IOMMU mode permutations.
  - Physical 82576 on Intel Alderlake platform: vfio_pci_driver_test
    35/35 pass across all four IOMMU mode permutations.

Assisted:

  - Series developed primarily with Claude Opus 4.7 with additional
    assistance from GPT 5.5.  Spec references spot checked and cross
    checked against multiple models.

Alex Williamson (8):
  selftests/vfio: igb: Use PHY internal loopback on 82576
  selftests/vfio: igb: Use advanced TX and RX descriptors
  selftests/vfio: igb: Program MSI-X interrupt routing
  selftests/vfio: igb: Extend memcpy completion timeout for line-rate hardware
  selftests/vfio: igb: Disable PCIe completion timeout retries
  selftests/vfio: Add vfio_pci_irq_reenable() helper
  selftests/vfio: igb: Factor hardware programming into igb_hw_init()
  selftests/vfio: igb: Recover after DMA-read faults

 .../selftests/vfio/lib/drivers/igb/igb.c      | 318 +++++++++++++-----
 .../vfio/lib/drivers/igb/registers.h          |  58 +++-
 .../lib/include/libvfio/vfio_pci_device.h     |   2 +
 .../selftests/vfio/lib/vfio_pci_device.c      |  22 ++
 4 files changed, 302 insertions(+), 98 deletions(-)

-- 
2.51.0
