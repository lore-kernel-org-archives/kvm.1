Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18442415F3E
	for <kvm@vger.kernel.org>; Mon,  3 Aug 2026 17:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785777024; cv=none; b=gF8Tdd4HgoTfpOyvq0XPUAcZntuxQrYtWynhwHfToK3CXusQTQG6jdMLLeBeHy5xNWpuy/yymZrVcNpk3T2Nb+PLD8jgd7WG1IAzOyovY5SFcJwYB7beVVwfW3s504xVzgd45mEMdl2Rt+Rlv0gQBNTk1GETJesHsdYADwXTZZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785777024; c=relaxed/simple;
	bh=nZ6OJZOTrjIR3kzdaxYKCWrZ9bI4UC6ZXdMNIBbkOtY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Cg70Jjx3QCDF3/phA7Xmd6i11qNrFk6aZBbK0JnQdbwH4XFnTS85jYUq7+yN9H7ltePJ/KnASCxdJ/aa9mb/uA9hmw+6WTnlHCThfehRIrA7SkA4t/oX5AXa0949Oah9X2ZgUinarFCW0HTsqWMWfxJ1mROeAG1nOUz9Afz/+WI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MzZ7LJ+Z; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MzZ7LJ+Z"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-69f2c67650aso5689036a12.2
        for <kvm@vger.kernel.org>; Mon, 03 Aug 2026 10:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785777020; x=1786381820; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=dKMPkl7D6nRliBWUc2slY3eC0FUHsOIRlAVnvVpAh7Y=;
        b=MzZ7LJ+Zzyf8dxodgI6hPgJ0zyN0+cHt5Gp4RXUNrvlhHXyKYvjD6UEX8rOpjoP7I5
         yP5Am0/5xbkBzlyuzbDQEUrkhKPiKtdFBnexjtiF6YKxqPYnzAg5oOQx5539YY4rGec1
         alQpzpJdUSLepKGfq1mK4cgLflD3CM3ayTDHSu4jdJjhhnNeekHeyewQXH+1AqKiVlCD
         CyLpBj7SicZWHpnDSKCpbUiD4NYjTKfMat9w2jH8PEXIzKRDshVAW69MIvx0rfUoIyWj
         mq0GiNbOhlXAA7g1greiEeCZY96fven6cBhmWUnpNOBeFLJBEXFtex52O1F1b/5AIU/z
         qAiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785777020; x=1786381820;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dKMPkl7D6nRliBWUc2slY3eC0FUHsOIRlAVnvVpAh7Y=;
        b=fxdeIuYhYDtny4V3lH5/he5sL84s9uf+04NqagHc90ng8GxDVDIVPFjwgS5JjKOw/J
         /B0BdUyYNqAA0mzaIxFU7NSjSZUdXEZ7BTXHvdHg+12XJ9LkUmBDtiY9ZAptXXMyVDEu
         GO0gva8PBhC+5jucxmepssTg9UdTm6P0/4aRfZ/icgSb3USZt3WFlEdb3g6/gCPCCL6O
         sTy88iismOO/syk+u64WZ3raUxdnw5NWENiuhQnEJW9HhBALbT93V1sCFwf6AS4QungB
         8lAERMcK9PwEjsZCOycGxtSBsp5CelEKlJ4Hs62Z9I+wn0/HHeg4MIegxZbasmQ9rlqf
         n9FA==
X-Forwarded-Encrypted: i=1; AHgh+RrByN4IteZyxEm1y02h11Kn/AjmTX5cNfrwyDJO0UdwpAEbb+RD4tUAbsPjjr/j6pq4wJQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAVc36ihgglkhh1BT4Qk5nWg2AGysFTWitz5b2vBkVO6NOmmnC
	YCINKhsilgZENCfXwbehGxK+1Xl8MlQgRdNnfBNPAs7JtcULGwDdOwuQ
