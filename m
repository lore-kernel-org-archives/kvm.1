Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A072A1A9F82
	for <kvm@vger.kernel.org>; Wed,  8 Jul 2026 03:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783482685; cv=none; b=NO/IRpJhtge/OzgvHE7aqq4eH6+hDTL2CCXBMSxH2NKRrWBDg8UACTsgU5VchLb7ZUFnncmWZJCds3QpqY68VUDWPh+q1h40Aw6nhwNBvqave8FPc8IRJ8DSQ6RUlKQdf4XIPdhabYwCxfwORQrqZTU6v5YzPdU961vma/c4BWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783482685; c=relaxed/simple;
	bh=chaZfJRwAKwdCAnNFtBorv2xozj1sPF/5I7xEdif0mw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GPQPdG+ptYAoE5e3KqWOom5HmuC0E2LdS0Jm42CT7KVDFEeag5B7dwTMmx1zpMyZXy34Ir5IXpMR14Lr+ygVS8TWhwvUY+hmP+TBD8ikZb9ezdM3pU18OT/QXXSnWz7UNYNX9qaQotrn+vGmNYziod7bhMyr/4x+RIHN+ksxwcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T9LOnOWb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T9LOnOWb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AA011F000E9;
	Wed,  8 Jul 2026 03:51:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783482684;
	bh=uewLCbYSWSgaqXIBspmd5Y8c3Ks+yPGuQTrQW4wAwCo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=T9LOnOWbwCVB9dVUOAxm6CFe2Q7tuRkUI/hD3Zk+eY12Xuk2354rbw6MUPk7PcFW7
	 tITsBS8m89Hyl8NelaC2tNGiL30/bxFzgtTluHFP9klFaH19h4z02xC5sj/+GppfLN
	 6cq7QuqW7wrAv9sLOgT2pKyJlLuUaRHZ412++JpJOzGriS3cP3X2WS0jpCECTYMZVY
	 XlsLb0eihx5GSVymN5dU8Vt66k8GJnoj6Gi3RCaWF7aEpeXvN6sEJGd2+yrJ8iCRkH
	 EhB1L24dcn7PkpiTKE/EGDLK5quppFAwkH6+VrQbo7QW+PQxuTt0/cNnh8KdfGdADX
	 6Fzc06ktPOJFA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 04/17] riscv: Add kprobes instruction simulation
 KUnit
Reply-To: sashiko-reviews@lists.linux.dev
To: "Charlie Jenkins" <thecharlesjenkins@gmail.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260707-riscv_insn_table-v3-4-3f8e5f75ba97@gmail.com>
References: <20260707-riscv_insn_table-v3-0-3f8e5f75ba97@gmail.com>
 <20260707-riscv_insn_table-v3-4-3f8e5f75ba97@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 03:51:23 +0000
Message-Id: <20260708035124.1AA011F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] The test performs 4.29 billion iterations without yielding and is =
forcefully enabled by `KUNIT_ALL_TESTS`, causing CI hangs and softlockup pa=
nics.
- [Medium] The test zeroes the simulated register state before every instru=
ction, heavily limiting conditional branch simulation coverage.
- [Low] The test calls multiple undefined functions for instruction simulat=
ion and register manipulation, causing a build failure.
- [Low] The `CONFIG_RISCV_KPROBES_SIMULATE_KUNIT` option is a tristate, but=
 the KUnit test calls unexported core kernel symbols, causing a module buil=
d failure.
--

--- Patch [4]: [PATCH v3 04/17] riscv: Add kprobes instruction simulation K=
Unit ---
commit fd54e10f3ed9775912526763a87c12f6ae0730fd
Author: Charlie Jenkins <thecharlesjenkins@gmail.com>

riscv: Add kprobes instruction simulation KUnit

This commit adds a KUnit test for RISC-V kprobes instruction simulation.
It iterates through all 32-bit integers to validate simulation behavior.
The test is gated behind a new configuration option.

