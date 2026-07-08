Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E1637E2E2
	for <kvm@vger.kernel.org>; Wed,  8 Jul 2026 23:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783553623; cv=none; b=bVzc/uyBLjhV9erBivVx5pkxHsCltVkXBnza/dwaH92xEzmaVnDXtymkflrqFtFZgmb7idJvnws7TfMqXJZDJlB7bp4bqLE8C5TLF+ypTXBYCghoDN8+N9qQa6J53NE1P3IuhljnCIhHpwQkys6YjjkjX2rp1C684r99DhA3F5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783553623; c=relaxed/simple;
	bh=gwETLKlzcxxCJPxUpV8wQyRBlJfgMBGBoOF2JsIzNlo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=L3fnSxr2Dxq6Ap8d91/CmVO7Kgj90JNAwmTslJfhnxpYtYg4IYq1tRIb551X251XWcOb07rRyqKpk9yrjf7spP/Ia3xxOPTY2l8voj8pSXpyZ3V0U0J0dnSfZXax0NlPsj16k++oI43QMF4CmukZuLWqJSqy5Yhu8xUTfMxlTHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UpTAjdKg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UpTAjdKg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5238F1F000E9;
	Wed,  8 Jul 2026 23:33:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783553621;
	bh=yXyhHJnkrfU0BLu6otfTwXDW4/+8XjLsYbxaLe3NBT0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UpTAjdKgqsDC19SQrq29soVlneWWCQxodc4rl/qQqsgYFDNusxMnJ13ytmYU7pblU
	 GCTl48jzXAbc2lw/q7KoFSDWduJIcdR5g3TRZT55s2QGDSJlKKK8WFt/6zp5c1izXn
	 +2GgcBX7g4KuSXfjHtBGn0rpxXiIxje22KePjRyo771TLAm5b1yNCW4a2A0FN2WNDq
	 KuTWZHpAImksjV1CCsJnpwF6PSOq5lX9ZWUpkwTifKzv2QWtIsMebm8xGX430LAIdi
	 aghs4Ai3nh6N4YF+fXUA7WH024QsfKY+MIrgBJzFhsvhL30Oe4S53+RHg8XJOfRvDr
	 rADfwidhgUhQw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 4/9] vfio: selftests: igb: Program MSI-X interrupt
 routing
Reply-To: sashiko-reviews@lists.linux.dev
To: "Josh Hilke" <jrhilke@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260708-igb_v3_b4-v3-4-1272650ca614@google.com>
References: <20260708-igb_v3_b4-v3-0-1272650ca614@google.com>
 <20260708-igb_v3_b4-v3-4-1272650ca614@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 23:33:40 +0000
Message-Id: <20260708233341.5238F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Commit message and implementation mismatch regarding macro defin=
itions.
- [Medium] Hardware Initialization Order: Unmasking interrupts before routi=
ng is configured.
--

--- Patch [4]: [PATCH v3 4/9] vfio: selftests: igb: Program MSI-X interrupt=
 routing ---
commit f99b27fd1b6bc3801803a7e5be3ec664facafb7a
Author: Alex Williamson <alex.williamson@nvidia.com>
Subject: vfio: selftests: igb: Program MSI-X interrupt routing

This commit updates the IGB selftest driver to use the full MSI-X programmi=
ng
sequence required by the 82576 hardware instead of relying on synchronous
QEMU workarounds. It configures auto-clear and auto-mask for vector 0 and
changes the EICR clear mechanism from read-to-clear to write-to-clear.

> Replace the magic '1' values written to EIMS/EIMC with IGB_EICR_VEC0,
> add the GPIE/EIAC/EIAM macros, and drop the wrong-valued IGB_GPIE_EIAME
> macro (the new definition lives next to IGB_GPIE_MULTIPLE_MSIX).

[Severity: Medium]
This isn't a bug in the code, but the commit message mentions introducing
custom macros like IGB_EICR_VEC0 and dropping IGB_GPIE_EIAME.

However, the implementation uses standard kernel definitions such as
E1000_EICR_RX_QUEUE0 and E1000_GPIE_MSIX_MODE.

Could the commit message be updated to match the actual code?

> diff --git a/tools/testing/selftests/vfio/lib/drivers/igb/igb.c b/tools/t=
esting/selftests/vfio/lib/drivers/igb/igb.c
> --- a/tools/testing/selftests/vfio/lib/drivers/igb/igb.c
> +++ b/tools/testing/selftests/vfio/lib/drivers/igb/igb.c

[ ... ]

> @@ -280,11 +280,32 @@ static void igb_init(struct vfio_pci_device *device)
>  	/* Enable MSI-X with 1 vector for the test */
>  	vfio_pci_msix_enable(device, MSIX_VECTOR, 1);
> =20
> -	/* Enable auto-masking of interrupts to avoid storms without a real ISR=
 */
> -	igb_write32(igb, E1000_GPIE, E1000_GPIE_EIAME);
> +	/*
> +	 * Program MSI-X interrupt routing per 82576 datasheet:
> +	 *
> +	 * GPIE (section 7.3.2.11, Table 7-47): set Multiple_MSIX (bit 4) to
> +	 * route interrupt causes through IVAR mapping, and EIAME (bit 30)
> +	 * to apply EIAM on MSI-X assertion (without EIAME, EIAM only
> +	 * applies on EICR read/write).
> +	 *
> +	 * EIAC (section 8.8.5): enable auto-clear of EICR for vector 0.
> +	 * Without auto-clear the cause stays set after delivery and the
> +	 * test can see spurious interrupts on the next memcpy batch.
> +	 *
> +	 * EIAM (section 8.8.6): enable auto-mask of EIMS for vector 0 on
> +	 * MSI-X assertion (effective because EIAME is set), so a single
> +	 * interrupt is delivered per memcpy batch even if the cause
> +	 * re-asserts before software re-enables the mask.
> +	 *
> +	 * IVAR (section 7.3.1.2, register definition in 8.8.13): map RX
> +	 * cause 0 to MSI-X vector 0 and mark the entry valid.
> +	 */
> +	igb_write32(igb, E1000_GPIE, E1000_GPIE_MSIX_MODE | E1000_GPIE_EIAME);
> +	igb_write32(igb, E1000_EIAC, E1000_EICR_RX_QUEUE0);
> +	igb_write32(igb, E1000_EIAM, E1000_EICR_RX_QUEUE0);
> =20
>  	/* Enable interrupts on vector 0 */
> -	igb_write32(igb, E1000_EIMS, 1);
> +	igb_write32(igb, E1000_EIMS, E1000_EICR_RX_QUEUE0);
> =20
>  	/* Map vector 0 to interrupt cause 0 and mark it valid */
>  	igb_write32(igb, E1000_IVAR0, E1000_IVAR_VALID);

[Severity: Medium]
Does unmasking the interrupt via E1000_EIMS before programming the routing
in E1000_IVAR0 risk unpredictable behavior?

If an interrupt condition is met in the small window between these writes, =
it
seems an interrupt could be triggered before the IVAR mapping is valid.

Should the mapping in IVAR0 be established before unmasking the interrupt?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260708-igb_v3_b4-=
v3-0-1272650ca614@google.com?part=3D4
