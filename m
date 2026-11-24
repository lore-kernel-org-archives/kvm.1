Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.11
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795502534;
	b=qlGQ7UnggY8CtFKS2to1jjUlvL1eoFX+1wxyaqD4eciiepi/wfYR5pnCpVAutO5ZLJEe
	 8Tk/4FQ860okqfwoGu/WXnyqTPMqZvqtnqKtzNkZCppS+6rESvIowRS3khYtHe9S0jdiN
	 opUsqaOdx+fgJ80YNeGPkBICvm26Fjud3QBl4xIumm9ktq5HFh0eIkpkbErboAiDOg9ND
	 KiDYkYsiVuAD9oF1Vwwcu2C22i/Cj/A+maXAbsqn++DaGfJUd1JqZzu9VRR77fA7jlPCv
	 cSINIuaKtNiKHiZJLV0fyAtFRHz5N8HD7Kk6UxAOJY5MZRu5R29pTZRudTAIVLR2zdQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795502534;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:DKIM-Signature:Received:Received:Date:From:To:CC:Subject:
	 Message-ID:References:Content-Type:Content-Disposition:In-Reply-To:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	bh=xqFLbZ0hgrcW9bJThJOrXXCEBBMUzExsqiT0XfxZEgk=;
	b=jpv4cSJeUSzKs3sxXbW6DovRB2SfKMLBtyE5nIPB39MuIJ0Kl4jPXodQnvUi0SRojONZ
	 e0UFa0FLg8GqxmONPqTsHeBosStELkc/+28sAO84mVcktyiCaSftu2ElXL4Z7TVVxtL18
	 P56v0ptgLRGY13jxZvfU09La6F2HetCuM3+qsKv6Sbu/Cv9M8x/NE8xC2kzu1PKl5ijat
	 Q6kTXtuF5g5BK0wRwSpzbisjOpmSC51+xx7JS+UE+QgqHMeEnpTAqr/fgTrV/X3qNw10p
	 v05VM01p5u1QaW0qYUIgC6zkqsfK7+1ZebyXlldpxEQ38fwxXxgY8YlDXg8/IE2+jvg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=cARDODjx;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=JMQ4fnpA;
	arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.11
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24ED5606A31E;
	Tue, 24 Nov 2026 06:42:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 24ED5606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=cARDODjx;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=JMQ4fnpA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795502533; x=1827038533;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=bczoK356fGZV8OBy8kvEqH7QABwcOBlotrdFqdDnTZk=;
  b=cARDODjxyKYliHkJQfdFsngcUFB6iMcvkVQcbEh2X/yqk0XQ+JEdgqpL
   Ddydz9PGB8nEfDlN0jl1gJ+8egfQSdTJSfPMiNefGpps3d0y4Zuf+SM2p
   nzZCx5JLRS+niQyPjFUW4absF3nFTG/K5tf18uJSoL55TruYW41NqEzZJ
   nSVJr6CKiUDOEt8n6d8bA8WZUyv359BGAP9ykMZ0dK8W+i3p5Cp+My2ec
   fO3UADxS6RKNG43tH2iSLJ3krwCEEtHDJN2/OWpnmvUoaUA7vFEctARbU
   OGqUHwnMNzMLf9eGXn/XtfNnGvvwFGkb5++HXmhOIxS6OutV86dPGZ3FE
   w==;
X-CSE-ConnectionGUID: /Mb5kkQITtywIUtwPWm7uw==
X-CSE-MsgGUID: lBCEICEaQaGhLTj01NQofA==
X-IronPort-AV: E=McAfee;i="6800,10657,11975"; a="4235004"
X-IronPort-AV: E=Sophos;i="6.27,230,1787036400"; 
   d="scan'208";a="4235004"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2026 22:38:00 -0800
