Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC39D221275
	for <kvm@vger.kernel.org>; Fri, 22 May 2026 22:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779489210; cv=none; b=DabHIxBdxOGu5XCamqh/occNp/e3SwJXEDeNAi4mAbCP+HP5hD12wETssJtX+uFllZukhg0l34bcdGaDKZgJO0a2X2DsTP8S3WkewU05I51LFxtYevhUmQfwfDBeikHx74yTW2UV5KlgxiifVjTyhniMfUl3wVMllRn19Vn4ACg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779489210; c=relaxed/simple;
	bh=9ZaGNBLMQL68QaEj0gAWT/Eargnq7NvJTMlnKirB1Tw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uX1yHjjv5byu60hmpPzkXPudb9UaDJhpUXNw2lkXICMwxs5vnFaxqLUhTZ+UkGsuNAX29QIq3DsNPvM8G7OwBBP+CDYJ3nyjYX1GemySHGb27c0Adi7b5hq5eU+Yl2mtC2KZ7vzO0trQqLvyhrqRkRF6wIPXQGvKaqHIAaXTiGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vLGtT4c4; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vLGtT4c4"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c8276c91addso4345398a12.2
        for <kvm@vger.kernel.org>; Fri, 22 May 2026 15:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779489208; x=1780094008; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kB3CpF1Jlmxz+wPpxElHcqfg37b8qDlRgrbghj+MTcg=;
        b=vLGtT4c42XuY8UavowDVleFSjcfxHHecQaDP0Q1vf5O7YFEWHzFAKCmKOV+xlpVGqm
         +tu9L9XnAAmBSB5v2tu5k3046zDWAYKphJId0R1hrRmbPr3ZSWvaeJZ4PtJ4cE4ihewe
         P/MMof4iLsxCfFdR6o4Ud05tTxdHkEpTY14AnBxJHIpXaaT5M6NaG+R79jJMUcrfuzBk
         mN6YLnzUyzPibMRO5X2X+9077aD2g0UoAGGZ3SlJKVLljrfyvPzj9eM1K/OhB2Q9cv6Z
         ZUHX941lpvkM0ViU8Hqyt1T5oIE0Fa9AQoJ3kKqeRhV6v18LUFb8q15Jy9wUKBArsWCd
         JxqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779489208; x=1780094008;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kB3CpF1Jlmxz+wPpxElHcqfg37b8qDlRgrbghj+MTcg=;
        b=K5qIDZASy2G7gPLZeDk/l5h6sDGldvzdllRMu8Xof6teJynvaZrv0yX8aJ+dSVFkKA
         cINZ95qMj08PGAOF0uCR2AJ8TnWfYnNKJ5opKSwBaungix1Ow66llyob/D1/rKBR/a61
         OhihCYeWSkkMfij1aaGkKd1zP8NTgxIc+r/v29i5g3fp0EvOeBmgjAQ/qF74qYjisHLI
         sVSpMhU6YpHiPMcKgvCQ5yVpgaZ+OmrJ4oyILJDFjzAEVPbrNk5qVoosbGihJnMEC45I
         AknP+BzHnQeJbZergtGT/PcNwa6a7DmHsw0db2PfSiovEDyLUEesA+2g2rpiZ7CQOLO0
         cRxw==
X-Forwarded-Encrypted: i=1; AFNElJ9c7wo1htq9GB+YvJn3hSG/4u2h+uLppN3nUo03sIad8F1AgmUSSShmltsqYq/vd2IzQwY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+TLMVPVIS24TCvKzmOQHbJBOtjIxVBCKDxqyLKkuflojWEluO
	UMnR9d/Q5nomQvkBqBtE8gSXpBigmbVlEXkRzgtooYDCb1Gn4NPvQYhvGxgmrjLhxlM8oKSrp9w
	6y+Gu4A==
X-Received: from pgbcb7.prod.google.com ([2002:a05:6a02:707:b0:c82:7df9:8c1d])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:3954:b0:39f:8b01:d968
 with SMTP id adf61e73a8af0-3b328cab982mr5401284637.11.1779489207796; Fri, 22
 May 2026 15:33:27 -0700 (PDT)
Date: Fri, 22 May 2026 15:33:27 -0700
In-Reply-To: <20260313071033.4153209-5-chengkev@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260313071033.4153209-1-chengkev@google.com> <20260313071033.4153209-5-chengkev@google.com>
Message-ID: <ahDZt1fT3vh-S3Yn@google.com>
Subject: Re: [PATCH V3 4/4] KVM: selftests: Add nested page fault injection test
From: Sean Christopherson <seanjc@google.com>
To: Kevin Cheng <chengkev@google.com>
Cc: pbonzini@redhat.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	yosry@kernel.org
Content-Type: text/plain; charset="us-ascii"

