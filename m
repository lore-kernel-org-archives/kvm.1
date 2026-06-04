Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 711EF2EEE92
	for <kvm@vger.kernel.org>; Thu,  4 Jun 2026 23:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780615076; cv=none; b=tAWbxkimjMe5Cm29SvUim1978sZC2YW8zxesnXr/+jjwKJPHB6L0ldaPlNd2aiokRKLThaADXKOY8tzW/QJkTxxxptBBlQT/tsslyYFDxw0ko6LDz16j9NkEfhXHJ3WOxvvjASeawJYds0Vd+6wW83PFMlaPoYGp/zeIGTBXR2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780615076; c=relaxed/simple;
	bh=Gaee3oU6+TfV+olINyhWE4H94Yl1TYRZoOCFheJpwqQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RsG7j3LVSh6sX3tslW9w2Tq6N4rKwcRFxCoXDDHcDx1aRlj6cc+j+vlVzUwfDBAT3EeddXcwQ4IxxndHVK5b4WrLNxOXj/yMnliiF6stCT/E3XhsKO510229plqm5XSqlyzxBAbqElWh2HQiKlj9HQMQykwRVTK5a6Hw1SJj5V8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jb9/0TKi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jb9/0TKi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06E6B1F00893;
	Thu,  4 Jun 2026 23:17:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780615075;
	bh=kkInxiDA5Rq5ZnGx0b2oUape5EboDYocuT8uKVFvP08=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jb9/0TKipGMLAdEjzNggrVqxJiu3A3igoMrWA2JfI6RmDppRz2PgnNXJB84ddA1H7
	 Xp6VN+J2GVCKkcZR/aR+x0WlZtp39Eqq403SX4vyo64iK2QeqUuXnVocX9zH2EDxvx
	 EiwCLuevf5/rtvYlWd6YqreLvjUT/O6r31Rle/yB737hR1ld8zed4rBo86WOY4GesZ
	 HHN/l3mL9tOXeD2nxy8+PiFQHeBC7EdjsdiUS5JwMcMJitHKQp770TqoE622RA+T7f
	 cIyNJg1k5J8IyWCflytQ+9FYurGzzPHImjmZLogYyPDGfF3TL6pKSIC67V8BzmlpUg
	 t+4IA8k6cZihA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] RISC-V: KVM: Fix skip of valid pages in
 kvm_riscv_gstage_unmap_range
Reply-To: sashiko-reviews@lists.linux.dev
To: atwufei@163.com
Cc: kvm@vger.kernel.org
In-Reply-To: <20260604230317.30501-3-atwufei@163.com>
References: <20260604230317.30501-3-atwufei@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 04 Jun 2026 23:17:54 +0000
Message-Id: <20260604231755.06E6B1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [High] Unprivileged host userspace can trivially trigger the newly added =
`WARN_ONCE`, causing a Denial of Service.

Pre-existing issues:
- [Critical] Skipping partial huge page unmaps leaves host memory accessibl=
e to the guest after it is freed.
- [High] Advancing an unaligned `addr` by `page_size` incorrectly preserves=
 the unaligned offset, causing subsequent valid pages in the range to be sk=
ipped.
- [High] Intermediate G-stage page table pages are completely bypassed duri=
ng unmap operations and are never freed, causing a permanent memory leak wh=
en VMs are destroyed.
--

commit d2321d423fc87ac8906198316ceb13deb7890738
Author: Wu Fei <wu.fei9@sanechips.com.cn>

RISC-V: KVM: Fix skip of valid pages in kvm_riscv_gstage_unmap_range

Same as kvm_riscv_gstage_wp_range, the possible valid pages should not
be skipped if !found_leaf. Different from wp case, which can
write-protect more than asked, unmap can't do that, no splitting is
added right now but a warning is logged instead.

> diff --git a/arch/riscv/kvm/gstage.c b/arch/riscv/kvm/gstage.c
> --- a/arch/riscv/kvm/gstage.c
> +++ b/arch/riscv/kvm/gstage.c
> @@ -395,15 +395,19 @@ void kvm_riscv_gstage_unmap_range(struct kvm_gstage=
 *gstage,
>  		if (ret)
>  			break;
> =20
> -		if (!found_leaf)
> -			goto next;
> -
> -		if (!(addr & (page_size - 1)) && ((end - addr) >=3D page_size))
> -			kvm_riscv_gstage_op_pte(gstage, addr, ptep,
> -						ptep_level, GSTAGE_OP_CLEAR);
> +		if (!found_leaf) {
> +			addr =3D ALIGN(addr + 1, page_size);
> +		} else {
> +			if (!(addr & (page_size - 1)) && ((end - addr) >=3D page_size))
> +				kvm_riscv_gstage_op_pte(gstage, addr, ptep,
> +							ptep_level, GSTAGE_OP_CLEAR);

[Severity: Critical]
This is a pre-existing issue, but by skipping the unmap of a partial
huge page when the alignment or size check fails, does this leave the
host memory accessible to the guest?

When an MMU notifier requests unmapping a sub-page of a huge page, for
example due to host page reclaim, migration, or a madvise DONTNEED call,
KVM skips unmapping the PTE here. This bypasses the MMU notifier
contract, leaving the guest with active read and write access to a
physical page that has been freed and potentially reallocated by the
host.

[Severity: High]
This is also a pre-existing issue, but does calling
kvm_riscv_gstage_op_pte() exclusively on leaf PTEs cause a permanent
memory leak of intermediate page tables?

Because kvm_riscv_gstage_get_leaf() only returns leaf PTEs, the recursive
branch in kvm_riscv_gstage_op_pte() intended to free intermediate page
tables:

kvm_riscv_gstage_op_pte() {
    ...
    if (ptep_level && !gstage_pte_leaf(ptep)) {
        ...
        if (op =3D=3D GSTAGE_OP_CLEAR)
            put_page(virt_to_page(next_ptep));
    ...
}

is never reached. When a VM is destroyed, the leaves are unmapped but
the intermediate page table pages appear to be leaked.

> +			else {
> +				WARN_ONCE(1, "Skip unmap range addr: %#llx, end: %#llx, page_size: %=
#lx\n",
> +						addr, end, page_size);
> +			}

[Severity: High]
Could this new WARN_ONCE be triggered by an unprivileged host userspace
process, causing a denial of service?

If userspace maps a huge page to a KVM guest and subsequently unmaps or
changes protections on a 4KB sub-page, the MMU notifier will request a
sub-page unmap. The alignment check will fail and trigger this warning.
On systems with panic_on_warn enabled, this allows an unprivileged
process to panic the host. Should this be converted to pr_warn_once()
or removed entirely?

> =20
> -next:
> -		addr +=3D page_size;
> +			addr +=3D page_size;

[Severity: High]
This is a pre-existing issue, but if the address is unaligned, does
advancing by page_size break the iterator alignment for all subsequent
huge pages?

If the unmap is skipped because addr is unaligned to the huge page size,
advancing by page_size leaves addr at the exact same unaligned offset
within the next huge page region. On the next iteration, the alignment
check !(addr & (page_size - 1)) will fail again, causing KVM to silently
skip unmapping every subsequent huge page up to the end of the range.
Should addr be aligned down before adding page_size?

> +		}
> =20
>  		/*
>  		 * If the range is too large, release the kvm->mmu_lock

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260604230317.3050=
1-1-atwufei@163.com?part=3D2
