Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F268E18DB35
	for <kvm@vger.kernel.org>; Fri,  7 Aug 2026 03:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786074690; cv=none; b=PymNQRU72ZUpn4qyYsZ+PyD7AmWQKvho+fxgG7BZmYYS+0/AWQWFBBSZ3QWz9n14gMZRCuCVy1shES8+VJpcKvkurcdy2Ruo3QKesSuGe3+GjDgiLiWJsBYe8X8fCHdj4M//GbWQeyn+FUpvEkgoETsWb5Cl3LHebVZ1YqalJrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786074690; c=relaxed/simple;
	bh=DsE3iVom0V6Bg34N2TQD9xICdojiH9gD7eZ+FHQsqVI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ryAnQnv6/lveZrZUrdntZWXdfNZZo1mGY5/aUATSJUrW6d37crXI2EBbgz4b8P24aYJ2wRIT1QsaTfMJbnTUiSLINWLeBt9nN+0vSlhDYDYZm8WWgtypyfYm5P3ZCGQ4dviYl6pXpcUbKscpZVI55m3A/vXCnG+xW8mg0yAWyoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d/gqUODd; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d/gqUODd"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-84864086bfeso2450401b3a.1
        for <kvm@vger.kernel.org>; Thu, 06 Aug 2026 20:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786074688; x=1786679488; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=roc/IS/aTyNJNRiP/nrbSlyNrCVYc83nltBjgP79s1s=;
        b=d/gqUODd9JuqNLzNNtueXFzHV2UdoLKI6RmLPYbdYbHtRwq2amisvWzvC0bBcFQ6T/
         srFnhWhn0ny0vNY/Jn6uB40lwbbFDpiVAqhx9g+1oEXOeAo+/F/fJj9tK0W1joIiZ7f+
         x0/IbF4W62vrYiTaz2TzNkzfB7EKN2MgjvYDnfNdEUmjW8Rv7TI1eZqw13wrISBjsBMF
         QkH4bw48cSo74fADgoz55ZbuV/LFHQTxv4C45qVjm5Eg6MGYotEv65Xmmy4GDH0JGEKs
         JXFboOCeiC0VS/mwFXmCHAZyetcV/dV+cxMufo1aPRnKlSTLN3905yEm+XlwA0f9ZQ+6
         oOIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786074688; x=1786679488;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=roc/IS/aTyNJNRiP/nrbSlyNrCVYc83nltBjgP79s1s=;
        b=kDpRdamWWJq5IckURZjEI3MPsHmaC7Gt2vHk+lZlBCdZ+tkS4k6MA2t1FUdzf6hKnK
         wGMWi9STQK+H7wUOMmSWI5sfslKgbsPGeEtLdsMd3Cni7wpAMDLPT63dqMslol4Ka/Ht
         fH6BU3kGekJxfwyN4J29ii0GLxSmH4InBKGJgGB1qslbOAqmOFNvzkuA0qklmEamlzIz
         H7bXv/OlpOnNkJyZUflFCJMlWvJ+ly/BFDEERWiFRl2zDb4XYzmAf/1ZT5dvKoGLTJg9
         2fsvnQgYtER16TaIqGwE7Kf90sZQL57LJSk10D6mJIlC2uun++YpNleRU3Vm3FNt4Soh
         h2iQ==
X-Forwarded-Encrypted: i=1; AHgh+Rosadg6VLP/ucUfmM3w+54gb9Mdbez1E1X+kTCT2CO3KcBgbogozuXelHGXS2pOMGVEDo4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzW1dcgHiN9jesKrHtrGA5DKQJe9OdZQLuChzPsNNmvDNW0JrJV
	zarapvG4Y+F2xyDwkHp89kiTJjOIsM8EbgfJmfruDjCdisIlXHwMkPat
