Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D522F3C37
	for <kvm@vger.kernel.org>; Wed, 22 Jul 2026 06:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784702395; cv=none; b=G1Jd55pICzCC7G7yUFOmEfLNyVZUeZxGgzcECKPeUwcKFhl3+m2NyGZELxv3tJlebReWS6qHwxIx8cG2kdjmqAiYSgkrz1DoYtY0RjmvRsLhnWg7j2WpIheB9BucaZUJYII/zxEuuNLn9Rdw/5ZNk/05OYHiLqhv/zat5mYtWSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784702395; c=relaxed/simple;
	bh=dXRw/xSnLp6YXM/e6TjGE4B4Di70vuKouR0rtn3edEE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jC2Dm6hETPUG50RxT3Kq2TyZ7J4RfqVTAXlO7bQT6h/mUB9iAYTSY5+tS60QAoY3lhbN4RJbkPqGWT/3H/Ct7WJY377movjQzB7jWyzyvSVufMOti+NknekJq3VrlxR92ntbHupDIJ7ChQPLGQDbmiZF5Y6YABokG6UTpVmgT4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jx9Stzna; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jx9Stzna"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3BE91F00A3A;
	Wed, 22 Jul 2026 06:39:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784702393;
	bh=kX8hm2StCuMQ9cProXKCZjMJNnfZb5II2Q2BPkOlPV4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jx9StznaGHUpP9eZJ98TJO0Xe6iBoqTybWp9ZKkv+8WAnBW76f2Cvwd53yjkdWNea
	 VUr7mWDVP3jevMkm1jT0NHJOlIrXaz/8c7o2HSTEvPTE64e+SQpB3g0UCvnz9xbaWc
	 r4CmYKkq1zLm3UT6deRR/xPpB+eCnBak3Bd36RIwkJEvgt0vxd03e7SL0c4orzKvyh
	 ME7a05zHDiEzYYZNyYz/L6YGiGBT2vaaifZFnZdQ+S5F/7H3bVJr1qcpqZ7rJflxK8
	 rrIzCnNusjPbRwJCiK6kGcZT92tYkCW1WWIxyRC6TkMCFA9F4a0uOyA+952qbZe7db
	 5jzacFT58MvfQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6] KVM: selftests: riscv: Add lazy V extension
 enablement for guests
Reply-To: sashiko-reviews@lists.linux.dev
To: JinRui <jinrui@haiwei.tech>
Cc: kvm@vger.kernel.org
In-Reply-To: <A0B8068D0600FC75+20260722062804.738428-1-jinrui@haiwei.tech>
References: <20260721122442.351865-1-jinrui@haiwei.tech>
 <A0B8068D0600FC75+20260722062804.738428-1-jinrui@haiwei.tech>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Jul 2026 06:39:53 +0000
Message-Id: <20260722063953.A3BE91F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Signed integer vulnerability in `vcpu_id` allows negative out-of=
-bounds array access to `handlers->v_epc`.
--

--- Patch [1]: [PATCH v6] KVM: selftests: riscv: Add lazy V extension enabl=
ement for guests ---
commit 5cdbaafd3cc51d972a0a5c63e8e0d160a2000c26
Author: jinrui <jinrui@haiwei.tech>

KVM: selftests: riscv: Add lazy V extension enablement for guests

This commit adds lazy V extension enablement for KVM selftest guests on
RISC-V to handle unhandled EXC_INST_ILLEGAL traps due to compiler
auto-vectorization. It replaces the unexpected trap handler with the full
exception vector table and updates route_exception() to enable the V
extension in the guest's saved status register when hitting illegal
instruction faults.

> diff --git a/tools/testing/selftests/kvm/lib/riscv/processor.c b/tools/te=
sting/selftests/kvm/lib/riscv/processor.c
> index ded5429f34483..b7449dffe660e 100644
> --- a/tools/testing/selftests/kvm/lib/riscv/processor.c
> +++ b/tools/testing/selftests/kvm/lib/riscv/processor.c

[ ... ]

> @@ -432,6 +453,46 @@ void route_exception(struct pt_regs *regs)
>  		ec =3D 0;
>  	}
> =20
> +	/*
> +	 * Handle V (vector) extension lazy enablement before any

[ ... ]

> +		if (handlers && handlers->v_available && !(regs->status & SR_VS)) {
> +			int vcpu_id;
> +
> +			asm volatile("csrr %0, sscratch" : "=3Dr" (vcpu_id));
> +			if (vcpu_id < handlers->v_epc_capacity &&
> +			    handlers->v_epc[vcpu_id] !=3D regs->epc) {

[Severity: Medium]
Could this lead to negative out-of-bounds array access on handlers->v_epc?

The vcpu_id is declared as a signed int and populated directly from the
sscratch register. If a vCPU is created with a large ID (which are 32-bit
unsigned) or a test writes a value with the highest bit set to sscratch,
vcpu_id evaluates to a negative integer.

Because it is signed, the upper-bound check:
vcpu_id < handlers->v_epc_capacity

would incorrectly pass for negative values, leading to an out-of-bounds
read and write to handlers->v_epc[vcpu_id], potentially corrupting adjacent
struct members.

> +				handlers->v_epc[vcpu_id] =3D regs->epc;
> +				regs->status |=3D SR_VS_INITIAL;
> +				return;
> +			}
> +		}
> +	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/A0B8068D0600FC75+20=
260722062804.738428-1-jinrui@haiwei.tech?part=3D1
