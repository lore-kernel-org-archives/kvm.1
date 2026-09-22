Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40C4723BCED
	for <kvm@vger.kernel.org>; Tue, 22 Sep 2026 00:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790036024; cv=none; b=ZTlIQkZ/KoBbvOuLFlpMwMOsKOX9WtS8cR4BfMU96zKmBbW/2Iv5yP3D88qDQ/HrxJY4gcg5vRzfnd4Y9knU6y0DCEiYIuzWdO8FoeLZFjBP3nQuSmJ3kVyuTFRQq2lerh1aV2V5SVDM9WUB5HgRkHfSXSesLsrujYXzEkSb9yU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790036024; c=relaxed/simple;
	bh=zCji+nm6bPfKkfRj+T++V9XtpQDPMG4grJBVw/GKfdM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JncC4tqAnIDiCEFuQxF8ugzGMvr+5S0hTIPU6TisA+445cZVaT/Af/wEDdPJVOdkJBTQkFVJ7cA28L5ThifGwRdxmb2p6bQOMN5e3ws+BIw1Dp3LaFmzoD2NA4Kj/pqfy5qHRUYu3PGRgWAQzU0u3Vzekf4XwjbJxLksb8GtD5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JD9FAtQ3; arc=none smtp.client-ip=209.85.210.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JD9FAtQ3"
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-85f1f3620bcso369376b3a.0
        for <kvm@vger.kernel.org>; Mon, 21 Sep 2026 17:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790036019; x=1790640819; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=mXJYeSwmdO8BSBlAcqHdtDGYHg5nY+v9YdRsbiYIKqY=;
        b=JD9FAtQ3kA8rtRCt/mYL9sTmlACasVySUvJZ/fSAHMmPbKBkuq/1qWCLEYxoWk4RIE
         GwWAzrjz13RyefN0KBmeJFjOX/ZKzSAzWiekjVMMHR75/YqtAR3esuq2/W1Qgtp+Z376
         3zfLWFNjWs84d3jgxvBMfXKSrO4JR817MjaaslXj3iXCcZKresFtzMcoxdvoS5qiHINq
         vXHYMBRYfd397ucENz5dsS/eniGw+OSDTTiMTVkXTb8O/5uEF0RpFTSNcxNpudfL0a1C
         Wozvp1//nSw7rNNSzEzg1AxEh9MVi0nMNDpZ9Ns53F6LgVPo+xpmVu3eU1iajr5otQor
         stbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790036019; x=1790640819;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mXJYeSwmdO8BSBlAcqHdtDGYHg5nY+v9YdRsbiYIKqY=;
        b=lPcctlrikuMK+9K++9fUDzeYdBguQ+0EDwrqP8qUZL2Fxkhl762YvObcN1pKpWgNMZ
         +as2IK9LAnGPyykQh2oGW3OF8N088VAz7+gAvGHdjG7Vv4f/thUwzmh/jKSr1VG/arCz
         oMVfN6QKhJRT0xjq8EbmLwzPxdjtzBzlpaRMhB5IC65Cp8rChea66VqskpwECZiudnN0
         d97d4Xo/j6CMpuvTf4EUfkCXxQyFak7rNn+BRWtwt2rgQAJChxNWo8lniM5eGULVhwVQ
         IH/9BZlhxIskbhVggdNHWEot1/OhgxuKTSjNEnay/kIGYhsZW1njo/qP8erJ4oemQ0BP
         Z5IA==
X-Forwarded-Encrypted: i=1; AKwUvBwfTLBpmDir++XvhyrG2XH0Ug6ygoGO+y3qe+7sK8rx4R9UaT+1/OFTHIzeJ/3sN4TUMYE=@vger.kernel.org
X-Gm-Message-State: AFuF++kc2q7Ka7V0XUDZxoOUe7THtbQ5dke+wBMhdi098JRZbINibxCJ
	Vlm8vGuG78KXJJhGSeM9voEl0L7f7TIJhxhTwRsce8aku7ybIaMwL7N5TrvAiJ32/DDerYB8hRF
	vckS0zw==
X-Received: from pgvn3.prod.google.com ([2002:a65:63c3:0:b0:cc4:aa2a:ae77])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:2590:b0:3dd:85a8:4c50
 with SMTP id adf61e73a8af0-3dde023e07dmr1126632637.20.1790036019241; Mon, 21
 Sep 2026 17:13:39 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Mon, 21 Sep 2026 17:13:30 -0700
