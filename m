Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B7B3F2118
	for <kvm@vger.kernel.org>; Wed,  1 Jul 2026 09:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782896813; cv=none; b=czIAD8DGqsdHE5pYnA+UGQBxwFDJ4mHlvPrIZONewCsC+uXqYzu1Ut5SVDoGJrNwIfxTZq0Gkrjb/fAZwBHN1tfVjXgabUeX+3dEJ9mczUNA/Cz06GxzjpDVY3Gv1vWCJ/64vdb7TrH/h4L17dSXHoK9l20Ky40NxTKYUwrZLIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782896813; c=relaxed/simple;
	bh=APt3qDISUO5fwexgZfwo+Q+3o/uIbSmiRZfFeUjBrAE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JF7CVomufzoUFBFECascMvhlaMhyBwd4JFLEbBl1fI93IvK3+lmyn4kl8cMmZmSQFIaGaZlnuAVYY3X2cio/HGjo2PUQW94NAVziZapM8gYBqdO89RY9kLYs+AMSCmriIVXNBVSHGAGbPFlBLPDAryDh2CAt6SIsmbDxGFVgg1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lnCfIZFH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lnCfIZFH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F9581F00A3A;
	Wed,  1 Jul 2026 09:06:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782896810;
	bh=6uBQ0A17Lk+l7IOXnXHlTtwvsc7+h7PiOygi1exzUkA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lnCfIZFHh2N5QKCnHbrGiUPXEvl8TL/zaULkK5eO+SeuR7pz+2opPw9aw6clxPb7j
	 /o3B84UxqYQPXRIcdcsGlCX9x9Py/OPlvVr86T8YRS6c/fqaBVU6WtcdFj4JXHX01G
	 xi4Gevh+uGo8t0rzKc6Loqi3gzpDTAxVNzHkApb4o/zhG6gplKno0Mmm2D5jPbffnG
	 lWpry1JXLCibzN72u6EKi1QE9YV0X82WuKU0xn9eXiMnsb7R1ihkUs1pZHgPXNchLt
	 djVN6nYSMWymGYzI11e1jfPAYPNc1+4p3yBb65+Yp4JNdjKpXoRElevs4+t/RSfRK5
	 JEDghfPsTO0Nw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] KVM: riscv: Register ptdump with debugfs on guest
 creation
Reply-To: sashiko-reviews@lists.linux.dev
To: Dylan.Wu <fredwudi0305@gmail.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260701085030.124579-3-fredwudi0305@gmail.com>
References: <20260701085030.124579-1-fredwudi0305@gmail.com>
 <20260701085030.124579-3-fredwudi0305@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 09:06:50 +0000
Message-Id: <20260701090650.6F9581F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] Lockless reads of the guest PGD pointer (`kvm->arch.pgd`) outside =
`kvm->mmu_lock` lead to a Use-After-Free (UAF) and potential kernel stack o=
verflow via undefined behavior.
- [High] Unbounded full page table walk under `mmu_lock` combined with `sin=
gle_open` buffer restarts causes severe lock contention.
- [Medium] Concurrent reads of the debugfs file cause a data race by modify=
ing the global static array `gstage_pg_levels` without synchronization.
- [Medium] The page table walk hardcodes the loop bound to `PTRS_PER_PTE`, =
silently truncating the guest address space dump for concatenated root tabl=
es.
--

commit efa8af5af3c60372dfe6205bc307cb96b4b1cf7a
Author: Dylan.Wu <fredwudi0305@gmail.com>
Subject: KVM: riscv: Register ptdump with debugfs on guest creation

Introduce KVM ptdump to show the guest gstage pagetables. This registers
a 'gstage_page_tables' file under the guest debugfs directory.
Userspace can now inspect the gstage layout and permissions, which
is useful for architectural debugging and memory management audits.

> diff --git a/arch/riscv/kvm/ptdump.c b/arch/riscv/kvm/ptdump.c
> new file mode 100644
> index 0000000000000..972d45d691b2b
> --- /dev/null
> +++ b/arch/riscv/kvm/ptdump.c

[ ... ]

