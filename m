Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010032.outbound.protection.outlook.com [52.101.61.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7EC43630B5;
	Fri, 10 Apr 2026 22:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775861567; cv=fail; b=WINKUEQQfzVTTq0vCNxjR5WABj0w1z2yLpu0bKTv21ImCxjoExBS+ZpwRIWX/Cp9oKY7D2qQKkOIM3yic8QmdLJcWLe5p08Dk9+P8h+1/SwiERRvxeF3B2E6X/+masXuhNqliW4dZWxI0sX3xrYh9DEHM0llZkyqyZjbWu6khV8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775861567; c=relaxed/simple;
	bh=X+h8WEnM6Nb1y6bKAq8+1f3uxDrM98q7lJrzNIesORM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Sh/ZSMqAJHVkFxjpH6bcZzImkvagnT25ZDunAfcdRwb5i/88mIpYrGdGDDp4uS4md3O9UK3rpYAbDl8I2YZU/mzRjUDuotzdWOf/itBJdHjer8PYmGMPiWcVj9PlEdhSyzQ7enFTVu+FRgcbE6TyPDCqsgmF1EQczhiPYw8SNBA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=TD3ttEPv; arc=fail smtp.client-ip=52.101.61.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="TD3ttEPv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bwNkNdOtaUkQzQPlXYyL7i0EuA6sLerusfROIsPUDS+hR1Wm5hIoN+YHVTYcxNwR3aSq61KFhayLTDu/OMmTUt+m6TTasXIvy0xoMnpGl7Q84zHa2wQuIQkdmSbGjOAHIUZ3JcoQI6fHZ43HCXvZkUkf4kgV00qwo0298pOkL8PQACxETD8Q58Uee9xtVOQDGAamZfFnJgLAyXnehOh8gb+PwedzF/5frK8DF2n84Hj5rcFhx7kIZA6IaZh7y4hvWNDOMq2bjBvUf7XRWowZhgK9hC0K+UmK505rq8Q031KWAUPeTnxZO5i55avTk9VXOW95WLQ2RSFCMNQQwmOvXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8psJPdhMvpu7B57j/BvfP9j1omdd3aanwAqazKZQ0u0=;
 b=PMXoTdyS7kUAgq2QxHZUmCTJS0WoGGfiiovqVOXe5+dCvmCNd1EI2nolw7eFn3Zw48+mbk27y9vPCzx7zrhUP2PsccrwjlM+G+pDPzYbQbcjqP67mkpJVox/Jdz9/z4lMi8uKINIRMTVmdcC9nKAMczCD/qKA6tAEF5OW2nCtkUHp2G9QIeV/vasBayVxzA3DsVn4fp/QZSqV4COX9bwEozf6O59YECTSNz0o+Ki250Y2RNrdX4JOxCWdzg5Sy7n4aWn0qNIVg6/5s9MB/D2eyB8+hpDVin3yl5Ue5P7WsRRjM39PBe8tGcpIAQhgdVf7TPsVodoTCFEdX4u/apOLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8psJPdhMvpu7B57j/BvfP9j1omdd3aanwAqazKZQ0u0=;
 b=TD3ttEPvNGW+cjsRTdIzSvKIAomOUCWy+g5vZQEd6qgUCVeca+akUld3OopQIMBwjnJZ27xxgs+dXR2/m6EKB6uGZyXy0EHL7EXke177XrHWUktJicKmF8DRuZnJycZdPmCyucsjncFlsyuugJuKqB3b09c5Pa73+FVP9xAQfo8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bdc) by PH0PR12MB8050.namprd12.prod.outlook.com
 (2603:10b6:510:26e::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.44; Fri, 10 Apr
 2026 22:52:40 +0000
Received: from IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 ([fe80::e192:692b:abba:8c88]) by IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 ([fe80::e192:692b:abba:8c88%3]) with mapi id 15.20.9769.016; Fri, 10 Apr 2026
 22:52:40 +0000
Message-ID: <57ffcf0e-a59b-4069-86b1-88bea6554028@amd.com>
Date: Fri, 10 Apr 2026 17:52:34 -0500
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
 <bb9f62f1-0c79-4d29-9866-c39d08c3a774@amd.com>
 <5a273b0f-8225-4e9e-924e-884183734659@intel.com>
 <73c46024-4cf2-4f03-9268-d4378825fa87@amd.com>
 <973067bf-6e6c-446a-a81a-713840d701a9@intel.com>
 <90f4a692-1c27-4967-bf12-ec3cb597681d@amd.com>
 <68a551ea-d9f0-436a-9bef-e35fd027bb95@intel.com>
Content-Language: en-US
From: "Moger, Babu" <bmoger@amd.com>
In-Reply-To: <68a551ea-d9f0-436a-9bef-e35fd027bb95@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN6PR2101CA0012.namprd21.prod.outlook.com
 (2603:10b6:805:106::22) To IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bdc)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PPF9A76BB3A6:EE_|PH0PR12MB8050:EE_
