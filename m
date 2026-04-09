Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010018.outbound.protection.outlook.com [52.101.193.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9960E2DC767;
	Thu,  9 Apr 2026 17:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775755160; cv=fail; b=dIp1iFHXuaB/yEIv1Z9c6OyuMLmaVkvvEo470XGOeXlyMedz43e3W+EirZ5OKFP7M4sGZadWHG8rKnvL9ZONeSkUkua7Et+XczmoQ5UhEbwSXpSWGrAQrAqiu5c0hWtEB6fdbibBC8VXMXIaaZzrH4REEx9qMJcBFkql/43v0is=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775755160; c=relaxed/simple;
	bh=f5evz+HzIQBzdJBoIRHE5F0/ZJbgSDywvhfaV4K9l0s=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=K+yi1uPcSIDiANTCTPsxf+xzRMx2aeCACAKp5rpeJ/kYT4uxqbA5NWFHhUf96+AXZXecm++Hyy3t1i08gHOttaYuKu6lJqM+P+2aTPgYYn2mY3AsAthmeYJ1WGdBwT9AqMZc25W0WZCfyMvyNnuCAPRBXNiK2OV0W7OVOqeoaoc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=EV943ePC; arc=fail smtp.client-ip=52.101.193.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="EV943ePC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=odDBCNxZ+k/5e7YoZH/vPNHrKjp/eBYbg96c9fw6X8b676MYHPjLP0LyzEI8UHfaj2WIXYC70PmVEhneKK6tfutYMOR/Ps+BKfsFCdYomFYyubgYtMdDcdCOjvyWECsfzL9fu1VXmrAQbnJKMXa0DyxZGGXb57uQhM4yNCY+TF4+5pT5dSF5oAPkv5Ic8uIy/9fxL7bxfA5XzXOpEesPzNuYfbPmGHLDBDJcgbpmOCkAkv1/wcCoF3p6zkBxQYWQSSAPx1UJeaX7GxPp1/QXKjEeRb/ZHGXVcXNiF487Fbz07iMiJ1YlpK2TBbqgqE+fI31R2kIKS6wHELWf/vDtHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zy2oaxrKM4cQxzIHfJFNRu0uElgjZpR/0Ih0FXlH1Y4=;
 b=ok2ORuqae/yBe0bCSw73ZgsHBMFiEchbnOAEhfDh+32ZkYzkpipsilkyOaKP2BAz+cUhblFlQMx1r/4SVMOAUfxC0VUiQv9par3cTGdghVhX2ojNU3pi9G8Fd8XqEXLJ5v1YKaf+n3daEAJBPFSQgbynUh1c575FfNu6llilo1gJIiVXFAyXB9wmztv6Ad6B0jRYGVoA9ijdF2y4CWJqnN2P3Yk/fmlTQ1xDLwuUrWgdTeo/Y3mghO5Hab559vAmOH1tp/naejLaK7HleD0O7K6lrVH2OQX/vdNUTrvIjt8fti57nEYM+Zpok0THvvenZ3bN+hcYz7rcAvaVaHt4jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zy2oaxrKM4cQxzIHfJFNRu0uElgjZpR/0Ih0FXlH1Y4=;
 b=EV943ePCNkTQrAN1xEdzby2YA24D4ZRXNUq9vFV9r7CAf4lH1qpOkqaK5T3jWpC3wUTCzZS/FqXvajY6cwvXSfGGKTqbRpegVkmp08Og5/eYkhL+sFVHdPLHZIcmVdOciUpMfK100Jd5/epr9suKL84balbYeD0ufCi6LvVMhW8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bdc) by MN2PR12MB4285.namprd12.prod.outlook.com
 (2603:10b6:208:1d7::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9791.33; Thu, 9 Apr
 2026 17:19:14 +0000
Received: from IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 ([fe80::e192:692b:abba:8c88]) by IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 ([fe80::e192:692b:abba:8c88%3]) with mapi id 15.20.9769.016; Thu, 9 Apr 2026
 17:19:14 +0000
Message-ID: <bb9f62f1-0c79-4d29-9866-c39d08c3a774@amd.com>
Date: Thu, 9 Apr 2026 12:19:09 -0500
User-Agent: Mozilla Thunderbird
From: "Moger, Babu" <bmoger@amd.com>
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
 <14a8ad0a-e842-4268-871a-0762f1169e03@intel.com>
 <47c0db32-d0e0-4c53-90bd-b74863d233dc@amd.com>
 <88eebfac-5286-4788-b244-911c659c0439@intel.com>
 <30deeb5b-d2ec-4f85-aa4f-c21400df3486@amd.com>
 <83ae0c18-5c5e-4b52-901d-4126fe7c141b@intel.com>
 <5a740f47-d3f3-45af-9d8c-ebcf3dd89c0d@amd.com>
 <3305c18e-9e50-4df0-b9f1-c61028628967@intel.com>
 <c6f574b7-fe5f-49ae-9865-0e4dbb2f9803@amd.com>
 <efc269f8-bf98-4f12-8d76-1fee564be84c@intel.com>
 <0ae2b267-4527-4251-9136-6afdc3fc97a5@amd.com>
 <72297351-2954-4318-81b6-7de409e5552c@intel.com>
 <20aaacfb-9601-4343-a5d5-f3df6152155b@amd.com>
 <43880b7b-b390-4e7f-8c2a-46cde9e3b051@intel.com>
Content-Language: en-US
In-Reply-To: <43880b7b-b390-4e7f-8c2a-46cde9e3b051@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0P221CA0003.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:11c::7) To IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bdc)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PPF9A76BB3A6:EE_|MN2PR12MB4285:EE_
X-MS-Office365-Filtering-Correlation-Id: f8528e3c-142d-4d67-77e0-08de965c1f5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|921020|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	oxVw5S+p7t9CdCOV8fyIzgMOD+11yjb/1c4tz6FJLsuyXNWq3ijRVNeWmWmcwg4wvTFvInfTIVIeprfD/4xGSrsWv+wFNmv78TepKRRDsZgBxwK6skBcO/Iz/xNRKKxeNtLoB1DFOB7yQls09pTJ2c/4XUrk/MUgL/2neb3PNENhNwE9yZb2ouLa88wp9/BOVEeSU8rqHNWum7r/tdeHv0nTtckKpMGVIK2ef2mlrrYjXJA0WFIJciuMp2aed4dKzBVlrU/EcL1aI0H8uy8QFmC9ZNCqtQ9Z6i5DP+0O8a0coKpJDO7h8IhjRLY/HQ9GfkSVeE63BA459qfukfpXaxUTyr4PY7ePd4qCpkFPlctCa86qZdZ2tu0sw8cYWR/eaMFaDzQl86SJRM1Ab4B6ZyX+rTGbeFxVLgrHqUgIV4y+jvoM0vU8HyeLgLVYilQ8NIat6pN0vW25/iX7Fq9rTy1WYvofrbn/J2BHKfh2dwCMjMc6ecmHELdjrsRJDGeuzPAsM+Vhahiwubo/UbNwAHs8c4REsUBpplD47XMEwet+H87G8L+kIFGfs6sFMtU36nrprYPax53jj9T6nGaT6Bpc6KB85/WKDyRtlL70WMlwJK82otbtMcS4DAKo3IshvGhFB+POpZPPl8Fp1jMGuGEGBtkXIgX/LhL1fUpYWW47UQPmMV3OxFOxxUqdllTvIkVUEUC3i8TwzuK2nf9jruMZDtNJM3l8lH3tT/BX6EdISreGhLGB6hTUjFVTBHArBSWNLsQGrrGUjfsTFLiFyQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PPF9A76BB3A6.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(921020)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bkJjeGNDQ0ZscDRyanp6cExQZEQ3VVVodU1oQWRmMURCLzB3K0hRWGNBZ1lr?=
 =?utf-8?B?OG1qckVHNU1XaSt0Z0NUUW1uVXJMRHdUR0xEMFFjS3QrRHZHdjBJMU9KQXFU?=
 =?utf-8?B?cTJnODJXem9VQlhzUVh5TGJzdmJOcXlvei9XUy9yS0lIeU9CM3NieTIzUWE3?=
 =?utf-8?B?RjVEM2hYTmxhOWhGaURvUWx3cWlxdzBjR2RtR1YvSzE1alJKaENWaytCYStK?=
 =?utf-8?B?RHBmWm5TSGFUem8xNHZhUEpRNFN3M2Ztc0o0NkgreVJGK3ExdjZwUytLOTJD?=
 =?utf-8?B?dFpjVG1yd3EzblVSK2N2Y1ZIUTJBNm42dGcveWZYbjduL1dURkJjOUMzbWNH?=
 =?utf-8?B?YktzdHlQU3Z4QW9xZ3hYN01jbDVjTTA5RG5uZ2RKckJnREl4Zi9zVkFVcDZP?=
 =?utf-8?B?UFNYR1FTV2xnQU9OM2dTVkpMZDBxVHlIWmU1eGxMaFBJNDcyTCtpWEZGcVQy?=
 =?utf-8?B?WStsTDIycTdTY2NKamtVdnhndEttSENWTjVUb1dVT2htRjZRbnVPVGNHdXNl?=
 =?utf-8?B?ZEJST1RqK2xmeEVjNlUzNzJkdFZ2Tm9zRHQ5Z3FsWDBueGVmRzRuMERmRzB3?=
 =?utf-8?B?SHpHcVdKRmxsbkVlYmtmTmxJSG9QTi9wRHhrM3RvU3l0OE1QZ3VMMUVnbVRh?=
 =?utf-8?B?T0hENjdiUlJwdjFwdWJQclF6akVwY2RicGlCOUlWREtLd1F6WFl3WEZPSURw?=
 =?utf-8?B?dFJFcGVhMzRRZndOd3NNdmd4ck5oRzgvMHY5ZWIzVkJramNleEJFbG1WNnU3?=
 =?utf-8?B?ek9DdGE0cUtOZUJSN0tIajRVUWdmbldZbHFudzJIeWZDMFZpOGh6eGlxOElW?=
 =?utf-8?B?eUN0L3NvWUdqOHVEREdLeHhGRytFeXcxTUYxam85SlRyMTdXVWw5ZEQvby9u?=
 =?utf-8?B?NEFoblc4K0p3aHNYZzVnWU5VNWREVndHV0JCSWJROGhZckduaVFnWFBYYUx0?=
 =?utf-8?B?SDZTeklYNjlQajY0L0ZmOXFkN1N5d3pXb1QzdjZPMCt2OWdybU54UlBISHI4?=
 =?utf-8?B?VnNjNnpBMSs4dEFYNVdSNmtYdGRmRzZ6eFlnRnJmV2ZxTklkNVhQbllhUFVh?=
 =?utf-8?B?WWkyeCs3MnJIVEZsc2tndkdWOWM0Ym9SYUVpbE42ZStJWEJBenYxWmZzYWVS?=
 =?utf-8?B?SDlBaTJudkxPU0ZXbDFJNGFiNWd2cTNOYW51TTBtY3ZjbnpEclRUY1RldHFB?=
 =?utf-8?B?Y1lieEdrUHN4NkhkN0lBZThmcWoxclhuWi9GLy8wSWJuQ3dJQWVsM3ZDajdB?=
 =?utf-8?B?T2RYQzBSTmRCTCthSVhtWFI3NE12OG5YWlN4WHZWWkN4WlhBUUd3WGVnaVFm?=
 =?utf-8?B?R0xmbU8xY2NLaWZURUtKUzNIQkIyU2dEdFpXMnIyZVdoS2toVXFWQjJnZkpF?=
 =?utf-8?B?UjZBS3hyMVE4SWhYUUQvL2IyUWV1WkMwcHRUeU02cHdXamREWTlqOG1xYzNB?=
 =?utf-8?B?NytjcnhCSXJzMnBiZlZ0WmVRbjBKZlBQVldDeTJ1UVQzck5mT3o4aGM2YmNt?=
 =?utf-8?B?SWNvWXZSdnJ3aUxMd0lUbEdock5Yd0RtVGNxL0ZBZFFOR3NOMGMwMk5PQldk?=
 =?utf-8?B?M0NQVENjc1FyTlhKWTRFQTlLYkdGSVRxby9yNzg2cDNmendhb29jdnZ0UWxa?=
 =?utf-8?B?eDRRRWFaZGlJTUZSMXdPUzJtZGQ4WGk0RnJPRk9vQnlSZWtTd0l6QVcwU212?=
 =?utf-8?B?OXJVcEFWQkxrTms2bzJNYkcra2N1K29tKzlhRldmOFhQdTVjV0FuTU5ob05l?=
 =?utf-8?B?M0h4bXhzd2poaHVuSTZLVktOR29hby95aEVjOU1oenJkMGpWbUJZNkpGZ0ZX?=
 =?utf-8?B?RVpmdVlUaXdPdlFJWG1ReGZla3orbzdCWU1VWXVIazFTb1EzQ2RkNXRNZXAr?=
 =?utf-8?B?Zkw5RFV0YVcwTHk2V1dLcjJMNVpVOGVVL0l0bW5DeEhDNmRzVTNYdWR2WXdK?=
 =?utf-8?B?YnV6WVlaVEt6d0tvNzRHL0hJZjMvTURsT2FhWll4WGtBRnJ4QWN1RmVGbXpt?=
 =?utf-8?B?NDR1NEx1WXNqQktlNll6Vzg4RXBWalJHUHVLYVVHNjNDY1o2dnl4MXk4WHE5?=
 =?utf-8?B?QzVzTXVvKzBqMjFGR0Y2VTdVUCtDR3BKb1dNVGhJWitxSjhuUGptZDUvMVRN?=
 =?utf-8?B?ZE1QeGVrZEhYeS9ZY1BTNWdOVVJCbTdPVTl5dnNRbTlWc1hVV3hNbzdueWFS?=
 =?utf-8?B?THVLRmsrd0Z1ZUtRTmZmNWYzU0E3YjB1b0FKeU1NUHRFaTVuTmxGc01ROUgy?=
 =?utf-8?B?ZER2TjZMYWs0THJDVVd5VVY0Y1VUcE9pTHo5Tm9ZeXhpNGxyc0pZME9CVzMr?=
 =?utf-8?Q?P92b42MeGY8QoUqnbg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8528e3c-142d-4d67-77e0-08de965c1f5c
