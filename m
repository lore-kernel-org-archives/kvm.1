Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010000.outbound.protection.outlook.com [40.93.198.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4BC33A8740;
	Fri, 13 Mar 2026 16:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773420662; cv=fail; b=NAIGkREU9c250EOeOnjj2JsjTBazt+Y/5s1Rtlk8ae6blbG46ATH4bHi7C+WhUpc8wqL/0MmeuFzj4+VouqVd1zN59LvjNvVP+eS9NZsd8fZtytqi9xNwWZa828WiakjDiNnBu6AB2aNqRr9OhrgmHzodui3R+tInvpBwbpsy7c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773420662; c=relaxed/simple;
	bh=Krhii2QzrtMZm7C6oYKBJsGw75KdjdXxZNrjGjClHtc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Aj6Zq+V7uo670l2Gc9XEDYcEmZm2oPeuxPodDVl3/+fYc0rZsfpth1VdHvUzth7Dfp762W1dAqX+yOAAq59cUhg/f1lHO8eqaiBXilr+6KsGt+qepTEeXRAq1YANHvytqWf/7Ahg+BZHVbFJDHwS41/03UqmWivIPabyCOvSRMA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xwSWmo5E; arc=fail smtp.client-ip=40.93.198.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xwSWmo5E"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eA4buZv1rF3BEWzTQPYj6xyagh6aIGbUQ9xOjfExpLLW0X3pCHv+faloodNR/3+0GcP/tqfebiieFukdk0v9/h/tmMcGyTyCYccKS5Jz/0LWxZFbVcFRmj6DITBecMkXQTAtKtoPKJKXqJ1PFnzQwpeUTjaffbEVoei1clXKkM9CYZhzPca3/CqFuWpqt3boEDp07v8p79Lz+p1usxlgRB5XEGmIDQB323NbrsYZGGSxTlpLmBEwIEsRpjwQGBAS0uV7enUKy+zVaaRQisKnSlc8yLeSb0LWIK/CRj0YEjHyspIDd97ns+V0K5ijBNHrY3QMxOo7KDnDpkNd/v/T0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yd7EsjNE6Ble/jUxX+fc8rvL1rsOk3T6DDEReZbRbZ4=;
 b=hcA8/oZ0KnuLq/6H/ub9Xe58CUGr1oe65s1qdGkcnXIn1tY20HMizC5zrNhXSiXdkrD7yWP30ZLDO1G4vjPNV2KoQEVcrBEsnqUtfc972FWFU+CzcBx46ddDKHH/aC+0F0ce8QtCN27hcxDt+Iy3dy0IGDqnGpTp5szMdEcH4Y48zQZ60BuqLTnuer0hSioV0WMSd7fj43TVfGCSI55U7Xq2XfBzDKXp3FPvouHprNdxStW2dvYSaZMnIIfaeVKOIHKo9iQwbav/xZrYxGqjT9u3ODEv2r4rb9m7NE8JJPZ9ourTTG2PqpafRb3QhW1I0o7rhdhb5vfugk9f5DztHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yd7EsjNE6Ble/jUxX+fc8rvL1rsOk3T6DDEReZbRbZ4=;
 b=xwSWmo5EfyhJMP12vrSdlcVZ+GneSkLa4kptzeIytuJn/BuRHgApRAflcPdzMXm5azXWd8xGH/HheaOq7dUqCF7KkyT/5K44j24AkfggDmpJvqp9voLb6TDcobdVpTkFS63FGyTekCeePTmogu+EVwy38h3SfdLTJr/aiQAa8nU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5070.namprd12.prod.outlook.com (2603:10b6:5:389::22)
 by CY8PR12MB8195.namprd12.prod.outlook.com (2603:10b6:930:77::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.8; Fri, 13 Mar
 2026 16:50:53 +0000
Received: from DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::f3f2:852c:78d5:9353]) by DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::f3f2:852c:78d5:9353%4]) with mapi id 15.20.9723.008; Fri, 13 Mar 2026
 16:50:53 +0000
Message-ID: <1b1a4428-4e7e-4a25-b5ec-a7e275ef1406@amd.com>
Date: Fri, 13 Mar 2026 11:50:50 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] KVM: SEV: Add support for SNP BTB Isolation
To: Kim Phillips <kim.phillips@amd.com>, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org, linux-coco@lists.linux.dev, x86@kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>, K Prateek Nayak
 <kprateek.nayak@amd.com>, Nikunj A Dadhania <nikunj@amd.com>,
 Michael Roth <michael.roth@amd.com>,
 Borislav Petkov <borislav.petkov@amd.com>, Borislav Petkov <bp@alien8.de>,
 Naveen Rao <naveen.rao@amd.com>, David Kaplan <david.kaplan@amd.com>,
 Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
