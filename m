Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C73F5BA45;
	Tue,  5 May 2026 00:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777941179; cv=none; b=gbJxrvzCQ7p3k8SWg4uh/aj/aRjEb4MUC6viFRrSHeNYZK/75HVcNx293Bqbj131nfS7lWK83B6Ys3wT8IKIdh6zYcWyS3a94H7yoMn5RMuJbMd3eA6yI920tP//Jn7BKgGqFvWTQxZQzx0iESuBsa5HC8cyhDYqdgobGR/C7c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777941179; c=relaxed/simple;
	bh=r7HmhpE7UAFkumiSk9LUXRR3zz5NATNdjybjQEMJ7LI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oLWcKRZfzyfj/WbVm0QBtFMF6A3DvgGWBBru9fQaGUJ7/JbTb94nPziyaioYJhlXSCyJkDIDRn6eLkrYSSUqdS0dByeAlf6hd9IRWq1AZHfVjQdXWcr+YuwUlG2ltWBhGtMsK35ch4o/yHRUzcnRT0zXDrG4WefS6UeMCLfdZJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=aGenCg35; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="aGenCg35"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 644ISu6p2268240;
	Tue, 5 May 2026 00:32:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=mUKzn
	rndz/y/kSobpQ/bp7SwiYr6+LQuOWP/vUSL8F0=; b=aGenCg35ORptrrCAG04QR
	G6EEQ8w0WKpJNUqSmXIcPrwwDwGOj5GjjnpKpKE+XVkyk06eZTR9Wm1Bjt8qC1la
	EzxDZ0hoTYrlnbavEgLwLjPP8Zu26kqLGse4N7KHcwWNPDL+ZMPEjqsIbdaioy3Z
	9cZPv2PsY+VsoW1b80byzae5OO90h7iWqdIZ6tfTX77jNb41WjSTi6DcYdnT4ncb
	i1gZKZgtDCL5F9YVBEopLpwtK6Ss1CqZ8T0O2zFM0rH2ysmuYpWjbE1jDbeppDGW
	e4KybN4T1VD6LqO3NFN2iFPwSxUkKgdI4hODiPB8ZR4hhMG3H+aEv3UCM4KZK/18
	w==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4dw9gxkwxa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 05 May 2026 00:32:32 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 6450VFI6006934;
	Tue, 5 May 2026 00:32:31 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4dx5e9yjkp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 05 May 2026 00:32:31 +0000 (GMT)
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 6450Tr5d001260;
	Tue, 5 May 2026 00:32:30 GMT
Received: from localhost.localdomain (ca-dev80.us.oracle.com [10.211.9.80])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4dx5e9yjfe-5;
	Tue, 05 May 2026 00:32:30 +0000 (GMT)
From: Dongli Zhang <dongli.zhang@oracle.com>
To: kvm@vger.kernel.org, x86@kernel.org, linux-kselftest@vger.kernel.org
Cc: seanjc@google.com, pbonzini@redhat.com, vkuznets@redhat.com,
        tglx@kernel.org, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, shuah@kernel.org, hpa@zytor.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        vschneid@redhat.com, kprateek.nayak@amd.com, jgross@suse.com,
        dwmw2@infradead.org, joe.jin@oracle.com
Subject: [PATCH 4/5] KVM: selftests: Test steal time when re-adding a vCPU on a new thread
Date: Mon,  4 May 2026 17:30:17 -0700
Message-ID: <20260505003044.78693-5-dongli.zhang@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260505003044.78693-1-dongli.zhang@oracle.com>
References: <20260505003044.78693-1-dongli.zhang@oracle.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-04_06,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 malwarescore=0 lowpriorityscore=0 mlxscore=0 adultscore=0 suspectscore=0
 spamscore=0 bulkscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2604200000 definitions=main-2605050003
