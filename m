Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E5939021B
	for <kvm@vger.kernel.org>; Tue, 28 Jul 2026 16:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785257450; cv=none; b=ZT9BEX0/kVt4D+9Y4IpBrRj2oXXkK0eW78FMSqZnjrym5vnTJpSGxLsX9Tvz06TzIuwm9eyalIEJt0s+Ontp+iyib39Px07T4g3DOqOFIFBCe1ATJ62i9r49UPPAFHpHITg5Sdv8Eed1V8YBOE1zodZbQSH9ULtFczLDXNifC5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785257450; c=relaxed/simple;
	bh=QbrDapLK+0y8bZRqYi76G7zVHlXOqJYoVW5bdt1GKKU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Md97HaXld2wBCaXwgV5qbKccifS/nJW17XzoqYCsoSikfMpWVzQ2ncD2JeEAJg24DzOair7y4sYyI4kwxzXDNWU0TCO1i7cDi4MDhx9JFxYEWCyNzkVT5RbyZton0Nb3hTMSNYyW58sSmW5lQfgBr/o4fL3QpqrrSzyTtJGg7yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dpYjh3I2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dpYjh3I2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22E811F000E9;
	Tue, 28 Jul 2026 16:50:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785257449;
	bh=QyDJ2NzOXwygytgQmcR4thiQiu9FOQZ36e9sP+fVX0c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dpYjh3I2C8enMFl/9tCY3OlMuKuZQ3wVU3jsuugnMEzw7gyKhP2Ou4/GQzVKC8ALG
	 ooHFb2jnqATx0OnjW2q89CpflbLiAw+zDd6dHhI1czqapyBrsKJ3FM37jBSAFFxWQD
	 995shz49lKn14LI8+ZXAjXCdgtnxphnWDjQ53/ZYDkbueFGDMKmmwbTceP2RwWAKFO
	 1T49b+ViHef6LLkUQc1XTeQh0kv3vCI50iYgDJIWYf+lpqkMav+gnxhkw0xt/t5+/s
	 cPloaLGmNyvfvcfHB0SPWatUz9svxe1QmvGpw6dqTHouLb579VDfU77PJ1joqokO+o
	 eKOyLdvRC7Bug==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/3] KVM: riscv: Register ptdump with debugfs on
 guest creation
Reply-To: sashiko-reviews@lists.linux.dev
To: Dylan.Wu <fredwudi0305@gmail.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260728161449.190058-4-fredwudi0305@gmail.com>
References: <3bb2f519-c70b-6c35-c404-6fbfe8adbeb1@kernel.org>
 <20260728161449.190058-1-fredwudi0305@gmail.com>
 <20260728161449.190058-4-fredwudi0305@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 16:50:48 +0000
Message-Id: <20260728165049.22E811F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:
- [Critical] Lockless traversal of `kvm->arch.pgd` using host `mmap_write_l=
ock` instead of `kvm->mmu_lock` leads to a Use-After-Free if gstage page ta=
bles are concurrently freed.
- [High] The generic host page table walker is structurally incompatible wi=
th KVM guest stage-2 page tables, leading to bogus walks and kernel panics.
- [Medium] Passing a NULL `kvm->arch.pgd` to the core page table walker cau=
ses it to silently fall back to walking the host process's page tables.
- [Medium] Mutating the static global array `gstage_pg_levels` without sync=
hronization causes data races and permanently corrupts the output layout ac=
ross different VMs.
- [Medium] Incompatible reuse of the host's `note_page()` function breaks r=
ange coalescing and prints incorrect output names.
- [Low] Linker error when KVM is compiled as a loadable module due to missi=
ng export of `ptdump_walk_pgd`.
--

--- Patch [3]: [PATCH v3 3/3] KVM: riscv: Register ptdump with debugfs on g=
uest creation ---
commit 5cf74731d352654675c1f47276baa2185271e44d
Author: Dylan.Wu <fredwudi0305@gmail.com>

KVM: riscv: Register ptdump with debugfs on guest creation

Implement the gstage page table dumper for RISC-V KVM, which exposes
the guest's gstage page tables via debugfs. When
CONFIG_PTDUMP_GSTAGE_DEBUGFS is enabled, a "gstage_page_tables" file
will be created under each VM's debugfs directory.

