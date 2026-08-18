Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D15937E30C
	for <kvm@vger.kernel.org>; Tue, 18 Aug 2026 20:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787085886; cv=none; b=dcGGsnyEOy7wwZ3r1/nBB7Beqznnqh3ojbywAnc9Ceus9xsP51GgHa09idavdZqlojKko29FbfClv29zItf42alyxfA6twAma9bRM8xdq0hl5YPtUoc5c4ZKDxQyHLIQFmKa93w5pNgU8dK353F5bMmxpqrUfRqbJvpcD/kd1Oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787085886; c=relaxed/simple;
	bh=fmUtB78rLYh+tgEDVeIbrAYdAmlyJAm0q5QCuFNQNGs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lH4g+H0INfQ5gtHPRyG3dlnJhNQluuMoCjII6TC6+HohPTU+fcld0wrFVlEU5ABiMGb9DA6Vp6b4DKCWeMcsDA94WAnUcYHEoEBo4dODJqR057m/iOQb4GUtikUdw9cCxSuuFsyFEPHzYyWVPW9jRoX28ADDQvoak1tX6NDTrQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackyli.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gqDnQvHf; arc=none smtp.client-ip=209.85.215.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackyli.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gqDnQvHf"
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c856470fe9fso144162a12.2
        for <kvm@vger.kernel.org>; Tue, 18 Aug 2026 13:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787085884; x=1787690684; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NzXfJ7GrXHwgFSyfN75/LYVcSrb54eTxnKJjh2ZDD8c=;
        b=gqDnQvHfGWRxG/43inB6VF/O1LOdP+lEFG372tbV8ajHTa3hLcSD7+BkNdLsQrgjHz
         YYxoXlPbWkXTtaqXNDCElinTTBI5+u8CFfzhJ6pY5u3J8gC59YgbmXG/7atYQ+HwXdR3
         zx5PFLpAcMf9qRSYZHUBC8gmyulc0ahHjXliNsvFZz7Fy9+6xlqRVD1JdnnHGSFB6NKb
         amfFFfIxOrLXpS/JElq55QNuhEe03PcYoAfhrcqS9rFpvhgYTb33isYHafk1wey89jto
         NBengBAGDyG8lOkQS1VPl/18iyGJBYjhKUasJDufZ88Vx7FNUgWU9Ua8YuJu+v/NPvI0
         MXOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787085884; x=1787690684;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NzXfJ7GrXHwgFSyfN75/LYVcSrb54eTxnKJjh2ZDD8c=;
        b=PuM0fOZPbqRISBABG2FHEKu51wG4Gi+UJ7iEoxTS8y53iymrVP+Rg4SH1wEqTwVzqi
         5yR41IKscyPOieOCdNjlqKcJqXnlXJ/rpwi2JHIP/cP7TG8b0gEcVw4MlJvZqfS8NWNw
         szMLn/Ha3YaRH+WZGGagOEizkO6wObAuY3Xj+aaW1FypVqoyyxGObkgAjEj3UwCDBQfs
         Fadcn1y60qRVBAEURZLoBvEkhUWFnSdT8aGcjqtTW7mEknNBPmZw+bVnUo61BqU+SIdO
         7gbnkE0TQPxaoWWB8eUZEJDPFkyzWfScSCcSpcuWzS3NxMxYXgqhu24M0USPqHoixH0c
         B3eQ==
X-Forwarded-Encrypted: i=1; AHgh+Rr/pGIPx6IdwUcFJP1kVja7Fh/2IW118VCLzKyYJMlVeAdwXaeimBSDYJ6/qewSrcyioi8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmxHDaC/DpP/IhSKKS8A2lw2IcgT5HR/kFOgnc2i0OKNLUQvRG
	QEO5bQObDnnTBhbsaKdamrbgTIp2MEjDX4tNbb6xBtPs938hXszJZfnFZc7c6TaBq6CvMDiN2P6
	iouXZ5XFQ
