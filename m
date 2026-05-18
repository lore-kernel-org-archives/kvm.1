Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E15396591;
	Mon, 18 May 2026 20:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779135926; cv=none; b=i4Qgpbe/ZWA67N2XLmNyuMcuWgROp5DNdUYfUvhd6+oj/GMnzB5M3PgxVM6nQCTjSOWGjuwoMMNPTtLZlqIBUpqQdrswSodo7SK4q3d9yNjAr8oCQhQhgHo7MzBJxVTn/CI75bq+bzW/tVqjBwWOwBX8itI+wrcKotS4PKlpSeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779135926; c=relaxed/simple;
	bh=mAo+nNH9B73epRdJSYz4wQGFb0T3sYNTm3+FkEL+Dl8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P1hlfJq0e0qgEHjkbDlXT8JnqH4Hepr3kFyPew66zhCJM6xU/cCYCO8mdz6Gwc0p1+2d7VJVBwAAxPtj0DWZuznm/OYN3gJfMS6tLDRoed05BiUXNWTKckvC7JRv1dujqkYjYtb6esjKHBpsXEN9N6Ps+1EhwlG8HVca/+sAuIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GLLyCX9H; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GLLyCX9H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1163EC2BCC6;
	Mon, 18 May 2026 20:25:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779135926;
	bh=mAo+nNH9B73epRdJSYz4wQGFb0T3sYNTm3+FkEL+Dl8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GLLyCX9H4Kr4vbiBMGoOMN6XW1G7e6nsrqa89blRaChUBFByh/bleDRfMF6FmJy6o
	 EJfFK9s1yNkRWs2Gw8xIKOPTSDtPDrzVxY4g1m48BQ4wVMJrbGwlXkv39Fpe4e0iUT
	 jxmb0eJYBomlPi5jXUxnC0OJ1L8SJTopzTNqDFyvxACUthrxK7UmlQDS6B1E0Bk6BX
	 IBEDw1yLXQZL9+jz6NvAGWH6IYqRub9FwgvrnG3KOryOVQumH3+rhjtjowUBS1at+O
	 tH3Yv1GhMq//khljfbvdGVGcp52YW7OPdVopiQ9xbWor56sPCCAbr8061I9M3FqbWA
	 rjQOLAJRFkhKw==
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosryahmed@google.com>,
	Yosry Ahmed <yosry@kernel.org>
Subject: [PATCH 6/8] KVM: selftests: Trigger save+restore randomly in the #PF stress test
Date: Mon, 18 May 2026 20:25:12 +0000
Message-ID: <20260518202514.2037078-7-yosry@kernel.org>
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

Instead of an explicit GUEST_SYNC() after each access+#PF, run another
thread that keeps sending SIGUSR to the vCPU thread, essentially
triggering exits to userspace and save+restore on random points in guest
execution. This makes the test a lot more meaningful as it opens the
door to exercising race conditions between #PF handling in the guest
and save+restore in the host.

The signals are ignored using SIG_IGN outside of __vcpu_run() to avoid
interrupting other ioctls/sysctls performed by the test.

Signed-off-by: Yosry Ahmed <yosry@kernel.org>
---
 .../kvm/x86/stress_save_restore_pf_test.c     | 56 ++++++++++++++++---
 1 file changed, 48 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86/stress_save_restore_pf_test.c b/tools/testing/selftests/kvm/x86/stress_save_restore_pf_test.c
index 12da74b4f725c..60a013e0f14fb 100644
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
@@ -99,14 +101,40 @@ static void guest_access_memory(void *arg)
 		/* Clear the present bit again so it faults next time */
 		*guest_get_pte(vaddr) &= ~pte_present_mask;
 		invlpg(vaddr);
+	}
+}
+
+static void *sigusr_thread_fn(void *arg)
+{
+	pthread_t vcpu_thread = (pthread_t)arg;
 
-		GUEST_SYNC(guest_accesses);
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
+	pthread_t sigusr_thread;
 	struct kvm_vcpu *vcpu;
 	int r, i, count = 0;
 	struct kvm_vm *vm;
@@ -140,18 +168,28 @@ int main(int argc, char *argv[])
 	/* Map the page tables so that the guest #PF handler can walk them */
 	virt_map_page_tables(vm);
 
+	/* Initialize the thread sending SIGUSR and install the handler */
+	pthread_create(&sigusr_thread, NULL, sigusr_thread_fn,
+		       (void *)pthread_self());
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
+		/* The guest only exists due to a signal or failed assertion */
+		if (!r) {
+			TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_IO);
+			TEST_ASSERT_EQ(get_ucall(vcpu, &uc), UCALL_ABORT);
 			REPORT_GUEST_ASSERT(uc);
 			break;
 		}
-		TEST_ASSERT_EQ(uc.cmd, UCALL_SYNC);
-		TEST_ASSERT_EQ(uc.args[1], count - 1);
 
 		state = vcpu_save_state(vcpu);
 
@@ -166,6 +204,8 @@ int main(int argc, char *argv[])
 	sync_global_from_guest(vm, guest_accesses);
 	pr_info("Guest page accesses: %lu\n", guest_accesses);
 
+	pthread_cancel(sigusr_thread);
+	pthread_join(sigusr_thread, NULL);
 	kvm_vm_free(vm);
 	return 0;
 }
-- 
2.54.0.563.g4f69b47b94-goog

