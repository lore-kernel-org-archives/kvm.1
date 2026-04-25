Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011001.outbound.protection.outlook.com [52.101.57.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 066FC14F70
	for <kvm@vger.kernel.org>; Sat, 25 Apr 2026 14:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777128354; cv=fail; b=dfSLd44Kveb9uv16xL5d5wyv6s8d9gstB6MibgBC5Et805EKvHW9oTIC15yOsPQdKtzmi9ByXF2In2niYwYYD/CxZGra14beBSh9U2fRutokuppCdrqS9AxuLQXtF1S037gPpyZKlWdhnqY1Gn+PoY5TuV19OMjMmgaDyW37fgA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777128354; c=relaxed/simple;
	bh=HtPU2Gx25nBvB+I3S/kVCUAlO0Jya/x9CRROh/FbRdE=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dOvIae9ui81ZdLLqc9SfMByYn0X7N7ph9E1R5NSxxIRjHX3mDMHUKkX2pCm8EIhwT60vkvEPcISiXERgU6De6z7JkoosBlLWa3kqfTViybb7NgeVH45SQgJJDMmnqnrz4kszzGh4G4y5aO23ZCBt2Lgq6IJ04Osm1B/lMFv0wNs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=SiC3DjsF; arc=fail smtp.client-ip=52.101.57.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="SiC3DjsF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uLI9UTp897rgS6J72qUgM6lkcCnzJ12hnfIx9ObRBV76QTOvnPr7kLGG9F2C9yUtBxD/W06zKmwu7bKLFxwkFu8nKG3L9KTfpciRde9pto5T/0WFUEJ03v2T5oiYDsNSYVJDVMLBbNsrKTL56UmpEZUQIFbXwe6/moJH9GtoUzKvdYLoGkg+K6eAh70ooHVwNMkuYthvGC6znVc52fzNbYiMOPrZI9ix0Xj5lGTtp9zMd19MSORT61+jfOOVy051lRLeliuDq/XCBcP3ppre1RLCPI9AQ9G2Uo3BMY6hfaLgmZ9KhgptOC+Nyg1g1lMOO6VBpt/EaUhdhUOXaAxo9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xB+CxVH3JvpcwHDm4Moto5pUruV6FDXSCs95hqlTlkA=;
 b=UDoAfWcOoGyi2VtWRyhvsEj5/YOMG+WrtvIO0t9giGHju2T6RKVfb975fU/iEmF5AvbnM6dEnPuevOuF6tEhlhA7gyntiJwusV6fq9+COuXJ4Aukh5kqdh0EnsNu55EgiHqZ4P6MJIuBixiPY0gynH64oRB/96SuBSUqZ4xAu7TrxeHoRX4NXzlfa6ayqrDlanlPu2fEW0sHgL5hCQXNhifcaRD/K0TQ3VzpRhvlM4oUzZvNmIftqsn8a/Nqo5WKHXvNzlDZ35BuVucPo5bTkRm9kZFoO40ctol5QNagRC3U4Loxz3IZbkDkpWV1Uqn2sDEdHttkDGnCyIxBRcRKrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xB+CxVH3JvpcwHDm4Moto5pUruV6FDXSCs95hqlTlkA=;
 b=SiC3DjsFtYvmRL1XornYRUAdaKit/zjwVcZWymkSPsRByoAcr/iIV9YRwy024aTFAO+MznV23wGBQRBbat9QHJjj20AEK7FozFV5nUR28pR9TFFMCUKRD/4p+JEfzWiB9K9aSwz6neRbcSUlzzcoa8VSrUj2iCXWNNSJTo4pKuw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5070.namprd12.prod.outlook.com (2603:10b6:5:389::22)
 by IA1PR12MB7687.namprd12.prod.outlook.com (2603:10b6:208:421::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.12; Sat, 25 Apr
 2026 14:45:49 +0000
Received: from DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::f3f2:852c:78d5:9353]) by DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::f3f2:852c:78d5:9353%4]) with mapi id 15.20.9870.012; Sat, 25 Apr 2026
 14:45:49 +0000
