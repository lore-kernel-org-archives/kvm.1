Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEBEA305057
	for <kvm@vger.kernel.org>; Mon,  8 Jun 2026 17:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780938092; cv=none; b=Ob2KSRYknsYmYPsYg6JrNpNOa+Dk1J45KkbVeB4l48Vsai4oXL5IS2SRO/hzozJIbzX7C4PjFd8I2UWiW1PYuZ4hVzOHo9bLSZjroY5rdri7wbzK54OCM2f7IdXs5co0azmUPJkfHZuAkUZHhgpdQxqQssshlmZVa63kOf5FhUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780938092; c=relaxed/simple;
	bh=2OAhqFIei3KAFqONKpDh3T67CXUy3r6g1deL+69zYZQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Jz5XZ9NDDExjBOFFEmlUWwwNimMzYJ22hMYRe4PZ7QpODQ770o/daEZKPoaZj1gZtieQMTxJxKqN8Qu51mqMUwBdwKxdNvEf29cCNOVJyxoc53fp94DJjYSDPJb/BPuA6JOuGGOOqVstIHc+e5vhF11xaupWi4/h1R1T6u7S6KA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jY4UxJJV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jY4UxJJV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7443B1F00893;
	Mon,  8 Jun 2026 17:01:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780938090;
	bh=PcdN79AwSZcRBEzVlkyO9fqqOF3Ya6fTByse0Nl90aQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jY4UxJJVj79wnKmU/XYdQenjNKObMkeQQedi/lKBWSau7BkeqWDTJP2ofdzqFyKIN
	 Rs+YQDoBHiDlavwOyX9hbVWJH9PFM31/dPRfFd0mZhlouZeilha56T3PCzoamkEJ7Y
	 Vk64XjbtKONfo0q0SzX8g+YVqL77dmy4YG5fb1kahd7BAjPBL4AXLboVJJ7fNlf1Am
	 zN8MQKTpz74Fa6sL7APZyaaL84SRUe/nl1m7AC3tM6YxbGtozM71EnQzQ3F07m2pad
	 AJJ3h1ykbWl1j5+BHHMmR2f0h4woYuLbFHMtqCH2sNbeBPvGwPPWrhNJNpG8qtRd+U
	 cVN8sxFVNDd5Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 25/60] kvm: Move kvm_vcpu->dirty_ring to struct
 kvm_vcpu_common
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260608144252.351443-26-joro@8bytes.org>
References: <20260608144252.351443-26-joro@8bytes.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Jun 2026 17:01:29 +0000
Message-Id: <20260608170130.7443B1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Time-of-Check to Time-of-Use (TOCTOU) race condition in vCPU creat=
ion allows exceeding `KVM_MAX_VCPUS`.
- [Low] Mixing goto-based error handling with scope-based `__free(kfree)` c=
leanup in `kvm_vcpu_init_common`.
--

commit 384dc0ded9d6fc5bf32fefdca7e2933c00f7cb54
Author: Joerg Roedel <joerg.roedel@amd.com>

kvm: Move kvm_vcpu->dirty_ring to struct kvm_vcpu_common

The dirty tracking should happen across all planes of a given VCPU, so
move the dirty_ring to struct kvm_vcpu_common.

> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index f1d528f392e5e..d37e9ee24f0a6 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -483,6 +483,13 @@ static int kvm_vcpu_init_common(struct kvm_vcpu *vcp=
u, struct kvm *kvm, unsigned
>  	common->ready =3D false;
>  	preempt_notifier_init(&common->preempt_notifier, &kvm_preempt_ops);
> =20
> +	if (kvm->dirty_ring_size) {
> +		r =3D kvm_dirty_ring_alloc(kvm, &common->dirty_ring,
> +					 id, kvm->dirty_ring_size);
> +		if (r)
> +			goto out_drop_counter;
> +	}
> +

[Severity: Low]
Does this introduce a mix of goto-based error handling and scope-based
cleanup?

Looking at kvm_vcpu_init_common(), common is allocated with __free(kfree):

	struct kvm_vcpu_common *common __free(kfree) =3D
		kzalloc(sizeof(*common), GFP_KERNEL_ACCOUNT);

But this patch adds a manual goto label (goto out_drop_counter) to handle
error paths. Our subsystem guidelines state that mixing goto-based cleanup
labels and scope-based __free() declarations within the same function
should be avoided.

[Severity: High]
Can this lead to a time-of-check to time-of-use race condition that allows
exceeding the maximum allowed vCPUs?

The bounds check for maximum vCPUs happens under kvm->lock, but then the
lock is dropped:

kvm_vm_ioctl_create_vcpu() {
	mutex_lock(&kvm->lock);
	if (kvm->created_vcpus >=3D kvm->max_vcpus) {
		mutex_unlock(&kvm->lock);
		return -EINVAL;
	}
	r =3D kvm_arch_vcpu_precreate(kvm, id);
	mutex_unlock(&kvm->lock);
	...
}

Later, the counter is incremented inside kvm_vcpu_init_common() under a new=
ly
acquired lock:

kvm_vcpu_init_common() {
	...
	mutex_lock(&kvm->lock);
	kvm->created_vcpus++;
	mutex_unlock(&kvm->lock);
	...
}

Does this sequence allow concurrent threads to pass the bounds check before=
 any
of them increment the counter, potentially creating an unbounded number of
vCPUs and bypassing the limit?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608144252.3514=
43-1-joro@8bytes.org?part=3D25