X-Gm-Gg: AR+sD12HUlO59uustlj3htWuHRmtm/NedSWAJVz/zSOv3CIFQ0iNdqQbwPA5SjYvlox
	X+McMWYhTTuGhESKKjMQiFmtNOZbty6+TnetVEBSA4dSVb6sdqE/AM7fCDidh1k57+EYZXp96le
	NDDI/NNuEM+B/2DZKIAAreHlP4XxOwSaH9OxYI66hbe08KZ6e0oqLsgJfiGwd9Be2QHBImOgqjG
	ujHuKI7tHREH6vn3gCcju6CP0rdUt8FxRhUEGGfMvE0FdZo+pBLeJ1EmbwRQEePxkttQhss/Ijq
	APiKFE1t5eJm/rbQtP1g1bqGfbjVmuR9Y0U5DGVSwHdVBZurw/Vf9xKfPOc6LHNfxWemL7XWFRm
	iw90WnrC4O/gN7jE/mZ4QA+aYrmN6yRHEubr7j3P4cPSHatrqDr2aG6p3dYlNBRwavYW9u6P41h
	u1UPDRzXRErSoBGTVxAEoLMrylphXcvKeaVBSQzTMbp0UfXn+2DHgAbyJ+JNrEx6fWmhqdSJgmD
	S91jss=
X-Received: by 2002:a05:6a00:4504:b0:845:da74:5d7c with SMTP id d2e1a72fcca58-84f2e0dba2cmr23794104b3a.32.1786074688151;
        Thu, 06 Aug 2026 20:51:28 -0700 (PDT)
Received: from cyh-System-Product-Name.. ([129.227.183.200])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84f5a3d0d96sm287586b3a.18.2026.08.06.20.51.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 20:51:27 -0700 (PDT)
From: "Yuhang.chen" <yhchen312@gmail.com>
To: anup@brainfault.org
Cc: atish.patra@linux.dev,
	palmer@dabbelt.com,
	pjw@kernel.org,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	pbonzini@redhat.com,
	shuah@kernel.org,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	zhouquan@iscas.ac.cn,
	"Yuhang.chen" <yhchen312@gmail.com>
Subject: [PATCH 2/2] RISC-V: KVM: selftests: Add PMU event filter test
Date: Fri,  7 Aug 2026 11:50:39 +0800
Message-Id: <20260807035039.294998-3-yhchen312@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260807035039.294998-1-yhchen312@gmail.com>
References: <20260807035039.294998-1-yhchen312@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a selftest that exercises KVM_SET_PMU_EVENT_FILTER on RISC-V. The
guest programs the CPU cycles and instructions SBI PMU events through
SBI_EXT_PMU_COUNTER_CFG_MATCH while the host installs filters with the
ALLOW and DENY actions, asserting that disallowed events return
SBI_ERR_NOT_SUPPORTED and allowed events succeed.

The test also validates ioctl argument rejection: an invalid action, a
non-zero flags field, and an over-large nevents value are each expected
to fail with -EINVAL or -E2BIG. A baseline run verifies PMU
availability and the test skips (KSFT_SKIP) when PMU or the filter
capability is absent.

Assisted-by: YuanSheng:deepseek-v4-pro
Co-developed-by: Quan Zhou <zhouquan@iscas.ac.cn>
Signed-off-by: Quan Zhou <zhouquan@iscas.ac.cn>
Signed-off-by: Yuhang.chen <yhchen312@gmail.com>
---
 tools/testing/selftests/kvm/Makefile.kvm      |   1 +
 .../kvm/riscv/pmu_event_filter_test.c         | 199 ++++++++++++++++++
 2 files changed, 200 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/riscv/pmu_event_filter_test.c

diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
index d28a057fa6c2..5d2dc3b25eac 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -218,6 +218,7 @@ TEST_GEN_PROGS_s390 += pre_fault_memory_test
 TEST_GEN_PROGS_riscv = $(TEST_GEN_PROGS_COMMON)
 TEST_GEN_PROGS_riscv += riscv/sbi_pmu_test
 TEST_GEN_PROGS_riscv += riscv/ebreak_test
+TEST_GEN_PROGS_riscv += riscv/pmu_event_filter_test
 TEST_GEN_PROGS_riscv += access_tracking_perf_test
 TEST_GEN_PROGS_riscv += arch_timer
 TEST_GEN_PROGS_riscv += coalesced_io_test
