Received: from www3579.sakura.ne.jp (www3579.sakura.ne.jp [49.212.243.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6951345CB2;
	Fri,  3 Jul 2026 05:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.212.243.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783056214; cv=none; b=GAMev2tBFiLjFHnfEmm50mqDD0xnEnzjYpCERLmBfKF7K4iMBvU35g3pFVlmFZU2oYqFrYBXU010liJ1SVPuJ9zAoMcve9gAooaA8wsVZ4qiExrfX4iTyPKA8gILM343D/oiaidz6KIcWJfJ/eLlGj+v4pNhPlDgMjOFlPgRqKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783056214; c=relaxed/simple;
	bh=L+KVAMGTsaOt599iuSVgif1jV4HKCoTCrodEu6dG+Qg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=A+Gc4UB90SCuTsiuMqXkaa2XqSWNd//ZghQGK5j+qqZ3Jx+b/bwjmbPsu42yIuIG2iauXPseAb42V4Fr3K4chHQhLCHD2WkjJwFSceRf1LJFTMrLMzYioYwCtsfpiienoqyCyORzdRB1CEuqW5v0NXTdKH34W0jY1ngmB7k19xI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rsg.ci.i.u-tokyo.ac.jp; spf=pass smtp.mailfrom=rsg.ci.i.u-tokyo.ac.jp; dkim=fail (0-bit key) header.d=rsg.ci.i.u-tokyo.ac.jp header.i=@rsg.ci.i.u-tokyo.ac.jp header.b=mHK+MzHF reason="key not found in DNS"; arc=none smtp.client-ip=49.212.243.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rsg.ci.i.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rsg.ci.i.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=rsg.ci.i.u-tokyo.ac.jp header.i=@rsg.ci.i.u-tokyo.ac.jp header.b="mHK+MzHF"
Received: from h183.csg.ci.i.u-tokyo.ac.jp (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
	(authenticated bits=0)
	by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 6635LT8Q018373
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Fri, 3 Jul 2026 14:21:44 +0900 (JST)
	(envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=8Z+IPYMxREf+abkIImBqXakTaTGWJQ+kmZT646AKWUY=;
        c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
        h=From:Message-Id:To:Subject:Date;
        s=rs20250326; t=1783056104; v=1;
        b=mHK+MzHFe5pufb2GxF26lI1muKh0LM+Rd1oFmcUJgWtJDzyFLEyjJTIMi9/UcG9e
         b6m3yIJruONYSU9TQbQxLPoMEcnG0kf5jFjS2l+n6JAbeK31JNC+hybrwvXnkhJR
         CG2PwqJugDdAZw7Gq+S+cEf1bBXJ2CehRXn6Zm+byZrqs5/zxSCr3J9Vj7FWVEYI
         RsrkydzvZE6U7li2a+bESxJ0pFUF36jchgz9/3gCXYzrS6j6CtVSjPUfhtDrgTPY
         OQIWzIYZLqeZ8afzJdDGh/Wrm8rVJU4n+foWkCyCwvP+A5ahHBTDWNDjflCsEBez
         8b8WsIzbrLT4qSjrTeLFkw==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Date: Fri, 03 Jul 2026 14:19:19 +0900
Subject: [PATCH v2 3/7] system/memory: Remove the resized callback
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-ram-v2-3-7f07fc06fba9@rsg.ci.i.u-tokyo.ac.jp>
References: <20260703-ram-v2-0-7f07fc06fba9@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260703-ram-v2-0-7f07fc06fba9@rsg.ci.i.u-tokyo.ac.jp>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
        =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
        Zhao Liu <zhao1.liu@intel.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Anthony PERARD <anthony@xenproject.org>,
        "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
        Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Reinoud Zandijk <reinoud@netbsd.org>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Alex Williamson <alex@shazbot.org>,
        =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
        qemu-block@nongnu.org, xen-devel@lists.xenproject.org,
        kvm@vger.kernel.org, Gerd Hoffmann <kraxel@redhat.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
        Peter Maydell <peter.maydell@linaro.org>,
        Richard Henderson <richard.henderson@linaro.org>,
        Song Gao <gaosong@loongson.cn>, Bibo Mao <maobibo@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Alistair Francis <alistair.francis@wdc.com>,
        Weiwei Li <liwei1518@gmail.com>,
        Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
        Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
        Chao Liu <chao.liu.zevorn@gmail.com>, linux-edac@vger.kernel.org,
        qemu-arm@nongnu.org, qemu-riscv@nongnu.org,
        Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
X-Mailer: b4 0.16-dev-925f5
X-Developer-Signature: v=1; a=openpgp-sha256; l=10859;
 i=odaki@rsg.ci.i.u-tokyo.ac.jp; h=from:subject:message-id;
 bh=L+KVAMGTsaOt599iuSVgif1jV4HKCoTCrodEu6dG+Qg=;
 b=owGbwMvMwCWmMbc20y1CyJDxtFoSQ5a72wPp7bZLZ897U1e/sKCf4VvVg/3yNqKLXbesnyLwy
 /id7LyJHaUsDGJcDLJiiiwpRbu5NaJrPxUmxLfAzGFlAhnCwMUpABPZrcPwP+Flw5Xje7OyFpQu
 b3h/6c6hbJ/E5wdKXi42TboU9Oen+k+G/1nv1azc0lxehausvPHl3iWuB9z5xvNMzaIFN25JPG0
 5ix8A
X-Developer-Key: i=odaki@rsg.ci.i.u-tokyo.ac.jp; a=openpgp;
 fpr=AEDC03C9AF734F2EC26A7BFFA4BAEAA73536753C

The previous change moved fw_cfg updates out of the RAMBlock resize
callback, leaving the callback pointer unused. Remove the now-unused
callback plumbing.

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
 include/system/memory.h   |  4 ----
 include/system/ramblock.h |  7 +------
 hw/core/loader.c          |  4 +---
 system/memory.c           |  7 ++-----
 system/physmem.c          | 24 ++++++------------------
 5 files changed, 10 insertions(+), 36 deletions(-)

diff --git a/include/system/memory.h b/include/system/memory.h
index e143c9c3f396..6a2d5f5f855f 100644
--- a/include/system/memory.h
+++ b/include/system/memory.h
@@ -1407,7 +1407,6 @@ bool memory_region_init_ram_flags_nomigrate(MemoryRegion *mr,
  *        must be unique within any device
  * @size: used size of the region.
  * @max_size: max size of the region.
- * @resized: callback to notify owner about used size change.
  * @errp: pointer to Error*, to store an error if it happens.
  *
  * Note that this function does not do anything to cause the data in the
@@ -1420,9 +1419,6 @@ bool memory_region_init_resizeable_ram(MemoryRegion *mr,
                                        const char *name,
                                        uint64_t size,
                                        uint64_t max_size,
-                                       void (*resized)(const char*,
-                                                       uint64_t length,
-                                                       void *host),
                                        Error **errp);
 #ifdef CONFIG_POSIX
 
diff --git a/include/system/ramblock.h b/include/system/ramblock.h
index 4435f8d55fe7..1a95fba87f0c 100644
--- a/include/system/ramblock.h
+++ b/include/system/ramblock.h
@@ -30,7 +30,6 @@ struct RAMBlock {
     ram_addr_t offset;
     ram_addr_t used_length;
     ram_addr_t max_length;
-    void (*resized)(const char*, uint64_t length, void *host);
     uint32_t flags;
     /* Protected by the BQL.  */
     char idstr[256];
@@ -244,7 +243,6 @@ static inline unsigned long int ramblock_recv_bitmap_offset(void *host_addr,
  *  @size: the size in bytes of the ram block
  *  @max_size: the maximum size of the block after resizing
  *  @mr: the memory region where the ram block is
- *  @resized: callback after calls to qemu_ram_resize
  *  @ram_flags: RamBlock flags. Supported flags: RAM_SHARED, RAM_PMEM,
  *              RAM_NORESERVE, RAM_PROTECTED, RAM_NAMED_FILE, RAM_READONLY,
  *              RAM_READONLY_FD, RAM_GUEST_MEMFD
@@ -257,13 +255,11 @@ static inline unsigned long int ramblock_recv_bitmap_offset(void *host_addr,
  *  On success, return a pointer to the ram block.
  *  On failure, return NULL.
  */
-typedef void (*qemu_ram_resize_cb)(const char *, uint64_t length, void *host);
-
 RAMBlock *qemu_ram_alloc_from_file(ram_addr_t size, MemoryRegion *mr,
                                    uint32_t ram_flags, const char *mem_path,
                                    off_t offset, Error **errp);
 RAMBlock *qemu_ram_alloc_from_fd(ram_addr_t size, ram_addr_t max_size,
-                                 qemu_ram_resize_cb resized, MemoryRegion *mr,
+                                 MemoryRegion *mr,
                                  uint32_t ram_flags, int fd, off_t offset,
                                  bool grow,
                                  Error **errp);
@@ -273,7 +269,6 @@ RAMBlock *qemu_ram_alloc_from_ptr(ram_addr_t size, void *host,
 RAMBlock *qemu_ram_alloc(ram_addr_t size, uint32_t ram_flags, MemoryRegion *mr,
                          Error **errp);
 RAMBlock *qemu_ram_alloc_resizeable(ram_addr_t size, ram_addr_t max_size,
-                                    qemu_ram_resize_cb resized,
                                     MemoryRegion *mr, Error **errp);
 void qemu_ram_free(RAMBlock *block);
 
diff --git a/hw/core/loader.c b/hw/core/loader.c
index 14d56f52e4ec..147b872031eb 100644
--- a/hw/core/loader.c
+++ b/hw/core/loader.c
@@ -1068,9 +1068,7 @@ static void *rom_set_mr(Rom *rom, Object *owner, const char *name, bool ro)
 
     rom->mr = g_malloc(sizeof(*rom->mr));
     memory_region_init_resizeable_ram(rom->mr, owner, name,
-                                      rom->romsize, rom->romsize,
-                                      NULL,
-                                      &error_fatal);
+                                      rom->romsize, rom->romsize, &error_fatal);
     memory_region_set_readonly(rom->mr, ro);
     vmstate_register_ram_global(rom->mr);
 
diff --git a/system/memory.c b/system/memory.c
index 8436668c181d..6ec4b4ebb20e 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -1610,16 +1610,13 @@ bool memory_region_init_resizeable_ram(MemoryRegion *mr,
                                        const char *name,
                                        uint64_t size,
                                        uint64_t max_size,
-                                       void (*resized)(const char*,
-                                                       uint64_t length,
-                                                       void *host),
                                        Error **errp)
 {
     RAMBlock *rb;
 
     memory_region_init(mr, owner, name, size);
     mr->ram = true;
-    rb = qemu_ram_alloc_resizeable(size, max_size, resized, mr, errp);
+    rb = qemu_ram_alloc_resizeable(size, max_size, mr, errp);
     return memory_region_set_ram_block(mr, rb);
 }
 
@@ -1650,7 +1647,7 @@ bool memory_region_init_ram_from_fd(MemoryRegion *mr, Object *owner,
     memory_region_init(mr, owner, name, size);
     mr->ram = true;
     mr->readonly = !!(ram_flags & RAM_READONLY);
-    rb = qemu_ram_alloc_from_fd(size, size, NULL, mr, ram_flags, fd, offset,
+    rb = qemu_ram_alloc_from_fd(size, size, mr, ram_flags, fd, offset,
                                 false, errp);
     return memory_region_set_ram_block(mr, rb);
 }
diff --git a/system/physmem.c b/system/physmem.c
index 9e5b50c5b1ca..54fe820ce828 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -2032,9 +2032,6 @@ int qemu_ram_resize(RAMBlock *block, ram_addr_t newsize, Error **errp)
          */
         if (unaligned_size != memory_region_size(block->mr)) {
             memory_region_set_size(block->mr, unaligned_size);
-            if (block->resized) {
-                block->resized(block->idstr, unaligned_size, block->host);
-            }
         }
         return 0;
     }
@@ -2065,9 +2062,6 @@ int qemu_ram_resize(RAMBlock *block, ram_addr_t newsize, Error **errp)
     physical_memory_set_dirty_range(block->offset, block->used_length,
                                         DIRTY_CLIENTS_ALL);
     memory_region_set_size(block->mr, unaligned_size);
-    if (block->resized) {
-        block->resized(block->idstr, unaligned_size, block->host);
-    }
     return 0;
 }
 
@@ -2297,7 +2291,7 @@ out_free:
 
 #if defined(CONFIG_POSIX) && !defined(EMSCRIPTEN)
 RAMBlock *qemu_ram_alloc_from_fd(ram_addr_t size, ram_addr_t max_size,
-                                 qemu_ram_resize_cb resized, MemoryRegion *mr,
+                                 MemoryRegion *mr,
                                  uint32_t ram_flags, int fd, off_t offset,
                                  bool grow,
                                  Error **errp)
@@ -2356,7 +2350,6 @@ RAMBlock *qemu_ram_alloc_from_fd(ram_addr_t size, ram_addr_t max_size,
     new_block->mr = mr;
     new_block->used_length = size;
     new_block->max_length = max_size;
-    new_block->resized = resized;
     new_block->flags = ram_flags;
     new_block->guest_memfd = -1;
     new_block->host = file_ram_alloc(new_block, max_size, fd,
@@ -2413,7 +2406,7 @@ RAMBlock *qemu_ram_alloc_from_file(ram_addr_t size, MemoryRegion *mr,
         return NULL;
     }
 
-    block = qemu_ram_alloc_from_fd(size, size, NULL, mr, ram_flags, fd, offset,
+    block = qemu_ram_alloc_from_fd(size, size, mr, ram_flags, fd, offset,
                                    false, errp);
     if (!block) {
         if (created) {
@@ -2458,7 +2451,6 @@ static int qemu_ram_get_shared_fd(const char *name, bool *reused, Error **errp)
 
 static
 RAMBlock *qemu_ram_alloc_internal(ram_addr_t size, ram_addr_t max_size,
-                                  qemu_ram_resize_cb resized,
                                   void *host, uint32_t ram_flags,
                                   MemoryRegion *mr, Error **errp)
 {
@@ -2504,7 +2496,7 @@ RAMBlock *qemu_ram_alloc_internal(ram_addr_t size, ram_addr_t max_size,
              * region if necessary.  The extra space will be usable after a
              * guest reset.
              */
-            new_block = qemu_ram_alloc_from_fd(size, max_size, resized, mr,
+            new_block = qemu_ram_alloc_from_fd(size, max_size, mr,
                                                ram_flags, fd, 0, reused, NULL);
             if (new_block) {
                 trace_qemu_ram_alloc_shared(name, new_block->used_length,
@@ -2527,7 +2519,6 @@ RAMBlock *qemu_ram_alloc_internal(ram_addr_t size, ram_addr_t max_size,
 
     new_block = g_malloc0(sizeof(*new_block));
     new_block->mr = mr;
-    new_block->resized = resized;
     new_block->used_length = size;
     new_block->max_length = max_size;
     new_block->fd = -1;
@@ -2547,8 +2538,7 @@ RAMBlock *qemu_ram_alloc_internal(ram_addr_t size, ram_addr_t max_size,
 RAMBlock *qemu_ram_alloc_from_ptr(ram_addr_t size, void *host,
                                    MemoryRegion *mr, Error **errp)
 {
-    return qemu_ram_alloc_internal(size, size, NULL, host, RAM_PREALLOC, mr,
-                                   errp);
+    return qemu_ram_alloc_internal(size, size, host, RAM_PREALLOC, mr, errp);
 }
 
 RAMBlock *qemu_ram_alloc(ram_addr_t size, uint32_t ram_flags,
@@ -2556,15 +2546,13 @@ RAMBlock *qemu_ram_alloc(ram_addr_t size, uint32_t ram_flags,
 {
     assert((ram_flags & ~(RAM_SHARED | RAM_NORESERVE | RAM_GUEST_MEMFD |
                           RAM_PRIVATE)) == 0);
-    return qemu_ram_alloc_internal(size, size, NULL, NULL, ram_flags, mr, errp);
+    return qemu_ram_alloc_internal(size, size, NULL, ram_flags, mr, errp);
 }
 
 RAMBlock *qemu_ram_alloc_resizeable(ram_addr_t size, ram_addr_t maxsz,
-                                    qemu_ram_resize_cb resized,
                                     MemoryRegion *mr, Error **errp)
 {
-    return qemu_ram_alloc_internal(size, maxsz, resized, NULL,
-                                   RAM_RESIZEABLE, mr, errp);
+    return qemu_ram_alloc_internal(size, maxsz, NULL, RAM_RESIZEABLE, mr, errp);
 }
 
 static void reclaim_ramblock(RAMBlock *block)

-- 
2.54.0