X-Gm-Gg: AR+sD11vHeI20h5mf4N/YC9ngEtHmozRh0lv82UcOvykWtXHlkXUpzSQCC4uKz4j/Rv
	jGQltYve8dDljs05GDtaR0wF6K+HPtm0nlNrApWeFqEm2c/YpUCETyN5Uj6lrWEIhK1obrwsae4
	lVnz1j4n/klwgBbfw7a1s9kqQnjDWonAhdbtBmKA2t/SNR/UrGHbn8x0YwQe7sebcao1BCtgPHN
	KD+IOAm+W2yoosUHjzX1EnWKGlCvX3yURy2n447GWGPKW/kYizgzx2v/N4nUAqZyA0+tU3toNyz
	D8LHKQt0QSwQuatWISjvYdnO0nIND9Zcil/Zu/qRIYTV53K1hxg4FU+DUkrJZxK/W0OlP8KlthV
	DNr2vaXx5IWArxQTQDqx2UdohWicKV66AkZRPCBkNJLemcD2P+kXiOkDdPRlSlPiO5ItG4x8RJD
	XCRWf0B+fgD4VuBAFe+OVTtv9MGa8fLG0Rj+RFAJmfrxVCMYx/hV+XhPV8CzpWCYLDjjmzgWIRM
	DuBEk0jpKu+Hw==
X-Received: by 2002:a05:6402:52cd:b0:6a0:a644:355e with SMTP id 4fb4d7f45d1cf-6a0a7c60f98mr9174702a12.2.1785777020112;
        Mon, 03 Aug 2026 10:10:20 -0700 (PDT)
Received: from hisam ([223.123.105.127])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a09c660f6fsm5767202a12.25.2026.08.03.10.10.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 10:10:18 -0700 (PDT)
From: Hisam Mehboob <hisamshar@gmail.com>
To: seanjc@google.com,
	pbonzini@redhat.com
Cc: maz@kernel.org,
	oupton@kernel.org,
	tabba@google.com,
	joey.gouly@arm.com,
	seiden@linux.ibm.com,
	suzuki.poulose@arm.com,
	yuzenghui@huawei.com,
	shuah@kernel.org,
	aqibaf@amazon.com,
	linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev,
	kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hisam Mehboob <hisamshar@gmail.com>
Subject: [PATCH v2] KVM: selftests: Replace ulong with unsigned long
Date: Mon,  3 Aug 2026 22:08:28 +0500
Message-ID: <20260803170825.925561-4-hisamshar@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

KVM selftests use the non-standard ulong alias in several files. glibc
exposes the alias transitively through its headers, whereas musl does not,
causing musl builds to fail with ulong undeclared.

Use unsigned long directly instead of depending on a libc-specific typedef.
This also avoids adding a duplicate typedef to a shared tools header.

Reported-by: Aqib Faruqui <aqibaf@amazon.com>
Closes: https://lore.kernel.org/r/20250829142556.72577-10-aqibaf@amazon.com
Signed-off-by: Hisam Mehboob <hisamshar@gmail.com>
---
Changes in v2:
- Replaced KVM selftest uses directly instead of adding a shared typedef.
- Dropped the tools/include/linux/types.h change.
- Added Reported-by and Closes tags.

Tested on x86_64 with:
- make -C tools/testing/selftests/kvm
- make -C tools/testing/selftests/kvm CC=musl-gcc

v1: https://lore.kernel.org/r/20260531144934.403888-3-hisamshar@gmail.com/

 .../testing/selftests/kvm/arm64/hypercalls.c  |  2 +-
 .../testing/selftests/kvm/memslot_perf_test.c |  2 +-
 tools/testing/selftests/kvm/steal_time.c      | 20 +++++++++----------
 tools/testing/selftests/kvm/x86/amx_test.c    |  2 +-
 tools/testing/selftests/kvm/x86/cpuid_test.c  |  2 +-
 .../testing/selftests/kvm/x86/hyperv_clock.c  |  2 +-
 .../testing/selftests/kvm/x86/hyperv_evmcs.c  |  4 ++--
 .../selftests/kvm/x86/hyperv_svm_test.c       |  2 +-
 .../selftests/kvm/x86/set_boot_cpu_id.c       |  2 +-
 tools/testing/selftests/kvm/x86/state_test.c  |  4 ++--
 .../testing/selftests/kvm/x86/tsc_msrs_test.c |  2 +-
 .../kvm/x86/vmx_nested_la57_state_test.c      |  2 +-
 .../kvm/x86/vmx_preemption_timer_test.c       |  4 ++--
 13 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/tools/testing/selftests/kvm/arm64/hypercalls.c b/tools/testing/selftests/kvm/arm64/hypercalls.c
