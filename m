Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012035.outbound.protection.outlook.com [52.101.43.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E0F2FFDC4;
	Wed,  8 Apr 2026 20:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775681153; cv=fail; b=McRxKE6wRMIJLJlCJp3pwTvat4SbGdQkk9coZRPO5ORGphpLSPoyzcjU04lUT4ip5HF06ovcR2dDWmKnIfQ8fxfdxwDAukL/nzcqt588luqa4uwfwbck3axmVpG/reN7my2Spt6f7n9GsE8j7osz7foM1ovVhoEIHtfsWS0qmKU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775681153; c=relaxed/simple;
	bh=ruG3mluU7jI9QayliMZfv2PMvjd2WJdU1IG8NBeSTwI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=f/qy7CHfftjWz/+N9Yc6gB+t/g/kZB52dUVnUpR9DrNti8H7AkkWb8AnGg10Te+BUJTpp0i+oNC68VSqy+n6+ZijrwTngPS+r+1xyK3rHiu7n3PM8fnRVJYI6a2XQlx/fAEKkCvtaAd8Bq961w7MRxmkQRWWwrMAzgd5MWdfBfk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4K+PKy52; arc=fail smtp.client-ip=52.101.43.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4K+PKy52"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NK1V54JItscRhvRDx/jVwI0JKYjBnRltlZN4FJ3XEXgVEQH1ZDJTJc7Wbiz1mFmzS50wJXSUwo5ONlsR2HHhDYzszrh1Vk/pgo/35LaVTKzmjhMusdPodODkhF/SWYbxIQX0LWmsB8cpoQwRSd/kSysNiZMKy6BqVVmwo1nhpYUYgWJwvcvfSA5DNA+rju8u2E7MMlohSt8gaFNC5SVxlqfxTkBJ+raujR3QDslElemNRsbZxyNC29a4vhKCLRM79RsGEcJzp/n4hv2nWbtPK9yG0tMh86WWLZVc8SjRX8FEKBQfBeH2pF03JLI2Xv1aTy3i3TilxPMtZxC0L3E42g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=orkL/CkIGYnVeHExZr3rU6HWYrD62X9XvSffkOk4s/E=;
 b=raejhD4Bt9AEzsnORpDB8wNjr2mV1kNwQthjphZ0vQfMkdYeTYAXkM+mF1iclqwqbbiXeaqwD9f13G7JDP3IfxcxLXh6rWdqWumKNJTod3bVgPdoRGY7irQvOTKYpcFH8QSH5aLdRbQDnDWajE+1CDKjCJXgTtapUi9f7/toT2gTWrqah+5/i5jR54jVTf5IpYt6AZn6GfQTs9tYGhpd5ZcgwxZJzCtSk9r7qst0/FnFU8f+NeULQuUXQGBXZDBsAIowftv9obdnSrpP26gTtZVXfyXEAdjicvh91yog1uN6bzHy5aCV4ypVyteysVhdo5ugzIDZ+INHIEMk8s3h4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=orkL/CkIGYnVeHExZr3rU6HWYrD62X9XvSffkOk4s/E=;
 b=4K+PKy52UmMlSNpwnafRmZaVgZbG02/bbYGsscZ1I+30kk3irGviXRHnC5Nt998vyrNKptp+83aieHIc4QHeDl/PcxzXX39hqD5QbfOk7vBNNgQiv8eye4ZGxG+LuqLLtcuPN1NMSuxnxJycF4yNkdccBKWLAAzOkoZfLhbSj78=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bdc) by MN0PR12MB6004.namprd12.prod.outlook.com
 (2603:10b6:208:380::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Wed, 8 Apr
 2026 20:45:47 +0000
Received: from IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 ([fe80::e192:692b:abba:8c88]) by IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 ([fe80::e192:692b:abba:8c88%3]) with mapi id 15.20.9769.016; Wed, 8 Apr 2026
 20:45:47 +0000
Message-ID: <0ae2b267-4527-4251-9136-6afdc3fc97a5@amd.com>
Date: Wed, 8 Apr 2026 15:45:43 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/16] fs,x86/resctrl: Add kernel-mode (e.g., PLZA)
 support to the resctrl subsystem
