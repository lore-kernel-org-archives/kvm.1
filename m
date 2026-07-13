Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012008.outbound.protection.outlook.com [52.101.43.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D37734B410;
	Mon, 13 Jul 2026 17:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783964302; cv=fail; b=F/H9Os+uEBfUdvjAyQzCojclUdNpNBt/sbYY5C6HJPAe9Wph1ZPYixT+scGELereu/5hyq7r16U4x7zoH7y23y/BPbvm4m4TrJxsC0YVesVZxzrBQ0HsqRPuEXo0RKrkwti0M+9j+kleOBMSGD2NLaVuRINNTQkzojYp0jbRBL0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783964302; c=relaxed/simple;
	bh=rhIi2Eq4oenIskdfq9C4mrCaWZoddiBHzLiB91OVVQo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VC/szhc0fO9r1vHPUoVivvSK41pgq6QqrxxK2RrnTUUlPAhf//uSa10azo7eNeVd810H7j8rtMz10h7ON3K7eIUcJ/kOc2tBhdHmjK4xwbfzkqL0lc3g3Nl4K2IVv4vDxkb0fYV2qhs+z9m8UWYn2T0R7rq5H2TI3gkDWlY0j4U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wCzso5vL; arc=fail smtp.client-ip=52.101.43.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wCzso5vL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KQGAfQSJdErH+fnK353muCq2WlO948mvUjDRGpdfRIG+wQSMI/JuKWkiYAoOgqv+oaF0mxvMQ2qLqN/Z2TR6BzoDyI+f7o5ZUIJHOQ2bXjo2GJUjdtLiXNy+QS1g0hOxoUN2k+7IekWzvKgBk6ji1ymsXwpprHifjD+ofD82sVBLMAuDJ+ajSoY7XhUim9hTeOEX/SjujGw5kmizisxV1KGOH5sjSUB/WH0AuTad5n1ncFOd65qS0cVzITyOpJE04FFKpsSI/JhNQtkL3b3MUGfL8qXFtCEIMO4D84LZ46aNgu5ZaTZIla90FSBupypGaAcRx+IPViBwW2eZwatruw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EYd7Tryhav2e8EaBPg0P7xRcZqSTDLWZ0qoBwZ1IfMk=;
 b=Fp3qj0rXWWzeun+v8swqmjbZUTC5+yWFOtNyS49NMrSBla0nk42AjD8ydjCNcchKWbzTF+Sb6mEKC5SnsgWOsJaouRlTKwFtgJ/kOhbE57VkuiWLHA9rG6Su+xn3+ymeYvKppDnR25iWPncahNqoe7FiXJBc12a3Q/y/QZ5nY3S4s71/fm8hnKNCCBWQ79dO+vbuCoWfIEUgNuTt0Zeng3FolRqe5TCwDhZ295SCtuVIpXUUy3NDN21m4RF0g+JfPJGXqvrMRImK7ZqV8FOFHqF9yLku7OWNSQK5FEkmBA0e/V+cMCRiBrVnffIe4WSH7BIYZ8jY64n0NchngIVeSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EYd7Tryhav2e8EaBPg0P7xRcZqSTDLWZ0qoBwZ1IfMk=;
 b=wCzso5vLXLgTQAQzPgzzCCfIyr95TuUhowcjFX/YJi7WZIh4xHlkl2bq1fmlGjT2txL3pW8eyHl8sJ/wdxJP8bpLXmeIkU7SFtMivFLkfkCMVvYXlZnQi5bwtaGb2Nh0xNj/zQVE4Sm+UOT7WkoVKFEqnEhFcnXvnscry2+WjV8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN7PR12MB8131.namprd12.prod.outlook.com (2603:10b6:806:32d::12)
 by IA0PR12MB8896.namprd12.prod.outlook.com (2603:10b6:208:493::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.18; Mon, 13 Jul
 2026 17:38:16 +0000
Received: from SN7PR12MB8131.namprd12.prod.outlook.com
 ([fe80::c2dd:62c5:67fe:aa46]) by SN7PR12MB8131.namprd12.prod.outlook.com
 ([fe80::c2dd:62c5:67fe:aa46%4]) with mapi id 15.21.0202.014; Mon, 13 Jul 2026
 17:38:16 +0000
Message-ID: <531e7646-2051-4983-98e8-3e0d7c184f52@amd.com>
Date: Mon, 13 Jul 2026 12:38:13 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 01/27] x86/apic: Propagate APIC_SPIV writes to hv
 for Secure AVIC
To: Naveen N Rao <naveen@kernel.org>, Borislav Petkov <bp@alien8.de>
Cc: Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
 Nikunj A Dadhania <nikunj@amd.com>, Neeraj Upadhyay
 <neeraj.upadhyay@amd.com>, Tianyu Lan <tiala@microsoft.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, Thomas Gleixner <tglx@kernel.org>
References: <cover.1783490022.git.naveen@kernel.org>
 <891e7c5b74a9c027bc417a2dd32e23c0d4d0c336.1783490022.git.naveen@kernel.org>
 <20260710020349.GAalBTBSz6pX3FA_fd@fat_crate.local>
 <alEEqV6NshD-T2K9@blrnaveerao1>
Content-Language: en-US
From: Tom Lendacky <thomas.lendacky@amd.com>
Autocrypt: addr=thomas.lendacky@amd.com; keydata=
 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
 WiyqywZI5g==
In-Reply-To: <alEEqV6NshD-T2K9@blrnaveerao1>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR14CA0046.namprd14.prod.outlook.com
 (2603:10b6:610:56::26) To SN7PR12MB8131.namprd12.prod.outlook.com
 (2603:10b6:806:32d::12)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8131:EE_|IA0PR12MB8896:EE_
X-MS-Office365-Filtering-Correlation-Id: 16c23f68-48c1-4918-0088-08dee1058548
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|11063799006|56012099006|18002099003|22082099003|4143699003;
X-Microsoft-Antispam-Message-Info:
	ku6ka+9kzIqLlEx3uemGbhBQzfFCj6E8U9uzegi9sV3yXvCEr8t3z2kENcwX4zcp3ow9VX3Ubo47Nju27/QqZke/55UNfmNkIVks2W3Lj0vmHjaFRlx+DOf7SK1FH0u+FJMWnozZ3EXY8K/M7VH6EC4ONcBNPSW3zR084HfqGepKTZSuqsih+OQhhWH24lBjKej3s85CijYjA+tY7myoN1RcfOlu61TXqRSTnCanW+dmQdIQoFn8nvDtuTlE2E8o90Qv+4kUUO/BtmWLxt6YMn/nPok+T0tC/6cDhc+BTpknnxxP804AyQE7lFWJsLHhfGhZeIy35WJRzIIT+3BXFbTL+wSdB0JQIutJs4Zo1tZl2fFjqb90UBnQMZZA7aGh7OoRoVL0U2idDc37YmVOvSSl+5Asp3RObW4jcZEV4Ua9DFXaxMPbqDJicnT+FhAR0x6c+FKn+i14SI5s3dPBKmpYwhgm/M4ON1MjWSZ7WAScqVMJem7LECeddOsj27lZPnZL1NIR5nvGgKduesDF1c6Tf2urZ+OgEg+FyVpMaFF6KMUx7hsix3v6Eqvvcyonh9XMY6uIrhhU7PjEBd9ukZbYuSC9ycGjCt2R/0eTKM7rEp8+doMTMREOqhvLRpqDeQAuECEh/ag9GwDW6t7olsFbZhTPFXhpeI88QV0fcpI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8131.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(11063799006)(56012099006)(18002099003)(22082099003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZDFSQ3IvOGExS0FTY3ozaURUdWlVSHo5MTBCdWVWejFieEQ4OWsrZFA5Q0Vx?=
 =?utf-8?B?a3BNUjZaZnRidGp4WlAwUzhvcGJUOHZmWHNnR3VwYVV2WU5xVzgxekpRYnNX?=
 =?utf-8?B?Ylhad3lFaHA1L0tNdEpnRm5JMVg3R2laQ051eHBEY3kwYXgxdVAvSTN3ZzFY?=
 =?utf-8?B?L3FHbjdySW01NXN0c2M3LzA5cUxJS2FXNU9vcXJKNFk3cHE4eVBnRHZ0cWxY?=
 =?utf-8?B?Z1JQK3N5ckd2KzNvQVVrdUwvWFVFaE1rakhsUFJqN3ZZdm9zdE9BN1NOL2c1?=
 =?utf-8?B?T3ZRS25FSnlESkRuajVXczhYbStZYkhDKytoeG0vY2c1ZXFaMjNuLzlsSkVF?=
 =?utf-8?B?WDhuSG9UaFMvcnVlVXNISy9QM21Ua3NTejF2VElOWStRWG94dFhuUm1kOWZi?=
 =?utf-8?B?elY4WGtsazVkeVdnQTMwc3d1WHFNWnB2L0V3NmpCY0lFcHlWdlVLRWVzWkVH?=
 =?utf-8?B?d0lSSk5Za1UvSzRBbWJDVmRZK3ZjcEF0N3NyVm8xcFpBN3l5YW1zVHExL0NJ?=
 =?utf-8?B?VGtnVVlDYncyYk9qUTVUa0VOQUtlM0FRUmI4TFZycGhwaEVZalJBd0F1bVNC?=
 =?utf-8?B?WEI1VjZtVEtxSVNLem5LOHdZbzQwT0RtdUlzN1JhQXpMNGRTMVFpVkZubUdI?=
 =?utf-8?B?YTFBeHdwZ0c1UnZMZXFkS2o0OU55SEpvMnlQTkc5eEVpL2V3MmJXYXVtZnhK?=
 =?utf-8?B?SWJ2QUZwRnlNN2pTUm04UmE0YmlGMmRDZVpSa3czSXEyK2VNR3g4UE80NW1z?=
 =?utf-8?B?dlNNYWVoQjZBMHFicjRIT1BiemY3NjJjVVdTUDZsb3llY0V2ZjJ1TmJZbFVu?=
 =?utf-8?B?M1RJNUJ4M2JSM0Urak9aMjl0RDBxVzdLY2pYSTNZeVJOVXVaeUZIcU5oVDNQ?=
 =?utf-8?B?R3pUYVFpaWhWTmp0NnVpQTlwb0MrT21pcnV1Szk2YkhCN1A1TURVTFFzaXV3?=
 =?utf-8?B?NG1HNk81K1ZBbFpEdFd2WktnS2Yya2dmL2svU3VxREltSkJzenpDQkdvcWZV?=
 =?utf-8?B?Q0FaQjA5ZWV3bkVqUmJlMEhlUkR1MmhxVmRtWDFDb1E4T3VJN0dqTmUyK3lG?=
 =?utf-8?B?WlJxSC9vSUxZWHQ2VlN5R2cyWG81d3hCMDZwanlyNmsvd2lEV1ZmRVVoR0VG?=
 =?utf-8?B?TEpJdmpseTVKSUxJbjlHR0JLM3NFbGV2L3M1ZHIzajhBcjUzUG56bG53ZHRF?=
 =?utf-8?B?K014dHBUWTlpOThpQnhuY3ljSE11ZVMzSTIyMWtWWjJ0WTBaNm10MHVIVU1y?=
 =?utf-8?B?Smo0Z1ZsRmpSWmNNYzVwRGFJNmljakZRdEtKbDlBVGU3YktPanFubDFCR1lj?=
 =?utf-8?B?bWViYzEyTDh4Q2NsTUJ5dm1FcUdTZnhJdHRNRnBjcGErbTJUTUE3YjhReVNF?=
 =?utf-8?B?OW5aeU1RT1hBK3pzSC9DcWNab3V2K0RZZXNtRGl2NXhsMU9tMEgySEN3MjV3?=
 =?utf-8?B?RHIrSzhZNGR0N291aGZKd1VGakpPM29JNVErOTRJR0lDNWlZODZXb005Y0xz?=
 =?utf-8?B?M1VyUiswU3B4NElSSkdLZTJlRUhZWTZwVmduNFc5OGtlcTBFYTJjU1gxbUV1?=
 =?utf-8?B?bTNFQUYrSzdwYnZNbjFLRi90NHZ5dVJSR2I3UkgyVEZsNXRkRjQrRW9iYTlK?=
 =?utf-8?B?YVJITGw1OEZ0SFlGb0ZoNXpBS0FIaHFpVDJiSzdSOTdtOXlzK3VZREIyOTVM?=
 =?utf-8?B?cFI2bGtSQ1o4WjduV1Z1RnM3L0R5K2NybE1oVzVDZk9ZYlNSejN2bldSZUMr?=
 =?utf-8?B?a3Jtc0J2Qm5Zb3dLV2tyKzF2MFpFblI0ZStqYVRjSHdGUXBudE1rekhqN1hR?=
 =?utf-8?B?dU9aWWlDaklmTkZyTGsyaUE2MVErb3R0S2Jad3laUmVJeGlJV2d0TzQzWGdK?=
 =?utf-8?B?Qnd4QzJWQXQ5allaNEJacVRxek81cjlTSEFsWkZRR3hEYk9kc1VySW1VQWNK?=
 =?utf-8?B?cE9yQ1paSEc2V1RlazBFUTlqdm42SFRjN1MveXdLZDRHOVZzQlFlRy9lWXhD?=
 =?utf-8?B?U1dVSnJRdUIwem1VTVl2SmthZWQxTDkxdzR4aHJBaXJ3RjVkYndUOUpWOFZs?=
 =?utf-8?B?VFY0TWlEY2lzczNlWjhQWC9mK05QTEw5eXVxUWEwQ09oOVVRbnlpYlpiWGsr?=
 =?utf-8?B?VHorVmQzSHRGdVZ5cWI1ZmZpQ0k1WHlEc1ZMUWVKcFc1R2pEcis1RGFudTcy?=
 =?utf-8?B?WW1vWDBhUThQZWFMNnJ3S3RFZEJkZXZGL0IyRjBLcHBuNlBrRVFUUGhqWlVm?=
 =?utf-8?B?cWliNW9iU1VhUlovZEdudWJxMmF2Qys3UXJsT3VpL3N4TEtaVmJCZVF0a0Rm?=
 =?utf-8?Q?gqsUfIE7/QeIvdTBg7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16c23f68-48c1-4918-0088-08dee1058548
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8131.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 17:38:16.1708
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hXvF0Dt9lIwYJtqvSvyHmyOZtQkgELoLu8yTmFg/26CweQRzQJ4DYBS6j3rsgUdZPxg1T2cGHVsUpuGgvNnNUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8896

On 7/10/26 10:02, Naveen N Rao wrote:
> On Thu, Jul 09, 2026 at 07:03:49PM -0700, Borislav Petkov wrote:
>> On Wed, Jul 08, 2026 at 12:01:59PM +0530, Naveen N Rao (AMD) wrote:
>>> From: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
>>>
>>> Hypervisor needs to be aware of the VAPIC's APIC_SPIV state for
>>> LVT masking/unmasking. So, propagate the guest's APIC_SPIV
>>> writes to the hypervisor.
>>>
>>> Fixes: c822f58a4fab ("x86/apic: Populate .read()/.write() callbacks of Secure AVIC driver")
>>
>> What is that patch actually fixing?
> 
> Guest doesn't boot without this change.

This sounds like something that should be submitted outside of this
series, especially since this is an RFC series.

Thanks,
Tom

> 
>>
>> Does it need to go to stable?
> 
> Yes. I will tag stable on this.
> 
>>
>> SPIV needs to be masked and unmasked by the guest?
>>
>> Doesn't seem too earth-shattering to me but what do I know...
> 
> APIC_SPIV has a bit to (soft-)disable the APIC. It starts off disabled 
> and the kernel has to write to it to enable the APIC. If writes from the 
> guest are not propagated to KVM, KVM does not deliver interrupts to the 
> guest since the APIC is disabled as far as it is concerned.
> 
> I will update the commit log with these details.
> 
>>
>>> Signed-off-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
>>
>> verify_tags: WARNING: Sender ["Naveen N Rao (AMD)" <naveen@kernel.org>] hasn't signed off on the patch!
>>
>> When you send someone else's patch, you *must* put you SOB after hers/his.
> 
> I was genuinely unaware of this. Just so I get this right:
> - Add just the 'Sob:' for patches from others that I post un-modified 
>   (without a Co-developed-by: tag)
> - Add 'Co-developed-by:' if I make any changes to the patch (commit log 
>   included?)
> 
> 
> Thanks,
> Naveen
> 

