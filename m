Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C17CE3C2D
	for <kvm@vger.kernel.org>; Sat, 30 May 2026 00:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780100588; cv=none; b=u1Sb6h385OAYvH36HNcPJMejfS+i2fF73sYvnaT/bznEAAj9Z48vsHD00RjlZxdmypC47Y9xKLqq7H680zpG5cVkFyD5Fhh3OBX6rQPiGNp7sFqUaAGkTVgtPsr4XzMHMRh49XYBRj83G1SAZ6rAt8t/Jw8l4cQEXghSxOh/p+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780100588; c=relaxed/simple;
	bh=sXMwmP2UqgFx30vp2DpWcFhwd0AM4JL50dzN5fKYRIQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ezKYryTqrj6yNxATVVZeLIB/rH3T0JnscLdJVFd5BGYCzBrXAZBJa+NPOlihtk3mMYuYdmoqqP0nyCy8eHegu4LDqHJACOH34AHKiXncAFh7lqYCk8WmlKEZ6iw5ly959Gfq+KdPF1vD5WEtalswXhdXpPto0/Z3BUgsjz2OK4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RwyrjPZv; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RwyrjPZv"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c85807671b1so339116a12.2
        for <kvm@vger.kernel.org>; Fri, 29 May 2026 17:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780100586; x=1780705386; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=CskMS4d6f2stDOuFXnBJMY4diyRXjtyxYts+dOwiu+M=;
        b=RwyrjPZvkHVufX1zVNsIG3ko0nADmdd+deS53EkxCX2Wccyikl5M6SPw1CQDTOR0RO
         fLAuh4ER/a5dncPPX8gj/ht91Eg3qAhCIQNcxtMO4+yTld7/p/xMi0PcBS5fFo/8IAiH
         rGTAzvxYtvhewy0kOWYvtUBfMcyeWtpGVibf7PjdWEE7YdPb02sZhBLhV5U3vsrqcEUX
         Nia+J4JJinENZfXEVQmQqRoxmtFD9mVkpc1lQoMqZjtj+anP1sVqjc2167H+89jfBVWt
         o6ogq4HI5olycYjl79K3YvwvBIYfvfkzj9c06ErpXhpUi5MKIlbBCdpEVzl4Id4hMDJa
         xkyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780100586; x=1780705386;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CskMS4d6f2stDOuFXnBJMY4diyRXjtyxYts+dOwiu+M=;
        b=CCNB+dmKFsm+wW4Vc7t85mbHOX6GUofbCLkHaBxOvcP02ANQngUo0jY5m90uqm04BU
         BdlWV09slFotv5lHNukPdZyzVWM79+mDTtFQuUngPFaf/EsHRd06SlrYlSIp+WApgJ2y
         jQkbTE2ApOCIpb3kJtvBG89nm/4U8fm0lEEfqJYU+jtmCXG02+kuaOgNJmrKQBrzo4QZ
         Hat+r9bWNZbywIg5vtsH55dTiSXm0b+GjeYarnU8F5/2JjhAartV/Rsz2TWp9Bc/MCMH
         VLpyjBpqX76EGw2fSm3s5x4nP1OWHJgcuGQdTTnXOhBtrbBZFBLc2InaODfXBqbCVq8l
         xq5g==
X-Gm-Message-State: AOJu0YwBc45zg6BzdDPTafnKqXbudyRo0mMpas87zd7ayUcrrO+XgHbg
	iKDTDgnfrPBK3j3vudBvM+Ax5aoWla5kQw4PspOHm/Nf2TWeXTbO9NRkAm5JICVFjmJ0O4epSBI
	d1bLsR5tb
