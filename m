Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91E5D3093CB
	for <kvm@vger.kernel.org>; Fri, 12 Jun 2026 23:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781306910; cv=none; b=HneRnVcsng3GexdtnsRV3H3SyZ97OPgzJGYLOKwb+/hMlrGD0XwqXkdDXCOSc5hjtAahZPlYKt1zf2fQQl1B4OLBGQqMQpQJYwy06Jw75uSl4jLuMAGT8+XzjqReQi3ABXJ2tAb3bpW4SGy6BG0L6sn17ULdtm/uKdQea+JLI58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781306910; c=relaxed/simple;
	bh=MKXKJlCOae9l9EhZ+kv7BR7vOjJNTj1TgcgXF6jY+OI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=f5xPmqy9Kh+Jk+mChrayIB0D/9NXQUxd2XL6m+f4sMdnPv9fd5JUEWDRUSW2T3+Aby++a6ueE1JwgyxoyTvlMyFUNInhuvScNj4I/35xRcP0uKf1lIoIwPkNihjrQG07iOLexXDJrN0iFLZajohqPK61EESwnZ+AXrdrzCIAGQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h7LLoLJJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h7LLoLJJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 482311F000E9;
	Fri, 12 Jun 2026 23:28:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781306909;
	bh=VYMRN18E9n9OXVJyDowkILUSt54MdPR0y/ywv5f6qHQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=h7LLoLJJ0gPRozBnOaFSs/gRf0vL+UqOReQEok3ox+cVt5GoIVEy6sR0Fsnc77b8K
	 0v0y0O++Tbp/o5PwCMcj+zLDFkhjWoPiIQx+HdOYNy4uc9klblAqEKPJ8GYO6J0CbP
	 oRf2v8ZbjwGMN9ySpd+36+xUhoN9yLvrT9AjZLssPu16PcbWcNTaFzTGfYvALBRdf4
	 3MlQkUTCuItIlB+Ve6TQanPzdCVnh0gKpBh4VEHtpvYYN7Nll1C4ftWhjVNeiX75DD
	 AtQ0p8dTyxb9gXtQygM641Lpmm3rLlq5QQ2jBH4WeTy4VjQ0ILfJP7COeYEHfmyJSi
	 j/J46ReE5VKDA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/8] KVM: x86: Manually check DR4/5 write values to
 fix SVM intercept priority
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sean Christopherson" <seanjc@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260612230113.684301-4-seanjc@google.com>
References: <20260612230113.684301-4-seanjc@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 12 Jun 2026 23:28:28 +0000
Message-Id: <20260612232829.482311F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Lack of canonical address checks for DR0-DR3 writes allows mal=
icious userspace or guests to crash the host kernel, and breaks nested virt=
ualization exception priorities.
--

commit 85827e7c2e927fda473c503a8703cddac0182bb8
Author: Sean Christopherson <seanjc@google.com>

KVM: x86: Manually check DR4/5 write values to fix SVM intercept priority

This patch manually pre-checks values written to DR4/5 (DR6/DR7 aliases) to
avoid relying on ->set_dr() for #GP signaling. This fixes an SVM intercept
priority issue where nSVM relies on the emulator to perform exception check=
s.

> diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
> index 4484c5fa19e33..a1bccab0eefee 100644
> --- a/arch/x86/kvm/emulate.c
> +++ b/arch/x86/kvm/emulate.c
> @@ -3853,15 +3853,23 @@ static int check_dr_read(struct x86_emulate_ctxt =
*ctxt)
>  static int check_dr_write(struct x86_emulate_ctxt *ctxt)
>  {
>  	u64 new_val =3D ctxt->src.val64;
> -	int dr =3D ctxt->modrm_reg;
>  	int rc;
> =20
>  	rc =3D check_dr_read(ctxt);
>  	if (rc !=3D X86EMUL_CONTINUE)
>  		return rc;
> =20
> -	if ((dr =3D=3D 6 || dr =3D=3D 7) && (new_val & 0xffffffff00000000ULL))
> -		return emulate_gp(ctxt, 0);
> +	switch (ctxt->modrm_reg) {
> +	case 4:
> +	case 5:
> +	case 6:
> +	case 7:
> +		if (new_val & 0xffffffff00000000ULL)
> +			return emulate_gp(ctxt, 0);
> +		break;
> +	default:
> +		break;

[Severity: Critical]
This is a pre-existing issue, but does this code need to check for canonical
addresses on DR0-DR3?

If a malicious guest forces instruction emulation of a write to DR0-DR3 wit=
h a
non-canonical address, this default case allows it to return X86EMUL_CONTIN=
UE.

Since kvm_set_dr() also doesn't check for canonical addresses on DR0-DR3,
could this allow a non-canonical value to be written to vcpu->arch.db[0..3]?

If hardware breakpoints are active, KVM restores these registers using
set_debugreg(), which eventually calls native_set_debugreg():

arch/x86/include/asm/debugreg.h:native_set_debugreg() {
    ...
    case 0:
        asm("mov %0, %%db0" ::"r" (value));
        break;
    ...
}

Because this inline assembly lacks an exception table entry (_ASM_EXTABLE),
could writing a non-canonical address generate an unhandled #GP in host
kernel mode and crash the host?

Additionally, by omitting the #GP check in the emulator, would this incorre=
ctly
synthesize a VM-exit to L1 instead of injecting a #GP to L2, breaking nested
virtualization exception priorities on SVM?

> +	}
> =20
>  	return X86EMUL_CONTINUE;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260612230113.6843=
01-1-seanjc@google.com?part=3D3
