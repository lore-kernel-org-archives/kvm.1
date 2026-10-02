Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D6CF471414
	for <kvm@vger.kernel.org>; Fri,  2 Oct 2026 09:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790932424; cv=none; b=kLnlhX45gV+M5uM/U1oUCRIu1lvql3Jm0fqodBIeXelQm8MVPJHou19ou45sRilVxxbuDJvoqL3QV3s/lBDyVawFAsMplg7ytAOJOG5OnDu//yThRfRJBN2HqGd1UHXGJ7c03k7AsWyttpN6MMgnsGzr4rymBWKYkS8M8Lj1ZCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790932424; c=relaxed/simple;
	bh=+Odf9+yfXn9iDf0FSbH3a+4cQGi3b1tPsua5/4x+52E=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KrwV96INZdgk6ZyAbchJTt4E5JAjyO1CF0bS0f1KUqI61edFeOr405GaNp0ED+aX0UHLGsngKvLWcJGEqIzFg+zYYAnDQllk4EtTvNUh0ZkHunM9s1vO5rYGRCpLfHhaoV1oN6YLKaMReUMuRohzhr6HcFvGTisHB6Q0a1yUOdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FM7Yvyt7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FM7Yvyt7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02E3B1F00899;
	Fri,  2 Oct 2026 09:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790932423;
	bh=/zmlTSObAu8HD3YArFH/qPrscwKR+rdTSmyOSDSMMKE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FM7Yvyt7L9JgwOVHF1Mq2JKsxAi93zhTmYzxeY00O6yFzSWEsqm9QXwtK3a9y5x2Z
	 uUIhrgxwP8vddeXxtWyNHh/XTwCa0HL3laBKsvNlfyHq48k0Op3ZlOV9/jC0PLWqqM
	 o7gtRbsUuR6cwuqJJ5WJELZJNMJnLkih+Su8eWpoRSQuGL7SEhxlgMaGG41fvPSXBS
	 dKuqg1qbGW1yPswnU8js52d8de5YbnA/+ip7OyWARFrbqAaeoZiE8rxNHJQjLR50gA
	 2OxL2azTxTzmgM0VecgRDndgrNUS7f+rAusgQtp2gc5kEMBGxSYqawxuDRNfJr2TfI
	 CzfSPD2psrNIA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 10/10] KVM: Pre-check uaccesses in KVM's APIs to
 read/write guest memory
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sean Christopherson" <seanjc@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20261001202234.3794060-11-seanjc@google.com>
References: <20261001202234.3794060-1-seanjc@google.com>
 <20261001202234.3794060-11-seanjc@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 02 Oct 2026 09:13:42 +0000
Message-Id: <20261002091343.02E3B1F00899@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] kvm: bounds check bypass in kvm_is_guest_access_ok due to intege=
r truncation and size ignore
--

commit 3b0fbcae79b36e79408bde507ed9fb555ab9f477
Author: Sean Christopherson <seanjc@google.com>

KVM: Pre-check uaccesses in KVM's APIs to read/write guest memory

This commit adds an early check for user access validity in KVM's guest
memory APIs. It introduces kvm_is_guest_access_ok() to validate access
bounds before performing memslot lookups, aiming to catch bugs during VM
teardown more noisily.

> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 770a2c3bd4458..80b19d47840b2 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
[ ... ]
> @@ -3211,6 +3211,11 @@ static int next_segment(unsigned long len, int off=
set)
>  		return len;
>  }
> =20
> +static bool kvm_is_guest_access_ok(struct kvm *kvm, int offset, int len,=
 int size)
> +{
> +	return kvm_can_do_uaccess(kvm) && !WARN_ON_ONCE(offset + len > PAGE_SIZ=
E);
> +}

[Severity: Medium]
Does this helper ignore the provided size parameter?=20

By hardcoding PAGE_SIZE in the WARN_ON_ONCE check, callers that pass a
smaller boundary (such as ghc->len) will have their custom bounds check
bypassed. If offset + len exceeds the custom size limit but remains under
PAGE_SIZE, it appears the access would be incorrectly permitted.

[ ... ]
> @@ -3294,7 +3299,7 @@ static int __kvm_read_guest_atomic(struct kvm *kvm,=
 struct kvm_memory_slot *slot
>  	int r;
>  	unsigned long addr;
> =20
> -	if (WARN_ON_ONCE(offset + len > PAGE_SIZE))
> +	if (!kvm_is_guest_access_ok(kvm, offset, len, PAGE_SIZE))

[Severity: Medium]
Does this silently truncate the len parameter?

In __kvm_read_guest_atomic(), len is defined as an unsigned long, but
kvm_is_guest_access_ok() takes len as a signed int.

>  		return -EFAULT;
> =20
>  	addr =3D gfn_to_hva_memslot_prot(slot, gfn, NULL);
[ ... ]
> @@ -3457,7 +3462,7 @@ int kvm_write_guest_offset_cached(struct kvm *kvm, =
struct gfn_to_hva_cache *ghc,
>  	int r;
>  	gpa_t gpa =3D ghc->gpa + offset;
> =20
> -	if (WARN_ON_ONCE(len + offset > ghc->len))
> +	if (!kvm_is_guest_access_ok(kvm, offset, len, ghc->len))

[Severity: Medium]
Similar to the above, len is an unsigned long here, which gets truncated
when passed to the signed int argument of the helper.=20

Additionally, ghc->len is passed as the size parameter, which is completely
ignored by kvm_is_guest_access_ok() in favor of PAGE_SIZE. Will this bypass
the intended cache length check?

>  		return -EINVAL;
> =20
>  	if (slots->generation !=3D ghc->generation) {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261001202234.3794=
060-1-seanjc@google.com?part=3D10