On Fri, Mar 13, 2026, Kevin Cheng wrote:
> Add a test that exercises nested page fault injection during L2
> execution. L2 executes I/O string instructions (OUTSB/INSB) that access
> memory restricted in L1's nested page tables (NPT/EPT), triggering a
> nested page fault that L0 must inject to L1.
> 
> The test supports both AMD SVM (NPF) and Intel VMX (EPT violation) and
> verifies that:
>   - The exit reason is an NPF/EPT violation
>   - The access type and permission bits are correct
>   - The faulting GPA is correct
> 
> Three test cases are implemented:
>   - Unmap the final data page (final translation fault, OUTSB read)
>   - Unmap a PT page (page walk fault, OUTSB read)
>   - Write-protect the final data page (protection violation, INSB write)
>   - Write-protect a PT page (protection violation on A/D update, OUTSB
>     read)
> 
> Signed-off-by: Kevin Cheng <chengkev@google.com>
> ---
>  tools/testing/selftests/kvm/Makefile.kvm      |   1 +
>  .../selftests/kvm/x86/nested_npf_test.c       | 374 ++++++++++++++++++
>  2 files changed, 375 insertions(+)
>  create mode 100644 tools/testing/selftests/kvm/x86/nested_npf_test.c
> 
> diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
> index 3d372d78a275..9308e6100f27 100644
> --- a/tools/testing/selftests/kvm/Makefile.kvm
> +++ b/tools/testing/selftests/kvm/Makefile.kvm
> @@ -94,6 +94,7 @@ TEST_GEN_PROGS_x86 += x86/nested_dirty_log_test
>  TEST_GEN_PROGS_x86 += x86/nested_emulation_test
>  TEST_GEN_PROGS_x86 += x86/nested_exceptions_test
>  TEST_GEN_PROGS_x86 += x86/nested_invalid_cr3_test
> +TEST_GEN_PROGS_x86 += x86/nested_npf_test

NPF is AMD specific.  Call it nested_tdp_fault_test.

>  TEST_GEN_PROGS_x86 += x86/nested_set_state_test
>  TEST_GEN_PROGS_x86 += x86/nested_tsc_adjust_test
>  TEST_GEN_PROGS_x86 += x86/nested_tsc_scaling_test
> diff --git a/tools/testing/selftests/kvm/x86/nested_npf_test.c b/tools/testing/selftests/kvm/x86/nested_npf_test.c
> new file mode 100644
> index 000000000000..7725e5dc3a38
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/x86/nested_npf_test.c
> @@ -0,0 +1,374 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2025, Google, Inc.
> + */
> +
> +#include "test_util.h"
> +#include "kvm_util.h"
> +#include "processor.h"
> +#include "svm_util.h"
> +#include "vmx.h"
> +
> +#define L2_GUEST_STACK_SIZE 64
> +
> +#define EPT_VIOLATION_ACC_READ		BIT(0)
> +#define EPT_VIOLATION_ACC_WRITE		BIT(1)
> +#define EPT_VIOLATION_ACC_INSTR		BIT(2)
> +#define EPT_VIOLATION_PROT_READ		BIT(3)
> +#define EPT_VIOLATION_PROT_WRITE	BIT(4)
> +#define EPT_VIOLATION_PROT_EXEC		BIT(5)
> +#define EPT_VIOLATION_GVA_IS_VALID	BIT(7)
> +#define EPT_VIOLATION_GVA_TRANSLATED	BIT(8)

Put these in tools/testing/selftests/kvm/include/x86/processor.h.

