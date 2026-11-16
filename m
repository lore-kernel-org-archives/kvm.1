Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794847847;
	b=APj9d3LfMoLH7f1j3pptAfpBikxRtYCUJl3SmBbGA4CMp0kZAcMXRxdi6uy6z9Sg6Qfu
	 TJpwlDEApM7TZxSN/KkDr1zJLx+K2IoDRlsHVrqghrd+loK5nbDkz+Hd4bwu8OMN/WrkH
	 bkHyn2a1gBo7F8HGH8hsXCv87Y5qlgZiUAKVn7wSaecJPp1a2cbqTXxadmlaH75hHVBi+
	 LJN1HuLirmBWAcFe52W/s2ZP/IoaXbQA+uDCxWqtageWqsUjWdQ4vgyEA1LsajMjiOxQJ
	 9np6OVqVGQ3Ef4byuS/hCY1T3maNlLZL4CzDhXrtO4jTIBVQnFniqICmErkM71kBARg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794847847;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Scanned-By;
	bh=YP0uMjXbMZzhkU1dEuU+r+EAx9s3iL97wWTm1GvIKRo=;
	b=cRnot1+2+9mXYC4FB8vQvYE/yoxcvs1TTSm2hkNypPCR+wB75z62m6Ib5yGe4jPi7mya
	 gfu2WAszNGGlG70yTJre8hrE+XPwepdBSg5sNR/yVpuY1Joy416B9u5QfjhP5qlxOdiA1
	 RujNuTASGgpSTa1eQenYYio8aDJD53VdlL6WuAF7ilfTq6PPPO/t6vVGI68SC4uzgkLkx
	 ah+rZTotSgdd4+yboYIn7x5JFdAaawvbpxZLYQNWdOwm0jyG9SE4gfr9MiF5GBddCKSxN
	 imA2fi8TjLwAK3czhXsYTUNHx09cju9BujvADTo4J9f9nNnKrEI3tOoAINEaWQK2V2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=b7KSabYF;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C3B606A323
	for <kvm@vger.kernel.org>; Mon, 16 Nov 2026 16:50:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 84C3B606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=b7KSabYF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794847845;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YP0uMjXbMZzhkU1dEuU+r+EAx9s3iL97wWTm1GvIKRo=;
	b=b7KSabYFXj2iOA1kOjkig6wkIEHi2tjHDedkS01wb2KES5cGP9c5olZYaMXJrh4yaBccqt
	jqGk9BRHmGbUQCST9igMbADjSB9bxfAuitbw8reWKOjTgq70BBgZi3MNIQiqrF6++LvXOg
	apAphuSVvIE6a4ijnWtoN4gbm6IDL/o=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-83-oXN2bRmCNliD4RMRV-JqRQ-1; Mon,
 16 Nov 2026 11:50:37 -0500
X-MC-Unique: oXN2bRmCNliD4RMRV-JqRQ-1
X-Mimecast-MFC-AGG-ID: oXN2bRmCNliD4RMRV-JqRQ_1794847834
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8295D18004F6;
	Mon, 16 Nov 2026 16:50:34 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 75E1C195B3C7;
	Mon, 16 Nov 2026 16:50:31 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	kvm@vger.kernel.org,
	Dmitry Osipenko <dmitry.osipenko@collabora.com>,
	Fabiano Rosas <farosas@suse.de>,
	Alistair Francis <alistair.francis@wdc.com>,
	Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
	Stefan Weil <sw@weilnetz.de>,
	Peter Xu <peterx@redhat.com>,
	Richard Henderson <richard.henderson@linaro.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
	David Gibson <david@gibson.dropbear.id.au>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	=?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
	John Snow <jsnow@redhat.com>
Subject: [PATCH v2 6/7] debug/mem: name qemu_anon_ram_alloc/qemu_ram_mmap pages
Date: Mon, 16 Nov 2026 11:50:01 -0500
Message-ID: <20261116165002.30939-7-jsnow@redhat.com>
In-Reply-To: <20261116165002.30939-1-jsnow@redhat.com>
References: <20261116165002.30939-1-jsnow@redhat.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

