Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B36351C1C
	for <kvm@vger.kernel.org>; Mon, 22 Jun 2026 04:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782101901; cv=none; b=YV/sn+pNXulP1iznrEKNIwKGDGzCWspj5wcjfonb0AsgNXac+vBEAVcjMkPU1h8YHhfSoahoHw3voJhc++egeGYQJ7QxbyAIR7GAJ9jTQiPhe/UG3ct+0KTnCVf+ceBkRcXZ3cJrNurppVrJAZIcvS7D+EjGDg4IOSzs8JbiJek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782101901; c=relaxed/simple;
	bh=S7RoODXi/KMHwaISNJRRiywEtqmd4ZJ+Cpw9pH0mMmI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mALQPwD2Rbp9yHdf+d8ZVnhOQz8FHD9H+qM3O/O7GrnSlodq7thMjoRPkJ/LvRpzl6/BqyAA4H5hZMCKQNl9t4AG+PQE8F6krIPmtaXr4PByn8uOBBzolYKj1F3LQsVIkrhuYNvOS6rZH7g6za+FSWXqnWDZUCDVHzdWQNjUifI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RjoteEsN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RjoteEsN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5410D1F00A3A;
	Mon, 22 Jun 2026 04:18:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782101900;
	bh=Ykfi6IyxbHOcbngi6BOZzgYmb17f2PHoq6AR4yaJ8bY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RjoteEsNtzdXV+yj5TuZdtUIR1ASpdZNu/pq+AaoTdbgK75Sp2JtnAwOB1HBgB4sa
	 0Urrswc987T4/i0fG7s2PGKlV+4X2VyaMaexUU9zT1JJ8F/vND+h/XVm9V0StQfN/U
	 Jia0rN61JuDXx0fs/c68F87OJeyNw+mYlZANRwC5WuBlz4lg/5I/1vqLi/+g9Gtl7e
	 C0c/btujzYiArOdVvYuerywM9Itx9GS2MknI6n+k6My2hyrTfEqYKsd26Bdm/2b0sE
	 ZdGeZhBJwDA3O7zZhgXEwAyCvLlq7/FJRZcR1ow90O9XBIbTU56sqrO1ZgHA7AGdXO
	 HlD5+ajrSUyVA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 08/16] riscv: kvm: Use generated instruction headers
 for csr code
Reply-To: sashiko-reviews@lists.linux.dev
To: "Charlie Jenkins via B4 Relay" <devnull+thecharlesjenkins.gmail.com@kernel.org>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260621-riscv_insn_table-v2-8-7f0810ee2274@gmail.com>
References: <20260621-riscv_insn_table-v2-0-7f0810ee2274@gmail.com>
 <20260621-riscv_insn_table-v2-8-7f0810ee2274@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 22 Jun 2026 04:18:20 +0000
Message-Id: <20260622041820.5410D1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] KVM's `guest_context.zero` can be overwritten by MMIO reads with `=
rd=3Dx0`, corrupting subsequent emulated instructions that read `x0`.
--

commit 6e0c9adf0592e2c6310d9a0a01fa605f82581d3e
Author: Charlie Jenkins <thecharlesjenkins@gmail.com>

riscv: kvm: Use generated instruction headers for csr code

Migrate the csr parsing code to use the generated instruction headers
instead of the hand-written instruction composition functions.

> diff --git a/arch/riscv/kvm/vcpu_insn.c b/arch/riscv/kvm/vcpu_insn.c
> index f09f9251d1f0a..8ccf6ec722f03 100644
> --- a/arch/riscv/kvm/vcpu_insn.c
> +++ b/arch/riscv/kvm/vcpu_insn.c
> @@ -146,43 +146,44 @@ int kvm_riscv_vcpu_csr_return(struct kvm_vcpu *vcpu=
, struct kvm_run *run)
> =20
>  static int csr_insn(struct kvm_vcpu *vcpu, struct kvm_run *run, ulong in=
sn)
>  {
> +	#define GET_REG(_rd) (*((unsigned long *)(&vcpu->arch.guest_context) + =
_rd))

[Severity: High]
This isn't a bug introduced by this patch, but KVM's software copy of the
zero register (which this GET_REG macro can read) can be permanently
corrupted by a pre-existing issue in MMIO emulation.

When an MMIO load uses x0 as the destination register (e.g., lw x0, (a0)),
kvm_riscv_vcpu_mmio_return() in arch/riscv/kvm/vcpu_insn.c unconditionally
stores the result:

    *((ulong *)(&vcpu->arch.guest_context) + vcpu->arch.mmio_decode.rd) =3D
        (long)data << shift >> shift;

Because rd is 0, this overwrites guest_context.zero at index 0.

Unlike kvm_riscv_vcpu_csr_return() which checks if (vcpu->arch.csr_decode.r=
d)
before writing, the MMIO return path lacks this guard.

Since instruction emulation like the CSR emulation here uses x0 as an
operand and reads from guest_context via GET_REG(), could the corrupted
non-zero value be used instead of the hardware-mandated 0, leading to
incorrect guest execution?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260621-riscv_insn=
_table-v2-0-7f0810ee2274@gmail.com?part=3D8
