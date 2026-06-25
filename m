Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A18303BBA04
	for <kvm@vger.kernel.org>; Thu, 25 Jun 2026 22:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782426995; cv=none; b=UvJELkOireDISPdZnwlWRNUt/zudGJwrrjqrrElirMevgGL0Prb5oKxpTlZ6d1xhfuE87wq/RIqsiZ+9WqRL1WrEcCGkwM26VOqB9BaX0k306elmaoXF+g1J/gRqJBbEUgMqmDrK0cQsr0D7mywEx8ezIuU1x+/21N+uqILCSc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782426995; c=relaxed/simple;
	bh=1kNFPkL0jjqmM1CIfdQrQjKKjNMyqeQX86Cc49gOi6Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GoZ8AXEwzUOhZnIOm4H7oxreD1Z0hS2op8wIh47XuBkMTeFAkQXSAA+WlU+S6X3SkMH3G7hLosK7MlLg8gt1sUlyu5JjmGcwVz9BNipPXfeBvnWrd12h8qNCnz7aPIKFpwERtGqwnJKDrJ4OZ3Ek+y6C0OPe5GBP5u/vRPoZbOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fjnQNwWV; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fjnQNwWV"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2c6a20348ceso3023635ad.1
        for <kvm@vger.kernel.org>; Thu, 25 Jun 2026 15:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782426993; x=1783031793; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=a16gRjtRn86UfUtiEbOop3NuB+KG8sDr/q18ZbA3jUg=;
        b=fjnQNwWV5yAyKyOGLuhFRxgNy5n35CTWPjkxgkRZLnV/ZJilWjSUT4mdU7BaxOtom1
         mOnk9YYwWSIF5HcrysECFnb0JUoWQcp+P2C9bQaKIYquIRXGNBk741xEuPk9jk7iryXf
         OC4YISFZ+pnqMicW2ReO4N7y6wq3YIyEhwIKnQ32AlGhgHPAvx9jKDBv+2TbJCqfzcpL
         SVnS4mikAKYmXylJuz0VuWIp8wFrRWc7iULgv/3psDRAb+CYh74dDFSzjQlblt5DbTzW
         X/p3q7waQCmWTLsAOuF4ejfoLgHQ7l1Qva55b/WTEJH2loSZNkqmgs8FAC/00ypXj0K3
         HowA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782426993; x=1783031793;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=a16gRjtRn86UfUtiEbOop3NuB+KG8sDr/q18ZbA3jUg=;
        b=h07iI/rQMcI1heFiTGAj1u223DPBjSbhF1wvcsZkyLYgIVLqHb1rn/rktCTACjcYX2
         d/JqUgN/GP4OuskvytgCJmY/OlFqrwXXuVQAfS1+HI5sqUo0u5VDFXxYGU04mtaJioZD
         hqOTHBAsJvQOZFk8uVt0xJ0/0G/uAS//fAuFN5Utg7i879WwBJGnKKtWwKekVu4I2Dma
         8zFTSp+anGJwxUkXT1+xOZRb0aUdnw3kHb4G4+92qpQqJ7f/44DvHQxRQyLjjy3f8ij5
         rorQBF4QsvoUwGMtcieqCEX9OUlYnubrX3VQjLb9Cb/iNRSQUgMB111I68nm7wPiaTxq
         zQmQ==
X-Gm-Message-State: AOJu0YyM4ZxGAJZxqDl3vSTgtQjT5Jm8p1WQwOIJQLvqZSqW71BSh6hG
	lymBROVt1U4lWmAsXkiwlPUuEQ9cnTZlqCdCJ+MpXxtf/vxiewtfcBLRVNRLYGtONhgplz1s5Tx
	G3wuZIA==
X-Received: from plzw5.prod.google.com ([2002:a17:902:9045:b0:2c6:bebe:2819])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1a26:b0:2b7:a350:463f
 with SMTP id d9443c01a7336-2c7fc730ab5mr44249395ad.10.1782426992753; Thu, 25
 Jun 2026 15:36:32 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 25 Jun 2026 15:36:20 -0700
In-Reply-To: <20260625223623.3376478-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260625223623.3376478-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260625223623.3376478-8-seanjc@google.com>
Subject: [PATCH v3 07/10] KVM: Move nVMX's lockdep logic for vcpu->mutex to a
 common helper
From: Sean Christopherson <seanjc@google.com>
To: Vitaly Kuznetsov <vkuznets@redhat.com>, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, David Woodhouse <dwmw2@infradead.org>, Paul Durrant <paul@xen.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+5b32c49cd8f005e65654@syzkaller.appspotmail.com, 
	syzbot+5d2b94b77112148d1744@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"

Extract nVMX's lockdep assertion that a vCPU is locked or otherwise
unreachable into a common helper, as KVM x86 is about to gain another user,
but there is nothing x86-specific about the logic, i.e. the assertion may
be useful for other architectures.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/nested.h | 6 ++----
 include/linux/kvm_host.h  | 6 ++++++
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/vmx/nested.h b/arch/x86/kvm/vmx/nested.h
index 6d6cd5904ddf..c6de848bd9ce 100644
--- a/arch/x86/kvm/vmx/nested.h
+++ b/arch/x86/kvm/vmx/nested.h
@@ -57,16 +57,14 @@ bool nested_vmx_check_io_bitmaps(struct kvm_vcpu *vcpu, unsigned int port,
 
 static inline struct vmcs12 *get_vmcs12(struct kvm_vcpu *vcpu)
 {
-	lockdep_assert_once(lockdep_is_held(&vcpu->mutex) ||
-			    !refcount_read(&vcpu->kvm->users_count));
+	kvm_lockdep_assert_vcpu_is_locked_or_unreachable(vcpu);
 
 	return to_vmx(vcpu)->nested.cached_vmcs12;
 }
 
 static inline struct vmcs12 *get_shadow_vmcs12(struct kvm_vcpu *vcpu)
 {
-	lockdep_assert_once(lockdep_is_held(&vcpu->mutex) ||
-			    !refcount_read(&vcpu->kvm->users_count));
+	kvm_lockdep_assert_vcpu_is_locked_or_unreachable(vcpu);
 
 	return to_vmx(vcpu)->nested.cached_shadow_vmcs12;
 }
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index ab8cfaec82d3..b10814f99a50 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -989,6 +989,12 @@ static inline struct kvm_io_bus *kvm_get_bus(struct kvm *kvm, enum kvm_bus idx)
 					 lockdep_is_held(&kvm->slots_lock));
 }
 
+static inline void kvm_lockdep_assert_vcpu_is_locked_or_unreachable(struct kvm_vcpu *vcpu)
+{
+	lockdep_assert_once(lockdep_is_held(&vcpu->mutex) ||
+			    !refcount_read(&vcpu->kvm->users_count));
+}
+
 static inline struct kvm_vcpu *kvm_get_vcpu(struct kvm *kvm, int i)
 {
 	int num_vcpus = atomic_read(&kvm->online_vcpus);
-- 
2.55.0.rc0.799.gd6f94ed593-goog

