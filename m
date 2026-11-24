Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.132
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795491229;
	b=FxDG0gZ4FTXTc0YTJN3u5NcmTfNnf3+exXvkWy3aF+17FZ0F2zwg0X5cawLm7ndls+68
	 GPxRTRnA4sPnWDklFQiziL2XSsnvdpbF6R9qVjItWNIu+ggzG3aGQjAzKxn8RGol7s10Y
	 7d3jvESXx0x5ZhB/VKGlu2WebGIeert+e6POJxG+TClzMFQQGYnQNRLSW6c1bbZXLz0bU
	 nCnI7krPYZ2uBWh5tQBxCDb4g5Dye4KsT7HiLSrQ4ND0TWN/M51wFYtTQCuSZRuzGl+hA
	 voovDMx92Rlcz7Ga2f/IPZSVgf59m9cKY7vXzcxrBEyWTcK6P/ZYPP+ntsNeTflLS5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795491229;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=+aG4MNfkbYBkCJSsJvADe/q3LoG/+w55119ipXSrHN0=;
	b=TFHyCTR4PbwYUTd9CAldsaclenMJZIIxwzrvFXTlxlRCnTiKN8WgugDfI/D0Azi/OoYk
	 pO93XCZY1wsne4TpJzwYh5hbnvnN4cjOuQq8VHlgAUdXkio3POx33qxsdWU96Je5StWBc
	 q3ne6alwmym9NWP3ChYxooLgmEAT/BN5NIrNvI8Ucm+TWpb8HqFfzAEFuc4auHA6vqm6l
	 xYj/0FsR8sKSY1lhwuElI8jlgtXjpsXo43C2Wn0ewdfheRqg4nLMVnm3CUzzgvCbP9/xd
	 Ue7A0DJja+n8viTgTYrk6jsHfTTD+SKYw7ldyziB5kZAvL7LkmxZHvOaR7Gq44TjyGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PMJ7jBSk;
	arc=none smtp.remote-ip=74.125.227.132
Received: from mail-pj2-f4.google.com (mail-pj2-f4.google.com [74.125.227.132])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 002D3606A32C
	for <kvm@vger.kernel.org>; Tue, 24 Nov 2026 03:33:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 002D3606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PMJ7jBSk
Received: by mail-pj2-f4.google.com with SMTP id d9443c01a7336-2f066a193bbso19825585ad.0
        for <kvm@vger.kernel.org>; Mon, 23 Nov 2026 19:33:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795491227; x=1796096027; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+aG4MNfkbYBkCJSsJvADe/q3LoG/+w55119ipXSrHN0=;
        b=PMJ7jBSk+76u+aS4R71dbTfXgO8kgDR3AoAU0QOxKZzj0hPYIk0m8+2OtlnQB15CX7
         7BBniUJartqZMNQcoU1c9pE9MdTH0doYGo9GEEIGLGVjGBtBT+VH2YDknAZlUPOjZ+W9
         YWzIYxr0FiSRZoPU9ndOwrjTNWr1hWbIr7i5hor4xcGB6gTkVEWzB/ngzSi1tqrQ3DjS
         JhslKDd0pn5BelpvdnkLKplltbYMqnhBNz5YZUzZ3T7feiuW3If0MEzRHH9hwONyae4w
         6ztGBr+oXTB4cgokhCBPSVwhgC0QkFUixb4BQ/bkPBqyQ8UhDgYIKnf03KUkCG4B2lFK
         HqBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795491227; x=1796096027;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+aG4MNfkbYBkCJSsJvADe/q3LoG/+w55119ipXSrHN0=;
        b=P2ImsUKcqqs0wb/I01wmt/Y73FEmdVR58QAAIhwExPHwva+CoLhh/PM88/aHIWdVLM
         L2VcTRdHmsqRiKMNLFt45rr3SH4WjYpfsGnfR2ZN7zkk7h3pOlag2WsybpGup47A3DOu
         5MmWbmG6smQnEcx1Sr40Qa55KA5CIZ5SyXGb83isV9JspBEAAqgqHyMI2xzp19o6TFt0
         PWzcHEWRzwBUC2pyRv5BYtv9c3zsFXhXNrHZN/U5Ur8DCL5yq1fN8f6RZqyxTAGAvkkh
         lAy9W9rkE5Pg/NLY9b9UvHyESJ522jodfageq73rNiyM/UxWWEAZjux3Qqcu+3HsgE2l
         R/Tw==
