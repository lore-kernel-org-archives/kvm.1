Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9473F2566E9
	for <kvm@vger.kernel.org>; Wed,  3 Jun 2026 10:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780482845; cv=none; b=pXgvDju7pMujrYoX7czAqsH8eaFnYfFwTm724L/KgAKnc6LblXt6NOM+pJ+ZJiTvhb9RUb/ViEH+7T9kK6Nm0sg9A0UXgIH3VTWskamD6y6tDXWgQorA9zgQ0qAGKpYFPDGg+GzJYMXRuIcnRvIiQur1LPHP6Oq0zgfdrYJ0XpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780482845; c=relaxed/simple;
	bh=HPtVTlUcJ6HedEmy3jR5YznQWUwa8WVWtqJxaDzITYg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JteKCLwYXdiCEUAwVLWO1XtzInmQzvEfuSOt4sq+9csaoUxKWYGHGjs35d4l02LiP+ePPU06EQd7HQking1jHCwpj5mG2FO6IfHBRdULTq/gH+DWNxdQ9HkmAMmwobHmbb2FkzpkgwbGGmvSfEO4v/E2+9qx1R4OQUc3TESbno8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E8Cc5SKf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E8Cc5SKf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 265151F00893;
	Wed,  3 Jun 2026 10:34:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780482844;
	bh=Ui5aW4JmiahRB0NxrnBeMwfkNu+vA54/z/J0QEEkQ9g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=E8Cc5SKfjdg/6tPuZVKgt58fPLt3zxaYoLEag0j5IM+t+qMWBp46+zxzyZo4QCQAa
	 ae5lonlmP4ocYA+twx7nGzbJ+3QIz82QuaZI5NWjLMwd0UbKDZ3FtQye8XzlI84wyl
	 5QHIZJVJ5mrol069NHPkP5MtDBMHIIyvah39YOr3l2kjVXN4qpKl7x8KafPKQN8UY3
	 Ye064k90o8Xz+JRbGRrK3lc3STeSEstd7A6dASfJb5EKL4iqjlpCHb5PcZW+RaXRfk
	 36TTt+fSm46teHkepkm3Hb9BL8iMccl3xsklAq7Cfw8SJPewrZvyIZRpNcM7PsaC+J
	 tGBcFLYLCq9KA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/4] RISC-V: KVM: Split huge pages when dirty logging
 =?utf-8?b?aXPCoGVuYWJsZWQ=?=
Reply-To: sashiko-reviews@lists.linux.dev
To: wang.yechao255@zte.com.cn
Cc: kvm@vger.kernel.org
In-Reply-To: <202606031757028642jwiaL-QePBLGAhMW88zw@zte.com.cn>
References: <202606031757028642jwiaL-QePBLGAhMW88zw@zte.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 03 Jun 2026 10:34:01 +0000
Message-Id: <20260603103403.265151F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] Dropping mmu_lock without flushing remote TLBs after modifying pag=
e tables.

Pre-existing issues:
- [High] Missing memory barrier before publishing newly allocated stage-2 c=
hild page tables.
--

commit 0208ccce76fbb3c703dc5faa9c4873b1be06a0ce
Author: Wang Yechao <wang.yechao255@zte.com.cn>

RISC-V: KVM: Split huge pages when dirty logging is enabled

Split huge pages eagerly when enabling dirty logging. The goal is to
avoid doing it while faulting on write-protected pages, which
negatively impacts guest performance.

> diff --git a/arch/riscv/kvm/mmu.c b/arch/riscv/kvm/mmu.c
> index 0676937bd9a1c..51bd1db74e1aa 100644
> --- a/arch/riscv/kvm/mmu.c
> +++ b/arch/riscv/kvm/mmu.c
> @@ -90,6 +90,52 @@ void kvm_riscv_mmu_iounmap(struct kvm *kvm, gpa_t gpa,=
 unsigned long size)
[ ... ]
> +/* the caller must held mmu lock */
> +static void mmu_split_huge_pages(struct kvm_gstage *gstage,
> +				 phys_addr_t start, phys_addr_t end,
> +				 bool flush)
> +{
> +	struct kvm *kvm =3D gstage->kvm;
> +	struct kvm_mmu_memory_cache *pcache =3D &kvm->arch.pgd_split_page_cache;
> +	int count =3D gstage->pgd_levels;
> +	phys_addr_t addr =3D start;
> +	int ret;
> +
> +	lockdep_assert_held(&kvm->mmu_lock);
> +
> +	while (addr < end) {
> +		if (need_topup_split_caches_or_resched(pcache, count)) {
> +			spin_unlock(&kvm->mmu_lock);
> +			cond_resched();

[Severity: High]
Does this drop the MMU lock while there are unflushed page table
modifications?

Because mmu_split_huge_pages() passes flush =3D false to
kvm_riscv_gstage_split_huge(), TLB flushes are deferred until
mmu_split_memory_region() completes. If cache top-up or rescheduling
is needed, the kvm->mmu_lock is dropped here without flushing the
remote TLBs for the pages that were split in previous loop iterations.

Could this allow other vCPUs to observe inconsistent stage-2 page
tables or execute with stale TLB mappings while the lock is dropped?
Perhaps a remote TLB flush should be issued for the already-processed
range before unlocking?

> +
> +			ret =3D kvm_mmu_topup_memory_cache(pcache, count);
> +			if (ret) {
> +				kvm_err("Failed to toup split page cache\n");
> +				spin_lock(&kvm->mmu_lock);
> +				return;
> +			}
> +			spin_lock(&kvm->mmu_lock);
> +		}
> +
> +		ret =3D kvm_riscv_gstage_split_huge(gstage, pcache, addr, 0, flush);

[Severity: High]
This is a pre-existing issue, but looking at kvm_riscv_gstage_split_huge()
which is called here, it appears to lack a memory barrier before publishing
the newly allocated stage-2 child page tables:

arch/riscv/kvm/gstage.c:kvm_riscv_gstage_split_huge() {
...
		for (i =3D 0; i < PTRS_PER_PTE; i++) {
			child_pte =3D make_child_pte(huge_pte, i, child_page_size);
			set_pte((pte_t *)&next_ptep[i], __pte(child_pte));
		}

		set_pte(ptep, pfn_pte(PFN_DOWN(__pa(next_ptep)),
				__pgprot(_PAGE_TABLE)));
...
}

Because RISC-V set_pte() translates to a simple WRITE_ONCE without an
implicit memory barrier, could the stores initializing the child PTEs be
reordered after the store that publishes the page table to ptep?

If so, a concurrent hardware page table walker traversing the newly
published ptep might read uninitialized or stale data from the child
page table, resulting in spurious stage-2 page faults. Would it make
sense to insert an smp_wmb() before publishing the new page table?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260603175256408L0=
jnqGs1cJGc0ijCdujci@zte.com.cn?part=3D2
