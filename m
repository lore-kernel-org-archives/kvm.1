Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A33B0CA52;
	Mon, 15 Jun 2026 05:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781502472; cv=none; b=KDI/njZ4UaSbJLa5JH/8COAECXBncV9K8tkDYHjYp14H6QfJWKGQZMo1V3V1Kl0GOJ74rZ2fZqB0FnZJNvKNlXQMZnKeoPTywIhMQGGcJjeZHa5sXSEwMwCrWS3SmLv9DEqHqVrdgBdhTS5ZVl7eQkxJ+IqtgskFcMGyQsaIpFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781502472; c=relaxed/simple;
	bh=EoKRMpNR1HD1fTaS9gHUJwEQYMgmkmfWK7gOf14CKmU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u9r4UZuSNveUGGnxGkCldSCRH1FlXvQ/6AyjWegFKB4+zq627C3vw3RMo9DLHpX5qmkpJ60cHNGywodko2CB4xT6AfsW9zETQ0CPvO71aNaF0AR8mT8MXSk6Ne0dYmNrbOPtcKA0b9L6YWmTrtzJMQO9v2My4oQfyyOt9AOS8rE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MNqwmO8x; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MNqwmO8x"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781502471; x=1813038471;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=EoKRMpNR1HD1fTaS9gHUJwEQYMgmkmfWK7gOf14CKmU=;
  b=MNqwmO8xzukJWuyQlrh0yL/91VeehVyuN1We8+HckNY+S/bhYgjg4Bcw
   vpDgM0QI3I/yUf0MwA0uZ9k6EBEiCfyMYSyT+8Xd8DBluVZLX1172FP3H
   SBoem5MHhhfW/YMF55xMTjs6Fjr+FqrKmzUp2s4lwum3HVAvGTtnKbHVt
   N9/0uTG+5G01A2ZqmtqH6ro3yAICTiAtGtjIGWdE6t+0eMUfNeKeEmQIb
   XdhKZg2Xj8TidYh9+//ao03J6GChH6iW6/cmS0SXe+0JG37+AfXs9q+fC
   YcM2Ns58+e/JBfndou2z9RoM6HOF3IW5PYepjpTu6DIQMpxFNE5AkOj+W
   w==;
X-CSE-ConnectionGUID: /pLjh1FmSkKTHiAyicE37g==
X-CSE-MsgGUID: i19pT+k+THi2TAToy/c5cA==
X-IronPort-AV: E=McAfee;i="6800,10657,11817"; a="81371853"
X-IronPort-AV: E=Sophos;i="6.24,205,1774335600"; 
   d="scan'208";a="81371853"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2026 22:47:50 -0700
X-CSE-ConnectionGUID: O/uWe0jvTvaLtc44lhyT+g==
X-CSE-MsgGUID: xHgNt4qVR362HFyuizz/zQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,205,1774335600"; 
   d="scan'208";a="247465599"
Received: from unknown (HELO [10.238.2.24]) ([10.238.2.24])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2026 22:47:48 -0700
Message-ID: <5bcd4834-7b4d-4543-828a-1e6a6c523a41@linux.intel.com>
Date: Mon, 15 Jun 2026 13:47:45 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 05/30] KVM: x86: Move local APIC specific helpers out
 of asm/kvm_host.h
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Yosry Ahmed <yosry@kernel.org>,
 Kai Huang <kai.huang@intel.com>
References: <20260613000329.732085-1-seanjc@google.com>
 <20260613000329.732085-6-seanjc@google.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20260613000329.732085-6-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/13/2026 8:03 AM, Sean Christopherson wrote:
> Move single-use local APIC IRQ helpers out of asm/kvm_host.h so that they

Nit:
Not sure if it's accurate to say kvm_lapic_irq_dest_mode() is a single-use
helper.

> are co-located with their user, and not exposed to the broader world.
> 
> No functional change intended.
> 
> Reviewed-by: Kai Huang <kai.huang@intel.com>
> Reviewed-by: Yosry Ahmed <yosry@kernel.org>
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>

> ---
>  arch/x86/include/asm/kvm_host.h | 12 ------------
>  arch/x86/kvm/irq.c              |  7 +++++++
>  arch/x86/kvm/lapic.h            |  5 +++++
>  3 files changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index 3886b536c8a5..71e575d011e7 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -1772,11 +1772,6 @@ struct kvm_lapic_irq {
>  	bool msi_redir_hint;
>  };
>  
> -static inline u16 kvm_lapic_irq_dest_mode(bool dest_mode_logical)
> -{
> -	return dest_mode_logical ? APIC_DEST_LOGICAL : APIC_DEST_PHYSICAL;
> -}
> -
>  enum kvm_x86_run_flags {
>  	KVM_RUN_FORCE_IMMEDIATE_EXIT	= BIT(0),
>  	KVM_RUN_LOAD_GUEST_DR6		= BIT(1),
> @@ -2509,13 +2504,6 @@ void __user *__x86_set_memory_region(struct kvm *kvm, int id, gpa_t gpa,
>  bool kvm_vcpu_is_reset_bsp(struct kvm_vcpu *vcpu);
>  bool kvm_vcpu_is_bsp(struct kvm_vcpu *vcpu);
>  
> -static inline bool kvm_irq_is_postable(struct kvm_lapic_irq *irq)
> -{
> -	/* We can only post Fixed and LowPrio IRQs */
> -	return (irq->delivery_mode == APIC_DM_FIXED ||
> -		irq->delivery_mode == APIC_DM_LOWEST);
> -}
> -
>  static inline void kvm_arch_vcpu_blocking(struct kvm_vcpu *vcpu)
>  {
>  	kvm_x86_call(vcpu_blocking)(vcpu);
> diff --git a/arch/x86/kvm/irq.c b/arch/x86/kvm/irq.c
> index 8c62c6d4d5c1..727245a6ab34 100644
> --- a/arch/x86/kvm/irq.c
> +++ b/arch/x86/kvm/irq.c
> @@ -423,6 +423,13 @@ void kvm_arch_irq_routing_update(struct kvm *kvm)
>  		kvm_make_scan_ioapic_request(kvm);
>  }
>  
> +static bool kvm_irq_is_postable(struct kvm_lapic_irq *irq)
> +{
> +	/* We can only post Fixed and LowPrio IRQs */
> +	return (irq->delivery_mode == APIC_DM_FIXED ||
> +		irq->delivery_mode == APIC_DM_LOWEST);
> +}
> +
>  static int kvm_pi_update_irte(struct kvm_kernel_irqfd *irqfd,
>  			      struct kvm_kernel_irq_routing_entry *entry)
>  {
> diff --git a/arch/x86/kvm/lapic.h b/arch/x86/kvm/lapic.h
> index 71970213dc1f..32f09b25884a 100644
> --- a/arch/x86/kvm/lapic.h
> +++ b/arch/x86/kvm/lapic.h
> @@ -237,6 +237,11 @@ static inline int kvm_lapic_latched_init(struct kvm_vcpu *vcpu)
>  	return lapic_in_kernel(vcpu) && test_bit(KVM_APIC_INIT, &vcpu->arch.apic->pending_events);
>  }
>  
> +static inline u16 kvm_lapic_irq_dest_mode(bool dest_mode_logical)
> +{
> +	return dest_mode_logical ? APIC_DEST_LOGICAL : APIC_DEST_PHYSICAL;
> +}
> +
>  bool kvm_apic_pending_eoi(struct kvm_vcpu *vcpu, int vector);
>  
>  bool kvm_lapic_suppress_eoi_broadcast(struct kvm_lapic *apic);

