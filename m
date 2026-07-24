Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D990231A053
	for <kvm@vger.kernel.org>; Fri, 24 Jul 2026 17:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784914716; cv=none; b=mzli7tb7EAaeA36sxH2H3aqQK2/b/YMXRSSR0XsZ1lWVZY7ngnkcE6MwqeZaCQI6KwJaeFiHZ00iKw+PqNScodoXhZOr4eAXALCnZx8JN2/x08j7ngBBY+pkw2fgiJy5AA91lHRl6O4Cw36KLK03lEfmgC1aQHZ6IRnJ5lBnM68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784914716; c=relaxed/simple;
	bh=CznwMI+ybD2px/NbMRsKM9HT1bxwGUsTLiXCIav773c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=selnHzi+hhMxfJiKYZsE8rK57n6bIkHYBXffAJCucX9T5Nqae86WAIk7xtzaRgpZJEPEF3PdJoBfiaKN+XxWK4UsmAgx/yNM46W8/eLBZKyTLg+gcGekIodSZZvegLZAjiUDD14PIvVAC5PPi/MyPN9lE/WkyQ+R5IGGwaS+9Io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kn6DQzhy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kn6DQzhy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FD4A1F000E9
	for <kvm@vger.kernel.org>; Fri, 24 Jul 2026 17:38:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784914714;
	bh=zLijo0TBrdaQW4JdIPeXSq4/pNB5UMcuXr1RjT2D8ms=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=kn6DQzhyaxONSQiSZo6x4jwvZP/dWOpiNEcpWm8O275ftAGVdw0DQfL0xAXIEWCRj
	 bsw69r34Gie50WeNdVnrL+Ds/4KmXrsgghKmsQJaEtBM5ZG8CbrWMc8ynG6CjOmyzR
	 o3bhOUFmCUfK2xJVnr8SlisPM939gF8GAoT67jlo9Gn8yaR9/5bKPNbRYY7s0K0khP
	 ls5BQf49ADH/JtQsT6TZZYiorHhghh6O+u8kLriUe2sMAI/ZaxY6/pXJpFdftn+aZ6
	 M5AJBxoc+5sFgXAdhoKKc1Ed4B3ACq8e7+/xGvjLNKx7Xhs/gQWplwfEJtfhcLxZAW
	 zoskUXu9FFSyA==
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-92ed19f4d60so59710785a.0
        for <kvm@vger.kernel.org>; Fri, 24 Jul 2026 10:38:34 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rralsmx5+mL+pGN76kkXPYQcvvfY0iybzW2ySoRP1bw38xZFCL1CM8upumin4oWKzjFLJE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwulxRRBGN4QilW2V5R/ipGnKdph1RVE4Vf9buTvuqHMH+H7Aon
	8sd7az/k38wkny0emQcg7BS2Fx349nEl5STKtRFTfHudbdP1ymijPa4ThCdcxw3eJbZBjhMy3fJ
	ml45G/I6XIkWAlFFe/qCFo3WhOuYI1NE=
X-Received: by 2002:a05:620a:4690:b0:930:d48:a3d2 with SMTP id
 af79cd13be357-932a955e9ccmr167355585a.21.1784914713804; Fri, 24 Jul 2026
 10:38:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260629183746.699840-1-yosry@kernel.org> <20260629183746.699840-8-yosry@kernel.org>
 <amOWvrZqRXxxHT1k@google.com>
