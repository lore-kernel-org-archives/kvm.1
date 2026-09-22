Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FB0447ACF1
	for <kvm@vger.kernel.org>; Tue, 22 Sep 2026 18:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790101177; cv=none; b=mjNZEfABJk3rPweLAhZLekBqIBz53rqCCpGBQwaObbzOlrl6ThMM2TkNYECrN3Ycc4cEvO2bCRzl1mwPCtSMy1snYSFMyd3i2J2WZuDItuR6B0nPOEzqBF1lc5ynTgtks7rAmcpAX5GaulgcvSrdWObv1cjgTAGACZYvJh78ZSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790101177; c=relaxed/simple;
	bh=j0Thyp8aLj/xwxDRmUNiwzoDNeLT1f94K0xU9ghFeK0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HLtUk07was3LfXSskW1o2odmaymwUEvXJGa5jMDDa+EruvdAPTxAgiOlQAeb66zLCt6Bf/mjaR+8LfIt6juaXDb0aMhf7ICfX0pxaQH3cNdB+NQSWwpe9K14t8+UGvdBmSFezZ7qEO0Tu5XQVJoosocRRp3dysopr6KAdCocwpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aisQz6r8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aisQz6r8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 445471F000FF;
	Tue, 22 Sep 2026 18:19:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790101176;
	bh=PkQBqiVYVST5PZCzwROMlG18TizMyNbvz6nMQd094Bg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=aisQz6r8EqorFQf9pRXjEJRdeLTav80Da+7NZcTJCgJcicGHz/fnKcPQJHdKIApPU
	 6JuXo/rgbE+2xMIDaXAimNdQVjvnsh1QiPVyR4x/3UZIkLbS6KMn4rxZt7yGxBoEdj
	 V/Q6og7gH86KdBtk5+i0O9gq0X6mAHF6mowwWdKrfDRpaSFh8MD9f6nsQ/XnxVo0i+
	 IpiZJYfB8fONBV5bBWWCiONCAZlswsYv/UBsbSPE46WYrXq+pXFsBBD705CFy1ztEL
	 8BpI5z2QZ6DMcU4HIrC4nZIL0JuGiUpABqBduC4tgoBcsDch0WwkPpVYudZRxSfW0W
	 bUI72RrKJ7oYg==
Date: Tue, 22 Sep 2026 23:49:01 +0530
From: Naveen N Rao <naveen@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	Dmytro Maluka <dmaluka@chromium.org>, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: Re: [PATCH] KVM: SVM: Clear AVIC Physical ID table entry if vCPU
 creation fails
Message-ID: <arK6ygKGfbqga3ij@blrnaveerao1>
References: <20260903062856.2090499-1-naveen@kernel.org>
 <aqROi4Gp_vPvsOtp@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aqROi4Gp_vPvsOtp@google.com>

On Fri, Sep 11, 2026 at 11:55:07AM -0700, Sean Christopherson wrote:
> On Thu, Sep 03, 2026, Naveen N Rao (AMD) wrote:
> > diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
> > index 3b037e385523..bc2c699380b3 100644
> > --- a/arch/x86/kvm/svm/avic.c
> > +++ b/arch/x86/kvm/svm/avic.c
> > @@ -885,6 +885,16 @@ int avic_init_vcpu(struct vcpu_svm *svm)
> >  	return ret;
> >  }
> >  
> > +void avic_vcpu_free(struct kvm_vcpu *vcpu)
> > +{
> > +	u32 max_id = x2avic_enabled ? x2avic_max_physical_id : AVIC_MAX_PHYSICAL_ID;
> 
> I don't love the duplicate (triplicate?) code, and looking at the usage in
> avic_init_backing_page() with fresh eyes sketched me out.  It's "fine", because
> KVM will reject vCPU creation if vcpu_id >= kvm->arch.max_vcpu_ids, i.e. checking
> only the architectural max won't exceed this max:
> 
> 	return min(kvm->arch.max_vcpu_ids - 1, arch_max);
> 
> But it's hard to see that, and I can't think of any reason why being paranoid
> during vCPU creation/destruction would be a bad thing.

Agreed.

> 
> Assuming it actually works (haven't tested yet), I'll send a v2 with a prep patch
> to add:
> 
>   static bool avic_is_addressable_vcpu(struct kvm_vcpu *vcpu)
>   {
> 	return (vcpu->vcpu_id * sizeof(u64)) <
> 	       PAGE_SIZE << avic_get_physical_id_table_order(vcpu->kvm);
>   }

Unless you are planning to replace similar checks in __avic_vcpu_load() 
and __avic_vcpu_put(), I think it will be simpler to just check the id 
itself and avoid dealing with the table size:
	return vcpu->vcpu_id <= __avic_get_max_physical_id(kvm, NULL);

This helper can then also be used in avic_init_backing_page().

> 
> and then this code becomes:
> 
>   void avic_vcpu_free(struct kvm_vcpu *vcpu)
>   {
> 	struct kvm_svm *kvm_svm = to_kvm_svm(vcpu->kvm);
> 
> 	if (kvm_svm->avic_physical_id_table && avic_is_addressable_vcpu(vcpu))
> 		WRITE_ONCE(kvm_svm->avic_physical_id_table[vcpu->vcpu_id], 0);
>   }
> 

Thanks,
Naveen