This patch adds a nickname parameter to qemu_anon_ram_alloc, which
passes it to qemu_ram_mmap, which passes it in turn to mmap_activate,
where it is used to name the region being allocated.

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
---
 include/qemu/mmap-alloc.h  |  3 ++-
 include/qemu/osdep.h       |  2 +-
 hw/display/virtio-gpu-gl.c |  2 +-
 migration/ram.c            |  3 ++-
 system/physmem.c           |  7 +++++--
 target/i386/kvm/tdx.c      |  3 ++-
 util/mmap-alloc.c          | 10 +++++++---
 util/oslib-posix.c         |  4 ++--
 util/oslib-win32.c         |  2 +-
 9 files changed, 23 insertions(+), 13 deletions(-)

diff --git a/include/qemu/mmap-alloc.h b/include/qemu/mmap-alloc.h
index 8344daaa03f..c34587179b6 100644
--- a/include/qemu/mmap-alloc.h
+++ b/include/qemu/mmap-alloc.h
@@ -36,7 +36,8 @@ void *qemu_ram_mmap(int fd,
                     size_t size,
                     size_t align,
                     uint32_t qemu_map_flags,
-                    off_t map_offset);
+                    off_t map_offset,
+                    const char *nickname);
 
 void qemu_ram_munmap(int fd, void *ptr, size_t size);
 
diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
index b27d159d5bb..5e712ff1c6c 100644
--- a/include/qemu/osdep.h
+++ b/include/qemu/osdep.h
@@ -552,7 +552,7 @@ void QEMU_ERROR("code path is reachable")
 
 int qemu_daemon(int nochdir, int noclose);
 void *qemu_anon_ram_alloc(size_t size, uint64_t *align, bool shared,
-                          bool noreserve);
+                          bool noreserve, const char *nickname);
 void qemu_anon_ram_free(void *ptr, size_t size);
 int qemu_shm_alloc(size_t size, Error **errp);
 