index 5d96cdf382c4..90d22b2cb6cc 100644
--- a/tools/testing/selftests/kvm/arm64/hypercalls.c
+++ b/tools/testing/selftests/kvm/arm64/hypercalls.c
@@ -162,7 +162,7 @@ struct st_time {
 
 static void steal_time_init(struct kvm_vcpu *vcpu)
 {
-	u64 st_ipa = (ulong)ST_GPA_BASE;
+	u64 st_ipa = (unsigned long)ST_GPA_BASE;
 	unsigned int gpages;
 
 	gpages = vm_calc_num_guest_pages(VM_MODE_DEFAULT, STEAL_TIME_SIZE);
diff --git a/tools/testing/selftests/kvm/memslot_perf_test.c b/tools/testing/selftests/kvm/memslot_perf_test.c
index 4d9ad6104a6e..8f26b1cee0cd 100644
--- a/tools/testing/selftests/kvm/memslot_perf_test.c
+++ b/tools/testing/selftests/kvm/memslot_perf_test.c
@@ -152,7 +152,7 @@ static void *vcpu_worker(void *__data)
 		case UCALL_SYNC:
 			TEST_ASSERT(uc.args[1] == 0,
 				"Unexpected sync ucall, got %lx",
-				(ulong)uc.args[1]);
+				(unsigned long)uc.args[1]);
 			sem_post(&vcpu_ready);
 			continue;
 		case UCALL_NONE:
diff --git a/tools/testing/selftests/kvm/steal_time.c b/tools/testing/selftests/kvm/steal_time.c
index 19a97d6a3607..b8e78b430669 100644
--- a/tools/testing/selftests/kvm/steal_time.c
+++ b/tools/testing/selftests/kvm/steal_time.c
@@ -73,12 +73,12 @@ static void steal_time_init(struct kvm_vcpu *vcpu, u32 i)
 	st_gva[i] = (void *)(ST_GPA_BASE + i * STEAL_TIME_SIZE);
 	sync_global_to_guest(vcpu->vm, st_gva[i]);
 
-	vcpu_set_msr(vcpu, MSR_KVM_STEAL_TIME, (ulong)st_gva[i] | KVM_MSR_ENABLED);
+	vcpu_set_msr(vcpu, MSR_KVM_STEAL_TIME, (unsigned long)st_gva[i] | KVM_MSR_ENABLED);
 }
 
 static void steal_time_dump(struct kvm_vm *vm, u32 vcpu_idx)
 {
-	struct kvm_steal_time *st = addr_gva2hva(vm, (ulong)st_gva[vcpu_idx]);
+	struct kvm_steal_time *st = addr_gva2hva(vm, (unsigned long)st_gva[vcpu_idx]);
 
 	ksft_print_msg("VCPU%d:\n", vcpu_idx);
 	ksft_print_msg("    steal:     %lld\n", st->steal);
@@ -102,7 +102,7 @@ static void check_steal_time_uapi(void)
 	vm = vm_create_with_one_vcpu(&vcpu, NULL);
 
 	ret = _vcpu_set_msr(vcpu, MSR_KVM_STEAL_TIME,
-			    (ulong)ST_GPA_BASE | KVM_STEAL_RESERVED_MASK);
+			    (unsigned long)ST_GPA_BASE | KVM_STEAL_RESERVED_MASK);
 	TEST_ASSERT(ret == 0, "Bad GPA didn't fail");
 
 	kvm_vm_free(vm);
@@ -151,7 +151,7 @@ static void guest_code(int cpu)
 
 	status = smccc(PV_TIME_ST, 0);
 	GUEST_ASSERT_NE(status, -1);
-	GUEST_ASSERT_EQ(status, (ulong)st_gva[cpu]);
+	GUEST_ASSERT_EQ(status, (unsigned long)st_gva[cpu]);
 
 	st = (struct st_time *)status;
 	GUEST_SYNC(0);
@@ -190,13 +190,13 @@ static void steal_time_init(struct kvm_vcpu *vcpu, u32 i)
 	st_gva[i] = (void *)(ST_GPA_BASE + i * STEAL_TIME_SIZE);
 	sync_global_to_guest(vm, st_gva[i]);
 