X-Received: from pfbem53.prod.google.com ([2002:a05:6a00:3775:b0:851:8c82:93ea])
 (user=jackyli job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:9a1:b0:84e:24f:2667
 with SMTP id d2e1a72fcca58-851cd7a9ccemr1725750b3a.8.1787085884306; Tue, 18
 Aug 2026 13:44:44 -0700 (PDT)
Date: Tue, 18 Aug 2026 20:44:16 +0000
In-Reply-To: <20260818-feature-pkey-dev-v1-0-8c0ef96a4da9@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260818-feature-pkey-dev-v1-0-8c0ef96a4da9@google.com>
X-Mailer: b4 0.14.3
Message-ID: <20260818-feature-pkey-dev-v1-2-8c0ef96a4da9@google.com>
Subject: [RFC PATCH 2/6] kvm: Add guest memory Pkey initialization
From: Jacky Li <jackyli@google.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>, 
	Richard Henderson <richard.henderson@linaro.org>, 
	"=?utf-8?q?Philippe_Mathieu-Daud=C3=A9?=" <philmd@mailo.com>, Peter Xu <peterx@redhat.com>, kvm@vger.kernel.org, 
	James Houghton <jthoughton@google.com>, Mingwei Zhang <mizhang@google.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Brendan Jackman <jackmanb@google.com>, 
	Reiji Watanabe <reijiw@google.com>, Jacky Li <jackyli@google.com>
Content-Type: text/plain; charset="utf-8"

Add initialization logic during early QEMU startup to allocate a
dedicated userspace protection key (Pkey) for protecting guest physical
memory when enabled via QEMU_ENABLE_PKEY_GUEST_MEMORY.

Signed-off-by: Jacky Li <jackyli@google.com>
---
 include/exec/cpu-common.h |  1 +
 system/vl.c               |  1 +
 util/meson.build          |  2 +-
 util/pkey.c               | 23 +++++++++++++++++++++++
 4 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
index 6594f7fa1b..5ede0c65dc 100644
--- a/include/exec/cpu-common.h
+++ b/include/exec/cpu-common.h
@@ -112,4 +112,5 @@ static inline CPUState *env_cpu(CPUArchState *env)
     return (CPUState *)env_cpu_const(env);
 }
 
+void qemu_init_guest_memory_pkey(void);
 #endif /* CPU_COMMON_H */
diff --git a/system/vl.c b/system/vl.c
index 061cbdf860..e49c6fed39 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -2907,6 +2907,7 @@ void qemu_init(int argc, char **argv)
     module_allow_arch(target_name());
 
     qemu_init_subsystems();
+    qemu_init_guest_memory_pkey();
 
     /* first pass of option parsing */
     optind = 1;
diff --git a/util/meson.build b/util/meson.build
index fa174c07a5..682a078a3d 100644
--- a/util/meson.build
+++ b/util/meson.build
@@ -9,7 +9,7 @@ if host_os != 'windows'
   util_ss.add(files('compatfd.c'))
   util_ss.add(files('event_notifier-posix.c'))
   if host_os != 'emscripten'
-    util_ss.add(files('mmap-alloc.c'))
+    util_ss.add(files('mmap-alloc.c', 'pkey.c'))
   endif
   freebsd_dep = []
   if host_os == 'freebsd'
diff --git a/util/pkey.c b/util/pkey.c
index 4f14a72151..249e36d508 100644
--- a/util/pkey.c
+++ b/util/pkey.c
@@ -40,6 +40,8 @@
 #define PKEY_DISABLE_ACCESS 0x1
 #endif
 
+static int guest_memory_pkey = -1;
+
 /* Each protection key occupies exactly 2 bits in the PKRU register. */
 #define BITS_PER_KEY 2
 /* The mask used to extract/write the 2-bit permission flags. */
@@ -86,6 +88,24 @@ static inline __attribute__((always_inline)) intptr_t local_syscall3(
     return ret;
 }
 
+__attribute__((target("pku"))) void qemu_init_guest_memory_pkey(void)
+{
+    if (guest_memory_pkey != -1) {
+        return;
+    }
+
+    const char *enable_pkey = getenv("QEMU_ENABLE_PKEY_GUEST_MEMORY");
+    if (enable_pkey && strcmp(enable_pkey, "1") == 0) {
+        int pkey = pkey_alloc(0, 0);
+        if (pkey == -1) {
+            error_report("pkey_alloc failed for guest memory: %s",
+                         strerror(errno));
+        } else {
+            guest_memory_pkey = pkey;
+        }
+    }
+}
+
 #else
 /* Dummy implementations for all other configurations (non-x86_64 Linux, */
 /* Windows, macOS, etc.) */
@@ -93,4 +113,7 @@ static inline __attribute__((always_inline)) intptr_t local_syscall3(
 #include <linux/kvm.h>
 #include <sys/ioctl.h>
 #endif
+
+void qemu_init_guest_memory_pkey(void)
+{}
 #endif

-- 
2.55.0.737.g08866a6d13-goog

