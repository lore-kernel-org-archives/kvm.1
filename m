Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010029.outbound.protection.outlook.com [52.101.85.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C1F131ED7C;
	Wed,  8 Apr 2026 01:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775610119; cv=fail; b=LDSfEZYQaeAlIa64yqc1N+GDoVzfYFhwVjQXqQC5HtIoJMWUpHeOgNFbwExeygWAB84sI/qzdX68t4yyIdcmfyz+A2eaZgbkz+tpddsRRbAtqZgjOcC9VMte+uH5wNueqStLn+SOJOVylwKy4QGK0lqS4ep0X1w7A+EoC551eWE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775610119; c=relaxed/simple;
	bh=c2GnCdk5+Ldl9esXJITCrnZyo/Q1CxirCH1IN+gs9Pg=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=n+e76t2vcVzQUUJyzw/mgwpOb0xpynQH69tR6ciRl01Wst3HeJbn4xQxW1VT59XgW11ysVtR1FumMOBzMsO2ZGIYisIYy0okK0eZtwYnQmJBgTk7DAQlHs0czogm4C6tvdQTqEYmqCIUroC9VLkiysDKXGQ9tOXpere/q+tfXN4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=skqJbgqC; arc=fail smtp.client-ip=52.101.85.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="skqJbgqC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HdQVPhGPvGbqql9YwsqnqKrDF1Z6pnf7XYwPQBhCn1PQzius8lnoChoJzFshJfzdDgkFybKVGrye4DRvAw0d5qVT640EUBh+HZWAfeUo/hBisT1ooqhOuSAUO/eFDbsWiLmFpRksh3MjOHi4jHEFmt9zEaXZ/RthEjIVTY2LzIyWCExni2I3H1cIv4Z+Zd/FjNgho+8AvINTuAzqG2z8xweH5k3ksyIEwISKjSgvmi6WmD5TMHVhTljT8MNMvaliMF2rL0Mvr+AWguEKQdJN95UvyzTVXzIQ3gbFwQsjRLiQol6dfHnNP9eznZeV+BYyHRle8EnLySf4Qqc4jhaAJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sykbCyGXSMIjmAjG0xdGVwUD4FzAYGlXsmnND0oZyhM=;
 b=eKVPqTIDTqU9XpFvdKzqwu4egmJachVDIQ0+UgTy/J99IcXV+OoB186vCQE+wb+MzLxhZBgzYvO8Kxt0yRY0suvrCx84sUdxi0zYj+wmHS4Sa9iHXYdnlTOgxsy7jxVUXXSTxociT6m5ata5voxrDFVuJ3BqNOWyYVp34VQWpFdxuZKUGUkHs53/F54FWD6ljOkxcq/tZ+gE6IQLU4xq6k05iGmYAwb2eluBnsGxzvZZ3xlCRHNKlvv9FPt57dU4eJz8LBccw48zVnNRCEW7ZTxB37xODt8uUtk0uwVmnDQkngcmkMw0wKm6jglBfOHcQZbyZ+Y7kJGqcY/efqbSUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sykbCyGXSMIjmAjG0xdGVwUD4FzAYGlXsmnND0oZyhM=;
 b=skqJbgqCnnYkkcjphttdZ4za8Gpaw8Hn8RDpXEDh5ayIf1+tN5939/3g6shz6kKaXsCVYiIwhY9/4vpIwOoooMDUOReRegeRyEog6yVZg4oQ10ZmJLFRO5sjNM0z8oRwJrYhq/f4RL2tHbYWkXfqTBCKDSDm9Ilu7a3FxMVFMeA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bdc) by MW5PR12MB5684.namprd12.prod.outlook.com
 (2603:10b6:303:1a1::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Wed, 8 Apr
 2026 01:01:48 +0000
Received: from IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 ([fe80::e192:692b:abba:8c88]) by IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 ([fe80::e192:692b:abba:8c88%3]) with mapi id 15.20.9769.016; Wed, 8 Apr 2026
 01:01:48 +0000
Message-ID: <c6f574b7-fe5f-49ae-9865-0e4dbb2f9803@amd.com>
Date: Tue, 7 Apr 2026 20:01:44 -0500
User-Agent: Mozilla Thunderbird
From: Babu Moger <babu.moger@amd.com>
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
 <tiala@microsoft.com>, "Neeraj.Upadhyay@amd.com" <Neeraj.Upadhyay@amd.com>,
 "chang.seok.bae@intel.com" <chang.seok.bae@intel.com>,
 "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
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
Content-Language: en-US
In-Reply-To: <3305c18e-9e50-4df0-b9f1-c61028628967@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR03CA0037.namprd03.prod.outlook.com
 (2603:10b6:610:b3::12) To IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bdc)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PPF9A76BB3A6:EE_|MW5PR12MB5684:EE_
