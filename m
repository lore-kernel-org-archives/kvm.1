Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30FBE42E8F2
	for <kvm@vger.kernel.org>; Fri,  7 Aug 2026 05:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786080782; cv=none; b=K+CQtk/d4El7GNJgFrLEewTQEsGKPZuTDRxH/995p2G3Uwe/wV3GJ41iCVRf7viM0XLyaGclKq7y2b5U4ZoKfUxTEuPOG7LudSDVw4rNKfmc0iTim6K0UT0KJRD6sFatG9W6j7bhH1+A21EIuyOM/XWLbPz2tTberwpUQA5sMhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786080782; c=relaxed/simple;
	bh=DsE3iVom0V6Bg34N2TQD9xICdojiH9gD7eZ+FHQsqVI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HceHaJ2KlHGeGcM/YLucgLh9mn8omSovsqRQOf60BEvsME2G+6Ot5N2loMUzSu+G4cuUrq/IVWcmwEvk/N4XMnmSEJ/xIYad/ulRrWSczI/fjCLDU7NDfwN/zlMpdX6xAPYb5rt7oFplEC1vX0tl4ppraW6pKB8rfr5gsafNK4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oclkTniV; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oclkTniV"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-84e0688b7e8so2867662b3a.1
        for <kvm@vger.kernel.org>; Thu, 06 Aug 2026 22:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786080777; x=1786685577; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=roc/IS/aTyNJNRiP/nrbSlyNrCVYc83nltBjgP79s1s=;
        b=oclkTniVehEibzwkhAwUT1Lh5T03Uv50svuTx3YWSbWYQ3LkacJh6U844T2FRNCJ1x
         ykAHXxR8mzf1njf1cB4HUG51jmL/bX8WJYt9Ml1k2HLhKj3PQbg03GpRyHl1NnjbN6Xk
         +GX/6ij+k/6SbEaZp02ms//PR4tIxvyvNI4HSdnPWXGKttprnuNbsqYxpKL7xCOVGB2G
         1JDq0yCvjSmbTU/Z1TU/UJCWkQdz1rOrmT2nhyEE5fGYNan/RP3LOJNZS5FbB7ehRlbg
         ihOIY4WJeNQgQrOgra75cHufaJcYtJoRTjnPNBV/BcvZjuJ8WOhWwYfxlTKyur6mSrCO
         roFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786080777; x=1786685577;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=roc/IS/aTyNJNRiP/nrbSlyNrCVYc83nltBjgP79s1s=;
        b=Y3HFgTnhg02M2AcKbZ78YcuYajlvP+6oyMpKxGdTEIP8+jgmRDh3dddWsTo7otvvJq
         k/SB2OgYP8AyPAVUOIQuR4l45m84A2DB4HafDTBxoX54SwyE9Kwcy3sGV0jImwBHGzpB
         4lYB2CKNpkpOfyb18UBYwLJPpkQ7z+M9OZF5XcJ5Jc0b73EcDvDFiYU6N21ipVVB/qlA
         LvI6z2e+pdWTOEFc4hZWeIiLhZmBkhApro0ht00oV9v+nLFUN0NxjqkNFgK7Dkfn0Wx5
         r74L0jzRZ86qvAxzkyQfqbcV5lH2MdTIpyz3vZhSrPmQ8VjpYunn905D1g0Qv73eR/5k
         E1Tw==
X-Forwarded-Encrypted: i=1; AHgh+Rp+/DeMGDFf7JJnsVNa6ECPbur2sxBH+vRIF+uciI4rftYD7vMk2yCpwHIGASo4uooVGso=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyy75Lc1pfB+kkoybJHANCIhpic5xOY1m44U2zSJgLm544MtfYv
	OdrXV72kZ8RpKgIQRczI7Gg1K0OcUMf1KoY+gBHO1OkafXAcgJvie9Cs
X-Gm-Gg: AR+sD13mjXCKsGj/3EQLW3PpvL3ZSEAMz3aUFooK9rEeHCuKgOzZ3xi/fPeETHVF5a9
	EDYIqlc9IotrC+aH2ntOiWr3QdxjCNwMqR1aTnjgCT1pugHI5EuHzvCv6tbPGoDUGOMvFgN6hjN
	+gnIomDuaCDMzfWHoJOrbXbeLL7NftsL3X4xLcfFKUEYc15nk7kJtNl4iAzvdeoEmcLtmyW1cKz
	WZzAtg5CM4ufGAJewepZ4gMvMmMoYiSjLSyXEqeHdtzVyFW+poz3RXy2Wj+IFFirnHJ0dy7LgPC
	uk8dStSvjA/X5q0iubcVkDJ7iQGYVVIo+DfKsRpydHDdqeJ2oGC+PEL8/rGtHqHRderUK/waMwW
	y3Ub7x2+h3RQQFG37OWyLhzaXvbOx4mVcETdF12MO9tftuJqvQfQ+RH27EUZ4YPuefmHi+ZhFfj
	Yqg7eEmxq+ajZ/T4ZVqtqhit8yMSbP9wsDbeIfrkb1K3DfQ3wvF3DP0aSQl1twkrcubSW2ARaTB
	Z9tKCM=
X-Received: by 2002:a05:6a00:4fc4:b0:847:99bb:b6d8 with SMTP id d2e1a72fcca58-84f2e009b31mr21558233b3a.26.1786080776836;
        Thu, 06 Aug 2026 22:32:56 -0700 (PDT)
Received: from cyh-System-Product-Name.. ([129.227.183.200])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cbe8f19634dsm108940a12.7.2026.08.06.22.32.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 22:32:56 -0700 (PDT)
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
Subject: [PATCH v2 2/2] RISC-V: KVM: selftests: Add PMU event filter test
Date: Fri,  7 Aug 2026 13:32:27 +0800
Message-Id: <20260807053227.341700-3-yhchen312@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260807053227.341700-1-yhchen312@gmail.com>
References: <20260807053227.341700-1-yhchen312@gmail.com>
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