X-CSE-ConnectionGUID: B4Bf7MPxQcu9o6F3nr3YRQ==
X-CSE-MsgGUID: phkQ366TRN+/+EtjNHK1Fg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,230,1787036400"; 
   d="scan'208";a="13482046"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa013.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2026 22:37:50 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Mon, 23 Nov 2026 22:37:49 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57 via Frontend Transport; Mon, 23 Nov 2026 22:37:49 -0800
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.4) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Mon, 23 Nov 2026 22:37:48 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EZ0AjVENjXEsNv1imN4MxJfjRVp/K7DcQiEKz3vehIHafQkNwkigYFdueMoDi1glQI9cRPD7lSvDziW+MjyTfG1B4qH/iaN+56eScgpG8IZDfIsyFZX34EvTbSnWJ8OGToOLRxy8/CY1qoh7aeOWuBW0qF6hAGUzXA1MWee6Y9ngSqBreL4Jxlv7b85y+6BbEZxQDoyU3j9PjHPDPocyT43w31WqgmbFao+aAyOk6K1IjkMBEc/ehhNb17LzBzYUh9qQBFCXCYlgl3gsOozBn9ZdB64jMiFO9LbTd3aAji2XRTStnoAEpqakIyjLivnLBMY1RjBOsMI1unDU3AzhIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xqFLbZ0hgrcW9bJThJOrXXCEBBMUzExsqiT0XfxZEgk=;
 b=Q7KQI/hlM9lzae4R+xRj/1PmLxjxwRoudWZAvbg1BmuhkKI9zJ64brJ8P1ApwYnUO45flTAWc2wBbj/f5oQxEw7DA8yYfFAUvpZRl1167eyzVHiWErZomv3NorluyjoFQ6bUrLLlV01s2kAZ5FOW+i9YdIKJMgHCA46q5Um7ra6AGQjDKEKzAEIt6GBbPWV3uvFL8DMmNw4/pHSm/XANxLEknyGVcNNPutqJB91xt+gGiDbjlMtpwwOG7c4rWpVI9zIsnBfbYmyyrBUU78GcemXGR4rWPk+R0MRZZIu2E1emRDaGczZbTFSjTJEPU/MNEBhg/48GIhyDd18mq4PL6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xqFLbZ0hgrcW9bJThJOrXXCEBBMUzExsqiT0XfxZEgk=;
 b=JMQ4fnpAmHbMM8z2lHrnTYypyxBzrOqrLrSZ5+5PqgzOCxJLHske4xxnX0PhvQW/pwkcJtW+xF5WB4Rwom3/d5Wdmq/WvxT5h9UKKfZrqIpzYgZ8LCCwC4Oyu7Bpi0FIOgM76qv8ySxGtO/YvY2G1DHl0Yte4JW9cSkUZEqgiN0=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA0PR11MB8380.namprd11.prod.outlook.com (2603:10b6:208:485::21)
 by CH3PR11MB7939.namprd11.prod.outlook.com (2603:10b6:610:131::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Tue, 24 Nov
 2026 06:22:41 +0000
Received: from IA0PR11MB8380.namprd11.prod.outlook.com
 ([fe80::ea8e:eec4:f8d3:f95d]) by IA0PR11MB8380.namprd11.prod.outlook.com
 ([fe80::ea8e:eec4:f8d3:f95d%5]) with mapi id 15.21.0639.012; Tue, 24 Nov 2026
 06:22:40 +0000
Date: Tue, 24 Nov 2026 14:22:28 +0800
From: Chao Gao <chao.gao@intel.com>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
CC: "Hansen, Dave" <dave.hansen@intel.com>, "Van De Ven, Arjan"
	<arjan.van.de.ven@intel.com>, "Xu, Yilun" <yilun.xu@intel.com>,
	"bp@alien8.de" <bp@alien8.de>, "binbin.wu@linux.intel.com"
	<binbin.wu@linux.intel.com>, "kas@kernel.org" <kas@kernel.org>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"mingo@redhat.com" <mingo@redhat.com>, "x86@kernel.org" <x86@kernel.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "hpa@zytor.com" <hpa@zytor.com>,
	"tglx@kernel.org" <tglx@kernel.org>
Subject: Re: [PATCH v3 1/2] x86/virt/seamldr: Support large TDX module
 binaries
Message-ID: <awUtJKFl0UMMHVQi@intel.com>
References: <20261119074925.3933804-1-chao.gao@intel.com>
 <20261119074925.3933804-2-chao.gao@intel.com>
 <bed831ec-b4e8-4762-83e1-f4a72075fa9a@intel.com>
 <av-3OatHEGZXmWr0@intel.com>
 <c5940627-54df-4ce7-86fe-f73520b61791@intel.com>
 <awQ7Mb0atIOtP1D9@intel.com>
 <41dc795ec6611a1998e94d8b422172d1cb588df4.camel@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41dc795ec6611a1998e94d8b422172d1cb588df4.camel@intel.com>
X-ClientProxiedBy: SG2PR02CA0131.apcprd02.prod.outlook.com
 (2603:1096:4:188::6) To IA0PR11MB8380.namprd11.prod.outlook.com
 (2603:10b6:208:485::21)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR11MB8380:EE_|CH3PR11MB7939:EE_
X-MS-Office365-Filtering-Correlation-Id: e27993c5-f72e-400a-2e4a-08df49f35787
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|1800799024|376014|7416014|366016|261026121527099003|261022075727099003|261022105027099003|261026140227099003|261028144727099003|261021121427099003|261102123227099003|11063799006|56012099006|4143699003|10067099003|261009223027099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: uLFKPFlzobBrWgLjT0CIKd/z+SO93kJS0Mi2QI5rtPBpDvmqgKIa3RJ117gpOq8I8gHyhWdSogJDsNAUqFgVHE2SeK0+F5URZvcOKYfsE3NZlpfDVsXETGdOCgBvlVxb1BfhvUx9VVtjUAwo05XZz49IWXaSeoHqg7ADsuYSbcwPiBjkOCGKFZHicIY719g4SzwTxWwrCvPCLul6eevenln/bK7OPnO0ilEJWrMHhVZfziYqfIPCwoqX2W95rBdrwnppClngo97mWqa0EbYfnXAs8CfEihfml8DSik/OuU72wqPUdaVkryXWhk6tdT2S5AT00PH9gXQ2nCky3F5rpaGm6E/at0w4b/uTjLf1o0wSj/bcEXGWkOBvkQZqiWTu3lNGCvJubNz7QFJOL1qbPzGJWAfIY7gdvPdvB3Lv7h8qF2GqTvHEiaDQQMVw1yN7+B2wrsxuOkrbelcOrLdQXBYMK18DflYnn0h1qiKq73xq6FBHh+EBqNaboDRNHzghy89Vk9piChTsWGuYgWvtRPcsZgTkGcVRqsi3ctJviXXWhN8m6fUpybw75dSHOtxZCDM+lr55D68x0BugoJoXpcg7MZmxuymeWZ93hZu+h0S0x48YIiACe+VoDSrz621fGk4cu4kqFVLDnqDwsYZ+Pfql4vg9QRxCxvdzrmGSZXU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR11MB8380.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(7416014)(366016)(261026121527099003)(261022075727099003)(261022105027099003)(261026140227099003)(261028144727099003)(261021121427099003)(261102123227099003)(11063799006)(56012099006)(4143699003)(10067099003)(261009223027099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?m7t7Rs7YLeOMUTZFeHU7yveyaKfU7GIVWB9W10BOhowGO1kTWf89HHFvIZtY?=
 =?us-ascii?Q?gxnQJcOfRZYq1UKUHTCig20dYJTzMmi/OPVliq03s7mXtyZVHg+Zj4xHyGkl?=
 =?us-ascii?Q?QircGRom5X9OpOLem6vILORCuvVbdekUEFyEoT4kPnFqcYNEz4SJmM9VxzX/?=
 =?us-ascii?Q?6iuICIv4RGwW4flALxwBz1x40XKGvwChxd1FPaOeD++b7jpkkuXsfZ3TUYR5?=
 =?us-ascii?Q?A/v90oRmIWEQ9FTxvj5iWqgX90HC4spKwPpoBSBSQ5v6IaF30LjhHxraBVl/?=
 =?us-ascii?Q?W34UxV0gmDd1p1ifqAAun0db5QSh1i8HJc1fU5GfLvk5WO4Rxv5SS/0jiFru?=
 =?us-ascii?Q?/tK+FycEOeWr+xpqTcSTVEOPhwHPtuSVPqbHaBAwCUP3haBD2alQTlhhIYiJ?=
 =?us-ascii?Q?nD2T7lfO+a5tL7QaGhveORQ7GCdOyW/ta0qupTcJRY5WnOAiuO2ewougQGju?=
 =?us-ascii?Q?mp8u4O6s6JXoxNgb7T8ouNIGWSygGosJMcb9f97Ta1engRh/aeJpYTkWx65W?=
 =?us-ascii?Q?eeBvvlxSTz43qAE44A+WrBLCpXtcVl11pzl5mmro87CWrbIzov6/sKsxbtz8?=
 =?us-ascii?Q?otG4Jn/q5xRL3VJyghJ7gFhwokVAFt+L786kBz5xAEctQTRvY+s6jPtET5y4?=
 =?us-ascii?Q?TkKkpwKr5givJvbeuoa8hDgAlxaEpPBh58KdTk7oh4in3i3x/bECUbEH0BJ8?=
 =?us-ascii?Q?eWLTvoGar9WWSOmYlXdESyzxFLTUIuKhvGIxlgc3Ge+rEb8UIj2xUyuP4zQ+?=
 =?us-ascii?Q?6sOk8RlcEHst4AEpu0BDEKahUrrdoEowGouil4U3wID7ctkyIzFe3jy9Hdmj?=
 =?us-ascii?Q?Yo5v9sOV99EN7yJYtZjG/+iHf+d2E8O6HwuYFVGRXkLbz++jP/zvXLXQXeHN?=
 =?us-ascii?Q?YLwh8pPcIHV7wctNoRcRHStTWmoDxU26PvYu31RaemeFz0zT1KjTennyMjzp?=
 =?us-ascii?Q?gRSENAlYT5vKXq0An+rKNmzU3Q1BywXUHs7c8CqR2wKw7rpJvoZZZTsZu/1R?=
 =?us-ascii?Q?4iKdzc0p5eUlvtHkLYkUNsvo0kC+v66P67uW1vm2OgT9c5SdlSIBOILJnBoW?=
 =?us-ascii?Q?WVjnsUzPlrPdLpeMPdmBULtZaL3pv/3wSZja40e4PprZMJUOD0qcnxkgA5KR?=
 =?us-ascii?Q?i9z7y/TpGfwsqxYlcTZUtOvMXzqtxo9OzT8R8KSUrZS7PWF9agZJ/1EJP+EG?=
 =?us-ascii?Q?fPP1Xn50kAsgpPGYBhKZ2giAgjx7FvqlN/AIAfR89GVEq4v0Ztk0bOzxdEjS?=
 =?us-ascii?Q?8a0Dhi+jlKpUXSl9+uurTR9z/ILfSc/Jx+mhjbGncX6K2tnnieGB4NM9b+1U?=
 =?us-ascii?Q?Phx8nzLcs/VySZnqKql7XTwtBl07UKL9WaH8erh8ffa3v9xfYgDQ2XiFBBvW?=
 =?us-ascii?Q?FNyMlDxYWjC9zHu40BI+b+6CEXm/Hqbz4JtrCw6c5s1fr6u6LuVg48IA0gTH?=
 =?us-ascii?Q?EYG+pvvnqqGYctjhPPApdIegAEmj6oY7ig/d1oEbvkexLIXdp5cnfOunTGqP?=
 =?us-ascii?Q?vyKio0UbhI5vaO9FQ/0FzyyoBB1vzZJUO5tP7mq6PFVeV+t/URK4MUNycQll?=
 =?us-ascii?Q?BU+lJMMrdYdN7tZxvCBWHOLWMtR029wSWxi6Pwuk9QgkWM2OTYDG1cvOlANz?=
 =?us-ascii?Q?SyBGKr3HHBco4AKAdq6NCtmDVi5RLtP5NyzzH/EN/2PGxvyDF2aBnJIYkKxC?=
 =?us-ascii?Q?FniculG54UrRtK9aAhVOMyTgf4pc1+uR8BkM2AocDlhHygRMHj7ft/jv8sCX?=
 =?us-ascii?Q?/bLfiNFU6w=3D=3D?=
X-Exchange-RoutingPolicyChecked: Oesxjxq70oidmY+OFyxNXSysPjWxRk5bbdI0f1KgFSBHtoL94L8eTKqzapoDqo82kBLc2EEwUoEliMwPVNeGBs+64JLy6+7aPfDqz9xGWI1B6nPpRtl31GsHFB9Mb1HXj6Bzvfs6q+hWq8/kkjLVue0sYfrxwLf//U86yFF322t06s88nY/WmNEuZEc2LZskCiCjLFF9hSqSZEJSB1fCzyjTg6+CVaEfn3EyIZDM0v932wCOxme0FZmZ1LQ23opsAUjZsVWSLmfx3/vu2UGVyeN8cvx0cfDUs2UnlhKZxaWLWqgdnU3cV3E0ROR4K8UO9xz4K082UIPhp/DzzdHHdQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: e27993c5-f72e-400a-2e4a-08df49f35787
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB8380.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 06:22:40.7670
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZM6yNNt1RS1u89d4/GRzgJUIku1uqGMDayAc5DhJm3TrvKRjx6t3xow/3HL9VlGNfKvs8jMV8D0plNyGtSnpKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7939
X-OriginatorOrg: intel.com

On Tue, Nov 24, 2026 at 03:20:11AM +0800, Edgecombe, Rick P wrote:
>On Mon, 2026-11-23 at 21:10 +0800, Chao Gao wrote:
>> > Why don't the data structures look like this disagram?
>> 
>> I started with data structures that look like the diagram. Three
>> simplifications got from there to the current code.
>> 
>> First, make the pages in the diagram contiguous. The diagram shows
>> them apart, as the ABI allows, but we don't need to allocate them
>> separately. It can be just a single large structure, and the existing
>> allocation code is reused as is.
>> 
>> Second, use a fixed number of pages. The ABI allows any number of
>> them, to support a module of any size. But modules are about 2MB
>> today, so the structure is just 16 pages, which is enough for a module
>> of about 32MB. The number can be raised if modules outgrow it.
>> 
>> Third, don't define the entries that point to the next page
>> explicitly. They are always the last u64 of a page. So the code that
>> fills in the structure can locate them as it goes.
>> 
>> Defining those entries explicitly would match the diagram. But then
>> those entries split the list of module page addresses into multiple
>> lists, one per page, and the first one is shorter than the others.
>> The code that fills them in has to keep track of which list it is in
>> and how long that list is. That is more code.
>
>How does it look if you just have two versions of the struct and cast? Did you
>try it? How many more lines? We don't want to fight to save a few lines of code
>if we end up needing lots of explanation to justify it.

I assume you mean keeping both definitions, the current one and one
that matches the ABI layout explicitly, and casting between them. That
does not look necessary to me. It would need the same amount of
explanation, because the code would still treat the list as one array
and special-case the last u64 of each page.

I tried making the data structures match the ABI layout explicitly,
with no cast (see the diff below). The patch goes from 31 added lines
to 69, but the logic is simple. There is no need to special-case the
last u64 of a page.

So the tradeoff is about 40 more lines of code for code that is more
readable, can be matched to the spec more easily, and needs less
explanation.

On second thought, I think the extra code is worth it. I will switch
in the next version unless someone objects.

diff --git a/arch/x86/virt/vmx/tdx/seamldr.c b/arch/x86/virt/vmx/tdx/seamldr.c
index b1137ca6150d..4d743a3186fc 100644
--- a/arch/x86/virt/vmx/tdx/seamldr.c
+++ b/arch/x86/virt/vmx/tdx/seamldr.c
@@ -24,7 +24,24 @@
 #define P_SEAMLDR_INFO			0x8000000000000000
 #define P_SEAMLDR_INSTALL		0x8000000000000001
 
-#define SEAMLDR_MAX_NR_MODULE_PAGES	496
+/*
+ * 'struct seamldr_params' spans this many pages. The number is somewhat
+ * arbitrary and fits modules of up to about 32MB. Increase it if modules
+ * outgrow that.
+ */
+#define SEAMLDR_PARAMS_NR_PAGES		16
+
+/*
+ * The number of module page addresses that the first page and each
+ * following page of 'struct seamldr_params' can hold. The last u64 of
+ * each page points to the next page.
+ */
+#define SEAMLDR_NR_PA_ENTRIES_FIRST_PAGE	495
+#define SEAMLDR_NR_PA_ENTRIES_PER_PAGE		(PAGE_SIZE / sizeof(u64) - 1)
+
+#define SEAMLDR_MAX_NR_MODULE_PAGES \
+	(SEAMLDR_NR_PA_ENTRIES_FIRST_PAGE + \
+	 (SEAMLDR_PARAMS_NR_PAGES - 1) * SEAMLDR_NR_PA_ENTRIES_PER_PAGE)
 #define SEAMLDR_MAX_NR_SIG_PAGES	1
 
 /*
@@ -34,6 +51,14 @@
  */
 #define SEAMLDR_SCENARIO_UPDATE		1
 
+/* A page of module page addresses that follows the first page. */
+struct seamldr_pa_page {
+	u64	module_pages_pa_list[SEAMLDR_NR_PA_ENTRIES_PER_PAGE];
+	u64	next_pa;
+};
+
+static_assert(sizeof(struct seamldr_pa_page) == PAGE_SIZE);
+
 /*
  * This is the "SEAMLDR_PARAMS" data structure defined in the
  * "SEAM Loader (SEAMLDR) Interface Specification".
@@ -48,10 +73,12 @@ struct seamldr_params {
 	u64	sigstruct_pages_pa_list[SEAMLDR_MAX_NR_SIG_PAGES];
 	u8	reserved[104];
 	u64	module_nr_pages;
-	u64	module_pages_pa_list[SEAMLDR_MAX_NR_MODULE_PAGES];
+	u64	module_pages_pa_list[SEAMLDR_NR_PA_ENTRIES_FIRST_PAGE];
+	u64	next_pa;
+	struct seamldr_pa_page following_pages[SEAMLDR_PARAMS_NR_PAGES - 1];
 } __packed;
 
-static_assert(sizeof(struct seamldr_params) == 4096);
+static_assert(sizeof(struct seamldr_params) == SEAMLDR_PARAMS_NR_PAGES * PAGE_SIZE);
 
 /*
  * Serialize P-SEAMLDR calls since the hardware only allows a single CPU to
@@ -143,6 +170,44 @@ static void populate_pa_list(u64 *pa_list, const u8 *vmalloc_addr, u32 vmalloc_l
 	}
 }
 
+/* Point each page of @params to the next one. */
+static void chain_params_pages(struct seamldr_params *params)
+{
+	int i;
+
+	params->next_pa = __pa(&params->following_pages[0]);
+
+	for (i = 0; i < ARRAY_SIZE(params->following_pages) - 1; i++)
+		params->following_pages[i].next_pa = __pa(&params->following_pages[i + 1]);
+}
+
+/*
+ * Write the addresses of all module pages to @params. Fill the first
+ * page, then as many of the following pages as needed.
+ */
+static void populate_module_pa_list(struct seamldr_params *params,
+				    const u8 *mod, u32 mod_nr_pages)
+{
+	struct seamldr_pa_page *page;
+	u32 nr;
+
+	chain_params_pages(params);
+
+	nr = min(mod_nr_pages, SEAMLDR_NR_PA_ENTRIES_FIRST_PAGE);
+	populate_pa_list(params->module_pages_pa_list, mod, nr);
+
+	mod	     += nr * PAGE_SIZE;
+	mod_nr_pages -= nr;
+
+	for (page = params->following_pages; mod_nr_pages; page++) {
+		nr = min(mod_nr_pages, SEAMLDR_NR_PA_ENTRIES_PER_PAGE);
+		populate_pa_list(page->module_pages_pa_list, mod, nr);
+
+		mod	     += nr * PAGE_SIZE;
+		mod_nr_pages -= nr;
+	}
+}
+
 static void populate_seamldr_params(struct seamldr_params *params,
 				    const u8 *sig, u32 sig_nr_pages,
 				    const u8 *mod, u32 mod_nr_pages)
@@ -152,7 +217,7 @@ static void populate_seamldr_params(struct seamldr_params *params,
 	params->module_nr_pages	= mod_nr_pages;
 
 	populate_pa_list(params->sigstruct_pages_pa_list, sig, sig_nr_pages);
-	populate_pa_list(params->module_pages_pa_list,	  mod, mod_nr_pages);
+	populate_module_pa_list(params, mod, mod_nr_pages);
 }
 
 /*
