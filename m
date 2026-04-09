Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011058.outbound.protection.outlook.com [40.107.208.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E563B29D291;
	Thu,  9 Apr 2026 18:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775757956; cv=fail; b=kE3HsCd7t7AtS77UFVsr//RBPT0YCGUFRo1WGQgsjIvMVvCgWYbHhg0ghe/+ZWt9MWzWT7Fcf3UxPOZlLp5oniQZZXsd8mbL9R0khUCZBSiwjis/88/qq863WiW6bJ5Q7+3330Ntcx26GhnIsNgPaUGY5X9toO/Vj9/96dpksWM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775757956; c=relaxed/simple;
	bh=1XilALrOWe4UtVzIU+VkTCVD4S6Vmc2n7FxQUtO9Erk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NJZMKpDXvhrjYhfJWwzWmA8/eh3Wh8TWY9BUs8fXaUaV5DF8ufb+8eygI+QG2QV8EKhw4788B8wTIkPwbUGJatzKHyuyPOhutzWB+XUvk7UuwDiCwj49Gmg5zdg6LVtFifaz2jJJKJmeP5eosu2eKLw6E1EsJL/849+gg31o9VY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=L1ep05iF; arc=fail smtp.client-ip=40.107.208.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="L1ep05iF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uPY9Yl8XQ12d4aSJZzSGR+yFvRM1eUWhPoPs8uEP7zU6z3fB3omQV5dDpgE9iormVZJmlxHSk6s6C4qhvOSO+HOCX3UXW/gSf6bqc6v3hXwL1jx4U1qhUhlPerzaMvP4hGIKl4ZJSPmON/pqGd9H7qusHKZubyl2PDx9OiwEpl6/0oNLYLwn9Ub1LlUuqSDcSYqbWM0N62Xg0SlyPwpkQKcOjIDeXVzAtx8r41veKDd4dWUjwqfpyk3njMAguj16rym5urlP1BxqSVBmyxbwbndOPvK/SInSobUnp/TlyGlCwcvULyurRZ4XNL/7tSi6rtARU0BVdZW4DJTE2UubNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2qRAQ6DhQ3pTXmwIN3Qsva3Tdz5dTGYwp5D8HEcq02U=;
 b=Z3LpX7f4/+RIUzTwyYnGFvxUBt9AfJiNBRWdBiIX5+DOnHNYs1pNCW5wSIpbQl6qLga48yDq/Nf+vnY8y8014+LOGj5rJnH096rbFcgAn8P6DH+RLSXxyrsPw7MhC4VNF7pbGgxT1L3gOclnhR7Oe6zGrigJ/8SF2X/2+o58blNJfkwudifVxmEZrwF3oOIBvHDDqe9C71BagDEWU/btuJmRQEgsW7YmxOxncRgiNL3GkSkSlLqll5fXRoyR60XHnZx9IrpXW0NpY5SUot6/aTU0ZvxH4LRn9Zi9GGJ75PV7+9H29QszRiAeV3KUkD9YtiqPiG/PzLrs5m4WnbyQQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2qRAQ6DhQ3pTXmwIN3Qsva3Tdz5dTGYwp5D8HEcq02U=;
 b=L1ep05iF9uVAZjjpOc3b8fZkDIpoVq1RNCbTSWZtnV0vDcQvIe1i0KK6i7crem4EyxAJ8rROuRnKIgOpGdVlbK5W+pY97XbNvp8Yhoj7/gQIrcnqPNK7lIQNI7PD/KveOTJlUxmSF8NCoLVsF6A/dWIZYjLY6/tXBCpbnOmuIrE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bdc) by MN2PR12MB4422.namprd12.prod.outlook.com
 (2603:10b6:208:265::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.42; Thu, 9 Apr
 2026 18:05:47 +0000
Received: from IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 ([fe80::e192:692b:abba:8c88]) by IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 ([fe80::e192:692b:abba:8c88%3]) with mapi id 15.20.9769.016; Thu, 9 Apr 2026
 18:05:46 +0000
Message-ID: <73c46024-4cf2-4f03-9268-d4378825fa87@amd.com>
Date: Thu, 9 Apr 2026 13:05:39 -0500
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
Content-Language: en-US
From: "Moger, Babu" <bmoger@amd.com>
In-Reply-To: <5a273b0f-8225-4e9e-924e-884183734659@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR11CA0137.namprd11.prod.outlook.com
 (2603:10b6:806:131::22) To IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bdc)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PPF9A76BB3A6:EE_|MN2PR12MB4422:EE_