diff --git a/tools/testing/selftests/kvm/riscv/pmu_event_filter_test.c b/tools/testing/selftests/kvm/riscv/pmu_event_filter_test.c
new file mode 100644
index 000000000000..1a76fce2aca6
--- /dev/null
+++ b/tools/testing/selftests/kvm/riscv/pmu_event_filter_test.c
@@ -0,0 +1,199 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Test for RISC-V KVM_SET_PMU_EVENT_FILTER.
+ *
+ * Verify that a VM-scoped PMU event filter installed via the
+ * KVM_SET_PMU_EVENT_FILTER ioctl is enforced when a guest configures a
+ * counter through the SBI PMU COUNTER_CFG_MATCH call:
+ *
+ *   - with no filter, events are programmable (baseline / PMU probe);
+ *   - KVM_PMU_EVENT_DENY rejects the listed events;
+ *   - KVM_PMU_EVENT_ALLOW admits only the listed events;
+ *   - replacing the filter with an empty DENY list re-enables everything.
+ *
+ * The filter is checked before any perf event is created, so the test only
+ * ever programs the cycle event (always supported by the host PMU) and varies
+ * the filter *list* contents to exercise membership without depending on host
+ * support for other events.  Counter management and SBI error reporting happen
+ * in the guest; the host installs filters and checks the reported errors.
+ */
+#include <errno.h>
+#include <stdlib.h>
+#include <string.h>
+
+#include "kvm_util.h"
+#include "test_util.h"
+#include "processor.h"
+#include "ucall_common.h"
+#include "sbi.h"
+
+/* SBI PMU hardware event indexes (type == HW == 0, so eidx == code). */
+#define EV_CYCLES	SBI_PMU_HW_CPU_CYCLES		/* 1 */
+#define EV_INSTR	SBI_PMU_HW_INSTRUCTIONS		/* 2 */
+
+/* Must match KVM_PMU_EVENT_FILTER_MAX_EVENTS in arch/riscv/kvm/vm.c. */
+#define MAX_EVENTS	256
+
+static void guest_code(void)
+{
+	struct sbiret ret;
+	unsigned long ctr;
+	long err;
+
+	for (;;) {
+		/*
+		 * Request the fixed cycle counter (cbase=0, cmask=1) for the
+		 * cycle event.  The host installs (or clears) the filter
+		 * before each entry, so the result reflects the active policy.
+		 */
+		ret = sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_CFG_MATCH,
+				0, 1, 0, EV_CYCLES, 0, 0);
+		err = ret.error;
+		ctr = ret.value;
+
+		/* Release the counter on success so the next iteration reuses it. */
+		if (!err)
+			sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_STOP,
+				  ctr, 1, SBI_PMU_STOP_FLAG_RESET, 0, 0, 0);
+
+		GUEST_SYNC1(err);
+	}
+}
+
+static struct kvm_pmu_event_filter *
+build_filter(__u32 action, __u32 flags, const __u64 *events, __u32 nevents)
+{
+	struct kvm_pmu_event_filter *f;
+	size_t size = sizeof(*f) + (size_t)nevents * sizeof(__u64);
+
+	f = calloc(1, size);
+	TEST_ASSERT(f, "calloc(pmu_event_filter)");
+	f->action = action;
+	f->nevents = nevents;
+	f->flags = flags;
+	if (nevents && events)
+		memcpy(f->events, events, nevents * sizeof(__u64));
+	return f;
+}
+
+/* Install a filter, asserting success. */
+static void set_filter(struct kvm_vm *vm, __u32 action,
+		       const __u64 *events, __u32 nevents)
+{
+	struct kvm_pmu_event_filter *f = build_filter(action, 0, events, nevents);
+
+	vm_ioctl(vm, KVM_SET_PMU_EVENT_FILTER, f);
+	free(f);
+}
+
+/* Install a filter and return the raw ioctl result (for negative tests). */
+static int try_set_filter(struct kvm_vm *vm, __u32 action, __u32 flags,
+			  const __u64 *events, __u32 nevents)
+{
+	struct kvm_pmu_event_filter *f = build_filter(action, flags, events, nevents);
+	int ret = __vm_ioctl(vm, KVM_SET_PMU_EVENT_FILTER, f);
+
+	free(f);
+	return ret;
+}
+
+/* Run the guest one step and return the cfg_match error code it reports. */
+static long run_one(struct kvm_vcpu *vcpu)
+{
+	struct ucall uc;
+
+	vcpu_run(vcpu);
+	TEST_ASSERT_EQ(get_ucall(vcpu, &uc), UCALL_SYNC);
+	return (long)uc.args[0];
+}
+
+static void test_filter_case(struct kvm_vm *vm, struct kvm_vcpu *vcpu,
+			     __u32 action, const __u64 *events, __u32 nevents,
+			     long expect, const char *desc)
+{
+	long err;
+
+	set_filter(vm, action, events, nevents);
+	err = run_one(vcpu);
+	TEST_ASSERT_EQ(err, expect);
+	pr_info("%s: err=%ld (expected %ld)\n", desc, err, expect);
+}
+
+static void test_bad_args(struct kvm_vm *vm)
+{
+	__u64 ev = EV_CYCLES;
+	int ret;
+
+	/* Invalid action. */
+	errno = 0;
+	ret = try_set_filter(vm, 2, 0, &ev, 1);
+	TEST_ASSERT(ret < 0 && errno == EINVAL,
+		    "invalid action should fail with EINVAL, got ret=%d errno=%d",
+		    ret, errno);
+
+	/* Non-zero flags are not supported. */
+	errno = 0;
+	ret = try_set_filter(vm, KVM_PMU_EVENT_ALLOW, 1, &ev, 1);
+	TEST_ASSERT(ret < 0 && errno == EINVAL,
+		    "non-zero flags should fail with EINVAL, got ret=%d errno=%d",
+		    ret, errno);
+
+	/* Too many events. */
+	errno = 0;
+	ret = try_set_filter(vm, KVM_PMU_EVENT_DENY, 0, NULL, MAX_EVENTS + 1);
+	TEST_ASSERT(ret < 0 && errno == E2BIG,
+		    "nevents > max should fail with E2BIG, got ret=%d errno=%d",
+		    ret, errno);
+}
+
+int main(void)
+{
+	struct kvm_vm *vm;
+	struct kvm_vcpu *vcpu;
+	long err;
+
+	TEST_REQUIRE(kvm_has_cap(KVM_CAP_PMU_EVENT_FILTER));
+
+	vm = vm_create_with_one_vcpu(&vcpu, guest_code);
+
+	/*
+	 * Baseline / PMU probe: with no filter the cycle event must be
+	 * programmable.  If it isn't, the host PMU is unusable in this
+	 * environment (e.g. Sscofpmf unavailable under TCG); skip the rest.
+	 */
+	err = run_one(vcpu);
+	if (err) {
+		pr_info("PMU unavailable (baseline cfg_match err=%ld), skipping\n",
+			err);
+		kvm_vm_free(vm);
+		exit(KSFT_SKIP);
+	}
+
+	/* DENY{cycles}: the cycle event is rejected. */
+	test_filter_case(vm, vcpu, KVM_PMU_EVENT_DENY,
+			 &(__u64){ EV_CYCLES }, 1,
+			 SBI_ERR_NOT_SUPPORTED, "deny cycles");
+
+	/* ALLOW{cycles}: the cycle event is admitted. */
+	test_filter_case(vm, vcpu, KVM_PMU_EVENT_ALLOW,
+			 &(__u64){ EV_CYCLES }, 1,
+			 0, "allow cycles");
+
+	/*
+	 * ALLOW{instructions}: cycles is not in the allow list, so it is
+	 * rejected.  Instructions itself is never programmed, so host support
+	 * for it is irrelevant.
+	 */
+	test_filter_case(vm, vcpu, KVM_PMU_EVENT_ALLOW,
+			 &(__u64){ EV_INSTR }, 1,
+			 SBI_ERR_NOT_SUPPORTED, "cycles not in allow{instr}");
+
+	/* Empty DENY list: nothing is denied, cycles is programmable again. */
+	test_filter_case(vm, vcpu, KVM_PMU_EVENT_DENY, NULL, 0,
+			 0, "clear (deny empty)");
+
+	test_bad_args(vm);
+
+	kvm_vm_free(vm);
+	return 0;
+}
-- 
2.34.1

