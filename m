Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BDF835F162
	for <kvm@vger.kernel.org>; Tue, 14 Jul 2026 01:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783993046; cv=none; b=P/grLDywDxVagFC5C5v2IZf4o01+MWtfaUqHhubVVsqZlGgvQk93sXP9zwi0F9UD08MABRkQwUGN57QnFl9X4jknMKVpsPDNnLJstIdxXkRZA/due9pxzN8urdQnYs70oXc2a457lfGHzwCWqGPkeMskTkXA2Lho+VQJm/6rUHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783993046; c=relaxed/simple;
	bh=VlrykwRJWQD77Sg/xgxE8ea29epMXn9QBXNpAO1TmSs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=oIOQeIYuUeWLIdMMpIO+DroaT60q8u9tYfl02WNxJ8lpZznTUEWRuRIVDTRB52g8doDReW/N42I0Ng8JjilJMccx4fKqWUE+CLFxV+McTXzbEkp5PM7pp3DgdRGxFbrbiGsc/Vi9qdea1FpIs4zirqgtt9WTM2oe9CHoreb7LsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kHpVDQs+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kHpVDQs+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D6271F000E9;
	Tue, 14 Jul 2026 01:37:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783993045;
	bh=kZjsSi/UzUwsoDG4yN9as5Fb3Y+6WlGQR2a7qTkxj+w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kHpVDQs+WKVZ6v2J/om+s7cvv5VC1hX1vNnkRgSGMriVPupvpOWpQeRBXBcs7NKYm
	 VYhlGccrfLPSkceaJ7rJoGxgv2lC3EgnW/u7dZQut3xmLoggLyfAuVABGUjTljCWUm
	 hjBtXHj7awXwZaj3tbVzwTWT3cQvqzlObb36UPSgO8Hmzh5GkL6f/KDo3hHhYbSIqF
	 Sz0RYoDczkhK00Fp5Fd26Sv1shNzyO5bpyNKGsNFkgU7x8WPkLeYYAh7A7TZEWlmMO
	 WSNeCvPqVu/8cAN483RppPsJieqIYaOrnLYM2HGwv8ahNYYrfN8BbPn5qenFgpgWwU
	 2G3Y2cNqYFn0Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] LoongArch: KVM: EIOINTC: factor IP-number decode
 into a helper
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tao Cui" <cui.tao@linux.dev>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260714012452.1021833-3-cui.tao@linux.dev>
References: <20260714012452.1021833-1-cui.tao@linux.dev>
 <20260714012452.1021833-3-cui.tao@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 01:37:24 +0000
Message-Id: <20260714013725.0D6271F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Missing bounds check on untrusted guest-controlled MSI data (`=
e->msi.data`) allows out-of-bounds array accesses and arbitrary host memory=
 corruption.
--

--- Patch [2]: [PATCH 2/2] LoongArch: KVM: EIOINTC: factor IP-number decode=
 into a helper ---
commit 819d482a674f6e7813eb24d40a7c6711789b26a8
Author: Tao Cui <cuitao@kylinos.cn>

LoongArch: KVM: EIOINTC: factor IP-number decode into a helper

This commit factors the ipmap IP-number decoding logic, which was previously
duplicated in eiointc_set_sw_coreisr() and eiointc_update_irq(), into a new
helper function named eiointc_get_ipnum().

> diff --git a/arch/loongarch/kvm/intc/eiointc.c b/arch/loongarch/kvm/intc/=
eiointc.c
> index 0c34d7ab264dc..c1e0cd8dca16c 100644
> --- a/arch/loongarch/kvm/intc/eiointc.c
> +++ b/arch/loongarch/kvm/intc/eiointc.c
> @@ -7,19 +7,27 @@
>  #include <asm/kvm_vcpu.h>
>  #include <linux/count_zeros.h>
> =20
> +static int eiointc_get_ipnum(struct loongarch_eiointc *s, int irq)
> +{
> +	int ipnum =3D (s->ipmap >> (irq / 32 * 8)) & 0xff;

[Severity: Critical]
This is a pre-existing issue, but does this bit shift result in undefined
behavior if an out-of-bounds irq is provided?

If a malicious guest or userspace provides an unvalidated MSI data payload,
it is passed as the irq parameter through the following call chain:

kvm_send_userspace_msi() -> kvm_set_msi() -> pch_msi_set_irq()

pch_msi_set_irq() {
    ...
    eiointc_set_irq(kvm->arch.eiointc, e->msi.data, level);
}

The unvalidated irq is used in the bit shift above, and also leads to
out-of-bounds array reads in eiointc_update_irq():

    cpu =3D s->sw_coremap[irq];

Could this also allow arbitrary host memory corruption when setting bits in
eiointc_set_irq() since isr is bounded to EIOINTC_IRQS?

    level ? __set_bit(irq, isr) : __clear_bit(irq, isr);

> +
> +	if (!(s->status & BIT(EIOINTC_ENABLE_INT_ENCODE))) {
> +		ipnum =3D count_trailing_zeros(ipnum);

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260714012452.1021=
833-1-cui.tao@linux.dev?part=3D2
