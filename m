Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 887963C09E5
	for <kvm@vger.kernel.org>; Fri, 26 Jun 2026 21:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782509742; cv=none; b=MPJVIwm1h9CRAozcvrM1RV3Ulo7hFOTFQnSGslmZMCzlpasIRxgXKn+DA3UXH11v/H8yxuGf9jbt0koQfa77m8liLoRGrJT8lBdPB0uvsB8zjAc1l/DGc4vH7KOgfAQVvHk2/XzoPTkAR3McNpWRR+MStwnMLJL2N8AZE0dw4WY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782509742; c=relaxed/simple;
	bh=+iVK0U72I4V9rzOETZXqLIHJYh3Jg+jyJNG57By+z/c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nK82nJCQc1KESUL54Tmh1sNL//FZgXt7CgHoPzzNu03aiK4veeKDOzpDW91XCtOmEXTX4ITr+QAjOLuLntGOGnaGZ8o0AbjLnRxgCCAj8g45TiiqmGamb5a0TFJqtp/DBgEb20vf2VnIbl83XyJtLFEyrbiSObJGxU5F+/6FyO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uZ3L2i52; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uZ3L2i52"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2c80be91ea3so20129925ad.1
        for <kvm@vger.kernel.org>; Fri, 26 Jun 2026 14:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782509739; x=1783114539; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=4C/F69MMCNbFC/U7daD4jUcYFr10L9zUYtkcPR6sWF8=;
        b=uZ3L2i527ZA7YodJWlK1UUWJDFk/VaiPEfGvUrXD40HeFD6ZnSs+F+59iuI0mCbM4E
         rrRm6cpcZHx+h2gs75QYyZZ1o/kxJZ0l9fYtSB2t1sbmBNT9N01UWHZuOdamI8Ks6Sv5
         jcIs9zPxL4GmBScjO5u4KMXyhWL3b87QcvzyjxdIRZ58VmRdhBbTUi+HeyVwFvPjurps
         lrMV1SuyFZ0a6tm5Td1W5mhQ/3YB7Uppy9eNSa5sSRCUnP/X6312wfrUmOMlz1XVKesQ
         2E3HlD4oNlBfca6dF1cZFuiHv5JyP6M5/NXRJPV0KiYhcgwXWucXHdkHK40S7q93rc42
         XX0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782509739; x=1783114539;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4C/F69MMCNbFC/U7daD4jUcYFr10L9zUYtkcPR6sWF8=;
        b=cHt7RSr/CuCBM5jpFCErLiu6IKgUtuaDRESl6JWhLbDMwMfDLbudgEJAOflaB+/WQ4
         pfG2F2dxu3tZE9Z32TF6rnLUGivGTeZlFRCVdyUfncuZi0xxZoENCatlIyvi/xW8gu7q
         A9qx1xbkn2T4/hYpNFkvuAY0UJLKCv5gMO3shkYDuvAhN8nHVpD4rf6uNFBpDdIlCgfc
         KT/g1ixViqQJ12sG+LZtgehmlnb0+XwxPqZgM6veAEj5QYEKbDOo4/IQom40lx15uMRW
         kS1ED69LxkSBqlwfxXxrZtoqCH3WIO+KLfhHQTE0JsSZuE4DIS4xWtnaofUBO2YQm1/4
         VSVg==
X-Forwarded-Encrypted: i=1; AHgh+RoHq69FrVzEgnGGaCN0bVnRE+h65cXfUN3LOsMHTLHfg6HdafoS3HGTc3PzIQIIh+VSvk4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7UZES29KG2/wMHv9/KYP3P2kPAGg5FSEpMyHIjwiiaq620NF/
	F4covzGXmeL6rt8F1pFJtFox4XFP4IEB9CA5GEPt/9yb/8sBWsHyU7xBGFAMEzhP9PzmGr2IXrG
	CyTKmIw==
X-Received: from plrr3.prod.google.com ([2002:a17:902:c603:b0:2c6:a096:4c29])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2f05:b0:2c2:be43:39bc
 with SMTP id d9443c01a7336-2c7fc6f3442mr85977465ad.22.1782509738712; Fri, 26
 Jun 2026 14:35:38 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 26 Jun 2026 14:35:15 -0700
In-Reply-To: <20260626213534.3866178-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260626213534.3866178-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260626213534.3866178-3-seanjc@google.com>
Subject: [PATCH v8 02/20] KVM: selftests: Add macros to read/write+sync
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
2.55.0.rc0.799.gd6f94ed593-goog