-	st_ipa = (ulong)st_gva[i];
+	st_ipa = (unsigned long)st_gva[i];
 	vcpu_ioctl(vcpu, KVM_SET_DEVICE_ATTR, &dev);
 }
 
 static void steal_time_dump(struct kvm_vm *vm, u32 vcpu_idx)
 {
-	struct st_time *st = addr_gva2hva(vm, (ulong)st_gva[vcpu_idx]);
+	struct st_time *st = addr_gva2hva(vm, (unsigned long)st_gva[vcpu_idx]);
 
 	ksft_print_msg("VCPU%d:\n", vcpu_idx);
 	ksft_print_msg("    rev:     %d\n", st->rev);
@@ -223,11 +223,11 @@ static void check_steal_time_uapi(void)
 	vm_userspace_mem_region_add(vm, VM_MEM_SRC_ANONYMOUS, ST_GPA_BASE, 1, 1, 0);
 	virt_map(vm, ST_GPA_BASE, ST_GPA_BASE, 1);
 
-	st_ipa = (ulong)ST_GPA_BASE | 1;
+	st_ipa = (unsigned long)ST_GPA_BASE | 1;
 	ret = __vcpu_ioctl(vcpu, KVM_SET_DEVICE_ATTR, &dev);
 	TEST_ASSERT(ret == -1 && errno == EINVAL, "Bad IPA didn't report EINVAL");
 
-	st_ipa = (ulong)ST_GPA_BASE;
+	st_ipa = (unsigned long)ST_GPA_BASE;
 	vcpu_ioctl(vcpu, KVM_SET_DEVICE_ATTR, &dev);
 
 	ret = __vcpu_ioctl(vcpu, KVM_SET_DEVICE_ATTR, &dev);
@@ -318,7 +318,7 @@ static void steal_time_init(struct kvm_vcpu *vcpu, u32 i)
 
 static void steal_time_dump(struct kvm_vm *vm, u32 vcpu_idx)
 {
-	struct sta_struct *st = addr_gva2hva(vm, (ulong)st_gva[vcpu_idx]);
+	struct sta_struct *st = addr_gva2hva(vm, (unsigned long)st_gva[vcpu_idx]);
 	int i;
 
 	pr_info("VCPU%d:\n", vcpu_idx);
@@ -455,7 +455,7 @@ static void steal_time_init(struct kvm_vcpu *vcpu, u32 i)
 
 static void steal_time_dump(struct kvm_vm *vm, u32 vcpu_idx)
 {
-	struct kvm_steal_time *st = addr_gva2hva(vm, (ulong)st_gva[vcpu_idx]);
+	struct kvm_steal_time *st = addr_gva2hva(vm, (unsigned long)st_gva[vcpu_idx]);
 
 	ksft_print_msg("VCPU%d:\n", vcpu_idx);
 	ksft_print_msg("    steal:     %lld\n", st->steal);
diff --git a/tools/testing/selftests/kvm/x86/amx_test.c b/tools/testing/selftests/kvm/x86/amx_test.c
index 4e63da2b1889..66b6e442c41c 100644
--- a/tools/testing/selftests/kvm/x86/amx_test.c
+++ b/tools/testing/selftests/kvm/x86/amx_test.c
@@ -325,7 +325,7 @@ int main(int argc, char *argv[])
 				vcpu_regs_get(vcpu, &regs2);
 				TEST_ASSERT(!memcmp(&regs1, &regs2, sizeof(regs2)),
 					    "Unexpected register values after vcpu_load_state; rdi: %lx rsi: %lx",
-					    (ulong) regs2.rdi, (ulong) regs2.rsi);
+					    (unsigned long)regs2.rdi, (unsigned long)regs2.rsi);
 			}
 			break;
 		case UCALL_DONE:
diff --git a/tools/testing/selftests/kvm/x86/cpuid_test.c b/tools/testing/selftests/kvm/x86/cpuid_test.c
index ef0ddd240887..dcd99a0501ee 100644
--- a/tools/testing/selftests/kvm/x86/cpuid_test.c
+++ b/tools/testing/selftests/kvm/x86/cpuid_test.c
@@ -128,7 +128,7 @@ static void run_vcpu(struct kvm_vcpu *vcpu, int stage)
 		TEST_ASSERT(!strcmp((const char *)uc.args[0], "hello") &&
 			    uc.args[1] == stage + 1,
 			    "Stage %d: Unexpected register values vmexit, got %lx",
-			    stage + 1, (ulong)uc.args[1]);
+			    stage + 1, (unsigned long)uc.args[1]);
 		return;
 	case UCALL_DONE:
 		return;
