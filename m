Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010039.outbound.protection.outlook.com [52.101.56.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2832930F94B;
	Wed, 19 Aug 2026 03:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787109263; cv=fail; b=HIp9pgdETwVhcbvivdjrvq7pwXp5N+pa8L2w6KdX30/kVpf4ZKoDCDsKN5nzYfz0VHJKBSQirnp6TQuG4ShNqM41bUb24YTDwDx0haFQpDKF8phz9fgsY9m/Frpx0kb95HhwJDRnfaV4wjprZsGsYX5Kd0Ao7kHR7aYnJ7aQZJo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787109263; c=relaxed/simple;
	bh=UzIXYzCPDIKbviPeloTCwHLVOLX7EajL+Xh69WLMvz4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LaLnm8ZEv5GqIND8+YzdgQP1+HJ6HopHudQMYcf9eY8q3jvsGjyKZIoWE54a4IcP+nUNrD3qtDn1PEYpimZhmbAwVN30EcGcipdxPcnaWvkU0t57pEKXLNvQVzX49Cp3ERhPb/CdEquK+YTzXW8JG+N+vP5OytYhWth/iil6sL8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=VBLij3fS; arc=fail smtp.client-ip=52.101.56.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="VBLij3fS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qIGW95lSpFlgejvKJUkVEPP2+i5qS5A1dTVByiz0wdlannvJG42nuUtZeeZQ/NI4Kj2RfD1JyXJTgxpi7ySl7ZXuDyhOUSKBBBltdYRcTMt/I1WNI+kUlpo0LtzJDf2BJ2Bu97gD/H0ZnphCtQyPz28wTUGOen7e6xcz4+z9EJVcLSCgo7EfrNeIaAS016XFrSEX1vKJPNZ9RCzDgz5u44qBGIcZan6FLUsvxqW7b/fZSA61RUHr31a4KzRxNh74UcYlNNlv7usJsaJcD5fxW3tFwMMiF381a8h4viAEMibmjrHlvKLbAXquCwQUdZZh6RSPelFzBj1QUa1Tav8qdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T2AqHbw3BfmIXiXPKZglF9uEQaJlOv3nBm3xQfZV/Sw=;
 b=DiE6nJUbXa265sU/XPE8zAZbvnDuGLEA42HGBqRgOrc2tGOOs9CsLXNdd/ZQA7s1AD+zir3kValtJnC76Ab38Qm4TVV0fWflc14BTAKDe9MncklzXd3RvbuCRJGUhxc1O/kg4PxRFKGn7X/qfvYjwlhEQNPd84f3Vk1QORqExc/91UqriXZnGGAER2sajK7/oZwXnVGu1z7iGgxFUMUF62hw6lFSBtiqCTot3/EP+nsrW9iD5LA2llsiT420f22k2fwGPKsgbcjWHBBB5eJNH1WwLQ1Lo1YXJwFCIErIrP2Fvl3WEigtYcSTV+Tl9uqVIvbU5GhNUXbfxKqoArmIAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T2AqHbw3BfmIXiXPKZglF9uEQaJlOv3nBm3xQfZV/Sw=;
 b=VBLij3fSU+7a3MURneSGMRC1hfwL7XmfIMnJb12yzaSYAV8AE9pxV1s5gNva2fuiY3vLdk0OVmWGjqf5p+SZnihAvqIybw0wA4LcpLhOO5K6OMk9BNJw6GWl8jJggYTRV/NTcj1tii/Ax9IuRUMP4kKVLl5HbU5r6Vyp4nbHbbw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB5713.namprd12.prod.outlook.com (2603:10b6:208:370::18)
 by DS0PR12MB8366.namprd12.prod.outlook.com (2603:10b6:8:f9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Wed, 19 Aug
 2026 03:14:17 +0000
Received: from MN0PR12MB5713.namprd12.prod.outlook.com
 ([fe80::cab0:6260:dd96:3fd8]) by MN0PR12MB5713.namprd12.prod.outlook.com
 ([fe80::cab0:6260:dd96:3fd8%7]) with mapi id 15.21.0339.007; Wed, 19 Aug 2026
 03:14:17 +0000
Message-ID: <8bab9ab9-0598-4e33-8dd3-9bad563fcbc0@amd.com>
Date: Wed, 19 Aug 2026 08:44:09 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 6/8] KVM: x86/pmu: Move RDPMC emulation into per-vendor
 callbacks
To: Zide Chen <zide.chen@intel.com>, Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, Jim Mattson <jmattson@google.com>,
 Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org,
 Mingwei Zhang <mizhang@google.com>, Shukla Manali <Manali.Shukla@amd.com>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>, Xudong Hao <xudong.hao@intel.com>
References: <20260817183143.226156-1-zide.chen@intel.com>
 <20260817183143.226156-7-zide.chen@intel.com>
Content-Language: en-US
From: Sandipan Das <sandipan.das@amd.com>
In-Reply-To: <20260817183143.226156-7-zide.chen@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0272.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1f2::11) To MN0PR12MB5713.namprd12.prod.outlook.com
 (2603:10b6:208:370::18)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB5713:EE_|DS0PR12MB8366:EE_
