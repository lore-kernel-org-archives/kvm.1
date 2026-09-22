Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 600D532D7C7
	for <kvm@vger.kernel.org>; Tue, 22 Sep 2026 19:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790104099; cv=none; b=MFQ/86bc86fmvh4bexlT5jC7+IIT015FImZOojeyX3ZthZ29xElx+r4/ijI8oJb6g78oCEf5Pilx62herVcmqLx1i4wC/o/Gsr7DP+AfVor1JfLBKJHz25ZSdstlVZDGaKk/QE6hnJMtOqL+31e4F5UxFZrFHwD9UIncBPRX7VM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790104099; c=relaxed/simple;
	bh=TfLSRc8IXru+Os1o9JEjfp9QdYf6CnoDoZoFuu1BL18=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Ob0VdeBoB2QKzIGf3+us4LfgSfmLBf+FA6VEL8JidHOt1IdHbUnMrrqrFWQIH8s7u0AJ6QLc/W3IfxcI5q8U7xWg6PdmQE+GnZrbqDVs4FkF2hNY4CoOonLkPulAhpMg42ng9xH4nTEbt+m8WrkoKR3dzonwYP7s0qB7ZTfXk0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rO+S5iTm; arc=none smtp.client-ip=209.85.214.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rO+S5iTm"
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2d6df0a1e18so1721325ad.1
        for <kvm@vger.kernel.org>; Tue, 22 Sep 2026 12:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790104098; x=1790708898; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=C75w1uHOvnYkd1qCKd9lYggpsrS2z41RfjWWa6AAiiw=;
        b=rO+S5iTmtsdgKZT+NTXJFggnRFfdlemrwfNhcHRil0fsbiMDe4FA5wiAYbY/i0uQLj
         p2E+vU+JZSG5Iy1gVR+QifizSMifpSltBQ7IT4pvnSnVBCN1K5AUMNWZtnlXwUgs4Zd0
         t6oUmr4lkWLaQSHOndpy9lOPV6rl3qAEF4JwboQ7xIxmVhpx2MYhW+v/BiTwhPEQEPGt
         F5wU0kHOgZPocp/IMoB9aNnDMyVCHCut3bnd/+jFhpPlC3nEGbmXvyveuGDl5DfBXCAm
         Nd4Lm4IVztA0raML3o58+Umf72kzR4JfEvBo1a43IoOdpzEeorfzihMUg0CVrlnWBHv9
         0RbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790104098; x=1790708898;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=C75w1uHOvnYkd1qCKd9lYggpsrS2z41RfjWWa6AAiiw=;
        b=KiWDUdz7tNTqBREgamtCVYA2LYucOJANUKkD3GSGkrncosD2u4qYWCW7SJTCremmIu
         o8IuvuTG3HfNeyUokvugyxVC8AXkO78sQKWXDqxFQ+9DMRwPrUPUSg9mStGZks4R0ppX
         2q6lQu8qto2ifHNKYkTvELz6L+uxrAcrgb/qs2o2kp8U8E8CSBvQRZVjzUlg71vL1k+E
         WOA0LqQ6BR5/n5tLvLl6okmx5/N7f4iLeQaNv1rW27P8CxyHmuRThoSOwIV8q0lsMl4s
         ThmZqnRNkWe2SEGENHJAztOv3y2Xey9B5bA0UbHRoxyOLVtMhSACG+xxMAsaKJHN9qd9
         3u4A==
X-Forwarded-Encrypted: i=1; AKwUvBzHZS0bHtg7Y9VDpS0Uq0WaDGbxO4cD9pJucWS1pMHTQ1gCfmzV+KqOQY3mceh1bVy6bSk=@vger.kernel.org
X-Gm-Message-State: AFuF++nB0vR0ZR834TZH0tX8sgtgpMtYWqhFVnrQUZvoOZEGMg6wcEqU
	bfEc4znJrqQRRTQ8XMQIAt4NBJVdN6mELvvpqvAs7B99ZQzG1d8j9UspWYe1A/C8yWU/I8L23bO
	OeJoRsQ==
X-Received: from pgbl3.prod.google.com ([2002:a63:5703:0:b0:cc7:584e:950f])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:4b03:b0:2df:5a6c:51c8
 with SMTP id d9443c01a7336-2df69dc8daamr2754505ad.39.1790104097441; Tue, 22
 Sep 2026 12:08:17 -0700 (PDT)
Date: Tue, 22 Sep 2026 12:08:16 -0700
In-Reply-To: <arK6ygKGfbqga3ij@blrnaveerao1>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260903062856.2090499-1-naveen@kernel.org> <aqROi4Gp_vPvsOtp@google.com>
 <arK6ygKGfbqga3ij@blrnaveerao1>
Message-ID: <arLSICws8RVdS-EA@google.com>
Subject: Re: [PATCH] KVM: SVM: Clear AVIC Physical ID table entry if vCPU
 creation fails
From: Sean Christopherson <seanjc@google.com>
To: Naveen N Rao <naveen@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	Dmytro Maluka <dmaluka@chromium.org>, 
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset="us-ascii"

