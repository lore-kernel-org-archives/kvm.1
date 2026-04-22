Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010070.outbound.protection.outlook.com [52.101.61.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 429391D63F0;
	Wed, 22 Apr 2026 21:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776894141; cv=fail; b=Q86nOgTVBvdQJ7NHwCwcMksV9FfJywSineZqbFP9L0rz5MKQOPhb1Dng9EGntowqsKgeaSPaMGHV9KFI/OSk6EkDq5AaxE6VzBXOfX9EWTnON07Njls+5soUS1G/M1itD3mjqTq4QGMeYQ/lQokmCZV+PmZRThC2KKfc9FP+Wy0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776894141; c=relaxed/simple;
	bh=7dK3s5e3py46+xmk/5zT7LCd6YmiVQswyewPrrW7Hdw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cH6WLhGNI1If0KYvj1vpWkERIFMlKI6jxRPNvr8ieCOCM7HSXBpkeHHCOctHBsf3wszhxJnas8rdv7Fo7NSEavrPGVcLleMOqG603y6hK9oBB9EMeuT6R/fWhZu29sE7aKZ+ZBzi/T4udneBAkdJB3ecoIruxp6vBPdm28JFKLw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=a/2Q9aGj; arc=fail smtp.client-ip=52.101.61.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="a/2Q9aGj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mbP5aJH2Tni0G9A7Q2AISjwNMzRIz9D8frEOK3NuEzT/8pWPIHU9RVBJ2QtepHL97tUCHGzd5ZiejUGNhwJZ2x604FMxyhyNIiLmmnWJscwEuu23wyw8fnXSceMG7ypu1PbsXaWFfvw153FMtQjWZiAOl+8Ac2hc2lI6gpQOVhsv0JKVmvTzZ6tlKOwI46UXyW+Xtd7RlxaDwy1rbojp9OE0YAgrdavUCrlRcFKVftifdSE5bkx9urNXbbva+eHXf/caTNEQY2DeAFZGA1G62utoeVMNPVwqhjuG3zluo0smLgRijHSyRAJzdnC6pcUUZs0PjKciAdwfca3mYfF7FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZJA1eHngvf/Bx9adksbwJWT19IIU7tSEaSXADHLJjNA=;
 b=XcCo+v1J/7+ID1c1ZM4M8/ClXSv5XD/CBozUr+HcVYUAiE2cI4KvPXjlIzFWG3s6gk/OD/0GVvwzzF3ooWglMw3y16K/rPrlTvFZYWH27BCFwZQ/StomhCdMn8IQvRFSLRJP66e+MDMct0f8ZltEtjK8Xmq7q7PxQCv3prhmxo55TBFXSnqqqdOyiJKd7zcRdikQLh2CXq60y2I52ePOq1DKUhiNu7UdTv8OWMx0tpu5FP+a/AUqOS23sEPq6SKlfiDclMsw/7TKl4wmTtFFRvmLjOQIxUstD4B/YYta73oLFBbKcLQRjorN/7IgTUmqNYmkIBTj5sStTeVGnlaXyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZJA1eHngvf/Bx9adksbwJWT19IIU7tSEaSXADHLJjNA=;
 b=a/2Q9aGjaF6tPt6/fdKL+vMSqxo0Yty3PT36vRt3SV0O/coZDuwGqwICSWWDTIDrmHJvPTqo8GRmvgZFknoOgvQpNMdMd5PZJCn4NjI1er6AfyCtsulYlnAuZmdirXuNC1iFeDUlmZ2WTwvhPtl0XowQCeAWI5R/ayQuIqYDq0E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS5PPFA3734E4BA.namprd12.prod.outlook.com
 (2603:10b6:f:fc00::65c) by CY3PR12MB9607.namprd12.prod.outlook.com
 (2603:10b6:930:103::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Wed, 22 Apr
 2026 21:42:12 +0000
Received: from DS5PPFA3734E4BA.namprd12.prod.outlook.com
 ([fe80::d03f:ffac:bea5:143c]) by DS5PPFA3734E4BA.namprd12.prod.outlook.com
 ([fe80::d03f:ffac:bea5:143c%6]) with mapi id 15.20.9846.019; Wed, 22 Apr 2026
 21:42:11 +0000
Message-ID: <6709398b-269d-47b5-9b41-084f410bb1a6@amd.com>
Date: Wed, 22 Apr 2026 16:42:05 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/16] fs,x86/resctrl: Add kernel-mode (e.g., PLZA)
 support to the resctrl subsystem
To: Reinette Chatre <reinette.chatre@intel.com>,
 Babu Moger <babu.moger@amd.com>, "corbet@lwn.net" <corbet@lwn.net>,
 "tony.luck@intel.com" <tony.luck@intel.com>,
 "Dave.Martin@arm.com" <Dave.Martin@arm.com>,
 "james.morse@arm.com" <james.morse@arm.com>,
 "tglx@kernel.org" <tglx@kernel.org>, "mingo@redhat.com" <mingo@redhat.com>,
 "bp@alien8.de" <bp@alien8.de>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
Cc: "skhan@linuxfoundation.org" <skhan@linuxfoundation.org>,
 "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
 "peterz@infradead.org" <peterz@infradead.org>,
 "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
 "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
 "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
 "rostedt@goodmis.org" <rostedt@goodmis.org>,
 "bsegall@google.com" <bsegall@google.com>, "mgorman@suse.de"
 <mgorman@suse.de>, "vschneid@redhat.com" <vschneid@redhat.com>,
 "kas@kernel.org" <kas@kernel.org>,
 "rick.p.edgecombe@intel.com" <rick.p.edgecombe@intel.com>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "pmladek@suse.com" <pmladek@suse.com>,
 "rdunlap@infradead.org" <rdunlap@infradead.org>,
 "dapeng1.mi@linux.intel.com" <dapeng1.mi@linux.intel.com>,
 "kees@kernel.org" <kees@kernel.org>, "elver@google.com" <elver@google.com>,
 "paulmck@kernel.org" <paulmck@kernel.org>,
 "lirongqing@baidu.com" <lirongqing@baidu.com>,
 "safinaskar@gmail.com" <safinaskar@gmail.com>,
 "fvdl@google.com" <fvdl@google.com>, "seanjc@google.com"
 <seanjc@google.com>,
 "pawan.kumar.gupta@linux.intel.com" <pawan.kumar.gupta@linux.intel.com>,
 "xin@zytor.com" <xin@zytor.com>, "tiala@microsoft.com"
 <tiala@microsoft.com>, "chang.seok.bae@intel.com"
 <chang.seok.bae@intel.com>, "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
 "elena.reshetova@intel.com" <elena.reshetova@intel.com>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "eranian@google.com" <eranian@google.com>,
 "peternewman@google.com" <peternewman@google.com>
References: <cover.1773347820.git.babu.moger@amd.com>
 <973067bf-6e6c-446a-a81a-713840d701a9@intel.com>
 <90f4a692-1c27-4967-bf12-ec3cb597681d@amd.com>
 <68a551ea-d9f0-436a-9bef-e35fd027bb95@intel.com>
 <39e0c786-cc35-4555-bfb9-ff7cd758c423@amd.com>
 <b74cfe34-e23e-49e3-beb4-d5639d42d5cc@intel.com>
 <99a2da36-6a21-4a99-98e0-3c9a4cf7ecf6@amd.com>
 <741aa53e-461c-4a1a-a701-6060d42012f8@intel.com>
 <e8530c71-fde2-4522-8b46-a24efb13b681@amd.com>
 <71099958-1ddf-40dc-8a3c-aa13d0c56fee@intel.com>
 <e624f652-f0a6-4926-a0ab-c4486d41eb6d@amd.com>
 <8d969f11-4a7f-4e36-b85a-c3ed714fc603@intel.com>
 <a46f4f2d-e3f1-454f-b94b-c54e14e45a69@amd.com>
 <0334ba64-71b3-40bd-8cce-9f0f119e7dc9@intel.com>
 <d693f797-65f6-46ed-bd49-beaeee2da858@amd.com>
 <c9e10de7-f5b1-4a38-be1f-f75bc1ae7780@intel.com>
 <9d8a18da-14e4-4d90-a224-7d69d4daeb13@amd.com>
 <de608041-bc45-4ca0-81fe-423a5167d7d0@intel.com>
 <39da36be-40a3-45cb-8e49-12dbb59aca74@amd.com>
 <ed0d2463-edbf-42df-b345-b83da356e865@intel.com>
Content-Language: en-US
From: "Moger, Babu" <bmoger@amd.com>
In-Reply-To: <ed0d2463-edbf-42df-b345-b83da356e865@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN1PR12CA0046.namprd12.prod.outlook.com
 (2603:10b6:802:20::17) To DS5PPFA3734E4BA.namprd12.prod.outlook.com
 (2603:10b6:f:fc00::65c)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS5PPFA3734E4BA:EE_|CY3PR12MB9607:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f8280ff-6f42-425a-d889-08dea0b80219
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|56012099003|18002099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info:
	lSkN37LK8tNMYXpVU3GqIyKEPb31QR0z4peMEN0R8N+zl4L9jOvtwPCpZAlao6gzCV9Wq0Kig8randaiklN3dlFUEEcBsCYe2kvdOz84L8v77kSR+KBU7IVpu7bPqWHceFTnpxhVMChGejXYutHxYcxs85g329RsFo0khXg66PFOUbBbFXJ6uQ2LL3LgwnNBOSIUuu246OCi6hXkxLnxaJQle2bVrKZL+7gmdHiDG8pVAwrbeo8MyqJX5Sd/5BmuLaj+zr87W0LZVnN9uURuRmotznnSG2i8AM0Uto3/k2tw0PxmTVJS9r6oAPgr432RQm0nf1ms+xZsEPmrUmJQtMMMEwksYzShKfr/py5AzPJe5yoJO34lFOJOOBHfkeNVYjkntGyrVpyi4A6vFipcBOBzTl3aKYH34bN7SsYClL/V6o8R67ZPB7fiu/BZXhT9BUyqMpevaCWsHnXzh9ChdxUCtzW6ftc8crIodTL3XVm1ulTNXkrITK4G4g4N1Y898HzWWSaDHTMgUeohipjvW4cWI4mO36CjHeKylv53RqF6xgbkaFdnkU+sxWKKmqlOx4TwCyGRENSSD7o1NLXLndIbC9NMOgUwiiXI1HVzzNnA650D5WbIMwlWHKAgcaHR38GaFU/wQutIdXnTRC37404ArYs+LF//+/JB7+KXUTnTGhBSlfNuzujG3oCIz7rDqMiOAzb5ADwT8XSJBAPVRFG5d4mW/HplSCtzFBv7S/FzISY815D+bOe+CDqfiLen/3R9/HxfJ5XS+3U991TqaQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS5PPFA3734E4BA.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(56012099003)(18002099003)(22082099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?djJvUXNLUUFIbjZrcWkwM0ozY204U0RTbDVIR1hVY0xFOE9MZGk3M3ZnazNX?=
 =?utf-8?B?T0c3ZGZIYWNwalhzbWtBVDZFZnh4MW5vNjl5djV4YUlWa1VEZ3FIZ2xkRWZY?=
 =?utf-8?B?Mmp6VEt4VWdKSi95blE5SEltL1lpMS9sNHFFM3lNdXJwaXg4cjdOdmtWUlU2?=
 =?utf-8?B?Ym9YbEovSlBER0xBVnZ4bXhLOHhyRjJXcHlIT1VhQmwzV1RDYmVuR2thMFJr?=
 =?utf-8?B?VzVNVjlmR1B3M2VpQXoyQjM4d3hWOUR0Z1ovVStaRnA4S1RHNHdiS3JhZSt6?=
 =?utf-8?B?c0xTaldCRGdsa005U3BZNzdTRVcyVjVkdjY1M1k1UEdrZkVsc2NnR0p6QzRU?=
 =?utf-8?B?WTZjRGtXUkJEL3UvQ1JCanU5WWlxekpHWVdHUXNVZmtNZlZJNnYwai9wb3NI?=
 =?utf-8?B?bkVXRHgrQXBDSnpWeStzNlBQRnRGc3JST3VOSzBqQmhvYWRkczdyRjFUeVZG?=
 =?utf-8?B?Q1d2K1JVYzFTYWZFRkRBaXllbUF2SncrV3BGQmVOWXR4SXVnUDM4c29PU1J1?=
 =?utf-8?B?L3NoaUJPRjR2cUVBbDg0WUE4bkU5MFJGdGt0REp3cUd0WWxuS1ozcDRWckFs?=
 =?utf-8?B?ZDBweXVBOU5qWExLeFo2QSs4bzlpNTU1TDJVdEUvQ2s5K3lNZk5ZNllQdzB3?=
 =?utf-8?B?VFBLaDY0bGFLSDlOTnNHaUttL0ZCODNqbGZZYnVyWEdIU21nMW0vclY3ckFN?=
 =?utf-8?B?ekxuQlNJY3IySnR2a2hSbGpQMFRvWnRkSVdVVm1KUFo4YWp1dWJEVXVkSDZu?=
 =?utf-8?B?YktQNEFWZ2FkN0h4dVJYclQ0WUNia3RHNmppM2NtMzFacU15a0RxcVNWeXVR?=
 =?utf-8?B?T3FQTXlCVS9iMUlVNnFIVXhtTHVoenNlYjBrUm1GUDlPalZFaUZiamJGY0Q5?=
 =?utf-8?B?UGRPY3NNSDZHaEU4bnFka250WEErWVNiMTJiUlZQd0d1ZlhHQ3VsVkJFc1B2?=
 =?utf-8?B?am1qT3JJZCtna3NMYUZzZGl0L0tZaDd6eFhpK1U3cTVDajhBYU9KZlNielRz?=
 =?utf-8?B?WnY5SGlSS3ZaMnZ4bEF2TlZxWkM5aGVscnJIVHY2NWFkbitXeHpqY05DM2hn?=
 =?utf-8?B?a2F1ZFNBTFY1UWQ0d0Y3b1dLakNXSG5yNnBRNkUydlVFS0FnS202azR1WlNH?=
 =?utf-8?B?QUJHS0dINmRnYVFCc3FseW1uWU9WMm5DYmU0R0RDdmpiaDEySDcvOWhjZzNY?=
 =?utf-8?B?b1QvWlN3dGk0RkJnL1cwSnQyeUtKcUZPWm0yMkNBRGx2c0tlUnVSUWhHVXpi?=
 =?utf-8?B?ZjRWSytNY2JFQ25MdXBtQTJkSXZuWW5JV2h2YUc4cnJUcmtoYWZJcmNrUzZh?=
 =?utf-8?B?dDdGQXZoQ3lPbFRiTXVBbnBxRlI3SUFEV3VrVFRpWllUOGd5VjQwUEpTaHRm?=
 =?utf-8?B?cldtV0FBMUJNQ0xIb3hWTm5xYng1M09rNDRmOXlSeGhUTFF0Z3dZZDFoZWhF?=
 =?utf-8?B?ZDFQRlFDaDNQZWhmR3ZKRXJyYm5GSVR2ODRFRHUwRXZMY2RGcUxJNk5zSjFu?=
 =?utf-8?B?TVJhNEFDcUkwMk83NHFlc2RaSmNyYTJBSllTVTN0L29DbnN1bFVicUFlRG5s?=
 =?utf-8?B?UnFaU0VxUzA3Ung1Q0NnWEhGZEdVV2JNeWp5eEx0U1Z5Zmt3TTQ2MVcrQTdB?=
 =?utf-8?B?Q2pUUlE4ZmpSYjlSY2RiZFBLK0NTeWxPRkRJaUFmUm9KbGgxTDhGSCthdk1u?=
 =?utf-8?B?cnIyVFhucUpuYWs2dXRvY0VPYTNrVkcxRXVaaFQrMkxUd2dnbzVoWUFDeFVV?=
 =?utf-8?B?TCtjaGFzcnBlMW1oeHFwYnZabEZ1dVZmbXRmamd6Skd2SmFueitINVhGZnBw?=
 =?utf-8?B?bmZSRmMrOTVWV2NZcFdjSmNsTG1TZmtHbXczVENXVXY1dk1aSzMzY3NRSDlr?=
 =?utf-8?B?Zzd4amlFOEtHbGllNXoxc3dQcjJYay8zeXdNSG5FMVFEUUI5SjFENmw5OXR4?=
 =?utf-8?B?dFM4Rndralhma2pDSDF0ZGFPUmUvakxDTlZGWGYvWmdpUmJ1UWRDMVdFUjhl?=
 =?utf-8?B?S1BjQWFxa0Y5L1RTTWYzRzRkZGxVK2hDenFvR1hibHN1empvaTQxejEzUjFU?=
 =?utf-8?B?S1QxdWptTzVoNU4xb0NnRUtYQmlWYWY5YjBxQUlldHJDcFRpb3Y0TzhBY1oy?=
 =?utf-8?B?WXlPRFA1WXJ0a042UTEyaVljNUxoWSt0MGVnK2N3dEtDYzVNUkhjanZSbktL?=
 =?utf-8?B?aFlPS3NNdlhpMFhrZU1rQnFGM2d2OXZIMU81OTVGZU5qYWk4WGhIaHhEdmlQ?=
 =?utf-8?B?bzJuOTFhZDFsTWFTR1BiU3JOeDk3WVNVMlN4NkZKRzNXN0I5WU44d1RwalI5?=
 =?utf-8?Q?EcVvREER9X7sd8HuSk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f8280ff-6f42-425a-d889-08dea0b80219
X-MS-Exchange-CrossTenant-AuthSource: DS5PPFA3734E4BA.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2026 21:42:10.7529
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SpTRWYBd/6ZoHK1bd7TaFIDv7xH83rnxMNkHCR8sMxg8iMAO+CTfuYXU2wdvqXAF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9607

Hi Reinette,

On 4/21/2026 9:56 PM, Reinette Chatre wrote:
> Hi Babu,
> 
> On 4/21/26 5:17 PM, Moger, Babu wrote:
>> On 4/21/2026 5:44 PM, Reinette Chatre wrote:
>>> On 4/21/26 3:04 PM, Moger, Babu wrote:
> 
>>>> That said, I agree we need to support this. Without it, we won’t be able to move the group from PLZA to non-PLZA.
>>>>
>>>> # cat info/kernel_mode
>>>>       inherit_ctrl_and_mon:
>>>>       global_assign_ctrl_assign_mon_per_cpu:group=uninitialized
>>>>       [global_assign_ctrl_assign_mon_per_cpu]:group=ctrl1/mon1/
>>>
>>> Like above where the listing is inconsistent. Is this what you mean?
>>
>> I meant the listing of "inherit_ctrl_and_mon" does not have groups while other modes have it.
> 
> I think this is ok since it does not need a group or any other (for now?) property.
> What issues do you foresee here?

Nothing at this point.  Will let you know if something comes up when 
started working on it.

Thanks,
Babu
