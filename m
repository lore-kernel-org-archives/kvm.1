Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D707B3E5560
	for <kvm@vger.kernel.org>; Thu, 14 May 2026 14:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778769590; cv=none; b=eOP+gUfVGyx5X9L72jrr4HTna8oRNh4AMmqn5j+A1Lh2bfb2UebI8PW3Kg3iwcwyHxuYYUhidr44WEGUrLSMCjspBlUHzHttRLnHp5NZcSeBumrWhX4s/23/Qo35Q9yKaa+T1zr26L76Wg9w4gA85rYF16WlQUf3eIvFgLKVr1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778769590; c=relaxed/simple;
	bh=EyCexTGSOb2WgY2CCAnSkeQ1xwUfMTZ3VrNqsKkgh7o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P1XnNRoEl99rEEPVL9ovbFfq2LW373T5iLGD2BMqjwdr28MlIrcbyzBmlat8LcNExqwi6JsUCtjlgE7Jbu+T+gAeew+Kw4zfUe7fJOOPAyvyFmgdydnjBqpIi5Zq2CejpnJv+aPA8jq9PxUAhoF6eErlUDWSZ/jpa3ETCGpB7pY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B8OUZAwz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B8OUZAwz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6A4DC2BCB3;
	Thu, 14 May 2026 14:39:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778769590;
	bh=EyCexTGSOb2WgY2CCAnSkeQ1xwUfMTZ3VrNqsKkgh7o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B8OUZAwz/I/MkQ/RHL+Q6Cto8A8Iw++JCjJp+chqNJx/3ZPgdBxNEW8JCwkEDogKc
	 8TM7vzizpJrosTWAARSyREvM2dbXhlhUAXEMZJavH+SBJmfv1FJDvqIpjVz8+nEHJ7
	 lGn9JM5NrSSmdoDY22LcxK5vg44nDT6xmXWAYMc2p4K4PvdExBtF65NjDfS3OoDwG8
	 SRUgXFR6UwPXyor6Da97X8DWrkAWvCtMT49PvZck4g+qs68Fsc0KOV8O67+N0l4FFp
	 JbD0ed88a4oJaZGG0yqfpkXCDsVMVGLNZnKWwUM4p8ZmYWGzpvXePnPf08FW3rGdlZ
	 29NLeVS8ydMkA==
Date: Thu, 14 May 2026 20:06:15 +0530
From: Naveen N Rao <naveen@kernel.org>
To: Manali Shukla <manali.shukla@amd.com>
Cc: "Nikunj A. Dadhania" <nikunj@amd.com>, seanjc@google.com, 
	pbonzini@redhat.com, mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, 
	kvm@vger.kernel.org, x86@kernel.org, santosh.shukla@amd.com, nikunj.dadhania@amd.com, 
	dapeng1.mi@linux.intel.com
Subject: Re: [PATCH v1 6/9] KVM: Add KVM_GET_LAPIC2 and KVM_SET_LAPIC2 for
 extended APIC
Message-ID: <agXanDurL2EogTtC@blrnaveerao1>
References: <20260204074452.55453-1-manali.shukla@amd.com>
 <20260204074452.55453-7-manali.shukla@amd.com>
 <4f0d5601-9580-4a11-9ca8-7f242d3f0c6c@amd.com>
 <f9784824-0c12-4c85-887f-b079285d4a6a@amd.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f9784824-0c12-4c85-887f-b079285d4a6a@amd.com>

On Mon, Mar 23, 2026 at 04:45:43PM +0530, Manali Shukla wrote:
> On 3/16/2026 6:30 PM, Nikunj A. Dadhania wrote:
> > 
> > 
> > On 2/4/2026 1:14 PM, Manali Shukla wrote:

...

> >> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> >> index 669c894f1061..ccd16bdff56a 100644
> >> --- a/arch/x86/kvm/x86.c
> >> +++ b/arch/x86/kvm/x86.c
> >> @@ -5331,6 +5331,17 @@ static int kvm_vcpu_ioctl_get_lapic(struct kvm_vcpu *vcpu,
> >>  	return kvm_apic_get_state(vcpu, s->regs, sizeof(*s));
> >>  }
> >>  
> >> +static int kvm_vcpu_ioctl_get_lapic2(struct kvm_vcpu *vcpu,
> >> +				    struct kvm_lapic_state2 *s)
> >> +{
> >> +	if (vcpu->arch.apic->guest_apic_protected)
> >> +		return -EINVAL;
> >> +
> >> +	kvm_x86_call(sync_pir_to_irr)(vcpu);
> >> +
> >> +	return kvm_apic_get_state(vcpu, s->regs, sizeof(*s));
> >> +}
> > 
> > Should this function verify that KVM_CAP_LAPIC2 was enabled for the VM?
> > The KVM_CAP_LAPIC2 documentation states "This must be called before
> > creating any VCPUs" which implies userspace must explicitly enable the
> > capability. However, this ioctl doesn't check kvm->arch.nr_extlvt or any
> > flag indicating the capability was enabled.
> > 
> > Looking at how this interacts with kvm_apic_get_state() in
> > arch/x86/kvm/lapic.c:
> > 
> >     int kvm_apic_get_state(struct kvm_vcpu *vcpu, void *regs, unsigned int size)
> >     {
> >         memcpy(regs, vcpu->arch.apic->regs, size);
> >         ...
> >     }
> > 
> > The function copies 'size' bytes from vcpu->arch.apic->regs. Since
> > sizeof(struct kvm_lapic_state2) is 4096 bytes and apic->regs is allocated
> > as a single page (also 4096 bytes), this works. But if the extended APIC
> > capability wasn't enabled via KVM_ENABLE_CAP, should userspace be allowed
> > to read the extended register space?
> > 
> 
> Yeah. Correct. If the capability is not enabled, userspace should not be
> allowed to read/write the extended register space. It makes sense to put
> a check here. I will fix this in V2.

I think the base KVM_GET_LAPIC2/KVM_SET_LAPIC2 ioctls should always be 
allowed, since we will now advertise KVM_CAP_LAPIC2 always.

Even though additional capability bits (to advertise AMD EXTAPIC space, 
for instance) may need some KVM code/validation, I am not sure we need 
to enforce it here by rejecting KVM_[G|S]ET_LAPIC2. 


- Naveen

