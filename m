Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 285493290A6
	for <kvm@vger.kernel.org>; Wed, 24 Jun 2026 08:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782290144; cv=none; b=jABbW/uOGuLUcgMePBLc4k2xOFskJ3nOVIM9WwNFCanojoqU63L2ImewU85po4asyVuZomn15mp4CWF5zxl4vmUg3JK5VtXeZocy56v98MlJTdz8f2hnrzqEQH2kI0pqyW0VApCo5OXfmxoKXxj2LAcaGSTGuwqjaU3Lwzyctl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782290144; c=relaxed/simple;
	bh=Lli4xSOlh5Mjq9FG3ctSEXMui088XF3UL+AtbEC5lsM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fBVEe/DRL/cTK4fBs08bHWmz2EAfTTO5UXykGaXUOkclW9H1wNv8KrhxB0rlAM/PgoD1cDOqow5OffEuYDAHOHeuhos9Ps8OGtdl/PnxL16SDZAq8x3X9gluffVNoOFrPJVT0A/qItJPompeQlGTpXhjlZuIytdg5SiFx2J+Ywg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Webex5KZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Webex5KZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBAFA1F00A3A;
	Wed, 24 Jun 2026 08:35:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782290143;
	bh=lo6Scma9UETMLETIZkdqUQ+/xRbMnBX9ZA0KPmRYXG8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Webex5KZEpeXDdPJ1KgRAuRN1urEu0/gokC7pj4bH2E5HCci7joUfSq777x+tAiCi
	 41VFjPptsEIJNnM1AKs1bHHbBqcZPJJR67+CtTeF+cuOawYc4ZlJ8CEXLvYZJwh3gY
	 pqJiQkyWH8r/GiITz0GRoueDxCAxm00cN810/R6aSqDZRVrnAXVrDDFUyuZLPtqnfF
	 IG1k2ILxwNrr1gZgKdNIcIL7UBZV2OWucIhBwwTzx2lyNiPcvodXOzgkv/MInAY9I7
	 9glurUHWtQOLVu3EE72hXp9jqvcGUv/ErSAVBIbywdUKmKDYcOT46KpruZhMcuiprz
	 FCTpmydF2pTmw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 RESEND 4/5] RISC-V: KVM: Split huge pages during
 KVM_CLEAR_DIRTY_LOG
Reply-To: sashiko-reviews@lists.linux.dev
To: wang.yechao255@zte.com.cn
Cc: kvm@vger.kernel.org
In-Reply-To: <20260624161128723A8RgX9GQcthwS3so76Ou2@zte.com.cn>
References: <20260624160054463wcDvJaMoydSggcNOWgcfB@zte.com.cn>
 <20260624161128723A8RgX9GQcthwS3so76Ou2@zte.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 24 Jun 2026 08:35:42 +0000
Message-Id: <20260624083542.DBAFA1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] Eager huge page splitting during KVM_CLEAR_DIRTY_LOG silently fail=
s for most ranges due to incorrect address alignment in mmu_split_huge_page=
s().

Pre-existing issues:
- [High] Write-protecting guest page table entries (SPTEs) clobbers concurr=
ent hardware Access/Dirty bit updates.
--

commit 00cb697f813eca012a08732046a12ddb66d6af56
Author: Wang Yechao <wang.yechao255@zte.com.cn>

RISC-V: KVM: Split huge pages during KVM_CLEAR_DIRTY_LOG

This commit splits huge pages on the range specified by KVM_CLEAR_DIRTY_LOG.
It also avoids splitting when enabling dirty logging if
KVM_DIRTY_LOG_INITIALLY_SET is set.

> diff --git a/arch/riscv/kvm/mmu.c b/arch/riscv/kvm/mmu.c
> index bc3bad67d507b..cbda927dd24e3 100644
> --- a/arch/riscv/kvm/mmu.c
> +++ b/arch/riscv/kvm/mmu.c
> @@ -164,6 +164,9 @@ void kvm_arch_mmu_enable_log_dirty_pt_masked(struct k=
vm *kvm,
>  	kvm_riscv_gstage_init(&gstage, kvm);
> =20
>  	kvm_riscv_gstage_wp_range(&gstage, start, end);

[Severity: High]
This is a pre-existing issue, but does calling kvm_riscv_gstage_wp_range()
clobber concurrent hardware Access/Dirty bit updates?

Looking at arch/riscv/kvm/gstage.c, kvm_riscv_gstage_op_pte() uses a
non-atomic read-modify-write when write-protecting:

kvm_riscv_gstage_op_pte() {
    ...
    else if (op =3D=3D GSTAGE_OP_WP)
        set_pte(ptep, __pte(pte_val(ptep_get(ptep)) & ~_PAGE_WRITE));
    ...
}

If the hardware page-table walker sets the Accessed or Dirty bit between the
read and the write, it seems the bit is permanently lost.

> +
> +	if (kvm_dirty_log_manual_protect_and_init_set(kvm))
> +		mmu_split_huge_pages(&gstage, start, end);

[Severity: High]
Does mmu_split_huge_pages() fail to split overlapping huge pages for small
or unaligned ranges?

Looking at mmu_split_huge_pages() in arch/riscv/kvm/mmu.c, it initializes
the address using ALIGN():

    phys_addr_t addr =3D ALIGN(start, PMD_SIZE);

If KVM_CLEAR_DIRTY_LOG passes an unaligned start address (e.g., clearing a
small mask), ALIGN() rounds the start address up. This could cause addr to
be greater than or equal to end, resulting in the while (addr < end) loop
terminating immediately and skipping the huge page that overlaps the
beginning of the target range. Should this use ALIGN_DOWN() instead?

>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260624160054463wc=
DvJaMoydSggcNOWgcfB@zte.com.cn?part=3D4
