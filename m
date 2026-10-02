Received: from mail-4317.protonmail.ch (mail-4317.protonmail.ch [185.70.43.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0955D3A7F4B
	for <kvm@vger.kernel.org>; Fri,  2 Oct 2026 05:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790919805; cv=none; b=Qhl8ZNjwrkjRaERh8sYu7QjP5RO+NdLMyYR24ew5kzmkHf+EHMLj4rCHo0omTw2i8bCv2s+xhRZg31Ck0V1nGYLuxrCcb7Qivs0JLiJR8mDdOoGtcmWs/D+LHGuRzapET9HdT9AFg5oNUV3yZDUHwqcnFkfYmY6XvFpmU66BwU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790919805; c=relaxed/simple;
	bh=Abom6ETQOi+clD7TO6693EVDx+y8nqVzgaATaa2nDZw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mxo4eM/OAarof7rgoPbgKyxp7XLbmnWHoeHiDOozpXpNlv07cEItMjIoMXImmYdoElG6Z/GsOyE9G3+HJnBNJsBUOvFzOp12g7Dd1K8p1E7KoOE2EdUhbnltHEjpx4twEO7kusb8LUIdL01cxV8ClaocfzQ2/DaNzQU+9B3Wvp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ryzome.com; spf=pass smtp.mailfrom=ryzome.com; dkim=pass (2048-bit key) header.d=ryzome.com header.i=@ryzome.com header.b=KrJEkMKy; arc=none smtp.client-ip=185.70.43.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ryzome.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ryzome.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ryzome.com header.i=@ryzome.com header.b="KrJEkMKy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ryzome.com;
	s=protonmail; t=1790919795; x=1791178995;
	bh=ti4cz9fUS1Tb8mbjP9WcPg7vLfJblpNhR/CVM8NmiTE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=KrJEkMKypQSLSb7Y7CuFZ5+FSYpjbP5V7tyRo6dK40hXHYlXvYljKt9H/04v2EdXD
	 it+kw8Ps4k3DtKDR5CF3SdTHT3q58PH3DQIYAVx9/CCdN3WVZUO5OlPUt9Civn8ieF
	 +W1yCabwbWj5HUmG7iWEm2g9Qk09grrZpYfLuA53yWaXgtPg5+qJPxFCClOvlC8cu2
	 hAtCXltCD2VNxVRuOqEUuYwAj8trYvk6eFqzNVXd2VlUrY5Cw4pBCFJvpNU8lAe7o9
	 TMsqtNXuB+DtumuUJiewbhE2p807QV/OAwVyr53vG40R3j0nSUPZyGyYQif74AKxwf
	 4nNXoohmP7DWw==
Date: Fri, 02 Oct 2026 05:43:09 +0000
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
From: Loc Nguyen <loc@ryzome.com>
Cc: Shuah Khan <shuah@kernel.org>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, hpa@zytor.com, x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH 2/2] KVM: selftests: Add a test for lost nested APF VM-Exits
Message-ID: <20261002053723.3275202-3-loc@ryzome.com>
In-Reply-To: <20261002053723.3275202-1-loc@ryzome.com>
References: <20261002053723.3275202-1-loc@ryzome.com>
Feedback-ID: 78153448:user:proton
X-Pm-Message-ID: 50ab911c6077c0bf2d4735ad7de23ad69d5a873e
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Exercise delivery of an asynchronous page fault from L2 to L1 as a
synthetic #PF VM-Exit.  Hold L2's backing page missing with userfaultfd
and bound the critical KVM_RUN with a signal-based timeout.

On an affected kernel, KVM queues the nested VM-Exit without requesting
event processing, re-enters L2, and blocks on the same missing page.  The
test detects the timeout and verifies that L1's APF record still contains
KVM_PV_REASON_PAGE_NOT_PRESENT.

On a fixed kernel, verify that L1 receives an exception VM-Exit with a #PF,
error code zero, a nonzero APF token, and a matching page-not-present
reason.

Skip the test when VMX, EPT, the nested APF features, or userfaultfd fault
handling are unavailable.

Signed-off-by: Loc Nguyen <loc@ryzome.com>
---
 tools/testing/selftests/kvm/Makefile.kvm      |   1 +
 .../selftests/kvm/x86/nested_apf_event_test.c | 306 ++++++++++++++++++
 2 files changed, 307 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/x86/nested_apf_event_test.c

diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selft=
ests/kvm/Makefile.kvm
index b31ee61af284..a882c1f8a5fb 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -92,6 +92,7 @@ TEST_GEN_PROGS_x86 +=3D x86/kvm_pv_test
 TEST_GEN_PROGS_x86 +=3D x86/kvm_buslock_test
 TEST_GEN_PROGS_x86 +=3D x86/monitor_mwait_test
 TEST_GEN_PROGS_x86 +=3D x86/msrs_test
+TEST_GEN_PROGS_x86 +=3D x86/nested_apf_event_test
 TEST_GEN_PROGS_x86 +=3D x86/nested_close_kvm_test
 TEST_GEN_PROGS_x86 +=3D x86/nested_dirty_log_test
 TEST_GEN_PROGS_x86 +=3D x86/nested_emulation_test
diff --git a/tools/testing/selftests/kvm/x86/nested_apf_event_test.c b/tool=
s/testing/selftests/kvm/x86/nested_apf_event_test.c
new file mode 100644
index 000000000000..97e23ef91ca6
--- /dev/null
+++ b/tools/testing/selftests/kvm/x86/nested_apf_event_test.c
@@ -0,0 +1,306 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2026, Ryzome
+ *
+ * Reproduce a lost nested asynchronous page-fault notification.
+ *
+ * L2 faults on a page held missing by userfaultfd.  KVM writes
+ * PAGE_NOT_PRESENT to L1's APF record and queues a synthetic #PF VM-exit.
+ * The vulnerable path omits KVM_REQ_EVENT, re-enters L2, and loses the
+ * notification before L1 can consume it.  A fixed L0 exits to L1 immediat=
ely.
+ */
+#include <errno.h>
+#include <fcntl.h>
+#include <linux/userfaultfd.h>
+#include <poll.h>
+#include <signal.h>
+#include <stdint.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/ioctl.h>
+#include <sys/mman.h>
+#include <sys/syscall.h>
+#include <unistd.h>
+
+#include <asm/kvm_para.h>
+
+#include "kvm_util.h"
+#include "processor.h"
+#include "test_util.h"
+#include "vmx.h"
+
+#define APF_VECTOR 0xF1U
+#define RUN_TIMEOUT_SECONDS 3U
+#define VMX_INTR_INFO_VECTOR_MASK 0xFFU
+#define VMX_INTR_INFO_TYPE_MASK 0x700U
+#define VMX_INTR_INFO_HARD_EXCEPTION (3U << 8)
+#define VMX_INTR_INFO_DELIVER_CODE BIT(11)
+#define VMX_INTR_INFO_VALID BIT(31)
+
+enum test_stage {
+=09STAGE_APF_ARMED =3D 1,
+=09STAGE_APF_DELIVERED,
+};
+
+static struct kvm_vcpu_pv_apf_data apf_data __aligned(64);
+static gva_t l2_target_gva;
+
+static void l2_guest_code(void)
+{
+=09u64 value;
+
+=09value =3D READ_ONCE(*(u64 *)READ_ONCE(l2_target_gva));
+=09GUEST_FAIL("L2 resumed after the missing page was resolved: %#lx", valu=
e);
+}
+
+static void l1_guest_code(struct vmx_pages *vmx, gpa_t apf_data_gpa)
+{
+=09u64 apf_msr;
+=09u64 intr_info;
+=09u64 reason;
+=09u64 token;
+
+=09GUEST_ASSERT(this_cpu_has(X86_FEATURE_KVM_ASYNC_PF));
+=09GUEST_ASSERT(this_cpu_has(X86_FEATURE_KVM_ASYNC_PF_VMEXIT));
+=09GUEST_ASSERT(this_cpu_has(X86_FEATURE_KVM_ASYNC_PF_INT));
+=09prepare_for_vmx_operation(vmx);
+=09load_vmcs(vmx);
+=09prepare_vmcs(vmx, l2_guest_code);
+=09vmwrite(GUEST_RFLAGS,
+=09=09X86_EFLAGS_FIXED | X86_EFLAGS_IF);
+
+=09wrmsr(MSR_KVM_ASYNC_PF_INT, APF_VECTOR);
+=09apf_msr =3D apf_data_gpa | KVM_ASYNC_PF_ENABLED |
+=09=09  KVM_ASYNC_PF_SEND_ALWAYS |
+=09=09  KVM_ASYNC_PF_DELIVERY_AS_PF_VMEXIT |
+=09=09  KVM_ASYNC_PF_DELIVERY_AS_INT;
+=09wrmsr(MSR_KVM_ASYNC_PF_EN, apf_msr);
+
+=09/*
+=09 * Let userspace discard and userfaultfd-register the target only after
+=09 * all L1 setup exits have completed.  The following KVM_RUN therefore
+=09 * has no pending event request to accidentally deliver the nested APF.
+=09 */
+=09GUEST_SYNC(STAGE_APF_ARMED);
+
+=09vmlaunch();
+=09GUEST_ASSERT_EQ(vmread(VM_EXIT_REASON), EXIT_REASON_EXCEPTION_NMI);
+
+=09intr_info =3D vmread(VM_EXIT_INTR_INFO);
+=09GUEST_ASSERT(intr_info & VMX_INTR_INFO_VALID);
+=09GUEST_ASSERT_EQ(intr_info & VMX_INTR_INFO_VECTOR_MASK, PF_VECTOR);
+=09GUEST_ASSERT_EQ(intr_info & VMX_INTR_INFO_TYPE_MASK,
+=09=09=09VMX_INTR_INFO_HARD_EXCEPTION);
+=09GUEST_ASSERT(intr_info & VMX_INTR_INFO_DELIVER_CODE);
+=09GUEST_ASSERT_EQ(vmread(VM_EXIT_INTR_ERROR_CODE), 0);
+
+=09token =3D vmread(EXIT_QUALIFICATION);
+=09reason =3D READ_ONCE(apf_data.flags);
+=09GUEST_ASSERT(token);
+=09GUEST_ASSERT_EQ(reason, KVM_PV_REASON_PAGE_NOT_PRESENT);
+
+=09/* Release the APF record slot before userspace resolves the page. */
+=09WRITE_ONCE(apf_data.flags, 0);
+=09GUEST_SYNC_ARGS(STAGE_APF_DELIVERED, token, reason, 0, 0);
+}
+
+#ifdef __NR_userfaultfd
+static int register_missing_page(void *hva)
+{
+=09struct uffdio_register uffd_register =3D {
+=09=09.range =3D {
+=09=09=09.start =3D (uintptr_t)hva,
+=09=09=09.len =3D PAGE_SIZE,
+=09=09},
+=09=09.mode =3D UFFDIO_REGISTER_MODE_MISSING,
+=09};
+=09struct uffdio_api uffd_api =3D {
+=09=09.api =3D UFFD_API,
+=09};
+=09int uffd;
+
+=09uffd =3D syscall(__NR_userfaultfd, O_CLOEXEC | O_NONBLOCK);
+=09if (uffd < 0 && (errno =3D=3D EPERM || errno =3D=3D EACCES))
+=09=09ksft_exit_skip("userfaultfd is unavailable: %s\n", strerror(errno));
+=09TEST_ASSERT(uffd >=3D 0, "userfaultfd failed: %s", strerror(errno));
+
+=09TEST_ASSERT(ioctl(uffd, UFFDIO_API, &uffd_api) =3D=3D 0,
+=09=09    "UFFDIO_API failed: %s", strerror(errno));
+=09TEST_ASSERT(ioctl(uffd, UFFDIO_REGISTER, &uffd_register) =3D=3D 0,
+=09=09    "UFFDIO_REGISTER failed: %s", strerror(errno));
+=09TEST_ASSERT(uffd_register.ioctls & (1ULL << _UFFDIO_COPY),
+=09=09    "userfaultfd does not support UFFDIO_COPY");
+
+=09return uffd;
+}
+
+static bool read_missing_page_event(int uffd, void *target_hva)
+{
+=09struct pollfd pollfd =3D {
+=09=09.fd =3D uffd,
+=09=09.events =3D POLLIN,
+=09};
+=09struct uffd_msg msg;
+=09ssize_t bytes;
+=09int ret;
+
+=09ret =3D poll(&pollfd, 1, 3000);
+=09if (ret !=3D 1 || !(pollfd.revents & POLLIN))
+=09=09return false;
+
+=09bytes =3D read(uffd, &msg, sizeof(msg));
+=09if (bytes !=3D sizeof(msg) || msg.event !=3D UFFD_EVENT_PAGEFAULT)
+=09=09return false;
+
+=09return (msg.arg.pagefault.address & ~(PAGE_SIZE - 1ULL)) =3D=3D
+=09       (uintptr_t)target_hva;
+}
+
+static void resolve_missing_page(int uffd, void *target_hva)
+{
+=09struct uffdio_copy uffd_copy =3D {
+=09=09.dst =3D (uintptr_t)target_hva,
+=09=09.len =3D PAGE_SIZE,
+=09};
+=09void *page =3D NULL;
+=09int ret;
+
+=09ret =3D posix_memalign(&page, PAGE_SIZE, PAGE_SIZE);
+=09TEST_ASSERT(!ret, "posix_memalign failed: %s", strerror(ret));
+=09memset(page, 0, PAGE_SIZE);
+=09uffd_copy.src =3D (uintptr_t)page;
+
+=09TEST_ASSERT(ioctl(uffd, UFFDIO_COPY, &uffd_copy) =3D=3D 0,
+=09=09    "UFFDIO_COPY failed: %s", strerror(errno));
+=09free(page);
+}
+
+static void alarm_handler(int signal)
+{
+=09(void)signal;
+}
+
+static void assert_sync_stage(struct kvm_vcpu *vcpu, u64 expected_stage)
+{
+=09struct ucall uc;
+
+=09TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_IO);
+=09switch (get_ucall(vcpu, &uc)) {
+=09case UCALL_SYNC:
+=09=09TEST_ASSERT_EQ(uc.args[1], expected_stage);
+=09=09break;
+=09case UCALL_ABORT:
+=09=09REPORT_GUEST_ASSERT(uc);
+=09=09break;
+=09default:
+=09=09TEST_FAIL("Unexpected ucall command %lu", uc.cmd);
+=09}
+}
+
+static void run_test(void)
+{
+=09struct kvm_vcpu_pv_apf_data *apf_hva;
+=09struct sigaction action =3D {
+=09=09.sa_handler =3D alarm_handler,
+=09};
+=09struct kvm_vcpu *vcpu;
+=09struct kvm_vm *vm;
+=09struct ucall uc =3D {};
+=09sigset_t blocked_signals;
+=09sigset_t old_signals;
+=09gva_t nested_gva;
+=09gva_t target_gva;
+=09gpa_t apf_gpa;
+=09void *target_hva;
+=09u32 stale_reason;
+=09bool uffd_event;
+=09bool run_timed_out;
+=09int run_errno =3D 0;
+=09int run_ret;
+=09int uffd;
+=09u64 ucall_cmd =3D UCALL_NONE;
+
+=09vm =3D vm_create_with_one_vcpu(&vcpu, l1_guest_code);
+=09vm_enable_tdp(vm);
+=09vcpu_alloc_vmx(vm, &nested_gva);
+=09target_gva =3D vm_alloc_page(vm);
+=09tdp_identity_map_default_memslots(vm);
+
+=09l2_target_gva =3D target_gva;
+=09sync_global_to_guest(vm, l2_target_gva);
+=09apf_gpa =3D addr_gva2gpa(vm, (gva_t)&apf_data);
+=09TEST_ASSERT(!(apf_gpa & 63U), "APF data GPA %#lx is misaligned",
+=09=09    apf_gpa);
+=09apf_hva =3D addr_gva2hva(vm, (gva_t)&apf_data);
+=09target_hva =3D addr_gva2hva(vm, target_gva);
+=09vcpu_args_set(vcpu, 2, nested_gva, apf_gpa);
+
+=09vcpu_run(vcpu);
+=09assert_sync_stage(vcpu, STAGE_APF_ARMED);
+
+=09TEST_ASSERT(madvise(target_hva, PAGE_SIZE, MADV_DONTNEED) =3D=3D 0,
+=09=09    "madvise failed: %s", strerror(errno));
+=09uffd =3D register_missing_page(target_hva);
+
+=09TEST_ASSERT(sigaction(SIGALRM, &action, NULL) =3D=3D 0,
+=09=09    "sigaction failed: %s", strerror(errno));
+=09sigfillset(&blocked_signals);
+=09sigdelset(&blocked_signals, SIGALRM);
+=09TEST_ASSERT(sigprocmask(SIG_SETMASK, &blocked_signals, &old_signals) =
=3D=3D 0,
+=09=09    "sigprocmask failed: %s", strerror(errno));
+
+=09alarm(RUN_TIMEOUT_SECONDS);
+=09run_ret =3D __vcpu_run(vcpu);
+=09run_errno =3D errno;
+=09alarm(0);
+=09run_timed_out =3D run_ret < 0 && run_errno =3D=3D EINTR;
+=09TEST_ASSERT(sigprocmask(SIG_SETMASK, &old_signals, NULL) =3D=3D 0,
+=09=09    "sigprocmask restore failed: %s", strerror(errno));
+
+=09stale_reason =3D READ_ONCE(apf_hva->flags);
+=09uffd_event =3D read_missing_page_event(uffd, target_hva);
+=09if (uffd_event)
+=09=09resolve_missing_page(uffd, target_hva);
+=09close(uffd);
+
+=09if (!run_ret)
+=09=09ucall_cmd =3D get_ucall(vcpu, &uc);
+=09if (ucall_cmd =3D=3D UCALL_ABORT)
+=09=09REPORT_GUEST_ASSERT(uc);
+=09kvm_vm_free(vm);
+
+=09TEST_ASSERT(uffd_event,
+=09=09    "L2 access did not produce the held userfaultfd fault");
+=09TEST_ASSERT(!run_timed_out ||
+=09=09    stale_reason =3D=3D KVM_PV_REASON_PAGE_NOT_PRESENT,
+=09=09    "KVM_RUN timed out without a stale APF reason: reason=3D%u",
+=09=09    stale_reason);
+=09TEST_ASSERT(!run_timed_out,
+=09=09    "Lost nested APF event: KVM re-entered L2 and blocked; APF reaso=
n=3D%u",
+=09=09    stale_reason);
+=09TEST_ASSERT(!run_ret, "KVM_RUN failed: %s", strerror(run_errno));
+=09TEST_ASSERT_EQ(ucall_cmd, UCALL_SYNC);
+=09TEST_ASSERT_EQ(uc.args[1], STAGE_APF_DELIVERED);
+=09TEST_ASSERT_EQ(uc.args[3], KVM_PV_REASON_PAGE_NOT_PRESENT);
+=09TEST_ASSERT(uc.args[2], "KVM returned a zero APF token");
+}
+#endif
+
+int main(int argc, char *argv[])
+{
+=09(void)argc;
+=09(void)argv;
+
+#ifndef __NR_userfaultfd
+=09ksft_exit_skip("__NR_userfaultfd is unavailable\n");
+#else
+=09TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_VMX));
+=09TEST_REQUIRE(kvm_cpu_has_ept());
+=09TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_KVM_ASYNC_PF));
+=09TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_KVM_ASYNC_PF_VMEXIT));
+=09TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_KVM_ASYNC_PF_INT));
+
+=09run_test();
+#endif
+=09return 0;
+}
--=20
2.43.0