Message-ID: <cba2b1d2-f361-41b0-9990-af840f6e0726@amd.com>
Date: Sat, 25 Apr 2026 09:45:47 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 7/7] KVM: SVM: Add Page modification logging support
From: Tom Lendacky <thomas.lendacky@amd.com>
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
 <aejLG_w8H16EifMj@google.com> <6688fe2e-c723-404a-80e1-3f4c5f5cc4c6@amd.com>
Content-Language: en-US
Autocrypt: addr=thomas.lendacky@amd.com; keydata=
 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
 WiyqywZI5g==
In-Reply-To: <6688fe2e-c723-404a-80e1-3f4c5f5cc4c6@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR03CA0192.namprd03.prod.outlook.com
 (2603:10b6:610:e4::17) To DM4PR12MB5070.namprd12.prod.outlook.com
 (2603:10b6:5:389::22)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5070:EE_|IA1PR12MB7687:EE_
X-MS-Office365-Filtering-Correlation-Id: 260e475a-30c0-4e4f-471e-08dea2d95723
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|18096099003|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	QuAyXlDOdHFHmgud9sUKZD3FdLhseMpPWvLi+BJ8/IWgwY1pYYmKHpemdqwfpXj8IQnbOO3Y9pV4poGbT1fPBi4UB95NWEuaZ3UeIwHgvAY41tSJPq4kJF7hH+RrimqYTNJPLjvVySw94e5vJUfWtlUrlKyWUIJzv0xBo7g91/4BqYJI72c4DL8ZqB3isGCknN+JwPI6ftVHSDRpod6MDF5VcwCu7e/NSldSnmxbEKKVSny5cCO254y+bjcfjAUx9Nn5s1XEgBtwOLOxeLlA7Sw0NV4TfDAbm+j2Ok2JFCU7sAfD78xrTwyRzmSuR4WtNPIbb3IDdB4h/b/7KeWsE974BSCcpu1Dm7PK3XN5tKuVwHOO5WQ3++L8aMbWiOC/zh5bxK6xuvmGp4/biwLUW/GO+2541KqAwtDWz49H1sqqZZvXrq4AMom97iDwUmWtipKtxkI8pGMOx9tj/KpeVdBZasOMQYDY8EC5eiC/7XKRs0qzPOJ8dKTJe2FmQ4a77xgDXr2pz/yCbER4hHiP2pr5DYq1CykcQ1zSoLnqol0sFlGOg9DwHpvgiidhiE9qk6OsewYWoTG5g/MRP098hGbuSZQLlti6rYjKtIJqAozI2sfiZaefCljXqT8V2g47/Lhr4j/pBguqtVT+M4WULLqkBw198AVHZj8mVzwp0BEoA1QWbw3/+l+9CTQxC1Lf21t2rJXrBR5PKmAlctndSAKowBG6iq+0bwpLQpeNS7Y=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5070.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(18096099003)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VlpYZjQvRHc5bVlVOHZJQkF0RTBuUkNZbGVZb3JmcEhnclB4bDdrbnhSSTRD?=
 =?utf-8?B?N3RHTHg5VzRnYlRzaFVTakhrVC9lcDZoeDM2c1J0SW9ZSzl0eUhFRUsvMHlX?=
 =?utf-8?B?UnNaYmE3QmJ2VkVuMG5wTUdGUU1Wd0VESHRKYTZ3M2x4THJhRWRMaGpVSlJY?=
 =?utf-8?B?dWZZSGhhVE9pNU80OGZ4QzRPbXRubGhUNytBSjkrRERyWHlNZE5qZzljN2dH?=
 =?utf-8?B?SDZFYVBuRWFieGlEVnFJcTdtMWtlRWdZZGo3YlFmZVp5NStBVHRDaStIN0FL?=
 =?utf-8?B?YlVrblVrbVFiUnFjNWpSMkhOVjNVUXMrUGtXWGpXckxES3ZJNHE0c1RoaXI5?=
 =?utf-8?B?ditPMUlTak5ndEtySHhZQnFsZXdaaHJ5WXBvdExZVWJFQW5QMWlnemYxK2JB?=
 =?utf-8?B?S1lobDRkUUJpam94c2VHRHFqd0ZlSEw1VmhQUFlMeVdyZzFDRHRxK3Nib3gr?=
 =?utf-8?B?UXdVNHl6akJVQzV4dGZtSTFGeFpBdjVFb0VNT1FuYmZIOStWSmdXNFU2bVR4?=
 =?utf-8?B?NjNaNTVwNTRsMFR6OENJRGdGdkVvanBOdEFiaGVGNjFRSy9pSHgwUWNQb1Fj?=
 =?utf-8?B?Q1VpZHIrMkVNYTVYekJIN3NOZS9TS1IxTFl2UkY1ZnFhSnk4RXVRSU5HUEVR?=
 =?utf-8?B?S2djcktMb1JIU0V0UXI1Nk9GWkYxTFR5ZGVuVVcvNzdIT3UvVk9oV1NkT09k?=
 =?utf-8?B?M2pFcGZydUUwa1E5eVQrUTg5QVBFQXVPNkczODZtc29HcXkwaU1TYVJxcUhM?=
 =?utf-8?B?b3ZLKzJTZDZHenBQdnpMTkxGa1Z0cUE5UTJOUFpzNWdjVHpuUkc3N0lPaFVY?=
 =?utf-8?B?Q2hTTExQU0FkaDAzc2JxMjB5VVRHeXU5QVR3akYyRGZ6S2RseElaSE9aSWp3?=
 =?utf-8?B?VGUxSW9uOUpGNzlKNmlVSUFkVFdmZ293Q1dBUlJ3UnRGd0NUa2lZdm0vNVVI?=
 =?utf-8?B?eFBtZ0pEd3ROa1E2eHhOUzhaeThYZFRvalNRa0FzNmJISStQQkRwMjhqZFRX?=
 =?utf-8?B?T0EzUUxjZnhOTm0wckRHdGMxT2ppNE1ZYUh6Z3dOZDVZTGdYT2UzZU4vVEVT?=
 =?utf-8?B?aVRXR0VGZC9maHZIdFlXSDBCMStOQTFOZVFPTkl4cTBvK2FUSzFWL1c2UTFm?=
 =?utf-8?B?d2k2TW1zdm1lRWhvTXQ3UjFQUjlYcUJyN1U3MU1sSWpJay9GdXBIUVkvNDU5?=
 =?utf-8?B?UGgwUzB0ODBEcU5Xa1l0NWJoL2EzaGNjTlI0V2NZVVNqRVpiVkN6L2tFRThF?=
 =?utf-8?B?Mzc0Qlg4eEU4M25xWkRhdEF1UWVyckRveHM0eU1kMmczOGtxbDNsRjFadWcw?=
 =?utf-8?B?bWdjYmVmVUh5c0ZiRzlHWDB1NXE5TXVUODlKMlNGd3AwalRkVTI4eFMrTG51?=
 =?utf-8?B?em9iL0wrQWxtcy9SZXY1MFJDUjY1QVpTc2w5ZDdDY2N3cmJGY2VQZ2xGSit4?=
 =?utf-8?B?dnRaUFNXL2RqVFVFaEx0KzdzcWpKbmpMREIranowK0oraGFhMFgwWmt1TmhJ?=
 =?utf-8?B?dDBQR3ljUG9kUnZzNmtJSmRKam9tVSs2WWpGdDFmeUE1UjRhQS9Bbk5wdHoz?=
 =?utf-8?B?QnNRcjhQQWxodHE3K0Jzd0hyUGV6b1phK2tseWRoY3BWdFhaVEpaSFNOcGNj?=
 =?utf-8?B?bmVnSmhPaENQZk8zb290Z2FFdHA1WXN1bVR1OWZZZzhxOHdYV2pSd0xSNVFV?=
 =?utf-8?B?RWYzOUl3M3NoRmpJNmNaNE91bUtueVFFejlGR0krZU5OZ0NUcmhMVE4rdldr?=
 =?utf-8?B?N3VjcW5KRkR1MFRGNENVakVWV2diV0FSelZwVmZQclZDSFd4TGFXYkpRaDF2?=
 =?utf-8?B?RzZ4QWRUNUxReHYrR0hCSFM0OEVnc2w2akxjellGT0I4dXNzTTA5elNoTmt2?=
 =?utf-8?B?Rms1aFNTa2o2RkJpMXZ1dXREYlQxZXZ4MEhlMy80bkpSM2g3ZlZJb0lvN3RX?=
 =?utf-8?B?R2F4S0w2OGQrQ000NXJ2M2YraitzazNVTWlabDJwai9CUU9XKzJnWEE4R01W?=
 =?utf-8?B?cGNRK0F4Rk45bnp5NU1SVkNIeU40SWM4OU1idjdwQXEwMXpKTmU3Z0crc2lR?=
 =?utf-8?B?cUo5cys5S3duYTFsUDhKb1BSTDhrV1NVZWpFcEVUYWRXckRlMjk2aEZWa1hQ?=
 =?utf-8?B?M2VSYlJVcy9qVVNPQ1BjQ3Q3aktXd0N2M3QyL29sOHQzQzlvZnpvU0RUQmF2?=
 =?utf-8?B?WkRZbyt4TGoybnNUNFVJVjdpL2p1YzhndE1oQ1RsZUt0b3g2UytsaXBhNis5?=
 =?utf-8?B?UEVCaE1oQkJON2hQS2hKN2NIVGtsSk1kNUdQbWpzRFFrdVA2LzBKNCtUNmRV?=
 =?utf-8?B?SVNoWDgxR2t4NEh0OWFOZzNzT09xYTY1RTRmUWs1V0xHbWtMTlM4QT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 260e475a-30c0-4e4f-471e-08dea2d95723
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5070.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2026 14:45:48.8503
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f+fksSm4P5WjoyYT2zouY3fxSGPngeqaNr4uXiLWJygvzw0EmFjBaO/fxx+UMgJnsO56pM+p76VY/llrBIWgZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7687

