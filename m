Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59271411664
	for <kvm@vger.kernel.org>; Tue, 16 Jun 2026 08:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781600224; cv=none; b=qCfMo7RSj3q8D+Vw94AMCkKMwbaUB4tckSECXb9E0HD6YnKXOxTEj3faC2a80Ym1B++u/BnDlAts9zLvrPjYYRv/9BiIXnCvuuWI6MDZKobAfJ/Y5QsE40UrkZKKcdxULWXu6oz7PYMIYca4RM7UEVFlmFkLRQsh8N2Fg21ieG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781600224; c=relaxed/simple;
	bh=v+gMl182wD+1g218clj9h8vi33nhvhLTvkrTtVqsx80=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Tuih9DVYVanOvW4qU2DlUSTnH7Mh1I7+yz+bwnRiOwfwpcxwboJQ8HWiDrlV+3y4We39H5M49hfUHs/TkfDVlAq+9vr4AnAhH67J7f5rDArz5wFZ7APGg4gqiNOJbbOmjlDdTiZYwX3fvAdgY4pw9N6B+eXMaLzalHGOoZyQlhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aGIfLYUi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aGIfLYUi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD0F91F000E9;
	Tue, 16 Jun 2026 08:57:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781600223;
	bh=nsnPZ6KEkTBAQRlFyvbUXuEzvTDj6cwtW7cYDDfnNAg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aGIfLYUi9XxXV4xX7JXEUQHlEiHNP5XsvMWU2NDOSBJ8sN6JpO25TYpacZI2QyjkP
	 FfnNhmx8CrBnOsSNZuIED1C4Vf4MBgQVMstr7J4eLVR++lgGbxXJMHxXO4Rg6rXMzy
	 nHFyFDC+zdMY5Q4d+w621dSOX5l/qn/efOrecbekJGaQtHQTRjFsgLYyTHtKrJnVYQ
	 +Gxf7z1l7YnhjhIc0UEvgwDo9SI7g9XNbgGCKxu749qRjLAZO4MgAeHituhbiT61XV
	 kVBXiAVU9iuT2zBh7jF6qTkw5qnc02XtpwMCzLU5c2LP4R07IxLFvQbswT8RwrUYQt
	 eXwnc7y31V7Lg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] LoongArch: KVM: User internal API to deliver interrupt
 in kernel mode
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bibo Mao" <maobibo@loongson.cn>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260616084538.2274484-1-maobibo@loongson.cn>
References: <20260616084538.2274484-1-maobibo@loongson.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 16 Jun 2026 08:57:02 +0000
Message-Id: <20260616085702.CD0F91F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] The KVM_INTERRUPT ioctl lacks bounds checking on the user-prov=
ided interrupt number, allowing unprivileged host userspace to trigger out-=
of-bounds bit operations.
- [Critical] Guest-controlled interrupt pin number extraction allows out-of=
-bounds bitwise writes in host kernel memory.
- [High] Time-of-check to time-of-use (TOCTOU) race condition in IPI delive=
ry and clearance allows inter-processor interrupts to be lost.
--

commit 29e0cf4460ddc2a662b4de4e3946b4ad4d5ce123
Author: Bibo Mao <maobibo@loongson.cn>

LoongArch: KVM: User internal API to deliver interrupt in kernel mode

This commit refactors interrupt delivery in kernel mode to use the internal
APIs kvm_queue_irq() and kvm_dequeue_irq() directly, bypassing the ioctl
interface. It also removes the printk error message for invalid interrupts
with number 0.

> diff --git a/arch/loongarch/kvm/intc/eiointc.c b/arch/loongarch/kvm/intc/=
eiointc.c
> index 2ab7fafa86d59..63f917de7903c 100644
> --- a/arch/loongarch/kvm/intc/eiointc.c
> +++ b/arch/loongarch/kvm/intc/eiointc.c
[ ... ]
> @@ -67,8 +66,11 @@ static void eiointc_update_irq(struct loongarch_eioint=
c *s, int irq, int level)
>  	if (found < EIOINTC_IRQS)
>  		return; /* other irq is handling, needn't update parent irq */
> =20
> -	vcpu_irq.irq =3D level ? (INT_HWI0 + ipnum) : -(INT_HWI0 + ipnum);
> -	kvm_vcpu_ioctl_interrupt(vcpu, &vcpu_irq);
> +	if (level)
> +		kvm_queue_irq(vcpu, INT_HWI0 + ipnum);

[Severity: Critical]
This isn't a bug introduced by this patch, but does the guest-controlled
ipnum lack bounds checking before being used here?

In eiointc_update_irq(), ipnum is calculated from the guest-controlled
s->ipmap register. If the guest enables EIOINTC_ENABLE_INT_ENCODE, this
value can be passed unmodified.