> diff --git a/arch/riscv/kernel/tests/Kconfig.debug b/arch/riscv/kernel/te=
sts/Kconfig.debug
> index 40f8dafffa0ab..9eda8938ec15b 100644
> --- a/arch/riscv/kernel/tests/Kconfig.debug
> +++ b/arch/riscv/kernel/tests/Kconfig.debug
> @@ -42,6 +42,19 @@ config RISCV_KPROBES_KUNIT
> =20
>           If unsure, say N.
> =20
> +config RISCV_KPROBES_SIMULATE_KUNIT
> +       tristate "KUnit test for riscv kprobes instruction simulation" if=
 !KUNIT_ALL_TESTS

[Severity: Low]
Should this be a bool rather than a tristate? Building this as a module
results in a regression because the test calls unexported kernel symbols
like simulate_jal and simulate_jalr, causing linker errors.

> +       depends on KUNIT
> +       depends on KPROBES
> +       default KUNIT_ALL_TESTS

[Severity: High]
Does hiding the prompt and defaulting to KUNIT_ALL_TESTS force CI pipelines
to run this test? Because the test is exceptionally slow, this setup
leaves automated testing systems no way to disable it when all tests are
requested.

> +       help
> +         Enable testing for riscv kprobes instruction simulation. Useful=
 for

[ ... ]

> diff --git a/arch/riscv/kernel/tests/kprobes/test-kprobes-simulate.c b/ar=
ch/riscv/kernel/tests/kprobes/test-kprobes-simulate.c
> new file mode 100644
> index 0000000000000..d82706685823d
> --- /dev/null
> +++ b/arch/riscv/kernel/tests/kprobes/test-kprobes-simulate.c
> @@ -0,0 +1,250 @@

[ ... ]

> +static void test_kprobe_simulate_riscv(struct kunit *test)
> +{
> +	unsigned int addr =3D 0xdeadbeef;
> +	unsigned int i =3D 0;
> +
> +	do {
> +		struct pt_regs regs =3D { 0 };

[Severity: High]
Will this loop execute 4.29 billion times without yielding the CPU?=20
Without a call to cond_resched(), iterating through all 32-bit integers
causes a regression by triggering softlockup watchdogs and RCU stall panics.

[Severity: Medium]
Because regs is zero-initialized on every iteration, are the source
registers evaluated by branch instructions restricted to zero? This
regression limits the conditional branch simulation to static outcomes
like 0 =3D=3D 0 and 0 < 0, entirely missing alternate execution paths.

> +
> +		if (riscv_insn_is_jal(i)) {

[ ... ]

> +		if (riscv_insn_is_jalr(i)) {
> +			unsigned long reg_addr =3D 0xffff;
> +			s32 offset =3D riscv_insn_jalr_extract_imm(i);
> +			u32 rd_index =3D riscv_insn_jalr_extract_xd(i);
> +			u32 rs1_index =3D riscv_insn_jalr_extract_xs1(i);
> +
> +			if (rs1_index)
> +				riscv_insn_reg_set_val((unsigned long *)&regs, rs1_index, reg_addr);

[Severity: Low]
Can this compile successfully? It appears riscv_insn_reg_set_val is an
undefined function, whereas the kernel actually uses rv_insn_reg_set_val.

> +			else
> +				reg_addr =3D 0;

[ ... ]

> +		} else if (riscv_insn_is_beq(i)) {
> +			s32 offset =3D riscv_insn_beq_extract_imm(i);
> +			u32 rs1_index =3D riscv_insn_beq_extract_xs1(i);
> +			u32 rs2_index =3D riscv_insn_beq_extract_xs2(i);
> +
> +			simulate_beq(i, addr, &regs);

[Severity: Low]
Are these individual branch simulation functions like simulate_beq defined
anywhere? Calling these undefined functions causes a build regression, as
the kernel uses a unified simulate_branch instead.

> +
> +			if (riscv_insn_reg_get_val((unsigned long *)&regs, rs1_index) =3D=3D

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260707-riscv_insn=
_table-v3-0-3f8e5f75ba97@gmail.com?part=3D4