X-MS-Office365-Filtering-Correlation-Id: 816b4027-e6d4-432f-84a5-08de9753de07
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|22082099003|18002099003|56012099003|921020;
X-Microsoft-Antispam-Message-Info:
	T/JuaWA8z26K1lvC6Jrjf22lJIIPk9SAPKs3gYyXOD0agjcJOaiKaH18MwMAdC5nYnKLUmDyfpQTVFVH34osC5U5GhofgKzWcHA8m3B1Xiw1fclqj5Tz56zdZzChfTRcwVBKBdTQna8HWFZA09w0tnYvIsHdlfu6/n8TjJ+NCfO8wAUUzOpb7q8E0ydkKPBySkT5XNpnvb+QVKGGUY6ljF7yqjW7nNZddqxoLgmzuA6Jlp9tPQkl9zvKSkQtKjBYnlovVyyNLi0y5wDe23W1CW9kPpX/ZraBDyl0k8NmZjV9x3Orw/sInOzMoF1j3M1ZSFkvRDgeJleLNlOfvdFTdx6HsGjLxl4nLhYR1Dk8/Q+y8qnjjyY4I5ZcaDVVpC4N+vd6xc6w0OTyW6JrbTsG8nA0nsjUPY81cGgkeou7l5yLN83NMKTltPu14k6GU7+khXEuEIyip2wVXPk1K2RkKsnONjZnPVqbCrsQ2KKb9kyauahxSCW1QrzM3tRyZFgIlRaZrHWX65cDpDw5Llmu5GsDCowkFE5C5vzAWriIyaFcRPuTGi6PbqPNSEIfgBHKDN6ar5j6wVO4S4dYSVhYqhcl1X+VjbGZ8BI6V+OWvEYDn0grrMgvWFxIclDyleMJPhSOCmpLtP6dmbqIaVBrUHcWqnczGj28hujyTt9wFqI4RheR0B/UuUA3Be37g9ULfrtwifR/djrj8lMYBOVdkjHD5UeG0XZMraQg3zoxfzE9XXsVx/WTkIsHT+qZ2TH78cTVRhS/47qgD/9jC6CHEw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PPF9A76BB3A6.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(22082099003)(18002099003)(56012099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aHhJT0xsRGl1dEYxdHhjR1ljYVgzSHZ2YnFNdHF6c1lnYjFKMVl4b2dPOU40?=
 =?utf-8?B?VklDOHU0SmJzNTNYS3RPYmlBaTl3MEVqajRlTTRyWnk5UnZFY2F5MEtsZE5J?=
 =?utf-8?B?YlBYYWpDdzAvVThReTJ0OEZpSFV4MmNmd3RtbU8xQWpIMThpWjJCZkRXS1BN?=
 =?utf-8?B?eFVoSVlydU12ejlmbG1Pc2VuN0YxQ2pCYVpEQXpaTENSRGZTTEtKMDhqbzB1?=
 =?utf-8?B?d2FTb1Y1RTRWd1hBMHV4OU51SEMzN2xpelJJVFdGQys1dkJQbGI2bnBPNkFo?=
 =?utf-8?B?c3hoaTNRbkp1STc2RzZabFVqOUt3Sk9Wd2tTNzA5ZlpiZnpNb0RRRXB0ZFZD?=
 =?utf-8?B?YTJqMWpIWFRtMXFzMEdNclZDblFYTmJhOHNLOFU1RzBIMDQ0c2Rqb0RPS0l4?=
 =?utf-8?B?RkpWeE5IL0s0eUVxWnBrQkxsK3JCYzRacHFtNUFadVIvSTBYMWdQb3EzbVRO?=
 =?utf-8?B?bkNCR0oyUnNHRkpPWnJZRjMybWdhejJ6Q2Qyd3pMM2pRY2VUQ0RYc1EzSUto?=
 =?utf-8?B?NWxDM2JqMElUSUM2cVF0dEZrajR0Tloxc0ZuOEgxR0ZLVWJXR0UydVgvNzVv?=
 =?utf-8?B?Z1IvWTFXYUFhRit6eWRlRk42VTlGQnI3RjFUUHF0dEd2TVpJLzQrRVdYc2h1?=
 =?utf-8?B?elBLTXpVUmFxWk13NFBGWmxlVGZzY1hqd01uTC9Pa3pkT25mclJPZ3VseU1O?=
 =?utf-8?B?bGZDZXU0Vi9lOXpwalJhUktiSmtOaE85eXEzN1c5WG5XYklEd1pMcVRicWU2?=
 =?utf-8?B?cDRPaTZhaGpqOTN5Q3M5dTJROWpZSU42UHFETmxrdmJJeXdjSWNLZ21BRlNY?=
 =?utf-8?B?amNjS3ZPYmRYNmtnQmxZdER4WFBCMWRDdWIvSkJIc3FSWEJnYU12OVdUM2xi?=
 =?utf-8?B?YjBjRldnekJZdDZQZkpJdUdoVlBBT0tRdlpobUU5ZVJ6elIzVkJQemRoZE03?=
 =?utf-8?B?YTg2WW1abmRpVlVUMmJlaW1HbldOVEJsek8rZmNLTGR4cFduT3o3YmVSbGFz?=
 =?utf-8?B?OFBVNXAySDlxRGw1c0JneGdXRGtsWWF2ZnNURG5lVWFscjhRZFNuMWNLbnJL?=
 =?utf-8?B?dFoyVWlIdWlzZWVSMHEzUDRuLzlSeUg0SSs4YmZqVG5nb29CR0lucm8rRDJW?=
 =?utf-8?B?RHNITmgzRzlMWFlKa0wwdzFJT3FQbjhzRVlITkZZczlBZURwbzZyQ3VHNGZE?=
 =?utf-8?B?OGNxeWVUOGk1OUVVeWZ3SEtobjlqTm9hOHh5dzFmMmR6UG9zNFZDU1g5U0Np?=
 =?utf-8?B?cGJoTkJQNTROb04yNFRaNGFMbGd2dWRVMVZRUmZnUU9hTCtoa3UybWhNU1pl?=
 =?utf-8?B?anNVZlFlVkxkdlRVTFZqYlpmcHdnQ1dpZDBGZnBkVkZ5SUgzTWxmUVlLWmNh?=
 =?utf-8?B?ZWNydVk1bUNaWFZrZkVkSXl4Q1NyUXp6ME9hUUsxQUNwam5SK3R6NmU4eFll?=
 =?utf-8?B?MkVXU014UUFtWlZRb2JRQWxZbmtVQ3gzMmMxYXA3ZW1MTGdsRGVFQjdjcmxV?=
 =?utf-8?B?Nkl2OGpSOVpqTjlGckRuRi9rVVUwTzloeVdzWmZZd2tKMnlVTlpIZHdhRTNm?=
 =?utf-8?B?NnFPcWZxeDZuV21PUkcrTzFna1BxU1Brd05qNjIwR0xhdTY3TmRnazhMMXVR?=
 =?utf-8?B?UEkrUWFuWXZSanJqb2lnN3I4dnhGcE9UNGpOb0ExRVQ1UGM5VHo4WlNhUlVJ?=
 =?utf-8?B?TWNFRzF5ZFRnYjE1RUVCalBMR0NtcWw4dlNIdkdJWWlma09BMmR6cEZLbUw3?=
 =?utf-8?B?WkpBWXcwUFdkY3gydmJuNFgyMVFwTGNmakxtMGMwOVgxOThSQlREZTdkYzN2?=
 =?utf-8?B?RWthbGtVa0J4amp5djNHenFYMUxmTGI2YzlkMHozN0IvanpHWlpQZGZqT0xO?=
 =?utf-8?B?eVJtQnJzbVEvTHBOR1RNTUVqdWhPSVFJbGV0ZmxKdm82NHZoQWMyd0JqOHNt?=
 =?utf-8?B?Sy93MUg0Z3dvMUpQYW5mM3IzRkhuQlhSS05OZWVLbHB6dVM1RVE1Y081OGlU?=
 =?utf-8?B?MFNLdG51NGNMOFZTL2MrdnpsRXF6WExjKys5eHUrYU1Sazl6eDBUKzFUdkZC?=
 =?utf-8?B?dWcxQ1VrUkk0MGNSWTFYYWo2T1VRbTRTMElPMlZ4V0JjVjFGaFlFMHdJMW9v?=
 =?utf-8?B?by9oL1RaOVdqZTYvRHBwd0l0My94eWNJQXpQb1grZnBHU2I2QVl3SzVWQzhX?=
 =?utf-8?B?ck12QnpjQXYySCthQVkrRFlMSmRmNHNoR0l3TjdmajJsbllnS0ladjhGelJ3?=
 =?utf-8?B?WjkxbTFxRCtwWW5oYnpTNEg0cWdiR0N2VHhQVnkrdHQ3V0poK0hldmpUZ0pY?=
 =?utf-8?Q?8Kc0GKU1zzYmhVajlU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 816b4027-e6d4-432f-84a5-08de9753de07
X-MS-Exchange-CrossTenant-AuthSource: IA0PPF9A76BB3A6.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2026 22:52:39.8761
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JQKfSv2JNWB+rucjWeQ9loId1YgWhj0pnh1m9LAJ7Z5XTKO/b7XJX/f4Jvd+s1sO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8050

Hi Reinette,

On 4/9/2026 10:41 PM, Reinette Chatre wrote:
> Hi Babu,
> 
> On 4/9/26 4:42 PM, Moger, Babu wrote:
>> Hi Reinette,
>>
>> On 4/9/2026 3:50 PM, Reinette Chatre wrote:
>>> Hi Babu,
>>>
>>> On 4/9/26 11:05 AM, Moger, Babu wrote:
>>>> On 4/9/2026 12:26 PM, Reinette Chatre wrote:
>>>>> On 4/9/26 10:19 AM, Moger, Babu wrote:
>>>>>> On 4/8/2026 6:41 PM, Reinette Chatre wrote:
>>>>>
>>>>>>> When the user switches to either "global_assign_ctrl_inherit_mon_per_cpu" or
>>>>>>> 'global_assign_ctrl_assign_mon_per_cpu" then "info/kernel_mode_assignment" is created
>>>>>>> (or made visible to user space) and is expected to point to default group.
>>>>>>> User can change the group using "info/kernel_mode_assignment" at this point.
>>>>>>>
>>>>>>> If the current scenario is below ...
>>>>>>>        # cat info/kernel_mode
>>>>>>>        [global_assign_ctrl_inherit_mon_per_cpu]
>>>>>>>        inherit_ctrl_and_mon
>>>>>>>        global_assign_ctrl_assign_mon_per_cpu
>>>>>>>
>>>>>>> ... then "info/kernel_mode_assignment" will exist but what it should contain if
>>>>>>> user switches mode at this point may be up for discussion.
>>>>>>>
>>>>>>> option 1)
>>>>>>> When user switches mode to "global_assign_ctrl_assign_mon_per_cpu" then
>>>>>>> the resource group in "info/kernel_mode_assignment" is reset to the
>>>>>>> default group and all CPUs PLZA state reset to match. The kernel_mode_cpus
>>>>>>> and kernel_mode_cpuslist files become visible in default resource group
>>>>>>> and they contain "all online CPUs".
>>>>>>>
>>>>>>> option 2)
>>>>>>> When user switches mode to "global_assign_ctrl_assign_mon_per_cpu" then
>>>>>>> the resource group in "info/kernel_mode_assignment" is kept and all
>>>>>>> CPUs PLZA state set to match it while also keeping the current
>>>>>>> values of that resource group's kernel_mode_cpus and kernel_mode_cpuslist
>>>>>>> files.
>>>>>>>
>>>>>>> I am leaning towards "option 1" to keep it consistent with a switch from
>>>>>>> "inherit_ctrl_and_mon" and being deterministic about how a mode is started with
>>>>>>
>>>>>> Yes. The "option 1" seems appropriate.
>>>>>>
>>>>>>> a clean slate. What are your thoughts? What would be use case where a user would
>>>>>>> want to switch between "global_assign_ctrl_inherit_mon_per_cpu" and
>>>>>>> "global_assign_ctrl_assign_mon_per_cpu" to just switch rmid_en on and off?
>>>>>>
>>>>>>
>>>>>> This is a bit tricky.
>>>>>>
>>>>>> Currently, our requirement is to have a CTRL_MON group for
>>>>>> global_assign_ctrl_inherit_mon_per_cpu. In this scenario, we use the
>>>>>> group’s CLOSID for PLZA configuration, and RMID is not used (rmid_en
>>>>>> = 0) when setting up PLZA.
>>>>>>
>>>>>> Our requirement is also to have a CTRL_MON/MON group for
>>>>>> global_assign_ctrl_assign_mon_per_cpu. In this case as well, the
>>>>>> group’s CLOSID and RMID (rmid_en = 1)  both are used configure PLZA.
>>>>>
>>>>> ah, right. Good catch.
>>>>>
>>>>>>
>>>>>> Actually, we should not allow these changes from
>>>>>> global_assign_ctrl_inherit_mon_per_cpu  to
>>>>>> global_assign_ctrl_assign_mon_per_cpu or visa versa.
>>>>>
>>>>> resctrl could allow it but as part of the switch it resets the "kernel mode group" to
>>>>> be the default group every time? This would be the "option 1" above.
>>>>
>>>> Other options.
>>>>
>>>> Allow global_assign_ctrl_inherit_mon_per_cpu -> global_assign_ctrl_assign_mon_per_cpu. As part of the switch, reset the "kernel mode group" to the default group.
>>>>
>>>> Allow global_assign_ctrl_assign_mon_per_cpu -> global_assign_ctrl_inherit_mon_per_cpu. In this case switch
>>>> to CTRL_MON/MON -> CTRL_MON.
>>>>
>>>
>>> ok. Could you please return the courtesy of providing feedback on the
>>> suggestion you are responding to and also include the motivation why your
>>> suggestion is the better option?
>>
>> Yea. Sure.
>>
>> We need to allow the switch between the modes. Otherwise only way to reset is to remount the resctrl filesystem. That is not a good option.
>>
>> Allow global_assign_ctrl_inherit_mon_per_cpu -> global_assign_ctrl_assign_mon_per_cpu. As part of the switch, reset the "kernel mode group" to the default group.
>>
>> This option is same as you suggested.
>>
>> Allow global_assign_ctrl_assign_mon_per_cpu -> global_assign_ctrl_inherit_mon_per_cpu. In this case switch
>> to CTRL_MON/MON -> CTRL_MON. This option basically disables monitor (rmid_en=0). It is less disruptive. Move is between child group to parent group.
> 
> ok. I am concerned that this creates an inconsistent interface. Specifically, sometimes
> when switching the mode the kernel group will reset and sometimes it won't. This inconsistency
> may be more apparent when writing the user documentation as part of this work. If you are
> able to clearly explain how this resctrl fs interface behaves (this cannot be about PLZA
> internals as above) then this could work.
> 

Yes, certainly. I’ll begin work on v3, and we can continue refining it 
as we move forward.

Thanks
Babu
