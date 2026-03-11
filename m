Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 348A5330B31
	for <kvm@vger.kernel.org>; Wed, 11 Mar 2026 13:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773235638; cv=none; b=HuJrl0p8HrA/g6dFkgf45MuJlK7bo2v2YULPwfbUnATq43uFDUSAaJ0OKgOtU/9oJkLm0HPIIjGl5ceL5c9B0fecWlggEeRU8KIk7gmdTZYmbzOKFIavTXgP3aaQu25+aO9+dTu92JNvOED2IMny4ursFpZYpXp+2LIZGpfMj38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773235638; c=relaxed/simple;
	bh=/+HfC0VLOHOYiC4gOIJJuTEqnh6faMoEQFWnLKZZ05g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=g0LjkLbsHWPYKiNMA78dgo0C5HFuwmyHJ1eY8B70DAQl0MwUJE9wOK1Efj9FpSDSK7pr/ADtJrpzZEJXhHaWmwjdCtGsoOh7TC70ciyLo6By+WhOA6tBTmo4OGpCtlW2o58dnqy2Iq0f0NJ8OQ28zUCxDVLXENc39BrCb6m9G38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=C3cBT+JT; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C3cBT+JT"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2ae467f128fso104039255ad.1
        for <kvm@vger.kernel.org>; Wed, 11 Mar 2026 06:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773235636; x=1773840436; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=cN43ZNEJkhJjC9vRm/4z1rElsxe6XAfZLnQLbd78RCo=;
        b=C3cBT+JTOQ2DZmdAWtNL4AdOtuUI+6VkZYoou84LwfRbDVQwSPT37k+kz7pW+Ve9Ov
         K1y8hzRoruJ/k9TMG2ib6WAuUl7qasmfisBhoZV0g2YCnE9YX1mqFa2dH/zonvx3iWQ2
         2D70ltDL7hZXUz0pMvB60RBP3TnWhzQ3TScIuqpudokyK2X2tWVX0KxPhiE7PvEO+aLf
         fptRMlY5u89gn+MId3qJaA7gr6irx8NJQ6dda82QtRBo13eSQViQoBTKkcWtnpOWKs1D
         S9R8HUD73yrASYUt5kr1srLf6NxFX+kcAu4upLkLVZw0FKzHPiCfYpzQDoA6oVoRTCUC
         h0jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773235636; x=1773840436;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cN43ZNEJkhJjC9vRm/4z1rElsxe6XAfZLnQLbd78RCo=;
        b=r64AXZfdMs1Mw3LVCGxQK0EmrJ1GlW+0VHzEL+YeIBbZDdZoMOJ1hy9Cs0oUbP/OIv
         HD0+pPxoLUqZLIQZ/h1uOa3/Y+mrSGGwKSWE5xyBBuY9jKb929GE81tnUWBOplwurjR1
         yBLXHfdr38ZJzPoV9K7bRxkyyMrou0Ytb5Mpk51DRUss6RzABO4OiXVe0MqvVWyXVaOi
         COqZANnRofMeBBh8I+tmmNFpuC5dfoNWtZiwgh43uka9mygrZk0En0q9T7vRtLTbgArY
         29s+lXyNMQQqMEjT1HtKwV79YTGiXjVnOJuxCToKPE+ndpkl5jge+9ZGoIWN+O2eT2zv
         gBIQ==
X-Forwarded-Encrypted: i=1; AJvYcCVv10MjGc//D7JnPHjwjSU9uG0rHqldLMI0gg0n32FzfzP/auSpSvspIkY4nbsPRnayRtY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwM5rp67XWUOGCUG16pbQAMByJQkzIyt3+kZdhuVTh8YALCO20j
	NDYBOuCOyK/5M8aLFYDIk9FhmwYbpuhWRRs0xw4MXU7pflDVE8ClhAfgofyZZa6kUetii+nkdwe
	Ux9X7xQ==
X-Received: from plnu3.prod.google.com ([2002:a17:903:1a43:b0:2a9:5ed9:f590])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1249:b0:2ae:4409:5993
 with SMTP id d9443c01a7336-2aeae90f919mr25288955ad.55.1773235636399; Wed, 11
 Mar 2026 06:27:16 -0700 (PDT)
Date: Wed, 11 Mar 2026 06:27:14 -0700
In-Reply-To: <CAO9r8zMTEi++JvAfKbMd2676Z8cTPQKcWA+mydzXGYPenUrG6g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260310224546.2582118-1-seanjc@google.com> <20260310224546.2582118-3-seanjc@google.com>
 <CAO9r8zMTEi++JvAfKbMd2676Z8cTPQKcWA+mydzXGYPenUrG6g@mail.gmail.com>
Message-ID: <abFtshMZLoLLbbXO@google.com>
Subject: Re: [PATCH 2/2] KVM: x86: Suppress WARNs on nested_run_pending after
 userspace exit
From: Sean Christopherson <seanjc@google.com>
To: Yosry Ahmed <yosry@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Tue, Mar 10, 2026, Yosry Ahmed wrote:
> > diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> > index 879cdeb6adde..cad16c83dcff 100644
> > --- a/arch/x86/kvm/x86.c
> > +++ b/arch/x86/kvm/x86.c
> > @@ -12090,6 +12090,13 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
> >         if (r <= 0)
> >                 goto out;
> >
> > +       /*
> > +        * If userspace may have modified vCPU state, mark nested_run_pending
> > +        * as "untrusted" to avoid triggering false-positive WARNs.
> > +        */
> > +       if (vcpu->arch.nested_run_pending == KVM_NESTED_RUN_PENDING)
> > +               vcpu->arch.nested_run_pending = KVM_NESTED_RUN_PENDING_UNTRUSTED;
> > +
> 
> Why not inside kvm_x86_vcpu_pre_run()?

That, is a very good question.  /facepalm