X-Forwarded-Encrypted: i=1; AL+hErGHGDimDzWGvqr83U+7u42TnE5BtwVKGzxxyJX3xig/boNk8lXMvw9WQ6RnPg8MjIwiR/c=@vger.kernel.org
X-Gm-Message-State: APuU4Z8Dr8S87qT4goj+NtTyKbUWR9Rzh2atC78blNfwlp/R7tWwu1pO
	wBs6TibKDo6ZaqiYltzP8vRpnZk3coNqu+mZ+JDzbJRspbEy0tqG5Clp
X-Gm-Gg: AZFdTZeO2nIshkpsR5ti711VxzkqT7JXHKn2i59Hl7z4t9kD5GXpY0KBtwDrkXLqS61
	ww5PO8EE+KuX4ANZy93XlZcwVHl4uepJrb0ZLYNZSnyRm9868cDO5FBNG28Q/hQEI+P9Id2m6WI
	qaKy0LygHa2kf+Pq6blWaE15mmAk4uqs+wrcW2tMsUBVGx7qE1lbXdJQDfRWCGZIo93b/kOvT1o
	X7kFYdEvH7rOaT9yGczns630Tw+V9ljThjpti+jbOIJ9hAAXIHijGsVK2jwTX6YYnSxeEcOFY79
	blDhm139m2qzDL0kyim5XPuhOwFwRex0q5CQ0slh0lpVuh6OsRcPLMWnRKGK7xoZsdz8KB25yGl
	BBIcC2Qoxnj7no3u7Ko1XQ4pSQqRUhCmw8GVQAMp2P2XiJXeWicnxGYfQEcqgQmLfHqeHIKwUFX
	PDovHHBThmyyfV8N9ozBkD8a0ouu7LT6HFsoG1nq3sKwDtk/37WlOwivcM1pBX2587WAEm9cpg/
	LuTnV2T/6sP4gtBWzcMlhR6yIHnYHoDn7V8fCewyu/HpGplZKE/muGISZUhS8c82yC90PX/9HUT
	CoQxxBOQo+78xENOjDGUd11r09WqvPgW5+sr59Wh2Q==
X-Received: by 2002:a05:6300:218b:b0:3f8:f0b1:e7c0 with SMTP id adf61e73a8af0-4014da5fc3emr12855841637.59.1795491227174;
        Mon, 23 Nov 2026 19:33:47 -0800 (PST)
Received: from q-Legion-Y7000-IRX9.. ([223.86.210.47])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c87077bff6sm6495773b3a.3.2026.11.23.19.33.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 19:33:46 -0800 (PST)
From: Bingyu Xian <shanbeeyoo@gmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Anup Patel <anup@brainfault.org>,
	Atish Patra <atish.patra@linux.dev>,
	Andrew Jones <andrew.jones@linux.dev>
Cc: Shuah Khan <shuah@kernel.org>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Quan Zhou <zhouquan@iscas.ac.cn>,
	Bingyu Xian <shanbeeyoo@gmail.com>,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-kselftest@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] KVM: selftests: Test steal-time dirty logging and RISC-V STA transitions
Date: Tue, 24 Nov 2026 11:33:28 +0800
Message-Id: <20261124033328.612894-3-shanbeeyoo@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261124033328.612894-1-shanbeeyoo@gmail.com>
References: <20261124033328.612894-1-shanbeeyoo@gmail.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

KVM writes to a guest steal-time structure must be recorded in the guest
RAM dirty log. Enable dirty logging on the shared-area memslot in the
common per-vCPU test path, clear initialization dirty bits after the
first run, and force runnable scheduling delay before checking that the
subsequent accounting write marks the expected page dirty.

On RISC-V, additionally exercise three SBI STA transitions: disabling an
active shared area, re-enabling the same area, and replacing an active
registration directly with a new area at the end of a second host page.
Clear the dirty log after each transition, arrange runnable contention on
the pinned CPU with a bounded monotonic timeout, and compare sequence and
stolen time against a stopped-vCPU snapshot so valid zero-increment skips
are permitted. After active replacement, verify that the old page remains
both unchanged and clean.

