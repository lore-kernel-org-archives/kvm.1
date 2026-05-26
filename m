Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9A97390CBD
	for <kvm@vger.kernel.org>; Tue, 26 May 2026 16:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779811351; cv=none; b=gNqNsV/QkGQNRFlACGOvIRS90+NJvsOivhuP9XhmiXId5GmZNlFLfr5auZ0gTa8v8eCMsfMpMiTqu6Q0Zn5S7FJMql59JfvMjXcpfFbatZbK2xijjqBy41nBrT8xvkRftu1RPGG2Gvvb2PF1Yr4zXMlpMMOPuDHBu6MRrXpYndI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779811351; c=relaxed/simple;
	bh=S9OGEUMGDDwqBxJQeDjRniwtTU3d0tYhrSFlsc7NF6A=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FChjHSxKDZjX3RxnVs6J6iKvEbYzHK+3Ny8PDQaQXEyCEm6nvR+wv39f1iPHZnNTO2hifJn6jkClaIUOvFRFGN6Edh9TdnmxpeR16RdOleQWoMTSfAbhy3daqirBjSmjlLojNJnULmKBeThWSUWf602mAPwqWXRqUmJMdUsbg/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MC6Zrju9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MC6Zrju9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F0F71F000E9;
	Tue, 26 May 2026 16:02:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779811349;
	bh=wExrHCn56bhU165W4U85e35+8scDGxT4F5LAwqp0RrA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MC6Zrju9SRjgsRD17pz80YAw1r/osq6Md+mrfCTa+Bb7KzlITfh/sYjWvaIaCghQE
	 /MLo59VeX1WHCX2ZCQJdZInYr/jwHFalF3NdljeNEAptm4YxDpKYyMrPSCMcYRU+Vr
	 I5nE5+rruG8C+yjZcRC7CE3nHEgJuevM0hd8DrDi3uw/YgSMxurJvqvcQ1NqAYHY3w
	 jMplp3hoelt9xZAmQYrOmOdTwq4PMW12rGlgx0iMn6LZm/dDOifpFYBhiEZ5VN/PmW
	 I1bKjlMyp407iEwsQG8MfumYqWeruSdgyl1H1xiXo1gp2tTEu4R3QtFEuwZq00UGx4
	 UoO9S4pMymW5g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 6/7] riscv: kexec: Add the relocate-trampoline
 wrapper
Reply-To: sashiko-reviews@lists.linux.dev
To: fangyu.yu@linux.alibaba.com
Cc: kvm@vger.kernel.org
In-Reply-To: <20260526125009.2404-7-fangyu.yu@linux.alibaba.com>
References: <20260526125009.2404-7-fangyu.yu@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 26 May 2026 16:02:29 +0000
Message-Id: <20260526160229.8F0F71F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] Writing per-image physical addresses to global variables during th=
e 'prepare' phase causes a Use-After-Free and state corruption if the kexec=
 load fails.
- [High] The assembly wrapper incorrectly calculates physical addresses for=
 `.bss` variables on `CONFIG_XIP_KERNEL` builds by assuming virtual offsets=
 always match physical offsets.

Pre-existing issues:
- [High] The kexec control page is made executable but never marked non-exe=
cutable when freed, and is left writable, violating W^X protections.
--

commit 6032faa530dc53961ca595e035246adbe5c3514a
Author: Fangyu Yu <fangyu.yu@linux.alibaba.com>

riscv: kexec: Add the relocate-trampoline wrapper

This commit adds a new assembly wrapper for kexec on RISC-V that handles
the two-step MMU teardown process. It also updates the preparation phase
to publish the wrapper and control code buffer physical addresses to global
variables.

> --- a/arch/riscv/kernel/kexec_relocate.S
> +++ b/arch/riscv/kernel/kexec_relocate.S
[ ... ]
> @@ -231,6 +231,43 @@ SYM_CODE_START(riscv_kexec_norelocate)
[ ... ]
> +	/*
> +	 * Now executing at the PA of this wrapper with the trampoline pgd
> +	 * installed (identity-mapped). Drop the MMU; PC stays valid because
> +	 * it is already a PA.
> +	 */
> +	csrw	CSR_SATP, zero
> +	sfence.vma x0, x0
> +
> +	/* Jump to the PA of control_code_buffer to run the relocate body. */
> +	la	t0, riscv_kexec_cc_buffer_pa

[Severity: High]
Does this PC-relative load calculate the correct physical address on
CONFIG_XIP_KERNEL builds?

On XIP kernels, .text executes from ROM and .data/.bss reside in RAM.
Because this code executes with the MMU disabled, a PC-relative load like
la will compute the distance relative to the ROM address.

Could this lead to computing an incorrect physical address and causing an
unhandled fault?

> +	REG_L	t0, 0(t0)
> +	jr	t0
> +SYM_CODE_END(riscv_kexec_relocate_entry)

> --- a/arch/riscv/kernel/machine_kexec.c
> +++ b/arch/riscv/kernel/machine_kexec.c
[ ... ]
> @@ -144,6 +146,11 @@ machine_kexec_prepare(struct kimage *image)
> =20
>  		/* Mark the control page executable */
>  		set_memory_x((unsigned long) control_code_buffer, 1);

[Severity: High]
This is a pre-existing issue, but does this leak executable pages back into
the general allocation pool?

If the kexec load fails, or if the image is later unloaded, kimage_free()
will return this page to the allocator. Since arch_kexec_pre_free_pages()
isn't implemented to clear _PAGE_EXEC, does this return an executable page
to the standard page allocator?

> +
> +		WRITE_ONCE(riscv_kexec_relocate_entry_pa,
> +			   __pa_symbol(&riscv_kexec_relocate_entry));
> +		WRITE_ONCE(riscv_kexec_cc_buffer_pa,
> +			   __pa(control_code_buffer));

[Severity: High]
Can writing per-image addresses to global variables during the prepare phase
cause a use-after-free if the load fails?

If do_kexec_load() fails after this point (for example, due to an invalid
segment in kimage_load_segment()), the new image and its control page are
freed by kimage_free().

If a previously loaded, valid kexec image was already in place, won't a
subsequent kexec reboot read these corrupted global variables and jump to
the freed page?

>  	} else {
>  		WRITE_ONCE(riscv_kexec_norelocate_pa,
>  			   __pa_symbol(&riscv_kexec_norelocate));

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260526125009.2404=
-1-fangyu.yu@linux.alibaba.com?part=3D6