X-MS-Exchange-CrossTenant-AuthSource: IA0PPF9A76BB3A6.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 17:19:14.2050
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NDx+Q0InbU+VaBvhbnLXi9PLUTdac6MEBvvc0aZjNlVzmu9xtzol8/ODuVrruee/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4285

Hi Reinette,

On 4/8/2026 6:41 PM, Reinette Chatre wrote:
> Hi Babu,
> 
> On 4/8/26 4:07 PM, Moger, Babu wrote:
>> On 4/8/2026 4:24 PM, Reinette Chatre wrote:
>>> On 4/8/26 1:45 PM, Babu Moger wrote:
> ...
> 
>>>> The modes "global_assign_ctrl_inherit_mon_per_cpu" and "global_assign_ctrl_assign_mon_per_cpu" represent the actual PLZA modes.
>>>>
>>>> Both of these modes introduce new files kernel_mode_cpus/ and kernel_mode_cpus_list in the resctrl group.
>>>
>>> Right. To be specific when the user changes the mode to either "global_assign_ctrl_inherit_mon_per_cpu" or
>>> "global_assign_ctrl_assign_mon_per_cpu" the new files will be created in the default resource group with
>>> associated setting applied globally at that time.
>>
>> If, at that point, "info/kernel_mode_assignment" points to // (the default group), is that correct?
> 
> I see "info/kernel_mode_assignment" pointing to default group as the only
> option right after a mode switch away from "inherit_ctrl_and_mon".
> 
> To elaborate, the current idea is that the mode within info/kernel_mode determines
> which, if any, control files are presented to user space.
> Assuming that the system boots up with:
> 	# cat info/kernel_mode
> 	[inherit_ctrl_and_mon]
> 	global_assign_ctrl_inherit_mon_per_cpu
> 	global_assign_ctrl_assign_mon_per_cpu
> 
> In above scenario "info/kernel_mode_assignment" does not exist (is not visible to
> user space).
> 
> When the user switches to either "global_assign_ctrl_inherit_mon_per_cpu" or
> 'global_assign_ctrl_assign_mon_per_cpu" then "info/kernel_mode_assignment" is created
> (or made visible to user space) and is expected to point to default group.
> User can change the group using "info/kernel_mode_assignment" at this point.
> 
> If the current scenario is below ...
> 	# cat info/kernel_mode
> 	[global_assign_ctrl_inherit_mon_per_cpu]
> 	inherit_ctrl_and_mon
> 	global_assign_ctrl_assign_mon_per_cpu
> 
> ... then "info/kernel_mode_assignment" will exist but what it should contain if
> user switches mode at this point may be up for discussion.
> 
> option 1)
> When user switches mode to "global_assign_ctrl_assign_mon_per_cpu" then
> the resource group in "info/kernel_mode_assignment" is reset to the
> default group and all CPUs PLZA state reset to match. The kernel_mode_cpus
> and kernel_mode_cpuslist files become visible in default resource group
> and they contain "all online CPUs".
> 
> option 2)
> When user switches mode to "global_assign_ctrl_assign_mon_per_cpu" then
> the resource group in "info/kernel_mode_assignment" is kept and all
> CPUs PLZA state set to match it while also keeping the current
> values of that resource group's kernel_mode_cpus and kernel_mode_cpuslist
> files.
> 
> I am leaning towards "option 1" to keep it consistent with a switch from
> "inherit_ctrl_and_mon" and being deterministic about how a mode is started with