To: Reinette Chatre <reinette.chatre@intel.com>,
 "corbet@lwn.net" <corbet@lwn.net>, "tony.luck@intel.com"
 <tony.luck@intel.com>, "Dave.Martin@arm.com" <Dave.Martin@arm.com>,
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
Content-Language: en-US
From: Babu Moger <babu.moger@amd.com>
In-Reply-To: <efc269f8-bf98-4f12-8d76-1fee564be84c@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR04CA0065.namprd04.prod.outlook.com
 (2603:10b6:610:74::10) To IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bdc)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PPF9A76BB3A6:EE_|MN0PR12MB6004:EE_
X-MS-Office365-Filtering-Correlation-Id: e27f5800-17cd-47c2-4add-08de95afcfb5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	mxQblHj6lQJyi33FoByocYA99AMe9Yy0we+8ZjOIjXQPjBhHHCgZBjyEV55aehEV4kec7pyhlJJfUKAWILpAfSarXLoFOc3rBSAkgJzo6eT42uo0m7LhADZi6wy+u7IXQ4fvGA48/2U2+cQG9VE6KfQ1nVlbUh51Q9CnD7tPBPx8UBPepu3tOSqDxweYJLF3tgeF60M8ZjOEhTnxovV4Mwhtu7aL/pd/ByIP46/oDdqAq89SLDJaO0ikBg+N+5gzm3ehDvdjxPHJHeQMOrIP7dMOK5V9ZeTmTYWkh9+Co3ChRwBgrEoMXnBjyX6K6VdQ/LQap+QSf9DIAETurQJBAn8vm98lEHqCobCzShwlWTjto764EdrE76BdvtyRPTJ50DPwWYF/XYd9sx25LVuC/qmrbGsFhYvPWNdpAa1udhj/e4w9cmdm5WBQosr74tA4Gh/Pkh8V3HW+fZTrE/BfIK9c+W0pYvQCxllGM38oODfgcj2jS3GxSEYstnF4mLoKPAlkixPxx2uFMFSkURpMtVBu2mU3CFB/iVR0Pk1cK2hJbHWJGhwYUFFeLV7/ibEEHaRnMVoziCaI8U8YnELnvB3jSURaNHR/0dzoTicbJyv1sVEycUBDkqyo/sfWCGTXpu6ZS0aC97INd6znUt//fIPh3c6JyGzVUojt8yvCHJx7u2jRrIXQ2zES7xacBG8qEVRy5ZksO6NWOra1OwUJgg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PPF9A76BB3A6.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N3FQbkgyYzZtU2JDekdCaXZ5dHRLUk0vTzZxQTVzYVlaMkNHVlBXMmxJQ1Nh?=
 =?utf-8?B?T0dSOWU4OFV0TVVVcXJPcHB0bkIwNjVoSFVtOHRzdHA4TFJlN2NqZnl3cHBM?=
 =?utf-8?B?cGFFV2lIQU5Gc1o4SlFXdjV1SHZqcXZ0RGJYWmZKVFdQeG9hZzNKQWtYRUFr?=
 =?utf-8?B?aC9yWDF3ZVBnR2N0aEQxU1ZqUDh5Y09qV0dyaHA4cEJQeloySnE0SnVNVyty?=
 =?utf-8?B?S1dmTGVCaFlWY0NoTXExcGRqWFJpbk1uOG5xMTEzYkdua1VRa3dxdFZrK1NW?=
 =?utf-8?B?M09iMTdiaGNuK0Z1emo0dEI2TUpOcE5ZVjVTVjN5T2x6RTBYSUc1U2dkZEJF?=
 =?utf-8?B?SThvRi83Tm1yNS9vaGVhdUh2WlYyT2w3alhRaE52VzlWUkozM2VSK1RXenVx?=
 =?utf-8?B?VXo1VVpheGRJSHdsWkVROUFIejVSWjc0enp3dk9FcG1ZRzJPRS8xSlNCS2Vi?=
 =?utf-8?B?ZkJoUUp4OTZZRWNyVmZiUGt2cWRqMnpxbjRBdXFPOVM1NjM3Y1hnMnJlTStM?=
 =?utf-8?B?M1ZNck12SmsyNlhxRENKNDI0b1ZRVzh1elBNZmVFNkwyUVFPRDlEZHNVSUxK?=
 =?utf-8?B?QnVUQkt5ZnZ3eGpnT3FpOCtOL005ZEV3S0creWtHc1l2QTFTQjZMWjRua1E0?=
 =?utf-8?B?UEJPNG1iTjNQMzRhVXhvZ2IzbWZYN1E5TlN2TTUybFhKYVB3U2Y4S1RKdTNs?=
 =?utf-8?B?V3Q1WEZWb1JPOWtYMnA2VmcxdnFMZTRRTDV4YUlJTmRtc1FRQzQwN2lEb2FU?=
 =?utf-8?B?bERvRU5FZUtyOFNyZnZ2dTVVR3dxOXQ5ZVZaT2c2ZzlwVE14cmt6dHYzTHoz?=
 =?utf-8?B?Y2J6ekpROUY3ZFl3RmRCVUU3VTRuQ0t1Ykpqb0dCaGhpWER6TGNzSXRRSXVx?=
 =?utf-8?B?Y3NIWGVodVBjdnNUUzFvT21yMCtic2w3U3NIWjVWR3JFT1lMQzB5SGl5VmRi?=
 =?utf-8?B?Sm5VQi8waE5CRFpZZmcxWjVJMlg0YUQxbWxMNEhtNFlZVitFamJUckgwS0xw?=
 =?utf-8?B?NHFtRnRHUGlpbi9Da0xJRXBrS1lCbUZyRXhqUkErNnBhUHN6U0tnTlZTYzRj?=
 =?utf-8?B?VFgzNVZPOEozMTdXQXQ0cnAwcGpDV0xSdUFkVVFldzZBa1BVSkhoYUxybnJ5?=
 =?utf-8?B?Q1QrSUtWRmlGbGxkSzV5ZEhqWENGRC93bklKSmZOcUtWaTV6V24rVWZndDQ3?=
 =?utf-8?B?aytYTk1DTTg5Q0ZSRFg1dE82VXR6YUpVcW9BNzZFNmxnd0IvcWpsSHZsOFRQ?=
 =?utf-8?B?ZGFCeW1ZQ0FmejVmZmtUdk9iejNrOUV2aytIZ2drZ2w5cm5wNG51R0dOSHJG?=
 =?utf-8?B?b2VwNUlSaVJROWJPdGZWZFFuaDlkVGFwMW1jckRzZW0vaFc1dXRHUVdRakk5?=
 =?utf-8?B?TmFuQUlGZUQvSHMvVENTaUt4TTN0TG5TcVdRQld2anNqOVpPRThqU0ErYVll?=
 =?utf-8?B?dFBpM3BGWHppdUpuc2ZVVWF6NFdrWGFBZFJPOFpqU1dXc1YrVTQ2eXdjbWpX?=
 =?utf-8?B?VDZlOTJvZGZCMHQrUkM2SW14RmR6NlhmUFRBVjFRaGdPVCs0VTJ3UHIrcEpD?=
 =?utf-8?B?cGU0SUQrMWVQQ3dIenQ2Mm5vbUdPVEZRV3VGL2hsMWMxeU9zNjFqeitlUXZO?=
 =?utf-8?B?S0VpU0s5dlBKcjludXJFb1Z4d0tmY0hwOGRTWE5Idm96dkZubnlXc1B5V1k4?=
 =?utf-8?B?b0dtNUZQUWZXKzRaa2p2SnE5TFJvZmlaVmJXS2JVenRralFTN2NQcDlqQU5S?=
 =?utf-8?B?WStHb21DekJaUldtSmFTNWtpdEQxSGc5aDJQSmRDTWdTN1pja2UycmJWa29C?=
 =?utf-8?B?Ym9Sd2ZBb3JTMzljMW5KZXRENU9NZG9ESVNjNTdHR1VoanZKcnJKOFFFQ0wr?=
 =?utf-8?B?Nlp3R2pWVjNoVkVaNlZVOTB4bW9TVlozNW1FYU0rallTbWJyb2tMT0dxakc1?=
 =?utf-8?B?bU0rdWJSekhDZ0RwZE5jTk9MQnVka01kNnVlKy95SHB1NUF5Zmk2d3lieHNR?=
 =?utf-8?B?bjJBR1A0Q0RyL1ZWRTE3Y3pzam9ldGZmNkNFajcyS1M1V0FZK1dEcnRxM3B1?=
 =?utf-8?B?cXNsdnNCOFJhZGtMREs0TzFtZGZ1RjNsbU5wZzl2WkNGOS80OWtlV0Zlb3VM?=
 =?utf-8?B?bitud0d3Z0NWajRkS3pJRk51UC8zdnM4b2JGbWE0bjRJTDBkVUljRFNUVWND?=
 =?utf-8?B?bkQ1aDRrWlJReW54Nk4vMDBRQ01RbzdIL0laOHNlQnMwc2x0LytUbm5HVGdq?=
 =?utf-8?B?dzNKWURjMS92SUNJVFdkbFhiNXJLM1MweDVGdHo2YlBEanVtVXVlNGFyRFNH?=
 =?utf-8?Q?rWLegK7e35r+ebYNuR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e27f5800-17cd-47c2-4add-08de95afcfb5
