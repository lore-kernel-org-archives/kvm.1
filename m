Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9253D47DF80
	for <kvm@vger.kernel.org>; Thu,  4 Jun 2026 13:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780580743; cv=none; b=YT0+nP4xBhbR5VVowaWEHqHrA/owlx7xKmhibEeXmOks/ZjMlqHl0M0ljpJb4X1TGi2ik41xg0RKoJtF+5rvFQ8oWrogZAEfIzdr12fOKkRBBB2XavV9UAwvMLmlHwA8eSp15tNK9RmloDIvtGdsdnJt6YHrIskCCxfyS9tZwng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780580743; c=relaxed/simple;
	bh=BfzRj9+PxZBuWnruTJpFaGdqesXc0dlzBlWko+GiOlg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KcAY/eiyoOlqGPKxjdNiVFiBNvVJFSf/r2AUvZIMxQsrB510ccg6/drH+Q5QA79GNy1CZoAu6EMKrcyHT+6JtOfDcedmPeY4v0PsNnPQixJBfSaJGRQgdummPIxAbho/a+8RXNrhlW/tAwnXRmk0wH6NGqVsyepgf+LaMA+8leg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N6iI3Yil; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N6iI3Yil"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780580740;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3CqFxIqjMMdGXqKKnL+tbt++sUy9MTe8z+qAn52XsHg=;
	b=N6iI3YilToHLvlQKw0ov3xIMezIv1/jdI8FwjStFirN0TDad5QQ3E8Cf8ftvIBu19uKHX5
	VCWkBYYlXgR2/jA33s/+xKr6DPsprXU4Up8b/wW48yngSB36AOPjMCvSDndVod6ZAPqVz2
	mubzWRtiG6tRj/jCs5aINTr2DBvIJf8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-655-hIXEbtZ2Oea0dXoPKwf-Ow-1; Thu,
 04 Jun 2026 09:45:36 -0400
X-MC-Unique: hIXEbtZ2Oea0dXoPKwf-Ow-1
X-Mimecast-MFC-AGG-ID: hIXEbtZ2Oea0dXoPKwf-Ow_1780580734
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 58F601956089;
	Thu,  4 Jun 2026 13:45:34 +0000 (UTC)
Received: from localhost (unknown [10.44.24.6])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id AB63E1955BC0;
	Thu,  4 Jun 2026 13:45:32 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 04 Jun 2026 17:43:57 +0400
Subject: [PATCH v5 11/12] system/physmem: make ram_block_discard_range()
 handle guest_memfd
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260604-rdm5-v5-11-5768e6a0943d@redhat.com>
References: <20260604-rdm5-v5-0-5768e6a0943d@redhat.com>
In-Reply-To: <20260604-rdm5-v5-0-5768e6a0943d@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhenzhong Duan <zhenzhong.duan@intel.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, David Hildenbrand <david@kernel.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 qemu-rust@nongnu.org, Alex Williamson <alex@shazbot.org>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>, 
 Fabiano Rosas <farosas@suse.de>, Mark Kanda <mark.kanda@oracle.com>, 
 Ben Chaney <bchaney@akamai.com>, Marcelo Tosatti <mtosatti@redhat.com>, 
 kvm@vger.kernel.org, "Dr. David Alan Gilbert" <dave@treblig.org>, 
 Zhao Liu <zhao1.liu@intel.com>, Eric Blake <eblake@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, Xiaoyao Li <xiaoyao.li@intel.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=6549;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=BfzRj9+PxZBuWnruTJpFaGdqesXc0dlzBlWko+GiOlg=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqIYEyCdxsURB1AYlGa1B17jLxB6W6D7m5G2RE6
 ymjLAOxw0GJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaiGBMgAKCRDa6OEJdZac
 5YorD/90sr8de39/rv34Sc0bwAgHrajghrQW4um+atQdLhevyScbCk2Py7uBuN+8Q0DTwHaAIUp
 Nw8xKH6ECa8QVvDckPABb3h2R28R+Rze6X9UjJaHervUzFnq42+14pGBYANu0FoJ58Wn4CZaWAN
 cdoypI9gjaVmL+mCIDnigSCE16CncY4t21VUoo+5GP0BKA3KMZGdy5f0ZdNbkFBUbdfkbEqEQWG
 K89z9z2wdPQz++ikpN+Mhxw9MaVPrntmEYCFgxUGeBdx0Pfo0IPLecLUzGBQdZUNHcFlxG5Vxuj
 1kxDFITQSCgBGy5z6WfAgPsIt1SwRtloKxzBty/k0VQYLbpv5QXziDziqe1rek1QMyuXeHOFq/C
 YSGsTOOXh7/EiKigMWc7IzOdbeCzvHION07ftzeO7KQVXwSbYPKm4VNf9RUPA0kFYOMpHv3c9Gi
 UwoE65+qVYF8idk0iUTUxZBGySLpxX8wcIude6+Svu11qh9j6xcdvyBrjLNb6KYu8rdkC6mNEmD
 MBH7MPtT4uzBhZ412faz4qX+y/wmsLP6RD/pu4XzbLYlJE+auZTEqPkX2umeCzjCkNN57DIsuOd
 XKUs9YLkAdZIkGZGSJuiwXmxs6W0aHsa8F+qc7b/KL27Y1u+LAfQE6Gxj81rQZy9TAWIpQRhqac
 JPteGbOCY/PZV8A==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Most callers of ram_block_discard_range() want to discard both the
