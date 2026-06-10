Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1648212FAD
	for <kvm@vger.kernel.org>; Wed, 10 Jun 2026 00:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781052826; cv=none; b=Fwe8Au6u/5ZbMU0JOdF37FJYyRFgkzFTKsxKrKh5hS6bTS7SaPkClZwwFcl5SbV4KBmgHDdrRsxPxjEK8XDq1QknRHbVEv0uWEUjRL2lJ22PUs9B8RJpQh8bgrFaZu328CHbkXNVnVfkI3FMpo3OX0DZbDFHFSr6BP9hwyhnY+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781052826; c=relaxed/simple;
	bh=ScPRcPwGvba396fESF1XeHxr6uaOkAA5AWqJT2uIMLw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RIz5IY5RJFGww3VMUIRBWbJOp8wy44EPcP6q4QgZLnjsFGA7GSzpc1bBwWWo0FjK4Qu+I4wvj9xC2SW2NVjr2KPOWbGOjtDpOUnuRJnqZOd9ktHzs1+nrH8ZZvhk+ko/3uRrPUpxKzJPR6kdt0ZYvpRtcn15dkL+W4hFXB9XeEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Sx5IX0UC; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Sx5IX0UC"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c85807671b1so3017891a12.2
        for <kvm@vger.kernel.org>; Tue, 09 Jun 2026 17:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781052824; x=1781657624; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=by7ZsTX6XZrYuMsgO2vouu/UY2EhVCY+8I0m+whd0SA=;
        b=Sx5IX0UCUb6TWVQ+8rGu4lhUo+m+xR6trzvRN2zJ0fdKoYDvm0EukEV1IlikwpXgLh
         B6ONRN5G+q5HAaoiuz/0E0D7Z1K+F3sHEMycq8R3SXnHZrswKf/zL65wW1XIsvJnAgAs
         EPVcPSNAYUr5upfpKlVqwcE5Cbi/XNTDIbVooZqJ/5RXuKCVWeMKHTG8GT8mM/JXsjXf
         Vz6XvlrGQuJOda4s+Ct2HhjqeiST8YeATr7a6jbzz6qkIgLHnmMKzmZCzA4tEGxqlnDo
         3vGuCEVY6XBRlD6IBHqsaQYiReUZ2ilqGGaOwWM51evWBg7JlrVXkMnaqNglaVXsBgmb
         MHsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781052824; x=1781657624;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=by7ZsTX6XZrYuMsgO2vouu/UY2EhVCY+8I0m+whd0SA=;
        b=cdR1Zg2yd0xsEfB40R5kEUnlZlwEUmhsrooHDb47s4SuU/y5ybUCDCcwJC/Wk1oj1+
         HSDXikQp+6yR8QKS+uvMUWx39KbiJ77nrP7STEBRNobEmoadKm357axy9Q7g9ILTHFE0
         NzksAGm7fK10L0WfP4M9BTBKAqgrNB6dNsbuVC921Qjb7cTBjXjOzI4yQ5GWjJZtdC9W
         x9kvjGJpsmTmSA3R9wkP8adEMkL7QtO9dy9bZaOE3CfDKZyxWX+SQFr5AztnwCM3uc0D
         lgTIlo2C8/2m5/O6aE/P5Aj8k5yWYbOBG34qSZpO8V5gyLjWOFe5NF8RFc6iEqbWFaCx
         qmdw==
X-Forwarded-Encrypted: i=1; AFNElJ8/HZmzC1T6LQjz3tfx8/Bn5p72lun0cpLrevZdLyQ8dp1rSibV7pnqyixG+0PPsketdeI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1IS0VVbLbAR3oFr/Y8RGsVHBV40PecWcF5Z7p0vZGTL4fGatC
	KXrUuk9pa9am82hpZI1UQtsinWWaMI4s47v4qRIguWJU8UAxQ6GyBzxgOC4klkGCsUN8YyAmtsn
	4RO3FJQ==
X-Received: from pfbhx1.prod.google.com ([2002:a05:6a00:8981:b0:842:5a44:a83c])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1481:b0:842:3841:fdba
 with SMTP id d2e1a72fcca58-8430a62c352mr6061239b3a.6.1781052823860; Tue, 09
 Jun 2026 17:53:43 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue,  9 Jun 2026 17:53:22 -0700
In-Reply-To: <20260610005338.2967132-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260610005338.2967132-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.1099.g489fc7bff1-goog
Message-ID: <20260610005338.2967132-3-seanjc@google.com>
Subject: [PATCH v6 02/18] KVM: selftests: Add macros to read/write+sync
 to/from guest memory
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oupton@kernel.org>, Sean Christopherson <seanjc@google.com>
Cc: Joey Gouly <joey.gouly@arm.com>, Steffen Eiden <seiden@linux.ibm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, kvm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	linux-kernel@vger.kernel.org, David Matlack <dmatlack@google.com>, 
	Josh Hilke <jrhilke@google.com>
Content-Type: text/plain; charset="UTF-8"

From: David Matlack <dmatlack@google.com>

Add SYNC_FROM_GUEST_AND_READ(vm, variable), to read a variable value
from the guest. Add WRITE_AND_SYNC_TO_GUEST(vm, variable, value) to
write a value to a guest variable. These macros improve the readability
of code which reads and writes data between host and guest in tests.

Use the new macro in existing tests that do back-to-back write+sync.

No functional changes are intended.

Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: David Matlack <dmatlack@google.com>
Co-developed-by: Josh Hilke <jrhilke@google.com>
Signed-off-by: Josh Hilke <jrhilke@google.com>
[sean: massage changelog]
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/dirty_log_test.c  |  9 +++-----
 .../testing/selftests/kvm/include/kvm_util.h  | 10 +++++++++
 tools/testing/selftests/kvm/mmu_stress_test.c |  9 +++-----
 tools/testing/selftests/kvm/steal_time.c      | 22 +++++++------------
 4 files changed, 24 insertions(+), 26 deletions(-)

diff --git a/tools/testing/selftests/kvm/dirty_log_test.c b/tools/testing/selftests/kvm/dirty_log_test.c
index 74ca096bf976..087e94a8a81a 100644
--- a/tools/testing/selftests/kvm/dirty_log_test.c
+++ b/tools/testing/selftests/kvm/dirty_log_test.c
@@ -708,8 +708,7 @@ static void run_test(enum vm_guest_mode mode, void *arg)
 
 		sync_global_to_guest(vm, iteration);
 
-		WRITE_ONCE(nr_writes, 0);
-		sync_global_to_guest(vm, nr_writes);
+		WRITE_AND_SYNC_TO_GUEST(vm, nr_writes, 0);
 
 		dirty_ring_prev_iteration_last_page = dirty_ring_last_page;
 		WRITE_ONCE(dirty_ring_vcpu_ring_full, false);
@@ -775,16 +774,14 @@ static void run_test(enum vm_guest_mode mode, void *arg)
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
index 04a910164a29..c1f588154398 100644
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
2.54.0.1099.g489fc7bff1-goog