On 4/24/26 11:25, Tom Lendacky wrote:
> On 4/22/26 08:20, Sean Christopherson wrote:
>> On Wed, Apr 22, 2026, Kai Huang wrote:
>>> On Tue, 2026-04-21 at 17:30 -0700, Sean Christopherson wrote:
>>>> On Tue, Apr 21, 2026, Kai Huang wrote:
>>>>> On Tue, 2026-04-21 at 08:08 -0700, Sean Christopherson wrote:
>>>>>>>    vCPU Reset:
>>>>>>>      vcpu_enter_guest()
>>>>>>>        ├─> kvm_check_request(KVM_REQ_EVENT)
>>>>>>>        ├─> kvm_apic_accept_events()
>>>>>>>        │     └─> kvm_vcpu_reset(..., true)
>>>>>>>        │           └─> init_vmcb(..., true)
>>>>>>>        │                 └─> control->pml_index = PML_HEAD_INDEX -- PML buffer was already flushed
>>>>>>>        └─> kvm_x86_call(): Next VMRUN
>>>>>>>
>>>>>>>> Could this result in the hypervisor losing track of dirty memory during live
>>>>>>>> migration, leading to memory corruption on the destination host, since
>>>>>>>> svm_flush_pml_buffer() isn't called before resetting the index?
>>>>>>>
>>>>>>> AFAIU, no. The PML buffer is always flushed opportunistically at every VM exit.
>>>>>>
>>>>>> Huh.  There's a pre-existing bug here.  Commit f7f39c50edb9 ("KVM: x86: Exit to
>>>>>> userspace if fastpath triggers one on instruction skip") added a path that skips
>>>>>> kvm_x86_ops.handle_exit(), and specifically can give userspace control without
>>>>>> going through vmx_flush_pml_buffer():
>>>>>>
>>>>>> 	if (unlikely(exit_fastpath == EXIT_FASTPATH_EXIT_USERSPACE))
>>>>>> 		return 0;
>>>>>>
>>>>>> 	r = kvm_x86_call(handle_exit)(vcpu, exit_fastpath);
>>>>>>
>>>>>> Given that SVM support for PML is (obviously) on its way, it's mildly tempting
>>>>>> to add a dedicated kvm_x86_ops hook to flush the buffer on a fastpath userspace
>>>>>> exit.  But, I dislike one-off kvm_x86_ops hooks, and that only works if there's
>>>>>> no other vendor action required.  E.g. very theoretically, a fastpath userspace
>>>>>> exit could also be coincident with bus_lock_detected.
>>>>>
>>>>> Seems vmx_vcpu_reset() doesn't reset PML index upon INIT event, which seems
>>>>> to be fine since we are not losing any dirty GPA tracking AFAICT (otherwise
>>>>> we already have a bug for VMX here)?
>>>>>
>>>>> How about doing the same for SVM?
>>>>
>>>> We don't really have that luxury.  On SHUTDOWN (even intercepted SHUTDOWN), the
>>>> state of the VMCB is technically undefined.  I.e. KVM needs to write _something_.
>>>
>>> You mean KVM needs to reset VMCB to reflect the architecturally defined INIT
>>> state for a vCPU?  Or the hardware itself may reset VMCB thus may reset PML
>>> index?
>>
>> Neither.  The APM states that the VMCB is undefined after SHUTDOWN.   PML index
>> could be anything:
>>
>>   15.14.3 Shutdown Intercept
>>   When this intercept occurs, any condition that normally causes a shutdown causes a #VMEXIT to the
>>   VMM instead. After an intercepted shutdown, the state saved in the VMCB is undefined.
>>
>> KVM synthesizes an INIT because it's the least awful option.
>>
>>   static int shutdown_interception(struct kvm_vcpu *vcpu)
>>   {
>> 	struct kvm_run *kvm_run = vcpu->run;
>> 	struct vcpu_svm *svm = to_svm(vcpu);
>>
>>
>> 	/*
>> 	 * VMCB is undefined after a SHUTDOWN intercept.  INIT the vCPU to put
>> 	 * the VMCB in a known good state.  Unfortuately, KVM doesn't have
>> 	 * KVM_MP_STATE_SHUTDOWN and can't add it without potentially breaking
>> 	 * userspace.  At a platform view, INIT is acceptable behavior as
>> 	 * there exist bare metal platforms that automatically INIT the CPU
>> 	 * in response to shutdown.
>> 	 *
>> 	 * The VM save area for SEV-ES guests has already been encrypted so it
>> 	 * cannot be reinitialized, i.e. synthesizing INIT is futile.
>> 	 */
>> 	if (!is_sev_es_guest(vcpu)) {
>> 		clear_page(svm->vmcb);
>> #ifdef CONFIG_KVM_SMM
>> 		if (is_smm(vcpu))
>> 			kvm_smm_changed(vcpu, false);
>> #endif
>> 		kvm_vcpu_reset(vcpu, true);
>> 	}
>>
>> 	kvm_run->exit_reason = KVM_EXIT_SHUTDOWN;
>> 	return 0;
>>   }
>>
>> Now, maybe the APM is trying to say only the save area is undefined, in which
>> case PML Index is fine and can and should be left alone.  But if that's the case,
>> the APM needs to be updated to make explicitly clear what fields in the VMCS are
>> and are not valid after SHUTDOWN.
> 
> I'm checking to see if I can get clarification on this.