shared and guest_memfd backing. Only kvm_convert_memory() intentionally
discards a single plane during private/shared conversions.

Rename the current implementation to ram_block_discard_shared_range()
and make ram_block_discard_range() a composite that also discards
guest_memfd when present (rb->guest_memfd >= 0). This ensures callers
like virtio-mem, virtio-balloon, hv-balloon, migration.. reclaim
private pages on discard.

Update kvm_convert_memory() to use the plane-specific
ram_block_discard_shared_range() since it only needs to discard
the shared backing when converting to private.

Likewise, after TDVF image copy, use ram_block_discard_shared_range().

Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 include/system/ramblock.h |  3 ++-
 accel/kvm/kvm-all.c       |  2 +-
 system/physmem.c          | 25 +++++++++++++++++++++----
 target/i386/kvm/tdx.c     |  2 +-
 system/trace-events       |  2 +-
 5 files changed, 26 insertions(+), 8 deletions(-)

diff --git a/include/system/ramblock.h b/include/system/ramblock.h
index 2b38718fe5f..f0639287bf0 100644
--- a/include/system/ramblock.h
+++ b/include/system/ramblock.h
@@ -103,7 +103,8 @@ struct RamBlockAttributes {
 
 /* @offset: the offset within the RAMBlock */
 int ram_block_discard_range(RAMBlock *rb, uint64_t offset, size_t length);
-/* @offset: the offset within the RAMBlock */
+int ram_block_discard_shared_range(RAMBlock *rb, uint64_t offset,
+                                   size_t length);
 int ram_block_discard_guest_memfd_range(RAMBlock *rb, uint64_t offset,
                                         size_t length);
 
diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 96f90ebb240..dcfb99cdf74 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -3426,7 +3426,7 @@ int kvm_convert_memory(hwaddr start, hwaddr size, bool to_private)
              */
             goto out_unref;
         }
-        ret = ram_block_discard_range(rb, offset, size);
+        ret = ram_block_discard_shared_range(rb, offset, size);
     } else {
         ret = ram_block_discard_guest_memfd_range(rb, offset, size);
     }
diff --git a/system/physmem.c b/system/physmem.c
index ddb67ba2359..0ff80a74917 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -4095,7 +4095,7 @@ int qemu_ram_foreach_block(RAMBlockIterFunc func, void *opaque)
  * Returns: 0 on success, none-0 on failure
  *
  */
