Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 186FC350285
	for <kvm@vger.kernel.org>; Mon, 22 Jun 2026 04:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782102609; cv=none; b=d1V1je+hUVoCbMqO5FZtmd7o+KaxEBDWwNpTeWdFwi7arLMmz2HxmsBnoI58q1SiA96xzf2pDYO+gvV1uc4n/9POez5SVVvSvpMNtBtLlItXd3c1a5JXf8skUiNRkpt+t1xewReZFzyWODODw7iRKMjoyNu1P+F3YJnYQYl8bOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782102609; c=relaxed/simple;
	bh=qybzJItKx6y4cK6b/QjR8mK+aLLzcUvu1/X2roIf9SE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gpwg0tV24njZ4e5y6WFm2XYcwLcokYF9Js+ynIvXkdYLJSrpgDb5dIDDbOf7wTHjTQ2x76ddEZoKZbeGwpLWne0JnwFTvmnh/BBHgCPfCpQFnbXLO5paCHtvMqwNC0ljSxXh4cyvtbTSP2p71j+voUrPR83iRy10csBVDbujsJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JmRo0EQw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JmRo0EQw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBE381F000E9;
	Mon, 22 Jun 2026 04:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782102608;
	bh=/iT8yENSe6vEqhcSqdk2BQ2j2E4cLoYrN+sgJo5br30=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JmRo0EQwklmX+0+HzYSxRR2CK5UJGVFxpAF7lp1j8L4D+u2ErVOW7z7b22ZtIVSuF
	 VsJ5gj/+pD2tv6eplMCyxJW3avBVf0GTkJj4aEM3jAMgKt+65Bg8yIXBMTZIj2uFbE
	 7Z3VziKcDUewXDuqQyNfi3eUQQ2vz73leTz2ZfdFpmmtoOKIFHfWiSqfWIfLvj+1iW
	 HVsObbqpUkiEjiwOqr0p8q/0jDjJ73gek6GFuU6/cPFzl3WvoowlIkE+nDF8/sXn/5
	 ELHgKgzpA5Y/N+IY637LQfbYZXP9/osab/kt0p/SmXn6MbhsLfGDAETZQp7tQ4I2xD
	 SwfRGCIEEJ+wQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 14/16] riscv: kvm: Use generated instruction headers
 for csr emulation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Charlie Jenkins via B4 Relay" <devnull+thecharlesjenkins.gmail.com@kernel.org>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260621-riscv_insn_table-v2-14-7f0810ee2274@gmail.com>
References: <20260621-riscv_insn_table-v2-0-7f0810ee2274@gmail.com>
 <20260621-riscv_insn_table-v2-14-7f0810ee2274@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 22 Jun 2026 04:30:07 +0000
Message-Id: <20260622043007.CBE381F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] KVM's MMIO emulation unconditionally overwrites the hardwired `x0`=
 register within the guest's context, causing subsequent KVM-emulated instr=
uctions to use non-zero garbage values for `x0`.
--

commit 7feea165a4c11a607fc4f7aca428cb92288c4147
Author: Charlie Jenkins <thecharlesjenkins@gmail.com>

riscv: kvm: Use generated instruction headers for csr emulation
   =20
Migrate the csr emulation code to use the generated instruction headers
instead of the hand-written instruction composition functions.

> diff --git a/arch/riscv/kvm/vcpu_insn.c b/arch/riscv/kvm/vcpu_insn.c
> index c5a70de4a5790..d666cd24f8c0e 100644
> --- a/arch/riscv/kvm/vcpu_insn.c
> +++ b/arch/riscv/kvm/vcpu_insn.c
[ ... ]
> @@ -154,7 +150,7 @@ static int csr_insn(struct kvm_vcpu *vcpu, struct kvm=
_run *run, ulong insn)
>  	#define GET_REG(_rd) (*((unsigned long *)(&vcpu->arch.guest_context) + =
_rd))
> =20
>  	int i, rc =3D KVM_INSN_ILLEGAL_TRAP;
> -	unsigned int csr_num;
> +	unsigned int csr_num, rd;
>  	const struct csr_func *tcfn, *cfn =3D NULL;
>  	ulong val =3D 0, wr_mask =3D 0, new_val =3D 0;
> =20
> @@ -163,26 +159,32 @@ static int csr_insn(struct kvm_vcpu *vcpu, struct k=
vm_run *run, ulong insn)
>  		wr_mask =3D -1UL;
>  		new_val =3D GET_REG(riscv_insn_csrrw_extract_xs1(insn));

[Severity: High]
This isn't a bug introduced by this patch, but does the newly introduced
GET_REG macro expose a pre-existing corruption of guest_context.zero?

In RISC-V, the x0 register is hardwired to 0. If a guest executes an MMIO
load with destination register x0, KVM unconditionally writes the loaded da=
ta
to guest_context.zero:

arch/riscv/kvm/vcpu_insn.c:kvm_riscv_vcpu_mmio_return() {
    ...
    *((ulong *)(&vcpu->arch.guest_context) + vcpu->arch.mmio_decode.rd) =3D
        (long)data << shift >> shift;
    ...
}

This patch changes csr_insn() to unconditionally read the source register
using GET_REG() without verifying if the register is x0.=20

If a guest triggers an MMIO load to x0, and then executes a CSR instruction
such as csrrw x0, sscratch, x0, will KVM read the corrupted non-zero value
from guest_context.zero and write it into the guest's CSR?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260621-riscv_insn=
_table-v2-0-7f0810ee2274@gmail.com?part=3D14