References: <20260311130611.2201214-1-kim.phillips@amd.com>
 <20260311130611.2201214-4-kim.phillips@amd.com>
Content-Language: en-US
From: Tom Lendacky <thomas.lendacky@amd.com>
Autocrypt: addr=thomas.lendacky@amd.com; keydata=
 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
 WiyqywZI5g==
In-Reply-To: <20260311130611.2201214-4-kim.phillips@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0080.namprd13.prod.outlook.com
 (2603:10b6:806:23::25) To DM4PR12MB5070.namprd12.prod.outlook.com
 (2603:10b6:5:389::22)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5070:EE_|CY8PR12MB8195:EE_
X-MS-Office365-Filtering-Correlation-Id: b77f475c-ee8a-4f99-2d4b-08de8120b04b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	GdMXXq7VOXza80YqS/K51oR7ZcYPSymni72huw+479X/pYz9DPs5FTlNZ1fUyRwuVrQX8ZyEESQnmy1E4XA/ZEYd3eNlvZQNwVgCGcIQIitepfdsWk8dGTv22KxqBPptNi7s1spcmE2DxUXjMOy0Iz+y/ylh7cHAOKuKGmmo12iXwe5FBoj+6MP9U0QpZkpP5EhRlI7+h4igEHksAJ0xF9P+E7YmhhW9yt18Y0BD79EpBpwnZ5NmZXYTptb89nhTOsyDQUOVlMXz8wSB2cyUsSxLem4kqxjs9tB3NRQu2Od5dUj39EDWngQlroAnpNmIxJIG4tcxaYAB6Dgqv2z/S19tSXGA9MbzxVw+QITMgkRgm/CNoShhm0eMbtEe9mFd0k8awMzBrate1PFq3pUG7ImJb0lFgQV767R5sGUBvg2vrGlwbO9hlBnnIIgSCqZNNGlZjpmwv4BB1df9VKifky3HeuhHoby9t3VLQ7rexVNtL0vwx7OTlF0baDLrM3NMu2+tm3BYK+oLnE/1C3INVhXhYCEDBwPXExF42Cuq8GeUd9KunzNUiv9iFLohioQw57jUZOckfEeM8XftZr8+41juPwf8U1mgx8ikE8x4c877yK9hbDaV1ig+6Sol5aQlE0MAkOTRgYDiO30WtBLs4VogaL9Ntd5SxaBpReioBSj3hNoNIme/cMDZS6r0P4zN5KsnO0lYqIaPCYgUNvBXNwxV93sR24HcpD3WW52gVDiUJoIlQgiUop/AINrTKNuB
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5070.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V0ovbHVHOWhxeHlsZURSd25DVGZ5VkUwR2dubVpYb2h1WDhldXZydWpodHhB?=
 =?utf-8?B?dE10bHJrZXVMbmNUZTJMQ01NbkdxZjZVbFU4SkIvNVJrZnEwL0JNN0RnaXBI?=
 =?utf-8?B?OHRmVlZEZzlmVFNKclhjTEs5SzBmY1FtVU1FZmtsbGZ2bld4Umo5WldsUnN3?=
 =?utf-8?B?YVFnQUhYVnBSZW1BVWZwNkRlMnJrMkNmcUZpeTJJZGRmUkpaWmt0MncvaTRq?=
 =?utf-8?B?Qk5QWUorM0ZnQUJXZW5QcFNaSnpGWVdwSnZWZHFpRGsybkFLY1FWLzZaRHov?=
 =?utf-8?B?aHF1K2ZEUXBac0p1YjI3cUN0eWRJb2Zhb1JCei9QVUZyKzN5RWtuU1JBNk5H?=
 =?utf-8?B?Sm9nQmluNzhFL01TcXdmWHZOdlo4Q1RCK2gveEF6WUF3RFBGL0N1Z3l0UlNR?=
 =?utf-8?B?WGpYaGxyVEpqM09uQ011aUxiNkU5Nm9oam91a04xay9GNXZEZ2E5VHM4ZSs0?=
 =?utf-8?B?TGV6YzJsVHp3MW10NGFzRjA3ajVuYVhpQ2MwYWJGSjNOMjNWamtySEo1SHNZ?=
 =?utf-8?B?YytjR05MY0FZOG5laGcrakgyaDVYR29ncTI5OUhyeDQ3Q3g3b0dPTVdVZFQy?=
 =?utf-8?B?d3hVRndZYnNXbUhoY2FRemw0RnBjK0cxRnhmSGI3c04vT3lHeEh1bU5yR3Bj?=
 =?utf-8?B?L0ROOFhpR3BNZUhBa2Z0dDRFUjdJbjBtK3JWdXZnaWZxb2hranlnU0VERmRZ?=
 =?utf-8?B?bm43aThTWUEzNE5tb01SeEZVaVR5dWllUXlhZnJKbnlIWWo1b2lKNE1nMXM5?=
 =?utf-8?B?V0hVblNoR2NleU4ySWxiY1FEWE0zYkRDclpnZDNZZ0w4ZHQ0SE1yNXIyR3Jh?=
 =?utf-8?B?c21qcUJ0R09hQlQ1K0tYYlpBVmJ6THVVMkVob1pKVzN5TU1vWDlSb1FRUWxt?=
 =?utf-8?B?S0JXWlFNUFBtK1U2Z0pKZWJna2R2YURPZk5IbVZFaXpiL0VvUUxRUUNnQkJM?=
 =?utf-8?B?cGx2QWJFWFRaWk9iTUhJQlNJMUp0TkJ0ekNSbGVyMTNZdmducHFQQ0RzQ2Zq?=
 =?utf-8?B?ZXMzU3NjZzIyQU91OXg3UHBHSmorMFZzalpyRGNIeFhGU0V2djI5blJFVWYv?=
 =?utf-8?B?d2xLdHE2NFExVmNSWEd0VGh5cThOU3ZZTUsvSG5zNFZPQmUyNEJUa3ZHL2hM?=
 =?utf-8?B?RkhKeDk1alo3VXBZRXY5S2Y3azJHR0d0eVJNUWZHeVZCR0hrWjU0VFBFb21R?=
 =?utf-8?B?Mnc3TklJNVZDd1cvV3Nad2NxUTQvNmliQnREVE1jYWNBWWxnenNUK0VzYTNV?=
 =?utf-8?B?UmtEQXVDM0I3bnVhZHhEeU1Tc1dnNGVYZUptN3VFSkpPM1dyTXAzSHlpRFlp?=
 =?utf-8?B?YmZCV0dWUFR1ZXQvczVUZVFmZXQ3b1g4VlpSdFVodTRhanhyWFYwNjJZVVJR?=
 =?utf-8?B?b0xBOFd5K0xLL1BhVHJQazRLTkExN2RYWENHazh2Qm84NmtHamVSdUlqVnZH?=
 =?utf-8?B?dFlwcGtjWEpod2ZyWlFySnpFNG1PY2ZJQVdoNTVNVktNMGs4RkRFb1hYVzBo?=
 =?utf-8?B?bm84NDlkcm0vc2Fma09OdzNLYXVTbWJpaldKUGEybnN1eEJhV2txOHp4WkxW?=
 =?utf-8?B?ZVNMNFpHNytHekE1ZEZHWmFUVE1YWnBMR1pJUkJxWFZDZFh4L3RGQjJaZGZB?=
 =?utf-8?B?VGdnY1RiUVA4MnA5Y1hjaS9pVDhoLzJqZlArNGJIOGF6Q0lzZUxGK1hvd0E0?=
 =?utf-8?B?ZitkTTk5YVhoUEFVdGd4RVp5RGx0aDZQcWlMMEFwMk1TVTVwbzZpSmQ2Rkg5?=
 =?utf-8?B?ZzAyWktxeU8xVDFodVhzUDRzTytmYjlSRDB4OTFIN3hZYWNSN2Zmc1I4S3BT?=
 =?utf-8?B?OWFlc1o5WHFGU3dWQzFxWXZRUW1oaFBSU3c3TTh1R25NaytJaXN6VUhBWE95?=
 =?utf-8?B?NkxZNUl6UTN1Zmc2akhGZUdWb3J3QU9PMUsxRzY5SUFQcFp2Rjd1ajhvK0JJ?=
 =?utf-8?B?S3hoU0dXNjA0V1grY2owSUU4aUx0SUxTYVNOMzN1MGwwYkFtOEpUbnI5WFY1?=
 =?utf-8?B?VjRCM1FOL3N1VzNyTXNUNGJDWXNXbTBPSVM0QVJCZXNFcFM0VWdQV0VNR1VP?=
 =?utf-8?B?V09ySFprT0l6emFTbGFyQzZGbUQ3VTVLUkdnSG13eUJHS01maVo5NFNWZjgr?=
 =?utf-8?B?eUZEVHJpQW5MS1JUbFBMR3lQM20yamhFaW1ZcHVYNHUxQlkzc3NzeUtBNUdu?=
 =?utf-8?B?alRFVDYxMmhFVXIvM1FoWllweFdacEdyYTV5SHZxK0JCbkVqN1ZuVTdEdW9h?=
 =?utf-8?B?dmdBOFNSbDNCenpDUUQ4UUpOdXJoSGZNYjZLUk8xdS9WWGdSSjFMUzZqRkli?=
 =?utf-8?Q?Afm8GgNiFXFhMik/AJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b77f475c-ee8a-4f99-2d4b-08de8120b04b
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5070.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2026 16:50:53.1181
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xG7e1/r01gQAhowFLKQV9dSWH1EI0+X8oAhcrt6ucrp0MD9H4eJfiNT3N9XgExLPZJyynNlK/FyAG8+ohgWL3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8195

