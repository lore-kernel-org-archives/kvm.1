Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C7FA35201E
	for <kvm@vger.kernel.org>; Mon, 22 Jun 2026 04:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782101986; cv=none; b=Ifa5Dk8ZSivE3CxNhPpBPp+SJo1lM5g7pV/DhYiAOrvYWCU7JzVP4xEs+5n9oMQ8yFtY1BcZEcEJ1pX+R+BshUrlxHpBss09wCuHWjR9VTv9TmVi1J01HKdQvKR3mKBuYB5KZRPil9aaDZjCQmTIy9nX/4C2nVYfiwPRM/edDl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782101986; c=relaxed/simple;
	bh=lgu5KtqRmIzGm4CQ+E1cYDXZat7Lb6ISHcP1jm0ess0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=S11AKBFjPv4HW450hYTEVUTVbimUOuDwv0Bks95tw4Bc9Mx6ekqrGjf/bAT9oCXQ/7iKNt9HuIRyPaVIB3bmVofEUi3xOa5oY9eCWGOpb2vauzBHtD80/SM/xd7on5+9ouXiuFXZP6iUDAkoKQ7vEnLr/f9lusek3tepB2S5Yck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X0HvEY1R; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X0HvEY1R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F032C1F000E9;
	Mon, 22 Jun 2026 04:19:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782101985;
	bh=oyECg/ZcRIQYQmdiFG0fbgUnpshM9DCGKnw7ANnIe+o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=X0HvEY1R/glUwp78o1WbdjpGYq/M/0yn3V90WSzPA5UaUp9hVnD9mUZ4pn5enhGRL
	 PyMQrdiPCTkRMoGOeh7nkfZ95qEZyucq9Nj2fl/ldXSd2yFyiHh5pF7/U+8ZtEZ/Y+
	 HudN5MJU4QPM3UQeNdF6FQYtXgJWbNOU2vJSmC2VXkZ/Qt3dZ/jPzclYpHpO46bp7N
	 hrL7ScczC9cPSu5TGmT5xlt91hdmC3h1i6fPyRa7jN/bZ5xJrtNjVp/ODtCDPbssiw
	 no3/jY7rzqA484ZgUd262/30HUftOp0G3wpYnV6irt3c5emWW5epdSqNgcutW6E1cR
	 TbW15/2TkKCLA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 04/16] riscv: Add kprobes instruction simulation
 KUnit
Reply-To: sashiko-reviews@lists.linux.dev
To: "Charlie Jenkins via B4 Relay" <devnull+thecharlesjenkins.gmail.com@kernel.org>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260621-riscv_insn_table-v2-4-7f0810ee2274@gmail.com>
References: <20260621-riscv_insn_table-v2-0-7f0810ee2274@gmail.com>
 <20260621-riscv_insn_table-v2-4-7f0810ee2274@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 22 Jun 2026 04:19:44 +0000
Message-Id: <20260622041944.F032C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] The KUnit test executes an uninterruptible 4.29 billion iteration =
loop, guaranteeing kernel soft lockups and breaking CI.
- [Medium] The KUnit test logic is tautological and its state initializatio=
n masks branch outcomes, halving test coverage.
--

commit 0b416648ab5f17f7e140c671781502c76b641895
Author: Charlie Jenkins <thecharlesjenkins@gmail.com>

riscv: Add kprobes instruction simulation KUnit

This commit introduces a KUnit test that iterates through all 32-bit
integers to validate kprobes instruction simulation. The tests are gated
behind a new CONFIG_RISCV_KPROBES_SIMULATE_KUNIT kconfig option.

diff --git a/arch/riscv/kernel/tests/Kconfig.debug b/arch/riscv/kernel/test=
s/Kconfig.debug
index 40f8dafffa0ab..9eda8938ec15b 100644
--- a/arch/riscv/kernel/tests/Kconfig.debug
+++ b/arch/riscv/kernel/tests/Kconfig.debug
@@ -42,6 +42,19 @@ config RISCV_KPROBES_KUNIT
=20
          If unsure, say N.
=20
> +config RISCV_KPROBES_SIMULATE_KUNIT
> +       tristate "KUnit test for riscv kprobes instruction simulation" if=
 !KUNIT_ALL_TESTS
> +       depends on KUNIT
> +       depends on KPROBES
> +       default KUNIT_ALL_TESTS

[Severity: High]
Will this default KUNIT_ALL_TESTS cause CI pipelines to break?

Since the test iterates through all 32-bit integers, it appears it could
cause standard testing environments to timeout or lockup when they enable
all tests.

> +       help
> +         Enable testing for riscv kprobes instruction simulation. Useful=
 for

[ ... ]

diff --git a/arch/riscv/kernel/tests/kprobes/test-kprobes-simulate.c b/arch=
/riscv/kernel/tests/kprobes/test-kprobes-simulate.c
new file mode 100644
index 0000000000000..d82706685823d
--- /dev/null
+++ b/arch/riscv/kernel/tests/kprobes/test-kprobes-simulate.c
@@ -0,0 +1,250 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +
> +#include <linux/kernel.h>

[ ... ]

> +static void test_kprobe_simulate_riscv(struct kunit *test)
> +{
> +	unsigned int addr =3D 0xdeadbeef;
> +	unsigned int i =3D 0;
> +
> +	do {
> +		struct pt_regs regs =3D { 0 };

[Severity: High]
Is it safe to run a 4.29 billion iteration loop inside the kernel without
yielding the CPU?

Looking at test_kprobe_simulate_riscv(), there doesn't appear to be any
mechanism like cond_resched() inside the loop or the simulated functions.
Won't this monopolize the CPU and reliably trigger the soft lockup watchdog
or RCU stall detectors?

[Severity: Medium]
Does initializing the registers to zero on every iteration reduce the cover=
age
of conditional branches?

If source registers like rs1 and rs2 are never populated with non-zero valu=
es,
won't the branch conditions evaluate to a single static outcome? For exampl=
e,
a beq (0 =3D=3D 0) will always be true, and bne (0 !=3D 0) will always be f=
alse.
This seems to skip testing the alternate branch paths.

> +
> +		if (riscv_insn_is_jal(i)) {

[ ... ]

> +		} else if (riscv_insn_is_auipc(i)) {
> +			s32 offset =3D riscv_insn_auipc_extract_imm(i);
> +			u32 rd_index =3D riscv_insn_auipc_extract_xd(i);
> +
> +			simulate_auipc(i, addr, &regs);
> +
> +			KUNIT_EXPECT_EQ_MSG(test, regs.epc, addr + 4,
> +					    "auipc instruction (0x%x) incorrectly simulated", i);
> +
> +			if (rd_index)
> +				KUNIT_EXPECT_EQ_MSG(
> +					test,
> +					riscv_insn_reg_get_val((unsigned long *)&regs, rd_index),
> +					(unsigned long)addr + offset,
> +					"auipc instruction (0x%x) incorrectly simulated", i);

[Severity: Medium]
Does extracting the expected values using the same macros as the implementa=
tion
make the test tautological?

If a macro like riscv_insn_auipc_extract_imm() is flawed, both the test and
the implementation will compute the identical incorrect value, causing the
test to spuriously pass.

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260621-riscv_insn=
_table-v2-0-7f0810ee2274@gmail.com?part=3D4
