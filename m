Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 016744A43E8
	for <kvm@vger.kernel.org>; Tue, 22 Sep 2026 19:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790105938; cv=none; b=GWbH5qRACsxEFqklBXJLz8IkNp0AkPxURGFopNS7a+X/O4TBFizqYDuZ5AFt4A7MQeFcCAlFR+KgJs3yL3NmXMMs4XRyMYV7Yme2atCWh5WXmXhTT9GoSC0Lni2E+iBgTNi72agqCN/V7d94s4sqS6B+JO7dbVD1yqj8duom4UE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790105938; c=relaxed/simple;
	bh=+MbZwQe1/sJcG5VHtPiS2m3PT7eN/dMvUoCYA68JpOM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KmvZR9MfoFOfnc7fk+eigthaJmimP0PRUY4Z/p28NaWZzOGfHoUDoUjCcZZLSpOFUDorcLGrJndwM2RgmHjpupZjCyDH8zTwcdmApw4NQvSlHzyyOPAKfddwy2sPt57WlNzpYvIC2sFigfWAohMzfQnhGgIwHubsbv+Wy0FIYOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OmwykeyR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OmwykeyR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C509F1F000FF;
	Tue, 22 Sep 2026 19:38:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790105936;
	bh=E5OqR4pRVnU1IVH+9lozdScssF+iJlJKhEiER+PzvwM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=OmwykeyR9Mgyhp5stSMvwm9ZZk/EupaTrevKEQ2P4ub5TIg7o3R+6xYUNrB9Gjlv7
	 HfG8xhnSgoflULIfLYTpjv6wOZYShKtDbhdEPngu5puBXbTLLnN3GpYq8YNxXf62hG
	 U+dT72XWu7WkRVM+iaLjfAH1A0mQLdf4kA4zoN/pIPKzwPrgJIlF0zB4RG54/RWO9L
	 fcbVnrVbXzydbimA9I+EpMMQ2niq/5raOF3z/4v/uZYnaq0B6IByWCigBklX7fxi57
	 uMIhC+ni8INjCXmIp6WQTEW/63VHQyv7uyB9bxLFC5F7btKrZhwKuhtuJtP9r0wQxJ
	 HnneoS8Aym6Ww==
Date: Wed, 23 Sep 2026 01:07:03 +0530
From: Naveen N Rao <naveen@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	Dmytro Maluka <dmaluka@chromium.org>, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: Re: [PATCH] KVM: SVM: Clear AVIC Physical ID table entry if vCPU
 creation fails
Message-ID: <arLVitTbUru4Gro4@blrnaveerao1>
References: <20260903062856.2090499-1-naveen@kernel.org>
 <aqROi4Gp_vPvsOtp@google.com>
 <arK6ygKGfbqga3ij@blrnaveerao1>
 <arLSICws8RVdS-EA@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <arLSICws8RVdS-EA@google.com>

On Tue, Sep 22, 2026 at 12:08:16PM -0700, Sean Christopherson wrote:
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

Shouldn't hurt. Though to be entirely honest, it looks a bit redundant 
in avic_init_vmcb(). And we will still have max_id key'ed off the AVIC 
max APIC ID there, which I thought was one of your original issues.

> 
> diff --git arch/x86/kvm/svm/avic.c arch/x86/kvm/svm/avic.c
> index 3b037e385523..3725c033f8e9 100644
> --- arch/x86/kvm/svm/avic.c
> +++ arch/x86/kvm/svm/avic.c
> @@ -395,6 +395,12 @@ static phys_addr_t avic_get_backing_page_address(struct vcpu_svm *svm)
>         return __sme_set(__pa(svm->vcpu.arch.apic->regs));
>  }
>  
> +static bool avic_is_addressable_vcpu(struct kvm_vcpu *vcpu)
> +{
> +       return (vcpu->vcpu_id * sizeof(u64)) <
> +              PAGE_SIZE << avic_get_physical_id_table_order(vcpu->kvm);
> +}
> +
>  void avic_init_vmcb(struct vcpu_svm *svm, struct vmcb *vmcb)
>  {
>         struct kvm_svm *kvm_svm = to_kvm_svm(svm->vcpu.kvm);
> @@ -425,7 +431,7 @@ static int avic_init_backing_page(struct kvm_vcpu *vcpu)
>          * avic_vcpu_load() expects to be called if and only if the vCPU has
>          * fully initialized AVIC.
>          */
> -       if (id > max_id) {
> +       if (id > max_id || WARN_ON_ONCE(!avic_is_addressable_vcpu(vcpu))) {

I still think it is reasonable to use __avic_get_max_physical_id() here, 
which makes the intent clear:
	if (id > __avic_get_max_physical_id(vcpu->kvm, NULL))

If the __ name is a concern, perhaps a new wrapper can help, seeing as 
this would now be used in two places.


- Naveen