In-Reply-To: <amOWvrZqRXxxHT1k@google.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Fri, 24 Jul 2026 10:38:21 -0700
X-Gmail-Original-Message-ID: <CAO9r8zN7ditPSQMPpRsWtPXXXoV0iNW5mhGLPb7A356Kd==RLg@mail.gmail.com>
X-Gm-Features: AUfX_mzGzEPZIZyOqAImkvuItPGB0Mp3pzA8o2-nixf4pU8aGXOTdWfV6S39E04
Message-ID: <CAO9r8zN7ditPSQMPpRsWtPXXXoV0iNW5mhGLPb7A356Kd==RLg@mail.gmail.com>
Subject: Re: [PATCH v3 07/10] KVM: selftests: Add basic stress test for
 save+restore and #PF handling
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 24, 2026 at 9:45=E2=80=AFAM Sean Christopherson <seanjc@google.=
com> wrote:
>
> On Mon, Jun 29, 2026, Yosry Ahmed wrote:
> > Add a basic stress test for handling #PFs in a guest while the host is
> > doing save+restore cycles. The guest periodically accesses non-present
> > memory causing a #PF, and the #PF handler walks the page tables and
> > updates the PTE to be present, like a proper #PF handler.
> >
> > After every access (and #PF), the guest triggers a sync and the test
> > performs save+restore of the VM. This is not very meaningful as
> > save+restore are performed after the access and #PF handling complete,
> > but following changes will change that.
> >
> > Assisted-by: Gemini:gemini-3.1-pro
> > Signed-off-by: Yosry Ahmed <yosry@kernel.org>
> > ---
> >  tools/testing/selftests/kvm/Makefile.kvm      |   1 +
> >  .../selftests/kvm/include/x86/processor.h     |  14 ++
> >  .../kvm/x86/stress_save_restore_pf_test.c     | 182 ++++++++++++++++++
> >  3 files changed, 197 insertions(+)
> >  create mode 100644 tools/testing/selftests/kvm/x86/stress_save_restore=
_pf_test.c
> >
> > diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/s=
elftests/kvm/Makefile.kvm
> > index 4ace12606e937..c61d51a0c112f 100644
> > --- a/tools/testing/selftests/kvm/Makefile.kvm
> > +++ b/tools/testing/selftests/kvm/Makefile.kvm
> > @@ -111,6 +111,7 @@ TEST_GEN_PROGS_x86 +=3D x86/set_sregs_test
> >  TEST_GEN_PROGS_x86 +=3D x86/smaller_maxphyaddr_emulation_test
> >  TEST_GEN_PROGS_x86 +=3D x86/smm_test
> >  TEST_GEN_PROGS_x86 +=3D x86/state_test
> > +TEST_GEN_PROGS_x86 +=3D x86/stress_save_restore_pf_test
>
> I'd rather go with just save_restore_pf_test, so that the focus of the te=
st is
> at the beginning of the file name.  E.g. I don't want to end up with a pi=
le of
> stress_xyz tests, because that makes tab completion a pain in the ass.
>
> I'd also be ok with save_restore_pf_stress_test, but I highly doubt we'll=
 end up
> with another save_restore_pf_test, i.e. I don't think the clarification i=
s needed.

I like having 'stress' in the name as I often find myself looking for
stress tests. We also have other stress tests, so I think
save_restore_pf_stress_test is good.

>
> Side topic, it probably makes sense to rename state_test to save_restore_=
state_test?

*opens state_test.c*
*sees comments at the top saying "Tests for vCPU state save/restore"*
*closes state_test.c*

Yes.

>
> > --- /dev/null
> > +++ b/tools/testing/selftests/kvm/x86/stress_save_restore_pf_test.c
> > @@ -0,0 +1,182 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +#include <stdio.h>
> > +#include <stdlib.h>
> > +#include <string.h>
> > +#include <errno.h>
> > +#include <sys/types.h>
> > +#include <time.h>
> > +#include <unistd.h>
> > +
> > +#include "test_util.h"
> > +#include "kvm_util.h"
> > +#include "processor.h"
> > +
> > +#define NR_ITERATIONS                500
> > +
> > +#define GOTO_PREV_LINE               "\033[A\r"
> > +#define PRINT_ITER(s, x)                                     \
> > +do {                                                         \
> > +     if (x =3D=3D 1)                                             \
> > +             printf(s "%d\n", x);                            \
> > +     else                                                    \
> > +             printf(GOTO_PREV_LINE s "%d\n", x);             \
>
> Oh c'mon.  I had to Google the escape sequence you're (heh, "you"), using=
 to
> understand this.

I named it GOTO_PREV_LINE specifically so that people don't have to
Google it. AI wanted to call it something like ESC_SEQ, this is a big
improvement :P

> Use a little creativity, and then the only magic escape sequence
> is the much more familiar carriage return.
>
>
>                 pr_info("\rSave+restore iterations: %d", count);
>         }
>         pr_info("\n");

I had something like this initially and I changed it, but I can't
remember exactly why. I *think* when there is a test failure the log
is messed up because we didn't print a line break after the last
"Save+restore.." message.

>
> > +     fflush(stdout);                                         \
> > +} while (0)
> > +
> > +#define PTRS_PER_PTE         512
> > +#define PXD_INDEX(vaddr, level)      (((vaddr) >> PG_LEVEL_SHIFT(level=
)) & (PTRS_PER_PTE - 1))
> > +
> > +#define TEST_MEM_BASE_GVA    0xc0000000ULL
> > +#define TEST_PGTABLE_GVA_OFFSET      0xd0000000ULL
> > +#define NR_TEST_ADDRS                PTRS_PER_PTE
>
> IMO, this macro does waaaaay more harm than good.  I'm looking at the usa=
ge and
> going "WTF is this is actually doing?".  Knowing that the test is mucking=
 with a
