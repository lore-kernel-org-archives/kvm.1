Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012020.outbound.protection.outlook.com [40.93.195.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A717C37880E
	for <kvm@vger.kernel.org>; Fri, 24 Apr 2026 16:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777047922; cv=fail; b=uzCUwExXM6EWLmqFLXJVTGCJ6nUn2LCnZtpMqM9aVWuLXLVfpQs+1vax9q2uw1vwe10iz8HHJ4YKyhqMIO6+o9KAgHbhA6C/RyvjPWSZZsfR7Ek+jCXyWM2deKqiO02pF4E+xm31cTJf1v9ffUyNJt+07c/l4h6O4Lsz8yX5mfs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777047922; c=relaxed/simple;
	bh=75PMTFMBrc/6N1Q2Qh68jXGvxL2XekogrsZ3Q2E13ec=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=J8RNeAMMjaDbUAYlu1DuA6BH+TkJqTnuHe4Oi4qdrQwQzqewF1Ybo+M1NOxmzN9ttZhGSJzYkEO5ZMPRKK/7OurLhokde5RmvdNGQHV8OhMow6QSOtOHRBcGHoqBlymkIH7U6WGstb9kjlRDKNVksg4jOhaagkxK4j3D5dAaTUg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=x3RjeTWa; arc=fail smtp.client-ip=40.93.195.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="x3RjeTWa"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SXIw+7RqS3JEL8U76TOBXSAGJoBcCulYxUAfAEE4hk//PgUHzhfw2sY6Mh+Md6WUX9rdKa973QqCdGOK5Fr4oaNBiXMAPq5d3PjRlb/8wk7GM2CthO7/rVNH2hA1+7R3kYH3YqYvVAOnTJmpWQlLpFo7h07U536IKkXr3aOwhrWPMba+770FKZN1oqvWt0aqwB+7LqVZZl4OmtgbuRfarDiONalK9zL7SoY8dBvwGM1tWdb7xIp0ymKZhpl1lZCzlygsG9k1tkN9nUjh3QGxZnxp7OLcq+TvXU4tsJMWZsQM6/EYIHYMBIdk2GP+qH7A/5L2d7nOWKOi0mj8q29JQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HXtqEiFNiC8Sk2OyOYerIKMSoS0Psyn7f8+CWMyZIA0=;
 b=SLigdLoCTGJOeNo09ZcpFtXnsYJScMJbSpM1WOW+6XDsst54Jg3WKIpNvuQQ9aq271P8wBsk48659JbYirKuP7l6beoeT9s7WbPru1cXKbrxWzYIyWGDdxPFViBM+BMZ/xwzC3kqm60zdmFc9nHXKR+xUxJBbOuLVuzgo4GhCtbXV9VKlfORCGfjZ0bGHptyhTfZnRQ064n83A5kg5bsPTqo0X4FSMnEqY3nWljDSVkYRc7s4bsWYS9ZWKFcZRjQ+IFB960EMTsnbqSOwKnc9xlfLGTShaPJKJYrj+dHMKSjykjZuhoOEvfc4dSRmVY1QxyjCecgJ3Xxh2XOURCSog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HXtqEiFNiC8Sk2OyOYerIKMSoS0Psyn7f8+CWMyZIA0=;
 b=x3RjeTWaIs1WTHeO+8MS4QvHlOH8Lq048ne2178xoSbkD9P8gxoGqkGThCqXHKU7AOeXdXlwojtf0qb4bQvZMRg9z8t9MncfJF/xLQhGCzBbRlYIxBadI0MoqIguPlWnM2Vgn92pP231ObHYSucv0ofiQ/P1IZUpZGAPDbrHLyA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5070.namprd12.prod.outlook.com (2603:10b6:5:389::22)
 by DS0PR12MB8455.namprd12.prod.outlook.com (2603:10b6:8:158::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.22; Fri, 24 Apr
 2026 16:25:17 +0000
Received: from DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::f3f2:852c:78d5:9353]) by DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::f3f2:852c:78d5:9353%4]) with mapi id 15.20.9846.021; Fri, 24 Apr 2026
 16:25:17 +0000
