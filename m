Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 590741B6D08
	for <kvm@vger.kernel.org>; Mon,  8 Jun 2026 18:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780945097; cv=none; b=dNkXLDDhFCieWTbR/cf+u8eHsAr2S1yjvTgUoP4a/ggQBORnuYA7DqHMfzxWzkPLZknFQTtQntDPjb28iRJix872JqabHFW22VJ9i90uiR5hwUmt7PuPxva7pd17BDvFHFzeXNyFR7oWOwPH69vPJP3pzxxeHFCZBS7mYqLmkwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780945097; c=relaxed/simple;
	bh=xPdknWNi6m6ddYNXIa5bf7UsXWZ/XGVWxFfo8z1mlj4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Q6DVYQBIPj2jjPT/Q38UlFAGiaYr7B8I0e930zPdEsTM5iFlhELwZt1h7knX5dvswYNJqrNOJaudy4p0gXQgKPwe5dqDmEAknMVkgyufsG+80+mTEiznReMtLJOem9xHJ7unkn294DX57kwUslnzVQMWQQYEc35Hq79iYRLucVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U3h+qAwD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U3h+qAwD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF3B31F00893;
	Mon,  8 Jun 2026 18:58:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780945096;
	bh=sM+Xq6xNYRQkdHtYqcjzM8tXGzyxkpTZW4pSFVrUyd8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=U3h+qAwDl8OBvMayiXsGw699FfP2SYfX3k/DtY40Ab8lhnVOLG4eXAtx6bgZaVij5
	 zOgboOCMwyFSFutvd0UsTjoHY1vDGzVjzLb4vwtKPtAS2SDIrgGWYB1+5RCbkLZxa9
	 axAsBpMhGNg+TujJ1nlw4YaurfilVXmX5uVKf/lBLBoi+duNbArS8/n0bNB7b1EPNY
	 uKyhlnJL7Uw2g5f+NmPggeBCKJnsm4sCK7aHGKbzr3tuuzJCjhEwfozjJZACzQrpJJ
	 /cSnreJsScucnnmPXMqK6tGfwfWGwr5drTJvXQM422U4NdlTCYG6alEjGImBt/Ukm0
	 medYG/00iCBIg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 37/60] kvm: Pass plane_level to kvm_set_routing_entry()
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260608144252.351443-38-joro@8bytes.org>
References: <20260608144252.351443-38-joro@8bytes.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Jun 2026 18:58:15 +0000
Message-Id: <20260608185815.DF3B31F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The `plane_level` field in the stack-allocated `route` structure i=
n `kvm_send_userspace_msi()` is left uninitialized, leading to unpredictabl=
e routing.
--

commit c0cc00a54b6971a99bf9346816eca0f0b3372493
Author: Joerg Roedel <joerg.roedel@amd.com>

The plane_level is used to route MSI IRQs to the correct plane.

This patch updates the KVM routing entry setup to include a plane_level
parameter. It modifies kvm_set_routing_entry across multiple architectures
to pass this target plane level for MSI IRQ routing.

[ ... ]

> diff --git a/virt/kvm/irqchip.c b/virt/kvm/irqchip.c
> index ae47e56176f1..14480d1df4f9 100644
> --- a/virt/kvm/irqchip.c
> +++ b/virt/kvm/irqchip.c
> @@ -146,7 +146,7 @@ static int setup_routing_entry(struct kvm *kvm,
> =20
>  	e->gsi =3D gsi;
>  	e->type =3D ue->type;
> -	r =3D kvm_set_routing_entry(kvm, e, ue);
> +	r =3D kvm_set_routing_entry(kvm, e, ue, 0);

[Severity: High]
Does this routing change leave route.msi.plane_level uninitialized in
kvm_send_userspace_msi() when handling the KVM_SIGNAL_MSI ioctl?

Looking at virt/kvm/irqchip.c:kvm_send_userspace_msi():

	struct kvm_kernel_irq_routing_entry route;

	if (!kvm_arch_irqchip_in_kernel(kvm) || (msi->flags & ~KVM_MSI_VALID_DEVID=
))
		return -EINVAL;

	route.msi.address_lo =3D msi->address_lo;
	route.msi.address_hi =3D msi->address_hi;
	route.msi.data =3D msi->data;
	route.msi.flags =3D msi->flags;
	route.msi.devid =3D msi->devid;

	return kvm_set_msi(&route, kvm, KVM_USERSPACE_IRQ_SOURCE_ID, 1, false);

Since the struct kvm_kernel_irq_routing_entry is allocated on the stack and
isn't zero-initialized, and plane_level isn't explicitly set here, could
route.msi.plane_level contain garbage stack data before it is passed to
kvm_set_msi()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608144252.3514=
43-1-joro@8bytes.org?part=3D37
