Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FF8B199E89
	for <kvm@vger.kernel.org>; Fri, 28 Aug 2026 10:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787911326; cv=none; b=NA+HUZnnkIzXPaxS239uFY/lbJrRlrqh17kpb5Tx3FwALTtPtjhQqKJUwHxyhBTqxQZXlY3OllalY/zZ9hC+nAME9Bv5i2R1EaDrFHC2YbC0/ga/nOdIaN1oPQ8BaLmdXFnf7uDpvy960PYyqOyrkzd0vQ3BxYk9UFGhmxm2k4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787911326; c=relaxed/simple;
	bh=pQMLep/+hIhLEd2X6htYtJiuWHQmWAvUkiuetsOVnw8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LDDyKXSSFCxtUn6IGBq/j1/b0mH3m+B0b736ZDGep860WcR9SPtXy5dTDJt5aTG1DNij5lJ4X206imXjOpMRYauvFjAhnMjnfFJt/jE7VO17Zkgw3LhkjqHQdnpd3IONmGsV1PFdr+aVtkJHYarPZwUgNT6Z0vh+zqXQhqhUx2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Klq/gdO6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Klq/gdO6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC38D1F000E9;
	Fri, 28 Aug 2026 10:02:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787911325;
	bh=4HHVhn2VJOJAxybdJEEd5xx8CTLE17wUloJKb6tegb8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Klq/gdO6gOOJXTQw9uG+LuggZLC6TzOLTpjb8qfwKETGBK76HAXcDULG+U84oaWcg
	 on0Y7c6xlOwMI6aPCsdOU+R6N9y/qPhG66O601qE7ad2g4cY3Nd+9IVJ8klRL9YeQp
	 QobIg0jginaRN3bPmFJuejsBdOrIcf+IrP8DBPNvI9OwCO1DjNCRBfTsF1B5eb8M3w
	 CAFlvDIJQV7npy9dY+00KlYEzwWqkBELkzYND+aqt3U76frRGzmEH2c4CjRT64mJ9q
	 0/Cao9DSgoVgQu0x6JOWwuPCIks74Q/OcmsPSFNXu7hS54NrayjcjM8TAJF4RWZvkp
	 YO+x1vuephH6A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] LoongArch: KVM: Validate MSI data before routing it to
 EIOINTC
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zeng Chi" <zeng_chi911@163.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260828093604.56622-1-zeng_chi911@163.com>
References: <20260828093604.56622-1-zeng_chi911@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 28 Aug 2026 10:02:04 +0000
Message-Id: <20260828100204.CC38D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Preexisting NULL pointer dereference in pch_pic_update_irq() w=
hen EIOINTC is not instantiated.
--

commit 2e412c04f647995bc67015a157c68cab104e2514
Author: Zeng Chi <zengchi@kylinos.cn>

    LoongArch: KVM: Validate MSI data before routing it to EIOINTC
   =20
    pch_msi_set_irq() passes e->msi.data straight into eiointc_set_irq() as
    the irq number. The MSI data comes from userspace and is never checked
    against EIOINTC_IRQS, which can corrupt kernel memory. This patch
    rejects MSI data that doesn't fit in the EIOINTC irq space.

> diff --git a/arch/loongarch/kvm/intc/pch_pic.c b/arch/loongarch/kvm/intc/=
pch_pic.c
> index e7b77705c516a..81fb534ce8dd5 100644
> --- a/arch/loongarch/kvm/intc/pch_pic.c
> +++ b/arch/loongarch/kvm/intc/pch_pic.c
> @@ -78,6 +78,9 @@ int pch_msi_set_irq(struct kvm *kvm, struct kvm_kernel_=
irq_routing_entry *e, int
>  		return dmsintc_set_irq(kvm, msg_addr, e->msi.data, level);
>  	}
> =20
> +	if (e->msi.data >=3D EIOINTC_IRQS)
> +		return -EINVAL;
> +
>  	eiointc_set_irq(kvm->arch.eiointc, e->msi.data, level);

[Severity: Critical]
This isn't a bug introduced by this patch, but is it possible for
s->kvm->arch.eiointc to be unconditionally dereferenced as a NULL pointer
in pch_pic_update_irq() when the EIOINTC device is not instantiated?

A KVM userspace process can create a KVM_DEV_TYPE_LOONGARCH_PCHPIC device
via ioctl without creating the KVM_DEV_TYPE_LOONGARCH_EIOINTC device.

If the process pre-populates the irr (Interrupt Request Register) of the
PCHPIC device using the KVM_SET_DEVICE_ATTR ioctl, and then runs a guest
VCPU to perform an MMIO write to PCH_PIC_MASK_START to unmask the pending
interrupt, it bypasses standard KVM IRQ injection checks.

This results in the following path:

loongarch_pch_pic_write() -> pch_pic_update_batch_irqs() -> pch_pic_update_=
irq()

arch/loongarch/kvm/intc/pch_pic.c:pch_pic_update_irq() {
	...
	if (level) {
		if (mask & s->irr & ~s->mask) {
			s->isr |=3D mask;
			irq =3D s->htmsi_vector[irq];
			eiointc_set_irq(s->kvm->arch.eiointc, irq, level);
	...
}

Because EIOINTC was never created, the pointer is NULL. Because
eiointc_set_irq() unconditionally dereferences it via s->isr, can this
malicious guest action trigger an immediate host kernel panic?

> =20
>  	return 0;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260828093604.5662=
2-1-zeng_chi911@163.com?part=3D1
