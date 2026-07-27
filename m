Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41ADF3E44EC
	for <kvm@vger.kernel.org>; Mon, 27 Jul 2026 13:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785157270; cv=none; b=jI9c/1h/J02HqhQpxsg7h9y3YvZhXCgPnqENAPpaczA/XdpYUCXteTilZ7t9a6WqPOKtVscxSDdI4qzVAH1Me5C3x2O7Roii5C1Ju/C9XnyzTUAXfKdS7tin/V5uiip7e5Hyrye9g/LbXAhJK6W8wFXgrLaD2s8Ps9FeuxpCdrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785157270; c=relaxed/simple;
	bh=Z9FUZNusYaET7iu0K2v8uRTI0/Mr7pYZ5Z935qdDW94=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dw/lpVctHqNtI1wS9JPTXbVbUqJQnCMv0Y2OhkWIU/YJR4Ebxoz12O/zfrd8WTgVXwlgxSV0u2mnu3DdiRi/BOzUSZRwjOL2kLRUwGICfGrapmUZ922l0NDphCYlacXp6C7VtHskBYwSYLHTvxLODlJ7WHclTcAUQ2fhBkNpEO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JskiWDLx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JskiWDLx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A871C1F000E9;
	Mon, 27 Jul 2026 13:01:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785157268;
	bh=dln+rxA6PINUzzz4mh6lejozv9NgGjUZEcbsgd5xWJU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JskiWDLxck6Pc2deBlExZVU3z2LRvgY6vIuWsrcjJkFJtX825mSXF6Hf9yWKFj0H2
	 lCbKy7aU71S6a8/paikYERos26sWGjpTdYILWAwoDcff1vtwbAL6W8XPPHgBGKv/NU
	 2DthPRx6rsEUcrmd7BoQpd73JZiMyjvB0hhme7JFFOgUqLxW/z/L6e8NKlGbTjiOaD
	 siAP1ayhWEzzcuMuYFP3b5y3z2YDaBQ3OsQrAgF4KKFR0CSq7euyof1xBrpkVOxfzD
	 lhL3UOMfO0yupJ4tiLp9vxIgTZJ81ks32wI+zpYahFLN0cxV2fn0tBNY3Q3ACLj1AI
	 cmbpNgeDXJvBg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/3] KVM: riscv: Register ptdump with debugfs on
 guest creation
Reply-To: sashiko-reviews@lists.linux.dev
To: Dylan.Wu <fredwudi0305@gmail.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260727123013.118984-4-fredwudi0305@gmail.com>
References: <20260727123013.118984-1-fredwudi0305@gmail.com>
 <20260727123013.118984-4-fredwudi0305@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 27 Jul 2026 13:01:08 +0000
Message-Id: <20260727130108.A871C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [High] gstage_ptdump_show traverses KVM guest stage-2 page tables without=
 holding kvm->mmu_lock, creating a severe use-after-free race condition.
- [High] Using the host's generic page table walker for KVM guest stage-2 p=
age tables causes incorrect parsing and potential kernel panics due to mism=
atched root page table geometries.
- [Medium] Concurrent accesses to the debugfs file cause a data race and pe=
rsistent state corruption due to mutation of the static `gstage_pg_levels` =
array.
- [Medium] If `kvm->arch.pgd` is NULL, the walker silently falls back to wa=
lking the host process's page tables, leaking the host virtual memory layou=
t.
- [Medium] gstage_note_page_flush triggers an integer underflow, printing a=
n astronomically huge size and an incorrect range boundary.
--

--- Patch [3]: [PATCH v2 3/3] KVM: riscv: Register ptdump with debugfs on g=
uest creation ---
commit d69a647519dc99ece115797b207b3ba4248c4915
Author: Dylan.Wu <fredwudi0305@gmail.com>

KVM: riscv: Register ptdump with debugfs on guest creation
   =20