X-MS-Exchange-CrossTenant-AuthSource: IA0PPF9A76BB3A6.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2026 20:45:47.1616
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +1QR1AgaVlNwfG3/pkXytijRT4afIMoDPvfN3g6XbaDc6QMCPJ3wyPdLDUX49Iz4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6004

Hi Reinette,

On 4/7/26 23:45, Reinette Chatre wrote:
> Hi Babu,
> 
> On 4/7/26 6:01 PM, Babu Moger wrote:
>> Hi Reinette,
>>
>> On 4/7/26 12:48, Reinette Chatre wrote:
>>> Hi Babu,
>>>
>>> On 4/6/26 3:45 PM, Babu Moger wrote:
>>>> Hi Reinette,
>>>>
>>>> Sorry for the late response. I was trying to get confirmation about the use case.
>>>
>>> No problem. I appreciate that you did this so that we can make sure resctrl supports
>>> needed use cases.
>>>
>>>>
>>>> On 3/31/26 17:24, Reinette Chatre wrote:
>>>>> On 3/30/26 11:46 AM, Babu Moger wrote:
>>>>>> On 3/27/26 17:11, Reinette Chatre wrote:
>>>>>>> On 3/26/26 10:12 AM, Babu Moger wrote:
>>>>>>>> On 3/24/26 17:51, Reinette Chatre wrote:
>>>>>>>>> On 3/12/26 1:36 PM, Babu Moger wrote:
>>>
>>>>> can have domains that span different CPUs. There thus seem to be a built in assumption of what a "domain"
>>>>> means for PQR_PLZA_ASSOC so it sounds to me as though, instead of saying that "PQR_PLZA_ASSOC needs
>>>>> to be the same in QoS domain" it may be more accurate to, for example, say that "PQR_PLZA_ASSOC has L3 scope"?
>>>>
>>>> Yes.
>>>
>>> Above is about L3 scope ...
>>
>> Yes. The scope for PQR_PLZA_ASSOC is L3.
>>
>> Is that what you are asking here?
> 
> I was trying to point out that there appears to be a mismatch between the actual scope and
> the planned implementation. As highlighted below during the discussion about "global" this is
> fine with me and I just wanted to confirm that this matches your intentions.

