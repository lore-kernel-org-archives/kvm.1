Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B25CD28F5
	for <kvm@vger.kernel.org>; Sat, 29 Aug 2026 00:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787962167; cv=none; b=K796TOwF9hwlq+fW3rCNvrUEGGGa6nmpsB8k2zmdF3hClMB3BnbO1rHiGJi2tF1pysVZQJB+nawekuse2znsfGTGF5JrMdRmARiQZpIhe/VqX6H1xUgCF+/Si/+8bDeb5AtjSjFYcTQBZvqJrSQAFv0E9aLjt62SdpfcvkM9LxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787962167; c=relaxed/simple;
	bh=TA4JreOBNDQDPNgyMV/ZkHMYb2AiweI3vgU1qQl4o44=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=u6+rasHUlV6yfGhZtfKIqznWEdyCAH4UTc/IvkD3iNhz60BjOm2TR7i4EKt52aB6Kgt0JWgGigavcTjqLO+j+/cV3+/eBplPLl+oKBLw/2pLXFymeTpohIXIucFqUkahETxec5Lz0JjSV0nMCWn1kUqIApbu96yrB3+kNwBb9vE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Akd/0dys; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Akd/0dys"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 176E51F000E9;
	Sat, 29 Aug 2026 00:09:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787962166;
	bh=g6xU9CltW2KqK7gMpyux/ev9QBqDd0SFFAkvhC84EAY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Akd/0dysM17u88OjVtYAI+9q4aQiz+YEao9l+E/vc4J3tuhwrJn8xZZNRFPpUO2be
	 R91gH3E8T5dLj3yCt0rHYXrnnjcDhgtPHOZqHMdHJxcL12U+101u5w6AkdbO2Wl3Eh
	 7AdvOZpwGLBADVluG94wKu7M+W9+bDpvE7QrT8iBBT6B9vgEQq2otKQetB0nH8+Gt1
	 s9q9RBfBd7jANm04bj6yE8gg1yTGQbSBfFeJJ/LwWnR+aMAIcH6B+00JidqtLw+ODF
	 QF5KvGzvmPGEj1t/jXKIRv0IftpJElxnfSdjoMk1RAqxefKvr/M+tlcI9cEGyT2GFn
	 EcF3ewNx0Lmhg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] KVM: x86: Restrict saved GPA writes to hardware
 write faults
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kyle Zeng" <kylebot@openai.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260828235840.63227-1-kylebot@openai.com>
References: <20260828235840.63227-1-kylebot@openai.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 29 Aug 2026 00:09:25 +0000
Message-Id: <20260829000926.176E51F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Read-modify-write (RMW) instructions on unmapped MMIO pages will c=
rash SEV guests because the emulated write phase lacks authorization, forci=
ng an impossible software page table walk.
--

commit 2459e3d7bfb5a32b95970716f7650879e8b5d707
Author: Kyle Zeng <kylebot@openai.com>

KVM: x86: Restrict saved GPA writes to hardware write faults

This patch modifies KVM's instruction emulator to carry hardware write-fault
information and restricts the reuse of a saved GPA for writes only when the
hardware reported a write access. It introduces an access mask to authorize
writes based on the initial hardware fault or fall back to a full
translation if unauthorized.

> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 79468ddfe4736..aa5deb7c73aa2 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -5088,8 +5088,13 @@ static int emulator_read_write_onepage(unsigned lo=
ng addr, void *val,
>  	 * Note, this cannot be used on string operations since string
>  	 * operation using rep will only have the initial GPA from the NPF
>  	 * occurred.
> +	 *
> +	 * The guest may have changed the instruction since the fault.  Reuse
> +	 * the GPA for writes only if hardware reported a write access;
> +	 * otherwise, recheck permissions for the decoded access.
>  	 */
> -	if (ctxt->gpa_available && emulator_can_use_gpa(ctxt) &&
> +	if ((ctxt->gpa_access & (write ? ACC_WRITE_MASK : ACC_READ_MASK)) &&
> +	    emulator_can_use_gpa(ctxt) &&

[Severity: High]
Will this break the write phase of read-modify-write (RMW) instructions for
SEV guests?

If a SEV guest executes an RMW instruction (like OR [mem], reg) on an
unmapped MMIO page, the hardware triggers a Nested Page Fault (NPF) on the
initial read access. KVM will set gpa_access to ACC_READ_MASK.

When the emulator attempts the write phase, it appears this check will fail
because ACC_WRITE_MASK is not set. This causes emulator_read_write_onepage()
to fall back to vcpu_mmio_gva_to_gpa().

Does this fallback attempt a software page table walk that will fail on
encrypted guest page tables, resulting in a spurious #PF and crashing the
SEV guest?

>  	    (addr & ~PAGE_MASK) =3D=3D (ctxt->gpa_val & ~PAGE_MASK)) {
>  		gpa =3D ctxt->gpa_val;
>  		ret =3D vcpu_is_mmio_gpa(vcpu, addr, gpa, write);

[ ... ]

> @@ -6454,7 +6459,10 @@ int x86_emulate_instruction(struct kvm_vcpu *vcpu,=
 gpa_t cr2_or_gpa,
> =20
>  		/* With shadow page tables, cr2 contains a GVA or nGPA. */
>  		if (vcpu->arch.mmu->root_role.direct) {
> -			ctxt->gpa_available =3D true;
> +			/* A write fault can require a read for RMW emulation. */
> +			ctxt->gpa_access =3D ACC_READ_MASK;
> +			if (emulation_type & EMULTYPE_PF_WRITE)
> +				ctxt->gpa_access |=3D ACC_WRITE_MASK;

[Severity: High]
Does this limit gpa_access too strictly for read faults on RMW instructions?

As mentioned above, if an instruction naturally faults on its first (read)
access, it will only get ACC_READ_MASK here. This seems to be the root cause
that later prevents the write phase from reusing the GPA during MMIO
emulation.

>  			ctxt->gpa_val =3D cr2_or_gpa;
>  		}
>  	} else {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260828235840.6322=
7-1-kylebot@openai.com?part=3D1
