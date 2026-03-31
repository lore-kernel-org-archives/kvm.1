Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0911466B49
	for <kvm@vger.kernel.org>; Tue, 31 Mar 2026 22:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774996404; cv=pass; b=IYHMYdvzAYF+uv2f7Nu/cpMgDDToesTyszXD0pAvH4efd2L2Rk+nT1ANTIIaYaOSXS+poDyEOkcAa+2Xoqs4nK9psK4KwIVxL4YjvZjKtC8Ki12ACk7Hd1CJsq01yfCNV9CIKMVpCqWLVWU7pKGJ+b1q9IVdV4kr2v6SG695E2w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774996404; c=relaxed/simple;
	bh=kSoKfcCAm8/gTpfZf+vjCSevgnCCnOACbGJyXLFwyWE=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rn74CP/Gr+Fx4DoDPZeKb56Q7AyuZhnMyzqeGI5eeSNWyRiqfZab/nCXhYs7uK9iS1HNwKBvtWu0adg9aTIVpxQh/77KcW0hLo6Sa4nswqTW48Ll9RzkqcMg7bXPVFDcp+NCTXz8bdZt1+OLFvdJTqcTcmlcmdiqLhLVAcqnGQ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uKt+Bh2t; arc=pass smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uKt+Bh2t"
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-6055a0414d7so365445137.2
        for <kvm@vger.kernel.org>; Tue, 31 Mar 2026 15:33:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774996402; cv=none;
        d=google.com; s=arc-20240605;
        b=gDWqG0Fk5gXaQ4onpp/3m3+Yv4tSyXaWFDLURaOcc9ePabNj8C3D+T94i+N6uEf8LX
         +TlYwzaY+OZE8SGQDJJJtXWwJOktMOnHL3gMRxW2tOYE4EgrfbsrveWvVJJ5L69jDb3C
         UeI+v3qsJDkiXGI3kHHQ9Lwk7MGq4oEjziR65Z6dJQhIVpJ2cT0CT3xHZF+iix031qk7
         iGXC/3UDObzguW8Oi/byrOhdyzT2gUEs4mV0cdYZyVftdyqmMxhpDGuYxKzZms8mEEtb
         5x1BdKUMrvN/nrBFoyMBPf08ahDTJl62KCZBfA7IiMQtaEP/MoBg1hAFKQ/aTb6w2yOj
         ssYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=t/sx/qLvnRMy19+TBDpUXhwm2KN2kFi93SeLbyugb9I=;
        fh=Hx326Hzy9KYMhk7q6x4ZbaZ1ppfuDvFJSvq+od9WOXk=;
        b=RGZolxV4u7BIGWg4Uuln7c8SsLvYeuFlqqJBlTs/Wsuxz381lI38xBgSjRaIb0varv
         hECLWowEaHWQMiWhQjgUTvVqxy+FkUlWcuFZDtwdmtG6GR9KjwV/4AHD3uXSFf73BPxu
         maDQ9T2HEOeSk3sV+uZ6xJpxriDcDRFRY1E6saGHnxGTogm83xyYWLtb/glG/6y6d5ki
         S7S7kSHY8554zTpVF7us7eN2nPJopIqhmX98wLbMzrnVr6C15gaw/cNlEYSfTQ/teGxM
         i4vcFUnXkWgSgD6kmAa8djYOKyBty5oThBHIZRxs+GdfBVhZCIfIw4Ek/U6+zMJCSNLQ
         7mgw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774996402; x=1775601202; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=t/sx/qLvnRMy19+TBDpUXhwm2KN2kFi93SeLbyugb9I=;
        b=uKt+Bh2t8W0KIuGpKieV3CyzODcnUOjEe/KZO6PjVMja/txD5rmq3nV1ok2y8movFk
         ZhP4wMkyUTQJoj37qC+Ak512OaQ2noS0xnn6lCeCzXwslvXWn2ZvmmuKA99rYo9xKBaR
         DIJjygL50EcqWIVokjljUtkG+DeY+IDjg+pycDSGu+OjjkZ1Rki3eIJyHMw52PlUFeXi
         54dz78gHqvn+J1utxFsHu8ojBPpaMzP0u2lXIOGkU/pcsE28Yr8J26ed1I2r9KwNXlHR
         KtesoQnN4Ng3JJxPlUPoxLeuvaRC5ifeRSw2acdXhg4IEHZ+7YtIK2C2myC8V9ENlxeR
         AbMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774996402; x=1775601202;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t/sx/qLvnRMy19+TBDpUXhwm2KN2kFi93SeLbyugb9I=;
        b=WdbFWGKXW/nexAurRFACYOURMmQxP8HrsA5pCQOW2H89w3C3l5yyPoPwoVsXGw/M3o
         O1FdeVR0p/dzzBcTsN+AUFerrck9BsYWTXqwsJLTKnM/dxmI+mZ3L5OEzmMnZBUjfsr6
         WHC7cnI1weDvrR2xgej8uK76kJRI+48rT/kFd6qWocK5JgH5TebHGu2NER/MmhqMsh8r
         F2jwp2qA/3vLIkjMIoOTj6/n0Y8DlVCv+cPEnmDxDjcGWFLi47fBeiBC9o30X1OvhkTt
         RqximveAZJR52j75SFYm9fMEFiEYT/l9h2rlwv2JaSgBMmlDAwPOqRMRaTXNR8qTnJTg
         vPIg==
