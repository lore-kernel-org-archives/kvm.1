Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7CBA2356C6
	for <kvm@vger.kernel.org>; Mon, 25 May 2026 05:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779686235; cv=none; b=MGK2vA2LrXPDUGegD5IAkcBvJ9/eEc3aptU7OtlFJxQzyyssp+RbgTyRLKmzR0x4lHLvrJM5eDTZOZJSYgsRQTCDiL1/IgwTV7Frb0sGEpVTxlluF8DBbFj1mIoxyEfK94b0pdNvr+QrF14VGgwJHJlDW6qS8VwxhchgbUw+Xhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779686235; c=relaxed/simple;
	bh=ZHxcErcXty1HmZPinImYNljm+wOhfbxoVxcYak+pfto=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Gx/dH2IgnkBEnERGQw6nkL6vQBq2yAMiWJziGNnRNyDu3rFDzuDbL3sRBvdpj6ZYJTSe2ZYPXiQr21xMKiOdhb4nKj/xGH/APdsMAQ4fFdawhWX4YhzEAuGSEZCSeaLXYdiBbvkfxVjPjR+2NR/ZzIEoXeFccW+gWb5+3nzSbTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B5zj+zcg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B5zj+zcg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 485D51F000E9;
	Mon, 25 May 2026 05:17:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779686234;
	bh=3Eypf9UJEuM/2OyOqF5KBeZNbrV9RWRXtVdFOl0Eyp0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=B5zj+zcgdZglMAOOm6LlYhsyH6OfwZ/CijrGfLdvZxR+LGTRT5v2lXb+GhRLc8ZiC
	 G4xPOt2OJbiW2NdX2JdkRjE7+W3dESofWsnT4pSGaOQ7v+kt+eobdO80xUXBFStrFB
	 MgXMLH6xTmuda1x82/EEjumtnHMj6+IAruE79MPqRFKbFLixfJcuW8W918R//5LHpl
	 K+sBq4TbnWStpd7/0153TEvYx3NFOP7T6GeykBl8e9vNyLFzAiUnRJVX8irrSc19KI
	 wc5ynG1DOY00h8ONPGNfr3SoPAj7jk8BHsZlXM/ZXb8jk/qxX7A+4qUhXxXUp97ir1
	 cKDojDz/CvM7g==
From: sashiko-bot@kernel.org
Subject: Re: [v3 2/2] KVM: irqchip: Cache IRQ routing entries allocation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yanfei Xu" <yanfei.xu@bytedance.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260525035242.107264-3-yanfei.xu@bytedance.com>
References: <20260525035242.107264-3-yanfei.xu@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 25 May 2026 05:17:13 +0000
Message-Id: <20260525051714.485D51F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Missing bounds check on user-supplied `ue->u.irqchip.irqchip` =
allows an out-of-bounds array write on LoongArch and PowerPC.
--

commit 8ac8d5f6cab84711afabacca6347f1ad673dc605
Author: Yanfei Xu <yanfei.xu@bytedance.com>
Subject: KVM: irqchip: Cache IRQ routing entries allocation

This patch caches a VM-local entries array allocation from a freed IRQ rout=
ing
table to reduce allocation and free churn during frequent routing updates. =
It
also initializes the remaining MSI fields on x86, LoongArch, and PowerPC si=
nce
cached entries are reused without being zeroed.

> diff --git a/arch/loongarch/kvm/irqfd.c b/arch/loongarch/kvm/irqfd.c
> index f4f953b224192..15cc80cde071b 100644
> --- a/arch/loongarch/kvm/irqfd.c
> +++ b/arch/loongarch/kvm/irqfd.c
> @@ -60,6 +60,8 @@ int kvm_set_routing_entry(struct kvm *kvm,
>  		e->msi.address_lo =3D ue->u.msi.address_lo;
>  		e->msi.address_hi =3D ue->u.msi.address_hi;
>  		e->msi.data =3D ue->u.msi.data;
> +		e->msi.flags =3D ue->flags;
> +		e->msi.devid =3D ue->u.msi.devid;

[Severity: Critical]
This isn't a bug introduced by this patch, but does the KVM_IRQ_ROUTING_IRQ=
CHIP
case in this function lack bounds checking on the irqchip index?

Looking at kvm_set_routing_entry() on LoongArch (and similarly on PowerPC),
the irqchip.pin is validated against KVM_IRQCHIP_NUM_PINS, but there doesn't
appear to be a check for e->irqchip.irqchip against KVM_NR_IRQCHIPS.

When kvm_set_routing_entry() returns success, setup_routing_entry() executes
this array write:

virt/kvm/irqchip.c:setup_routing_entry() {
    ...
    if (e->type =3D=3D KVM_IRQ_ROUTING_IRQCHIP)
        rt->chip[e->irqchip.irqchip][e->irqchip.pin] =3D e->gsi;
    ...
}

Could this allow a user-supplied routing entry to provide an arbitrarily
large irqchip index, causing an out-of-bounds write of e->gsi into the heap
memory following the kvm_irq_routing_table?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260525035242.1072=
64-1-yanfei.xu@bytedance.com?part=3D2
