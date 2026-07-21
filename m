Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31B043BE175
	for <kvm@vger.kernel.org>; Tue, 21 Jul 2026 10:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784629524; cv=none; b=eR7lUSoxRYQaZjMM4ZpNfvTpwbUPSiRpbusREnzZyKKpWYwd7rW/nzA3WJqlMf1YCEKuWcQSAP1f3bVOUUbIY7dRKzZ7j0yr5m4HuLfN6h3BEXeD/wVo9+5EWbS/wwFj5MG4QzbTpFQYaKDzov3xEhwG3xMxUu/1cn/DANytgDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784629524; c=relaxed/simple;
	bh=NB+WVKXRyaYGeWdVMk3DOw4pdqgaWqVyxQtQZDhfy7g=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HSZ43DrDQA62f/l4UsOeDOCU04HEKB1/GUbwr1JQ9BCpapShne+FNw0gIY+FDb6kGV8CD5wdDOR5AAZrBymQ6IeMq+fOLjTo4+tOSUYIlUFAhrMU9/yGEiAGoO5x+Xm4K89WwpZNC/o0HMmwoJ3MYxsAPz5Uw6n/NeG9HKDlYng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UbTwJc0x; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UbTwJc0x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF8081F000E9;
	Tue, 21 Jul 2026 10:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784629522;
	bh=iwwckfaxYsmxuMkLlTlXq8eZ3I3+sj/tiqHCypZJR88=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UbTwJc0xJiyoe/S+klmIzFlIYhhoQX0w/qQnMTLYJWlmdYr3GvTPQ6fVmg/94At40
	 2aKDAHi6EYH/5S8gOEm+rahEfcqHDLGBDVpqAOj50E2gZfDqFNSIQ0hxwSm8cbrGDE
	 jF7aJcBJxwyD+NwTH7rPy1JRWVFcaJ1VPbsr5cWkFLzTmitYTtSrZSlifpYKMHPlWn
	 SpolBEy8owMfRMYWVdhbedMITJy6IPqtWJEcaFFWGhFtK3xJvZnTljl8YxTbEXzyrv
	 zfetfRReMln5mQfJ/yD8QuID6Ex6aKFEl0/32KntPyTSI5ovJ/V42X/XhobDHUFzEL
	 mfLIalaoXp0mA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] KVM: selftests: riscv: Add lazy V extension enablement
 for guests
Reply-To: sashiko-reviews@lists.linux.dev
To: JinRui <jinrui@haiwei.tech>
Cc: kvm@vger.kernel.org
In-Reply-To: <4FAAF34C966898C0+20260721101406.305108-1-jinrui@haiwei.tech>
References: <4FAAF34C966898C0+20260721101406.305108-1-jinrui@haiwei.tech>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jul 2026 10:25:22 +0000
Message-Id: <20260721102522.AF8081F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Lazy V extension enablement causes an inescapable infinite excep=
tion loop on hosts without the V extension when an illegal instruction is e=
xecuted.
- [Medium] Reading the live `sstatus` CSR instead of the preserved `regs->s=
tatus` creates a TOCTOU vulnerability with nested exceptions.
--

--- Patch [1]: [PATCH] KVM: selftests: riscv: Add lazy V extension enableme=
nt for guests ---
commit 2d8f4dc253676991c8c0807d4dda2a90b9cca890
Author: jinrui <jinrui@haiwei.tech>

KVM: selftests: riscv: Add lazy V extension enablement for guests

This commit introduces lazy V extension enablement for guests in RISC-V KVM
selftests to handle compiler auto-vectorization. It replaces the default
unexpected trap handler with the full exception vector table and adds a che=
ck
in route_exception() to enable V and retry the instruction.

> diff --git a/tools/testing/selftests/kvm/lib/riscv/processor.c b/tools/te=
sting/selftests/kvm/lib/riscv/processor.c
> index ded5429f34483..68577b2f48f4e 100644
> --- a/tools/testing/selftests/kvm/lib/riscv/processor.c
> +++ b/tools/testing/selftests/kvm/lib/riscv/processor.c
[ ... ]
> @@ -432,6 +438,28 @@ void route_exception(struct pt_regs *regs)
>  		ec =3D 0;
>  	}
> =20
> +	/*
> +	 * Handle V (vector) extension lazy enablement before any
> +	 * registered handler. The compiler's default march may include
> +	 * V, and auto-vectorization generates vector instructions that
> +	 * trigger EXC_INST_ILLEGAL when VS (Vector Status) in sstatus
> +	 * is Off. Enable VS to Initial and re-execute the faulting
> +	 * instruction, mimicking what a real OS kernel does.
> +	 *
> +	 * This check runs before any test-registered handler, so tests
> +	 * that install their own EXC_INST_ILLEGAL handler (e.g.
> +	 * sbi_pmu_test) are not affected.
> +	 */
> +	if (!(regs->cause & CAUSE_IRQ_FLAG) && ec =3D=3D EXC_INST_ILLEGAL) {
> +		unsigned long sstatus;
> +
> +		asm volatile("csrr %0, sstatus" : "=3Dr" (sstatus));

[Severity: Medium]
Does reading the live sstatus CSR here instead of using the preserved
regs->status create an issue with nested exceptions?

If the prologue of route_exception() uses auto-vectorized instructions, it
traps. The nested trap fixes sstatus and returns, leaving the live sstatus.=
VS
altered to Initial. The outer handler would then read the modified live
sstatus instead of the original exception state in regs->status, skipping V
enablement for the original fault.

> +		if (!(sstatus & SR_VS)) {
> +			regs->status |=3D SR_VS_INITIAL;
> +			return;

[Severity: Medium]
Can this cause an infinite exception loop on hosts that don't support the V
extension?

If a test deliberately executes an illegal instruction (like sbi_pmu_test) =
on
hardware without V support, SR_VS is hardwired to 0. The code sets
SR_VS_INITIAL and returns to re-execute, but the instruction faults again w=
ith
VS=3D0, repeating infinitely.

> +		}
> +	}
> +
>  	if (handlers && handlers->exception_handlers[vector][ec])
>  		return handlers->exception_handlers[vector][ec](regs);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/4FAAF34C966898C0+20=
260721101406.305108-1-jinrui@haiwei.tech?part=3D1
