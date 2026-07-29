Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F3C3DD519
	for <kvm@vger.kernel.org>; Wed, 29 Jul 2026 07:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785309447; cv=none; b=X7s7woXJMNlurXcduNp0KQbqZZaJKi6uxzAf2lHeE+r1r/cA184qIC+2ubctxmBjIcwOtioNNMo8r6mGgDYBbahnzi8an4FotKGxHL6qA6eYdg1qst46W9zryVfbRs9BsTKYDf1hrpDUl2TRbF04fqflOXCMVbNIA2bTcaOv4IQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785309447; c=relaxed/simple;
	bh=RKJ1lHNUmFLxFNf7hY0DxFQZ9VvwTplpfXqPV5lC908=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PhEZ4OwmJt62w0WEXPShCyDD6YT3AFfiNVyDHdD7MyNoLXcUyb6Y6Xe+vvoJPMMWrA6xOLXGE+1Agv6CRJ586GWNEgoMrOyn3cpK6za8c5qt59mHNtWTOL67XepKiueWxgd5iJNRtnU8TT8FTfGqzI1Ln9EscvbXRW44SZCWVqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FHnhls7L; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FHnhls7L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DE841F000E9;
	Wed, 29 Jul 2026 07:17:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785309442;
	bh=fkTR2IUcTHFaCvGGhLj2V8CcolpwiCUC0oWSZZYHmVM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FHnhls7L16mzroV1GfSIeBYfdrW0ZhlJ90f8bXmpWjIECn6YNrAyOYnBG5epdKe7l
	 dLSWOguakXN9enkG7dU7JG+NjsUnlgUAWw35pXyBoTaqNY8vlPDzV3fnGXLNdR2z0e
	 3EMvuAqRodNg9NqedlGUbNmGrFsHfESzllClegeSgsIGRE3ToS8Kuln/NUy6PSmbQz
	 Sx/2+DhV7umVN+t4GJTOhLGrv6Mf8bJIYQXO4dFLAihbgH+H+q7q5KDIhD8GpiusnG
	 A7MzESoslSgAVx0mFhUa+WfcyrGaiPYy6DGK/GwFZn8/YKhcBv6VpAmpuXZIIFBxY2
	 lFvuN5Oir87oQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] RISC-V: KVM: Fix spurious -EEXIST and clean up gstage
 fault path types
Reply-To: sashiko-reviews@lists.linux.dev
To: Bingyu.Xian <shanbeeyoo@gmail.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260729070749.730218-1-shanbeeyoo@gmail.com>
References: <20260729070749.730218-1-shanbeeyoo@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Jul 2026 07:17:21 +0000
Message-Id: <20260729071722.6DE841F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The patch fails to resolve the 34-bit GPA truncation on RV32 becau=
se the address calculation `(trap->htval << 2)` is still evaluated using 32=
-bit arithmetic before assignment.
--

--- Patch [1]: [PATCH] RISC-V: KVM: Fix spurious -EEXIST and clean up gstag=
e fault path types ---
commit 9da8ae12634bbc92cd912d48c6458250997cb454
Author: Bingyu.Xian <shanbeeyoo@gmail.com>

RISC-V: KVM: Fix spurious -EEXIST and clean up gstage fault path types

This commit updates the G-stage page fault path to treat -EEXIST from
kvm_riscv_gstage_map_page() as a success, aligning RISC-V with other
architectures. It also updates the type of vma_pageshift to unsigned int
and fault_addr to gpa_t, intending to prevent 34-bit guest physical address
truncation on RV32.

[ ... ]

> diff --git a/arch/riscv/kvm/vcpu_exit.c b/arch/riscv/kvm/vcpu_exit.c
> index 6c8530b9f29ed..76cceecee5aba 100644
> --- a/arch/riscv/kvm/vcpu_exit.c
> +++ b/arch/riscv/kvm/vcpu_exit.c
> @@ -17,7 +17,8 @@ static int gstage_page_fault(struct kvm_vcpu *vcpu, str=
uct kvm_run *run,
>  {
>  	struct kvm_gstage_mapping host_map;
>  	struct kvm_memory_slot *memslot;
> -	unsigned long hva, fault_addr;
> +	unsigned long hva;
> +	gpa_t fault_addr;

[Severity: High]
This is a pre-existing issue, but does the calculation for fault_addr still
truncate the address on RV32 before this assignment?

The commit message notes this type change is meant to prevent 34-bit guest
physical addresses from being truncated. However, looking further down in
gstage_page_fault(), the actual calculation is:

    fault_addr =3D (trap->htval << 2) | (trap->stval & 0x3);

Because trap->htval is an unsigned long, the shift (trap->htval << 2) is
evaluated as a 32-bit operation on RV32. This discards the upper bits of
the 34-bit guest physical address before the final result is widened and
stored in the new 64-bit gpa_t variable.

Should trap->htval be explicitly cast to gpa_t or u64 before the shift
operation to ensure the higher bits are preserved?

>  	bool writable;
>  	gfn_t gfn;
>  	int ret;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260729070749.7302=
18-1-shanbeeyoo@gmail.com?part=3D1