PML_INDEX will be valid even when a SHUTDOWN is intercepted. I'm working
to see if we can update the APM to identify what would be valid and what
wouldn't be in this situation.

For a triple-fault SHUTDOWN, the saved x86 state could be inconsistent
because the CPU stopped in the middle of a sequence and redirected to
shutdown. Everything will be saved, but it might not be valid x86 state.
The question then becomes are there fields within the VMCB control area
that are based on x86 state that might not be valid (e.g. V_IRQ or nRIP,
etc.).

Thanks,
Tom

> 
> Thanks,
> Tom
> 
>>
>>>> Hmm, actually, how is that going to work?  Dropping PML entries just because a
>>>> vCPU hit SHUTDOWN isn't going to fly.  
>>>>
>>>
>>> Not dropping, but just leave PML index unchanged.  The PML buffer itself is
>>> still there unchanged, and PML is still working in hardware thus the buffer
>>> will eventually get flushed.
>>
>> As above, the PML index could be garbage.
>>
>>> This is the case for VMX AFAICT, thus I wonder whether this also works for
>>> SVM.
>>
>> No, VMX is fine.
>>
>>>> E.g. if a VM crashes while it's being
>>>> migrated by the host, then it could end up with corrupted, incoherent data on
>>>> the target due to leaving dirtied pages behind.
>>>
>>> If we leave PML index unchanged upon INIT as mentioned above, I don't think
>>> we will lose any dirty GPA tracking.  But maybe I am missing something.
>>
>> Correct.  The question is whether or not AMD's architecture guarantees PML Index
>> will be valid/accurate after SHUTDOWN.
>>
> 
> 

