Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A23E3B2AA
	for <kvm@vger.kernel.org>; Tue,  2 Jun 2026 17:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780420165; cv=none; b=OqlDPYryAQJ3u0ovjMj+SVqlYd2QRF4tbxOe56DCtIXYVM/zRFDLfGEB/A/hWAbjJqJLAxt4P5gytcNIF0FfQvSRcOa+iNfisYXs7MSSUCD4IuC/qGRtUgHdfWdYja3e75oQDbMzvrNQZSv16f25aSd1I7Xxt1x9PZ5/sW+oZUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780420165; c=relaxed/simple;
	bh=zXVaPGZ4QHBBXBt4EQ+3Iyp8TBCruXvDKknQdm+GMz8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hUP6M77ZjXEhfUuGpom7a6DtvmVzBeW2GKKZ2p69wo1x/qvCWY9Co4jhcRfxrM8sFCO8X7e9vu9lJjFEmunoqa5DiFCp4SMCZxVaKLzeG93SW2ZzRYfHySjiVCYzAZbbQ6xCZtjsCHmZDeGkevxEPPMjgPotNGj4edyuj4CfnrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TVs0tCQJ; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TVs0tCQJ"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2bf08c2a24bso59020105ad.2
        for <kvm@vger.kernel.org>; Tue, 02 Jun 2026 10:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780420164; x=1781024964; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=G8m+N8ql2TMEshzUG0QqHbQGCheVGCGULcRY+JWxijg=;
        b=TVs0tCQJDUfRWcVUsMXLC6jT32/ZlA32NT9j1UKN7MOuvWgNMgiW1Ij2lpp/lT5+3V
         g8+WYIhC6eG5i2b6GBmNghi1UfNP8uUSFiyfVVOEhzGC9oi/xJF7Umr11DJhonS8V01N
         PLGYt+MAr9GinTSq/xhVbIULy53iRHgaRtAThv+aHHhb+fOuBkFLr2qiSNGDXy5D0H7j
         4X5Hwb909GT4wiFhc0NXksKPQNKB4ThzXHxEjaTV/gTNmiPIwv96jdO1nUR1ryZYhszn
         2XCe8bvFjuw9yd/fHEnJBc0qd9O9kgjGqsPzVogSne7Rlda3/b2sszZ4mEfVb8smzll7
         /iLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780420164; x=1781024964;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G8m+N8ql2TMEshzUG0QqHbQGCheVGCGULcRY+JWxijg=;
        b=p/+C/QQzG6ay/f1ImL0UMWIS69GzGr57TlXziBAlmAbYB9Q319CiT2F8wBlO7Hi8ZP
         5xn8fiQTn1/SYv9aYp7BR2ryCnthFpU2d7q/D31cbKO+QlHyamw6IsnxkCKq+WmyvlZJ
         /z/l6U6ekhPFZU6Qe9oYa2sMnox4VsZiBlNz6WQ0dJK+wnyT1fGEheG6nZKEsCtPZtOd
         qomwHjLuLwCsqXb3xMxzmAml3lsJmAVg4sBmPS02OwMxwMDMVf2uw1nLcZWjviRePvxd
         Vug7B8hSKhXems0gNtxl+spQqPrwfYrlQRC8uHwevUkw5YmcE5zF9m/XXUyBpzs3/+Pu
         wFhQ==
X-Gm-Message-State: AOJu0Ywtq8zTX3yUsSImo26bf4oQlV2aF+x2erQ9+qzwnDf0ri/F0+aw
	TwweHffMvGu3Vh/+hoAoSmtSzguo7b45ruuMp20ftk4sX0N5O6AjLPkYT5WNZVpw7n0WjpGftbK
	7T6W8Mg==
X-Received: from plry22.prod.google.com ([2002:a17:902:b496:b0:2bd:9e64:2df1])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ce8d:b0:2c0:c625:4011
 with SMTP id d9443c01a7336-2c0c62543ffmr134938685ad.4.1780420163529; Tue, 02
 Jun 2026 10:09:23 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue,  2 Jun 2026 10:09:19 -0700
In-Reply-To: <20260602170921.1304394-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260602170921.1304394-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.1013.g208068f2d8-goog
Message-ID: <20260602170921.1304394-2-seanjc@google.com>
Subject: [PATCH v4 1/3] KVM: guest_memfd: Treat memslot binding offset+size as
 unsigned values
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ackerley Tng <ackerleytng@google.com>, Michael Roth <michael.roth@amd.com>, 
	Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

When binding a memslot to a guest_memfd file, treat the offset and size as
unsigned values to fix a bug where the sum of the two can result in a false
negative when checking for overflow against the size of the file.  Passing
unsigned values also avoids relying on somewhat obscure checks in other
flows for safety, and tracks the offset and size as they are intended to be
tracked, as unsigned values.

On 64-bit kernels, the number of pages a memslot contains and thus the size
(and offset) of its guest_memfd binding are unsigned 64-bit values.  Taking
the offset+size as an loff_t instead of a uoff_t inadvertently converts
the unsigned value to a signed value if the offset and/or size is massive.

