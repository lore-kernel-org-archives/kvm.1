Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ACA5436BC9;
	Mon, 27 Jul 2026 23:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785196370; cv=none; b=PEs6yWkkrQLVBixB6imLN7SgDinxNFjb1WJK6kMbfzFh85jjPEqBAJwwg7Y86LF/OdEund0+D3uIJO0nKb+MIunckahm5CrURVPA0AHuygRBQ6YiskqH+YAMEJmYzTGaQpCXno5ihQubDcCH2dLbp7vPSYzwF2Z9Sumrxh8QuOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785196370; c=relaxed/simple;
	bh=CdXmvVI/WClm8inGWUNHc14O4uSxMRjzxS7NDgvIHPU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NISHDapN6TWt+rMqO+qg89IVG0ONW7Afya2ApDbtgc/CRxhCmJoeh4fEdJkljahQqZN0euKl1wsFrb2O1ONVBMZC8ehXrWM7Z9EPhxK5MiHX9JYs8WooU/tXs5QD5AxXZP9jGYeM4T3JNuxTv8D6AKAM81dvmOZ4LOZAtFmjymM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NHvLeS+I; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NHvLeS+I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C91D61F00A3D;
	Mon, 27 Jul 2026 23:52:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785196369;
	bh=GP55Ggpml4LQEtyKFOMEAyc89EXT9kPnZgTodK2DKJo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NHvLeS+I3hiXrKRskoMaDgIhCoB80gfbtWt09p0ia46/A4BDHG+cNBb0s8TZyfTof
	 0AjHbEfeM7uRfGMxpXvO+B3odSN3RhtPh6V3u9SmZpE32HzmaoHiYzSq3zQ4JlSqFB
	 F20YiqoMk8rGDWpXI+l/Qku/LoZdKbZr/bSaDyMTl79lE8KR6jgJXF5jvL4UU0+3T4
	 IgRmog9qcFDb1o63UZzXVLeOeFekeu6HeuJX2+3c4kd3qfkGfNJL0LqTROJ86LW6Df
	 wO0ue5Yu51rLjW4o+l+2kyzezNNV6qs5miKjgFnpsMsVoA0jDsQuvhk1P94jnztjki
	 NvDHWsHYkc5yw==
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosry@kernel.org>
Subject: [PATCH v4 11/12] KVM: selftests: Support running stress save+restore and #PF test in L2
Date: Mon, 27 Jul 2026 23:52:27 +0000
Message-ID: <20260727235228.1007324-12-yosry@kernel.org>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
In-Reply-To: <20260727235228.1007324-1-yosry@kernel.org>
References: <20260727235228.1007324-1-yosry@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extend the stress test to allow running the access+#PF code in L2
instead of L1 by adding proper L1 guest code to bootstrap L2. By
default, the test runs in L2 after running in L1 if nested is supported.

Assisted-by: Gemini:gemini-3.1-pro
Signed-off-by: Yosry Ahmed <yosry@kernel.org>
---
 .../kvm/x86/save_restore_pf_stress_test.c     | 61 ++++++++++++++++++-
 1 file changed, 58 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86/save_restore_pf_stress_test.c b/tools/testing/selftests/kvm/x86/save_restore_pf_stress_test.c
index 664ed280b2e76..0e5ddeb5af444 100644
--- a/tools/testing/selftests/kvm/x86/save_restore_pf_stress_test.c
+++ b/tools/testing/selftests/kvm/x86/save_restore_pf_stress_test.c
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
 
@@ -81,6 +84,36 @@ static void guest_access_memory(void *arg)
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
@@ -108,7 +141,7 @@ static void vcpu_sigusr_ignore(void)
 	sigaction(SIGUSR1, &sa, NULL);
 }
 
-int main(int argc, char *argv[])
+static void run_test(bool nested)
 {
 	struct kvm_x86_state *state;
 	int r, i, level;
@@ -121,9 +154,17 @@ int main(int argc, char *argv[])
 	gva_t gva;
 	u64 pte;
 
-	vm = vm_create_with_one_vcpu(&vcpu, guest_access_memory);
+	vm = vm_create_with_one_vcpu(&vcpu, nested ? l1_guest_code : guest_access_memory);
 	vm_install_exception_handler(vm, PF_VECTOR, guest_pf_handler);
 
+	if (nested) {
+		if (kvm_cpu_has(X86_FEATURE_SVM))
+			vcpu_alloc_svm(vm, &gva);
+		else
+			vcpu_alloc_vmx(vm, &gva);
+		vcpu_args_set(vcpu, 1, gva);
+	}
+
 	/* Allocate a page and write the pattern to it */
 	gva = vm_alloc_page(vm);
 	*(u64 *)addr_gva2hva(vm, gva) = PATTERN;
@@ -194,10 +235,24 @@ int main(int argc, char *argv[])
 
 	sync_global_from_guest(vm, guest_faults);
 	TEST_ASSERT(guest_faults > 0, "No guest page faults triggered");
-	pr_info("Guest page faults: %lu\n", guest_faults);
+	pr_info("Guest page faults%s: %lu\n", nested ? " (in L2)" : "", guest_faults);
 
 	pthread_cancel(sigusr_thread);
 	pthread_join(sigusr_thread, NULL);
 	kvm_vm_free(vm);
+}
+
+int main(int argc, char *argv[])
+{
+	pr_info("Running save+restore stress test...\n");
+	run_test(/*nested=*/false);
+
+	if (!kvm_cpu_has(X86_FEATURE_SVM) && !kvm_cpu_has(X86_FEATURE_VMX)) {
+		pr_info("Nested virtualization not supported, skipping nested test\n");
+		return 0;
+	}
+
+	pr_info("Running save+restore stress test with a nested guest...\n");
+	run_test(/*nested=*/true);
 	return 0;
 }
-- 
2.55.0.229.g6434b31f56-goog

