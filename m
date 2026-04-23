Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 485B319C556;
	Thu, 23 Apr 2026 23:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776986995; cv=none; b=WxCXfaEND2Orw6rYzDNQJKea2kEiuE0E30Pgvq16V3R7kkSHANN+yqXJliS7PpcSoSm3MRdN3oe/tCEnDYY2c/GYYGzXpeCyTH3DFXkfODlKsuyMIzLTjNz5LpplSaw93P7oNmrq39WCVFkQ08GExHBFRzBz1EQNOz7sofG9l7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776986995; c=relaxed/simple;
	bh=gOPidmCRXi4BatggfBlyyOeeTP+Ab0sBqGHBfWVtsKY=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=BmZKkWf3pZ1WTpTN0Z9nQ3mjcJTgIvXElUay1uUNtotnVZ4LdGU6AEL7jQH8ALflsRxZdBXJH9xPr3QU5oa++lmpdm1/A2Xh1sMDq1pY6c4AlBEB52dCmIcOEpQ/qDLPW9gaMA/p8R2hdsjCNx8da7uIbW4jJ+yfEnMHNxEEEM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=HLDJ4wCo; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="HLDJ4wCo"
Received: from smtpclient.apple (c-24-130-165-117.hsd1.ca.comcast.net [24.130.165.117])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 63NMv41v1817216
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 23 Apr 2026 15:57:05 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 63NMv41v1817216
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2026032601; t=1776985026;
	bh=6W9iThonCmQx4dYJQMBQrxRDvx5m6/3f4NOKsNrPQtY=;
	h=Subject:From:In-Reply-To:Date:Cc:References:To:From;
	b=HLDJ4wCoo4s9yT6/jY1r0dRzac+I79VDuXWQMZALYLaA1rLx26oQvKzAu8NWhIA4P
	 mlQ4fToQSQzuWMCZ+8dkGRvAOr8SN1GjfzbF/rUVxpsIIBuHJmvsRJHL233mFDBdOr
	 trQemUeL+exgKteLWHqs6MsTvazeyI6UaZwWNJ5vSKIPWf5ddd1imZapq4oriYIfiA
	 BCsJ9YTsLaxho+VifoA0dLybi0Pjao1tHOwkENYRq8ZNuW/zH1+pHgYAWNQmvxs46Q
	 KgzGwiIELFy7obniVxhSEa51BLiGfQbloWCgZDLYJFL2upZLoM5C5XxRc0xjuWZoSx
	 +On4CPPn/mVlQ==
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.500.181\))
Subject: Re: [PATCH v9 00/22] Enable FRED with KVM VMX
From: Xin Li <xin@zytor.com>
In-Reply-To: <7f93eb25874ddd13a1ad6e3c75785f11041c8b7f.camel@infradead.org>
Date: Thu, 23 Apr 2026 15:56:54 -0700
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-doc@vger.kernel.org, Andrew Cooper <andrew.cooper3@citrix.com>,
        "Saenz Julienne, Nicolas" <nsaenz@amazon.es>, pbonzini@redhat.com,
        seanjc@google.com, corbet@lwn.net, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, luto@kernel.org, peterz@infradead.org,
        chao.gao@intel.com, hch@infradead.org, sohil.mehta@intel.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <DADE0E58-DD8A-4206-BF54-1DA87864117D@zytor.com>
References: <20251026201911.505204-1-xin@zytor.com>
 <7f93eb25874ddd13a1ad6e3c75785f11041c8b7f.camel@infradead.org>
To: David Woodhouse <dwmw2@infradead.org>
X-Mailer: Apple Mail (2.3864.500.181)



> On Apr 23, 2026, at 7:35=E2=80=AFAM, David Woodhouse =
<dwmw2@infradead.org> wrote:
>=20
> On Sun, 2025-10-26 at 13:18 -0700, Xin Li (Intel) wrote:
>> This patch set enables the Intel flexible return and event delivery
>> (FRED) architecture with KVM VMX to allow guests to utilize FRED.
>=20
> This could do with having a *lot* of KVM selftests.

Hi David,

Thanks, I will integrate your tests into this FRED test:
https://lore.kernel.org/kvm/20240207172646.3981-26-xin3.li@intel.com/


>=20
> Here's one to get you started (untested as I haven't found suitable
> hardware to test it on).