-int ram_block_discard_range(RAMBlock *rb, uint64_t offset, size_t length)
+int ram_block_discard_shared_range(RAMBlock *rb, uint64_t offset, size_t length)
 {
     int ret = -1;
 
@@ -4144,7 +4144,7 @@ int ram_block_discard_range(RAMBlock *rb, uint64_t offset, size_t length)
              * have a MAP_PRIVATE mapping, possibly messing with other
              * MAP_PRIVATE/MAP_SHARED mappings. There is no easy way to
              * change that behavior whithout violating the promised
-             * semantics of ram_block_discard_range().
+             * semantics of ram_block_discard_shared_range().
              *
              * Only warn, because it works as long as nobody else uses that
              * file.
@@ -4200,8 +4200,9 @@ int ram_block_discard_range(RAMBlock *rb, uint64_t offset, size_t length)
             goto err;
 #endif
         }
-        trace_ram_block_discard_range(rb->idstr, host_startaddr, length,
-                                      need_madvise, need_fallocate, ret);
+        trace_ram_block_discard_shared_range(rb->idstr, host_startaddr, length,
+                                             need_madvise, need_fallocate,
+                                             ret);
     } else {
         error_report("%s: Overrun block '%s' (%" PRIu64 "/%zx/" RAM_ADDR_FMT")",
                      __func__, rb->idstr, offset, length, rb->max_length);
@@ -4211,6 +4212,22 @@ err:
     return ret;
 }
 
+int ram_block_discard_range(RAMBlock *rb, uint64_t offset, size_t length)
+{
+    int ret;
+
+    ret = ram_block_discard_shared_range(rb, offset, length);
+    if (ret) {
+        return ret;
+    }
+
+    if (rb->guest_memfd >= 0) {
+        ret = ram_block_discard_guest_memfd_range(rb, offset, length);
+    }
+
+    return ret;
+}
+
 int ram_block_discard_guest_memfd_range(RAMBlock *rb, uint64_t offset,
                                         size_t length)
 {
diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
index 4714c9d514e..fcb11aa67e4 100644
--- a/target/i386/kvm/tdx.c
+++ b/target/i386/kvm/tdx.c
@@ -385,7 +385,7 @@ static void tdx_finalize_vm(Notifier *notifier, void *unused)
      * KVM_MEMORY_MAPPING. It becomes useless.
      */
     ram_block = tdx_guest->tdvf_mr->ram_block;
-    ram_block_discard_range(ram_block, 0, ram_block->max_length);
+    ram_block_discard_shared_range(ram_block, 0, ram_block->max_length);
 
     tdx_vm_ioctl(KVM_TDX_FINALIZE_VM, 0, NULL, &error_fatal);
     CONFIDENTIAL_GUEST_SUPPORT(tdx_guest)->ready = true;
diff --git a/system/trace-events b/system/trace-events
index e6e1b612798..51b4a4679a2 100644
--- a/system/trace-events
+++ b/system/trace-events
@@ -32,7 +32,7 @@ global_dirty_changed(unsigned int bitmask) "bitmask 0x%"PRIx32
 address_space_map(void *as, uint64_t addr, uint64_t len, bool is_write, uint32_t attrs) "as:%p addr 0x%"PRIx64":%"PRIx64" write:%d attrs:0x%x"
 find_ram_offset(uint64_t size, uint64_t offset) "size: 0x%" PRIx64 " @ 0x%" PRIx64
 find_ram_offset_loop(uint64_t size, uint64_t candidate, uint64_t offset, uint64_t next, uint64_t mingap) "trying size: 0x%" PRIx64 " @ 0x%" PRIx64 ", offset: 0x%" PRIx64" next: 0x%" PRIx64 " mingap: 0x%" PRIx64
-ram_block_discard_range(const char *rbname, void *hva, size_t length, bool need_madvise, bool need_fallocate, int ret) "%s@%p + 0x%zx: madvise: %d fallocate: %d ret: %d"
+ram_block_discard_shared_range(const char *rbname, void *hva, size_t length, bool need_madvise, bool need_fallocate, int ret) "%s@%p + 0x%zx: madvise: %d fallocate: %d ret: %d"
 qemu_ram_alloc_shared(const char *name, size_t size, size_t max_size, int fd, void *host) "%s size %zu max_size %zu fd %d host %p"
 
 subpage_register(void *subpage, uint32_t start, uint32_t end, int idx, int eidx, uint16_t section) "subpage %p start 0x%08x end 0x%08x idx 0x%08x eidx 0x%08x section %u"

-- 
2.54.0

