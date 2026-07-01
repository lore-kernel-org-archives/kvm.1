Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011058.outbound.protection.outlook.com [52.101.62.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA353B2FF6;
	Wed,  1 Jul 2026 22:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782946277; cv=fail; b=EgRQt0fgfHeVYfkk8YPG0uKkvRb1JslIFiXoEBNPU2zgMaAYdsoYiEJfeCvIOd3sTx8oOtWqhznpr60R0XiJc//9et9MDCvZCqofUpDnb1JG+CpjqHDt6pVdXRjQSdhmd3zcN1qz0nZiPEFl74Bl2xhl5Il5FlKBr4KtD1HQDtY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782946277; c=relaxed/simple;
	bh=tCgMrWnPKI7G1k26HYmmSmc/rTN1JByvTteJsIj/Hu4=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QRaotl/hFNiBvmkIv3w2WtwxoHYzuHSfWqv0MuphtMCSpMmA7xdPocT8UXAJmhhPyA/KxeuvrAQNhSoe9wELXbIa642boIPGLjgXBXFvoAAiBedLWBqrTB/074dom3e+xha9j91QMiviLAHyCl0S4iQGbObnSiXGEDkWFUg8xkY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=yrS2C7gW; arc=fail smtp.client-ip=52.101.62.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="yrS2C7gW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hc2MY1knHZ9Gp62zs37BOPj8mhBqYRAzeH9g/W+TL6zKedx2rsqJuldQX+ARSrEHs2QVR4BSJfp9mI5st7KOptcT79GRuozDZEAqsJomWu/XBI9F3/TxqjovS9RKvgfhGVoRmHXRD5MCKy3vqAysBjLEfE2H7Q+AzkDpO4xvAdqCBHHAqurazK38X1dj+uE9kF7nIdulSPNsy2qhXjJwEs6GKfW8mSR9ubHcFmTTxyRda431rZ1/Acw5KKSv7W6iGXhe4kJV2Rl4yOnhjuZHEVzd7FJ7AbjJE1KWHGuuYRvTWTw8PK9y6ypFqk2X1dtQ/WN59P7gDjiedA+J+TQb+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MJ7ZyH4cbHmTuzV18VQUtzlQPYixEv0cbbQd0AOP6iI=;
 b=jNEvhFrbKMaLD/rYEw9rXVNRYo/9te1jVG0iNrdSxg7zNa+U1gt3mKJgAv9NTThHi0OgJ7PAzGxPDTWMCkRhnGTWRLXFBles2dJgUlVQRsGLDgTa6m5vYiGlspI+uh+VxL0j4qurXmr2QZR/NRRALkC+ekrQkiHqtt6GIa5vl32OVj079hHsXC0Fju6w3MN9BxV4Fmt7k+qbGXYj5J9jUilcu8JZgjn1rxjcnLzPCWFFiPf/o/Kr4vR71d6hOn40y7aOJELN7RVwB1d12FuZl94UjvKOXeEamkK96CYts68ePsqJO0e3k7198+N/HLqmJ/lVzgUaa/btx+bv8U5SoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MJ7ZyH4cbHmTuzV18VQUtzlQPYixEv0cbbQd0AOP6iI=;
 b=yrS2C7gWDofW00/vo+pyAc56wadovomcOKvVbB8NmoO8Np6vZyhLr4RAZLGLFcOlyqSgiMFvxHSPZrIKRPSQ6ZadtW3cUG+O7WgyzVU538cZjbGC20z2N4y0CIFL26tC6GMxiCV9/y5YZPZfqFBesLlz9H+RNytwXLY0rPbsTHU=
Received: from DS7PR03CA0108.namprd03.prod.outlook.com (2603:10b6:5:3b7::23)
 by DS7PR12MB6165.namprd12.prod.outlook.com (2603:10b6:8:9a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Wed, 1 Jul 2026
 22:51:05 +0000
Received: from SA2PEPF000015CD.namprd03.prod.outlook.com
 (2603:10b6:5:3b7:cafe::8f) by DS7PR03CA0108.outlook.office365.com
 (2603:10b6:5:3b7::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.9 via Frontend Transport; Wed, 1
 Jul 2026 22:51:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF000015CD.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Wed, 1 Jul 2026 22:51:05 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 1 Jul
 2026 17:51:04 -0500
Date: Wed, 1 Jul 2026 14:41:43 -0500
From: Michael Roth <michael.roth@amd.com>
To: Sean Christopherson <seanjc@google.com>
CC: Paolo Bonzini <pbonzini@redhat.com>, <kvm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Ackerley Tng <ackerleytng@google.com>,
	Hyunwoo Kim <imv4bel@gmail.com>, Tom Lendacky <thomas.lendacky@amd.com>,
	=?utf-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>, Fuad Tabba <tabba@google.com>
Subject: Re: [PATCH v3 04/12] KVM: Rename .gmem_invalidate() to
 .gmem_reclaim_memory()
Message-ID: <zbnvtw4oim3x5yhbnnssa2fsesnjn22lntwy6fhvh5y4b6dlqc@u3wijxm6pjww>
References: <20260630222607.497895-1-seanjc@google.com>
 <20260630222607.497895-5-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260630222607.497895-5-seanjc@google.com>
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CD:EE_|DS7PR12MB6165:EE_
X-MS-Office365-Filtering-Correlation-Id: fa914ca2-7282-4101-eb97-08ded7c33bdc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|23010399003|82310400026|36860700016|18002099003|22082099003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	aV4croQt96J00aDJODfjbRD3679zY4Slw+EblCpdXj2F+g+ew8O8IuIPWUOnjYa7LJY7ODFORxCLeR8w+/JqHgSaja59ztTCDps3DNdV6w3hdZ7rB/sMWBj1LBL1kiPoGnDjhrYutOJ7fpR0hS6GT7a+k5iRRYbpkLVtVusyyMbaC/LhYp/iEEFq6qz+1CTYazW0NifDX2N8DclLw0QvmWOo/M9va+B4DN1PmnluQ+tDl+Z0y/Ni0pwibPvK1Nb8s5TgS6tXOySciOXR9nTD9Wg/rqZ12jWlhSanH9FNmETEg+CU64uq9Q8l/aMz/Cu9H6LrGK9M79dih5czuFzij59YKjC80ynLqqOmGOeN84UKwPpsYN2VawzOtJRzGP1DuPyVWdw8vF7Xs85ntZUqKEZGScFoOQ4j8/myANKYjX3DcBNhd7jENuo/PLt11jI8iQBJQs1Xt9jVSz8b247vdgDCCUJki4N8qfuGj1s90aiQz9YB5cpaEvMs+ChUf8jOssjmvR28g9MXRVFSWDgqkJ5A+yjL2NdACRSsjWEJz9G6PsghvIwI9oJQ3JtN5TcbsUU+VG+U4Y54vax7uSpbDSsWp0ZR8Fvyq7bxtu4H+8pVVSOawNTjm0P0ugK53Y680SUHYR/UXD0cFeE33O1cwAkiTVpz/gSz5mqSxsC5C4fQBR4gXwTqvyCoSEuEsT4s8xP/4j2S1wk8OOx99ka66w==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(82310400026)(36860700016)(18002099003)(22082099003)(11063799006)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	5fVuJvAGxBLiqDbIvpg83Ji2dxYeZlKvG6zH1u+caVVKgDNKKUSChgxw3OtkABsK1OCIDjSxZNYAVgRbDcVFK7yrSSsJibHAwRXb7mj3q3893u+QC2V0ogQbEY9D9gBjNRk3xJq2ebTDTGHGt9xnD6+cRUedAsmqlfNEPvoCAVgg1BBILX6UrWTOfiJKvz3rVvPMjMtKmVMWsr8IGqNKxZxUOI717gS8YhgAUdLi0J8JGLC0uYgvXAht0/f9pOBs3i3xtgnmCd0SqR8hJnL+rxAWd/kYKEClG48QECIcccELa4HQ6DU1houlmR7UbS3/c+/KNDcm69DNvLGSzBh6UrX4nvsncIoy2ul/VA/HupG1WlP3ZRKRojwm9bxxFDiPDprQhJDnUw8SYcRYkS9exIjlcWsnQuzJZsPA6YAQmQ4ezDwmAxIbL8v7+RsT/8wX
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 22:51:05.5733
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa914ca2-7282-4101-eb97-08ded7c33bdc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015CD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6165

On Tue, Jun 30, 2026 at 03:25:59PM -0700, Sean Christopherson wrote:
> Rename .gmem_invalidate() to .gmem_reclaim_memory() as the hook is called
> when a folio is freed, which is far too late and lacks sufficient
> information for KVM to actually invalidate its usage of the memory.
> 
> Keep guest_memfd's trampoline, even though it would be trivial to wire up
> .free_folio() directly to an arch callback, to avoid bleeding guest_memfd
> internals into arch code (specifically, avoid referencing folios in arch
> code).
> 
> Opportunistically guard kvm_x86_ops.gmem_reclaim_memory() with an ifdef to
> ensure the callback will actually be called, e.g. so that non-SEV code
> doesn't try to wire up a callback without enabling
> CONFIG_HAVE_KVM_ARCH_GMEM_INVALIDATE.
> 
> No functional change intended.
> 
> Cc: Ackerley Tng <ackerleytng@google.com>
> Cc: stable@vger.kernel.org # 6.12.x
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Reviewed-by: Michael Roth <michael.roth@amd.com>

> ---
>  arch/x86/include/asm/kvm-x86-ops.h | 4 +++-
>  arch/x86/include/asm/kvm_host.h    | 4 +++-
>  arch/x86/kvm/svm/sev.c             | 2 +-
>  arch/x86/kvm/svm/svm.c             | 4 +++-
>  arch/x86/kvm/svm/svm.h             | 3 +--
>  arch/x86/kvm/x86.c                 | 4 ++--
>  include/linux/kvm_host.h           | 2 +-
>  virt/kvm/guest_memfd.c             | 2 +-
>  8 files changed, 15 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/x86/include/asm/kvm-x86-ops.h b/arch/x86/include/asm/kvm-x86-ops.h
> index 83dc5086138b..acae9f6d6c5e 100644
> --- a/arch/x86/include/asm/kvm-x86-ops.h
> +++ b/arch/x86/include/asm/kvm-x86-ops.h
> @@ -147,7 +147,9 @@ KVM_X86_OP_OPTIONAL(get_untagged_addr)
>  KVM_X86_OP_OPTIONAL(alloc_apic_backing_page)
>  KVM_X86_OP_OPTIONAL_RET0(gmem_prepare)
>  KVM_X86_OP_OPTIONAL_RET0(gmem_max_mapping_level)
> -KVM_X86_OP_OPTIONAL(gmem_invalidate)
> +#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_INVALIDATE
> +KVM_X86_OP_OPTIONAL(gmem_reclaim_memory)
> +#endif
>  #endif
>  
>  #undef KVM_X86_OP
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index b517257a6315..5e8603deb252 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -1901,7 +1901,9 @@ struct kvm_x86_ops {
>  	gva_t (*get_untagged_addr)(struct kvm_vcpu *vcpu, gva_t gva, unsigned int flags);
>  	void *(*alloc_apic_backing_page)(struct kvm_vcpu *vcpu);
>  	int (*gmem_prepare)(struct kvm *kvm, kvm_pfn_t pfn, gfn_t gfn, int max_order);
> -	void (*gmem_invalidate)(kvm_pfn_t start, kvm_pfn_t end);
> +#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_INVALIDATE
> +	void (*gmem_reclaim_memory)(kvm_pfn_t start, kvm_pfn_t end);
> +#endif
>  	int (*gmem_max_mapping_level)(struct kvm *kvm, kvm_pfn_t pfn, bool is_private);
>  };
>  
> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> index 30792adcfc8e..4465e75494f2 100644
> --- a/arch/x86/kvm/svm/sev.c
> +++ b/arch/x86/kvm/svm/sev.c
> @@ -5136,7 +5136,7 @@ int sev_gmem_prepare(struct kvm *kvm, kvm_pfn_t pfn, gfn_t gfn, int max_order)
>  	return 0;
>  }
>  
> -void sev_gmem_invalidate(kvm_pfn_t start, kvm_pfn_t end)
> +void sev_gmem_reclaim_memory(kvm_pfn_t start, kvm_pfn_t end)
>  {
>  	kvm_pfn_t pfn;
>  
> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index ef69a51ab27f..6be0000ab386 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
> @@ -5460,9 +5460,11 @@ struct kvm_x86_ops svm_x86_ops __initdata = {
>  	.vcpu_get_apicv_inhibit_reasons = avic_vcpu_get_apicv_inhibit_reasons,
>  	.alloc_apic_backing_page = svm_alloc_apic_backing_page,
>  
> +#ifdef CONFIG_KVM_AMD_SEV
>  	.gmem_prepare = sev_gmem_prepare,
> -	.gmem_invalidate = sev_gmem_invalidate,
> +	.gmem_reclaim_memory = sev_gmem_reclaim_memory,
>  	.gmem_max_mapping_level = sev_gmem_max_mapping_level,
> +#endif
>  };
>  
>  /*
> diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
> index d077783c287e..cf7c1a437f38 100644
> --- a/arch/x86/kvm/svm/svm.h
> +++ b/arch/x86/kvm/svm/svm.h
> @@ -1009,7 +1009,7 @@ int sev_dev_get_attr(u32 group, u64 attr, u64 *val);
>  extern unsigned int max_sev_asid;
>  void sev_handle_rmp_fault(struct kvm_vcpu *vcpu, gpa_t gpa, u64 error_code);
>  int sev_gmem_prepare(struct kvm *kvm, kvm_pfn_t pfn, gfn_t gfn, int max_order);
> -void sev_gmem_invalidate(kvm_pfn_t start, kvm_pfn_t end);
> +void sev_gmem_reclaim_memory(kvm_pfn_t start, kvm_pfn_t end);
>  int sev_gmem_max_mapping_level(struct kvm *kvm, kvm_pfn_t pfn, bool is_private);
>  struct vmcb_save_area *sev_decrypt_vmsa(struct kvm_vcpu *vcpu);
>  void sev_free_decrypted_vmsa(struct kvm_vcpu *vcpu, struct vmcb_save_area *vmsa);
> @@ -1039,7 +1039,6 @@ static inline int sev_gmem_prepare(struct kvm *kvm, kvm_pfn_t pfn, gfn_t gfn, in
>  {
>  	return 0;
>  }
> -static inline void sev_gmem_invalidate(kvm_pfn_t start, kvm_pfn_t end) {}
>  static inline int sev_gmem_max_mapping_level(struct kvm *kvm, kvm_pfn_t pfn, bool is_private)
>  {
>  	return 0;
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 0626e835e9eb..6b9a1b0b1460 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -10592,9 +10592,9 @@ int kvm_arch_gmem_prepare(struct kvm *kvm, gfn_t gfn, kvm_pfn_t pfn, int max_ord
>  #endif
>  
>  #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_INVALIDATE
> -void kvm_arch_gmem_invalidate(kvm_pfn_t start, kvm_pfn_t end)
> +void kvm_arch_gmem_reclaim_memory(kvm_pfn_t start, kvm_pfn_t end)
>  {
> -	kvm_x86_call(gmem_invalidate)(start, end);
> +	kvm_x86_call(gmem_reclaim_memory)(start, end);
>  }
>  #endif
>  #endif
> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index ab8cfaec82d3..d777eaadbcd2 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -2607,7 +2607,7 @@ long kvm_gmem_populate(struct kvm *kvm, gfn_t start_gfn, void __user *src,
>  #endif
>  
>  #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_INVALIDATE
> -void kvm_arch_gmem_invalidate(kvm_pfn_t start, kvm_pfn_t end);
> +void kvm_arch_gmem_reclaim_memory(kvm_pfn_t start, kvm_pfn_t end);
>  #endif
>  
>  #ifdef CONFIG_KVM_GENERIC_PRE_FAULT_MEMORY
> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> index 86690683b2fe..db0fcc38b145 100644
> --- a/virt/kvm/guest_memfd.c
> +++ b/virt/kvm/guest_memfd.c
> @@ -530,7 +530,7 @@ static void kvm_gmem_free_folio(struct folio *folio)
>  	kvm_pfn_t pfn = page_to_pfn(page);
>  	int order = folio_order(folio);
>  
> -	kvm_arch_gmem_invalidate(pfn, pfn + (1ul << order));
> +	kvm_arch_gmem_reclaim_memory(pfn, pfn + (1ul << order));
>  }
>  #endif
>  
> -- 
> 2.55.0.rc0.799.gd6f94ed593-goog
> 
