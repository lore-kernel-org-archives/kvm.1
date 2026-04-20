Received: from pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com [34.218.115.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 767173382DE
	for <kvm@vger.kernel.org>; Mon, 20 Apr 2026 15:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.218.115.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776700096; cv=none; b=j39g9EmZuUCIE3VtQun3Q/vOSRxs05UbxbHt0zRb16rHYBxHoR/CdKZYf+L+c+9oL2ZZLZ1Hpls9FOU0KIXy4mITjmd+RuiVtdLpStkQYQPZTVf+3lR84xWB7eJ7TrORKQjlfvAvKFtuFS+pz4qYybFRS5KBcJuTM3x6QlUVviQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776700096; c=relaxed/simple;
	bh=FuJJZW5A//o3/vg9QyqE9QPIleES82RCdWDy1WePclc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oVG9Sp/KWGYI/FD4B+I6YnTKgJYubcxsl1fB37PUeemgo+YGDkTqE3BEJLlGVnD7wLeqQEGt5FzQcoweFDMf7bPPSGAEVhrcSzMQH0HGXXP1ASft9qWKWvnLBqu0Fx9TMcR43nTBxPzzfctg4Qg8ZDJy9ZiQMgtWVDeK571P9q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=d0zsOikL; arc=none smtp.client-ip=34.218.115.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="d0zsOikL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1776700095; x=1808236095;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ah+6fNR46FmWzr51aYuhunXbtJ0DU+tZTlj7ooPeOu0=;
  b=d0zsOikLz0dFYj1+hdxJOxMApNSU9unOgTwkewhkGKj4/fJjfADFijIb
   rK4Uvtyuk3ycX/RsqYbSZhPSB4JKWc66z0jaWPwPOiz6q3FgZTITSQRth
   7J8ATWDJU0HhOv3XUDMBqNs+2Y3FYV/Xd2XbyMXXz11ytdReh5TXffGAL
   8mswju6gWTRXsfQs0RkZIJR7pimVLyXmYLJ2do9cGnLm+syUTZjN/hNzI
   yFfK95pGq21Rf4OvOOPjc4CM15bwiH43AAcUcBg2jiTBRojW/9rPKATV2
   jAOHG1X88frvh/iIeplhXBv86BU6ohKtPTiLCInp6WVAKkdBpwuRPuIm1
   w==;
X-CSE-ConnectionGUID: DD2pH79UTY2aNONMFTcx8w==
X-CSE-MsgGUID: PIXTaEIFSnG9uNkCyuPLTg==
X-IronPort-AV: E=Sophos;i="6.23,190,1770595200"; 
   d="scan'208";a="17538958"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2026 15:48:15 +0000
Received: from EX19MTAUWA002.ant.amazon.com [205.251.233.234:16745]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.60.139:2525] with esmtp (Farcaster)
 id 707427f7-bf85-493e-907c-3b9126d13d1d; Mon, 20 Apr 2026 15:48:14 +0000 (UTC)
X-Farcaster-Flow-ID: 707427f7-bf85-493e-907c-3b9126d13d1d
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Mon, 20 Apr 2026 15:48:13 +0000
Received: from dev-dsk-itazur-1b-11e7fc0f.eu-west-1.amazon.com (172.19.66.53)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Mon, 20 Apr 2026 15:48:11 +0000
From: Takahiro Itazuri <itazur@amazon.com>
To: <kvm@vger.kernel.org>, Sean Christopherson <seanjc@google.com>, "Paolo
 Bonzini" <pbonzini@redhat.com>
CC: Vitaly Kuznetsov <vkuznets@redhat.com>, Fuad Tabba <tabba@google.com>,
	Brendan Jackman <jackmanb@google.com>, David Hildenbrand <david@kernel.org>,
	David Woodhouse <dwmw2@infradead.org>, Paul Durrant <pdurrant@amazon.com>,
	Nikita Kalyazin <nikita.kalyazin@linux.dev>, Patrick Roy
	<patrick.roy@campus.lmu.de>, Patrick Roy <patrick.roy@linux.dev>, "Derek
 Manwaring" <derekmn@amazon.com>, Alina Cernea <acernea@amazon.com>, "Michael
 Zoumboulakis" <zoumboul@amazon.com>, Takahiro Itazuri <zulinx86@gmail.com>,
	Takahiro Itazuri <itazur@amazon.com>
