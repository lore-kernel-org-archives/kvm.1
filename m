Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794098652;
	b=rcf7yT2dZ5rVqnlXBcKUhIvBdPEya0lxiVJgtE5sj6jlX/CSIiStLnF9+jVG5ylI5hrc
	 4eUg43RvKaF2ubcFZQDAKaj8Tribv1ckp9tK2zdqmocsJfIZNTIi/mSBlA278o4sYvvFv
	 0dBgiZGXOMGw9KnfhFLQF80Pdw8Ul6H8fqHw5uF+qKd4QtO3OGeGUoiDuUNGrPaFH+Krm
	 9J8wqPpkANzWapHT4XTxTVE6e+EqP8hFGJrjRZMN213y7VPezSt7ur+uGryBnB1IAdbSS
	 VOlsXtqQJikn5MR9b48vDVOY12hItrSYfzFq7MqNQ2IPL9kLrDmlm4dXrLd5qD3tMHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794098652;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=h5Cd/VC6aFMP32fHph0UV0rTVC4GF8CgjbTF6S9e6Lc=;
	b=NIc0QRVRl4FGhQqNxT6kYGRcp042DPzYzR9IIQ5cfrjZZVgJ0G5jveKM21Kz/TBoh4l5
	 dm3fMZa2cEJ4MImglFVrh3gJ5Y19WMn71zSLF/CtUSS164QR54kK/rV8RSOTjUNKOgyfs
	 L7tQWe8gpxKVz5d4KT7CQaFthTDR/NKUUp+XtmKu1pCmgpzp8SEX6XVcjJbqmcCBh3iAh
	 m2vk0umEctlpCibVwWWm+FbdApcXoGGaKGoMKi9nFJAY8IZ6LfAUT+yOlIZUMF5AuVZS/
	 fZVvG0mUYtFJ2kRhwfZ4jIePd/09DHk2C3GW54NTRbyN01p1hGRCsR8g/a3mOzUEb1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NwnEeaMF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA8FE606A326
	for <kvm@vger.kernel.org>; Sun,  8 Nov 2026 00:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NwnEeaMF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E244F1F008A2;
	Sun,  8 Nov 2026 00:44:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794098651;
	bh=h5Cd/VC6aFMP32fHph0UV0rTVC4GF8CgjbTF6S9e6Lc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NwnEeaMFpDr4HwL0jycs22k5go6EI2HbNKolbEPMKVV/MBMx1SZSnj3QssWkYGf5R
	 Dap/Ofy6yw7+SYqovorn4ZfK/9TZ8Y/N4QsV2lnKLZCx14vRbF/bnBVDQrnaTRJm4C
	 e3z4NpNHyY3gN669yrw6WTN7YThxXClelkxmre26uazpUXCOf5YXHd8nJV7c+JtVxO
	 SC8QCK9J+b0MRxWztmJJXlEW6m2t2vdHSLd5xDmadP0lVP/p1vNgqGt4BCzTvMjKs4
	 wCEyw6hW2w7OTOGohLpSAvYjrfsx65kxNuJ95NkPpH1kyN5IASsfxJAKHGITkJYlkK
	 vWCtV5OnHCKqg==
Message-ID: <sashiko-outbox-203459@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v3 48/88] samples/kvm: Support dynamic revocation
 via kvm_gmem_revoke
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ackerley Tng" <ackerleytng@google.com>, "Alexey Kardashevskiy" <aik@amd.com>, "Aneesh
 Kumar K.V" <aneesh.kumar@kernel.org>, "Christian Brauner" <brauner@kernel.org>, "David
 Hildenbrand" <david@kernel.org>, "David Woodhouse" <dwmw2@infradead.org>, "Fred
 Griffoul" <fgriffo@amazon.co.uk>, "Jacob Pan" <jacob.pan@linux.microsoft.com>, "Jianxiong
 Gao" <jxgao@google.com>, "John Starks" <John.Starks@microsoft.com>, "Michael
 Roth" <michael.roth@amd.com>, "Paolo Bonzini" <pbonzini@redhat.com>, "Samiullah
 Khawaja" <skhawaja@google.com>, "Sean Christopherson" <seanjc@google.com>, "Suzuki
 K Poulose" <suzuki.poulose@arm.com>, "Tarun Sahu" <tarunsahu@google.com>, "Vishal
 Annapurve" <vannapurve@google.com>, "Xu Yilun" <yilun.xu@linux.intel.com>, "Fuad
 Tabba" <fuad.tabba@linux.dev>
Cc: kvm@vger.kernel.org, linux-mm@kvack.org
In-Reply-To: <20261106-gmem-alternative-providers-v3-48-8484dde66a7e@google.com>
References: <20261106-gmem-alternative-providers-v3-0-8484dde66a7e@google.com>
 <20261106-gmem-alternative-providers-v3-48-8484dde66a7e@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 08 Nov 2026 00:44:10 +0000
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] samples/kvm: stale identifier names and patch references in
  commit message
--

commit 42b1d24c6caccfeaf35dd92048463c002a041484
Author: Ackerley Tng <ackerleytng@google.com>

> samples/kvm: Support dynamic revocation via kvm_gmem_revoke
>
> Support dynamic revocation in the sample memory provider module by
> calling kvm_gmem_revoke() when pages are marked absent via
> MPS_SET_PRESENT.
>
> Note down the attaching gmem inode during .attach() and disallow double
> attachment to the same provider file.
>
> Clear the revoked pages after kvm_gmem_revoke() using mps_zero_range()
> to ensure that stale data is wiped and cannot be observed when pages are
> later marked present or reused.
>
> Regarding locking and ordering:
> - In mps_set_present(), mark the absent bitmap first before revoking so
>   any concurrent page fault immediately sees the page as absent and
>   rejects the lookup with -EFAULT.
> - kvm_gmem_revoke() is called under info->lock to fully serialize
>   MPS_SET_PRESENT operations against each other and prevent races
>   between marking pages absent and present.
> - The PFN passed to kvm_gmem_revoke() is derived from info->base_pfn +
>   start. The mapping between page index and physical PFN is static and
>   immutable for the lifetime of the provider file, ensuring that the
>   pfn mapping remains completely stable across the revoke call.
> - Passing pfn directly to kvm_gmem_revoke() allows guest_memfd to
>   reclaim the physical range directly without calling back into the
>   provider. This keeps the lock hierarchy strictly top-down (info->lock
>   -> filemap_invalidate_lock -> mmu_lock) with no callbacks or deadlocks.
>
> For now, nothing needs to be done when setting a page present, since users
> should (re-)fault and (re-)obtain the PFN via .get_pfn(), to be added in a
> later patch.
>
> For users that don't support faulting, like the IOMMU, the counterpart to
> kvm_gmem_revoke() will be made available for the first user to indicate
> that the memory is now available. guest_memfd should then do the page tab=
le
> mappings as necessary, based on the shared/private status.
>
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>

[Severity: Low]
This isn't a bug, but the commit message has a few stale references from an
earlier version of the series:

- MPS_SET_PRESENT, mps_zero_range(), and mps_set_present() were renamed to
  MP_SET_PRESENT, mp_zero_range(), and mp_set_present().
- Recording info->gmem_inode in .attach() and disallowing double attachment
  was already done in commit "samples/kvm: Implement attach and release
  provider ops in sample provider", not in this patch.
- .get_pfn() was already added earlier in the series in commit "samples/kvm:
  Implement get_pfn provider operation", rather than in a later patch.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106-gmem-alter=
native-providers-v3-0-8484dde66a7e@google.com?part=3D48