Yes. The "option 1" seems appropriate.

> a clean slate. What are your thoughts? What would be use case where a user would
> want to switch between "global_assign_ctrl_inherit_mon_per_cpu" and
> "global_assign_ctrl_assign_mon_per_cpu" to just switch rmid_en on and off?


This is a bit tricky.

Currently, our requirement is to have a CTRL_MON group for 
global_assign_ctrl_inherit_mon_per_cpu. In this scenario, we use the 
group’s CLOSID for PLZA configuration, and RMID is not used (rmid_en = 
0) when setting up PLZA.

Our requirement is also to have a CTRL_MON/MON group for 
global_assign_ctrl_assign_mon_per_cpu. In this case as well, the group’s 
CLOSID and RMID (rmid_en = 1)  both are used configure PLZA.

Actually, we should not allow these changes from 
global_assign_ctrl_inherit_mon_per_cpu  to 
global_assign_ctrl_assign_mon_per_cpu or visa versa.

This seems restrictive.

> 
> 
>> And if "info/kernel_mode_assignment" points to a different group
>> (for example, test//), then the kernel_mode_cpus/ and
>> kernel_mode_cpus_list files will be created only under the test//
>> group. Is that correct?
> 
> I expect that if "info/kernel_mode_assignment" exists then the group
> listed within contains kernel_mode_cpus and kernel_mode_cpuslist.
> How the group ends up in "info/kernel_mode_assignment" could result
> from mode change or from write by user space.
> 
Ack.

Thanks
Babu>