Ack.

> 
>>
>>>   
>>>>>
>>>>> This seems to be what this implementation does since it hardcodes PQR_PLZA_ASSOC scope to the L3
>>>>> resource but that creates dependency to the L3 resource that would make PLZA unusable if, for example,
>>>>> the user boots with "rdt=!l3cat" while wanting to use PLZA to manage MBA allocations when in kernel?
>>>>
>>>> Yes. that is correct. It should not be attached to one resource. We need to change it to global scope.
>>>
>>> Can I interpret "global scope" as "all online CPUs"? Doing so will simplify
>>
>> Yes. That is correct.
>>
>>
>>> supporting this feature. It does not sound practical for a user wanting to assign
>>> different resource groups to kernel work done in different domains ... the guidance should
>>> instead be to just set the allocations of one resource group to what is needed in the different
>>> domains? There may be more flexibility when supporting per-domain RMIDs though but so far
>>> it sounds as though the focus is global. We can consider what needs to be done to support
>>> some type of "per-domain" assignment as exercise whether current interface could support it
>>> in the future.
>>
>> Yes. Makes sense.
>>
>>>
> 
> ...
> 
>>>> The PLZA MSR is updated when user changes the association to the
>>>> file. No context switch code changes are needed. This will be
>>>> dedicated group. The current resctrl group files, "cpus, cpus_list
>>>
>>> Why does this have to be a dedicated group? One of the conclusions from v1
>>> discussion was that the "PLZA group" need *not* be a dedicated group. I repeated that
>>> in my earlier response that I left quoted above. You did not respond to these
>>> conclusions and statements in this regard while you keep coming back to this
>>> needing to be a dedicated group without providing a motivation to do so.
>>> Could you please elaborate why a dedicated group is required?
>>
>> If the same group applies identical limits to both user and kernel
>> space, it essentially behaves like a current resctrl group. In that
>> sense, it’s not really a PLZA group. PLZA’s key value is the ability
>> to separate allocations between user space and kernel space. A
> 
> The plan has never been to force identical allocations for user and kernel
> space since that would go against this feature entirely. Even so, just as
> user and kernel space cannot be forced to have identical allocations they
> also cannot be forced to have different allocations. Specifically,
> a task *can* use the same CLOSID for user and kernel space work just as easily
> as it can use *different* CLOSID for user and kernel space work. There
> should not be any CLOSID reserved just for kernel work. Or am I missing something?

