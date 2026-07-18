Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 234E3190462
	for <kvm@vger.kernel.org>; Sat, 18 Jul 2026 04:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784350104; cv=none; b=JHzZWsE15Jr/cQ+ohMUeWHtys1phL9S2PvGS/OPGYTy77b6IDyijx46oI8GQZRx1QEjN0zO7BLAeQHO9SH222vZswLyQ2GWj4CXukoRixtAp62znuCNO50Sbjn3mPFtNRoLO3wzO8qpjqK8EkZ8KjsXvXFw03NCKpHA6AE5LgnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784350104; c=relaxed/simple;
	bh=uEE2S+7tduJBT1m5jAfbWSkoKq9ufS5IbtHQ8T+6tWI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mPj4Gbf4y4fQNvclbWuLKaiGh8abqMaHH+uFBBviFDIDRsZ1K+H4t57auwp8TnSl5hPQ/ju24dWTbxOVezpV2F+KQFpoyBGGiw9o+8xlXgnmER6dFYliHWpmmQwHBWwRm3Hlzi+BOBJmYO8HL6His9EjoGEHFwszV+vJM8SKxC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A0y6FAze; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A0y6FAze"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 792B11F000E9;
	Sat, 18 Jul 2026 04:48:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784350102;
	bh=C8dpV5CvK7iP8m9Rq73Ozodr0ITu/uSF5aDfmTjmkPI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=A0y6FAzevu98nYD1CBn9djyWnoJlcBXl5ri9wlS7vMn5MptNKTZtF5/nIRNqjJUwo
	 zaNfCdYrCHItFgllKi8+sbuvPgyRRSvo3uogrELGrdVNq/MC2gfrBYJaHMyfYauM1O
	 7Wh9icvue1YH3+t0yjC3aBgVrZtgvYgdeJMtm/8qW/+wpkYU72+qclseU6jihva9IE
	 0mQU1Aa0jVDnAjXEzJY71Y5GtfeDLGLQ0xvxXWEwLwjUOMO/sw7Ev/thKOWoai1aLs
	 Lcf7LmVKCuvCrxVhSfi2/qOnS0EMB7Er2vuEM/wiA/dTmCcTDO+Q+tcMETnNHDZasf
	 DTyOGyUyuWPLQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] RISC-V: KVM: Reject overlapping AIA IMSIC address
 fields
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pengpeng Hou" <pengpeng@iscas.ac.cn>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260718040000.005.6ede2881-caplitmus-rv@iscas.ac.cn>
References: <20260718040000.005.6ede2881-caplitmus-rv@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 18 Jul 2026 04:48:22 +0000
Message-Id: <20260718044822.792B11F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Cross-VM state corruption via TOCTOU in KVM_DEV_RISCV_AIA_GRP_=
IMSIC device attribute handling.
--

--- Patch [1]: [PATCH] RISC-V: KVM: Reject overlapping AIA IMSIC address fi=
elds ---
commit 0b0c0711466532b5918ed0373b83ed94930f6c86
Author: Pengpeng Hou <pengpeng@iscas.ac.cn>

RISC-V: KVM: Reject overlapping AIA IMSIC address fields

This commit fixes an issue where overlapping IMSIC configuration fields cou=
ld
give a single address bit two different meanings. It adds a check during
initialization to reject group-index layouts that overlap with the guest and
HART index bits.

> diff --git a/arch/riscv/kvm/aia_device.c b/arch/riscv/kvm/aia_device.c
> index b195a93add1ce..d0262ed3c0225 100644
> --- a/arch/riscv/kvm/aia_device.c
> +++ b/arch/riscv/kvm/aia_device.c
> @@ -244,6 +244,12 @@ static int aia_init(struct kvm *kvm)
>  	if (aia->nr_sources && aia->aplic_addr =3D=3D KVM_RISCV_AIA_UNDEF_ADDR)
>  		return -EINVAL;
> =20
> +	/* Group index bits must not overlap guest and HART index bits. */
> +	if (aia->nr_group_bits &&
> +	    aia->nr_group_shift < IMSIC_MMIO_PAGE_SHIFT +
> +					  aia->nr_guest_bits + aia->nr_hart_bits)
> +		return -EINVAL;
> +

[Severity: High]
This is a pre-existing issue, but is there a race window here that could
corrupt cross-VM state?

Looking at kvm_riscv_aia_imsic_rw_attr() in arch/riscv/kvm/aia_imsic.c, the
vsfile_lock is dropped before the IPI is sent:

	read_unlock_irqrestore(&imsic->vsfile_lock, flags);

	if (!rc && vsfile_cpu >=3D 0)
		rc =3D imsic_vsfile_rw(vsfile_hgei, vsfile_cpu, imsic->nr_eix,
				     isel, write, val);

If the target VCPU migrates to another physical CPU concurrently, could the
VCPU thread executing kvm_riscv_vcpu_aia_imsic_update() free the vsfile_hgei
and reassign it to a different VM?

A delayed IPI from imsic_vsfile_rw() would then execute on the original CPU
in imsic_vsfile_local_rw():

	new_hstatus |=3D ((unsigned long)idata->hgei) << HSTATUS_VGEIN_SHIFT;
	csr_write(CSR_HSTATUS, new_hstatus);

Does this locally modify the hardware state without verifying if the target
VCPU still owns it?

>  	/* Initialize APLIC */
>  	ret =3D kvm_riscv_aia_aplic_init(kvm);
>  	if (ret)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260718040000.005.=
6ede2881-caplitmus-rv@iscas.ac.cn?part=3D1
