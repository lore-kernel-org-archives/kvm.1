Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 088FC2DA775
	for <kvm@vger.kernel.org>; Mon,  1 Jun 2026 16:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780330161; cv=none; b=SM96smGCpm3hQ6J9emzaA/0F9Tto4L4ScaQL7mFKe5eG8uM3yPKG9xkuOgjIlLJFJ309xDvV1efZ686SNW97nSMoFnbN5lLZ87yTBe9CUuQoCG3F8OXtfQf0czM6mcHX67LTKQkxVodoBlyiz/K3iPqJEyRQjaNxdOhlJZN5M+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780330161; c=relaxed/simple;
	bh=BKh0LYa3+KixITxqd5d5kuREXIKGV1eZGe4VGdAvnNk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=srqo3eZlsF38KBLIVtexWzt1CF0wcCoZsP0fyAjZPUliNOrSq8itI9O4xXyF5M2tmOEgyPoMxSFWq0KAG9wOVaFBNQH4O79t0SXRh7oNRbIGBCrSCoSoWSLGaAJBIPgMX5YFwUgmeW46mV/mPBrUUlavg2vMZL74J+V8Rk729f0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LUQjiiuI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LUQjiiuI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F2281F00893;
	Mon,  1 Jun 2026 16:09:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780330158;
	bh=yrp1UWw+1W6UytVKc9OKuST2BhvFH7o4OQ1pyBIE2b4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LUQjiiuI04NsmnSwPeekyMbkvZfnAs9qs3SLQrwHn4dFz4C1uyGxiPCSNJiuMWWO4
	 wweaLnKU31118u84h4zh8I7pxo71zgp7CnxmZyAgul/Zwd0Jf4W5ts8Q9ZXZOEuHMO
	 2Q4xzhl6GEKb/iGi4zLC82bqjql+D9WVhtxntMtPuDSRlcAr+oHhLt3L/PPVMUpibb
	 7dDoeiq9ho5LwoglfMt32qZxS5V82/L6rB6oJbVgyCwCCG26bbmL0YbLxNCAGM9oWI
	 KQPS3FxY92DciIkrgCrLDVknh+M6LtDTAweSn+f7zLbSBSqXxPTmpM/Y8FaVJr0epf
	 bLsedhq64GSYA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/8] KVM: s390: Avoid potentially sleeping while
 atomic when zapping pages
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260601152951.196859-4-imbrenda@linux.ibm.com>
References: <20260601152951.196859-4-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 01 Jun 2026 16:09:18 +0000
Message-Id: <20260601160918.9F2281F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] ptep_zap_softleaf_entry unconditionally calls swap_put_entries_dir=
ect on non-present PTEs, which triggers warnings and fails when processing =
migration entries.
--

commit 98730d8ed19b62efe3e43850095ef240bb137294
Author: Claudio Imbrenda <imbrenda@linux.ibm.com>

KVM: s390: Avoid potentially sleeping while atomic when zapping pages

This commit factors out try_get_locked_pte(), which performs a spin_trylock=
()
instead of blocking and avoids allocating missing page tables. This new
function is used to prevent sleeping while atomic when zapping pages.

> diff --git a/arch/s390/mm/gmap_helpers.c b/arch/s390/mm/gmap_helpers.c
> index f8789ffcc05ca..396207163ca6c 100644
> --- a/arch/s390/mm/gmap_helpers.c
> +++ b/arch/s390/mm/gmap_helpers.c
> @@ -34,6 +34,70 @@ static void ptep_zap_softleaf_entry(struct mm_struct *=
mm, softleaf_t entry)
>  	swap_put_entries_direct(entry, 1);

[Severity: High]
This isn't a bug introduced by this patch, but does ptep_zap_softleaf_entry=
()
incorrectly pass non-swap softleaf entries to generic swap reclaim code?

The function acts as a dispatch for non-present PTEs, handling both swap and
migration entries, but unconditionally passes the entry to
swap_put_entries_direct().

Migration entries use swap types greater than MAX_SWAPFILES. When
swap_put_entries_direct() passes this to get_swap_device(), it will fail,
printing a 'Bad swap file entry' error to the kernel log and hitting a
WARN_ON_ONCE(!si).

Because this path is reachable by a guest issuing ESSA instructions on memo=
ry
regions undergoing host-side migration, could a malicious guest intentional=
ly
trigger this path to spam the host's dmesg logs on every migrated page,
creating a host-side denial of service?

>  }
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260601152951.1968=
59-1-imbrenda@linux.ibm.com?part=3D3