> page table's worth of PTEs is super useful information.

I initially thought that using PTRS_PER_PTE in guest_access_memory()
reads a bit weird, but looking at it now I agree.

>
>
> > +#define PATTERN                      0xabcdefabcdefabcdULL
> > +
> > +static u64 pte_present_mask;
> > +static u64 pte_huge_mask;
> > +
> > +static u64 expected_vaddr;
> > +static u64 guest_faults;
> > +
> > +static u64 *guest_get_pte(u64 vaddr)
> > +{
> > +     u64 pgtable_pa, pte;
> > +     u64 *pgtable;
> > +     int level;
> > +     bool la57;
> > +
> > +     la57 =3D !!(get_cr4() & X86_CR4_LA57);
>
> Superfluous use of !!, and of the local bool itself.  Just do
>
>         level =3D (get_cr4() & X86_CR4_LA57) ? PG_LEVEL_256T : PG_LEVEL_5=
12G;

Ack.

>
> > +     level =3D la57 ? PG_LEVEL_256T : PG_LEVEL_512G;
> > +
> > +     pgtable_pa =3D get_cr3() & PHYSICAL_PAGE_MASK;
> > +     for (; level > PG_LEVEL_4K; level--) {
> > +             pgtable =3D (u64 *)(pgtable_pa + TEST_PGTABLE_GVA_OFFSET)=
;
> > +             pte =3D pgtable[PXD_INDEX(vaddr, level)];
> > +             GUEST_ASSERT(pte & pte_present_mask);
> > +             GUEST_ASSERT(!(pte & pte_huge_mask));
> > +             pgtable_pa =3D PTE_GET_PA(pte);
> > +     }
> > +
> > +     pgtable =3D (u64 *)(pgtable_pa + TEST_PGTABLE_GVA_OFFSET);
> > +     return &pgtable[PXD_INDEX(vaddr, PG_LEVEL_4K)];
> > +}
>
> Hmm, I think we should put this helper in tools/testing/selftests/kvm/lib=
/x86/processor.c,
> and then provide a "struct kvm_mmu *guest_mmu;" that is automatically syn=
chronized
> to the guest during kvm_arch_vm_post_create().  I think vm->mmu is fully =
populated
> at that point?

Hmm yes, It is initialized in virt_pgd_alloc(), which is called in
____vm_alloc() on the first allocation, which I think will be in
kvm_vm_elf_load(). We can probably add an assertion to make sure that
holds true.

However, I think we can't really provide a full kvm_mmu. We can
synchronize the PTE masks, which I assume is what you mean here, but
then provide a 'pgd' which isn't really usable because guest PTEs
created by virt_map() (and friends) are not automatically sync'd to
the guest. I thought about doing that, but it isn't straightforward
because we cannot use direct mappings (see
https://lore.kernel.org/all/CAO9r8zNqYA6CACeGTVLcyj4bJ2XPAzEXL+y9tLuCU5Y-F=
=3DD-WA@mail.gmail.com/).

>
> Then this test should be able to use the PTE macros from x86/processor.h,=
 and
> future tests don't need to reinvent the wheel.

Maybe provide a kvm_mmu with pgd=3DNULL just a placeholder to use the PTE m=
asks?

