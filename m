Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E4AF47B410
	for <kvm@vger.kernel.org>; Thu,  4 Jun 2026 13:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780580281; cv=none; b=o8H/eO73zvevaLQuUtIcMJdTtul4FBAerJX3ohqL2iRBQQWg+RBqpRPFC0Sf5jLLYlwjr1L8mcLOLQcDUvAfseXMhhf3mEtyM5mXlnRMyXPLdiaCQiLOH3OkuzT9JstXWG+iyP/R/8vWqeiBWYdpFRG3u+mpwxr4MWe5C2vEDeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780580281; c=relaxed/simple;
	bh=mnJL3ZByLkz0JPnx+woeGShzf8elEq33ZARt1AepbWQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZswBOnLK0BtfGbfXPMOdCKMWHmu/dRVojyS4dX8VoxnfR9i4k9VzS80llBX/Soc0D2tXT/8lci/6fZUKmo7IcZyd4ltmojgY4E9aSJs54ZT35Vhkt8Cda9QX2Te1hMSb+jMeisTlFdm1L5FeDs+7cYRC5gHCQxPVmruAQS+j0+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aghq9bee; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aghq9bee"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC3CC1F00893;
	Thu,  4 Jun 2026 13:37:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780580279;
	bh=mXVC/FXnYdaG2UhOQyBXEOMAzprx1EqJpkw7/m0tHCA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aghq9beeUqX2vWsakAEfcHW9bbVq4R3Q26OQc13R/rxt+U36S+QmWiX0CHetYRmFb
	 MqkSHhS92x0u2+NuHTHluXfFkyVUBMWnCuoJRXNSZVTnDsddxXiheLxczVovjFaUNG
	 bGfswd2gUHmzLbO3X/rDpAoIWFqBsgPSpWeKBDbA6WKsouZzwCvK+bysxjkrNFe9Xr
	 U/pNixQYKwO76vmYSWmlwYcNhw3kO0qLnnzmTlNT8/0LW2Me53wsPEg3fpDuKePSSS
	 5ZXaWUwSYF5u5ZLgnl6xZpV1mkBD68dA6Um0SVyc5CHDqIA7/KIWd12zbi4L/915DX
	 v0M2ISuihR4bw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/9] riscv: kexec: Bound FDT search by source buffer
 size, not destination
Reply-To: sashiko-reviews@lists.linux.dev
To: fangyu.yu@linux.alibaba.com
Cc: kvm@vger.kernel.org
In-Reply-To: <20260604132418.15725-3-fangyu.yu@linux.alibaba.com>
References: <20260604132418.15725-3-fangyu.yu@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 04 Jun 2026 13:37:59 +0000
Message-Id: <20260604133759.AC3CC1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] In `kexec_file_load`, an attacker can bypass Secure Boot restr=
ictions by providing an initrd that starts with a forged FDT header, overwr=
iting the kernel-constructed FDT.
- [High] The check `if (!internal->fdt_addr)` falsely rejects a valid FDT i=
f it is placed at physical address 0x0.
--

commit 0ee8b0469cc5460085b86fc5826ddc9fa0522c40
Author: Fangyu Yu <fangyu.yu@linux.alibaba.com>

riscv: kexec: Bound FDT search by source buffer size, not destination

This commit changes the FDT size check in machine_kexec_prepare() to use
bufsz instead of memsz. This correctly bounds the read to the provided
source buffer, preventing out-of-bounds reads and potential kernel faults
when a segment is padded with zeros at its destination.

> diff --git a/arch/riscv/kernel/machine_kexec.c b/arch/riscv/kernel/machin=
e_kexec.c
> index ea6794c9f4c2d..e6e179cffc447 100644
> --- a/arch/riscv/kernel/machine_kexec.c
> +++ b/arch/riscv/kernel/machine_kexec.c
> @@ -38,21 +38,21 @@ machine_kexec_prepare(struct kimage *image)
> =20
>  	/* Find the Flattened Device Tree and save its physical address */
>  	for (i =3D 0; i < image->nr_segments; i++) {
> -		if (image->segment[i].memsz <=3D sizeof(fdt))
> +		if (image->segment[i].bufsz < sizeof(fdt))
>  			continue;
> =20
>  		if (image->file_mode)
>  			memcpy(&fdt, image->segment[i].buf, sizeof(fdt));
>  		else if (copy_from_user(&fdt, image->segment[i].buf, sizeof(fdt)))
>  			continue;
> =20
>  		if (fdt_check_header(&fdt))
>  			continue;
> =20
>  		internal->fdt_addr =3D (unsigned long) image->segment[i].mem;
>  		break;

[Severity: Critical]
This is a pre-existing issue, but does this blind search loop in
machine_kexec_prepare() allow a user-provided segment to spoof the FDT?

For kexec_file_load, architecture-specific loading adds the user-provided
initrd segment before the kernel-constructed FDT segment. If a malicious
initrd starts with FDT magic bytes, it seems this loop would accept it and
break early.

Would this cause the next kernel to boot using an attacker-controlled FDT
instead of the kernel-generated one? This could allow injection of arbitrary
bootargs (like init=3D/bin/sh module.sig_enforce=3D0) and bypass Secure Boot
restrictions.

>  	}
> =20
>  	if (!internal->fdt_addr) {

[Severity: High]
This is a pre-existing issue, but could the !internal->fdt_addr check in
machine_kexec_prepare() incorrectly reject a valid FDT if it is placed at
physical address 0x0?

On RISC-V platforms where the physical memory base starts at 0x0 (such as
the T-Head TH1520), the FDT segment can legitimately be loaded at physical
address 0x0. The search loop will correctly set internal->fdt_addr =3D 0, b=
ut
this check would treat it as an error and return -EINVAL.

Is there a risk that this false rejection breaks kexec functionality on
platforms where memory starts at 0x0?

>  		pr_err("Device tree not included in the provided image\n");
>  		return -EINVAL;
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260604132418.1572=
5-1-fangyu.yu@linux.alibaba.com?part=3D2
