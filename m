Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78810282F3A
	for <kvm@vger.kernel.org>; Tue, 30 Jun 2026 22:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782859174; cv=none; b=F82EeDAxvZHUVNa9LmYdJGV+Ja9Dnq8cD4rnMDvus52RQ0QCd5o/pTO4Y/s6QdasJAQ1VWmHp2SulKoGj/PqpEBwRQxhyW3CYpH+qkri9hNO3hz1PrhPkabEZEIwbL1AsoaFDcWnubzMbyOje2sS9IxO0j9vkQpIhOEnLqk1J9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782859174; c=relaxed/simple;
	bh=+McgvhPG+c9IVESFJCqVZEsJ/CV2UW7SmTM51k30t+o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pbKGPMjoVU/SenDxg6ofYmmqzjC8fIOacvcWKsFCeDLb9KjlQaYwAzLGIrdedMlNUqu3Lal/xq1fVyJPspTqmgsH7f51mmyJdSOGUu12PvCUl0kgeFhF58wVWkQi6Rsu8wNj0WJt5MfRwZsSsUcl41TZZGpvY0JJ7mUUYiKbXKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iDOugm17; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iDOugm17"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E5191F000E9;
	Tue, 30 Jun 2026 22:39:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782859173;
	bh=EVIbvlmD+r7xfix3jecGm/fFQaPgFXI5BBnMhbaAi34=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iDOugm17H1SCEqfMGwTvoRDK1wbU7LXxUNF3uulP9iQbJ/7/KpUrFUsHkJbfTB5kw
	 BZeRrvJQs3S3LE2rdo6bpcPq4jfOu/r32i4RUqzbgckuI0Fyqwd7q6JIqx16xKlMQK
	 BWlsa1orLDoljqXnMrM4Up4Wl9s6926M8/hE0QCpElt+qD4nsck55ij590HUyIdSAA
	 Oo0Bu/IaIuiryM7OH4ebJLbGbZpsPlFbbyVcV88Ag0nR2Wyd7TItr5jrjbPVQcSb4x
	 dFnYbq6CF+D42HoqFlw5tFfqjvkgSyZ5Oe8b+hV6njQDjxEJTqYk/EBHN1bkXqvwXh
	 mQv2URNm8kNWQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 04/12] KVM: Rename .gmem_invalidate() to
 .gmem_reclaim_memory()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sean Christopherson" <seanjc@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260630222607.497895-5-seanjc@google.com>
References: <20260630222607.497895-1-seanjc@google.com>
 <20260630222607.497895-5-seanjc@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Jun 2026 22:39:32 +0000
Message-Id: <20260630223933.1E5191F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Failure to leak a page after an RMP transition error in sev_gm=
em_reclaim_memory allows hypervisor-owned pages to be unsafely returned to =
the host page allocator.
--

commit c2f5753d0289e9cb80f17e6494a0d03b0f6a529a
Author: Sean Christopherson <seanjc@google.com>

KVM: Rename .gmem_invalidate() to .gmem_reclaim_memory()

Rename the .gmem_invalidate() hook to .gmem_reclaim_memory() since it is
called when a folio is freed, which is too late to invalidate memory usage.
Keep guest_memfd's trampoline and opportunistically guard the callback with
an ifdef.

> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> index 30792adcfc8e5..4465e75494f2d 100644
> --- a/arch/x86/kvm/svm/sev.c
> +++ b/arch/x86/kvm/svm/sev.c
> @@ -5136,7 +5136,7 @@ int sev_gmem_prepare(struct kvm *kvm, kvm_pfn_t pfn=
, gfn_t gfn, int max_order)
>  	return 0;
>  }
> =20
> -void sev_gmem_invalidate(kvm_pfn_t start, kvm_pfn_t end)
> +void sev_gmem_reclaim_memory(kvm_pfn_t start, kvm_pfn_t end)
>  {

[Severity: Critical]
This is a pre-existing issue, but does failing to leak the page on RMP upda=
te
errors allow it to be unsafely returned to the host allocator?

In sev_gmem_reclaim_memory(), if rmp_make_shared() fails, the code logs a
warning and proceeds to the next PFN:

    rc =3D rmp_make_shared(pfn, use_2m_update ? PG_LEVEL_2M : PG_LEVEL_4K);
    if (WARN_ONCE(rc, "SEV: Failed to update RMP entry ..."))
        goto next_pfn;

By jumping to next_pfn instead of calling snp_leak_pages(), the
hypervisor-owned page could be freed back to the host allocator.

Could this trigger a hardware RMP violation and a host panic upon the page's
next use? A later patch in the series fixes a guest-triggerable vector for
this failure, but the structural issue remains.

>  	kvm_pfn_t pfn;
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260630222607.4978=
95-1-seanjc@google.com?part=3D4