Subject: [RFC PATCH v4 6/7] KVM: selftests: Test pfncache with gmem-backed memory
Date: Mon, 20 Apr 2026 15:46:07 +0000
Message-ID: <20260420154720.29012-7-itazur@amazon.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260420154720.29012-1-itazur@amazon.com>
References: <20260420154720.29012-1-itazur@amazon.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: EX19D046UWA004.ant.amazon.com (10.13.139.76) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

Add a selftest that exercises pfncache (gfn_to_pfn_cache) with
guest_memfd-backed memory by using kvm-clock as the test vehicle.

The test creates two VM configurations:

 - NO_DIRECT_MAP VM: All memory is gmem-backed (MMAP | INIT_SHARED |
   NO_DIRECT_MAP). KVM_MEMSLOT_GMEM_ONLY is set, so pfncache resolves
   PFNs via kvm_gmem_get_pfn() and maps KHVAs via vmap().

 - SW_PROTECTED_VM: Memory starts private. pfncache resolves PFNs via
   kvm_gmem_get_pfn() for private pages. This validates the private
   memory pfncache path for future extensibility (e.g. pKVM-like VMs).

The guest writes MSR_KVM_SYSTEM_TIME_NEW (triggering kvm_gpc_activate()
internally), reads the pvclock structure to verify KVM wrote through the
pfncache KHVA correctly, and reports the kvm-clock value to the host for
bounds checking against KVM_GET_CLOCK.

Signed-off-by: Takahiro Itazuri <itazur@amazon.com>
---
 tools/testing/selftests/kvm/Makefile.kvm      |   1 +
 .../selftests/kvm/x86/pfncache_gmem_test.c    | 193 ++++++++++++++++++
 2 files changed, 194 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/x86/pfncache_gmem_test.c

diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selft=
ests/kvm/Makefile.kvm
index 148d427ff24b..faf454d64e4e 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -92,6 +92,7 @@ TEST_GEN_PROGS_x86 +=3D x86/nested_emulation_test
 TEST_GEN_PROGS_x86 +=3D x86/nested_exceptions_test
 TEST_GEN_PROGS_x86 +=3D x86/platform_info_test
 TEST_GEN_PROGS_x86 +=3D x86/pmu_counters_test
+TEST_GEN_PROGS_x86 +=3D x86/pfncache_gmem_test
 TEST_GEN_PROGS_x86 +=3D x86/pmu_event_filter_test
 TEST_GEN_PROGS_x86 +=3D x86/private_mem_conversions_test
 TEST_GEN_PROGS_x86 +=3D x86/private_mem_kvm_exits_test
