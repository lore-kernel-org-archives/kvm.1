Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 488E32C326F;
	Wed,  6 May 2026 02:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778036189; cv=fail; b=kNPpgkk9a/SASFPEf3q3PtqjMNXZmprfCXrRYZZON4HRZCgORx+USN3gT1t0sLfkgVDSLap3F+9XgV0s7kt9sl9LS35V3iz+mtLNHTuRI3R1a3O2UGn2CsnpndJpgi39v4v1erlUp3Yl10aBx+tYPXVtyb5q0J5N0R1hUsVOU8U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778036189; c=relaxed/simple;
	bh=lrtrgzT6F4lDh1RVwevzTBySKZalyutMjMr/dWxyF3k=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Kt8HNPBHgXLmA9pNXEZ1EiSd7RiE2YtyryEKob9hItA5vljRyiaoYL5lU52TyPM5Irldxkmw5x/P5w0PcUYn9nbsG7wsh1ozhItH0E8Eqp4X3ywB7opubx5oNvG1GSnmF7Zeffc5DlZ2iBS0CV17OI/dyXlE00SNOyMn3dzZ49g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QX5ovB9u; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QX5ovB9u"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778036188; x=1809572188;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=lrtrgzT6F4lDh1RVwevzTBySKZalyutMjMr/dWxyF3k=;
  b=QX5ovB9uWRK2S3AiUzB1IyQFg/lhxUXtsxpDr+aTY5xG76pM5IxlFsQV
   56TeIa5bHa834CaGS64pCjFxPWMb8jA85uuGTbIBFGsOZ+omTDMRkcDeJ
   HYDEP/COvsx4ui/y//p+1vbeVx5OTCp741QvQD1FUK77l+Hqnpg4VLboZ
   /Ad6kC6tM7+nyO9DCDtLE7xkD6KIMSABhgbCFZWM0fgIMJ5a8pyqW6Omh
   H8m3S5z4WWMnzu7iH+ORvHn0Dhoyb4FN1rOmigX+YxlIJfh/hq+qOZyQA
   W8H93IM611rUcn5FJNs9gxXFvwhJRHfLuiO6Rw2M0z9ZSpH33//w/nxG5
   g==;
X-CSE-ConnectionGUID: FBrSFwdXSkG6S79wfxlpag==
X-CSE-MsgGUID: m2QWL3XeSPub6oW8ubalOw==
X-IronPort-AV: E=McAfee;i="6800,10657,11777"; a="90029499"
X-IronPort-AV: E=Sophos;i="6.23,218,1770624000"; 
   d="scan'208";a="90029499"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2026 19:56:27 -0700
X-CSE-ConnectionGUID: sd4s7xD1TLOZB3wvlqcGmw==
X-CSE-MsgGUID: oh3KysdETk6Ex6qaqe/kVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,218,1770624000"; 
   d="scan'208";a="235116546"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2026 19:56:27 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 5 May 2026 19:56:26 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 5 May 2026 19:56:26 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.42)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 5 May 2026 19:56:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fNZYASkMErgNd093UPpfVPewhx5U7m884KOTbxXzbAlCpxOJRrKFQYRssNMqXNUeOu2r1MkyBq7BmbR2SE8p/lzg+v5nPNl2mBMA1JfBcQ0uuaY8oApUOQmQRPWeHd5mxn5XYtXYSWpRy85GpdtkQlw/SfQLLcrxLamcfPToVHKjR60m1witouWct7D2eNzysbB/OOu3eSbZlBcLcKnSCbvPNS/y/O037Eng4yDS7aH/6MkxXp/IKODVa+ftcxr1yprJ3EnR6IHm7BZrd2a7kGZC2vZHyxZBWajDQ9BkuVGAqXS7UHah/ww09JfCcZRqdSyHYmw6SaEybiKWFH6j5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pynfOXosVL0l21WI1v2txusY2ygRivervMCdnK7ICqE=;
 b=fe+onE8hteALduk0malXMNRkU5ezWNXIDJ/kcAOsUdcqMD1FC/JNj6qsdlTM2BAGM4JteVcxmAm2WYZ3Vx/bHIjho7fP3nhxEykTF88F67PO9QDpHeoDtaEB3EiQ4Uoi+YYEgqvY2AubsYysC8wJYHItmVLM6JO2yI4epqLrsY5HpTy1f1Zvk9nDSm/KHSZ4G1rjEfrGHFtMZnkauvi7ysArnxQGbCDrdJFxqdhQtIKIr0L72YT9W/rQI+WqzXmHMYpHVhMVjGYT5yONPNOsE4Nen9i6df75YFMspPPuvhAt8YStNxEH3xZ/htnVJuF3ImLd9KMoaR7E6Ok1rZ80wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB8660.namprd11.prod.outlook.com (2603:10b6:610:1ce::13)
 by PH7PR11MB7552.namprd11.prod.outlook.com (2603:10b6:510:26a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Wed, 6 May
 2026 02:56:22 +0000
Received: from CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::fdc2:40ba:101d:40bf]) by CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::fdc2:40ba:101d:40bf%3]) with mapi id 15.20.9891.008; Wed, 6 May 2026
 02:56:22 +0000