X-Proofpoint-ORIG-GUID: WLienUrZ6ILV06pwIX-YMZmJakUCsi2Z
X-Proofpoint-GUID: WLienUrZ6ILV06pwIX-YMZmJakUCsi2Z
X-Authority-Analysis: v=2.4 cv=Wa48rUhX c=1 sm=1 tr=0 ts=69f93aa0 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=3I1J8UUJPc9JN9BFgKH3:22 a=yPCof4ZbAAAA:8 a=mdh-CN5XSU-5sGMK1b8A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA1MDAwMiBTYWx0ZWRfX/+8k37ODFtoE
 5ihH0ZLzFPIj4p/FBi6dGq6rbP+459IEnYv7ROAQaJqFqnZjNzQvXOysForUUkEC5JQilvfFIQM
 CGfB+bKTbAoxQAWs792OLE4crLoigEwW/ljjioCDA2qcwS7fEmI3KPkrf+E4TkE/NRsZZKiL17Z
 4kYnu6Dedc42LkbEnlwhlTb5V4UntaFZbTwfO3NwvnRAimVUlXzcEwEKBhEVr8QAO3jGMZ1rWF9
 /66eefDK+FnGD2SghaTnhSA9l3OWahv8INVNQVsqfrWXLdfsXFzPCdgaDYVDrWKdWerFpCXSdLl
 AbtkkAwy47V8OMruQhpS+Yh+hD+kJDGIL2H4Ani+Q9A8ZllPfSEiPyogp7XI4jL123DWVbzZa8T
 QMS2cE1IcGdfspqvJY0EQIuFj2G4JAHHr3m9xubeSj38PKMSWXse60i4oTCWHgAqV36Sxq2kvbo
 uIPQS/YwArUcejb2nnw==

Add a selftest for the case where a vCPU is re-added on a new host thread
with its state is reset and steal time is re-enabled on the same vCPU fd.

Run the vCPU once after enabling steal time to establish a baseline, induce
host-side run_delay, and run it again to capture the accumulated steal
time. Then reset the vCPU state, re-enable steal time, and run the same
vCPU fd from a newly created host thread.

Verify that the first steal time update observed after the vCPU is re-added
stays sane and monotonic relative to the pre-reset value.

This models QEMU's vCPU hot-unplug/hotplug flow. KVM does not destroy the
vCPU fd when a vCPU is removed, while QEMU tears down the old vCPU thread
and later reuses the parked vCPU fd from a new thread when the vCPU is
added again.

Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
---
 tools/testing/selftests/kvm/Makefile.kvm      |   1 +
 .../selftests/kvm/x86/steal_time_reset_test.c | 144 ++++++++++++++++++
 2 files changed, 145 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/x86/steal_time_reset_test.c

diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
index 9118a5a51b89..b452d5691a24 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -148,6 +148,7 @@ TEST_GEN_PROGS_x86 += x86/max_vcpuid_cap_test
 TEST_GEN_PROGS_x86 += x86/triple_fault_event_test
 TEST_GEN_PROGS_x86 += x86/recalc_apic_map_test
 TEST_GEN_PROGS_x86 += x86/aperfmperf_test
+TEST_GEN_PROGS_x86 += x86/steal_time_reset_test
 TEST_GEN_PROGS_x86 += access_tracking_perf_test
 TEST_GEN_PROGS_x86 += coalesced_io_test
 TEST_GEN_PROGS_x86 += dirty_log_perf_test
