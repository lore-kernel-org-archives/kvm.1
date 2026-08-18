Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5267537D100
	for <kvm@vger.kernel.org>; Tue, 18 Aug 2026 20:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787085888; cv=none; b=fJZQLEQckiPp6nX11O4NL/I/KQPo823I6PZeASlltk8xu7JL1T2kr0Tz8YOM6k+fwz+h+FpBHpJzOdRCvO9zOTX0M98pWOxgKXpMt3AcoYEj969hUIRl5Qn4n4uD2y2vRW3p7c8AhKa6W0iFMktwbKNE2Cg1GLM7smW00im/ENY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787085888; c=relaxed/simple;
	bh=e5ds21oM4zvbuZOpfIjnx0+/N2O1hxYDrHpRAFKnlLY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=edoopVvMvJwFLRxZf0OfU8jqmfq5fIcxZoRR5zZMgC7VDq7iOdsCw0nJd5RR30MDBkmhaQwsZa+ZOhogAIwOtUhRYUQnKE2LYQAuzt4M/rrzj3kiZN7bmNWcXfusKXSi/sPkgQV/IYyWiLXyfV7H5O5n3fln7TC1KPnXmFzIAgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackyli.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Y+fLaYca; arc=none smtp.client-ip=209.85.210.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackyli.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y+fLaYca"
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-8487ed7f7beso326602b3a.0
        for <kvm@vger.kernel.org>; Tue, 18 Aug 2026 13:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787085887; x=1787690687; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PQq0Bm6wEPPaaVqXBMNHqZK4usIK/j6tgDNzvWv82vs=;
        b=Y+fLaYcaOGTrTpo7bRSBh4YYhVOk4EnCK64Hljj98NT9I1nx87UPBb9b7l+arROh8I
         smufEDoNjqP5gZid1ZEjjt1oN5oaQxW5tgJ6af9Jpd9gg3n69TEQTSmDA3dhv8Xl7Gz8
         m/nwB6lXG+RRGMM++kwakEcUDvCMUVHBcScD5TwbRq/Sg2xuNyOkj0LSR900PqVPkqnK
         JwB9596rP6KSAlZhEfaHdDbFBQJYuHapF+uYQDAnLd3skeQQBRUyoPnDdEBUEWGaY1YV
         UEZus3WWRC4a3sEh1A/PRb+73ger/ytXKc6we8EfvMXxAsK4Wxu50zcEiqfI582U5bu/
         9glQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787085887; x=1787690687;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PQq0Bm6wEPPaaVqXBMNHqZK4usIK/j6tgDNzvWv82vs=;
        b=l/GyNS2Tu3iACADsriuqMUR5Sfo93dNsSFWN9g1srLDXUPpUQROAhianRhDYbpLCSZ
         hDILQsV1u/WDV6Q1yLfOBV7jflHy0kv9iMe3/B6ZEay4PPbDfNvSKh/Cs0FwfJat2t5Z
         s66E3/NZko+XJE5nWN4UBnjZ/JauIX1De8z05aFr7QrgP1uo9tHnepvUx3fKhQckbsBC
         OipvYmmNH6D/oJ7B3jdRFlN4F5B69nQD9MfesTJuJwvgI2LIsnPfyOwgTGWuykU7Ooqn
         J7Ne1Gxa4OMq+G9OV5QvaX31t4bH9Jy4lIac5fLZ7/Rr59c/KdtsP2WPCOdIfYxCYVlZ
         L+8A==
X-Forwarded-Encrypted: i=1; AHgh+RqFXXZ8N03CB+H1+y4sdLR6L6FBgsgtz0qSwpGjJSMHXXQktKX0MwSU1e93y2cTp501y5g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBO3573nDMVALmE87IbmWMB2SIksI59hGOycXKC8wIIyt2L67G
	LlJrFwEUtpMgSp2Mudq7hdbPLexu0Pe8KgAXF5n/HWCX5hW66Lmu/ChWqUnyeDemwGiNOvXH9Fl
	0uGzxFR/l