X-MS-Office365-Filtering-Correlation-Id: ec4f805f-ef14-46e1-0532-08de950a68f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Fl7dfyiAj+1yZvBCmBkV23NqH/FyoDmh0yQsfpuCMIoKN+veFenzPmvQlgzAE3Iv994efIUuGvpOEKCs+frqDY381doA/Ak4RZAqCUSLwGwgnvgJ0axaGEWWbqde6VGwMagBvpZzKkTbsUJU03Bt2iB+G911DmfaIP6yum/1HCsACDGlOpJyKasbO07RfoNDCIKIsUkgrMiQsii7ykcjTt0GsccVn7iOYOOZQOmTgZcHDQKFLRfGKOHtMh/Xs12OLO+K0fpSsrSh4qo/sNXGw+fqhcpNQ3Fp6i7oF2rcLS7Jhy/wlnhgmaFsbSvRscRJb6qu4bPKwvGmytM5InwN3GF22n+kMGWS0Yf5qN8J1TCS9YSN7/G7n2Vk9ykqIzok32Ppqdt/beQUzARyt1KVXDd2m0t8VRuXwipjjPV1JabqocbTB8FX9J59QtrFdYfGKEvaNzpG/hz4wy3IHYDxXuq6HfsQA6pQtaXjP3Medpnqg1QZG32B3L4DjpKfKJ8clUw0IZFWSKBjtMYmef8YNfny6UJQYWo6fe7vvEam0EAcUPIHLDwfvNzUqpuk+YyDF0wtZXJAD7JZzLgZXRtkA06JPldVD3LXYmmV1cXW/eE4VGSK4RHfK4acdtESJVjHyuKbmQS8d7jOF5htQRVmxULJze0C9mynCM3msk4/6LM3qRiwmAbtr1ElObzrYiURLI7m7WK8tFBK/IpkDVLsZvFRoakgmpTMxEUOuUc5BBg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PPF9A76BB3A6.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SVJURWViTCtKSVJqblNDbzNWR2U5UE1hdkp5UHJHZmJ3QXhmVmRyclhoclRv?=
 =?utf-8?B?K2N6VHE1OEpRWnp2WStwVFdBOWhJTTJsOEViaHFvSjFabWF5dk5zUC85V1RW?=
 =?utf-8?B?UEg4eUVta2ZiVmtVdWRwemhPMzlXa29tdmVaK2dkcXIyd0ZORi9jQnJHdTI4?=
 =?utf-8?B?d0ZLL2dLTm5XTDE4MTdRdjBCbDhNaEJYSmFvS0VEZ1VPMnUyRGN6eW1uTEJG?=
 =?utf-8?B?UFhINW5oc1liVlJOdG12bGd3ZTRhTGY5VTA5VFFCTjltL0t3MGJLSmVrbzdC?=
 =?utf-8?B?QWpWWjZiN0FOY2UxWHBaVlF0WU5BVENyOGo4S2RlTlpLQzRtc2hET2NpQ3VJ?=
 =?utf-8?B?MFh2LzBES21YMlFSbC9xWksrTHBtVEJLU1dVTndyN1dKRkZ4RVBvQTZ1M3Bl?=
 =?utf-8?B?My90L3dZak9BYnVQSThjd1lqMitycTBuQkZmVG1Ga3IrdjFVTVdqZGEwc2hl?=
 =?utf-8?B?cHlxTFNqc0pqOHRiTzdvS0NIVkZ3eG1Wc2RzL0s3YWZXVXVIWTZMUkp5QzZR?=
 =?utf-8?B?V1FDQ0tUYWlBcFdaemdUcEJTWWE4TU9pQjZORGdZNmFEV0J5WW93a3JiUDE2?=
 =?utf-8?B?cWZtQWs0VVFaYWZmSGtadGQxdGZScFl0Z0xNL3JIYitvRFBRT2VLNm9xNFFG?=
 =?utf-8?B?ZEc0UjJJdUdaVE1vdzdpa0F6cnBwdUpOdHNsQmRFVldMSVdLbkx1TllhY0Er?=
 =?utf-8?B?b1RSTjNIVFVGL2wrUVFrSWFjQVF5QnVydEtTeXNVc21MbDNERjZnVHZXM3FR?=
 =?utf-8?B?U2FKeHd6Y1VobkhIblVUaEU1YVNQRFdwcStoN2hHSTBiMnRETC9kamZxRmVp?=
 =?utf-8?B?Vy8vTkloMzNqRzVkZkwrTjdjMkp3d01CeVhJbHR0RWpZR2g0bDRFKzJuWllM?=
 =?utf-8?B?Y2tYQlg5NlpTdmtqSWwvVGJJaHg1ZmV0cTkxV2xxeWlHQ2Q0MHNMaFNTMkM5?=
 =?utf-8?B?QU1CaXlMMEFWbUo3aHNsaG9RYmRDQzUzZVZ4d3ROZ004WHpxQ0JmUVpja1ha?=
 =?utf-8?B?MTUyNWRCazdDa0luZWxFbXZnc0NtbVJJbFJjOGF3emZtaExFR1B6bENiQ3lp?=
 =?utf-8?B?UTdGbkFINlNQQUNEVlRiSDBsSzFYSmV0UlFoQlFLeTMxSnJKejJreDRlcjhs?=
 =?utf-8?B?cU1Gbll1NmJWaDFzdTc0UFlzUkRlaVpuYkJmU01TZ3BLd002MDdEaUNuZmRj?=
 =?utf-8?B?aERORFUvQTMxWmVneWVOcUJ1UWE1aEpTRDgrZ1JEYWVORTk1VTArRy9MRXdZ?=
 =?utf-8?B?aXprY0ZMT1h4SmVBSUhMOHVQeHl6UkMwdVNHOWZRMm9NdjcwUGxSS1BkN1By?=
 =?utf-8?B?QUliQ3FoZ1VXS0hlZGJIeFNkendZcDlsWldPb3J4VkpQN0RZb0EreTJIZE4z?=
 =?utf-8?B?cVpKTElrY2w2clhRdHp1T0ZscWE3ZVJEdzgrQWR0eDhobC9weVRuRDZqb0lV?=
 =?utf-8?B?QitqUmtIaVlvd2tURHdrSGRTalRMSytENW1Od0s0NU9NeWx3cnBWcUpyeFRz?=
 =?utf-8?B?UzZTMkNjWUhhMm12b3ZQcUdqazd0RlRaME54R0FlekdNZzBoOFRxNGI2bmVj?=
 =?utf-8?B?NmJMNkppcGk3bmVseGtrRERmL2VxUU5CSnk4YkJlTXZTSmJIb1NnK2tsN2ts?=
 =?utf-8?B?TTI3V0RoUGU2WStNQ3VyNHJpcGt0R2JqaXBIZnhhZ1RKelo3VWJLSnN0NCt6?=
 =?utf-8?B?Z1VhbE5RdTZOL1lFbWFMQkNtREZjcHR1NDlEeUxIUDh2aVlUV21yckFNOXRD?=
 =?utf-8?B?WnhhZCtqdnN1ZmszVlUveE5NR1lHREk1cW9DK0IzdGM4ckhKaHdyd0pTV3JM?=
 =?utf-8?B?aE03L091VldxS0s0MlJpV2s4R2Q1UzlWWk5wVys3dHYzWjFGNTRIeit2MURP?=
 =?utf-8?B?L3NWQlFlYlE3ZE9xVGRZejFXZzZyRjlHRVlzM2JjbnBpV1FOc3BEWGNmSlB2?=
 =?utf-8?B?bnN0UGxtR3czQ1dSVkk0OTJ5N0NNaU9LTGc5UGUvWTBJZ1J2R3RxYlhYSzZG?=
 =?utf-8?B?QTI0NXlyWnBBZVZtYkhGUWFBc0I2aFhKU1R0Y0dvVHUzeWoyZlR1TzJqZVp6?=
 =?utf-8?B?TUdQTStoUjRWcFJlcy9Od2NVTnd1T1NMV3RJVlNLcDVYNVdvYXhXdXd0ajYy?=
 =?utf-8?B?V09KMWM4N3pvZndTaFM1Q1c3UklabkFINzYxTFBxVGVzekJDWjQ1MTBaa3F3?=
 =?utf-8?B?VUZSRkF6dTRwcElrbThuYUk2QXVlcGxLY2VNNkpsUnAvQTJJTzhBNTFRLytk?=
 =?utf-8?B?Wmx2L0hpSjZYWEhIZEZ5MkVYRm1BL3RNbDJoK091WjJDSmpGU2UzYUJsWlQy?=
 =?utf-8?Q?3XrL2Q0arXK2kjSDiF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec4f805f-ef14-46e1-0532-08de950a68f0