X-MS-Office365-Filtering-Correlation-Id: eca96f7c-8169-4569-3715-08de96629f54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|921020|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	umhqQdhIe5Ftw4w3il4NQkjPsZAhVdGiRHh7CTFT9gPc8muZIb2p1rgYL1RjN1jDHoj1obPFkkcYW9VmR/4f355Egn2mbXIM2cT9UtSUD4EQgOR7xtyYT2sT/09u2TQS+nSW0pAaZ5E56zsh7D3yFuJ+cxoqRl9Jhb6v9CbDQyriLQq2ewLKqqvT1nNJEWb1YtU5YW5DYqXMQgbcY9NOFArN93UEu+zUxWB5kIE/Krcjhed56qDf7CDmhr4ef1diGwDrVKPkeLmON/m2DzT+Z0bqhxpQjUBeVwBVgsv+ybNQ4U0WOYvM75MWrUCqXXxvEYuDGmV8YqNnIanBLzTzfUu8idfQg8AP4G6+bns2pFnoASVomeawXpjw1rOSIGK8zVWqFbLwLwXPGPI/aeQxr7HerkziQobSZLveB91Vabjom9sGCO2nlX46Y5We419MJxe6ddlBQiuoxOBKHwbHhLLGo8G2Y3+7kmJlMqBHExzBklqsP/M6nEwSaaGmhinqm0hsSBUgSe2q/DLX7UXxHXxMD07G4S1SxU4qWbDFUJUmW/YCHJJp1ZM7hWNA3Dy1Dx1JYAej12uSGD5CdXfcYR8zpefH3T63myiNdLgu7OherByOKYs4hwIDb22zx/Rr8MFn3jTWWuB2DEuS1aLb8/crLz5jMcYA9Es6NAfh/vTeJt7NeDbOStTmFNWodR2JZ3Y2Ema92glfCKZME3oBuDHWlB+outBnpZ8UNVO7viLPX7yCm4tv/rnw9FyZgVBkciWO0880J5arAYBPWmuGyw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PPF9A76BB3A6.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(921020)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SDlsdHFidytoQ3NwNElFTEllQS94bWdxdmlEbVZtZzJNS1JmWjZKYU1hVDlF?=
 =?utf-8?B?aWJJdW9pNFBZUHhlY3FqRTQrR1RoY2lSL0FrdmpQWmNTQUQ3bS96R3pYc0or?=
 =?utf-8?B?bldsaGVvR1h6dit4cGZwdUg4RVNicnFMa0VCamZ1NXJhM25VOXRBUFZ4TWNt?=
 =?utf-8?B?VFBuRnhXMjEwYUpBK3dNakxoV3lsWU1reHVQZ0lhbmFpNHVIK01YS2lSSEhv?=
 =?utf-8?B?YzV5YkJnWFliek9zV212eCtyTkdyanEvUTNlYTNFaG5uVkpHVTY5b3lKSEw4?=
 =?utf-8?B?Wnh6aEJDeCtMcGc5cnF6dzVtRjhZN3JPYTh0NzBWTVpBSVNRQU9vdlI3Q25k?=
 =?utf-8?B?UTdZYjhCeUJYeGE3MXlyaWloSGNNbnZSTG9LYVhDeWR1dnFuSmw3UnVrMjIz?=
 =?utf-8?B?WjlualB5VGUyakxtb1U4enN3bklUcEpDeFZzM0p5alRTM1RkZmJqUS8rVjJo?=
 =?utf-8?B?UGZiaTJ6Z2dXQWNEOTBSQWpCWjlndXNwL3U4VHJpQ0lWSi9uL1RERXE3OUt4?=
 =?utf-8?B?Y1BrMXJpT2pTZ3lWQmUvTnY2OVRUTVh2b3VFcVhPb1ZlYlBBTTNpSlc3ZTFh?=
 =?utf-8?B?eW5wQXpyL3ZnVVFTeVZrTGhlVCszeUkvSzhZd1IrV2J6bml4bHdrcWxqWU9o?=
 =?utf-8?B?RFhNV3pMVTN5eUxheVlJaGFXVno2OU5tZ0lRNUg3eGo5TFp1ejg5RGxSWkt2?=
 =?utf-8?B?YnZuMVVJdEdIT3JLalhNQm5pOFFCNEY2VDRSZFpLd3hJOHVUc1huN3RkZDJQ?=
 =?utf-8?B?bk1kZ2N2RlphdHdUVjdSWW1CbHMzWlNiZnVNaXhLUG9kVVUyQmxKYXNpRkhu?=
 =?utf-8?B?bEZmWWtVQS9TT1Fnd1lOU0pObGtHclNIZE9MdzdlMW0xVUs0TUdybFZLTnJS?=
 =?utf-8?B?UG1TekgzVHV1VTZiSWFkekFSVHJ5N2RaWHlyRVBuWi92ZUNvbEhzd2dlYzc4?=
 =?utf-8?B?R1ZSUTdrcUE1REg1U0FlL0xHdy8xUlF3bk85R3ZIdFRhNUViTUdCQ1NaN21y?=
 =?utf-8?B?Q2hVb2RrNE1UZVRTakRwV09TNU5RL3lrV3kxVVpvcW1lNHpMdDBoSTEyYWhU?=
 =?utf-8?B?U1M5S0xLd0RlS2hUSUt3aFVGT0RvKy9WT2h0VWhEc0JKTkhOVFRnclp0K1ZP?=
 =?utf-8?B?THc2b0Y0emtKZEVPcWxiTEJyNzlET3hXZ0VGL2UvSm9RRXJzUW1WaitXelpB?=
 =?utf-8?B?QXZGanNVVFk5THdWbkNnNlhxeFFWNFhLQVM1MUhrQW1tV0hudEsyZ3Z3V2Nt?=
 =?utf-8?B?aHhHWkxyN0wzVmNpeTJDOGtxUlRETndsVzNXelhzL2tLSng4L2dkZDV6ZlQ5?=
 =?utf-8?B?WlhBb2JYdVJwNno0RnpMcTJqb0RrS0RNQndIcHAzTXJHSEhZYjdOU3owRXJ0?=
 =?utf-8?B?UkNwTE9RSFh4N2kxUHNiamFzSkorTU1sWHBLZ3Y3VHVuVWoxUkN3S09VN1lZ?=
 =?utf-8?B?c1MvME1KZTJocFBnQkZOV042VEZnaDhBRTJMWFplMVo5cGJuUGNEL2R5QWxL?=
 =?utf-8?B?YUxuRzViMnVkaVFtUk1rQmxPZ2pyRGtoMWorZkNtbnZwRXJTMEFkd2lpMkJF?=
 =?utf-8?B?ajFSSm54R0lTbm5PZjVqRnJTUzRiQ3d1YlVudFU3ZFZ6Y3NEYk5Ka2x1dWJJ?=
 =?utf-8?B?WERkb1YvOXZWRkVnV0dtS2ZwdS8yZGNLYWhnaEwvazJBbzdrUFE2RytiU2VY?=
 =?utf-8?B?dlYyNU9LK1RMUHVSTkpKWWRZRWNQMzlPeWRnNjBXZEdyeWVEVXhYY0lwblY0?=
 =?utf-8?B?ZUE3ZDlYUGxJWUd6MFdQcFpFYlhIWHRzNTlZaVFVc05LQldlak16T1d5clcy?=
 =?utf-8?B?SHcyTTRIWDVSdVFSamIzWDdjbjRuSjFSSzlHeTRYN1hqVHZ4Z1Q3VFBacCsr?=
 =?utf-8?B?SlJTYlRVWGNnZlJzMW1FT1g3T1piZDZiVUhlT0VUMzN3Umo3T1ZDVzZsMU5C?=
 =?utf-8?B?VGYxVngrQmtQdGdOamo4NVRRTUdaRTlsQVJKT09tQ054YzRqNUxoYUhVdWtC?=
 =?utf-8?B?cDJhamlGdm45OTJDTzJyVUc4VzB5bXR2NTJPWStXc0luQzljcG02S3YrUUNV?=
 =?utf-8?B?WkV0NTcyWDJRUFErY0dmaHhtbTdtUEFvKzV4dVZQUEFnUHl6UWtreUVaWGhZ?=
 =?utf-8?B?T1dkSDd0UytSZUVxRXczYjBwSFBkOFFZY0dma2QxbkJsTWJnVkRMNzdRRVA3?=
 =?utf-8?B?akJVdDk5OGNiTVFldFpheHZKam1relMyNk1zVGYyRGUxVWV3TjBKVXVqR3p3?=
 =?utf-8?B?OXBPTWx5Nlp5OEpIWkV0ZUM0MnhZeC9jWGRpK1YzYlJLd0RHbnQyLytoYVRN?=
 =?utf-8?Q?u0O2j7TAD1+WgfQxbg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eca96f7c-8169-4569-3715-08de96629f54
