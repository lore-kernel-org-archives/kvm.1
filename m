Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD4DA3E16A9
	for <kvm@vger.kernel.org>; Wed,  8 Jul 2026 21:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783546679; cv=none; b=gZP+SyEzsEi3rYqsm0VJMxlf3bxpXJ0kvt1Lh0F92Yqik3wFC+kY6sf3wm/Nz2aj7fmGUDgOMoSPITBzgMpJAZEOnh9W8tFPfsEPJtBdMD4VumNpzl7lzcAR4/MTXRYftQHoHKDixW20OX9clNLW8QJlBrz2N2ST+vph6ZY4CLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783546679; c=relaxed/simple;
	bh=oNlrIZHtI+fOCrtjA7kzhADNoKX+kegB62oKlMlJ36c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uV9jxdH1CYTHYne0m4QaoCGGmmWgybmgzBb3OrGX8mp6z4cQO6NxvIx/oFurxPMV8Oo4/kiJbFoMLqIkjEhVIozsFhuY/u6eg7fJ6nNO6NtBf2NiRH7FSJ2xS3mfSfltctrRlamZHRXxb6VNcGkpyP6L1SnNDWGfi4Dc+lilMpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XFgIqf60; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XFgIqf60"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-8484ba00601so747143b3a.1
        for <kvm@vger.kernel.org>; Wed, 08 Jul 2026 14:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783546676; x=1784151476; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=R+ih+gkmNfMBYrEi1/0uawSdekgkxwJZiIjENB0lVHA=;
        b=XFgIqf60Ubv/mtXvyvMLab3kS3KwQxzOfR/vQuL0Tv8eQ2eJJuzTsCUPP/F3EoPZt+
         VH25Vs3y5Kx17phBBl2HInC9leWi3rg8LSj8xQ+5quKK9gx6yVHBugt+eh4hHwR5+iWP
         9OSVk7eAsu4ZPyimE4wRkWC0DiYMF5EAl5LFHNBox+HUHc/5bI/J7xMZaZHHl/2Q7hzP
         siMebSXs7nOjA0KtQDnxwtyaDcDT9zlMht5AklDLOePQSL0ZS1uVhUQATtXEW8QID2L2
         Ltvu3m1jToqSnSEjntv0dQVGBXO0fmMvt3I8DdYYs873TrpcOrQGjJsyPudC7AF3K1mm
         LQKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783546676; x=1784151476;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=R+ih+gkmNfMBYrEi1/0uawSdekgkxwJZiIjENB0lVHA=;
        b=F0FTrroYn4tR3jY3FJRe5ZjVF/Ir9e1l1Xao5wniCr7eGE3qjzvPKv7huWtDKwJ55J
         YY1OvcAEj/aiZaU1sC1vVuKJhsufYC7aYrqHw8aIzH2roRISURCsa8lXFee2s9JMw/9H
         aeKgBxDTCycXheJcxwzp3yIEEwYKeWDWCGw6JY4Oqyshowb5NCFd9m+9du3a/HvmSDBK
         I789wG37f23xsk47NvUYzP3JcgSehlDfkKzv2RFYZr3mu6H7QDX7pqCs1ci8kxesPBJT
         vtNn6nE4gJDNBUSF6DEBEWSsqz2ycuI7Sn0SjTrhs6hc0h2YzWNoo2gNqfEOc9XTpgdP
         MQGw==
X-Forwarded-Encrypted: i=1; AHgh+Rr25Wk2Yx3R6IAf7FIskUoG/8swmKSTjLlI1BKgTJxDWhjLeam8N55ic8Yn32lb1hTxvFE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywzbg3UMmhv03GXOWxuvmlvyFnxRvUxWcGFx7K94rHPWDIr4nmx
	jif+Cpvtl/oBMFQAKID/qTmhu0al5AJ/kTcB2ji4MhBqrcoIhlsOzpT09vZMrYjllfzNHmDsLev
	YJqjEoQ==
X-Received: from pfcf12.prod.google.com ([2002:a05:6a00:238c:b0:845:f28c:430e])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:39a8:b0:845:d285:3b6e
 with SMTP id d2e1a72fcca58-84842fce41amr3639665b3a.58.1783546675996; Wed, 08
 Jul 2026 14:37:55 -0700 (PDT)
Date: Wed, 8 Jul 2026 14:37:55 -0700
In-Reply-To: <20260618081355.3253581-17-yilun.xu@linux.intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260618081355.3253581-1-yilun.xu@linux.intel.com> <20260618081355.3253581-17-yilun.xu@linux.intel.com>
Message-ID: <ak7DMwbF4viiVoO5@google.com>
Subject: Re: [PATCH v2 16/17] KVM: TDX: Add in-kernel Quote generation
From: Sean Christopherson <seanjc@google.com>
To: Xu Yilun <yilun.xu@linux.intel.com>
Cc: x86@kernel.org, kvm@vger.kernel.org, linux-coco@lists.linux.dev, 
	linux-kernel@vger.kernel.org, djbw@kernel.org, kas@kernel.org, 
	rick.p.edgecombe@intel.com, yilun.xu@intel.com, xiaoyao.li@intel.com, 
	sohil.mehta@intel.com, adrian.hunter@intel.com, kishen.maloor@intel.com, 
	tony.lindgren@linux.intel.com, peter.fang@intel.com, baolu.lu@linux.intel.com, 
	zhenzhong.duan@intel.com, dave.hansen@intel.com, dave.hansen@linux.intel.com
Content-Type: text/plain; charset="us-ascii"

