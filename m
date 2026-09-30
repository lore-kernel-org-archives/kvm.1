Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B17351EE1E
	for <kvm@vger.kernel.org>; Wed, 30 Sep 2026 21:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790804619; cv=none; b=jYkaWzi1DYTx7OrlG59KZ38/+hHG2BzrutZJbMcXdjhrPOqTwx+r1orBmt/WppAyUNQKQTFdSmHc+i3mL5OLxTyCb7cWP+UL/dqYRbDPPfhuWyavt6XoJtfZPq7izLY9oPcuh40hPj1tbOjQH/PIMyMYgHHdSSYA6lywigfJlxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790804619; c=relaxed/simple;
	bh=oAM9BEPdO+2lB0fPevZ8PtTTa5Ne01iPxVrJGPbXQf4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=eMGPl7xRz2LAaYnQ2YkZniYlFgcq2Oi2sS6JgV1y5gzKgIEyBk9SlVdTn7TgJrmnonEroKMOo8qkuSD0qFaDetqChr1FPttn7T5vmoq85HxJ5UJ3+j7AK6fgwuxTL2XE9gOPMW17PzCkmAYDUH45jD1tx1Gr2GYs9h+UEEogyFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PZTJHWnl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PZTJHWnl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90CD51F0089A;
	Wed, 30 Sep 2026 21:43:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790804617;
	bh=ziS+bedr7OJIfMgmHKmz6ad9HpLn4MOAGSRAgKreCOs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PZTJHWnlSJo2aAyeKQcoLZTO5NOVG5R5RPWjnuSmPThp/UqYkrCIFSRAM0nuMtX0g
	 UYoxILGH9Q+nICYCtUu3xQ1iP2SP60m2oUmBG9999cyqARIUEFo4FD0AxnElptkoQI
	 +z8vAtApj3c2rZkeM+4lP0kaWSEp9GIbgeZxBFno1XbuKVwmTRQqV3a7TMHIWoJred
	 Dnv8FWN5HE2tak1Gt9ICTdHxgE5s4fP0S/mV6Prl2oLvFA9/iOptCH0MJwhAhqV0P7
	 Mw0hbRdZULsNXqUjHqHhAOBhYKLzcfVuYoUjhDpTbCR3SOVEegLbkf6cfMv7lOzJ5U
	 Xk/plSAgGWvaw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 18/20] KVM: x86: Expose APX sub-features to userspace
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chang S. Bae" <chang.seok.bae@intel.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260930210750.1487547-19-chang.seok.bae@intel.com>
References: <20260930210750.1487547-1-chang.seok.bae@intel.com>
 <20260930210750.1487547-19-chang.seok.bae@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 21:43:37 +0000
Message-Id: <20260930214337.90CD51F0089A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] kvm: x86: Missing cpuid_entry_override for leaf 0x29 exposes unm=
asked host features
--

commit 93c8fb6f09423dcd87349e9f19f305fc82d6113e
Author: Chang S. Bae <chang.seok.bae@intel.com>

KVM: x86: Expose APX sub-features to userspace

This commit adds CPUID leaf 0x29 sub-leaf 0 to expose APX sub-features
(New Conditional Instructions, New Data Destination, Flags Suppression)
to userspace if the APX foundation is available.

> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> index 990ad7ea48186..6c47e0ffedd84 100644
> --- a/arch/x86/kvm/cpuid.c
> +++ b/arch/x86/kvm/cpuid.c
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
Does this code leak unfiltered host CPUID capabilities for leaf 0x29 to the
guest?

If the host supports X86_FEATURE_APX, KVM fails to apply
cpuid_entry_override(entry, CPUID_29_0_EBX) or explicitly clear the
unvirtualized registers (eax, ecx, edx) for leaf 0x29 in __do_cpuid_func().

This could bypass the capability mask initialized in
kvm_initialize_cpu_caps(), violating the KVM invariant that new
guest-visible features must default off and be explicitly enumerated.
This might break capability negotiation and live migration between hosts
with varying hardware support.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260930210750.1487=
547-1-chang.seok.bae@intel.com?part=3D18
