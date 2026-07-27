Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF72B435A8D;
	Mon, 27 Jul 2026 23:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785196370; cv=none; b=cpGIvODaJEauKrWLSaVjaq0sObfX6sW6++x5PGRNjXN49k0VNdSpAwpVsb3FSyd0GNNJxec79ai3P2RKVrILAD+C3H/7SWW0EAvJ4WIWn0eQQuksXrc48YD1DsAbFi0bdUrhN4hSJ7PYHHXiIiFqa5P64HW3FPbwAt7WvEd2zzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785196370; c=relaxed/simple;
	bh=DzdwvsLQnQVnSaQQz2ybvbhRCOyodV45xMfWCDF4WTw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uZsiHOm3C4NI8/tkRMHdR2YIXag8QDXBw6L5SdUqBysbSB9UlmTzjbPGzVtxvHec5+iPjyAeqmwvaedSMdT4NyxvgKSDjup5XEcA4wRjO0eDRuqZLVMrRCuapRf3cavRQwiZECGmeUrkPh0BRaqBgmI9y9Sy+u73KSEJJ9i5/QE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D8w1gX1O; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D8w1gX1O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 738E91F00AC4;
	Mon, 27 Jul 2026 23:52:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785196368;
	bh=ZJTnYhYbQkorkJd5CPfCk8qhPIp0eWbw/7ro1vrHox8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=D8w1gX1O2oSKzgr8ltAJp9KGDe91F150RLAe3lkDI2pJ3IKeyRye9IgCfDaY2Y6ht
	 bvCRiCeWRUvdsufxw6KmMZLiQFRe9hYk3UYjgkpL+R14CTV/ux8e6pqpsqabrWS1IW
	 r1ulg+ATkbvWCfZJvxkmiFafPfxRxYL/glDjYBBgxMa4DN4t+UFsNnWcLlzFcWgbUD
	 1nlIzQvBShYdELYb3IHqFwPWJ5hA54QLTGkRdl+nmwzLrGP9ZlyvTNBJ7RXiffQC7O
	 Pfn3y3ESFhEAZPZbU2pYnJitQDa7xChS+/2csf9kC7E6nqylBjkqpfy7LRESWbZMDg
	 JqNOlvPKyIxdg==
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosry@kernel.org>
Subject: [PATCH v4 10/12] KVM: selftests: Trigger save+restore randomly in the #PF stress test
Date: Mon, 27 Jul 2026 23:52:26 +0000
Message-ID: <20260727235228.1007324-11-yosry@kernel.org>
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
 .../kvm/x86/save_restore_pf_stress_test.c     | 59 ++++++++++++++++---
 1 file changed, 51 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86/save_restore_pf_stress_test.c b/tools/testing/selftests/kvm/x86/save_restore_pf_stress_test.c
index 1f7e142e5cfec..664ed280b2e76 100644
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
@@ -128,18 +156,30 @@ int main(int argc, char *argv[])
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
-		TEST_ASSERT_EQ(uc.args[1], i);
 
 		state = vcpu_save_state(vcpu);
 
@@ -153,8 +193,11 @@ int main(int argc, char *argv[])
 	pr_info("\n");
 
 	sync_global_from_guest(vm, guest_faults);
+	TEST_ASSERT(guest_faults > 0, "No guest page faults triggered");
 	pr_info("Guest page faults: %lu\n", guest_faults);
 
+	pthread_cancel(sigusr_thread);
+	pthread_join(sigusr_thread, NULL);
 	kvm_vm_free(vm);
 	return 0;
 }
-- 
2.55.0.229.g6434b31f56-goog

