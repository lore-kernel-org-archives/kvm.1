Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B6493B9956;
	Thu, 15 Oct 2026 14:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792075508; cv=fail; b=J6d8SsqUNn0guUcAH/fDv0ByLaPyt5D4U3Z1vJifa/HyevpZzK+QB6sHwPFBG+EF8DPijiuD9VgGFQnjLoRG6xetP/nG7fgeOPTBVBOAP6A0nsu9ZDi47CadulrmA+EVPByEifDtRFIRGKaz5++b9gUPfoO1O4iFpKnFv9unELQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792075508; c=relaxed/simple;
	bh=9AtFCbdrXxBHMTG6iGuy7yeJdhnvSewrOWpg9tJGBw8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=O5ZXayQBekN67ytv70Bm1ZPMg3+WdFpbt1YM97qf5TAASmXKl1hNQHB6wAwOoVunNOGkfFIWjG6WJ5Aka/Tp3fRWjORvzZBsJsOgPFeBldvDB36FdGCbGCYNABDPQ4s8CbsQHfvo1OxFEOuyU5TYYtTgeg5L+nyrjxpZ8Q2ZtPc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aarmSGaX; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aarmSGaX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792075507; x=1823611507;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=9AtFCbdrXxBHMTG6iGuy7yeJdhnvSewrOWpg9tJGBw8=;
  b=aarmSGaXPn8tDew9PMI5qawqG5v/Ftc4NfreiPCnxSnYl9ORBc/wMHvH
   ZAWn96llBVync0D2FX5As0wmw11RtpGdXOasqgPkN4h2vuguCKEgptNDR
   KJZsWkLYAny8lurPQrK17jMj33mvStxuVR2TgTetd7idoWcOUG3fBiYN9
   CT+pBZS1uDGoF3cj6ZsqVZczxuySt18asQXgeA22yJYKo6QR3Yc1jJwo5
   wgRwtP143WTQGD4UNZoiFAERUCUpA1gFarItWoTSdVZvhVb4Vw73XB9/R
   +f26gRyrpM11H1Z4B0Jd7L/taJ6O2+oA92G61IYYoHG6/12v2bNnK7Xdl
   w==;
X-CSE-ConnectionGUID: pmCNr0FTR5+x5ovf0y0f2g==
X-CSE-MsgGUID: MUsDJTPLR/O9vDROnLGDQQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11936"; a="734245"
X-IronPort-AV: E=Sophos;i="6.27,160,1787036400"; 
   d="scan'208";a="734245"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2026 07:45:06 -0700
X-CSE-ConnectionGUID: OftSttHrTNaQ5Nwk4D1LXQ==
X-CSE-MsgGUID: TNcosXW1RNGwFxQot+6vTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,160,1787036400"; 
   d="scan'208";a="1640847"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2026 07:45:06 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 15 Oct 2026 07:44:50 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 15 Oct 2026 07:44:49 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.69) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 15 Oct 2026 07:44:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RZI6KKnrCLAOMZGuPvZskkzyIQNX1PTG6AMQI8TIqu4tmHEe60Wz3BiuZe4I7OoEFmsSFan56K46DSAukAOBOyM0weD5W+gXW+36Hl6iw/HkoO7pnbpI5C+xw4SMgv1NFESWKvVwpFVJurxgexbvZNpawoCtyJsEwtrbfsGncqbgbRWr7QCiP4CgjdtbFxQLOH/xTjADykRe1cp7DTIADAw0tMNMFj+rJg0se8Ea4w+UENI6VVSXmKYvMkYBznLiG77mpUFmme6uBFYvFsvNkh00TopdjhpqzRXi59vQwQh6wjZWNINkmgGMGpOh7AOVuBllAhopT5Sd/efpOpOFkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sz12abD67p0hPhwVmGOMtVuTVRiahJdKKfhQMdEQamQ=;
 b=DzIygxWxqbklIchfhZttEAyfCLC7yKl2+4DclT1uLQO/qrageMG2/Lk1SIsHOTJs8UCc+02y5w6L/T74ikPqWL8aCF9ai86tDkx/+cMw5ietruSb4Uas8pGuuJuQZpkSXEPJIWkQ3D7+TVOCnC/wCVFGF/oRkqbCXEJVpdpQKTVXTIl8EsbMZMEQldFoI1tnq6CYXc2ou1xOcV0JuocRrI6B0vDendpSKB0wAlQnZAUZUug11ScL0dTdTdQAazpe5AtFNlMQ2HnqlssdKW3MVjzO6/bPG/1kEniChrmNCQOAgMqDDv3Ax5JSdor43/O9xW9Hts5RYCwqSH23EQQkuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB8370.namprd11.prod.outlook.com (2603:10b6:a03:540::20)
 by LVXPR11MB9780.namprd11.prod.outlook.com (2603:10b6:408:387::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Thu, 15 Oct
 2026 14:44:46 +0000
Received: from SJ2PR11MB8370.namprd11.prod.outlook.com
 ([fe80::b6cf:ce77:3cdf:7cc]) by SJ2PR11MB8370.namprd11.prod.outlook.com
 ([fe80::b6cf:ce77:3cdf:7cc%6]) with mapi id 15.21.0496.021; Thu, 15 Oct 2026
 14:44:46 +0000
Message-ID: <6764525f-0245-4cd3-b35c-c2bbf4e65733@intel.com>
Date: Thu, 15 Oct 2026 07:44:42 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 04/18] fs/resctrl: Introduce kernel mode enum
To: Babu Moger <babu.moger@amd.com>, <tony.luck@intel.com>, <bp@alien8.de>,
	<ben.horgan@arm.com>
