Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 919C9431A5C
	for <kvm@vger.kernel.org>; Mon, 20 Jul 2026 18:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784571024; cv=none; b=sTA9n700IH3JnWq/IlXRSLb1JMR28jYjlrgY7RkJmW3t3CLBDGGcWvx/uSiAHhs8WO7DNJQU70xg2zEH2t68lPpaxL8X7BLdUplDMIYdBtl/e+w2tyg2QN99AiwEvz2F0lhB5nhotR5kb8SVskwrOOanqDJSc89WS009Tu3eNF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784571024; c=relaxed/simple;
	bh=EHkA2v+AXhrQbSNriCf7XPkFWBbD/Z2/yEMVzHW0INk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BHhXoZy3fECqJm1siPap5kSZjr10zxX/MYvtWooO7WWPYWVLkz7z+/B2aMmpQQPR/W0tEM+zQ4KACsBp2poHfkbDXy4Frt/WZ24MP4KnyyhgwjAH5lOiyY+CvpptWDj2J9uWxaK5rVP7M2wNUGFjy32WQyZQZTmVDdYVc1yW2mQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j9SAQ1yE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j9SAQ1yE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB96F1F00A3A;
	Mon, 20 Jul 2026 18:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784571023;
	bh=4qy52e1Zy/dr9nw08VjAa2DSKTjmPkUGnjw/lRI9noo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=j9SAQ1yEQovObkWX8S7/YLUvCWOuNx8+ATpmkY+R7hubHSSuCj8RZ3wnqPyLiHc6l
	 sID9e49BPsB7yzk9okSTlSc8AItoOFcDrcidpGovn8vJD21Bt20S+kTWO08UESEBAY
	 tPUPZ0HquyaL7pqJe67MlrfqKbX1Ux9r+JR6JcFrcLCVmYH0nssk7PFYS9u9RoNjcK
	 iLHcJibvUFX5d13XYGqc/cCv9d87Wu9PVF1RlOx7+Zor6KWZ8ToIAMj26hb/WMOtQx
	 sdR4jCuMchwbozD01J5tTV6N/Z3ZFPq6lxSDGNRmba9eCfexBRvaKfQ8gCyuqd7oEc
	 y/m9YmXkbju1w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 18/20] KVM: x86: Expose APX sub-features to userspace
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chang S. Bae" <chang.seok.bae@intel.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260720171949.498680-19-chang.seok.bae@intel.com>
References: <20260720171949.498680-1-chang.seok.bae@intel.com>
 <20260720171949.498680-19-chang.seok.bae@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Jul 2026 18:10:22 +0000
Message-Id: <20260720181022.CB96F1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] KVM fails to mask host CPUID values for leaf 0x29, silently exposi=
ng raw, unvirtualized host features and unknown future APX sub-features to =
userspace and the guest VM.
- [Medium] CPUID leaf 0x29 is an indexed leaf but is missing from `cpuid_fu=
nction_is_indexed()`, causing KVM to return sub-leaf 0's data for all reque=
sted sub-leaves.
--

--- Patch [18]: [PATCH v5 18/20] KVM: x86: Expose APX sub-features to users=
pace ---
commit 86716b3a350e45c75f1b5a6c88353188cae56ce0
Author: Chang S. Bae <chang.seok.bae@intel.com>

KVM: x86: Expose APX sub-features to userspace

This commit adds CPUID leaf 0x29 sub-leaf 0 to expose APX sub-features
(NCI, NDD, NF) to userspace if the APX foundation is available.

> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> --- a/arch/x86/kvm/cpuid.c
> +++ b/arch/x86/kvm/cpuid.c
[ ... ]
> @@ -1719,7 +1723,8 @@ static inline int __do_cpuid_func(struct kvm_cpuid_=
array *array, u32 function)
>  	}
>  	/* APX sub-features */
>  	case 0x29:
> -		entry->eax =3D entry->ebx =3D entry->ecx =3D entry->edx =3D 0;
> +		if (!kvm_cpu_cap_has(X86_FEATURE_APX))
> +			entry->eax =3D entry->ebx =3D entry->ecx =3D entry->edx =3D 0;
>  		break;

[Severity: High]
If kvm_cpu_cap_has(X86_FEATURE_APX) is true, does this bypass capability
filtering and expose raw host CPUID values for leaf 0x29?

Looking at other leaves in __do_cpuid_func(), they typically use
cpuid_entry_override() or manually clear unused registers to apply the KVM
masks. Without this masking, it appears a userspace VMM querying
KVM_GET_SUPPORTED_CPUID for leaf 0x29 will receive unvirtualized hardware
features, which could then leak into the guest.

[Severity: Medium]
Does cpuid_function_is_indexed() in arch/x86/include/asm/cpuid/api.h also
need to be updated to include 0x29?

Since leaf 0x29 is an indexed leaf (as indicated by the newly added sub-leaf
0), missing it in cpuid_function_is_indexed() means KVM will not set
KVM_CPUID_FLAG_SIGNIFCANT_INDEX.=20

As a result, if a guest queries an unsupported index like ECX=3D1,
kvm_find_cpuid_entry2() might incorrectly return the data for sub-leaf 0
instead of treating it as a distinct entry.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260720171949.4986=
80-1-chang.seok.bae@intel.com?part=3D18
