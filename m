Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B1C332470E
	for <kvm@vger.kernel.org>; Fri,  4 Sep 2026 00:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788482628; cv=none; b=r+rk4sd0Zn0jAASS1yjFs2sAqXZNJnOq/udJZj4zf1TDV1Ij4aUraa+nAP8LoyYleKAMD9KNpcYMHaV8IMb0xctbMGGusK6ctFcIUwCcPhPMXfqiGqlHUhVshO054U0dIHfSkI4SXyFhbc+qkTRzDe6t/cz1YIZVOGpSrJQjtJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788482628; c=relaxed/simple;
	bh=MqvkRlvP3U3NczrZYJ3FMOO7WFdag2M3s3OFWKM5J84=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fwIvjOZZ6i39p35N3k3SMV9kQuPyWQi4wBboz1cxMfTqQKFcFbSHSLHpVNV8nPcnUy98VVFrL/HpB8YDrIoyNXv6OzCcLDDUdvP1iEN/lDSdWQYFhHNDN8PCGQJ6iMK2SxmTE20DTVMGBhtC+ddWvpGlnI3LARGkd9H75kquUTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UJSdAI6M; arc=none smtp.client-ip=209.85.215.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UJSdAI6M"
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cc39363cc88so578868a12.0
        for <kvm@vger.kernel.org>; Thu, 03 Sep 2026 17:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788482627; x=1789087427; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=HKx1UbmkHdZWwP93GWvKxJAzVfbjWV3VN7p9EAmhWKI=;
        b=UJSdAI6MemqFkfUOYcokJ093Q8Vd+kgMJ+ORxp3dtxuxV6yBxnd6BCyS0XzhOSeejo
         rOW6t56mB3xlHkH36Ap18IL8f3kUhbbn3nA+5vUb8ynqKCLYXNKZri69uyTvyrLbNoYp
         XTj3p60OgtycpesL0qPI0Jp2AQPDrupKGyCy6oOCeNP8deczQgSo9mzUwQUXIC+Pw4Lw
         1ZeJCXB4fZRoqjNcQp3C/NNgyMd+4ajmu/Y5Xl1voC3U7vIVQDFK+8vZAX3DqFcQC9JK
         SSABPoZ+/0d06wNZX4wxiwg+q75uFhXn7/AOWnpNxPxsFz9i9U1PqxEVytd15bRYFvKI
         IWXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788482627; x=1789087427;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HKx1UbmkHdZWwP93GWvKxJAzVfbjWV3VN7p9EAmhWKI=;
        b=M6jyr688CWYfIht0c9V1t/8FDxYeEPQ9j2FOk80iud7frbnJTKrQjd5asqMDRkrl77
         rkgKe/9spAAJIhF8x5XcYESw00DRLHZvYcdBSy7QlXfhK5xOVKqIcDwShixghZIPbY1Q
         +Huhca7T5pm9hLgA1XhmgjeSVThV8wt6zRGsjmtlqqp1phHzhZFOnMpsikTbugpSOKQC
         9vnsjCsawy4mrfJ2TYqREavQKEVgpga+gmlW/gU5lK+TQvjp0ji9lh9JNaQcD6xxb6/L
         tCtsdIZcIdOPsN5rge4y6YKbzyoNQ1xSnpKHxeWpWHNOFBNwsxtl7cOXm0nQwqqM9SLX
         JhwQ==
X-Forwarded-Encrypted: i=1; AKwUvBxhv/8HPSCy9miO4+9Zm9AdA84NV0pHhHypE8ofw8be0OgMSC0rq6TJJn/QuruJlkcHSXE=@vger.kernel.org
X-Gm-Message-State: AFuF++lpGuyICMbNZm/6ufZqgYp2RcQfhegULz7z9bVvN023ijQFQRLR
	H9QUvFTZJuf9ZJPiXvRm/BtzoARbp/W1Ah5Fmy0g/Ei6LMo2smi58agzgaYHsfdMcePXohHLGuJ
	NofxAcQ==
X-Received: from pgbq19.prod.google.com ([2002:a63:5c13:0:b0:cc2:9b7a:38a])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:2291:b0:3d0:88f5:f812
 with SMTP id adf61e73a8af0-3da39d147e0mr3721581637.10.1788482626470; Thu, 03
 Sep 2026 17:43:46 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu,  3 Sep 2026 17:43:40 -0700
In-Reply-To: <20260904004342.3162959-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260904004342.3162959-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.979.g7e5102b832-goog
Message-ID: <20260904004342.3162959-3-seanjc@google.com>
Subject: [PATCH v3 2/4] KVM: Use goto to handle errors during memslot preparation
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: David Hildenbrand <david@kernel.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Stefan Teodorescu <fane@google.com>, Dennis Tighe <dtighe@google.com>, 
	Sashiko Bot <sashiko-bot@kernel.org>, Yan Zhao <yan.y.zhao@intel.com>
Content-Type: text/plain; charset="UTF-8"

Use a goto to unwind early memslot changes if preparing for a memslot
operation fails.  This will allow moving the creation of guest_memfd
bindings into kvm_set_memslot() without needing to copy+paste the unwind
logic.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 virt/kvm/kvm_main.c | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 65eb26a0520d..3c0dbe60a5b4 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -1931,21 +1931,8 @@ static int kvm_set_memslot(struct kvm *kvm,
 	}
 
 	r = kvm_prepare_memory_region(kvm, old, new, change);
-	if (r) {
-		/*
-		 * For DELETE/MOVE, revert the above INVALID change.  No
-		 * modifications required since the original slot was preserved
-		 * in the inactive slots.  Changing the active memslots also
-		 * release slots_arch_lock.
-		 */
-		if (change == KVM_MR_DELETE || change == KVM_MR_MOVE) {
-			kvm_activate_memslot(kvm, invalid_slot, old);
-			kfree(invalid_slot);
-		} else {
-			mutex_unlock(&kvm->slots_arch_lock);
-		}
-		return r;
-	}
+	if (r)
+		goto err;
 
 	/*
 	 * For DELETE and MOVE, the working slot is now active as the INVALID
@@ -1977,6 +1964,20 @@ static int kvm_set_memslot(struct kvm *kvm,
 	kvm_commit_memory_region(kvm, old, new, change);
 
 	return 0;
+
+err:
+	/*
+	 * For DELETE/MOVE, revert the above INVALID change.  No modifications
+	 * required since the original slot was preserved in the inactive slots.
+	 * Changing the active memslots also release slots_arch_lock.
+	 */
+	if (change == KVM_MR_DELETE || change == KVM_MR_MOVE) {
+		kvm_activate_memslot(kvm, invalid_slot, old);
+		kfree(invalid_slot);
+	} else {
+		mutex_unlock(&kvm->slots_arch_lock);
+	}
+	return r;
 }
 
 static bool kvm_check_memslot_overlap(struct kvm_memslots *slots, int id,
-- 
2.55.0.979.g7e5102b832-goog

