Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010016.outbound.protection.outlook.com [52.101.56.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9BB0353A90;
	Mon, 13 Jul 2026 18:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783967724; cv=fail; b=CAmi/2cCfTYMap2/03AxZOvoUMiFLMu7twse6XeWpo7SVgw8fnK1cEE934/K8InThaRmMg+XAsQ/76hK5Yt1rOE+FFODeo3gTVBoRjt5T0AztfgE1JAYaowj8RzuiVyT5WziEb7maI7uzhzmqudqQAcrz0EXfJmWLOo9RNskE0I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783967724; c=relaxed/simple;
	bh=V3WlJjQPgqPuK66lmDIZfLcYCCmD5S/8ccJbnxhl5TE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gmxZfJw6Fqg2ZhUwioRJY/4zmNxnKwQ11eYTBwM3S+uNo6m1PGKmcJ8O9lVWU1uBiyyjPe8252un3AWzsP9sP7Mwk7DMp/FM8IV6DiF4+5oPQZhx6DSkiYtGmWQ1I88NcF+Afe8zdctNx/9fk/uBThIdjoZueAg9+bbPmo8xODw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Jh+rFNWJ; arc=fail smtp.client-ip=52.101.56.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Jh+rFNWJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SsH3CFh2ufoCUdRY4ur36EfIQIcZKBjAqMXiGKZOArsngbKJLnZvRi7nJageV85okg/MOsKjRYgBFemwBBeH/ryxsZAxfQy/Vg+UWMA4lksvHUALUXcwgQmeezodJOQcwRk8I0DKIFRU4JGAS07L/dSGgnwkMlD32d3lK7dRdwlcoNQWkgXJCci5SfgUCxWb+IowFP1QdTrgOp/M6RIcENJfIVhBqJa6ws1CyON3C+HUBVOTFryD9dklFfAXZGA0kMmLIG0Zg3rxPlafd0NVYTGbMgphQ6w4gnX58AdKxJFPhd8h5OJwjqzItHOrt2En1KGLtzlf4ZX5sAap6bgEsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NGnQmwsEqiOvrkjRKcxwK3z0lJYjy7L5V4KGswWW6fI=;
 b=fGqkQvsoygcHL5xfXyDZnRkpx8aLt1l++VBCFf0Jm7gmX2e8vAAki8mnrjPgWNLxxc/8CUtiKDHtDeAO0arLS4d+Wc+9GBTo6EZ8EVn+s1xC6zkkNNaj1GaDO5kirQRI+uTcSfGmAndsvgeA60xJ8favVwexwSM1U6Kq8AMdLh7TqMw5EGqwhS6p1WLzBegOvF54id6m/zz0vlFHx8ZNTMEhXb646i8q9rxojOOQFlVBJGPJXFlrkr0UQxDIe5CbnCofC7dRGsojrAfxYyRm0i8W1m4IT5jzV4ev97REeJ5uySjOjWKogy8ZukDnPXvgf1XjEJcVE+L+PDLcEt2VRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NGnQmwsEqiOvrkjRKcxwK3z0lJYjy7L5V4KGswWW6fI=;
 b=Jh+rFNWJ8xHqC3VzigQb3Cqage741LXVMVBvhjHNoIVhnzBXLp9SMWYj4qHjE3IPYSZ5tLMy/yEk5cpXy2TujW/smYm7ztsXE5x084lsp1ql8RY4cDwvhnWMQ8AI1BYSZuFGUgF3RTJbvgsendgHr/pD1NAk7P+VCrO3n75QztE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN7PR12MB8131.namprd12.prod.outlook.com (2603:10b6:806:32d::12)
 by PH8PR12MB6940.namprd12.prod.outlook.com (2603:10b6:510:1bf::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.19; Mon, 13 Jul
 2026 18:35:15 +0000
Received: from SN7PR12MB8131.namprd12.prod.outlook.com
 ([fe80::c2dd:62c5:67fe:aa46]) by SN7PR12MB8131.namprd12.prod.outlook.com
 ([fe80::c2dd:62c5:67fe:aa46%4]) with mapi id 15.21.0202.014; Mon, 13 Jul 2026
 18:35:14 +0000
Message-ID: <b27e0ce6-08c9-4f2c-a07e-8bd523ac516e@amd.com>
Date: Mon, 13 Jul 2026 13:35:11 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 06/27] KVM: SVM: Add helper to check if Secure AVIC
 is enabled for a guest
To: "Naveen N Rao (AMD)" <naveen@kernel.org>,
 Sean Christopherson <seanjc@google.com>, Borislav Petkov <bp@alien8.de>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>, Nikunj A Dadhania <nikunj@amd.com>,
 Neeraj Upadhyay <neeraj.upadhyay@amd.com>, Tianyu Lan <tiala@microsoft.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, Thomas Gleixner <tglx@kernel.org>
References: <cover.1783490022.git.naveen@kernel.org>
 <5e077730f0d598623cca4438617f38cf04820196.1783490022.git.naveen@kernel.org>
Content-Language: en-US
From: Tom Lendacky <thomas.lendacky@amd.com>
Autocrypt: addr=thomas.lendacky@amd.com; keydata=
 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
 WiyqywZI5g==
In-Reply-To: <5e077730f0d598623cca4438617f38cf04820196.1783490022.git.naveen@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0100.namprd03.prod.outlook.com
 (2603:10b6:610:cd::15) To SN7PR12MB8131.namprd12.prod.outlook.com
 (2603:10b6:806:32d::12)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8131:EE_|PH8PR12MB6940:EE_
X-MS-Office365-Filtering-Correlation-Id: 16d97c6d-cc65-46e4-5785-08dee10d7ae9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|22082099003|4143699003|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info:
	5wzgakrMZ+1kPng8w2cdO6Fa5XB7uBb9zS+yKr4wHQ0V/ew7C4RvqTXCnqT/LE1ieTV6fC4bIylIifo7OppXlKQ96lC1Z0fos0e9tqCD5VoF9THOzC8je836i9i5szWYVmZjgQaXtOWpFSJm99hn2ywVZfPh/Z/lP9WAzEDXTB7VCehSR+zEqQMq281U+Hh/W4uhQNxd/ojro9XvL+X5/Na7bmAe3hwEB1T7DNSs5/bscUlLYarSr8doWceArwz85Epm9Dz6hE0OtseojQVH9QIOUFZWZCN7jnHhDDtIO/MXBv0wjraR4/u+5Z98Be02+DBpXqqgdw9uWXHUZOOcnnmsYrta2jWOr3tBrLFVyAUTiZgMZLjRbqScErw/yaRjfJe+OhCPVQRNwR3mZcI+poTf0hUeGXOVnvzZvIT2D7Unm1x/DpAMi9Sri16y50eK8Z5YnXZNIW0SLunfulfHA9LvROY7CoBl7Rd/xZcP2gwHavXWjbRyr/wrTKKMazxkhJagbdo6D8RVjHM3KVOsptQaWu1b2X3sl0S0XUEEnelEkCF/SlBxPBgizar8CMO66I8sgTijyL7Fr76h77yGyXVb3ymNYlNWGw4VPdEwQ4LRqG1lrNQkzBi1CIlMFt1N+QVxgMxQjrEAcdx3smbrI1IqW1dWPusQO3+nR6PW4xo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8131.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(22082099003)(4143699003)(56012099006)(11063799006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c1FPYzV1NmN2aEg0b0syWEFxK0RLLy9Ma3ZMSWc2eVlqdTQ3ZFowTjhjYzFt?=
 =?utf-8?B?VWs0bU56Mlc1aURqcVprMFJobW42dE84c3JKTUZXV2owWk5YK0JoNmlXdXVO?=
 =?utf-8?B?eFQzQllWV0VtcnVkejgxUXdxOEdXT1Q3SzVFZEE1cFFCOExFZmFySUF4RWU3?=
 =?utf-8?B?eFVEUkRweFpIZGdZZ2tZVE15aGpsajR6a0ZsNzY5amoxd0xROThvNzFoV3Fi?=
 =?utf-8?B?UXdFZTEzMk5la3hZSzFvaEN0dW9peEVLdW5qYkZ2ZU5XSnBNY2pqbGFuenF1?=
 =?utf-8?B?VlRBMDFFaXRuT2k0KzZWbEVlVE5hbXM4S2RnZ3c3OUFaRk50VTdBQ1pjbDc3?=
 =?utf-8?B?dUhKdm5CVUY2L0pFL3pKamorUHI5UEVvTGhEU0d5bS9kSllqNkdBZVRQUDVL?=
 =?utf-8?B?bVp6TmF6WWhnS0xKUW5Fc0ErbGVEa0MzVlFMOVMrSDUybTdZcEE0ckswTUhX?=
 =?utf-8?B?Yko3YlNSMU1WZ0tzT1RHQlpWdUVwYVgyRHhXQ0RLWjlaeGM3QWhXWlVJSkRi?=
 =?utf-8?B?amVQcUdIWm00L0N3MmZGSVhkRFMvN2o3OEVld1FRd0pFL05ULzRIcHg3NlRP?=
 =?utf-8?B?dlJ3RG1xdzZFQ1lzK3FSY1lIWjVJaTFEZVg5WmZsS1ZPb3crY3gwRkQzMFk1?=
 =?utf-8?B?YUNpUDQ1aGlMd0FleXRycVB2K1Z1eCsrOFVyUStzVFhZVm5NS1AzMmc4VExn?=
 =?utf-8?B?UHpnczN6TDlXR2ZBdHBXcjExMjdRODJvamROeG13b3FvbndSa08yd1czQVkr?=
 =?utf-8?B?eVFnZlVacVZoNmMwa2RBK0RrMS9DY0RvbXdvQlcxKzdHdmVaMnJxV3JZVmFq?=
 =?utf-8?B?SDdCQ2gwYUdQTmVhMnY4bWxKK2UxODFRUGozaS9Pd29HM3gyMUtBRDlQcTJn?=
 =?utf-8?B?YzlxT2JBRzR2SDNvbFlrWVJ0SnIvZVkraFVMQlFsanpHcXRhd3hWRnNhM3Rw?=
 =?utf-8?B?SERUZEIxZXg0RHZycTlJejVZZWxSVmdudTRjUk43Ym9CazZLRVFNU1JnUlNr?=
 =?utf-8?B?TkpZbFJEb3Jsa1lqTkxHelM4MVg5TmMrUnlmand4R1NzOTV2OWFkY05XUTdV?=
 =?utf-8?B?M3QwbU1QVHRQZ0xiQitHeStpcjQ4REZ2YnRkaEIxS1A0cWhSOElWZHkrQldU?=
 =?utf-8?B?cVdkYk45a2hla0k4WTVPam5JNXp5ekNRc0tjVThVcGJqdjliL0dyVmJUTkZE?=
 =?utf-8?B?dWJTNzZSVW83OVVHSVVtZUNucm9obDlEZWIrdGdqeVAwNm52VmNxVDJYQnpR?=
 =?utf-8?B?R2lSUzhxeEt3SXZKRXdSVkFyM1hUWFVUT2lYVkZ3dThYSTVzRVlEc3paQU5r?=
 =?utf-8?B?OENRWnRmejUyYTV0allBa0RRZDU3Z3YrOHJLbWVQV0FaWUZsODM3WWN6a2sr?=
 =?utf-8?B?QkQyZmdaTXlrZ1RpZDRiR2NsOW5ydDRVMDNjVUM2c1lxclU4ak0wTXhnZU9t?=
 =?utf-8?B?NHhlMXJtejBnU3FDM3lidHIwNWhpSWZZT1U1d0ZYc0o4blkvSnhSSXA2dTFY?=
 =?utf-8?B?Mk9MQ0xVM0R3NSs1TmVXWjVLc1NiVWxMTDhlNlE2OFRlWllvWU50K2FNTFpU?=
 =?utf-8?B?NDFKLy9sWDZrWk1ydjlZRUJJalNRSjRxanNwUm9yZU1ka3lCSWV4VnQ3Z25s?=
 =?utf-8?B?VlRUNlVKaXNNd1dENUhxM3dmOVl1Z3V1ai8xQWovRHM4V0c5MktreW9acDkv?=
 =?utf-8?B?OTlGSFE1czVyRTlmdEJFY1U0S2d2VHJBUGJyU2c2QnU4cExRNCtxbG1YYm1J?=
 =?utf-8?B?OWs0V1VMM29TQUVjYWlHbm5NVEpKL0ppenpSbzc3RDlsMHhQNnhBV1h5dEVa?=
 =?utf-8?B?NVlwYUErd05Qa1lBRERjc285WnB5Z1ltUE4vTXR3L0JOcTJVSXZHc1U5dHA1?=
 =?utf-8?B?QUxWY2laREI4YjBLREp2Y3dJSDFSMjRwTWlSNU9vZmFZeEgrblRpS3ZMKzFN?=
 =?utf-8?B?c1lRVzl4MThEWDdrSllKMkNIRHIvbU9UV2hhZGhMcW1jV3NvU1VKaGJVL3dZ?=
 =?utf-8?B?VHU0MXpadkpzbU5pVTB1eVpGemxYR1Mwb1ZUY2xrdjI3ZEZ0VGlSVXNWV0lI?=
 =?utf-8?B?R2hHZHB3N0hkOVBGN1JGRmVCaGNCUmJ6WDh2SXFORENUclU1ejVIQ2luMncr?=
 =?utf-8?B?b1FFOXBqNHBYVFJ4cE16ZXpYSm1EZFdMUy8zOGFUckIzWEpxalppVzR0Z2tr?=
 =?utf-8?B?cjdZUm83bGFXVzRwVHZ1dmFISytoaGRIaEhYZ3ljb0FCdlp0aFVJUEE1SDVJ?=
 =?utf-8?B?dHNkNHB4aWIxa0pMYTZKTi9SWllkdkdUMmNvTHloKzNmSzFMTmk1Z24wNlM5?=
 =?utf-8?Q?JTXCjwRltjd2IAHXJc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16d97c6d-cc65-46e4-5785-08dee10d7ae9
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8131.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 18:35:14.7164
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pwZEfm4VRqkQ71M2AOluYvhFq74u2VRaxu5+9qqgW3M6KSFszKGkR5ZFQwZ9Gtd2IXlNmlrmnKmxJYFBisvs3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6940

On 7/8/26 01:32, Naveen N Rao (AMD) wrote:
> Add a helper snp_is_secure_avic_enabled() along the lines of the similar
> helper for Secure TSC to check if Secure AVIC is enabled in the VMSA SEV
> Features for a SEV-SNP guest.
> 
> Note: Enabling Secure AVIC in the VMSA SEV Features puts the SEV-SNP
> guest in Secure AVIC "mode", and it is up to the guest to then "enable"
> Secure AVIC through the Secure AVIC Control MSR. While the use of
> "enabled" in the helper might sound like a misnomer, it reflects the
> fact that KVM has no visibility into whether the guest has actually
> enabled Secure AVIC or not. For all practical purposes, KVM assumes that
> the guest has Secure AVIC enabled. Since a Secure AVIC mode guest is
> extremely restricted, it is in the best interest of the guest to enable
> Secure AVIC at the earliest.

The last sentence probably isn't needed.

And typically the function isn't introduced until it is used. But if no
one has any objection:

Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>

> 
> Signed-off-by: Naveen N Rao (AMD) <naveen@kernel.org>
> ---
>  arch/x86/include/asm/svm.h | 1 +
>  arch/x86/kvm/svm/svm.h     | 2 ++
>  arch/x86/kvm/svm/sev.c     | 8 ++++++++
>  3 files changed, 11 insertions(+)
> 
> diff --git a/arch/x86/include/asm/svm.h b/arch/x86/include/asm/svm.h
> index 42ececa8963d..5857b942957b 100644
> --- a/arch/x86/include/asm/svm.h
> +++ b/arch/x86/include/asm/svm.h
> @@ -311,6 +311,7 @@ static_assert((X2AVIC_4K_MAX_PHYSICAL_ID & AVIC_PHYSICAL_MAX_INDEX_MASK) == X2AV
>  #define SVM_SEV_FEAT_ALTERNATE_INJECTION		BIT(4)
>  #define SVM_SEV_FEAT_DEBUG_SWAP				BIT(5)
>  #define SVM_SEV_FEAT_SECURE_TSC				BIT(9)
> +#define SVM_SEV_FEAT_SECURE_AVIC			BIT(16)
>  
>  #define VMCB_ALLOWED_SEV_FEATURES_VALID			BIT_ULL(63)
>  
> diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
> index 616e45624f4c..1157d022bac1 100644
> --- a/arch/x86/kvm/svm/svm.h
> +++ b/arch/x86/kvm/svm/svm.h
> @@ -1013,6 +1013,7 @@ void sev_gmem_invalidate(kvm_pfn_t start, kvm_pfn_t end);
>  int sev_gmem_max_mapping_level(struct kvm *kvm, kvm_pfn_t pfn, bool is_private);
>  struct vmcb_save_area *sev_decrypt_vmsa(struct kvm_vcpu *vcpu);
>  void sev_free_decrypted_vmsa(struct kvm_vcpu *vcpu, struct vmcb_save_area *vmsa);
> +bool snp_is_secure_avic_enabled(struct kvm *kvm);
>  #else
>  static inline struct page *snp_safe_alloc_page_node(int node, gfp_t gfp)
>  {
> @@ -1050,6 +1051,7 @@ static inline struct vmcb_save_area *sev_decrypt_vmsa(struct kvm_vcpu *vcpu)
>  	return NULL;
>  }
>  static inline void sev_free_decrypted_vmsa(struct kvm_vcpu *vcpu, struct vmcb_save_area *vmsa) {}
> +static inline bool snp_is_secure_avic_enabled(struct kvm *kvm) { return false; }
>  #endif
>  
>  /* vmenter.S */
> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> index 74fb15551e83..686227a15328 100644
> --- a/arch/x86/kvm/svm/sev.c
> +++ b/arch/x86/kvm/svm/sev.c
> @@ -211,6 +211,14 @@ static bool snp_is_secure_tsc_enabled(struct kvm *kvm)
>  	       !WARN_ON_ONCE(!sev_snp_guest(kvm));
>  }
>  
> +bool snp_is_secure_avic_enabled(struct kvm *kvm)
> +{
> +	struct kvm_sev_info *sev = to_kvm_sev_info(kvm);
> +
> +	return (sev->vmsa_features & SVM_SEV_FEAT_SECURE_AVIC) &&
> +	       !WARN_ON_ONCE(!sev_snp_guest(kvm));
> +}
> +
>  /* Must be called with the sev_bitmap_lock held */
>  static bool __sev_recycle_asids(unsigned int min_asid, unsigned int max_asid)
>  {

