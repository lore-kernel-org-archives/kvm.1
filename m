Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794960185;
	b=EnIXKuXvMpzdgWBWJSMi9rAT4sPRxSaTOYIoZCwtnHfH92YjzL4Pd7l3E/r+tOGZuUqb
	 9bqF+vMXoLXfDsF+Eejm1o7krmCDxgFICcKObGHXdAsKDkkcl/hTQ9WxSRh97IdTlroiC
	 0ozegAnhKkoG1OlxBm5i4qpRAGxRDEQvw2wO86O1dJxYpm786swbxUyfoe9RvaIwwdzhX
	 EwvLd8kZPBWrp+3u6aAjaFRMUjFgjHUbsUiaIINcgTalYgUQWPCAvx7Vc4gHFR2T+7TWH
	 yYMW7K23jptiaEhc9JVYGKmKz+4Gl+SP5+t9JtG9b1JP2psIjXI1jNHagd7dMaTiotg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794960185;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=ruetEu3w4F3uyV9meI9TwuIeqJjqrgOGrw8MVUmeCfo=;
	b=u9+/Fk/nZPPczh3GBuvXHoUBPteS7E2K09QG86EqeQMWX2xLICzRdDgnlNNEWL/E8naa
	 IjK6mxYrAPDmnsVqzyNZUmzjff8TjHiB4UHpMqu0I0GM8cwUKBy1N4ujF/d0Weni2BFdM
	 /6CNfDkBnSZM5fhlOcXvj9F3RvqVY2Pmd/+GLON8b7Oe8EMx8r1PfsF1n47naB5L1nMhu
	 0sRH7hmnMlqSbhDTjiTT3OBFVtUOY7V+VG7/sTtzg25I3K7LXMMTB6YbO+jXKlIbavWIQ
	 ENN03+5E/RZNtCoa9O+SMGt/aqnl4+CLXxebEZk4u8DoPdB0F22VjjGPmNv5NEFPzlQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HYy3Qz6I;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A8C606A31C;
	Wed, 18 Nov 2026 00:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HYy3Qz6I
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F66A1F000C4;
	Wed, 18 Nov 2026 00:03:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794960185;
	bh=ruetEu3w4F3uyV9meI9TwuIeqJjqrgOGrw8MVUmeCfo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=HYy3Qz6I7vm9bFZz1PaRbkSlcqv71FwR8/DWJu7EjBz4xenknwu1LQf34lIDpRVQq
	 8/8tSaqcGy8BfqniZREhfPi9n6mlUWJ2Ef8wxaNrJhP+jrK1soWKuCRTL37ApZq2TE
	 8q2GW5DJhHOs1pXHhu/DPw9RtEbNrzPbiQlkV5snBHiSwgTV/EOeQVETERnQ+8cU34
	 hBT3cmkr2p78CwBnkJIvy5OZrk1yWYARw59bup+gyUlPlJtgG5VOzUhK+Pc0Ufi9ak
	 q33GFXsc1uVLziv2dypy19FuL1KfUxSVInf1k6014rYDSGFbvQlFFLDJW1irJkZ9QL
	 RGdqnYeGpwi0g==
Date: Tue, 17 Nov 2026 16:03:03 -0800
From: Oliver Upton <oupton@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: sashiko-reviews@lists.linux.dev, kvm@vger.kernel.org,
	Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH] KVM: Send reschedule IPIs instead of SMP function calls
 for non-waiting requests
Message-ID: <avzrN0IZqTg3GlC1@kernel.org>
References: <20261117205428.3717-1-seanjc@google.com>
 <sashiko-outbox-219682@kernel.org>
 <avzoSx9ukQecCGq-@seanjc-mac.roam.internal>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <avzoSx9ukQecCGq-@seanjc-mac.roam.internal>

On Tue, Nov 17, 2026 at 03:50:35PM -0800, Sean Christopherson wrote:
> +Oliver and Marc,
> 
> FYI on what I think is a pre-existing TLB flush bug (that can affect other
> requests as well).

Thanks!

> > If an interrupt fires mid-loop and makes a non-waiting multi-vCPU request
> > (for example on arm64 via irqfd_wakeup() -> kvm_arch_set_irq_inatomic() ->
> > ... -> vgic_queue_irq_unlock()):
> > 
> > kvm_flush_remote_tlbs()
> >   kvm_make_all_cpus_request(kvm, KVM_REQ_TLB_FLUSH)
> >     cpumask_clear(cpus)
> >     kvm_make_vcpu_request(vcpu0, ...)
> >       kvm_vcpu_exiting_guest_mode(vcpu0)
> >         cmpxchg(&vcpu0->mode, IN_GUEST_MODE, EXITING_GUEST_MODE)
> >       __cpumask_set_cpu(vcpu0->cpu, cpus)
> >     <hardirq>
> >       irqfd_wakeup()
> >         ...
> >           kvm_make_all_cpus_request(kvm, KVM_REQ_IRQ_PENDING)
> >             cpumask_clear(cpus)  <-- wipes vcpu0->cpu from cpu_kick_mask
> >             kvm_make_vcpu_request(vcpu0, ...)
> >               kvm_request_needs_ipi(vcpu0, ...)  <-- false (EXITING_GUEST_MODE)
> >     kvm_kick_many_cpus(cpus, true)  <-- misses vcpu0->cpu
> > 
> > Because the outer request already transitioned vcpu0->mode from
> > IN_GUEST_MODE to EXITING_GUEST_MODE, the nested non-waiting request sees
> > mode != IN_GUEST_MODE and neither sends a reschedule IPI nor re-adds
> > vcpu0->cpu to cpu_kick_mask.  When the interrupt returns,
> > kvm_kick_many_cpus() skips kicking and waiting for vcpu0, so the waiting
> > request (such as a remote TLB flush) can complete while vcpu0 is still in
> > guest mode or reading shadow page tables.
> > 
> > Only touching cpu_kick_mask when KVM_REQUEST_WAIT is set (and tracking
> > whether any CPU was kicked with a local boolean for the return value)
> > would avoid this.
> 
> Unless I'm misreading this, clobbering cpu_kick_mask and dropping the kick for
> a waiting request is a pre-existing bug.  I'll address this in v2, and make sure
> the series is tagged for stable@.

Yeah, this looks like bad things could happen on arm64 when we pause the
VM for global VGIC state changes among other things. CC us on the v2 if
you don't mind.

Thanks,
Oliver
