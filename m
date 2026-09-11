Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E24A3F65F7
	for <kvm@vger.kernel.org>; Fri, 11 Sep 2026 19:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789153838; cv=none; b=iOI84gx2xscqPjf6V2M2l7RjAZY5L0oDanpYH6+/O1W/9/+qFXsME2HvBH7gwOXnfltMIUVdiqYGmvJCOLTRwL8SJLhSie3ycJUjEuVs2rCNQM7owMmj1pkrA1Iyin1Z7inCLsbRJVQJUQ9Wo1Sv9Ww5BYAZqn+0yaFoAg4JWQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789153838; c=relaxed/simple;
	bh=vyMzPnz2TmZhBXy6xeTGPazIedheXmUq5F+asiN5JeA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BSfmrhMpidf4Lk/GkFhuteYx3vhFveRmcfMkxW9SCqn3EGdtSeS9cZQ+sjBVKCDj/750zjsvDpzCP1qc37aJorYGaWKMoDJVCrr1xtlnAaS8XtT5AvfFuJdCUZfC9CGPJ3jaGRYEPVULLoGuKfanXK4PtjEb7G8BAnW0k+HgLpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rFkSRHsl; arc=none smtp.client-ip=209.85.210.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rFkSRHsl"
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-8623e5d4279so2402765b3a.1
        for <kvm@vger.kernel.org>; Fri, 11 Sep 2026 12:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789153831; x=1789758631; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aYJ3q/PWHxSDzZK8mLX9eezWSce2XRbm0G9gH/LJPZY=;
        b=rFkSRHsli+Ru2igQ2mqihlLPV1jDIdR/T+6q/pa1Lcqo4bD1PiGOyoyk+RwqnEEtVl
         ybfUXMFGcYYnIu9Bgp79j6pPQUygJ6sv3TJtLtfS0/sUPQQ9xPvBDTJU4XzYTNCsew7X
         36YYcYlfIlze7X/N8kqBw5YvD74R1//ZXbxTTXyWNF92H3CYupZ8K+Ifzs/LOaoY1kcS
         gLET0fpwwRcsWKcCg461F00XOo62YadWZAewubatysDQakqrK8GIAF5c6pnldfrku9Ks
         x5YiC7xOgWVDMgJs9h2WuTiYdSxYYCnwkLFK9WTIsVac4KUdo2Uz2Z+0CEhAqgQ7XJ16
         yrvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789153831; x=1789758631;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aYJ3q/PWHxSDzZK8mLX9eezWSce2XRbm0G9gH/LJPZY=;
        b=Pw0v3hOw1TBcRC761ePG0jTkOBxo8S+9+2uddLX2fYr3sy1sdTHkpXZZ0vPRjYLdC0
         ZMlgRPr764M+aj8NiPXSX0q9FO5P6uYTGVwmxzzqVlqSlB8JcBq03xgkS1nFq6XEMu7/
         73V51nbnJjr0GU9q4ch6ehOhzlqaxYCV1NX+nOm+GTe5jZR34C6dCd0N/P3UFUKdsDsK
         mBBTAOYg0uJCoeDJGq7XD+ykWj75825KMy73QXoPhjml3MeplcJycX8rYXf+IK+P+3Op
         W13ZNPkuYnqKyyivbNeD+B6mba5+vSZGTt4TBjmXtb+4yxAKqD2P0+eGHW/SoX5VuXLl
         szhQ==
X-Forwarded-Encrypted: i=1; AKwUvBxTEx3PNoRxXZaHpxXN9YAp2c+rb9QqoX0M+P3ioHA4mRDtbl7RhxBeWM3JcB1+1trFcyQ=@vger.kernel.org
X-Gm-Message-State: AFuF++mCnJ7pmoqvwAECYLhaUZtS6C4jjhDysyCfbNsnP2/4wXR+9Bp/
	Un6hiBdloPqOfH6RnFvt+WqUQLnTj6j9KHRHq/I+FjKm2gdl2XPE/19BXO19IWgHz2iyJvyDqzP
	q9m4uaDeqK6aFzg==