>
> > +
> > +static void guest_pf_handler(struct ex_regs *regs)
> > +{
> > +     u64 fault_addr;
> > +     u64 *ptep;
> > +
> > +     fault_addr =3D get_cr2();
> > +     GUEST_ASSERT_EQ(fault_addr, READ_ONCE(expected_vaddr));
> > +
> > +     ptep =3D guest_get_pte(fault_addr);
> > +     GUEST_ASSERT(ptep);
> > +     GUEST_ASSERT(!(*ptep & pte_present_mask));
> > +
> > +     *ptep |=3D pte_present_mask;
> > +     invlpg(fault_addr);
>
> invlpg() should be unnecessary.  #PF is architecturally required to flush=
 TLB
> entries for the faulting address.  And since the PTEP is guaranteed to be=
 !PRESENT,
> the CPU can't have speculatively added a new TLB entry after the fault.

Yes, good catch.

>
> > +
> > +     guest_faults++;
> > +}
> > +
> > +static void guest_access_memory(void *arg)
> > +{
> > +     u64 vaddr, val;
> > +     int i =3D 0;
> > +
> > +     for (;; i++) {
>
> Dude.
>
>         for (i =3D 0; ; i++)
>
> > +             vaddr =3D TEST_MEM_BASE_GVA + (i % NR_TEST_ADDRS) * PAGE_=
SIZE;
> > +             WRITE_ONCE(expected_vaddr, vaddr);
> > +
> > +             /* Read to trigger #PF */
> > +             val =3D READ_ONCE(*(u64 *)vaddr);
> > +             GUEST_ASSERT_EQ(val, PATTERN);
> > +
> > +             /* Clear the present bit again so it faults next time */
> > +             *guest_get_pte(vaddr) &=3D ~pte_present_mask;
> > +             invlpg(vaddr);
> > +
> > +             GUEST_SYNC(guest_faults);
> > +     }
> > +}
> > +
> > +int main(int argc, char *argv[])
> > +{
> > +     struct kvm_x86_state *state;
> > +     int r, i, level, count =3D 0;
> > +     gpa_t gpa, pgtable_gpa;
> > +     struct kvm_vcpu *vcpu;
> > +     struct kvm_vm *vm;
> > +     struct ucall uc;
> > +     u64 *pgtable;
> > +     gva_t gva;
> > +     u64 pte;
> > +
> > +     vm =3D vm_create_with_one_vcpu(&vcpu, guest_access_memory);
> > +     vm_install_exception_handler(vm, PF_VECTOR, guest_pf_handler);
> > +
> > +     pte_present_mask =3D PTE_PRESENT_MASK(&vm->mmu);
> > +     pte_huge_mask =3D PTE_HUGE_MASK(&vm->mmu);
> > +     sync_global_to_guest(vm, pte_present_mask);
> > +     sync_global_to_guest(vm, pte_huge_mask);
> > +
> > +     /* Allocate a page and write the pattern to it */
>
> Oh, is that was this code is doing?  /s
>
> I love comments.  I hate useless comments.
>
> > +     gva =3D vm_alloc_page(vm);
> > +     *(u64 *)addr_gva2hva(vm, gva) =3D PATTERN;
> > +     gpa =3D addr_gva2gpa(vm, gva);
> > +
> > +     /*
> > +      * Map all virtual addresses to the pattern page and clear the pr=
esent
> > +      * bit such that guest accesses will cause a #PF.
> > +      */
> > +     for (i =3D 0; i < NR_TEST_ADDRS; i++) {
> > +             gva =3D TEST_MEM_BASE_GVA + i * getpagesize();
> > +             virt_pg_map(vm, gva, gpa);
> > +             *vm_get_pte(vm, gva) &=3D ~pte_present_mask;
> > +     }
> > +
> > +     /*
> > +      * Now create mappings for the page tables created above so that =
the
> > +      * guest #PF handler can walk them. All PTEs for test virtual add=
resses
> > +      * should lie on the same PTE page, so one page is mapped for eac=
h page
> > +      * table level.
> > +      *
> > +      * Use an offset for the GVA instead of creating identity mapping=
s to
> > +      * avoid collision with existing mappings at low GVAs (e.g. ELF).
> > +      */
> > +     pgtable_gpa =3D vm->mmu.pgd;
> > +     for (level =3D vm->mmu.pgtable_levels; level >=3D PG_LEVEL_4K; le=
vel--) {
> > +             virt_map(vm, pgtable_gpa + TEST_PGTABLE_GVA_OFFSET, pgtab=
le_gpa, 1);
> > +             pgtable =3D addr_gpa2hva(vm, pgtable_gpa);
> > +             pte =3D pgtable[PXD_INDEX(TEST_MEM_BASE_GVA, level)];
> > +             pgtable_gpa =3D PTE_GET_PA(pte);
> > +     }
> > +
> > +     while (count++ < NR_ITERATIONS) {
>
> Seriously.
>
>         for (i =3D 0; i < NR_ITERATIONS; i++)
>
> I'm a-ok with people using AI to help with development, but I still absol=
utely
> expect the result to follow kernel style and generally not be the stupide=
st way
> to write code.

To be honest I focused on iterating on the juicy bits (e.g. page table
walker) to make sure the code there is clean and readable, I probably
missed the "simple" things like loops :)