diff --git a/tools/testing/selftests/kvm/x86/steal_time_reset_test.c b/tools/testing/selftests/kvm/x86/steal_time_reset_test.c
new file mode 100644
index 000000000000..6d5991227c4a
--- /dev/null
+++ b/tools/testing/selftests/kvm/x86/steal_time_reset_test.c
@@ -0,0 +1,144 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Verify that resetting a vCPU and re-enabling KVM steal time on the same
+ * vCPU fd does not corrupt the accumulated steal-time value when the vCPU
+ * is re-added on a new host thread.
+ */
+#include <pthread.h>
+#include <asm/kvm_para.h>
+#include "kvm_util.h"
+#include "processor.h"
+
+#define ST_GPA_BASE		(1 << 30)
+
+static void *st_gva;
+static u64 guest_stolen_time;
+static u64 main_steal;
+static u64 thread_steal;
+
+static void guest_code(void)
+{
+	struct kvm_steal_time *st = st_gva;
+
+	WRITE_ONCE(guest_stolen_time, READ_ONCE(st->steal));
+	GUEST_SYNC(0);
+	WRITE_ONCE(guest_stolen_time, READ_ONCE(st->steal));
+	GUEST_DONE();
+}
+
+static void run_vcpu(struct kvm_vcpu *vcpu)
+{
+	struct ucall uc;
+
+	vcpu_run(vcpu);
+
+	switch (get_ucall(vcpu, &uc)) {
+	case UCALL_SYNC:
+	case UCALL_DONE:
+		break;
+	case UCALL_ABORT:
+		REPORT_GUEST_ASSERT(uc);
+	default:
+		TEST_ASSERT(false, "Unexpected exit: %s",
+			    exit_reason_str(vcpu->run->exit_reason));
+	}
+}
+
+static void *do_steal_time(void *arg)
+{
+	struct timespec ts, stop;
+
+	clock_gettime(CLOCK_MONOTONIC, &ts);
+	stop = timespec_add_ns(ts, 100 * MIN_RUN_DELAY_NS);
+
+	while (1) {
+		clock_gettime(CLOCK_MONOTONIC, &ts);
+		if (timespec_to_ns(timespec_sub(ts, stop)) >= 0)
+			break;
+	}
+
+	return NULL;
+}
+
+static void *vcpu_thread(void *arg)
+{
+	struct kvm_vcpu *vcpu = arg;
+
+	run_vcpu(vcpu);
+	sync_global_from_guest(vcpu->vm, guest_stolen_time);
+	thread_steal = guest_stolen_time;
+
+	return NULL;
+}
+
+int main(void)
+{
+	struct kvm_x86_state *reset_state;
+	struct kvm_steal_time *st;
+	struct kvm_vcpu *vcpu;
+	pthread_attr_t attr;
+	struct kvm_vm *vm;
+	pthread_t thread;
+	cpu_set_t cpuset;
+	long run_delay;
+
+	ksft_print_header();
+	ksft_set_plan(1);
+
+	TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_KVM_STEAL_TIME));
+
+	CPU_ZERO(&cpuset);
+	CPU_SET(0, &cpuset);
+	pthread_attr_init(&attr);
+	pthread_attr_setaffinity_np(&attr, sizeof(cpuset), &cpuset);
+	pthread_setaffinity_np(pthread_self(), sizeof(cpuset), &cpuset);
+
+	vm = vm_create_with_one_vcpu(&vcpu, guest_code);
+
+	vm_userspace_mem_region_add(vm, VM_MEM_SRC_ANONYMOUS, ST_GPA_BASE, 1, 1, 0);
+	virt_map(vm, ST_GPA_BASE, ST_GPA_BASE, 1);
+
+	st_gva = (void *)ST_GPA_BASE;
+	sync_global_to_guest(vm, st_gva);
+
+	st = addr_gva2hva(vm, ST_GPA_BASE);
+	memset(st, 0, sizeof(*st));
+
+	reset_state = vcpu_save_state(vcpu);
+
+	vcpu_set_msr(vcpu, MSR_KVM_STEAL_TIME, ST_GPA_BASE | KVM_MSR_ENABLED);
+	run_vcpu(vcpu);
+
+	run_delay = get_run_delay();
+	pthread_create(&thread, &attr, do_steal_time, NULL);
+
+	while (get_run_delay() - run_delay < MIN_RUN_DELAY_NS)
+		sched_yield();
+
+	pthread_join(thread, NULL);
+	run_delay = get_run_delay() - run_delay;
+	TEST_ASSERT(run_delay >= MIN_RUN_DELAY_NS,
+		    "Expected run_delay >= %lu, got %ld",
+		    MIN_RUN_DELAY_NS, run_delay);
+
+	run_vcpu(vcpu);
+	sync_global_from_guest(vm, guest_stolen_time);
+	main_steal = guest_stolen_time;
+
+	vcpu_load_state(vcpu, reset_state);
+	vcpu_set_msr(vcpu, MSR_KVM_STEAL_TIME, ST_GPA_BASE | KVM_MSR_ENABLED);
+
+	pthread_create(&thread, NULL, vcpu_thread, vcpu);
+
+	pthread_join(thread, NULL);
+	TEST_ASSERT(thread_steal >= main_steal &&
+		    thread_steal - main_steal < (1ULL << 63),
+		    "Expected sane steal in new vCPU thread: main=%"PRIu64", thread=%"PRIu64,
+		    main_steal, thread_steal);
+	ksft_test_result_pass("reset preserved steal time across threads\n");
+
+	pthread_attr_destroy(&attr);
+	kvm_x86_state_cleanup(reset_state);
+	kvm_vm_free(vm);
+	ksft_finished();
+}
-- 
2.39.3

