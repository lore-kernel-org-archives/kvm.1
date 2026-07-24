Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2CEF15687D
	for <kvm@vger.kernel.org>; Fri, 24 Jul 2026 16:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784911554; cv=none; b=IErOO/+vO0E0zNvVMzmqqH0XpTGTvKMJf1i/H3zzDAuO44FRg62JE+JXQLQYGs9/gtW0XIlVgdTswM46FHqw6UxIx2G2Bpvp5YE9gLFQkY6louJdOOlPDz2tz7t9I56ezGqqabJzU4od9BV7c0o07WOuIjowURnVakh7yq1/QPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784911554; c=relaxed/simple;
	bh=ANyx1b4ulN8ior/0opp38YSbdRabBzHua3dxsFlzAx0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=I9BDCM4g8wnf/aa5aJ62ckJFqRHIixs/SFklHwo2mqfxjKCb8fCH3RL1c8+SWN7bp9kR1rysQUPouK3cLXreMaIfXk3MqPTazeYHPXJbvNUNjN/eBy67NT7SM1vJ+pI1cY4kiMRHpcpq+oQK0y8rJ9NAX9DFPgDt9f46u8ujoHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TyAGKy9b; arc=none smtp.client-ip=209.85.210.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TyAGKy9b"
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-84a251c2e3eso2185920b3a.1
        for <kvm@vger.kernel.org>; Fri, 24 Jul 2026 09:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784911552; x=1785516352; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wOkAxwjEVGe+pdS4ceu3SNaqiJGFCDw5HG9tUWbHUlc=;
        b=TyAGKy9biwAziXZJpC0AqKMfeKJ6yeoHjZi1jQ1NLTsN918tJdTKR2nvGIgUmbKd+m
         wlVsv5cmxs3zIIf6MYPUX3QBiivnkp5T+sDgE5TxmqzWtK8zMSjQzXZjsmvmQEINTGtF
         xI1E3k65lDBKXP1a2Qb8amDCV1+EjRPcFeCRE1MPDe4rTaa+AOmq23b2WiqLgojjxcUR
         aM+8SE0Z70xBs+Nt1unybEoUoZcqmhMjxwaDVaQsYq5SEKC4Pn5VUl21bLoZcMUH6Y86
         n0buiE+kEK8vClOCunP74EAKmWlRJXvaQE3r8tQ29csq2CRm1s/SEOYIKFAFueJFt11i
         nEEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784911552; x=1785516352;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wOkAxwjEVGe+pdS4ceu3SNaqiJGFCDw5HG9tUWbHUlc=;
        b=GP6CQTR762iRqUkTmn0v1LOho1l1OHc50rajAlTpbuWe7uOfw31Bgd1D5sA+D6ipVT
         hr3SkK1VRP3GAexp7ViIKgeV2I0GeM3mzFXS4vncKIHKeyM0AahS68y8PGnQIDQfsAH1
         NnUDXS7Pvyjf3QfqbRbE/dKwy409V4zcJ2s35lbjs0epAsCUkoVgRZPWeDhGLDv84N3X
         uzquzl08sGUZR4VAdZw4oLYbCjljJfIhi9XOxD+QrWQa+ppVBnuMlRpwZsxdNBBjEYfp
         79qvHWaFZnx+ZHwHC5XhqI+O1w2oZM9TWSNGIywi5nxmUAs7XHaKjYJLYF4H1EkZi2mz
         dxiQ==
X-Forwarded-Encrypted: i=1; AHgh+Rq90laoywKfFjmCAZE3xUzD3wtUsDNkg/teWj112qozr9t8Hg+HLP0Gbn/ClNuezcQ2GDw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9m+qW0PHFfjyzcLLrO8732tplWv5VTbZmilzTGr2JTyb8neA3
	yoIlBhJAO656rTF85lUEafjVyupCDbh3v5zxkPNGxnyk0ZASq1Z/TUcwttMYdycsh9miTNPWiu3
	WjeYkWQ==
X-Received: from pgnm21.prod.google.com ([2002:a63:7d55:0:b0:c98:2639:852e])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:928f:b0:842:446a:4cb5
 with SMTP id d2e1a72fcca58-84e4df6f4dbmr1066140b3a.0.1784911551550; Fri, 24
 Jul 2026 09:45:51 -0700 (PDT)
Date: Fri, 24 Jul 2026 09:45:50 -0700
In-Reply-To: <20260629183746.699840-8-yosry@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260629183746.699840-1-yosry@kernel.org> <20260629183746.699840-8-yosry@kernel.org>
Message-ID: <amOWvrZqRXxxHT1k@google.com>
Subject: Re: [PATCH v3 07/10] KVM: selftests: Add basic stress test for
 save+restore and #PF handling
