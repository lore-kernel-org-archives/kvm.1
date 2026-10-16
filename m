Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3ED725A2A2
	for <kvm@vger.kernel.org>; Fri, 16 Oct 2026 00:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792112022; cv=none; b=HwZq/AL1fUlj5bCy7h9HORGbzCeVM6q6f4P9hYWxmB/dgVpAQNHyRuqxhNTOd9r7slwkOMmtabEfvf73qrkYwPfPFA9yii+HQTHzkQIXNH59FBhDD4MAjk7x/N3nXFBJkQJXJYhb9X1QIUhT26HyW9m3pyNnWCcbakNPIrJ5+L8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792112022; c=relaxed/simple;
	bh=c/rHAYjbF/iR0UNEq17ASuQeAKKJEqDnVLFmO41pGUY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LDu1SIL9qg/kex449G3VmdwxdC0RYsDm8DAZtaN97P37eM/mVpiPR2Sns9NAJH4biABDldA+y5tkmBUCuWICpJecVqD5xWq4H0S+UGKAMyXN4yiJhU0YXfIqMQ4/bvSeUF+hHWY6oWpB5k4kjaWAnrHDxaxnGq81ceco25lMVog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=diYTGbjk; arc=none smtp.client-ip=209.85.214.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="diYTGbjk"
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2df8484f12cso66397055ad.3
        for <kvm@vger.kernel.org>; Thu, 15 Oct 2026 17:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792112021; x=1792716821; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ajBIk136uVxpI53sUFSso4YotN3OcG6aregDR0+fYpQ=;
        b=diYTGbjkJxt0+XuDIQFfAkvvlFo9m6gA560spFvJafsVQiAgScquO1XsqcLc2Epkh0
         KY6Q/T03TERraaup+SEfse51NsapYCf2lTSvqcE1JPcFyVq+rJkXiTkZ2/2TJEIULvgi
         RTRtX1Pvon6U6ZBiXh9n8mydhvM2+O268qX7U94xZHvhY79skbEJd4wNZXjT/rF5/whW
         dEIGUGYjTqeJIS7YnocUJuO4RbNpUYSrg2AkZKdeThaJodmdQzttnJdoCJj8TtgKlQ4M
         /ZRyCK5RbzlSLWzpYVjfyIgdFV3iupL+J1VZor8W9z1sb6H72UxnD5y0POZxPFfBfYhH
         FbcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792112021; x=1792716821;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ajBIk136uVxpI53sUFSso4YotN3OcG6aregDR0+fYpQ=;
        b=dJJn5uGXEOLUeEQUbzYO6pDbDALqhwf0aegR6FwgfZs5myl2pORaN41VAc9FkKK3ri
         7visZq7Li9ADJSoX5BSZ5wBnPjGV846cQvvqPW2b2XE0Ce+CJW6CbEuC4HpccW01RkAv
         9SDU8yS7sY74FT6nEXZEr8vCK/OlKqJwyBrUflNDm/FqPYXFWs2GDc4AsvA5vUItl6o0
         mo7L7GugSh9fniLCd/+AqJKba0U/i3luWzOaZdOllmPChhDNHkbBbodR5A0JLg28c0cl
         0F0KtwVZzHvmw1ESxgMC3AZQHPdbFsQajLEFg9m0h7Ek3VRTmRGZjy+9kixILkWeP+Rv
         cUJg==
X-Forwarded-Encrypted: i=1; AKwUvBwDyMWeQW2x1ael1F1dWG8X4lnYByIOpXB9eEr/Kqxww3WMjMvTFiJjVaFAsEhaFVAtVAo=@vger.kernel.org
X-Gm-Message-State: AFq9FYIQgODFq1XIzsg++0/RUjWo+jjKdtZAPFTFvsUYjs03JNLmNV0c
	gN4Kasn8sNOHv59WWTFKbmPc7Uh0dWDcX0kxf9P+0vb8l1trB9pzRCvlxejGvbhu+MHWGrKw6Ph
	phEAp6Q==
X-Received: from pllk2.prod.google.com ([2002:a17:902:7602:b0:2e6:5c7:de7d])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e841:b0:2e9:7dda:bfc7
 with SMTP id d9443c01a7336-2e97ddac0e3mr9904065ad.66.1792112020750; Thu, 15
 Oct 2026 17:53:40 -0700 (PDT)
Date: Thu, 15 Oct 2026 17:53:40 -0700
In-Reply-To: <CAO9r8zMt5ZNwr3Y+NfFcAW5Cf4JaerCScSsLxcvsvHYR=DoYBw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261012233638.2546339-1-yosry@kernel.org> <20261012233638.2546339-25-yosry@kernel.org>
 <CALMp9eRb3ExsQ0g24YQyo85sV1fnHZadh33hBChUY=ZGUaT7jA@mail.gmail.com> <CAO9r8zMt5ZNwr3Y+NfFcAW5Cf4JaerCScSsLxcvsvHYR=DoYBw@mail.gmail.com>
Message-ID: <atF1lByf9w3Pvzyt@google.com>
Subject: Re: [PATCH v3 24/27] KVM: nSVM: Flush L2's ASID when emulating INVLPGA
From: Sean Christopherson <seanjc@google.com>
To: Yosry Ahmed <yosry@kernel.org>
Cc: Jim Mattson <jmattson@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Maxim Levitsky <mlevitsk@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 15, 2026, Yosry Ahmed wrote:
> On Thu, Oct 15, 2026 at 4:37=E2=80=AFPM Jim Mattson <jmattson@google.com>=
 wrote:
> > > diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> > > index 8f2542357e78d..436d13f106369 100644
> > > --- a/arch/x86/kvm/svm/svm.c
> > > +++ b/arch/x86/kvm/svm/svm.c
> > > @@ -2468,17 +2468,61 @@ static int clgi_interception(struct kvm_vcpu =
*vcpu)
> > >
> > >  static int invlpga_interception(struct kvm_vcpu *vcpu)
> > >  {
> > > +       struct vcpu_svm *svm =3D to_svm(vcpu);
> > >         /* FIXME: Handle an address size prefix. */
> > >         gva_t gva =3D kvm_rax_read(vcpu);
> > >         u32 asid =3D kvm_ecx_read(vcpu);
> > > +       int cpu;
> > >
> > >         if (nested_svm_check_permissions(vcpu))
> > >                 return 1;
> > >
> > >         trace_kvm_invlpga(to_svm(vcpu)->vmcb->save.rip, asid, gva);
> > >
> > > -       /* Let's treat INVLPGA the same as INVLPG (can be optimized!)=
 */
> > > -       kvm_mmu_invlpg(vcpu, gva);
> > > +       /*
> > > +        * INVLPG on a non-canonical address is a NOP according to th=
e SDM,
> > > +        * assume the same behavior from INVLPGA since the APM doesn'=
t specify.
> > > +        */
> > > +       if (is_noncanonical_invlpg_address(gva, vcpu))
> > > +               return kvm_skip_emulated_instruction(vcpu);
> >
> > If L1 is in 32-bit mode with junk in RAX[63:32] (e.g. bits left over
> > from long mode), the full 64-bit value may not be canonical. Should
> > the kvm_rax_read(vcpu) above be kvm_register_read(vcpu,
> > VCPU_REGS_RAX)?
>=20
> Doesn't kvm_rax_read() already use kvm_reg_mode_mask() as per
> __BUILD_KVM_GPR_ACCESSORS()?

Yes, Jim's probably thinking of older kernels before fc40b1254c32 ("KVM: x8=
6: Add
mode-aware versions of kvm_<reg>_{read,write}() helpers").
