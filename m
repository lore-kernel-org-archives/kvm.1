Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5098F474267
	for <kvm@vger.kernel.org>; Fri, 16 Oct 2026 10:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792146379; cv=none; b=Wlv21+Rc0G3J++lXBZLxov6hzbFKpGXgBHR8TRWGwURei/Q8vmQARde5tkU7MP37ZobwmCNzetrML8JmpXnDldc6zFE+HR5WXgIkHaamP7KYaeoHZV8M/QAD+1tSGlxinIC9zPSeksVcYd6AapwVZQTzckJC07BdejeQJA9WNmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792146379; c=relaxed/simple;
	bh=YGvigXi5HbXbvZekCG/AjNtMT1K/BjyEG/Wx8neJHCw=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=D/HcDmvO3wcp+ai+DK7Fttqh8fKHhzSHBPSCmWTGNBV9SHZOAUpDunCMKhKYPbqmrJGP8lESJxmj9MvEXXXPYNI8CbC/T9hJ2w11cYXQwVphsl3nYmZTUcTOS/IKTheK+ZnRSLXw11URBjE7otlpVO5V2SpO+VeQ79euSNnu1e0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O+mAFyKg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O+mAFyKg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 052471F000C6;
	Fri, 16 Oct 2026 10:26:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792146378;
	bh=zx1Cx5FhllTQe1lMPpLzfTNgzJuvEHDEyLb0JH0v2Xo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=O+mAFyKgAzlAxxUlXuS3MZ+m8lmjvx+ApynopkBxpFo+OxRNbquwWXuy4ocbEXAPb
	 CSd6MIJkhgh4QQCDjvTgdFsrixsrBe2xOj7gxCUHWUqprb/u8MWmX8NRkCBQssTzqm
	 4n2Z+JQX8Vtf1w8CaXJHPTHqVfjMIZJRj2x7qZc2tNnQXe6jHtxPqyBOcipvIFehK2
	 XdDCPkXeh0ZXIIrP5f3ABOkMCaV06Spk/kYsKyR2+Rax4SAYpcUT8jhcWu9LJ78ko4
	 H+8Fub04Oq1RZQ3LvGlorTTCG24I0FOT8TbJoUemd03wV7K3Dtss4lSmc8wn5uBNyp
	 N2ejpyuU+gfCQ==
Message-ID: <sashiko-outbox-174168@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] KVM: riscv: Set Accessed bit in dirty-log write fault
 fast path
Reply-To: sashiko-reviews@lists.linux.dev
To: "SeungJu Cheon" <suunj1331@gmail.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20261016101458.221648-1-suunj1331@gmail.com>
References: <20261016101458.221648-1-suunj1331@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 10:26:17 +0000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] kvm: riscv: host memory corruption via dirty logging fast path
--

commit b1648eda48b2a005ceca6ca39f80fd20aed60966
Author: SeungJu Cheon <suunj1331@gmail.com>
KVM: riscv: Set Accessed bit in dirty-log write fault fast path

This patch fixes an issue where the fast path for dirty logging write
faults loops indefinitely on hardware that faults when the Accessed bit
is clear. It ensures the accessed bit is set alongside write and dirty
bits.

Cc: stable@vger.kernel.org # 7.2+

> diff --git a/arch/riscv/kvm/mmu.c b/arch/riscv/kvm/mmu.c
> index 371fccaf9df08..21637b7959730 100644
> --- a/arch/riscv/kvm/mmu.c
> +++ b/arch/riscv/kvm/mmu.c
[ ... ]
> @@ -591,14 +591,15 @@ static bool kvm_riscv_mmu_dirty_log_write_fault_fas=
t(struct kvm *kvm,
[ ... ]
> -		new_pte =3D pte_mkdirty(pte_mkwrite_novma(old_pte));
> +		new_pte =3D pte_mkyoung(pte_mkdirty(pte_mkwrite_novma(old_pte)));

[Severity: Critical]
Does this unconditionally set the _PAGE_WRITE bit on the stage-2 PTE
without verifying if the original mapping was host-writable?

When dirty logging is enabled, a guest write to a previously read-only
mapped page can trigger kvm_riscv_mmu_map() with logging enabled:

kvm_riscv_mmu_map()
    if (is_write && logging &&
        kvm_riscv_mmu_dirty_log_write_fault_fast(kvm, memslot, gpa, out_map=
))
        return 0;

If we unconditionally add _PAGE_WRITE here via pte_mkwrite_novma(),
could an unprivileged guest bypass host write-protection by reading an
unallocated page (like the shared zero page) and then writing to it
during live migration?

This appears to bypass the host writability checks in the slow path's
__kvm_faultin_pfn(), which might allow a guest to write directly into
host read-only pages, such as CoW mappings or the shared zero page.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016101458.2216=
48-1-suunj1331@gmail.com?part=3D1
