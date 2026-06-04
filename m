Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6CEB4CA272;
	Thu,  4 Jun 2026 20:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780605365; cv=none; b=kHtCoNB4xY0z8Sd7enCJ8wTc/TgQC+HTwTg+v3042Il8XHCpiChZO/fm7L6cpPtGqWLyKZF0FS66qKaidMG8XZybv5hriYj5Kq9eEkyj9bZ3zXTUOSPTNrLW9DLp9Slgs5Vrx9EH/CCh7Vd+VIRoin0YusxePQhKkY1y9aYpbKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780605365; c=relaxed/simple;
	bh=8iBKASzbz9mlsV2tDL6ihk64B3BCpKYDiU7NsrNIa1k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mg3YtgPC8IpT+dI0ni+Bb2OgQbOR1Uog8IAGk2whpV1dKEBnefV8s/fg1HMSXBWTrY1OnifSQV1z8v+wCyS/fmb1pxINvwbSmIgQDo2iLG3rSk7OgzuSfK/BfAEUtaiA/M3ZXGSXcO9w9hCfdJ14mJXgSYM077CuvoO5hCcqtic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DsdXjiG9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DsdXjiG9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90AEB1F0089B;
	Thu,  4 Jun 2026 20:36:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780605362;
	bh=VsVTfc8q8V6S6PMSRT8ydmbG/vrsrRUOqsArdYthojc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DsdXjiG9GbOPWYH/5Mn5OIaekbHvRlV0WFKW+s3vVwJ32A5vPgBWAUkin1ek+tTLI
	 cY/9K/DwQgwHIXqIQL2I5e0AqXNQollFgKkNgQiCknboibnKUDv4QQMXiuXkvB5Eq7
	 hKmHkasH8baEZ1YzqpJdbFGr9xgkb3M6vshsFrV8b2CXWAXJ8/Nfsx+s5TiARoW7OX
	 dLio1Bsz6M5ZeXSlgUQ6v4sMeoFeAY9z15J9Vt8KDo4wAl9qS1WvpCHyLLmD11hB6L
	 7rjmjnJTlLu+Ea0skafFuK+/B+e/BGJEMAFnH1zV9IHx9ayVPqoaYnhFORz313CO6h
	 CDSxDQDq+ryAA==
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosry@kernel.org>
Subject: [PATCH v2 08/10] KVM: selftests: Trigger save+restore randomly in the #PF stress test
Date: Thu,  4 Jun 2026 20:35:44 +0000
Message-ID: <20260604203546.365658-9-yosry@kernel.org>
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
 .../kvm/x86/stress_save_restore_pf_test.c     | 59 ++++++++++++++++---
 1 file changed, 51 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86/stress_save_restore_pf_test.c b/tools/testing/selftests/kvm/x86/stress_save_restore_pf_test.c
index 622d102179e66..92efb7ac9d95f 100644
--- a/tools/testing/selftests/kvm/x86/stress_save_restore_pf_test.c
+++ b/tools/testing/selftests/kvm/x86/stress_save_restore_pf_test.c
@@ -5,6 +5,8 @@
 #include <errno.h>
 #include <sys/types.h>
 #include <time.h>
+#include <pthread.h>
+#include <signal.h>
 #include <unistd.h>
 
 #include "test_util.h"
@@ -94,15 +96,41 @@ static void guest_access_memory(void *arg)
 		/* Clear the present bit again so it faults next time */
 		*guest_get_pte(vaddr) &= ~pte_present_mask;
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
+		usleep(100);
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
 	int r, i, level, count = 0;
+	pthread_t sigusr_thread;
 	gpa_t gpa, pgtable_gpa;
 	struct kvm_vcpu *vcpu;
 	struct kvm_vm *vm;
@@ -151,18 +179,30 @@ int main(int argc, char *argv[])
 		pgtable_gpa = PTE_GET_PA(pte);
 	}
 
+	/* Initialize the thread sending SIGUSR and install the handler */
+	vcpu_sigusr_ignore();
+	r = pthread_create(&sigusr_thread, NULL, sigusr_thread_fn,
+			   (void *)pthread_self());
+	TEST_ASSERT(!r, "pthread_create() failed: %d", r);
+
 	while (count++ < NR_ITERATIONS) {
+		/*
+		 * Only handle SIGUSR while the vCPU is running, otherwise
+		 * ignore it to avoid interrupting other ioctls/syscalls.
+		 */
+		vcpu_sigusr_listen();
 		r = __vcpu_run(vcpu);
-		TEST_ASSERT(!r, "vcpu_run failed");
-		TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_IO);
-
-		get_ucall(vcpu, &uc);
-		if (uc.cmd == UCALL_ABORT) {
+		if (r == -1)
+			TEST_ASSERT_EQ(errno, EINTR);
+		vcpu_sigusr_ignore();
+
+		/* The guest only exits due to a signal or failed assertion */
+		if (!r) {
+			TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_IO);
+			TEST_ASSERT_EQ(get_ucall(vcpu, &uc), UCALL_ABORT);
 			REPORT_GUEST_ASSERT(uc);
 			break;
 		}
-		TEST_ASSERT_EQ(uc.cmd, UCALL_SYNC);
-		TEST_ASSERT_EQ(uc.args[1], count - 1);
 
 		state = vcpu_save_state(vcpu);
 
@@ -175,8 +215,11 @@ int main(int argc, char *argv[])
 	}
 
 	sync_global_from_guest(vm, guest_faults);
+	TEST_ASSERT(guest_faults > 0, "No guest page faults triggered");
 	pr_info("Guest page faults: %lu\n", guest_faults);
 
+	pthread_cancel(sigusr_thread);
+	pthread_join(sigusr_thread, NULL);
 	kvm_vm_free(vm);
 	return 0;
 }
-- 
2.54.0.1032.g2f8565e1d1-goog

