Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010042.outbound.protection.outlook.com [52.101.193.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03B243F1663;
	Tue, 10 Mar 2026 21:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773178913; cv=fail; b=beN+5TVV4RKO8zqIeYs3AkGKugXi8wsz//oy3gx7Phv18Aqh9+bYrSPoZRnv5wE9HRimSkI7vN4ZnEZBxminLzPThmYYQhnw1RM8zlUY/J/qrNEhTRJvettYQc02hpXf1dhaOvgKVRsmEi3Yzj13rlTj7M2b9/v1YbPZZr2yQY0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773178913; c=relaxed/simple;
	bh=iF+bSvtVpZBIxlEPpppgg96XGYix/newmBvJt/tuW6A=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SZuhwH/uJSWIK5Slsa5diwH8Aye1IXMLMwGz+lXls2XlPN+Rl3eckpQuiEaxPIpK931eMYTOCkHg7J7B0O5hs9qEwRe7gh59hBAfdMea7r3+DMB6WQHC1LHZiGhgUXhdX5QE3mZuRLj9Z4OljYCsYdVrc9J312qh15YqVSMGS3Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=RJMs8xrT; arc=fail smtp.client-ip=52.101.193.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="RJMs8xrT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ioghla+3n2dwYYmrMBm9+jl4oz5XEBlNHUhJkw4z0ScnqFJjFVdgwXZXufuqdNSH+dCD4jqM9yA7wZUvoKeJNAz6ugqFluik14UHAZa8XlIKOfzEpAae1eyT2HdrAt+P2g8ZzjXuUMeOs+19PqKmroMP7VEfrHk4L8eRhQtbZMcyJ3Zcdl5UWAQj5Vv7u7yecAYFwL/xavXSBLUFocmHBjuk91s/pBIf3vdnZpCA6elUvVa6z4aKBJZoz50r0xzpRoCxaVUn/fCfvbGR8pTHgzfzlqVZjjZuK8Xw9u49+CbFFL9oTWW8LhP3huyIb6O34lQXq0yKbSzElnaCDLELgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e6V6M/l7jxxxPftD5V02tnsB4ZQjQ7DMOEXKTYG5Jvs=;
 b=vng9ZE1MAPUmj8Xdd2uJulwMpWwhcDkK4oKJfkFDJZ/CUTrzW/XsmcjVkNvL1PFCJJnvhGgFzw+Wh5nwsHue0ZGg5HHttxd9EEIjCXpYt/G0enY+09zXCY18cN79r0ZkPgvfWy00ANph/vvfE9RGm8SfdthdjqFeDQF4g5Stacw+ybg/Y167GuauFJSkB1+qrQUifWRdBfbRI5St7o5Bv8nhc2JrF2E/nLLnNaAvlbQmBRNWTqmFfO5Sajnw7GoeE37XD8nzYFr1FGmmti7UwASGKQL0bwPZpxTH/nAJDwgApqF72V/eeVykGQwTQf3u3Kjdzp1ZHZAPYdjEpRzh3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e6V6M/l7jxxxPftD5V02tnsB4ZQjQ7DMOEXKTYG5Jvs=;
 b=RJMs8xrTO5fnPJyn0wW5+WPjCTgJG37HcyZPeTQDVVk3e/95EZmhRjrQENKfZOcmPSjnt+e9oYoT4Y7GEGAPoheK7JUSQY46SXhXWOfXOec+hvFQHwpk4u8bsjWaFJkcODM+AYqyaRDfEUDJQ5QyVZuRp+95H0GxixIkwikWpTE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5070.namprd12.prod.outlook.com (2603:10b6:5:389::22)
 by IA1PR12MB6259.namprd12.prod.outlook.com (2603:10b6:208:3e5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Tue, 10 Mar
 2026 21:41:46 +0000
Received: from DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::f3f2:852c:78d5:9353]) by DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::f3f2:852c:78d5:9353%4]) with mapi id 15.20.9700.010; Tue, 10 Mar 2026
 21:41:46 +0000
