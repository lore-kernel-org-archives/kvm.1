Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5005E188596
	for <kvm@vger.kernel.org>; Mon, 22 Jun 2026 03:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782098050; cv=none; b=JIHlIzQi39qNEK6rWxgNhG3YCwxElndHAept34lM2om8DwSPIoMiunzRBa24x9HEJ2uXPtWRE3hOgmpzKppGKkhdNB7fciIIqFoMECG6cg6NuT+0P+UM5E5ohEf1wQycS8hYo86mTXoJB9f3dW/HPl/58SMaQZbuGSN92vXlduU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782098050; c=relaxed/simple;
	bh=opRbICt3Fd9iuqeXzybYpDlzxC3rtH2pFBADOLx8ZJU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OAHGsB7ix0BB2tuGf/qFZ1p3wHPEJ3YXTreY5le1igtQ7IEx22TlHVzq0PYvCX3n+1FBBbrl/5HvT5hetwE/0/ThpzdLjEt2oZe/gDu10rWdD+ewcQYkBi1n1nRXCqb9yMLENNOA7cYn80ZSthFZCdyRRY/kkt/4o5eRfEw4OIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N7soOi64; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N7soOi64"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B70581F000E9;
	Mon, 22 Jun 2026 03:14:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782098048;
	bh=Pwxfu1olBg2Md7foEGnngQlBHD+BbjJDuyhh4EbRffA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=N7soOi64oRupbIhi0Io4WuckCAMkIvLjvK9m8G3e5W0RjVb3crz0hVM3vSdILtaAE
	 UUZwIHv0nmMBSovxzHAEU9aHl9Ewog26dIRLNAdErxNkqFqnik1gLwigwHy9b217Ed
	 qNNXC8UmyhYssZVVpKwNm7U25AhqVvg1QngZKHYz6wxjuOvquOywjWy5NeYl9X89E9
	 K37ijt9oo+RMPgxPER3xmd24cSh4K7HsMNIwpNMz6QOSipPUw0zpaqEc1+BmDSqGsw
	 Qh5S/Gh6njwdoSxsCjkA2oUvNA0tHXnfqxTkVUQQr3xS4pg4LwggNUI5s+aytDPkyJ
	 2sZQqdlWnJT1Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] LoongArch: KVM: Use internal API to deliver
 interrupt in kernel mode
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bibo Mao" <maobibo@loongson.cn>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260622030508.2731279-1-maobibo@loongson.cn>
References: <20260622030508.2731279-1-maobibo@loongson.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 22 Jun 2026 03:14:08 +0000
Message-Id: <20260622031408.B70581F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Un-ratelimited `kvm_err` log spam triggered by malicious guest wri=
tes.
--

commit 5c0076c5351b1595453bb8b4c3718d9f86784e4f
Author: Bibo Mao <maobibo@loongson.cn>

LoongArch: KVM: Use internal API to deliver interrupt in kernel mode

This patch replaces kvm_vcpu_ioctl_interrupt() with internal APIs
kvm_queue_irq() and kvm_dequeue_irq() for delivering interrupts in kernel
mode. It also removes unnecessary printk information when injecting
unsupported interrupts with number 0.

> diff --git a/arch/loongarch/kvm/intc/ipi.c b/arch/loongarch/kvm/intc/ipi.c
> index 4fa0897d7bdb0..b7744dcbdd8e3 100644
> --- a/arch/loongarch/kvm/intc/ipi.c
> +++ b/arch/loongarch/kvm/intc/ipi.c
[ ... ]
> @@ -40,16 +39,15 @@ static void ipi_send(struct kvm *kvm, uint64_t data)

[Severity: High]
This is a pre-existing issue, but since this patch cleans up unnecessary
kvm_err() logs elsewhere, I wanted to ask about the kvm_err() in ipi_send().

If a malicious guest writes an invalid CPU ID to the IOCSR_IPI_SEND registe=
r,
it triggers this path:

arch/loongarch/kvm/intc/ipi.c:ipi_send() {
...
	vcpu =3D kvm_get_vcpu_by_cpuid(kvm, cpu);
	if (unlikely(vcpu =3D=3D NULL)) {
		kvm_err("%s: invalid target cpu: %d\n", __func__, cpu);
		return;
	}
...
}

Since kvm_err() does not appear to be rate-limited, could a guest loop
repeatedly trigger this to spam the host syslog?

Could this lead to host performance degradation or RCU stalls, effectively
acting as a host denial of service?

>  static void ipi_clear(struct kvm_vcpu *vcpu, uint64_t data)
>  {
>  	uint32_t status;
> -	struct kvm_interrupt irq;
> =20
>  	spin_lock(&vcpu->arch.ipi_state.lock);
>  	vcpu->arch.ipi_state.status &=3D ~data;
>  	status =3D vcpu->arch.ipi_state.status;
> -	spin_unlock(&vcpu->arch.ipi_state.lock);
>  	if (status =3D=3D 0) {
> -		irq.irq =3D -LARCH_INT_IPI;
> -		kvm_vcpu_ioctl_interrupt(vcpu, &irq);
> +		kvm_dequeue_irq(vcpu, LARCH_INT_IPI);
> +		kvm_vcpu_kick(vcpu);
>  	}
> +	spin_unlock(&vcpu->arch.ipi_state.lock);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260622030508.2731=
279-1-maobibo@loongson.cn?part=3D1
