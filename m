Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F041E38F25F
	for <kvm@vger.kernel.org>; Mon, 10 Aug 2026 06:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786344322; cv=none; b=MDnizWTSj7LqtLJhPJ0hlC0juN3e9tPgFmNv6amNO5X6ut7ZMuQYaj7d8VOjcrcVyDEwAWkYUVdrXq/ybzh2Yfjs1XXtPzDO/HkNHf81SyypaTaw4VAho7ESwFTXixmwcq3zKdLKj2NBQlbg9cs2X3vW5IdmnziMeONdnQxgDrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786344322; c=relaxed/simple;
	bh=ii3fveW4yTOqs6pRLul+WSJUQsAbIZZmq671yhIZMCo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gdfH9ya/XM3I+0Ar2SLdwLJntrwO7Cp1N/DeZX59WU3tXg9HmSbkgHnI23BywSJWyiMzVvC05wcJ6KFIkAmEHt/CbTtUGH3nzRbPjUwZZzbY965LC7raunSvmtbuPo2BQrJn1RxGpiYRuw2lywQ8kxV1HF11QQxSAZdMi4GLiVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bhPUPNlL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bhPUPNlL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 224FD1F00A3A;
	Mon, 10 Aug 2026 06:45:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786344320;
	bh=IpX+Gf6qsuvIL18//qL+vnFv6i3B9g4XxkxJOs0ZzPg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bhPUPNlLaQh2P/dthzp6lt4zimPi5Btgot2p+MwEDRaoeX7kIOA7cP0gOuuM21Lnu
	 OilJ3pJBaY7fI7OXuKrRbfspOP6bKpAdpWdWewgaWD2/4xL7W1S+E149SB/lRzuTfm
	 8BqaKSG+gdFHvoKN07gXQ5r+LeXy3JO3UEacpg8f19wPzqMuFJgSITTwP/TC3quuV8
	 1jkPYbhfuhqVEcgaqHAc9FwXydMJuwpAO842scNxlc3wdg3nXDpVjkymcugmBo/dTl
	 ZrHOOQ8cgV2sSi/hBpp+/tgRVkFF+UcSBdIxLzKxFeeNfe9uBcSU8qNb+MLhisf9Lt
	 zYxpxFuc9GjHw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] KVM: x86: ioapic: Update state only after
 successful delivery
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hao Zhang" <hao_zhang_kdev@163.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <anls-aUppuiFolpS@192.168.1.215>
References: <anls-aUppuiFolpS@192.168.1.215>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 10 Aug 2026 06:45:19 +0000
Message-Id: <20260810064520.224FD1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Clearing `irr_delivered` for duplicate edge interrupts causes spur=
ious injections upon VM migration.
--

--- Patch [1]: [PATCH 1/2] KVM: x86: ioapic: Update state only after succes=
sful delivery ---
commit 709ff05e7e6d1df68c0523d442968791b55f37d1
Author: Hao Zhang <zhanghao1@kylinos.cn>

KVM: x86: ioapic: Update state only after successful delivery

This commit defers updating I/O APIC delivery state until interrupt
delivery actually succeeds. It ensures level-triggered pins aren't blocked
forever on a failed delivery and edge-triggered interrupts aren't incorrect=
ly
dropped from the saved IRR state.

> diff --git a/arch/x86/kvm/ioapic.c b/arch/x86/kvm/ioapic.c
> index 757667fb2bfa0..540e5665fbe4f 100644
> --- a/arch/x86/kvm/ioapic.c
> +++ b/arch/x86/kvm/ioapic.c

[ ... ]

> @@ -491,8 +488,12 @@ static int ioapic_service(struct kvm_ioapic *ioapic,=
 int irq, bool line_status)
>  	} else
>  		ret =3D kvm_irq_delivery_to_apic(ioapic->kvm, NULL, &irqe);
> =20
> -	if (ret && irqe.trig_mode =3D=3D IOAPIC_LEVEL_TRIG)
> -		entry->fields.remote_irr =3D 1;
> +	if (ret > 0) {
> +		if (irqe.trig_mode =3D=3D IOAPIC_EDGE_TRIG)
> +			ioapic->irr_delivered |=3D 1 << irq;
> +		else if (irqe.trig_mode =3D=3D IOAPIC_LEVEL_TRIG)
> +			entry->fields.remote_irr =3D 1;
> +	}

[Severity: High]
This isn't a bug introduced by this patch, but while looking at irr_deliver=
ed
tracking, does ioapic_set_irq() have an issue with duplicate edge interrupt=
s?

If a device emulator calls KVM_IRQ_LINE multiple times for an edge-triggered
interrupt without an intervening level=3D0, the first call delivers the
interrupt and sets irr_delivered here in ioapic_service().

However, on subsequent calls, ioapic_set_irq() does this:

arch/x86/kvm/ioapic.c:ioapic_set_irq() {
	...
	old_irr =3D ioapic->irr;
	ioapic->irr |=3D mask;
	if (edge) {
		ioapic->irr_delivered &=3D ~mask;
		if (old_irr =3D=3D ioapic->irr) {
			ret =3D 0;
			goto out;
		}
	}
	...
}

It unsets irr_delivered but then detects the duplicate edge and returns ear=
ly.

Could this leave irr_delivered incorrectly cleared?

If a VM migration occurs after this, KVM_GET_IRQCHIP might read the interru=
pt
as pending instead of delivered.

Would this cause a spurious injection on the destination?

> =20
>  	return ret;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/anls-aUppuiFolpS@19=
2.168.1.215?part=3D1
