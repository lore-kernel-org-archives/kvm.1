Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB5B9407564
	for <kvm@vger.kernel.org>; Thu, 14 May 2026 14:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778768939; cv=none; b=XFnUd/yK2R6cNC6DmfxHPElv3kh+jEBPytof7QYwBAy45vrl3xrxs3knR+ItGq64IOGAZH5LmQi/l5VGfHYyIfMt613CoGLHn4UvDU+A/MpgNF8SpcRJC3s9Y/x1D1i/VBYeQvrmAusgAkcy0tNsvividhu4rwY4orn0ONIK1os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778768939; c=relaxed/simple;
	bh=cE2lkLmKq0IcZdV/Mrh7n/fH686ncFoZwuoKXAn37F0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bLd1NrkrgOz3fLqw174n5Y8l3Y6yyO9Pwvf89Ckskvz0JfodgFiX5Zm4VKbmWd6JWZ7nT8Fylucbk/5raGJMjCuEZMEl6rvQR/tYiaNAS/j9rQVYla2Q9t3HfTJTsk31w7aUYo6drESH0DOsO2Y66p5novNyNVbxg5OW9g8Cbyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IPURNUCu; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IPURNUCu"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-83544d05c5aso4365856b3a.2
        for <kvm@vger.kernel.org>; Thu, 14 May 2026 07:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778768937; x=1779373737; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7LCeT1NsI569FTnrt0qFrtZYhyjYrpE+ZVg188rcut0=;
        b=IPURNUCua3A3uJ1fpwifjzs9ly9D0GCgd5TAPMU69Il4r56cRDMF9WhsAa39yqnxLH
         nH00yYo74tHC5mpyBWKbgQcjCP5RHbN3rJ5uW7mgq2K6jnHMdwKPV+8FXnBa06K/utnG
         qIuKb6AZi56YLZQ0ACxgGQspfUCQonUmYJJdHBhRwbZ2RgLRgxi8dDxGO1qGJ+yij+VK
         Q1PS5YxCYyzVQH3iz4Mot1AlubmAddEwkLgDqPsKd8dynRRHDbd9ePlj+YdA7iE383DE
         XgQXRCXYJotrl1k5Dmc7Y6Wfjmvz6OtXbso/zgHTnUCE5EN3qxl7OFJHcRaCwjgXVbJM
         zEjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778768937; x=1779373737;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7LCeT1NsI569FTnrt0qFrtZYhyjYrpE+ZVg188rcut0=;
        b=XKgR4g0A8uZU6q7IAYGoZYSU0NNS4e0TiCqFiiI0yFEYTW6q0Ffq0gu0CSYBinG51Y
         LPre64oirI9SMfrwME2MoiViIVj3NqvjPxJwY0xxZ11Vs/jML+MnM7tQkqpAD6yNalMf
         3bMA7gD2zNjUtUtleFoRPJRYN+8aUlhlDJf6jadCVDxImgtsbnko/mbzP4F7nU/pgmxR
         a7fMg1STtRD9FQNVWnUbiQrAJ1gcGjinqB2U1+43T/Y54hDl7y2o7E8OGZbMiGOW6yZu
         l2qwFpx3EFXXn9HtVFnpT8QRQD8LQnF8zmsjrceULDsNMWXy7Q5TRxSnx+3PSBogocAI
         4Kaw==
X-Forwarded-Encrypted: i=1; AFNElJ+v6GEpaO84VPJQeZ4muUu3vAfZiHf4D6N++ZjUhng0b1MTmV9y7OcY4nxzYohfHygLDpM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLDUhHKvjJnxJCgnJ4DvFXALuFPITaPEVp6BffzMwptE4Kdjz1
	mdRn/Ae/+jdh4XkSxwank5sxr+x/rplaY1h1MCxXJlxBLkNcYYzNF3asQx1/QhNOFVF0V38SRU2
	DZ9Fp4A==