X-MS-Office365-Filtering-Correlation-Id: 001c3537-b88c-4256-c604-08defd9ff42d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|7416014|376014|56012099006|10067099003|6133799003|3023799007|18002099003|22082099003|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info:
	kYs7u/Gg+vfZyB5TcukFMI3GukkBw8T6+A3JfVALuALPXoJWA5+devuRFBuqX7GCFUukjwTJQGqaJM/DJtnJ3aXhFBgBcmISMx3WSIrDA9W9EvbzHFA/Uh6Za6VYHNRa9ZeEkGm04uR/CiYq05C1FqIabE0qsKySBgv7AuzjQ8CkR43vYCgKxUckGOTgh6A2gFM6fBIMWnLWoUh7YsgaUHdoD8+0+b3/ww+wkAXSX/LjFy9vOrzbJsDfbKdM2PQX5aJfPyObWttrkb7ASLtBR81AwgWWu4HBEo/RBqocdFyVNeLMhY3Xn2Q06Q99XZTHzB1krOfzMXQWAs/D9mZIpXz3PRwIzKtYbMTYJNHe8CUrCTJ5rMknQH+jFgHSrJ1zP+vze2NuCDEynFxHNH7GLargf8vi4nLJyFtTXGR7u3hkuzM4p6XrlRw/RRxtSx/QfDvYFrPNV1jlls1qKR0cMoSKT3HxPEkwDJ0i1mHJ0N2edyiPw0I6Y+nU8nnfxus3fALaBJZtm4I3DRpIAq8rQGr+mLLvO4FInAFBnD5JsonSMB/46AQfqS80KfE+el7lWzmNKbhNMUhPFMX1mtuw3Fjb7nI8BmrKhCntGEMSn+QD6KfUEqGsWIgVYbbzW434eyenAvQXAEuOaBi3+Gm0ujI3LfZvIGw/7Z9rZYJyY+g=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB5713.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(7416014)(376014)(56012099006)(10067099003)(6133799003)(3023799007)(18002099003)(22082099003)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VTViM0VaRWcwQmhvT2UvRjNoek9ZSXRSUlZBT3piQ1hNZDVCVTVMSFRCWk1L?=
 =?utf-8?B?Qnl2VS9KT3lib0tlVjB1bEZ4ellJUWhycmNJNHZ4Q0VkMURQdDg3K0pSQ1BI?=
 =?utf-8?B?bzd0NlRGbmJ3eTVWdTdaeEFYbllndC9SenRGV2NjM0IvYk5vS3I4c2tWNmlo?=
 =?utf-8?B?K21iR2lQMEVQMzBSaHhkVmlvaHpvQlVTUTdScjBsR3QxN2VHbDdXN2JERS9V?=
 =?utf-8?B?MzBvbFd2ZjJhRld5d05kRXBxQnQvS0xaRUZ0YzlSRnRTdS90dy9oT2d2Nndm?=
 =?utf-8?B?ZVh3Mk1MZE55cUJ2TTdwN1NtdWI2MUJPajRrdXZkYnNqa0NUb2poT3UxbVpU?=
 =?utf-8?B?Q1NMTG1mcEs1L2dmYVZoakdUTWVNN3k1QjBmRGFkNGRwYlcrNTBmL2txWkFI?=
 =?utf-8?B?b2RLMVNHczZCMXphUUJPRVN4QU1ObTFCbjFaeGMzU09nalprWGR2enpXbzVM?=
 =?utf-8?B?YXJCNlF0b2ZGNEtjMEFwZXpySndrR3YzUWloa0NxNG9oUHdKRDVqMTZhQlIz?=
 =?utf-8?B?MHlyV05nTWtxSGk4MGhzUXBiWDdRLzMxTDliUnV3b2REbXJqaWxmTVZmYWdD?=
 =?utf-8?B?RWFrNGgwZG93RWUzaHpWcGZqeEJEN1k2bS9lMVA3NzNybE44SmQ3MXBOcjdr?=
 =?utf-8?B?enh3ekhHSjAydTdLeitLTmx4K2hOaTVFcmxBUmVoNHlZaXFDUWxOY0EyNDJY?=
 =?utf-8?B?ZUFLd00vdmNON0kzY0pNNzR2TUxzMnRGc1JHQXZoRG9oVVNsMDhEUXpleTd0?=
 =?utf-8?B?cVRLT3FuT3lEckNhb3dzWndmUnUrSXhrZm1Wbk5FdnljSTcxU1lBRWM0K0Qx?=
 =?utf-8?B?WHNWSndYNWRkZGRsbjdwSnhzbVE5Sko2UlRrS29ucGtBV09YT1J5amgyN0tv?=
 =?utf-8?B?TWxSOVNMMndtM0I1enZJVHB6TkRWaW9RWXFLUFFwVlM5a09tNDRCN21lT01D?=
 =?utf-8?B?K3AvTjBDa0FITHdManFzWXNVWXF3UHlLa0NUanlSenVrOUJZWFlkR0M1MHhp?=
 =?utf-8?B?QzBsRHpvTG5sY3VxMlJRYlBTb1JXOFNNeE1ZVnFsZTdPa09WeUFUNW9GRUNm?=
 =?utf-8?B?cUp4QWxsZnc2MjBBWE1ZL2RiN1BPenR0STdjNkQzOTZLZHRxMmszdFNsL2Ry?=
 =?utf-8?B?OHhKcHJHaGQyWUIwemJlQWFOcitLV2JvaGV4U012emtHM3RLem5LWjdLSnJl?=
 =?utf-8?B?SXE4Q3J1WEVpVTBaV09INnJWdnJua0txMkVsZzA4blRDQkl5M1NobzJLTi85?=
 =?utf-8?B?WFFJY2FJajRjNTh5aEZ5aThiZGFLUTZQbFZ0NjJWc3FDalhTRzd0WVhBZ2pP?=
 =?utf-8?B?ekJhOUZNM0oyTlRiRmdVVzR2Z2ErcFB0NVpGSGFEVWdjZ1F0Q09VaGV1QU1H?=
 =?utf-8?B?eGMvMHJWUVhuSlJvKy8vNWVkdlg3ZGFnMFpBZlhZT0RNRktSNGhjNEN4b1Bi?=
 =?utf-8?B?amZKdHlIZzdubms3MzdmZzZzcjA5dHFjZDdwdmJGMTJQVi9ycEJYb2RRZ2NJ?=
 =?utf-8?B?OXZoRHBRdnN5b25kckVYNmE2bFIrdU9zTHRHU0lPUUM1NXFIS1lneXlodkhE?=
 =?utf-8?B?NGVqVFZqNnY3M1lXZlZybWNKZDVWVkVRVkcvNno2N1dVeUt3Z0RsQVdqVGRx?=
 =?utf-8?B?SGt3NXpwYnpCQTZNMUppVW9lWmIxdk5uMUhncHppNWhtVmxrV05KT3pVRXpo?=
 =?utf-8?B?dXEwdkpPY2dsZlpXMzhSbWRIcmZxZncxcWxCcHJxbExjMXZEM3YwUXhZOEdR?=
 =?utf-8?B?ZysybUpkbkFMOStZaVMxSklmTm13L3lBSHYwV0VuZjhVTTRMLzFCOHBVbGdh?=
 =?utf-8?B?OTN5eFVqRG4yeHluMDlvS0ZseE43WFJzU2tsSGFub2JTbERadzB5d1NRRW1p?=
 =?utf-8?B?NDFXWmtNQ0c2N1FVYUtDbDNvTzNrL1M1V2lFYzY2YU9nRGJ1QnRwRkRqTGJq?=
 =?utf-8?B?TzJVdTNuanlla1RyeUpHZWRoSG84anJYSndmUnp6NXhmeEJPbkpWcDcrRmlt?=
 =?utf-8?B?SzlweHBXQ2VheFpoK1JuTXBHWFdvVDRlcEtaL2RGQWdrRG8vRjB4TFhOS1Uy?=
 =?utf-8?B?QnZia2NSQ2pPM2U3OHB6MFVYVW1jd3BVYmwzbC9FaTFTUkhsbzAxbUJPS0RF?=
 =?utf-8?B?RU5kQkFtZWc0N2U1WXQ1RkV2U0lqVG94WjJ4L244YWYvODRvZXZxRlVJa3dr?=
 =?utf-8?B?M2R1Y2FTbUJmTGloR1JMM3ZVeXoybUZFWGNCODB4ZnU1bTloVGxpZUQxdzFH?=
 =?utf-8?B?ZkZLN0RhZ2NwcFlURWRzVjZGY0dPcTR3U0JBY3JLZ0orTHNFMi9VVFpjU2Y5?=
 =?utf-8?B?bU40Yjl4c0xMcDFLckE1M2tlNFh3UUkvRHVvWmlHVS8vRkJqWDQ3UT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 001c3537-b88c-4256-c604-08defd9ff42d
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5713.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2026 03:14:17.3692
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: itzzG6LmQz3IrSgbKqFTsLzJWeGH2xku19PSpV5f7/tEQE5nhPROFZsYY7ltTfE+E1NVp29cpWlFvwVWQdruPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8366

