Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE7894457C3
	for <kvm@vger.kernel.org>; Fri, 31 Jul 2026 17:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785519532; cv=none; b=Qz0uRP6ts/PIvLSpusguqFDE32J9vsyBYk7Za9shpzuLSEAcKZ4JKJ1EsnQAhASFOBOGKb4KICSrx3wgZwHGyVZnetwNyb0Xc9VeGzv7IshyiiQYz4tuHimtMAn7w1PO4xjqJQggW6Znt7NXNfRGaDtjbLulkNqRuxZ97BuG+SM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785519532; c=relaxed/simple;
	bh=IYcC9lIapaYdJoAFtUXkm8OwJYJ5zsexH5lmUSeBS6I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dyvEJeXQVCXAnhXT6vPokIrPYMTJyn3tyMDZM+zEyLR5O9u6AFJiWpmyZzCcgESWyr/4htBk401/z9wmYjDQ1XFTC5hYLUfTM9ub7Rgg4PFGwv/cC7opFwYIkhP3BD67V+RkxmVWBymG4N0OVN+NntWTOzH5HCbe91LgcGLTF+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dSj7nIwq; arc=none smtp.client-ip=209.85.210.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dSj7nIwq"
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-8485b7e18b4so2415902b3a.1
        for <kvm@vger.kernel.org>; Fri, 31 Jul 2026 10:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785519528; x=1786124328; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ZBZ4WEbR2BQ44y7jx9EAFSDGpgtjFTxL2JrU5WB2i+c=;
        b=dSj7nIwqGnTJBQxSYXBxauBqkaCyblUJ7F+UxoxRt38OltPuponYjAMB3gtHMYo0ak
         ea4/w/8P4yhEPV30OZQtxcdADa5lfnWlKCeRmKqVODQSOFeKRBJPpXRY+Y/WpfOB07o8
         /Zz8sl0E/BXexnq9CtEF4WvmG/XqSuDfvS+2Dq3YEfV5xfzLxz08+9JJtz+iPBf25oAK
         C3IGx3O1Fh4MNCC5vo82W96RUIK0MXL02G/3+cSi8vmBHdAXWR+Ac1b4aVCTVSHKbfHf
         0iUFs6Pd7TRa8tK1y39DyppsFAt9aClarnOFmqieSS6L3wen6/Twyk08JmCq5+O5ggaU
         DKuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785519528; x=1786124328;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZBZ4WEbR2BQ44y7jx9EAFSDGpgtjFTxL2JrU5WB2i+c=;
        b=njvxVV9Da2cr7FD3KKgmioVjvX8UsbatqJwj/XqB7Q134hoNHpH7NG40opu7D790Xz
         4GWCZ/0ow97OCDVrXwQd4VfiZBFi4yA3Tp/A2u3Qn7XdhHvlSzvbfZCNChlrON4C3NVm
         D+k6x3a/A+ORV0aBmrEMOej3Fk9EA7cUXimP99CPIZqp75LKrVeMxRicTAggfU580pZt
         9pP+caPJNyNTANMAYAt3o/18h3iPnhfqOnzttKSiaTF0giPTz45+HJbxOsWErWe0n9Xv
         eHI0gwL/2jSpMrlpXLYPfq5P2RxunTZNYfzPI43hO5O3H5LlvdCxHNzY92Mpn6DncoB7
         y8yg==
X-Forwarded-Encrypted: i=1; AHgh+Rp0Sw3Fa/UtHGaYWt0fGTwt6w7xwJ4ANYNx3n+1LP+5J1UkzN4SzDNSy1Kx+HV7melDN/w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4MN/2O0yxvjUnD4+I0hUn6Y7EhhWLg568ZPhKHboWo/UwtWIU
	hKSYhp8EjIrecYZyGqw9OO7t5RNxyPSfcKfyMigr2awtn/a/WPDSkgzWlK63Wqhfj8SAs+28bba
	1aeoU5A==
X-Received: from pgce6.prod.google.com ([2002:a05:6a02:1c6:b0:c99:aff5:7092])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:180d:b0:848:2f84:f42e
 with SMTP id d2e1a72fcca58-84ee49c4d6bmr433113b3a.71.1785519528369; Fri, 31
 Jul 2026 10:38:48 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 31 Jul 2026 10:38:39 -0700
In-Reply-To: <20260731173842.2649391-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260731173842.2649391-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.508.g3f0d502094-goog
Message-ID: <20260731173842.2649391-3-seanjc@google.com>
Subject: [PATCH v2 2/5] KVM: guest_memfd: Move gmem function declarations to
 dedicated guest_memfd.h
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>
Cc: David Hildenbrand <david@kernel.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosry@kernel.org>, Ackerley Tng <ackerleytng@google.com>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oupton@kernel.org>, Tianrui Zhao <zhaotianrui@loongson.cn>, 
	Bibo Mao <maobibo@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>, 
	Anup Patel <anup@brainfault.org>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Janosch Frank <frankja@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"