On 3/11/26 08:06, Kim Phillips wrote:
> This feature ensures SNP guest Branch Target Buffers (BTBs) are not
> affected by context outside that guest.  CPU hardware tracks each
> guest's BTB entries and can flush the BTB if it has been determined
> to be contaminated with any prediction information originating outside
> the particular guest's context.
> 
> To mitigate possible performance penalties incurred by these flushes,
> it is recommended that the hypervisor run with SPEC_CTRL[IBRS] set.
> Note that using Automatic IBRS is not an equivalent option here, since
> it behaves differently when SEV-SNP is active.  See commit acaa4b5c4c85
> ("x86/speculation: Do not enable Automatic IBRS if SEV-SNP is enabled")
> for more details.
> 
> Indicate support for BTB Isolation in sev_supported_vmsa_features,
> bit 7.
> 
> SNP-active guests can enable (BTB) Isolation through SEV_Status
> bit 9 (SNPBTBIsolation).
> 
> For more info, refer to page 615, Section 15.36.17 "Side-Channel
> Protection", AMD64 Architecture Programmer's Manual Volume 2: System
> Programming Part 2, Pub. 24593 Rev. 3.42 - March 2024 (see Link).
> 
> Link: https://bugzilla.kernel.org/attachment.cgi?id=306250
> Signed-off-by: Kim Phillips <kim.phillips@amd.com>
> ---
> v2: No changes
> v1: https://lore.kernel.org/kvm/20260224180157.725159-4-kim.phillips@amd.com/
> 
>  arch/x86/include/asm/svm.h | 1 +
>  arch/x86/kvm/svm/sev.c     | 3 +++
>  2 files changed, 4 insertions(+)
> 
> diff --git a/arch/x86/include/asm/svm.h b/arch/x86/include/asm/svm.h
> index edde36097ddc..2038461c1316 100644
> --- a/arch/x86/include/asm/svm.h
> +++ b/arch/x86/include/asm/svm.h
> @@ -305,6 +305,7 @@ static_assert((X2AVIC_4K_MAX_PHYSICAL_ID & AVIC_PHYSICAL_MAX_INDEX_MASK) == X2AV
>  #define SVM_SEV_FEAT_RESTRICTED_INJECTION		BIT(3)
>  #define SVM_SEV_FEAT_ALTERNATE_INJECTION		BIT(4)
>  #define SVM_SEV_FEAT_DEBUG_SWAP				BIT(5)
> +#define SVM_SEV_FEAT_BTB_ISOLATION			BIT(7)
>  #define SVM_SEV_FEAT_SECURE_TSC				BIT(9)
>  
>  #define VMCB_ALLOWED_SEV_FEATURES_VALID			BIT_ULL(63)
> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> index 3f9c1aa39a0a..ac29cf47dd08 100644
> --- a/arch/x86/kvm/svm/sev.c
> +++ b/arch/x86/kvm/svm/sev.c
> @@ -3167,6 +3167,9 @@ void __init sev_hardware_setup(void)
>  
>  	if (sev_snp_enabled && tsc_khz && cpu_feature_enabled(X86_FEATURE_SNP_SECURE_TSC))
>  		sev_supported_vmsa_features |= SVM_SEV_FEAT_SECURE_TSC;
> +
> +	if (sev_snp_enabled)
> +		sev_supported_vmsa_features |= SVM_SEV_FEAT_BTB_ISOLATION;

This would also need to update the SVM_SEV_FEAT_SNP_ONLY_MASK that Sean
suggested/created in the IBPB-On-Entry series.

Thanks,
Tom

>  }
>  
>  void sev_hardware_unsetup(void)

