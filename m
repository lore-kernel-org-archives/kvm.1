Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 564414A4EF4
	for <kvm@vger.kernel.org>; Tue, 22 Sep 2026 19:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790105778; cv=none; b=W6eb9B0fdIGz0jOWr1TsidoA+dsKZ8LHg03Mw4ys9dh5mV4poJYqzbxuRmWlZBSGCUM4mFH90x22rtmMQgvPCms+2nqMG6HJL6VTdNJwwGgFfY47a7OBXrDuri7Fs2zjG86zctoBmmdc3qLKQcyPKWTeTtXq1HI8Vnzb5isRX8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790105778; c=relaxed/simple;
	bh=iU/Hm2nUIXt5eC5TICqGKbZ8QQc9HPgN2KxZxbl5Bkk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=M4SSn2m71L1SBi9kXaYagt74EoZ+xooRgRNbmOugq6++YDJwRPbF4Y5F1BSshTmKEP0CHvRMixZMfvaLxAT+PyJKFHR1CPiQVPb2JkBNOjzKL2Pq5FguxGAZxMYtpj26ZGYjOVYQkIjtloRyWFXVurZth7JfXFtd7OPx9BboUHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iQZKnUpq; arc=none smtp.client-ip=209.85.210.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iQZKnUpq"
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-86a2639398cso415146b3a.3
        for <kvm@vger.kernel.org>; Tue, 22 Sep 2026 12:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790105777; x=1790710577; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bIL+sMCbuRErwmOZKYZI3yloR3lh18Frxp7kLWuzaUc=;
        b=iQZKnUpqxuTs3OuYTaB+V2vOmbIf4eAA6qQzGE0V7qxQyR+jRB8MmzGeo8fMV0PKIX
         5RDeqyMy87RYdXNtxkijQCONUXk+i9glpWauLq3rshnMSkd6vqwigxU1kIEDwiYoS5Ed
         Qgz/hMR9Ojo5uVVFz08fOxdN+jROF8ZO5l+f84Cly9HSYl5/0Y0cn/cjLWaawnqZctaD
         vKAv/fci10dHdA47Mxrz/z1+04fSCx/mCgSHoe/Yvqg8nTUIyz4l7jXIStJXaxuFxtI2
         tzX3HW48Vpa3ZeQr6prEFswX1WUcMcz/yI4iRUzHPVm6up/AOXBfgrbmm/FaJOCSdGor
         X7nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790105777; x=1790710577;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bIL+sMCbuRErwmOZKYZI3yloR3lh18Frxp7kLWuzaUc=;
        b=HyNvGliprX9JMutN5ve+MV28ah5BHY1YA8p/PCcGQ65rixxndQGNdJVtw9qUkiZhYn
         M7DZVdLXlOrem9oq9FEB/MXXEbHzDNFLMQm0hh3Do1YhcUI6Jq8xzVzyOSN9ZkKsioIS
         hA/So/IyCFAv+s9m9Yw1hyqRWAhnznEWUlIBFgqZweR9+z9R9kKxL1gz7HME7UJaLvpX
         R5a6aF5i58RZDeJq9tebrKU3VFAFQn5nE5eIPkLlEX4kYEISm1+CsdxhEnCUixG2GpjZ
         DVIX+wakz/S+BgeSxkfGicNgPuXAio/jSAfqM/p4NTTRLXUwKDDU6e9gBf9ZFscWm1Fx
         D+nA==
X-Forwarded-Encrypted: i=1; AKwUvByF4FBRc1/hYinDsM2fAK427+LDh9cjvSYJb5FPiyXX7amBJr5s5rWnnfRf/aAK/AG9Gog=@vger.kernel.org
X-Gm-Message-State: AFuF++nwlNGmUlcQ90R3ayAUWEunrs1aEei9vVDY4hNHnVKmqJDYpEjn
	RYmzz4NQ6y2RxIvNkg/jE+zwag/52MhrWocF+sFjE1Kr6VeZtJ7Rmnak3Kzto2JeuaE97NYRTG+
	yMNtLTw==
X-Received: from pfbdn3.prod.google.com ([2002:a05:6a00:4983:b0:848:7bbd:284b])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2da1:b0:857:7337:5db7
 with SMTP id d2e1a72fcca58-87d1a0b617fmr572184b3a.21.1790105776263; Tue, 22
 Sep 2026 12:36:16 -0700 (PDT)
Date: Tue, 22 Sep 2026 12:36:15 -0700
In-Reply-To: <arLSICws8RVdS-EA@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260903062856.2090499-1-naveen@kernel.org> <aqROi4Gp_vPvsOtp@google.com>
 <arK6ygKGfbqga3ij@blrnaveerao1> <arLSICws8RVdS-EA@google.com>
Message-ID: <arLYrxstIphr3EvH@google.com>
Subject: Re: [PATCH] KVM: SVM: Clear AVIC Physical ID table entry if vCPU
 creation fails
From: Sean Christopherson <seanjc@google.com>
To: Naveen N Rao <naveen@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	Dmytro Maluka <dmaluka@chromium.org>, 
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset="us-ascii"

