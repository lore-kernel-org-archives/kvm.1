Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B10E93BD62C
	for <kvm@vger.kernel.org>; Tue, 26 May 2026 16:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779813039; cv=none; b=FaV1m7h7rb5I6IQbAkrAUxM0Q0ZOessgN555mgDvzwOgmKpUwy0SKpPicYQe85gnByvgAQNir+X1rxiSERJn2aLNXnmVOI0ajhSMekrQqvAbEGVSpysjhd7uATmSkJNUYz4y3RCyjqTD+jqXZ8Vg61Br+yoSERcgyurW/PbsTxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779813039; c=relaxed/simple;
	bh=nevdse5t1kv9gNIo9f0Audc3CzDL/suBD0JEhDghzgc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Pj0VRiON0jj9+hugdVducAiBVa/kS9ZfR8uzupAPnbQLTeUDSeQR1Jl8tKNqgBpJe15HmOeaixj2bU38Rd/85v32vFhmkMzHMyCKBXIXA+pKd3VNz8ermYjGQEmyK1uuOUp+U7TIvz+oMwzTPZdt7Q44ZKbCm6nFi7377MbAXZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bGMb7I5s; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bGMb7I5s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 798EB1F000E9;
	Tue, 26 May 2026 16:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779813038;
	bh=4YeuA7IpI6JywUxHIAkYJPVBfYIBWeXGN2kVbZOsDPo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bGMb7I5sVFk0EuyvfOOnmARyO+szeIWJHPFICCoRaWcYclHXwvttqMDAMN6z+FwNg
	 QomuDu2C0hef6v/Drt8uHlemerowNpvzLL5mxQnrLul6BI+A+mxOgwfxMVXqabVSk5
	 3pl1BZONK+v2whTfFTwQG/gzuGWlk6fmB5hl0VfTBC89DXF2wpaO7/JAy3RE8qFdi+
	 3k9Rt3WY6cW8fEOFjrWft80kzYx3FqRxCi4QQzqau8dtPMGPq8zpd35aXbWJMN0rtf
	 AiMWJSa81BkfQiuB3tmuv9nMK0fA14+B7lfyCmugauBIZCrTz0mDdackF7A77tvaZo
	 zu30sq4LmYQDg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 7/7] riscv: kexec: Route normal kexec through the
 trampoline page table
Reply-To: sashiko-reviews@lists.linux.dev
To: fangyu.yu@linux.alibaba.com
Cc: kvm@vger.kernel.org
In-Reply-To: <20260526125009.2404-8-fangyu.yu@linux.alibaba.com>
References: <20260526125009.2404-8-fangyu.yu@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 26 May 2026 16:30:38 +0000
Message-Id: <20260526163038.798EB1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The control code page (image->control_code_page) is marked executa=
ble using set_memory_x() during machine_kexec_prepare(), but this permissio=
n is never reverted. Because machine_kexec_cleanup() is empty, if the kexec=
 image is freed, the page is returned to the buddy allocator while still re=
taining executable permissions.
--

commit 1b8b8dd4e5bc4de88d60ccac9a5bd712badb4dd3
Author: Fangyu Yu <fangyu.yu@linux.alibaba.com>

riscv: kexec: Route normal kexec through the trampoline page table

This patch modifies the normal kexec path on RISC-V to route through a
trampoline wrapper that disables the MMU before jumping to the relocation
code. This resolves an emulation issue with KVM in VS-mode where the previo=
us
single-step transition failed.

> diff --git a/arch/riscv/kernel/machine_kexec.c b/arch/riscv/kernel/machin=
e_kexec.c
> index e3eb1e71920a5..99cc251f971c6 100644
> --- a/arch/riscv/kernel/machine_kexec.c
> +++ b/arch/riscv/kernel/machine_kexec.c
[ ... ]
> @@ -231,11 +231,15 @@ machine_kexec(struct kimage *image)
>  {
>  	struct kimage_arch *internal =3D &image->arch;
>  	unsigned long jump_addr =3D (unsigned long) image->start;
> -	unsigned long first_ind_entry =3D (unsigned long) &image->head;
> +	/*
> +	 * The relocate body runs entirely with the MMU off (the wrapper
> +	 * drops SATP before jumping into control_code_buffer), so the very
> +	 * first entry must be a physical address.
> +	 */

[Severity: High]
This is a pre-existing issue, but since the relocate body now runs entirely
with the MMU off, is the set_memory_x() call for the control code page in
machine_kexec_prepare() still necessary?

Currently, image->control_code_page is marked executable during preparation,
but these permissions are never reverted because machine_kexec_cleanup()
is empty. If the kexec image is freed, the page is returned to the buddy
allocator while retaining its executable status. This leads to a persistent
W^X violation when the page is later reallocated for regular kernel data.

Since SATP=3D0 during the execution of this buffer, does it make sense to r=
emove
the set_memory_x() call entirely to prevent this leak of executable
permissions?

> +	unsigned long first_ind_entry =3D __pa(&image->head);
>  	unsigned long this_cpu_id =3D __smp_processor_id();
>  	unsigned long this_hart_id =3D cpuid_to_hartid_map(this_cpu_id);
>  	unsigned long fdt_addr =3D internal->fdt_addr;
> -	void *control_code_buffer =3D page_address(image->control_code_page);
>  	riscv_kexec_method kexec_method =3D NULL;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260526125009.2404=
-1-fangyu.yu@linux.alibaba.com?part=3D7
