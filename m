Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D89A834A767
	for <kvm@vger.kernel.org>; Sat, 23 May 2026 12:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779539424; cv=none; b=lGajrzl5GgfeZzH4C0rwe/S9rfweKXtie3Z/sgTKKxwsIUjhtkdwe/swwOP7IW6Gn9B9ESb2iLJGVs+meUgg2BJdmlYTbS3gYLD/aZtLq46jYe9Uoaf4e88FTn9eaT1FubdoLM4nvrRJJLo2jFs99DkWe65n4WXa4fPqLVOk8qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779539424; c=relaxed/simple;
	bh=qfwd2gtzHixi2Cx6b9F6dm+QS5q3MB+L2+cDRnqaeM0=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=h9MhdTIOUyU+y4ZDTLwQtAHvD2k6ETainUIuzH7HtCyBpYZo56Ujf/lcqPk9/KjvtyliaO30xZMT4hFTwjHo6x/UezSA2+5rvss5EFUnFGFtmTxZoceP2mQWWrloqm8OiryCqxC3fUbknWtJkMZGYM8creEtJALV2WFh7u9e17k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=au4Rvsez; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="au4Rvsez"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64A321F000E9
	for <kvm@vger.kernel.org>; Sat, 23 May 2026 12:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779539423;
	bh=PvrVL/urDdI0/P/t8T6iBh6+B/dHAY4rtioL3v9eqAo=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=au4Rvsezf3/SdmC91cB4YCDL0PkkPF077mE0JOEDkRwa0z0gAQ3miKgV1JVd/+iWu
	 YlXvf6vHwk/oaA8vGnZOjT0ur1/l4BzMe27J/PGMoONgwEMAYUkM0EvrVL5tDf8sz2
	 dSvOBSTH0DLtxdjt1kPsl/ttRE3sfOOjrD+NEg+X2MQdwmrEFY5oz5OfVUu8pTL1KN
	 UtUtjiwTngve3P7VO8S9N74XAwaphKte6S3Uf1qrz9ZEqym94nihYsUkHNL0i0b4Ce
	 OxrruJbF0EKwSB97glahi2F6+rw/LTN//RCdCG31bLf5w3aeJm7qoOhdUe23mRqYes
	 eks7u7sQpATYg==
From: sashiko-bot@kernel.org
Subject: Re: [RFC v2 3/5] KVM: PPC: selftests: add support for powerpc
Reply-To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
In-Reply-To: <6e0c74f1273a4baf652d84820ae83696e77263d9.1779524962.git.ritesh.list@gmail.com>
References: <6e0c74f1273a4baf652d84820ae83696e77263d9.1779524962.git.ritesh.list@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 23 May 2026 12:30:22 +0000
Message-Id: <20260523123023.64A321F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Guest registers r1 (stack pointer) and r2 (TOC pointer) are not =
saved to or restored from ex_regs during exception handling.
- [Medium] Overly restrictive PTE assertions in addr_arch_gva2gpa() prevent=
 address translation for non-RWX pages.
--

commit b672003494da996fee181637da999ccf8c28f3e8
Author: Nicholas Piggin <npiggin@gmail.com>
Subject: KVM: PPC: selftests: add support for powerpc

This commit implements KVM selftests support for powerpc (Book3S-64).
It includes virtual memory support for the radix MMU, ucall implementation
via PAPR hcalls, and real-mode guest interrupt handling.

> diff --git a/tools/testing/selftests/kvm/lib/powerpc/handlers.S b/tools/t=
esting/selftests/kvm/lib/powerpc/handlers.S
> new file mode 100644
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/lib/powerpc/handlers.S
[ ... ]
> +virt_handle_interrupt:
> +	stdu	%r1,-INT_FRAME_SIZE(%r1)
> +	mr	%r3,%r31
> +	bl	route_interrupt
> +	ld	%r4,(32*8)(%r31) /* NIA */
> +	ld	%r5,(33*8)(%r31) /* MSR */
> +	ld	%r6,(35*8)(%r31) /* LR */
> +	ld	%r7,(36*8)(%r31) /* CTR */
> +	ld	%r8,(37*8)(%r31) /* XER */
> +	lwz	%r9,(38*8)(%r31) /* CR */
> +	mtspr	SPR_SRR0,%r4
> +	mtspr	SPR_SRR1,%r5
> +	mtlr	%r6
> +	mtctr	%r7
> +	mtxer	%r8
> +	mtcr	%r9
> +reg=3D4
> +	ld	%r0,(0*8)(%r31)
> +	ld	%r3,(3*8)(%r31)
> +.rept 28
> +	ld	reg,(reg*8)(%r31)
> +	reg=3Dreg+1
> +.endr

[Severity: Medium]
Are r1 (stack pointer) and r2 (TOC pointer) missing from the restore sequen=
ce?

Since they aren't restored here, tests cannot modify the stack pointer duri=
ng
exception handling.

[ ... ]
> +handle_interrupt:
> +reg=3D4
> +.rept 28
> +	std	reg,(reg*8)(%r13)
> +	reg=3Dreg+1
> +.endr

[Severity: Medium]
Does this sequence skip saving r1 and r2 into ex_regs?

If they are skipped, the C handlers receive uninitialized values for these
registers in ex_regs->gprs[1] and gprs[2], meaning they cannot inspect the
stack pointer or TOC pointer at the time of the exception.

> diff --git a/tools/testing/selftests/kvm/lib/powerpc/processor.c b/tools/=
testing/selftests/kvm/lib/powerpc/processor.c
> new file mode 100644
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/lib/powerpc/processor.c
[ ... ]
> +gpa_t addr_arch_gva2gpa(struct kvm_vm *vm, gva_t gva)
> +{
[ ... ]
> +	ptep =3D virt_get_pte(vm, pt, gva, level, NULL);
> +	pte =3D be64_to_cpu(*ptep);
> +
> +	TEST_ASSERT(pte,
> +		"PTE not present at level: %u gva: 0x%lx pte:0x%lx\n",
> +		level, gva, pte);
> +
> +	TEST_ASSERT((pte & PTE_VALID) && (pte & PTE_LEAF) &&
> +		    (pte & PTE_READ) && (pte & PTE_RW) && (pte & PTE_EXEC),
> +		    "PTE not valid at level: %u gva: 0x%lx pte:0x%lx\n",
> +		    level, gva, pte);

[Severity: Medium]
Is it possible for tests to map memory without write or execute permissions
(e.g., read-only or non-executable pages)?

If so, this assertion will falsely trigger and abort the test during virtual
to physical address translation. Should this check only verify PTE_VALID and
PTE_LEAF to support testing diverse page permissions?

> +
> +	return (pte & PTE_PAGE_MASK) + (gva & (vm->page_size - 1));
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1779524962.gi=
t.ritesh.list@gmail.com?part=3D3
