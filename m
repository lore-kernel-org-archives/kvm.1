Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19EE0479885
	for <kvm@vger.kernel.org>; Wed, 26 Aug 2026 16:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787762552; cv=none; b=ksHjwjh7m9xeB5rYFq0CLtInd0XsQBpQDmRxTnYNS/JjUVzmd2E1yHp/GX6zYkMBmmhwGqFeplRL2G7X/iP/LvgVWUXCPJMtJBeTasi5QfEnaCfQbhXnGPdttx6GbOVQkoIyc6nQUkZ8WFWxscJrTYtRjIUexgpEMP34prD0PIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787762552; c=relaxed/simple;
	bh=BEhe2r+8iU4EkJKKeUDkD+GqT9e+NS4i1MkXdRfLIgA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=i0GXMEIdBSWVoZMbr/6iefbim+oLDY0hG+WgPMAYK1/g6Wa31B9h+9n+ReUH5BXt6rJQZhIfiKxQhMZZLJ4ihQpv79M0Oen8xkeJMP3KhKRD+BWomw1K5Z+QjcgVa3r8lEl/cxiqVMJUa/ZrgLpw/W45u/0CjK1TM6dgkTj5whM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rd1EuFxO; arc=none smtp.client-ip=209.85.214.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rd1EuFxO"
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2cc640dfde3so17500595ad.1
        for <kvm@vger.kernel.org>; Wed, 26 Aug 2026 09:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787762539; x=1788367339; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Ji0mUaDNfVUZXzbmrEerFV372UGViNyfEX1CgVwEdcw=;
        b=rd1EuFxOE7fMErYv4lq06VO33Ck9hx3jzPxEOU4a4g1wpaCn/h3V73xoT4FzV+PMpP
         JT2o0Vs2RtD3koE9JX/XUqqby8I7fmHOAXVj1TCwGq9qK3F+lnlcktZv+3llkJIdZ92h
         2CXp92hb1WOsBwUitGcl0LYdnV65oklSH8GrsVttaT/V5+UqSX4rjLAk8HE3ehoWeFmL
         j5fwgqeTv113BEOsmVZhTiul5Yqtcra7ieAe/i56gyVTN3fEENxvcpFhvXrcjQv3ISdv
         K1PB8fQV16r/6I8zrmgVnycc7XEyiLl/svCQGe8VLwdeQC2SrT2mSXJ8V+CeHkEI7BY8
         heUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787762539; x=1788367339;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Ji0mUaDNfVUZXzbmrEerFV372UGViNyfEX1CgVwEdcw=;
        b=E/hbCbu2bQhfbEUp9z+vinHoXArZCYa93XZbi+zqhAlBbMK1Kn+Q3p4ufIaCLY8zyR
         ozNXNAgCX3VcWMf1ImFFqALSz6fQfEtLmMlphLbmXKeZcVoWwCAWkYKFnJYKEQnEblhi
         F5RftY+65txZbNwTRSwtrMH5hJEh3z6GgzZAmPaExFMznLj2jH/OCVEuyvEdyoA9veNy
         f7kp6heDib5y1vv1TM9TOTWjU/NPsNtvJQ7uC98RMUI7+LTWLaIJpZ6ITpsu36xmBTzD
         8POrQfyg0/dPWe/iN16bxBDaNOw/pmH+eLHBxoUUgkt1bJRfqOsUtw7oovT5kEkyBXO6
         Lg7w==
X-Gm-Message-State: AFuF++m0ErD4W7+SFSR5yvv4k/L6YLMCXu4Rgp2fzlqKesKwFvjlL/vM
	YTcMdihPOSGfkOxJBVzwWdzx4UfU0F2VfcCDMFiWh7WZjuLQUooGYZCbsXYMzhlhzmqWo62uS3K
	MRbQ/6g==
X-Received: from plef20.prod.google.com ([2002:a17:902:f394:b0:2cc:79e2:e717])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ef50:b0:2d7:1aeb:739
 with SMTP id d9443c01a7336-2d71aeb1484mr67465065ad.13.1787762538425; Wed, 26
 Aug 2026 09:42:18 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 26 Aug 2026 09:42:12 -0700
In-Reply-To: <20260826164214.756512-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260826164214.756512-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.860.g4b6b3295ed-goog
Message-ID: <20260826164214.756512-3-seanjc@google.com>
Subject: [PATCH v2 2/4] KVM: x86/mmu: Harden "map private PFN" against
 unexpected root invalidation
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Kai Huang <kai.huang@intel.com>, 
	Yan Zhao <yan.y.zhao@intel.com>, Sashiko Bot <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Move kvm_tdp_mmu_map_private_pfn()'s reload of the MMU into its tight loop
so that an unexpected root invalidation has a better chance of being
handled gracefully, even though it should be impossible for the vCPU's root
to be invalidated after the initial reload.  As is, encountering an invalid
root is *guaranteed* to put the task into an infinite loop (albeit a
breakable loop that honors NEED_RESCHED).

Add a WARN to try and detect bugs that break KVM's expectations, along with
a comment to explain why it should be impossible for the root to be
invalidated.

Note, the loop in question doesn't actually check for a stale page fault,
i.e. likely won't detect an invalid loop in the first place.  That bug will
be addressed shortly.

Cc: Kai Huang <kai.huang@intel.com>
Cc: Yan Zhao <yan.y.zhao@intel.com>
Cc: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu/mmu.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 3220f05387b5..1969c26861e5 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -5209,10 +5209,6 @@ int kvm_tdp_mmu_map_private_pfn(struct kvm_vcpu *vcpu, gfn_t gfn, kvm_pfn_t pfn)
 	if (kvm_gfn_is_write_tracked(kvm, fault.slot, fault.gfn))
 		return -EPERM;
 
-	r = kvm_mmu_reload(vcpu);
-	if (r)
-		return r;
-
 	r = mmu_topup_memory_caches(vcpu, false);
 	if (r)
 		return r;
@@ -5224,10 +5220,22 @@ int kvm_tdp_mmu_map_private_pfn(struct kvm_vcpu *vcpu, gfn_t gfn, kvm_pfn_t pfn)
 		if (kvm_test_request(KVM_REQ_VM_DEAD, vcpu))
 			return -EIO;
 
+		r = kvm_mmu_reload(vcpu);
+		if (r)
+			return r;
+
 		cond_resched();
 
 		guard(read_lock)(&kvm->mmu_lock);
 
+		/*
+		 * Because slots_lock is held, it should be impossible for *any*
+		 * roots to be invalidated after the initial MMU reload.  WARN,
+		 * but continue on; the above MMU reload will do the right thing
+		 * if the current root is actually invalid.
+		 */
+		WARN_ON_ONCE(kvm_test_request(KVM_REQ_MMU_FREE_OBSOLETE_ROOTS, vcpu));
+
 		r = kvm_tdp_mmu_map(vcpu, &fault);
 	} while (r == RET_PF_RETRY);
 
-- 
2.55.0.860.g4b6b3295ed-goog

