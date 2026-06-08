Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 200D933F5B0
	for <kvm@vger.kernel.org>; Mon,  8 Jun 2026 23:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780962014; cv=none; b=LqxcYHex6dPfOdFESqRjGNmkRpGhyMUbu8HK7ULcDmK9cg/wryvWzmI4lA5994VSwRqehrb52tc2dOzogedWqrXwPJhRiudRL45ry54sf7fI0h7/tY0A+XeRSDjWJ0dRuYWGrB0snJFH+pagBWhHO5YTFw5jd/RQAtKbF1P+/Iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780962014; c=relaxed/simple;
	bh=If/lZ0LLJGOA1v7cSkc88/sDVgWUfW8qvbqQ72xeYyU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZC4i5kqysFyb0bGicVTlgTnsMpTzCbi11z5YcqO1J7YsNWnUhwza/yFSdD9eJsjScKvT9jfyfJ3SIZnk41WytX3OAeCvQoYLXLuZc2SjB4wxKP0sIFCKfatQezrwHBUY4mjPw4tEt1FbbSL2Sfxh7OaPnVvpaRAll9c7P/bBq1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kQ/AX3pB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kQ/AX3pB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23A6F1F00893;
	Mon,  8 Jun 2026 23:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780962012;
	bh=nCBFYzp8gI9tQnez85OgRqDg7ruRqQ65Zyf9rvgo3ig=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kQ/AX3pBzzMO0b8Hgz4baBluYeXkNVCrrbZUlpGXYus1xDV+xVV6DsM9vgEZGaLHx
	 eJS6E9uyxFNvNtzY7op8DhT/vn1+AMfp1si9Yp9aV6+PAG6waix3neLNcqwvG8Jder
	 Z1dSckT5Kl/6ZLHRSCFCcWJD2mrZiCp94WpzePhyLhKF3rVy9ixPbyeXwXRIk3RMuv
	 P5UN8X/8cNw5O7Sqag+UkK7K6CBZwOFMMQiYT4CdzSQw7PvtA2uF16FVAqkF8hjU8+
	 RAVNaMG1dcX3jY/RTk3pJO1eEHYO0sk0LlHPBRRA1jDvF6rHgVNesYS4eJoackpOHu
	 9rFYowAYTC/CA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 60/60] kvm: svm: Advertise full multi-VMPL support to
 the SNP guest
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260608144252.351443-61-joro@8bytes.org>
References: <20260608144252.351443-61-joro@8bytes.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Jun 2026 23:40:11 +0000
Message-Id: <20260608234012.23A6F1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The patch unconditionally advertises the new GHCB_HV_FT_SNP_MULTI_=
VMPL feature to guests without userspace enumeration or control, violating =
KVM invariants.
--

commit 885b4d7d907e2c3c684356fd3142ddc49a702d2c
Author: Tom Lendacky <thomas.lendacky@amd.com>

kvm: svm: Advertise full multi-VMPL support to the SNP guest

This commit updates the GHCB hypervisor features bitmap to include the
GHCB_HV_FT_SNP_MULTI_VMPL flag. It indicates to the guest that full
multi-VMPL support is available.

> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> --- a/arch/x86/kvm/svm/sev.c
> +++ b/arch/x86/kvm/svm/sev.c
> @@ -43,7 +43,8 @@
>  #define GHCB_HV_FT_SUPPORTED	(GHCB_HV_FT_SNP			| \
>  				 GHCB_HV_FT_SNP_AP_CREATION	| \
>  				 GHCB_HV_FT_SNP_RINJ		| \
> -				 GHCB_HV_FT_APIC_ID_LIST)
> +				 GHCB_HV_FT_APIC_ID_LIST	| \
> +				 GHCB_HV_FT_SNP_MULTI_VMPL)

[Severity: High]
Does unconditionally exposing this feature break KVM live migration
and capability negotiation?

It looks like GHCB_HV_FT_SNP_MULTI_VMPL is now enabled by default for
all SEV-SNP guests whenever they request HV features, without giving
userspace the ability to enumerate or control it.

If a guest queries this newly exposed flag and attempts to switch to a
valid VMPL (e.g., vmpl =3D 1), but userspace has not yet created the
target plane, would sev_handle_vmgexit_msr_protocol() return -EINVAL
when calling __sev_snp_run_vmpl()? This appears to propagate up to the
KVM_RUN loop and abort the VM entirely, meaning the guest could
unexpectedly crash its own VM on a host missing userspace configuration.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608144252.3514=
43-1-joro@8bytes.org?part=3D60
