Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF74B3F6C4D;
	Mon, 29 Jun 2026 18:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782758285; cv=none; b=A9CnCtMHE/4w3/fVZAmWZgLDVl2/r08psm3go02ENpcqnGrObCeQolt2fjTqlpIjpGUHipkjgCd8M/BG24oI7ISMtQ1rfleV0bqn3CXqaCTPR35myYeAuOgCZV2tvOP0taKVcjqeYcspR4i51/zVxrRMZ0+MBjHoICPYje/mpxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782758285; c=relaxed/simple;
	bh=IPae5YGN57egAlA4K3wo2v/W3TwME+M3gdsBVU6RH+o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZqZhYKzq6u13s0U14LtzVsyd5fXx3lYxSGDNbcxKMnEs6m2hRv0tnnBEyFKkbRp5j2vJ2RrhR7roj47OEHNLh/PvqrQLJrEBJtl6I23EeV2YS3EZFPFcmxPMkSPd18uVzGPPb4U1F0ASML5MUAvUHzd65OB7SPD/DZKbEFugmlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JLSWFBl+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JLSWFBl+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 861761F00A3F;
	Mon, 29 Jun 2026 18:38:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782758282;
	bh=bZ+H7h35t+oOdDOqM68YUXk/FPO7as3W8d8Ot/ijoWk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JLSWFBl+TqD/OIMZ2iPDs6VU4/+bwnPFJZavRIF1QncbS5gHut67/fHCYP5KKU4Ts
	 XWD3rAEFucLd9Ml6UA7vCUiaMk/1Oz4iHo941ppuxACwn+dq4eU+xJTiHPKH8mEV9r
	 y0nq9rK8MO0Gm6gXpCFObUF6QQv8XKdK4Y5npdxkIyWnUg2XoSxpIvqrt0MYKeTiqU
	 N0l5NVdssdL2C4czLuEhPS5rwi7i24EfQUinPcVkh7kDm+L50uNLfopw0h8BLDpu6Z
	 TtiB0mhXtBGoD0fYkv4YCH30WRzSBB3HbFM5gK8VeQ0e9UODF4zRjgfn5/puHaGgEb
	 za8d2fnKdjqxg==
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosry@kernel.org>
Subject: [PATCH v3 09/10] KVM: selftests: Support running stress save+restore and #PF test in L2
Date: Mon, 29 Jun 2026 18:37:44 +0000
Message-ID: <20260629183746.699840-10-yosry@kernel.org>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
In-Reply-To: <20260629183746.699840-1-yosry@kernel.org>
References: <20260629183746.699840-1-yosry@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extend the stress test to allow running the access+#PF code in L2
instead of L1 by adding proper L1 guest code to bootstrap L2. The test
runs in nested mode if a '-n' flag is added.

Assisted-by: Gemini:gemini-3.1-pro
Signed-off-by: Yosry Ahmed <yosry@kernel.org>
---
 .../kvm/x86/stress_save_restore_pf_test.c     | 68 ++++++++++++++++++-
 1 file changed, 66 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86/stress_save_restore_pf_test.c b/tools/testing/selftests/kvm/x86/stress_save_restore_pf_test.c
index bbbb5bb2a2ee1..9ab52d27a61d9 100644
--- a/tools/testing/selftests/kvm/x86/stress_save_restore_pf_test.c
+++ b/tools/testing/selftests/kvm/x86/stress_save_restore_pf_test.c
@@ -8,10 +8,13 @@
 #include <pthread.h>
 #include <signal.h>
 #include <unistd.h>
+#include <getopt.h>
 
 #include "test_util.h"
 #include "kvm_util.h"
 #include "processor.h"
+#include "svm_util.h"
+#include "vmx.h"
 
 #define NR_ITERATIONS		500
 
@@ -99,6 +102,36 @@ static void guest_access_memory(void *arg)
 	}
 }
 
+static void l1_svm_code(struct svm_test_data *svm)
+{
+	generic_svm_setup(svm, guest_access_memory);
+	run_guest(svm->vmcb, svm->vmcb_gpa);
+	GUEST_ASSERT(false);
+}
+
+static void l1_vmx_code(struct vmx_pages *vmx)
+{
+	GUEST_ASSERT(prepare_for_vmx_operation(vmx));
+	GUEST_ASSERT(load_vmcs(vmx));
+	prepare_vmcs(vmx, guest_access_memory);
+
+	/* Ignore any #PF */
+	GUEST_ASSERT(!vmwrite(EXCEPTION_BITMAP, BIT(PF_VECTOR)));
+	GUEST_ASSERT(!vmwrite(PAGE_FAULT_ERROR_CODE_MASK, 0));
+	GUEST_ASSERT(!vmwrite(PAGE_FAULT_ERROR_CODE_MATCH, -1));
+
+	GUEST_ASSERT(!vmlaunch());
+	GUEST_ASSERT(false);
+}
+
+static void l1_guest_code(void *test_data)
+{
+	if (this_cpu_has(X86_FEATURE_SVM))
+		l1_svm_code(test_data);
+	else
+		l1_vmx_code(test_data);
+}
+
 static void *sigusr_thread_fn(void *arg)
 {
 	pthread_t vcpu_thread = (pthread_t)arg;
@@ -126,6 +159,25 @@ static void vcpu_sigusr_ignore(void)
 	sigaction(SIGUSR1, &sa, NULL);
 }
 
+static bool parse_args_nested(int argc, char *argv[])
+{
+	bool nested = false;
+	int opt;
+
+	while ((opt = getopt(argc, argv, "n")) != -1) {
+		switch (opt) {
+		case 'n':
+			nested = true;
+			break;
+		default:
+			printf("Usage: %s [-n]\n", argv[0]);
+			exit(1);
+		}
+	}
+
+	return nested;
+}
+
 int main(int argc, char *argv[])
 {
 	struct kvm_x86_state *state;
@@ -136,12 +188,24 @@ int main(int argc, char *argv[])
 	struct kvm_vm *vm;
 	struct ucall uc;
 	u64 *pgtable;
+	bool nested;
 	gva_t gva;
 	u64 pte;
 
-	vm = vm_create_with_one_vcpu(&vcpu, guest_access_memory);
+	nested = parse_args_nested(argc, argv);
+
+	vm = vm_create_with_one_vcpu(&vcpu, nested ? l1_guest_code : guest_access_memory);
 	vm_install_exception_handler(vm, PF_VECTOR, guest_pf_handler);
 
+	if (nested) {
+		TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_SVM) || kvm_cpu_has(X86_FEATURE_VMX));
+		if (kvm_cpu_has(X86_FEATURE_SVM))
+			vcpu_alloc_svm(vm, &gva);
+		else
+			vcpu_alloc_vmx(vm, &gva);
+		vcpu_args_set(vcpu, 1, gva);
+	}
+
 	pte_present_mask = PTE_PRESENT_MASK(&vm->mmu);
 	pte_huge_mask = PTE_HUGE_MASK(&vm->mmu);
 	sync_global_to_guest(vm, pte_present_mask);
@@ -216,7 +280,7 @@ int main(int argc, char *argv[])
 
 	sync_global_from_guest(vm, guest_faults);
 	TEST_ASSERT(guest_faults > 0, "No guest page faults triggered");
-	pr_info("Guest page faults: %lu\n", guest_faults);
+	pr_info("Guest page faults%s: %lu\n", nested ? " (in L2)" : "", guest_faults);
 
 	pthread_cancel(sigusr_thread);
 	pthread_join(sigusr_thread, NULL);
-- 
2.55.0.rc0.799.gd6f94ed593-goog