diff --git a/tools/testing/selftests/kvm/x86/hyperv_clock.c b/tools/testing/selftests/kvm/x86/hyperv_clock.c
index c083cea546dc..3dc9a9c2aa54 100644
--- a/tools/testing/selftests/kvm/x86/hyperv_clock.c
+++ b/tools/testing/selftests/kvm/x86/hyperv_clock.c
@@ -248,7 +248,7 @@ int main(void)
 		TEST_ASSERT(!strcmp((const char *)uc.args[0], "hello") &&
 			    uc.args[1] == stage,
 			    "Stage %d: Unexpected register values vmexit, got %lx",
-			    stage, (ulong)uc.args[1]);
+			    stage, (unsigned long)uc.args[1]);
 
 		/* Reset kvmclock triggering TSC page update */
 		if (stage == 7 || stage == 8 || stage == 10) {
diff --git a/tools/testing/selftests/kvm/x86/hyperv_evmcs.c b/tools/testing/selftests/kvm/x86/hyperv_evmcs.c
index 1bda2cd3f739..6bca5afccef0 100644
--- a/tools/testing/selftests/kvm/x86/hyperv_evmcs.c
+++ b/tools/testing/selftests/kvm/x86/hyperv_evmcs.c
@@ -221,7 +221,7 @@ static struct kvm_vcpu *save_restore_vm(struct kvm_vm *vm,
 	vcpu_regs_get(vcpu, &regs2);
 	TEST_ASSERT(!memcmp(&regs1, &regs2, sizeof(regs2)),
 		    "Unexpected register values after vcpu_load_state; rdi: %lx rsi: %lx",
-		    (ulong) regs2.rdi, (ulong) regs2.rsi);
+		    (unsigned long)regs2.rdi, (unsigned long)regs2.rsi);
 	return vcpu;
 }
 
@@ -277,7 +277,7 @@ int main(int argc, char *argv[])
 		/* UCALL_SYNC is handled here.  */
 		TEST_ASSERT(!strcmp((const char *)uc.args[0], "hello") &&
 			    uc.args[1] == stage, "Stage %d: Unexpected register values vmexit, got %lx",
-			    stage, (ulong)uc.args[1]);
+			    stage, (unsigned long)uc.args[1]);
 
 		vcpu = save_restore_vm(vm, vcpu);
 
diff --git a/tools/testing/selftests/kvm/x86/hyperv_svm_test.c b/tools/testing/selftests/kvm/x86/hyperv_svm_test.c
index 1f74b0fa9b83..3a3dc31072e8 100644
--- a/tools/testing/selftests/kvm/x86/hyperv_svm_test.c
+++ b/tools/testing/selftests/kvm/x86/hyperv_svm_test.c
@@ -186,7 +186,7 @@ int main(int argc, char *argv[])
 		/* UCALL_SYNC is handled here.  */
 		TEST_ASSERT(!strcmp((const char *)uc.args[0], "hello") &&
 			    uc.args[1] == stage, "Stage %d: Unexpected register values vmexit, got %lx",
-			    stage, (ulong)uc.args[1]);
+			    stage, (unsigned long)uc.args[1]);
 
 	}
 
diff --git a/tools/testing/selftests/kvm/x86/set_boot_cpu_id.c b/tools/testing/selftests/kvm/x86/set_boot_cpu_id.c
index 8e3898646c69..909cd9e83fda 100644
--- a/tools/testing/selftests/kvm/x86/set_boot_cpu_id.c
+++ b/tools/testing/selftests/kvm/x86/set_boot_cpu_id.c
@@ -69,7 +69,7 @@ static void run_vcpu(struct kvm_vcpu *vcpu)
 			TEST_ASSERT(!strcmp((const char *)uc.args[0], "hello") &&
 					uc.args[1] == stage + 1,
 					"Stage %d: Unexpected register values vmexit, got %lx",
-					stage + 1, (ulong)uc.args[1]);
+					stage + 1, (unsigned long)uc.args[1]);
 			test_set_bsp_busy(vcpu, "while running vm");
 			break;
 		case UCALL_DONE:
diff --git a/tools/testing/selftests/kvm/x86/state_test.c b/tools/testing/selftests/kvm/x86/state_test.c
index 4a1056a6cb8d..e6f521a6e737 100644
--- a/tools/testing/selftests/kvm/x86/state_test.c
+++ b/tools/testing/selftests/kvm/x86/state_test.c
@@ -296,7 +296,7 @@ int main(int argc, char *argv[])
 		/* UCALL_SYNC is handled here.  */
 		TEST_ASSERT(!strcmp((const char *)uc.args[0], "hello") &&
 			    uc.args[1] == stage, "Stage %d: Unexpected register values vmexit, got %lx",
-			    stage, (ulong)uc.args[1]);
+			    stage, (unsigned long)uc.args[1]);
 
 		state = vcpu_save_state(vcpu);
 		memset(&regs1, 0, sizeof(regs1));
@@ -343,7 +343,7 @@ int main(int argc, char *argv[])
 		vcpu_regs_get(vcpu, &regs2);
 		TEST_ASSERT(!memcmp(&regs1, &regs2, sizeof(regs2)),
 			    "Unexpected register values after vcpu_load_state; rdi: %lx rsi: %lx",
-			    (ulong) regs2.rdi, (ulong) regs2.rsi);
+			    (unsigned long)regs2.rdi, (unsigned long)regs2.rsi);
 	}
 
 done:
diff --git a/tools/testing/selftests/kvm/x86/tsc_msrs_test.c b/tools/testing/selftests/kvm/x86/tsc_msrs_test.c
index 91583969a14f..55779773614b 100644
--- a/tools/testing/selftests/kvm/x86/tsc_msrs_test.c
+++ b/tools/testing/selftests/kvm/x86/tsc_msrs_test.c
@@ -78,7 +78,7 @@ static void run_vcpu(struct kvm_vcpu *vcpu, int stage)
 		else
 			ksft_test_result_fail(
 				"stage %d: Unexpected register values vmexit, got %lx",
-				stage + 1, (ulong)uc.args[1]);
+				stage + 1, (unsigned long)uc.args[1]);
 		return;
 	case UCALL_DONE:
 		ksft_test_result_pass("stage %d passed\n", stage + 1);
diff --git a/tools/testing/selftests/kvm/x86/vmx_nested_la57_state_test.c b/tools/testing/selftests/kvm/x86/vmx_nested_la57_state_test.c
index 75073efa926d..448721b54181 100644
--- a/tools/testing/selftests/kvm/x86/vmx_nested_la57_state_test.c
+++ b/tools/testing/selftests/kvm/x86/vmx_nested_la57_state_test.c
@@ -109,7 +109,7 @@ int main(int argc, char *argv[])
 		}
 
 		TEST_ASSERT(uc.args[1] == stage,
-			    "Expected stage %d, got stage %lu", stage, (ulong)uc.args[1]);
+			    "Expected stage %d, got stage %lu", stage, (unsigned long)uc.args[1]);
 		if (stage == 1) {
 			pr_info("L2 is active; performing save/restore.\n");
 			state = vcpu_save_state(vcpu);
diff --git a/tools/testing/selftests/kvm/x86/vmx_preemption_timer_test.c b/tools/testing/selftests/kvm/x86/vmx_preemption_timer_test.c
index eb8021c33cd4..72fbf1b70e9f 100644
--- a/tools/testing/selftests/kvm/x86/vmx_preemption_timer_test.c
+++ b/tools/testing/selftests/kvm/x86/vmx_preemption_timer_test.c
@@ -193,7 +193,7 @@ int main(int argc, char *argv[])
 		/* UCALL_SYNC is handled here.  */
 		TEST_ASSERT(!strcmp((const char *)uc.args[0], "hello") &&
 			    uc.args[1] == stage, "Stage %d: Unexpected register values vmexit, got %lx",
-			    stage, (ulong)uc.args[1]);
+			    stage, (unsigned long)uc.args[1]);
 		/*
 		 * If this stage 2 then we should verify the vmx pt expiry
 		 * is as expected.
@@ -234,7 +234,7 @@ int main(int argc, char *argv[])
 		vcpu_regs_get(vcpu, &regs2);
 		TEST_ASSERT(!memcmp(&regs1, &regs2, sizeof(regs2)),
 			    "Unexpected register values after vcpu_load_state; rdi: %lx rsi: %lx",
-			    (ulong) regs2.rdi, (ulong) regs2.rsi);
+			    (unsigned long)regs2.rdi, (unsigned long)regs2.rsi);
 	}
 
 done:
-- 
2.51.0