Message-ID: <23ec6b06-96b9-42aa-937a-908b2ce73a69@amd.com>
Date: Tue, 10 Mar 2026 16:41:45 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] KVM: SVM: Set/clear CR8 write interception when AVIC
 is (de)activated
To: Sean Christopherson <seanjc@google.com>
Cc: Naveen N Rao <naveen@kernel.org>, Srikanth Aithal <sraithal@amd.com>,
 Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jim Mattson <jmattson@google.com>,
 "Maciej S . Szmigiero" <maciej.szmigiero@oracle.com>
References: <20260203190711.458413-1-seanjc@google.com>
 <20260203190711.458413-3-seanjc@google.com>
 <19935696-36cf-411b-af90-aabe6a98d7e7@amd.com> <abBSPkKmMiFCfKek@google.com>
 <947bf241-d149-4933-874a-de96aeb73dff@amd.com>
 <abBYiODdL4405KbB@blrnaveerao1>
 <debf1c3f-f0aa-4b9d-ba35-feed87aa899e@amd.com> <abBkgY9W4_PD1uef@google.com>
Content-Language: en-US
From: Tom Lendacky <thomas.lendacky@amd.com>
Autocrypt: addr=thomas.lendacky@amd.com; keydata=
 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
 WiyqywZI5g==
In-Reply-To: <abBkgY9W4_PD1uef@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0153.namprd04.prod.outlook.com
 (2603:10b6:806:125::8) To DM4PR12MB5070.namprd12.prod.outlook.com
 (2603:10b6:5:389::22)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5070:EE_|IA1PR12MB6259:EE_