Locally storing the offset and size as signed values is benign in and of
itself (though even that is *extremely* difficult to discern), but
operating on their sum is not.

For the offset, KVM explicitly checks against a negative value, which might
seem like a bug as KVM could incorrectly reject a legitimate binding, but
that's not actually the case as KVM_CREATE_GUEST_MEMFD takes a signed value
for its size, i.e. a would-be-negative offset is also greater than the
maximum possible size of any guest_memfd file.

Regarding the size, while KVM lacks an explicit check for a negative value,
i.e. seemingly has a flawed overflow check, KVM restricts the number of
pages in a single memslot to the largest positive signed 32-bit value:

        if (id < KVM_USER_MEM_SLOTS &&
            (mem->memory_size >> PAGE_SHIFT) > KVM_MEM_MAX_NR_PAGES)
                return -EINVAL;

and so that maximum "size" will ever be is 0x7fffffff000.

The sum of the two is, however, problematic.  While the size is restricted
by KVM's memslot logic, the offset is not, i.e. the offset is completely
unchecked until the "offset + size > i_size_read(inode)" check.  If the
offset is the (nearly) largest possible _positive_ value, then adding size
to the offset can result in a signed, negative 64-bit value.  When compared
against the size of the file (guaranteed to be positive), the negative sum
is always smaller, and KVM incorrectly allows the absurd offset.

Opportunistically add missing includes in kvm_mm.h (instead of relying on
its parents).

Fixes: a7800aa80ea4 ("KVM: Add KVM_CREATE_GUEST_MEMFD ioctl() for guest-specific backing memory")
Cc: stable@vger.kernel.org
Cc: Ackerley Tng <ackerleytng@google.com>
Reviewed-by: Michael Roth <michael.roth@amd.com>
Reviewed-by: Ackerley Tng <ackerleytng@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 virt/kvm/guest_memfd.c | 8 ++++----
 virt/kvm/kvm_mm.h      | 7 +++++--
 2 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index bf9659a7b0f6..a1cb72e66288 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -640,15 +640,16 @@ int kvm_gmem_create(struct kvm *kvm, struct kvm_create_guest_memfd *args)
 }
 
 int kvm_gmem_bind(struct kvm *kvm, struct kvm_memory_slot *slot,
-		  unsigned int fd, loff_t offset)
+		  unsigned int fd, uoff_t offset)
 {
-	loff_t size = slot->npages << PAGE_SHIFT;
+	uoff_t size = slot->npages << PAGE_SHIFT;
 	unsigned long start, end;
 	struct gmem_file *f;
 	struct inode *inode;
 	struct file *file;
 	int r = -EINVAL;
 
+	BUILD_BUG_ON(sizeof(gpa_t) != sizeof(offset));
 	BUILD_BUG_ON(sizeof(gfn_t) != sizeof(slot->gmem.pgoff));
 
 	file = fget(fd);
@@ -664,8 +665,7 @@ int kvm_gmem_bind(struct kvm *kvm, struct kvm_memory_slot *slot,
 
 	inode = file_inode(file);
 
-	if (offset < 0 || !PAGE_ALIGNED(offset) ||
-	    offset + size > i_size_read(inode))
+	if (!PAGE_ALIGNED(offset) || offset + size > i_size_read(inode))
 		goto err;
 
 	filemap_invalidate_lock(inode->i_mapping);
diff --git a/virt/kvm/kvm_mm.h b/virt/kvm/kvm_mm.h
index 9fcc5d5b7f8d..7510ca915dd1 100644
--- a/virt/kvm/kvm_mm.h
+++ b/virt/kvm/kvm_mm.h
@@ -3,6 +3,9 @@
 #ifndef __KVM_MM_H__
 #define __KVM_MM_H__ 1
 
+#include <linux/kvm.h>
+#include <linux/kvm_types.h>
+
 /*
  * Architectures can choose whether to use an rwlock or spinlock
  * for the mmu_lock.  These macros, for use in common code
@@ -72,7 +75,7 @@ int kvm_gmem_init(struct module *module);
 void kvm_gmem_exit(void);
 int kvm_gmem_create(struct kvm *kvm, struct kvm_create_guest_memfd *args);
 int kvm_gmem_bind(struct kvm *kvm, struct kvm_memory_slot *slot,
-		  unsigned int fd, loff_t offset);
+		  unsigned int fd, uoff_t offset);
 void kvm_gmem_unbind(struct kvm_memory_slot *slot);
 #else
 static inline int kvm_gmem_init(struct module *module)
@@ -82,7 +85,7 @@ static inline int kvm_gmem_init(struct module *module)
 static inline void kvm_gmem_exit(void) {};
 static inline int kvm_gmem_bind(struct kvm *kvm,
 					 struct kvm_memory_slot *slot,
-					 unsigned int fd, loff_t offset)
+					 unsigned int fd, uoff_t offset)
 {
 	WARN_ON_ONCE(1);
 	return -EIO;
-- 
2.54.0.929.g9b7fa37559-goog

