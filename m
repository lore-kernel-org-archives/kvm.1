Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8DC142900B
	for <kvm@vger.kernel.org>; Tue, 21 Jul 2026 14:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784644971; cv=none; b=mW5m+5QvlfoOjYbVPoS0jGg38FJrXpz4S+XK6qwhRkRM2veEunbjOFXA9zxbfxsIz6h7OYaBPrxMXvcThlZFetHYphqQW9VecN02Bt0CvkLb26yMSXGGHfs9ECx4vMa6S4ZQZgE8omJq94QmQ6YgLLf0hshTZeKyykC5qv+FvSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784644971; c=relaxed/simple;
	bh=6gnOLqcKaT1b14yHGtbHzIkRInXXkAxSyjq/G02Jdqs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dqqfFzFP1zCL6i8RdM5dvAdaS9os2sHajDfTcb62hzJL30OS2CIOMUU6sFk+d9OIWSyXYuIf6xpUmCgOh6PfkrBKL4l5sQuLCKXO68DYsshraBKrWa1YL3jBCADcOL42YbGZZ9kcBv8l+KurmwPze+vCudam0PWomemwOSbOxU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=k0Owua73; arc=none smtp.client-ip=209.85.210.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k0Owua73"
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-8482b95574dso14739865b3a.1
        for <kvm@vger.kernel.org>; Tue, 21 Jul 2026 07:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784644966; x=1785249766; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LNFqq4/9miHE+hyKXsNlebDayPW56SZCH4SA/Bf1Nq4=;
        b=k0Owua73HvKxNhBrLl4dXEEJre/gw3rqjbQ4rMPvncBAZQft4LMu55K0qGvI9KYSAx
         QX44Ayb1d6cEwUy18+77kR2iddcH5jrf4GQL3vQppEywBz6gPqYYxtmlTfwSAoYzbXbv
         m24eYKY9J773nwidRV6/huQBA1C18mJJ22aUTqSRjfLOrvn2Ui3SiaZqfn1x/sfQ20nW
         KvPn0XKVVr7+xkIHGUSVLf7HQge9dLg6NFZvIVZFa4LkA6xuzb2UoMlqV03yNH0BjFbT
         Y1tmgskDZvpTzou67Lf6mC5pI1d2U5Voe/fDXkR1DMmcOAQBmY5wIBn7ZgDzKZEH//Fs
         28EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784644966; x=1785249766;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LNFqq4/9miHE+hyKXsNlebDayPW56SZCH4SA/Bf1Nq4=;
        b=b/XwRFtKkaNJkaflFD1h6TPfuO1SXnfle7NGYub+wz47PbCxMED/ZPQ1jD50P3Oqb2
         5h2EJzcyENRMF7ewgjiICuVe1aZUgiWba/5Ikc/HtwPtJt6zkDjMWvqq/BDCxryB/Mzh
         LhZNgqHnaYQucLBXPfdjtNbKbAfiM2t2U5TvJUfZ+SoV6i5q/7AfHCS/gI6skiPDRY0p
         O8zxaKy/RvKCARSBCZ5xsYdYa7DwTLPv31Msu/CTJUNBuA/MenvJmhoHu3d5q0bY6qjA
         q+6AYJiiFd/RAzhSwCEgmkiLVLP6EsgQbGpEjtb1rXfvbkc6LHqBfxmF/IeeWAuMkTzV
         +6tw==
X-Forwarded-Encrypted: i=1; AHgh+Roo61FWqRDFB+JmL4WEcVasTSn50sczUbGxKD39zQffBHy+3TbTNyzYxax11M7reASmeqY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxq32AqJEJzOkldXlEiMnFH0SMbIlG+M7m1ovjHUJt4k0AaySM6
	to0g9IfzrR8Cm7f6erHqjPQDhFx67puvJ+HBPIclBVSsbmP3ABN3CTturhr/vWOlHxCJHAGFtIJ
	iZxlWhA==
X-Received: from pfwp3.prod.google.com ([2002:a05:6a00:26c3:b0:848:478d:6efb])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:aa7:8490:0:b0:84e:23a:14ba
 with SMTP id d2e1a72fcca58-84e023a1807mr3186376b3a.55.1784644965816; Tue, 21
 Jul 2026 07:42:45 -0700 (PDT)
Date: Tue, 21 Jul 2026 07:42:45 -0700
In-Reply-To: <20260721062426.C4EB81F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <al8M4gCwsWXS_jMs@192.168.1.215> <20260721062426.C4EB81F000E9@smtp.kernel.org>
Message-ID: <al-E7uwCqS6na41W@google.com>
Subject: Re: [PATCH v2] KVM: x86: Mark nested RSM-created VM-Enter as untrusted
From: Sean Christopherson <seanjc@google.com>
To: sashiko-reviews@lists.linux.dev
Cc: Hao Zhang <hao_zhang_kdev@163.com>, kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Tue, Jul 21, 2026, sashiko-bot@kernel.org wrote:
> > diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> > index 4d2bacd00ec4f..f54757bd83821 100644
> > --- a/arch/x86/kvm/svm/svm.c
> > +++ b/arch/x86/kvm/svm/svm.c
> 
> [ ... ]
> 
> > diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> > index cc75feec05daa..333072cc9bce4 100644
> > --- a/arch/x86/kvm/vmx/vmx.c
> > +++ b/arch/x86/kvm/vmx/vmx.c
> > @@ -6720,7 +6720,8 @@ static int __vmx_handle_exit(struct kvm_vcpu *vcpu, fastpath_t exit_fastpath)
> >  	 * invalid guest state should never happen as that means KVM knowingly
> >  	 * allowed a nested VM-Enter with an invalid vmcs12.  More below.
> >  	 */
> > -	if (KVM_BUG_ON(vcpu->arch.nested_run_pending, vcpu->kvm))
> > +	if (KVM_BUG_ON(vcpu->arch.nested_run_pending == KVM_NESTED_RUN_PENDING,
> > +		       vcpu->kvm))
> >  		return -EIO;
> 
> [Severity: High]
> Does this allow the KVM_NESTED_RUN_PENDING_UNTRUSTED flag to leak and lock up
> the vCPU?
> 
> If a malicious L2 guest modifies SMRAM to create an invalid nested state, then
> executes RSM, vmx_leave_smm() restores this state and sets nested_run_pending
> to KVM_NESTED_RUN_PENDING_UNTRUSTED.

LOL, that is an impressively convoluted hallucination from Sashiko.  SMI is an
unconditional VM-Exit on Intel, and KVM doesn't support emulating parallel SMM,
i.e. it's impossible for L2 to have access to "live" SMRAM.

That said, leaving nested_run_pending set isn't good, and I missed that my
suggested "fix" would require tweaking the above KVM_BUG_ON().  I'll respond to
v3 with an alternative solution.
