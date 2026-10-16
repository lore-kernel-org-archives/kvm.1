Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013000.outbound.protection.outlook.com [40.93.201.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 662A23812D2;
	Fri, 16 Oct 2026 15:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792163435; cv=fail; b=g/OLfXY+BSZd/F15oxeqijWAHtHPVtx0fjiynIQ4osZB4IhfXlLTCF5YqceafNqPjacHno9QR9l/oxZZM68zWMOE2nxU/tXmXL9uHIf4oWToG7JfOfYUgTJcxC4Hv0TOxsz0j8b1eH0ik1P3n9UvdUyGd2Fk1hA39TXiZH7BU9Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792163435; c=relaxed/simple;
	bh=RazDnH+YyyEutkjGuC4WhnKhyc9e4MrGKg8a0D+Hn74=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FCCzOUXXNFwwQFGFdobgII6pJn/Z1M5e0foeI52xrgUKLAxXakSHlQQZ0fC/atiFSsDSX57DYTHkuV7hqr4W7vEYUG6vVuuJFVXcmMWmhQ8wHDJ+UaZ31wslfs0zRxZRgr232xL5ekY98fnEhN2Gyz65gPdhWWnJVf61QJVlrb0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QFWp0Nvy; arc=fail smtp.client-ip=40.93.201.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QFWp0Nvy"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Id1V/ab9jk6wywlU1iMKPkpTHpJK/jXpm4eOuN8xy5YxLjbQIaWeQHJnuFkwpOx7RPkx3kLYl+Zn6fKAOJgJaJFtcWXg2uGJ21wmQ1Nj0ixhgwGxpeLVglrkYU43ANcV22OoQdcqSmREzZBxWwMkNpK2rqydlhJTLWDfGtOTTyD+/PVxedhhfhQVBEg6iwBZ+skkNnnr6gx40K6tkIXNcBX81orK+tqnmDWPp5k2gDNxslA9WuYJHtnIhkEjWD+kj0Lm6nMY6yq1Ogqzt3lnwRFar+Zf/FskeYHKZ9ObRKokfUkm4b/dDXTQ5Suu1xVAtNRxydxxo/CbyCEY2htzGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sOSjKi7Z2hzhxBLWZiKG4wajBjMBYBtkycbtY4YCri8=;
 b=gKRJDSsYfe40icoVDE2owyTUpNKCJO/2Kvvd3qEWJ1+aSq3MXyL+m8b1PT0ImyJCBTpfvaGqJjT0G2EByhcEi9JOFNIqet8obgBwFnRIN7V+xz8HIyvO4Iv9qXyDbdrsEBbFJKrwiFuLAqI8Yv+4K33Lgr8BELL4vQcJmZ+SfpBZLQhdeQbaGVhFWDF3gpu9c/bpycfmXyj6vmB/k5zVAZssIU2Wha5hjy81c3Pt7lyx0Uo546yAIwHVf92kUOj3Oozy+IdZ59kQQGdGZGei9ral//mBG1aP9G4voyRfggCgOjh5HJMmZ4egsyUxnSi4YhtgC3ZrGUguzrkYeL1sEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sOSjKi7Z2hzhxBLWZiKG4wajBjMBYBtkycbtY4YCri8=;
 b=QFWp0NvyfQL5C2qTBwU2QiuHB91NBLWJcyJinV/3IEvr7iI92YUktwysw1mso1un0SGL5VtEY7qjXdMWVxNRp4wCPajEMSmBdyCu5viTgD6AnB/d6+8fhpun63lyN4rcIZPnGGkOJwqphL3Lcze8XHVK3g9dqlBU2dR0nmms4go=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5320.namprd12.prod.outlook.com (2603:10b6:208:314::17)
 by DS0PR12MB7876.namprd12.prod.outlook.com (2603:10b6:8:148::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.16; Fri, 16 Oct
 2026 15:10:24 +0000
Received: from BL1PR12MB5320.namprd12.prod.outlook.com
 ([fe80::1876:4a6d:2cf5:b8d1]) by BL1PR12MB5320.namprd12.prod.outlook.com
 ([fe80::1876:4a6d:2cf5:b8d1%5]) with mapi id 15.21.0522.013; Fri, 16 Oct 2026
 15:10:24 +0000
Message-ID: <351da689-6f30-4f56-8f3b-ea62cc501d7e@amd.com>
Date: Fri, 16 Oct 2026 10:10:10 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 06/18] fs/resctrl: Introduce kernel mode states for
 resctrl
To: Reinette Chatre <reinette.chatre@intel.com>,
 Babu Moger <babu.moger@amd.com>, tony.luck@intel.com, bp@alien8.de,
 ben.horgan@arm.com
Cc: corbet@lwn.net, skhan@linuxfoundation.org, rdunlap@infradead.org,
 x86@kernel.org, Dave.Martin@arm.com, james.morse@arm.com, tglx@kernel.org,
 mingo@redhat.com, dave.hansen@linux.intel.com, hpa@zytor.com,
 fenghuay@nvidia.com, kas@kernel.org, rick.p.edgecombe@intel.com,
 akpm@linux-foundation.org, rppt@kernel.org, dapeng1.mi@linux.intel.com,
 elver@google.com, enelsonmoore@gmail.com, jlayton@kernel.org,
 kuba@kernel.org, ebiggers@kernel.org, seanjc@google.com,
 ewanhai-oc@zhaoxin.com, binbin.wu@linux.intel.com, peterz@infradead.org,
 ashish.kalra@amd.com, superm1@kernel.org, chang.seok.bae@intel.com,
 prathyushi.nangia@amd.com, kim.phillips@amd.com, ackerleytng@google.com,
 elena.reshetova@intel.com, naveen@kernel.org, darwi@linutronix.de,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-coco@lists.linux.dev, kvm@vger.kernel.org, eranian@google.com,
 peternewman@google.com
References: <cover.1790867441.git.babu.moger@amd.com>
 <d98872b26051bfad280f72da3bcddea1e978b37c.1790867441.git.babu.moger@amd.com>
 <b2c67318-b52d-440d-bf40-fde40b47ae07@intel.com>
Content-Language: en-US
From: "Moger, Babu" <bmoger@amd.com>
In-Reply-To: <b2c67318-b52d-440d-bf40-fde40b47ae07@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0006.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::11) To BL1PR12MB5320.namprd12.prod.outlook.com
 (2603:10b6:208:314::17)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5320:EE_|DS0PR12MB7876:EE_