CC: <corbet@lwn.net>, <skhan@linuxfoundation.org>, <rdunlap@infradead.org>,
	<x86@kernel.org>, <Dave.Martin@arm.com>, <james.morse@arm.com>,
	<tglx@kernel.org>, <mingo@redhat.com>, <dave.hansen@linux.intel.com>,
	<hpa@zytor.com>, <fenghuay@nvidia.com>, <kas@kernel.org>,
	<rick.p.edgecombe@intel.com>, <akpm@linux-foundation.org>, <rppt@kernel.org>,
	<dapeng1.mi@linux.intel.com>, <elver@google.com>, <enelsonmoore@gmail.com>,
	<jlayton@kernel.org>, <kuba@kernel.org>, <ebiggers@kernel.org>,
	<seanjc@google.com>, <ewanhai-oc@zhaoxin.com>, <binbin.wu@linux.intel.com>,
	<peterz@infradead.org>, <ashish.kalra@amd.com>, <superm1@kernel.org>,
	<chang.seok.bae@intel.com>, <prathyushi.nangia@amd.com>,
	<kim.phillips@amd.com>, <ackerleytng@google.com>,
	<elena.reshetova@intel.com>, <naveen@kernel.org>, <darwi@linutronix.de>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-coco@lists.linux.dev>, <kvm@vger.kernel.org>, <eranian@google.com>,
	<peternewman@google.com>
References: <cover.1790867441.git.babu.moger@amd.com>
 <66efcdc1bf71c1cb47c546b1d1299b58594bd30d.1790867441.git.babu.moger@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <66efcdc1bf71c1cb47c546b1d1299b58594bd30d.1790867441.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P221CA0029.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:303:8b::34) To SJ2PR11MB8370.namprd11.prod.outlook.com
 (2603:10b6:a03:540::20)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB8370:EE_|LVXPR11MB9780:EE_