Date: Wed, 6 May 2026 10:56:10 +0800
From: Chao Gao <chao.gao@intel.com>
To: Dave Hansen <dave.hansen@intel.com>
CC: <kvm@vger.kernel.org>, <linux-coco@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <x86@kernel.org>,
	<binbin.wu@linux.intel.com>, <dave.hansen@linux.intel.com>,
	<djbw@kernel.org>, <ira.weiny@intel.com>, <kai.huang@intel.com>,
	<kas@kernel.org>, <nik.borisov@suse.com>, <paulmck@kernel.org>,
	<pbonzini@redhat.com>, <reinette.chatre@intel.com>,
	<rick.p.edgecombe@intel.com>, <sagis@google.com>, <seanjc@google.com>,
	<tony.lindgren@linux.intel.com>, <vannapurve@google.com>,
	<vishal.l.verma@intel.com>, <yilun.xu@linux.intel.com>,
	<xiaoyao.li@intel.com>, <yan.y.zhao@intel.com>, Thomas Gleixner
	<tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v8 10/21] x86/virt/seamldr: Shut down the current TDX
 module
Message-ID: <afqtylwGsoLsp/0f@intel.com>
References: <20260427152854.101171-1-chao.gao@intel.com>
 <20260427152854.101171-11-chao.gao@intel.com>
 <0523b07b-2df2-4cf4-bf98-6efe01780698@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <0523b07b-2df2-4cf4-bf98-6efe01780698@intel.com>
X-ClientProxiedBy: TP0P295CA0007.TWNP295.PROD.OUTLOOK.COM (2603:1096:910:2::7)
 To CH3PR11MB8660.namprd11.prod.outlook.com (2603:10b6:610:1ce::13)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8660:EE_|PH7PR11MB7552:EE_
