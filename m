Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D32A4734D4
	for <kvm@vger.kernel.org>; Tue, 22 Sep 2026 23:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790118462; cv=none; b=qvOwNlw62utvYuAoBFhJNhyiTa14JqiniiZb2smWH9EqY40sn66+TygquUHOwEg9+DGz9BOXvH/LVt+c9V0uhyf5Ljga9dHpDJwqtSQ/rSNgITTkB5BWNyrB/kZE12Vaj42oQqNzE4LpHBL8xuLFZp4KxJivPIc46JVNBA4761c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790118462; c=relaxed/simple;
	bh=bafBXW72cgjyWru+cPAZZaD/bbft9duIUQC9not2kp8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=O40PCotE1vgNApnSPzmcBwd/Txm79K8S0exurbcrPmI+TpMl79bWnnvO9DvBwUr/EtRSmpVQyAa2Zwn/KoXRLhLtVb1sVddIkXbG21dWrJFvx2nTeAGbNlltT17dFDX4nddDQtdcA+lcgqbAheYIsxUeTxraZ26pfB1A8kVsdA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=afdPal3T; arc=none smtp.client-ip=209.85.216.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="afdPal3T"
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-38f283baf1fso362444a91.3
        for <kvm@vger.kernel.org>; Tue, 22 Sep 2026 16:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790118460; x=1790723260; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/TTDa8+5MH1bdzaEu5ZmWZePkyGRpybuiLVB+Zn8iqk=;
        b=afdPal3TVj7/HBxdqXj5J3Jiky96xK4q3lQgeRffATCbIijii/4+a0UgF5zeQloJza
         mN5BsonOPCXum96ig+GuyEfC8Snn4ExTAJImMHM9+m1vVoia5LeystNlUy7Nluf0Kjvv
         vq0jwn9Iby3xUIcm6Wzpb9DTj3YURVojUZC6O6GGoL6I7vkeFFsznfmC/G52Yb5RwY50
         Aobf/dJ/c/jz72WyOL52y+RJxUp72r2VefUUxrhXgkKOxGF9DHq6teh4GBu7XItftFVS
         JplXUiEFWbAQiBUaRxvKIM2MrLmnCgQZBZSuJLt18+c9meUglf/ggfBEn+G/N2aJvXGk
         mAsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790118460; x=1790723260;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/TTDa8+5MH1bdzaEu5ZmWZePkyGRpybuiLVB+Zn8iqk=;
        b=OEPDANWaF2F793gcP5Tw6s9/3NBGw+KIAQ0aXY6in0acVIXEeqHiDlHP4592CPUvsR
         dJh4AlD/AeQBGLBuNE0YNeNUBdiF0inMgb7a/nY+DiKKWqVDTPgOxLsWQCaPSOq+BhbU
         4Cw4+DWiAeTxQ92vOJ39Y1ZDz8N3jnKXhPKxo/d4WXvSx0BR1vv1of4Cyz6cxXsU+4nO
         /XPvGvLL8vs613JjuYWJm3D4ndbFe2hRB+wdEM6xaV7BL+xCp3+//EvXzXvGok1y5zI/
         LbHUwPWGYVlnJzb4J0eK74OOgmHuzpMkTKYwUz9AeFOsRa948Fog19TI8/rvz0QnjtE3
         FgQw==
X-Forwarded-Encrypted: i=1; AKwUvBwquuZoGwkGIdCMUSaUOuWSOMlQRkoKRLNK2uKgEZYAB6Lh6WeXNVN4NEkRlvBzmxQiSWs=@vger.kernel.org
X-Gm-Message-State: AFuF++lXwOwxW4VyJsLL07ECUjPpnFuOUsbeykXh+qwAIzJPu0hPVuro
	38s/2cTf7UeAteqicNNSUYKmV217RUiVkdoX0J2WKWAXcV6yuX3orIZqTcG4YGhzjdprc/+BYuF
	VvZx3MQ==
X-Received: from pght3.prod.google.com ([2002:a63:eb03:0:b0:cc7:535a:4a42])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3e48:b0:39e:135e:130e
 with SMTP id 98e67ed59e1d1-3a07e4e3d55mr792668a91.3.1790118460270; Tue, 22
 Sep 2026 16:07:40 -0700 (PDT)
Date: Tue, 22 Sep 2026 16:07:39 -0700
In-Reply-To: <arLm-7h6nllfVpdT@blrnaveerao1>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260903062856.2090499-1-naveen@kernel.org> <aqROi4Gp_vPvsOtp@google.com>
 <arK6ygKGfbqga3ij@blrnaveerao1> <arLSICws8RVdS-EA@google.com>
 <arLYrxstIphr3EvH@google.com> <arLm-7h6nllfVpdT@blrnaveerao1>
Message-ID: <arMKOysEYFt_t4go@google.com>
Subject: Re: [PATCH] KVM: SVM: Clear AVIC Physical ID table entry if vCPU
 creation fails
From: Sean Christopherson <seanjc@google.com>
To: Naveen N Rao <naveen@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	Dmytro Maluka <dmaluka@chromium.org>, 
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset="us-ascii"

On Wed, Sep 23, 2026, Naveen N Rao wrote:
> On Tue, Sep 22, 2026 at 12:36:15PM -0700, Sean Christopherson wrote:
> Yes, this LGTM, with a minor fix below.
> 
> > 
> > diff --git arch/x86/kvm/svm/avic.c arch/x86/kvm/svm/avic.c
> > index 3b037e385523..e767e43bfb40 100644
> > --- arch/x86/kvm/svm/avic.c
> > +++ arch/x86/kvm/svm/avic.c
> > @@ -395,6 +395,11 @@ static phys_addr_t avic_get_backing_page_address(struct vcpu_svm *svm)
> >         return __sme_set(__pa(svm->vcpu.arch.apic->regs));
> >  }
> >  
> > +static bool avic_is_addressable_vcpu(struct kvm_vcpu *vcpu)
> > +{
> > +       return vcpu->vcpu_id <= __avic_get_max_physical_id(vcpu->kvm, NULL);
> > +}
> > +
> >  void avic_init_vmcb(struct vcpu_svm *svm, struct vmcb *vmcb)
> >  {
> >         struct kvm_svm *kvm_svm = to_kvm_svm(svm->vcpu.kvm);
> > @@ -412,7 +417,6 @@ void avic_init_vmcb(struct vcpu_svm *svm, struct vmcb *vmcb)
> >  
> >  static int avic_init_backing_page(struct kvm_vcpu *vcpu)
> >  {
> > -       u32 max_id = x2avic_enabled ? x2avic_max_physical_id : AVIC_MAX_PHYSICAL_ID;
> >         struct kvm_svm *kvm_svm = to_kvm_svm(vcpu->kvm);
> >         struct vcpu_svm *svm = to_svm(vcpu);
> >         u32 id = vcpu->vcpu_id;
> > @@ -425,7 +429,7 @@ static int avic_init_backing_page(struct kvm_vcpu *vcpu)
> >          * avic_vcpu_load() expects to be called if and only if the vCPU has
> >          * fully initialized AVIC.
> >          */
> > -       if (id > max_id) {
> > +       if (avic_is_addressable_vcpu(vcpu)) {
> 
> Missing a negation there:
> 	if (!avic_is_addressable_vcpu(vcpu))

Heh, I discovered this literally ~10 seconds before reading your mail.  Hooray
for tests!

> ... which also means all three places are inverting the check, so you 
> could optionally flip the helper instead.

I'll keep it as is, Paolo generally prefers "positive" predicates, and I tend to
agree with him, e.g. it makes it the error paths more obvious (the above bug
notwithstanding).
