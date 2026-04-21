Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0458333B6CC
	for <kvm@vger.kernel.org>; Tue, 21 Apr 2026 23:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776813386; cv=none; b=rUh22bqz5K6OA6l7ZR/7PKb+PJ9dILLiokXKlyC705nj1Q4dACtwh8En/dHU8gt7Npz8SzkAseX3vtNB791ResLrxUcn3kHE1G4vqqTf7SOHeGMc/otFC+ekyve41Xuxb6/d0wtTHGWHvpvo7fi7/wbeGe64RMMiAcATcXWMyaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776813386; c=relaxed/simple;
	bh=teRtuSAZMi2WrLpwGlWDr79ldyhEAGld70T3XoZK5mA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fLGvMMWecalTcEdlcUEzTSybwGu9iDfF/ZJd684D7kzS0+vTOoyvN573r7eacNCH6eYe+2B2vFsU0xK8N1D/8ViiXR6OMoyY9hU3sCQApesHLgt8Fk4CW4cVMFkR2ZkBdKV/HzMWvYDS0bxwryzOMNtBEAk4AoCPzmJ5cY9sICo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=E3JQeDMx; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E3JQeDMx"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-82f6e6a3a76so5913345b3a.0
        for <kvm@vger.kernel.org>; Tue, 21 Apr 2026 16:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776813384; x=1777418184; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FwatT0V+jKnF19uq58SkHbFVpF1HDKdkG1///6NKWgs=;
        b=E3JQeDMx+0XQR4GM+H2xSp+2e4O6of+9mlrtGlxfQ5YAVoPSpCMxw/30mzm703KC/U
         7XoSdgD+dml1lZtCvU4mEFn+W+w1Do2oNFN7idMR4Oz47YfqoOErvGbPXjAisXqi9lo7
         oRQtPnOiuUKGV7T3bWuRlgaK4oUICcoQ41V+uzPNcw+8ZEzfahJwqhyrXQxraewl+XP+
         yicUVMJjQAZOL7bAJCxyzGICFPeAco6w9jw+pWL6YmXPygS1At21jcdwqkhBG2Yybejd
         m8U2SqWoYxJQe1M9gEluJQymkGpe9gvCuAKiamRtPcaGqYaLh/1cgjLVxkmUJRKShio+
         0LjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776813384; x=1777418184;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FwatT0V+jKnF19uq58SkHbFVpF1HDKdkG1///6NKWgs=;
        b=FFDLE+32GTUkJppptv19qVM7edNtN7c7Qr/2OD9EjrYjStDuGUhMDNcZiotW8be08e
         H0fRz6nVxc6F4GSSRr4RxItetpEdLiTjZ3/+PFBuSEXR3lo1fPbhpUjg1CLQx7okfFFL
         88kRd6+iMaqHB8aL/7So3CPhjuHRYj4Rk2q6hKFmU+cwEwQSi5E/HyZ89eB2hNbYJnoq
         puxzj2uJpp9OTErCSRTLwOdi6hRxdqLFqgkz0lJyECIimUPlXQlWaz2PG/f/b4Tbr8eI
         mzCGfUU+SYJ+gGQEFyqm6jZSC8VccpotH88bEGD08/0uoJ83PgVEsyuVsmWTJp+nRsV0
         CHSw==
X-Gm-Message-State: AOJu0YyG3APHlmwYLkLsoGNq0IpFktlHnelEoc4tOV6/Vlrgy9BOibUJ
	ig14HUoq+kuxj/IvT6Q3mHEaY0uukZOyoR6NZtEX75bY/EVzInHBYVdN5MkRWRH70rmQANb7ktt
	HDldyWLSI
