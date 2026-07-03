Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF16C28030E;
	Fri,  3 Jul 2026 17:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783099622; cv=none; b=NuQNX5SiIZPZngHtSxWWkgAN+m1ERG57wEaFp4r41d1Xn6/rI7e+L08TkjhwxBB3Ihvjr+/mV/Tte2AzRaTIiOhzHxeDEMv7O6WQdKSm217pb7Pnlf7OkaA0RL/LWOIKkZZMrH5kOTEpnjvZRQHo80oKVyfvFmKWu/+8QWl3QKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783099622; c=relaxed/simple;
	bh=x2qvVm7S5qpOtcrg6qva6t90vPaZWYv7L/ElrE9VP00=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SPlaU73djAyDg7XKHGlmXPBBhahYdH9DR4KXE29JT702m4F33Y8ZAkHj90MZbvS7p6MXByVfWW4fJe24a3sWPSzG2Rplfh3DkRYZZnh1V2eLBPkaL0BUZMBCHTTKWDKwb0x3ea60R69dTju3GRgimHFvNM8btGkhRL1isz96A60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=awkZio4g; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="awkZio4g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB2E91F000E9;
	Fri,  3 Jul 2026 17:27:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783099621;
	bh=GghZRMfDxFxOEYG6UNYpnjw6iTpLNB9yu8ideduIdDM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=awkZio4g3HuSzUBD8Trhctv4swr3EWj1uV6z6qerJEfjMtJQ30hohqsQ8AtygkEgt
	 6dHDvNbtKB5/4f2GwjIq9RoUg6ShblTFRTSyRYkuOPV89mO7g5FzMmPJd5waycy+Mk
	 8qDKz7ch1OnaTYZsjX30cm6LaJZGta9l+YBUim08eWOU4TQDZsJsv2G4C36QI4WmJO
	 nGrZTv1Q9SBtXq97GLBYeo6yKihdzedUnJzeQ0EJvbZybaWKWSj+c+aOMVHIUsktnq
	 VQljKzGdIYZ9+PdyHo7xI4wWkNLZ2Q6f3Zzv0rDlnYQtHTUPoRjeaf0BgNinLwznz7
	 1aeImu39krgAw==
Date: Fri, 3 Jul 2026 22:51:22 +0530
From: Naveen N Rao <naveen@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Xiao Wu <xiaowu.417@qq.com>
Subject: Re: [PATCH v2 3/3] KVM: SVM: Remove VM from the GA Log notifier list
 before VM destruction
Message-ID: <akfvgO7K2-1qdznm@blrnaveerao1>
References: <20260630210156.457151-1-seanjc@google.com>
 <20260630210156.457151-4-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260630210156.457151-4-seanjc@google.com>

On Tue, Jun 30, 2026 at 02:01:56PM -0700, Sean Christopherson wrote:
> When a VM is being destroyed, delete it from the list used to process GA
> Log interrupts before vCPUs are freed, otherwise avic_ga_log_notifier()
> could theoretically hit a use-after-free if a GA Log notification arrives
> for a vCPU after the last reference to the VM has been put.
> 
> Note, in practice, it's likely all but impossible to trigger UAF, as all
> all irqfds and thus all IRTEs are cleaned up by:
> 
>   kvm_irqfd_release()
>   |
>   |-> irqfd_deactivate()
>       |
>       |-> irqfd_shutdown()
>           |
>           |-> irq_bypass_unregister_consumer()
> 
> And kvm_irqfd_release() is guaranteed to run before the last reference to
> the VM is put.  KVM also configures GA Log interrupts only when a vCPU is
> blocking (older versions of KVM configre GA Log interrupts at all times,
> but AVIC is off by default on those kernels).  Hitting UAF would require
> tearing down a VM shortly after a vCPU stopped blocking, and with a very,
> very delayed IRQ from hardware.
> 
> Opportunistically use guard() to avoid a local "flags" variable.
> 
> Fixes: 5881f73757cc ("svm: Introduce AMD IOMMU avic_ga_log_notifier")
> Cc: Naveen N Rao (AMD) <naveen@kernel.org>
> Cc: Xiao Wu <xiaowu.417@qq.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  arch/x86/kvm/svm/avic.c | 19 ++++++++++++-------
>  arch/x86/kvm/svm/svm.c  |  2 ++
>  arch/x86/kvm/svm/svm.h  |  1 +
>  3 files changed, 15 insertions(+), 7 deletions(-)

LGTM.
Reviewed-by: Naveen N Rao (AMD) <naveen@kernel.org>


- Naveen