Message-ID: <6688fe2e-c723-404a-80e1-3f4c5f5cc4c6@amd.com>
Date: Fri, 24 Apr 2026 11:25:15 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 7/7] KVM: SVM: Add Page modification logging support
To: Sean Christopherson <seanjc@google.com>, Kai Huang <kai.huang@intel.com>
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "nikunj@amd.com" <nikunj@amd.com>, "bp@alien8.de" <bp@alien8.de>
References: <20260407063245.2755579-1-nikunj@amd.com>
 <20260407063245.2755579-8-nikunj@amd.com>
 <34cfe5e8-756a-435a-a73d-54bf69801161@amd.com> <aeeS7LDPJ6NCy3Uw@google.com>
 <3e4641288d7791919abf1a5b02b80431285484e5.camel@intel.com>
 <aegWmKk8uK5r10dM@google.com>
 <977e805339a29ab789650aa18cd320dd1e9e0c25.camel@intel.com>
 <aejLG_w8H16EifMj@google.com>
Content-Language: en-US
From: Tom Lendacky <thomas.lendacky@amd.com>
Autocrypt: addr=thomas.lendacky@amd.com; keydata=
 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
 WiyqywZI5g==
In-Reply-To: <aejLG_w8H16EifMj@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH3P220CA0023.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:610:1e8::29) To DM4PR12MB5070.namprd12.prod.outlook.com
 (2603:10b6:5:389::22)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5070:EE_|DS0PR12MB8455:EE_