X-MS-Office365-Filtering-Correlation-Id: c683377c-2f00-4b75-f069-08de7eedd417
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|7053199007|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	WOn7+lA+f2OvpY69ypV+oWDm9wGFmU58bhNbBvZVCNEhvVyCkRJQlcO5DvUGignZQDs7CuiSfmP/ic9uK3NPIaG77TCvXKqVBgaQBw7lJS7NjznsModdS7ImITiZkXVPNrMmdCFRHMu119KRshTur19lqvYqFzvRAkQzPpudYHFULyfr7ge+z7t56bRqfL6g0HorZQZ64iDByreUXLkCR8J6/zsBLpZvt3oOdMJM3oWgOPGmKMQsLeqQmWcKjW2luga1qA/nNITufSfJs77RQQ4HgrtSkm6VPdrR+kRtIofgDGoaL98kCSbem1SB+2xeRPZKHoww04v+1t1y7bUguxf6NMZ9aKl0GkowaCM8/FNKw0d/N+G2pSa9QC/5S24EOITG2f8VlBqN8cwRhsCbAhWWu/lO1opOWaoT9Lxhb7HV4+AlMy2eCXo6Jhq1RdY+Ewn/wIN+DLjqW5UuqOiVrJb9jABMUdDxWX1+kdRgUkxgdcYhPIz6BTMkqgNRSwqCDhDIxiNuOzsnTupSomtYBrQ07lsLnIXhuAnP8hlKxL1+CkWC29oTX7PoG/sbXWt3ukI33o55d3lvGqGz91P4tvM0ftiuZFCqwj5PXqOW4ldmOnUsMQPZNnGQuQUzE6492oSyYecGljNqJayTMKKv1dN9CYLhS3clabezk5j4cIMmfOqBgUIbSIqVSehgP6uAlpMigeo0pydh/OHxIAj9mshbmJ9qWKn3P/b5EOqH36k=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5070.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VGV0TkRsdjFZdFVEUjRFSlFMdzREdUlnQVEyU1dwOUlhZlA1WDBJelk4T0xC?=
 =?utf-8?B?cWtEQyswdmtOckVCT0NRZ1J3bHVIYjhkQWJwcHRJQzJmV3Nad2tXTFp1Lzds?=
 =?utf-8?B?NDlJUGlxM3hWWGtrWFZUNllqbEhheDdWSVlock1qaitidVE5N005MFY4UWZi?=
 =?utf-8?B?OXdWZ1NzNzZnWDRuZGZhdGxWMjJHc1Z6Y3dNdjNocnJPUFlqNEpoTEV2V2xq?=
 =?utf-8?B?M05NSjhHK3AxaEJjZ0c2eGYxUmd2REpaQmtYemw3a1FRRjNUN2d0UEhRYUJn?=
 =?utf-8?B?a0lBRXhQMDZRUGVzYTN4ZVpHQWdkMUsxTkNCOFhvVVc3NTAxZnZoL3V0UldE?=
 =?utf-8?B?YU1BRVg1RXJxVkM3bFhXVTMwUGt1THg0eFFvL3ZTWXlRL1JHWndzMkV1U0ZQ?=
 =?utf-8?B?NUkzcTR4Q0J6MklMZThvSk5rTVM5dzV3cDlPNi9sV2xzSWdyL1pEaHRDdmQ3?=
 =?utf-8?B?eldJeWJKZU1kclEzUkNYZ015bmxJWVlPdzRRcUJ6NHk4ZVAveHlyZng2YXNK?=
 =?utf-8?B?UzcyekxYSnAvRUpqMVVvRS9PZUNrYkxWRXlCdXp4eVR0VkdGZS93YUV4QXFw?=
 =?utf-8?B?V2l3NjBQb3hPNDJMOHR6YVB2SnRpRUFZaFo4eDFwZU5Td2NEK3AvS3llNVNE?=
 =?utf-8?B?REk1ZndaY1ZmVUVvMUk5QS92a2VJWVZ0ekpySW5sRWxFd3N0SU9wN3VFeWEw?=
 =?utf-8?B?MUQrWWVGSGV1cGdvZmpMdllLbWlyVmVnMVl0bytXbVRTYUhjelZ1OTZsYzhr?=
 =?utf-8?B?d3kxYU5nNFVzUnVQUjJra1FzL3JrM08rUWRDcjljL3Y5ZU1YVmJRbmViTnc5?=
 =?utf-8?B?V21VZW1VTzFpbC9OaEFNUEJCR1UrWDYyZUhKNEd2MDJrRkJhdXFOZkFrMzgv?=
 =?utf-8?B?S2xzcUFLbkIrOTNzSWJZbXBZNWU4MnRJK0F4RWF0RlFxSi9EQ095LzI4bFVs?=
 =?utf-8?B?SEY1aFQzVDRGZ2I0R2p4T3FxbDZzS2VlSnVxWEpLMEF2b2U4SWZSRUNtL0Rq?=
 =?utf-8?B?dDlBeEQxN2FkSFo0dy9uVEp6SFhHUzd5UGRiTmR1N3hseExsbGt4WG5BV04z?=
 =?utf-8?B?NnRBclhvSERFQnVHK2FCZ1poaG1OM2gzMHpwUDhjdTRqMzVMTnBzUHN4azZn?=
 =?utf-8?B?UU9kQ1RvQmYxUG5aRjNQM3JIaVVwUXVzeHFWNExWSWRPYjh4RVBzWGo5Mmo2?=
 =?utf-8?B?NWh3M1puV2tqUjFhYkthUXZtNVl2MWU1QTFrY1lNQVRrdW5BaDJoNjBxVzhX?=
 =?utf-8?B?QUFJYXBRN1JTM3VOa1NxVE01OUZleXVoaGVoZTl2WkQ5M2xEdU1ZdGd0Ry9M?=
 =?utf-8?B?bXRaUmI4R0l6TEoyYUtPejVHMVJuSGFoVEQxTTJUeUMzSDF2dzNOUzY4UE5v?=
 =?utf-8?B?dVM4cU1hYVVhQkU0S3NTM0lKaFpHaUZDNjdZVTZmd0ROK1JqNmZMN1A1Wkxi?=
 =?utf-8?B?anNrcGdYM1J6L053OUZtU3RqS010UUx3dUJYQ3lkeTZ5UFJrMlpGazFDcU9W?=
 =?utf-8?B?MjJrVHZjQ1UyMDV0RmtKOVJ0ZHEyVVpVa2R4Y0pPOFNGLzFQQTRYb0VpNWd3?=
 =?utf-8?B?UlBvRDFsNHYyNURrWVBEWHhHNTFBQm1PLytuSjNaa1FEWkxyemxBeUdERk9w?=
 =?utf-8?B?TDhaWHBkT1dJVHJqbzhZVnBVN09UN0x1bytrWkJBemRVcUloeXBad1pLSnFz?=
 =?utf-8?B?cDJCcmsxaVlZREtnaEF0R1ZUendlNGYydUJRY3dsbU1LcG9WUTJyYWRlbndH?=
 =?utf-8?B?d0cranM4aENvR2U0Vk1TbnlSWmd6ODdrWmJ0VFVxWjZ0WU1nT0dvYVFkRU05?=
 =?utf-8?B?d1pVY01JVnYyWU91aktVQ3FkN3FmaFo2SnExZU9MeGExbTJKM29jcVhIbmkz?=
 =?utf-8?B?U0VxbHBMN1B1cEdJQ2hXK1hjNmY5Q055TFNpMDAwKzFZUVhPdkRWcy9ERjlz?=
 =?utf-8?B?cTF3aUZqUXNtSU5OdmxOVmN6Z0prL0RhOXNnbEt2N3hKaGt0SnBlYm1KV0FX?=
 =?utf-8?B?RmJtV2VGdTB2N1RtR2NJUWk1MEhkVXFLUWtyRlN0L1NFWmZZSk9GaTdUN2Yr?=
 =?utf-8?B?b3VSdHpUV3pjYS94ejc1bUdSdHV2K2xoRDNpNm55QlJGRWhWcGpObW8yNTFy?=
 =?utf-8?B?Wjllbk0rZmxXMVl6YmVoM0NpM3k2L1JhRzA2OXpmTHpRZVQrZzFqZEV3Yy9K?=
 =?utf-8?B?VnB6VGt6aEVxZjdPWjVBa3N3UStQTnZNQXVUU2F1ejgzQzJwN0FETHM4Q1lS?=
 =?utf-8?B?Y25Wa0RGVGhwRm40ZjhLK2VteXVZQ200ZGc2em9uOXRJWEQ5ZWZ5aHl4Vm44?=
 =?utf-8?Q?yNwzk6jBfZ7VsR49oJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c683377c-2f00-4b75-f069-08de7eedd417
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5070.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2026 21:41:46.6001
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dWFrrkybK9StKWSAvwmyM5A22eWYKy+JZhvCuMKxcOt1d+GqRjDtM7TAT8gaup6Dhy1NTmzTj8oNYSsbPBXOyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6259

