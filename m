Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A88402B87
	for <kvm@vger.kernel.org>; Wed, 12 Aug 2026 08:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786524751; cv=none; b=W7rOcxMDW8PR2KGKhbTb844rGxGmFa07xRO5JnLhMyWikE6IC9KxHdiPkse5YxNCl/9AR/46AKu4DOzDV1ePnqZ+roleTUe43xrGIQyJdnMSVyFJ5qOVUEpGKvoCxdxaCel8DPEfxk8SaMr9Xq0HGs1v196PsxAQQFmObTqm4R0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786524751; c=relaxed/simple;
	bh=zE2tbfKe2hnjtVnx64JpiE30lZRJpIDE13x2mX5tr0s=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=q08+jQGMA3fvq8VaRMjXCEVLSrvbIKO42f4xpmPo23gHZwo3gchs3jtOmecvNV6nXNkyr8HhPccZzTD+pwpIiSQZUS2WaXGplr4NooAbIBQ9p4xAUx6wEia3QJ/jkdR+Rv1T1DcawHMyHdWiIAvVbhuUPHJDEyUbGotZgI7xWRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hmaebmJv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hmaebmJv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EA541F000E9;
	Wed, 12 Aug 2026 08:52:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786524749;
	bh=d1G/PQ7aGjC1ctKY1CV/rLqQ7lwqCl/imrcgjybVfwE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hmaebmJvXk9W5wPtMTenS0xtiHmuJ7NuEfZlWg+ObXrgokHp09V8A3FBhEyAAOGng
	 k+c+byHWDbkwJSLj1/mWC3I1Fsnlx1E0NfboBR+LAt7WblNy9zbAKH4MEmghA6uZdk
	 keyubQrV3t8Hjnt4H/LWnt9HQ9nmagZYScdGhKCLrm3Px5b8Tq9D3Z29n52T8aYTPi
	 oRUyNs7IolrB36vYLd6kOukArqVJSFvoRXnqhBS/Yh6v6VSMjAXAQ+BoAXOBjdFCPz
	 uDefVr6j+fstBfDI4Jq8bHMg89OrdpJEMEEHrNIc2fh0gx7gvZgklvcsdmGl15CkTf
	 pKBU8aK4eQUCw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 3/6] KVM: x86: ioapic: Preserve irr_delivered for
 duplicate edge interrupts
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hao Zhang" <hao_zhang_kdev@163.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <anwwV80QWHxemrWS@192.168.1.215>
References: <anwwV80QWHxemrWS@192.168.1.215>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 08:52:28 +0000
Message-Id: <20260812085229.4EA541F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] KVM's IOAPIC fails to latch edge-triggered interrupts if they puls=
e while the pin is masked, and fails to deliver latched edge-triggered inte=
rrupts upon unmasking.
--

--- Patch [3]: [PATCH v5 3/6] KVM: x86: ioapic: Preserve irr_delivered for =
duplicate edge interrupts ---
commit 691f4f74cce4e2c3436bc9f3cdf594c985c284e3
Author: Hao Zhang <zhanghao1@kylinos.cn>

KVM: x86: ioapic: Preserve irr_delivered for duplicate edge interrupts

For edge-triggered interrupts, ioapic_set_irq() clears irr_delivered before
checking whether the new edge is a duplicate. This patch moves the state
update after the duplicate-edge check to prevent duplicate edges from making
a delivered interrupt appear pending during VM migration.

> diff --git a/arch/x86/kvm/ioapic.c b/arch/x86/kvm/ioapic.c
> index 24a7cc3b8b7ef..676effd674f9e 100644
> --- a/arch/x86/kvm/ioapic.c
> +++ b/arch/x86/kvm/ioapic.c
> @@ -230,11 +230,11 @@ static int ioapic_set_irq(struct kvm_ioapic *ioapic=
, unsigned int irq,

[Severity: High]
This isn't a bug introduced by this patch, but while reviewing
ioapic_set_irq(), does KVM fail to latch edge-triggered interrupts if they
pulse while the pin is masked?

Earlier in ioapic_set_irq(), the IRR bit is cleared unconditionally when the
pin goes low:

	if (!irq_level) {
		ioapic->irr &=3D ~mask;
		ret =3D 1;
		goto out;
	}

This appears to destroy the latch state for edge-triggered interrupts that
were not yet delivered.

Furthermore, looking at ioapic_write_indirect(), when unmasking, pending
interrupt injection is restricted only to level-triggered interrupts:

		if (e->fields.trig_mode =3D=3D IOAPIC_LEVEL_TRIG &&
		    ioapic->irr & (1 << index) && !e->fields.mask && !e->fields.remote_ir=
r) {

Could this sequence cause latched edge-triggered interrupts to be silently
ignored and lost if a guest temporarily masks IOAPIC pins during interrupt
handling?

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
> =20
>  	ret =3D ioapic_service(ioapic, irq, line_status);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/anwugm-oU0v1VM-t@19=
2.168.1.215?part=3D3