X-Received: from pfbha15.prod.google.com ([2002:a05:6a00:850f:b0:82f:a9ab:e28c])
 (user=jrhilke job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:4ac9:b0:82c:217c:98ca
 with SMTP id d2e1a72fcca58-82f8c828d95mr20260813b3a.12.1776813384163; Tue, 21
 Apr 2026 16:16:24 -0700 (PDT)
Date: Tue, 21 Apr 2026 23:15:44 +0000
In-Reply-To: <20260421231557.1254270-1-jrhilke@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260421231557.1254270-1-jrhilke@google.com>
X-Mailer: git-send-email 2.54.0.rc2.533.g4f5dca5207-goog
Message-ID: <20260421231557.1254270-4-jrhilke@google.com>
Subject: [PATCH v3 03/16] KVM: selftests: Add guest read/write macros
From: Josh Hilke <jrhilke@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Matlack <dmatlack@google.com>, Alex Williamson <alex@shazbot.org>, Josh Hilke <jrhilke@google.com>
Content-Type: text/plain; charset="UTF-8"

From: David Matlack <dmatlack@google.com>

Add SYNC_FROM_GUEST_AND_READ(vm, variable), to read a variable value
from the guest. Add WRITE_AND_SYNC_TO_GUEST(vm, variable) to write a
value to a guest variable. These macros improve the readability of code
which reads and writes data between host and guest in tests.

Also update existing guest reads/writes to use these macros in the
following tests:
- tools/testing/selftests/kvm/dirty_log_test.c
- tools/testing/selftests/kvm/mmu_stress_test.c
- tools/testing/selftests/kvm/steal_time.c

No functional changes are intended.

Suggested-by: Sean Christopherson <seanjc@google.com>
Co-developed-by: Josh Hilke <jrhilke@google.com>
Signed-off-by: Josh Hilke <jrhilke@google.com>
Signed-off-by: David Matlack <dmatlack@google.com>
---
 tools/testing/selftests/kvm/dirty_log_test.c  |  6 ++----
 .../testing/selftests/kvm/include/kvm_util.h  | 10 +++++++++
 tools/testing/selftests/kvm/mmu_stress_test.c |  9 +++-----
 tools/testing/selftests/kvm/steal_time.c      | 21 +++++++------------
 4 files changed, 22 insertions(+), 24 deletions(-)

diff --git a/tools/testing/selftests/kvm/dirty_log_test.c b/tools/testing/selftests/kvm/dirty_log_test.c
index d58a641b0e6a..66c3d9554379 100644
--- a/tools/testing/selftests/kvm/dirty_log_test.c
+++ b/tools/testing/selftests/kvm/dirty_log_test.c
@@ -764,16 +764,14 @@ static void run_test(enum vm_guest_mode mode, void *arg)
 		 * writing memory during verification, pages that this thread
 		 * sees as clean may be written with this iteration's value.
 		 */
-		WRITE_ONCE(vcpu_stop, true);
-		sync_global_to_guest(vm, vcpu_stop);
+		WRITE_AND_SYNC_TO_GUEST(vm, vcpu_stop, true);
 		sem_wait(&sem_vcpu_stop);
 
 		/*
 		 * Clear vcpu_stop after the vCPU thread has acknowledge the
 		 * stop request and is waiting, i.e. is definitely not running!
 		 */
-		WRITE_ONCE(vcpu_stop, false);
-		sync_global_to_guest(vm, vcpu_stop);
+		WRITE_AND_SYNC_TO_GUEST(vm, vcpu_stop, false);
 
 		/*
 		 * Sync the number of writes performed before verification, the
diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
index 8b39cb919f4f..499e695f1fc4 100644
--- a/tools/testing/selftests/kvm/include/kvm_util.h
+++ b/tools/testing/selftests/kvm/include/kvm_util.h
@@ -1144,6 +1144,16 @@ vm_adjust_num_guest_pages(enum vm_guest_mode mode, unsigned int num_guest_pages)
 	memcpy(&(g), _p, sizeof(g));				\
 })
 
+#define SYNC_FROM_GUEST_AND_READ(_vm, _variable) ({		\
+	sync_global_from_guest(_vm, _variable);			\
+	READ_ONCE(_variable);					\
+})
+
+#define WRITE_AND_SYNC_TO_GUEST(_vm, _variable, _value) do {	\
+	WRITE_ONCE(_variable, _value);				\
+	sync_global_to_guest(_vm, _variable);			\
+} while (0)
+
 /*
  * Write a global value, but only in the VM's (guest's) domain.  Primarily used
  * for "globals" that hold per-VM values (VMs always duplicate code and global
diff --git a/tools/testing/selftests/kvm/mmu_stress_test.c b/tools/testing/selftests/kvm/mmu_stress_test.c
index 51c070556f3e..a9fac4bc02c2 100644
--- a/tools/testing/selftests/kvm/mmu_stress_test.c
+++ b/tools/testing/selftests/kvm/mmu_stress_test.c
@@ -155,10 +155,8 @@ static void *vcpu_worker(void *data)
 		    "Expected EFAULT on write to RO memory, got r = %d, errno = %d", r, errno);
 
 	atomic_inc(&nr_ro_faults);
-	if (atomic_read(&nr_ro_faults) == nr_vcpus) {
-		WRITE_ONCE(all_vcpus_hit_ro_fault, true);
-		sync_global_to_guest(vm, all_vcpus_hit_ro_fault);
-	}
+	if (atomic_read(&nr_ro_faults) == nr_vcpus)
+		WRITE_AND_SYNC_TO_GUEST(vm, all_vcpus_hit_ro_fault, true);
 
 #if defined(__x86_64__) || defined(__aarch64__)
 	/*
@@ -383,8 +381,7 @@ int main(int argc, char *argv[])
 	rendezvous_with_vcpus(&time_run2, "run 2");
 
 	mprotect(mem, slot_size, PROT_READ);
-	mprotect_ro_done = true;
-	sync_global_to_guest(vm, mprotect_ro_done);
+	WRITE_AND_SYNC_TO_GUEST(vm, mprotect_ro_done, true);
 
 	rendezvous_with_vcpus(&time_ro, "mprotect RO");
 	mprotect(mem, slot_size, PROT_READ | PROT_WRITE);
diff --git a/tools/testing/selftests/kvm/steal_time.c b/tools/testing/selftests/kvm/steal_time.c
index 7be8adfe5dd3..23380de79817 100644
--- a/tools/testing/selftests/kvm/steal_time.c
+++ b/tools/testing/selftests/kvm/steal_time.c
@@ -72,8 +72,7 @@ static void steal_time_init(struct kvm_vcpu *vcpu, uint32_t i)
 	int ret;
 
 	/* ST_GPA_BASE is identity mapped */
-	st_gva[i] = (void *)(ST_GPA_BASE + i * STEAL_TIME_SIZE);
-	sync_global_to_guest(vcpu->vm, st_gva[i]);
+	WRITE_AND_SYNC_TO_GUEST(vcpu->vm, st_gva[i], (void *)(ST_GPA_BASE + i * STEAL_TIME_SIZE));
 
 	ret = _vcpu_set_msr(vcpu, MSR_KVM_STEAL_TIME,
 			    (ulong)st_gva[i] | KVM_STEAL_RESERVED_MASK);
@@ -181,8 +180,7 @@ static void steal_time_init(struct kvm_vcpu *vcpu, uint32_t i)
 	vcpu_ioctl(vcpu, KVM_HAS_DEVICE_ATTR, &dev);
 
 	/* ST_GPA_BASE is identity mapped */
-	st_gva[i] = (void *)(ST_GPA_BASE + i * STEAL_TIME_SIZE);
-	sync_global_to_guest(vm, st_gva[i]);
+	WRITE_AND_SYNC_TO_GUEST(vm, st_gva[i], (void *)(ST_GPA_BASE + i * STEAL_TIME_SIZE));
 
 	st_ipa = (ulong)st_gva[i] | 1;
 	ret = __vcpu_ioctl(vcpu, KVM_SET_DEVICE_ATTR, &dev);
@@ -279,10 +277,8 @@ static bool is_steal_time_supported(struct kvm_vcpu *vcpu)
 static void steal_time_init(struct kvm_vcpu *vcpu, uint32_t i)
 {
 	/* ST_GPA_BASE is identity mapped */
-	st_gva[i] = (void *)(ST_GPA_BASE + i * STEAL_TIME_SIZE);
-	st_gpa[i] = addr_gva2gpa(vcpu->vm, (vm_vaddr_t)st_gva[i]);
-	sync_global_to_guest(vcpu->vm, st_gva[i]);
-	sync_global_to_guest(vcpu->vm, st_gpa[i]);
+	WRITE_AND_SYNC_TO_GUEST(vcpu->vm, st_gva[i], (void *)(ST_GPA_BASE + i * STEAL_TIME_SIZE));
+	WRITE_AND_SYNC_TO_GUEST(vcpu->vm, st_gpa[i], addr_gva2gpa(vcpu->vm, (vm_vaddr_t)st_gva[i]));
 }
 
 static void steal_time_dump(struct kvm_vm *vm, uint32_t vcpu_idx)
@@ -376,8 +372,7 @@ static void steal_time_init(struct kvm_vcpu *vcpu, uint32_t i)
 	};
 
 	/* ST_GPA_BASE is identity mapped */