X-Received: from pgnr27.prod.google.com ([2002:a63:8f5b:0:b0:c85:7ee2:5d43])
 (user=jrhilke job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:3213:b0:3a2:d79c:414f
 with SMTP id adf61e73a8af0-3b427f5fca4mr1761269637.48.1780100585901; Fri, 29
 May 2026 17:23:05 -0700 (PDT)
Date: Sat, 30 May 2026 00:21:18 +0000
In-Reply-To: <20260530002134.558837-1-jrhilke@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260530002134.558837-1-jrhilke@google.com>
X-Mailer: git-send-email 2.54.0.929.g9b7fa37559-goog
Message-ID: <20260530002134.558837-4-jrhilke@google.com>
Subject: [PATCH v4 03/19] KVM: selftests: Add guest read/write macros
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
 tools/testing/selftests/kvm/dirty_log_test.c  |  6 ++---
 .../testing/selftests/kvm/include/kvm_util.h  | 10 +++++++++
 tools/testing/selftests/kvm/mmu_stress_test.c |  9 +++-----
 tools/testing/selftests/kvm/steal_time.c      | 22 +++++++------------
 4 files changed, 23 insertions(+), 24 deletions(-)

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
index 7be8adfe5dd3..a866927581fa 100644
--- a/tools/testing/selftests/kvm/steal_time.c
+++ b/tools/testing/selftests/kvm/steal_time.c
@@ -72,8 +72,8 @@ static void steal_time_init(struct kvm_vcpu *vcpu, uint32_t i)
 	int ret;
 
 	/* ST_GPA_BASE is identity mapped */
-	st_gva[i] = (void *)(ST_GPA_BASE + i * STEAL_TIME_SIZE);
-	sync_global_to_guest(vcpu->vm, st_gva[i]);
+	WRITE_AND_SYNC_TO_GUEST(vcpu->vm, st_gva[i],
+				(void *)(ST_GPA_BASE + i * STEAL_TIME_SIZE));
 
 	ret = _vcpu_set_msr(vcpu, MSR_KVM_STEAL_TIME,
 			    (ulong)st_gva[i] | KVM_STEAL_RESERVED_MASK);
@@ -181,8 +181,7 @@ static void steal_time_init(struct kvm_vcpu *vcpu, uint32_t i)
 	vcpu_ioctl(vcpu, KVM_HAS_DEVICE_ATTR, &dev);
 
 	/* ST_GPA_BASE is identity mapped */
-	st_gva[i] = (void *)(ST_GPA_BASE + i * STEAL_TIME_SIZE);
-	sync_global_to_guest(vm, st_gva[i]);
+	WRITE_AND_SYNC_TO_GUEST(vm, st_gva[i], (void *)(ST_GPA_BASE + i * STEAL_TIME_SIZE));
 
 	st_ipa = (ulong)st_gva[i] | 1;
 	ret = __vcpu_ioctl(vcpu, KVM_SET_DEVICE_ATTR, &dev);
@@ -279,10 +278,8 @@ static bool is_steal_time_supported(struct kvm_vcpu *vcpu)
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
@@ -376,8 +373,7 @@ static void steal_time_init(struct kvm_vcpu *vcpu, uint32_t i)
 	};
 
 	/* ST_GPA_BASE is identity mapped */
-	st_gva[i] = (void *)(ST_GPA_BASE + i * STEAL_TIME_SIZE);
-	sync_global_to_guest(vm, st_gva[i]);
+	WRITE_AND_SYNC_TO_GUEST(vm, st_gva[i], (void *)(ST_GPA_BASE + i * STEAL_TIME_SIZE));
 
 	err = __vcpu_ioctl(vcpu, KVM_HAS_DEVICE_ATTR, &attr);
 	TEST_ASSERT(err == 0, "No PV stealtime Feature");
@@ -476,8 +472,7 @@ int main(int ac, char **av)
 
 		/* Second VCPU run, expect guest stolen time to be <= run_delay */
 		run_vcpu(vcpus[i]);
-		sync_global_from_guest(vm, guest_stolen_time[i]);
-		stolen_time = guest_stolen_time[i];
+		stolen_time = SYNC_FROM_GUEST_AND_READ(vm, guest_stolen_time[i]);
 		run_delay = get_run_delay();
 		TEST_ASSERT(stolen_time <= run_delay,
 			    "Expected stolen time <= %ld, got %ld",
@@ -497,8 +492,7 @@ int main(int ac, char **av)
 
 		/* Run VCPU again to confirm stolen time is consistent with run_delay */
 		run_vcpu(vcpus[i]);
-		sync_global_from_guest(vm, guest_stolen_time[i]);
-		stolen_time = guest_stolen_time[i] - stolen_time;
+		stolen_time = SYNC_FROM_GUEST_AND_READ(vm, guest_stolen_time[i]) - stolen_time;
 		TEST_ASSERT(stolen_time >= run_delay,
 			    "Expected stolen time >= %ld, got %ld",
 			    run_delay, stolen_time);
-- 
2.54.0.929.g9b7fa37559-goog