X-MS-Office365-Filtering-Correlation-Id: f01a5024-81ef-48e9-434b-08df2b979a5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|7416014|6133799003|22082099003|10067099003|18002099003|4143699003|261009223027099003|56012099006|5023799004|11063799006;
X-Microsoft-Antispam-Message-Info:
	B7jHLf7PRS3NN/GPU4Ghu+10vxwwZP5hQCcrL2+CN7VxepZ/FU+ksiNy5zIn2Op2nnDxeCB4VGZpQkArBQiWWqzYdl4Bur6s6wPM8KkEcttfiOy5GdR5OMFRpzogp/LcKPgVuc0Zq+BfpzCLGgwb0G6CkP0QJOMficGU48MXiSccQs2XlNh7SmyBEAPx4iM0vnbGAZ0BfZ/P04N9yLjsENOTxTiyCsjjMZOdrJvEdCNoxDqsTCJQbPLOM0/NRnmtNvDy/x+4EWktKdGoUyoLuSu+bsHwvmrn/QsTY3cvgvGFF8A9ePA0ewgEDLgEqyJ/J5OvSB5w3HH/Zug2PoPxQrFGFeifSr2lywxFTsSnYwWag5wexXfwj0SG/LfgYwVNX2w1KiE3iSDYGLXq1By27z5O8H4iXHDMN1jh+Sv+lzumWXpHcrPky8nlyjg8iBobpnp8RKN7WUqKBdNP/Urynw2WT/pH5+m8y2lUUZBaqfIQ7EN5ZK0+b57zlbAR7sKGbh2K5Y8bnb2VfLBnB/mo/uEm56Hh8fWaOs51v3Og3TMNwqZkKd0360Oe/KBdakTBN5GcjzCYxheWYdfsQrM23Wgxot87Olx6q7G1QpDPxXC5ITVdac+GlCkrfrFfIXqQ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5320.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(7416014)(6133799003)(22082099003)(10067099003)(18002099003)(4143699003)(261009223027099003)(56012099006)(5023799004)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aGxwQThxZVRVRFdSTGpoaXNPWU1EZWpHZ0VrbEN1K1ltVHh2TFU1Mk92ZS9H?=
 =?utf-8?B?WW9RNHVqb3BQajdjU0l3YXpBcXNnKzNKSHlnVHh6TFI1WnZ2MkZJWlErRlk4?=
 =?utf-8?B?NWV5RjVHTFBvU3d3cmF4SDBSOGllQnB3WUo4R1VtaWxsNS9GU1NYSGFPc3Jl?=
 =?utf-8?B?eUc3TE1tK2d4WWpDazVZa2JhV0g3VFphRFZQbkRZaEpKSlNoanFvL08ya0dG?=
 =?utf-8?B?cDZ6TlRNNkphRkE1cDZWcmhTNUpWMXQvMDVtY3JLUVdxUnJJWGx5MHBzYytQ?=
 =?utf-8?B?b3lrZjZhQjNhaUFsajdvQkpSYVN1WkpUeTNHNnRUVVo0Y1haZjNtUVQ1dXhQ?=
 =?utf-8?B?WWQzd29vTTRaZENRa0p3SlZvazBrTDh1eEFoSENaeEd2Q2JZWFRWNUhZWS82?=
 =?utf-8?B?QlRqbGdxUjZkbXNxQ3JaT2YyWVZieHNOcllPWllqdDRUQmRnTW9Jbm11eTlv?=
 =?utf-8?B?RGl2QUtQN2oyZWZSUHNuQWVaKzJDUmRqcU1UeEpXSTBBRlNWV0lVMkg1MUhU?=
 =?utf-8?B?ZjhFUDJvdGVmaGdQWDhHYm84TVFOS0JsNVNpbnpaQXQvNnNwcWVuSmFnQURP?=
 =?utf-8?B?MW1oUktIUHgvQ21GaC9JQkticDhaZHNzNS9mNm5jUnZRQ3dGb2dwREtkd3l5?=
 =?utf-8?B?Wm9EanJUV2N5Rld3RHZnd0txY1dFZlBoL0F1UThYYkloa2NOaFEzUENCVnNZ?=
 =?utf-8?B?RDBXeExZdTVBL1hPTnVjdWRPc0dnK2tVcUtzL2pHZDYvWWdNajhzOUx0bnBR?=
 =?utf-8?B?Vk55YWdiN3lUek5TZk9HcksrYytpb3cybUgvbEt2eDlaM3BEYTZYMlFBZUZS?=
 =?utf-8?B?TUFDS3NnejA4ZHVLcXY4aVYwTTlHUG9qMkdXc3ZLdEdHQzVqclkycnJxZlM2?=
 =?utf-8?B?UmpOUitxTG5RaFJJY0hyUHdLZnRwYldhZXo5WTY0c2tOL2wvT2xYMklVb2xP?=
 =?utf-8?B?WjlETU9FWHNJVEl5OEpEL01hZEpNRUswZ0NKdEJ2YzBGZGNqWkpvZzZpVkM4?=
 =?utf-8?B?ZEg5TzZjY21ObDY5aThzeGVFQ0xPUU5aaGJ0dG10aTVCTzQvTGl1MEJjQWpH?=
 =?utf-8?B?ZmRpR3ZUc0JnZzAydzE0N2M4S0lNYno0aFh5bUx6Q2JoTnhkNkVMZ2ZkSUtX?=
 =?utf-8?B?YjRYYXd2d2JOazE2eUcwWG02N0N3WnhpTFlyQ1F0cDJneGJBN1MvdTQ2N0lB?=
 =?utf-8?B?ckJMWldhakUxMmxVaTVLcWJBeWQwVGxmRXJzdE9tTnd0U29rci9CSHVTczhu?=
 =?utf-8?B?Ri90eExOYkJ3OWF5QmhtU0lhcDRLZVc3UldBcWI5MzJxUXQ2Rkc3R1dvVHNZ?=
 =?utf-8?B?ckxoUDU4eFNJVTh3RjcxQldvV1NMbFVWM0JLRHo5Y21oS0JQK3pSWWN4eThh?=
 =?utf-8?B?L2dNOWtsTlBBU2Y1dmJaODZJdGljZW1ERnJUQ2tTSVVXcUtzeFFHVGRaRUs0?=
 =?utf-8?B?L3BxcVdDM1Jja1FhdjZIYURneFdKUEVpQWxxTElVS2NIcXZMalpiSnRUdzVy?=
 =?utf-8?B?M0R4NGJ3ZE8yakZxK2w1dS9nR0pRdkM4cFAxZG1WQnJFRmxPc3lTVGFjY3Bp?=
 =?utf-8?B?RXBDYk1sVmJTTXJ2VXhJVkRNK1pQVXVYV085NktQV04xQlBpc05MVVBtcEFI?=
 =?utf-8?B?SGJJU1R4U3dXSHExOHB3S25aTER5YXdNOXdOcmRJWGpDY2dJRXZib3huYjQw?=
 =?utf-8?B?OVkyNGZEa3NheVVMSFFOR3c1SWNuc0kzcGRPWXlvejBHMVk0UjRyMjN0TmxZ?=
 =?utf-8?B?Y3FNVDlOL3RmT1dHa3lQcGZwbXNXZHgzdGQ5YVg4RWRCQ0I0cTI3cG1wYWVD?=
 =?utf-8?B?bEJTa3pld2RTcktFNVpnSWtDUXZOYjlBdWFHNFBkOE9HTmYyVWZlc1JndFdx?=
 =?utf-8?B?bzRoN0dvejV6ZUhTNHFxMnBRK2hyWDRpaUQxZ0xzTXY2MXZjT0JWb2s4eGgz?=
 =?utf-8?B?bDRBZUlRRERJTURPUWplWUE3ak8rTjMyV1I3WGpTK2pUR3dTWTFQMEVYSFh0?=
 =?utf-8?B?UkU2T25iRlcrU1JnVEtWbVorUUVRenF6MGhXODdJSUhRSEZvOStWKzNyWklr?=
 =?utf-8?B?Ti96VlpnUFVuV2VEcFZsaUhaeWIzRWh2K2R2QU8ydkptQzFDdkFjQXBpbU5W?=
 =?utf-8?B?aXVQVHQzdGQ5WURJUXp6a01pSlFEUDVCcWJpb0FvY3pDd1ZKNjd2K1c2V016?=
 =?utf-8?B?c1FweTA1S045YUE5OUNFOTFxSjRwTC9zc05jTEp3YkV0R3VTN3p1ZXpMd2Ra?=
 =?utf-8?B?MXExaG9lV2lCSkREYUgvMDJWMCsyT0t6SGlYRG9jck9iVCs3ZTMyUWpxVXhv?=
 =?utf-8?Q?CD0b/uCFcNVXXL70Jo?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f01a5024-81ef-48e9-434b-08df2b979a5f
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5320.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 15:10:24.1290
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jGjCNn0IJvKTATmXHc7273Zgbv7XF/BaORkK1ATL+qovwi3YyoBGIdUAF5S9O8mT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7876

