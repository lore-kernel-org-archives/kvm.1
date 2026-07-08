Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E31826B0A9
	for <kvm@vger.kernel.org>; Wed,  8 Jul 2026 03:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783482915; cv=none; b=MrqxjYYOYxGyea7mHm3hFguSy001iqeyLPfYrc5WgpWOGwpC6EWacDhxfZBKVV3yglftsH6lMLSqa8Vm59hZuoQieLSRzGQvc+Rl7JkvH06A7EK3KwyvPTl3ZTqqYsZNi5eELBlTyFt77NyVylO8m2S0DPZApBXREaKUxm1d8Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783482915; c=relaxed/simple;
	bh=SChAgm2U+mDWPzzYoOrd1CGwOy2+Z/Rnckg8Z9oKUwk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QvbWnozkuYcK6j5xlmKFXRElPl5HFCD2mIBzCMvWJNO0F04+ghKyS5KIS90AHJ8GozaY7iq+6ev+fsKZt1C2LtcydRuz0y5hWZCzpDgJbvn7ET+q+HDWPoryo4DMeFAqb+BtCyP8uxjcJj7j3eNqEUWEyhtJ+cQM83vKiruV2ZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fDj7l0Rp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fDj7l0Rp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57B7B1F000E9;
	Wed,  8 Jul 2026 03:55:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783482914;
	bh=MY+wsUi5k2SKQRCjUcbR/owSB8DYp4uKklAiIKtQEdo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fDj7l0RpbusHlEwa9mt8mDqu52DO/D/pnxgunAkMC/qWjhNxzHaumuNV+GtXmKhPU
	 QsQkONIDRIgJOyWH5Z2LI6R7LHiCvfdY2Q2tgAooyZYK/6pQ4QAfRsarLnZbzDiG0O
	 LoSLtSXVap4HEOihKi5sQOG2YKREPRlA40Mxks7myokSLOmSPszTZqQRyMOpyOTfX/
	 CZrNNakhRL565YgVl11aNl3VHXo3ikYcIiK3nJJP5KchyU+XfVY5O7kaFpck6t8Buz
	 YUm/KfD81YBD2vrD5SUSQz+ahSkpyVjWLPsOC6FCAZQ13Hk5vQQ+9wcsrU6XxEhgaE
	 YxsZwuU1MUCtA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 07/17] riscv: Maintain epc on misaligned emulation
 error
Reply-To: sashiko-reviews@lists.linux.dev
To: "Charlie Jenkins" <thecharlesjenkins@gmail.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260707-riscv_insn_table-v3-7-3f8e5f75ba97@gmail.com>
References: <20260707-riscv_insn_table-v3-0-3f8e5f75ba97@gmail.com>
 <20260707-riscv_insn_table-v3-7-3f8e5f75ba97@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 03:55:13 +0000
Message-Id: <20260708035514.57B7B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] Removing `regs->epc =3D 0` breaks the emulation of misaligned stor=
es that use the `zero` register (`x0`), causing them to leak and write the =
instruction pointer (EPC) to memory instead of zero.

Pre-existing issues:
- [High] Emulating kernel-mode misaligned memory accesses uses `memcpy()` w=
ithout exception tables, leading to kernel panics when accessing unmapped m=
emory (e.g., via `bpf_probe_read()` or `get_user()`).
--

--- Patch [7]: [PATCH v3 07/17] riscv: Maintain epc on misaligned emulation=
 error ---
commit 4be6480bf402b9e8440e0f9f14c2dfd93692b4cd
Author: Charlie Jenkins <thecharlesjenkins@gmail.com>

riscv: Maintain epc on misaligned emulation error

Currently the epc is set to zero when there is a misaligned emulation
error. This will print a misleading error message with the current epc
value of zero instead of the epc value that triggered the emulation.
Avoid setting epc to zero to maintain the state of epc.

> diff --git a/arch/riscv/kernel/traps_misaligned.c b/arch/riscv/kernel/tra=
ps_misaligned.c
> index 81b7682e6c6db..524215a186e03 100644
> --- a/arch/riscv/kernel/traps_misaligned.c
> +++ b/arch/riscv/kernel/traps_misaligned.c
> @@ -238,8 +238,6 @@ static int handle_scalar_misaligned_load(struct pt_re=
gs *regs)
>  	if (get_insn(regs, epc, &insn))
>  		return -1;
> =20
> -	regs->epc =3D 0;
> -
>  	if ((insn & INSN_MASK_LW) =3D=3D INSN_MATCH_LW) {
>  		len =3D 4;
>  		shift =3D 8 * (sizeof(unsigned long) - len);

[Severity: High]
This is a pre-existing issue, but does emulating kernel-mode misaligned
loads and stores in these handlers risk a kernel panic?

Further down in handle_scalar_misaligned_load() and
handle_scalar_misaligned_store(), the code falls back to memcpy() when
user_mode(regs) is false:

	} else {
		memcpy(&val, (u8 *)addr, len);
	}

If a routine like get_user() or bpf_probe_read() is passed an unmapped,
misaligned pointer, the hardware traps here. Since memcpy() lacks exception
table entries, won't the resulting page fault be unhandled and bypass the
intended safety mechanisms?

[ ... ]

> @@ -349,8 +346,6 @@ static int handle_scalar_misaligned_store(struct pt_r=
egs *regs)
>  	if (get_insn(regs, epc, &insn))
>  		return -1;
> =20
> -	regs->epc =3D 0;
> -
>  	val.data_ulong =3D GET_RS2(insn, regs);

[Severity: High]
Does removing this assignment cause an information leak when emulating
stores from the zero register (x0)?

The GET_RS2() and GET_RS2C() macros calculate the register value by taking
the byte offset into struct pt_regs. For the zero register (index 0), this
maps to offset 0, which corresponds to regs->epc.

Previously, clearing regs->epc =3D 0 neutralized this aliasing, allowing
misaligned stores using x0 (e.g., sw x0, 1(a0)) to correctly write zero.
Without this, will the code now read the actual EPC value and write the
faulting instruction pointer to memory instead of zero?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260707-riscv_insn=
_table-v3-0-3f8e5f75ba97@gmail.com?part=3D7
