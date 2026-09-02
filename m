Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D1F3DA7D6
	for <kvm@vger.kernel.org>; Wed,  2 Sep 2026 18:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788373226; cv=none; b=VqFCA5p7gHjJB4D01coGS46EhQV05haymus4UKkLsGhGZSGEljoqoELyomolAoz80SEA7840PIBscyUpwo5YmhF3JOVm70chLKTU96+S51aN28KWWzCIYnY3hT5jEeCFa4ZXKolEtDDTAYGGDf0KjQRKs1l5vmunvUapf8bpCf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788373226; c=relaxed/simple;
	bh=SNf4WUEJ+xEg0G0RzQZ95uMwbsxag8eFYUy+XvGm2s8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=M5Putm++8K84OUFykvd0NhpAiqdfLwP/VwAUDdTBfLENib/19ry9mhZsRRqlQ4EZbpRcuy07QqiDb5xCFw7orrqInU8hiVZTDxRNCcHsdbc2mRzXx3NaCtCjOyObKpxE+4N5JpWFSiNAvCFuIpCcNaHP9F7LG/doK6MAOxHUcKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dD89G+Ww; arc=none smtp.client-ip=209.85.216.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dD89G+Ww"
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-38e7ff7b375so1965259a91.1
        for <kvm@vger.kernel.org>; Wed, 02 Sep 2026 11:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788373225; x=1788978025; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=enQThv/Z+5wbYGLAU8qGaGyyNyk23OKTo0dZTiQBGes=;
        b=dD89G+WwCZoQ+6md2/KGc+sbBlpN0baCzastzoNpeaxcVECx+r0+H85a/AhSlAESpB
         2p37Rc/wAjKpSLxmZmUbsWwU7Q/fmhtcmfBmWeOkZstD9GgdbUmNIeIloO7exxh7FAmp
         i0mIKIb7LZUgNx56Q8DCXbWAGgpDlOQnPKjhQyrNvLt2wwqs05r/cuQjEzmWhmxFpazX
         v+WxBQPKyYoKZT9cm5UJVHPP0cpcWSylGfWFkGyvZt5vYDBzyK/sHP2311Pr5pt/L/nI
         3OO1enVlQ6+voNihDWQ/8uSstuFvgsDMv7HNYYrOwd0yB4ZBMLl3V5v6u5YKbLgwQ9ye
         en8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788373225; x=1788978025;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=enQThv/Z+5wbYGLAU8qGaGyyNyk23OKTo0dZTiQBGes=;
        b=QLf89yQYNs30YaHd2wOY/sZJvMNvzyQxrKb4+vI6OamN8wqHWki9pLvUAQOLLEtRIo
         nKHIyTdZxfflHDRgdyk5DNdoKG5JUfGjHE73jTlyw1i+HWVQWT6V8cxOK5Xsq9SHNdot
         qtEhi7gJv6q6lMa2VPKIQyvJFMWlxN9n2eQPbl4Gl+ohf1CyfRFIuE2SXq6Ciqgt6hVj
         qIxNsRAA/TfU63Z8PKQSMY3DS0YBZIo882rc9DXOA4LQQEY/kxYVkRfoZVE57gIgOdqe
         3M3RS5JwpiXpMBvbAMtdZzNJCxtRua9bTKDDgsYslFf3JCvdtVYnkc7RUuKq63dZ/70l
         4FFw==
X-Forwarded-Encrypted: i=1; AKwUvByJNWRSckq+UxWEdAyHU9GqUzlA6SnV5tHnrbVA+IbrbnnlowZge1Z7qRtxgjXAPr6VQJk=@vger.kernel.org
X-Gm-Message-State: AFuF++l8CRCgn7Z7Qsz0fxa+LU7qIVI+0kMA/BT/mScQiW08MV0xK9R8
	4QB8OEXAQPnmW1D7ivMmb32OvgCzpmhBk6wo2fNjUbuXoNKdahEM8HB2X09b7jVXPsj7thw2x75
	6LkVRpg==
X-Received: from pjblp16.prod.google.com ([2002:a17:90b:4a90:b0:396:67ed:da2f])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:17cf:b0:398:d286:344d
 with SMTP id 98e67ed59e1d1-39aee178e92mr9991369a91.22.1788373224396; Wed, 02
 Sep 2026 11:20:24 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed,  2 Sep 2026 11:20:18 -0700
In-Reply-To: <20260902182020.2615443-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260902182020.2615443-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.970.g62bdec98f9-goog
Message-ID: <20260902182020.2615443-3-seanjc@google.com>
Subject: [PATCH v2 2/4] KVM: Use goto to handle errors during memslot preparation
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
2.55.0.970.g62bdec98f9-goog

