Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D17BFCA45
	for <kvm@vger.kernel.org>; Mon, 22 Jun 2026 04:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782102430; cv=none; b=u/YdD9PaUZePgL3jJ0IA0sePW5oAaiZX9v5YvnmBjSh/14bYuniLHVZv8DGQMhgmnU1RSGT+2Cl99Tfr29JB+wxxSW8s0wAdgUMflfKtXkzLiI5DSe0FGZnjhOW31nCpB0xcyHwRd+zm176H0hYCT3SsKDm8LJgI3UM2VSuBshk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782102430; c=relaxed/simple;
	bh=BzROYusngFD3Iflu3aBreP0lbg7ajIDblkuJVdF+q1M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NN72s7v4SmAZpxYcleeGfMdnq6M+pxULK1/vc01o4IruuHkpf18dU114qsq0+ab9iDKaIZ14yDhL4lysV/h8QLGPEizWDhCxOwvGpCYsNCi7LcEIE9XaOEJhXXbIOCWW1ejH7iQo9LZyyvStPkhmboLIoaAzizLtxsURhGdxdoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=haG2zlcx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="haG2zlcx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59C011F000E9;
	Mon, 22 Jun 2026 04:27:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782102429;
	bh=vrUzQoXGE+yZC/Z6/ONauMa7Gz0p2qzX/fmaxT5I/Po=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=haG2zlcxzH68kYMhgW7H91CHtXyVKo65+wBuj+T+2Tk3Nrgudzb5i9wxGEn7/eXfO
	 jbYuThIe7Sk8xtj3Z8txd+S/WQCawyQliCDCEVj1V5bdar5P84ZaUjkl3gnKc6NQD4
	 Z14eh4AStumoSlPiLwzria9W0xanMHS8zyORRyK6QCBqqm1qw3WCgGHgfPnU6tqDhV
	 wSbM4f1DEO1JDt/VI9XYIVqxw7iJ7OAt48SQU/2of1wke/CLD0kkGBgm8uz50/q7mm
	 vAem7jeAlfdFkqg0HVyqAgY3ijtWtbQoY5hYgGWlfLHvsTDPe49ZHTujJ60+R8mPg8
	 wl+5k89HS8FnQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 11/16] riscv: kvm: Use generated instruction headers
 for mmio emulation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Charlie Jenkins via B4 Relay" <devnull+thecharlesjenkins.gmail.com@kernel.org>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260621-riscv_insn_table-v2-11-7f0810ee2274@gmail.com>
References: <20260621-riscv_insn_table-v2-0-7f0810ee2274@gmail.com>
 <20260621-riscv_insn_table-v2-11-7f0810ee2274@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 22 Jun 2026 04:27:08 +0000
Message-Id: <20260622042709.59C011F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] The migration to generated instruction headers missed the required=
 '+8' offset for compressed instructions that use 3-bit register fields, ca=
using KVM to access the wrong architectural registers.
- [High] Removal of `#ifdef CONFIG_64BIT` guards exposes 32-bit KVM hosts t=
o Undefined Behavior (negative bit shift) when a guest triggers 64-bit inst=
ruction emulation.
--

commit 5795a15cde75d07e7edad3d6b52a93e9aa4d9d86
Author: Charlie Jenkins <thecharlesjenkins@gmail.com>

riscv: kvm: Use generated instruction headers for mmio emulation
   =20
Migrate the mmio emulation code to use the generated instruction headers
instead of the hand-written instruction composition functions.

> diff --git a/arch/riscv/kvm/vcpu_insn.c b/arch/riscv/kvm/vcpu_insn.c
> index 8ccf6ec722f03..1d8741d022425 100644
> --- a/arch/riscv/kvm/vcpu_insn.c
> +++ b/arch/riscv/kvm/vcpu_insn.c
[ ... ]
> @@ -408,44 +408,47 @@ int kvm_riscv_vcpu_mmio_load(struct kvm_vcpu *vcpu,=
 struct kvm_run *run,
[ ... ]
> -#ifdef CONFIG_64BIT
> -	} else if ((insn & INSN_MASK_LD) =3D=3D INSN_MATCH_LD) {
> +	} else if (riscv_insn_is_ld(insn)) {
>  		len =3D 8;
>  		shift =3D 8 * (sizeof(ulong) - len);
> -	} else if ((insn & INSN_MASK_LWU) =3D=3D INSN_MATCH_LWU) {

[Severity: High]
By removing these CONFIG_64BIT guards, does this expose 32-bit KVM hosts
to undefined behavior?

If a guest triggers emulation of a 64-bit load, len becomes 8, and shift
is calculated as 8 * (sizeof(ulong) - len). On a 32-bit host where
sizeof(ulong) is 4, shift becomes -32.

This would result in a negative bit shift when kvm_riscv_vcpu_mmio_return()
later evaluates (long)data << shift >> shift.

> +		rd =3D riscv_insn_ld_extract_xd(insn);
> +	} else if (riscv_insn_is_lwu(insn)) {
>  		len =3D 4;
> -#endif
[ ... ]
> -	} else if ((insn & INSN_MASK_C_LW) =3D=3D INSN_MATCH_C_LW) {
> +	} else if (riscv_insn_is_c_lw(insn)) {
>  		len =3D 4;
>  		shift =3D 8 * (sizeof(ulong) - len);
> -		insn =3D RVC_RS2S(insn) << SH_RD;
> -	} else if ((insn & INSN_MASK_C_LWSP) =3D=3D INSN_MATCH_C_LWSP &&
> -		   ((insn >> SH_RD) & 0x1f)) {
> +		rd =3D riscv_insn_c_lw_extract_xd(insn);

[Severity: High]
Does this code read or write to the wrong guest register?

Compressed instructions like c.lw and c.sw use 3-bit register fields
corresponding to general purpose registers x8 through x15. The generated
extraction macros (like riscv_insn_c_lw_extract_xd) return the raw 0-7
value.

Without an explicit +8 offset mapping, won't KVM incorrectly use registers
x0-x7 as the index into the guest_context array?

> +	} else if (riscv_insn_is_c_lwsp(insn)) {
>  		len =3D 4;
>  		shift =3D 8 * (sizeof(ulong) - len);
> +		rd =3D riscv_insn_c_lwsp_extract_xd(insn);
>  	} else {
>  		return -EOPNOTSUPP;
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260621-riscv_insn=
_table-v2-0-7f0810ee2274@gmail.com?part=3D11
