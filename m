Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B875F39BFEC
	for <kvm@vger.kernel.org>; Mon, 10 Aug 2026 11:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786361965; cv=none; b=NHjF1u7p+gTEiulyhWt6OA0+Z+VL2n2se+RGLb8x4Fanbs/WA3YgYIJZ7hcOA56LFamahNAi3Zk1NUzSvG9BPKDuUPwPru8IfU7uzi766oH4IFJy7F9xDRisnNACVmttTk4BTPkTddkQIcqnDwm/JoOkzr1QrCvRkUQE74kV6GE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786361965; c=relaxed/simple;
	bh=xkFREG0YvuKokzgxr5U/43Xr1vgqHFzrVD+BJbML6go=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KAYNo6IKT1zhAA1tgxRQpe5EVDqtLbDaeBbP7VgOECpci1wC5eeIOOjnjXDB4dWcN0c1YVtCsVUyryUqFRz0EplVTXK5aEE3yKRDCuaFVGTSbSZsc950tVY+ZLkjbrXr8ozDzabRupuehUr2sXPuobJciIZsWTMnIafwAtnGlaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=buvhcnO8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="buvhcnO8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ACBE1F000E9;
	Mon, 10 Aug 2026 11:39:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786361964;
	bh=gfbSVEQ1KNgz02BcPakjzI7j97QZClctgHnvwiZ93yE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=buvhcnO83iCPVtQdAcZ9IMkDc1D2FO/cKLs+Lcmpkj75sFyRV02Vd73aTEHgxPszd
	 uW1qSmevgYNiWPrWGt9oW5xy2Cs/jGqL3KU8aARrDfnKq7F0e5gv1Z/3YBCvEB6Lrj
	 tylcCGDyE7sPx4ybggw7m8GEBej0fPmaTy8shME50H+ki08GcnY/zNUMvKiSrbMplA
	 7a3Z1sXrG9e0B5ahHQNR2znipndSFSRPFEIGC30CeT23kdCzSXDd6AAXiEUEbvbJzY
	 ebFC7j0eiq0Klxfh0J1dtcYIwwNv8kpyw6l18RotLbzqooxZgfEPGd+dRohDKmk2iS
	 wobIBKpeUWurw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/3] KVM: TDX: Fix the exit reason handling
Reply-To: sashiko-reviews@lists.linux.dev
To: "Xiaoyao Li" <xiaoyao.li@intel.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260810112200.2326727-3-xiaoyao.li@intel.com>
References: <20260810112200.2326727-1-xiaoyao.li@intel.com>
 <20260810112200.2326727-3-xiaoyao.li@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 10 Aug 2026 11:39:23 +0000
Message-Id: <20260810113924.4ACBE1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The condition `tdx->vt.exit_reason.basic !=3D -1` in `tdx_get_ex=
it_info()` is unconditionally true due to C integer promotion rules, defeat=
ing the check for synthesized invalid exit reasons and leaking uninitialize=
d or host state to the `kvm_exit` tracepoint.
--

--- Patch [2]: [PATCH v2 2/3] KVM: TDX: Fix the exit reason handling ---
commit d21d0519253cbb288be7d1030cb7a0bb7547067a
Author: Xiaoyao Li <xiaoyao.li@intel.com>

KVM: TDX: Fix the exit reason handling

This patch modifies how KVM handles TDX exit reasons by isolating
the lower 16 bits into the basic field and keeping the upper 16 bits
unchanged. It synthesizes an invalid exit reason (-1) for specific
TDX SEAMCALL statuses and updates tdx_get_exit_info() to check this field.

> diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
> index 66e9e6ee62dae..2c8844acbd43e 100644
> --- a/arch/x86/kvm/vmx/tdx.c
> +++ b/arch/x86/kvm/vmx/tdx.c

[ ... ]

> @@ -2147,7 +2156,7 @@ void tdx_get_exit_info(struct kvm_vcpu *vcpu, u32 *=
reason,
>  	struct vcpu_tdx *tdx =3D to_tdx(vcpu);
> =20
>  	*reason =3D tdx->vt.exit_reason.full;
> -	if (*reason !=3D -1u) {
> +	if (tdx->vt.exit_reason.basic !=3D -1) {

[Severity: Medium]
Will this check always evaluate to true due to C integer promotion rules?

The basic field in union vmx_exit_reason is a 16-bit unsigned bitfield. When
comparing it to -1, the unsigned 16-bit value is promoted to a signed 32-bit
integer. If the value was set to -1 (65535), the comparison evaluates as
65535 !=3D -1, which is always true.

Could this cause uninitialized or host state (such as tdvpr_pa passed via r=
cx
to the TDX module) to leak to the kvm_exit tracepoint instead of falling ba=
ck
and safely zeroing the exit data?

>  		*info1 =3D vmx_get_exit_qual(vcpu);
>  		*info2 =3D tdx->ext_exit_qualification;
>  		*intr_info =3D vmx_get_intr_info(vcpu);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260810112200.2326=
727-1-xiaoyao.li@intel.com?part=3D2
