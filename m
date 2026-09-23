Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1964A47044B;
	Wed, 23 Sep 2026 08:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790151567; cv=fail; b=Uh+8yR5RIrPzQnFSMJyz4mdzHtV6JL+33TccrHDL+4MlKDpQr5ZZIaGi1ycwF2TUir6vvIZQmfB4ko2qpEc+ssKO+fAn+GYovxtVHcWqvDaVC0NCiEMuBTtg5v6pR7IYzxSaWOAudJTveEDAZnY/0zVebCWJbKH9p1DKSoxAG9o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790151567; c=relaxed/simple;
	bh=8YkWcrcwp32NFrfqkKzboIh7NsqSZZMX7Ym0m/UQsJ0=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Gnb5yYtCSGyrNMUfPtUwkdYuiOAI/m+OO5eDB1pjKo6lUrRECk/9HkfwHXGd8g3FTxG8ACQbQN5jJPZmTatXuFurT3hyrzzbBJZJRSeaCTEusgVoOU87H8NZj8U/VsevdyLnFO7Fcgc3GZSuo2d5qM3di+5oWQVkcE1BLFC6xAk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mQAwBOic; arc=fail smtp.client-ip=192.198.163.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mQAwBOic"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790151566; x=1821687566;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=8YkWcrcwp32NFrfqkKzboIh7NsqSZZMX7Ym0m/UQsJ0=;
  b=mQAwBOicLw0ZiO5cjznc3U4W6YWnvoayuBnveB9vO7B7sJ7ZPxiSO2E2
   tEEBLeX3J39LfjLLxLsG+yE+ub3Qs4aPqqmE1pCkRtBJitZWgMg5a2/ug
   oBMRxxjekvBhHeIG0oi+nWU+kgpVI+TiXxl+CYC5PaaZm/cnx4UXet0fW
   qMPqqBxeUQTfvr+vHRTGh3mdGLll5jjzcD0VSecJZw+8ieQ0jeBdPpJiW
   ITPUF0ae2H/gk1oqnV2Y9DP0AUG5QqsmReR3yAsgTT+sx8a2Z7OyLBdRY
   ZNFUxF0yz+iYtpN5TiPlezzvtPq1DsB19emrW0UTEZG1szbDYL8BlGLf5
   Q==;
X-CSE-ConnectionGUID: S5l/ZKrAQUS1Xrqvm3OlaA==
X-CSE-MsgGUID: 4mRiTq32TJ+BLMbdhaJTRw==
X-IronPort-AV: E=McAfee;i="6800,10657,11913"; a="1314433"
X-IronPort-AV: E=Sophos;i="6.27,118,1787036400"; 
   d="scan'208";a="1314433"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by fmvoesa116.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2026 01:19:26 -0700
