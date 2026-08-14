Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E15F6472F72
	for <kvm@vger.kernel.org>; Fri, 14 Aug 2026 16:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786725078; cv=none; b=Ic0ow5CBQPZyvxPt6Hg4OsDpplAeEtybOeEDlJzovkDt0ItiJEzATq0hXDQX6CgEQmqKeGotvvQKLfoD6vsIbuRjW4WAaCL14XnM9DmaAfsjgjbCIU+EGLLpKKXtDblMXG7ROhUr+QGMTViy6PDatojZsuuVD2pFJvYEBtLBLwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786725078; c=relaxed/simple;
	bh=OK/9//Dj+gAaaxS4pnys9c0BCgVJkDvubRE7/V000ik=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fifB1kyfABm/EXszjyTJs+6LBKNI8eV9blLxN+LkENDwvTLy8PGMJMfeCl9Q0YEpBbzGq5rMulTYlmkuK3cDB1Iyg4tsFwxFv494hZG5t7udYs/T+o8qUwkGgpy21jqegcCxN+5tqXPTr7h3koz+t8wGjqSPPmryvV/0FXuSHWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GzNrGjJO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GzNrGjJO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74F2B1F000E9;
	Fri, 14 Aug 2026 16:31:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786725076;
	bh=kJJ9NTwcpPOpFkSUdOJ67ka9Xt26NqkiRvH2unZCl1E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GzNrGjJOQLlz1gfWOG0qK6+k55I8HxK4/eTeifDUusObS+QI9aIbe3WDkzB0kd5eI
	 LXxEjYjOOnqIQEN0iXsgKAWjWFfH6SV9+9LJKqG3pzob41N6ZxWP1eOShh+eEoS75o
	 Qr9ZLUgM3aMPfpPJnHKxicC/k9riTy+w+q8DzvPQpblIvzLVipyEIYDCBePbSyJDwt
	 E+rZSYcQNW3vDiUXwZl8c65dtqmjuA8EfN11s60xciHCkXwdwlLnCazuvumEcAbUUe
	 H/i7YN6L8zsORLHO/TkLLKOy8UtG7+sk0jznI5QdBlUrJJ7aPtrRyzHcKaD6vWJjwt
	 j/Gl5NkLgChNA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/4] KVM: selftests: Adapt to the updated VMPTRST
 behavior when eVMCS is used
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vitaly Kuznetsov" <vkuznets@redhat.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260814162221.2144473-4-vkuznets@redhat.com>
References: <20260814162221.2144473-1-vkuznets@redhat.com>
 <20260814162221.2144473-4-vkuznets@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 16:31:16 +0000
Message-Id: <20260814163116.74F2B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The helper function `evmcs_vmptrst` became completely unused after =
this patch removed its only caller in `vmptrst()`, but its definition was l=
eft behind.
--

--- Patch [3]: [PATCH 3/4] KVM: selftests: Adapt to the updated VMPTRST beh=
avior when eVMCS is used ---
commit 18309c20d40234d7991916df5f035584459347c3
Author: Vitaly Kuznetsov <vkuznets@redhat.com>

KVM: selftests: Adapt to the updated VMPTRST behavior when eVMCS is used

This commit updates selftests to stop mocking VMPTRST behavior with eVMCS,
adjusting them to match genuine Hyper-V behavior. It removes the
eVMCS-specific branch from vmptrst() and modifies the eVMCS test expectatio=
ns.

> diff --git a/tools/testing/selftests/kvm/include/x86/vmx.h b/tools/testin=
g/selftests/kvm/include/x86/vmx.h
> --- a/tools/testing/selftests/kvm/include/x86/vmx.h
> +++ b/tools/testing/selftests/kvm/include/x86/vmx.h
> @@ -341,9 +341,6 @@ static inline int vmptrst(u64 *value)
>  	u64 tmp;
>  	u8 ret;
> =20
> -	if (enable_evmcs)
> -		return evmcs_vmptrst(value);
> -

[Severity: Low]
Does this leave evmcs_vmptrst() as unused dead code?

Since this was the only caller, the definition in=20
tools/testing/selftests/kvm/include/x86/evmcs.h is left behind:

static inline int evmcs_vmptrst(u64 *value)
{
	*value =3D current_vp_assist->current_nested_vmcs &
		~HV_X64_MSR_VP_ASSIST_PAGE_ENABLE;

	return 0;
}

Could this definition be removed as well to keep the header clean?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260814162221.2144=
473-1-vkuznets@redhat.com?part=3D3
