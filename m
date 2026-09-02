Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179B6233D9E
	for <kvm@vger.kernel.org>; Wed,  2 Sep 2026 03:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788318037; cv=none; b=PMW4XnlcmFeJHqaKNl1VxA1zudtUMY//IhbXStCg9l0Hl9LTVn1QmRKuSqzby9QdwIVcCbRW+6EFew+8nxHICzF86i2rDLpcfTmdB6wNq7lfm4gP1729Fdjbj+Ebr2xvsRfqaxsiEaXAD/716mdjgkR6jeX40H38hlMY890H7JE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788318037; c=relaxed/simple;
	bh=Nm/zVf75wbLwEvf0ICOmjGdz7gOqEeXAYrv0MjQtX6c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gzrwqa8a01PVuk6P/RtUdaJDzWy0dY/UI45Xh7doJlQrOq/zu2ZN55ZFyWsWupUd0mQ4SKFtn7DuiFCbhyKVsbv6TsdqJ4jFEU3fuEHjB3D9OU7ygJNPpvXZxy+EiLZtVjTo/osk0ky8mEBYe/tiaYtwzgBuiyONEUt/NssxjsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hI+Rg6Uw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hI+Rg6Uw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95DC11F00A3A;
	Wed,  2 Sep 2026 03:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788318035;
	bh=bBpGALnF15NFbJbFt6+Vvlv9l8uqJgpOLCHnFP3L4/s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hI+Rg6Uw3tMjM/5v2r6YrlTDGMaV0++UUPT11JFTU/B7KLRRiHmGxeLCgYRovQYmI
	 cW0xusklnlV5CE7gN4yt1QlpUSjf3UL/8ycpLCau4Y+FCB6jR2Ih8h1lH01wF9CMfM
	 FGZ9cCLu0tgWUdD9ferqSq9TNypgwMNP3ui+oQZCAv4ExfQqlT7AxEFmedCQvppnwT
	 XxaIWC0+r+RAp9tk3nEbb3Mm5n3yLKZhEjtAhB27AAUUEqp0PtUKsGNMxA2aNM6nHJ
	 AITa8duWLuNnz901p+GRMShIuX4+7jYdvBTQjlWDz0yHSHbXtHA1CUtQt+C4ohavgr
	 pLVj9Vi8OFWLQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 18/20] KVM: x86: Expose APX sub-features to userspace
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chang S. Bae" <chang.seok.bae@intel.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260902021804.718676-19-chang.seok.bae@intel.com>
References: <20260902021804.718676-1-chang.seok.bae@intel.com>
 <20260902021804.718676-19-chang.seok.bae@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 03:00:35 +0000
Message-Id: <20260902030035.95DC11F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] KVM exposes unmasked host APX sub-features and leaks raw host CP=
UID state to the guest by failing to apply the capability mask for leaf 0x2=
9.
--

commit c301f6e3ae94455385fa1906a5a873f104314430
Author: Chang S. Bae <chang.seok.bae@intel.com>

KVM: x86: Expose APX sub-features to userspace
   =20
Add CPUID leaf 0x29 sub-leaf 0 to expose these APX sub-features, if the
APX foundation is available: New Conditional Instructions (NCI), New Data
Destination (NDD), and Flags Suppression (NF).

> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> index 990ad7ea48186..6c47e0ffedd84 100644
> --- a/arch/x86/kvm/cpuid.c
> +++ b/arch/x86/kvm/cpuid.c
[ ... ]
> @@ -1733,7 +1737,8 @@ static inline int __do_cpuid_func(struct kvm_cpuid_=
array *array, u32 function)
>  	}
>  	/* APX sub-features */
>  	case 0x29:
> -		entry->eax =3D entry->ebx =3D entry->ecx =3D entry->edx =3D 0;
> +		if (!kvm_cpu_cap_has(X86_FEATURE_APX))
> +			entry->eax =3D entry->ebx =3D entry->ecx =3D entry->edx =3D 0;
>  		break;

[Severity: Medium]
Will this leak unmasked raw host CPUID state to the guest when APX is
available?

Since do_host_cpuid() populates the initial entry directly from the physical
CPU's output, it appears this case completes without calling
cpuid_entry_override(entry, CPUID_29_0_EBX) to apply the capability mask.

Does omitting the override mean KVM passes the raw host CPUID 0x29:0 direct=
ly
to the guest, including eax, ecx, edx, and any unsupported ebx bits?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902021804.7186=
76-1-chang.seok.bae@intel.com?part=3D18
