Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2F992E6CC7
	for <kvm@vger.kernel.org>; Thu, 28 May 2026 02:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779934282; cv=none; b=X1uoXFkGFn1Sw44lOMF0UzrgN/6TEx49pOxNBuvDsZYbL4GMBEJWBzPJN+MdCjieUfX3b8hcnOTAILpHmstKyr+Beke8Qg+1GcAJELwqKoRTrSgGpil+6s1wI6CK3z/SfRun3L5cFc0JvWT/pf1BAe1yuIuElgOEuZOJqGhC1XA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779934282; c=relaxed/simple;
	bh=9ORIIIPjjw2AM0EjG4bGAqCl8hMp5MbkJ75KWEmuX2Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MKf/tsoniceruO1ou0CfPwv4nRqchfcJ5sAbBZ/F+zmy8jjwR1uvOFBFz5yavj94N1gb7c0E4zC9OGYVry7BX49UVF/Sa8eyybVjDyNzKldhLMvnm/0RHkl23lM6eRt4E1UmYgcG97MxVfnx+q/iGnBnsBvH5XFjt7O2vMB8aN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=C5XWVZ6Q; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C5XWVZ6Q"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2baf7378ad0so131717725ad.0
        for <kvm@vger.kernel.org>; Wed, 27 May 2026 19:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779934280; x=1780539080; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=09DnXFwxmloYaY3q9ixVHTqMxNXMN2GudCccAuHpU6A=;
        b=C5XWVZ6Q4/24pLz4HB1bcfykczUKpCjLuLMnra4uPcEzO2d08kCxF2mKI3P7DlaBc+
         WupJ3o+cgvRrsc2UexLkvd3M+bHhjOX6X0fMm8H29/FyJVfJwl4QNOz9QoW8IQznEPbF
         svEL2NbOl0XNF0ZpzJONozOo48sCQFF1CPPv0NTZgPfnLrj5LX4JqvaXT4XnadM3tgqR
         vtQkkMoD6AS9QKaoziG9r7/Qld7xouhnbjAziNSfXGKBS3UOb1u+ytkPNxuGIluuI+5j
         c7m5++LmzIThURWK4Mp+2fVhBstKa/imi5RQ1Se7rLDDvnqqOEYErBFw9dcQg3UyxdX+
         4rOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779934280; x=1780539080;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=09DnXFwxmloYaY3q9ixVHTqMxNXMN2GudCccAuHpU6A=;
        b=Ier46peSJCIgLJx290lxuI7cEewwBmEp4NNVSyWgOFXWQhrodejV0uM/fkmfAr+7Xk
         OPYKYkPXXh4UX6yWao5IXhSpxkUIa8u1ynfyVSniLiagRFTN73ENv3gsJ66r6QfsyRc7
         DARXorUsUWSEzL3pt4tHOBtuS+0BAuSu/p0l5DnTioWleEDdPkDfgh8disUKzqyewEic
         pBheH24HxlmHCyJA9U7yf/x1Dr+dKq4KyXdqVcKJiazKJ2Yxz7X32K08KBbIu5MoHjxa
         r4K/t1bQiM0zsm+c8djUOmGSeJrUKic/7k6y0Z8eRrRU0kDFX6UEtLYPZh7XrJzaNqGF
         2zVA==
X-Gm-Message-State: AOJu0YxN2zoKqNjdGtDi4n1SD0wL7Afa1rxoJZkgmxuMWeAhvsh1gURQ
	lWVKQy35SWFGGaEcug63+wIcCwABheYFJvTxOgqbInXhtC4mS4/eeAzm/AFkt7n+ARp8c4iDZAS
	nbHm9DQ==
X-Received: from plo18.prod.google.com ([2002:a17:902:ee52:b0:2bd:a0e6:1a81])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:fc85:b0:2bc:e2ed:fd03
 with SMTP id d9443c01a7336-2beb06a041emr278192465ad.39.1779934279990; Wed, 27
 May 2026 19:11:19 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 27 May 2026 19:11:15 -0700
In-Reply-To: <20260528021117.107984-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260528021117.107984-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.794.g4f17f83d09-goog
Message-ID: <20260528021117.107984-2-seanjc@google.com>
Subject: [PATCH v3 1/3] KVM: guest_memfd: Treat memslot binding offset+size as
 unsigned values
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ackerley Tng <ackerleytng@google.com>, Sean Christopherson <seanjc@google.com>
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
2.54.0.794.g4f17f83d09-goog