X-MS-Office365-Filtering-Correlation-Id: e47a514a-26ef-4c4e-f50b-08df2acadb81
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|23010399003|376014|7416014|366016|261009223027099003|10067099003|11063799006|5023799004|4143699003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: T2bLlHsFCyOc7xAYYbLJHvl4Rc6WV/GgIzCOBro8fSg109T7yrXeNyW62yYWwy2OmmIv90oMvWqntj1QzmZkL6sUMvkZi7qBgrASfzqpA6Pvf0guak6AVHYvUybBOGiLwXsMJHfNcrj6Jn26PZm7G6HnFPBpkXn/GGNoYyMvTBvD5Q/Yz4ciRMbzVooNl1b/thUek74oXfxkzI77q5Dq4kwLDiqgVdtNRiJFRM7rYyov7D91blEEN3O6DB030SYt7xpb0d7NcO6Cs5vdiZcwaG24QtoPMm2l7nxOpSJ4BQq/erB3EBL+7gdMdzNljbaUNLh6SOno1qSQfJp5wigU3aA491b6aHBmcwXUJsLsClXEZ4H2VH1OspZ+Xt+dwerE6Y9idAltxD3ElHzwqhsV54vmlGExH7i3t44yYpvJA8n26AWTfCPN6Iw0v2wiffR5uGQXMroeIwK4o1oDVdfumD0O5p06Mj54Q2eblrApabgBN4oc3dIPrHJGuF+2t7+SUcTCLuJSC2bpWV7hPZCNa/2tEGb89F/iPu/sYCPse+rsipfPtQMzekcD67SIkGaMBHGvL7jr5wtaxPxM651j93npDe29nMvXpbVi9M4lcCxw22JcLoJX6JxG86kg2DrahduJ/GXNYAx8+SVbcRCwV6QkOUmRINlfGPeuq/0kss8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB8370.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(7416014)(366016)(261009223027099003)(10067099003)(11063799006)(5023799004)(4143699003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cUg0bjdKcmJTZ0E2QkFDNkRSdXJObkVoVlk0WVVWRGZORWkxVzgvdTliSVQv?=
 =?utf-8?B?YzIydWNlY21BdGxuOStQRGcxUWZoK3N3UVB6NnEzVDNDVkdsUFVKd0FQSkdU?=
 =?utf-8?B?ejQzalh5b1dxbEpEamNjUDNIc28rcU8rRVA1TlcyTkJmcTAxUDBJc2FSdVlY?=
 =?utf-8?B?Uklnd2dmSU9BalhzZXUzdUFmSEhtclVSWldCVFJaMFJuSXZUbktXSU1aaHhy?=
 =?utf-8?B?RytVTXlyeUk1YUc1REljamxBMnV0UlkxZm9MRTZUNG5oN2VDcTR0QUdodldI?=
 =?utf-8?B?emRxUTlkL0dBdktwQ214cHhZSEhjWVlncUlaTklma0RyREJHdlRTTTUyeW52?=
 =?utf-8?B?NXdpeXg5SjZocVRKMlZ6RXoxc0p2a3lJbitQWWU0dTFDU2dFb29NOWlMVHZy?=
 =?utf-8?B?T1pFcnlObTBNVjFYU3ZlbEcrRUxlQ2VmMjBKWmtIRGFOQ1FJTDlUbmdhbGRL?=
 =?utf-8?B?Q2FJa2JGUFBtVXhRRHlWSDFpRHNFWTNiWW0yYTI3dWk4T1JNNFJTUWxpcEhR?=
 =?utf-8?B?NHY5a05CektvZWkvcXhBWFFiR2tTVnl3S3I4QmhRMGR0bTB5N29WVG0rRnNN?=
 =?utf-8?B?dVptckVwWVJWSXcrUzMzMHZFRHlpZk13SEEvdjJKbkVGVUR6WkkrS0JYaFRo?=
 =?utf-8?B?OEs0MkJ2UTJ3ZnAwZFZPQmFWWElaQzgrblEzYmUvSG9hK3ZEMFFlRzNlc3ln?=
 =?utf-8?B?SnREMDNhRExjN1Q4ZzBKeXBWR2NMOGJDSEVFemVWVDMvNU9qVFNVMzFpSkxx?=
 =?utf-8?B?ZGd1TE1lZDFoWFBBQUl6TUYzdzVxak44M09oTXRFRW5xNFFRWHdaZ2hZc0Ex?=
 =?utf-8?B?Q2lBTE1FNHhRanVnLzA5NXN5bG44Q0hyU2kzNUJtQzJkYnFHYVFuakxRVUJK?=
 =?utf-8?B?QUNNRlNsSnBrVHlXcGlGRXVHMUs3US90QkpkQmlnaWprKy9GZ0MrblFsRVdY?=
 =?utf-8?B?MnRyNWJMNUx0R3ljYVI1Yk9tcGdDZ2xZeHJVeXNyT0piMGhkd1FzZHk1Zk1K?=
 =?utf-8?B?UU00NkQxS3dRYmFQQnpta0RnaDRCTHhsU2xxa01kc09SZ1JCREdHSUw4U1Bv?=
 =?utf-8?B?Rkk2d29oK0RHTEI1MjZmWXVJcmUyZm1uMzdOMEhjTHRVUEpRdXhJRXRVc1hJ?=
 =?utf-8?B?OUJLWG9GZFdENTFFSkNBeFFreEl6aURmNU5NaEx2U3F1WWEyMXpqc3VOUkZ3?=
 =?utf-8?B?TndIek9pcUwrQSt4M0xTUXV1WWVsRUZEZXFUazE2TTN6cktyc0t2ZURpWms5?=
 =?utf-8?B?K2J5aEZIYytOR3EzUkR2T2o3OTJGVXRFUnN2VUQwdzF4YVpIb1ZqN1U2Q0pT?=
 =?utf-8?B?TWpGWXR6TGw4WU1yTzJId1ovL0l2V0gyeEh2RTdaMjdWZ1R1bGdYa1dvSXI1?=
 =?utf-8?B?T3Nlb2lpanp6OUdUV3JCck9JdkJzLzJFQmRMdzFyc1NrckRacnVFRlZ2L2sr?=
 =?utf-8?B?Y1U5eFlvVVVFeW5SUGV0WHJ5MTFKRjM3VmhpanlSbVJuMlBHbzlBWHFqTnV1?=
 =?utf-8?B?VytCTHlTaXlVRjF4ZVhHZ1dhUXJka3U0a0tLT0poc0Jjb3c1SjBUa0tjS1A0?=
 =?utf-8?B?SEpUN3hjZE02Y3ZYM0ZhWjhBbkRZR25BZk5RRGFkQVNHc0NzY2FPaUdjYkwv?=
 =?utf-8?B?WS9lTVRzRlJZVFFqWXpkMTIwcDBoOWpHK1Z0Z0NIMHlxYktlZmlHQTZwdXpa?=
 =?utf-8?B?Ly9zVnBwcFoyL280SGI1SnNuK1lZM1BlYWlCZHIxSHk5Qi9tZ0tJN3UzeUxq?=
 =?utf-8?B?Z1BDbGN0TllQV1pyY09Zck0yQkRLYk80cUcwdTUyS1V0TW9EeGdyZUQyTUsw?=
 =?utf-8?B?QmRyYVNUNnlLOFh6Y3dJQ1hManNlTHdzRm80VTJ3S29sY0xVQjA5cUpraElU?=
 =?utf-8?B?d05xZDlkN1UraFdaRVhnUU5kUmI5ei9oK0pmeUlWQWlVRjgvTnc1TS9kaHdG?=
 =?utf-8?B?WHloVytZRitPZXRyQVp6ZHlPTmhNSnY2dUpXWU40ei9hd2ovcGZXdHVkaWlM?=
 =?utf-8?B?eGUzTWtsb3FFVCsrNHJ4ejFIRHUrTkYrbXA2dzhneWFXNHBoOXlKRXlCYjlj?=
 =?utf-8?B?dVZobHRtbUVMV3l3Y3EzbkdlNW5qbUI0MzlZQy9Ec1pZY3ViNXFNY2hlU3dt?=
 =?utf-8?B?ZDFBaEV2ZkR0ZnR6cERNWmRyZUNYb0drSHlZNUxlcHd1bjhOc0ZVRWlhLzVU?=
 =?utf-8?B?WWM1WHF6bXQ0NVRpMUlxMGlDa042anBRakxSbzI1d0FWeEFSRkdpTW4zT0Na?=
 =?utf-8?B?bE91eGVRcWEyT0dhd0FIS3p6TjRHUnFhUGdrb2FyWllxc1lNZXl4cWxFU3Mr?=
 =?utf-8?B?VThOMWdObE5zbW9PQys2V1dTMVhLWXBWeUtDS0pndGRyMHlXMkpSeDBOSjht?=
 =?utf-8?Q?mKn4+vTJ1IVw5jOY=3D?=
X-Exchange-RoutingPolicyChecked: dGnYT6zLoQB0j3Mlnjn/1bkrQmJGFCBW/WLmYA6QOOQFKrGapUY1BI7X7WPYS+B/CtRWf+ECDDyVn+g8oq1ajKv9hrU3LY2DM0uczH4EQTx4ChwXIEmq8CBQuzn4Uxi3+JIY7CaFIxv5vWfiwaPTUARR39+sywrMHT20MteIlgHtUVb5VJOyhGZrRfR9+8zewrohSFdArSHN4VL29eibSb8uZiLmsQFvnGqPt3q4LMIo/1rcsBrd4xIoEIV/WFUgZRGpDfpkH7jUpcjjZE1tY6b8ApD57qzcZRGQTAP/A3UerAJbQHDUH7PsWJQnfwPWINTs2d97iUD++tuP0teqgA==
X-MS-Exchange-CrossTenant-Network-Message-Id: e47a514a-26ef-4c4e-f50b-08df2acadb81
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB8370.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 14:44:46.6014
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5jcniY5pMl+2BVQ7ZrE/80zd/Fh1Hd5D9RDdXfeUSH98Yy+BBypIrrJ7Jj4xtqpU95fBmfEDuoiDvMpX80wyh0LxiCFPH4mpfSv1vqcZLe8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LVXPR11MB9780
X-OriginatorOrg: intel.com

Hi Babu,

On 10/1/26 8:10 AM, Babu Moger wrote:
> Kernel mode work can use different allocation and monitoring associations

Here I think "different allocation and monitoring associations" means
different CLOSID/RMID, while other places "different allocation and monitoring
associations" means different MSR_IA32_PQR_PLZA_ASSOC.closid_en and
MSR_IA32_PQR_PLZA_ASSOC.rmid_en? 

> than the originating user task. On x86, Privilege Level Zero Association
> (PLZA) enables the kernel to switch to a different CLOSID and/or RMID when
> entering kernel mode.
> 
> Architectures need a common way to name kernel modes before resctrl
> can report what is active or what the platform supports.
> 
> Introduce enum resctrl_kernel_mode:
>   - RESCTRL_INHERIT_USER: Kernel mode work inherits allocation and
>     monitoring from the user task.
>   - RESCTRL_GLOBAL_ENABLE_PER_CPU: Kernel mode work uses allocation and/or
>     monitoring associations that differ from the user task.

As written this is not accurate because there is nothing that prevents
the "kernel mode group" from being the same as a task's own group?

Could the description of RESCTRL_GLOBAL_ENABLE_PER_CPU be made more specific
to include that (a) it is a single (global) association that applies to *all*
user space tasks, and (b) it can be enabled/disabled on each CPU? With these
two additional details reader will more easily understand why the name of this
mode is "RESCTRL_GLOBAL_ENABLE_PER_CPU".

> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---

...

> ---
>  include/linux/resctrl.h | 29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
> 
> diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
> index 10dfdca7f4bf..f6adff7f4e1f 100644
> --- a/include/linux/resctrl.h
> +++ b/include/linux/resctrl.h
> @@ -723,6 +723,35 @@ int resctrl_arch_io_alloc_enable(struct rdt_resource *r, bool enable);
>   */
>  bool resctrl_arch_get_io_alloc_enabled(struct rdt_resource *r);
>  
> +/**
> + * enum resctrl_kernel_mode - Kernel mode control and monitoring association.
> + *
> + * @RESCTRL_INHERIT_USER:
> + *     Kernel mode inherits both allocation and monitoring associations
> + *     from the user-space task. On x86, the kernel uses the same CLOSID and
> + *     RMID as the user-space task.
> + *
> + * @RESCTRL_GLOBAL_ENABLE_PER_CPU:
> + *     All kernel mode work uses the same allocation and/or monitoring
> + *     association via an assigned CTRL_MON or MON group. The mode can
> + *     be enabled/disabled per-CPU. When the mode is disabled on a CPU
> + *     then the kernel work on that CPU inherits the allocation and
> + *     monitoring association from the user-space task, effectively the
> + *     kernel mode becomes RESCTRL_INHERIT_USER on that CPU.
> + *
> + *     All online CPUs are included by default. A subset may be selected
> + *     through the resctrl group interface, and a CTRL_MON or MON group
> + *     may be assigned to this mode. On x86, CLOSID and RMID are configured

The sentence starting with "A subset ..." repeats what is described in the
first paragraph so it could just be dropped? This leaves the first sentence
of second paragraph out of place, how about merging it into first paragraph
like:

	The mode can be enabled/disabled per-CPU, all online CPUs are enabled
	by default.

> + *     independently; either or both may differ from the user-space task.
> + */
> +enum resctrl_kernel_mode {
> +	RESCTRL_INHERIT_USER,
> +	RESCTRL_GLOBAL_ENABLE_PER_CPU,
> +	RESCTRL_KMODE_LAST = RESCTRL_GLOBAL_ENABLE_PER_CPU
> +};
> +
> +#define RESCTRL_NUM_KERNEL_MODES (RESCTRL_KMODE_LAST + 1)
> +
>  extern unsigned int resctrl_rmid_realloc_threshold;
>  extern unsigned int resctrl_rmid_realloc_limit;
>  

Reinette