No. You are not missing anything.


> 
>> single CPU can belong to two groups: one group manages the user-
>> space allocation for that CPU, while another manages the kernel-mode
>> allocation.
> 
> Exactly. This is why it is important to have two files for this CPU association
> within a resource group. The cpus/cpus_list file continues to be used as today
> while the new kernel_mode_cpus/kernel_mode_cpus_list is used for kernel work.
> With this a task can be associated with any resource group for its user space
> allocations but when it runs on one of the CPUs within kernel_mode_cpus then
> its kernel work will be done with allocations of the resource group the
> kernel_mode_cpus file belongs to, which may or may not be the same
> resource group that the user space task belongs to.

Yes. Exactly.

> 
>> This approach also simplifies file handling, which is another reason
>> I prefer it.
> 
> I *think* we have different interpretations of "dedicated group":
> It sounds as though you interpret "dedicated group" as a way that enforces
> the same allocations to user space and kernel work.
> I interpret "dedicated group" essentially as a CLOSID reserved for kernel
> work. Since I do not see that resctrl should dedicate a CLOSID/resource group
> for kernel work I have been pushing against such "dedicated group".

Actually, our understanding is same. Probably, I am not explaining it 
right. Hope we get there soon.


> 
>> That said, I’m open to not having a dedicated group if we can still support all the features that PLZA provides without it.
> 
> I find that enabling user space to share CLOSID/RMID between user space
> and kernel space to indeed support what PLZA provides. I think I am missing
> something here since below proposal again attempts to isolate a resource group
> (CLOSID) for kernel work.

No. I dont want to isolate a group just for PLZA. All I am saying is, we 
should provide option to create a dedicated group if the user wants to 
do it.

