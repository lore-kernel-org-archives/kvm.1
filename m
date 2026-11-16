Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794847858;
	b=cki22/ANuvhpaM+qv7JwMGJ7u8XuJh71WU/FMbiI/nIH8/+OBFazkolfv2sG6ChtTcUo
	 rDWsp5QJekxYBxPnyMeT3Jo2odyJptLAai61EG1eMGqLNMVCHGc/Mkk+8Kr9ZyHBB2Tmj
	 ytv6g1e/cviq/TTLQGV4Q+VY/t/pOTjUQPnrK82ROHn+7vUn3hnRMZvBbFIpTbi61mhqU
	 seybkhKyGTsktrCqT5p/jJMB1oXu+zozLpYjIYw7g4PuZkXi3tL9Cpfwtpn8m0rfpkYim
	 x0PpiYUY0rjL6OjWExp7eBv6d0syobx+tgzOCxhUTdKr00qb+QnN917X6CjCwJ3PGZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794847858;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Scanned-By;
	bh=Jp0mGo3e+aoHROpQxWmlVJQlrDv/FWEXONRrD+RSbRk=;
	b=GMvKCFRpd3/CtGBdlKBieREVCjWurHyLoTDjm9IV1u+x47FigDKSVHYaN5ZDj9zOYdLx
	 oBQbFMwJutU8GJIHKn3alS3i0ATsoBDSoNbf2q7f9cEIg1Rpc+zmgjsYxHwtWjm37Cq2M
	 gAQtY6dtajPhXKNDOtTBh66uyCx/K9q2URK1WqfVCW9z+Aggf7IoYWrMMHgc80dRyxYGv
	 y+2J351MV7TudE1DK0QYQ2XPTS4ahl3XyBqRcoJclaVzreHghHLWnKkObyYxfyrkMt7O4
	 EGsGuila6Tt3iiMQNnMv/SHceWy4vljzn1rMxB/EKKhHabhytwJsrwcCtbVdomy4mjg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=DfpBCFhW;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C313606A31C
	for <kvm@vger.kernel.org>; Mon, 16 Nov 2026 16:50:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0C313606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=DfpBCFhW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794847856;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Jp0mGo3e+aoHROpQxWmlVJQlrDv/FWEXONRrD+RSbRk=;
	b=DfpBCFhWTlK0KbrW1pemVxsTRIITwCJbharE74+DjuHGYVqlpac66pQqBjq8yVr3+INegT
	i1kHLDzq8TNsjzYuuUORb+W8fa9jfNskPB49lt2XbPyScK6MTxt2BWqxEKO1URgxKxwVXG
	HjN4dtDREy6XLLMeRZ8TT9eyC2+9ICw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-620-Xt4MFfkuMampiktxB2dtPg-1; Mon,
 16 Nov 2026 11:50:50 -0500
X-MC-Unique: Xt4MFfkuMampiktxB2dtPg-1
X-Mimecast-MFC-AGG-ID: Xt4MFfkuMampiktxB2dtPg_1794847838
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EE0C1195604C;
	Mon, 16 Nov 2026 16:50:37 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A4884195B3C7;
	Mon, 16 Nov 2026 16:50:34 +0000 (UTC)
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
Subject: [PATCH v2 7/7] debug/mem: HACK add qemu_name_buffer
Date: Mon, 16 Nov 2026 11:50:02 -0500
Message-ID: <20261116165002.30939-8-jsnow@redhat.com>
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
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

This is a hack to allow us to name malloc'd buffers that are backed by
anonymous mmap allocations.

Quite useful in my debugging, probably not quite appropriate for
upstream unless we can figure out a more robust method for identifying
when we get an mmap'd page from malloc and adjusting the pointer
offset accordingly - I am currently subtracting a fixed 16 bytes
because that "works on my system", and I have no clue if that's
appropriate everywhere or not.