In-Reply-To: <20260922001332.1121266-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260922001332.1121266-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260922001332.1121266-5-seanjc@google.com>
Subject: [PATCH v5 4/6] KVM: guest_memfd: Split bind() into prepare()+commit() phases
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: David Hildenbrand <david@kernel.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Stefan Teodorescu <fane@google.com>, Dennis Tighe <dtighe@google.com>, 
	Sashiko Bot <sashiko-bot@kernel.org>, Ackerley Tng <ackerleytng@google.com>, 
	Yan Zhao <yan.y.zhao@intel.com>
Content-Type: text/plain; charset="UTF-8"

Split binding a memslot to a guest_memfd instance into prepare() and
commit() phases so that KVM can separate preparing the memslot from binding
the memslot to the gmem instance, i.e. from committing the memslot.  This
will allow waiting to commit the memslot+gmem binding until the memslot is
fully prepared, which is necessary as the memslot becomes reachable when
the binding is created.

As a bonus, drop the unwind-on-failure from the commit phase (other than
nullifying the bindings), as the only reason bind() did the full unwind is
because it technically didn't own the memslot, i.e. "needed" to leave
memslot in the same state it started in.

No functional change intended (the unwinding down on bind() failure was
effectively dead code since KVM simply deletes the memslot on failure,
i.e. there was nothing that could actually observe the unwind).

Cc: stable@vger.kernel.org
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 virt/kvm/guest_memfd.c | 68 ++++++++++++++++++++++++------------------
 virt/kvm/guest_memfd.h | 19 ++++++++----
 virt/kvm/kvm_main.c    | 18 ++++++++++-
 3 files changed, 70 insertions(+), 35 deletions(-)

diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index c094611f7c7a..80932f4ec4a3 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -641,15 +641,14 @@ int kvm_gmem_create(struct kvm *kvm, struct kvm_create_guest_memfd *args)
 	return __kvm_gmem_create(kvm, size, flags);
 }
 