X-Received: from pfbly23.prod.google.com ([2002:a05:6a00:7597:b0:851:8e56:35d3])
 (user=jmattson job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:6f63:b0:86b:43b6:c3f5 with SMTP id d2e1a72fcca58-86b43b6ca48mr7613895b3a.9.1789153830858;
 Fri, 11 Sep 2026 12:10:30 -0700 (PDT)
Date: Fri, 11 Sep 2026 12:10:11 -0700
In-Reply-To: <aqREBvLRKgD5cGgk@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <aqREBvLRKgD5cGgk@google.com>
X-Mailer: git-send-email 2.55.0.1032.g73a4cd73de-goog
Message-ID: <20260911191011.528460-1-jmattson@google.com>
Subject: [PATCH] KVM: selftests: Add test for shadow VMCS flush during vCPU teardown
From: Jim Mattson <jmattson@google.com>
To: Sean Christopherson <seanjc@google.com>
Cc: James Houghton <jthoughton@google.com>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	Yosry Ahmed <yosry@kernel.org>, Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="UTF-8"

As requested, a half-baked selftest. :)

I dropped stable from the cc list.

When a vCPU is destroyed while L2 is active and VMCS shadowing is
enabled, KVM synthesizes a nested VM-Exit. This flushes the cached
shadow VMCS12 back to guest memory. However, on process exit, do_exit()
calls exit_mm() before closing file descriptors. KVM teardown runs
with current->mm == NULL on a borrowed lazy TLB active_mm.
Consequently, nested_flush_cached_shadow_vmcs12() writes the shadow
VMCS12 into whatever address space is active on that CPU.

Add a selftest to verify this behavior. The test runs a victim process
and a nested VMM process on the same physical CPU. The victim process
maps a page and fills it with canary bytes. The VMM sets up an L2 guest
with VMCS shadowing mapped at the identical host virtual address using
MAP_FIXED_NOREPLACE. When the VMM exits with open file descriptors, the
victim yields the CPU while the VMM terminates. This scheduling
heuristic attempts to hit the race window where VMM teardown runs under
the victim's active_mm and flushes the shadow VMCS into the victim's
address space.

---
 tools/testing/selftests/kvm/Makefile.kvm      |   1 +
 .../kvm/x86/vmx_shadow_vmcs_teardown_test.c   | 317 ++++++++++++++++++
 2 files changed, 318 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/x86/vmx_shadow_vmcs_teardown_test.c

diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
index 5e2fcee198f2..2aa9cc75fbd7 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -143,6 +143,7 @@ TEST_GEN_PROGS_x86 += x86/vmx_exception_with_invalid_guest_state
 TEST_GEN_PROGS_x86 += x86/vmx_msrs_test
 TEST_GEN_PROGS_x86 += x86/vmx_invalid_nested_guest_state
 TEST_GEN_PROGS_x86 += x86/vmx_nested_la57_state_test
+TEST_GEN_PROGS_x86 += x86/vmx_shadow_vmcs_teardown_test
 TEST_GEN_PROGS_x86 += x86/apic_bus_clock_test
 TEST_GEN_PROGS_x86 += x86/xapic_ipi_test
 TEST_GEN_PROGS_x86 += x86/xapic_state_test
