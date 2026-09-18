Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD1C637E2E9
	for <kvm@vger.kernel.org>; Fri, 18 Sep 2026 08:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789720608; cv=none; b=DTAkNqZiuc/Lq1OAztTeLh1cWm7VbLxJ9Vl3ZQqJCt+3yM8asI/frAtgKVancDCunmqxpcmIu/54/0kjo4aPrkVieSPQFo/iigYTwyxFgDDMD4SGs26Sh4zzGZNLwMrunw9TCTEXH27ceGAZkPzzHMZDX44Y69Dw6uBBfqbwTxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789720608; c=relaxed/simple;
	bh=wNmkN1GpxEy4YgPDFK/Y4GOLMGvCXLNvFdmlETsX+QA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nUtTWKHsRz1UTMT+jmo30BdI6PqNDFLbjvHE7Z4f1l/5thIX8juqOJs2772E/esSr8Fn2tlp8tONxXkqNr8HWkYns9n4C83nTvoVFEm1OuwmVXfqQwnzhcncnwh4GBvP3nvqq4PIcvhNKtECRZ467/VvVkLzjFpae6MlPcbT10o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XLKTvOsv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XLKTvOsv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 337E41F000FF;
	Fri, 18 Sep 2026 08:36:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789720607;
	bh=KvpFJKGpGeGR4bps8b3S5quSnsp9Ov9gACuSt/+F4T0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XLKTvOsvlzQZ2l1bMnokfjaImo/wFQMd5uur2yR4UDbfU7q9s/Q8hNoRN7i7XD0v2
	 MUJ1I2vFNI872Aw8aEjTNthB+ekX9h0vdk1yHFgQ5a70JtcyTSqpfpKwVuyuyVfpBS
	 yXsy1/47H+Iff9uGAHI2R/a0HU3aQJVicj1oFzBNiXPCi7UgHRWXGcZKudrh+plr0E
	 rB1RztzqRixdh8irXxJYaP/ctq8RzcBvXIqIWQoVO9aciaMZsouspM7PxzrPT6rLqf
	 xMzbiv5PCdBxJSY9TRYDWjyFZORqNbbJ300Ak1ouzZfw1VKdkjCpdu0+MuAjx5X3ei
	 A0uycbFf3qs8Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 24/28] KVM: x86/mmu: Do not prefetch sptes on gfns
 backed by memory attributes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Paolo Bonzini" <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260918081543.139871-25-pbonzini@redhat.com>
References: <20260918081543.139871-1-pbonzini@redhat.com>
 <20260918081543.139871-25-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 08:36:46 +0000
Message-Id: <20260918083647.337E41F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] kvm: x86/mmu: inverted condition in kvm_mmu_prefetch_sptes() bypas=
ses memory protections
--

commit 68c32d2a3026b65b5bee3d2be8dae5b6311d03d5
Author: Nicolas Saenz Julienne <nsaenz@amazon.com>

KVM: x86/mmu: Do not prefetch sptes on gfns backed by memory attributes

This commit aims to prevent prefetching GFNs that have memory protections
applied, because prefetched SPTEs are always given full access. It
introduces a check using kvm_get_memory_attributes() to skip prefetching
for such pages.

> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index 3fd4cc3c57a53..097095f71d605 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -3187,6 +3187,11 @@ static bool kvm_mmu_prefetch_sptes(struct kvm_vcpu=
 *vcpu, gfn_t gfn, u64 *sptep,
>  		return false;
> =20
>  	for (i =3D 0; i < nr_pages; i++, gfn++, sptep++) {
> +		if (!kvm_get_memory_attributes(vcpu->kvm, gfn)) {
> +			kvm_release_page_clean(pages[i]);
> +			continue;
> +		}

[Severity: High]
Does this logic invert the intended check?

When a page has no memory attributes, kvm_get_memory_attributes() returns 0,
making the ! condition evaluate to true. This causes normal memory pages to
be skipped, which could lead to performance regressions.

Conversely, if a page does have memory attributes, it returns non-zero, mak=
ing
the condition false. Could an untrusted guest VM deterministically trigger
page prefetching by faulting on adjacent pages, allowing protected memory
to fall through to mmu_set_spte() and be mapped with full access?

> +
>  		mmu_set_spte(vcpu, slot, sptep, access, gfn,
>  			     page_to_pfn(pages[i]), NULL);
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918081543.1398=
71-1-pbonzini@redhat.com?part=3D24
