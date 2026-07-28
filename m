Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8C15306754
	for <kvm@vger.kernel.org>; Tue, 28 Jul 2026 15:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785252218; cv=none; b=cKG1lMH2KQAI1dS69fuArqbwom02fwLNO4y+bVXZ/k4HhupSwsWW1nrQRAcqLYNvlVBXHgafZjWxqF7qMdSAbU3HQX5z19kJIXOuMh+8Y2mmvf7b9ZpH+kegQUKHrAKxjP2Px8qMzIJX6iNS29ZUx0qkky325cDE+aNqoaS/144=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785252218; c=relaxed/simple;
	bh=BD24merAGOOQFZUl/j3itxwHEqQl0iXVh6oiFcEd7Uc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=givRzQXWKtkNZs8bRc7kJJR2kK3iRbojKLs3YFt7BIUivqm4IfLXmLDA1waCLrPGde01k8a6ZHkgcx1xSAkYGhRDGvEPITKQnp3844XZpQIDUBpbFG5uluhbKd+HhU8sSaGaLQx56eO78/+jO/SbNOmq2EUfhLa2W7fXkTAScOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DYMLBa3Y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DYMLBa3Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC28F1F000E9;
	Tue, 28 Jul 2026 15:23:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785252216;
	bh=COHXcrHqaHqid1Amko5iSSqC6V28GNfBn/ThKyQcASo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DYMLBa3Yg0/vmnDgWKO1+0SDmvmDXqYNyPbLfG0tz8G4+RDXruJiOIRkrl4WLGmMl
	 O/2wQJyysXyBsq5z98i95LwNgdGRhEv99xkMmw8txbLUxw+MQ48BOs4+RQ1l6eemUY
	 SvZjxENkaa64mBSF/5EQw/H2kYiKajny3vm5pUSYyog1TyMNxR6ACf7b531UdR8MIm
	 fOWbLeZ5btdkxSQQrrzsh9x7bffffehDxiCyMgQy7iV/nmjI7y7WD4ohnzbFzj6mdi
	 mgzc30dyudvD0Ycf+Aqzf+HbZCC+9Lgiw+B3Nb68OWtiVzskeukcenoFcD2gnpuF1y
	 opLzPR4Awa6rw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 21/36] KVM: x86: Avoid redundant masterclock updates
 from multiple vCPUs
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Woodhouse" <dwmw2@infradead.org>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260728144954.355376-22-dwmw2@infradead.org>
References: <20260728144954.355376-1-dwmw2@infradead.org>
 <20260728144954.355376-22-dwmw2@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 15:23:35 +0000
Message-Id: <20260728152335.DC28F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Moving O(N) VM-wide vCPU iterations inside a raw spinlock critical=
 section and before write_seqcount_end() causes severe hardirq latency and =
prolongs reader spinning.
--

--- Patch [21]: [PATCH v7 21/36] KVM: x86: Avoid redundant masterclock upda=
tes from multiple vCPUs ---
commit 47fb88fca997575b4513fe25e0a0202e7a2e0b1b
Author: David Woodhouse <dwmw@amazon.co.uk>

KVM: x86: Avoid redundant masterclock updates from multiple vCPUs

This patch optimizes masterclock updates by preventing multiple vCPUs from
redundantly executing the update sequence. It introduces a check in
__kvm_start_pvclock_update() to bail out if another vCPU has already
processed the request.

> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
[ ... ]
> @@ -1710,10 +1710,39 @@ static void kvm_make_mclock_inprogress_request(st=
ruct kvm *kvm)
>  	kvm_make_all_cpus_request(kvm, KVM_REQ_MCLOCK_INPROGRESS);
>  }
> =20
> -static void __kvm_start_pvclock_update(struct kvm *kvm)
> +static void kvm_clear_mclock_inprogress_request(struct kvm *kvm)
>  {
> +	struct kvm_vcpu *vcpu;
> +	unsigned long i;
> +
> +	kvm_for_each_vcpu(i, vcpu, kvm)
> +		kvm_clear_request(KVM_REQ_MCLOCK_INPROGRESS, vcpu);
> +}
> +
> +static bool __kvm_start_pvclock_update(struct kvm *kvm, struct kvm_vcpu =
*requesting_vcpu)
> +{
> +	struct kvm_vcpu *vcpu;
> +	unsigned long i;
> +
>  	raw_spin_lock_irq(&kvm->arch.tsc_write_lock);
> +
> +	/*
> +	 * If another vCPU already did the update while we were waiting
> +	 * for the lock, our request will have been cleared. Bail out.
> +	 */
> +	if (requesting_vcpu &&
> +	    !kvm_test_request(KVM_REQ_MASTERCLOCK_UPDATE, requesting_vcpu)) {
> +		kvm_clear_mclock_inprogress_request(kvm);
> +		raw_spin_unlock_irq(&kvm->arch.tsc_write_lock);
> +		return false;
> +	}
> +
> +	/* The update is VM-wide; prevent other vCPUs from redoing it. */
> +	kvm_for_each_vcpu(i, vcpu, kvm)
> +		kvm_clear_request(KVM_REQ_MASTERCLOCK_UPDATE, vcpu);

[Severity: High]
Will this O(N) loop cause hardirq latency issues on large VMs?

By moving the kvm_for_each_vcpu() loop inside the raw_spin_lock_irq()
critical section, a VM with hundreds or thousands of vCPUs will execute
many atomic bit operations with interrupts disabled.

> +
>  	write_seqcount_begin(&kvm->arch.pvclock_sc);
> +	return true;
>  }
[ ... ]
> @@ -1730,22 +1759,25 @@ static void kvm_end_pvclock_update(struct kvm *kv=
m)
>  	struct kvm_vcpu *vcpu;
>  	unsigned long i;
> =20
> -	write_seqcount_end(&ka->pvclock_sc);
> -	raw_spin_unlock_irq(&ka->tsc_write_lock);
>  	kvm_for_each_vcpu(i, vcpu, kvm)
>  		kvm_make_request(KVM_REQ_CLOCK_UPDATE, vcpu);
> =20
>  	/* guest entries allowed */
> -	kvm_for_each_vcpu(i, vcpu, kvm)
> -		kvm_clear_request(KVM_REQ_MCLOCK_INPROGRESS, vcpu);
> +	kvm_clear_mclock_inprogress_request(kvm);
> +
> +	write_seqcount_end(&ka->pvclock_sc);
> +	raw_spin_unlock_irq(&ka->tsc_write_lock);
>  }

[Severity: High]
Does moving the seqcount and lock release to the end of the function
prolong the critical section too much?

The O(N) vCPU iteration loops are now happening before
write_seqcount_end() and before releasing the tsc_write_lock. This
substantially increases the IRQ-disabled critical section length.

Furthermore, won't holding the seqcount write lock across these loops force
reader vCPUs in kvm_guest_time_update() to spin indefinitely, wasting CPU
cycles and exacerbating latency?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260728144954.3553=
76-1-dwmw2@infradead.org?part=3D21
