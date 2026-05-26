Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1043C341AD6
	for <kvm@vger.kernel.org>; Tue, 26 May 2026 15:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779807624; cv=none; b=ZLuW+efLRG93a3Vewb1joqxZvvXCpxIV0/oE/RrNiCON7A0FBNYKWA9i4iE+OqUqWy65kuqHYSYY46GXP+FoufuZ0Twy+NteXAp43qr5DK3NhCsEbagYkQwPnJmRDP4i0JkQ0UxDgWYM4DmXG0Q8dOEvs0F3qBqGizBWWVs8ih0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779807624; c=relaxed/simple;
	bh=tbhtKzSSsynZMC8olhd/mAf6FgFYxlQfdbDkuGXavWY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Mu9FNPNLrv4fNk6CZ5D/IdKWbsf2rIc4IFdPFzaSzgDiqNIHcEi6yik4hUW1Wl3GrCeXN9fjTLohC+zoyD07fBng0IzlVmRSCesUseeIbIj/e5eMiQu9PMdW9tNnE70MJGSEJcDSAYrIkmjKpNJolNvnHSnc1MJLabbJdyjbz7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iuAiC45w; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iuAiC45w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65E0B1F000E9;
	Tue, 26 May 2026 15:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779807622;
	bh=xXAjwB3YegN9l4M8Ld6fn+Y0Ke+EBQbyr7plwRr7eTI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iuAiC45wXVXcBsR3YTQnesb2bJXFz6Vx7wEpwiDdlLzLCZfljCb50mPqmncE1q3O1
	 CKMD/5drgOTEXDm+cT/F15GKFCp54UhHF2gbvCRlrOaKnugwbj484yTqqgx+Cjm9Kz
	 u1B9JzjaRA2iFuSKC0bVfbmaWwwI6R7NPTIVMdqAGUpPkC3nlYWu+JrEH5EytcwjXk
	 v6dgW7gSLz87ggjgweV8DKVlid5HHm2XCGi7d+9HJj4NSgqzXed0s7OqmN+8aQxTfP
	 JnUCtrlxxzf9RPQyAN20NW3dnSy5YyvVrowdT3yDjmBZvIKyUzogFp1v2kEyYkANXQ
	 iMW5eHW2iQfbg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/7] riscv: kexec: Switch to trampoline page table
 before norelocate
Reply-To: sashiko-reviews@lists.linux.dev
To: fangyu.yu@linux.alibaba.com
Cc: kvm@vger.kernel.org
In-Reply-To: <20260526125009.2404-5-fangyu.yu@linux.alibaba.com>
References: <20260526125009.2404-5-fangyu.yu@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 26 May 2026 15:00:21 +0000
Message-Id: <20260526150022.65E0B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] Missing `sfence.vma` after `csrw CSR_SATP, zero` causes a fata=
l instruction fetch page fault, leading to a system hang during crash kexec.
--

commit 05a54b3ecf6222d16e88b0edb1efa0fb1ed8df09
Author: Fangyu Yu <fangyu.yu@linux.alibaba.com>

riscv: kexec: Switch to trampoline page table before norelocate

This patch converts the riscv_kexec_norelocate function into a two-pass
trampoline. This allows dropping the kernel page tables while still
executing from a mapped address, and replaces the old stvec-based handoff
with a direct jump.

> diff --git a/arch/riscv/kernel/kexec_relocate.S b/arch/riscv/kernel/kexec=
_relocate.S
> index af6b99f5b0fd9..2b9892bf04f2d 100644
> --- a/arch/riscv/kernel/kexec_relocate.S
> +++ b/arch/riscv/kernel/kexec_relocate.S

[ ... ]

> @@ -199,13 +221,13 @@ SYM_CODE_START(riscv_kexec_norelocate)
>  	csrw	CSR_SSCRATCH, zero
> =20
>  	/*
> -	 * Switch to physical addressing
> -	 * This will also trigger a jump to CSR_STVEC
> -	 * which in this case is the address of the new
> -	 * kernel.
> +	 * We are already executing from the trampoline VA with the trampoline
> +	 * page table installed, so there is no need to rely on the old flow
> +	 * of programming stvec and taking the implicit trap on SATP switch.
> +	 * Jump directly to the target entry instead.
>  	 */
> -	csrw	CSR_STVEC, a2
>  	csrw	CSR_SATP, zero
> +	jr	a2

[Severity: Critical]
Does this sequence require an sfence.vma before the jump?

According to the RISC-V Privileged Architecture Manual, writes to the satp
register do not guarantee that subsequent instruction fetches use the new
translation until an sfence.vma is executed.

Without it, the CPU might fetch the target address a2 using the active
trampoline page table instead of physical addressing. Since the crash kernel
isn't mapped in the trampoline page table, could this trigger an Instruction
Page Fault?

Without the stvec setup that was removed, the CPU would vector to the
standard kernel trap handler. Because satp is now 0, the trap handler would
be fetched as a physical address, which could result in a nested Instruction
Access Fault and a total system hang during crash recovery.

> =20
>  SYM_CODE_END(riscv_kexec_norelocate)
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260526125009.2404=
-1-fangyu.yu@linux.alibaba.com?part=3D4