On 18-08-2026 00:01, Zide Chen wrote:
> The current RDPMC emulation splits responsibility: rdpmc_ecx_to_pmc()
> in each vendor returns a kvm_pmc, then common code calls
> pmc_read_counter().
> 
> This design cannot support RDPMC reads that don't map to a counter,
> such as PERF_METRICS on Intel platforms.
> 
> Replace rdpmc_ecx_to_pmc() with emulate_rdpmc(), which takes full
> ownership of the emulation and writes the result directly into @data.
> 
> Opportunistically drop the redundant bitmask in intel_emulate_rdpmc()
> since pmc_read_counter() already applies the counter's bit-width mask.
> 
> No functional change intended.
> 
> Signed-off-by: Zide Chen <zide.chen@intel.com>
> Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> Reviewed-by: Jim Mattson <jmattson@google.com>
> ---
> v6: new patch.
> ---
>  arch/x86/include/asm/kvm-x86-pmu-ops.h |  2 +-
>  arch/x86/kvm/pmu.c                     |  9 +--------
>  arch/x86/kvm/pmu.h                     |  4 ++--
>  arch/x86/kvm/svm/pmu.c                 | 13 +++++++++----
>  arch/x86/kvm/vmx/pmu_intel.c           | 25 ++++++++++++-------------
>  5 files changed, 25 insertions(+), 28 deletions(-)
> 

