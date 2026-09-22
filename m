Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C579436BF0
	for <kvm@vger.kernel.org>; Tue, 22 Sep 2026 20:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790110003; cv=none; b=RHBJTgpBROx1u7tZVLto4qj0VX/XIiRsoKq74M3j0D3KVyv6+l79naTbnQcHoZZd9WIONo+GC3RwlR21So7/R4chPxPi+HDnfJeUQQ9b7oRwkpBfd6NJFCFMU3Yc9KFBnCxdF3TgncGJpswp0wznUqTFMTfgohtkNVYfZUqsI0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790110003; c=relaxed/simple;
	bh=11ri4Eby+rJovBEfE9OXOxiCVERszQzrASdd5mt+BZ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AB73Gdaaaif7bIWWsDbu/mcy1X9SHAdXJTTiBuoUVFttRgDe28w/wajc8fntOmfXe2KycRZSrPteerV1uxGSTgZTF9yrHRml3LabH6NPH7+XkOshR4HWHvzOwCHW0hmGCkJPOALSC8jBFSRm9ZoLkml9UQqDs+3WoKGuq6YIaI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=My0hynWm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="My0hynWm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 056CA1F0089B;
	Tue, 22 Sep 2026 20:46:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790109985;
	bh=abXomQ+78JzUBRoNKxINvpdK/3iN7F39CjELfLCPkQ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=My0hynWm/q+EjA0Ntj2dBUNBleUaRUKig3/7LCnQrqmoOmz3Cf3rkX8Pt/el+B6Ft
	 2/s4hOnXPS4im8kL2UxfVHmj1MX9o0qOpEaMKg4YQUrl/ppZl3LECl9qibdEKtWU/+
	 SXpmJu8orKx5LTYEUzYJlFlSn0EGfOLV38oZI2PD5LOt6xnjQHoqWqtVfU2RayqjUg
	 CfuPL5bfcwD4t9ClXROB2y/BJAJeoPBfCobXvfJ0S/db7ogvdVNRuFw5/XOjAtozjH
	 L3rIzFqsinnk2NavJDUldx37Sc1GjNuNp7hH6+2N+0pVz7+bU+SwdTjESIDwkkEvwM
	 BJJ8YAAdaXMpw==
Date: Wed, 23 Sep 2026 02:13:54 +0530
From: Naveen N Rao <naveen@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	Dmytro Maluka <dmaluka@chromium.org>, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: Re: [PATCH] KVM: SVM: Clear AVIC Physical ID table entry if vCPU
 creation fails
Message-ID: <arLm-7h6nllfVpdT@blrnaveerao1>
References: <20260903062856.2090499-1-naveen@kernel.org>
 <aqROi4Gp_vPvsOtp@google.com>
 <arK6ygKGfbqga3ij@blrnaveerao1>
 <arLSICws8RVdS-EA@google.com>
 <arLYrxstIphr3EvH@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <arLYrxstIphr3EvH@google.com>