X-Received: from pfbim15.prod.google.com ([2002:a05:6a00:8d8f:b0:84e:46f:f15e])
 (user=jackyli job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2e19:b0:847:97a4:d6b3
 with SMTP id d2e1a72fcca58-851cd8346efmr1708280b3a.16.1787085886501; Tue, 18
 Aug 2026 13:44:46 -0700 (PDT)
Date: Tue, 18 Aug 2026 20:44:18 +0000
In-Reply-To: <20260818-feature-pkey-dev-v1-0-8c0ef96a4da9@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260818-feature-pkey-dev-v1-0-8c0ef96a4da9@google.com>
X-Mailer: b4 0.14.3
Message-ID: <20260818-feature-pkey-dev-v1-4-8c0ef96a4da9@google.com>
Subject: [RFC PATCH 4/6] kvm: Lock guest RAMBlocks via PKRU during host
 userspace execution
From: Jacky Li <jackyli@google.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>, 
	Richard Henderson <richard.henderson@linaro.org>, 
	"=?utf-8?q?Philippe_Mathieu-Daud=C3=A9?=" <philmd@mailo.com>, Peter Xu <peterx@redhat.com>, kvm@vger.kernel.org, 
	James Houghton <jthoughton@google.com>, Mingwei Zhang <mizhang@google.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Brendan Jackman <jackmanb@google.com>, 
	Reiji Watanabe <reijiw@google.com>, Jacky Li <jackyli@google.com>
Content-Type: text/plain; charset="utf-8"

Protect guest RAMBlocks from host-side speculative execution attacks by
locking and unlocking the guest memory protection key before and after
`KVM_RUN`.

Signed-off-by: Jacky Li <jackyli@google.com>
---
 accel/kvm/kvm-all.c       |  7 ++++++-
 include/exec/cpu-common.h |  2 ++
 system/physmem.c          |  6 +++++-
 util/pkey.c               | 45 +++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 58 insertions(+), 2 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 83cbd120a8..ae395cd374 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -19,6 +19,7 @@
 
 #include <linux/kvm.h>
 
+#include "exec/cpu-common.h"
 #include "qemu/atomic.h"
 #include "qemu/option.h"
 #include "qemu/config-file.h"
@@ -3666,7 +3667,11 @@ int kvm_vcpu_ioctl(CPUState *cpu, unsigned long type, ...)
 
     trace_kvm_vcpu_ioctl(cpu->cpu_index, type, arg);
     accel_cpu_ioctl_begin(cpu);
-    ret = ioctl(cpu->kvm_fd, type, arg);
+    if (type == KVM_RUN) {
+        ret = qemu_pkey_kvm_run(cpu->kvm_fd, arg);
+    } else {
+        ret = ioctl(cpu->kvm_fd, type, arg);
+    }
     accel_cpu_ioctl_end(cpu);
     if (ret == -1) {
         ret = -errno;
diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
index 28399088f6..90047128de 100644
--- a/include/exec/cpu-common.h
+++ b/include/exec/cpu-common.h
@@ -114,4 +114,6 @@ static inline CPUState *env_cpu(CPUArchState *env)
 
 void qemu_init_guest_memory_pkey(void);
 int qemu_pkey_mprotect_guest_memory(void *addr, size_t len, int prot);
+void qemu_reset_pkey_with_ibpb(void);
+int qemu_pkey_kvm_run(int fd, void *arg);
 #endif /* CPU_COMMON_H */
diff --git a/system/physmem.c b/system/physmem.c
index 9f5a0f194c..c7101f6841 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -2755,7 +2755,11 @@ static void *qemu_ram_ptr_length(RAMBlock *block, ram_addr_t addr,
                                     1, lock, is_write);
     }
 
-    return ramblock_ptr(block, addr);
+    void *ptr = ramblock_ptr(block, addr);
+    if (ptr) {
+        qemu_reset_pkey_with_ibpb();
+    }
+    return ptr;
 }
 
 /*
diff --git a/util/pkey.c b/util/pkey.c
index 0151714f32..2e42da7d9c 100644
--- a/util/pkey.c
+++ b/util/pkey.c
@@ -117,17 +117,62 @@ __attribute__((target("pku"))) int qemu_pkey_mprotect_guest_memory(void *addr,
     return pkey_mprotect(addr, len, prot, pkey);
 }
 
+__attribute__((target("pku"))) void qemu_reset_pkey_with_ibpb(void)
+{
+    int pkey = guest_memory_pkey;
+    if (pkey == -1) {
+        return;
+    }
+    if (inline_pkey_get(pkey) == 0) {
+        return;
+    }
+
+    /* IBPB */
+    prctl(PR_SET_SPECULATION_CTRL, PR_SPEC_INDIRECT_BRANCH, PR_SPEC_DISABLE, 0,
+                0);
+
+    inline_pkey_set(pkey, 0);
+}
+
+__attribute__((target("pku"))) int qemu_pkey_kvm_run(int fd, void *arg)
+{
+    int pkey = guest_memory_pkey;
+    if (pkey == -1) {
+        return ioctl(fd, KVM_RUN, arg);
+    }
+
+    assert(pkey >= 0 && pkey < KEY_COUNT);
+
+    inline_pkey_set(pkey, 0);
+
+    intptr_t ret = local_syscall3(__NR_ioctl, fd, KVM_RUN, (intptr_t)arg);
+
+    inline_pkey_set(pkey, PKEY_DISABLE_ACCESS);
+
+    if (ret < 0) {
+        errno = -ret;
+        ret = -1;
+    }
+    return (int)ret;
+}
+
 #else
 /* Dummy implementations for all other configurations (non-x86_64 Linux, */
 /* Windows, macOS, etc.) */
 #if defined(CONFIG_LINUX)
 #include <linux/kvm.h>
 #include <sys/ioctl.h>
+
+int qemu_pkey_kvm_run(int fd, void *arg)
+{ return ioctl(fd, KVM_RUN, arg); }
 #endif
 
 void qemu_init_guest_memory_pkey(void)
 {}
 
+void qemu_reset_pkey_with_ibpb(void)
+{}
+
 int qemu_pkey_mprotect_guest_memory(void *addr, size_t len, int prot)
 {
     return 0;

-- 
2.55.0.737.g08866a6d13-goog

