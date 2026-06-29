Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2ABD2853E9
	for <kvm@vger.kernel.org>; Mon, 29 Jun 2026 02:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782700898; cv=none; b=mOqriR3sDvKe/F9/ZINh697Eeb4kamsnjEZelN9+XP26+6J9bbElbluhf842cSCKhG7ofqlv2eFoSUiJv0WWekdxsUhSnhtZ2G9//E3cJ3Y1LXOG0KlgttARAbFW1+tC1z9yHJPn3lfhlvYhFP8MDp45jLuj8h/qCuSjzPMrRUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782700898; c=relaxed/simple;
	bh=QLNqIqBlBKyYU3WnU3tAzyHUjYPBs5dorNC4M2xDnDQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JPYhEvtl99JRyrXKbpRloHqQy6geMXdBp8Ofz0POJmD1trgqv4k0q4US+kiD3kt59mFGQ5G3vJy2BvXZXkBKLO4NdBAYisRFOvz3QQVKc2UOsARn08xkTAbpAFFl15mxTa+vHBjflbLsXQD8rp3P2+HDEKrC55MwIcRzKGOgFmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kaxLbOQ+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kaxLbOQ+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F3391F000E9;
	Mon, 29 Jun 2026 02:41:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782700897;
	bh=YiR5ADGFU1cjSgyiGaJH3s7u8suRjw/9AALn1d3P2Lg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kaxLbOQ+luluizoZwFrO00/9pdy8UHl+XEbAk/R7HjCEpPRDt4GnnBB+q+q803cl/
	 QahOqES2+S8qFDQPLaN9kr0XjDdO6u8X+DeWKPYhdJxIQJVG0KIoaUnjblQon0gZkP
	 vPaSLS3/wRmKTXfj9QAyaw7ejKDLXDP3IpP7XzqtjuXGG6d25OrxG7wI2MoSGcsZja
	 MvEqgRpGRefAQbgzxva3yL2DLqhC4+4g5JRXQAO9faG9vZbQQ1IiTBau0iQEaQwjJd
	 XAAXsTB923Y9LGhdfgAJe/7EXHcCYx88ximaTaGkA2gBCLT1flY7gPevEAkjz/fR6e
	 ZfN3xjZpLjwJA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/3] LoongArch: KVM: Use internal API to deliver
 interrupt in kernel mode
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bibo Mao" <maobibo@loongson.cn>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260629023213.597030-4-maobibo@loongson.cn>
References: <20260629023213.597030-1-maobibo@loongson.cn>
 <20260629023213.597030-4-maobibo@loongson.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 29 Jun 2026 02:41:35 +0000
Message-Id: <20260629024137.2F3391F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Multiple pre-existing WARN_ONCE and WARN_ON_ONCE macros are reacha=
ble by unprivileged host userspace and malicious guests, allowing a host-si=
de DoS if `panic_on_warn` is enabled.
- [High] Uninitialized array `vector` is conditionally assigned but uncondi=
tionally evaluated and used to modify hardware CSRs.
--

commit f75612ad87b1cded57456f721c300aad7e8b6150
Author: Bibo Mao <maobibo@loongson.cn>

LoongArch: KVM: Use internal API to deliver interrupt in kernel mode
   =20
This commit updates KVM on LoongArch to use internal APIs
kvm_queue_irq() and kvm_dequeue_irq() for delivering interrupts in kernel
mode, rather than the user mode kvm_vcpu_ioctl_interrupt(). It also moves
IPI injection and ack operations within lock protection to reduce contentio=
n.

> diff --git a/arch/loongarch/kvm/intc/dmsintc.c b/arch/loongarch/kvm/intc/=
dmsintc.c
> index 708abbcd55bff..ed85532247759 100644
> --- a/arch/loongarch/kvm/intc/dmsintc.c
> +++ b/arch/loongarch/kvm/intc/dmsintc.c
> @@ -47,7 +47,6 @@ void dmsintc_inject_irq(struct kvm_vcpu *vcpu)

[Severity: High]
This isn't a bug introduced by this patch, but looking at dmsintc_inject_ir=
q()
just above this change, is the vector array properly initialized?

arch/loongarch/kvm/intc/dmsintc.c:dmsintc_inject_irq() {
        unsigned long vector[4], old;
        ...
        for (i =3D 0; i < 4; i++) {
                old =3D atomic64_read(&(ds->vector_map[i]));
                if (old)
                        vector[i] =3D atomic64_xchg(&(ds->vector_map[i]), 0=
);
        }

        if (vector[0]) {
                old =3D kvm_read_hw_gcsr(LOONGARCH_CSR_ISR0);
                kvm_write_hw_gcsr(LOONGARCH_CSR_ISR0, vector[0] | old);
        }
}

If atomic64_read() returns zero, vector[i] is left uninitialized. When it
checks if (vector[0]) later, could this evaluate to true using stack garbage
and write random data into the guest CSRs?

>  int dmsintc_deliver_msi_to_vcpu(struct kvm *kvm,
>  				struct kvm_vcpu *vcpu, u32 vector, int level)
>  {

[ ... ]

> diff --git a/arch/loongarch/kvm/vcpu.c b/arch/loongarch/kvm/vcpu.c
> index 361fca46e2b32..265aaad633157 100644
> --- a/arch/loongarch/kvm/vcpu.c
> +++ b/arch/loongarch/kvm/vcpu.c
> @@ -1465,6 +1465,9 @@ int kvm_vcpu_ioctl_interrupt(struct kvm_vcpu *vcpu,=
 struct kvm_interrupt *irq)
>  	if (vector >=3D EXCCODE_INT_NUM)
>  		return -EINVAL;
> =20
> +	if (kvm_arch_irqchip_in_kernel(vcpu->kvm))
> +		return -EINVAL;
> +

[Severity: High]
This is a pre-existing issue, but I noticed there are several WARN_ONCE and
WARN_ON_ONCE macros reachable by unprivileged host userspace and malicious
guests in this subsystem.

For example, in kvm_vcpu_ioctl_interrupt(), providing an intr =3D=3D 0
unconditionally hits a fallback block that calls:

WARN_ONCE(1, "%s: invalid interrupt ioctl %d\n", __func__, irq->irq);

Similarly, in ipi_send() and eiointc_update_irq(), guest-controlled CPU IDs
can yield a NULL vCPU, directly triggering:

WARN_ONCE(1, "%s: invalid target cpu: %d\n", __func__, cpu);

And in loongarch_ipi_readl(), a guest unaligned MMIO read triggers:

WARN_ON_ONCE(offset & (len - 1));

Could these be converted to pr_warn_once(), return an error, or drop the
assertions entirely? These could allow a host-side denial of service if
panic_on_warn is enabled.

>  	if (!kvm_guest_has_msgint(&vcpu->arch) && (vector =3D=3D INT_AVEC))
>  		return -EINVAL;
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260629023213.5970=
30-1-maobibo@loongson.cn?part=3D3
