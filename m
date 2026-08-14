Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E6A73D332A
	for <kvm@vger.kernel.org>; Fri, 14 Aug 2026 16:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786725129; cv=none; b=KIzo42oEZgX5TNxbb4pFey6z+6HJ+dJ2HcpUy857afgtr7Rt0pdYxBxoBBESH2sMWswlEpuuo8rz/Soy72KO3wRvLpo/RlnRqYguXtJUNULx7lv63w6iXzp3IJx9IoNUqeehFTLe7/MCWJYfpZA2+COakrbZGJ5o3CnsesMiQ+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786725129; c=relaxed/simple;
	bh=VzrjakyueuoGXJJIY8AvoJ7aRzxRGDInxKTxVbWa0No=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=H5M5SEQS4xoijnf8PSlkShAtZ2YWYqyc8x2xAMiuaxsYBxo27kqM1p9MpsqfLEl26lktbU24ZlknAtSv3yUyCUiKXjAPe2ZzzWDDtb/fEI47doMMwKsrZLfZomd4joCvZg7wHhRbHDkjmAbaC3T6tJkwFj5NTmiNQbOe41b5XnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bytnrbk9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bytnrbk9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8C5D1F000E9;
	Fri, 14 Aug 2026 16:32:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786725128;
	bh=vuW15qxeu/tdUVfitcfQDgl0FgixfUIiPAwadFW6D2k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bytnrbk9Gl7fsYuw3nucwi/jBlxw3ErrtLBw5XpNONThhLtkt5/4bpC7fBbUIcIyL
	 WmBPgEIcbRDr2539MYSEjb6zJa1K/25GXVlqLJgZm2WyQCZracnuBcRSmMtZqNBHt3
	 MuzdTtKh28MKNB8aw4Ggx4vTFCK/tvBKR7LpP96VJPZKdwFg8Jclp3bIdEfzVoeZ4C
	 bHqgQ2kX1RuA/rKX9qiYfnGplfgXIYgwhnPDHUeySpCoKE+z1RBTvuwA4YGttyPame
	 /jkpYSSK6pk0N4Xi1wJLavoKq8flBe9a3BeZ8FpztZotmziuO9luGUIc3PYRztxmWC
	 aBpQchaacNKKg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/4] KVM: nVMX: Make VMPTRST return eVMCS GPA when it is
 used
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vitaly Kuznetsov" <vkuznets@redhat.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260814162221.2144473-3-vkuznets@redhat.com>
References: <20260814162221.2144473-1-vkuznets@redhat.com>
 <20260814162221.2144473-3-vkuznets@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 16:32:07 +0000
Message-Id: <20260814163207.D8C5D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Compilation failure when CONFIG_KVM_HYPERV is disabled.
--

--- Patch [2]: [PATCH 2/4] KVM: nVMX: Make VMPTRST return eVMCS GPA when it=
 is used ---
commit e9f713cf2125ef734863ce5fc9c30ea6f602ede7
Author: Vitaly Kuznetsov <vkuznets@redhat.com>

KVM: nVMX: Make VMPTRST return eVMCS GPA when it is used
   =20
This commit changes the behavior of VMPTRST to return the eVMCS GPA when
eVMCS is active. This aligns KVM's behavior with genuine Hyper-V instead of
returning 1 without skipping the instruction.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D221841

> diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
> index c78c67525ac9b..d13a4d47bc68f 100644
> --- a/arch/x86/kvm/vmx/nested.c
> +++ b/arch/x86/kvm/vmx/nested.c
[ ... ]
> @@ -5958,8 +5958,14 @@ static int handle_vmptrst(struct kvm_vcpu *vcpu)
>  	if (!nested_vmx_check_permission(vcpu))
>  		return 1;
> =20
> -	if (unlikely(nested_vmx_is_evmptr12_valid(to_vmx(vcpu))))
> -		return 1;
> +	/*
> +	 * Hyper-V TLFS does not specify the behavior of VMPTRST when eVMCS is =
used
> +	 * but genuine Hyper-V seems to be returning eVMCS GPA.
> +	 */
> +	if (nested_vmx_is_evmptr12_valid(to_vmx(vcpu)))
> +		current_vmptr =3D to_vmx(vcpu)->nested.hv_evmcs_vmptr;

[Severity: Low]
Will this cause a build failure when CONFIG_KVM_HYPERV is disabled?

Because nested_vmx_is_evmptr12_valid() is a static inline function rather
than a preprocessor macro, the compiler still evaluates and type-checks
this branch even when the helper is hardcoded to return false. If the
hv_evmcs_vmptr member in struct nested_vmx is conditionally compiled based
on CONFIG_KVM_HYPERV, the compiler will fail to find it here.

> +	else
> +		current_vmptr =3D to_vmx(vcpu)->nested.current_vmptr;
> =20
>  	if (get_vmx_mem_address(vcpu, exit_qual, instr_info,
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260814162221.2144=
473-1-vkuznets@redhat.com?part=3D2
