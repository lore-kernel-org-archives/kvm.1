Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E5B6175A8F
	for <kvm@vger.kernel.org>; Wed,  8 Jul 2026 04:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783483444; cv=none; b=fXkKTCFNzYJJtXwvMPAMERp8A605Byey3j8XgiC1cQ153J4urdzBUwC8JSK+3u0I5AitiTJCKRVx8jzSI5n9hRiKZbOYjmWFl7yGSgZn4Uc6cheRKwYdwPvuYpBpiTEGwBCD/CMRybATBm36/AIHQBl+CbHGN5mdic3YNH8UhJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783483444; c=relaxed/simple;
	bh=k4Ab/kyGvVYMuU1MbP3V0CQURuIu0FU1AAKvFIlgZfw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uIetwv9CPk+ZdC5rj/LSliwHBDslRuouTOkxprMip+2tm8xR70U9Wt3TgKdq9oL1VkJjcrXuGh6WPecvmx2nzFRXpyhcp8NGGW5dfNFm7Qda4Zg1+lJXrED079vEpTNf8pJDcLWsJxPrMdCT19qQwL26MKAeaUyZkbHtTZxCPr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G4E0ESQo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G4E0ESQo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EADE1F000E9;
	Wed,  8 Jul 2026 04:04:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783483442;
	bh=LyyFM1VML3EzsF/K3DP6V6eCSt/9IaCvH/Dj/KuJvhI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=G4E0ESQopfKVxP7dTKECeol4LPe+EGTSmsxG56HOWrT9nsvcKcQPJOmvyR1FleVPj
	 NOQIIjogrOik3oP6/xxNWFKH+yyWaUtEegjdL2Zpv2z+ClZ5xNBLHeQGbCF9T5BtNW
	 9gM36aiarUFRKiSZKurvXrV9kQ6TeX/DVRJY2PuKTpwWP6VsTTjT+l9J24Wrjv2W+m
	 tRLY+Tkz2TJ+1Bad0BNhUa++Iw94WYJK3nGKzda2b9O4w4UO4Cvj/GTyGT+l5fuuhT
	 o02P9t60uwU3+kw0eO8EiJZkt5TErfDf7dzNFd6eO7KX5V8IpUPhRFqKQOBWBgIthT
	 QBU5X3Sd1bQJA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 15/17] riscv: kvm: Use generated instruction headers
 for csr emulation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Charlie Jenkins" <thecharlesjenkins@gmail.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260707-riscv_insn_table-v3-15-3f8e5f75ba97@gmail.com>
References: <20260707-riscv_insn_table-v3-0-3f8e5f75ba97@gmail.com>
 <20260707-riscv_insn_table-v3-15-3f8e5f75ba97@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 04:04:01 +0000
Message-Id: <20260708040402.9EADE1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] RVC (compressed) MMIO loads and stores read from and write to the =
wrong guest registers due to a missing architectural offset calculation.
- [Low] The CSR emulation code uses the `csrrwi` immediate extractor macro =
for a `csrrsi` instruction.
--

--- Patch [15]: [PATCH v3 15/17] riscv: kvm: Use generated instruction head=
ers for csr emulation ---
commit 1deda6264dba206b7c5ef34e0d344daa8c535ddc
Author: Charlie Jenkins <thecharlesjenkins@gmail.com>

riscv: kvm: Use generated instruction headers for csr emulation

This commit migrates the CSR emulation code to use the generated instruction
headers instead of the hand-written instruction composition functions.

> diff --git a/arch/riscv/kvm/vcpu_insn.c b/arch/riscv/kvm/vcpu_insn.c
> index c3e4cf2cd44b7..51eb2c717bff3 100644
> --- a/arch/riscv/kvm/vcpu_insn.c
> +++ b/arch/riscv/kvm/vcpu_insn.c
[ ... ]
> @@ -166,26 +162,32 @@ static int csr_insn(struct kvm_vcpu *vcpu, struct k=
vm_run *run, ulong insn)
[ ... ]
>  	} else if (riscv_insn_is_csrrsi(insn)) {
>  		wr_mask =3D riscv_insn_csrrwi_extract_imm(insn);
>  		new_val =3D -1UL;
>  		csr_num =3D riscv_insn_csrrsi_extract_csr(insn);
> +		rd =3D riscv_insn_csrrsi_extract_xd(insn);

[Severity: Low]
This isn't a bug, but is riscv_insn_csrrwi_extract_imm() mistakenly used he=
re
for a csrrsi instruction instead of riscv_insn_csrrsi_extract_imm()?

>  	} else if (riscv_insn_is_csrrci(insn)) {
[ ... ]


commit 8d80090faef41d1000ad8ee985dcdaa3df7c12d3
Author: Charlie Jenkins <thecharlesjenkins@gmail.com>

riscv: kvm: Use generated instruction headers for mmio emulation

This commit migrates the MMIO emulation code to use the generated instructi=
on
headers instead of the hand-written instruction composition functions.

> diff --git a/arch/riscv/kvm/vcpu_insn.c b/arch/riscv/kvm/vcpu_insn.c
> index a1898ab8bbe85..78adc28308193 100644
> --- a/arch/riscv/kvm/vcpu_insn.c
> +++ b/arch/riscv/kvm/vcpu_insn.c
[ ... ]
> @@ -411,44 +411,47 @@ int kvm_riscv_vcpu_mmio_load(struct kvm_vcpu *vcpu,=
 struct kvm_run *run,
[ ... ]
> -	} else if ((insn & INSN_MASK_C_LD) =3D=3D INSN_MATCH_C_LD) {
> +	} else if (riscv_insn_is_c_ld(insn)) {
>  		len =3D 8;
>  		shift =3D 8 * (sizeof(ulong) - len);
> -		insn =3D RVC_RS2S(insn) << SH_RD;
> +		rd =3D riscv_insn_c_ld_extract_xd(insn);

[Severity: High]
Does this code miss the + 8 offset calculation when extracting the register?

Previously, RVC_RS2S correctly added the 8 offset so compressed MMIO loads
would write to x8-x15. With the raw 3-bit extractor macro
riscv_insn_c_ld_extract_xd(insn), rd will be a raw 0-7 value, causing
compressed MMIO loads like c.ld to overwrite x0-x7 (corrupting SP, GP, etc.)
instead.

> -	} else if ((insn & INSN_MASK_C_LDSP) =3D=3D INSN_MATCH_C_LDSP &&
[ ... ]
> @@ -537,35 +536,30 @@ int kvm_riscv_vcpu_mmio_store(struct kvm_vcpu *vcpu=
, struct kvm_run *run,
[ ... ]
> -	} else if ((insn & INSN_MASK_C_SD) =3D=3D INSN_MATCH_C_SD) {
> +	} else if (riscv_insn_is_c_sd(insn)) {
>  		len =3D 8;
> -		data64 =3D GET_RS2S(insn, &vcpu->arch.guest_context);
> +		rs2 =3D riscv_insn_c_sd_extract_xs2(insn);

[Severity: High]
Does this code leak the wrong register state to the emulated MMIO device?

Similar to the load case above, GET_RS2S correctly added the 8 offset, but
riscv_insn_c_sd_extract_xs2(insn) extracts only the raw 3-bit value. This
causes compressed MMIO stores like c.sd to read from x0-x7 instead of x8-x1=
5,
leaking unintended guest state.

> -	} else if ((insn & INSN_MASK_C_SDSP) =3D=3D INSN_MATCH_C_SDSP &&
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260707-riscv_insn=
_table-v3-0-3f8e5f75ba97@gmail.com?part=3D15
