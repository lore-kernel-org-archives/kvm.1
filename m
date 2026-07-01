Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C1B8259C9C;
	Wed,  1 Jul 2026 14:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782914459; cv=none; b=FvLMF29mmCSVgW65DXFSbTP9hnhClYDpnj2VLYsWaNLxpm7Maqg/QQk9h18FcuHotZEcIgO0yFDuW5Ka/zT8mah1BZ51Hpry489IH5u+QBO8pIVree4fNcc1ncWmXWU337WPdi642FTWCY2WMvTUcJLVWvyzvQmfTAvI73OHLL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782914459; c=relaxed/simple;
	bh=+uweFtF+It7SFqYWFt7m6yyvCKQ9uRQgyx42e4lrpHo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TfF6oz7itO4QgmOCle4R9KY9eq0SKIjdy5rT2U0UnHYVlet159uaYDKt8LC9CaEHdjhiLMhTIp1S6Amlf+nE5Em3aA95Ctj9/xeMxNXic6d+fbSW8jlbttXA1TJLBx89ZzRPW+nuuvsSlOWmhmji9ZPqY/Iha2Z3U+zjT8P62Ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aekLN52E; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aekLN52E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBFD91F000E9;
	Wed,  1 Jul 2026 14:00:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782914458;
	bh=O3gKZvSQchpTlNN+s4QU/u4480kCb0+4fLtpTnmfcCo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aekLN52EN1oaVLIS5sN4Fj7XjylCvgfIxf0OJAWPgk09PTqxDvxd8A4TY2LevgR2v
	 Sry7JhwPrbSjz7QwD16v2uHEA2KIFlDbjoqqXDiXuEm6eWvrsc00x73D1ayAPZWVje
	 iQuahlBbBXDr+hW6JGxitf0lmsCd1Rgd/BQ38/ull3N6X3JOU11H5RQVcYYoP5LPc4
	 rxZNaFVzcwRAStZQ9/AJaAfk9RyuhZseULr56yN/LWFH4JMneFnbyCmXF1Ooxg/7NK
	 NGimnKU4pGHR1ambujLbIqm5hKc4A83dbJgd5ZR8RkykdT/iEeOoApelvuUk2UlynF
	 b0TBZGKODiV7w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 12/17] riscv: dts: spacemit: k1: Add Zic64b ISA
 extension
Reply-To: sashiko-reviews@lists.linux.dev
To: "Guodong Xu" <docular.xu@gmail.com>
Cc: robh@kernel.org, devicetree@vger.kernel.org, kvm@vger.kernel.org, conor+dt@kernel.org
In-Reply-To: <20260701-rva23u64-hwprobe-v2-v5-12-2c61f94a695a@gmail.com>
References: <20260701-rva23u64-hwprobe-v2-v5-0-2c61f94a695a@gmail.com>
 <20260701-rva23u64-hwprobe-v2-v5-12-2c61f94a695a@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 14:00:57 +0000
Message-Id: <20260701140057.EBFD91F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Adding a new ISA extension (`zic64b`) to the explicitly deprecated =
`riscv,isa` devicetree property.
--

commit a35d1f188ef1737f4ebf996e0483596e27176d0a
Author: Guodong Xu <docular.xu@gmail.com>

riscv: dts: spacemit: k1: Add Zic64b ISA extension

This commit adds the Zic64b ISA extension to the K1 X60 cores. It updates
both the riscv,isa-extensions list and the deprecated riscv,isa string
across all CPU nodes in the device tree.

> diff --git a/arch/riscv/boot/dts/spacemit/k1.dtsi b/arch/riscv/boot/dts/s=
pacemit/k1.dtsi
> index 08a0f28d011fe..f179c619f5807 100644
> --- a/arch/riscv/boot/dts/spacemit/k1.dtsi
> +++ b/arch/riscv/boot/dts/spacemit/k1.dtsi
> @@ -54,12 +54,12 @@ cpu_0: cpu@0 {
>  			compatible =3D "spacemit,x60", "riscv";
>  			device_type =3D "cpu";
>  			reg =3D <0>;
> -			riscv,isa =3D "rv64imafdcbv_zicbom_zicbop_zicboz_zicntr_zicond_zicsr_=
zifencei_zihintpause_zihpm_zfh_zba_zbb_zbc_zbs_zkt_zvfh_zvkt_sscofpmf_sstc_=
svinval_svnapot_svpbmt";
> +			riscv,isa =3D "rv64imafdcbv_zic64b_zicbom_zicbop_zicboz_zicntr_zicond=
_zicsr_zifencei_zihintpause_zihpm_zfh_zba_zbb_zbc_zbs_zkt_zvfh_zvkt_sscofpm=
f_sstc_svinval_svnapot_svpbmt";

[Severity: Low]
This isn't a bug, but the riscv,isa devicetree property is officially
deprecated in the devicetree bindings. Is it intentional to add the
new zic64b extension to this legacy string?

The accepted policy generally dictates that new extensions should only be
added to the riscv,isa-extensions property.

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701-rva23u64-h=
wprobe-v2-v5-0-2c61f94a695a@gmail.com?part=3D12