On 3/10/26 13:35, Sean Christopherson wrote:
> On Tue, Mar 10, 2026, Tom Lendacky wrote:
>> On 3/10/26 12:48, Naveen N Rao wrote:
>>> On Tue, Mar 10, 2026 at 12:36:09PM -0500, Tom Lendacky wrote:
>>>> On 3/10/26 12:17, Sean Christopherson wrote:
>>>>> On Tue, Mar 10, 2026, Srikanth Aithal wrote:
>>>>>>
>>>>>> Hello Sean,
>>>>>>
>>>>>> From next-20260304 onwards [1], including recent next kernel next-20260309,
>>>>>> booting an SEV-ES guest on AMD EPYC Turin and AMD EPYC Genoa has been
>>>>>> failing. However, on EPYC Milan, the SEV-ES guest boots fine.
>>>>>
>>>>> ...
>>>>>
>>>>>> Bisecting shows that this commit is the first bad one. When I revert it, I
>>>>>> am able to boot the SEV-ES guest successfully on both Turin and Genoa
>>>>>> platforms:
>>>>>>
>>>>>> e992bf67bcbab07a7f59963b2c4ed32ef65c8431 is the first bad commit
>>>>>> commit e992bf67bcbab07a7f59963b2c4ed32ef65c8431
>>>>>> Author: Sean Christopherson <seanjc@google.com>
>>>>>> Date:   Tue Feb 3 11:07:10 2026 -0800
>>>>>
>>>>> Gah, I hate how KVM manages intercepts for SEV-ES+.  Though to a large extent I
>>>>> blame the architecture for not simply making CR{0,4,8} intercept trap-like.
>>>>> Side topic, is the host actually allowed to trap CR3 writes?  That seems like a
>>>>> huge gaping security flaw, especially for SNP+.
>>>>>
>>>>> Anyways, this should fix the immediate problem.
>>>>>
>>>>> diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
>>>>> index 33172f0e986b..b6072872b785 100644
>>>>> --- a/arch/x86/kvm/svm/avic.c
>>>>> +++ b/arch/x86/kvm/svm/avic.c
>>>>> @@ -237,7 +237,8 @@ static void avic_deactivate_vmcb(struct vcpu_svm *svm)
>>>>>         vmcb->control.int_ctl &= ~(AVIC_ENABLE_MASK | X2APIC_MODE_MASK);
>>>>>         vmcb->control.avic_physical_id &= ~AVIC_PHYSICAL_MAX_INDEX_MASK;
>>>>>  
>>>>> -       svm_set_intercept(svm, INTERCEPT_CR8_WRITE);
>>>>> +       if (!sev_es_guest(svm->vcpu.kvm))
>>>>> +               svm_set_intercept(svm, INTERCEPT_CR8_WRITE);
>>>>>  
>>>>>         /*
>>>>>          * If running nested and the guest uses its own MSR bitmap, there
>>>>>
>>>>> Argh!  The more I look at this code, the more frustrated I get.  The unconditional
>>>>> setting of TRAP_CR8_WRITE for SEV-ES+ is flawed.  When AVIC is enabled, KVM doesn't
>>>>
>>>> AVIC is disabled for SEV guests (see __sev_guest_init() and the
>>>> kvm_set_apicv_inhibit(kvm, APICV_INHIBIT_REASON_SEV) call at the end of
>>>> the function).
>>>
>>> AVIC gets inhibited globally, but continues to be enabled on 
>>> vcpu_create() opportunistically -- see kvm_create_lapic(). It only gets 
>>> disabled later during vcpu setup via 
>>> vcpu_reset()->svm_vcpu_reset()->init_vmcb()->avic_init_vmcb()
>>
>> I'm just saying that the unconditional trap for CR8_WRITE isn't flawed
>> for SEV-ES+ because AVIC can't work with SEV, so there isn't any time
>> that CR8 writes shouldn't be trapped.
> 
> Yeah, I forgot that (obviously).
> 
> But sync_cr8_to_lapic() is very broken, no?  INTERCEPT_CR8_WRITE will never be
> set, and svm->vmcb->control.int_ctl will become stale as soon as the VMSA is
> live, and so in all likelihood KVM is crushing CR8 to zero for SEV-ES guests.

I don't think so. V_TPR is written on #VMEXIT even for SEV-ES+ guests,
and since it is a trap, CR8 is set and so V_TPR should have that value.
That would imply sync_cr8_to_lapic() should do the right thing.

After attempting to verify this behavior it turns out that writes to CR8
(and CR2) are, in fact, not trapped, but the APM was not updated with
this information (I'll send a patch to remove that code). KVM's CR8
value is, however, synced with the proper value through
sync_cr8_to_lapic() because V_TPR in the VMCB is updated on #VMEXIT.

Thanks,
Tom