Since INT_HWI0 is 2, the passed IRQ number can be up to 257. Because
kvm_queue_irq() uses this to set a bit in vcpu->arch.irq_pending (which
is a single 64-bit unsigned long), does this write past the end of
irq_pending and corrupt adjacent host memory?

> +	else
> +		kvm_dequeue_irq(vcpu, INT_HWI0 + ipnum);
> +	kvm_vcpu_kick(vcpu);
>  }

> diff --git a/arch/loongarch/kvm/intc/ipi.c b/arch/loongarch/kvm/intc/ipi.c
> index 1f6ebbd0af5c8..ab3d894eb1469 100644
> --- a/arch/loongarch/kvm/intc/ipi.c
> +++ b/arch/loongarch/kvm/intc/ipi.c
[ ... ]
> @@ -10,15 +10,14 @@
>  static void ipi_set(struct kvm_vcpu *vcpu, uint32_t data)
>  {
>  	uint32_t status;
> -	struct kvm_interrupt irq;
> =20
>  	spin_lock(&vcpu->arch.ipi_state.lock);
>  	status =3D vcpu->arch.ipi_state.status;
>  	vcpu->arch.ipi_state.status |=3D data;
>  	spin_unlock(&vcpu->arch.ipi_state.lock);
>  	if ((status =3D=3D 0) && data) {
> -		irq.irq =3D LARCH_INT_IPI;
> -		kvm_vcpu_ioctl_interrupt(vcpu, &irq);
> +		kvm_queue_irq(vcpu, LARCH_INT_IPI);

[Severity: High]
This isn't a bug introduced by this patch, but can a race condition here
cause inter-processor interrupts to be lost?

The queuing of the interrupt via kvm_queue_irq() happens outside the lock
based on a local snapshot of status. If CPU 0 clears an IPI and unlocks, and
CPU 1 sets a new IPI and queues it, could CPU 0 then resume and incorrectly
execute kvm_dequeue_irq() based on its stale status?

> +		kvm_vcpu_kick(vcpu);
>  	}
>  }
> =20
[ ... ]
> @@ -40,15 +39,14 @@ static void ipi_send(struct kvm *kvm, uint64_t data)
>  static void ipi_clear(struct kvm_vcpu *vcpu, uint64_t data)
>  {
>  	uint32_t status;
> -	struct kvm_interrupt irq;
> =20
>  	spin_lock(&vcpu->arch.ipi_state.lock);
>  	vcpu->arch.ipi_state.status &=3D ~data;
>  	status =3D vcpu->arch.ipi_state.status;
>  	spin_unlock(&vcpu->arch.ipi_state.lock);
>  	if (status =3D=3D 0) {
> -		irq.irq =3D -LARCH_INT_IPI;
> -		kvm_vcpu_ioctl_interrupt(vcpu, &irq);
> +		kvm_dequeue_irq(vcpu, LARCH_INT_IPI);

[Severity: High]
This isn't a bug introduced by this patch, but this dequeue operation appea=
rs
to mirror the race condition mentioned above, potentially clearing an inter=
rupt
that was just queued by another CPU.

> +		kvm_vcpu_kick(vcpu);
>  	}
>  }

> diff --git a/arch/loongarch/kvm/vcpu.c b/arch/loongarch/kvm/vcpu.c
> index e28084c49e682..bd90be3f498b4 100644
> --- a/arch/loongarch/kvm/vcpu.c
> +++ b/arch/loongarch/kvm/vcpu.c
[ ... ]
> @@ -1492,10 +1492,8 @@ int kvm_vcpu_ioctl_interrupt(struct kvm_vcpu *vcpu=
, struct kvm_interrupt *irq)
>  		kvm_queue_irq(vcpu, intr);
>  	else if (intr < 0)
>  		kvm_dequeue_irq(vcpu, -intr);

[Severity: Critical]
This isn't a bug introduced by this patch, but does the KVM_INTERRUPT ioctl
handler lack bounds checking on the user-provided interrupt number?

The ioctl parses an __u32 irq from user memory and passes it to
kvm_vcpu_ioctl_interrupt(), which unconditionally passes it to
kvm_queue_irq() or kvm_dequeue_irq().

Since these functions execute atomic bit operations (set_bit/clear_bit) on
vcpu->arch.irq_pending and vcpu->arch.irq_clear (which are single 64-bit
unsigned long values), could an unprivileged host process with /dev/kvm
access supply arbitrarily large values to manipulate host kernel memory
outside the bounds of the VCPU architecture struct?

> -	else {
> -		kvm_err("%s: invalid interrupt ioctl %d\n", __func__, irq->irq);
> +	else
>  		return -EINVAL;
> -	}
> =20
>  	kvm_vcpu_kick(vcpu);
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260616084538.2274=
484-1-maobibo@loongson.cn?part=3D1
