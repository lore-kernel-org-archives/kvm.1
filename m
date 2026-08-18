Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51AE837DAC2
	for <kvm@vger.kernel.org>; Tue, 18 Aug 2026 20:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787085887; cv=none; b=rtH6C393EyOo2MafcvcPOUkGjKTcGieMLCecqCJYdNf0Xhu6IFBaeYmJEqOwxbt65aBsLLUqtMbtJt6IWz+HFht+ELNahP80om5I0J6uePF+qo61u9w81+MNjHFfV8rFBMz6z1tLmuwFTE9g191EOoQqkua2+1o54+Wu28NM1n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787085887; c=relaxed/simple;
	bh=+deeZZzRZnd2Nph82caalLrn9ey8kc4nJ7X+e+DRFg4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=d0VV7J2wgcDXIbEkbf1XzgsNkk4KRPt6O2sX5Y06f0AlEJ1TObVyqz+tMJFApCQ7DVgB6k8UdgKMnv14XVK0ksh2DMn3Er6eCtVKhvqUBBYyBSinPepkRJhLVp+txjuzsHLQX1fb0H34JrbRCQYwcGyqWshHmtN2YhMoL7NWzEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackyli.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BJWdEy3w; arc=none smtp.client-ip=209.85.215.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackyli.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BJWdEy3w"
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cab3e9cd922so131497a12.0
        for <kvm@vger.kernel.org>; Tue, 18 Aug 2026 13:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787085885; x=1787690685; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XSfBO46rQqbTNTbJ8xMsfzE0sjSykEikLSHsdbiM95o=;
        b=BJWdEy3wg1FqlbK3tJrJ5A2nLtlgcXeepz7SJUdgo9xdxgRewD6JgMcEW/sRpE4OcC
         lBjSKZ2CPSjZaDRT6TTUgnF+kGawj51RqaxlFBe7odGYEauasKMjAgyF0EbR6amBSIYI
         TzV32YIvCOK1fXAfyqi0vgVaIVt7mJqrVipjTgU9ZcKfuawYogNj8Or2Tch81Nf19VY9
         UQ1Ha6f5+IiMkAuehH6xVTRiG4wIZPYnIpFxMZJtaHRDaxB18nPsqFHH9+iGS5Fj3xfc
         YUwl1fpeBbkr+sJx+qqRzwrxFk7kaC7B87y8dR8ml6vgohVnhxEh+nV7OA4vrIGP7Xzj
         4ItA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787085885; x=1787690685;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XSfBO46rQqbTNTbJ8xMsfzE0sjSykEikLSHsdbiM95o=;
        b=cVGF7sumwVW44n/yIjc4z04UiAYlcVC5yvlfqDYLJNL4sVLz/NhxORrbcwvtCo2nNJ
         jQos1DWBBDoX4g7FfHGOnwlJvO73/qfRacQf72xHsLJBfRahmtTvXE9RXYszrbYSnMdA
         vEkNQ+F7u38wIVePqhlBtEzXtb+cfRNtKSUJtbx6IrSI7yW1kkgFNArIrMhn+ii9MQIl
         aNXqwhQpL3DXpIDaEWjVLfPKzWGup+9TtMlqWRhcnu1vNvwnlt+CPRrnTRHFdQPQTHOE
         pzmgkmCpHypIsfrq7kU6cgXfk3yaYKXDt+vJfiYYqvysz00KGrK7oidO7EMGbp+e1FF5
         ANsQ==
X-Forwarded-Encrypted: i=1; AHgh+RpIj4TqdnkQdXtIn99V2g7WRmKehcuHeP4tgqEIpPU9mhiXU0qf8spCyclsvToC/zK4iyk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOA8zZdPIvTd/39I8EfnoPS5jedBXP78jZorElBTqnOoeyxOoi
	W4mYkvW8klr/3X1w3zbaywl/u36b4zEDyvChMrynkQMZmIG3LglIhgZIVbHXZVjgR3djUAaGx4v
	M26ReDsT7
X-Received: from pglg36.prod.google.com ([2002:a63:1124:0:b0:cc1:522f:464c])
 (user=jackyli job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:cd96:b0:3bf:6d96:ac40
 with SMTP id adf61e73a8af0-3ccfef7af73mr837294637.12.1787085885436; Tue, 18
 Aug 2026 13:44:45 -0700 (PDT)
Date: Tue, 18 Aug 2026 20:44:17 +0000
In-Reply-To: <20260818-feature-pkey-dev-v1-0-8c0ef96a4da9@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260818-feature-pkey-dev-v1-0-8c0ef96a4da9@google.com>
X-Mailer: b4 0.14.3
Message-ID: <20260818-feature-pkey-dev-v1-3-8c0ef96a4da9@google.com>
Subject: [RFC PATCH 3/6] physmem: Tag guest RAMBlocks with Protection Key
From: Jacky Li <jackyli@google.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>, 
	Richard Henderson <richard.henderson@linaro.org>, 
	"=?utf-8?q?Philippe_Mathieu-Daud=C3=A9?=" <philmd@mailo.com>, Peter Xu <peterx@redhat.com>, kvm@vger.kernel.org, 
	James Houghton <jthoughton@google.com>, Mingwei Zhang <mizhang@google.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Brendan Jackman <jackmanb@google.com>, 
	Reiji Watanabe <reijiw@google.com>, Jacky Li <jackyli@google.com>
Content-Type: text/plain; charset="utf-8"

Apply the allocated guest memory protection key to all guest RAMBlocks
using `pkey_mprotect()` to enforce hardware-assisted access control.

This ensures that guest physical RAM mappings are tagged with our
dedicated Pkey in the host page tables, allowing the PKRU register to
dynamically permit or block access to guest memory.

Signed-off-by: Jacky Li <jackyli@google.com>
---
 include/exec/cpu-common.h |  1 +
 include/qemu/mmap-alloc.h |  5 +++++
 system/physmem.c          | 16 ++++++++++++++--
 util/mmap-alloc.c         |  3 +--
 util/pkey.c               | 16 ++++++++++++++++
 5 files changed, 37 insertions(+), 4 deletions(-)

diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
index 5ede0c65dc..28399088f6 100644
--- a/include/exec/cpu-common.h
+++ b/include/exec/cpu-common.h
@@ -113,4 +113,5 @@ static inline CPUState *env_cpu(CPUArchState *env)
 }
 
 void qemu_init_guest_memory_pkey(void);