X-MS-Exchange-CrossTenant-AuthSource: IA0PPF9A76BB3A6.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2026 01:01:47.9345
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0pDmyqR+5FvTPeL5GPmcybXHgbuwwnsiDVOd89123vwS3wGTK6JcIDrxCQfVDamB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5684

Hi Reinette,

On 4/7/26 12:48, Reinette Chatre wrote:
> Hi Babu,
> 
> On 4/6/26 3:45 PM, Babu Moger wrote:
>> Hi Reinette,
>>
>> Sorry for the late response. I was trying to get confirmation about the use case.
> 
> No problem. I appreciate that you did this so that we can make sure resctrl supports
> needed use cases.
> 
>>
>> On 3/31/26 17:24, Reinette Chatre wrote:
>>> On 3/30/26 11:46 AM, Babu Moger wrote:
>>>> On 3/27/26 17:11, Reinette Chatre wrote:
>>>>> On 3/26/26 10:12 AM, Babu Moger wrote:
>>>>>> On 3/24/26 17:51, Reinette Chatre wrote:
>>>>>>> On 3/12/26 1:36 PM, Babu Moger wrote:
> 
>>> can have domains that span different CPUs. There thus seem to be a built in assumption of what a "domain"
>>> means for PQR_PLZA_ASSOC so it sounds to me as though, instead of saying that "PQR_PLZA_ASSOC needs
>>> to be the same in QoS domain" it may be more accurate to, for example, say that "PQR_PLZA_ASSOC has L3 scope"?
>>
>> Yes.
> 
> Above is about L3 scope ...

