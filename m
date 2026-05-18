Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB30F397E81;
	Mon, 18 May 2026 20:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779135926; cv=none; b=lkpH/04sa1817msFJC3/yb/jpEd3PSNpitIhsSOSGNE7A+bofcOPXZp4IH91fNcWY8hbmMDXjfYXP/AAgJxzX5lGFC+AzGXn81gQGCWJW6Kg2DiuYD9pyqxFZGcp1YgpRBqs06zNepmdbpz0obSv3uxzOjsFUC4C28pBLCkJcP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779135926; c=relaxed/simple;
	bh=3W1mqMj3S3aKcUENCuMkekxQJwZQe9cxUP021hxxxmk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=plWqVBCMd/QVPiAVwgEV94hQYaTtaEn7NQIi4sewj2Kz1lSam98RV+iybL7Zbr53r7meO1rvATkDcv01KJVebVXo1aBfuyHvG5+v9RglP5EglDza4hvBDDEQEHbnUUeC2wTu1aqtbuCEkeKd5L0YHx/ztlan2Q51nk99EBpeX4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OZcfQyPI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OZcfQyPI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73DB1C2BCF6;
	Mon, 18 May 2026 20:25:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779135926;
	bh=3W1mqMj3S3aKcUENCuMkekxQJwZQe9cxUP021hxxxmk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OZcfQyPI2PDjZOPrvDruwHit2hMiyPaPDTRyBt6SE3c9DnMXcmYrCD97XYzU9ZWmQ
	 Odbl5qY4dP5HTenO3BkZ5fY+nRchwQ83diNSBX00ItyZmE+q7OUYR/brRNfHRikk15
	 o6Lezeqa2nLbwa0sDQo1eTLLOd/To46lfbQfc7NBJvEyluFdBtZAvSGKs9JZP1f7Dc
	 H+dEIzntxK7clIbBlKOHGwDxyjBAitLzAS9vXg7fF+BUvZSglEJ9f/mFT9O4piQr7R
	 1MuPc1k4SziaGJ9cz1Xnporv8XTWZQBN7gi0gNCns8QPIum9VB0f4suYDBCGXArvug
	 Dzc9xkSX2Ying==
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosryahmed@google.com>,
	Yosry Ahmed <yosry@kernel.org>
Subject: [PATCH 7/8] KVM: selftests: Support running stress save+restore and #PF test in L2
Date: Mon, 18 May 2026 20:25:13 +0000
Message-ID: <20260518202514.2037078-8-yosry@kernel.org>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
In-Reply-To: <20260518202514.2037078-1-yosry@kernel.org>
References: <20260518202514.2037078-1-yosry@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yosry Ahmed <yosryahmed@google.com>

Extend the stress test to allow running the access+#PF code in L2
instead of L1 by adding proper L1 guest code to bootstrap L2. The test
runs in nested mode if a '-n' flag is added.

Signed-off-by: Yosry Ahmed <yosry@kernel.org>
---
 .../kvm/x86/stress_save_restore_pf_test.c     | 75 ++++++++++++++++++-
 1 file changed, 73 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86/stress_save_restore_pf_test.c b/tools/testing/selftests/kvm/x86/stress_save_restore_pf_test.c
index 60a013e0f14fb..ec3d36d6e4846 100644
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
 
@@ -26,6 +29,8 @@
 #define NR_TEST_ADDRS		512
 #define PATTERN			0xabcdefabcdefabcdULL
 
+#define L2_GUEST_STACK_SIZE	64
+
 #define PTRS_PER_PTE		512
 #define PXD_INDEX(vaddr, level)	(((vaddr) >> PG_LEVEL_SHIFT(level)) & (PTRS_PER_PTE - 1))
 
@@ -104,6 +109,41 @@ static void guest_access_memory(void *arg)
 	}
 }
 
+static void l1_svm_code(struct svm_test_data *svm)
+{
+	unsigned long l2_guest_stack[L2_GUEST_STACK_SIZE];
+
+	generic_svm_setup(svm, guest_access_memory, &l2_guest_stack[L2_GUEST_STACK_SIZE]);
+
+	run_guest(svm->vmcb, svm->vmcb_gpa);
+	GUEST_ASSERT(false);
+}
+
+static void l1_vmx_code(struct vmx_pages *vmx)
+{
+	unsigned long l2_guest_stack[L2_GUEST_STACK_SIZE];
+
+	GUEST_ASSERT(prepare_for_vmx_operation(vmx));
+	GUEST_ASSERT(load_vmcs(vmx));
+	prepare_vmcs(vmx, guest_access_memory, &l2_guest_stack[L2_GUEST_STACK_SIZE]);
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
@@ -131,6 +171,25 @@ static void vcpu_sigusr_ignore(void)
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
@@ -139,12 +198,24 @@ int main(int argc, char *argv[])
 	int r, i, count = 0;
 	struct kvm_vm *vm;
 	struct ucall uc;
+	bool nested;
 	gva_t gva;
 	gpa_t gpa;
 
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
@@ -202,7 +273,7 @@ int main(int argc, char *argv[])
 	}
 
 	sync_global_from_guest(vm, guest_accesses);
-	pr_info("Guest page accesses: %lu\n", guest_accesses);
+	pr_info("Guest page accesses%s: %lu\n", nested ? " (from L2)" : "", guest_accesses);
 
 	pthread_cancel(sigusr_thread);
 	pthread_join(sigusr_thread, NULL);
-- 
2.54.0.563.g4f69b47b94-goog