> +static void kvm_ptdump_walk_level(struct ptdump_state *pt_st,
> +				  unsigned long *tbl, int level,
> +				  unsigned long start_addr)
> +{
> +	unsigned long addr =3D start_addr;
> +	unsigned long next, virt_addr;
> +	int i;
> +	unsigned long step =3D 1UL << (PAGE_SHIFT + (4 - level) * 9);

[Severity: High]
Can step calculation result in a negative bitwise shift? If level > 4 (which
could occur if pgd_levels is read as 0 due to concurrent VM destruction), t=
his
triggers undefined behavior.

> +
> +	for (i =3D 0; i < PTRS_PER_PTE; i++, addr +=3D step) {

[Severity: Medium]
Does this hardcoded loop bound truncate the guest address space dump? RISC-=
V=20
KVM uses concatenated page tables for the top-level gstage directory (up to=
=20
2048 entries for a 16KB root table), but this caps iteration at PTRS_PER_PT=
E.

> +		unsigned long val =3D tbl[i];

[ ... ]

> +static int kvm_ptdump_visitor(struct seq_file *m, void *v)
> +{
> +	struct kvm_ptdump_state *st =3D m->private;
> +	struct kvm *kvm =3D st->kvm;
> +	unsigned long *pgd =3D (unsigned long *)kvm->arch.pgd;
> +	int start_level =3D 5 - kvm->arch.pgd_levels;

[Severity: High]
Are these lockless reads of pgd and pgd_levels safe? If the VM is torn down=
=20
concurrently, kvm_riscv_mmu_free_pgd() could clear these fields and free th=
e=20
pages. This read happens outside of mmu_lock, which might result in a dangl=
ing
pointer being passed to the page table walker.

> +	int i, j;
> +
> +	st->parser_state.level =3D -1;
> +	st->parser_state.start_address =3D 0;
> +	st->parser_state.seq =3D m;
> +
> +	for (i =3D 0; i < ARRAY_SIZE(gstage_pg_levels); i++) {
> +		gstage_pg_levels[i].bits =3D gstage_pte_bits;

[Severity: Medium]
Does this loop modify the global static array gstage_pg_levels without any=
=20
synchronization? If multiple threads read the debugfs file concurrently, th=
is
data race could cause corrupted or incomplete page table dumps.

> +		gstage_pg_levels[i].num =3D ARRAY_SIZE(gstage_pte_bits);
> +		gstage_pg_levels[i].mask =3D 0;
> +		for (j =3D 0; j < ARRAY_SIZE(gstage_pte_bits); j++)
> +			gstage_pg_levels[i].mask |=3D gstage_pte_bits[j].mask;
> +	}
> +
> +	read_lock(&kvm->mmu_lock);
> +	if (pgd) {
> +		kvm_ptdump_walk_level(&st->parser_state.ptdump, pgd,
> +			start_level, 0);
> +	}
> +	read_unlock(&kvm->mmu_lock);

[Severity: High]
Could walking the entire page table under mmu_lock cause severe lock conten=
tion
or a soft lockup for the guest VM, especially when combined with the buffer=
=20
restarts from single_open() below?

> +
> +	note_page(&st->parser_state.ptdump, 0, -1, 0);
> +	return 0;
> +}
> +
> +static int kvm_ptdump_open(struct inode *inode, struct file *file)
> +{
> +	struct kvm *kvm =3D inode->i_private;
> +	struct kvm_ptdump_state *st;
> +	int ret;

[ ... ]

> +	st->parser_state.marker =3D st->marker;
> +	st->parser_state.pg_level =3D gstage_pg_levels;
> +	st->parser_state.ptdump.range =3D st->range;
> +
> +	ret =3D single_open(file, kvm_ptdump_visitor, st);

[Severity: High]
Does using single_open() here risk excessive retries? Since single_open()=20
collects output into a contiguous buffer, if the output exceeds the initial=
=20
buffer size, it discards it, doubles the allocation, and restarts the visit=
or.=20
Each restart would repeat the entire recursive page table walk under the=20
mmu_lock.

> +	if (ret) {
> +		kfree(st);
> +		kvm_put_kvm(kvm);
> +	}
> +	return ret;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701085030.1245=
79-1-fredwudi0305@gmail.com?part=3D2
