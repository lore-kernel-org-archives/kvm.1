Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E3928C037
	for <kvm@vger.kernel.org>; Mon, 10 Aug 2026 15:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786376574; cv=none; b=oTlDMBz9dNguZlpXcoU601JlkHyPn/RnoH8aLXcC9e78u0e0LgGKjhA6QUFmct7rCubfpdwbzU79uG2uWwkgAmEBrsTXb3ivxHTxe9093c2nopx7uUQa0SsL+B/I5ydSDp92+BeN7p9B7uu3ynTSzGq6BAUwO1EVECtE+AYjvcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786376574; c=relaxed/simple;
	bh=ZdfFRGqLs1S+5UDL1H7vEHfAbM9F6Sd3CtjvP+cTQnw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mBu0ay5kQU+MocY1Sid2Lv9vqK+aCu9yOXo+pDEtMJFLDrXLMsNajMe+vaOO/Dm5pzcN3sqFtyeH23h1NCqtCZqdrRPxxfq3+uRITlPmRlyOWS9TXigg7xbq/oENo1g8TOAAPAMkIzh5wXnVkEcKNGiQRbPrDmPBhR8AdGgael0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d7ZM4aup; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d7ZM4aup"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1F471F00A3D;
	Mon, 10 Aug 2026 15:42:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786376572;
	bh=t2QybIpkDmMbwKt6nJDiEFi2R+Pf4wrn9YzH5aMwSoI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=d7ZM4aupJJxSR8s1Vq0+9z08dLhQzbD7uLlCalmdIPbtnM+/UMlSFDJ/QYFcW4ewr
	 S1fUXfabfrn7XlduA0H9JS5AdmnslpxS51RT6M7kKL4GsWLfKtPeZIHBie9mHI5/6Q
	 fG9U8MS5iFQ50czCeSJKnuED+OjXGmvpZe1j0LJ4w3kpdcEuSuNfKvj4ficogtvB3H
	 0sWxMIr4cOYDbPFxXzke0ttOrZNLbUHf5djzY3IScdmDWydxlQDLh0GoeK3BsVZ/jR
	 xfzvkITC6MKjwtDFPshzk6dTz6ghi1cX2YULHK1M6bdhg9YaBAxahk7Ec18b54weKL
	 xibUKSRItcDVQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/3] KVM: x86: ioapic: Preserve irr_delivered for
 duplicate edge interrupts
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hao Zhang" <hao_zhang_kdev@163.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <annsVk4_GaOGAzCL@192.168.1.215>
References: <annsVk4_GaOGAzCL@192.168.1.215>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 10 Aug 2026 15:42:51 +0000
Message-Id: <20260810154252.B1F471F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but changing an IOAP=
IC pin's trigger mode from edge-triggered to level-triggered via MMIO does =
not clear `irr_delivered`, causing subsequent level-triggered interrupts to=
 be masked and lost across live migration.
--

--- Patch [3]: [PATCH v3 3/3] KVM: x86: ioapic: Preserve irr_delivered for =
duplicate edge interrupts ---
commit 591f7b002947a1810eb5f06b6ab21c5e4d90fcae
Author: Hao Zhang <zhanghao1@kylinos.cn>

KVM: x86: ioapic: Preserve irr_delivered for duplicate edge interrupts

This commit moves the state update of irr_delivered after the duplicate edge
check in ioapic_set_irq() to prevent duplicate edge interrupts from leaving
the interrupt visible in the KVM_GET_IRQCHIP state. It also adds a selftest
to verify this behavior.

> diff --git a/arch/x86/kvm/ioapic.c b/arch/x86/kvm/ioapic.c
> index 24a7cc3b8b7ef..676effd674f9e 100644
> --- a/arch/x86/kvm/ioapic.c
> +++ b/arch/x86/kvm/ioapic.c
> @@ -230,11 +230,11 @@ static int ioapic_set_irq(struct kvm_ioapic *ioapic=
, unsigned int irq,
>  	old_irr =3D ioapic->irr;
>  	ioapic->irr |=3D mask;
>  	if (edge) {
> -		ioapic->irr_delivered &=3D ~mask;
>  		if (old_irr =3D=3D ioapic->irr) {
>  			ret =3D 0;
>  			goto out;
>  		}
> +		ioapic->irr_delivered &=3D ~mask;
>  	}

[Severity: High]
This is a pre-existing issue, but does changing an IOAPIC pin's trigger mode
from edge-triggered to level-triggered via MMIO leave a stale irr_delivered
bit?

If a guest configures a pin as edge-triggered, an interrupt sets the bit in
ioapic->irr_delivered. If the guest then reconfigures the pin to
level-triggered in ioapic_write_indirect(), the stale irr_delivered bit is
not cleared.

When a subsequent level interrupt is asserted, ioapic_set_irq() sets the irr
bit but skips clearing irr_delivered because the pin is now level-triggered
and edge is false.

During VM migration, kvm_get_ioapic() extracts the state:

	state->irr &=3D ~ioapic->irr_delivered;

Could this stale irr_delivered bit incorrectly mask out the pending level
interrupt and permanently lose it across live migration?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/annqlqBOOGIQJ7sY@19=
2.168.1.215?part=3D3
