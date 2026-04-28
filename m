Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2988B42EEB4
	for <kvm@vger.kernel.org>; Tue, 28 Apr 2026 17:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777396565; cv=none; b=sIhRnl/0jj1r/pO8vNjVfcl39nvYtjHGVFq8KvM0ewZtZEuejFdOJmcPViuyHndWA48vGl52DCvfEAgXSa12lDhGEM76L9aFr3mEC6UEgebnLDutvpbt/0mVVo4+BL3Kf/U6ELyS+M40C7XS6wu1eYMHfYms5YLOaUDcKU1HzWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777396565; c=relaxed/simple;
	bh=1uiml0bm9m36ZN+On0jSrkItfTHXBP/nIdcfCh6AX9o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=I77LJRnnWQzflfa/rh1iTiAGAo1kaWKBd1mMXRtAALsS9BiXdbGyiFMh2JFagRX6UUQ2xttr31vXBBqUqN7fAzlmH3N+BSni47zkqZqfY8wsS+bHTCM52qqylBmUVRh4g5uOF6vZIBA7TWtPsomHP0Td1jI1VFlD0qcqf11bre8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=msHN2qIl; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="msHN2qIl"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-82f6a5b4f88so15449691b3a.2
        for <kvm@vger.kernel.org>; Tue, 28 Apr 2026 10:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777396557; x=1778001357; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=oYc/5nXwDHl/2dX5VkltRQ5fFLBzkZa0o8ZgjwDLbaQ=;
        b=msHN2qIlpCKsYDsaW2hhGpPewfg+4/1T2ioW26bel0gMGqHrHBpumJfS34zfTFg77U
         ADBz17TV8fVFsvgcHavXuQvkO1a7Jfb6RWe8JNmp+cPqda6sbRjeTXBkFEN1fIRLW5cv
         d7wIhXT/2Z4q/TwRIi1ZLlur6CR7djDhokgn9xRAhkUy4mJL9NUNYqp8Ez+vbDtP0G0G
         jvdoLnh5LKi3Xyu8fpcyU9g/NnHIdv+6405U2JyTF1Jb+OjMGGAiCHcuJTMvliq4RBU/
         FDtVDUIPkRHK+ifiqSaZdf0L1LWlSHIpRwGQtfnhr6+PKCuZpdyXYlimn45vouu7Ycla
         ObPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777396557; x=1778001357;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oYc/5nXwDHl/2dX5VkltRQ5fFLBzkZa0o8ZgjwDLbaQ=;
        b=B/NpmVeSlbmNbf5vwfshpSA1Cl20mPyjjD3RVY0bwsNf3dyd6TuMi7s5mGBH0KhCPu
         d9HmcH9OEMo1TFKIOOiMzxj2R9m8nA7P2yxrhD28WckMmbcW3RVVwNMerMZuSVOeGTBw
         pt06Yft5Ykp4A5gAZnhVN/4/m0X1TJXfqe01YOHgWb2VXo/YEImqRLsi0HjJVXYzZcz2
         aAzlv7g+MihW2hdElmYtlwbXjP9tspr284te+oyL8lDhFeoWLO+A1YvVVUeItKIa0nyQ
         RFYVxybZTlejB89qn7yL7SMd4OPyQzxZ/R1+p+X4lICsH5ADRBcj3TC386WzmG1fW7vs
         m3mA==
X-Forwarded-Encrypted: i=1; AFNElJ/cCj9MXrwT9hea+YmK+gAIQw6KnyzuxFfqM4ikd9i1eQck1aWuF9Ldi/duL/oRPXcJMQY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywd7BYCWWRltzu3MqkE5yIiVTccak86iqzAJbKGP4CYl0qrOtOv
	Z7++0ABj8DySjIBIpJbsPOpOvrn1OiZswiHqv+DsMQ/J/ger9HOTvOgsdoboP9NsUprzJCqHtvp
	gjYIbwg==