X-MS-Office365-Filtering-Correlation-Id: 113fd50e-fd59-4734-2c93-08dea21e1279
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	xG3LZTOrtnDe478YPoBZRTbZaZ/DBg0DFgprEe6sDozdp+GDkq99TjLYTjCbf71aC/d2YymIw0PcP3/dZ+/KJep9UFMdPkQw/Tbw2UXPO39Cm3ssB6qq0yiq2cijW1BD9iHMcndL8fUvpxA386x2xEdWKMlpNmiPuki+6tDF+goINyI3831aT164Eg4DqWKwQk5ezD7/2I2j5NQ15rbRIgYnlIdM/rk20kZRhGEf8WvGY2lZMyX8WxY/RYa2ShVF9tPbfRGanijgWsC/VHfBN9ApkYyppg/5WOeJ0SJT7ZIBij4pr7+aFag4Iqdhr8Zov6ifq/Zd8AncOfSmYiOMOztkt4WpeBcKkkRuaBch2er+MtTa2rPvConslWtGSSxlLeitIjh27CNd8T6CYKZ8C9mNbU1Uh6EtN6CAveiIle3Xu+hRQfsIX7ekuoijLOEVatr+3Vm+lct/dA60BzpUpXwIS6UZ5WyeMx5g8M7n7/QyCpauNP1ocKoYPhfj2xRFoZIh1RhlAY1PcG3qlc3eg2vXDhREGP5wJHGfiCl+s5dUIBNSpptZEUweLe2NK8259uVicpWy6GGe95Qk7RAXCVWTQWxAcbQYjbouYO7tVOCt2TfTRpymBNX8mm4rcKYT47CSFBHEpxarD78tBBz4n0egi7EpO2ahTqwvTIEY0otw0K9q10Dkz/p2WL6zpYWUsA5QN97qXaXZr0gy5+7PwGM9yQDvx1FezHcqZTIb00k=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5070.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U2g2YksrcGxpRHA1c1JVR2Q4YXlxcStKb2ZwWHVDRnExMVhKcXNqc0t0RGVx?=
 =?utf-8?B?T1ZZY09KNVJERlZ4b1hod1YwMW1vRFdNbS9ZbDQ1bW5uTW12OWxIMCtYS3Br?=
 =?utf-8?B?d25LOGgzRUI3QzBzTHZDRnVtcCtGeHdUTno4bFpOMUJITnErUGx3eHJ0TEV5?=
 =?utf-8?B?Mm9rTmE0MnJnRTJYSDlrM3VmQWd3YUcvUklySE4xZmRVUXN3czNzUVRVaE5s?=
 =?utf-8?B?b1BNR3BUd3RTekhkcVU1QkVEdWF4MjlIMkV6VDN0YkpTOWw2blIrUmVqR0l4?=
 =?utf-8?B?V3F1QTdnckZDOUJuMENlWmNVSUIrUWpXSXhsSjhoanBqV2dpR25RYXN2cnFh?=
 =?utf-8?B?ZFlZWWMzam5QazJGUitOR3VxY1F6STJtMit5Tkp1K3FFYnFjT2tOQ3RKSHdH?=
 =?utf-8?B?RGxNZnNuTE9va3lVQVNYVDVscE1pbmxmT3VqZ3U4VU9FclVWbkF6YmVYZmc4?=
 =?utf-8?B?UFk5NXJtc2UzNXpsOVp2aW44ak1KeXpCdTV6amlnWXAvZ0ZUSWFjYjlnMXNW?=
 =?utf-8?B?WDBIaHFwa2NQOWVENDJtS3UzVzZzcDZ6L09sSXJtazZ5RGZGZ3lYZmJJcmdu?=
 =?utf-8?B?NUQ5ZlFvcFdZdDJRNXZIS2wwMkRXNHBQVVgzQ2JjWHF5bStXdzljdTNhOXor?=
 =?utf-8?B?QlVtQmpLQWlEVVJ1WlVGMmRPT0dBaW1oWWhFR3R3WnZRSWRPeW1RVDBYdk1C?=
 =?utf-8?B?ekljZi8vekVxYUxRNzQrYmdqVzFDeWxncTZEdUJ5WllPU1RTN1hEcnJQK1Ay?=
 =?utf-8?B?WXhzNGQ0aGk3WGZCcVBIVzRVeXVIeStGWW1KbFlYUG00QkFtQW1xU3JBaVpp?=
 =?utf-8?B?K1k3MFQ4clFEZm4wb3F3L2ozczNkQUNaemRudkU3NWZjdEdpQXZpZWYwbzQ5?=
 =?utf-8?B?d3dEbENWZEVKVndOQU1zUTNZemlkQyt5YVB6NkM5L0xUQW1FbkQzbTQxaXFn?=
 =?utf-8?B?STlsVmJuZk1OaEVrSU16WVBaMXo4YXdLRVplODhhRzZ4NlBRVG4zM0FuTUZW?=
 =?utf-8?B?dE5LRGkrMGpObExUaFh2MmdldTF2Y1hzUS9POVh1TWhlTms3aHU0Rks2M2M5?=
 =?utf-8?B?ZUxNcXJ0U0lsc3J3b1BEQjZaTGxia0p1WWRDeEtXeGRVVFk3SnZ6c3lTdlpR?=
 =?utf-8?B?TDZVb216RWsvUXBlTnFrTGU2YmxVZ1pIRDZ5K0Z3M00zK2JJbEZIVzB1NDlH?=
 =?utf-8?B?U29YZ1ZZM01QU2d0SW1LdkNyRmt1UDBxbFBPRk9LZUNSaWJ0TC9iM1pQRzhI?=
 =?utf-8?B?TFhDMGdQTVhYcnRROUJ5STVvOHVCTWJsdDcvNnRlZDVIVFc5cTNoUlpWTDBB?=
 =?utf-8?B?TWp0d0hXeHc0ejZzbFFWSTZ1OFBIRWtSTDRWU0J0ZndlM2xLdTBQYWtDdUNM?=
 =?utf-8?B?NmZhR0FZMmZJZEt2Y3YrN01qVWtJNG9POGZZdklLN0JYS0dWckNqRCtuTlhr?=
 =?utf-8?B?REdOdnZIUHgreExuYXdSV0FjTmpIV2JnTm8xRjE3bVBGb2hXLzBkMmltd0pB?=
 =?utf-8?B?WWtzMlZlcENqNWF0eTh5QzFJTEtYeGxEREVubzA4cGM4dHVxazFPV2R0cWxK?=
 =?utf-8?B?aW1FdjJUc3hDZGdVdG5IdFR4N1M2Qm80Sm9ncWUxV0c1OHIrcUNnRkVlUm0v?=
 =?utf-8?B?MlBISzVLV2hRcVEwbkJNcXh3UUt1NnozOW5ydUcwaHJPL3NobFg3Z2w4Y0RC?=
 =?utf-8?B?TFlvUkRkdXZmUWd5bXA4azNaWDI2a0s3VkUwaGF5SkV1L3c4OXowQ3J0WlYx?=
 =?utf-8?B?ZXFhZmk3TDVhWUlLTkc4aVJxQ1Z1SFJBNFlMY3hVcFlLRVJpZHI3aEd6SWxG?=
 =?utf-8?B?Sy9WR0NkSVNERDczNEFwQ2FJTnQzYi92YjY2L3FRcG51TStFbWNwSWlvb0h0?=
 =?utf-8?B?MG80djRCK3ZQeEpvNkRLZTNlS2E2NFNheFZIRUk1TmtXQlFOZWJSc1dMZzJv?=
 =?utf-8?B?bFhSR015dTg5WnBhak9pQUg3ekN6UUNoV05hVlJPRmpNQlZHUWdJTi9DQTJQ?=
 =?utf-8?B?UlFFcktoNDdVaWdrUDNsWDhsZTlmUis3a0tJdXZ6TStIZUZ0NG85MDd2KzBo?=
 =?utf-8?B?bTBrL1lnaWFFUytVTHBTd1l2UFZ5Z1IyaDBQam9obE12eHlRZy9TM3hxMDRo?=
 =?utf-8?B?VWRIdG5WR094OTA3bnZEK1pJUkN6WU8waFRlUGk0dmFrM2F3YUxvRTVVY0dJ?=
 =?utf-8?B?ZGIwTFNMRGhOelNxWHRZOUFhcjV4ZWJweTVremRhMlp5T0I3RmxQT1JwQ2JB?=
 =?utf-8?B?Q2FKRTdnOVRZaWFHR21haVNmTWJJTXE2c21YZUd0NTBZa1UwS1lnNFBJRTlq?=
 =?utf-8?Q?1BQP+yiifbMpx+8Rnl?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 113fd50e-fd59-4734-2c93-08dea21e1279
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5070.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2026 16:25:17.7915
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EErCNY8x3JcKc5rOvQNfIYa5plKdywYGGIvQaFREuK55AWjxwdHtB5l6B0z+yKgVMKfm+UHBHl4UzdDY3m3W1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8455

