Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CFDF423E82
	for <kvm@vger.kernel.org>; Thu,  6 Aug 2026 21:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786052455; cv=none; b=OC/jHKhjgbszL0HNDU/zzSNuWfix0y1uBPub0dhkX6jL9vHaK04sFDRTNh/UXZnqzJi8w1nUtdDXuLi1yRn/8HPloCe0fEC+pzI8EKt3aUkZiKK+wUsvQ2co7/7OobQ82FrjJvhRhAUf+9mFZlxO1qyC8Rj8Pxlsdlalp8YHktw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786052455; c=relaxed/simple;
	bh=fcJaKiC+PLAI3Uhl19cXGBBLAU5ESuVMNz27IIUYbzU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YmTpSRbu7h5+VuLzNCmLJATVri4BJcIguZ0YAdB/On06O5udZ8Y+AdCwK/+L/aWrnlVTNEYsy7NJJXPKH9/ZflLY8PbOmSeBKsx3SiG4FndPvWkpj6YW9CDHch10N78rXx6hQnQ5kbofhnYQ8tALiOr8SHGlqUXN4sXbHDoBNzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vU5WyDI8; arc=none smtp.client-ip=209.85.214.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vU5WyDI8"
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2cfa55c9430so27100965ad.0
        for <kvm@vger.kernel.org>; Thu, 06 Aug 2026 14:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786052454; x=1786657254; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=XaYcUb4i48pvUQtoL/N+DHfkbu37vszwR9D06c2Pljg=;
        b=vU5WyDI8lCUhfzX8cw9y8DnCq7irbw2T9cGlir2qyojewJtyU/BvW2YJl64EghF9M/
         Is7Z4u/Z7ox7xPImVnlcG2V0OWuOM10RdN9YYtMQIUJ4iryWuMOdYbQMG8Axwkv7zEwf
         o/CyvqDFLKsqtaJRV9Ulnk6pH2Maq/A6ns20uuXvg50eBatEx5wsrf0CRaj+Y5E0/Z/N
         XCyNhNe0KtJezo/7eNP6ulewAKOmkEaNnkGhouLCO1sSMMMhl3VfA9aWAz4SGUSP9RSo
         VgYIdklJZATu3+GBbD6laW3EO4Ufxm/eQC7t7OZyWuF3y+BAlYF8GgxREpRVXdB1biQz
         uoNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786052454; x=1786657254;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XaYcUb4i48pvUQtoL/N+DHfkbu37vszwR9D06c2Pljg=;
        b=tCBLzwZMCoONQoT1gFgBYWvJgQTOSqpF09j4ZVxCULEd9UJIoCBmUK7gbb8STTV3vf
         S3G2YaH0pupVNE2jMvCBW6fXLjTx/RPvdyL1w+dfFSB2wEWBQ6rcS7gGPTcQs817allS
         NCD442sLd5LpXtnc0RynlLq4BGE2dGLkURm7BrQDTIgRz0JQGEEn/0nSv0JRATAqxf0p
         0K9+OU93cRHaVbYmvNsjefZ7dAvq/P6XVZ6shfW4YC198HMpGzunE3hlwB911X+QynWV
         2xMHLRRz6z3VHvIz9imZSUIDi6+50d2aVfUa1HBWFyiDBRbP0Kj/ZCFMGiskZozkJOlu
         k/jw==
X-Gm-Message-State: AOJu0Yx96xsd0juawR/zHUR+4b9LFRVCaJ/CiA6MO3khDsIPXZ6jWkEC
	pllSbuQX5OgHvFDblwBwUMiCr+8k3a2HSwNlbuKiv8eYhnC4R4hIiABJE5eAjWhFkzPzmRQcy8k
	zZXhomQ==
X-Received: from plblo4.prod.google.com ([2002:a17:903:4344:b0:2cf:7d3e:e383])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:298f:b0:2c7:f12d:5d37
 with SMTP id d9443c01a7336-2d0caa02fd3mr219970215ad.17.1786052453781; Thu, 06
 Aug 2026 14:40:53 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu,  6 Aug 2026 14:40:47 -0700
