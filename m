Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11020127.outbound.protection.outlook.com [52.101.84.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF757328B77
	for <kvm@vger.kernel.org>; Tue, 28 Apr 2026 17:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.127
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777396429; cv=fail; b=NHQ74db0DCRAFKIxuFvRgcD27Fi4NSy8i/uz0wa/HZSbd8VzRzXtiBJlrF1MaAQ4M1g50EZmvdMYecDv/NB6pb/rthY6/GjjDnuEogzxtcfn9KqmOir0FzkpIFLOqPD/nOdzP+M+j1o2T4AshZgzW95rKsToma2zlEDlEGzHqAs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777396429; c=relaxed/simple;
	bh=aYAPcplC/ScgWp4VvSKpUDOc8d4PhGbvOAdSQiSdB3Y=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=HiHm3FJulNaESun2lzzsIv8Ox++x/IqavBXAJE/wLSQvvuVDLj5wyrkpC1oCFTKLeFGgB8Pnue2A6CQF+6KWIAI85Lun8Qh49jebZ8lbwjWLodddftbWeODG2c8XUbe+ZwyMk52IaDl8KzYNybuHlJFI+DbE0xzcjSGD9hFdkbE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=netum.fi; spf=pass smtp.mailfrom=netum.fi; dkim=pass (1024-bit key) header.d=netum.fi header.i=@netum.fi header.b=upASUIy7; arc=fail smtp.client-ip=52.101.84.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=netum.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netum.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=netum.fi header.i=@netum.fi header.b="upASUIy7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YWadnA/2F4dMqzZ1GO9IXXpe38iokHppQm60C+4a4QMc4Onab9x3eZVkzIOFUiTjNo2KmzZn1fukmtfLnE5fmClvrOM4Bj2o9udybzaRDQ0A4UBB7l5o2cQH7vxbhb+iLtvSC4CY5XLzGl0rWfuiTHcaohSwTgjnO+okPJr0vnLuSybZe/3djkN1DNJLkQQVHE8njYG4jeqy+q+7WMxxwumoIRM7mU/YCZqYNsEgyDf5LVZPMUMGY0Ejiq4G4Ftdsi1ARkz92yC7RTu0eRhzM0ROW8FJ38hV3uyPueimHLOoj8GEc5t8RrVY45XbsRKRACmDKQBeVMzYxlbkjhknOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2xQoteArFGtQx4uCLIf59aCShiqros5aFjX0lTvDg2Q=;
 b=y9s6MC+a/NM7Tcm5/RFMfxyOBAbY0J7Q4NtLmFDG5A5UQnzxanj4F3Umy6jB2wZz2kshEh9s4c88Y6m5Plws3gBL4hwHhzZVjhGmASem4DBhEXEkHxoC2Cc8sHeZNuThj93eQM2OHZ9FumMBpMPJhoPrQHEec6YGftlvhPpOYrZpgwA3iMlmjFi2SKYIeykSdkkNC2VgJtHQmZHkIBV9hiVESjDpu25eIPbBs4HDWKXwYB8kKKdy07BhjKUO3QBs+umIztgt4dQNvnXAaNO/ZSCEF1uDfaJvhIbpcwGiaFueSGt/tqu1ubEmYxfYlv2PAa4B0Tt6y1rIr3FISmk8oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=netum.fi; dmarc=pass action=none header.from=netum.fi;
 dkim=pass header.d=netum.fi; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netum.fi; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2xQoteArFGtQx4uCLIf59aCShiqros5aFjX0lTvDg2Q=;
 b=upASUIy7bwagJnVOL22mofObGAZmvwoaVztux93/aI6MbqbxzFeX2FIAWjlZyrNeX9mgS6cITstb/0bdoXbOoLGdSMbtCp2A9BJWyV1uCB8+kFnxkmbbBwnhRVmrmDQKNzKc8CQYzRx+6DWjb/1sqAR6+jjHrlO1Zcb/Ym0XfZg=
Received: from GVXPR02MB12019.eurprd02.prod.outlook.com
 (2603:10a6:150:30f::19) by DB9PR02MB7115.eurprd02.prod.outlook.com
 (2603:10a6:10:223::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.22; Tue, 28 Apr
 2026 17:13:41 +0000
Received: from GVXPR02MB12019.eurprd02.prod.outlook.com
 ([fe80::d5ec:2c8c:3d7:fdf9]) by GVXPR02MB12019.eurprd02.prod.outlook.com
 ([fe80::d5ec:2c8c:3d7:fdf9%6]) with mapi id 15.20.9846.025; Tue, 28 Apr 2026
 17:13:41 +0000
From: =?iso-8859-1?Q?Joonas_Kylm=E4l=E4?= <joonas.kylmala@netum.fi>
To: "alex@shazbot.org" <alex@shazbot.org>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Subject: VFIO dma-buf bug causing "refcount_t: underflow; use-after-free"
 error
Thread-Topic: VFIO dma-buf bug causing "refcount_t: underflow; use-after-free"
 error
Thread-Index: AQHc1yyg4T1YbZEQ8E67eovCs95Pww==
Date: Tue, 28 Apr 2026 17:13:41 +0000
Message-ID:
 <GVXPR02MB12019AA6014F27EF5D773E89BFB372@GVXPR02MB12019.eurprd02.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=netum.fi;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GVXPR02MB12019:EE_|DB9PR02MB7115:EE_
x-ms-office365-filtering-correlation-id: da2364f8-4ce8-45d2-25fd-08dea5497ed2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|38070700021|18002099003|56012099003;
x-microsoft-antispam-message-info:
 8Z8bs590P0UJETsXNrBbbWijeU6CfVdIM+q26USvbEIPDi7fpKqiBk0osgfzps0RtH8jHxEA+gYuBF9OiekZJeuCrpMOClACfEAXcpdVw5bOPymFqpxlvi6+2xJJgwGEBqT+YidGKRJ/eJkpI1n7sq/lsn7hc/B3iRx746TPUJE0xT00tlt8LoZ4E4QfTFQUNxaE2spuJ/MWBRA3U4t+eMe9RKxOEa+zPzxHN1t6yeeIiMwWBCy649NL6qCEPQt+CNLG4jnbZi6mEx2Aub72uGR7yNyTBHX4nnqdQCCHlxVyAqCMdQGd2/F9rYKMYtuqiXPmN20os/cyuJljCb/1b9kxHWf0CwyDjdvZvAcWo9NryGJoD6F/k6EbAGtGht9eZq8Z+SikDVYKJyQm5Lxpu4HUWQoUt4Jiv+UFR2RDcH+E4FqRe4u0yCo+F7oWbpNnzp2CkRDcTiBxxIhb9O1wanCOmsJBiYeJzpUbf5VftOlG1GRN2+qoX5RRaYJ6gvwPXwGYXLXJ3UAAsJ9x/N8kenYhgfsXfVaWlIovPLWjAutHPLJW+A9Ciq/KSySd7ZUdEsoBt9yhfkeHbq9IJnQASDeJ1oLoMg4pN+f5hRAU+mkuTaYp+erv8E/ewS3MzJIbdbuo16K2RS3eIj7ljTBWnwiWZgnkSgfdCafx0oIbAFLGAGfXunjmFFPpttqVsAA5fp6Suq9flpApie427Fw5x2QxuHUCdhMuBss9b8JaAjHjpBtSJXvL52iMqci4VWQiHX1bBC/1BQTBkV/fScj/RL+s3I2WO/1o4BpDGfCmZh0=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXPR02MB12019.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(18002099003)(56012099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?/fRGsbOE5JLKW9wUsyf7j1C5kLYv6/WOT6mWOkzGf5y1UAckxgl2g0Wv1h?=
 =?iso-8859-1?Q?4EmMmfTYhQ/d6SWgBI4bpoXckkbg1Uc5yvdVX7iySVw21k9EDAgnRegIx1?=
 =?iso-8859-1?Q?30rx9BoZQcJAROPEVP5QSylUhu+ymvqbEKOvTgqRkjIgdy/WDeWBdEhWph?=
 =?iso-8859-1?Q?Z2hkcRi4rcqacCsgA38iE/Ff5Xfoplg4yFKdQxDmiW6T85zhPPWIh+gu6a?=
 =?iso-8859-1?Q?/YXmjqGDl5wRkJz0nAzP5VP94VLb2Z+oCJRixs9fe5eb35U50Ix04vdeSj?=
 =?iso-8859-1?Q?Q85tsW1XLRn9fLfKr0lPSKdMHxk04RNe1uZJ57n6SgA7lbCVGCaPYbi4k5?=
 =?iso-8859-1?Q?CoC/NpF4lGE51QdH8jUBMSzr5A3pOIwO9xTn3dgARnM/JnKmmpo8h1jc+p?=
 =?iso-8859-1?Q?e2d8B3NEBfIBegoN8W7NexLuy4UV0qhrex4+9ytKn2JRLahTbOXktMnc38?=
 =?iso-8859-1?Q?L0EMMgf3LaxDQhnp3D7wcHQLJ4qkkJa3nkTLnux+gJafH50y4aXTRU3V8L?=
 =?iso-8859-1?Q?0X8pyb0z0yVgqMvE9951ewp2bV2JcFDvacEglfKLyS5pCT/N8XU+F8hID/?=
 =?iso-8859-1?Q?8S+C3TyYMceDd2WUFZFqSQ0LNtTjfx1qN+3IyFBEIBQ51UpH1CM8pE53KI?=
 =?iso-8859-1?Q?WR4yffrMi0MvK2gkS8hBfMYKulXRzZRcr6nTV0D2urgXKz5x3jCQKUs1fu?=
 =?iso-8859-1?Q?VGLfH3Sn5uEjx5JFmcBNYr93iE4XfVH9YjDVpOl27cYcrEqLjbDhlE6vYe?=
 =?iso-8859-1?Q?CSl36NL0b2l1SIBqAws4xdDW68pO3PRIG6bcMOmNeTEljB13uh1do503UA?=
 =?iso-8859-1?Q?+gEDq4LOH98tVd0LwnmJwYcVxIjEK6YHm/Duxz86bm0yX4BWXZalWZRYRY?=
 =?iso-8859-1?Q?XH19H2WhfG7o3MHPVUCrUPDwFYuy5aRUKCnDSpONRLRDvJotqkHmXgC5sh?=
 =?iso-8859-1?Q?7PCbkouzVzGzVBMUVql/Ir0yehEFGZ2Z235sIWbRU+/e5eVKuY0K8mpIXf?=
 =?iso-8859-1?Q?4Ozf4WJzNJI7VfeCLxV+1iT+QdfZXvM0rt0xZCQMkhndxUNEej2tSw8d6B?=
 =?iso-8859-1?Q?2OQD/oirn/Cf9VEPc816ADwe+sm8bW7bHFPyeQJA/KN6HnPJxsuBBRUQ43?=
 =?iso-8859-1?Q?jhW3owj/YSyGqdmrkuw004kf3v+fxku3ocvxZh5v39lSCfmRQIly6oCKiu?=
 =?iso-8859-1?Q?aQI17n2y3o4zTFFmTjYN/zxiwglFRAItZkxCjjOdGrWX3MlPr8HfsQsYEi?=
 =?iso-8859-1?Q?7fE9aYe/zSf1KhVd86m7IhOvKpo/v00Mng8LsQ7dS/sTqrJ0v4eXmJAqSX?=
 =?iso-8859-1?Q?wo0MYxIL2tgoSuUatGuaHilhExBgwTpHYLJBbBuI9tO1z3fmqVi/5sMsSg?=
 =?iso-8859-1?Q?JPnddBJ4RL56Qi1qdzE3KFGV5I4EHJd25RGXrLd3bB/6fT2h9RgjUvxAX4?=
 =?iso-8859-1?Q?khZfmaEuhstvX3YFOwkR37nVFMJM3rv4JpXOwVr3efcJN3nRb4RAgUkzE9?=
 =?iso-8859-1?Q?eTkKjktZNlFpXD6Jy6SKSrqRFS1eXQafg1Vz66xqxmpVNCnjv5Q+8CGMrH?=
 =?iso-8859-1?Q?8dSv51XepWgquRliUvF+klNDbZTii5wr7/4Y9CQ2UlrgV2nH+M8+/cN+Zp?=
 =?iso-8859-1?Q?XE+IgxR7xuL22/7rxKR9L72xiRotbHLls/LcJ4zQPrD136APs5lAeBtGH9?=
 =?iso-8859-1?Q?NMJvsK+bwBt6qQtUFWHij9giXISGh0QB1Y9Q5HdKZ9q99sbkmrC9Onpdew?=
 =?iso-8859-1?Q?Ql09R53JW59MxWXzo3Byc+9rKTk2oDgs4nQnLt5qL5pBiRRcMgte8FMRiy?=
 =?iso-8859-1?Q?QPiccaoGBQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: netum.fi
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GVXPR02MB12019.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da2364f8-4ce8-45d2-25fd-08dea5497ed2
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2026 17:13:41.1493
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 1330b308-7c67-4943-8c87-7d7ac3b96393
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SFWR7911ZeCIsvuFPnDNLAQ/1lz7kH6NquVZBTqrPCE3sitk/41rALBwiqyA7clPoIZjwc8Qkb/S2xSNOwbCyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR02MB7115

Hi,=0A=
=0A=
I was learning today about AI and asked it (GPT5.5 & other models) to find =
issues in the VFIO code. It found a bug in vfio_pci_dmabuf.c leading to ker=
nel printing following error trace in dmesg when I run a reproducer script =
the AI generated:=0A=
=0A=
[  215.226402] vfio-pci 0000:0a:00.0: resetting=0A=
[  215.371687] vfio-pci 0000:0a:00.0: reset done=0A=
[  216.397532] ------------[ cut here ]------------=0A=
[  216.397540] refcount_t: underflow; use-after-free.=0A=
[  216.397542] WARNING: lib/refcount.c:28 at refcount_warn_saturate+0x59/0x=
90, CPU#5: python3/3269=0A=
[  216.397557] Modules linked in: vfio_pci vfio_pci_core vfio_iommu_type1 v=
fio sd_mod scsi_mod scsi_common ccm snd_seq_dummy snd_hrtimer snd_seq snd_s=
eq_device rfcomm algif_hash algif_skcipher af_alg qrtr bnep binfmt_misc nls=
_ascii nls_cp437 vfat fat snd_hda_codec_intelhdmi snd_hda_codec_hdmi snd_hd=
a_codec_alc269 snd_hda_codec_realtek_lib snd_hda_scodec_component snd_hda_c=
odec_generic snd_soc_dmic snd_hda_intel snd_sof_pci_intel_tgl snd_sof_pci_i=
ntel_cnl snd_sof_intel_hda_generic soundwire_intel snd_sof_intel_hda_sdw_bp=
t snd_sof_intel_hda_common snd_soc_hdac_hda snd_sof_intel_hda_mlink snd_sof=
_intel_hda soundwire_cadence snd_sof_pci snd_sof_xtensa_dsp snd_sof snd_sof=
_utils snd_soc_acpi_intel_match snd_soc_acpi_intel_sdca_quirks soundwire_ge=
neric_allocation intel_rapl_msr snd_soc_sdw_utils intel_uncore_frequency sn=
d_soc_acpi intel_uncore_frequency_common crc8 soundwire_bus x86_pkg_temp_th=
ermal intel_powerclamp snd_soc_sdca coretemp iwlmvm hid kvm_intel btusb snd=
_soc_avs mei_hdcp mei_pxp btmtk uvcvideo mac80211=0A=
[  216.397650]  videobuf2_vmalloc btrtl snd_soc_hda_codec uvc kvm snd_hda_e=
xt_core videobuf2_memops btbcm videobuf2_v4l2 snd_hda_codec videodev irqbyp=
ass libarc4 snd_hda_core btintel videobuf2_common snd_intel_dspcfg rapl snd=
_intel_sdw_acpi intel_cstate snd_hwdep mc intel_uncore bluetooth pcspkr snd=
_soc_core iwlwifi snd_ctl_led think_lmi snd_compress ecdh_generic snd_pcm_d=
maengine firmware_attributes_class wmi_bmof ee1004 cfg80211 snd_pcm thinkpa=
d_acpi mei_me nvram mei snd_timer rfkill processor_thermal_device_pci_legac=
y snd processor_thermal_device processor_thermal_wt_hint soundcore platform=
_temperature_control ac processor_thermal_soc_slider int3403_thermal proces=
sor_thermal_rfim processor_thermal_rapl intel_pmc_core intel_rapl_common pr=
ocessor_thermal_wt_req pmt_telemetry pmt_discovery intel_hid processor_ther=
mal_power_floor processor_thermal_mbox pmt_class sparse_keymap int3400_ther=
mal int340x_thermal_zone acpi_thermal_rel intel_pmc_ssram_telemetry acpi_pa=
d acpi_tad intel_soc_dts_iosf igen6_edac joydev evdev msr=0A=
[  216.397749]  parport_pc ppdev lp parport efi_pstore nfnetlink efivarfs i=
p_tables x_tables autofs4 ext4 crc16 mbcache jbd2 dm_crypt dm_mod xe ucsi_a=
cpi typec_ucsi typec roles intel_vsec drm_gpuvm configfs drm_gpusvm_helper =
gpu_sched drm_ttm_helper drm_exec drm_suballoc_helper i915 drm_buddy ttm i2=
c_algo_bit drm_display_helper iTCO_wdt intel_pmc_bxt nvme watchdog cec xhci=
_pci rc_core nvme_core xhci_hcd drm_client_lib psmouse sdhci_uhs2 drm_kms_h=
elper sdhci i2c_i801 nvme_keyring aesni_intel video cqhci usbcore e1000e dr=
m thunderbolt gf128mul serio_raw mmc_core i2c_smbus nvme_auth wmi usb_commo=
n battery button [last unloaded: vfio_pci]=0A=
[  216.397839] CPU: 5 UID: 0 PID: 3269 Comm: python3 Tainted: G S          =
        7.1.0-rc1+ #5 PREEMPT(lazy) =0A=
[  216.397846] Tainted: [S]=3DCPU_OUT_OF_SPEC=0A=
[  216.397848] Hardware name: LENOVO 20W0004CMX/20W0004CMX, BIOS N34ET50W (=
1.50 ) 04/08/2022=0A=
[  216.397851] RIP: 0010:refcount_warn_saturate+0x59/0x90=0A=
[  216.397859] Code: 44 48 8d 3d 09 bc 35 01 67 48 0f b9 3a c3 cc cc cc cc =
48 8d 3d 08 bc 35 01 67 48 0f b9 3a c3 cc cc cc cc 48 8d 3d 07 bc 35 01 <67=
> 48 0f b9 3a e9 4d b4 70 00 48 8d 3d 06 bc 35 01 67 48 0f b9 3a=0A=
[  216.397862] RSP: 0018:ffffd05f83a03c60 EFLAGS: 00010246=0A=
[  216.397867] RAX: 0000000000000000 RBX: ffff8db0425a49c0 RCX: 00000000000=
00000=0A=
[  216.397871] RDX: 0000000000000000 RSI: 0000000000000003 RDI: ffffffffb03=
64910=0A=
[  216.397873] RBP: ffff8dafc9fc0550 R08: ffff8dafca8f90a8 R09: 00000000000=
00000=0A=
[  216.397876] R10: 0000000000000000 R11: 0000000000000000 R12: ffff8dafc9f=
c0000=0A=
[  216.397878] R13: ffff8dafc9fc0560 R14: 7fffffffffffffff R15: ffff8db0425=
a4980=0A=
[  216.397882] FS:  00007fc096c06780(0000) GS:ffff8db74ea75000(0000) knlGS:=
0000000000000000=0A=
[  216.397886] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033=0A=
[  216.397889] CR2: 00007fc096932010 CR3: 000000014040b005 CR4: 0000000000f=
72ef0=0A=
[  216.397892] PKRU: 55555554=0A=
[  216.397894] Call Trace:=0A=
[  216.397898]  <TASK>=0A=
[  216.397904]  vfio_pci_dma_buf_cleanup+0x163/0x168 [vfio_pci_core]=0A=
[  216.397923]  vfio_pci_core_close_device+0x67/0xe0 [vfio_pci_core]=0A=
[  216.397935]  vfio_df_close+0x4c/0x80 [vfio]=0A=
[  216.397946]  vfio_df_group_close+0x36/0x80 [vfio]=0A=
[  216.397956]  vfio_device_fops_release+0x21/0x40 [vfio]=0A=
[  216.397965]  __fput+0xe6/0x2b0=0A=
[  216.397972]  __x64_sys_close+0x3d/0x80=0A=
[  216.397979]  do_syscall_64+0xea/0x15d0=0A=
[  216.397988]  ? ksys_write+0x6b/0xe0=0A=
[  216.397996]  ? __x64_sys_pread64+0x91/0xc0=0A=
[  216.398003]  ? do_syscall_64+0x128/0x15d0=0A=
[  216.398010]  ? do_syscall_64+0x128/0x15d0=0A=
[  216.398017]  ? ksys_write+0x6b/0xe0=0A=
[  216.398023]  ? do_syscall_64+0x128/0x15d0=0A=
[  216.398029]  ? __x64_sys_ioctl+0x96/0xe0=0A=
[  216.398036]  ? do_syscall_64+0x128/0x15d0=0A=
[  216.398042]  ? do_syscall_64+0x9f/0x15d0=0A=
[  216.398048]  ? clear_bhb_loop+0x30/0x80=0A=
[  216.398054]  entry_SYSCALL_64_after_hwframe+0x76/0x7e=0A=
[  216.398059] RIP: 0033:0x7fc096c9a687=0A=
[  216.398063] Code: 48 89 fa 4c 89 df e8 58 b3 00 00 8b 93 08 03 00 00 59 =
5e 48 83 f8 fc 74 1a 5b c3 0f 1f 84 00 00 00 00 00 48 8b 44 24 10 0f 05 <5b=
> c3 0f 1f 80 00 00 00 00 83 e2 39 83 fa 08 75 de e8 23 ff ff ff=0A=
[  216.398067] RSP: 002b:00007ffe422781f0 EFLAGS: 00000202 ORIG_RAX: 000000=
0000000003=0A=
[  216.398071] RAX: ffffffffffffffda RBX: 00007fc096c06780 RCX: 00007fc096c=
9a687=0A=
[  216.398074] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00000000000=
00005=0A=
[  216.398076] RBP: 0000000000a83590 R08: 0000000000000000 R09: 00000000000=
00000=0A=
[  216.398079] R10: 0000000000000000 R11: 0000000000000202 R12: 00007fc096f=
43160=0A=
[  216.398081] R13: 0000000000000135 R14: 0000000000a83590 R15: 00007fc096f=
43168=0A=
[  216.398087]  </TASK>=0A=
[  216.398089] ---[ end trace 0000000000000000 ]---=0A=
=0A=
The AI tool explained that bug is about kref_put() being called too many ti=
mes in vfio_pci_dmabuf.c (or something like this, I had to reboot my comput=
er to test this bug with latest kernel so lost the exact response). The bug=
 can be reproduced like this (quoting AI):=0A=
=0A=
> The script exports a VFIO PCI BAR as a DMA-BUF, maps the DMA-BUF fd into =
a=0A=
> Python memory object, revokes it by clearing PCI_COMMAND_MEMORY, then clo=
ses the=0A=
> VFIO device fd while keeping the DMA-BUF fd and mapping alive.=0A=
=0A=
As I'm unsure about copyright matters relating to distributing the AI gener=
ated code, let me instead summarize on my own words on how this is being re=
produced in the script:=0A=
=0A=
1. Open PCI device that has BAR0 using VFIO API=0A=
2. Using VFIO, enable PCI memory write accesses by setting PCI config space=
 command register (0x04) to value 0x2 (memory enable bit at index 1 is set =
to 1). Perhaps it is on by default, so this step may be unnecessary=0A=
3. Use the VFIO API's VFIO_DEVICE_FEATURE IOCTL with VFIO_DEVICE_FEATURE_GE=
T / VFIO_DEVICE_FEATURE_DMA_BUF to create a DMA-BUF file descriptor for a B=
AR0 memory chunk e.g. 4KB. The DMA-BUF descriptor is now open.=0A=
4. Using VFIO, *disable* PCI memory write accesses by setting PCI config sp=
ace command register (0x04) to value 0x0 (memory enable bit at index 1 is s=
et to 0).=0A=
5. Now close the VFIO PCI device file descriptor opened in step 1.=0A=
6. Now close the DMA-BUF file descriptor=0A=
=0A=
As I understand this bug happens because when the PCI memory accesses are d=
isabled the VFIO driver will revoke the DMA-buf and somehow call "kref_put(=
&priv->kref, vfio_pci_dma_buf_done);" once and then finally when closing VF=
IO device it calls it another time, leading to this error.=0A=
=0A=
The kernel version I used was from Linus' repository, commit 3b3bea6d4b9c16=
2f9e555905d96b8c1da67ecd5b (the latest version from today).=0A=
=0A=
Thanks for looking into this bug. Let me know if something is unclear, happ=
y to clarify.=0A=
=0A=
Best regards,=0A=
Joonas Kylm=E4l=E4=