Yes. The scope for PQR_PLZA_ASSOC is L3.

Is that what you are asking here?

>   
>>>
>>> This seems to be what this implementation does since it hardcodes PQR_PLZA_ASSOC scope to the L3
>>> resource but that creates dependency to the L3 resource that would make PLZA unusable if, for example,
>>> the user boots with "rdt=!l3cat" while wanting to use PLZA to manage MBA allocations when in kernel?
>>
>> Yes. that is correct. It should not be attached to one resource. We need to change it to global scope.
> 
> Can I interpret "global scope" as "all online CPUs"? Doing so will simplify

Yes. That is correct.


> supporting this feature. It does not sound practical for a user wanting to assign
> different resource groups to kernel work done in different domains ... the guidance should
> instead be to just set the allocations of one resource group to what is needed in the different
> domains? There may be more flexibility when supporting per-domain RMIDs though but so far
> it sounds as though the focus is global. We can consider what needs to be done to support
> some type of "per-domain" assignment as exercise whether current interface could support it
> in the future.

Yes. Makes sense.

> 
> ...
> 
>>>> There are multiple ways this feature can be applied. For simplicity, the discussion below focuses only on CLOSID.
>>>>
>>>>
>>>>        1. Global PLZA enablement
>>>>
>>>> PLZA can be configured as a global feature by setting |PQR_PLZA_ASSOC.closid = CLOSID| and |PQR_PLZA_ASSOC.plza_en = 1| on all threads in the system. A dedicated CLOSID is reserved for this purpose,
>>>
>>> Also discussed during v1 is that there is no need to dedicate a CLOSID for this purpose.
>>> There could be an "unthrottled" CLOSID to which all high priority user space tasks as
>>> well as all kernel work of all tasks are assigned.
>>> If user space chooses to dedicate a CLOSID for kernel work then that should supported and
>>> interface can allow that, but there is no need for resctrl to enforce this.
> 
> (above is comment about dedicated group - please see below)
> 
>   
>> Yes. I agree. The changes in context switch code is a concern.
>>
>> You covered some of the cases I was thinking(xx_set_individual).
>>
>> How about this idea?
>>
>> I suggest splitting the PLZA into two distinct aspects:
>>
>> 1. How PLZA is applied within a resource group
>>
>> 2. How PLZA is monitored
> 
> I think I see where you are going here. While the "How PLZA is monitored" naming
> refers to "monitoring" I *think* what you are separating here is (a) how PLZA is configured
> (CLOSID and RMID settings) and (b) how that PLZA configuration is assigned to tasks/CPUs,
> not just within a resource group but across the system. Please see below.
> 
> 
>> Introduce a new file, "info/kmode_type", to describe how kmode applies in the system.
> 
> ack. "in the system" as you have above, not "within a resource group" as mentioned
> before that.
> 
>>
>> # cat info/kmode_type
>> [global] <- Kernel mode applies to the entire system (all CPUs/tasks)
>>    cpus   <- Kernel mode applies only to the CPUs in the group
>>    tasks  <- Kernel mode applies only to the tasks in the group
>>
>> The "global" option is the default right now and it is current common use-case.
>>
>> The "info/kmode_type -> cpus" option introduces new files
>> "kmode_cpus" and "kmode_cpus_list" for users to apply kmode to
>> specific set of CPUs. This lets users change the CPU set for PLZA.
> Where were you thinking about placing these files in the hierarchy?