On Tue, Sep 22, 2026, Sean Christopherson wrote:
> On Tue, Sep 22, 2026, Naveen N Rao wrote:
> > On Fri, Sep 11, 2026 at 11:55:07AM -0700, Sean Christopherson wrote:
> > > On Thu, Sep 03, 2026, Naveen N Rao (AMD) wrote:
> > > > diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
> > > > index 3b037e385523..bc2c699380b3 100644
> > > > --- a/arch/x86/kvm/svm/avic.c
> > > > +++ b/arch/x86/kvm/svm/avic.c
> > > > @@ -885,6 +885,16 @@ int avic_init_vcpu(struct vcpu_svm *svm)
> > > >  	return ret;
> > > >  }
> > > >  
> > > > +void avic_vcpu_free(struct kvm_vcpu *vcpu)
> > > > +{
> > > > +	u32 max_id = x2avic_enabled ? x2avic_max_physical_id : AVIC_MAX_PHYSICAL_ID;
> > > 
> > > I don't love the duplicate (triplicate?) code, and looking at the usage in
> > > avic_init_backing_page() with fresh eyes sketched me out.  It's "fine", because
> > > KVM will reject vCPU creation if vcpu_id >= kvm->arch.max_vcpu_ids, i.e. checking
> > > only the architectural max won't exceed this max:
> > > 
> > > 	return min(kvm->arch.max_vcpu_ids - 1, arch_max);
> > > 
> > > But it's hard to see that, and I can't think of any reason why being paranoid
> > > during vCPU creation/destruction would be a bad thing.
> > 
> > Agreed.
> > 
> > > 
> > > Assuming it actually works (haven't tested yet), I'll send a v2 with a prep patch
> > > to add:
> > > 
> > >   static bool avic_is_addressable_vcpu(struct kvm_vcpu *vcpu)
> > >   {
> > > 	return (vcpu->vcpu_id * sizeof(u64)) <
> > > 	       PAGE_SIZE << avic_get_physical_id_table_order(vcpu->kvm);
> > >   }
> > 
> > Unless you are planning to replace similar checks in __avic_vcpu_load() 
> > and __avic_vcpu_put(), 
> 
> Heh, I had coded up exactly that (and then completely forgot that I was going to
> send a v2, *sigh*).
> 
> > I think it will be simpler to just check the id 
> > itself and avoid dealing with the table size:
> > 	return vcpu->vcpu_id <= __avic_get_max_physical_id(kvm, NULL);
> > 
> > This helper can then also be used in avic_init_backing_page().
> 
> Eww, I missed that wrinkle.   Keying off the table order could get a false negative
> in avic_init_backing_page(), at least in theory.
> 
> What if we do both, sort of?  Convert load/put, and add a sanity check in
> avic_init_vmcb() as well?

Uh, I think I had a brain fart and forgot that load()/put() are only called if
AVIC is or was active.   So unless I'm having a brain fart *now*...

I like your code a lot more.  I don't see any reason to keep the check on
avic_get_physical_id_table_order() in load()/put().  If we screw up that math
*and* don't notice immediately, then we deserve the OOB explosions.

So this?  Probably over two patches to isolate the changes to load()/put() from
the change to avic_init_backing_page().

diff --git arch/x86/kvm/svm/avic.c arch/x86/kvm/svm/avic.c
index 3b037e385523..e767e43bfb40 100644
--- arch/x86/kvm/svm/avic.c
+++ arch/x86/kvm/svm/avic.c
@@ -395,6 +395,11 @@ static phys_addr_t avic_get_backing_page_address(struct vcpu_svm *svm)
        return __sme_set(__pa(svm->vcpu.arch.apic->regs));
 }
 
+static bool avic_is_addressable_vcpu(struct kvm_vcpu *vcpu)
+{
+       return vcpu->vcpu_id <= __avic_get_max_physical_id(vcpu->kvm, NULL);
+}
+
 void avic_init_vmcb(struct vcpu_svm *svm, struct vmcb *vmcb)
 {
        struct kvm_svm *kvm_svm = to_kvm_svm(svm->vcpu.kvm);
@@ -412,7 +417,6 @@ void avic_init_vmcb(struct vcpu_svm *svm, struct vmcb *vmcb)
 
 static int avic_init_backing_page(struct kvm_vcpu *vcpu)
 {
-       u32 max_id = x2avic_enabled ? x2avic_max_physical_id : AVIC_MAX_PHYSICAL_ID;
        struct kvm_svm *kvm_svm = to_kvm_svm(vcpu->kvm);
        struct vcpu_svm *svm = to_svm(vcpu);
        u32 id = vcpu->vcpu_id;
@@ -425,7 +429,7 @@ static int avic_init_backing_page(struct kvm_vcpu *vcpu)
         * avic_vcpu_load() expects to be called if and only if the vCPU has
         * fully initialized AVIC.
         */
-       if (id > max_id) {
+       if (avic_is_addressable_vcpu(vcpu)) {
                kvm_set_apicv_inhibit(vcpu->kvm, APICV_INHIBIT_REASON_PHYSICAL_ID_TOO_BIG);
                vcpu->arch.apic->apicv_active = false;
                return 0;
@@ -1045,8 +1049,7 @@ static void __avic_vcpu_load(struct kvm_vcpu *vcpu, int cpu,
        if (WARN_ON(h_physical_id & ~AVIC_PHYSICAL_ID_ENTRY_HOST_PHYSICAL_ID_MASK))
                return;
 
-       if (WARN_ON_ONCE(vcpu->vcpu_id * sizeof(entry) >=
-                        PAGE_SIZE << avic_get_physical_id_table_order(vcpu->kvm)))
+       if (WARN_ON_ONCE(!avic_is_addressable_vcpu(vcpu)))
                return;
 
        /*
@@ -1108,8 +1111,7 @@ static void __avic_vcpu_put(struct kvm_vcpu *vcpu, enum avic_vcpu_action action)
 
        lockdep_assert_preemption_disabled();
 
-       if (WARN_ON_ONCE(vcpu->vcpu_id * sizeof(entry) >=
-                        PAGE_SIZE << avic_get_physical_id_table_order(vcpu->kvm)))
+       if (WARN_ON_ONCE(!avic_is_addressable_vcpu(vcpu)))
                return;
 
        /*

