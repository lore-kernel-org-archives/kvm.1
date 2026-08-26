Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 211D147A0A9
	for <kvm@vger.kernel.org>; Wed, 26 Aug 2026 16:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787762557; cv=none; b=Z7y9GjSfdpbPaxz9Z6cgbEGzJy9Xw0JQF2SwS3jgOQaes2YzHzkEQN9xWdmUFzipPTinDXBeNRCCL4Ux1WRcC/VUb4W1R9cKHPFxArfqLx0FQAvwQ6ROxJhiSyQX5khQK+ScwjJF5BADCeK/hE35lojvA9F7u2tgCP9GqSakYhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787762557; c=relaxed/simple;
	bh=i578dgYavrIdohpu+SpEj4jJ+sVyZzrBwA5orlX4/TM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LmH1hDNcK4FLXe+KTYArf8yfyeTPjkx9xvR7HepSfrIyYw0rQxSq15lXqwe7XfCsaIlbXvU+ufrcXjItXoS1L9IeKBgWTGqnP5ZyKlNOJA3r72yCSzzLKQ8uJz1ZJqm/s68KARBojTOPPQrx0m22IJ1nBQSn5J3b6WwSCBFlrmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dQJ7TW0d; arc=none smtp.client-ip=209.85.215.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dQJ7TW0d"
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cc1bbd7d6e6so1345109a12.3
        for <kvm@vger.kernel.org>; Wed, 26 Aug 2026 09:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787762537; x=1788367337; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=t27G+87/xldPf9EXxl/42NH6liZLtdScRqOAABQHwp0=;
        b=dQJ7TW0dItjw4PhJful09lq7CNsUAg37JXrX5Mv6wAy5X5qo8zYd4swK/euFAo6427
         HaWktrz6hkFNFi8B8RK/RKq0Zt+eQbZ86iuK5U82yyVCFDZLcC1DH4ZLsnwypzhCB4y1
         b4bf/dPURgM800Z5k74ji0SNwU+e6ks9yYDUWrHlMLDOXa7RaJHDLu6DstVBobkrJciM
         9F/RIM2mH0zELbGYWaJrd4kCZZ+R8cWoAB7YlaZKrHsTEeIhqvQ6dtHN/EoSwkYLGw1d
         jF3uKo1e5qPZy4pptOOVRflIvgJ5dEFtoNt/VFqDiGexxEg/GsaZYXKiSInzFUMhRPu2
         zb5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787762538; x=1788367338;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=t27G+87/xldPf9EXxl/42NH6liZLtdScRqOAABQHwp0=;
        b=d4a1CZLfzGgjPrwpFlBSoQySeiV5xBuWMFNSPH8yD0FJmtTLysk2QzHP6n0INMXL4X
         5B34cE6ySg49STsAeta2VN6jRUUCMyB6Ph7XgDtDDt/RkcJi7BUjiYVDKUQbwZz4dTXK
         K8zNFMGtZVx9wT/3NjnfMDgLxarNmUnDmfhrCiGR+LNNhWORtDHgZOn/ExgjUqv6uAQj
         wmuEbMI0iaOUXYAXU2fQaWN4VqNGKT7XMvUxXgnSNOarUvH9fkowojHkk3+VeHORf7S4
         lpNgyLRJZ2KVnAKj+CETxko1VnbiIJnnqoDLdx/dPnNO8hupaC4Bfz8FFn2H2kNI4mvc
         cCYg==
X-Gm-Message-State: AFuF++l7jDZEQ2HAwDycv67/wdJ5PU/dbM2MSyUa6Z4BmkefQEARrlj5
	xg1jvhbPTeFLhW7LuLIcz7FLPD0ub0r23oBE3GlQXRkHkLx/EoXciP8+l2/z20/3C0hx3PYs+IR
	XsEkYiw==
X-Received: from pghp20.prod.google.com ([2002:a63:fe14:0:b0:c9a:c533:8316])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:4f92:b0:848:2e3c:9955
 with SMTP id d2e1a72fcca58-85371fa599amr14451999b3a.4.1787762537296; Wed, 26
 Aug 2026 09:42:17 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 26 Aug 2026 09:42:11 -0700
In-Reply-To: <20260826164214.756512-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260826164214.756512-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.860.g4b6b3295ed-goog
Message-ID: <20260826164214.756512-2-seanjc@google.com>
Subject: [PATCH v2 1/4] KVM: x86/mmu: Reload MMU on *every* page pre-fault attempt/iteration
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Kai Huang <kai.huang@intel.com>, 
	Yan Zhao <yan.y.zhao@intel.com>, Sashiko Bot <sashiko-bot@kernel.org>
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
Reviewed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Reviewed-by: Kai Huang <kai.huang@intel.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu/mmu.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 064ecc33b926..3220f05387b5 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -5061,6 +5061,10 @@ static int kvm_tdp_page_prefault(struct kvm_vcpu *vcpu, gpa_t gpa,
 		if (kvm_check_request(KVM_REQ_VM_DEAD, vcpu))
 			return -EIO;
 
+		r = kvm_mmu_reload(vcpu);
+		if (r)
+			return r;
+
 		cond_resched();
 		r = kvm_mmu_do_page_fault(vcpu, gpa, error_code, true, NULL, level);
 	} while (r == RET_PF_RETRY);
@@ -5101,14 +5105,6 @@ long kvm_arch_vcpu_pre_fault_memory(struct kvm_vcpu *vcpu,
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
2.55.0.860.g4b6b3295ed-goog

