Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795612251;
	b=06VAvnxvrY0sEBSeQzQUFL4CzhepjnCIuPEkhdWJhBd0g3E6voxcLOZjryZfq1VQhMlq
	 wmdCPaJDiMGzG+n93dNGJ3wj0J2Y/130W+JDwtPVvzprIMxzv4Xi/hfTO7F31MFtH5lJQ
	 pCHOrRfuMnzH8OOMo+kjP8+aYnFYXY9B5nUMi3Cw4DxIaNyRZfCgAsElpZvqH7aF68N4A
	 4VmpS4NEo/aFx8LFw80CuLCTNbuC12wN7EIiDqT+0JbXk0ALf/1o1yQl7WHPRU9rm0PgC
	 6P/VxjVME+LDxvMOHHKW46n1dCsm0liPo0iIyDhaxM/k6K38hdcKi/EEFS1DWIl8+6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795612251;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Pun56188Odwz3hfLVvarkflGwAWOvbKsC7R9kBgNN6I=;
	b=YTVJKkcYQqBHqKi1oN+AewCpAyfup6wBIVKmpFoXjNVYnwc7JsCybw81Pmguzb7pMRrl
	 UOrx01wDjcBw8HfQg4dtrzGN5ajND/lNOL1hLr7xLQJ4YXli4MFskrlIujygLdMyDoUvG
	 ZBNXtLAq4YwE2O/ZBB6OlkbPeKumc7jKx9Ev+XZ0eJaADxmLKa3ogNTb9/Q0o7IQUJ0uC
	 LpNWeHrfxy5M1aLLClNTVnKONgk7Nk2WLOAAkeVBxnS2h2FqZKGmFmgGmQtjekUwFtXFz
	 Lsgo1XqYib0C6mghEdu3UEtTaHxrPLJU0+PwmwS9LZFaba+MoBgXL/0DRwtHQhSSZCQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V03vSjrd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3448A606A321
	for <kvm@vger.kernel.org>; Wed, 25 Nov 2026 13:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V03vSjrd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16C651F000CA;
	Wed, 25 Nov 2026 13:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795612250;
	bh=Pun56188Odwz3hfLVvarkflGwAWOvbKsC7R9kBgNN6I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=V03vSjrdgbtVIlor69sb8LPaqKXyFKZnR1VbUaxoRFWcg0+l4WROAvmdUDdbnHwTg
	 6dPIVdgEFe2AWRSib0AfhjACzHW0zhn9BiI2Jjp9MaoXqY2U8qi9nGy7YgcTT+h68Y
	 cXz8ckJVNixOP1lroj/+RREyvwIPb0IkzJxfLoL+Pt0Gb9oiS7Zt5AcbOoxk36IYMi
	 l4oRA8cLBfSBGsaHiqmUDlUonv7W65HDltWOezpV8euYdV+vscJr1GOlRXEpqE16+c
	 XCSjPmmOqd5AW39dujOZ0qTM8VqSYUSFcwNKK5rFZ7AAQdxrIOjipHpjAIaqeW4n+Y
	 nsQuKBQFVHfKQ==
Message-ID: <sashiko-outbox-233465@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] RISC-V: KVM: Account G-stage page table memory
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tan Chi" <tanchi25@mails.ucas.ac.cn>
Cc: kvm@vger.kernel.org, tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com
In-Reply-To: <20261125125024.1983082-1-tanchi25@mails.ucas.ac.cn>
References: <20261125125024.1983082-1-tanchi25@mails.ucas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Nov 2026 13:10:49 +0000
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found no new issues
in this patch, but noticed 1 related pre-existing issue it does not
introduce:
- [Critical] KVM: riscv: missing write memory barrier in
  kvm_riscv_gstage_set_pte() [1]
--

commit 00af1817efd260bd8b07164e38fe69598a62a280
Author: Tan Chi <tanchi25@mails.ucas.ac.cn>

RISC-V: KVM: Account G-stage page table memory

This commit uses kvm_account_pgtable_pages() to account for the allocation
and freeing of RISC-V KVM G-stage root and lower-level page tables in
NR_SECONDARY_PAGETABLE.

Link: https://lore.kernel.org/r/20220426053904.3684293-6-yosryahmed@google.=
com

> diff --git a/arch/riscv/kvm/gstage.c b/arch/riscv/kvm/gstage.c
> index 0aace3215d3e8..f8841136d8526 100644
> --- a/arch/riscv/kvm/gstage.c
> +++ b/arch/riscv/kvm/gstage.c
> @@ -162,6 +162,7 @@ int kvm_riscv_gstage_set_pte(struct kvm_gstage *gstag=
e,
>  				return -ENOMEM;
>  			set_pte(ptep, pfn_pte(PFN_DOWN(__pa(next_ptep)),
>  					      __pgprot(_PAGE_TABLE)));
> +			kvm_account_pgtable_pages(next_ptep, 1);

[Severity: Critical]
This problem wasn't introduced by this patch, but shouldn't there be an
smp_wmb() before set_pte() links next_ptep into ptep [1], as in
kvm_riscv_gstage_split_huge()?

set_pte() is a plain WRITE_ONCE() on RISC-V.  Without a write memory
barrier after kvm_mmu_memory_cache_alloc() zeroes next_ptep, the store to
ptep can become visible to a concurrent hardware page table walker before
the zero-initialization of next_ptep completes, exposing uninitialized
entries as child PTEs.

[1] https://sashiko.dev/#/bug/linux-9339e577-5f31-42a2-a5ea-9844d30b43f8

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261125125024.1983=
082-1-tanchi25@mails.ucas.ac.cn?part=3D1
