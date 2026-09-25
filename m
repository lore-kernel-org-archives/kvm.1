Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9318F3ADB89
	for <kvm@vger.kernel.org>; Fri, 25 Sep 2026 17:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790357206; cv=none; b=ja/N4MLzM2FZbdjIxSEX0jV3ckkOzKeK9spv4dgS4bqPk92ku1VAEVr90vOsAcW3XLwU2Nu2/04oKX0l4UNM++QyzQErUNk3x/rs0hiOYKIurJiVwArsw19zxWnenDA+ISaI6x1EZqgBGs3W4xNo6dKjTzk8XExa++wlvRAjSlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790357206; c=relaxed/simple;
	bh=Kb67YwfyWNoL2sF/ZNj2o27z2jN9tmL0em0j4RETEDk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dhOXog/ey4G6qrVezAoj+KNkGPXXZg2cZPT4EnhJSeGSXeAE1D3X9Yb2slZKtyNbD4/MRDa4+cARGSdv6IDztDQPENCVMA1F0qIlvaNF2l0LPQQapiVIiwSZWSxqoYHNYAGhTi8UvlDpgieRCoJMrM5LEnyg/S2GRV6OIP2bhQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XUmrgFcK; arc=none smtp.client-ip=209.85.216.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XUmrgFcK"
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-39de4a68f7cso964600a91.1
        for <kvm@vger.kernel.org>; Fri, 25 Sep 2026 10:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790357205; x=1790962005; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=i5iqQY2eF2987byf6Cg4qriCDFMQPLoSo76CmmN4ILw=;
        b=XUmrgFcKf29wfroprCoSFQALsL5q6rUv7Drpf1AZ/7tHauilrqlhDg4PoGaxTrqkdy
         rXFXKr2f+WrMtJuuLYKAIS17A+OOsEvSdIHWmiuVID5V0YUycha7sg3C16tINt01M6Gt
         W2liUQm57ufnmDMBWfp4ykpSk1A9VVFyJbK47YkQuI+7bDsYNabBbIir+bXqu1CwCH84
         hvDA+/rPnYwaW3Ju/+G2sopgUnf5STy/mRLsHuHIH2f1ssXdL18FCoO2Hlf4Kxw8Fb9k
         pI8wGa9nPAF0Ep1PSiGPG1iACrDUxYfB5+kFtnwVeNzwg1dwzQ5wUfiMzLFAsBCmER80
         y+xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790357205; x=1790962005;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=i5iqQY2eF2987byf6Cg4qriCDFMQPLoSo76CmmN4ILw=;
        b=MEbzKLkZRf6LWFJw0m/gQAnjSZGKpcM2UQUIiVgXQXRL1Ntvxcdn98oNRx8t4sDadz
         sLADq32J+SHgxAcHXYuRwWqHB+z8P3oVZAilyEfuSg6hQBWRp3/8XRiAqsCt9KX31W0g
         4Ci+JHg4Oh02c6pvPB5VSoBLcyAHZ5zGUTLyh8EB9R9NhWGjD//jtpWdDmoeMmpNIv0/
         ODe6a/ZXkwI67r4JtoTlF6cgaaRg9KDH7j+rfVBTW2YvW7nTRKBDCCSX7FvSkL4zogGy
         26toCp1soLkc9MLmeStSTSStwuqc3Rsqu+kZ7l/HpIMPYaVqAu+jcQOWnObGcrpHT7mX
         SZVw==
X-Forwarded-Encrypted: i=1; AKwUvByz7w/meX/jYnOnov5BPMNAZiL1of4tGFN5uXWAmZ5tn3cVKH34QDf5/L6OQn5NCskVtkU=@vger.kernel.org
X-Gm-Message-State: AFuF++nCdc2Ri8bmRkDM8rG6xMfiz7Pm/+bPrcT1aeL+bmusQuYUwH0W
	GA6VJa9nLbYECvuWp3OXh6U47N8A1nouJHsJqoEbZFjh39BTz9kDDiZQv6qx4DNeVanbnRk6Ezm
	h3J+0wA==
X-Received: from pjbmj17.prod.google.com ([2002:a17:90b:3691:b0:3a0:a5f0:a52f])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:384b:b0:3a0:c360:a562
 with SMTP id 98e67ed59e1d1-3a0c360bd58mr1579039a91.14.1790357204638; Fri, 25
 Sep 2026 10:26:44 -0700 (PDT)
Date: Fri, 25 Sep 2026 10:26:43 -0700
In-Reply-To: <20260721052113.18B251F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260721050600.87268-1-shivansh.dhiman@amd.com>
 <20260721050600.87268-4-shivansh.dhiman@amd.com> <20260721052113.18B251F000E9@smtp.kernel.org>
Message-ID: <arau02kKKLWDOFcE@google.com>
Subject: Re: [PATCH v4 3/5] KVM: nSVM: Sanitize nested DR6 using kvm_dr6_fixed()
From: Sean Christopherson <seanjc@google.com>
To: sashiko-reviews@lists.linux.dev
Cc: Shivansh Dhiman <shivansh.dhiman@amd.com>, kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Tue, Jul 21, 2026, sashiko-bot@kernel.org wrote:
> > diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
> > index 8d1967f5c099f..9b1afa47c54c9 100644
> > --- a/arch/x86/kvm/svm/nested.c
> > +++ b/arch/x86/kvm/svm/nested.c
> > @@ -810,7 +810,7 @@ static void nested_vmcb02_prepare_save(struct vcpu_svm *svm)
> >  
> >  	if (unlikely(new_vmcb12 || vmcb12_is_dirty(control, VMCB_DR))) {
> >  		vmcb02->save.dr7 = svm->nested.save.dr7 | DR7_FIXED_1;
> > -		svm->vcpu.arch.dr6  = svm->nested.save.dr6 | DR6_ACTIVE_LOW;
> > +		svm->vcpu.arch.dr6  = svm->nested.save.dr6 | kvm_dr6_fixed(vcpu);
> 
> [Severity: High]
> This isn't a bug introduced by this patch, but kvm_deliver_exception_payload()
> in arch/x86/kvm/x86.c has the exact same flaw with DR6_ACTIVE_LOW.
> 
> Could it be fixed using the newly exported kvm_dr6_fixed() helper?
> 
> Currently, kvm_deliver_exception_payload() executes:
> 
>     case DB_VECTOR:
>         ...
>         vcpu->arch.dr6 |= DR6_ACTIVE_LOW;
>         vcpu->arch.dr6 |= ex->payload;
>         vcpu->arch.dr6 ^= ex->payload & DR6_ACTIVE_LOW;
> 
> This unconditionally forces all active-low bits to 1 before applying the
> current exception payload, destroying any previously accumulated 0 bits.
> 
> If a guest OS relies on the Bus Lock Detect #DB to mitigate DoS attacks,
> and another #DB event (like a Single Step) occurs before the guest clears
> DR6, kvm_deliver_exception_payload() will force DR6 bit 11 back to 1.
> 
> Because the new #DB payload does not have the bus lock bit set, the
> subsequent XOR leaves bit 11 as 1.
> 
> Does this destroy the accumulated event and allow a malicious task to evade
> detection?
> 
> Could this be updated to use kvm_dr6_fixed(vcpu) instead of DR6_ACTIVE_LOW
> to avoid clearing previously accumulated active-low DR6 events?

No, the whole thing needs to be rewritten.  The issue isn't active-low vs. fixed-1,
it's that the semantics of each bit are feature specific, i.e. don't correlate with
active-high vs. active-low.
