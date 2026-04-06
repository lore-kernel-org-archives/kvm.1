Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E205A38AC8A
	for <kvm@vger.kernel.org>; Mon,  6 Apr 2026 16:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775492331; cv=none; b=MBP6VVY+eoJnDPeInfpoFG0C2O5Rpcda2KohPtY0smI9a/FrM5q0ZmjczYE/4iXIBj4lVas8KNxgcd/Oi69y5AIOdkSsqGsXV4rcpGQqa4Qcxha6iE1DpBnFKzfs9V6N/N0/WjsTpvKiiMF8Z7ez7JNUY0kjss9xSe+pL8B/IqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775492331; c=relaxed/simple;
	bh=QvaCK626nlesWizOQhwqUdAERLWQAz4wh63qrmM2GCg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dBi0MjDyTwrLF+7y14qpvJPaBxwlSydj6esqf3OZdgFPnM0i/l2otaEKSvf+TQ0APFdVg2FnAKlbgHl4YpMqiGD2YEhrU14I9vTrYPqYJq+Yv6UTSEuSzSz4lWjdYUkry+4EP4srNr7QEQLojELmyWfRzNIdwZY1xGfFpxGGlpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tjItRr07; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tjItRr07"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2b24305cb3cso50960275ad.2
        for <kvm@vger.kernel.org>; Mon, 06 Apr 2026 09:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775492329; x=1776097129; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=T2QSLazbAa8uq7gDHUm4wAyBHiBwOk/6UT3o64YvzzI=;
        b=tjItRr07tK4aldalViJn+olydwi/VjF3DtdIIVUcLgYqETFtahDTLabDiodwNnp+O/
         x+lNXjeSwi284QB6DGMeCuOVbH/eUibjahDl/T+PMS087Zb+F9FlZ0KhO4FiALR5JPVH
         uLnx2Wrp3ANmwDzfdqJ9AHFj///4eJjNtZ8sg0/obbDDoIw3QbOOhaxZWKwUcPU4pqfM
         PFMpU2qgMxrtdlucNA4il8KUIDLAA01jYdTVQ164Gv6dV+njdROqZy7kaQKOhZEjPX78
         4ruj6CqUMHAwWa6v2lgt0frzLt2j6xPicSPBPh6hh38DcopLJT9RmhxX033d+Ds1bASh
         vvXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775492329; x=1776097129;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T2QSLazbAa8uq7gDHUm4wAyBHiBwOk/6UT3o64YvzzI=;
        b=BMg1voCNaqc2vzFP2JhROm5+HHNYhJQVdYOPxP7c9pt4c9SXgziE0Uga+f9omGHQij
         np01Wiy/I2wvAueSbe4mkrphsL1AAumo46+bLkuh+kILnIFslpypcjo1VEMlGvB0H8wY
         6sEATI58fpXPVy3iycPE9mdoqCPxX5+zifAcGFlKEAJMgPrIuaY13p9+37bH3XVWAuGE
         BLwRxCvb88xuxzLRqVJtCtUufiBYxzKpLHI3N9jXZUBfRgyVKOo+om+bEUhARMdsHdFw
         IrFcSNyEFgwOBMViM3aYY7QVtIK432yadFAch/EzO3R5MnsQJDBvSYRpuo+AlNo88iI2
         aDQA==
X-Gm-Message-State: AOJu0YyyzxKRkj4eULE1ZIdcrMGfKpCNLGZ47zQMtQMeM8r1ZW4sBTT+
	LwkylUmyQ7azHaEKOClbY/hizU8SQPVBndTsJPPMKa1s9j7/I8yzOveG+6gXOAuW+B6Wcfp2DFc
	Vf9NuAg==
X-Received: from pgbo7.prod.google.com ([2002:a63:5a07:0:b0:c76:651e:6d52])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:6a26:b0:39c:5624:ee53
 with SMTP id adf61e73a8af0-39f2ee45330mr14232816637.24.1775492329078; Mon, 06
 Apr 2026 09:18:49 -0700 (PDT)
Date: Mon, 6 Apr 2026 09:18:47 -0700
In-Reply-To: <20260403100119.3311-1-ethan.yang.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260403031111.3171-1-ethan.yang.kernel@gmail.com> <20260403100119.3311-1-ethan.yang.kernel@gmail.com>
Message-ID: <adPc51OyKMdkU4pc@google.com>
Subject: Re: [PATCH v2] KVM: x86: Don't leave APF half-enabled on bad APF data GPA
From: Sean Christopherson <seanjc@google.com>
To: Ethan Yang <ethan.yang.kernel@gmail.com>
Cc: kvm@vger.kernel.org, xiaoyao.li@intel.com, pbonzini@redhat.com, 
	syzbot+bc0e18379a290e5edfe4@syzkaller.appspotmail.com, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, x86@kernel.org, 
	tglx@kernel.org, mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, 
	hpa@zytor.com, glider@google.com
Content-Type: text/plain; charset="us-ascii"

Thanks for posting this!  My "week" estimate was wee bit off...

On Fri, Apr 03, 2026, Ethan Yang wrote:
>  static inline u64 pdptr_rsvd_bits(struct kvm_vcpu *vcpu)
> @@ -3616,6 +3621,7 @@ static int set_msr_mce(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>  static int kvm_pv_enable_async_pf(struct kvm_vcpu *vcpu, u64 data)
>  {
>  	gpa_t gpa = data & ~0x3f;
> +	bool enable;
>  
>  	/* Bits 4:5 are reserved, Should be zero */
>  	if (data & 0x30)
> @@ -3632,18 +3638,20 @@ static int kvm_pv_enable_async_pf(struct kvm_vcpu *vcpu, u64 data)
>  	if (!lapic_in_kernel(vcpu))
>  		return data ? 1 : 0;
>  
> +	enable = __kvm_pv_async_pf_enabled(data);
> +
> +	if (enable &&
> +	    kvm_gfn_to_hva_cache_init(vcpu->kvm, &vcpu->arch.apf.data, gpa,
> +				      sizeof(u64)))

I would rather forgo a local variable and either hhave the below check stay as
kvm_pv_async_pf_enabled() or just redo the call to __kvm_pv_async_pf_enabled().

> +		return 1;

Newline please.

>  	vcpu->arch.apf.msr_en_val = data;
>  
> -	if (!kvm_pv_async_pf_enabled(vcpu)) {
> +	if (!enable) {
>  		kvm_clear_async_pf_completion_queue(vcpu);
>  		kvm_async_pf_hash_reset(vcpu);
>  		return 0;
>  	}
>  
> -	if (kvm_gfn_to_hva_cache_init(vcpu->kvm, &vcpu->arch.apf.data, gpa,
> -					sizeof(u64)))
> -		return 1;
> -
>  	vcpu->arch.apf.send_always = (data & KVM_ASYNC_PF_SEND_ALWAYS);
>  	vcpu->arch.apf.delivery_as_pf_vmexit = data & KVM_ASYNC_PF_DELIVERY_AS_PF_VMEXIT;

As I sketched out, in a follow-up patch, I would like to to update these fields
as well.  I don't like tracking stale information, even if it _should_ be unused.

Actually, even better, just drop the fields.  That way zeroing msr_en_val via
INIT won't lead to stale data either.

I'll post a v3, should be easier overall than posting diffs for the suggestions
and then making you write changelogs :-)