-int kvm_gmem_bind(struct kvm *kvm, struct kvm_memory_slot *slot,
-		  unsigned int fd, uoff_t offset)
+int kvm_gmem_prepare_memory_region(struct kvm *kvm, struct kvm_memory_slot *slot,
+				   unsigned int fd, uoff_t offset)
 {
 	uoff_t size = slot->npages << PAGE_SHIFT;
-	unsigned long start, end;
 	struct gmem_file *f;
 	struct inode *inode;
 	struct file *file;
-	int r = -EINVAL;
+
 
 	BUILD_BUG_ON(sizeof(gpa_t) != sizeof(offset));
 	BUILD_BUG_ON(sizeof(gfn_t) != sizeof(slot->gmem.pgoff));
@@ -673,44 +672,55 @@ int kvm_gmem_bind(struct kvm *kvm, struct kvm_memory_slot *slot,
 	if (!PAGE_ALIGNED(offset) || offset + size > i_size_read(inode))
 		goto err;
 
-	filemap_invalidate_lock(inode->i_mapping);
-
-	start = offset >> PAGE_SHIFT;
-	end = start + slot->npages;
-
-	if (!xa_empty(&f->bindings) &&
-	    xa_find(&f->bindings, &start, end - 1, XA_PRESENT)) {
-		r = -EEXIST;
-		filemap_invalidate_unlock(inode->i_mapping);
-		goto err;
-	}
-
 	/*
 	 * memslots of flag KVM_MEM_GUEST_MEMFD are immutable to change, so
 	 * kvm_gmem_bind() must occur on a new memslot.  Because the memslot
 	 * is not visible yet, kvm_gmem_get_pfn() is guaranteed to see the file.
 	 */
 	WRITE_ONCE(slot->gmem.file, file);
-	slot->gmem.pgoff = start;
+	slot->gmem.pgoff = offset >> PAGE_SHIFT;
 	if (kvm_gmem_supports_mmap(inode))
 		slot->flags |= KVM_MEMSLOT_GMEM_ONLY;
 
-	r = xa_err(xa_store_range(&f->bindings, start, end - 1, slot, GFP_KERNEL));
-	if (r) {
-		xa_store_range(&f->bindings, start, end - 1, NULL, GFP_KERNEL);
-		slot->gmem.file = NULL;
-		slot->gmem.pgoff = 0;
-		slot->flags &= ~KVM_MEMSLOT_GMEM_ONLY;
-	}
-	filemap_invalidate_unlock(inode->i_mapping);
-
 	/*
-	 * Drop the reference to the file, even on success.  The file pins KVM,
-	 * not the other way 'round.  Active bindings are invalidated if the
-	 * file is closed before memslots are destroyed.
+	 * Gift the caller a reference to the file.  The reference will be
+	 * dropped after bindings are established, or if installing the new
+	 * memslot ultimately fails.
 	 */
+	return 0;
+
 err:
 	fput(file);
+	return -EINVAL;
+}
+
+int kvm_gmem_commit_memory_region(struct kvm *kvm, struct kvm_memory_slot *slot)
+{
+	struct gmem_file *f = slot->gmem.file->private_data;
+	struct inode *inode = file_inode(slot->gmem.file);
+	unsigned long start, end;
+	int r;
+
+	if (WARN_ON_ONCE(slot->gmem.file->f_op != &kvm_gmem_fops))
+		return -EIO;
+
+	filemap_invalidate_lock(inode->i_mapping);
+
+	start = slot->gmem.pgoff;
+	end = start + slot->npages;
+
+	if (!xa_empty(&f->bindings) &&
+	    xa_find(&f->bindings, &start, end - 1, XA_PRESENT)) {
+		filemap_invalidate_unlock(inode->i_mapping);
+		return -EEXIST;
+	}
+
+	r = xa_err(xa_store_range(&f->bindings, start, end - 1, slot, GFP_KERNEL));
+	if (r)
+		xa_store_range(&f->bindings, start, end - 1, NULL, GFP_KERNEL);
+
+	filemap_invalidate_unlock(inode->i_mapping);
+
 	return r;
 }
 
diff --git a/virt/kvm/guest_memfd.h b/virt/kvm/guest_memfd.h
index 0f9c6f840838..01bd359d27e3 100644
--- a/virt/kvm/guest_memfd.h
+++ b/virt/kvm/guest_memfd.h
@@ -8,8 +8,9 @@
 int kvm_gmem_init(struct module *module);
 void kvm_gmem_exit(void);
 int kvm_gmem_create(struct kvm *kvm, struct kvm_create_guest_memfd *args);
-int kvm_gmem_bind(struct kvm *kvm, struct kvm_memory_slot *slot,
-		  unsigned int fd, uoff_t offset);
+int kvm_gmem_prepare_memory_region(struct kvm *kvm, struct kvm_memory_slot *slot,
+				   unsigned int fd, uoff_t offset);
+int kvm_gmem_commit_memory_region(struct kvm *kvm, struct kvm_memory_slot *slot);
 void kvm_gmem_unbind(struct kvm_memory_slot *slot);
 #else
 static inline int kvm_gmem_init(struct module *module)
@@ -17,9 +18,17 @@ static inline int kvm_gmem_init(struct module *module)
 	return 0;
 }
 static inline void kvm_gmem_exit(void) {};
-static inline int kvm_gmem_bind(struct kvm *kvm,
-					 struct kvm_memory_slot *slot,
-					 unsigned int fd, uoff_t offset)
+
+static inline int kvm_gmem_prepare_memory_region(struct kvm *kvm,
+						 struct kvm_memory_slot *slot,
+						 unsigned int fd, uoff_t offset)
+{
+	WARN_ON_ONCE(1);
+	return -EIO;
+}
+
+static inline int kvm_gmem_commit_memory_region(struct kvm *kvm,
+						struct kvm_memory_slot *slot)
 {
 	WARN_ON_ONCE(1);
 	return -EIO;
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index ccfd5f5102a5..45b509f4e54b 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -2117,7 +2117,23 @@ static int kvm_set_memory_region(struct kvm *kvm,
 	new->flags = mem->flags;
 	new->userspace_addr = mem->userspace_addr;
 	if (change == KVM_MR_CREATE && (mem->flags & KVM_MEM_GUEST_MEMFD)) {
-		r = kvm_gmem_bind(kvm, new, mem->guest_memfd, mem->guest_memfd_offset);
+		r = kvm_gmem_prepare_memory_region(kvm, new, mem->guest_memfd,
+						   mem->guest_memfd_offset);
+		if (r)
+			goto out;
+
+		r = kvm_gmem_commit_memory_region(kvm, new);
+
+		/*
+		 * Drop the reference to the file, even on success.  The file
+		 * pins KVM, not the other way 'round.  Active bindings are
+		 * invalidated if the file is closed before memslots are
+		 * destroyed.
+		 */
+#ifdef CONFIG_KVM_GUEST_MEMFD
+		 fput(new->gmem.file);
+#endif
+
 		if (r)
 			goto out;
 	}
-- 
2.55.0.1082.g2b9226bbc0-goog

