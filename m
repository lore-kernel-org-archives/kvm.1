Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40DD731F988;
	Mon, 18 May 2026 11:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779103785; cv=fail; b=bgP5cZoQy3Y69b3mPTDtAFRlGq+KtQ4VoAMUT7J3ecfDGrKxPob698RGznXBrT73eWKnHrmFGrwxLcMxDl96l4umFs4SPqctoEzfCByS+diXSpgDioM9IRxI2NgYFFsJCqycrlxKYKoGxBpRcTURI6Kk6ji3idb2tjLOGGMiS+U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779103785; c=relaxed/simple;
	bh=+e7yQ4c+PbDW3h8VI43ZmbnrZhEAvEQm3/pV/nxzkYw=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=izeIN9SWtweUekxDVOqyXhhDVwi6lUl38OaYnX4bntwBMeTB3cx2dNvzYcuH/fmY915UZyJldMOKz3udD7xkf2xIlvvIJnAMrbTB/Em890MzzSE/ugvYTe3GYMjK2sX+b44lPmWp42kD9eVl7Rpt0zF14TYNsT4qrotyGND4cMk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S7Wozs1U; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S7Wozs1U"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779103782; x=1810639782;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=+e7yQ4c+PbDW3h8VI43ZmbnrZhEAvEQm3/pV/nxzkYw=;
  b=S7Wozs1Upm9M1vMg2l4RVF5v1woUpq+gnipU8IhW+iGUr6VPyWgnIEgG
   q4fsjS7NpG589jhT4TMaLSyvu8FSRLK9OQs0FVTARPZ2F1/Hh1Ik/Eebw
   hDZLh1/zWOyTz3GRlzdExS8L8wIFYbtsILB57/DIn123G6ZR3TyoMD1Ku
   b9PsQ0UR4bFm2thXTWEAncognlJV3KaJdupx2NpKWDV7Yw+YC9iAsevkG
   /fL3vWr9+RluOlGqCHPrSvSf371yiaGmkh18vRGgyWNUUidkAoKmYpM6u
   OzXfWqvI2Ro0pjAzDEyVIcwlfxD06+wrvn5iM4AA8/cx68gS8asdSGnCy
   g==;
X-CSE-ConnectionGUID: KSN8WaivQyqX02zTNaX29g==
X-CSE-MsgGUID: zO0x1kAMRhqNUiVGj/XDxA==
X-IronPort-AV: E=McAfee;i="6800,10657,11789"; a="83805990"
X-IronPort-AV: E=Sophos;i="6.23,241,1770624000"; 
   d="scan'208";a="83805990"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2026 04:29:40 -0700
