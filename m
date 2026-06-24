Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C7F5261B9B
	for <kvm@vger.kernel.org>; Wed, 24 Jun 2026 22:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782339828; cv=none; b=P7YdcnIfGx8Po0xLJ9BmaKYgjfSnXGoXmuiXVCpBL1s9NWv2Bfa17dPzoj/pSTfWtsqEapXEgfX21od0wW/3NGs4lckedZbCud1T5a8Dal+xhtgHT8eKhjiW34zjI9rQD9mZje2v2xt13gbqDtSMAOudh3ESHhdF8wowy0BYUcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782339828; c=relaxed/simple;
	bh=Qah0NJdWnxEA3sSPzbP6H+/vmIuDbjySOez2BfTd0tI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dt72obEP7ldksr7gFWQOcx0VOw6yPIMiEJpuTLqS1LE9F0HVwfYwJlsiVxYo60+incOm4Kf4wR3vb5Dyxdxk85mQxoHw/WtuSPhGpXS1t6ggxw9EPEshyOdgUk1rQZd7hnxQA/XH8Ut+iqObOqK8SZvX3iH2DciDXDbY8w41a8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PJvjz0qP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PJvjz0qP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C47C1F000E9;
	Wed, 24 Jun 2026 22:23:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782339827;
	bh=r7uJ749YfxJ2suyJg2ViJague/ynyAnJ940xQ1UYdBI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PJvjz0qPMxejBMHesQUZJejXJdpALlXt1vUMQW911LDIpgURjUk4UtBKpVRk+dqg/
	 Heqar6fRYDR9awn6TBEDS+qBjkxJPcUBoVlcn4OtYTanMvAhultHqKwhtF42JNgK7q
	 GLTvkkAUlHYXX55aHppEXt5v64t4q7UjRCwPp+M/GkfEBImQpxYCyRvdaP1vAAnycy
	 Grr6DeaN+g/fCN/h6JzPG87RmUjnsdLVm+YxTXmwape9pvlTExMOZmNwZda8vFKysv
	 Ib7VY/BanlZVBYVkmu8yN0Q6NyFiVQttqOKSFIo+Ek59iCLbn79GCRzt1qYbHJqhPw
	 kO+kyHmVk7wFA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 3/6] x86/sev: Disable CPU hotplug while SNP is active
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ashish Kalra" <Ashish.Kalra@amd.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <ba146ca15b7f76eee386c8c073fb3f1cc36e5781.1782336473.git.ashish.kalra@amd.com>
References: <cover.1782336473.git.ashish.kalra@amd.com>
 <ba146ca15b7f76eee386c8c073fb3f1cc36e5781.1782336473.git.ashish.kalra@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 24 Jun 2026 22:23:46 +0000
Message-Id: <20260624222347.0C47C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] CPU hotplug is disabled too late in the SEV-SNP initialization seq=
uence, leaving a race condition that could lead to SEV-SNP guest memory cor=
ruption.
--

commit 3de14e7df8d9891da860d77abb4bcd8843de6e48
Author: Ashish Kalra <ashish.kalra@amd.com>

x86/sev: Disable CPU hotplug while SNP is active

This commit disables CPU hotplug while SEV-SNP is active to prevent CPUs
brought online after SNP initialization from bypassing RMP checks. This
ensures the hardware checks are consistently enforced across all active
cores to protect guest memory integrity.

> diff --git a/drivers/crypto/ccp/sev-dev.c b/drivers/crypto/ccp/sev-dev.c
> index c002a7ca26a8a..3b245ad2d3fe9 100644
> --- a/drivers/crypto/ccp/sev-dev.c
> +++ b/drivers/crypto/ccp/sev-dev.c
[ ... ]
> @@ -1478,6 +1478,9 @@ static int __sev_snp_init_locked(int *error, unsign=
ed int max_snp_asid)
> =20
>  	snp_hv_fixed_pages_state_update(sev, HV_FIXED);
> =20
> +	/* Disable CPU hotplug while SNP is active (see snp_disable_cpu_hotplug=
). */
> +	snp_disable_cpu_hotplug();
> +

[Severity: High]
Is there a race condition between snp_prepare() and snp_disable_cpu_hotplug=
()?

Earlier in __sev_snp_init_locked(), snp_prepare() is called which sets
SNP_EN on all online CPUs. If a CPU is offlined and re-onlined before we re=
ach
snp_disable_cpu_hotplug(), could it lose its SNP_EN bit and bypass RMP chec=
ks?

Also, if the intermediate firmware commands like SEV_CMD_SNP_INIT_EX or
SEV_CMD_SNP_DF_FLUSH fail and return early:

	rc =3D __sev_do_cmd_locked(SEV_CMD_SNP_DF_FLUSH, NULL, error);
	if (rc) {
		dev_err(sev->dev, "SEV-SNP: SNP_DF_FLUSH failed rc %d, error %#x\n",
			rc, *error);
		return rc;
	}

snp_disable_cpu_hotplug() will never be called. Does this leave the system
permanently vulnerable to hotplugging CPUs without SNP_EN if snp_prepare()
has already executed?

>  	snp_setup_rmpopt();
> =20
>  	sev->snp_initialized =3D true;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1782336473.gi=
t.ashish.kalra@amd.com?part=3D3