Add a new RISC-V KVM specific ptdump implementation that dumps the
guest stage-2 (gstage) pagetables via debugfs. The code reuses the
common ptdump data structures and helpers from asm/ptdump.h, and
exposes a "gstage_page_tables" file in each guest VM's debugfs
directory (kvm->debugfs_dentry).

[ ... ]

> diff --git a/arch/riscv/kvm/ptdump.c b/arch/riscv/kvm/ptdump.c
> new file mode 100644
> index 0000000000000..83a92969bd419
> --- /dev/null
> +++ b/arch/riscv/kvm/ptdump.c

[ ... ]

> +static void gstage_note_page_flush(struct ptdump_state *pt_st)
> +{
> +	pte_t pte_zero =3D {0};
> +
> +	gstage_note_page(pt_st, 0, -1, pte_val(pte_zero));
> +}

[Severity: Medium]
Will this trigger an integer underflow when calculating the block size?

The generic host code uses 0 to denote ULONG_MAX + 1 for address spaces
ending at the top of the 64-bit space, where 0 - start_address gracefully
yields the correct distance.

However, the KVM guest physical address space ends at gpa_size (e.g., 2TB).
Passing 0 here means addr >=3D st->marker[1].start_address evaluates to
false, skipping the 'Guest Physical Address End' marker. It then calculates
the size as (0 - start_address) >> 10, which underflows into a massive
unsigned integer.

Should this pass the actual end of the guest physical address space instead
of 0?

> +
> +static int gstage_ptdump_show(struct seq_file *m, void *v)
> +{
> +	struct kvm *kvm =3D m->private;
> +	gpa_t gpa_size =3D kvm_riscv_gstage_gpa_size(kvm->arch.pgd_levels);

[ ... ]

> +	unsigned int i, j;
> +
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
Is it safe to mutate the static global array gstage_pg_levels here without
any synchronization?

Since gstage_pg_levels is a global static array, concurrent reads of the
debugfs file for different VMs will race here, which could lead to omitted
protection bits.

Additionally, downgrading a level's name to "PGD" permanently modifies the
array for subsequent reads of VMs that might have deeper page tables. Could
this state be maintained per-VM instead of globally?

> +
> +	ptdump_walk_pgd(&st.ptdump, kvm->mm, kvm->arch.pgd);

[Severity: High]
Does this traversal require kvm->mmu_lock to safely walk the guest page
tables?

If a user reads the debugfs file while the VM is concurrently modifying or
tearing down its page tables, the walker will traverse these structures
locklessly. ptdump_walk_pgd() acquires the host userspace mmap_write_lock
for kvm->mm, but does not acquire kvm->mmu_lock, which could lead to
dereferencing freed intermediate page table pages (use-after-free).


[Severity: High]
Can the host's generic page table walker safely handle KVM guest stage-2
page tables with different geometries?

KVM RISC-V guest page tables have dynamically configured depth through
kvm->arch.pgd_levels, which can differ from the host's compile-time depth
in CONFIG_PGTABLE_LEVELS.

If the host uses 4 levels and the guest uses 3 levels, the generic walker
will treat the guest's 3-level root as a 4-level root. It will descend one
level too deep, extracting a PFN from leaf PTEs, converting it to a kernel
virtual address, and dereferencing it. Could this trigger an out-of-bounds
direct map access and panic the host kernel?


[Severity: Medium]
What happens if kvm->arch.pgd is NULL when this is called?

If the debugfs file is read while kvm_arch_flush_shadow_all() is executing
during process exit, kvm->arch.pgd could be NULL.

Inside the generic walker, it detects a NULL pgd and falls back to
pgd_offset(walk->mm, addr). Since walk->mm is the host QEMU process's mm,
the walker will format and leak the host process's page table layout as if
it were the guest's stage-2 memory. Should we check for a NULL pgd before
initiating the walk?

> +
> +	return 0;
> +}

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260727123013.1189=
84-1-fredwudi0305@gmail.com?part=3D3