diff --git a/hw/display/virtio-gpu-gl.c b/hw/display/virtio-gpu-gl.c
index 2b7a41c4664..66c302315c5 100644
--- a/hw/display/virtio-gpu-gl.c
+++ b/hw/display/virtio-gpu-gl.c
@@ -145,7 +145,7 @@ static void virtio_gpu_gl_device_realize(DeviceState *qdev, Error **errp)
 #if !defined(CONFIG_WIN32)
     if (virtio_gpu_hostmem_enabled(b->conf)) {
         map = qemu_ram_mmap(-1, b->conf.hostmem, qemu_real_host_page_size(),
-                            0, 0);
+                            0, 0, "virgl-hostmem");
         if (map == MAP_FAILED) {
             error_setg_errno(errp, errno,
                              "virgl hostmem region could not be initialized");
diff --git a/migration/ram.c b/migration/ram.c
index e6db3bf5238..c48e05078d1 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -3720,7 +3720,8 @@ int colo_init_ram_cache(Error **errp)
     WITH_RCU_READ_LOCK_GUARD() {
         RAMBLOCK_FOREACH_NOT_IGNORED(block) {
             block->colo_cache = qemu_anon_ram_alloc(block->used_length,
-                                                    NULL, false, false);
+                                                    NULL, false, false,
+                                                    "colo cache");
             if (!block->colo_cache) {
                 error_setg(errp, "Can't alloc memory for COLO cache of "
                            "block %s, size 0x" RAM_ADDR_FMT,
diff --git a/system/physmem.c b/system/physmem.c
index a7300bb9d97..202e3a5cd00 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -1767,7 +1767,8 @@ static void *file_ram_alloc(RAMBlock *block,
     qemu_map_flags |= (block->flags & RAM_SHARED) ? QEMU_MAP_SHARED : 0;
     qemu_map_flags |= (block->flags & RAM_PMEM) ? QEMU_MAP_SYNC : 0;
     qemu_map_flags |= (block->flags & RAM_NORESERVE) ? QEMU_MAP_NORESERVE : 0;
-    area = qemu_ram_mmap(fd, memory, block->mr->align, qemu_map_flags, offset);
+    area = qemu_ram_mmap(fd, memory, block->mr->align, qemu_map_flags, offset,
+                         "file_ram_alloc");
     if (area == MAP_FAILED) {
         error_setg_errno(errp, errno,
                          "unable to map backing store for guest RAM");
@@ -2169,7 +2170,9 @@ static void ram_block_add(RAMBlock *new_block, Error **errp)
         } else {
             new_block->host = qemu_anon_ram_alloc(new_block->max_length,
                                                   &new_block->mr->align,
-                                                  shared, noreserve);
+                                                  shared, noreserve,
+                                                  new_block->mr->name);
+
             if (!new_block->host) {
                 g_autofree char *size_s = size_to_str(new_block->max_length);
                 error_setg_errno(errp, errno,
diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
index 52bb2ec6ced..e4d589fc950 100644
--- a/target/i386/kvm/tdx.c
+++ b/target/i386/kvm/tdx.c
@@ -354,7 +354,8 @@ static void tdx_finalize_vm(Notifier *notifier, void *unused)
         case TDVF_SECTION_TYPE_TD_HOB:
         case TDVF_SECTION_TYPE_TEMP_MEM:
             entry->mem_ptr = qemu_ram_mmap(-1, entry->size,
-                                           qemu_real_host_page_size(), 0, 0);
+                                           qemu_real_host_page_size(), 0, 0,
+                                           "tdx");
             if (entry->mem_ptr == MAP_FAILED) {
                 error_report("Failed to mmap memory for TDVF section %d",
                              entry->type);
diff --git a/util/mmap-alloc.c b/util/mmap-alloc.c
index 2133b2c9bda..f0b903dfdbe 100644
--- a/util/mmap-alloc.c
+++ b/util/mmap-alloc.c
@@ -187,7 +187,8 @@ static void *mmap_reserve(size_t size, int fd)
  * it accessible.
  */
 static void *mmap_activate(void *ptr, size_t size, int fd,
-                           uint32_t qemu_map_flags, off_t map_offset)
+                           uint32_t qemu_map_flags, off_t map_offset,
+                           const char *nickname)
 {
     const bool noreserve = qemu_map_flags & QEMU_MAP_NORESERVE;
     const bool readonly = qemu_map_flags & QEMU_MAP_READONLY;
@@ -236,6 +237,8 @@ static void *mmap_activate(void *ptr, size_t size, int fd,
          */
         activated_ptr = mmap(ptr, size, prot, flags, fd, map_offset);
     }
+
+    qemu_name_vma(ptr, size, "%s", nickname);
     return activated_ptr;
 }
 
@@ -253,7 +256,8 @@ void *qemu_ram_mmap(int fd,
                     size_t size,
                     size_t align,
                     uint32_t qemu_map_flags,
-                    off_t map_offset)
+                    off_t map_offset,
+                    const char *nickname)
 {
     const size_t guard_pagesize = mmap_guard_pagesize(fd);
     size_t offset, total;
@@ -277,7 +281,7 @@ void *qemu_ram_mmap(int fd,
     offset = QEMU_ALIGN_UP((uintptr_t)guardptr, align) - (uintptr_t)guardptr;
 
     ptr = mmap_activate(guardptr + offset, size, fd, qemu_map_flags,
-                        map_offset);
+                        map_offset, nickname);
     if (ptr == MAP_FAILED) {
         munmap(guardptr, total);
         return MAP_FAILED;
diff --git a/util/oslib-posix.c b/util/oslib-posix.c
index 454579c72df..ba3ebb52eb5 100644
--- a/util/oslib-posix.c
+++ b/util/oslib-posix.c
@@ -207,13 +207,13 @@ fail_close:
 
 /* alloc shared memory pages */
 void *qemu_anon_ram_alloc(size_t size, uint64_t *alignment, bool shared,
-                          bool noreserve)
+                          bool noreserve, const char *nickname)
 {
     const uint32_t qemu_map_flags = (shared ? QEMU_MAP_SHARED : 0) |
                                     (noreserve ? QEMU_MAP_NORESERVE : 0);
     size_t align = QEMU_VMALLOC_ALIGN;
 #ifndef EMSCRIPTEN
-    void *ptr = qemu_ram_mmap(-1, size, align, qemu_map_flags, 0);
+    void *ptr = qemu_ram_mmap(-1, size, align, qemu_map_flags, 0, nickname);
 
     if (ptr == MAP_FAILED) {
         return NULL;
diff --git a/util/oslib-win32.c b/util/oslib-win32.c
index 5f3e8f4d980..52c6335995c 100644
--- a/util/oslib-win32.c
+++ b/util/oslib-win32.c
@@ -45,7 +45,7 @@ static int get_allocation_granularity(void)
 }
 
 void *qemu_anon_ram_alloc(size_t size, uint64_t *align, bool shared,
-                          bool noreserve)
+                          bool noreserve, const char *nickname)
 {
     void *ptr;
 
-- 
2.56.1

