Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 454F032D0EE
	for <kvm@vger.kernel.org>; Thu, 25 Jun 2026 17:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782407054; cv=none; b=AzgVI5VqdgtWvWMOIvj7UO4Q74/cFnSzz5YBqYCzejRZiZlrxkFhXbZPD5qFVLv9TNgNTPaD0vk/CxVJzFAzDdgv45ouVaS/xO9J+L1/lWaNuuFg5Hqvt8sR7+oA1c4ZhngrrZ6/MRKmMAItgRO294S38BdVLoi18GHI3b7fpPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782407054; c=relaxed/simple;
	bh=MiqwjdM20zQIsp0EHw4LS6tSbTRdKT1E0ABs2t+aSPE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GKnDQeFQ6dpsmXRE3icvabWATPlyKRfBYC/SglbTf2tM7NVrCbHYkV763CNXuyXXiCAwNEb+wPYJ9Mhx2aDJmPHjo60XlDFH2akJXtRCkexmqLhMZf0EW71uvJYvSwmVuGzI76h3VXSYbCCxgyxMIR4xOxyvHZvqNi0tWodZk6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tEUTCG8f; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tEUTCG8f"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c8895156101so47124a12.1
        for <kvm@vger.kernel.org>; Thu, 25 Jun 2026 10:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782407052; x=1783011852; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dD6+f4NJ9jwMc5PXM39kQQy0YbW+UaJTuTkTzFc1/yc=;
        b=tEUTCG8fnyHeu7wEtJ/KOkrIlnZY2HUv9eaC4EBZqfCtfgfi4etkZnm+8MbZiCg+0t
         AU/Ki5DNGWTQuyy5pJL0SDELFBRqBMhMr4fri01tjLMTfydBiQ65TJVYnk9OsADsw+c7
         vcIx/2aM7rCDI796xlxq1bcDJgLTFk9k0WJYqTv0SsORx81W7WdYo2UxwJ0t0rBYluU8
         kl+HCAq+FiBh/ymWAaHv2bZDfXDQ8IBPVyeJpyBYKj+qaQqTDSK5FviR3ep/hhvBEksL
         mpouGV/WAEkpwdA0AoKoVa7o1CGGAmsntp4oOcIseGWu9g/hlWMUnTP2MGBEhF2o5aXL
         aBrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782407052; x=1783011852;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dD6+f4NJ9jwMc5PXM39kQQy0YbW+UaJTuTkTzFc1/yc=;
        b=Ir/Qw9EkjJ+dy7SyQv8Imm2yVRuMjIXGnAw1dhF8E3UR/RSTo1ho08VeSh4hqvnhdq
         e+A09yOqyIBIcxZdqm+UfTTrEasifFO5Fzb1ZKj3gq+8y/9Bqxux7V++ydZ9ZLuydvz4
         Lw7VAblojQxWkwIl73aovzI0c3yJctxSN5Nyvf0faMh6TMocfjFnnR0/LvjRratBnDU0
         +gWruQ+88pVa5LnRfglTVOX4ch/3EgvCQUQn0H9o3s7GmBM3zVl64A2zZqJ02idRlR0Y
         1HucgPUb8RxiMRVncUCQuu8U62TNokrQuOv7W/UV+1OvyA+VvL/ahRK+GkY7RVYT55om
         ieAg==
X-Gm-Message-State: AOJu0Yw2CC1KODMXVg1FmLhlhIcVE2AbmH6mQq+lU/1H4V5vZvIJWXxU
	AzZXWO0Ck4nYWZ/BGMPjzfWKWBKCSjAMvQYeHfZLwgS+SPo46IsFY9xw2q6UAK1r7bRKklvekXY
	8UQkQvw==
X-Received: from pgbeq18.prod.google.com ([2002:a05:6a02:2692:b0:c93:ce52:b585])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:43a2:b0:39b:ae5c:164d
 with SMTP id adf61e73a8af0-3bd4aee9bdamr4445421637.4.1782407052116; Thu, 25
 Jun 2026 10:04:12 -0700 (PDT)
Date: Thu, 25 Jun 2026 10:04:11 -0700
In-Reply-To: <20260604023314.3907511-2-binbin.wu@linux.intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260604023314.3907511-1-binbin.wu@linux.intel.com> <20260604023314.3907511-2-binbin.wu@linux.intel.com>
Message-ID: <aj1fi_0SBxMK5WOB@google.com>
Subject: Re: [RFC PATCH v2 1/4] KVM: x86: TDX: Track supported configurable
 CPUID bits
From: Sean Christopherson <seanjc@google.com>
To: Binbin Wu <binbin.wu@linux.intel.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, pbonzini@redhat.com, 
	rick.p.edgecombe@intel.com, xiaoyao.li@intel.com, chao.gao@intel.com, 
	kai.huang@intel.com