On Tue, Sep 22, 2026, Naveen N Rao wrote:
> On Fri, Sep 11, 2026 at 11:55:07AM -0700, Sean Christopherson wrote:
> > On Thu, Sep 03, 2026, Naveen N Rao (AMD) wrote:
> > > diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
> > > index 3b037e385523..bc2c699380b3 100644
> > > --- a/arch/x86/kvm/svm/avic.c
> > > +++ b/arch/x86/kvm/svm/avic.c
> > > @@ -885,6 +885,16 @@ int avic_init_vcpu(struct vcpu_svm *svm)
> > >  	return ret;
> > >  }
> > >  
> > > +void avic_vcpu_free(struct kvm_vcpu *vcpu)
> > > +{
> > > +	u32 max_id = x2avic_enabled ? x2avic_max_physical_id : AVIC_MAX_PHYSICAL_ID;
> > 
> > I don't love the duplicate (triplicate?) code, and looking at the usage in
> > avic_init_backing_page() with fresh eyes sketched me out.  It's "fine", because
> > KVM will reject vCPU creation if vcpu_id >= kvm->arch.max_vcpu_ids, i.e. checking
> > only the architectural max won't exceed this max:
> > 
> > 	return min(kvm->arch.max_vcpu_ids - 1, arch_max);
> > 
> > But it's hard to see that, and I can't think of any reason why being paranoid
> > during vCPU creation/destruction would be a bad thing.
> 
> Agreed.
> 
> > 
> > Assuming it actually works (haven't tested yet), I'll send a v2 with a prep patch
> > to add:
> > 
> >   static bool avic_is_addressable_vcpu(struct kvm_vcpu *vcpu)
> >   {
> > 	return (vcpu->vcpu_id * sizeof(u64)) <
> > 	       PAGE_SIZE << avic_get_physical_id_table_order(vcpu->kvm);
> >   }
> 
> Unless you are planning to replace similar checks in __avic_vcpu_load() 
> and __avic_vcpu_put(), 

Heh, I had coded up exactly that (and then completely forgot that I was going to
send a v2, *sigh*).

> I think it will be simpler to just check the id 
> itself and avoid dealing with the table size:
> 	return vcpu->vcpu_id <= __avic_get_max_physical_id(kvm, NULL);
> 
> This helper can then also be used in avic_init_backing_page().

Eww, I missed that wrinkle.   Keying off the table order could get a false negative
in avic_init_backing_page(), at least in theory.

What if we do both, sort of?  Convert load/put, and add a sanity check in
avic_init_vmcb() as well?

diff --git arch/x86/kvm/svm/avic.c arch/x86/kvm/svm/avic.c
index 3b037e385523..3725c033f8e9 100644
--- arch/x86/kvm/svm/avic.c
+++ arch/x86/kvm/svm/avic.c
@@ -395,6 +395,12 @@ static phys_addr_t avic_get_backing_page_address(struct vcpu_svm *svm)
        return __sme_set(__pa(svm->vcpu.arch.apic->regs));
 }
 
+static bool avic_is_addressable_vcpu(struct kvm_vcpu *vcpu)
+{
+       return (vcpu->vcpu_id * sizeof(u64)) <
+              PAGE_SIZE << avic_get_physical_id_table_order(vcpu->kvm);
+}
+
 void avic_init_vmcb(struct vcpu_svm *svm, struct vmcb *vmcb)
 {
        struct kvm_svm *kvm_svm = to_kvm_svm(svm->vcpu.kvm);
@@ -425,7 +431,7 @@ static int avic_init_backing_page(struct kvm_vcpu *vcpu)
         * avic_vcpu_load() expects to be called if and only if the vCPU has
         * fully initialized AVIC.
         */
-       if (id > max_id) {
+       if (id > max_id || WARN_ON_ONCE(!avic_is_addressable_vcpu(vcpu))) {
                kvm_set_apicv_inhibit(vcpu->kvm, APICV_INHIBIT_REASON_PHYSICAL_ID_TOO_BIG);
                vcpu->arch.apic->apicv_active = false;
                return 0;
@@ -1045,8 +1051,7 @@ static void __avic_vcpu_load(struct kvm_vcpu *vcpu, int cpu,
        if (WARN_ON(h_physical_id & ~AVIC_PHYSICAL_ID_ENTRY_HOST_PHYSICAL_ID_MASK))
                return;
 
-       if (WARN_ON_ONCE(vcpu->vcpu_id * sizeof(entry) >=
-                        PAGE_SIZE << avic_get_physical_id_table_order(vcpu->kvm)))
+       if (WARN_ON_ONCE(!avic_is_addressable_vcpu(vcpu)))
                return;
 
        /*
@@ -1108,8 +1113,7 @@ static void __avic_vcpu_put(struct kvm_vcpu *vcpu, enum avic_vcpu_action action)
 
        lockdep_assert_preemption_disabled();
 
-       if (WARN_ON_ONCE(vcpu->vcpu_id * sizeof(entry) >=
-                        PAGE_SIZE << avic_get_physical_id_table_order(vcpu->kvm)))
+       if (WARN_ON_ONCE(!avic_is_addressable_vcpu(vcpu)))
                return;
 
        /*