Use per-architecture hooks for protocol-specific lifecycle cases instead of
adding #ifdefs in main(). These SBI enable/disable operations match those
used by the Linux RISC-V guest CPU online and CPU-down callbacks, while the
selftest exercises the SBI protocol directly rather than booting Linux.
Drop the v1 MADV_DONTNEED check, which discarded guest page contents and
did not model migration.

Co-developed-by: Quan Zhou <zhouquan@iscas.ac.cn>
Signed-off-by: Quan Zhou <zhouquan@iscas.ac.cn>
Signed-off-by: Bingyu Xian <shanbeeyoo@gmail.com>
---
Changes in v2:
- Move accounting dirty-log checks into the common per-vCPU loop and
  remove the added #ifdefs from main().
- Test RISC-V disable, re-enable of the same area, and direct active
  replacement separately; drop the v1 MADV_DONTNEED case.
- Isolate registration dirty bits with kvm_vm_get_dirty_log() and arrange
  bounded runnable contention instead of assuming unconditional updates.
- Align the two-page region and boundary offset to getpagesize().

 tools/testing/selftests/kvm/steal_time.c | 233 ++++++++++++++++++++---
 1 file changed, 206 insertions(+), 27 deletions(-)

diff --git a/tools/testing/selftests/kvm/steal_time.c b/tools/testing/selftests/kvm/steal_time.c
index 82b94a82d..276eb03a6 100644
--- a/tools/testing/selftests/kvm/steal_time.c
+++ b/tools/testing/selftests/kvm/steal_time.c
@@ -8,6 +8,7 @@
 #include <time.h>
 #include <sched.h>
 #include <pthread.h>
+#include <linux/bitmap.h>
 #include <linux/kernel.h>
 #include <asm/kvm.h>
 #ifdef __riscv
@@ -29,11 +30,17 @@ static u64 guest_stolen_time[NR_VCPUS];
 
 static struct kvm_vm *vm_create_steal_time(u32 nr_vcpus, void *guest_code,
 					   struct kvm_vcpu *vcpus[]);
+static long force_steal_time(void);
 
 #if defined(__x86_64__)
 
 /* steal_time must have 64-byte alignment */
 #define STEAL_TIME_SIZE		((sizeof(struct kvm_steal_time) + 63) & ~63)
+#define NR_LIFECYCLE_TESTS	0
+
+static void check_steal_time_lifecycle(void)
+{
+}
 
 static void check_status(struct kvm_steal_time *st)
 {
@@ -115,6 +122,11 @@ static void check_steal_time_uapi(void)
 
 /* PV_TIME_ST must have 64-byte alignment */
 #define STEAL_TIME_SIZE		((sizeof(struct st_time) + 63) & ~63)
+#define NR_LIFECYCLE_TESTS	0
+
+static void check_steal_time_lifecycle(void)
+{
+}
 
 #define SMCCC_ARCH_FEATURES	0x80000001
 #define PV_TIME_FEATURES	0xc5000020
@@ -239,6 +251,7 @@ static void check_steal_time_uapi(void)
 
 /* SBI STA shmem must have 64-byte alignment */
 #define STEAL_TIME_SIZE		((sizeof(struct sta_struct) + 63) & ~63)
+#define NR_LIFECYCLE_TESTS	3
 
 static gpa_t st_gpa[NR_VCPUS];
 
@@ -329,6 +342,129 @@ static void steal_time_dump(struct kvm_vm *vm, u32 vcpu_idx)
 	pr_info("\n");
 }
 
