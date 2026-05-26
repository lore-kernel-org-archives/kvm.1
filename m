Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C97B224E4C6
	for <kvm@vger.kernel.org>; Tue, 26 May 2026 13:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779801431; cv=none; b=T5G3w7sma3XTm+KDmfq/Cim/s699WS44TBLHBkjCAi9NbwX3KfPbn4SSDMi1P3E8zbMz0+qxm1hO9B8nDhkqfXpRElDpQtqJuZWS70A5zf8iUqPiCqZfEAKtn1Q8h7clEWiFJ7ZeyjnR8m+wHz1G84UMEA21BI+FsYKvwFU7iG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779801431; c=relaxed/simple;
	bh=xQobCGYBivBMcOFzdO2RITfwWzz3INW2IBz/Wm/hIc4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mH21Y0wVAjvyW0Y68ZdUaTwtzszZrQrvrdjl7ChEtmAI0FUw5apzRG8/NXytdhcIrssDUYyNfJAQb72H8dlRPeb7ntEQRFRgoftuNEyTFAYs9JNMo4vRd3my3buXsrbE83y7KAyNbwJK2J64e+eox+XJS99RIMK3GEhN8Pbd2QU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HtUjpzpY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HtUjpzpY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E43D11F000E9;
	Tue, 26 May 2026 13:17:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779801430;
	bh=OUXVg+EFRDZF0tCyBe/HiFb7oEb55JxIp+aDmypQ/Qg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HtUjpzpY60zmPwQmW6bZGRaVHe+CzU8IpgvZ/uR0O4EfMwnSvzElTl25P69XSc/84
	 YACTqsiIp0JSF49g7jqV+AteA3W/EHaYAcMrFLkRPfVk6tTr3l0cUq9+OWG/1BNqGe
	 n6v/iuEidK6Py68bwyGgcp8ErdpxO2gy1VnDPx+P1BKa+vOEKcn0tccBYdshJJjFXE
	 jrTqDVI1WSGdFRCufkpa/SsOHZMSJ/mpBMSt2T7B5aPnvcvW1khbzZ7/+RLYldm6jn
	 9ogq+1DklCiavjlXMnCNe9QeLRc+D2r4U0vHjgJnPDdkPXziJOvYbVSHbkT3i5g/0a
	 YtP/zCx8zwxGw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/7] riscv: Add kexec trampoline text section to
 vmlinux.lds.S
Reply-To: sashiko-reviews@lists.linux.dev
To: fangyu.yu@linux.alibaba.com
Cc: kvm@vger.kernel.org
In-Reply-To: <20260526125009.2404-2-fangyu.yu@linux.alibaba.com>
References: <20260526125009.2404-2-fangyu.yu@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 26 May 2026 13:17:09 +0000
Message-Id: <20260526131709.E43D11F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Low] The `KEXEC_TRAMP_TEXT` macro introduces section layout directives b=
ut is placed in `image-vars.h`, a header strictly intended for linker scrip=
t variable assignments.
- [Low] The linker ASSERT failure message statically hardcodes '4K', which =
is inaccurate for RISC-V kernels configured with larger page sizes.
- [Low] The `.kexec.tramp.text` section and its boundary symbols are omitte=
d when `CONFIG_XIP_KERNEL` is enabled alongside `CONFIG_KEXEC_CORE`, causin=
g a build failure.
--

commit 2ab699179f3a5599c71d8911590e4b8328996c8a
Author: Fangyu Yu <fangyu.yu@linux.alibaba.com>

riscv: Add kexec trampoline text section to vmlinux.lds.S

This commit adds a dedicated .kexec.tramp.text area to the RISC-V linker
script when CONFIG_KEXEC_CORE is enabled. It aligns the section to PAGE_SIZE
and adds an assertion to ensure the trampoline fits within a single page.

> diff --git a/arch/riscv/kernel/image-vars.h b/arch/riscv/kernel/image-var=
s.h
> index 3df30dd1c458b..ae286c6d5d65a 100644
> --- a/arch/riscv/kernel/image-vars.h
> +++ b/arch/riscv/kernel/image-vars.h
> @@ -34,4 +34,18 @@ __efistub_screen_info		=3D screen_info;
> =20
>  #endif
> =20
> +#ifdef CONFIG_KEXEC_CORE
> +#define KEXEC_TRAMP_TEXT						\
> +		. =3D ALIGN(PAGE_SIZE);					\
> +		__kexec_tramp_text_start =3D .;				\
> +		KEEP(*(.kexec.tramp.text))				\
> +		KEEP(*(.kexec.tramp.text.*))				\
> +		__kexec_tramp_text_end =3D .;				\

[Severity: Low]
Does placing a section layout macro like KEXEC_TRAMP_TEXT in image-vars.h
violate the architectural purpose of this header?

The header comment indicates it is intended only for "Linker script
variables to be set after section resolution", rather than layout directives
containing KEEP and ALIGN.

> +		ASSERT((__kexec_tramp_text_end - __kexec_tramp_text_start) <=3D PAGE_S=
IZE,  \
> +			".kexec.tramp.text exceeds 4K");				\

[Severity: Low]
Should the error message avoid hardcoding "4K" here?

RISC-V supports larger page sizes like 16KB and 64KB, so if the assertion
dynamically checks against PAGE_SIZE and fails on a larger page size,
emitting "exceeds 4K" might be misleading.

> +		. =3D ALIGN(PAGE_SIZE);
> +#else
> +#define KEXEC_TRAMP_TEXT /* nothing */
> +#endif
> +
>  #endif /* __RISCV_KERNEL_IMAGE_VARS_H */
> diff --git a/arch/riscv/kernel/vmlinux.lds.S b/arch/riscv/kernel/vmlinux.=
lds.S
> index 61bd5ba6680a7..47fefee772667 100644
> --- a/arch/riscv/kernel/vmlinux.lds.S
> +++ b/arch/riscv/kernel/vmlinux.lds.S
> @@ -45,6 +45,7 @@ SECTIONS
>  		ENTRY_TEXT
>  		IRQENTRY_TEXT
>  		SOFTIRQENTRY_TEXT
> +		KEXEC_TRAMP_TEXT

[Severity: Low]
Will this cause a build failure when CONFIG_XIP_KERNEL is enabled alongside
CONFIG_KEXEC_CORE?

When CONFIG_XIP_KERNEL is active, vmlinux.lds.S delegates to
vmlinux-xip.lds.S and skips including image-vars.h.

Because the KEXEC_TRAMP_TEXT macro is never evaluated, the symbols
__kexec_tramp_text_start and __kexec_tramp_text_end would be undefined when
arch/riscv/kernel/machine_kexec.c tries to reference them.

>  		_etext =3D .;
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260526125009.2404=
-1-fangyu.yu@linux.alibaba.com?part=3D1