At least this way, my trick is published to the list for posterity.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 include/qemu/bitmap.h   |  6 ++++++
 include/qemu/mmap-vma.h |  3 +++
 hw/core/loader.c        |  3 +++
 hw/i386/x86-common.c    |  3 +++
 system/device_tree.c    |  2 ++
 system/physmem.c        |  8 ++++++--
 util/mmap-vma.c         | 23 +++++++++++++++++++++++
 7 files changed, 46 insertions(+), 2 deletions(-)

diff --git a/include/qemu/bitmap.h b/include/qemu/bitmap.h
index 0044333cb51..6681c87737f 100644
--- a/include/qemu/bitmap.h
+++ b/include/qemu/bitmap.h
@@ -104,6 +104,12 @@ static inline unsigned long *bitmap_try_new(long nbits)
     return g_try_new0(unsigned long, nelem);
 }
 
+static inline size_t bitmap_size(long nbits)
+{
+    long nelem = BITS_TO_LONGS(nbits);
+    return sizeof(unsigned long) * nelem;
+}
+
 static inline unsigned long *bitmap_new(long nbits)
 {
     long nelem = BITS_TO_LONGS(nbits);
diff --git a/include/qemu/mmap-vma.h b/include/qemu/mmap-vma.h
index 763ea5a5cab..4646657022c 100644
--- a/include/qemu/mmap-vma.h
+++ b/include/qemu/mmap-vma.h
@@ -15,4 +15,7 @@
 int qemu_name_vma(void *ptr, size_t sz, const char *fmt, ...)
     G_GNUC_PRINTF(3, 4);
 
+int qemu_name_buffer(void *ptr, size_t sz, const char *fmt, ...)
+    G_GNUC_PRINTF(3, 4);
+
 #endif
diff --git a/hw/core/loader.c b/hw/core/loader.c
index 5cbfba0a86d..cc0e0d6979a 100644
--- a/hw/core/loader.c
+++ b/hw/core/loader.c
@@ -45,6 +45,7 @@
 #include "qemu/osdep.h"
 #include "qemu/datadir.h"
 #include "qemu/error-report.h"
+#include "qemu/mmap-vma.h"
 #include "qapi/error.h"
 #include "qapi/qapi-commands-machine.h"
 #include "qapi/type-helpers.h"
@@ -1111,6 +1112,8 @@ ssize_t rom_add_file(const char *file, const char *fw_dir,
         goto err;
     }
 
+    qemu_name_buffer(rom->data, size, "%s", file);
+
     if (fw_dir) {
         rom->fw_dir  = g_strdup(fw_dir);
         rom->fw_file = g_strdup(file);
diff --git a/hw/i386/x86-common.c b/hw/i386/x86-common.c
index dcd4fa8eb79..608c4cf4202 100644
--- a/hw/i386/x86-common.c
+++ b/hw/i386/x86-common.c
@@ -25,6 +25,7 @@
 #include "qemu/cutils.h"
 #include "qemu/units.h"
 #include "qemu/datadir.h"
+#include "qemu/mmap-vma.h"
 #include "qapi/error.h"
 #include "system/numa.h"
 #include "system/system.h"
@@ -914,6 +915,8 @@ void x86_load_linux(X86MachineState *x86ms,
 
     setup  = g_malloc(setup_size);
     kernel = g_malloc(kernel_size);
+    qemu_name_buffer(kernel, kernel_size, "%s", kernel_filename);
+
     fseek(f, 0, SEEK_SET);
     if (fread(setup, 1, setup_size, f) != setup_size) {
         fprintf(stderr, "fread() failed\n");
diff --git a/system/device_tree.c b/system/device_tree.c
index 48365435ea0..816874fb299 100644
--- a/system/device_tree.c
+++ b/system/device_tree.c
@@ -27,6 +27,7 @@
 #include "hw/core/loader.h"
 #include "hw/core/boards.h"
 #include "qemu/config-file.h"
+#include "qemu/mmap-vma.h"
 #include "qapi/qapi-commands-machine.h"
 #include "qobject/qdict.h"
 
@@ -41,6 +42,7 @@ void *create_device_tree(int *sizep)
 
     *sizep = FDT_MAX_SIZE;
     fdt = g_malloc0(FDT_MAX_SIZE);
+    qemu_name_buffer(fdt, FDT_MAX_SIZE, "device_tree");
     ret = fdt_create(fdt, FDT_MAX_SIZE);
     if (ret < 0) {
         goto fail;
diff --git a/system/physmem.c b/system/physmem.c
index 202e3a5cd00..dc0e9540919 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -26,6 +26,7 @@
 #include "qemu/hbitmap.h"
 #include "qemu/madvise.h"
 #include "qemu/lockable.h"
+#include "qemu/mmap-vma.h"
 
 #ifdef CONFIG_TCG
 #include "accel/tcg/cpu-ops.h"
@@ -2105,7 +2106,7 @@ void qemu_ram_msync(RAMBlock *block, ram_addr_t start, ram_addr_t length)
 }
 
 /* Called with ram_list.mutex held */
-static void dirty_memory_extend(ram_addr_t new_ram_size)
+static void dirty_memory_extend(ram_addr_t new_ram_size, const char *nickname)
 {
     unsigned int old_num_blocks = ram_list.num_dirty_blocks;
     unsigned int new_num_blocks = DIV_ROUND_UP(new_ram_size,
@@ -2133,6 +2134,9 @@ static void dirty_memory_extend(ram_addr_t new_ram_size)
 
         for (j = old_num_blocks; j < new_num_blocks; j++) {
             new_blocks->blocks[j] = bitmap_new(DIRTY_MEMORY_BLOCK_SIZE);
+            qemu_name_buffer(new_blocks->blocks[j],
+                             bitmap_size(DIRTY_MEMORY_BLOCK_SIZE),
+                             "bitmap<%s>", nickname);
         }
 
         qatomic_rcu_set(&ram_list.dirty_memory[i], new_blocks);
@@ -2254,7 +2258,7 @@ static void ram_block_add(RAMBlock *new_block, Error **errp)
     }
 
     ram_size = (new_block->offset + new_block->max_length) >> TARGET_PAGE_BITS;
-    dirty_memory_extend(ram_size);
+    dirty_memory_extend(ram_size, new_block->mr->name);
     /* Keep the list sorted from biggest to smallest block.  Unlike QTAILQ,
      * QLIST (which has an RCU-friendly variant) does not have insertion at
      * tail, so save the last element in last_block.
diff --git a/util/mmap-vma.c b/util/mmap-vma.c
index 46ea98f1134..083400a9c2e 100644
--- a/util/mmap-vma.c
+++ b/util/mmap-vma.c
@@ -73,3 +73,26 @@ int qemu_name_vma(void *ptr, size_t sz, const char *fmt, ...)
 
     return rc;
 }
+
+G_GNUC_PRINTF(3, 4)
+int qemu_name_buffer(void *ptr, size_t sz, const char *fmt, ...)
+{
+    /*
+     * this is hacky as hell, but ptmalloc will occasionally use
+     * mmap() for large buffers - when it does so, you get a pointer
+     * to 16 bytes after the actual mmap. This function compensates
+     * for that to guess at what the real mmap allocation was.
+     *
+     * This can be used unconditionally whether or not the allocation
+     * was actually mmap'd - if it wasn't, this just fails. Yes, it's
+     * still very ugly.
+     */
+    va_list args;
+    size_t pagesz = qemu_real_host_page_size();
+
+    ptr = ptr - 0x10;
+    sz = ROUND_UP(sz + 0x10, pagesz);
+
+    va_start(args, fmt);
+    return qemu_vname_vma(ptr, sz, fmt, args);
+}
-- 
2.56.1