> +enum test_type {
> +	TEST_FINAL_PAGE_UNMAPPED,	    /* Final data page not present */
> +	TEST_PT_PAGE_UNMAPPED,		    /* Page table page not present */
> +	TEST_FINAL_PAGE_WRITE_PROTECTED,    /* Final data page read-only */
> +	TEST_PT_PAGE_WRITE_PROTECTED,	    /* Page table page read-only */
> +};
> +
> +static vm_vaddr_t l2_test_page;
> +static void (*l2_entry)(void);
> +
> +#define TEST_IO_PORT 0x80
> +#define TEST1_VADDR 0x8000000ULL
> +#define TEST2_VADDR 0x10000000ULL
> +#define TEST3_VADDR 0x18000000ULL
> +#define TEST4_VADDR 0x20000000ULL
> +
> +/*
> + * L2 executes OUTS reading from l2_test_page, triggering a nested page
> + * fault on the read access.
> + */
> +static void l2_guest_code_outs(void)
> +{
> +	asm volatile("outsb" ::"S"(l2_test_page), "d"(TEST_IO_PORT) : "memory");
> +	GUEST_FAIL("L2 should not reach here");
> +}
> +
> +/*
> + * L2 executes INS writing to l2_test_page, triggering a nested page
> + * fault on the write access.
> + */
> +static void l2_guest_code_ins(void)
> +{
> +	asm volatile("insb" ::"D"(l2_test_page), "d"(TEST_IO_PORT) : "memory");
> +	GUEST_FAIL("L2 should not reach here");
> +}
> +
> +static void l1_vmx_code(struct vmx_pages *vmx, uint64_t expected_fault_gpa,
> +			 uint64_t test_type)
> +{
> +	unsigned long l2_guest_stack[L2_GUEST_STACK_SIZE];
> +	uint64_t exit_qual;
> +
> +	GUEST_ASSERT(vmx->vmcs_gpa);
> +	GUEST_ASSERT(prepare_for_vmx_operation(vmx));
> +	GUEST_ASSERT(load_vmcs(vmx));
> +
> +	prepare_vmcs(vmx, l2_entry, &l2_guest_stack[L2_GUEST_STACK_SIZE]);
> +
> +	GUEST_ASSERT(!vmlaunch());
> +
> +	/* Verify we got an EPT violation exit */
> +	__GUEST_ASSERT(vmreadz(VM_EXIT_REASON) == EXIT_REASON_EPT_VIOLATION,
> +		       "Expected EPT violation (0x%x), got 0x%lx",
> +		       EXIT_REASON_EPT_VIOLATION,
> +		       vmreadz(VM_EXIT_REASON));
> +
> +	exit_qual = vmreadz(EXIT_QUALIFICATION);
> +
> +	switch (test_type) {
> +	case TEST_FINAL_PAGE_UNMAPPED:
> +		/* Read access, final translation, page not present */

These comments aren't super helpful, because for the most part the information
is redundant with respect to "test_type.  E.g. it's pretty darn easy to see this
is a !PRESENT fault on the final page.

And what _is_ notable is that TDP page walks are *always* read+write, and that
NPT walks are *always* USER (see below for why this test doesn't get false failures).

> +		__GUEST_ASSERT(exit_qual & EPT_VIOLATION_ACC_READ,
> +			       "Expected ACC_READ set, exit_qual 0x%lx",
> +			       exit_qual);
> +		__GUEST_ASSERT(exit_qual & EPT_VIOLATION_GVA_IS_VALID,
> +			       "Expected GVA_IS_VALID set, exit_qual 0x%lx",
> +			       exit_qual);
> +		__GUEST_ASSERT(exit_qual & EPT_VIOLATION_GVA_TRANSLATED,
> +			       "Expected GVA_TRANSLATED set, exit_qual 0x%lx",
> +			       exit_qual);

I appreciate trying to make life easier for debuggers, but this goes a bit too
far.  Checking only select bits also reduces coverage, e.g. KVM could generate
completely bogus information, but this test wouldn't detect it.

IMO, this is much more readable, and just as easy to debug:

	/*
	 * Note, EPT page table accesses are always read+write, e.g. so that
	 * the CPU can do A/D updates at-will.
	 */
	switch (test_type) {
	case TEST_FINAL_PAGE_UNMAPPED:
		GUEST_ASSERT_EXIT_QUAL(exit_qual, EPT_VIOLATION_ACC_READ |
						  EPT_VIOLATION_GVA_IS_VALID |
						  EPT_VIOLATION_GVA_TRANSLATED);
		break;
	case TEST_PT_PAGE_UNMAPPED:
		GUEST_ASSERT_EXIT_QUAL(exit_qual, EPT_VIOLATION_ACC_READ |
						  EPT_VIOLATION_ACC_WRITE |
						  EPT_VIOLATION_GVA_IS_VALID);
		break;
	case TEST_FINAL_PAGE_WRITE_PROTECTED:
		GUEST_ASSERT_EXIT_QUAL(exit_qual, EPT_VIOLATION_ACC_WRITE |
						  EPT_VIOLATION_PROT_READ |
						  EPT_VIOLATION_PROT_EXEC |
						  EPT_VIOLATION_GVA_IS_VALID |
						  EPT_VIOLATION_GVA_TRANSLATED);
		break;
	case TEST_PT_PAGE_WRITE_PROTECTED:
		GUEST_ASSERT_EXIT_QUAL(exit_qual, EPT_VIOLATION_ACC_READ |
						  EPT_VIOLATION_ACC_WRITE |
						  EPT_VIOLATION_PROT_READ |
						  EPT_VIOLATION_PROT_EXEC |
						  EPT_VIOLATION_GVA_IS_VALID);
		break;
	}

and then for NPT:

	/*
	 * Note, without GMET enabled, NPT walks are always user accesses.  And
	 * like EPT, page table accesses are always read+write.
	 */
	switch (test_type) {
	case TEST_FINAL_PAGE_UNMAPPED:
		GUEST_ASSERT_NPF_EC(exit_info_1, PFERR_USER_MASK |
						 PFERR_GUEST_FINAL_MASK);
		break;
	case TEST_PT_PAGE_UNMAPPED:
		GUEST_ASSERT_NPF_EC(exit_info_1, PFERR_WRITE_MASK |
						 PFERR_USER_MASK |
						 PFERR_GUEST_PAGE_MASK);
		break;
	case TEST_FINAL_PAGE_WRITE_PROTECTED:
		GUEST_ASSERT_NPF_EC(exit_info_1, PFERR_PRESENT_MASK |
						 PFERR_WRITE_MASK |
						 PFERR_USER_MASK |
						 PFERR_GUEST_FINAL_MASK);
		break;
	case TEST_PT_PAGE_WRITE_PROTECTED:
		GUEST_ASSERT_NPF_EC(exit_info_1, PFERR_PRESENT_MASK |
						 PFERR_WRITE_MASK |
						 PFERR_USER_MASK |
						 PFERR_GUEST_PAGE_MASK);
		break;
	}