Reviewed-by: Sandipan Das <sandipan.das@amd.com>

> diff --git a/arch/x86/include/asm/kvm-x86-pmu-ops.h b/arch/x86/include/asm/kvm-x86-pmu-ops.h
> index 4a223c2793e3..4b50ed058aed 100644
> --- a/arch/x86/include/asm/kvm-x86-pmu-ops.h
> +++ b/arch/x86/include/asm/kvm-x86-pmu-ops.h
> @@ -13,7 +13,7 @@
>   * KVM_X86_PMU_OP_OPTIONAL() can be used for those functions that can have
>   * a NULL definition.
>   */
> -KVM_X86_PMU_OP(rdpmc_ecx_to_pmc)
> +KVM_X86_PMU_OP(emulate_rdpmc)
>  KVM_X86_PMU_OP(msr_idx_to_pmc)
>  KVM_X86_PMU_OP_OPTIONAL(check_rdpmc_early)
>  KVM_X86_PMU_OP(is_valid_msr)
> diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
> index 2fddcbc8924d..789624658e8f 100644
> --- a/arch/x86/kvm/pmu.c
> +++ b/arch/x86/kvm/pmu.c
> @@ -768,8 +768,6 @@ static int kvm_pmu_rdpmc_vmware(struct kvm_vcpu *vcpu, unsigned idx, u64 *data)
>  int kvm_pmu_rdpmc(struct kvm_vcpu *vcpu, unsigned idx, u64 *data)
>  {
>  	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
> -	struct kvm_pmc *pmc;
> -	u64 mask = ~0ull;
>  
>  	if (!pmu->version)
>  		return 1;
> @@ -777,17 +775,12 @@ int kvm_pmu_rdpmc(struct kvm_vcpu *vcpu, unsigned idx, u64 *data)
>  	if (is_vmware_backdoor_pmc(idx))
>  		return kvm_pmu_rdpmc_vmware(vcpu, idx, data);
>  
> -	pmc = kvm_pmu_call(rdpmc_ecx_to_pmc)(vcpu, idx, &mask);
> -	if (!pmc)
> -		return 1;
> -
>  	if (!kvm_is_cr4_bit_set(vcpu, X86_CR4_PCE) &&
>  	    (kvm_x86_call(get_cpl)(vcpu) != 0) &&
>  	    kvm_is_cr0_bit_set(vcpu, X86_CR0_PE))
>  		return 1;
>  
> -	*data = pmc_read_counter(pmc) & mask;
> -	return 0;
> +	return kvm_pmu_call(emulate_rdpmc)(vcpu, idx, data);
>  }
>  
>  static bool kvm_need_any_pmc_intercept(struct kvm_vcpu *vcpu)
> diff --git a/arch/x86/kvm/pmu.h b/arch/x86/kvm/pmu.h
> index be578013ed83..eb6bbc658f5b 100644
> --- a/arch/x86/kvm/pmu.h
> +++ b/arch/x86/kvm/pmu.h
> @@ -24,8 +24,8 @@
>  #define KVM_FIXED_PMC_BASE_IDX INTEL_PMC_IDX_FIXED
>  
>  struct kvm_pmu_ops {
> -	struct kvm_pmc *(*rdpmc_ecx_to_pmc)(struct kvm_vcpu *vcpu,
> -		unsigned int idx, u64 *mask);
> +	int (*emulate_rdpmc)(struct kvm_vcpu *vcpu, unsigned int idx,
> +			     u64 *data);
>  	struct kvm_pmc *(*msr_idx_to_pmc)(struct kvm_vcpu *vcpu, u32 msr);
>  	int (*check_rdpmc_early)(struct kvm_vcpu *vcpu, unsigned int idx);
>  	bool (*is_valid_msr)(struct kvm_vcpu *vcpu, u32 msr);
> diff --git a/arch/x86/kvm/svm/pmu.c b/arch/x86/kvm/svm/pmu.c
> index c18286545a7a..0517fd4bbcd7 100644
> --- a/arch/x86/kvm/svm/pmu.c
> +++ b/arch/x86/kvm/svm/pmu.c
> @@ -84,10 +84,15 @@ static int amd_check_rdpmc_early(struct kvm_vcpu *vcpu, unsigned int idx)
>  }
>  
>  /* idx is the ECX register of RDPMC instruction */
> -static struct kvm_pmc *amd_rdpmc_ecx_to_pmc(struct kvm_vcpu *vcpu,
> -	unsigned int idx, u64 *mask)
> +static int amd_emulate_rdpmc(struct kvm_vcpu *vcpu, unsigned int idx, u64 *data)
>  {
> -	return amd_pmu_get_pmc(vcpu_to_pmu(vcpu), idx);
> +	struct kvm_pmc *pmc = amd_pmu_get_pmc(vcpu_to_pmu(vcpu), idx);
> +
> +	if (!pmc)
> +		return 1;
> +
> +	*data = pmc_read_counter(pmc);
> +	return 0;
>  }
>  
>  static struct kvm_pmc *amd_msr_idx_to_pmc(struct kvm_vcpu *vcpu, u32 msr)
> @@ -302,7 +307,7 @@ static bool amd_pmc_is_disabled_in_current_mode(struct kvm_pmc *pmc)
>  }
>  
>  struct kvm_pmu_ops amd_pmu_ops __initdata = {
> -	.rdpmc_ecx_to_pmc = amd_rdpmc_ecx_to_pmc,
> +	.emulate_rdpmc = amd_emulate_rdpmc,
>  	.msr_idx_to_pmc = amd_msr_idx_to_pmc,
>  	.check_rdpmc_early = amd_check_rdpmc_early,
>  	.is_valid_msr = amd_is_valid_msr,
> diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
> index 1fd0480baf68..bbf4afcffafc 100644
> --- a/arch/x86/kvm/vmx/pmu_intel.c
> +++ b/arch/x86/kvm/vmx/pmu_intel.c
> @@ -85,14 +85,13 @@ static void reprogram_fixed_counters(struct kvm_pmu *pmu, u64 data)
>  	}
>  }
>  
> -static struct kvm_pmc *intel_rdpmc_ecx_to_pmc(struct kvm_vcpu *vcpu,
> -					    unsigned int idx, u64 *mask)
> +static int intel_emulate_rdpmc(struct kvm_vcpu *vcpu, unsigned int idx,
> +			       u64 *data)
>  {
>  	unsigned int type = idx & INTEL_RDPMC_TYPE_MASK;
>  	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
> -	struct kvm_pmc *counters;
> +	struct kvm_pmc *counters, *pmc;
>  	unsigned int num_counters;
> -	u64 bitmask;
>  
>  	/*
>  	 * The encoding of ECX for RDPMC is different for architectural versus
> @@ -105,7 +104,9 @@ static struct kvm_pmc *intel_rdpmc_ecx_to_pmc(struct kvm_vcpu *vcpu,
>  	 * as KVM doesn't support such PMUs.
>  	 */
>  	if (WARN_ON_ONCE(!pmu->version))
> -		return NULL;
> +		return 1;
> +
> +	idx &= INTEL_RDPMC_INDEX_MASK;
>  
>  	/*
>  	 * General Purpose (GP) PMCs are supported on all PMUs, and fixed PMCs
> @@ -119,23 +120,21 @@ static struct kvm_pmc *intel_rdpmc_ecx_to_pmc(struct kvm_vcpu *vcpu,
>  	case INTEL_RDPMC_FIXED:
>  		counters = pmu->fixed_counters;
>  		num_counters = pmu->nr_arch_fixed_counters;
> -		bitmask = pmu->counter_bitmask[KVM_PMC_FIXED];
>  		break;
>  	case INTEL_RDPMC_GP:
>  		counters = pmu->gp_counters;
>  		num_counters = pmu->nr_arch_gp_counters;
> -		bitmask = pmu->counter_bitmask[KVM_PMC_GP];
>  		break;
>  	default:
> -		return NULL;
> +		return 1;
>  	}
>  
> -	idx &= INTEL_RDPMC_INDEX_MASK;
>  	if (idx >= num_counters)
> -		return NULL;
> +		return 1;
>  
> -	*mask &= bitmask;
> -	return &counters[array_index_nospec(idx, num_counters)];
> +	pmc = &counters[array_index_nospec(idx, num_counters)];
> +	*data = pmc_read_counter(pmc);
> +	return 0;
>  }
>  
>  static inline struct kvm_pmc *get_fw_gp_pmc(struct kvm_pmu *pmu, u32 msr)
> @@ -868,7 +867,7 @@ static void intel_mediated_pmu_put(struct kvm_vcpu *vcpu)
>  }
>  
>  struct kvm_pmu_ops intel_pmu_ops __initdata = {
> -	.rdpmc_ecx_to_pmc = intel_rdpmc_ecx_to_pmc,
> +	.emulate_rdpmc = intel_emulate_rdpmc,
>  	.msr_idx_to_pmc = intel_msr_idx_to_pmc,
>  	.is_valid_msr = intel_is_valid_msr,
>  	.get_msr = intel_pmu_get_msr,

