Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73E0B360EED;
	Tue, 13 Oct 2026 02:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791857812; cv=fail; b=iaBjvA2yxyN4t4lwaVURYfb9a/yUXDVI4L8pngctuwviwSBJsizrJeltEYZBxj9mrEtpeU6VbCl7QPSMcv+GqRixwyI/biv3wWYcMudY2sFqbH6xLUdoiZlKSNpXRfqxHt2Tb2cHwM/GqL54kIyesfQLMipW5SYkR/jejKWS6r4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791857812; c=relaxed/simple;
	bh=6WtRmSQvfYL/h8mYnuwZ+VCU7BkLUfi1F1vx9URo2SU=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dpqzOkIn5IWZ4RP42dM/ePSHxu05VMHUAQ/5AA51gaeBvfFxEubgck8vhnY4LNsJ+YzIevNr0POOhtwn3yU5KhPO4G9ZXPBrva81+gYPHn/esayW9+1TcjgKlYn4MDGaWd6UWi979rMUAWk0akUSHN5TC4jbfVcm/GD+CJC4jZM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dM34SxPL; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dM34SxPL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791857810; x=1823393810;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=6WtRmSQvfYL/h8mYnuwZ+VCU7BkLUfi1F1vx9URo2SU=;
  b=dM34SxPLCKfYNTTzTnbyxS15t2RpYOm7wJs0otxkNqaMy9UEimWrruPu
   kJg6AS3AhWGpo1oik4bQ9ClPaV1Npj5Ybt1UwoEZA5620fJMxP0TRVgDn
   /O3q4FSGYnw6GD7Q/ABsGCMFVWh7NuZkz+Ut1+tJr7npHUQfOCt/PBc5T
   P3MuOTpfvZj5LKTIS6ujwC2aVKSLP/gSHOnBSxA1qGKEku8AP8VuRnHrq
   SwtuY20wI3eBR380uOg1CF62FBxN/KcCh4KGksGP/M2JSiraYSqPQ4ft0
   if8QrMeTXYNiLBRNrd3tYYBWICN5Eaet7lbLHyt942XpEBlZLIBgtA+86
   w==;
X-CSE-ConnectionGUID: 4xto8IKoSeGgc/E+rfCPRQ==
X-CSE-MsgGUID: yyF4znwhS8GfKkJqXi4FWA==
X-IronPort-AV: E=McAfee;i="6800,10657,11933"; a="578527"
X-IronPort-AV: E=Sophos;i="6.27,154,1787036400"; 
   d="scan'208";a="578527"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2026 19:16:49 -0700
X-CSE-ConnectionGUID: 5l3R5duaTFq6rgBfs5z+uA==
X-CSE-MsgGUID: 8ecGdL2oT6e88OrVdJX4aQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,154,1787036400"; 
   d="scan'208";a="1047421"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2026 19:16:49 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 12 Oct 2026 19:16:48 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Mon, 12 Oct 2026 19:16:48 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.43) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 12 Oct 2026 19:16:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MjYXCDqBpcJ7hzIfUzorg0URuwMfdygKVfVdzihcGq42IOD7I3UJWbfPud2xCsSX/vUWvxZmY+tcHBdfSFRlyg2XFyrcVZF3yDJ2vOVM6LcT4Reh2WSNZ6jcdqcvcuWSe2njCAI6ysVewOy1HS+yPqtAts9WaRVgrFq8ZvpSdxpzCKxr8N00jDsdwKewcFTSdAYCruH4wLFzMzvQbxqbb69WI63BggyutUI//OsLYaUDfCCZjBR49rRepAi7Za/llZI8pqV8YbQCICT58+9jgoiGJVrtr558pZLOozSS+T39mPsCU5ef8Yd0STIlQjG7kQlCy7Gnzs1c/hOebL7mlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4v2WgawMy/03rSFqvkk+AL+teWnUkikeWe1L+jHUZiU=;
 b=TCAnNhgzhd7/gcGdnd1+Kl2qILZzVVumpfN7dpwnjFn4Ts2XsyG1ugMuV3VMEFyPj2DGSBGeuIFyyNI3m++LEYG9lWCnkjMq7r0ObvA3rHQ7srSBOtsOQME5dnQi+mhn/CkpgywUZbcDoBRy7JsgRv+KWlsByBg2SzO8dJUh4bQwxqP6CK9JdjNGfgiZQoKlsZmQCJq2Qd2/I3+EIxfusnI5Wmq72ThjwNVprMviaiDLLOs+LXYg1q/vhpdG64dtzMU+5VYz9sbViYVg2LtBQT0nW8tMhmtQJzxpuU2HBxTohn+FzafivZsSKy44Jl3YYbWvhq2WUQttb+jqcqDYYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA0PR11MB8379.namprd11.prod.outlook.com (2603:10b6:208:488::20)
 by SA2PR11MB4937.namprd11.prod.outlook.com (2603:10b6:806:118::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Tue, 13 Oct
 2026 02:16:45 +0000
Received: from IA0PR11MB8379.namprd11.prod.outlook.com
 ([fe80::549f:e4b3:e10d:aaa6]) by IA0PR11MB8379.namprd11.prod.outlook.com
 ([fe80::549f:e4b3:e10d:aaa6%6]) with mapi id 15.21.0496.019; Tue, 13 Oct 2026
 02:16:45 +0000
Message-ID: <3e7f1507-2a82-44a1-a06b-52b6a49d971c@intel.com>
Date: Mon, 12 Oct 2026 19:16:41 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] fs/resctrl: Assign counters to existing groups
 when enabling mbm_event