> 
>>>> Add a file, "info/kmode_monitor", to describe how kmode is monitored.
>>>>
>>>> # cat info/kmode_monitor
>>>> [inherit_ctrl_and_mon] <- Kernel uses the same CLOSID/RMID as user. Default option for the "global"
>>>> assign_ctrl_inherit_mon <- One CLOSID for all kernel work; RMID inherited from user.
>>>> assign_ctrl_assign_mon <- One resource group (CLOSID+RMID) for all kernel work. Default option for "cpu" type.
>>>
>>> My first thought is that the naming is confusing. resctrl has a very strong relationship between
>>> "RMID" and "monitoring" so naming a file "monitor" that deals with allocation/ctrl/CLOSID is
>>> potentially confusion.
>>>
>>> Apart from that, while I think I understand where you are going by separating the mode into
>>> two files I am concerned about future complications needing to accommodate all different
>>> combinations of the (now) essentially two modes. My preference is thus to keep this simple by
>>> keeping the mode within one file.
>>>
>>> Even so, when stepping back, it does not really look like we need to separate the "global"
>>> and "per CPU" modes. We could just have a single "per CPU" mode and the "global" is just
>>> its default of "all CPUs", no?
>>
>> Yes. That correct.
>>
>>>
>>> Consider, for example, the implementation just consisting of:
>>>
>>>      # cat info/kernel_mode
>>>      [inherit_ctrl_and_mon]
>>>      global_assign_ctrl_inherit_mon_per_cpu
>>>      global_assign_ctrl_assign_mon_per_cpu
>>>   
>>>>
>>>> Rename “kernel_mode_assignment” to “kmode_group” to assign the specific group to kmode. This file usage is same as before.
>>>>
>>>> #cat info/kmode_groups (Renamed "kernel_mode_assignment")
>>>> //
>>>
>>> Please consider the intent of this file when thinking about names. The idea is that "info/kernel_mode"
>>> specifies the "mode" of how kernel work is handled and it determines the configuration files used in that
>>> mode as well as the syntax when interacting with those files. By renaming "kernel_mode_assignment" to
>>> "kmode_groups" it implicitly requires all future kernel mode enhancements to need some data related to "groups".
>>>
>>> In summary, I think this can be simplified by introducing just two new files in info/ that enables the
>>> user to (a) select and (b) configure the "kernel mode". To start there can be just two modes,
>>> global_assign_ctrl_inherit_mon_per_cpu and global_assign_ctrl_assign_mon_per_cpu.
>>> global_assign_ctrl_inherit_mon_per_cpu mode requires a control group in kernel_mode_assignment while
>>> global_assign_ctrl_assign_mon_per_cpu requires a control and monitoring group.
>>>
>>> The resource group in info/kernel_mode_assignment gets two additional files "kernel_mode_cpus" and
>>> "kernel_mode_cpus_list" that contains the CPUs enabled with the kernel mode configuration, by default
>>> it will be all online CPUs. The resource group can continue to be used to manage allocations of and
>>> monitor user space tasks. Specifically, the "cpus", "cpus_list", and "tasks" files remain.
>>>
>>> A user wanting just "global" settings will get just that when writing the group to
>>> info/kernel_mode_assignment. A user wanting "per CPU" settings can follow the
>>> info/kernel_mode_assignment setting with changes to that resource group's kernel_mode_cpus/kernel_mode_cpus_list
>>> files. Any task running on a CPU that is *not* in kernel_mode_cpus/kernel_mode_cpus_list can be
>>> expected to inherit both CLOSID and RMID from user space for all kernel work.
>>
>> After further consideration, I don’t think the info/kernel_mode file
>> is necessary. There’s no need to enforce a specific mode for all the
>> PLZA groups. Avoiding this constraint makes the design more
>> flexible, particularly as we move toward supporting multiple PLZA
>> groups in the future. MPAM already appears capable of handling more
>> than one group—for example, one group could use
>> inherit_ctrl_and_mon, while another could use
>> global_assign_ctrl_inherit_mon_per_cpu.
> 
> You are looking ahead at future capabilities for which we do not know all requirements
> at this time. I think it is very good to consider how things may progress and your example
> of MPAM is of course on point. I believe the current design does consider this progression.
> Please see https://lore.kernel.org/lkml/2ab556af-095b-422b-9396-f845c6fd0342@intel.com/
> (search for "per_group_assign_ctrl_assign_mon"). In that exploration per-group assignment
> is actually accomplished with global files. I thus think we should not make such a big
> architectural decision that does not benefit the immediate feature using partial information.
> As it is, a "info/kernel_mode" gives the flexibility to expand to, if needed, configuration
> files within a resource group. That is why the intention is to associate the mode within
> info/kernel_mode with the presence/absence of info/kernel_mode_assignment (search for
> "Visibility depends on active mode in info/kernel_mode" in linked email) since in the
> future resctrl may need to enable a mode that needs configuration files within each
> resource group and when enabling such mode the per-resource group files will appear
> instead of the global info/kernel_mode_assignment.
> 
>>
>> The mode can simply be determined on a per-group basis. We can introduce two new files—kernel_mode_cpus and kernel_mode_cpus_list—within each resctrl group when kmode (or PLZA) is supported.
> 
> I think having these files in every resource group is confusing since user can only interact
> with these files in one resource group for current PLZA. Why not *just* have the files in the
> resource group that matches the group in info/kernel_mode_assignment?