+static gpa_t lifecycle_second_gpa;
+
+static void sta_lifecycle_guest(void)
+{
+	sta_set_shmem(ST_GPA_BASE, 0);
+	GUEST_SYNC(0);
+	GUEST_SYNC(1);
+
+	sta_set_shmem(INVALID_GPA, 0);
+	GUEST_SYNC(2);
+	GUEST_SYNC(3);
+
+	/* Re-enable the same area, as the guest CPU online callback does. */
+	sta_set_shmem(ST_GPA_BASE, 0);
+	GUEST_SYNC(4);
+	GUEST_SYNC(5);
+
+	/* Replace the active registration without disabling it first. */
+	sta_set_shmem(lifecycle_second_gpa, 0);
+	GUEST_SYNC(6);
+	GUEST_SYNC(7);
+	sta_set_shmem(INVALID_GPA, 0);
+	GUEST_DONE();
+}
+
+static void sta_lifecycle_run(struct kvm_vcpu *vcpu, unsigned int stage)
+{
+	struct ucall uc;
+
+	vcpu_run(vcpu);
+	switch (get_ucall(vcpu, &uc)) {
+	case UCALL_SYNC:
+		TEST_ASSERT_EQ(uc.args[1], stage);
+		break;
+	case UCALL_DONE:
+		TEST_ASSERT_EQ(stage, 8);
+		break;
+	case UCALL_ABORT:
+		REPORT_GUEST_ASSERT(uc);
+	default:
+		TEST_FAIL("Unexpected STA lifecycle exit at stage %u", stage);
+	}
+}
+
+static void check_sta_page(struct sta_struct *st, struct sta_struct *before)
+{
+	TEST_ASSERT(st->sequence != before->sequence && !(st->sequence & 1),
+		    "Expected a completed STA update, sequence=%u", st->sequence);
+	TEST_ASSERT(st->steal > before->steal, "STA stolen time did not advance");
+	TEST_ASSERT_EQ(st->flags, 0);
+	TEST_ASSERT_EQ(st->preempted, 0);
+}
+
+static void check_steal_time_lifecycle(void)
+{
+	struct sta_struct snapshot, before, *first, *second;
+	size_t host_page_size = getpagesize();
+	unsigned long dirty = 0;
+	unsigned int gpages;
+	struct kvm_vcpu *vcpu;
+	struct kvm_vm *vm;
+
+	vm = vm_create_with_one_vcpu(&vcpu, sta_lifecycle_guest);
+	gpages = vm_calc_num_guest_pages(VM_MODE_DEFAULT, 2 * host_page_size);
+	vm_userspace_mem_region_add(vm, VM_MEM_SRC_ANONYMOUS, ST_GPA_BASE,
+				    1, gpages, KVM_MEM_LOG_DIRTY_PAGES);
+	/* Also exercise an STA structure ending at a host page boundary. */
+	WRITE_AND_SYNC_TO_GUEST(vm, lifecycle_second_gpa,
+				ST_GPA_BASE + 2 * host_page_size - sizeof(struct sta_struct));
+	first = addr_gpa2hva(vm, ST_GPA_BASE);
+	second = addr_gpa2hva(vm, lifecycle_second_gpa);
+
+	/* Establish active updates on the first page before testing disable. */
+	sta_lifecycle_run(vcpu, 0);
+	before = *first;
+	/* Registration writes zeroes and dirties the page independently. */
+	kvm_vm_get_dirty_log(vm, 1, &dirty);
+	force_steal_time();
+	sta_lifecycle_run(vcpu, 1);
+	check_sta_page(first, &before);
+	kvm_vm_get_dirty_log(vm, 1, &dirty);
+	TEST_ASSERT_EQ(dirty, BIT(0));
+
+	sta_lifecycle_run(vcpu, 2);
+	snapshot = *first;
+	/* Entry before the disable call may have updated the old area. */
+	kvm_vm_get_dirty_log(vm, 1, &dirty);
+	force_steal_time();
+	sta_lifecycle_run(vcpu, 3);
+	TEST_ASSERT(!memcmp(first, &snapshot, sizeof(snapshot)),
+		    "Disabled STA shared page was modified");
+	kvm_vm_get_dirty_log(vm, 1, &dirty);
+	TEST_ASSERT_EQ(dirty, 0);
+	ksft_test_result_pass("STA disable stops shared page updates\n");
+
+	sta_lifecycle_run(vcpu, 4);
+	before = *first;
+	kvm_vm_get_dirty_log(vm, 1, &dirty);
+	force_steal_time();
+	sta_lifecycle_run(vcpu, 5);
+	check_sta_page(first, &before);
+	kvm_vm_get_dirty_log(vm, 1, &dirty);
+	TEST_ASSERT_EQ(dirty, BIT(0));
+	ksft_test_result_pass("STA re-enable resumes shared page updates\n");
+
+	sta_lifecycle_run(vcpu, 6);
+	/* Snapshot after the last entry that could still update the old area. */
+	snapshot = *first;
+	before = *second;
+	kvm_vm_get_dirty_log(vm, 1, &dirty);
+	force_steal_time();
+	sta_lifecycle_run(vcpu, 7);
+	check_sta_page(second, &before);
+	TEST_ASSERT(!memcmp(first, &snapshot, sizeof(snapshot)),
+		    "Old STA shared page was modified after replacement");
+	kvm_vm_get_dirty_log(vm, 1, &dirty);
+	TEST_ASSERT_EQ(dirty, BIT(1));
+	ksft_test_result_pass("STA active replacement updates only the new page\n");
+
+	sta_lifecycle_run(vcpu, 8);
+	kvm_vm_free(vm);
+}
+
 static void check_steal_time_uapi(void)
 {
 	struct kvm_vm *vm;
@@ -368,8 +504,13 @@ static void check_steal_time_uapi(void)
 
 /* steal_time must have 64-byte alignment */
 #define STEAL_TIME_SIZE		((sizeof(struct kvm_steal_time) + 63) & ~63)
+#define NR_LIFECYCLE_TESTS	0
 #define KVM_STEAL_PHYS_VALID	BIT_ULL(0)
 
+static void check_steal_time_lifecycle(void)
+{
+}
+
 struct kvm_steal_time {
 	__u64 steal;
 	__u32 version;
@@ -466,22 +607,58 @@ static void check_steal_time_uapi(void)
 }
 #endif
 
+struct steal_time_worker {
+	bool stop;
+	struct timespec deadline;
+};
+
 static void *do_steal_time(void *arg)
 {
-	struct timespec ts, stop;
+	struct steal_time_worker *worker = arg;
+	struct timespec ts;
 
-	clock_gettime(CLOCK_MONOTONIC, &ts);
-	stop = timespec_add_ns(ts, MIN_RUN_DELAY_NS);
-
-	while (1) {
+	while (!READ_ONCE(worker->stop)) {
 		clock_gettime(CLOCK_MONOTONIC, &ts);
-		if (timespec_to_ns(timespec_sub(ts, stop)) >= 0)
+		if (timespec_to_ns(timespec_sub(ts, worker->deadline)) >= 0)
 			break;
 	}
 
 	return NULL;
 }
 
+/* The caller is pinned; its worker inherits the same CPU affinity. */
+static long force_steal_time(void)
+{
+	struct steal_time_worker worker = {};
+	struct timespec ts;
+	pthread_t thread;
+	cpu_set_t cpuset;
+	long start, delay;
+	int cpu = sched_getcpu();
+
+	clock_gettime(CLOCK_MONOTONIC, &ts);
+	worker.deadline = timespec_add_ns(ts, 5 * NSEC_PER_SEC);
+	start = get_run_delay();
+	kvm_pthread_create(&thread, NULL, do_steal_time, &worker);
+	kvm_pthread_getaffinity(thread, &cpuset);
+	TEST_ASSERT(CPU_COUNT(&cpuset) == 1 && CPU_ISSET(cpu, &cpuset),
+		    "Worker failed to inherit parent's CPU affinity");
+
+	do {
+		sched_yield();
+		delay = get_run_delay() - start;
+		clock_gettime(CLOCK_MONOTONIC, &ts);
+	} while (delay < MIN_RUN_DELAY_NS &&
+		 timespec_to_ns(timespec_sub(ts, worker.deadline)) < 0);
+
+	WRITE_ONCE(worker.stop, true);
+	kvm_pthread_join(thread, NULL);
+	TEST_ASSERT(delay >= MIN_RUN_DELAY_NS,
+		    "Timed out waiting for runnable delay: expected >= %lu ns, got %ld",
+		    MIN_RUN_DELAY_NS, delay);
+	return delay;
+}
+
 static void run_vcpu(struct kvm_vcpu *vcpu)
 {
 	struct ucall uc;
@@ -509,7 +686,8 @@ static struct kvm_vm *vm_create_steal_time(u32 nr_vcpus, void *guest_code,
 	/* Create a VM and an identity mapped memslot for the steal time structure */
 	vm = vm_create_with_vcpus(nr_vcpus, guest_code, vcpus);
 	gpages = vm_calc_num_guest_pages(VM_MODE_DEFAULT, STEAL_TIME_SIZE * nr_vcpus);
-	vm_userspace_mem_region_add(vm, VM_MEM_SRC_ANONYMOUS, ST_GPA_BASE, 1, gpages, 0);
+	vm_userspace_mem_region_add(vm, VM_MEM_SRC_ANONYMOUS, ST_GPA_BASE,
+				    1, gpages, KVM_MEM_LOG_DIRTY_PAGES);
 	virt_map(vm, ST_GPA_BASE, ST_GPA_BASE, gpages);
 
 	return vm;
@@ -518,26 +696,31 @@ static struct kvm_vm *vm_create_steal_time(u32 nr_vcpus, void *guest_code,
 int main(int ac, char **av)
 {
 	struct kvm_vcpu *vcpus[NR_VCPUS];
+	unsigned long *dirty_log;
+	unsigned int dirty_npages, page;
 	struct kvm_vm *vm;
-	pthread_t thread;
-	cpu_set_t cpuset;
 	long stolen_time;
 	long run_delay;
 	bool verbose;
-	int i, cpu;
+	int i;
 
 	verbose = ac > 1 && (!strncmp(av[1], "-v", 3) || !strncmp(av[1], "--verbose", 10));
 
 	/* Set CPU affinity so we can force preemption of the VCPU */
-	cpu = pin_self_to_any_cpu();
+	pin_self_to_any_cpu();
 
 	vm = vm_create_steal_time(NR_VCPUS, guest_code, vcpus);
 
 	ksft_print_header();
 	TEST_REQUIRE(is_steal_time_supported(vcpus[0]));
-	ksft_set_plan(NR_VCPUS);
+	TEST_REQUIRE(!access("/proc/self/schedstat", R_OK));
+	ksft_set_plan(2 * NR_VCPUS + NR_LIFECYCLE_TESTS);
+	dirty_npages = memslot2region(vm, 1)->region.memory_size / getpagesize();
+	dirty_log = bitmap_zalloc(dirty_npages);
+	TEST_ASSERT(dirty_log, "Failed to allocate dirty log");
 
 	check_steal_time_uapi();
+	check_steal_time_lifecycle();
 
 	/* Run test on each VCPU */
 	for (i = 0; i < NR_VCPUS; ++i) {
@@ -547,30 +730,24 @@ int main(int ac, char **av)
 
 		/* First VCPU run initializes steal-time */
 		run_vcpu(vcpus[i]);
+		/* Exclude initialization writes from the accounting dirty log. */
+		kvm_vm_get_dirty_log(vm, 1, dirty_log);
+		force_steal_time();
 
 		/* Second VCPU run, expect guest stolen time to be <= run_delay */
 		run_vcpu(vcpus[i]);
+		kvm_vm_get_dirty_log(vm, 1, dirty_log);
+		for (page = 0; page < dirty_npages; page++)
+			TEST_ASSERT_EQ(!!test_bit(page, dirty_log),
+				       page == i * STEAL_TIME_SIZE / getpagesize());
+		ksft_test_result_pass("vcpu%d shared page update is marked dirty\n", i);
 		stolen_time = SYNC_FROM_GUEST_AND_READ(vm, guest_stolen_time[i]);
 		run_delay = get_run_delay();
 		TEST_ASSERT(stolen_time <= run_delay,
 			    "Expected stolen time <= %ld, got %ld",
 			    run_delay, stolen_time);
 
-		/* Steal time from the VCPU. The steal time thread has the same CPU affinity as the VCPUs. */
-		run_delay = get_run_delay();
-		kvm_pthread_create(&thread, NULL, do_steal_time, NULL);
-		kvm_pthread_getaffinity(thread, &cpuset);
-		TEST_ASSERT(CPU_COUNT(&cpuset) == 1 && CPU_ISSET(cpu, &cpuset),
-			    "Worker failed to inherit parent's CPU affinity");
-
-		do
-			sched_yield();
-		while (get_run_delay() - run_delay < MIN_RUN_DELAY_NS);
-		kvm_pthread_join(thread, NULL);
-		run_delay = get_run_delay() - run_delay;
-		TEST_ASSERT(run_delay >= MIN_RUN_DELAY_NS,
-			    "Expected run_delay >= %ld, got %ld",
-			    MIN_RUN_DELAY_NS, run_delay);
+		run_delay = force_steal_time();
 
 		/* Run VCPU again to confirm stolen time is consistent with run_delay */
 		run_vcpu(vcpus[i]);
@@ -588,6 +765,8 @@ int main(int ac, char **av)
 		}
 		ksft_test_result_pass("vcpu%d\n", i);
 	}
+	free(dirty_log);
+	kvm_vm_free(vm);
 
 	/* Print results and exit() accordingly */
 	ksft_finished();
-- 
2.34.1

