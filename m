Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 854352356C6;
	Mon, 15 Jun 2026 05:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781499803; cv=none; b=tQBhYXvku8VS5YKrrIymy8RwVru5jdGQmLhpfvDRNEae5Q02rIbBH49CSrKSqEfDlCwzWAWGEO3ZIBxTt+rxHytPKO2ciGQozxQMx+1gfJkmxNJENJstI/wCI5etHvXvtdOu/3+BPN95S+JJTMelOXuBYTZgde9C49LKutzoBcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781499803; c=relaxed/simple;
	bh=5e5svv7+J2WqqpHKo95064tq+J8tq6Zrv987HcefWnI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dCvkOVHSYQDMQt7iaJkvp4vmvgYh5kGqiFU0vBltGD4wzRjVKY6o5jjG1OBQmY5k6yJGBL7IJP+IoMigSQBDYZP6hRZEQTh+60xUAZCTsI2Ou7NwrQBEPIdzI69K/cSNjsgPNp8TD+F1HZLUzyiBHyYz9PzcsQGZZ2OX4ePhntI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BylerFLd; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BylerFLd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781499803; x=1813035803;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=5e5svv7+J2WqqpHKo95064tq+J8tq6Zrv987HcefWnI=;
  b=BylerFLdnKuTNlyAlZ1mJFgUoPmvuqFp0pXW2RHUURy69u5MYUnwruAI
   rs04xmgpYTLpOGlaDF76US0yyuILCdHKkI57y+vzk9b9nlhIO3QXvwqiy
   r/GhNKIyIP/xJLjRktjTdRcgfWJ+2bCrvaQnLrSdJRqegUZHQacnGaexR
   tLMHMCkuE4Zi6PhI6dnwRqnCrYtRGAGs1Q+MVrjOHFUZDxVrfwxt2bPnR
   /QFyAaBr7snBGVaoBCALmBoRm0iaWbgH3RuliBTV6cOQ1FqIX5VuRqJzu
   LKNxlyzvw/sAPtjdD4aD+zQcmgy9BDlpcW+2GwQH+y3DCus081APi44Bz
   w==;
X-CSE-ConnectionGUID: V2eo/30+QoqIkODGFEVZUQ==
X-CSE-MsgGUID: CEgYrbY5Rg2lAnKGrL6TjA==
X-IronPort-AV: E=McAfee;i="6800,10657,11817"; a="82244253"
X-IronPort-AV: E=Sophos;i="6.24,205,1774335600"; 
   d="scan'208";a="82244253"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2026 22:03:23 -0700
X-CSE-ConnectionGUID: aKPvEoxtQbyZRaeuXnH4mA==
X-CSE-MsgGUID: cXgXhop3Se6UF2g8LlMp+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,205,1774335600"; 
   d="scan'208";a="271049833"
Received: from unknown (HELO [10.238.2.24]) ([10.238.2.24])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2026 22:03:20 -0700
Message-ID: <c77aaa1e-b571-466c-a162-53a4ddc9b932@linux.intel.com>
Date: Mon, 15 Jun 2026 13:03:18 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 02/30] KVM: x86: Move get_segment_base() to regs.h, as
 kvm_get_segment_base()
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Yosry Ahmed <yosry@kernel.org>,
 Kai Huang <kai.huang@intel.com>
References: <20260613000329.732085-1-seanjc@google.com>
 <20260613000329.732085-3-seanjc@google.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20260613000329.732085-3-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/13/2026 8:03 AM, Sean Christopherson wrote:
> Move get_segment_base() to regs.h, as kvm_get_segment_base(), so that the
> bulk of the register code can be moved from x86.c to a new regs.c, without
> simultaneously needing to rename "public" helpers to explicitly scope them
> to KVM.
> 
> No functional change intended.
> 
> Cc: Yosry Ahmed <yosry@kernel.org>
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>

> ---
>  arch/x86/kvm/regs.h | 5 +++++
>  arch/x86/kvm/x86.c  | 9 ++-------
>  2 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/x86/kvm/regs.h b/arch/x86/kvm/regs.h
> index a57ba26279ed..e5b16a0826d9 100644
> --- a/arch/x86/kvm/regs.h
> +++ b/arch/x86/kvm/regs.h
> @@ -412,4 +412,9 @@ static inline bool is_guest_mode(struct kvm_vcpu *vcpu)
>  	return vcpu->arch.hflags & HF_GUEST_MASK;
>  }
>  
> +static inline unsigned long kvm_get_segment_base(struct kvm_vcpu *vcpu, int seg)
> +{
> +	return kvm_x86_call(get_segment_base)(vcpu, seg);
> +}
> +
>  #endif
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 74b8f98dcb24..0f48cd630c32 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -8492,11 +8492,6 @@ static int emulator_pio_out_emulated(struct x86_emulate_ctxt *ctxt,
>  	return emulator_pio_out(emul_to_vcpu(ctxt), size, port, val, count);
>  }
>  
> -static unsigned long get_segment_base(struct kvm_vcpu *vcpu, int seg)
> -{
> -	return kvm_x86_call(get_segment_base)(vcpu, seg);
> -}
> -
>  static void emulator_invlpg(struct x86_emulate_ctxt *ctxt, ulong address)
>  {
>  	kvm_mmu_invlpg(emul_to_vcpu(ctxt), address);
> @@ -8641,7 +8636,7 @@ static void emulator_set_idt(struct x86_emulate_ctxt *ctxt, struct desc_ptr *dt)
>  static unsigned long emulator_get_cached_segment_base(
>  	struct x86_emulate_ctxt *ctxt, int seg)
>  {
> -	return get_segment_base(emul_to_vcpu(ctxt), seg);
> +	return kvm_get_segment_base(emul_to_vcpu(ctxt), seg);
>  }
>  
>  static bool emulator_get_segment(struct x86_emulate_ctxt *ctxt, u16 *selector,
> @@ -13839,7 +13834,7 @@ unsigned long kvm_get_linear_rip(struct kvm_vcpu *vcpu)
>  
>  	if (is_64_bit_mode(vcpu))
>  		return kvm_rip_read(vcpu);
> -	return (u32)(get_segment_base(vcpu, VCPU_SREG_CS) +
> +	return (u32)(kvm_get_segment_base(vcpu, VCPU_SREG_CS) +
>  		     kvm_rip_read(vcpu));
>  }
>  EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_get_linear_rip);