X-CSE-ConnectionGUID: efw88wmzRrmsI8Yh5irwxw==
X-CSE-MsgGUID: 1jY05/EjRQeM3O7wUvEQrg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,241,1770624000"; 
   d="scan'208";a="238522295"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2026 04:29:40 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 18 May 2026 04:29:38 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 18 May 2026 04:29:38 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.51) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 18 May 2026 04:29:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y2kja5Pq2xjpnJX0MVQaHrmHvubEl7cKgH63uGGHdNYnKeKVHCezVm8G6ikX42Gt2wBsb/iHgijdfT+qF4FNi6GBNbw4VQP7NKV8xYXCXmOlSQ9+1OZd+PYUYvJGgpHPpeBFC0JPhXApDtraiRSccqxRM2ZZBa5TpsoVigw86vh+ok6094RXGJWyaOq3chz7H272+jzrqQ8yfbcL9qLhJZMgvn0et28woSwaFR7Ux3W+Mkkm8BvrL/xywSqAUEAUov5hXp7YWbtUG8V4RvG/5y6+6kboAKN5YhmUTOdy+mfXoKHCfaylSQY8XFf82y1WtsbQ4X2jcZjKXmNQJtrp3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fNae7XemLQXMU1KF96DRdYtbf2vZy5z+kbkgax/1msI=;
 b=Thf+2PJz4FhG1GkqwBBzAQhr2wiP0RKGGqtGFnpOamKMkQJ+rJosrZZ+F0AVmK12jDqNrutAhsT7mnrF0cBPEah0bDByxC4tQQe8y32dQayU9P1GYMexSeOGc6YRdzWLhCJbiHAZbhEoTbO8V5LA0jxsVZZ1E2gyjmg54PGRso3C5dUfKdHYd35d8hbrpHwruenn/9xnRbFRQi7Ul+WdwTR9Eg6JUSbV3U/EokIuIyfeZzLffuQ+tm+1zt4sg0UnUzz7AElhynLHq2dfpLr/S3YkvYDf93tnb5RbkzvM93bdBjXnpbq41AUlUCKnsRyYQedOkj3Ve7zLt4oqMjrpww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN7PR11MB2836.namprd11.prod.outlook.com (2603:10b6:406:ad::26)
 by MW4PR11MB6862.namprd11.prod.outlook.com (2603:10b6:303:220::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.22; Mon, 18 May
 2026 11:29:31 +0000
Received: from BN7PR11MB2836.namprd11.prod.outlook.com
 ([fe80::ac36:7540:4e6f:8d3b]) by BN7PR11MB2836.namprd11.prod.outlook.com
 ([fe80::ac36:7540:4e6f:8d3b%6]) with mapi id 15.20.9913.009; Mon, 18 May 2026
 11:29:31 +0000
Date: Mon, 18 May 2026 19:29:11 +0800
From: Chao Gao <chao.gao@intel.com>
To: Dave Hansen <dave.hansen@intel.com>
CC: <kvm@vger.kernel.org>, <linux-coco@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <binbin.wu@linux.intel.com>,
	<dave.hansen@linux.intel.com>, <djbw@kernel.org>, <ira.weiny@intel.com>,
	<kai.huang@intel.com>, <kas@kernel.org>, <nik.borisov@suse.com>,
	<paulmck@kernel.org>, <pbonzini@redhat.com>, <reinette.chatre@intel.com>,
	<rick.p.edgecombe@intel.com>, <sagis@google.com>, <seanjc@google.com>,
	<tony.lindgren@linux.intel.com>, <vannapurve@google.com>,
	<vishal.l.verma@intel.com>, <yilun.xu@linux.intel.com>,
	<xiaoyao.li@intel.com>, <yan.y.zhao@intel.com>, Thomas Gleixner
	<tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v9 05/23] coco/tdx-host: Expose TDX module version
Message-ID: <agr4B50GvUuid5g4@intel.com>
References: <20260513151045.1420990-1-chao.gao@intel.com>
 <20260513151045.1420990-6-chao.gao@intel.com>
 <5e097cb0-362a-4dee-af68-9ce583312c97@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <5e097cb0-362a-4dee-af68-9ce583312c97@intel.com>
