Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FF7F3CBE96
	for <kvm@vger.kernel.org>; Thu,  9 Jul 2026 08:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783586649; cv=none; b=UX7fqR2dnUYhY1US3sKtMdl6/sDAiX+ZtrJvusIrQUPUmQ/pbSwDXXbSApDZX9HRr9FdbtBz1I4KvZbdnWnykYjyksLxK8qt+gJE/o2n/OVCcM+wRtd1R5gCxxWFSrZ4A91EJqZOnUdA04N+gNiIHHROH5iPkFYuL/EFQRodCK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783586649; c=relaxed/simple;
	bh=om8G+H0n9OTgm4VtbslCXdPYTvR8ZyNo0qhWuoPVSLA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WSNGxvnoppob6XpdjhLY8vxiv7bjzeyNxQ49D2bsriSmjWUtqFuQuct8+1cup77BnHRZpY9SlV7JHwRRq56VdhDZL2X4LZ1iHVEsxiRg4HULy1576AVclumg9/+uaP2p4bkuLMoO3zAZbn21BN6Oj/QvfCgWj7f0SE48p+kpd3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kyo5oQWS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kyo5oQWS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD00A1F000E9;
	Thu,  9 Jul 2026 08:44:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783586648;
	bh=mRejYyuTDOMFs7rXYfPN4UVDiDio7Bcfv/PNj//F9O0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kyo5oQWS0/wKo1c808u7FrvfQ5OvNSN1Sk5+78j/Wm01yDvPakzyNsLf9iWIff7wK
	 BSCEz7Qvi+4ri5kPwLZ0crDRCdZvb3Vv2JsITfq9ll3dxmMxfc0rjkVdHH2MCkgb7R
	 elVhwuLyN0l8YOinaO+h510bnr6CK/U7LX0ibI3WXfPZOZi+gcOhm7K4Hee41XI6BJ
	 qOZ7MtYGlbeKPSUcz5wFuqk2AxPfTHtTzS0u8HLSM0PlvIPDZRSLBWR0ifoAFh66b+
	 +v8k5ShGMvKpNlY91nv5QiFoi1wdNolkfxqXGIPZ1UQHxIU5foECB7V5Qhckcg3Abz
	 T/ub+rwWG3gGw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 3/4] LoongArch: KVM: Return directly when IPI address
 is not aligned
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bibo Mao" <maobibo@loongson.cn>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260709082109.1361767-4-maobibo@loongson.cn>
References: <20260709082109.1361767-1-maobibo@loongson.cn>
 <20260709082109.1361767-4-maobibo@loongson.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 08:44:07 +0000
Message-Id: <20260709084407.DD00A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] The early return path for unaligned accesses in `loongarch_ipi_rea=
dl` fails to populate the `val` output parameter, leaking stale data to the=
 guest.

Pre-existing issues:
- [Critical] A malicious guest can trigger a host kernel panic by performin=
g an unaligned MMIO access to the MIPS KVM IPI region.
--

--- Patch [3]: [PATCH v4 3/4] LoongArch: KVM: Return directly when IPI addr=
ess is not aligned ---
commit 8225fc6b95e2b4712a3ffe27c14012171a25b47b
Author: Bibo Mao <maobibo@loongson.cn>

LoongArch: KVM: Return directly when IPI address is not aligned

This patch modifies KVM on LoongArch to return directly from IPI read and
write operations when the address is unaligned, rather than just printing a
warning.

> diff --git a/arch/loongarch/kvm/intc/ipi.c b/arch/loongarch/kvm/intc/ipi.c
> index bccdfd963e5b5..8ec40e09c5abb 100644
> --- a/arch/loongarch/kvm/intc/ipi.c
> +++ b/arch/loongarch/kvm/intc/ipi.c
> @@ -181,9 +181,12 @@ static int loongarch_ipi_readl(struct kvm_vcpu *vcpu=
, gpa_t addr, int len, void
>  	uint32_t offset;
>  	uint64_t res =3D 0;
> =20
> -	offset =3D (uint32_t)(addr & 0x1ff);
> -	WARN_ON_ONCE(offset & (len - 1));
> +	if (addr & (len - 1)) {
> +		kvm_pr_unimpl("%s: ipi not aligned addr %llx len %d\n", __func__, addr=
, len);
> +		return 0;
> +	}

[Severity: High]
Does this early return path in loongarch_ipi_readl() need to populate the v=
al
output parameter before returning success (0)?

If a guest performs an unaligned read, kvm_io_bus_read() will see a success=
ful
return, but val remains unmodified. Could this lead to stale data from
previous VM exits being copied into the guest's registers?

[ ... ]

[Severity: Critical]
This is a pre-existing issue and was not introduced by this patch, but while
reviewing unaligned IPI access handling, a guest-triggerable BUG_ON() was
noticed in the MIPS loongson_vipi_read() and loongson_vipi_write() paths:

arch/mips/kvm/loongson_ipi.c:loongson_vipi_read() {
    ...
    BUG_ON(offset & (len - 1));
    ...
}

Could a malicious guest trigger a host kernel panic by performing an unalig=
ned
MMIO read or write targeting the loongson_ipi region?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709082109.1361=
767-1-maobibo@loongson.cn?part=3D3
