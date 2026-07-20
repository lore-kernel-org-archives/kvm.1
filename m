Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EADD3A450F
	for <kvm@vger.kernel.org>; Mon, 20 Jul 2026 18:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784571072; cv=none; b=o+Tk6slLhgQVkkMofxLfukkYQJJOfhge1epW7EOPJmd4MigPaEiTgC4ekYq/DRA9qBpkDyc/QLCUP8pvvnYWvsJOSU3uXsGGbpi/rWVeBCw/TAQagX5UZbmuXrxcq/AhhCoz/humKLR7qoBLIgNnlm6dDxCIp9RMvGvJ2fLK7jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784571072; c=relaxed/simple;
	bh=IFUAfXdCZ5nPaOFgM8NgweQ+bI2+JNPBJJOFt0N731o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VOBSZY7w3EfcJhwa3RM7LuSJwR6A1VmZteB6/XRb5qM4J2KGvrGc0gNopjVXCMR7EyD1dVS+78OVIfe3FqshczciSbd8AjcgmnYCSCPcBph39pyDtLW+PVVmCIPM092OYXJaGa8qnZnpNRmd4l7Be+QbZK42Jk+Cz/zJ1gJpB2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EEoERgBx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EEoERgBx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C975E1F000E9;
	Mon, 20 Jul 2026 18:11:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784571071;
	bh=niU7PCVKzIYXSxEawvt7f94K1CHCMeAf1mu40XW4ycU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EEoERgBxs/q3wtC17QKnIUJkVKuOCpWYgB5F5o3quT6FXM4/c8eV659vzi0zIqqab
	 UdkE7CDfoqx8YxmsvyjOSmpw7chx8I1RFwVdzByzRmK4HynsvzyZzWE/5dN9z55LHA
	 gKA1gTWAe16IzhFtKwARsUPsV9OBF0Kk8lzZvEX4723zp7d+7R1VTOyDcEPtBYLZR+
	 Or/wVLXco+i5vbvK6r+Gl3/x8NxfVzj7rOuHYCzjB7tw118C9tUXI96fdrS0enACEL
	 ERGYEt0/VVgziDyMWy8GWmkwEW2G2Ijo69kBMS8k8dn11at2xHr6ajtl0mMf95IIiX
	 Vx49orEZ5RCyg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 13/20] KVM: x86: Reject EVEX-prefixed instructions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chang S. Bae" <chang.seok.bae@intel.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260720171949.498680-14-chang.seok.bae@intel.com>
References: <20260720171949.498680-1-chang.seok.bae@intel.com>
 <20260720171949.498680-14-chang.seok.bae@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Jul 2026 18:11:10 +0000
Message-Id: <20260720181110.C975E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The EVEX prefix check evaluates `ctxt->modrm` without ensuring the =
ModRM byte was fetched, resulting in a read of stale data, and acts as enti=
rely dead code.
--

--- Patch [13]: [PATCH v5 13/20] KVM: x86: Reject EVEX-prefixed instruction=
s ---
commit fbeae1bf78a009984ff1eb258601fe615d601296
Author: Chang S. Bae <chang.seok.bae@intel.com>

KVM: x86: Reject EVEX-prefixed instructions

Explicitly mark EVEX-prefixed opcodes (0x62) as unsupported.

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
> +		opcode.flags =3D NotImpl;

[Severity: Low]
Does this evaluate stale data in ctxt->modrm?

When a 32-bit guest executes an instruction starting with 0x62 in
x86_decode_insn(), opcode_table[0x62] yields NotImpl, which lacks the ModRM
flag. Because the ModRM flag is missing, insn_fetch() is bypassed.

Since the EVEX check doesn't short-circuit in 32-bit mode, it will evaluate
whatever stale data remains in ctxt->modrm from a prior emulation on that
context.

Because opcode.flags is already initialized to NotImpl by the table lookup,
is this check entirely redundant?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260720171949.4986=
80-1-chang.seok.bae@intel.com?part=3D13
