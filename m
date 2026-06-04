Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D4752DEA8C
	for <kvm@vger.kernel.org>; Thu,  4 Jun 2026 02:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780538556; cv=none; b=bXsEH7Nh401ISZmuGCWbfZMac9xG/auc4j2vUGG4qFpiHHf48e4rgd5lAFMekY9me2ui+rVWox/e/bZP1J61TzjEO51XuZIrETw31C1oo3gass2kedPU6oO7npqlqqGWJuBHAt01r6+vu0FVHwBaR1Xd/D9YNUdx62juLBJ9cX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780538556; c=relaxed/simple;
	bh=k3Yc1XFg6EauSlB403XZ71rI8Xpea7Gw0rMMppNrkpE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fqGMZlmPDIemms3zlVIf+2LoLKadQh8uILKNSbrdZH5Wd9XNt1KzK7BK6khANluSQTD6Tpf+GUDGApH5v/6mN5TJOT+LGAcZbKbDZdLGnM1a57RGBd0Ty328DVJlgfvJrUB3BfVB8aT9OqJxhOKQDFilEgGce/L/YA7fwWSLpsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AHAgSBrK; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AHAgSBrK"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2c0532a6588so2116625ad.0
        for <kvm@vger.kernel.org>; Wed, 03 Jun 2026 19:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780538553; x=1781143353; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Yv/smi8BVjBhAR0WbWcaPoaVTMVUt7+IZnoA91Z0pSw=;
        b=AHAgSBrKXLhWGblGNtDcJMfYT3XtznUTZa4rclc5kshijOklUiPU/dlulZ9xP7yGII
         Wk32F4j5ewnV8BEwQ47tlOcaRWNsu3EmIwKbLD45PrOpcqAYMYjRsffSjJAUDWXYZ+tl
         zG6PqK63DfGlLcRzu5OZN0G69aZLqnfaqngJ799wTIdvuCg7WmHP8IOxxcWtdZJx0lOB
         6Qz1P4rMDlA9RzhUviXf7yoa5bf7AML3TFILSkQGkZubvQ61INYH8qEaMCzL/cNYBrss
         AH//m89klCLw06srsKLdFQxneCcZMSjiGfhD5aJkN7LQM7EggMRwaJfQcy9vVMGVecfn
         71CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780538553; x=1781143353;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Yv/smi8BVjBhAR0WbWcaPoaVTMVUt7+IZnoA91Z0pSw=;
        b=H6HCqQWwvw/hMAMM2pmFRELe8OA5+tjQPy1QikCTje+CNDKGisOyBsRabCsrvVOrDs
         OjFjO/N+cxBqIaLBQBhIV4V4EpcI1m5q0qC0kubZ/qa8ClofMrnQceQjq6Mifs0MRgc7
         cxDisg27vkxnKO63u+l1/fiNdVjMdVK/JisRMAVrQrcv+aK/jePBKrKip0Ty+QZzBsnv
         6RGlcN8kKo2tBRwgCTMSfnhvfzeSbZHqsKt2pfYZwfYjaVPwWPD8CIpMT21YUYPZgpT4
         EzfXLqYDLW+3yExB/rkhzijjEnoQRB1/zUXj85KT1+4POYMQF44kpbdHzcXp1siPoqul
         w5hg==
X-Gm-Message-State: AOJu0YwdUqsfD5UfrkfD6ER7EE11NpmahlOGMOG0pM+nfacOfleazt/f
	M0EzBUDdWRcvxl6mqHExB5+lXqXXHteifZsVxy7Q5A0YwcU2U/snHalyeqJTjkWiOE3c8fzgxVF
	2eK2c5ww7
