Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A52C24A078
	for <kvm@vger.kernel.org>; Tue, 21 Jul 2026 12:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784637606; cv=none; b=JlvYJx0y39aV92TlzN8NB5XZuT1fi8JMysKn67rn5K8k3YCQhBVD6MlUwAdgbjThauvxM0i8UZ9vnRT0yaF7aOd+HL/aLfxfLEEIOGwuQ2pK+Ez9ebEqP+ENvYzcazb1G0PUUghNWI1ZHfEBxAKhkiNkCSxeQ8embTSEFfpjGEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784637606; c=relaxed/simple;
	bh=aOKJqzquDVHoKVJ5hXg2fuUKcSLDuRBbAZaqFntLHok=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OXbN1nobMOWvx4Bb4wBRrvQTd5j4aj2Uo9xOpwAaVahniBWPa1kvqSv/SBRtsJjJhPHf6tQ5CAcry8aqrjJo1zdmz/dZvP6snYk/HJjNg8ajk9DGQoVsmcQzYK12MkLrBVaEALy0/C4LYYVeBfEWeIkuRUOlniNMECTSYFVBfXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z6cc6nFv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z6cc6nFv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3587D1F000E9;
	Tue, 21 Jul 2026 12:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784637605;
	bh=OerlBI4QHKFdx0dey1o8F3oqcDOWKNf5c95sGK1PhNg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Z6cc6nFvPyBvgBwpvN0QHQcTA9EF1zsYchJNs48aSljQTLgSS6YRxWuMAhHqbCag6
	 i2k/yPuBG91XWelhrprDY0Lq15R/9VdNsvOqq0/FfblBpx/Om5MzFq3VDqjNk1aAqJ
	 WZm5tSwJFODYSzjXxIzPJgfDwTmXYMIztJ8cQT7Hg62vSdKbXI7J3XrrqHx2vTDOzI
	 XrvU2pMNHo2L36aO4yU0uCesrS/4gCUnumOfe22cwnKOw68lL2Wml6GqSr5dEsXLGh
	 KRtFFhZO5DhpBnf6jMhwVxuR6p1nJpfHuknyZRaLPduoSqFTfJwOnx5vHXzOi5umkO
	 G6Mq1XQla6dbQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] LoongArch: KVM: Implement KVM_GET/SET_SREGS for bulk
 CSR migration
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tao Cui" <cui.tao@linux.dev>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260721121842.156025-1-cui.tao@linux.dev>
References: <20260721121842.156025-1-cui.tao@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jul 2026 12:40:04 +0000
Message-Id: <20260721124005.3587D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] Redundant vcpu_load()/vcpu_put() in kvm_arch_vcpu_ioctl_get_sr=
egs causes preempt_notifiers list corruption and a guaranteed kernel crash.
--

--- Patch [1]: [PATCH] LoongArch: KVM: Implement KVM_GET/SET_SREGS for bulk=
 CSR migration ---
commit 0b0da4f87cc239c49e5848ae374209644b4ea927
Author: Tao Cui <cuitao@kylinos.cn>

LoongArch: KVM: Implement KVM_GET/SET_SREGS for bulk CSR migration
   =20
This commit adds KVM_GET_SREGS and KVM_SET_SREGS ioctls for LoongArch to
allow bulk CSR migration. It defines the kvm_sregs struct as a flat array
to optimize performance compared to multiple KVM_GET/SET_ONE_REG calls.

> diff --git a/arch/loongarch/kvm/vcpu.c b/arch/loongarch/kvm/vcpu.c
> index 20c207d80e31a..0890b68efa2ae 100644
> --- a/arch/loongarch/kvm/vcpu.c
> +++ b/arch/loongarch/kvm/vcpu.c

[ ... ]

> @@ -1001,12 +1001,51 @@ static int kvm_set_reg(struct kvm_vcpu *vcpu, con=
st struct kvm_one_reg *reg)
> =20
>  int kvm_arch_vcpu_ioctl_get_sregs(struct kvm_vcpu *vcpu, struct kvm_sreg=
s *sregs)
>  {
> -	return -ENOIOCTLCMD;
> +	int i;
> +	unsigned long estat, gintc;
> +	struct loongarch_csrs *csr =3D vcpu->arch.csr;
> +
> +	/*
> +	 * Pull pending interrupts into ESTAT with a single vcpu_load/put so
> +	 * the ESTAT value read below matches the current interrupt state.
> +	 * This also avoids the per-register load/put side-effect that makes
> +	 * the ONE_REG path's ESTAT snapshot order-sensitive.  The SW CSR
> +	 * reads run under vcpu->mutex, which serialises this ioctl.
> +	 */
> +	preempt_disable();
> +	vcpu_load(vcpu);

[Severity: Critical]
Will this vcpu_load() call corrupt the preempt_notifiers hlist?

The KVM generic ioctl handler kvm_vcpu_ioctl() in virt/kvm/kvm_main.c alrea=
dy
calls vcpu_load() before dispatching KVM_GET_SREGS. Calling vcpu_load() a=20
second time here will double-register the preempt notifier, which calls=20
hlist_add_head() on a node already at the head of the list, creating a=20
circular reference.

> +	kvm_deliver_intr(vcpu);
> +	vcpu->arch.aux_inuse &=3D ~KVM_LARCH_SWCSR_LATEST;
> +	vcpu_put(vcpu);

[Severity: Critical]
Does this vcpu_put() cause a guaranteed kernel panic?

Because the node's pointers were corrupted by the double vcpu_load(), this
vcpu_put() unregisters the node but poisons its pointers. When the ioctl
returns to the generic kvm_vcpu_ioctl() handler, the outer vcpu_put() will
attempt to unregister the node again. This writes to LIST_POISON2 and
unconditionally triggers a fatal page fault on the host.

> +	preempt_enable();
> +
> +	for (i =3D 0; i < KVM_LOONGARCH_NR_SREGS; i++) {

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260721121842.1560=
25-1-cui.tao@linux.dev?part=3D1
