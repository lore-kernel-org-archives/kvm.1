Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DF2B3A544C
	for <kvm@vger.kernel.org>; Thu,  9 Jul 2026 21:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783631536; cv=none; b=oCx8u29+yepUpLGnh/uSXsS0PJfdgISGJaEVCVlT9ULWZGI1a8G5j4QkVvENNxC/m5QoPJw84UZvttwCxx8TBcQ0kp9cEp1NI02tsL8sT8cHIJY3cMC/5NGG6n3MPBhtjAoAc8t0yKPiyFqgY6I+XwiJXw70HiuQJ4CwpIHuje4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783631536; c=relaxed/simple;
	bh=sgjyELo8SMgNoFZ13Ur3QFk9n6kq2iX8narmvLn9mA0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XKZUxUWW2p1SbTMFm0IL5Org8As5ZiRmR1q6ohm/wMgKQoqBJ6Ewh5+w66VIMKMlMUbbCr24CWGn6UyIyA5Vw0exta9qB5UE/HsJD9Ei6posgZv4yf0HEPbEgUnPoS5GMdHgFCET8w0pAOy29J+SbdcbUAToxn4jhkOZgS838XA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M36GMU6t; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M36GMU6t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95E8A1F000E9;
	Thu,  9 Jul 2026 21:12:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783631535;
	bh=B4pT20Tx2rNu1pORT7QY+aAStB0vFxzS5sldhYPV2h4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=M36GMU6t9c5ZS4n1rggB2O1YozZKbpqw/D9J7CvzEkyAvGD7xZDOGQ3e9+6LKmXpA
	 3pYp931Pf+e7+b51u+UXtexqckENSZDsE91y3dYwRGvRGhqSUIY4mnaDkxz9wZV68X
	 QgaCf0nZhizpnLaUas1CbzuswM4ARUiJj/l8eSOHDAMaSx8lddqt/FQKxOsXkb9xpH
	 d6dBmJzkwZpyrP1HY6zZI2UUttp8dkv2DYENg0k9qXE/s2f8gNpIkM+kfOED5U3m0O
	 MiH8722BRyCIfxKk4u+4cNcPL5G2vkbhSpE07r+A9TFEhGL4r94n1lXOq/1006PZD0
	 izqPekDXexkCQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 16/18] KVM: guest_memfd: Explicitly pass number of
 pages to kvm_arch_gmem_prepare()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sean Christopherson" <seanjc@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260709204948.1988414-17-seanjc@google.com>
References: <20260709204948.1988414-1-seanjc@google.com>
 <20260709204948.1988414-17-seanjc@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 21:12:13 +0000
Message-Id: <20260709211214.95E8A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Data race between guest memory population and fault-driven zer=
oing leads to host kernel panic via RMP violation.
--

--- Patch [16]: [PATCH v4 16/18] KVM: guest_memfd: Explicitly pass number o=
f pages to kvm_arch_gmem_prepare() ---
commit b12c982da03eae2bbf9f63075885746a3653b16b
Author: Sean Christopherson <seanjc@google.com>

KVM: guest_memfd: Explicitly pass number of pages to kvm_arch_gmem_prepare()

This commit modifies the guest_memfd prepare() hook to explicitly pass the
number of pages, allowing prepare() and invalidate() hooks to be combined
into a single convert() hook. It also adds a WARN_ON_ONCE to the SNP code if
more than a single 4KiB page is prepared.

> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> index d5d3688eb1bdf..cd7a795834cb6 100644
> --- a/virt/kvm/guest_memfd.c
> +++ b/virt/kvm/guest_memfd.c

[ ... ]

[Severity: Critical]
This is a pre-existing issue, but could a data race between guest memory
population and fault-driven zeroing lead to a host kernel panic?

Looking at __kvm_gmem_populate() in virt/kvm/guest_memfd.c:

	folio_unlock(folio);

	if (!kvm_range_has_memory_attributes(kvm, gfn, gfn + 1,
					     KVM_MEMORY_ATTRIBUTE_PRIVATE,
					     KVM_MEMORY_ATTRIBUTE_PRIVATE)) {
		ret =3D -EINVAL;
		goto out_put_folio;
	}

	ret =3D post_populate(kvm, gfn, pfn, src_page, opaque);
	if (!ret)
		folio_mark_uptodate(folio);

The folio is unlocked before the memory is populated or marked up-to-date.
If an unprivileged host userspace process concurrently triggers a page fault
on the same private GFN, could kvm_gmem_get_pfn() fetch this unlocked folio?

kvm_gmem_get_pfn() would observe the !uptodate folio and zero it via the
host direct map:

	if (!folio_test_uptodate(folio)) {
		clear_highpage(folio_page(folio, 0));
		folio_mark_uptodate(folio);
	}

If this host zeroing overlaps with or occurs after rmp_make_private() in the
population callback, wouldn't this host write cause an RMP violation and
crash the host kernel?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709204948.1988=
414-1-seanjc@google.com?part=3D16