The default group can also serve as the PLZA group.

#cat info/kernel_mode_assignment
//

At this point, the (kmode_cpus / kmode_cpus_list) files will exist in 
the default group:

Then user changes the PLZA group to "test".

#echo "test//" > info/kernel_mode_assignment

At this point, we expect the files "(kmode_cpus/kmode_cpus_list)" to be 
visible in "test//" group.

One open question is whether we should remove the visibility of these 
files from the default group. It’s unclear if we can safely do this 
dynamically.

An alternative approach would be to always keep the files present, but 
allow access to them only for groups that are listed in 
"info/kernel_mode_assignment".


>>
>> The info/kernel_mode_assignment file would indicate which resctrl
>> group(or groups) is used for PLZA. The files—kernel_mode_cpus and
>> kernel_mode_cpus_list would indicate how the plza is applied which
>> each group.
> 
> The "how PLZA is applied" should be learned from info/kernel_mode where user
> space learns whether RMID is inherited or not. While I find kernel_mode_cpus
> and kernel_mode_cpus_list to be just for configuration and just found in the
> resource group listed in info/kernel_mode_assignment.

ok.

> 
>>
>> Files and behavior:
>> - cpus / cpus_list:
>>
>> CPUs listed here use the same allocation for both user and kernel space.
> 
> Both user and kernel space?

As it stands today, the CPU list is written to MSR_PQR_ASSOC, resulting 
in the same allocation for both user and kernel within a given CLOS.

Kernel-mode allocation changes only if specific CPUs are included in the 
kmode_cpus list.


> Monitoring would depend on info/kernel_mode_assignment ("inherit_mon")
> and kernel space allocation would depend on whether the CPU on which the task runs
> can be found in kernel_mode_cpus, no?

Yes. that is correct.

> 
> 
>> There is no change to the current semantics of these files.
>> If these files are empty, the group effectively becomes a PLZA-dedicated group.
> 
> I do not see it this way. If the cpu/cpus_list files are empty then it means that the
> tasks in the group will use their own CLOSID/RMID for user space allocation and
> monitoring. What allocations/monitoring is used by tasks when in kernel mode depends
> on whether the CPU the task is running on can be found in a kernel_mode_cpus/kernel_mode_cpuslist
> file. If the CPU the task is running on can be found in a kernel_mode_cpus/kernel_mode_cpuslist
> file then it will inherit whatever the PQR_PLZA setting of that CPU which is the allocation
> associated with the resource group to which that kernel_mode_cpus/kernel_mode_cpuslist belongs.
> If the CPU the task is running on cannot be found in kernel_mode_cpus/kernel_mode_cpuslist
> then its kernel work will inherit its user space allocations and monitoring.
> 

Yes. that is correct. I think our understanding is correct, but our 
implementation ideas are different it seems.

>>
>> - kernel_mode_cpus / kernel_mode_cpus_list:
>>
>> These files determine whether a separate kernel allocation is applied.
>> If empty, user and kernel share the same allocation.
>> If non-empty, the kernel uses a separate allocation.
>>
>> The group can be CTL_MON or MON group. Based on type the group the CLOSID and RMID will be used to enable PLZA. If it is MON, then rmid_en = 1 when writing PLZA MSR.
> 
> This will be difficult to get right since CTRL_MON groups also have RMID assigned.
> 
>> Here’s the proposed flow:
>>
>> # mount -t resctrl resctrl /sys/fs/resctrl/
>> # cd /sys/fs/resctrl/
>> # cat info/kernel_mode_assignment
>> //
>>
>> By default, the root (default) group is PLZA-enabled when resctrl is mounted. All CPUs use CLOSID 0 for both user and kernel-mode allocation.
>>
>> # cat cpus_list
>> 1-64
>> # cat kmode_cpus_list
>> 1-64
>>
>> Next, create a new group for PLZA:
>>
>> # mkdir plza_group
>>
>> # echo "plza_group//" > info/kernel_mode_assignment
>>
>> At this point, plza_group becomes the new PLZA-enabled group, and the PLZA-related MSRs are updated accordingly.
> 
> It really looks like you are getting back to trying to dedicate a resource group to
> kernel work and that is not something that resctrl should enforce.
> 
>>
>> # cat plza_group/cpus_list
>> <empty>
>>
>> # cat plza_group/kmode_cpus_list
>> 1-64
>>
>> The user can then update kmode_cpus_list to apply PLZA only to a specific subset of CPUs, if desired.
>>
>>
>> What do you think of this approach?
> 
> It is difficult to predict how the "next" PLZA will actually end up looking like and I find resctrl creating a complicated
> interface to support this to be risky. Instead I would prefer to focus on efficiently supporting what PLZA can do today
> and make it extensible. Apart from that I find the implicit interface, "If it is MON, then rmid_en = 1" to be too
> architecture specific for a generic interface while also not able to accurately capture user's intent (i.e. user may
> indeed, for example, want "a CTRL_MON group to have rmid_en = 1"). Finally, I am just so confused about why the implementations
> keep needing to dedicate a resource group/CLOSID to kernel work.