On Tue, Sep 22, 2026 at 12:36:15PM -0700, Sean Christopherson wrote:
> On Tue, Sep 22, 2026, Sean Christopherson wrote:
> > On Tue, Sep 22, 2026, Naveen N Rao wrote:
> > > On Fri, Sep 11, 2026 at 11:55:07AM -0700, Sean Christopherson wrote:
> > > > On Thu, Sep 03, 2026, Naveen N Rao (AMD) wrote:
> > > > > diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
> > > > > index 3b037e385523..bc2c699380b3 100644
> > > > > --- a/arch/x86/kvm/svm/avic.c
> > > > > +++ b/arch/x86/kvm/svm/avic.c
> > > > > @@ -885,6 +885,16 @@ int avic_init_vcpu(struct vcpu_svm *svm)
> > > > >  	return ret;
> > > > >  }
> > > > >  
> > > > > +void avic_vcpu_free(struct kvm_vcpu *vcpu)
> > > > > +{
> > > > > +	u32 max_id = x2avic_enabled ? x2avic_max_physical_id : AVIC_MAX_PHYSICAL_ID;
> > > > 
> > > > I don't love the duplicate (triplicate?) code, and looking at the usage in
> > > > avic_init_backing_page() with fresh eyes sketched me out.  It's "fine", because
> > > > KVM will reject vCPU creation if vcpu_id >= kvm->arch.max_vcpu_ids, i.e. checking
> > > > only the architectural max won't exceed this max:
> > > > 
> > > > 	return min(kvm->arch.max_vcpu_ids - 1, arch_max);
> > > > 
> > > > But it's hard to see that, and I can't think of any reason why being paranoid
> > > > during vCPU creation/destruction would be a bad thing.
> > > 
> > > Agreed.
> > > 
> > > > 
> > > > Assuming it actually works (haven't tested yet), I'll send a v2 with a prep patch
> > > > to add:
> > > > 
> > > >   static bool avic_is_addressable_vcpu(struct kvm_vcpu *vcpu)
> > > >   {
> > > > 	return (vcpu->vcpu_id * sizeof(u64)) <
> > > > 	       PAGE_SIZE << avic_get_physical_id_table_order(vcpu->kvm);
> > > >   }
> > > 
> > > Unless you are planning to replace similar checks in __avic_vcpu_load() 
> > > and __avic_vcpu_put(), 
> > 
> > Heh, I had coded up exactly that (and then completely forgot that I was going to
> > send a v2, *sigh*).
> > 
> > > I think it will be simpler to just check the id 
> > > itself and avoid dealing with the table size:
> > > 	return vcpu->vcpu_id <= __avic_get_max_physical_id(kvm, NULL);
> > > 
> > > This helper can then also be used in avic_init_backing_page().
> > 
> > Eww, I missed that wrinkle.   Keying off the table order could get a false negative
> > in avic_init_backing_page(), at least in theory.
> > 
> > What if we do both, sort of?  Convert load/put, and add a sanity check in
> > avic_init_vmcb() as well?
> 
> Uh, I think I had a brain fart and forgot that load()/put() are only called if
> AVIC is or was active.   So unless I'm having a brain fart *now*...
> 
> I like your code a lot more.  I don't see any reason to keep the check on
> avic_get_physical_id_table_order() in load()/put().  If we screw up that math
> *and* don't notice immediately, then we deserve the OOB explosions.

Ha, I think we replied at the same time.

> 
> So this?  Probably over two patches to isolate the changes to load()/put() from
> the change to avic_init_backing_page().

Yes, this LGTM, with a minor fix below.

> 
> diff --git arch/x86/kvm/svm/avic.c arch/x86/kvm/svm/avic.c
> index 3b037e385523..e767e43bfb40 100644
> --- arch/x86/kvm/svm/avic.c
> +++ arch/x86/kvm/svm/avic.c
> @@ -395,6 +395,11 @@ static phys_addr_t avic_get_backing_page_address(struct vcpu_svm *svm)
>         return __sme_set(__pa(svm->vcpu.arch.apic->regs));
>  }
>  
> +static bool avic_is_addressable_vcpu(struct kvm_vcpu *vcpu)
> +{
> +       return vcpu->vcpu_id <= __avic_get_max_physical_id(vcpu->kvm, NULL);
> +}
> +
>  void avic_init_vmcb(struct vcpu_svm *svm, struct vmcb *vmcb)
>  {
>         struct kvm_svm *kvm_svm = to_kvm_svm(svm->vcpu.kvm);
> @@ -412,7 +417,6 @@ void avic_init_vmcb(struct vcpu_svm *svm, struct vmcb *vmcb)
>  
>  static int avic_init_backing_page(struct kvm_vcpu *vcpu)
>  {
> -       u32 max_id = x2avic_enabled ? x2avic_max_physical_id : AVIC_MAX_PHYSICAL_ID;
>         struct kvm_svm *kvm_svm = to_kvm_svm(vcpu->kvm);
>         struct vcpu_svm *svm = to_svm(vcpu);
>         u32 id = vcpu->vcpu_id;
> @@ -425,7 +429,7 @@ static int avic_init_backing_page(struct kvm_vcpu *vcpu)
>          * avic_vcpu_load() expects to be called if and only if the vCPU has
>          * fully initialized AVIC.
>          */
> -       if (id > max_id) {
> +       if (avic_is_addressable_vcpu(vcpu)) {

Missing a negation there:
	if (!avic_is_addressable_vcpu(vcpu))

... which also means all three places are inverting the check, so you 
could optionally flip the helper instead.


Thanks!
- Naveen

>                 kvm_set_apicv_inhibit(vcpu->kvm, APICV_INHIBIT_REASON_PHYSICAL_ID_TOO_BIG);
>                 vcpu->arch.apic->apicv_active = false;
>                 return 0;
> @@ -1045,8 +1049,7 @@ static void __avic_vcpu_load(struct kvm_vcpu *vcpu, int cpu,
>         if (WARN_ON(h_physical_id & ~AVIC_PHYSICAL_ID_ENTRY_HOST_PHYSICAL_ID_MASK))
>                 return;
>  
> -       if (WARN_ON_ONCE(vcpu->vcpu_id * sizeof(entry) >=
> -                        PAGE_SIZE << avic_get_physical_id_table_order(vcpu->kvm)))
> +       if (WARN_ON_ONCE(!avic_is_addressable_vcpu(vcpu)))
>                 return;
>  
>         /*
> @@ -1108,8 +1111,7 @@ static void __avic_vcpu_put(struct kvm_vcpu *vcpu, enum avic_vcpu_action action)
>  
>         lockdep_assert_preemption_disabled();
>  
> -       if (WARN_ON_ONCE(vcpu->vcpu_id * sizeof(entry) >=
> -                        PAGE_SIZE << avic_get_physical_id_table_order(vcpu->kvm)))
> +       if (WARN_ON_ONCE(!avic_is_addressable_vcpu(vcpu)))
>                 return;
>  
>         /*
> 