X-CSE-ConnectionGUID: QFx63HSKR7GUsGhXBN8VZw==
X-CSE-MsgGUID: mlhdzP6UQKaz0VE3HL038g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,118,1787036400"; 
   d="scan'208";a="4577569"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa011.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2026 01:19:25 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 23 Sep 2026 01:19:25 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Wed, 23 Sep 2026 01:19:25 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.65) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 23 Sep 2026 01:19:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jeMeX5ItKLRGlZDnY6eg25TVoQf/0ZBPVApRDzWz469Yqpw+HMB9Ah2H/azCEEdCPnZQ2o5sYiCRq6zg6Pco02/lXPqeT6sewqkLDCmp1FWNgAn/45Y6TC6FzinHjH/fc7gWFOyZTvJaUYLE1/6mVZ73vb3emBrsQM7kB7atH4TZd1rLBvZ4TupTtSHBmrut6wiaELGTyinPoDg03m3tL/BslI5gbRLzfwDgXfShHYaM6BRGm0T8luQiBJY2BGxDwX5LuUrkEbPO1kyFCaHV4wE1D3anFtTt2vxz29U0s7aKzIiEpkVHscC1ecXU/qYn8jYTeIHYfNAHwcXN59Nc+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c1U/jN/w5EFlV8CkTofX/V3J9Bs3JzszEYObaSyIQlg=;
 b=KHgGam9Tt/0aM7C0xalYy9bVGzBCaZk+02VoREqV8scIKiOeG/XJKfz/BgSBoAgCQqNnOvsQvYMU1zzSAKZvfAwP708VS8SZs2shdSrvNrlwLzgrtPv+LHhCXlfhOmO4wM0yqf/y7b1auRq4rJV0QFeV+a9QhdygeQ61H1+AysvBn1USBP+8u2igpHpsV484qUf8a3KO2xJ/caArsL7IzykIL+Ooko9BEk5YJ9Oag99xf/G6NbLeuBU62fP0RZtYPXEqjc/U7xRIDI1K0TZiLZ5JKcDsDUcPzxB0FMj4Fkc8xrp5WIOR/r8ownoqfEfMnaj0wBEjUDAZ2p+aTkPtfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA0PR11MB8380.namprd11.prod.outlook.com (2603:10b6:208:485::21)
 by PH0PR11MB5901.namprd11.prod.outlook.com (2603:10b6:510:143::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Wed, 23 Sep
 2026 08:19:22 +0000
Received: from IA0PR11MB8380.namprd11.prod.outlook.com
 ([fe80::ea8e:eec4:f8d3:f95d]) by IA0PR11MB8380.namprd11.prod.outlook.com
 ([fe80::ea8e:eec4:f8d3:f95d%2]) with mapi id 15.21.0451.012; Wed, 23 Sep 2026
 08:19:22 +0000
Date: Wed, 23 Sep 2026 16:19:12 +0800
From: Chao Gao <chao.gao@intel.com>
To: Tony Lindgren <tony.lindgren@linux.intel.com>
CC: <x86@kernel.org>, <linux-coco@lists.linux.dev>, <kvm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <yilun.xu@linux.intel.com>, Kiryl Shutsemau
	<kas@kernel.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>, Dave Hansen
	<dave.hansen@linux.intel.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar
	<mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin"
	<hpa@zytor.com>
Subject: Re: [RFC PATCH v2 00/10] TDX: Stop auto-generating the global
 metadata code
Message-ID: <arOLgHrOf8tlTwfv@intel.com>
References: <20260918132946.76533-1-chao.gao@intel.com>
 <arNnJO3aKDlCD2Uz@tlindgre-MOBL1>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <arNnJO3aKDlCD2Uz@tlindgre-MOBL1>
X-ClientProxiedBy: TY4PR01CA0127.jpnprd01.prod.outlook.com
 (2603:1096:405:379::14) To IA0PR11MB8380.namprd11.prod.outlook.com
 (2603:10b6:208:485::21)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR11MB8380:EE_|PH0PR11MB5901:EE_
X-MS-Office365-Filtering-Correlation-Id: a7ecd264-0c8e-4355-1bf7-08df194b5f47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|23010399003|4143699003|10067099003|5023799004|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: EcsbYNLCP5Wut2p/M1TFx36FDCDkyAPUDQpFv1xS5Y4Vk0aDALZigZNwdl77aimDKb3xec4ELfnpMjuIcVFYd5vG1FheG4RYJM742Ls4n1SaYMF3BHoD/BWQyQL5kN/NYbk5D9PKlBa2zPfcTwDaz1Q7Mroqvx7JhiNx8uUIIJnyZEMVACls6LY1+r+PGyCdsOzD4Ns8UI1NAmHWvHXr+eWNpI7UHnDU62XiCo0v0GohQK8ufwGggyBbCPeqNtZSlQzfwwbzW8tWgvJNPVpU/Dl4sXq1BhmZOHDQXMItVuWrSzKMHjY8tWXDAZ06d/i4MUcmPJT5IPplz1H4UGk6faomoF7pqltUG8+5zDqBI0geyQCqS0ihjwmFVFBjKke3RcAkOy0RocKu21/H2eHIoL7w9B+VR2WN+i4309xcMXaCAT8jUWMJpPCGJCGPfllVy9bdyi4RapAs7b2yzaqeDY2QAZSajuu8mTOJpR1TmVVWG9DPLj2s6ZZNPluqnxr0wPDq7XAsqFoJVsWy76FExThtOUxUtN8T4wTuV9UJ4KRmpjRKdrQ8PdYtXqj5rgdfy0A9GzLEJyigcZEX9S6wsFWKmYvUUHYLkGxbwrDH+YRZhijHuU45H8tCr4JA5i0HSz1ISofVhnKsU0d4S/dgYws4zqYPWUWnBjUpXw7O0k0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR11MB8380.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(23010399003)(4143699003)(10067099003)(5023799004)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SYTZXfgSQDoO+jzdVqrsX1OOG8MwmkiKdNQ0iWJxKSbL4/PU4L1uhOviY7AX?=
 =?us-ascii?Q?amtm988AsY1NaD2NGJ2ccTMpbys3Ktd7hHCU7Wdk83ZGaebFxpIWYlqY/sUI?=
 =?us-ascii?Q?ifZdf4PSxtaq9tvu112GruiF4Le5g5ECP3j8qpX4RtAZ2T/kMqtWWuWP51Q+?=
 =?us-ascii?Q?EX6IsLElBvHrPUoiwVo661FQdlqqslRy7fldWbNlqTH0zOrXSZs6oiaTgiGK?=
 =?us-ascii?Q?b8xhKVGrEIv5oNWEFZrCHbAb3mHvAzauHRR36Anh2HapzvBooJ9nHTP9wvgq?=
 =?us-ascii?Q?MvM/F99kXs9GzNCXplzclQdh4OPoK3gUDHWsWuQD9tr82xTjFLnz/FPVeoWY?=
 =?us-ascii?Q?hwchKwidfUcHyxULkPoparNDWFE16tqtA/89c4K1x28qdfgCXItqomgoKPpR?=
 =?us-ascii?Q?YcxeHDzhroKM51Gxdyo3CX665yNVhCGLozW9Ab3IGLuFH8RgQYGjQ1aSpGho?=
 =?us-ascii?Q?wwMTsIQy9bTiG1x2smhSGPlPAE7YD/LuZUaTIw0cGVB9cgQLjULscjA0b/qR?=
 =?us-ascii?Q?oOyYfDouKvjgQXljLIV3cDFe/q5S2znwikZS9jp+ckSNuLa8Vudhz/0Ox8rr?=
 =?us-ascii?Q?Y0oIngZ6aMZsBmJJ4BxiJblknDblanQk8IZ+UuSptcCdM2dd2iBrIVROttFd?=
 =?us-ascii?Q?HwNqigqm181IPhU0JwkJjCEXkj+1H+H4JpWVvCm7zfORQMyJMozk1Aou6pPX?=
 =?us-ascii?Q?QnuUlrAVaIZUzNIYkXdN1ig7WhQ8Syfiy2KqXBME+qzvLxKu9JabqquV0J2b?=
 =?us-ascii?Q?lRHh29YnqxSUKrIUZ+ZSkSDF/0wIZuL5CKosUXHja4zVJxJUXXtL3Itl1S2N?=
 =?us-ascii?Q?zEOu703ZZqR1OAyS9zIwbtuVp0jFkAwz1qiu7Bo5+tsUCE/C1Vc24nxh0tjN?=
 =?us-ascii?Q?MtnztqZK8gt6loNCEHPyx969oJtdTkINhjJbgPGUnXeaI/9ooH6MoqYGwTkb?=
 =?us-ascii?Q?4QU5Ss/l8RPdOBA2Ck+TqWPrxi82PKBnSDxoyB1HNnzV7BV2CY/sRKM0jywH?=
 =?us-ascii?Q?BnbeU+pzJX+YepBNImm8cJUk4QuuIPX0hXV0CVT8KKXT44UBRw9EKf/LxIy8?=
 =?us-ascii?Q?SyliFCujhRl4vAQ6uza/0e6lAuJeCXTSF7WDc49bNlGmCUDoAJmbD1UYJHwN?=
 =?us-ascii?Q?Tt4iXXroc2Vq/SCdP1223JW7dA3fyotDqVfQ2noZx3vR/BZphJ0gan5ETEp2?=
 =?us-ascii?Q?5AhpJFf3rFV3Gd++1ZW4/CW8UxkjaNUiuHprre8efmLvGvkL0K6qcaGCWaMK?=
 =?us-ascii?Q?d7fcBnw5E++8UVyw6KLmzaVbMtEADcHn30WsA+fJCMAHlVVQwW6SSIDWslqW?=
 =?us-ascii?Q?xszbK/54k+Ust3yEd+N6KAj7bYHcVhDs6ELQT2JzOAll/9AJdRK73JIMwtSH?=
 =?us-ascii?Q?y1dUBYqLE6bVZSTWjpsGQgU+rY+AjcXxBeAl5v5iOhUcP8NY5JxWSHzQbcL4?=
 =?us-ascii?Q?/g2VYF++NKkkwocSCdeMH1s8igsAlzFK6J+AuThR7EKGbp4Pz5MItVD/1gYL?=
 =?us-ascii?Q?h9sZT0tI1D3lxd75GCd7GUE0rPXFl4jde/l/4IPLyICOZxkHaO+hTSUei+75?=
 =?us-ascii?Q?YRWYfxJS0+Z+1hXoPqDk0WNd8dvSfdEtwf5a0tewhnelhBhQTVYosE1qPKlz?=
 =?us-ascii?Q?xNP3pY/rP7jW14ccFvzAZsQuGu3QLuYQoKMdtf/a7p7Bm1sjdjtsEIiS481I?=
 =?us-ascii?Q?kcSZY3gah9Swe+xCgfrgS2qzi7se0p0TwSGKQYB625w4D6qldPvx6EXfJcey?=
 =?us-ascii?Q?uHhOKm5Zug=3D=3D?=
X-Exchange-RoutingPolicyChecked: vwMUBgSpDtJyMEWduL36iI2FLA6OiCwMY1ytOeyitzzVayUX3FYwpUwJ9g1r1ftqfu8mvy1dFIj+lYHNdgvoUwXsdD6Q4M0lFDxtIudn2cZGTwtLBP8vhZBNY3bMkYhwH0o8zoit++tFqcVcDgq5L+elo19A5tuNfAQ7omefMMOmNKB3Zka6Dv3Guv3J2x1TanFWjc9JBgDa8iu8SCjjGf17w4Zl/KyEPEJm8Wo/B94X2vdGZaIBo0tnvLlN6XpvgkEUW//qkTCScW4tNELvLfJ4Y58IjsnEnBxLbR/EbFEuM46C4n7E66kkCgPdd2/ZTMLa5NxJ4/XFZelXShgI6w==
X-MS-Exchange-CrossTenant-Network-Message-Id: a7ecd264-0c8e-4355-1bf7-08df194b5f47
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB8380.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 08:19:22.3443
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pd4mFxo/vXGjtThyrnEsfjifeotijp6H3LLE4wZE91tkcXbitNMVVVtitPNR6DZ6/PfDiQeLYO9KOwzIm3EcDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5901
X-OriginatorOrg: intel.com

On Wed, Sep 23, 2026 at 08:44:04AM +0300, Tony Lindgren wrote:
>On Fri, Sep 18, 2026 at 06:29:19AM -0700, Chao Gao wrote:
>> This series cleans up the TDX global metadata code. It has two goals:
>> 
>> 1. Replace the generated code with a table-driven metadata reader.
>> 
>> 2. Make the existing code easier to read and maintain, and simplify
>>    adding new metadata fields.
>> 
>> During the v1 review, Dave raised concerns about signing off on
>> AI-generated code. I have since rewritten the affected patches based on
>> my own understanding of the code.
>> 
>> The main goal of this RFC is to agree on whether the table-driven reader is
>> the right replacement for the generated code. Please raise any concerns or
>> alternative design ideas.
>
>For alternatives, I wonder if grouping the metadata would help in the long
>run. Some of TDX metadata needs to be cached. Some of the metadata is init
>time data for how much memory to allocate etc. Some of the metadata needs
>to be re-read after TDX module update.

I agree that TDX metadata should be cached only when there is a reason to.

And yes, some init-time data is cached even though nothing reads it after
init: max_tdmrs, max_reserved_per_tdmr and the pamt_*_entry_size fields are
only needed while building the TDMRs.

Only the version fields are re-read after a module update. Splitting them
out of struct tdx_sys_info would be a good improvement, so the rest of the
structure could then be __ro_after_init.

These are cleanups that can be done in a separate series.

>
>Should we have the table-driven metadata reader use the TDX module
>metadata directly by default instead of always copying the data? That
>could be used for the init time data. And data could still be cached for
>CPUIDs etc.

The table-driven reader doesn't impose caching. It maps field IDs to
members of whatever structure the caller passes, so the destination can be
a cached global or a stack local. For init-time data, we can read it into a
stack local the same way the handoff class is read in tdx_module_shutdown().