Let me make sure I understand what you mentioned earlier. Copied the 
text below from the thread for the context:

https://lore.kernel.org/lkml/3305c18e-9e50-4df0-b9f1-c61028628967@intel.com/
=====================================================================

Please consider the intent of this file when thinking about names. The 
idea is that "info/kernel_mode"
specifies the "mode" of how kernel work is handled and it determines the 
configuration files used in that
mode as well as the syntax when interacting with those files. By 
renaming "kernel_mode_assignment" to
"kmode_groups" it implicitly requires all future kernel mode 
enhancements to need some data related to "groups".

In summary, I think this can be simplified by introducing just two new 
files in info/ that enables the
user to (a) select and (b) configure the "kernel mode". To start there 
can be just two modes,
global_assign_ctrl_inherit_mon_per_cpu and 
global_assign_ctrl_assign_mon_per_cpu.
global_assign_ctrl_inherit_mon_per_cpu mode requires a control group in 
kernel_mode_assignment while
global_assign_ctrl_assign_mon_per_cpu requires a control and monitoring 
group.

The resource group in info/kernel_mode_assignment gets two additional 
files "kernel_mode_cpus" and
"kernel_mode_cpus_list" that contains the CPUs enabled with the kernel 
mode configuration, by default
it will be all online CPUs. The resource group can continue to be used 
to manage allocations of and
monitor user space tasks. Specifically, the "cpus", "cpus_list", and 
"tasks" files remain.

A user wanting just "global" settings will get just that when writing 
the group to
info/kernel_mode_assignment. A user wanting "per CPU" settings can 
follow the
info/kernel_mode_assignment setting with changes to that resource 
group's kernel_mode_cpus/kernel_mode_cpus_list
files. Any task running on a CPU that is *not* in 
kernel_mode_cpus/kernel_mode_cpus_list can be
expected to inherit both CLOSID and RMID from user space for all kernel 
work.

======================================================================

Let me try to get few clarification on things here.

# cat info/kernel_mode
   [inherit_ctrl_and_mon]
   global_assign_ctrl_inherit_mon_per_cpu
   global_assign_ctrl_assign_mon_per_cpu

My understanding of "inherit_ctrl_and_mon" is that the kernel inherits 
both the CLOS and the RMID from user space. Basically both user and 
kernel uses same CLOSID and RMID. This reflects the current behavior 
(without PLZA) correct? This would correspond to the default group when 
resctrl is mounted.

The modes "global_assign_ctrl_inherit_mon_per_cpu" and 
"global_assign_ctrl_assign_mon_per_cpu" represent the actual PLZA modes.

Both of these modes introduce new files kernel_mode_cpus/ and 
kernel_mode_cpus_list in the resctrl group.

When the user echoes a group name into info/kernel_mode_assignment, PLZA 
is applied globally across all CPUs. This is default behavior.

If the user wants PLZA to apply only to a specific subset of CPUs, then 
the kernel_mode_cpus or kernel_mode_cpus_list files need to be updated 
accordingly.

global_assign_ctrl_inherit_mon_per_cpu : The group needs to be CTLR_MON 
group. This mode uses rmid_en=0 when writing PLZA MSR.

global_assign_ctrl_assign_mon_per_cpu: The group needs to be 
CTLR_MON/MON group. This mode uses rmid_en=1 when writing PLZA MSR.

Did I get it right?

Thanks
Babu
