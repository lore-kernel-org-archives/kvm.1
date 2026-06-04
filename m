Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B4D4CA28E;
	Thu,  4 Jun 2026 20:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780605364; cv=none; b=UuUk9nq3YKrFAOF2T+HOq8ddp9l5JySFYtsrNPyyXMmEuXiUO0cO/YWwshRiPyVXZHGm1okPJdlcpOtMJLW+oIw4CnQoOgeX7SqSMUZugtYZb31Rtup+96Jpu9pcgrrSvWYTxROY+LRyTOHpwBQ4tJm6Ke780aPgx4AjhCTl2Ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780605364; c=relaxed/simple;
	bh=jYDcP1j84C4u3f4AWfEcCd2MRGkrmQ+VaR17b6rbbk0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RAGj96nkSxQewtZ6PogKnc73JA6ESHlzNlnAwQ7mB7bhL+xCxaRsgRglYKtKlY1KW/JoMEUBDwrXwMRoJV/4p+pua+MzhmmH9AQNgZ7zPK3kkNvIQS7oRQ6KIwqBkCGtzVT59Ys+k8St503lCl+Ug0n/quazB9qdIBRidV9i/ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZHNFg7TL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZHNFg7TL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E74801F0089C;
	Thu,  4 Jun 2026 20:36:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780605363;
	bh=i/TIB41PHxWTXJyWP5r4IoLt45r+2twsxHvTX+LHVr0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZHNFg7TL+XnYcX0olqhU6rn7MBVxy0m7tm4oIfzK/uxV0hn8FUhAkMi9KmGpQg8I6
	 9C8gBxiYKqAbcPv4FyvqlXK2xPC65FI+7NXFBm3t45EFM3F91RNX/unsHMXtM97mfz
	 xpVXikvzOt6f5sH2FQb9lQcrsr5+CIuriLJsWXy4GCR0xAf3lmES2iyroZdNbb2Zde
	 r09a6W+i3A6AFYog2fQOsq9RsrwCfPEqAmOLn2oRpCA7zNOBWYXDB3gW4sNMIICLwy
	 xcBg/mHm9byWxlnt0XplJ06DGLYONH1sE37i59pWNE5SjbaWqpXVO0/Z/vYqujCnCG
	 fwBwXIRu0YZCA==
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosry@kernel.org>
Subject: [PATCH v2 09/10] KVM: selftests: Support running stress save+restore and #PF test in L2
Date: Thu,  4 Jun 2026 20:35:45 +0000
Message-ID: <20260604203546.365658-10-yosry@kernel.org>
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
In-Reply-To: <20260604203546.365658-1-yosry@kernel.org>
References: <20260604203546.365658-1-yosry@kernel.org>
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
 .../kvm/x86/stress_save_restore_pf_test.c     | 75 ++++++++++++++++++-
 1 file changed, 73 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86/stress_save_restore_pf_test.c b/tools/testing/selftests/kvm/x86/stress_save_restore_pf_test.c
index 92efb7ac9d95f..c285ef093400d 100644
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
 
@@ -25,6 +28,8 @@ do {								\
 	fflush(stdout);						\
 } while (0)
 
+#define L2_GUEST_STACK_SIZE	64
+
 #define PTRS_PER_PTE		512
 #define PXD_INDEX(vaddr, level)	(((vaddr) >> PG_LEVEL_SHIFT(level)) & (PTRS_PER_PTE - 1))
 
@@ -99,6 +104,41 @@ static void guest_access_memory(void *arg)
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
@@ -126,6 +166,25 @@ static void vcpu_sigusr_ignore(void)
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
@@ -136,12 +195,24 @@ int main(int argc, char *argv[])
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
@@ -216,7 +287,7 @@ int main(int argc, char *argv[])
 
 	sync_global_from_guest(vm, guest_faults);
 	TEST_ASSERT(guest_faults > 0, "No guest page faults triggered");
-	pr_info("Guest page faults: %lu\n", guest_faults);
+	pr_info("Guest page faults%s: %lu\n", nested ? " (in L2)" : "", guest_faults);
 
 	pthread_cancel(sigusr_thread);
 	pthread_join(sigusr_thread, NULL);
-- 
2.54.0.1032.g2f8565e1d1-goog