X-MS-Office365-Filtering-Correlation-Id: b419942a-7a97-4622-1784-08deab1b0e1b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|1800799024|376014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: dHD3G1jucV4zLtbpg3CTaJBjGLEpy8ES2MJ5ltNnZnFR4AGLCKj4e6meyADgxr4Dlg23aaeI7o1qkMnePyAQ3PVl2SsDiBiP+995IkPwZb84zCCPxYwt5nOjJs0LcPnsH8JEFNZ0SoIeVfvvH7ouhcGgZ4SGPBdKnuzt59gmyIwRUV4DmTXcPfDjBELDDwSQ0qraWp4OZzzpXBsK99wP7wWNBYP8U9QdIVrLhTXTUAAaRcOe6yhIQlKRB3iNgh6yU4yljeW8Mlu36lWJ7wPouzcDMdCba6xlsJD2jzzHNKfNC7UcrLfYw5DYrfRuG0sJUCUBiS/OKcSzK2i0BX/45ALo8i+Z1g0TKRG/ern148bdu6HXTz5ytMet1b2BBMRmidGnZSIfqGE1lOFL3BOUe8NddiYJgKl8nb/Z60ygqBP4w47paGJcR0ehGfCNnKAdPp8F8Ha+6eMtZDvUG56i1jJjBcESLcjba7Nrnr15W1vKSXfbsGPl5q4zlBO0J/jOzf0MpGzIyZWaLiJDoU6L92FcDloTDlrAXwTW4anoFT95mW+iaXW9qfk9fennqC9IrDz7TKcV7JkmOxUGxHQHJqPneCC1yIFaNETeizmFr0EG5S+Mdhm+kr6o8K1bFMfm/vNvvyIqmaE1nc12wXwx5Sl0n5nrTnn5U4Q7O42ziHOy+Ge7j0sKfy782kED7C6C
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8660.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(376014)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2UVJH29h3Q2VhxjgeYClvJPbEjxIglMMA+o+81LDU4o8fxoDUV+M/UJtFf8z?=
 =?us-ascii?Q?sCd3ld6RekjAeGE1qMfiFuXNI6itwewhdvMy+PpJmIUcCdchcbggoiWoR8Ar?=
 =?us-ascii?Q?G9evri2TCtPMZ6tTg/rXB1hHlhmhqZ3lRgL+qmgq/Rz9euoqi8WZ8RcsofFh?=
 =?us-ascii?Q?EaqvNt62nZGmy0DoviQVMwS72bitLf1M/eKU6dw/GQ35p8yi9O/w0IYXsirJ?=
 =?us-ascii?Q?nlBiUcN/cppSlTIB7kQlyC2V2qTjo90yvi6ATDBsaAJF5B5NlQyElf6iaaGZ?=
 =?us-ascii?Q?4EuA/2fWdER8cb/Wgbmn+0gyQJ7M7gakPWfwuAQCg302CzKalv4W8SEKihXt?=
 =?us-ascii?Q?PXDh0Q3NAHaDzB4rpwduftA/fOW8/YhZoLiuPUkNdqxvNjpj2LxUj+4Mx7r8?=
 =?us-ascii?Q?moiT2DjcrGng6WMoZi0q3DVeYwj1BcaMzN2BZxqgxWqzV2bBTKDtw9CyxDhq?=
 =?us-ascii?Q?U/97rRjH8WMkZlCbKwaZJVJXBqUd4jEnJYsrErxrzdSnUCMa3lq8qyw9wf+E?=
 =?us-ascii?Q?7xzY/lpDRY+jf0iuKMhlTtz7ETKu1VYSUgnJLsAtZqtrnB/sOn2tDub/AfHS?=
 =?us-ascii?Q?87d3PVL20PLJTjQpoEw5w/gPH1kPrJxkytFwp2ixeTYS73lTxZnXx6mOztBa?=
 =?us-ascii?Q?gfD5PcVZDAXUZkIJprN+tv9dGI6RjG7YIsvQdYUZz9Ic4bg1VG5giPtOegIQ?=
 =?us-ascii?Q?M9O63rV9wyBEV7+sMhvQ6ityPSx+O6HNxbQEEE7szc+8mQvxv9Jr3DGOPStC?=
 =?us-ascii?Q?HbC0w3BPhae6jJGzo05Lua7WClNa7w6x6CUDllNvg9dNBIhmfLyNNYmXJCJ1?=
 =?us-ascii?Q?S7rhcj/PsvDcdHCIsFrbUaFnyWGvGMC573Ew+T5bPXZIt8Xa8dXZh6G9By6a?=
 =?us-ascii?Q?tLZxB7ZKoWI5iP21BNKGXe6iwlsluURx/FoJeFDs0o3435Z58+TqiQEVsIBA?=
 =?us-ascii?Q?KNCOIKQmIthRQ8BFbmK4T5b6eKH5xmO+GsLw4RcBUFSaK4vBmMJdpudzLFgQ?=
 =?us-ascii?Q?9g7j6GUDMiJHqTk/ZeW+B8GU3Ma6qP4NwqU+f2OtYgbeJBnHSucVTgYmZHMo?=
 =?us-ascii?Q?UUriytdBOEhPX7mpwXrbka0sZh2+Q4VQZDbIPJtgVYz0WSViGdzHOAbFynJY?=
 =?us-ascii?Q?5Ubc9E7v7n3l/pO+YOtuZbqKJ3JvKOv1LHv4/ib+VnRTic3dEwVTZMx2lbfW?=
 =?us-ascii?Q?sHUb+0RMj0h1Fh4AWlpsk8IZ077wFrLTHz5Voyv1VWlbD5ZCo2Aev/EYjPgo?=
 =?us-ascii?Q?iTMvfFygiAtJXt0VjUQdzzEGVas/TR13QDPh+DSbRk9Kq9h3zMgdpMH8THFr?=
 =?us-ascii?Q?l5f6aHzj4ViVnk2pgFPinr47CcK662yZ7tUBdpGlUWF1R+g+TkmxtuO8Ea0z?=
 =?us-ascii?Q?uBE5u7SYNCaXmy4bpgDFldQag1fSO+OCqQPKkVzspw6y1BsKNcEdGf0ZWacA?=
 =?us-ascii?Q?RlddqQIBSSVer/VhNvFhdR0GMNUd/Vq/0mfsuqo+oJzaMlj8sI6ifyr2KLt2?=
 =?us-ascii?Q?ofStyuANHue1vFYWkaPdhsFAnb7d1P1JrY+0AO6Nn8WeT5kCu//ZPxMq/wit?=
 =?us-ascii?Q?bKGBvpifWIrySfnrhHAh4mYs+850cM4TIh3ArWlijzWg8zqgZYKmUwK1ELDD?=
 =?us-ascii?Q?id2aTWAVpheuDDfFFsU3srVelO4kmTOOZ1MHseeB27952ta3RrvSRst7zDnp?=
 =?us-ascii?Q?lW4fpzgNB7EQIbf50hB/7H2Bcs7gEmH6cKfPUtqz5evieIBniZPq1naLu9J+?=
 =?us-ascii?Q?9gxqOMQ3TA=3D=3D?=