From: Sean Christopherson <seanjc@google.com>
To: Yosry Ahmed <yosry@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Mon, Jun 29, 2026, Yosry Ahmed wrote:
> Add a basic stress test for handling #PFs in a guest while the host is
> doing save+restore cycles. The guest periodically accesses non-present
> memory causing a #PF, and the #PF handler walks the page tables and
> updates the PTE to be present, like a proper #PF handler.
> 
> After every access (and #PF), the guest triggers a sync and the test
> performs save+restore of the VM. This is not very meaningful as
> save+restore are performed after the access and #PF handling complete,
> but following changes will change that.
> 
> Assisted-by: Gemini:gemini-3.1-pro
> Signed-off-by: Yosry Ahmed <yosry@kernel.org>
> ---
>  tools/testing/selftests/kvm/Makefile.kvm      |   1 +
>  .../selftests/kvm/include/x86/processor.h     |  14 ++
>  .../kvm/x86/stress_save_restore_pf_test.c     | 182 ++++++++++++++++++
>  3 files changed, 197 insertions(+)
>  create mode 100644 tools/testing/selftests/kvm/x86/stress_save_restore_pf_test.c
> 
> diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
> index 4ace12606e937..c61d51a0c112f 100644
> --- a/tools/testing/selftests/kvm/Makefile.kvm
> +++ b/tools/testing/selftests/kvm/Makefile.kvm
> @@ -111,6 +111,7 @@ TEST_GEN_PROGS_x86 += x86/set_sregs_test
>  TEST_GEN_PROGS_x86 += x86/smaller_maxphyaddr_emulation_test
>  TEST_GEN_PROGS_x86 += x86/smm_test
>  TEST_GEN_PROGS_x86 += x86/state_test
> +TEST_GEN_PROGS_x86 += x86/stress_save_restore_pf_test

I'd rather go with just save_restore_pf_test, so that the focus of the test is
at the beginning of the file name.  E.g. I don't want to end up with a pile of
stress_xyz tests, because that makes tab completion a pain in the ass.

I'd also be ok with save_restore_pf_stress_test, but I highly doubt we'll end up
with another save_restore_pf_test, i.e. I don't think the clarification is needed.

Side topic, it probably makes sense to rename state_test to save_restore_state_test?

> --- /dev/null
> +++ b/tools/testing/selftests/kvm/x86/stress_save_restore_pf_test.c
> @@ -0,0 +1,182 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <errno.h>
> +#include <sys/types.h>
> +#include <time.h>
> +#include <unistd.h>
> +
> +#include "test_util.h"
> +#include "kvm_util.h"
> +#include "processor.h"
> +
> +#define NR_ITERATIONS		500
> +
> +#define GOTO_PREV_LINE		"\033[A\r"
> +#define PRINT_ITER(s, x)					\
> +do {								\
> +	if (x == 1)						\
> +		printf(s "%d\n", x);                            \
> +	else							\
> +		printf(GOTO_PREV_LINE s "%d\n", x);		\

Oh c'mon.  I had to Google the escape sequence you're (heh, "you"), using to
understand this.  Use a little creativity, and then the only magic escape sequence
is the much more familiar carriage return.


                pr_info("\rSave+restore iterations: %d", count);
        }
        pr_info("\n");

> +	fflush(stdout);						\
> +} while (0)
> +
> +#define PTRS_PER_PTE		512
> +#define PXD_INDEX(vaddr, level)	(((vaddr) >> PG_LEVEL_SHIFT(level)) & (PTRS_PER_PTE - 1))
> +
> +#define TEST_MEM_BASE_GVA	0xc0000000ULL
> +#define TEST_PGTABLE_GVA_OFFSET	0xd0000000ULL
> +#define NR_TEST_ADDRS		PTRS_PER_PTE

IMO, this macro does waaaaay more harm than good.  I'm looking at the usage and
going "WTF is this is actually doing?".  Knowing that the test is mucking with a
page table's worth of PTEs is super useful information.


> +#define PATTERN			0xabcdefabcdefabcdULL
> +
> +static u64 pte_present_mask;
> +static u64 pte_huge_mask;
> +
> +static u64 expected_vaddr;
> +static u64 guest_faults;
> +
> +static u64 *guest_get_pte(u64 vaddr)
> +{
> +	u64 pgtable_pa, pte;
> +	u64 *pgtable;
> +	int level;
> +	bool la57;
> +
> +	la57 = !!(get_cr4() & X86_CR4_LA57);

Superfluous use of !!, and of the local bool itself.  Just do

	level = (get_cr4() & X86_CR4_LA57) ? PG_LEVEL_256T : PG_LEVEL_512G;

> +	level = la57 ? PG_LEVEL_256T : PG_LEVEL_512G;
> +
> +	pgtable_pa = get_cr3() & PHYSICAL_PAGE_MASK;
> +	for (; level > PG_LEVEL_4K; level--) {
> +		pgtable = (u64 *)(pgtable_pa + TEST_PGTABLE_GVA_OFFSET);
> +		pte = pgtable[PXD_INDEX(vaddr, level)];
> +		GUEST_ASSERT(pte & pte_present_mask);
> +		GUEST_ASSERT(!(pte & pte_huge_mask));
> +		pgtable_pa = PTE_GET_PA(pte);
> +	}
> +
> +	pgtable = (u64 *)(pgtable_pa + TEST_PGTABLE_GVA_OFFSET);
> +	return &pgtable[PXD_INDEX(vaddr, PG_LEVEL_4K)];
> +}