To: "Moger, Babu" <bmoger@amd.com>, Babu Moger <babu.moger@amd.com>,
	<tony.luck@intel.com>, <bp@alien8.de>
CC: <x86@kernel.org>, <Dave.Martin@arm.com>, <james.morse@arm.com>,
	<corbet@lwn.net>, <skhan@linuxfoundation.org>, <rdunlap@infradead.org>,
	<tglx@kernel.org>, <mingo@redhat.com>, <dave.hansen@linux.intel.com>,
	<hpa@zytor.com>, <kas@kernel.org>, <rick.p.edgecombe@intel.com>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-coco@lists.linux.dev>, <kvm@vger.kernel.org>
References: <cover.1791589412.git.babu.moger@amd.com>
 <3d966ae2e051ef54e1aedb1a2839c812ab880bcb.1791589412.git.babu.moger@amd.com>
 <918780dd-30ad-429d-ac35-25d79d47450d@intel.com>
 <92529635-c9be-4edb-842d-7817fafd5523@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <92529635-c9be-4edb-842d-7817fafd5523@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0092.namprd04.prod.outlook.com
 (2603:10b6:303:83::7) To IA0PR11MB8379.namprd11.prod.outlook.com
 (2603:10b6:208:488::20)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR11MB8379:EE_|SA2PR11MB4937:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c040ac5-f102-4769-f14b-08df28d0079d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|23010399003|376014|1800799024|366016|18002099003|10067099003|22082099003|11063799006|4143699003|56012099006|261009223027099003;