X-MS-Exchange-CrossTenant-AuthSource: IA0PPF9A76BB3A6.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 18:05:45.9525
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ytf/gjy9QnLpCyVXodlOilOVoL6LSEnfsxuQfGdlUbyTzf2c3cafTBIAMBuMLcqc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4422

Hi Reinette,

On 4/9/2026 12:26 PM, Reinette Chatre wrote:
> 
> Hi Babu,
> 
> On 4/9/26 10:19 AM, Moger, Babu wrote:
>> On 4/8/2026 6:41 PM, Reinette Chatre wrote:
> 
>>> When the user switches to either "global_assign_ctrl_inherit_mon_per_cpu" or
>>> 'global_assign_ctrl_assign_mon_per_cpu" then "info/kernel_mode_assignment" is created
>>> (or made visible to user space) and is expected to point to default group.
>>> User can change the group using "info/kernel_mode_assignment" at this point.
>>>
>>> If the current scenario is below ...
>>>      # cat info/kernel_mode
>>>      [global_assign_ctrl_inherit_mon_per_cpu]
>>>      inherit_ctrl_and_mon
>>>      global_assign_ctrl_assign_mon_per_cpu
>>>
>>> ... then "info/kernel_mode_assignment" will exist but what it should contain if
>>> user switches mode at this point may be up for discussion.
>>>
>>> option 1)
>>> When user switches mode to "global_assign_ctrl_assign_mon_per_cpu" then
>>> the resource group in "info/kernel_mode_assignment" is reset to the
>>> default group and all CPUs PLZA state reset to match. The kernel_mode_cpus
>>> and kernel_mode_cpuslist files become visible in default resource group
>>> and they contain "all online CPUs".
>>>
>>> option 2)
>>> When user switches mode to "global_assign_ctrl_assign_mon_per_cpu" then
>>> the resource group in "info/kernel_mode_assignment" is kept and all
>>> CPUs PLZA state set to match it while also keeping the current
>>> values of that resource group's kernel_mode_cpus and kernel_mode_cpuslist
>>> files.
>>>
>>> I am leaning towards "option 1" to keep it consistent with a switch from
>>> "inherit_ctrl_and_mon" and being deterministic about how a mode is started with
>>
>> Yes. The "option 1" seems appropriate.
>>
>>> a clean slate. What are your thoughts? What would be use case where a user would
>>> want to switch between "global_assign_ctrl_inherit_mon_per_cpu" and
>>> "global_assign_ctrl_assign_mon_per_cpu" to just switch rmid_en on and off?
>>
>>
>> This is a bit tricky.
>>
>> Currently, our requirement is to have a CTRL_MON group for
>> global_assign_ctrl_inherit_mon_per_cpu. In this scenario, we use the
>> group’s CLOSID for PLZA configuration, and RMID is not used (rmid_en
>> = 0) when setting up PLZA.
>>
>> Our requirement is also to have a CTRL_MON/MON group for
>> global_assign_ctrl_assign_mon_per_cpu. In this case as well, the
>> group’s CLOSID and RMID (rmid_en = 1)  both are used configure PLZA.
> 
> ah, right. Good catch.
> 
>>
>> Actually, we should not allow these changes from
>> global_assign_ctrl_inherit_mon_per_cpu  to
>> global_assign_ctrl_assign_mon_per_cpu or visa versa.
> 
> resctrl could allow it but as part of the switch it resets the "kernel mode group" to
> be the default group every time? This would be the "option 1" above.

Other options.

Allow global_assign_ctrl_inherit_mon_per_cpu -> 
global_assign_ctrl_assign_mon_per_cpu. As part of the switch, reset the 
"kernel mode group" to the default group.

Allow global_assign_ctrl_assign_mon_per_cpu -> 
global_assign_ctrl_inherit_mon_per_cpu. In this case switch
to CTRL_MON/MON -> CTRL_MON.

Thanks
Babu



> 
> Reinette
> 
> 

