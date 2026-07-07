Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63AB0314A65
	for <kvm@vger.kernel.org>; Tue,  7 Jul 2026 22:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783464212; cv=none; b=U+NXDrOb760Z7+fPpSqTSvF8FDZGjlGt4Qzq8Ia31ZjwCjW6FPwHYqJLaHt0RDp3+n5+enXKysUKCGwHOorUAdQERG2iTgziT/O8eZd4+bZOCbiUmiqDEYTyQw4wQ0I0Pk2OkUVtZCpuB/6EXJhbemctFZFGvAt19sfbiYjz/nA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783464212; c=relaxed/simple;
	bh=hBr3sufYHCJbturLkE6E23ofSi+Up7qe/Lqbr2VGs54=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O2dOYiGCG6MnrNssz9WryItagQ/LC22NLcoiW4dK441QnD5wOejWrmgC8rX+kRkCTgcKKNvmFjGGQRCIFw+6/glmxy6IRwLSk7xBvibj9D4PIK3mE3HAZAdtDc8Poub+liXNz7WYbiDSnGVpKo53TNMg0AwXk00RoasXXv4L4gU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Kv7t1L88; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Kv7t1L88"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2c9b1edf2bdso1109745ad.1
        for <kvm@vger.kernel.org>; Tue, 07 Jul 2026 15:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1783464211; x=1784069011; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0POncQiCikAc5guGwIPh9olnmP/V6mz621ilQVpgEaE=;
        b=Kv7t1L88HBlbj6hQeooHA0lxhQz4Y5OJirN3QgHLAR4ZftDfxFLw28fpUn/54BPN3j
         /wK0ND2M5F7ko8dC/+TdtWPqMgdzz9F/xswEi2vNLCByvW24wFQL1hrG/Xsg2UIVV5Ls
         UY8JMFRsV08+FFWjHsSXtVcKeWV47bTC+vRAmRsyDTWfqiwYRzMfb9T316F4rYIquTrl
         Y0NkeLdxTX3G1//OzFHsjGrWmtzl0LGqWBa37ikiRtjMeFixOhSKR637m9uKErBDY5e9
         nXkauVT6GaiDn0GQGPw/PAc8YhDQ3qzDYz0chqToDp4X5h1h04+tNL6IuDC8oEMwJID/
         HyAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783464211; x=1784069011;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0POncQiCikAc5guGwIPh9olnmP/V6mz621ilQVpgEaE=;
        b=jwsl3o9z2NWCX9UwI9nF9XcmtAuvqRA2G/BXEHB/JKhb/Db/q/3G5scW9sBcTLafDQ
         s9SCmTdHMwkgpD3BVvw/3YRqSuhCB7CnjKXfHgXoHP9Fl4KQj9j+gSoxxhC6F19GhBiw
         sZcYVjv7RukIeLS/JPOjdjHzHTXKRg5DVda9SO59l4k5SjSVycj1s+4B+V3xkUsOkjHf
         CDn4Z6XJ79SfQvVk6GlJQKda4iU2qcdQ0HdCsM4BrrC2wOHrujYx/KJWL2VrzAPUc3rs
         q/714VnnJgpiCij66cnH5KiIDN6CB87lo2KVIVzwInPAaIn/ce/Wmpjn1ZkB6gMT5C5j
         y5JA==
X-Forwarded-Encrypted: i=1; AHgh+Rpwb4ZNg+VGHFudZIiO4fZL3XxFUBBIFYhpMzODwhTP3uogzn0vjeJjl8PeA5GI9BS2SL8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxi10xVf24wrcHDxMNanI9+BV8qtygSEf3BwttpCn5c3AScJqGK
	uCbljhwwf/ryA2+/iU9up20ewsppkMpXUawrTOXAJIbER8AGtpWP+nxt5QrxN97nzuE=
X-Gm-Gg: AfdE7cl7ggqmXJ1oNcYktwHi6PNdgD0VO9wNX3aDxe7fQfDyf0SQIuNnAL7/aFn+eXR
	7VHqxaZFyhxakhEh183R8cc4U+/UuwrAO5+b8xYToD3aVrmFFJrvm8OS5YQxso6S682Pvchf1jS
	Fvo8FSL6wfvbsaRDLZNrCysgdnSiPSfuKSjDJxPzIlvIMR1CrOjRmppxp/BVKXQMJHpO5dUapRM
	EJE9CeOGCbOH8d9svgMDOzcDL7LrNjnW3pwaN7rx5bijqRKn1IP4v8TQiDuw9YFjOZR4KMWyOCg
	keYshOwQsVcaNw3yZLDcVFua6FE+8HFZA3c3EMVvJdjJCAK5UL63dlRB02UEWYib57hOP5iNtmO
	r9yLTtLbvt1LGv92vbn91WgrVCGWEQEwyXQLtY8Ie4Wy9bbUn1b6I/bvdlTG0ZAscT/HseRymCA
	IbITbSVI0xxV5/Ld3K8EzqM7mS9jf2HgdkqzGUcEA=