It needs to be inside the resctrl group (in struct rdtgroup).


> 
>> The PLZA MSR is updated when user changes the association to the
>> file. No context switch code changes are needed. This will be
>> dedicated group. The current resctrl group files, "cpus, cpus_list
> 
> Why does this have to be a dedicated group? One of the conclusions from v1
> discussion was that the "PLZA group" need *not* be a dedicated group. I repeated that
> in my earlier response that I left quoted above. You did not respond to these
> conclusions and statements in this regard while you keep coming back to this
> needing to be a dedicated group without providing a motivation to do so.
> Could you please elaborate why a dedicated group is required?

If the same group applies identical limits to both user and kernel 
space, it essentially behaves like a current resctrl group. In that 
sense, it’s not really a PLZA group. PLZA’s key value is the ability to 
separate allocations between user space and kernel space. A single CPU 
can belong to two groups: one group manages the user-space allocation 
for that CPU, while another manages the kernel-mode allocation.
This approach also simplifies file handling, which is another reason I 
prefer it.

That said, I’m open to not having a dedicated group if we can still 
support all the features that PLZA provides without it.


> 
> 
>> and tasks" will not be accessible in this mode. This option give
> 
> These files can continue to be accessible.

ok.

> 
>> some flexibility for the user without the context switch overhead.
> 
> Dedicating a resource group to PLZA removes flexibility though, no?

Yes. But makes it easy to handle the files as I mentioned above.

> 
>>
>> The "info/kmode_type -> tasks" option introduces a new file,
>> "kmode_tasks", for users to apply kmode to specific set of tasks.
>> This requires context switch changes. This will be dedicated group.
>> The current resctrl group files, "cpus, cpus_list and tasks" will
>> not be accessible in this mode. We currently have no use case for
>> this, so it will not be supported now.
> 
> Thank you for confirming. This is a relief.
> 
>>
>>
>> Add a file, "info/kmode_monitor", to describe how kmode is monitored.
>>
>> # cat info/kmode_monitor
>> [inherit_ctrl_and_mon] <- Kernel uses the same CLOSID/RMID as user. Default option for the "global"
>> assign_ctrl_inherit_mon <- One CLOSID for all kernel work; RMID inherited from user.
>> assign_ctrl_assign_mon <- One resource group (CLOSID+RMID) for all kernel work. Default option for "cpu" type.
> 
> My first thought is that the naming is confusing. resctrl has a very strong relationship between
> "RMID" and "monitoring" so naming a file "monitor" that deals with allocation/ctrl/CLOSID is
> potentially confusion.
> 
> Apart from that, while I think I understand where you are going by separating the mode into
> two files I am concerned about future complications needing to accommodate all different
> combinations of the (now) essentially two modes. My preference is thus to keep this simple by
> keeping the mode within one file.
> 
> Even so, when stepping back, it does not really look like we need to separate the "global"
> and "per CPU" modes. We could just have a single "per CPU" mode and the "global" is just
> its default of "all CPUs", no?

Yes. That correct.