X-Received: from pgbcs9.prod.google.com ([2002:a05:6a02:4189:b0:c76:8ec1:5090])
 (user=jrhilke job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:a98:b0:3b2:924c:566e
 with SMTP id adf61e73a8af0-3b49766642bmr6444151637.36.1780538552537; Wed, 03
 Jun 2026 19:02:32 -0700 (PDT)
Date: Thu,  4 Jun 2026 02:01:24 +0000
In-Reply-To: <20260604020143.748245-1-jrhilke@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260604020143.748245-1-jrhilke@google.com>
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
Message-ID: <20260604020143.748245-3-jrhilke@google.com>
Subject: [PATCH v5 02/21] KVM: selftests: Add guest read/write macros
From: Josh Hilke <jrhilke@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Matlack <dmatlack@google.com>, Alex Williamson <alex.williamson@redhat.com>, 
	Josh Hilke <jrhilke@google.com>
Content-Type: text/plain; charset="UTF-8"

From: David Matlack <dmatlack@google.com>

Add SYNC_FROM_GUEST_AND_READ(vm, variable), to read a variable value
from the guest. Add WRITE_AND_SYNC_TO_GUEST(vm, variable, value) to
write a value to a guest variable. These macros improve the readability
of code which reads and writes data between host and guest in tests.

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
 tools/testing/selftests/kvm/dirty_log_test.c  |  9 +++-----
 .../testing/selftests/kvm/include/kvm_util.h  | 10 +++++++++
 tools/testing/selftests/kvm/mmu_stress_test.c |  9 +++-----
 tools/testing/selftests/kvm/steal_time.c      | 22 +++++++------------
 4 files changed, 24 insertions(+), 26 deletions(-)

diff --git a/tools/testing/selftests/kvm/dirty_log_test.c b/tools/testing/selftests/kvm/dirty_log_test.c
index 12446a4b6e8d..561b80064230 100644
--- a/tools/testing/selftests/kvm/dirty_log_test.c
+++ b/tools/testing/selftests/kvm/dirty_log_test.c
@@ -698,8 +698,7 @@ static void run_test(enum vm_guest_mode mode, void *arg)
 
 		sync_global_to_guest(vm, iteration);
 
-		WRITE_ONCE(nr_writes, 0);
-		sync_global_to_guest(vm, nr_writes);
+		WRITE_AND_SYNC_TO_GUEST(vm, nr_writes, 0);
 
 		dirty_ring_prev_iteration_last_page = dirty_ring_last_page;
 		WRITE_ONCE(dirty_ring_vcpu_ring_full, false);
@@ -761,16 +760,14 @@ static void run_test(enum vm_guest_mode mode, void *arg)
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
index 2ecaaa0e9965..88211d696a11 100644
--- a/tools/testing/selftests/kvm/include/kvm_util.h
+++ b/tools/testing/selftests/kvm/include/kvm_util.h
@@ -1138,6 +1138,16 @@ vm_adjust_num_guest_pages(enum vm_guest_mode mode, unsigned int num_guest_pages)
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
index 54d281419d31..473ef4c0ea9f 100644
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
index 76fcdd1fd3cb..2de87549fcc0 100644
--- a/tools/testing/selftests/kvm/steal_time.c
+++ b/tools/testing/selftests/kvm/steal_time.c
@@ -70,8 +70,8 @@ static bool is_steal_time_supported(struct kvm_vcpu *vcpu)
 static void steal_time_init(struct kvm_vcpu *vcpu, u32 i)
 {
 	/* ST_GPA_BASE is identity mapped */
-	st_gva[i] = (void *)(ST_GPA_BASE + i * STEAL_TIME_SIZE);
-	sync_global_to_guest(vcpu->vm, st_gva[i]);
+	WRITE_AND_SYNC_TO_GUEST(vcpu->vm, st_gva[i],
+				(void *)(ST_GPA_BASE + i * STEAL_TIME_SIZE));
 
 	vcpu_set_msr(vcpu, MSR_KVM_STEAL_TIME, (ulong)st_gva[i] | KVM_MSR_ENABLED);
 }
@@ -187,8 +187,7 @@ static void steal_time_init(struct kvm_vcpu *vcpu, u32 i)
 	};
 
 	/* ST_GPA_BASE is identity mapped */
-	st_gva[i] = (void *)(ST_GPA_BASE + i * STEAL_TIME_SIZE);
-	sync_global_to_guest(vm, st_gva[i]);
+	WRITE_AND_SYNC_TO_GUEST(vm, st_gva[i], (void *)(ST_GPA_BASE + i * STEAL_TIME_SIZE));
 
 	st_ipa = (ulong)st_gva[i];
 	vcpu_ioctl(vcpu, KVM_SET_DEVICE_ATTR, &dev);
@@ -310,10 +309,8 @@ static bool is_steal_time_supported(struct kvm_vcpu *vcpu)
 static void steal_time_init(struct kvm_vcpu *vcpu, u32 i)
 {
 	/* ST_GPA_BASE is identity mapped */
-	st_gva[i] = (void *)(ST_GPA_BASE + i * STEAL_TIME_SIZE);
-	st_gpa[i] = addr_gva2gpa(vcpu->vm, (gva_t)st_gva[i]);
-	sync_global_to_guest(vcpu->vm, st_gva[i]);
-	sync_global_to_guest(vcpu->vm, st_gpa[i]);
+	WRITE_AND_SYNC_TO_GUEST(vcpu->vm, st_gva[i], (void *)(ST_GPA_BASE + i * STEAL_TIME_SIZE));
+	WRITE_AND_SYNC_TO_GUEST(vcpu->vm, st_gpa[i], addr_gva2gpa(vcpu->vm, (gva_t)st_gva[i]));
 }
 
 static void steal_time_dump(struct kvm_vm *vm, u32 vcpu_idx)
@@ -442,8 +439,7 @@ static void steal_time_init(struct kvm_vcpu *vcpu, u32 i)
 	};
 
 	/* ST_GPA_BASE is identity mapped */
-	st_gva[i] = (void *)(ST_GPA_BASE + i * STEAL_TIME_SIZE);
-	sync_global_to_guest(vm, st_gva[i]);
+	WRITE_AND_SYNC_TO_GUEST(vm, st_gva[i], (void *)(ST_GPA_BASE + i * STEAL_TIME_SIZE));
 
 	err = __vcpu_ioctl(vcpu, KVM_HAS_DEVICE_ATTR, &attr);
 	TEST_ASSERT(err == 0, "No PV stealtime Feature");
@@ -549,8 +545,7 @@ int main(int ac, char **av)
 
 		/* Second VCPU run, expect guest stolen time to be <= run_delay */
 		run_vcpu(vcpus[i]);
-		sync_global_from_guest(vm, guest_stolen_time[i]);
-		stolen_time = guest_stolen_time[i];
+		stolen_time = SYNC_FROM_GUEST_AND_READ(vm, guest_stolen_time[i]);
 		run_delay = get_run_delay();
 		TEST_ASSERT(stolen_time <= run_delay,
 			    "Expected stolen time <= %ld, got %ld",
@@ -570,8 +565,7 @@ int main(int ac, char **av)
 
 		/* Run VCPU again to confirm stolen time is consistent with run_delay */
 		run_vcpu(vcpus[i]);
-		sync_global_from_guest(vm, guest_stolen_time[i]);
-		stolen_time = guest_stolen_time[i] - stolen_time;
+		stolen_time = SYNC_FROM_GUEST_AND_READ(vm, guest_stolen_time[i]) - stolen_time;
 		TEST_ASSERT(stolen_time >= run_delay,
 			    "Expected stolen time >= %ld, got %ld",
 			    run_delay, stolen_time);
-- 
2.54.0.1032.g2f8565e1d1-goog

