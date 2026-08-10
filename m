Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CD6B2FBE
	for <kvm@vger.kernel.org>; Mon, 10 Aug 2026 01:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786325628; cv=none; b=iDTU4hDM0ThpQIK315uIHgRlCs+ntGepj0ViAB7quRxtahZehHvIlM4Z5zC7W401ook9i835zQOowEM/EzU2osPZAmmYPNmEzqWwkNRV8D6UuxEIk4i/AmsTnuZGY6uSGAHnJfK3KFR8yjmf2/9fmGejpUzaZKu4/IM88O5a13A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786325628; c=relaxed/simple;
	bh=pOocq8y3uGqYZvpwfMZ7TYgecjxKJJtfVJqAtxTH4Vc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=i9ClXP0UK2G7CcJjI0PT3rvmDCQdUzwMlFzmx+QGj7xy4F6rd8M9hP2vW6+9kAQZJXxzBR7kOr9TXBkS4WKKlS5kkH2eCHg1vs15NemgILb7D2MrQ1O2pNuelWWPQFa5m/WQFt2yBQRQtvGoQ0OcNa+W4bkUVxJUE27KjO5vuCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fITsH6Ml; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fITsH6Ml"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76E231F000E9;
	Mon, 10 Aug 2026 01:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786325626;
	bh=0PnfD3RGOHu3qlEKHuaYfSerujhBCQa9X2A1ESqiEMk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fITsH6MlONEe0GtMMA2JCaUcZkMzAuT0+zsaHd7Ap1gmmCTCcvkGN2dcJ0C4bqv7E
	 UcskqrgyBC9GTkQp3+ObY3HxrucEtFTmFM/GuvDL/ubwHSCMCvD9T0WOrArX1gsu62
	 ui9Pty3BAo2If5hBYPpfimT6uq4ygHdEeKsv5u84AIqPc/ydXBfGIxD8z6SVFJVKmt
	 Uxx/mdAp3beZCq787Pr93vOSpC802g+ub3JV3inpOpHuz21KK2+yst4JsB2IXg43xO
	 qm2sbLmzI5QP2h3WqGIJQ0bMTT34mJt0LyRW6z4ISzmYT68h3JAlcNp6NS1Xb5Eqk5
	 5oxhTFpOGkv0Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] RISC-V: KVM: Serialize IMSIC attributes with vCPU
 migration
Reply-To: sashiko-reviews@lists.linux.dev
To: "Xie Bo" <xb@ultrarisc.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260810-imsic-attr-race-v2-1-00ed95ad321e@ultrarisc.com>
References: <20260721073612.137259-1-xb@ultrarisc.com>
 <20260810-imsic-attr-race-v2-1-00ed95ad321e@ultrarisc.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 10 Aug 2026 01:33:45 +0000
Message-Id: <20260810013346.76E231F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Silent loss of attribute writes due to un-serialized CPU hot-unplu=
g. The patch relies on `vcpu->mutex` to protect the VS-file, but `kvm_riscv=
_aia_disable()` bypasses this mutex during CPU offline.
--

--- Patch [1]: [PATCH v2] RISC-V: KVM: Serialize IMSIC attributes with vCPU=
 migration ---
commit 27600b866db246ae439be14c51b6bb1e480a817e
Author: Xie Bo <xb@ultrarisc.com>

RISC-V: KVM: Serialize IMSIC attributes with vCPU migration

This commit serializes KVM device ioctls for IMSIC attributes against
KVM_RUN by acquiring the target vCPU mutex in kvm_riscv_aia_imsic_rw_attr().
This aims to prevent the VS-file from being migrated and recycled while
the attribute is being accessed.

Link: https://lore.kernel.org/r/20260721073612.137259-1-xb@ultrarisc.com

> diff --git a/arch/riscv/kvm/aia_imsic.c b/arch/riscv/kvm/aia_imsic.c
> --- a/arch/riscv/kvm/aia_imsic.c
> +++ b/arch/riscv/kvm/aia_imsic.c

[ ... ]

> @@ -995,6 +1000,8 @@ int kvm_riscv_aia_imsic_rw_attr(struct kvm *kvm, uns=
igned long type,
>  		rc =3D imsic_vsfile_rw(vsfile_hgei, vsfile_cpu, imsic->nr_eix,
>  				     isel, write, val);

[Severity: High]
This is a pre-existing issue, but does relying on vcpu->mutex here leave a
race window with CPU hot-unplug?

If a concurrent KVM_SET_DEVICE_ATTR resolves the hardware HGEI and drops
imsic->vsfile_lock, couldn't a simultaneous CPU hot-unplug event cause
kvm_riscv_aia_disable() to run on the offlining CPU?

Looking at the CPU offline path in arch/riscv/kvm/aia.c:

kvm_riscv_aia_disable() {
    ...
    /* Notify IMSIC */
    kvm_riscv_vcpu_aia_imsic_release(vcpu);
    ...
}

This bypasses vcpu->mutex, locklessly flushes the vCPU's HGEI to the SW
file, and frees the HGEI.

If that happens before the IPI is sent in imsic_vsfile_rw(), would we end up
modifying the freed hardware HGEI instead of the SW file, or failing to send
the IPI entirely if the CPU goes fully offline?

Could this result in silently losing attribute updates during live migratio=
n?

> +out_unlock:
> +	mutex_unlock(&vcpu->mutex);
>  	return rc;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260810-imsic-attr=
-race-v2-1-00ed95ad321e@ultrarisc.com?part=3D1