> diff --git a/arch/riscv/kvm/ptdump.c b/arch/riscv/kvm/ptdump.c
> new file mode 100644
> --- /dev/null
> +++ b/arch/riscv/kvm/ptdump.c
[ ... ]
> +static void gstage_note_page(struct ptdump_state *pt_st, unsigned long a=
ddr,
> +			     int level, u64 val)
> +{
> +	struct ptdump_pg_state *st =3D container_of(pt_st, struct ptdump_pg_sta=
te, ptdump);
> +
> +	note_page(pt_st, addr, level, val);
> +
> +	if (level >=3D 0)
> +		st->current_prot =3D val & gstage_pg_levels[level].mask;
> +}

[Severity: Medium]
Will reusing the host note_page() function break range coalescing and
produce incorrect output?

The host note_page() function hardcodes the use of kernel_pg_levels to
compute the page protection mask. Because kernel_pg_levels and
gstage_pg_levels mask different bits, won't note_page() falsely detect a
protection change for almost every page before we override it here?

Additionally, it seems note_page() will use kernel_pg_levels to print out
the directory names, potentially printing incorrect level names for the
guest entries.

[ ... ]
> +static int gstage_ptdump_show(struct seq_file *m, void *v)
> +{
> +	struct kvm *kvm =3D m->private;
[ ... ]
> +	for (i =3D 0; i < ARRAY_SIZE(gstage_pg_levels); i++) {
> +		gstage_pg_levels[i].mask =3D 0;
> +		for (j =3D 0; j < ARRAY_SIZE(gstage_pte_bits); j++)
> +			gstage_pg_levels[i].mask |=3D gstage_pte_bits[j].mask;
> +	}
> +
> +	if (kvm->arch.pgd_levels < 5)
> +		gstage_pg_levels[1].name =3D "PGD";
> +	if (kvm->arch.pgd_levels < 4)
> +		gstage_pg_levels[2].name =3D "PGD";
> +	if (kvm->arch.pgd_levels < 3)
> +		gstage_pg_levels[3].name =3D "PGD";

[Severity: Medium]
Does mutating the static global gstage_pg_levels array here cause data
races?

Since debugfs files can be read concurrently for multiple VMs with different
pgd_levels, won't these lockless writes corrupt the array for subsequent
reads of other VMs?

> +
> +	ptdump_walk_pgd(&st.ptdump, kvm->mm, kvm->arch.pgd);

[Severity: Critical]
Does this lockless traversal risk a use-after-free of the gstage page table=
s?

KVM guest stage-2 page tables are strictly managed under kvm->mmu_lock. The
debugfs walker acquires the host process's mmap_write_lock via
ptdump_walk_pgd(), but does not hold kvm->mmu_lock.

If a concurrent KVM operation such as a memslot removal or an MMU notifier
fires and calls kvm_riscv_gstage_unmap_range(), it will free the intermedia=
te
page table pages. Will this walker concurrently read freed memory?

[Severity: High]
Is the generic host page table walker structurally compatible with KVM guest
stage-2 page tables?

The generic walker relies on compile-time host macros like PGDIR_SHIFT and
PTRS_PER_PGD. However, RISC-V KVM gstage page tables have dynamic geometries
based on kvm->arch.pgd_levels.

When the host macros are applied to the gstage root, will the walker
compute incorrect indices and treat guest leaf PTEs as intermediate
directories, causing out-of-bounds memory accesses?

[Severity: Medium]
What happens if the debugfs file is read before the gstage root is
allocated?

At VM initialization, kvm->arch.pgd is NULL. If a NULL pgd is passed to
walk_pgd_range(), won't it silently fall back to walking the host process's
page tables via pgd_offset(walk->mm, addr)?

[Severity: Low]
Will this cause a build failure when KVM is compiled as a loadable module?

The core kernel symbol ptdump_walk_pgd() is not exported to modules via
EXPORT_SYMBOL(), which might cause a linker error here when KVM is built as
a module.

> +
> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260728161449.1900=
58-1-fredwudi0305@gmail.com?part=3D3
