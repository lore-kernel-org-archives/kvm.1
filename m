Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74042472F91
	for <kvm@vger.kernel.org>; Tue, 28 Jul 2026 19:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785266818; cv=none; b=OIOJVb22roZvSoymHQ1S4rxPUVKZyIS9pQrQjsCmkuTZesyn0RaiWTfdG7l8PI4kT611Xx4oA/t4XJg8ulLDEqR+CIgI6LGP1Bd1A5YT4P23lUrN191bJlmYb7ieAoBv7OwKdO1Q9I/sbfLc/qDJgStldWInb+VqkaMLK3ht08s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785266818; c=relaxed/simple;
	bh=hBr3sufYHCJbturLkE6E23ofSi+Up7qe/Lqbr2VGs54=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bhqzEFubqYFIwjFh8odZzDHaI3+6McdCJQtAH2JqqAcgAQps/5ZaXFcN5F/4/PGVmwBWH3XS22TBQYa+5t2K+ysEOyVk2OBfoDQFN0dFEMJs4lF7QY/HKUdbX6RBA4D8H9EtJw89oP+AuRelwHbs4u2puxtO7CUJ13Dtpc7S5MA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dVK4rEzw; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dVK4rEzw"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2cf452def93so12061245ad.1
        for <kvm@vger.kernel.org>; Tue, 28 Jul 2026 12:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1785266813; x=1785871613; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0POncQiCikAc5guGwIPh9olnmP/V6mz621ilQVpgEaE=;
        b=dVK4rEzwnHQ6ssf1geOo8WAhW2W9IdPTe6ih3SKanDKwNLZMjfYpZXVp8oeY0vUlXB
         8OGeca2f71rpimby4xUMPj6P8QWV5fm3jVEmbwWTF7r/FckAX9RcrhIxy97PiUQ4mEEf
         1SoopFDIXWrq6+QqRKZVZqFYK+yA2i6gG0PQd2rzeu4qDxbXu6tXhH+9haZFfQBu+ytg
         01wgh/yS08/ruxhpfLUVznhZCS8TA7gap9UbDkGY5MZ8R/r9l/Mh7yg6QKO8svu0CJnd
         31dSVeW8jbhy/Zmnb4MI1VCw+uKzjFC8KkKmFjzIo+8QDj75/1baG87PO//PP8lHBPZZ
         XueA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785266813; x=1785871613;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0POncQiCikAc5guGwIPh9olnmP/V6mz621ilQVpgEaE=;
        b=Fc4wF4d0ApFbSnxo4liCj3qwfpQcJxxAhfWA1q8enIo+KSLHo9krrvlWyRDzNGT1gT
         awgoC8I+02fRmFVfFlzjDKVuiFTLxTenWoEQLcN1gfdildQNWruB5MJss9+ek/q6ddIO
         bamtXzsf0OeATAkTfFTzXqIJ7yc2TSH0pao57Ew7S94ghFbmpBB3dKJY0xHuXx1F5bL1
         2aPDfxeAnIWwFmt6Mh3+mYX32cYsqAloyY5VuVGcd8RG7uOn1koHYZr9X3bHf7A+TAzg
         XwV6Q+m9ZxkSBE0SVLHip8rUzhMIyNdsLA/hNx4VkAxEPkcMOU56EReyGwLmqoTxTDMj
         hV7A==
X-Forwarded-Encrypted: i=1; AHgh+Rrt87w6p6StRlTVn1Rx6NpMm3nBzoz0tZ/jSGKJpdpQRD1AX7M9SmXy+e+9xhy/0fkp3G0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuMN2vtSTLd7Z+pUBd6Ia8xHrW41LxGqNo9hAEXGQGARrykDwY
	nRl3LmF0AtiZW/QH76RS4d+BVMgXsaiEHVXR5i62jlTMpPZKNGeF/29T1+/yq0Ohcps=
X-Gm-Gg: AR+sD11e5doqeSoa1CLSkM7ffilU/hypRWxj9AqOZvKF8XkgI2MdmaQDu82QqHNIpm8
	ZCCSLpiJGhoR0na8Xp53g3WvcDmGgAQlPgPtPvEGuGV0JmtHcizLXBxxpGsdoLbvfgj1smz5/5Z
	JZps1TgVnzXY3QUBc5nyxSuVl7bJwkvNJWD15OGrUQuvZmIOVK//31QGAo4Hs3VEO7AA9/ckNyV
	bpdgBjmzIY5RoIbtf79Y9pS2q3q40XPzSt5+bwpleqeA4R5JqqdD0e8rPtdcmchmrvVq5QzHH1m
	Az3F1jQ1wBaSlA3p0k/x+R6XZJNiJroi481+NOaguE+oAyEBAMietW4bXnnfehjoQcsgyaHwUo/
	p0cYGa6zuTe8mbfNzqxHukfuBlObTCwfSw8YVeHyJdM8DlnEsQqZ8d5qrdYXKVZu7stCcmhbwD4
	VzPBVmfDvyVnnlGykALHvXrm9JgHs11GyS7wDCU2o=
X-Received: by 2002:a17:90b:1b05:b0:384:927f:3db9 with SMTP id 98e67ed59e1d1-38f6a2069fbmr3543414a91.1.1785266813372;
        Tue, 28 Jul 2026 12:26:53 -0700 (PDT)
Received: from p14s.cg.shawcable.net ([2604:3d09:148c:c800:b9d1:87c9:a085:86c9])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f7f1353fdsm372650a91.8.2026.07.28.12.26.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 12:26:52 -0700 (PDT)
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
	lorenzo.pieralisi@linaro.org,
	gshan@redhat.com
Cc: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	kvm@vger.kernel.org
Subject: [RFC v2 09/24] hw/core/loader: Add a ROM loader notifier
Date: Tue, 28 Jul 2026 13:26:15 -0600
Message-ID: <20260728192630.240375-10-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260728192630.240375-1-mathieu.poirier@linaro.org>
References: <20260728192630.240375-1-mathieu.poirier@linaro.org>
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

