Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B642478F2F
	for <kvm@vger.kernel.org>; Thu,  6 Aug 2026 01:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785981146; cv=none; b=i3yrVuzUfW+mT2xzfQajENOXy9tl4WhNflTPnfoEKFNnfwhQkyYzqfRqenld3x+Ypz8DOXTSI1h0BJGR3xflE19Xk8KbSbr6HocDSNUJ0YbPvQKCpoOJvpTRQg+H0XaPTtHO25pn21P8g99z2QOD9jkfiYbG/PHG8uk9V3VVxeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785981146; c=relaxed/simple;
	bh=Z2Fzpk87yOrJ8IaSrsMNUQ17EwV1JPnK4PtGsR2D078=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PyL5PVuuM20oUl4VT09V/N8naN7LtdePlT8i7OYRzfZzVFM5oCkvx9wTRfXLJkS2fkKCqxfL/SLTczbKwTA6aFL/SUTqdFpEtfXCXuzUSlJwYhmEkMGW9umOIrA3xcCl7rijO8DyIX9jTr6kb0ZfwtYrG5Py01uWxpcu0WwtVVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lxAEuE0l; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lxAEuE0l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A1641F000E9;
	Thu,  6 Aug 2026 01:52:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785981145;
	bh=aK2+pB/lfqkQXlbN8LBz6TYuCjA+OLOWtLQz5Ge3ixE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lxAEuE0lAWU7J5Hpattu1DlIg7yFuQks7sZTiex+PzJB2uMl2W1vqKI2PXTY4t9Ns
	 aPFmaA9ZytIaomUOdP3RYd1rLY4o0E5C/UVDdNeV5ee+naeYUjJI9373m2PAR0W9qX
	 WlBXb65G5Mn1+7JLlX3bcNSs0UlmT+8RTglo9wHCrmthLOChTMM9XOmW2BhBjiM2XI
	 /ni3ZfziP0fAqrSkZVJJxC8knWx985WKtUoGM1deYIYMaKQf2Zk3mTwugHu2vaJRy9
	 D/MM1sMSLAtfrW4uoFiZz1P6H1n1QLpGDoteMbn0U1uG/BGOWhMsq48fpNzqb0KSdE
	 Z78ZpLUkSNMcA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 4/7] KVM: VMX: Implement LASS violation check
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sohil Mehta" <sohil.mehta@intel.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260806011536.4172258-5-sohil.mehta@intel.com>
References: <20260806011536.4172258-1-sohil.mehta@intel.com>
 <20260806011536.4172258-5-sohil.mehta@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 06 Aug 2026 01:52:24 +0000
Message-Id: <20260806015225.3A1641F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] LASS enforcement for supervisor-mode instruction fetches incorrect=
ly ignores whether SMEP is enabled.
- [High] LASS is incorrectly enforced in compatibility mode, leading to spu=
rious #GP faults for supervisor accesses.
--

--- Patch [4]: [PATCH v4 4/7] KVM: VMX: Implement LASS violation check ---
commit 7357ad469a8f5e7cd4a7e4ed10750c1068c7cc69
Author: Zeng Guang <guang.zeng@intel.com>

KVM: VMX: Implement LASS violation check

This commit adds a VMX implementation for detecting Linear Address Space
Separation (LASS) violations during instruction emulation. It enforces
mode-based protections on emulated instruction fetches, data accesses,
and VMX/SGX ENCLS instructions. LASS enforcement relies on CR4 and RFLAGS
settings, applying restrictions selectively based on execution context.

> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
[ ... ]
> @@ -8604,6 +8604,53 @@ gva_t vmx_get_untagged_addr(struct kvm_vcpu *vcpu,=
 gva_t gva, unsigned int flags
>  	return (sign_extend64(gva, lam_bit) & ~BIT_ULL(63)) | (gva & BIT_ULL(63=
));
>  }
> =20
> +bool vmx_is_lass_violation(struct kvm_vcpu *vcpu, gva_t gva,
> +			   unsigned int size, unsigned int flags)
> +{
> +	const bool is_supervisor_address =3D !!(gva & BIT_ULL(63));
> +	const bool implicit_supervisor =3D !!(flags & X86EMUL_F_IMPLICIT);
> +	const bool fetch =3D !!(flags & X86EMUL_F_FETCH);
> +
> +	if (!kvm_is_cr4_bit_set(vcpu, X86_CR4_LASS) || !is_long_mode(vcpu))
> +		return false;

[Severity: High]
Should this check use is_64_bit_mode() instead of is_long_mode()?

If a guest is in compatibility mode with LASS and SMAP enabled, a compatibi=
lity
mode application might trigger an interrupt resulting in an implicit superv=
isor
access to the IDT or TSS. Since compatibility-mode linear addresses are 32-=
bit,
bit 63 is always 0.

Does using is_long_mode() cause the hypervisor to erroneously flag these as
LASS violations for supervisor mode, breaking 32-bit execution?

> +
> +	/*
> +	 * INVLPG isn't subject to LASS, e.g. to allow invalidating userspace
> +	 * addresses without toggling RFLAGS.AC.  Branch targets aren't subject
> +	 * to LASS in order to simplify far control transfers (the subsequent
> +	 * fetch will enforce LASS as appropriate).
> +	 */
> +	if (flags & (X86EMUL_F_BRANCH | X86EMUL_F_INVLPG))
> +		return false;
> +
> +	if (!implicit_supervisor && vmx_get_cpl(vcpu) =3D=3D 3)
> +		return is_supervisor_address;
> +
> +	/*
> +	 * LASS enforcement for supervisor-mode data accesses depends on SMAP
> +	 * being enabled, and like SMAP ignores explicit accesses if RFLAGS.AC=
=3D1.
> +	 */
> +	if (!fetch) {
> +		if (!kvm_is_cr4_bit_set(vcpu, X86_CR4_SMAP))
> +			return false;
> +
> +		if (!implicit_supervisor && (kvm_get_rflags(vcpu) & X86_EFLAGS_AC))
> +			return false;
> +	}

[Severity: High]
Does LASS enforcement for supervisor-mode instruction fetches require a che=
ck
for SMEP being enabled here?

According to the architecture specification, LASS applies to supervisor
instruction fetches only if SMEP is enabled, similar to how it requires
SMAP for data accesses.

If a guest OS running in 64-bit mode with CR4.LASS =3D 1 and CR4.SMEP =3D 0
performs a supervisor-mode instruction fetch from a user-mode address,
will omitting a kvm_is_cr4_bit_set(vcpu, X86_CR4_SMEP) check when fetch
is true cause a spurious #GP fault to be injected?

> +
> +	/*
> +	 * The entire access must be in the appropriate address space.  Note,
> +	 * if LAM is supported, @gva has already been untagged, so barring a
> +	 * massive architecture change to expand the canonical address range,
> +	 * it's impossible for a user access to straddle user and supervisor
> +	 * address spaces.
> +	 */
> +	if (size && !((gva + size - 1) & BIT_ULL(63)))
> +		return true;
> +
> +	return !is_supervisor_address;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260806011536.4172=
258-1-sohil.mehta@intel.com?part=3D4