On Thu, Jun 18, 2026, Xu Yilun wrote:
>  void __init tdx_early_init(void);
> diff --git a/arch/x86/kvm/vmx/tdx.h b/arch/x86/kvm/vmx/tdx.h
> index ac8323a68b16..5e4b3aee0577 100644
> --- a/arch/x86/kvm/vmx/tdx.h
> +++ b/arch/x86/kvm/vmx/tdx.h
> @@ -47,6 +47,12 @@ struct kvm_tdx {
>  	 * Set/unset is protected with kvm->mmu_lock.
>  	 */
>  	bool wait_for_sept_zap;
> +
> +	/*
> +	 * Whether to get the quote directly in kernel, without exiting to
> +	 * userspace.
> +	 */
> +	bool get_quote_in_kernel;

Why is this cached per-VM?  IIUC, tdx_quote_enabled() is constant after initial
TDX bringup.

And is keying off tdx_quote_enabled() and only tdx_quote_enabled() backwards
compatible?  How do we know that cutting userspace out of the loop wont' break
anything?


>  };
>  
>  /* TDX module vCPU states */
> diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
> index 9f7c39e0d4b5..20558b0185b6 100644
> --- a/arch/x86/kvm/vmx/tdx.c
> +++ b/arch/x86/kvm/vmx/tdx.c
> @@ -1538,11 +1538,133 @@ static int tdx_get_quote_user(struct kvm_vcpu *vcpu, u64 gpa, u64 size)
>  	return 0;
>  }
>  
> +static bool write_quote_status_to_guest(struct kvm_vcpu *vcpu, u64 status,
> +					gpa_t gpa)
> +{
> +	if (kvm_vcpu_write_guest(vcpu,
> +				 gpa + offsetof(struct tdx_quote_req, status),
> +				 &status, sizeof(status)))
> +		return false;
> +
> +	return true;
> +}

This is a completely useless wrapper.  Actually, it's worse than useless, as it
inverts the return value from the widely used kvm_vcpu_write_guest() API.

> +
> +static bool write_quote_to_guest(struct kvm_vcpu *vcpu, void *quote_data,
> +				 u32 quote_len, gpa_t gpa)
> +{
> +	if (kvm_vcpu_write_guest(vcpu,
> +				 gpa + TDX_QUOTE_REQ_HDR_SIZE,

This is unnecessarily confusing.  I had to look at the definition of
TDX_QUOTE_REQ_HDR_SIZE to understand that this just writing to tdx_quote_req.data.
I might not care if this was the only write, but then the very next statement
writes to a field that isn't obviously in the header.

> +				 quote_data, quote_len))
> +		return false;
> +
> +	if (kvm_vcpu_write_guest(vcpu,
> +				 gpa + offsetof(struct tdx_quote_req, out_len),
> +				 &quote_len, sizeof(quote_len)))
> +		return false;
> +
> +	return true;
> +}

So is this.  There's literally one caller.

> +
> +static u64 get_quote_kernel(struct kvm_vcpu *vcpu, struct tdx_quote_req *req,
> +			    gpa_t req_gpa, size_t total_len)
> +{
> +	struct tdx_td *td = &to_kvm_tdx(vcpu->kvm)->td;
> +
> +	/* Only support version 1 as defined in the GHCI spec */
> +	if (req->version != 1)
> +		return TDX_QUOTE_STATUS_ERROR;
> +
> +	/* Header + input data must fit in the page read from guest memory */
> +	if ((size_t)req->in_len + TDX_QUOTE_REQ_HDR_SIZE > PAGE_SIZE)
> +		return TDX_QUOTE_STATUS_ERROR;
> +
> +	/* Caller owns the requested quote */
> +	void *quote_data __free(kvfree) =
> +		tdx_quote_generate(td, req->data, req->in_len, &req->out_len);

Am I the only person that finds the __free() stuff to be difficult to follow?
I'm sure there are flows where it's a big net positive, but IMO this isn't one.
If the *unnecesary* layers of single-use helpers are stripped away, I suspect
we'll naturally end up with a goto sequence that is more obvious that using __free().

> +
> +	if (!quote_data)
> +		return TDX_QUOTE_STATUS_UNAVAILABLE;
> +
> +	if ((size_t)req->out_len + TDX_QUOTE_REQ_HDR_SIZE > total_len)

Can we really not pre-check the size?

> +		return TDX_QUOTE_STATUS_ERROR;
> +
> +	if (!write_quote_to_guest(vcpu, quote_data, req->out_len, req_gpa))
> +		return TDX_QUOTE_STATUS_ERROR;
> +
> +	return TDX_QUOTE_STATUS_SUCCESS;
> +}
> +
> +static u64 tdx_get_quote_check_args(struct kvm_vcpu *vcpu, u64 gpa, u64 size)

Adding single use helpers does not make the code easier to read.

> +{
> +	gfn_t gfn_start, gfn_end;
> +	u64 end;
> +
> +	if (!size)
> +		return TDVMCALL_STATUS_INVALID_OPERAND;
> +
> +	if (!PAGE_ALIGNED(gpa) || !PAGE_ALIGNED(size))
> +		return TDVMCALL_STATUS_ALIGN_ERROR;
> +
> +	if (check_add_overflow(gpa, size, &end))
> +		return TDVMCALL_STATUS_INVALID_OPERAND;
> +
> +	gfn_start = gpa_to_gfn(gpa);
> +	gfn_end = gpa_to_gfn(end);
> +
> +	/*
> +	 * Reject if the guest didn't explicitly convert its quote pages to
> +	 * shared.
> +	 */
> +	if (!kvm_range_has_memory_attributes(vcpu->kvm, gfn_start, gfn_end,
> +					     KVM_MEMORY_ATTRIBUTE_PRIVATE, 0))

TOCTOU?

> +		return TDVMCALL_STATUS_INVALID_OPERAND;
> +
> +	return TDVMCALL_STATUS_SUCCESS;
> +}
