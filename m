Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A7ED3438BE
	for <kvm@vger.kernel.org>; Thu, 21 May 2026 14:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779375314; cv=none; b=FfnaMeJZ9HNFl2ru4dzGMD/O6t7iUarMQhyB9hR0e8mNEjGpTZuQmg2a/y1DcOtn0U85KoAKjGnpcqoNbbKEuuDBFV4vqP4EumZf8nedk3aiOsnK/UZX6RkMmP2niiSGemqyNvAhL/5ES1q08d2t/1Awp/KJQECK8KiLo//DV70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779375314; c=relaxed/simple;
	bh=JHmX46WMiCL4T7MILKB3MT1aTrQqhv5QNie47KLwDQg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=aI+YYuHzJ1QCScPyuslgRt3i88kmxeLaC5qObWG6A//bmIo6gsUQ3qkGg6BpMhtRAku1YSSeK6Ns6taLQ7hSBxbfb4P7gBtm2mNASfxb/FGjvAmXQTi3VCyn/plB/ODykf5RuzuGuAQrn0cwTLMNL8WPKAWb7h5FutstQIyt7pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UPLPjRWZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UPLPjRWZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779375311;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=KbVkSi2FA3zfV3b05kKADQgLFBaKkxPEvGcknU8X7sg=;
	b=UPLPjRWZNaisTbU+lpDwYJrfdLFBQmwyc054Cli++XUkamlg2Db6GauEZovhcdaycUFT6l
	qO16paeIroO1+p2q0r0qbHQiiixE5uLBzPJLhTBF4Ce+iSEpb4oDKnnaJc6KusieKyOZPs
	rtumLaxXfMrJPwopPhnam0B+r3sL+A8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-436-6EIFua6ZMxicfKq195Lx0A-1; Thu,
 21 May 2026 10:54:59 -0400
X-MC-Unique: 6EIFua6ZMxicfKq195Lx0A-1
X-Mimecast-MFC-AGG-ID: 6EIFua6ZMxicfKq195Lx0A_1779375297
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CA05319560B8;
	Thu, 21 May 2026 14:54:56 +0000 (UTC)
Received: from localhost (unknown [10.44.24.26])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0CFAA3002D2D;
	Thu, 21 May 2026 14:54:54 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Peter Xu <peterx@redhat.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
	Zhao Liu <zhao1.liu@intel.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	kvm@vger.kernel.org (open list:X86 KVM CPUs)
Subject: [PATCH] target/i386/sev: fix MemoryRegion reference leaks in gpa2hva callers
Date: Thu, 21 May 2026 18:54:51 +0400
Message-ID: <20260521145451.1831984-1-marcandre.lureau@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

From: Marc-André Lureau <marcandre.lureau@redhat.com>

gpa2hva() returns a referenced MemoryRegion via its p_mr out-parameter
(inherited from memory_region_find()), but both SEV callers were failing
to release it.

Fixes: c7f7e6970d3b ("sev: add sev-inject-launch-secret")
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 include/system/memory.h | 2 ++
 target/i386/sev.c       | 4 ++--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/system/memory.h b/include/system/memory.h
index 1417132f6d9..53f65a224bb 100644
--- a/include/system/memory.h
+++ b/include/system/memory.h
@@ -1343,6 +1343,8 @@ void memory_region_ref(MemoryRegion *mr);
  */
 void memory_region_unref(MemoryRegion *mr);
 
+G_DEFINE_AUTOPTR_CLEANUP_FUNC(MemoryRegion, memory_region_unref)
+
 /**
  * memory_region_init_io: Initialize an I/O memory region.
  *
diff --git a/target/i386/sev.c b/target/i386/sev.c
index b44b5a1c2b9..3ae922779d7 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -1573,7 +1573,7 @@ snp_populate_metadata_pages(SevSnpGuestState *sev_snp,
     OvmfSevMetadataDesc *desc;
     int type, ret, i;
     void *hva;
-    MemoryRegion *mr = NULL;
+    g_autoptr(MemoryRegion) mr = NULL;
 
     for (i = 0; i < metadata->num_desc; i++) {
         desc = &metadata->descs[i];
@@ -2067,7 +2067,7 @@ int sev_inject_launch_secret(const char *packet_hdr, const char *secret,
     int error, ret = 1;
     void *hva;
     gsize hdr_sz = 0, data_sz = 0;
-    MemoryRegion *mr = NULL;
+    g_autoptr(MemoryRegion) mr = NULL;
     SevCommonState *sev_common = SEV_COMMON(MACHINE(qdev_get_machine())->cgs);
 
     if (!sev_common) {
-- 
2.54.0