X-ClientProxiedBy: KUZPR02CA0014.apcprd02.prod.outlook.com
 (2603:1096:d10:33::12) To BN7PR11MB2836.namprd11.prod.outlook.com
 (2603:10b6:406:ad::26)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PR11MB2836:EE_|MW4PR11MB6862:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f3a3c23-87da-4b90-da1b-08deb4d0b880
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|3023799003|4143699003|11063799003|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: DnyuSj0ICMdmbXQY/+fxNEAg9+oq6MmN4M7aIdkyqvqlZxIQpSa7YPm6iPIsPsnk8Ea6uSTuBtnKFOXAekbvVa9bR57WnFFrRqM+6vGhTPsz+baquvdRj/zKZOqWIWb7XfVvaRGyIHv8pFgClWEjt11eax9Nkh9Ivf++JUCQuhpypapub17dUtrnygAliGK+oFjyvPLRQV+2AZVgQx///bMPeHyG3mcbjI/dnCsMFZNSqwVXMjZypIJLaJhLI5dlEaol+KPekElivgVfxWbhn8/9wm04wobKYnsFRhEq/oDJ7vQv9PVK3IXpGPEMb7AFgSckblMTherDmHLkvH53sV1ArbOJvZWpZUP7M7BhW9ybG8uvSli/CMGYHWliOphbVcrNdIEmJnMEdOU7SZToQUMF8myNMFSWBxL1tScl3wf5ZyMJziBOnwReDr4n0t56PzWJE+dwFkpQSBLmJRBJ/PDlL1YesOI58Y3oICR7Db//7bAirYtRaxskuQdIHIE/qtOjxp/LBN2sm9N7BVRQ5i714C+ODBbCTZSIG4a3NEPaZTYWb8HV7TpQaFxOxdVf1Nc7HLFkJ6LCgkrAcOWIYc2eOydGfc830nx+m1u8T/QHk+5wusMYqWxjgp+fiTZ+xEgti6iZszo4DwDa/uUWH5DnHBwalflftudGyG2mkf+NSqelh+cUE0ba1hVauTdT
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN7PR11MB2836.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(3023799003)(4143699003)(11063799003)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?K2ZziMeNxvoq5Cjpsnv7rQGolXrh/fScx8RUUgAXPGfQP1nIlajNs8/WyGo8?=
 =?us-ascii?Q?69EOg7I4+SLTkAYa7GVWgUNRqY+P9nAVLSKfARxeKCe7ZebWza21VyYXKJC8?=
 =?us-ascii?Q?c4r51+gaa9/EQmY0t2ytGEf1GEWn/bHARGXzEyWbtRTuhSA/iQ42upHC1LNC?=
 =?us-ascii?Q?54QIfQpCGDAYIvYFT01lMvtgNJXnunY8Z2VQpmO3Gc7eLBY0GWtDzEdYpm6x?=
 =?us-ascii?Q?swPM1gKVn5hUXdQT2/+Tbb30VqhDXv0Yzz0Xo+DeEwAni8oL+Wt1WlG5JojZ?=
 =?us-ascii?Q?0Ybb61KO5dAJuLvCJELw/NNIhRbmKh//KcLzmlskjBeWz1Jcw6d0WVOuXfRD?=
 =?us-ascii?Q?2elD5sUMzZPg9zROaHWF/Qj6Br2ECbeSGeul/HotA4ra400YJ6kmCUe84dPT?=
 =?us-ascii?Q?Vn8H5NkLA3BYlmS7UjHmENKXh2YooRNA0bqOXTRETiG/HgBzLiJWlsa+eotY?=
 =?us-ascii?Q?iIjIxPzNbCx5RSAMXNpZegqjT4wVGny48ObLKQvSuQu6hBDTQ6ugL1pNPAY8?=
 =?us-ascii?Q?qX11YoIUwu/MaDkhRuJCxtlk3lNcjk1lx4+g3RN+EVR10iE7xtW8Wn7FyFLi?=
 =?us-ascii?Q?YQHIXUr1VIgkaezaoXTTeGMNxfLDGaMinoa5Usupj51vj8Owc5O+/7vVJ1W9?=
 =?us-ascii?Q?ffe3NUqnNz7QBLrD+2a6exynRVpEo+Xe7umjTPjL0Vex+hmIuxAyXtJgCdV9?=
 =?us-ascii?Q?4rhI2F7Lgz41DWPb/Cpa6bw4f45wJUde2OJzmMS4QbbQ+36Dj5j6I/ytJ9ba?=
 =?us-ascii?Q?8DGD8VNT/W1f3n4kUnRCrVZ0PDWR0zE5qBrX5U6++gi+dyP1xV6E6gDkUZS8?=
 =?us-ascii?Q?7oYb/MGE8VwXwFxSqwGCW/9JetLTnrjYnE5Y0NEipu34jbrZHwyZuLIUkIwU?=
 =?us-ascii?Q?HXpI2F81GHz5AMKm9a8ElR60ugaIq2w2kBzuuV3zlFql+9xbea2DD7ml9moO?=
 =?us-ascii?Q?98lqpB5+9pL8q611l9/T0IC42gYsXfGWRWU9RuvEMcH5/V8XN2FCnj9/fLKp?=
 =?us-ascii?Q?1SoErV0B3WI5SGYf62bB2KS+F/Ho6UcLYZ4LemK2ivv9akow2+pDj8e64dCV?=
 =?us-ascii?Q?kFNoFPMHzKysqfsY4GJr3qjqTGQgXoV1DUHaM28w3QEnMFkerAIVW8Uh0W4n?=
 =?us-ascii?Q?fK31NhLpd+NQURRw2fvDV69Oc2VSOkz+mXKF/apyuhFt0cLfKOGgows35tPm?=
 =?us-ascii?Q?jSW6C2nvjdiyNw0Piv6Y70F7gmUgHaoPUhX9JgQxoYKHA4xaWplML/x4TKLE?=
 =?us-ascii?Q?UMJRCfRV4EtuOkg99D6Ml2d9AFurtdw9oybeUI1wEHzH3x1hyNci9iStdyn7?=
 =?us-ascii?Q?gsu/CHdlGOybouaCWMCr3NorDiaJN+DXLRWE/yBI7rhi/Zg+a645nI9+q+Zt?=
 =?us-ascii?Q?TI2S0DgAaIw9qpxAESBon7alioPJBjKefcRKXuLtXGXPlWJ9f6JmatJ6CjwJ?=
 =?us-ascii?Q?RrePzOaM+zB3aq3n8RJz2eu8d3o21bzR597UMdVdzDcGWKhozBsDMHBBummG?=
 =?us-ascii?Q?ON8x4s2j75k342nxaJSJ2dqL5R1LtfTBntFWsKrT81mHDGKiND4M7hmHv/Qi?=
 =?us-ascii?Q?ud9Mbzn5lN8ReNAvIYj595jOr/gutJ8bO50q2/yYUu2xRDnAo8EWL4LgAscw?=
 =?us-ascii?Q?9R045qeOBRC/s+0jPlL/SnRT45Jvoxc/BNlDmhZ1q6gg3qfGENRvROnuwNPS?=
 =?us-ascii?Q?HfPARHkdgGywQxK/1AoD7EFk2YXN0Ag60uIG55pt0zJu4/bOeL5Vl18uugWd?=
 =?us-ascii?Q?Slwa77ttJA=3D=3D?=
