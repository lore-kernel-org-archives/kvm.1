Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C51911D9A5F
	for <kvm@vger.kernel.org>; Tue, 26 May 2026 15:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779809194; cv=none; b=OuA7OZMU888rXf21lEbJB44METODqLnw8hMtZLuGrDFHQ0RHrgNsZPcxv51Dr96i+f7B47m+LxrTvq+3zl21elCAaR9shUT4KOAHfAWR5Db3w2HAXkRpuZb/vf5Em1fo2RQbw4wngBUxFpWa5eCi1avQA2pj5+nLDtvTHAV2ej4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779809194; c=relaxed/simple;
	bh=c/GWuYvxE73rVUL7dJbR3Z0OSjIQfIAjUZrsPt151A0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=I2cFrOFVYfv7oBR5GRiLQGIVs4Ylg7b3SLHOee1OmyDVM+jHZu1Qkoi/9bc+onVCnyTEUOQJjjj2R/Nn+sF33MBw4uVgnZ/D4ao6n+YoT2SUyuI2atThOcSSbAm69OCJUPvP6BWPju4JMmpcxNeS+EOCa9XKI7f93uDKopv//qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iUVT+VCC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iUVT+VCC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40C971F000E9;
	Tue, 26 May 2026 15:26:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779809193;
	bh=TYYTQclcKOxMie+PVuh5Nly6jX/1/FXtZwAqxYlPwtk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iUVT+VCC1jl2DXaWWoHPBkAFSlkal4EhQCgTM9Ja/7H2L+51C511kBsBEa2o2sDiq
	 DioJ7ns4GCyqWnGu5UiQVvOd+9eiZ7gsA2ziY4fY6iTjJ3n1cDb0t5GzoCgjl6ynP1
	 15aJIUCT1nx3eSsmJp+LE6ZpSM/tOvXnveSckNPg8A5whrIiW7pNLd4lhV0q4/MuSc
	 UMdxGWO7DK2tJSFA6yPk569WeN70SSQGJP9xzoxw8bi04LBpi9sFv91FK65YhHJdSL
	 YT5sgkkQltC3LFpOm8vjZSvUuO6P/s+wfP/RMPos85Jtmy8TJumy+1pL0/XmNdlGB7
	 4xnLU5A1vE4cQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 5/7] riscv: kexec: Always build the trampoline page
 table
Reply-To: sashiko-reviews@lists.linux.dev
To: fangyu.yu@linux.alibaba.com
Cc: kvm@vger.kernel.org
In-Reply-To: <20260526125009.2404-6-fangyu.yu@linux.alibaba.com>
References: <20260526125009.2404-6-fangyu.yu@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 26 May 2026 15:26:32 +0000
Message-Id: <20260526152633.40C971F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] W^X memory protection bypass due to missing set_memory_nx() in mac=
hine_kexec_cleanup()
- [High] Out-of-bounds read in machine_kexec_prepare() during FDT search le=
ading to kernel panic
--

commit 12b9a2069db4f35db2b3ed4b36105e4aefe8ff09
Author: Fangyu Yu <fangyu.yu@linux.alibaba.com>

riscv: kexec: Always build the trampoline page table

This patch refactors the kexec preparation path to build the trampoline
page table and capture its satp value unconditionally, rather than only
doing so for crash kernels.

> diff --git a/arch/riscv/kernel/machine_kexec.c b/arch/riscv/kernel/machin=
e_kexec.c
> index 00fdc42d650df..556b76bcf96e7 100644
> --- a/arch/riscv/kernel/machine_kexec.c
> +++ b/arch/riscv/kernel/machine_kexec.c
> @@ -119,6 +119,16 @@ machine_kexec_prepare(struct kimage *image)
>  		return -EINVAL;
>  	}

[Severity: High]
This is a pre-existing issue in the code just above this hunk, but can the
device tree search loop trigger an out-of-bounds read?

When iterating over kexec segments to locate the device tree, the code
checks memsz but not bufsz:

        if (image->segment[i].memsz <=3D sizeof(fdt))
                continue;

        if (image->file_mode)
                memcpy(&fdt, image->segment[i].buf, sizeof(fdt));

If a segment is provided where p_filesz is smaller than sizeof(fdt) but
p_memsz is larger, memcpy() will read past the end of the kernel-allocated
image buffer. If this buffer happens to be adjacent to an unmapped guard
page, could this result in a fatal page fault?

> =20
> +	/*
> +	 * Build the trampoline page table and capture its SATP value.
> +	 * The crash path consumes it today; the non-crash kexec path
> +	 * will use the same setup as well.
> +	 */
> +	riscv_kexec_build_tramp((unsigned long)__kexec_tramp_text_start,
> +				__pa_symbol(__kexec_tramp_text_start));
> +	WRITE_ONCE(kexec_tramp_satp,
> +		   PFN_DOWN(__pa_symbol(kexec_tramp_pgd)) | satp_mode);
> +
>  	/* Copy the assembler code for relocation to the control page */
>  	if (image->type !=3D KEXEC_TYPE_CRASH) {
>  		control_code_buffer =3D page_address(image->control_code_page);

[ ... ]

> @@ -135,19 +145,8 @@ machine_kexec_prepare(struct kimage *image)
>  		/* Mark the control page executable */
>  		set_memory_x((unsigned long) control_code_buffer, 1);

[Severity: High]
This isn't a bug introduced by this patch, but if the kexec payload is
subsequently unloaded (like via kexec -u) or fails later in the load
process, kimage_free() will call the architecture-specific
machine_kexec_cleanup().

Since machine_kexec_cleanup() on riscv is an empty stub, it doesn't call
set_memory_nx() to reverse this permission change. The page is then freed
back to the buddy allocator via kimage_free_pages() while still retaining
its executable permission.

Does this leave executable pages in the generic kernel allocator, bypassing
write-xor-execute protections?

>  	} else {
> -		/*
> -		 * Crash kexec uses riscv_kexec_norelocate as a trampoline.
> -		 * Pre-build the trampoline page tables and capture the
> -		 * trampoline SATP value plus the physical address of
> -		 * riscv_kexec_norelocate so that the panic path only has
> -		 * to switch satp and jump.
> -		 */
> -		riscv_kexec_build_tramp((unsigned long)__kexec_tramp_text_start,
> -					__pa_symbol(__kexec_tramp_text_start));
>  		WRITE_ONCE(riscv_kexec_norelocate_pa,
>  			   __pa_symbol(&riscv_kexec_norelocate));
> -		WRITE_ONCE(kexec_tramp_satp,
> -			   PFN_DOWN(__pa_symbol(kexec_tramp_pgd)) | satp_mode);
>  	}
> =20
>  	return 0;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260526125009.2404=
-1-fangyu.yu@linux.alibaba.com?part=3D5
