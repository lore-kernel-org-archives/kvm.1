Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BBCF3F54DB
	for <kvm@vger.kernel.org>; Thu,  7 May 2026 13:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778159720; cv=none; b=uQ5/DtExfu2tHilzdFVNnUlqukxdNOURctZ+RPfTiN9nq5O1UJQjQS/G6XN3ngE1pIxrxJZfCju51S/iW3EoDJ379Nf2xM4BgrsrjRi0btS+p8EqpbgN+dNs17G+dYKKndEZlFvnGalIcu9biU4kbISFdiWpTe+phKAHEtIXBtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778159720; c=relaxed/simple;
	bh=TJ0W6FAj31MR3dvN8d50sBuasX/e1T3Sfw51y9p35pI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RPWHTs1I6qHCOZrE5X9guNSM4Egtc4lFnpRQ6JRgtLMv4WVxB/LYX6BsWxaAiPPGCy0FxUhrllat/EwNcqCwLmNT8SP64SvxvA1l4WI4eQ8QXVqGzxEFK89kLPEopJ+U9vTToVLoXpe7OWx1KPJjdwCni8gJFDuCVfKMiuCjyQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Uga1GR8T; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Uga1GR8T"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-835444b6ce1so632260b3a.1
        for <kvm@vger.kernel.org>; Thu, 07 May 2026 06:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778159718; x=1778764518; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ieS6nKC0vkJ+fsaqZW4LZNoV5kL2RHdXCSYZo6FgAl8=;
        b=Uga1GR8TjgztUCTln4ry+JZT6SPApuSj79zy0gxM1l4sG/wyraeqV8bDMLcGd2a9GD
         osr9aB2DLwMUm78zfwApSH2yhStUipxq38+obL36+qMdDTxLQd2ZnOAKF+2eZLVH/8Th
         0VK2QWYW2gjfcy4bPg9x7uXJEOuuSeSV1srt4tQQaLbGoBPqyWyepKzAZOV47OT/lxsW
         PE3JXDPUZRnblrTQyfmNz2obMtTalz/8KpDA6bLRjeGUuDsczACBmk7EI/mti1ZaJ+wF
         et1Lwel8//Ao6Xk7wBKy8A7fvwjcjIeOKdozjZkiMl4vljaxUug7kP3VDgCKWgUfkZVa
         6Zvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778159718; x=1778764518;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ieS6nKC0vkJ+fsaqZW4LZNoV5kL2RHdXCSYZo6FgAl8=;
        b=B8R4dwzkFKFIbjKGIzW+AUfulRr/Zw3LWk+jtdIQAqWLDpuVozXsQNMwQk/l88v7AN
         gEfj3pq88C6xuv11N7gXblfWSjjDFoQDtYwa/uA2T+57L7NSwXg8HyDwIx6rp8vM6cvw
         oNggBvRMSGLcMGJKB6FKHOsmpGqOvmLiP+++LHfOJ+zq0N12JxLukm+FBAVCRlA5CJRf
         H2jRJ939274BjCmjhITAu3t5Dtr6xJv17fKG6yVGDA7cO8N2jcIk5Ibwprwl16BEFj0w
         AK009AlOlouwp7fasMUnWByFvDd3tgSN5wieJnbfs3NtE8UyJn70AzWz9SGqAQxHlOa2
         00Og==
X-Forwarded-Encrypted: i=1; AFNElJ8Uv5oHU8EVdFaUPuB4gXgxitnuNG/4dsW6bB+JxJUj5oR+nCbps6mVKz4CGmI89mYXpNA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBLgPklOaUKgqYq19i8ekv/3JD2eBVPuNNid4gIEeJ+/RLm3Qb
	sb5nbSqXa30hwcjkbex3z74cUd3PE2hiIHcFaN76nQ+XVmPnOJac0zlb/H4ixoEePLgTE4fVIfC
	9MxCuIQ==