Hi Reinette,

On 10/15/2026 9:37 AM, Reinette Chatre wrote:
> Hi Babu,
> 
> nit: "for resctrl" in subject is redundant.

ok.

> 
> On 10/1/26 8:10 AM, Babu Moger wrote:
>> The filesystem tracks supported kernel modes, the active mode, and the
>> control and monitoring association for the assigned group.
> 
> Please let the context describe the context at the time of the patch, not how
> things will work after entire series is applied.
> 
> Please use consistent terminology, this series switches between "assigned group"
> and "backing group" to refer to the same group.

Will use the "backing group". That seems more clearer.

> 
> Please use the changelog to guide the reader to understand the architecture
> and how things fit together. Many changelogs are very cryptic without explanation
> of what the patch does and why.
> 
Ack.

>>
>> Introduce struct resctrl_kmode_cfg and initialize the default configuration
>> from the platform's capabilities.
> 
> Please check all changelogs to ensure they all are able to provide an
> answer to "why". More specifically, please consider:
> 	https://lore.kernel.org/lkml/20250911165433.GBaML-yTUZHkywuJIe@fat_crate.local/
> 

Ack

>>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> ---
> ...
> 
>> ---
>>   fs/resctrl/internal.h | 29 +++++++++++++++++++++++++++++
>>   fs/resctrl/rdtgroup.c | 25 +++++++++++++++++++++++++
>>   2 files changed, 54 insertions(+)
>>
>> diff --git a/fs/resctrl/internal.h b/fs/resctrl/internal.h
>> index e62a277dee85..98f04a2a762b 100644
>> --- a/fs/resctrl/internal.h
>> +++ b/fs/resctrl/internal.h
>> @@ -314,6 +314,35 @@ struct mbm_state {
>>   	u32	prev_bw;
>>   };
>>   
>> +/**
>> + * enum kmode_state - Control or monitoring association
> 
> What does "control or monitoring association" mean? This is becoming
> an overloaded term used to mean different things and becoming confusing.
> For comparison, earlier patch introduced *another*
> "control and monitoring association" enum:
> 
> 	enum resctrl_kernel_mode - Kernel mode control and monitoring association

Sure.

> 
>> + * @KMODE_INHERIT: Inherit from the user-space task.
>> + * @KMODE_ASSIGN: Use the backing group's CLOSID or RMID.
>> + */
>> +enum kmode_state {
>> +	KMODE_INHERIT,
>> +	KMODE_ASSIGN
>> +};
>> +
>> +/**
>> + * struct resctrl_kmode_cfg - Kernel mode configuration
>> + * @kmode_sup:	Bitmap of supported kernel modes.
>> + * @kmode_cur:	Currently selected kernel mode.
> 
> Adding this comment during a second pass ... please consider later motivations
> about naming of these fields. This field is introduced as "kmode_cur" but when
> considering the language used in rest of series "active" seems more appropriate.
> 
> @kmode_sup could also just be @supported (the "kmode" is redundant).

Sure. Will change kmode_cur to "current".


> 
>> + * @ctrl:	Control association for %RESCTRL_GLOBAL_ENABLE_PER_CPU.
>> + *		Kept while %RESCTRL_INHERIT_USER is selected.
> 
> The "Kept while ..." does not seem to match implementation. Looks like
> resctrl_kmode_switch() always resets it to KMODE_ASSIGN?

Yes. Will remove the line.

> 
> At this point the reader is left to decipher the architecture via cryptic
> changelogs and inaccurate comments. It is very difficult to parse.
> 
>> + * @mon:	Monitoring association for %RESCTRL_GLOBAL_ENABLE_PER_CPU.
>> + *		Kept while %RESCTRL_INHERIT_USER is selected.
> 
> Similar comment about "Kept ..."

Yes. Will remove the text.

> 
>> + * @rdtgrp:	Resource group backing %RESCTRL_GLOBAL_ENABLE_PER_CPU.
>> + *		%NULL while that mode is not selected.
>> + */
>> +struct resctrl_kmode_cfg {
>> +	DECLARE_BITMAP(kmode_sup, RESCTRL_NUM_KERNEL_MODES);
>> +	enum resctrl_kernel_mode	kmode_cur;
>> +	enum kmode_state		ctrl;
>> +	enum kmode_state		mon;
>> +	struct rdtgroup			*rdtgrp;
>> +};
>> +
>>   extern struct mutex rdtgroup_mutex;
>>   
>>   static inline const char *rdt_kn_name(const struct kernfs_node *kn)
>> diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
>> index 68be9b903ac6..7c39792be1fa 100644
>> --- a/fs/resctrl/rdtgroup.c
>> +++ b/fs/resctrl/rdtgroup.c
>> @@ -76,6 +76,9 @@ static void rdtgroup_destroy_root(void);
>>   
>>   struct dentry *debugfs_resctrl;
>>   
>> +/* Kernel mode for this system. */
>> +static struct resctrl_kmode_cfg resctrl_kmode;
>> +
>>   /*
>>    * Memory bandwidth monitoring event to use for the default CTRL_MON group
>>    * and each new CTRL_MON group created by the user.  Only relevant when
>> @@ -2297,6 +2300,26 @@ static void io_alloc_init(void)
>>   	}
>>   }
>>   
>> +/*
>> + * Set RESCTRL_INHERIT_USER as the default when the platform supports
>> + * allocation or monitoring. Otherwise leave kernel mode unsupported.
> 
> This (and why) would be useful to describe in changelog.

Ack.

> 
>> + */
>> +static void resctrl_kmode_init(void)
>> +{
>> +	if (!resctrl_arch_alloc_capable() && !resctrl_arch_mon_capable())
>> +		return;
>> +
> 
> This check seems unnecessary? resctrl_kmode_init() will only be called
> on a system that is capable of allocation or monitoring.
> The planned AET changes will change this behavior see
> https://lore.kernel.org/lkml/20260928221509.68002-16-tony.luck@intel.com/
> but in that case it still seems as though initializing the kernel mode as
> below always needs to be done.
> 
> That begs the question why is resctrl_kmode_init() needed at all? Why not use
> a static initializer?

Sure. Will do.

> 
> I find resctrl_kmode_init() to be potentially confusing since it does *not*
> actually initialize resctrl_kmode. This is only possible to see two patches
> later where get_rdt_resources() is changed so that x86 sets its supported
> modes and this runs *before* resctrl_kmode_init().
> 
> If anyone decides one day "this initialization code is missing a bitmap_zero()"
> then it will break PLZA.

Sounds good. Will remove resctrl_kmode_init() and statically initialize 
resctrl_kmode.

Thanks
Babu