X-Received: from pfbde15.prod.google.com ([2002:a05:6a00:468f:b0:82f:1051:621])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:408a:b0:82f:5051:f022
 with SMTP id d2e1a72fcca58-834ddc2d824mr3942585b3a.32.1777396557290; Tue, 28
 Apr 2026 10:15:57 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 28 Apr 2026 10:15:38 -0700
In-Reply-To: <20260428171541.1342335-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260428171541.1342335-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260428171541.1342335-3-seanjc@google.com>
Subject: [RFC PATCH 2/5] KVM: guest_memfd: Move gmem function declarations to
 dedicated guest_memfd.h
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: David Hildenbrand <david@kernel.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosry@kernel.org>, Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>, 
	Tianrui Zhao <zhaotianrui@loongson.cn>, Bibo Mao <maobibo@loongson.cn>, 
	Huacai Chen <chenhuacai@kernel.org>, Anup Patel <anup@brainfault.org>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"

Extract the gmem function declarations out of kvm_mm.h and into a dedicated
header, guest_memfd.h.  This will allow creating a MAINTAINERS entry for
guest_memfd without having to rely on content pattern matching.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 virt/kvm/guest_memfd.c |  1 +
 virt/kvm/guest_memfd.h | 34 ++++++++++++++++++++++++++++++++++
 virt/kvm/kvm_main.c    |  1 +
 virt/kvm/kvm_mm.h      | 27 ---------------------------
 4 files changed, 36 insertions(+), 27 deletions(-)
 create mode 100644 virt/kvm/guest_memfd.h

diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index 69c9d6d546b2..a93a31568337 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -9,6 +9,7 @@
 #include <linux/pagemap.h>
 
 #include "kvm_mm.h"
+#include "guest_memfd.h"
 
 static struct vfsmount *kvm_gmem_mnt;
 
diff --git a/virt/kvm/guest_memfd.h b/virt/kvm/guest_memfd.h
new file mode 100644
index 000000000000..e8b825da264b
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
+		  unsigned int fd, loff_t offset);
+void kvm_gmem_unbind(struct kvm_memory_slot *slot);
+#else
+static inline int kvm_gmem_init(struct module *module)
+{
+	return 0;
+}
+static inline void kvm_gmem_exit(void) {};
+static inline int kvm_gmem_bind(struct kvm *kvm,
+					 struct kvm_memory_slot *slot,
+					 unsigned int fd, loff_t offset)
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
index 89489996fbc1..a4035ffb421f 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -56,6 +56,7 @@
 
 #include "coalesced_mmio.h"
 #include "async_pf.h"
+#include "guest_memfd.h"
 #include "kvm_mm.h"
 #include "vfio.h"
 
diff --git a/virt/kvm/kvm_mm.h b/virt/kvm/kvm_mm.h
index 9fcc5d5b7f8d..4958c0a93d64 100644
--- a/virt/kvm/kvm_mm.h
+++ b/virt/kvm/kvm_mm.h
@@ -67,31 +67,4 @@ static inline void gfn_to_pfn_cache_invalidate_start(struct kvm *kvm,
 }
 #endif /* HAVE_KVM_PFNCACHE */
 
-#ifdef CONFIG_KVM_GUEST_MEMFD
-int kvm_gmem_init(struct module *module);
-void kvm_gmem_exit(void);
-int kvm_gmem_create(struct kvm *kvm, struct kvm_create_guest_memfd *args);
-int kvm_gmem_bind(struct kvm *kvm, struct kvm_memory_slot *slot,
-		  unsigned int fd, loff_t offset);
-void kvm_gmem_unbind(struct kvm_memory_slot *slot);
-#else
-static inline int kvm_gmem_init(struct module *module)
-{
-	return 0;
-}
-static inline void kvm_gmem_exit(void) {};
-static inline int kvm_gmem_bind(struct kvm *kvm,
-					 struct kvm_memory_slot *slot,
-					 unsigned int fd, loff_t offset)
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
2.54.0.545.g6539524ca2-goog

