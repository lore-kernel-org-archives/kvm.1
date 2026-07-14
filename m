Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 372B13F210C
	for <kvm@vger.kernel.org>; Tue, 14 Jul 2026 07:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784015632; cv=none; b=SK+r2HL4WeGvf7wDne5VeaZpuWOPoZfqOdy9DzxqP9HnK8TBPqv+84ux/XU8nluqG+FQyw/Twp7TlULeOBCNJAOEE+AUywN3+VY9sXQdYVaQ9z+FfISoKyyIobbiV8VGg7pmnqSS1qn2D2BtMHu3kKqV6qfXMvU27RFjrai/+xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784015632; c=relaxed/simple;
	bh=Lh7l8rCzIDVkRV5DbgZkP4fufM+2aklzmayjdCHfnPE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hSh2l50jXEPtWWfX8y1XBavimvCJs0ZPVEBPumdhFGs288PjHobYtSBRJFB3YJDMsDKcDzDRzqHSHog1JW8iXVpnYvmeMV4Vvgq65Vwptk9W5+It2+tCqaxW/28LmGijIF1carDSlYX9HNttfZXvYNV2gbzoaZYwkRZYwVTlXmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fIuijtbg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fIuijtbg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D58791F00A3A;
	Tue, 14 Jul 2026 07:53:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784015631;
	bh=r0f4dobjIC5vuXPWltYSoCnOcVLDAq407Zdbkls72bo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fIuijtbgFO8v16MUKGUEmCoUZ/JCOoXFb04amxUj9dWLwWHHyX5au+zxQE6awcZNA
	 2p1i8YeiJizBtgLOUuTsAFpdxbhgZp+NKY5IIJkbxDFDYmtV3SusVAKw93lU8qqKgd
	 xEaEnnbUGLxwwTw6rlKVHVQKxJ1DxDJopFrHB7Gmhz7tZy+zpc0S9ZthuBrLoQZT/D
	 AsLdwCECjqDWkEKNvXqxS2GVij9cBxu2I/i0H4bAULMsqBR6My9m0zcdzCqNytY+iW
	 QtUQg8QChzb9w0VFpX8l+75UmurrBXLI1lwjHWIw5MqY9/9KdzLMeNOLjPcTMx0yYJ
	 EeXNkS529J9Kw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 5/5] LoongArch: KVM: Use internal API to deliver
 interrupt in kernel mode
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bibo Mao" <maobibo@loongson.cn>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260714072520.2745942-6-maobibo@loongson.cn>
References: <20260714072520.2745942-1-maobibo@loongson.cn>
 <20260714072520.2745942-6-maobibo@loongson.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 07:53:50 +0000
Message-Id: <20260714075350.D58791F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Medium] The commit silently includes a critical fix for a guest-triggera=
ble out-of-bounds array access in the EIOINTC emulation.

Pre-existing issues:
- [Critical] Unvalidated 'msi.data' from userspace causes severe out-of-bou=
nds memory accesses in 'eiointc_set_irq' and 'eiointc_update_irq'.
--

--- Patch [5]: [PATCH v5 5/5] LoongArch: KVM: Use internal API to deliver i=
nterrupt in kernel mode ---
commit f180398d8de8f24b25d2d879c17f336978ed95e1
Author: Bibo Mao <maobibo@loongson.cn>

LoongArch: KVM: Use internal API to deliver interrupt in kernel mode
   =20
API kvm_vcpu_ioctl_interrupt() is mainly to used to deliver interrupt
from user mode, and internal APIs kvm_queue_irq() and kvm_dequeue_irq()
are used in kernel mode.

Also move IPI inject and ack within lock protection to avoid contention
in ipi_set() and ipi_clear().

> diff --git a/arch/loongarch/kvm/intc/eiointc.c b/arch/loongarch/kvm/intc/=
eiointc.c
> index fd089d54da103..e04aadbd68db9 100644
> --- a/arch/loongarch/kvm/intc/eiointc.c
> +++ b/arch/loongarch/kvm/intc/eiointc.c
> @@ -17,7 +17,8 @@ static void eiointc_set_sw_coreisr(struct loongarch_eio=
intc *s)
>  		if (!(s->status & BIT(EIOINTC_ENABLE_INT_ENCODE))) {
>  			ipnum =3D count_trailing_zeros(ipnum);
>  			ipnum =3D ipnum < 4 ? ipnum : 0;
> -		}
> +		} else if (ipnum >=3D LOONGSON_IP_NUM)
> +			ipnum =3D 0;

[Severity: Medium]
This looks like a fix for an out-of-bounds array access, as ipnum is used to
index into s->sw_coreisr[][] shortly after this.

Should this fix be documented in the commit message or split into a separate
patch so it can be properly tracked and backported?

[ ... ]

> @@ -36,13 +37,13 @@ static void eiointc_update_irq(struct loongarch_eioin=
tc *s, int irq, int level)
>  {
>  	int ipnum, cpu, found;
>  	struct kvm_vcpu *vcpu;
> =20
>  	ipnum =3D (s->ipmap >> (irq / 32 * 8)) & 0xff;
>  	if (!(s->status & BIT(EIOINTC_ENABLE_INT_ENCODE))) {
>  		ipnum =3D count_trailing_zeros(ipnum);
>  		ipnum =3D ipnum < 4 ? ipnum : 0;
> -	}
> +	} else if (ipnum >=3D LOONGSON_IP_NUM)
> +		ipnum =3D 0;
> =20
>  	cpu =3D s->sw_coremap[irq];

[Severity: Critical]
This is a pre-existing issue, but does this code perform an out-of-bounds r=
ead
or write if irq is greater than or equal to EIOINTC_IRQS (256)?

In pch_msi_set_irq(), the untrusted 32-bit e->msi.data is passed directly as
the irq index:

arch/loongarch/kvm/intc/pch_pic.c:pch_msi_set_irq() {
    ...
    eiointc_set_irq(kvm->arch.eiointc, e->msi.data, level);
    ...
}

eiointc_set_irq() then performs a bitwise operation on the 256-bit isr array
without bounds checking:

arch/loongarch/kvm/intc/eiointc.c:eiointc_set_irq() {
    ...
    level ? __set_bit(irq, isr) : __clear_bit(irq, isr);
    eiointc_update_irq(s, irq, level);
    ...
}

And here in eiointc_update_irq(), it accesses s->sw_coremap[irq].

If e->msi.data from userspace or guest is >=3D 256, could this cause host k=
ernel
memory corruption?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260714072520.2745=
942-1-maobibo@loongson.cn?part=3D5