Same here for me now :(

>=20
> =46rom bd465aabebcb124e09a26fe9f4c861354febabe4 Mon Sep 17 00:00:00 =
2001
> From: David Woodhouse <dwmw@amazon.co.uk>
> Date: Thu, 23 Apr 2026 15:20:11 +0100
> Subject: [PATCH] KVM: selftests: Add FRED event type classification =
test
>=20
> Test that software-generated events deliver the correct FRED event
> type in the FRED stack frame.
>=20
> In FRED mode, the CPU pushes event metadata including the event type
> into the FRED stack frame. Different instruction types should produce
> different event types:
>  - ICEBP (INT1): EVENT_TYPE_PRIV_SWEVT (5)
>  - INT3:         EVENT_TYPE_SWEXC (6)
>  - INT n:        EVENT_TYPE_SWINT (4)
>=20
> The test sets up a guest in FRED mode by enabling CR4.FRED and
> configuring the FRED MSRs, with a hand-written FRED entry point that
> extracts the event type from the FRED SS field. It exercises each
> software event type and verifies the classification is correct.
>=20
> Requires KVM guest FRED support (the FRED KVM VMX series) and
> hardware FRED support. Skips if either is unavailable.
>=20
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> ---
> tools/testing/selftests/kvm/Makefile.kvm      |   1 +
> .../selftests/kvm/x86/int1_fred_test.c        | 225 ++++++++++++++++++
> 2 files changed, 226 insertions(+)
> create mode 100644 tools/testing/selftests/kvm/x86/int1_fred_test.c
>=20
> diff --git a/tools/testing/selftests/kvm/Makefile.kvm =
b/tools/testing/selftests/kvm/Makefile.kvm
> index 148d427ff24b..62e76617f82f 100644
> --- a/tools/testing/selftests/kvm/Makefile.kvm
> +++ b/tools/testing/selftests/kvm/Makefile.kvm
> @@ -74,6 +74,7 @@ TEST_GEN_PROGS_x86 +=3D x86/feature_msrs_test
> TEST_GEN_PROGS_x86 +=3D x86/exit_on_emulation_failure_test
> TEST_GEN_PROGS_x86 +=3D x86/fastops_test
> TEST_GEN_PROGS_x86 +=3D x86/fix_hypercall_test
> +TEST_GEN_PROGS_x86 +=3D x86/int1_fred_test
> TEST_GEN_PROGS_x86 +=3D x86/hwcr_msr_test
> TEST_GEN_PROGS_x86 +=3D x86/hyperv_clock
> TEST_GEN_PROGS_x86 +=3D x86/hyperv_cpuid
> diff --git a/tools/testing/selftests/kvm/x86/int1_fred_test.c =
b/tools/testing/selftests/kvm/x86/int1_fred_test.c
> new file mode 100644
> index 000000000000..7ffb54b56047
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/x86/int1_fred_test.c
> @@ -0,0 +1,225 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Test FRED event type classification for software-generated events.
> + *
> + * In FRED mode, the CPU pushes event metadata including the event =
type
> + * into the FRED stack frame SS field. This test verifies the correct
> + * event type for:
> + *   - ICEBP (INT1, opcode 0xF1): EVENT_TYPE_PRIV_SWEXC (5)
> + *   - INT3 (opcode 0xCC):        EVENT_TYPE_SWEXC (6)
> + *   - INT n (opcode 0xCD nn):    EVENT_TYPE_SWINT (4)
> + *
> + * The FRED stack page is evicted via MADV_DONTNEED before each test
> + * to also exercise EPT/NPT fault handling during FRED frame push.
> + *
> + * This test requires KVM guest FRED support and hardware FRED =
support.
> + * It will skip if either is unavailable.
> + */
> +#include <stdint.h>
> +#include <string.h>
> +#include <sys/mman.h>
> +
> +#include "test_util.h"
> +#include "kvm_util.h"
> +#include "processor.h"
> +
> +/* FRED: CPUID.(EAX=3D7,ECX=3D1):EAX bit 17 */
> +#define X86_FEATURE_FRED KVM_X86_CPU_FEATURE(7, 1, EAX, 17)
> +
> +/* FRED MSRs */
> +#define MSR_IA32_FRED_RSP0 0x1cc
> +#define MSR_IA32_FRED_STKLVLS 0x1d0
> +#define MSR_IA32_FRED_CONFIG 0x1d4
> +
> +/* FRED event types (from arch/x86/include/asm/trapnr.h) */
> +#define EVENT_TYPE_SWINT 4 /* INT n */
> +#define EVENT_TYPE_PRIV_SWEXC 5 /* INT1 (ICEBP) */
> +#define EVENT_TYPE_SWEXC 6 /* INTO, INT3 */
> +
> +/* FRED SS field layout */
> +#define FRED_SS_TYPE_SHIFT 48
> +#define FRED_SS_TYPE_MASK (0xfULL << FRED_SS_TYPE_SHIFT)
> +#define FRED_SS_VECTOR_SHIFT 32
> +#define FRED_SS_VECTOR_MASK (0xffULL << FRED_SS_VECTOR_SHIFT)
> +
> +/* CR4.FRED (bit 32) */
> +#define X86_CR4_FRED (1ULL << 32)
> +
> +/* Guest memory layout */
> +#define FRED_STACK_GPA 0xc0000000ULL
> +#define FRED_STACK_SIZE PAGE_SIZE
> +
> +/*
> + * FRED stack frame as pushed by the CPU on event delivery.
> + * Layout from low address (RSP) to high address:
> + *
> + *   RSP+0x00: error code
> + *   RSP+0x08: RIP (return address)
> + *   RSP+0x10: CS (with auxiliary info in upper bits)
> + *   RSP+0x18: RFLAGS
> + *   RSP+0x20: RSP (original)
> + *   RSP+0x28: SS (with event type/vector in upper bits)
> + */
> +struct fred_stack_frame {
> + uint64_t error_code;
> + uint64_t rip;
> + uint64_t cs;
> + uint64_t rflags;
> + uint64_t rsp;
> + uint64_t ss;
> +};
> +
> +/* Shared result area */
> +static volatile uint64_t fred_ss_value;
> +static volatile uint64_t fred_saved_rip;
> +static volatile bool fred_handler_called;
> +
> +static void __used fred_handler(struct fred_stack_frame *frame)
> +{
> + fred_ss_value =3D frame->ss;
> + fred_saved_rip =3D frame->rip;
> + fred_handler_called =3D true;
> +}
> +
> +/*
> + * FRED entry points. MSR_IA32_FRED_CONFIG points to the page-aligned
> + * base. Ring 3 events enter at base+0, ring 0 events at base+0x100.
> + * Since ICEBP executes in ring 0, the CPU enters at fred_entrypoint
> + * + 256 =3D fred_entrypoint_kernel.
> + */
> +extern void fred_entrypoint(void);
> +
> +asm(
> + ".pushsection .text\n"
> + ".global fred_entrypoint\n"
> + ".balign 4096\n"
> +"fred_entrypoint:\n"
> + /* Ring 3 entry =E2=80=94 unused, no userspace in this test */
> + "ud2\n"
> + /* Pad to +256 for ring 0 entry */
> + ".org fred_entrypoint + 256, 0xcc\n"
> +"fred_entrypoint_kernel:\n"
> + "movq %rsp, %rdi\n"
> + "call fred_handler\n"
> + ".byte 0xf2, 0x0f, 0x01, 0xca\n" /* ERETS */
> + ".popsection\n"
> +);
> +
> +static void check_fred_event(uint64_t expected_rip, uint8_t =
expected_vector,
> +     uint8_t expected_type, const char *name)
> +{
> + uint64_t event_type, event_vector;
> +
> + GUEST_ASSERT(fred_handler_called);
> + GUEST_ASSERT_EQ(fred_saved_rip, expected_rip);
> +
> + event_type =3D (fred_ss_value & FRED_SS_TYPE_MASK) >> =
FRED_SS_TYPE_SHIFT;
> + event_vector =3D (fred_ss_value & FRED_SS_VECTOR_MASK) >> =
FRED_SS_VECTOR_SHIFT;
> +
> + GUEST_ASSERT_EQ(event_vector, expected_vector);
> + GUEST_ASSERT_EQ(event_type, expected_type);
> +}
> +
> +static void guest_code(void)
> +{
> + uint64_t expected_rip;
> +
> + /*
> + * Enable FRED:
> + *  1. Set MSR_IA32_FRED_CONFIG to our entry point
> + *  2. Set MSR_IA32_FRED_RSP0 to our FRED stack
> + *  3. Set MSR_IA32_FRED_STKLVLS (all events use stack level 0)
> + *  4. Set CR4.FRED
> + */
> + wrmsr(MSR_IA32_FRED_CONFIG, (uint64_t)fred_entrypoint);
> + wrmsr(MSR_IA32_FRED_RSP0, FRED_STACK_GPA + FRED_STACK_SIZE);
> + wrmsr(MSR_IA32_FRED_STKLVLS, 0);
> +
> + {
> + uint64_t cr4;
> + asm volatile("mov %%cr4, %0" : "=3Dr"(cr4));
> + cr4 |=3D X86_CR4_FRED;
> + asm volatile("mov %0, %%cr4" :: "r"(cr4));
> + }
> +
> + /* Test 1: ICEBP (INT1) =E2=80=94 should be EVENT_TYPE_PRIV_SWEXC =
(5) */
> + fred_handler_called =3D false;
> + asm volatile("lea 1f(%%rip), %0\n\t"
> +     ".byte 0xf1\n\t"
> +     "1:" : "=3Dr"(expected_rip) :: "memory");
> + check_fred_event(expected_rip, DB_VECTOR, EVENT_TYPE_PRIV_SWEXC,
> + "ICEBP");
> + GUEST_SYNC(0);
> +
> + /* Test 2: INT3 =E2=80=94 should be EVENT_TYPE_SWEXC (6) */
> + fred_handler_called =3D false;
> + asm volatile("lea 1f(%%rip), %0\n\t"
> +     "int3\n\t"
> +     "1:" : "=3Dr"(expected_rip) :: "memory");
> + check_fred_event(expected_rip, BP_VECTOR, EVENT_TYPE_SWEXC, "INT3");
> + GUEST_SYNC(1);
> +
> + /* Test 3: INT $0x20 =E2=80=94 should be EVENT_TYPE_SWINT (4) */
> + fred_handler_called =3D false;
> + asm volatile("lea 1f(%%rip), %0\n\t"
> +     "int $0x20\n\t"
> +     "1:" : "=3Dr"(expected_rip) :: "memory");
> + check_fred_event(expected_rip, 0x20, EVENT_TYPE_SWINT, "INT $0x20");
> + GUEST_SYNC(2);
> +}
> +
> +static const char * const test_names[] =3D {
> + [0] =3D "ICEBP (EVENT_TYPE_PRIV_SWEXC)",
> + [1] =3D "INT3 (EVENT_TYPE_SWEXC)",
> + [2] =3D "INT $0x20 (EVENT_TYPE_SWINT)",
> +};
> +
> +int main(int argc, char *argv[])
> +{
> + struct kvm_vcpu *vcpu;
> + struct kvm_vm *vm;
> + struct ucall uc;
> + unsigned int nr_pages;
> + void *fred_stack_hva;
> + int test;
> +
> + TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_FRED));
> +
> + pr_info("Testing FRED event types with EPT fault on stack\n");
> +
> + vm =3D vm_create_with_one_vcpu(&vcpu, guest_code);
> +
> + /* Map the FRED stack page */
> + nr_pages =3D vm_calc_num_guest_pages(VM_MODE_DEFAULT, =
FRED_STACK_SIZE);
> + vm_userspace_mem_region_add(vm, VM_MEM_SRC_ANONYMOUS,
> +    FRED_STACK_GPA, 1, nr_pages, 0);
> + virt_map(vm, FRED_STACK_GPA, FRED_STACK_GPA, nr_pages);
> + fred_stack_hva =3D addr_gpa2hva(vm, FRED_STACK_GPA);
> +
> + for (test =3D 0; test < ARRAY_SIZE(test_names); test++) {
> + /*
> + * Evict the FRED stack page so the CPU takes an EPT/NPT
> + * violation when pushing the FRED frame. KVM must handle
> + * the fault, map the page, and reinject the event.
> + */
> + madvise(fred_stack_hva, FRED_STACK_SIZE, MADV_DONTNEED);
> +
> + vcpu_run(vcpu);
> + TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_IO);
> +
> + switch (get_ucall(vcpu, &uc)) {
> + case UCALL_ABORT:
> + REPORT_GUEST_ASSERT(uc);
> + break;
> + case UCALL_SYNC:
> + TEST_ASSERT_EQ(uc.args[1], test);
> + pr_info("  %s: PASSED\n", test_names[test]);
> + break;
> + default:
> + TEST_FAIL("Unexpected ucall");
> + }
> + }
> +
> + kvm_vm_free(vm);
> + return 0;
> +}
> --=20
> 2.43.0
>=20
>=20
>=20
>=20