Hmm, I think we should put this helper in tools/testing/selftests/kvm/lib/x86/processor.c,
and then provide a "struct kvm_mmu *guest_mmu;" that is automatically synchronized
to the guest during kvm_arch_vm_post_create().  I think vm->mmu is fully populated
at that point?

Then this test should be able to use the PTE macros from x86/processor.h, and
future tests don't need to reinvent the wheel.

> +
> +static void guest_pf_handler(struct ex_regs *regs)
> +{
> +	u64 fault_addr;
> +	u64 *ptep;
> +
> +	fault_addr = get_cr2();
> +	GUEST_ASSERT_EQ(fault_addr, READ_ONCE(expected_vaddr));
> +
> +	ptep = guest_get_pte(fault_addr);
> +	GUEST_ASSERT(ptep);
> +	GUEST_ASSERT(!(*ptep & pte_present_mask));
> +
> +	*ptep |= pte_present_mask;
> +	invlpg(fault_addr);

invlpg() should be unnecessary.  #PF is architecturally required to flush TLB
entries for the faulting address.  And since the PTEP is guaranteed to be !PRESENT,
the CPU can't have speculatively added a new TLB entry after the fault.

> +
> +	guest_faults++;
> +}
> +
> +static void guest_access_memory(void *arg)
> +{
> +	u64 vaddr, val;
> +	int i = 0;
> +
> +	for (;; i++) {

Dude.

	for (i = 0; ; i++)

> +		vaddr = TEST_MEM_BASE_GVA + (i % NR_TEST_ADDRS) * PAGE_SIZE;
> +		WRITE_ONCE(expected_vaddr, vaddr);
> +
> +		/* Read to trigger #PF */
> +		val = READ_ONCE(*(u64 *)vaddr);
> +		GUEST_ASSERT_EQ(val, PATTERN);
> +
> +		/* Clear the present bit again so it faults next time */
> +		*guest_get_pte(vaddr) &= ~pte_present_mask;
> +		invlpg(vaddr);
> +
> +		GUEST_SYNC(guest_faults);
> +	}
> +}
> +
> +int main(int argc, char *argv[])
> +{
> +	struct kvm_x86_state *state;
> +	int r, i, level, count = 0;
> +	gpa_t gpa, pgtable_gpa;
> +	struct kvm_vcpu *vcpu;
> +	struct kvm_vm *vm;
> +	struct ucall uc;
> +	u64 *pgtable;
> +	gva_t gva;
> +	u64 pte;
> +
> +	vm = vm_create_with_one_vcpu(&vcpu, guest_access_memory);
> +	vm_install_exception_handler(vm, PF_VECTOR, guest_pf_handler);
> +
> +	pte_present_mask = PTE_PRESENT_MASK(&vm->mmu);
> +	pte_huge_mask = PTE_HUGE_MASK(&vm->mmu);
> +	sync_global_to_guest(vm, pte_present_mask);
> +	sync_global_to_guest(vm, pte_huge_mask);
> +
> +	/* Allocate a page and write the pattern to it */

Oh, is that was this code is doing?  /s

I love comments.  I hate useless comments.

> +	gva = vm_alloc_page(vm);
> +	*(u64 *)addr_gva2hva(vm, gva) = PATTERN;
> +	gpa = addr_gva2gpa(vm, gva);
> +
> +	/*
> +	 * Map all virtual addresses to the pattern page and clear the present
> +	 * bit such that guest accesses will cause a #PF.
> +	 */
> +	for (i = 0; i < NR_TEST_ADDRS; i++) {
> +		gva = TEST_MEM_BASE_GVA + i * getpagesize();
> +		virt_pg_map(vm, gva, gpa);
> +		*vm_get_pte(vm, gva) &= ~pte_present_mask;
> +	}
> +
> +	/*
> +	 * Now create mappings for the page tables created above so that the
> +	 * guest #PF handler can walk them. All PTEs for test virtual addresses
> +	 * should lie on the same PTE page, so one page is mapped for each page
> +	 * table level.
> +	 *
> +	 * Use an offset for the GVA instead of creating identity mappings to
> +	 * avoid collision with existing mappings at low GVAs (e.g. ELF).
> +	 */
> +	pgtable_gpa = vm->mmu.pgd;
> +	for (level = vm->mmu.pgtable_levels; level >= PG_LEVEL_4K; level--) {
> +		virt_map(vm, pgtable_gpa + TEST_PGTABLE_GVA_OFFSET, pgtable_gpa, 1);
> +		pgtable = addr_gpa2hva(vm, pgtable_gpa);
> +		pte = pgtable[PXD_INDEX(TEST_MEM_BASE_GVA, level)];
> +		pgtable_gpa = PTE_GET_PA(pte);
> +	}
> +
> +	while (count++ < NR_ITERATIONS) {

Seriously.

	for (i = 0; i < NR_ITERATIONS; i++)

I'm a-ok with people using AI to help with development, but I still absolutely
expect the result to follow kernel style and generally not be the stupidest way
to write code.