X-Exchange-RoutingPolicyChecked: TPnxOMMnskLZ/v7uRG9j+yAnq2Pz8osRjbaA/TVk+XAiEuSqkH0aDfkabj8U3hSgYpcOdnnNGe25wZ7KNgbnhGmVL7FMXaONGyY+lPVIBbdic0N/IcuBgkZj5mZN/vEWPoz3gFamAzkwIvVKneZ/XxbIKTzenSIAElHSADfcfYpTu5aUbu4GV52flzvcSj+cBGiHOYuiIZjtY5SgtXBhBr73diQZar2O7yWadI0Jt/VTQzcseMy/O/q1Mp2Lu4X1O3qSlaCP2AM2VpiYqiavJFJ8G6kG4FZQdKivnp1uY0P/CrZVjQWdb5deocECmwbXuv+vmRi0Kp8E1cWatKHr7w==
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f3a3c23-87da-4b90-da1b-08deb4d0b880
X-MS-Exchange-CrossTenant-AuthSource: BN7PR11MB2836.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 11:29:30.9490
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1yBSiUsz5bOAG3ci8un/zqOU3uIbutczjq4J6rnI3byP6CYXIdb16avA4AxIkIFDEV61KK6UCQXaNb7HILTXKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6862
X-OriginatorOrg: intel.com

On Fri, May 15, 2026 at 09:53:59AM -0700, Dave Hansen wrote:
>On 5/13/26 08:09, Chao Gao wrote:
>> For TDX module updates, userspace needs to select compatible update
>> versions based on the current module version. This design delegates
>> module selection complexity to userspace because TDX module update
>> policies are complex and version series are platform-specific.
>
>I'm not sure exactly what a "version series" is.

By "version series" I meant release lines such as 1.5.x, 2.0.x, and
3.0.x, but that is not clear from the changelog.

>Do you need to say more
>than that the policy is complex?

I will tighten it up and just say that the update policy is complex.

>
>> For example, the 1.5.x series is for certain platform generations, while
>> the 2.0.x series is intended for others. And TDX module 1.5.x may be
>> updated to 1.5.y but not to 1.5.y+1.
>
>That's not much of an example, IMNHO. How about:
>
>	For example, the 1.5.x series runs on Sapphire Rapids but not
>	Granite Rapids, which needs 2.0.x. Updates are also constrained
>	by version distance, so a 1.5.6 module might permit updates to
>	1.5.7 but not to 1.5.20.

Yes, that is much better than my version.

>
>> Expose the TDX module version to userspace via sysfs to aid module
>> selection. Since the TDX faux device will drive module updates, expose
>> the version as its attribute.
>> 
>> One bonus of exposing TDX module version via sysfs is: TDX module
>> version information remains available even after dmesg logs are cleared.
>
>I honestly wouldn't even mention this bit. You don't need a bonus.

Sure, I will drop that part.

>
>> +++ b/Documentation/ABI/testing/sysfs-devices-faux-tdx-host
>> @@ -0,0 +1,6 @@
>> +What:		/sys/devices/faux/tdx_host/version
>> +Contact:	linux-coco@lists.linux.dev
>> +Description:	(RO) Report the version of the loaded TDX module. The TDX module
>> +		version is formatted as x.y.z, where "x" is the major version,
>> +		"y" is the minor version and "z" is the update version. Versions
>> +		are used for bug reporting, TDX module updates etc.
>
>The "etc." is silly. Just zap it.
>
>Description:	(RO) Report the version of the loaded TDX module.
>		Formatted as "major.minor.update". Used by TDX module
>		update tooling. Example: "1.2.03"
>
>That's at least a wee bit of warning to folks about the leading 0 so if
>they are parsing it they are a wee bit careful with it.

Thanks, this wording is much better and more concise.
