Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F952388392
	for <kvm@vger.kernel.org>; Mon, 20 Jul 2026 18:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784571166; cv=none; b=E6AOxSK+f+ZjQCqMl4+8LnPZ60CiqwoOqhXL21HEuuYmbpm61XsfvzcRYh2goaEpAFsbu/5KFNK7p6yZBsXBv8cWwvsjALIRtn6ZVacG3XQsz9X7w5ZP0PABN3SY0oHUcQ9d1z/Ik4h9Lmnq81/mWRixJlncZTrqrMKLgjE7l0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784571166; c=relaxed/simple;
	bh=Dsf0J00nBbaqCkZJbvfNlWCDqudt2Md2SPXUyVR+1zE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=djfvGLqvNitD/v1ys7Qd3zPwkrcay6gKQgQWOwrrhyBzkJqIMv40kj34JUXSx/gUVKefigH8F8aaf8dyk7FYMwUJ45AYrAnqwCpNQnN9VWfnNVZsxpzgBNv/Q6wZA8jxWBKtvSL/Tg8nuWx80HnByc1AFvzOBycHRUkHhBzRprA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dFRnhfH6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dFRnhfH6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4AA41F000E9;
	Mon, 20 Jul 2026 18:12:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784571165;
	bh=xovvLh4ejVu13dmbtAuIq9H6nAXxqu7rM9M6vX0rE6o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dFRnhfH6t0wtX0r2HN/fyUHVeWmAt2zq7GeWkLt+T86WSTRww6U2pk3T6QzuWRvjU
	 XZCwlWKnQEXVVJzTqYv9z6TEgiIdypziu8oGfMuL1fEgsgcPEhH4CVzOQEaNo406IS
	 SEEfsWDBun6gpI5g4bBqKT0AshCxcfujTWsNUtctJ9BuZQ1txGMWS+9ED31k1vaNad
	 gdlbq4OdZaQRz1b/huyG83X0ZnXILnhwnE8RvpuZ0WAF0/1R6yVEzI47JxLinPUcuH
	 D4Ua9M3B/MUA0pOzgNU7Awl17MEnTG9PlSYZSIA/nKdox/4XHtyDR5glZBlroZq/KQ
	 18o6coeD7DsLA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 17/20] KVM: x86: Expose APX foundation feature to
 userspace
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chang S. Bae" <chang.seok.bae@intel.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260720171949.498680-18-chang.seok.bae@intel.com>
References: <20260720171949.498680-1-chang.seok.bae@intel.com>
 <20260720171949.498680-18-chang.seok.bae@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Jul 2026 18:12:44 +0000
Message-Id: <20260720181244.E4AA41F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] CPUID leaf 0x29 is not added to cpuid_function_is_indexed(), pre=
venting KVM from properly flagging it as a multi-subleaf CPUID.
--

--- Patch [17]: [PATCH v5 17/20] KVM: x86: Expose APX foundation feature to=
 userspace ---
commit e317b8613a3aae9996b941415cb6b3fe55b0643f
Author: Chang S. Bae <chang.seok.bae@intel.com>

KVM: x86: Expose APX foundation feature to userspace

This commit exposes the APX feature to userspace components and updates the
maximum supported CPUID leaf to 0x29. It clears the APX feature on SVM
environments since EGPR support is not yet implemented.

> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> --- a/arch/x86/kvm/cpuid.c
> +++ b/arch/x86/kvm/cpuid.c
[ ... ]
> @@ -1713,6 +1717,10 @@ static inline int __do_cpuid_func(struct kvm_cpuid=
_array *array, u32 function)
>  		}
>  		break;
>  	}
> +	/* APX sub-features */
> +	case 0x29:
> +		entry->eax =3D entry->ebx =3D entry->ecx =3D entry->edx =3D 0;
> +		break;

[Severity: Medium]
Should CPUID leaf 0x29 also be added to cpuid_function_is_indexed() in
arch/x86/include/asm/cpuid/api.h?

Without adding it there, KVM will not set KVM_CPUID_FLAG_SIGNIFCANT_INDEX
for leaf 0x29. This causes kvm_find_cpuid_entry2() to ignore the
guest-provided ECX sub-leaf index when resolving this leaf.

If a VMM populates leaf 0x29 index 0 with APX features, a guest querying
index 1 will incorrectly receive the features of index 0 instead of
all-zeros.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260720171949.4986=
80-1-chang.seok.bae@intel.com?part=3D17