X-Received: by 2002:a17:903:1b25:b0:2cc:9e99:55c9 with SMTP id d9443c01a7336-2ccbf07a111mr68428465ad.26.1783464210619;
        Tue, 07 Jul 2026 15:43:30 -0700 (PDT)
Received: from p14s.cg.shawcable.net ([2604:3d09:148c:c800:46c8:dda7:40fa:8958])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9d3bbaesm18183805ad.57.2026.07.07.15.43.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 15:43:30 -0700 (PDT)
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: berrange@redhat.com,
	kchamart@redhat.com,
	pierrick.bouvier@oss.qualcomm.com,
	peter.maydell@linaro.org,
	mst@redhat.com,
	cohuck@redhat.com,
	pbonzini@redhat.com,
	eblake@redhat.com,
	armbru@redhat.com,
	jpb@kernel.org,
	lorenzo.pieralisi@linaro.org
Cc: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	kvm@vger.kernel.org
Subject: [RFC v1 10/25] hw/core/loader: Add a ROM loader notifier
Date: Tue,  7 Jul 2026 16:42:51 -0600
Message-ID: <20260707224306.1202330-11-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260707224306.1202330-1-mathieu.poirier@linaro.org>
References: <20260707224306.1202330-1-mathieu.poirier@linaro.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jean-Philippe Brucker <jean-philippe@linaro.org>

Add a function to register a notifier that is invoked when ROMs get
loaded into guest memory.

It will be used by Arm confidential guest support, in order to register
all blobs loaded into memory with KVM, so that their content is moved
into Realm state and measured into the initial VM state.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 hw/core/loader.c         | 15 +++++++++++++++
 include/hw/core/loader.h | 17 +++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/hw/core/loader.c b/hw/core/loader.c
index 5cbfba0a86d2..b3d769bec5cb 100644
--- a/hw/core/loader.c
+++ b/hw/core/loader.c
@@ -74,6 +74,8 @@
 #endif
 
 static int roms_loaded;
+static NotifierList rom_loader_notifier =
+    NOTIFIER_LIST_INITIALIZER(rom_loader_notifier);
 
 /* return the size or -1 if error */
 int64_t get_image_size(const char *filename, Error **errp)
@@ -1201,6 +1203,11 @@ MemoryRegion *rom_add_blob(const char *name, const void *blob, size_t len,
     return mr;
 }
 
+void rom_add_load_notifier(Notifier *notifier)
+{
+    notifier_list_add(&rom_loader_notifier, notifier);
+}
+
 /* This function is specific for elf program because we don't need to allocate
  * all the rom. We just allocate the first part and the rest is just zeros. This
  * is why romsize and datasize are different. Also, this function takes its own
@@ -1242,6 +1249,7 @@ ssize_t rom_add_option(const char *file, int32_t bootindex)
 static void rom_reset(void *unused)
 {
     Rom *rom;
+    RomLoaderNotifyData notify;
 
     QTAILQ_FOREACH(rom, &roms, next) {
         if (rom->fw_file) {
@@ -1290,6 +1298,13 @@ static void rom_reset(void *unused)
         address_space_flush_icache_range(rom->as, rom->addr, rom->datasize);
 
         trace_loader_write_rom(rom->name, rom->addr, rom->datasize, rom->isrom);
+
+        notify = (RomLoaderNotifyData) {
+            .addr = rom->addr,
+            .len = rom->datasize,
+            .as = rom->as,
+        };
+        notifier_list_notify(&rom_loader_notifier, &notify);
     }
 }
 
diff --git a/include/hw/core/loader.h b/include/hw/core/loader.h
index d9431e8a8d12..94cf6ad2e26b 100644
--- a/include/hw/core/loader.h
+++ b/include/hw/core/loader.h
@@ -342,6 +342,23 @@ void *rom_ptr_for_as(AddressSpace *as, hwaddr addr, size_t size);
 ssize_t rom_add_vga(const char *file);
 ssize_t rom_add_option(const char *file, int32_t bootindex);
 
+typedef struct RomLoaderNotifyData {
+    /* Address of the blob in guest memory */
+    hwaddr addr;
+    /* Length of the blob */
+    size_t len;
+    /* Address space of the blob */
+    AddressSpace *as;
+} RomLoaderNotifyData;
+
+/**
+ * rom_add_load_notifier - Add a notifier for loaded images
+ *
+ * Add a notifier that will be invoked with a RomLoaderNotifyData structure for
+ * each blob loaded into guest memory, after the blob is loaded.
+ */
+void rom_add_load_notifier(Notifier *notifier);
+
 /* This is the usual maximum in uboot, so if a uImage overflows this, it would
  * overflow on real hardware too. */
 #define UBOOT_MAX_DECOMPRESSED_BYTES (64 << 20)
-- 
2.43.0