X-Microsoft-Antispam-Message-Info: ASFwd8EQJEFuszgUS922M/Ut0PyqGJO7Bc5uDioCmLBW34YDK0wmODmLwyDqmQ0Dih5EptEWYL4eRNLXngH2zizDIhxdo6GjhqE4p/V+FkZ3EE2hu/7ohwBEnS//jZbpu5Lro4BjmBnrv3LxEqRaMrVcDVNQ5kYVnNijUUAUS1IAHUd7RZxQ5+f+kXPQ7U8oG5rL9BNueVwuGk3NK/a/UxnlPm7EQzwdncw9p7Lst8Qu1NdH+a29lYb95SWTCFffMF3Y1GWBzlWKC/oF2sWzyZX9L/0JUD7joA7oswl29ZDQjZPVtF1YDta7FflnLx0ng9C+HqEFvWgCGt8PuAJAKkw8FvlA19YrspVu5Sir6IrvSpHdlkCP0hNvSPDWzmxMQvz89T5IM0owR6yio5hzlR9RERvOlP7NmpfaJqO/mG5h2i738glhK3qmeXfhte4AL39i7hxya7VyfqWPVNXGZb3UeUymAF+pVKHu/g+pu6Vm3DPztmE75SSDlsr4TXxP+4y/ym/7Z0R958b9Ah6w5MF76Dw6NSNOyp2gjkjz819XG8WU/4LuHmmIm09pJxH7cV+gtrOCFwk0WJKU7PrFTpVNj8as9c9FQ/jCWNPfupYEw6RJ7iXm3/xFHXcSwrpb2L25omVd4A9VM7H43ZRLWAUQIwb6LSxhW0Ybz4yNK/A=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR11MB8379.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(376014)(1800799024)(366016)(18002099003)(10067099003)(22082099003)(11063799006)(4143699003)(56012099006)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z0ZBWWx3eGNadndZYTRWd3FoNkFsQUhRam8wWUh4S2M3Q2piSGdzdjhFN080?=
 =?utf-8?B?MXNIb3k2MVRxK1QxWmE4V00yL1l0MWxKWEYxOXJLMWNFM1NnNllOaHEwa2hI?=
 =?utf-8?B?VUU5M1FpcWRjV240T2MyMTdGZnJvUHFFdU1MVlZaR3YvWWIvWVRzaE9DYVli?=
 =?utf-8?B?OVZST0ZpLzlwZUhGUDhicXZIb2ZFejZTSGdjL3dwcDQyQ0tvUjhOVnZYRnpW?=
 =?utf-8?B?THY3N0ppQjFVTUFUc2ZuNDRiL0EyancwVkZUQStCYUttb0ZiSzYxSTkyZE5U?=
 =?utf-8?B?TmhGUmpqT0tqTDVmcDYzekNYNnc2NDk4SGE1MFJveTdFNmsyQ25XWlVpMWFP?=
 =?utf-8?B?dWFNQ0Vtb0pxcEU2RlVmV0Z0anVRdjBiM1pidFkzVkhLMlRmRWxZZklaUk9q?=
 =?utf-8?B?MDd2emV2S3lQcHpmTDA0RUFXdTQrQUY4aHRXaWJBTGo4eXFFV0h0dm9qR0dH?=
 =?utf-8?B?c2F5VUpGVlBkc2hMMk9GbWZxb1RIOHVaQ0RCTHNwMld4THpZbWtvS2dOWmM4?=
 =?utf-8?B?OHdRZGZMTGFuK2p0Z2Y0MmtBN2NycWphbmV4TTF4SmlQN0NmZ25XUjQyZTcw?=
 =?utf-8?B?aHREWTJiZVlWb2xZMkQrNG1UV3NaVVNJNEpKRlE0TmN1a3VFOUhiMUFpRmV3?=
 =?utf-8?B?OEpqdE5GM1I2S2dSeEpNTVdmNXgzcXdUaGZ5WkViemh0eFk5TndjNHpXVGNZ?=
 =?utf-8?B?eG00TjVDZ2JvbFgxcUNqVHpEYS9GVU1OeFl1YTR1YlVBT29ub1pZYWlQaUs4?=
 =?utf-8?B?ekMyWit4RWs5VndJaXRQTGZhM1FPY3hwWkpEcTMwYzhKVHFIYjdWOUFYczFL?=
 =?utf-8?B?VXUyU1MzSTNlclRINHM0eUdJanVjekFUdER3V0pVSXk0VnJTTjhsZDg2b3Uw?=
 =?utf-8?B?LzJObzVDaXRTRmJnTW0zUDUwV0d2MC94NThZRHhwOEpoY2xjUlAvNkgrckZz?=
 =?utf-8?B?T2F2eGRCQ1V0cVIyUU9KTWoxaExMOXNvZW55VkJvaFEwME5CZ0Ywakg2RXY5?=
 =?utf-8?B?MWhhR1ErUXhmclNpeXJHb3Z4ekVzRzFMMWFCdTZ3OWc5b3lKWFNNOTdBVktC?=
 =?utf-8?B?UlorUkdYcFM2SWRYamw0cHRJN1lUdnhIQzhGeGlqcVNmVUh4SjVHU2hrOXpL?=
 =?utf-8?B?ZDZMMFY4YXhNaTh1YyswVkJ4dTU5dW5VZ1J4cnJ4aGFsbS9aWDN1SVFLcXA3?=
 =?utf-8?B?LzlpNmtmcEdLWS9wd2xSR0hoN0I2cXlyaXMxRHBrZlk1NHRmRmFLRjhJSFNp?=
 =?utf-8?B?MjVkU09BR0tYZkxOaUhlRFZUVGdoRzZ0OWZNQUh2WEpKOFVvNi85MXV5anZR?=
 =?utf-8?B?QUJ4OU5Ld1M3S1JqUW5McFNBMFZ4Ri9EeHh6bVpEdGxoSlkzSnFWQkdCbG9B?=
 =?utf-8?B?TXpmSXhvSmJ6SDlqNFZpSm44clVDTmhYOGlCcDFhRXpDb2twZXJreFFtUHhh?=
 =?utf-8?B?NFlqRHZ4SmlDTVcvUnhyL0djUVpuYXJoamJaS2VlZzBoVTBkZ3A5WEM2MkdJ?=
 =?utf-8?B?T2RZb09EOEFYVXcyenpKTDR4RVp3RksrMGhyRnZNYUpTVm8wS2Npc3hjaWVX?=
 =?utf-8?B?TG13Z0Yyc1JoMEhLU1dBOVFIbTFXZ08vYkJHZjQwV1lUQzl3MXFiditzV2F4?=
 =?utf-8?B?VW1sSmZ0b0k4bFJMdkRaRy9wMk00endvRFJYWnErbFZrL2kzVU9nUS9qMHFi?=
 =?utf-8?B?d1JWcko1Z2hVT0NQT2hLNlN5MHBzWWZUd0V3cmRXYktXMUEwWk5KRytKaUFO?=
 =?utf-8?B?WndHVlQ1MGVveDlHbVJGcXFkTGJSRDZFbzRDcW00MUxzMVlxWTNEUFNOZ01m?=
 =?utf-8?B?S3hZdzJGVWRMSlpMUkgxeTRHR21ESW5jbUtaSFVEREc5VG1xaTN3bjZsb3hF?=
 =?utf-8?B?MFRIUWl1dzBmNkxyd0s4c2p4bDZ6cDJaaFZBZld2MURway9oTTZVeGw5UE9k?=
 =?utf-8?B?YnpjR1g3dTFrbHdpMnFDRENlQmFMeDVraFB4aUhDSHV5L29kRmZ2SVhnNmht?=
 =?utf-8?B?WSs3T1h1a1FzZmRBMFh4MGZQSWl1L3JFWG1FUVVKSHBpa0RSTzZRbnJ6UWtW?=
 =?utf-8?B?dFY1WUJ2NjFCTzZ6VVplK1FISkQxU1drL2ZuU3FacE5UNVJkMy9qelZZazh0?=
 =?utf-8?B?aTdwSFIxWEwwaUpLMmxLcURwbldLVVE3bmpPanhGUkRSbjEvOFE1SlN5NGdQ?=
 =?utf-8?B?ZlhYbVNnY0N5alBPK1NST2krVXJ1aGVPaXJxQmpVNGpsY2JGcSsrM09zNCtC?=
 =?utf-8?B?U3owRG81SEZzLzBsenhVWGZraGo4M0s0VlNKaGxGY1Z4K3phd0RCc1VMOGxs?=
 =?utf-8?B?QWI3WktIVFppdlgxWDhBVGZid005S0h2dWI2SUhOczVXYW9xZzVBOFd1YjBy?=
 =?utf-8?Q?KusUnT0tv/lPLuDc=3D?=