-	st_gva[i] = (void *)(ST_GPA_BASE + i * STEAL_TIME_SIZE);
-	sync_global_to_guest(vm, st_gva[i]);
+	WRITE_AND_SYNC_TO_GUEST(vm, st_gva[i], (void *)(ST_GPA_BASE + i * STEAL_TIME_SIZE));
 
 	err = __vcpu_ioctl(vcpu, KVM_HAS_DEVICE_ATTR, &attr);
 	TEST_ASSERT(err == 0, "No PV stealtime Feature");
@@ -476,8 +471,7 @@ int main(int ac, char **av)
 
 		/* Second VCPU run, expect guest stolen time to be <= run_delay */
 		run_vcpu(vcpus[i]);
-		sync_global_from_guest(vm, guest_stolen_time[i]);
-		stolen_time = guest_stolen_time[i];
+		stolen_time = SYNC_FROM_GUEST_AND_READ(vm, guest_stolen_time[i]);
 		run_delay = get_run_delay();
 		TEST_ASSERT(stolen_time <= run_delay,
 			    "Expected stolen time <= %ld, got %ld",
@@ -497,8 +491,7 @@ int main(int ac, char **av)
 
 		/* Run VCPU again to confirm stolen time is consistent with run_delay */
 		run_vcpu(vcpus[i]);
-		sync_global_from_guest(vm, guest_stolen_time[i]);
-		stolen_time = guest_stolen_time[i] - stolen_time;
+		stolen_time = SYNC_FROM_GUEST_AND_READ(vm, guest_stolen_time[i]) - stolen_time;
 		TEST_ASSERT(stolen_time >= run_delay,
 			    "Expected stolen time >= %ld, got %ld",
 			    run_delay, stolen_time);
-- 
2.54.0.rc2.533.g4f5dca5207-goog