diff --git a/tools/testing/selftests/kvm/x86/pfncache_gmem_test.c b/tools/t=
esting/selftests/kvm/x86/pfncache_gmem_test.c
new file mode 100644
index 000000000000..c61b161f3e0c
--- /dev/null
+++ b/tools/testing/selftests/kvm/x86/pfncache_gmem_test.c
@@ -0,0 +1,193 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2025, Amazon.com, Inc. or its affiliates.
+ *
+ * Test pfncache (gfn_to_pfn_cache) with guest_memfd-backed memory.
+ *
+ * Exercises pfncache indirectly through kvm-clock: the guest writes
+ * MSR_KVM_SYSTEM_TIME_NEW (triggering kvm_gpc_activate() in KVM), KVM wri=
tes
+ * pvclock data through the pfncache's KHVA, and the guest reads the
+ * pvclock_vcpu_time_info structure to verify correctness.
+ *
+ * Two VM configurations exercise distinct pfncache code paths:
+ *
+ *  - NO_DIRECT_MAP VM: All memory is gmem-backed and shared (MMAP |
+ *    INIT_SHARED | NO_DIRECT_MAP).  KVM_MEMSLOT_GMEM_ONLY is set, so
+ *    gpc_is_gmem_backed() always returns true.  PFN resolution goes throu=
gh
+ *    kvm_gmem_get_pfn() and KHVA mapping uses vmap().
+ *
+ *  - SW_PROTECTED_VM: Memory starts private.  pfncache uses
+ *    kvm_gmem_get_pfn() for private pages.  This validates the private
+ *    memory pfncache path for future extensibility (e.g. pKVM-like VMs).
+ */
+#include <asm/kvm_para.h>
+#include <asm/pvclock.h>
+#include <asm/pvclock-abi.h>
+#include <stdint.h>
+
+#include "test_util.h"
+#include "kvm_util.h"
+#include "processor.h"
+
+#define GUEST_SYNC_CLOCK(__stage, __val)	\
+	GUEST_SYNC_ARGS(__stage, __val, 0, 0, 0)
+
+static void guest_main(vm_paddr_t pvti_pa, struct pvclock_vcpu_time_info *=
pvti)
+{
+	int stage =3D 0;
+
+	wrmsr(MSR_KVM_SYSTEM_TIME_NEW, pvti_pa | KVM_MSR_ENABLED);
+
+	for (;;) {
+		uint64_t clock;
+
+		GUEST_ASSERT(pvti->system_time !=3D 0);
+		clock =3D __pvclock_read_cycles(pvti, rdtsc());
+		GUEST_SYNC_CLOCK(stage++, clock);
+	}
+}
+
+static uint64_t run_and_verify_kvm_clock(struct kvm_vcpu *vcpu,
+					 uint64_t prev_clock)
+{
+	struct kvm_clock_data start, end;
+	struct ucall uc;
+	uint64_t guest_clock;
+
+	vm_ioctl(vcpu->vm, KVM_GET_CLOCK, &start);
+	vcpu_run(vcpu);
+	vm_ioctl(vcpu->vm, KVM_GET_CLOCK, &end);
+
+	TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_IO);
+
+	switch (get_ucall(vcpu, &uc)) {
+	case UCALL_SYNC:
+		break;
+	case UCALL_ABORT:
+		REPORT_GUEST_ASSERT(uc);
+		/* unreachable */
+		return 0;
+	default:
+		TEST_FAIL("Unexpected ucall: %lu", uc.cmd);
+	}
+
+	guest_clock =3D uc.args[2];
+
+	TEST_ASSERT(start.clock <=3D guest_clock && guest_clock <=3D end.clock,
+		    "guest clock %llu ns not in expected range [%llu, %llu] ns",
+		    (unsigned long long)guest_clock,
+		    (unsigned long long)start.clock,
+		    (unsigned long long)end.clock);
+
+	if (prev_clock)
+		TEST_ASSERT(guest_clock > prev_clock,
+			    "guest clock %llu ns not monotonic (prev %llu ns)",
+			    (unsigned long long)guest_clock,
+			    (unsigned long long)prev_clock);
+
+	pr_info("  guest clock %llu ns, expected range [%llu, %llu] ns\n",
+		(unsigned long long)guest_clock,
+		(unsigned long long)start.clock,
+		(unsigned long long)end.clock);
+
+	return guest_clock;
+}
+
+#define PVCLOCK_SLOT		10
+#define PVCLOCK_GPA		(1ULL << 32)
+
+static struct kvm_vm *setup_vm(struct vm_shape shape,
+			       struct kvm_vcpu **vcpu_out)
+{
+	struct kvm_vm *vm;
+
+	vm =3D __vm_create_shape_with_one_vcpu(shape, vcpu_out, 0, guest_main);
+
+	/*
+	 * For SW_PROTECTED_VM, the primary memslot doesn't have guest_memfd.
+	 * Place the pvclock page in a separate memslot with both anonymous
+	 * memory (for shared) and guest_memfd (for private), and mark it
+	 * private so that pfncache exercises the kvm_gmem_get_pfn() path.
+	 */
+	if (shape.type =3D=3D KVM_X86_SW_PROTECTED_VM) {
+		int memfd =3D vm_create_guest_memfd(vm, getpagesize(), 0);
+
+		vm_mem_add(vm, VM_MEM_SRC_ANONYMOUS, PVCLOCK_GPA,
+			   PVCLOCK_SLOT, 1, KVM_MEM_GUEST_MEMFD, memfd, 0);
+		virt_map(vm, PVCLOCK_GPA, PVCLOCK_GPA, 1);
+		vcpu_args_set(*vcpu_out, 2, (vm_paddr_t)PVCLOCK_GPA,
+			      (struct pvclock_vcpu_time_info *)PVCLOCK_GPA);
+		vm_mem_set_private(vm, PVCLOCK_GPA, getpagesize());
+	} else {
+		vm_vaddr_t pvti_gva;
+		vm_paddr_t pvti_gpa;
+
+		pvti_gva =3D vm_vaddr_alloc(vm, getpagesize(), 0x10000);
+		pvti_gpa =3D addr_gva2gpa(vm, pvti_gva);
+		vcpu_args_set(*vcpu_out, 2, pvti_gpa, pvti_gva);
+	}
+
+	return vm;
+}
+
+static void test_no_direct_map(void)
+{
+	struct vm_shape shape =3D {
+		.mode =3D VM_MODE_DEFAULT,
+		.type =3D VM_TYPE_DEFAULT,
+		.src_type =3D VM_MEM_SRC_GUEST_MEMFD_NO_DIRECT_MAP,
+	};
+	struct kvm_vcpu *vcpu;
+	struct kvm_vm *vm;
+	uint64_t clock =3D 0;
+
+	pr_info("Testing pfncache with NO_DIRECT_MAP guest_memfd\n");
+
+	vm =3D setup_vm(shape, &vcpu);
+
+	/* Verify kvm-clock works with gmem-backed pfncache (vmap KHVA) */
+	clock =3D run_and_verify_kvm_clock(vcpu, clock);
+	clock =3D run_and_verify_kvm_clock(vcpu, clock);
+
+	kvm_vm_free(vm);
+}
+
+static void test_sw_protected_vm(void)
+{
+	struct vm_shape shape =3D {
+		.mode =3D VM_MODE_DEFAULT,
+		.type =3D KVM_X86_SW_PROTECTED_VM,
+	};
+	struct kvm_vcpu *vcpu;
+	struct kvm_vm *vm;
+	uint64_t clock =3D 0;
+
+	pr_info("Testing pfncache with SW_PROTECTED_VM (guest_memfd-backed privat=
e memory)\n");
+
+	vm =3D setup_vm(shape, &vcpu);
+
+	/* Verify kvm-clock works with gmem-backed private memory */
+	clock =3D run_and_verify_kvm_clock(vcpu, clock);
+	clock =3D run_and_verify_kvm_clock(vcpu, clock);
+
+	kvm_vm_free(vm);
+}
+
+int main(int argc, char *argv[])
+{
+	TEST_REQUIRE(kvm_has_cap(KVM_CAP_GUEST_MEMFD));
+	TEST_REQUIRE(sys_clocksource_is_based_on_tsc());
+
+	if (kvm_check_cap(KVM_CAP_GUEST_MEMFD_FLAGS) &
+	    GUEST_MEMFD_FLAG_NO_DIRECT_MAP)
+		test_no_direct_map();
+	else
+		print_skip("GUEST_MEMFD_FLAG_NO_DIRECT_MAP not supported");
+
+	if (kvm_check_cap(KVM_CAP_VM_TYPES) & BIT(KVM_X86_SW_PROTECTED_VM))
+		test_sw_protected_vm();
+	else
+		print_skip("KVM_X86_SW_PROTECTED_VM not supported");
+
+	return 0;
+}
--=20
2.50.1

