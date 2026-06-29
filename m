Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 765133E867F;
	Mon, 29 Jun 2026 18:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782758283; cv=none; b=ZQa97jLaYkjOS4PfMUORtTd2ivT3JgwPa0Aeyi4evGVTaeXK5qiXBNSTBnkHLngzmrKvfVm7gTtoW8WhcpYg6XdVfciRZ+IVfY8vDX96wn4/uQ7cs5d8J3vD3jgZ/W8JXYMCtvYdkw6M2e0Z4JT0bB5rmrXlFbaBsKTBxFURVdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782758283; c=relaxed/simple;
	bh=QDjqNc7w6BO5BlPCa2mo0SomRl12uAe1D/IjKkU3y1o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q2G1w1b1wQ5wyL34sSA4X/czb7ELiZQkjXqm+ZDzYjbiWTc5IKk9ap1Sg91hn7zgFKfiVDHy5R2fU2NFrKc+YspixL4fmpq+INKNh9LsNuR7R1nyZGDW2lXEt7+Vq8/LDHGCrUOhU0iOAOwnrWXmXZUAtfIRiiQG03Dhh/y4ojU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HPkeO5qn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HPkeO5qn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32D3E1F00A3E;
	Mon, 29 Jun 2026 18:38:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782758282;
	bh=fiSlfqzHoXkAJbJkazUecIRx38pSa/4jEPodnNV/e80=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HPkeO5qn32OpRxnLFYBf24Tc3texk8NF+jET0DuMX0qAO0QOKVXhN7MknipPa821V
	 u/c339BM1RJB55NRaWNUYTgmffmqMzqg6NcbYK+R+9X5szeJ68F5ym340CrCgQn3Ov
	 KYNZO7OsyHd6jwvs1mk7Y+EDhFHyqUaEbUtXKUlanILKzDiAxiM0snxUY7SUeLiTrE
	 DF+eFc1bs+tgCOvk3p685KSM+bITicSbVh+K+v8MO0WLqLCA//Wb+QZPrD4cQ0x08C
	 x5f8wCJoZP3xwy48AOgStgCJzZyaJTT7KoNl7cjd5DQScZqrIQ/2d/i3ccNiBFJXy0
	 Ud4iRodAXzKbw==
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosry@kernel.org>
Subject: [PATCH v3 08/10] KVM: selftests: Trigger save+restore randomly in the #PF stress test
Date: Mon, 29 Jun 2026 18:37:43 +0000
Message-ID: <20260629183746.699840-9-yosry@kernel.org>
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
index 1b6f64bbcf937..bbbb5bb2a2ee1 100644
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
-		TEST_ASSERT_EQ(uc.args[1], count);
 
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
2.55.0.rc0.799.gd6f94ed593-goog