Content-Type: text/plain; charset="us-ascii"

On Thu, Jun 04, 2026, Binbin Wu wrote:
> ---
>  arch/x86/kvm/vmx/tdx.c | 174 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 174 insertions(+)
> 
> diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
> index ffe9d0db58c5..e0567088ebf5 100644
> --- a/arch/x86/kvm/vmx/tdx.c
> +++ b/arch/x86/kvm/vmx/tdx.c
> @@ -52,6 +52,178 @@
>  	__TDX_BUG_ON(__err, #__fn, __kvm, ", " #a1 " 0x%llx, " #a2 ", 0x%llx, " #a3 " 0x%llx", \
>  		     a1, a2, a3)
>  
> +#define TDX_CPUID_IGNORE_INDEX	BIT(0)
> +struct tdx_supported_cpuid_reg {
> +	u32 function;
> +	u32 index;
> +	u8 flags;
> +	u8 reg;
> +	u32 mask;
> +};
> +
> +/*
> + * Multi-bit fields are statically initialized, feature bits are initialized
> + * in tdx_initialize_cpu_cfg_caps().
> + */
> +static struct tdx_supported_cpuid_reg tdx_kvm_supported_cpuid[] __ro_after_init = {
> +	{ 0x1, 0, 0, CPUID_EAX, GENMASK_U32(27, 16) | GENMASK_U32(13, 0) },
> +	{ 0x1, 0, 0, CPUID_EBX, GENMASK_U32(23, 16) },
> +	{ 0x1, 0, 0, CPUID_ECX, 0 },
> +	{ 0x1, 0, 0, CPUID_EDX, 0 },
> +	{ 0x4, 0, TDX_CPUID_IGNORE_INDEX, CPUID_EAX, ~GENMASK_U32(13, 10) },
> +	{ 0x4, 0, TDX_CPUID_IGNORE_INDEX, CPUID_EBX, GENMASK_U32(31, 12) },
> +	{ 0x4, 0, TDX_CPUID_IGNORE_INDEX, CPUID_ECX, GENMASK_U32(31, 0) },
> +	{ 0x4, 0, TDX_CPUID_IGNORE_INDEX, CPUID_EDX, GENMASK_U32(2, 0) },
> +	{ 0x7, 0, 0, CPUID_EBX, 0 },
> +	{ 0x7, 0, 0, CPUID_ECX, 0 },
> +	{ 0x7, 0, 0, CPUID_EDX, 0 },
> +	{ 0x7, 1, 0, CPUID_EAX, 0 },
> +	{ 0x7, 1, 0, CPUID_EDX, 0 },
> +	{ 0x7, 2, 0, CPUID_EDX, 0 },
> +	{ 0x18, 0, TDX_CPUID_IGNORE_INDEX, CPUID_EDX, GENMASK_U32(25, 14) },
> +	{ 0x1E, 1, 0, CPUID_EAX, 0 },
> +	{ 0x1F, 0, TDX_CPUID_IGNORE_INDEX, CPUID_EAX, GENMASK_U32(4, 0) },
> +	{ 0x1F, 0, TDX_CPUID_IGNORE_INDEX, CPUID_EBX, GENMASK_U32(15, 0) },
> +	{ 0x1F, 0, TDX_CPUID_IGNORE_INDEX, CPUID_ECX, GENMASK_U32(15, 0) },
> +	/* See comments in td_init_cpuid_entry2() for CPUID 0x80000008 EAX[23:16]. */
> +	{ 0x80000008, 0, 0, CPUID_EAX, GENMASK_U32(23, 16) | GENMASK_U32(7, 0) },
> +	{ 0x80000008, 0, 0, CPUID_EBX, 0 },

For non-feature bits, I think I would rather handle them entirely at runtime via
switch statement(s).  Realistically, CPUID.0x1.E{A,B}X are never going to be
repurposed to hold feature bits, and so generating a mask of allowed bits adds
unnecessary cognitive load and maintenance.  Ditto for CPUID 0x4, 0x18, and 0x1F.

CPUID.0x1E is a bit different because it's kinda sorta a feature?  That one is
probably worth restricting, but again that's easy to do in a case-statement.

Then for the feature bits, there should be no need to define a separate structure,
just do "u32 kvm_tdx_cpu_caps[NR_KVM_CPU_CAPS]".  Then KVM can even further
restrict that array with kvm_cpu_caps (though it might take some creativity to
deal with things like MWAIT).  Because generally speaking, KVM shouldn't allow
features that KVM doesn't support for non-TDX VMs.
