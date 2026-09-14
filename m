Received: from esa7.hc1455-7.c3s2.iphmx.com (esa7.hc1455-7.c3s2.iphmx.com [139.138.61.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A9D93F4DE2;
	Mon, 14 Sep 2026 07:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.138.61.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789371089; cv=none; b=rvliac+S+y9eyTTZxceyQolHFK4W+C8cVKVHvFvezqZ/cT5yznWw7md4iRjNn778EQOnh4aC/WE8cahB62dH1ONh3lJ9O5Gi5E7xjxbk1FdjV1HvTAJHwvPgS4OQ7YdwJ2fdsTS8r5DvroC/6qi5LhfdQ/pEySIp1uZU4ywneQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789371089; c=relaxed/simple;
	bh=D/w0Nd7mMBMXBwcmirCSoGgamOmcMh+0zKgJNohHTyU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HKhHX5KXmhsLYK6xnws6yTMBAiZgFfuvAmAEROPO1loBuj2p6PuvKpwLX3AtN1ttrmLNwlqkwXwYub544NM52CPu1yi3/rlM/r8pTEz1hGlooCmT9WjzWz4jB7eLg7MIrHuj0LoqXaflZCpJXdOEATYKKOehElWgAHgoougmLs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=gxaLJStz; arc=none smtp.client-ip=139.138.61.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="gxaLJStz"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1789371087; x=1820907087;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=D/w0Nd7mMBMXBwcmirCSoGgamOmcMh+0zKgJNohHTyU=;
  b=gxaLJStzIaPiPr8A7AGJe/AstoPg/WNcrL2NT0kPbr0US9vePeEBvx4/
   FVmdO/rae8YOwDThXwgd8LHmp33jGP1mrei12/JBxJYMKpx1jCFVWWyaZ
   ARVerSld3GYvy/6rE+KWY6vVBausJaFUjUu+0BkOAkM8gU1zl23dKlysZ
   +es5V7M3C4kRKRb/W3Rh459ijFdxPQRInhQImShYGKIPcNeW85AmJWIRp
   a6PfRWr63Lg7v/Z2CXVqJWXxw4RUAFZKv/1bLF6K93uZOkxWgSrrPTQtp
   LpizG5jtVuu973sjaBOUI7WHYkPk+YnCvyz1AXhW4zsqLTVkGAcBsNOwR
   w==;
X-CSE-ConnectionGUID: m7LyXl5mTdu6pk5FjUT07g==
X-CSE-MsgGUID: eTmntcNGT+iuxUwVs8KXCA==
X-IronPort-AV: E=McAfee;i="6800,10657,11904"; a="233859365"
X-IronPort-AV: E=Sophos;i="6.27,102,1786978800"; 
   d="scan'208";a="233859365"
Received: from gmgwnl01.global.fujitsu.com ([52.143.17.124])
  by esa7.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2026 16:31:19 +0900
Received: from az2nlsmgm3.fujitsu.com (unknown [10.150.26.205])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by gmgwnl01.global.fujitsu.com (Postfix) with ESMTPS id 99F5A100036C;
	Mon, 14 Sep 2026 07:31:19 +0000 (UTC)
Received: from az2nlsmom2.o.css.fujitsu.com (unknown [10.150.26.200])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by az2nlsmgm3.fujitsu.com (Postfix) with ESMTPS id 4DA631800513;
	Mon, 14 Sep 2026 07:31:19 +0000 (UTC)
Received: from [127.0.1.1] (unknown [10.124.178.20])
	by az2nlsmom2.o.css.fujitsu.com (Postfix) with ESMTP id 90E2A180012C;
	Mon, 14 Sep 2026 07:31:13 +0000 (UTC)
From: Itaru Kitayama <itaru.kitayama@fujitsu.com>
Date: Mon, 14 Sep 2026 16:30:46 +0900
Subject: [PATCH v2 3/3] KVM: arm64: selftests: Test 52-bit guest virtual
 addresses
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260914-arm64-52bit-va-v2-3-3911cb9d4ad4@fujitsu.com>
References: <20260914-arm64-52bit-va-v2-0-3911cb9d4ad4@fujitsu.com>
In-Reply-To: <20260914-arm64-52bit-va-v2-0-3911cb9d4ad4@fujitsu.com>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>, 
 Fuad Tabba <fuad.tabba@linux.dev>, Joey Gouly <joey.gouly@arm.com>, 
 Steffen Eiden <seiden@linux.ibm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Zenghui Yu <yuzenghui@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Sean Christopherson <seanjc@google.com>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
 kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Itaru Kitayama <itaru.kitayama@fujitsu.com>, 
 Takayuki Okamoto <tokamoto@fujitsu.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789371056; l=4315;
 i=itaru.kitayama@fujitsu.com; s=20260825; h=from:subject:message-id;
 bh=D/w0Nd7mMBMXBwcmirCSoGgamOmcMh+0zKgJNohHTyU=;
 b=VA0ne9nO2NfJtWMm9NxCz3CmVr9fkGlNn8NDYp2vGUuIDTaOEeAvCHVW02A5c5d5QN+mOmvw6
 P533nSEpYopCtjYRq6O4Pb1k4WBfmehGom4eFkGDD9Sp51UzYxkxnBf
X-Developer-Key: i=itaru.kitayama@fujitsu.com; a=ed25519;
 pk=g9bTnr9giRP7JwNSZHy+OMLQZBEUtSE9tUnXso0hH1Y=

Exercise reads and writes through low and high guest virtual addresses
in the 52-bit VA modes with 4K, 16K and 64K pages. Verify that mappings
to the same GPA share data and mappings to distinct GPAs remain
independent.

Signed-off-by: Itaru Kitayama <itaru.kitayama@fujitsu.com>
---
 tools/testing/selftests/kvm/Makefile.kvm     |   1 +
 tools/testing/selftests/kvm/arm64/lpa_test.c | 124 +++++++++++++++++++++++++++
 2 files changed, 125 insertions(+)

diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
index 96bab7002d39..1e9d059ffb24 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -179,6 +179,7 @@ TEST_GEN_PROGS_arm64 += arm64/hello_el2
 TEST_GEN_PROGS_arm64 += arm64/host_sve
 TEST_GEN_PROGS_arm64 += arm64/hypercalls
 TEST_GEN_PROGS_arm64 += arm64/external_aborts
+TEST_GEN_PROGS_arm64 += arm64/lpa_test
 TEST_GEN_PROGS_arm64 += arm64/mmio_sign_ext
 TEST_GEN_PROGS_arm64 += arm64/page_fault_test
 TEST_GEN_PROGS_arm64 += arm64/psci_test
diff --git a/tools/testing/selftests/kvm/arm64/lpa_test.c b/tools/testing/selftests/kvm/arm64/lpa_test.c
new file mode 100644
index 000000000000..8fe6f254db28
--- /dev/null
+++ b/tools/testing/selftests/kvm/arm64/lpa_test.c
@@ -0,0 +1,124 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Higher virtual addresses read/write test
+ */
+#include <test_util.h>
+
+#include "kvm_syscalls.h"
+#include "kvm_util.h"
+#include "ucall_common.h"
+#include "guest_modes.h"
+#include "processor.h"
+
+#define LOW_GVA		0xc0000000
+#define HIGH_GVA (LOW_GVA | BIT(48))
+
+static void guest_code(void)
+{
+	u64 *low = (u64 *)LOW_GVA;
+	u64 *high = (u64 *)HIGH_GVA;
+
+	WRITE_ONCE(*low, 1);
+	GUEST_ASSERT_EQ(READ_ONCE(*high), 1);
+	WRITE_ONCE(*high, 2);
+	GUEST_ASSERT_EQ(READ_ONCE(*low), 2);
+
+	GUEST_SYNC(0);
+
+	asm volatile("dsb sy\n\t"
+		     "tlbi vmalle1is\n\t"
+		     "dsb sy\n\t"
+		     "isb"
+		     : : : "memory");
+
+	GUEST_SYNC(1); /* Host installs HIGH_GVA -> gpa_b. */
+
+	asm volatile("dsb sy\n\t"
+		     "isb\n\t"
+		     : : : "memory");
+
+	/* low and high map to different GPAs. */
+	WRITE_ONCE(*low,  1);
+	WRITE_ONCE(*high, 2);
+
+	/* Check both after both writes to detect accidental aliasing. */
+	GUEST_ASSERT_EQ(READ_ONCE(*low),  1);
+	GUEST_ASSERT_EQ(READ_ONCE(*high), 2);
+
+	/* Updating the low mapping must not change the high mapping. */
+	WRITE_ONCE(*low, 3);
+
+	GUEST_ASSERT_EQ(READ_ONCE(*low),  3);
+	GUEST_ASSERT_EQ(READ_ONCE(*high), 2);
+
+	GUEST_DONE();
+}
+
+static void run_test(enum vm_guest_mode mode, void *arg)
+{
+	unsigned int *nr_tests = arg;
+	struct kvm_vcpu_init init;
+	struct kvm_vm *vm;
+	struct kvm_vcpu *vcpu;
+	struct ucall uc;
+
+	if (mode != VM_MODE_P52V52_4K &&
+	    mode != VM_MODE_P52V52_16K &&
+	    mode != VM_MODE_P52V52_64K)
+		return;
+
+	vm = __vm_create(VM_SHAPE(mode), 1, 0);
+	kvm_get_default_vcpu_target(vm, &init);
+	vcpu = aarch64_vcpu_add(vm, 0, &init, guest_code);
+	kvm_arch_vm_finalize_vcpus(vm);
+
+	vm_init_descriptor_tables(vm);
+	vcpu_init_descriptor_tables(vcpu);
+
+	u64 gpa_a = vm_phy_pages_alloc(vm, 1, 0, 0);
+	u64 gpa_b = vm_phy_pages_alloc(vm, 1, 0, 0);
+
+	virt_pg_map(vm, LOW_GVA, gpa_a);
+	virt_pg_map(vm, HIGH_GVA, gpa_a);
+
+	for (;;) {
+		vcpu_run(vcpu);
+		switch (get_ucall(vcpu, &uc)) {
+		case UCALL_DONE:
+			goto done;
+		case UCALL_ABORT:
+			REPORT_GUEST_ASSERT(uc);
+			break;
+		case UCALL_SYNC:
+			switch (uc.args[1]) {
+			case 0:
+				WRITE_ONCE(*virt_get_pte_hva(vm, HIGH_GVA), 0);
+				break;
+			case 1:
+				virt_pg_map(vm, HIGH_GVA, gpa_b);
+				break;
+			default:
+				TEST_FAIL("Unexpected sync stage: %lu\n", uc.args[1]);
+			}
+			/* Complete the host's PTE store before resuming the guest. */
+			asm volatile("dsb sy" : : : "memory");
+			break;
+		default:
+			TEST_FAIL("Unhandled ucall: %ld\n", uc.cmd);
+		}
+	}
+
+done:
+	kvm_vm_free(vm);
+	(*nr_tests)++;
+}
+
+int main(int argc, char **argv)
+{
+	unsigned int nr_tests = 0;
+
+	for_each_guest_mode(run_test, &nr_tests);
+	if (!nr_tests)
+		ksft_exit_skip("No supported 52-bit VA guest mode; skipping test\n");
+	return 0;
+}

-- 
2.43.0

