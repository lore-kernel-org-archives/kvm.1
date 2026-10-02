Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8525470456
	for <kvm@vger.kernel.org>; Fri,  2 Oct 2026 09:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790932411; cv=none; b=YCcTRa+JM2cJTkcFOw1c4Xs1SkrX6rbGMHylIOYwHBW8CU6kj5OTHlELF/hdqEFWy7fScrpnBd+W+VdcMr1lhmP0annoI/TBD+2TfqvyLCKo7VbZ/V8GMuSsrNTcxhZf87JnkMIBX9Fn+ST04pDu1uQS3jeB+ldrrXPfSwr7h9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790932411; c=relaxed/simple;
	bh=tuLKKlOpCUbMDqRioGNIs4+bj67ZW1RzvodU01+mMpc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Ks6CxHWgihgST7GQj2GTQBmOl7zsd/n1vIZADYvpeony5lhxz3FY1RW5HpWU5g9cXevdjy36HM2mSBGnLxvE2oEOaevzoGE3ua0kbmtCLO57VKOQYMMTzIA9R8KTpB7F5x2FAeJT1fpGGkp85LFMLF8RBpKnM00yZzdgFDZ3NSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I8EbFIin; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I8EbFIin"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9ACBE1F00893;
	Fri,  2 Oct 2026 09:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790932409;
	bh=2dF8I3kDmzcWiM86dZTKaJYmSE6qtyZdl90EDDB5BhA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=I8EbFIin4GGzhxFlM/D2m5K12sSpe3T5nnl2KWAbpG7kXYm1/wpQc8/lMzDZMJQkg
	 IMPIIVKdW2sJDxqDlYoGZZ/URzUvpGpmBWekdBiogeODSyIKj7M5QOBDyKWfQiCtJ5
	 PNnV40gWG8zUzkDDeCbYwIyHG+TqlYeHIf55e9p9vNdrFWK5Pna6h4FVagxGVJnCNA
	 Ayv/fUlhB2w6oHeUmpG8VGl3DXfvPImsudb2JnZAjOvGCIK/f33jQ/yMnsaeb1egvV
	 JyZaydtL3l/goKquLJNQJ3Y58i5NDWF0wj7t+o6UWPv59eVLnsLT6EVHWzLRl4airg
	 Udc4e3wvm4k3w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v15 10/23] KVM: selftests: Set up TDX boot parameters
 region
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lisa Wang" <wyihan@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20261001-tdx-selftests-v15-10-7c62a5d8a992@google.com>
References: <20261001-tdx-selftests-v15-0-7c62a5d8a992@google.com>
 <20261001-tdx-selftests-v15-10-7c62a5d8a992@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 02 Oct 2026 09:13:29 +0000
Message-Id: <20261002091329.9ACBE1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] selftests: ineffective TEST_ASSERT due to prior 32-bit truncation
--

commit 818beb22776783ed2680d4f875f92a2f1dad9ff5
Author: Sagi Shahar <sagis@google.com>

KVM: selftests: Set up TDX boot parameters region

This commit allocates memory for TDX boot parameters and defines the utility
functions necessary to fill this memory with the boot parameters.

> diff --git a/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c b/tools/t=
esting/selftests/kvm/lib/x86/tdx/tdx_util.c
> --- a/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
> +++ b/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
[ ... ]
> @@ -38,6 +39,53 @@ void tdx_vm_setup_boot_code_region(struct kvm_vm *vm)
[ ... ]
> +void tdx_vm_load_common_boot_parameters(struct kvm_vm *vm)
> +{
[ ... ]
> +	/* Set parameters! */
> +	params->cr0 =3D kvm_get_default_cr0();
> +	TEST_ASSERT(vm->mmu.pgd < (1ULL << 32),
> +		    "PGD must be within 32-bit address space for 32-bit boot code");
> +	params->cr3 =3D vm->mmu.pgd;
> +	params->cr4 =3D cr4;
> +	params->idtr.base =3D vm->arch.idt;
> +	params->idtr.limit =3D kvm_get_default_idt_limit();
> +	params->gdtr.base =3D vm->arch.gdt;
> +	params->gdtr.limit =3D kvm_get_default_gdt_limit();
> +
> +	TEST_ASSERT(params->idtr.base < (1ULL << 32),
> +		    "idt must be within 32-bit address space for 32-bit boot code");
> +	TEST_ASSERT(params->gdtr.base < (1ULL << 32),
> +		    "gdt must be within 32-bit address space for 32-bit boot code");

[Severity: Low]
Does this assignment silently truncate the 64-bit vm->arch.idt and
vm->arch.gdt addresses?

Since params->idtr.base and params->gdtr.base are 32-bit fields, the
subsequent TEST_ASSERT checks evaluate the already-truncated values. If a
test allocates an IDT or GDT address beyond 4GB, the assertions will
always be trivially true because the upper 32 bits are lost before the
check.

This could lead to confusing test failures during guest execution instead
of properly failing the assertion here.

Should these assertions check vm->arch.idt and vm->arch.gdt directly
before assigning them to the base fields?

> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261001-tdx-selfte=
sts-v15-0-7c62a5d8a992@google.com?part=3D10
