Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C01A3321BD
	for <kvm@vger.kernel.org>; Wed, 29 Jul 2026 19:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785355122; cv=none; b=Unoo2tU5jwqNCnX9SQItH53h+BJyo6XxLjCYk04waLfYD2ZTfIGZNfMmkVDbrNhRDokp7WU61YOBgjSw3DRUomZ6j/cKJI0Csw0QIHc3jTAxLAvPatlovr0vYygSu0IjCmmrevfwtFZPLD8L9HKPmxEl0OgA4JDI8pgAGyRM4EA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785355122; c=relaxed/simple;
	bh=nGMBqn8YOnw+DXpFh/GwXjdmIS7OixALI3/xeti70DM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ozhaT3FXD6y4vM0Xou9dChwX9AVVe9GaFFVVqrUVpv22BhcvPNP888DD0izJDSVSBeEhrKWeS4y6g7OlFCK01vZVHjwmK8Tvjr5Hfg5T/xI0OqjYyQh4Qz+j8ru0MdHQ37oXJF4WNBixX1muR4X8djWCsR/6T1D3rOJxoedf3WQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZQN1JB2X; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZQN1JB2X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24B9F1F00A3A;
	Wed, 29 Jul 2026 19:58:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785355121;
	bh=1vKI/CozdJnpDDTWbeS8nuheUPLJOWSqYaM4k71ZPv4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZQN1JB2XyAUxaDo4wbJ0pU9C4Fw8rA1r1aR9TuJrAImtHKk8Ap8uApVERBjsoOhXR
	 MyYB4IN0wtR7V7kkjJCYRbL7phLFd4CEVpsovY3k5C34CdocEh/mQIBeYQd2lBkCVs
	 K1SamxWUx+jOs7H2gjrFs0xV20f/UFLxJgnQ/RhLOvnXok4GBa/alqQpqCBcRCn6+7
	 NOoL9QkhwsKLhlxNGGdtXCf1UhNhxL1y/z2AkdVj48KRVCa24qetcU+AA2+pIXcBKh
	 y4Dga2/w3dR0yDUmzdGnX0XuI0oKFeDpV6XuPp3HDuDlNVL9Vk4yhbIKI/h5bJNp9y
	 A7sSfay8xvYXg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 13/20] KVM: x86: Reject EVEX-prefixed instructions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chang S. Bae" <chang.seok.bae@intel.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260729191656.598771-14-chang.seok.bae@intel.com>
References: <20260729191656.598771-1-chang.seok.bae@intel.com>
 <20260729191656.598771-14-chang.seok.bae@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Jul 2026 19:58:40 +0000
Message-Id: <20260729195841.24B9F1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The newly added EVEX prefix check evaluates an uninitialized or =
stale `ctxt->modrm` byte in 32-bit mode and is entirely redundant because K=
VM already maps opcode 0x62 to `NotImpl`.
--

--- Patch [13]: [PATCH v6 13/20] KVM: x86: Reject EVEX-prefixed instruction=
s ---
commit 086b81f7f3526e32d2a152bf460681542a47ce74
Author: Chang S. Bae <chang.seok.bae@intel.com>

KVM: x86: Reject EVEX-prefixed instructions

This commit explicitly marks EVEX-prefixed opcodes (0x62) as unsupported
in the x86 instruction emulator.

> diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
> index cb075bd74f769..fc7f9f17c1da4 100644
> --- a/arch/x86/kvm/emulate.c
> +++ b/arch/x86/kvm/emulate.c
> @@ -5045,6 +5045,11 @@ int x86_decode_insn(struct x86_emulate_ctxt *ctxt,=
 void *insn, int insn_len, int
>  	if (opcode.flags & ModRM)
>  		ctxt->modrm =3D insn_fetch(u8, ctxt);
> =20
> +	/* EVEX-prefixed instructions are not implemented */
> +	if (ctxt->opcode_len =3D=3D 1 && ctxt->b =3D=3D 0x62 &&
> +	    (mode =3D=3D X86EMUL_MODE_PROT64 || (ctxt->modrm & 0xc0) =3D=3D 0xc=
0))

[Severity: Medium]
Could this evaluate an uninitialized or stale ctxt->modrm?

Looking at x86_decode_insn(), since opcode 0x62 is already mapped to
NotImpl in the KVM opcode_table, the opcode.flags & ModRM condition will
be false, and ctxt->modrm will not be fetched just above this check.

When evaluating this in 32-bit mode, would it end up reading an
uninitialized struct member, even though the instruction is already
set to be rejected anyway?

> +		opcode.flags =3D NotImpl;
> +
>  done_modrm:
>  	ctxt->d =3D opcode.flags;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260729191656.5987=
71-1-chang.seok.bae@intel.com?part=3D13