X-Received: from pfbld11.prod.google.com ([2002:a05:6a00:4f8b:b0:839:5556:c979])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:140e:b0:824:afe1:f7e3
 with SMTP id d2e1a72fcca58-83a5badc168mr7568181b3a.15.1778159718060; Thu, 07
 May 2026 06:15:18 -0700 (PDT)
Date: Thu, 7 May 2026 06:15:16 -0700
In-Reply-To: <20260507003613.1784851-2-vannapurve@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260507003613.1784851-1-vannapurve@google.com> <20260507003613.1784851-2-vannapurve@google.com>
Message-ID: <afyQZP75rbj68ceX@google.com>
Subject: Re: [PATCH v2 1/2] KVM: x86: Introduce arch specific
 has_protected_pmu state
From: Sean Christopherson <seanjc@google.com>
To: Vishal Annapurve <vannapurve@google.com>
Cc: pbonzini@redhat.com, dave.hansen@linux.intel.com, 
	rick.p.edgecombe@intel.com, dapeng1.mi@linux.intel.com, mizhang@google.com, 
	kai.huang@intel.com, jmattson@google.com, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Thu, May 07, 2026, Vishal Annapurve wrote:
> PMU state for TDX VMs is virtualized by TDX Module [1]. Introduce
> has_protected_pmu state to track the pmu state for such scenarios. Disable
> KVM's PMU virtualization framework if pmu state is protected as
> additional enlightenment is needed within KVM to control/manage the
> visibility of PMU state to such VMs.
> 
> Additionally disallow userspace VMM to toggle PMU state using
> KVM_CAP_PMU_CAPABILITY if pmu state is protected.
> 
> [1] Section 15.2: https://cdrdv2.intel.com/v1/dl/getContent/733575
> 
> Suggested-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Vishal Annapurve <vannapurve@google.com>
> ---
>  arch/x86/include/asm/kvm_host.h | 1 +
>  arch/x86/kvm/x86.c              | 8 ++++++--
>  2 files changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index c470e40a00aa..8371dcaaed1a 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -1422,6 +1422,7 @@ struct kvm_arch {
>  	bool has_private_mem;
>  	bool has_protected_state;
>  	bool has_protected_eoi;
> +	bool has_protected_pmu;
>  	bool pre_fault_allowed;
>  	struct hlist_head *mmu_page_hash;
>  	struct list_head active_mmu_pages;
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 0a1b63c63d1a..4836e206f64a 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -6910,7 +6910,8 @@ int kvm_vm_ioctl_enable_cap(struct kvm *kvm,
>  			break;
>  
>  		mutex_lock(&kvm->lock);
> -		if (!kvm->created_vcpus && !kvm->arch.created_mediated_pmu) {
> +		if (!kvm->created_vcpus && !kvm->arch.created_mediated_pmu &&
> +			!kvm->arch.has_protected_pmu) {

Align.

>  			kvm->arch.enable_pmu = !(cap->args[0] & KVM_PMU_CAP_DISABLE);
>  			r = 0;
>  		}
> @@ -13375,7 +13376,10 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
>  	kvm->arch.default_tsc_khz = max_tsc_khz ? : tsc_khz;
>  	kvm->arch.apic_bus_cycle_ns = APIC_BUS_CYCLE_NS_DEFAULT;
>  	kvm->arch.guest_can_read_msr_platform_info = true;
> -	kvm->arch.enable_pmu = enable_pmu;
> +	if (kvm->arch.has_protected_pmu)
> +		kvm->arch.enable_pmu = false;
> +	else
> +		kvm->arch.enable_pmu = enable_pmu;

	kvm->arch.enable_pmu = enable_pmu && !kvm->arch.has_protected_pmu;

>  #if IS_ENABLED(CONFIG_HYPERV)
>  	spin_lock_init(&kvm->arch.hv_root_tdp_lock);
> -- 
> 2.54.0.563.g4f69b47b94-goog
> 