X-Exchange-RoutingPolicyChecked: VduDFQtZr/xbOITjUuVYrDb9x9YkIbOuuHwXuGx4SEMpuJ11kiORJmMsrrRaT3MSrQcH6IiIYJ5ukP8L2wsGD3MSJkhmdCrRjcyXm141myD8LIWXoyEpEARiKwmqN6S2Pxi5uGx2DiFLEsiWaMLqlmSlABM60y9JMyWot+RgoKEyWkIum+LUOa1PLpgczFlUFvp/Cd7A7pIw4C+/5fxsvAQvPNFexepO6eu4rNySedAcnwVgUoGMdL4LGfg48JAN/Mi8UiWbKeG2Eo2HRRpBoSWWOIAfZseO+zs+KBAY3oryKosxSclQFvKlwrJBPV/SWDTPK1jgxvcKlB4GSj9+Mw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c040ac5-f102-4769-f14b-08df28d0079d
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB8379.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 02:16:45.7254
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T+Ps5f14zQX5CU+Ka5YGD5D2LtkGgneY3jbEdCitu7hvFEMaZ+ZI8ey+JyMEsuHuM9j8pd8AN/d7VVb7yEZjuXWUjWiRG9Tl0OkmXsutV+w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4937
X-OriginatorOrg: intel.com

