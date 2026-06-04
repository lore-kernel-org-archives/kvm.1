Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D72B14014A1
	for <kvm@vger.kernel.org>; Thu,  4 Jun 2026 13:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780580404; cv=none; b=ekWjZqJE2CqIcRHQJJHc1bwHY6laP1aDk+b7Ys8ZK+XPtgqSxrQCCdk6kiY4e0tpLUypJBggF4EOYZpDxIOaBABb+GaXlBrLl0uef8uV6cMktmsC2Anq4qYTAyA9y1jOdPRF58WnKdDcHfv4sbXWG36npgP/wTsSi9MF76Q/KTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780580404; c=relaxed/simple;
	bh=OM5Z4fQNeXwKpEMDODppIK4+LiMMqkdC6dibUUTFc+M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hVjwkMuH4sS6AFJuj2OserIT3x0OliH/+ZyErlq+PKpJlCWbfEpmaKmeRX0FVC9akjKRznjRcqNp/q43xqTN/aeu4w0pSIkfHwVsZk+UNJGw3n1oyCWojOc/3yEgOTYUHFbyDy1EpkzCJn6LUs2EtOeBHxIxXjpWMu2QxYIAISE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QSz2tMSp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QSz2tMSp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 984AC1F00893;
	Thu,  4 Jun 2026 13:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780580403;
	bh=LVr55RISjXEnP2Z8MtFuSNmrfsv1VmtIEP7ZeMfbMWg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QSz2tMSpAbIOvwAMpYCRgNAs2XzLwIj3+h80DX6N/fWrzxOfr8KWERESLng1mR3Pr
	 lwDAm3t89vZ9lpS8yuhtubDRTyOKcAKZNFuYOsI2annQXhRFuuBuEuRs0lECTSk9XS
	 FqU7ol/v/Ep/PjjWqgWNVNlWTwWGKx8GaFht7zug2IuJHbZ8vVUCjNxrMr0bkt9CmK
	 t0xsHSvZrJakjvZs0sBKQhnRmMKUhktfnNqNVqpMwDXEOnji6bYKtiGI6fI9m+8Bfl
	 NNmvvXon751ousf2lIuwOWeB3slqfuWg/wcBYe7G8qHZEinVJgz/458KBdPPPuTTVe
	 O8HaaWXAVbXWQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 6/9] riscv: kexec: Switch to trampoline page table
 before norelocate
Reply-To: sashiko-reviews@lists.linux.dev
To: fangyu.yu@linux.alibaba.com
Cc: kvm@vger.kernel.org
In-Reply-To: <20260604132418.15725-7-fangyu.yu@linux.alibaba.com>
References: <20260604132418.15725-7-fangyu.yu@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 04 Jun 2026 13:40:03 +0000
Message-Id: <20260604134003.984AC1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] Missing `sfence.vma` after clearing `CSR_SATP` causes a fatal =
Instruction Page Fault on kexec.
--

commit 4cdd8f4ea42becec74890b3443cd153befa568f3
Author: Fangyu Yu <fangyu.yu@linux.alibaba.com>

riscv: kexec: Switch to trampoline page table before norelocate

This commit updates riscv_kexec_norelocate to act as a two-pass trampoline,
allowing it to drop kernel page tables while still executing from a mapped
address. It also replaces the previous stvec-based exception handoff with a
direct jump to the target entry.

> diff --git a/arch/riscv/kernel/kexec_relocate.S b/arch/riscv/kernel/kexec=
_relocate.S
> index af6b99f5b0fd9..8cfdf6f4032a8 100644
> --- a/arch/riscv/kernel/kexec_relocate.S
> +++ b/arch/riscv/kernel/kexec_relocate.S
[ ... ]
> @@ -198,14 +220,8 @@ SYM_CODE_START(riscv_kexec_norelocate)
>  	csrw	CSR_SCAUSE, zero
>  	csrw	CSR_SSCRATCH, zero
> =20
> -	/*
> -	 * Switch to physical addressing
> -	 * This will also trigger a jump to CSR_STVEC
> -	 * which in this case is the address of the new
> -	 * kernel.
> -	 */
> -	csrw	CSR_STVEC, a2
>  	csrw	CSR_SATP, zero
> +	jr	a2
> =20
>  SYM_CODE_END(riscv_kexec_norelocate)

[Severity: Critical]
Does this sequence require an sfence.vma instruction after clearing
CSR_SATP?

According to the RISC-V Privileged Architecture specification, writes to the
satp register do not imply any synchronization. A subsequent instruction fe=
tch
may still use the old satp value unless explicitly synchronized with an
sfence.vma instruction.

Without sfence.vma, the CPU pipeline is allowed to fetch the instruction at
a2 (the start of the new kernel) using the old satp value. Because a2 is a
physical address and is not identity-mapped in the trampoline page table,
this fetch could trigger an instruction page fault.

Since the stvec override was removed by this patch, the trap would attempt
to vector to the old kernel's default trap handler. As that handler is also
unmapped in the trampoline, this sequence appears to result in a double fau=
lt
and a system hang during kexec.

If a similar pattern is introduced for riscv_kexec_relocate_entry later in
this series, it might also need an sfence.vma to avoid a page fault when
fetching the relocation code.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260604132418.1572=
5-1-fangyu.yu@linux.alibaba.com?part=3D6