X-Exchange-RoutingPolicyChecked: mih6Ragbok0sQo3P9kaXWamv/FQw41YpaHx2V1GZVlHGVgltMMEjbqy4CDMme0Ymc9xsUox9/HYyXe7DUK+DeFA1jR6J0Mhi1oqNbx4WOFiCVFAwULye5ZAdIQEFTSix69rY/ePQL4ZHdw86bZ8qHXy/jth7VYU3ol1m9ddE6UTk2CIuXEL5fASsI+PLb1XZ9zEoKcg6ykK+oAPilaYAgrEmC6kPbrJ4puVX59BzUe79XnUtjL6FfM+lg6raj7c1AFHrrKZT5j+rWBAlTL3lIbUe66u/2TCRUujWW2rWpg6UHIdTW8kmpo8FYb81W8zg+BNFLFPaJGajXVhRSo8ylQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: b419942a-7a97-4622-1784-08deab1b0e1b
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8660.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 02:56:22.4678
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: izXn+zx3yDmVRxVjQp2nA5Re37IoAV4S07S1tMASYElOOkZV1RK3R9s1uDNosBwCPvCk8VGumYJ4M0aJ1xsf5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7552
X-OriginatorOrg: intel.com

On Thu, Apr 30, 2026 at 11:52:50AM -0700, Dave Hansen wrote:
>On 4/27/26 08:28, Chao Gao wrote:
>>  static int do_seamldr_install_module(void *seamldr_params)
>>  {
>>  	enum module_update_state newstate, curstate = MODULE_UPDATE_START;
>> +	int cpu = smp_processor_id();
>> +	bool primary;
>>  	int ret = 0;
>>  
>> +	primary = cpumask_first(cpu_online_mask) == cpu;
>
>Isn't cpumask_first(cpu_online_mask)==0, always? I thought CPU 0 could
>never be offlined.

Not always. On x86, CPU 0 can be offlined at runtime if the kernel is booted
with the cpu0_hotplug command-line option. See cpu_hotplug.rst.
