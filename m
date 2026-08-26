Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F03EC472522
	for <kvm@vger.kernel.org>; Wed, 26 Aug 2026 16:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787763438; cv=none; b=p+Fhpg/hufF1RdiRz3vOnLMyKYg6dGeGWT060FSKiOK9Vjy4Ni4HnR++w9lMcujWuVkKtL4u+M0jinVXKFPQU4QhosTjPGeOE07YRkXHr2wtdXxj0XihyHiQ180xWGS8xvJEPJDFzBAI3W43eFvKAa2mhGFOHM7Mqh7xx9YOzWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787763438; c=relaxed/simple;
	bh=eLzGsaIqqz6YWoWe35pINseyeVjtWXcTj3A9HpYWDF4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=quIA/jNcYGIurVhn05AgJMMJTvSqDdi3ImLfY5DurNzxW+SdMom0s/FXGPmgSSURygwKB0AR9bS1QpU/RHIJUaCpD9CLLyyfJpYR8P0sXbfQre7wKxIgPDmJghUoNdDjjb3hiTIJa8m6tZN3VNPh3aMaXEpJcW2+jcp6BZ/D3zE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kdk0KE+W; arc=none smtp.client-ip=209.85.214.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kdk0KE+W"
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2d6c166bafcso18602625ad.2
        for <kvm@vger.kernel.org>; Wed, 26 Aug 2026 09:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787763409; x=1788368209; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=w5Tsw7lPtzwoej7ARhrRPL0yRyi2kwBS46nGNEACN58=;
        b=kdk0KE+WocgsnkHXaBbvtFXekSz/8s72JiuGHP4fO9SV6GGlIdrp7pONBO8I1q89jv
         5uL4/p822OHLBt8fBC60Bil8sIVxNx9cRvIV6LzaeOwRu6RjqqInb8G489Osbk21I+KQ
         sMsKs7T2cUnJxEMF9adCd99KV7A8eqLpIwqg67n5ysRhXYi54jT7sOilaQynGpM89FdV
         I5snQ8+yCRx1G2h0bupOa7besLLnqJus+LOF5iWqWBZ/n7xHh7BRVMyCKgeKrolxat/5
         Jg2YZZZOpdub7Ute6AFpKKzPY2AjZ+HkQSEatJEL3Psui0F75RuMqngawlGjaxenHavo
         9J1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787763409; x=1788368209;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=w5Tsw7lPtzwoej7ARhrRPL0yRyi2kwBS46nGNEACN58=;
        b=Kecf41GncDVSZi/pd+fRU5GM8sUBNF7O2T5rvxG4KDPs5QmYlMOdtToQy0oKm14UBJ
         JbbRLxaiwLE1jI31h8Ukl5i3gRaQ5cweMBVoAQkfNyer5PeEYQqniQj0kRlN//tSM2o3
         TxZnxOhYOkDOrjKbTPz+hdvQLGR2sEhgJ+H8I/M2XP/ejivpXIo44m2V5+mDXdA7TQx7
         G68FjceJdseppBvULG4EwF9NjH5Y9tiGQO9/FlgVS4uZg1TKGv674QJUJBZ2PBLY0kH9
         SKO3bUr008UREgqOYT2IdX0MINEW69d+KWYdx1JcPNG82GwPy644ngKQbX9O1ZRu8JQX
         8/Gw==
X-Forwarded-Encrypted: i=1; AHgh+RrJrXK9WowYYL/0n6FvjXYrkKqP0pEatzslLDnVpg8Q2nZjFYdr+Ojc87PS5/lTaNVED28=@vger.kernel.org
X-Gm-Message-State: AFuF++liu2Mg7mEL+m779udMX8SLzYUn4hlytOF4pWPCispNunby1WPn
	XgG8JuDxk9hlK+2zmoRzKC7B2Kckl7RAKMYiHhvzvtVQOdcj+kLsecgdsojdvwuCnq5eMIv++pW
	33fWjpg==
X-Received: from pgcz15.prod.google.com ([2002:a63:7e0f:0:b0:cc1:58f8:d2e7])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:a382:b0:3c8:f342:132c
 with SMTP id adf61e73a8af0-3cf83b22623mr16663653637.11.1787763409021; Wed, 26
 Aug 2026 09:56:49 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 26 Aug 2026 09:56:47 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.887.g758fc8c411-goog
Message-ID: <20260826165647.769231-1-seanjc@google.com>
Subject: [PATCH v2] KVM: guest_memfd: Elaborate on how release() vs. get_pfn()
 is safe against UAF
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: David Hildenbrand <david@kernel.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yan Zhao <yan.y.zhao@intel.com>, Vishal Annapurve <vannapurve@google.com>
Content-Type: text/plain; charset="UTF-8"