On 4/22/26 08:20, Sean Christopherson wrote:
> On Wed, Apr 22, 2026, Kai Huang wrote:
>> On Tue, 2026-04-21 at 17:30 -0700, Sean Christopherson wrote:
>>> On Tue, Apr 21, 2026, Kai Huang wrote:
>>>> On Tue, 2026-04-21 at 08:08 -0700, Sean Christopherson wrote:
>>>>>>    vCPU Reset:
>>>>>>      vcpu_enter_guest()
>>>>>>        ├─> kvm_check_request(KVM_REQ_EVENT)
>>>>>>        ├─> kvm_apic_accept_events()
>>>>>>        │     └─> kvm_vcpu_reset(..., true)
>>>>>>        │           └─> init_vmcb(..., true)
>>>>>>        │                 └─> control->pml_index = PML_HEAD_INDEX -- PML buffer was already flushed
>>>>>>        └─> kvm_x86_call(): Next VMRUN
>>>>>>
>>>>>>> Could this result in the hypervisor losing track of dirty memory during live
>>>>>>> migration, leading to memory corruption on the destination host, since
>>>>>>> svm_flush_pml_buffer() isn't called before resetting the index?
>>>>>>
>>>>>> AFAIU, no. The PML buffer is always flushed opportunistically at every VM exit.
>>>>>
>>>>> Huh.  There's a pre-existing bug here.  Commit f7f39c50edb9 ("KVM: x86: Exit to
>>>>> userspace if fastpath triggers one on instruction skip") added a path that skips
>>>>> kvm_x86_ops.handle_exit(), and specifically can give userspace control without
>>>>> going through vmx_flush_pml_buffer():
>>>>>
>>>>> 	if (unlikely(exit_fastpath == EXIT_FASTPATH_EXIT_USERSPACE))
>>>>> 		return 0;
>>>>>
>>>>> 	r = kvm_x86_call(handle_exit)(vcpu, exit_fastpath);
>>>>>
>>>>> Given that SVM support for PML is (obviously) on its way, it's mildly tempting
>>>>> to add a dedicated kvm_x86_ops hook to flush the buffer on a fastpath userspace
>>>>> exit.  But, I dislike one-off kvm_x86_ops hooks, and that only works if there's
>>>>> no other vendor action required.  E.g. very theoretically, a fastpath userspace
>>>>> exit could also be coincident with bus_lock_detected.
>>>>
>>>> Seems vmx_vcpu_reset() doesn't reset PML index upon INIT event, which seems
>>>> to be fine since we are not losing any dirty GPA tracking AFAICT (otherwise
>>>> we already have a bug for VMX here)?
>>>>
>>>> How about doing the same for SVM?
>>>
>>> We don't really have that luxury.  On SHUTDOWN (even intercepted SHUTDOWN), the
>>> state of the VMCB is technically undefined.  I.e. KVM needs to write _something_.
>>
>> You mean KVM needs to reset VMCB to reflect the architecturally defined INIT
>> state for a vCPU?  Or the hardware itself may reset VMCB thus may reset PML
>> index?
> 
> Neither.  The APM states that the VMCB is undefined after SHUTDOWN.   PML index
> could be anything:
> 
>   15.14.3 Shutdown Intercept
>   When this intercept occurs, any condition that normally causes a shutdown causes a #VMEXIT to the
>   VMM instead. After an intercepted shutdown, the state saved in the VMCB is undefined.
> 
> KVM synthesizes an INIT because it's the least awful option.
> 
>   static int shutdown_interception(struct kvm_vcpu *vcpu)
>   {
> 	struct kvm_run *kvm_run = vcpu->run;
> 	struct vcpu_svm *svm = to_svm(vcpu);
> 
> 
> 	/*
> 	 * VMCB is undefined after a SHUTDOWN intercept.  INIT the vCPU to put
> 	 * the VMCB in a known good state.  Unfortuately, KVM doesn't have
> 	 * KVM_MP_STATE_SHUTDOWN and can't add it without potentially breaking
> 	 * userspace.  At a platform view, INIT is acceptable behavior as
> 	 * there exist bare metal platforms that automatically INIT the CPU
> 	 * in response to shutdown.
> 	 *
> 	 * The VM save area for SEV-ES guests has already been encrypted so it
> 	 * cannot be reinitialized, i.e. synthesizing INIT is futile.
> 	 */
> 	if (!is_sev_es_guest(vcpu)) {
> 		clear_page(svm->vmcb);
> #ifdef CONFIG_KVM_SMM
> 		if (is_smm(vcpu))
> 			kvm_smm_changed(vcpu, false);
> #endif
> 		kvm_vcpu_reset(vcpu, true);
> 	}
> 
> 	kvm_run->exit_reason = KVM_EXIT_SHUTDOWN;
> 	return 0;
>   }
> 
> Now, maybe the APM is trying to say only the save area is undefined, in which
> case PML Index is fine and can and should be left alone.  But if that's the case,
> the APM needs to be updated to make explicitly clear what fields in the VMCS are
> and are not valid after SHUTDOWN.

I'm checking to see if I can get clarification on this.

Thanks,
Tom

> 
>>> Hmm, actually, how is that going to work?  Dropping PML entries just because a
>>> vCPU hit SHUTDOWN isn't going to fly.  
>>>
>>
>> Not dropping, but just leave PML index unchanged.  The PML buffer itself is
>> still there unchanged, and PML is still working in hardware thus the buffer
>> will eventually get flushed.
> 
> As above, the PML index could be garbage.
> 
>> This is the case for VMX AFAICT, thus I wonder whether this also works for
>> SVM.
> 
> No, VMX is fine.
> 
>>> E.g. if a VM crashes while it's being
>>> migrated by the host, then it could end up with corrupted, incoherent data on
>>> the target due to leaving dirtied pages behind.
>>
>> If we leave PML index unchanged upon INIT as mentioned above, I don't think
>> we will lose any dirty GPA tracking.  But maybe I am missing something.
> 
> Correct.  The question is whether or not AMD's architecture guarantees PML Index
> will be valid/accurate after SHUTDOWN.
> 