diff --git a/tools/testing/selftests/kvm/x86/vmx_shadow_vmcs_teardown_test.c b/tools/testing/selftests/kvm/x86/vmx_shadow_vmcs_teardown_test.c
new file mode 100644
index 000000000000..e0863ef20d3e
--- /dev/null
+++ b/tools/testing/selftests/kvm/x86/vmx_shadow_vmcs_teardown_test.c
@@ -0,0 +1,317 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * vmx_shadow_vmcs_teardown_test
+ *
+ * Verify that destroying a nested VMM with active shadow VMCS12 does not
+ * flush the cached shadow VMCS into an unrelated process memory space
+ * during process exit in lazy TLB mode.
+ */
+
+#include <errno.h>
+#include <fcntl.h>
+#include <sched.h>
+#include <stdbool.h>
+#include <stdint.h>
+#include <string.h>
+#include <sys/mman.h>
+#include <sys/wait.h>
+#include <linux/mman.h>
+#include <unistd.h>
+
+#include "test_util.h"
+#include "kvm_util.h"
+#include "processor.h"
+#include "vmx.h"
+#include "kselftest.h"
+
+#define PORT_L0_EXIT		0x2000
+#define SHADOW_VMCS_GPA		0x80000000ULL
+#define SHADOW_VMCS_GVA		0x80000000ULL
+#define CANARY_BYTE		0x5a
+#define L2_GUEST_STACK_SIZE	64
+
+struct test_result {
+	bool corrupted;
+	size_t corrupt_offset;
+	uint8_t corrupt_val;
+};
+
+static void l2_guest_code(void)
+{
+	/* Exit to L0 */
+	asm volatile("inb %%dx, %%al"
+		     : : [port] "d" (PORT_L0_EXIT) : "rax");
+}
+
+static void l1_guest_code(struct vmx_pages *vmx_pages)
+{
+	unsigned long l2_guest_stack[L2_GUEST_STACK_SIZE];
+
+	GUEST_ASSERT(prepare_for_vmx_operation(vmx_pages));
+	GUEST_ASSERT(load_vmcs(vmx_pages));
+
+	/* Prepare the VMCS for L2 execution. */
+	prepare_vmcs(vmx_pages, l2_guest_code,
+		     &l2_guest_stack[L2_GUEST_STACK_SIZE]);
+
+	/* Enable VMCS shadowing and set the shadow VMCS link pointer. */
+	vmwrite(SECONDARY_VM_EXEC_CONTROL,
+		vmreadz(SECONDARY_VM_EXEC_CONTROL) | SECONDARY_EXEC_SHADOW_VMCS);
+	vmwrite(VMCS_LINK_POINTER, vmx_pages->shadow_vmcs_gpa);
+
+	vmlaunch();
+	GUEST_FAIL("L1 guest must not regain control");
+}
+
+static bool kvm_cpu_has_shadow_vmcs(void)
+{
+	uint64_t ctrl;
+
+	ctrl = kvm_get_feature_msr(MSR_IA32_VMX_TRUE_PROCBASED_CTLS) >> 32;
+	if (!(ctrl & CPU_BASED_ACTIVATE_SECONDARY_CONTROLS))
+		return false;
+
+	ctrl = kvm_get_feature_msr(MSR_IA32_VMX_PROCBASED_CTLS2) >> 32;
+	return ctrl & SECONDARY_EXEC_SHADOW_VMCS;
+}
+
+static void run_vmm(int pcpu, void *target_hva, int c2_to_c1_fd)
+{
+	vm_vaddr_t vmx_pages_gva;
+	struct kvm_vcpu *vcpu;
+	struct kvm_vm *vm;
+	struct vmx_pages *vmx;
+	void *shadow_hva;
+
+	pin_self_to_cpu(pcpu);
+
+	vm = vm_create_with_one_vcpu(&vcpu, l1_guest_code);
+
+	/* Allocate VMX pages and shared descriptors. */
+	vcpu_alloc_vmx(vm, &vmx_pages_gva);
+	vmx = addr_gva2hva(vm, vmx_pages_gva);
+
+	/*
+	 * Map the shadow VMCS page at the exact target_hva allocated by the
+	 * victim so it collides with the victim process's mapping.
+	 */
+	shadow_hva = mmap(target_hva, PAGE_SIZE, PROT_READ | PROT_WRITE,
+			  MAP_PRIVATE | MAP_ANONYMOUS | MAP_FIXED_NOREPLACE, -1, 0);
+	TEST_ASSERT(shadow_hva == target_hva, "mmap target_hva failed in VMM");
+	memset(shadow_hva, 0, PAGE_SIZE);
+
+	/* Add a caller-managed memslot for the shadow VMCS backing page. */
+	vm_userspace_mem_region_add_caller_managed(vm, shadow_hva,
+						   SHADOW_VMCS_GPA, 10, 1, 0);
+	virt_pg_map(vm, SHADOW_VMCS_GVA, SHADOW_VMCS_GPA);
+
+	/* Override the shadow VMCS pointers in vmx_pages. */
+	vmx->shadow_vmcs = (void *)SHADOW_VMCS_GVA;
+	vmx->shadow_vmcs_hva = shadow_hva;
+	vmx->shadow_vmcs_gpa = SHADOW_VMCS_GPA;
+
+	vcpu_args_set(vcpu, 1, vmx_pages_gva);
+
+	for (;;) {
+		struct kvm_run *run = vcpu->run;
+		struct ucall uc;
+
+		vcpu_run(vcpu);
+		TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_IO);
+
+		if (run->io.port == PORT_L0_EXIT)
+			break;
+
+		switch (get_ucall(vcpu, &uc)) {
+		case UCALL_ABORT:
+			REPORT_GUEST_ASSERT(uc);
+			/* NOT REACHED */
+		default:
+			TEST_FAIL("Unknown ucall %lu", uc.cmd);
+		}
+	}
+
+	/*
+	 * Signal the victim process that the VMM is about to terminate
+	 * while L2 is active with VMCS shadowing enabled.
+	 */
+	TEST_ASSERT(write(c2_to_c1_fd, "X", 1) == 1, "write to victim failed");
+
+	/*
+	 * Exit immediately without closing VM or vCPU file descriptors.
+	 * The kernel closes them in exit_files() after exit_mm() sets
+	 * current->mm = NULL.
+	 */
+	_exit(0);
+}
+
+static void run_victim(int pcpu, int ready_fd, int c2_to_c1_fd,
+		       int p_to_c1_fd, int result_fd)
+{
+	struct test_result result = { .corrupted = false };
+	void *victim_hva;
+	char sync_byte;
+	size_t i;
+	int flags;
+
+	pin_self_to_cpu(pcpu);
+
+	victim_hva = mmap(NULL, PAGE_SIZE, PROT_READ | PROT_WRITE,
+			  MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+	TEST_ASSERT(victim_hva != MAP_FAILED, "mmap failed in victim");
+	memset(victim_hva, CANARY_BYTE, PAGE_SIZE);
+
+	/* Send mapped virtual address to parent so VMM can collide with it. */
+	TEST_ASSERT(write(ready_fd, &victim_hva, sizeof(victim_hva)) == sizeof(victim_hva),
+		    "write ready failed");
+
+	/* Wait for VMM to launch L2 and reach exit to userspace. */
+	TEST_ASSERT(read(c2_to_c1_fd, &sync_byte, 1) == 1, "read sync failed");
+
+	/* Set parent-to-victim pipe to non-blocking. */
+	flags = fcntl(p_to_c1_fd, F_GETFL, 0);
+	TEST_ASSERT(flags >= 0, "fcntl F_GETFL failed");
+	TEST_ASSERT(fcntl(p_to_c1_fd, F_SETFL, flags | O_NONBLOCK) == 0,
+		    "fcntl F_SETFL failed");
+
+	/*
+	 * Loop yielding the CPU while the VMM terminates. When the VMM
+	 * sleeps in synchronize_srcu() during teardown, the scheduler
+	 * runs this victim process on the CPU. When the VMM wakes up,
+	 * the scheduler context switches from this victim to the VMM
+	 * with current->mm == NULL, leaving the victim's CR3 active.
+	 */
+	for (;;) {
+		ssize_t ret = read(p_to_c1_fd, &sync_byte, 1);
+
+		if (ret == 1)
+			break;
+		if (ret < 0 && (errno == EAGAIN || errno == EWOULDBLOCK)) {
+			sched_yield();
+			continue;
+		}
+		TEST_FAIL("read from parent pipe failed: ret=%zd, errno=%d",
+			  ret, errno);
+	}
+
+	/* Verify that the entire page remained untouched. */
+	for (i = 0; i < PAGE_SIZE; i++) {
+		if (((uint8_t *)victim_hva)[i] != CANARY_BYTE) {
+			result.corrupted = true;
+			result.corrupt_offset = i;
+			result.corrupt_val = ((uint8_t *)victim_hva)[i];
+			break;
+		}
+	}
+
+	TEST_ASSERT(write(result_fd, &result, sizeof(result)) == sizeof(result),
+		    "write result failed");
+	_exit(0);
+}
+
+static bool run_iteration(int pcpu)
+{
+	int pipe_ready[2];
+	int pipe_c2_to_c1[2];
+	int pipe_p_to_c1[2];
+	int pipe_result[2];
+	pid_t pid_victim;
+	pid_t pid_vmm;
+	struct test_result result = {};
+	void *target_hva = NULL;
+	int status;
+
+	TEST_ASSERT(pipe(pipe_ready) == 0, "pipe failed");
+	TEST_ASSERT(pipe(pipe_c2_to_c1) == 0, "pipe failed");
+	TEST_ASSERT(pipe(pipe_p_to_c1) == 0, "pipe failed");
+	TEST_ASSERT(pipe(pipe_result) == 0, "pipe failed");
+
+	pid_victim = fork();
+	TEST_ASSERT(pid_victim >= 0, "fork victim failed");
+	if (pid_victim == 0) {
+		close(pipe_ready[0]);
+		close(pipe_c2_to_c1[1]);
+		close(pipe_p_to_c1[1]);
+		close(pipe_result[0]);
+		run_victim(pcpu, pipe_ready[1], pipe_c2_to_c1[0],
+			   pipe_p_to_c1[0], pipe_result[1]);
+	}
+
+	close(pipe_ready[1]);
+	close(pipe_result[1]);
+	close(pipe_p_to_c1[0]);
+
+	/* Wait for victim to initialize its mapping and retrieve its address. */
+	TEST_ASSERT(read(pipe_ready[0], &target_hva, sizeof(target_hva)) == sizeof(target_hva),
+		    "wait ready failed");
+	close(pipe_ready[0]);
+
+	pid_vmm = fork();
+	TEST_ASSERT(pid_vmm >= 0, "fork VMM failed");
+	if (pid_vmm == 0) {
+		close(pipe_c2_to_c1[0]);
+		close(pipe_p_to_c1[1]);
+		close(pipe_result[0]);
+		run_vmm(pcpu, target_hva, pipe_c2_to_c1[1]);
+	}
+
+	close(pipe_c2_to_c1[0]);
+	close(pipe_c2_to_c1[1]);
+
+	/* Wait for VMM to completely terminate. */
+	waitpid(pid_vmm, &status, 0);
+	TEST_ASSERT(WIFEXITED(status) && WEXITSTATUS(status) == 0,
+		    "VMM child failed with status %d", status);
+
+	/* Signal victim to exit yield loop. */
+	TEST_ASSERT(write(pipe_p_to_c1[1], "D", 1) == 1, "signal victim failed");
+	close(pipe_p_to_c1[1]);
+
+	/* Read result from victim. */
+	TEST_ASSERT(read(pipe_result[0], &result, sizeof(result)) == sizeof(result),
+		    "read result failed");
+	close(pipe_result[0]);
+
+	waitpid(pid_victim, &status, 0);
+	TEST_ASSERT(WIFEXITED(status) && WEXITSTATUS(status) == 0,
+		    "Victim child failed with status %d", status);
+
+	if (result.corrupted)
+		pr_info("Memory check: corruption at offset 0x%zx: expected 0x%02x, actual 0x%02x\n",
+			result.corrupt_offset, CANARY_BYTE, result.corrupt_val);
+	else
+		pr_info("Memory check: entire page intact (canary = 0x%02x)\n",
+			CANARY_BYTE);
+
+	return result.corrupted;
+}
+
+int main(int argc, char *argv[])
+{
+	bool corrupted = false;
+	int pcpu;
+	int i;
+	const int iterations = 5;
+
+	TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_VMX));
+	TEST_REQUIRE(kvm_cpu_has_shadow_vmcs());
+
+	pcpu = pin_self_to_any_cpu();
+
+	pr_info("Testing shadow VMCS teardown on pCPU %d (%d iterations)...\n",
+		pcpu, iterations);
+
+	for (i = 0; i < iterations; i++) {
+		if (run_iteration(pcpu)) {
+			corrupted = true;
+			break;
+		}
+	}
+
+	TEST_ASSERT(!corrupted,
+		    "Memory corruption detected! Active MM was corrupted during vCPU teardown: canary byte 0x%02x overwritten\n",
+		    CANARY_BYTE);
+
+	pr_info("PASS: No memory corruption detected during teardown.\n");
+	return 0;
+}
-- 
2.55.0.1032.g73a4cd73de-goog

