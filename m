Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com [209.85.221.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28D424EE84F
	for <kvm@vger.kernel.org>; Thu, 10 Sep 2026 16:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789057444; cv=none; b=oOPxIkZEliPrvTeg5jJmA6g40EDB1P6JXj+8gM/pIiPzXD4BDe4rqxSDo9g7jH82l37C8RMUhoMIRgO+LyV7kdqXE7rjW+vkOlBLKGwN6yURifX1Er7ys4KJh42SHK73TYiuVPfZNR1mrEbmQJH/VgwA9/JUUqbfyc8SvSD88w4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789057444; c=relaxed/simple;
	bh=MnMX/OSFrRzbTxG7baAXBumw8j8z3VdCQcDWmSfrIJ0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qdvvJW1UlB2fkqelQ9yFkrQtqUHqNGZqyC0EL6wLQ1EtI5pdQfWZfkfhZ8G8omBaj4ovfCZhw+lG94t9Mq3kCJRstfXxBxxv51UxvrfVl4NtW+MBJDML0KGPUz3fHFXuYJi9pjkYtBX78pgpdiqfUoW9xQ6SGbBEp0gIDmixhiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--elver.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WQ6am5kD; arc=none smtp.client-ip=209.85.221.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--elver.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WQ6am5kD"
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-482e05af072so6375236f8f.3
        for <kvm@vger.kernel.org>; Thu, 10 Sep 2026 09:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789057439; x=1789662239; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RRWmScgPx+BLIgnYUF1mxiVgMRyBAcMFYt7T+8tBBLE=;
        b=WQ6am5kDkIfSMrePPt0m4Sa89K6912KJnDNj1ZlfI81/JHyfLf4XwCYtb+HyKQJqs+
         bZvRRBKVB0zXhJu0WhZg1iFHFfWqGkDB1vM4wkmF9HLok3P2QNR5omVUfzkSaMxoHmM1
         TW+4TYY8pHnDEehoY0z/iisB8AULso/6+NzHk/3IMYgLA4hHy1OInvRZkKxgZgGz13qH
         7pW0BwjMQdKjgsyDnbHSlni36zWNX7NxUycUpwH89lmB3PUbgjFo2sRTghkCGKe6A9Tl
         cmgSfg+WkHrCqbqPvhreW7YsYL/N5QzQJcwRaYNtXPwGgETfL+y06Ov6rVP4+s7Blm6C
         oDJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789057439; x=1789662239;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RRWmScgPx+BLIgnYUF1mxiVgMRyBAcMFYt7T+8tBBLE=;
        b=AMgio+EmCPFqBg22UPG7sd0rRxvYVNZRn5o7AL4wMJwmPQwHJnjBkP9xP7bKefBsHG
         LgYZXofXtXyEqoYMT2ysl5VOwHJhygtp70N8Dc1gYYHrDDlhEbUjTI+wX8sx6C5SZtGa
         sXuIAeBH9DwTegLM72QvKQdbATCBB1bE8ICbqmZY37oTJQgPaSPq0RytJD+gQgNPe4vH
         v9jxrJXiNCM32/dMeRTsN/wiXwRTfxtKF71o2qGSzShhTU7UHf46SpUNJom9kMC4EezZ
         lzgNXPdMK8vAC6oA00Hk62DvTx85cQv+OMElVhCWbYukw5w5WycRCceupmwdTaN/EKBP
         iJww==
X-Forwarded-Encrypted: i=1; AKwUvBym5VgNOwnzB3pkNMKlpFH1cXi/9o5paLF3OPC26VLvbqdpzGbhl0n7Dl1h0JbhSFGf4zg=@vger.kernel.org
X-Gm-Message-State: AFuF++kVKyz1CVkPEb+xefuxRE4BZBczjuL+LjySYYVtTJQhk4eXSdCd
	xocRneIFYe5aJYc8kHbHtWPopibEf/Gx9XUllVKU1iFV6YBE0cRgTsoB5eVuLJsJrJvWXt4Jh42
	6lg==
X-Received: from wmoy5.prod.google.com ([2002:a05:600c:17c5:b0:499:d96d:63b2])
 (user=elver job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:46d5:b0:49c:fc6c:be06
 with SMTP id 5b1f17b1804b1-49cfc6cc142mr367514185e9.29.1789057438931; Thu, 10
 Sep 2026 09:23:58 -0700 (PDT)
Date: Thu, 10 Sep 2026 16:21:36 +0000
In-Reply-To: <20260910162343.4092060-1-elver@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260910162343.4092060-1-elver@google.com>
X-Mailer: git-send-email 2.55.0.1003.g10538fe699-goog
Message-ID: <20260910162343.4092060-4-elver@google.com>
Subject: [PATCH RFC 03/10] KVM: guest_memfd: Avoid conditional mmu_lock acquisition
From: Marco Elver <elver@google.com>
To: elver@google.com
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, Kiryl Shutsemau <kas@kernel.org>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, David Hildenbrand <david@kernel.org>, kvm@vger.kernel.org, 
	linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Refactor __kvm_gmem_invalidate_start() to check for present bindings
upfront via xa_find() instead of tracking found memslots inside the
range iteration with a 'found_memslot' flag and conditionally acquiring
and releasing KVM's mmu_lock.

Eliminating the conditional locking inside the loop simplifies control
flow, ensures lock scoping is straightforward, and subsequently allows
Clang context analysis to verify that mmu_lock is held unconditionally
across kvm_mmu_unmap_gfn_range().

No functional change intended.

Signed-off-by: Marco Elver <elver@google.com>
---
 virt/kvm/guest_memfd.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index 625e62e1a031..896f3b076562 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -124,10 +124,16 @@ static void __kvm_gmem_invalidate_start(struct gmem_file *f, pgoff_t start,
 					pgoff_t end,
 					enum kvm_gfn_range_filter attr_filter)
 {
-	bool flush = false, found_memslot = false;
+	bool flush = false;
 	struct kvm_memory_slot *slot;
 	struct kvm *kvm = f->kvm;
-	unsigned long index;
+	pgoff_t index = start;
+
+	if (!xa_find(&f->bindings, &index, end - 1, XA_PRESENT))
+		return;
+
+	KVM_MMU_LOCK(kvm);
+	kvm_mmu_invalidate_start(kvm);
 
 	xa_for_each_range(&f->bindings, index, slot, start, end - 1) {
 		pgoff_t pgoff = slot->gmem.pgoff;
@@ -140,13 +146,6 @@ static void __kvm_gmem_invalidate_start(struct gmem_file *f, pgoff_t start,
 			.attr_filter = attr_filter,
 		};
 
-		if (!found_memslot) {
-			found_memslot = true;
-
-			KVM_MMU_LOCK(kvm);
-			kvm_mmu_invalidate_start(kvm);
-		}
-
 		flush |= kvm_mmu_unmap_gfn_range(kvm, &gfn_range);
 
 #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_INVALIDATE
@@ -157,8 +156,7 @@ static void __kvm_gmem_invalidate_start(struct gmem_file *f, pgoff_t start,
 	if (flush)
 		kvm_flush_remote_tlbs(kvm);
 
-	if (found_memslot)
-		KVM_MMU_UNLOCK(kvm);
+	KVM_MMU_UNLOCK(kvm);
 }
 
 static void kvm_gmem_invalidate_start(struct inode *inode, pgoff_t start,
-- 
2.55.0.1003.g10538fe699-goog