Extract the gmem function declarations out of kvm_mm.h and into a dedicated
header, guest_memfd.h.  This will allow creating a MAINTAINERS entry for
guest_memfd without having to rely on content pattern matching.

Reviewed-by: Ackerley Tng <ackerleytng@google.com>
Acked-by: David Hildenbrand (Arm) <david@kernel.org>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 virt/kvm/guest_memfd.c |  1 +
 virt/kvm/guest_memfd.h | 34 ++++++++++++++++++++++++++++++++++
 virt/kvm/kvm_main.c    |  1 +
 virt/kvm/kvm_mm.h      | 27 ---------------------------
 4 files changed, 36 insertions(+), 27 deletions(-)
 create mode 100644 virt/kvm/guest_memfd.h

diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index 86690683b2fe..de2585539b25 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -9,6 +9,7 @@
 #include <linux/pagemap.h>
 
 #include "kvm_mm.h"
+#include "guest_memfd.h"
 
 static struct vfsmount *kvm_gmem_mnt;
 
diff --git a/virt/kvm/guest_memfd.h b/virt/kvm/guest_memfd.h
new file mode 100644
index 000000000000..0f9c6f840838
--- /dev/null
+++ b/virt/kvm/guest_memfd.h
@@ -0,0 +1,34 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef __KVM_GUEST_MEMFD_H__
+#define __KVM_GUEST_MEMFD_H__
+
+#include <linux/kvm_types.h>
+
+#ifdef CONFIG_KVM_GUEST_MEMFD
+int kvm_gmem_init(struct module *module);
+void kvm_gmem_exit(void);
+int kvm_gmem_create(struct kvm *kvm, struct kvm_create_guest_memfd *args);
+int kvm_gmem_bind(struct kvm *kvm, struct kvm_memory_slot *slot,
+		  unsigned int fd, uoff_t offset);
+void kvm_gmem_unbind(struct kvm_memory_slot *slot);
+#else
+static inline int kvm_gmem_init(struct module *module)
+{
+	return 0;
+}
+static inline void kvm_gmem_exit(void) {};
+static inline int kvm_gmem_bind(struct kvm *kvm,
+					 struct kvm_memory_slot *slot,
+					 unsigned int fd, uoff_t offset)
+{
+	WARN_ON_ONCE(1);
+	return -EIO;
+}
+
+static inline void kvm_gmem_unbind(struct kvm_memory_slot *slot)
+{
+	WARN_ON_ONCE(1);
+}
+#endif /* CONFIG_KVM_GUEST_MEMFD */
+
+#endif /* __KVM_GUEST_MEMFD_H__ */
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index e44c20c04961..a2f67623e60a 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -56,6 +56,7 @@
 
 #include "coalesced_mmio.h"
 #include "async_pf.h"
+#include "guest_memfd.h"
 #include "kvm_mm.h"
 #include "vfio.h"
 
diff --git a/virt/kvm/kvm_mm.h b/virt/kvm/kvm_mm.h
index 7510ca915dd1..c65cfdb14f1c 100644
--- a/virt/kvm/kvm_mm.h
+++ b/virt/kvm/kvm_mm.h
@@ -70,31 +70,4 @@ static inline void gfn_to_pfn_cache_invalidate_start(struct kvm *kvm,
 }
 #endif /* HAVE_KVM_PFNCACHE */
 
-#ifdef CONFIG_KVM_GUEST_MEMFD
-int kvm_gmem_init(struct module *module);
-void kvm_gmem_exit(void);
-int kvm_gmem_create(struct kvm *kvm, struct kvm_create_guest_memfd *args);
-int kvm_gmem_bind(struct kvm *kvm, struct kvm_memory_slot *slot,
-		  unsigned int fd, uoff_t offset);
-void kvm_gmem_unbind(struct kvm_memory_slot *slot);
-#else
-static inline int kvm_gmem_init(struct module *module)
-{
-	return 0;
-}
-static inline void kvm_gmem_exit(void) {};
-static inline int kvm_gmem_bind(struct kvm *kvm,
-					 struct kvm_memory_slot *slot,
-					 unsigned int fd, uoff_t offset)
-{
-	WARN_ON_ONCE(1);
-	return -EIO;
-}
-
-static inline void kvm_gmem_unbind(struct kvm_memory_slot *slot)
-{
-	WARN_ON_ONCE(1);
-}
-#endif /* CONFIG_KVM_GUEST_MEMFD */
-
 #endif /* __KVM_MM_H__ */
-- 
2.55.0.508.g3f0d502094-goog