Add more context and information to the comment in kvm_gmem_release() that
explains why there's no synchronization on RCU _or_ kvm->srcu.  Point (b)
from commit 67b43038ce14 ("KVM: guest_memfd: Remove RCU-protected attribute
from slot->gmem.file")

      b) kvm->srcu ensures that kvm_gmem_unbind() and freeing of a memslot
         occur after the memslot is no longer visible to kvm_gmem_get_pfn().

is especially difficult to fully grok, particularly in light of commit
ae431059e75d ("KVM: guest_memfd: Remove bindings on memslot deletion when
gmem is dying"), which addressed a race between unbind() and release().

See the extended on-list discussion[*] for more details about exactly what
KVM guards against, and how.

No functional change intended.

Link: https://lore.kernel.org/all/CAEvNRgGmyd1yqQXsnz5hWRZpBZUs%3DpiEWbEaqP9%2Bcz9ZqEMQ6g@mail.gmail.com [*]
Cc: Yan Zhao <yan.y.zhao@intel.com>
Cc: Vishal Annapurve <vannapurve@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---

v2: Explain how this all works in even gorier detail. [Yan]

v1: https://lore.kernel.org/all/20251113232229.1698886-1-seanjc@google.com

 virt/kvm/guest_memfd.c | 50 +++++++++++++++++++++++++++++++++++++-----
 1 file changed, 44 insertions(+), 6 deletions(-)

diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index b596486d184c..7f1c6a0f8039 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -300,17 +300,55 @@ static int kvm_gmem_release(struct inode *inode, struct file *file)
 	 * dereferencing the slot for existing bindings needs to be protected
 	 * against memslot updates, specifically so that unbind doesn't race
 	 * and free the memslot (kvm_gmem_get_file() will return NULL).
-	 *
-	 * Since .release is called only when the reference count is zero,
-	 * after which file_ref_get() and get_file_active() fail,
-	 * kvm_gmem_get_pfn() cannot be using the file concurrently.
-	 * file_ref_put() provides a full barrier, and get_file_active() the
-	 * matching acquire barrier.
 	 */
 	mutex_lock(&kvm->slots_lock);
 
 	filemap_invalidate_lock(inode->i_mapping);
 
+	/*
+	 * Note!  synchronize_srcu() is _not_ needed after nullifying memslot
+	 * bindings as slot->gmem.file cannot be set back to a non-null value
+	 * without the memslot first being deleted.  I.e. this relies on the
+	 * synchronize_srcu_expedited() in kvm_swap_active_memslots() to ensure
+	 * kvm_gmem_get_pfn() (which runs with kvm->srcu held for read) can't
+	 * grab a reference to slot->gmem.file even if the struct file object
+	 * is reallocated.
+	 *
+	 * file_ref_put() provides a full barrier, and __get_file_rcu() the
+	 * matching acquire barrier, to ensure that kvm_gmem_get_file() (via
+	 * __get_file_rcu()) sees refcount==0 or fails the "file reloaded"
+	 * check (file != NULL due to nullifying the file pointer here).
+	 *
+	 * Unlike most other users of get_file_rcu(), where callers don't care
+	 * if they race with a write, only that they have a reference to _a_
+	 * live file, kvm_gmem_get_pfn() needs to get the exact file that is
+	 * associated with the memslot.  Without the aforementioned SRCU
+	 * synchronization, the following could happen:
+	 *
+	 *  CPU0				CPU1
+	 *  kvm_gmem_get_pfn()
+	 *    f = X (from slot->gmem.file)
+	 *					kvm_gmem_release())
+	 *					  slot->gmem.file = NULL
+	 *
+	 *					kvm_set_memory_region()
+	 *					  slot deleted
+	 *
+	 *					kvm_set_memory_region()
+	 *					  slot created
+	 *					  slot->gmem.file = f (alloc the same object)
+	 *
+	 *  get_file_active()
+	 *    file = f
+	 *    file_reloaded = f
+	 *
+	 * <KVM does weird things with an old memslot+file>
+	 *
+	 * Obviously KVM would be broken in many places if the synchronization
+	 * were omitted, but it's important to note that get_file_active() does
+	 * NOT guarantee a reference to the correct file was obtained, only
+	 * that the file doesn't point at a reallocated object.
+	 */
 	xa_for_each(&f->bindings, index, slot)
 		WRITE_ONCE(slot->gmem.file, NULL);
 

base-commit: 76671054f9a1ff6abb976583cd8da37650acdc97
-- 
2.55.0.887.g758fc8c411-goog