+int qemu_pkey_mprotect_guest_memory(void *addr, size_t len, int prot);
 #endif /* CPU_COMMON_H */
diff --git a/include/qemu/mmap-alloc.h b/include/qemu/mmap-alloc.h
index 8344daaa03..82fe7f0c3d 100644
--- a/include/qemu/mmap-alloc.h
+++ b/include/qemu/mmap-alloc.h
@@ -63,4 +63,9 @@ void qemu_ram_munmap(int fd, void *ptr, size_t size);
  */
 #define QEMU_MAP_NORESERVE  (1 << 3)
 
+static inline int qemu_map_flags_to_prot(uint32_t qemu_map_flags)
+{
+  return PROT_READ | ((qemu_map_flags & QEMU_MAP_READONLY) ? 0 : PROT_WRITE);
+}
+
 #endif
diff --git a/system/physmem.c b/system/physmem.c
index 362a00f76c..9f5a0f194c 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -2144,6 +2144,12 @@ static void dirty_memory_extend(ram_addr_t new_ram_size)
     ram_list.num_dirty_blocks = new_num_blocks;
 }
 
+static inline int ramblock_get_prot(const RAMBlock *rb)
+{
+  uint32_t map_flags = (rb->flags & RAM_READONLY) ? QEMU_MAP_READONLY : 0;
+  return qemu_map_flags_to_prot(map_flags);
+}
+
 static void ram_block_add(RAMBlock *new_block, Error **errp)
 {
     const bool noreserve = qemu_ram_is_noreserve(new_block);
@@ -2282,6 +2288,13 @@ static void ram_block_add(RAMBlock *new_block, Error **errp)
         }
         ram_block_notify_add(new_block->host, new_block->used_length,
                              new_block->max_length);
+        int prot = ramblock_get_prot(new_block);
+        int ret = qemu_pkey_mprotect_guest_memory(new_block->host,
+                                                  new_block->max_length, prot);
+        if (ret != 0) {
+            error_report("qemu_pkey_mprotect failed for guest RAMBlock: %s",
+                         strerror(errno));
+        }
     }
     return;
 
@@ -2624,8 +2637,7 @@ static int qemu_ram_remap_mmap(RAMBlock *block, uint64_t start, size_t length)
     flags = MAP_FIXED | MAP_ANONYMOUS;
     flags |= block->flags & RAM_SHARED ? MAP_SHARED : MAP_PRIVATE;
     flags |= block->flags & RAM_NORESERVE ? MAP_NORESERVE : 0;
-    prot = PROT_READ;
-    prot |= block->flags & RAM_READONLY ? 0 : PROT_WRITE;
+    prot = ramblock_get_prot(block);
     area = mmap(host_startaddr, length, prot, flags, -1, 0);
     return area != host_startaddr ? -errno : 0;
 }
diff --git a/util/mmap-alloc.c b/util/mmap-alloc.c
index ed14f9c64d..0dc8e8275d 100644
--- a/util/mmap-alloc.c
+++ b/util/mmap-alloc.c
@@ -185,10 +185,9 @@ static void *mmap_activate(void *ptr, size_t size, int fd,
                            uint32_t qemu_map_flags, off_t map_offset)
 {
     const bool noreserve = qemu_map_flags & QEMU_MAP_NORESERVE;
-    const bool readonly = qemu_map_flags & QEMU_MAP_READONLY;
     const bool shared = qemu_map_flags & QEMU_MAP_SHARED;
     const bool sync = qemu_map_flags & QEMU_MAP_SYNC;
-    const int prot = PROT_READ | (readonly ? 0 : PROT_WRITE);
+    const int prot = qemu_map_flags_to_prot(qemu_map_flags);
     int map_sync_flags = 0;
     int flags = MAP_FIXED;
     void *activated_ptr;
diff --git a/util/pkey.c b/util/pkey.c
index 249e36d508..0151714f32 100644
--- a/util/pkey.c
+++ b/util/pkey.c
@@ -106,6 +106,17 @@ __attribute__((target("pku"))) void qemu_init_guest_memory_pkey(void)
     }
 }
 
+__attribute__((target("pku"))) int qemu_pkey_mprotect_guest_memory(void *addr,
+                                                                   size_t len,
+                                                                   int prot)
+{
+    int pkey = guest_memory_pkey;
+    if (pkey == -1) {
+        return 0;
+    }
+    return pkey_mprotect(addr, len, prot, pkey);
+}
+
 #else
 /* Dummy implementations for all other configurations (non-x86_64 Linux, */
 /* Windows, macOS, etc.) */
@@ -116,4 +127,9 @@ __attribute__((target("pku"))) void qemu_init_guest_memory_pkey(void)
 
 void qemu_init_guest_memory_pkey(void)
 {}
+
+int qemu_pkey_mprotect_guest_memory(void *addr, size_t len, int prot)
+{
+    return 0;
+}
 #endif

-- 
2.55.0.737.g08866a6d13-goog