> 
> Consider, for example, the implementation just consisting of:
> 
> 	# cat info/kernel_mode
> 	[inherit_ctrl_and_mon]
> 	global_assign_ctrl_inherit_mon_per_cpu
> 	global_assign_ctrl_assign_mon_per_cpu
>   
>>
>> Rename “kernel_mode_assignment” to “kmode_group” to assign the specific group to kmode. This file usage is same as before.
>>
>> #cat info/kmode_groups (Renamed "kernel_mode_assignment")
>> //
> 
> Please consider the intent of this file when thinking about names. The idea is that "info/kernel_mode"
> specifies the "mode" of how kernel work is handled and it determines the configuration files used in that
> mode as well as the syntax when interacting with those files. By renaming "kernel_mode_assignment" to
> "kmode_groups" it implicitly requires all future kernel mode enhancements to need some data related to "groups".
> 
> In summary, I think this can be simplified by introducing just two new files in info/ that enables the
> user to (a) select and (b) configure the "kernel mode". To start there can be just two modes,
> global_assign_ctrl_inherit_mon_per_cpu and global_assign_ctrl_assign_mon_per_cpu.
> global_assign_ctrl_inherit_mon_per_cpu mode requires a control group in kernel_mode_assignment while
> global_assign_ctrl_assign_mon_per_cpu requires a control and monitoring group.
> 
> The resource group in info/kernel_mode_assignment gets two additional files "kernel_mode_cpus" and
> "kernel_mode_cpus_list" that contains the CPUs enabled with the kernel mode configuration, by default
> it will be all online CPUs. The resource group can continue to be used to manage allocations of and
> monitor user space tasks. Specifically, the "cpus", "cpus_list", and "tasks" files remain.
> 
> A user wanting just "global" settings will get just that when writing the group to
> info/kernel_mode_assignment. A user wanting "per CPU" settings can follow the
> info/kernel_mode_assignment setting with changes to that resource group's kernel_mode_cpus/kernel_mode_cpus_list
> files. Any task running on a CPU that is *not* in kernel_mode_cpus/kernel_mode_cpus_list can be
> expected to inherit both CLOSID and RMID from user space for all kernel work.

After further consideration, I don’t think the info/kernel_mode file is 
necessary. There’s no need to enforce a specific mode for all the PLZA 
groups. Avoiding this constraint makes the design more flexible, 
particularly as we move toward supporting multiple PLZA groups in the 
future. MPAM already appears capable of handling more than one group—for 
example, one group could use inherit_ctrl_and_mon, while another could 
use global_assign_ctrl_inherit_mon_per_cpu.

The mode can simply be determined on a per-group basis. We can introduce 
two new files—kernel_mode_cpus and kernel_mode_cpus_list—within each 
resctrl group when kmode (or PLZA) is supported.

The info/kernel_mode_assignment file would indicate which resctrl 
group(or groups) is used for PLZA. The files—kernel_mode_cpus and 
kernel_mode_cpus_list would indicate how the plza is applied which each 
group.

Files and behavior:
- cpus / cpus_list:

CPUs listed here use the same allocation for both user and kernel space.
There is no change to the current semantics of these files.
If these files are empty, the group effectively becomes a PLZA-dedicated 
group.

- kernel_mode_cpus / kernel_mode_cpus_list:

These files determine whether a separate kernel allocation is applied.
If empty, user and kernel share the same allocation.
If non-empty, the kernel uses a separate allocation.

The group can be CTL_MON or MON group. Based on type the group the 
CLOSID and RMID will be used to enable PLZA. If it is MON, then rmid_en 
= 1 when writing PLZA MSR.


Here’s the proposed flow:

# mount -t resctrl resctrl /sys/fs/resctrl/
# cd /sys/fs/resctrl/
# cat info/kernel_mode_assignment
//

By default, the root (default) group is PLZA-enabled when resctrl is 
mounted. All CPUs use CLOSID 0 for both user and kernel-mode allocation.

# cat cpus_list
1-64
# cat kmode_cpus_list
1-64

Next, create a new group for PLZA:

# mkdir plza_group

# echo "plza_group//" > info/kernel_mode_assignment

At this point, plza_group becomes the new PLZA-enabled group, and the 
PLZA-related MSRs are updated accordingly.

# cat plza_group/cpus_list
<empty>

# cat plza_group/kmode_cpus_list
1-64

The user can then update kmode_cpus_list to apply PLZA only to a 
specific subset of CPUs, if desired.


What do you think of this approach?


Thanks
Babu