Hi Babu,

On 10/12/26 6:02 PM, Moger, Babu wrote:
> On 10/12/2026 1:44 PM, Reinette Chatre wrote:
>> On 10/9/26 4:44 PM, Babu Moger wrote:

...

>>> @@ -1611,6 +1627,19 @@ ssize_t resctrl_mbm_assign_mode_write(struct kernfs_open_file *of, char *buf,
>>>               mbm_cntr_free_all(r, d);
>>>               resctrl_reset_rmid_all(r, d);
>>>           }
>>> +
>>> +        /*
>>> +         * Counters were freed above, so both new groups (via mkdir) and
>>> +         * the groups that already exist need assignments. Groups created
>>> +         * while in "default" mode have no counter assigned, including the
>>> +         * default group created when resctrl is mounted. Assign counters
>>
>> This patch refers three times to how "default group" receives counters during auto assignment.
>>
>> How important is it that the default group is assigned counters when switching to "mbm_event" mode?
>>
>> This patch implies that auto assignment will always include the default group but that cannot be
>> guaranteed since the default group is always at the end of the rdt_all_groups list. This means
>> that when traversing rdt_all_groups in resctrl_assign_cntrs_allrdtgrp(), whether default group
>> receives counters would depend on how many other CTRL_MON and MON groups there are.
> 
> Good point. I recreated the problem. It is not always guaranteed that the default group gets the counter with the current logic.
> 
>>
>>
>>> +         * to them so that enabling the mode leaves the same assignments
>>> +         * that mkdir would have made.
>>
>> Related to previous comment is that the changelog mentions "same per-group state that auto-assignment
>> would have produced" that repeats a similat claim made above that states "same assignments that mkdir
>> would have made". This behavior assumes that a CTRL_MON group is created with all its MON groups before
>> the next CTRL_MON group is created *and* that enough counters are available for all groups. If
>> there are not enough counters then the most recent CTRL_MON groups will receive counters first potentially
>> leaving the first "mkdir" created CTRL_MON groups without counters.
>>
>> It is not clear to me whether default group requires counters. Separately, I do not see whether resctrl
>> can or should support the same ordering as what "mkdir" would have produced. If these are not actually
>> requirements then the patch is fine but the comments, documentation change, and changelog need to change
>> to match the code.
>>
>> If the default group does require counters then we either need to change how groups
>> are added to rdt_all_groups or how resctrl_assign_cntrs_allrdtgrp() traverses the list.
> 
> 
> We have always treated the default group as a special case. I think

In general I think the special treatment results from the default group
always being present. It is not clear to me that this implies that the default
group needs to have counters assigned when switching to mbm_event mode.


> we should ensure that the default group gets counters before any
> other group. How about adding logic to give the default group
> priority when assigning counters? 

I do not find there to be a strong motivation for this assignment but it
should be fine to establish such expectation at this point. Just to confirm, you
explicitly only consider the default group and not also the monitoring groups
belonging to the default group?

> How about something like this?
> 
> diff --git a/fs/resctrl/monitor.c b/fs/resctrl/monitor.c
> index 9e705eafe873..5f3711d78a19 100644
> --- a/fs/resctrl/monitor.c
> +++ b/fs/resctrl/monitor.c
> @@ -1339,8 +1339,10 @@ static void resctrl_assign_cntrs_allrdtgrp(void)
>  {
>         struct rdtgroup *prgrp, *crgrp;
> 
> +       rdtgroup_assign_cntrs(&rdtgroup_default);
>         list_for_each_entry(prgrp, &rdt_all_groups, rdtgroup_list) {
> -               rdtgroup_assign_cntrs(prgrp);
> +               if(prgrp != &rdtgroup_default)
> +                       rdtgroup_assign_cntrs(prgrp);
> 
>                 list_for_each_entry(crgrp, &prgrp->mon.crdtgrp_list, mon.crdtgrp_list)
>                         rdtgroup_assign_cntrs(crgrp);
> 
> 

ok. If you go this route, please add a small comment to highlight why the list
traversal is done in this unexpected way. If you do so, please take care with
potential duplicate comments between this function and its caller.

I do not have a preference about which groups need counters assigned when
switching to mbm_event mode. Please just ensure that the documentation (resctrl.rst,
changelog, code comments) match the behavior and explains why.

Thank you very much.

Reinette