X-Received: from pfbmd16.prod.google.com ([2002:a05:6a00:7710:b0:82f:c134:e67c])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:ad8f:b0:839:dd77:34fb
 with SMTP id d2e1a72fcca58-83f041eff94mr10426507b3a.22.1778768936700; Thu, 14
 May 2026 07:28:56 -0700 (PDT)
Date: Thu, 14 May 2026 07:28:56 -0700
In-Reply-To: <CALMp9eS4s9tsOmvDUDeqS7oph0mSHyhxBiULQdwHVaG+7gXLSQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260513224608.1859737-1-jmattson@google.com> <20260513224608.1859737-4-jmattson@google.com>
 <CALMp9eS4s9tsOmvDUDeqS7oph0mSHyhxBiULQdwHVaG+7gXLSQ@mail.gmail.com>
Message-ID: <agXcKDjnJc9DPcyr@google.com>
Subject: Re: [PATCH v3 3/4] KVM: x86: Virtualize AMD CPUID faulting
From: Sean Christopherson <seanjc@google.com>
To: Jim Mattson <jmattson@google.com>
Cc: pbonzini@redhat.com, tglx@kernel.org, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, shuah@kernel.org, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, ctpence@google.com
Content-Type: text/plain; charset="us-ascii"

On Thu, May 14, 2026, Jim Mattson wrote:
> > diff --git a/arch/x86/kvm/cpuid.h b/arch/x86/kvm/cpuid.h
> > index 95d09ccbf951..fc96ba86c644 100644
> > --- a/arch/x86/kvm/cpuid.h
> > +++ b/arch/x86/kvm/cpuid.h
> > @@ -185,8 +185,9 @@ static inline int guest_cpuid_stepping(struct kvm_vcpu *vcpu)
> >
> >  static inline bool cpuid_fault_enabled(struct kvm_vcpu *vcpu)
> >  {
> > -       return vcpu->arch.msr_misc_features_enables &
> > -                 MSR_MISC_FEATURES_ENABLES_CPUID_FAULT;
> > +       return (vcpu->arch.msr_misc_features_enables &
> > +               MSR_MISC_FEATURES_ENABLES_CPUID_FAULT) ||
> > +               (vcpu->arch.msr_hwcr & MSR_K7_HWCR_CPUID_USER_DIS);
> >  }
> 
> Sashiko raises a good point here about a pre-existing issue that

Calling this pre-existing is a bit of a stretch.  I'm guessing VMX doesn't check
the #GP before the VM-Exit (checking #GP before a VM-Exit is so stupid).

Yes, KVM technically emulates MSR_MISC_FEATURES_ENABLES_CPUID_FAULT for AMD, but
we're firmly in "making shit up" territory when reasoning about the interactions
between SVM and a feature that doesn't exist on real AMD CPUs.

> probably warrants a fix before propagating it further:
> 
> > Does this emulation of CPUID faulting respect architectural fault
> > priorities in a nested virtualization scenario?
> >
> > According to the AMD APM, if CPUID faulting is enabled, a #GP fault takes
> > precedence over a CPUID VM-exit intercept.

Where in the APM?  I can't find anything in the description of CPUID or CpuidUserDis
that specifies the priority, and "Table 15-7. Instruction Intercepts" is flat out
wrong because it just says:

   CPUID  CPUID  No exceptions to check.

> > Because KVM emulates CPUID faulting in kvm_emulate_cpuid(), the fault check
> > happens after nested VM-exit intercept checks. If an L1 hypervisor enables
> > both CPUID faulting and a CPUID VM-exit intercept, L0's nested exit
> > handlers will observe L1's intercept request and immediately reflect the
> > VM-exit to L1.
> >
> > Since this reflection happens before evaluating kvm_emulate_cpuid(), does
> > this allow L2 guests to completely bypass the CPUID faulting restrictions
> > imposed by L1?