X-Gm-Message-State: AOJu0YyMIOmqwofJ07I0ybuBxV/1mtsZrkGOz9HG6w8qLJ6LXZMpp35w
	7kU234lQ3qBXxCQoN4mB0Tk5bZ/8t3qnwAJu1zWRZB10IGw5qR+sy3Lr0RZHj2owJdFzl5O/2r5
	BS94rE9Nh3FZyEVj+QuuUMrQtNHbdk5I0Cg/xEG8a
X-Gm-Gg: ATEYQzzP16yFhmmSUjNSXgS0nnNDyN54ZERXJgUXpAK9E6jskeuMAaeVhKWJHbalNb4
	F6P6z+PdhTuQMUM09c7QJPMVIiEtE9LAKDozA0VgpVSMA7hMcVU0scBexw5XxzIuYw7TM1BtP7z
	KwiJ3f+KmE+OwuZZYjxRS0h6BqjRaoHyOH6VnkU20Bt9ZRur2+UzGjzHLWjhwHucEEmhU+9MGlv
	PKry6x330HLikCKdkizHkEn0aB8tHCyBwRsYfSJaQY5cq7U/ROQQlNFrVmVar0N2IqLLHd87LCr
	BsXj3xrygw/jbXJda2nJ5I8DW0W5a5Ix6y9gwLhnQEWVnzX5FlkBnEkkT5+i+T6On9SflQ==
X-Received: by 2002:a05:6102:6884:b0:605:23e7:30a4 with SMTP id
 ada2fe7eead31-605680faeeemr406939137.27.1774996401056; Tue, 31 Mar 2026
 15:33:21 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 31 Mar 2026 15:33:20 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 31 Mar 2026 15:33:19 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <20260326-gmem-inplace-conversion-v4-25-e202fe950ffd@google.com>
References: <20260326-gmem-inplace-conversion-v4-0-e202fe950ffd@google.com> <20260326-gmem-inplace-conversion-v4-25-e202fe950ffd@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 31 Mar 2026 15:33:19 -0700
X-Gm-Features: AQROBzAKk6Utt-XQ0U1-IucoHPkAd_A6svVmQ0C1L4caLlaffOGn0MEaGSZG1lo
Message-ID: <CAEvNRgE6Tn81Yddgbjqs-gs491NzpppjbDHKzpmdPCxgSPeUPQ@mail.gmail.com>
Subject: Re: [PATCH RFC v4 25/44] KVM: selftests: Test basic single-page
 conversion flow
To: aik@amd.com, andrew.jones@linux.dev, binbin.wu@linux.intel.com, 
	brauner@kernel.org, chao.p.peng@linux.intel.com, david@kernel.org, 
	ira.weiny@intel.com, jmattson@google.com, jroedel@suse.de, 
	jthoughton@google.com, michael.roth@amd.com, oupton@kernel.org, 
	pankaj.gupta@amd.com, qperret@google.com, rick.p.edgecombe@intel.com, 
	rientjes@google.com, shivankg@amd.com, steven.price@arm.com, tabba@google.com, 
	willy@infradead.org, wyihan@google.com, yan.y.zhao@intel.com, 
	forkloop@google.com, pratyush@kernel.org, suzuki.poulose@arm.com, 
	aneesh.kumar@kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
	Sean Christopherson <seanjc@google.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Shuah Khan <shuah@kernel.org>, Vishal Annapurve <vannapurve@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>, 
	Kairui Song <kasong@tencent.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>, Barry Song <baohua@kernel.org>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
	Wei Xu <weixugc@google.com>, Jason Gunthorpe <jgg@ziepe.ca>, Vlastimil Babka <vbabka@kernel.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

