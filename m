Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B9C6225775
	for <kvm@vger.kernel.org>; Wed,  8 Jul 2026 03:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783482529; cv=none; b=jmfD5zPgDXe5+7KAPpRM33oVbHCK9QmvTeDtw/SY7fSeSGRUST4+onDy4j8uNrDsYcXrHDVcdyjMYF2lg1NDAFmBEHOI6ykwMCooHDUFvL9ot8t5cHO/8s9pIXr2pX6YWhNvesS66Nt8ImdlCNU+AsOx7Amf055RHVjNq6US9eA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783482529; c=relaxed/simple;
	bh=opkA5bfQtK447IUzjxGpt1frAkQ+1tqSgi55xYgdZnc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hRSe/zvCtWcaa7PcvDl3z+QeNnR1Yyh//zcXx0C5EKN6ndjt7go5Xtyb03pxVUTytgQ+M03TliS+oWWcX/rWqoH8sDp4smnrAxg3w7fjThx+cWTQKzfDnv+ATIakPkfTp+T7x8NtLbPxcnv1lfm9NlgY/C6MkO5EGl/1+o1P3G8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LFE83Mla; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LFE83Mla"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C37D71F00A3A;
	Wed,  8 Jul 2026 03:48:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783482528;
	bh=QiiZxDGkMhiILY4fYTmNv1ionpxCpzSqCh9OvUWBS4Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LFE83Mlat/0m8LTbVYcAOJb2ItcAcLLhOAgR6wT/0/AQsuksEwEPsTgrqOH5Cl6+j
	 NfBvqC3E/lWxGrvhSrxeQOgkOjAf0wXm1He0XEUCp4Y7MrQy3FWbN29vX8MwCphQQE
	 Q/5cFQ6NqWPoHawfgNWAK8AuXWtEeK66DgoKQduGfYou4tbQnoQKapHGWITXiHIQ7J
	 L0gusD+wNmg/gkjC4ff7clVYed9NkjR3h5XSyPr9AZYdE0h04U8fvn3eFOIVDJGkcW
	 Qcda8Ib3RU2fQ4To/irGVp6sf2wCiIcNsvKPdpVC0cp7BiR7g3mmyqKBja7+5Lp3wO
	 P7jas7560H12w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 09/17] riscv: kvm: Use generated instruction headers
 for csr code
Reply-To: sashiko-reviews@lists.linux.dev
To: "Charlie Jenkins" <thecharlesjenkins@gmail.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260707-riscv_insn_table-v3-9-3f8e5f75ba97@gmail.com>
References: <20260707-riscv_insn_table-v3-0-3f8e5f75ba97@gmail.com>
 <20260707-riscv_insn_table-v3-9-3f8e5f75ba97@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 03:48:47 +0000
Message-Id: <20260708034847.C37D71F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Undefined macro `GET_REG` causes a build failure, and intended `ge=
t_reg()` usage masks a logic error where an immediate is treated as a regis=
ter index.
--

--- Patch [9]: [PATCH v3 09/17] riscv: kvm: Use generated instruction heade=
rs for csr code ---
commit d70b1983c271eb6387c8473892b04f021becb8ff
Author: Charlie Jenkins <thecharlesjenkins@gmail.com>

riscv: kvm: Use generated instruction headers for csr code

This commit migrates the CSR parsing code in RISC-V KVM to use the generated
instruction headers instead of hand-written instruction composition functio=
ns.

> diff --git a/arch/riscv/kvm/vcpu_insn.c b/arch/riscv/kvm/vcpu_insn.c
> index f09f9251d1f0a..a1898ab8bbe85 100644
> --- a/arch/riscv/kvm/vcpu_insn.c
> +++ b/arch/riscv/kvm/vcpu_insn.c

[ ... ]

> @@ -144,45 +144,49 @@ static int csr_insn(struct kvm_vcpu *vcpu, struct k=
vm_run *run, ulong insn)
>  	const struct csr_func *tcfn, *cfn =3D NULL;
>  	ulong val =3D 0, wr_mask =3D 0, new_val =3D 0;
> =20
>  	/* Decode the CSR instruction */

[ ... ]

> +	} else if (riscv_insn_is_csrrwi(insn)) {
>  		wr_mask =3D -1UL;
> +		new_val =3D riscv_insn_csrrwi_extract_imm(insn);
> +		csr_num =3D riscv_insn_csrrwi_extract_csr(insn);
> +	} else if (riscv_insn_is_csrrsi(insn)) {
> +		wr_mask =3D riscv_insn_csrrwi_extract_imm(insn);

[Severity: High]
Should this use a csrrsi specific extraction function? It looks like it is
currently reusing riscv_insn_csrrwi_extract_imm() due to a copy-paste error.

>  		new_val =3D -1UL;
> +		csr_num =3D riscv_insn_csrrsi_extract_csr(insn);
> +	} else if (riscv_insn_is_csrrci(insn)) {
> +		wr_mask =3D GET_REG(riscv_insn_csrrwi_extract_imm(insn));

[Severity: High]
This introduces an undefined macro GET_REG, which will break the build.

If the intention was to use the newly added get_reg() helper, does that
introduce a logic error? The csrrci instruction uses a 5-bit zero-extended
immediate directly as the write mask, rather than using the immediate as a
register index.

Also, similar to the csrrsi branch above, should this use the csrrci
extraction functions instead of riscv_insn_csrrwi_extract_imm() and
riscv_insn_csrrwi_extract_csr()?

>  		new_val =3D 0;
> +		csr_num =3D riscv_insn_csrrwi_extract_csr(insn);
> +	} else {
>  		return rc;
>  	}
> =20
> +	#undef GET_REG
> +

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260707-riscv_insn=
_table-v3-0-3f8e5f75ba97@gmail.com?part=3D9
