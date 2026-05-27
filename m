Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC9A1A5B9E
	for <kvm@vger.kernel.org>; Wed, 27 May 2026 06:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779862813; cv=none; b=KYy7SWL6IMBEsQTECojmwi5hVjKuMUFI1iHKAu09sazH3hfvIFAVyJMYujrhAWJcpI/qUGmw+8DpQIjTJDgiUj45iSqCfCGff45A5xTes0nPGPPKrsvGbbV/xA3TzpLNlkWuFddW8qQ8y5++gp5pqkTrAtqkNn3yvD+BnHwImL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779862813; c=relaxed/simple;
	bh=NAZwaIJkrOGm7VNZq25KVgZK+0hsP23dRBeMlH14Z8U=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iWAr79So/+6UgefaN42jItg6Li5bW2i+rgv47FuQdUeD1oZ1fw/Y4YjJSwioX1L5LYDe3K/a6UaY7QM6FTSzr/fSfT9HPRL3GWDABC/LwZ9gk9MWMSZ5LTqp7I3M0YiDKGV4jxY6qa/nkT0O/EtDCBygbDNWe1OfgOnwALAqQdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RWjhpMAx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RWjhpMAx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B667A1F000E9;
	Wed, 27 May 2026 06:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779862805;
	bh=AYEIfGZPlU34T6zoQr+uwzzxoUc6uAS2TPVpWS2WFQ8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RWjhpMAx9+H8NuAPktFnFyYiT2Tp18wsK4tdLlkWB6O+Qp64zyR0+zQ912uz+GzC+
	 omQqFTpG6uEgNpNqvd7r3iRjMbFDnnHDZlRqG166Bq9IP0i+fYBGG+ZywaRQ2qa3h8
	 +UTfW+4g5ktmteaK4+C7HrgL8y4mjGxFe0MKr1sYH+KwcDVegF4ZZ2s3ylvTiiIVVF
	 2jIYcSBg4osiRKCfgIeCj+A78VtznGnujBoMbKMJjjfreF29xZAx2WmQExbGbQ+U9O
	 +LmCvzLsP/ULKiVPzgm28wgyZ276ZRAjmpWP2WKa6tbNlUdaI7+6YECjb19TR4LbSH
	 A/fBduzFgakbQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/3] KVM: RISC-V: SBI FWFT: Fix stale feature
 exposure after runtime extension changes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yong-Xuan Wang" <yongxuan.wang@sifive.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260526-kvm-get_reg_list-v2-v2-1-7940a401454a@sifive.com>
References: <20260526-kvm-get_reg_list-v2-v2-1-7940a401454a@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 27 May 2026 06:20:05 +0000
Message-Id: <20260527062005.B667A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] The removal of the `!tconf->enabled` check allows guests to access=
 and manipulate FWFT features that userspace explicitly disabled.
- [High] Dynamically evaluating `feature->supported(vcpu)` during guest SBI=
 calls or ONE_REG ioctls corrupts the running hardware state.
--

commit 1795bfc5a03de0367e3bbad5e0256579be467a29
Author: Yong-Xuan Wang <yongxuan.wang@sifive.com>

KVM: RISC-V: SBI FWFT: Fix stale feature exposure after runtime extension c=
hanges

This commit updates the RISC-V KVM SBI FWFT implementation to determine
feature availability dynamically at runtime rather than relying on an
initialization-time snapshot. It replaces checks against a static 'supporte=
d'
field with calls to the feature's supported() callback.

> diff --git a/arch/riscv/kvm/vcpu_sbi_fwft.c b/arch/riscv/kvm/vcpu_sbi_fwf=
t.c
> index 2eab15339694f..d3be059c38223 100644
> --- a/arch/riscv/kvm/vcpu_sbi_fwft.c
> +++ b/arch/riscv/kvm/vcpu_sbi_fwft.c
> @@ -279,8 +279,8 @@ static int kvm_fwft_get_feature(struct kvm_vcpu *vcpu=
, u32 feature,
>  		return SBI_ERR_DENIED;
>  	}
> =20
> -	if (!tconf->supported || !tconf->enabled)
> -		return SBI_ERR_NOT_SUPPORTED;
> +	if (!tconf->feature->supported(vcpu))
> +		return  SBI_ERR_NOT_SUPPORTED;

[Severity: High]
Does the removal of the !tconf->enabled check allow guests to access and
manipulate FWFT features that userspace has explicitly disabled?

The enabled field is used by the VMM to explicitly mask specific features
for the guest via the KVM ONE_REG API. By omitting this check here, a guest
could successfully issue SBI_EXT_FWFT_SET and SBI_EXT_FWFT_GET calls to
configure any feature supported by the underlying hardware, completely
bypassing the VMM's security and feature masking policies.

[Severity: High]
Does evaluating feature->supported(vcpu) dynamically during guest SBI calls
corrupt the running hardware state?

The SBI_FWFT_POINTER_MASKING_PMLEN feature's supported callback invokes
try_to_set_pmm(), which probes the hardware by executing csr_set and
csr_read_clear on the physical CSR_HENVCFG register.

When triggered by a guest SBI call, this directly clears the ENVCFG_PMM bits
in the active hardware CSR. Because SBI calls execute in the in-kernel fast
path without a full vcpu_put()/vcpu_load() cycle, KVM resumes the guest
without restoring CSR_HENVCFG, silently disabling pointer masking for the
running guest.

[ ... ]

> @@ -428,7 +427,7 @@ static int kvm_sbi_ext_fwft_get_reg_id(struct kvm_vcp=
u *vcpu, int index, u64 *re
>  			continue;
> =20
>  		conf =3D kvm_sbi_fwft_get_config(vcpu, feature->id);
> -		if (!conf || !conf->supported)
> +		if (!conf || !feature->supported(vcpu))
>  			continue;

[Severity: High]
Can this also corrupt the physical host CPU state when called from a ONE_REG
ioctl?

Similar to the SBI call path above, evaluating feature->supported(vcpu) here
invokes the hardware probing logic. If triggered via a ONE_REG ioctl from
userspace, it would corrupt the CSR_HENVCFG register of the physical host
CPU executing the ioctl thread.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260526-kvm-get_re=
g_list-v2-v2-0-7940a401454a@sifive.com?part=3D1