Ackerley Tng <ackerleytng@google.com> writes:

> Add a selftest for the guest_memfd memory attribute conversion ioctls.
> The test starts the guest_memfd as all-private (the default state), and
> verifies the basic flow of converting a single page to shared and then back
> to private.
>
> Add infrastructure that supports extensions to other conversion flow
> tests. This infrastructure will be used in upcoming patches for other
> conversion tests.
>
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>
> Co-developed-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  tools/testing/selftests/kvm/Makefile.kvm           |   1 +
>  .../selftests/kvm/guest_memfd_conversions_test.c   | 205 +++++++++++++++++++++
>  2 files changed, 206 insertions(+)
>
> diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
> index dc68371f76a33..0e2a9adfca57e 100644
> --- a/tools/testing/selftests/kvm/Makefile.kvm
> +++ b/tools/testing/selftests/kvm/Makefile.kvm
> @@ -147,6 +147,7 @@ TEST_GEN_PROGS_x86 += access_tracking_perf_test
>  TEST_GEN_PROGS_x86 += coalesced_io_test
>  TEST_GEN_PROGS_x86 += dirty_log_perf_test
>  TEST_GEN_PROGS_x86 += guest_memfd_test
> +TEST_GEN_PROGS_x86 += guest_memfd_conversions_test
>  TEST_GEN_PROGS_x86 += hardware_disable_test
>  TEST_GEN_PROGS_x86 += memslot_modification_stress_test
>  TEST_GEN_PROGS_x86 += memslot_perf_test
> diff --git a/tools/testing/selftests/kvm/guest_memfd_conversions_test.c b/tools/testing/selftests/kvm/guest_memfd_conversions_test.c
> new file mode 100644
> index 0000000000000..841b2824ae996
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/guest_memfd_conversions_test.c
> @@ -0,0 +1,205 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2024, Google LLC.
> + */
> +#include <sys/mman.h>
> +#include <unistd.h>
> +
> +#include <linux/align.h>
> +#include <linux/kvm.h>
> +#include <linux/sizes.h>
> +
> +#include "kvm_util.h"
> +#include "kselftest_harness.h"
> +#include "test_util.h"
> +#include "ucall_common.h"
> +
> +FIXTURE(gmem_conversions) {
> +	struct kvm_vcpu *vcpu;
> +	int gmem_fd;
> +	/* HVA of the first byte of the memory mmap()-ed from gmem_fd. */
> +	char *mem;
> +};
> +
> +typedef FIXTURE_DATA(gmem_conversions) test_data_t;
> +
> +FIXTURE_SETUP(gmem_conversions) { }
> +
> +static uint64_t page_size;
> +
> +static void guest_do_rmw(void);
> +#define GUEST_MEMFD_SHARING_TEST_GVA 0x90000000ULL
> +
> +/*
> + * Defer setup until the individual test is invoked so that tests can specify
> + * the number of pages and flags for the guest_memfd instance.
> + */
> +static void gmem_conversions_do_setup(test_data_t *t, int nr_pages,
> +				      int gmem_flags)
> +{
> +	const struct vm_shape shape = {
> +		.mode = VM_MODE_DEFAULT,
> +		.type = KVM_X86_SW_PROTECTED_VM,
> +	};
> +	/*
> +	 * Use high GPA above APIC_DEFAULT_PHYS_BASE to avoid clashing with
> +	 * APIC_DEFAULT_PHYS_BASE.
> +	 */
> +	const uint64_t gpa = SZ_4G;
> +	const uint32_t slot = 1;
> +	u64 supported_flags;
> +	struct kvm_vm *vm;
> +
> +	vm = __vm_create_shape_with_one_vcpu(shape, &t->vcpu, nr_pages, guest_do_rmw);
> +
> +	supported_flags = vm_check_cap(vm, KVM_CAP_MEMORY_ATTRIBUTES2_FLAGS);
> +	TEST_REQUIRE(supported_flags & KVM_SET_MEMORY_ATTRIBUTES2_PRESERVE);
> +
> +	vm_mem_add(vm, VM_MEM_SRC_SHMEM, gpa, slot, nr_pages,
> +		   KVM_MEM_GUEST_MEMFD, -1, 0, gmem_flags);
> +
> +	t->gmem_fd = kvm_slot_to_fd(vm, slot);
> +	t->mem = addr_gpa2hva(vm, gpa);
> +	virt_map(vm, GUEST_MEMFD_SHARING_TEST_GVA, gpa, nr_pages);
> +}
> +
> +static void gmem_conversions_do_teardown(test_data_t *t)
> +{
> +	/* No need to close gmem_fd, it's owned by the VM structure. */
> +	kvm_vm_free(t->vcpu->vm);
> +}
> +
> +FIXTURE_TEARDOWN(gmem_conversions)
> +{
> +	gmem_conversions_do_teardown(self);
> +}
> +
> +/*
> + * In these test definition macros, __nr_pages and nr_pages is used to set up
> + * the total number of pages in the guest_memfd under test. This will be
> + * available in the test definitions as nr_pages.
> + */
> +
> +#define __GMEM_CONVERSION_TEST(test, __nr_pages, flags)				\
> +static void __gmem_conversions_##test(test_data_t *t, int nr_pages);		\
> +										\
> +TEST_F(gmem_conversions, test)							\
> +{										\
> +	gmem_conversions_do_setup(self, __nr_pages, flags);			\
> +	__gmem_conversions_##test(self, __nr_pages);				\
> +}										\
> +static void __gmem_conversions_##test(test_data_t *t, int nr_pages)		\
> +
> +#define GMEM_CONVERSION_TEST(test, __nr_pages, flags)				\
> +	__GMEM_CONVERSION_TEST(test, __nr_pages, (flags) | GUEST_MEMFD_FLAG_MMAP)
> +
> +#define __GMEM_CONVERSION_TEST_INIT_PRIVATE(test, __nr_pages)			\
> +	GMEM_CONVERSION_TEST(test, __nr_pages, 0)
> +
> +#define GMEM_CONVERSION_TEST_INIT_PRIVATE(test)					\
> +	__GMEM_CONVERSION_TEST_INIT_PRIVATE(test, 1)
> +
> +struct guest_check_data {
> +	void *mem;
> +	char expected_val;
> +	char write_val;
> +};
> +static struct guest_check_data guest_data;
> +
> +static void guest_do_rmw(void)
> +{
> +	for (;;) {
> +		char *mem = READ_ONCE(guest_data.mem);
> +
> +		GUEST_ASSERT_EQ(READ_ONCE(*mem), READ_ONCE(guest_data.expected_val));
> +		WRITE_ONCE(*mem, READ_ONCE(guest_data.write_val));
> +
> +		GUEST_SYNC(0);
> +	}
> +}
> +
> +static void run_guest_do_rmw(struct kvm_vcpu *vcpu, loff_t pgoff,
> +			     char expected_val, char write_val)
> +{
> +	struct ucall uc;
> +	int r;
> +
> +	guest_data.mem = (void *)GUEST_MEMFD_SHARING_TEST_GVA + pgoff * page_size;
> +	guest_data.expected_val = expected_val;
> +	guest_data.write_val = write_val;
> +	sync_global_to_guest(vcpu->vm, guest_data);
> +
> +	do {
> +		r = __vcpu_run(vcpu);
> +	} while (r == -1 && errno == EINTR);
> +
> +	TEST_ASSERT_EQ(r, 0);

TEST_ASSERT_EQ() ends up calling exit() on failures, which skips
FIXTURE_TEARDOWN().

Other than the explicit assertions not working with the
kselftest_harness, kvm selftest library functions like vm_mem_add() also
call TEST_ASSERT, which doesn't play nice with kselftest_harness.

Any suggestions for this? Should we use the kselftest framework with
these tests?

(I ran into this issue while trying to test something else, where I
needed FIXTURE_TEARDOWN() to clean up system state.)

Or is it "okay" in this case since FIXTURE_TEARDOWN() only cleans up
stuff that would happen if the program exits anyway?

>
> [...snip...]
>
