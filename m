Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C464437859;
	Tue, 28 Jul 2026 17:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785260565; cv=none; b=J+YogdUhRQtKUsTQoZMD8eIGwPwlW5Hyi1yD5oA0iVmAnKwfTUaHnLdmSY9HZoVRtj0fnpMQsOVe/0oxA8ynAjP/qCuLpZ8Cg12a8K4MZ26Tmts4ouOMSGTaE3Zw604n1738EHYVA9/HSPfBpeu2QRnZy3u14jctPQrZlEL5hJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785260565; c=relaxed/simple;
	bh=oKnTegTqn88JBcgZigx5XF3a6iaWAYrJr6I1EBK5T1E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lZ3/HJzKpGa9Ihr41UiBxhe5oHRcjKO5wAsO7Q5Aoz/VdYhTEszdKQfyG06Vkun/gTprXwt3O0jLDlE9I6NO+GvEKXsbpoxkmODCBSvudC0UiR7EYC0x+fMumpVSWpQuA2Id1DvnTvL87uKW8kIuCtkoU9faqqw+vOlSYimcjqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QDHwz3zF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QDHwz3zF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8B181F00A3D;
	Tue, 28 Jul 2026 17:42:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785260562;
	bh=Do4wGOWcxIEgXqqDzEgkR+1JO02aORBnE1Rv4B6xzS0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QDHwz3zFedQMLh0BTdbkRSOHTs/tOErUMYVHw/baMEVVjhRwPhu0tIrO2ZdI7TG43
	 B4pNN2D+AuGMtPmxtIZ3MCKklHF+l2IAnKuhBJmLnBsqyjTFBKoYLg5Cp6ZRpJXRQS
	 JBDpFb0rdes7XtxyRZg8cg06jWN/WYcugYR6drPiKZ5CKhhKRcjYaKg6OcuZs36Uyl
	 Dgvt/ajsruXV1yollNdmQvtL646Iat9KNhhsYAICAPd0uINgrF0BbpB6bEe6clBYdm
	 NGyKooi9zj0dmuchsiedJ+aD8jz612eoT/44/9OuHbDASF3soI7rMQngOJVcGZH3UG
	 f5j1mrOxLL2Dw==
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosry@kernel.org>
Subject: [PATCH v5 11/13] KVM: selftests: Trigger save+restore randomly in the #PF stress test
Date: Tue, 28 Jul 2026 17:42:30 +0000
Message-ID: <20260728174232.2423257-12-yosry@kernel.org>
X-Mailer: git-send-email 2.55.0.487.gaf234c4eb3-goog
In-Reply-To: <20260728174232.2423257-1-yosry@kernel.org>
References: <20260728174232.2423257-1-yosry@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Instead of an explicit GUEST_SYNC() after each access+#PF, run another
thread that keeps sending SIGUSR to the vCPU thread, essentially
triggering exits to userspace and save+restore on random points in guest
execution. This makes the test a lot more meaningful as it opens the
door to exercising race conditions between #PF handling in the guest
and save+restore in the host.

The signals are ignored using SIG_IGN outside of __vcpu_run() to avoid
interrupting other ioctls/sysctls performed by the test.

Assisted-by: Gemini:gemini-3.1-pro
Signed-off-by: Yosry Ahmed <yosry@kernel.org>
---
 .../kvm/x86/save_restore_pf_stress_test.c     | 56 ++++++++++++++++---
 1 file changed, 49 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86/save_restore_pf_stress_test.c b/tools/testing/selftests/kvm/x86/save_restore_pf_stress_test.c
index 1f7e142e5cfec..4b5accec642c0 100644
--- a/tools/testing/selftests/kvm/x86/save_restore_pf_stress_test.c
+++ b/tools/testing/selftests/kvm/x86/save_restore_pf_stress_test.c
@@ -5,6 +5,8 @@
 #include <errno.h>
 #include <sys/types.h>
 #include <time.h>
+#include <pthread.h>
+#include <signal.h>
 #include <unistd.h>
 
 #include "test_util.h"
@@ -76,15 +78,41 @@ static void guest_access_memory(void *arg)
 		/* Clear the present bit again so it faults next time */
 		*guest_get_pte(vaddr) &= ~PTE_PRESENT_MASK(&guest_mmu);
 		invlpg(vaddr);
+	}
+}
+
+static void *sigusr_thread_fn(void *arg)
+{
+	pthread_t vcpu_thread = (pthread_t)arg;
 
-		GUEST_SYNC(guest_faults);
+	for (;;) {
+		pthread_testcancel();
+		pthread_kill(vcpu_thread, SIGUSR1);
+		usleep(msecs_to_usecs(1));
 	}
+	return NULL;
+}
+
+static void dummy_signal_handler(int signo) {}
+static struct sigaction sa;
+
+static void vcpu_sigusr_listen(void)
+{
+	sa.sa_handler = dummy_signal_handler;
+	sigaction(SIGUSR1, &sa, NULL);
+}
+
+static void vcpu_sigusr_ignore(void)
+{
+	sa.sa_handler = SIG_IGN;
+	sigaction(SIGUSR1, &sa, NULL);
 }
 
 int main(int argc, char *argv[])
 {
 	struct kvm_x86_state *state;
 	int r, i, level;
+	pthread_t sigusr_thread;
 	gpa_t gpa, pgtable_gpa;
 	struct kvm_vcpu *vcpu;
 	struct kvm_vm *vm;
@@ -128,18 +156,29 @@ int main(int argc, char *argv[])
 		pgtable_gpa = PTE_GET_PA(pte);
 	}
 
+	/* Initialize the thread sending SIGUSR and install the handler */
+	vcpu_sigusr_ignore();
+	r = pthread_create(&sigusr_thread, NULL, sigusr_thread_fn,
+			   (void *)pthread_self());
+	TEST_ASSERT(!r, "pthread_create() failed: %d", r);
+
 	for (i = 1; i <= NR_ITERATIONS; i++) {
+		/*
+		 * Only handle SIGUSR while the vCPU is running, otherwise
+		 * ignore it to avoid interrupting other ioctls/syscalls.
+		 */
+		vcpu_sigusr_listen();
 		r = __vcpu_run(vcpu);
-		TEST_ASSERT(!r, "vcpu_run failed");
-		TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_IO);
+		TEST_ASSERT(!r || errno == EINTR, "Expected success or SIGUSR1");
+		vcpu_sigusr_ignore();
 
-		get_ucall(vcpu, &uc);
-		if (uc.cmd == UCALL_ABORT) {
+		/* The guest only exits due to a signal or failed assertion */
+		if (!r) {
+			TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_IO);
+			TEST_ASSERT_EQ(get_ucall(vcpu, &uc), UCALL_ABORT);
 			REPORT_GUEST_ASSERT(uc);
 			break;
 		}
-		TEST_ASSERT_EQ(uc.cmd, UCALL_SYNC);
-		TEST_ASSERT_EQ(uc.args[1], i);
 
 		state = vcpu_save_state(vcpu);
 
@@ -153,8 +192,11 @@ int main(int argc, char *argv[])
 	pr_info("\n");
 
 	sync_global_from_guest(vm, guest_faults);
+	TEST_ASSERT(guest_faults, "No guest page faults triggered");
 	pr_info("Guest page faults: %lu\n", guest_faults);
 
+	pthread_cancel(sigusr_thread);
+	pthread_join(sigusr_thread, NULL);
 	kvm_vm_free(vm);
 	return 0;
 }
-- 
2.55.0.487.gaf234c4eb3-goog