In-Reply-To: <20260806214050.78058-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260806214050.78058-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
Message-ID: <20260806214050.78058-2-seanjc@google.com>
Subject: [PATCH 1/4] KVM: x86/mmu: Reload MMU on *every* page pre-fault attempt/iteration
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Kai Huang <kai.huang@intel.com>, Yan Zhao <yan.y.zhao@intel.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Sashiko Bot <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Reload the MMU (which is a nop if the MMU doesn't need to be reloaded) on
every attempt to pre-fault a guest page, i.e. when the page fault path
signals that the caller should retry.  If the synchronize_srcu_expedited()
in kvm_invalidate_memslot() completes before kvm_vcpu_pre_fault_memory()
grabs SRCU, but kvm_mmu_reload() in the pre-fault path completes before
kvm_invalidate_memslot() triggers x86's "fast zap all", then the pre-fault
task will reach kvm_tdp_page_prefault() with an invalid root.

Attempting to fault-in memory with an invalid root ultimately puts
kvm_tdp_page_prefault() into an infinite (breakable) retry loop, which
manifests most obviously as a hang in the pre_fault_memory_test selftest,
but also eventually causes RCU (SRCU?) to complain.

  INFO: rcu_tasks detected stalls on tasks:
  000000000cda47bd: .. nvcsw: 6/6 holdout: 1 idle_cpu: -1/25
  task:pre_fault_memor state:R  running task     stack:12696
  pid:95588 tgid:95588 ppid:95584  task_flags:0x400000 flags:0x00080801
  Call Trace:
   <TASK>
   lock_release+0x4e/0x320
   __get_user_pages+0x546/0xcd0
   up_read+0x1b/0x30
   get_user_pages_unlocked+0xee/0x350
   hva_to_pfn+0xd3/0x3d0 [kvm]
   lock_release+0x4e/0x320
   xa_load+0x5c/0x170
   xa_load+0x14c/0x170
   __kvm_faultin_pfn+0xd9/0x130 [kvm]
   lock_acquire+0x65/0x2b0
   lock_release+0x4e/0x320
   kvm_mmu_faultin_pfn+0x1e1/0x690 [kvm]
   gup_fast_fallback+0x63e/0xdf0
   kvm_tdp_page_fault+0xeb/0x140 [kvm]
   kvm_mmu_do_page_fault+0x12e/0x200 [kvm]
   kvm_arch_vcpu_pre_fault_memory+0x16e/0x200 [kvm]
   kvm_vcpu_pre_fault_memory+0xc1/0x1f0 [kvm]
   kvm_vcpu_pre_fault_memory+0x116/0x1f0 [kvm]
   kvm_vcpu_ioctl+0x3a4/0x6b0 [kvm]
   clockevents_program_event+0x5d/0x170
   __se_sys_ioctl+0x6d/0xb0
   entry_SYSCALL_64_after_hwframe+0x4b/0x53
   do_syscall_64+0x10a/0x480
   __irq_exit_rcu+0x8e/0x140
   entry_SYSCALL_64_after_hwframe+0x4b/0x53
   </TASK>

Fixes: 6e01b7601dfe ("KVM: x86: Implement kvm_arch_vcpu_pre_fault_memory()")
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu/mmu.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index c519e8e8d646..621b0a42f2a1 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -5036,6 +5036,10 @@ static int kvm_tdp_page_prefault(struct kvm_vcpu *vcpu, gpa_t gpa,
 		if (kvm_check_request(KVM_REQ_VM_DEAD, vcpu))
 			return -EIO;
 
+		r = kvm_mmu_reload(vcpu);
+		if (r)
+			return r;
+
 		cond_resched();
 		r = kvm_mmu_do_page_fault(vcpu, gpa, error_code, true, NULL, level);
 	} while (r == RET_PF_RETRY);
@@ -5076,14 +5080,6 @@ long kvm_arch_vcpu_pre_fault_memory(struct kvm_vcpu *vcpu,
 	if (kvm_is_gfn_alias(vcpu->kvm, gpa_to_gfn(range->gpa)))
 		return -EINVAL;
 
-	/*
-	 * reload is efficient when called repeatedly, so we can do it on
-	 * every iteration.
-	 */
-	r = kvm_mmu_reload(vcpu);
-	if (r)
-		return r;
-
 	direct_bits = 0;
 	if (kvm_arch_has_private_mem(vcpu->kvm) &&
 	    kvm_mem_is_private(vcpu->kvm, gpa_to_gfn(range->gpa)))
-- 
2.55.0.679.g6767b8d81c-goog

