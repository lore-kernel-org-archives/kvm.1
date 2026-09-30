Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F7C4DE70B
	for <kvm@vger.kernel.org>; Wed, 30 Sep 2026 20:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790799626; cv=none; b=pT8pkblxnvy98Lm1x4kzZe1m8iF0M2hl3UU+jffh2lz5qB/uaxSOe3HcXexky025bLxf5MjXvg6/sUr+/nzd/mm++yUPvw+9cBD9kkdEABJpN+7X+9AN2B3jyWH2KcJIJsU285wOKPYyVPT1pm1d8pJ5JceSfcmUCD542Qn5zMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790799626; c=relaxed/simple;
	bh=pROM/d8TjYItyczd0ZLvs1b3rVntUprmiozAkwXTu5g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Hruhr0B7vZlAnIFklAP13EWmRFkRU8BgfhKNjxqJyIAl8vrhpiOdWy6QprrNeAyO735DhXEDyFCzyw+I5+iB3KBFpJhTmDFNtGHs9uBPT3Kt/y5zbG/Kwi5lddWhEEdcVx9DIFQ2M+HbNRETBt4a1xyMWslxStt5BuZtT8UdtDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PpP8FCMf; arc=none smtp.client-ip=209.85.214.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PpP8FCMf"
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2df7bc60df6so44559645ad.3
        for <kvm@vger.kernel.org>; Wed, 30 Sep 2026 13:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790799624; x=1791404424; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/BSGxIvKKiTIcHT7dHMyFdt77JSPWeT71yIZ+PkBTxY=;
        b=PpP8FCMfUjQGOZJ/4LXP8ve0h4GugpWnXW/0F+NSwnFNhjpYRIWQMPMM1Ffjb9Sk07
         C5wRW9DAziZ8GEdGwCwUSEDFW3ESk/ETQB2tDFhm0JxZXW/rj9OiQueGSUw6llvFPquJ
         wnALnORrNiort5Gh9LUM8gOrauK/fpDZNk2+rFlwge7L8U9lDTTwk5IjjA8MQzGyff+B
         vH3EGaKbDVuxMoVZXp1e3aWQb7oleFwlsUe7O+yT2Na7USexPJpDibcUlQgtpyfBXng6
         60Aq8rV8d5W9dVEoGnw8idSV+ymqAAvPFVJ8NtL40mRd/EKIPpFtGvtpUjzPQ2N6vZd0
         yz6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790799624; x=1791404424;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/BSGxIvKKiTIcHT7dHMyFdt77JSPWeT71yIZ+PkBTxY=;
        b=SIwI1MvU0E/2QR7/RNUJuYWVq0yqnUOQZ79OHXRNXZty8VNtkt4qEzLFmRxG5UhTIx
         4II+I//an778T1PxScb5E7Wn3tseNJDuasWtWc8FWWUxaMYq9eqmB3tTbal+sDRyboAg
         n241tb+RNplwuxgOLr+O1ZwOYjlmm449iRyBVl1aX7AoxonTDCCHYPZmTW2vfl79jd37
         XBG6K4XlrpEaqyyBW+GxjTt8UFvnugg7pJM73MUhR1fqkmNQLwamAe+iYQ5NGQDdakFR
         GY9f59rCkjG4+erai0M14XIFUx+qoacBvanFjJkPkIatOcNbWUtz2lgrn6et+YRW7q00
         lbQw==
X-Gm-Message-State: AFq9FYIWEQDXd9L3yHfpzg9plLSCLXxwZrPbbykd3NpvWsvCtig4tto2
	0AhJk+e6jCWNpRce4/AxnQ0KIrcJc2nkJboDvxCQstlfZObfmnIcksRZnKuf/67O7GaZmEZ7SuS
	9ebUtzQ==
X-Received: from pldy20.prod.google.com ([2002:a17:902:cad4:b0:2df:a5ff:bf3])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:4587:b0:2db:63cb:1b17
 with SMTP id d9443c01a7336-2e2e4b5b242mr23140155ad.18.1790799623967; Wed, 30
 Sep 2026 13:20:23 -0700 (PDT)
Date: Wed, 30 Sep 2026 13:20:23 -0700
In-Reply-To: <20260930195407.28A811F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260930193634.3415089-1-seanjc@google.com> <20260930193634.3415089-13-seanjc@google.com>
 <20260930195407.28A811F000FF@smtp.kernel.org>
Message-ID: <ar1vB2BtBggBIxzp@google.com>
Subject: Re: [PATCH v6 12/12] KVM: SVM: Add support for virtualizating Bus
 Lock Detect
From: Sean Christopherson <seanjc@google.com>
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Wed, Sep 30, 2026, sashiko-bot@kernel.org wrote:
> > diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
> > index c3380d865b751..6d0242966dc87 100644
> > --- a/arch/x86/kvm/svm/svm.h
> > +++ b/arch/x86/kvm/svm/svm.h
> [ ... ]
> > @@ -789,7 +789,12 @@ BUILD_SVM_MSR_BITMAP_HELPERS(void, set, __set)
> >  
> >  static inline u64 svm_get_supported_debugctl(struct kvm_vcpu *vcpu)
> >  {
> > -	return DEBUGCTLMSR_LBR;
> > +	u64 debugctl = DEBUGCTLMSR_LBR;
> > +
> > +	if (guest_cpu_cap_has(vcpu, X86_FEATURE_BUS_LOCK_DETECT))
> > +		debugctl |= DEBUGCTLMSR_BUS_LOCK_DETECT;
> > +
> 
> [Severity: Medium]
> Does this restrict host-initiated MSR restoration? By making the
> DEBUGCTLMSR_BUS_LOCK_DETECT bit strictly dependent on guest_cpu_cap_has(),
> this might reject host-initiated writes to MSR_IA32_DEBUGCTLMSR if the VMM
> restores MSRs before initializing the guest CPUID.
> 
> In svm_set_msr(), the rejection happens unconditionally:
> 
> svm_set_msr()
>     if (data & ~svm_get_supported_debugctl(vcpu))
>         return 1;
> 
> Since svm_set_msr() does not appear to check msr->host_initiated before
> enforcing this capability limit, could this regression break live
> migration when userspace sends KVM_SET_MSRS before the CPUID is fully
> configured?

By design.  The msr->host_initiated exemption is "legacy" KVM behavior that we're
actively trying to remove.
