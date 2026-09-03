Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1395F50EBF5
	for <kvm@vger.kernel.org>; Thu,  3 Sep 2026 19:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788464219; cv=none; b=bxSQ2Gv8NlzH7ECWJEUVIWRNVzd8HsKEKS1lO6U27/nOlVIcmP+wNJ5zULogNK3KVUx5A5kWppgubkIbyTj05nuGHAEMjsfq0W1NpxwigDCfq4wfIryVUg6Z5WJu6jTXmplADmUWzNls47wTOi+ngdNIW2GPznF+tW94LELyzhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788464219; c=relaxed/simple;
	bh=TRVI0rDWsxNGBTz6qm81OE3wXj63LYZ+zuMZKUW1KSo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s5XWjXLtZ649CHr68k282UwnGi/VErDS27360PnBKBgHniur1+9vjQaYxOKqc31ZRtsTVB3FXTnBLrzWiy0GHs+CdYAU3/MZ5RVjzH0vTwVVFmWwKkpFVTTvfoweAdaIZpjudETqALw2OQmxTmJi/Mad2fpkR7nSCaWwlpvb2Ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XEjs0iw9; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XEjs0iw9"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-38dfe910e9dso202922a91.3
        for <kvm@vger.kernel.org>; Thu, 03 Sep 2026 12:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1788464189; x=1789068989; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ycFh0f47IuceK21rmhYjAzxurWXaF92SY8dhiJMI5DE=;
        b=XEjs0iw9ZXS7AOr2KU7DTTAPNmkuAuRNTt0Ksat5H6qQAUFYgqvQIE/iYiG8A2A9Gc
         dmfVO5sSsokUYFtvfGb2eKCxFoCmyzqcttLm7q0C813RvuUDamF275yISaqhGnqNsM+h
         jly81+OVourRz3Pkkz1/N7c0KPk3cMDxknxE5iQz39Nf6+q/2/r8zZDdoWaPADo9W8Gf
         1gyMw1AbEf3zvm38QjidAMMQWE2S9zPSZsmmDfDf9ADv4pR/Cga5g7QvScD1tQdE4B+3
         GJWVBprIlMVLr6a+bGz+oJ2zRNzA/gPw1L/WL9HIbRl1NqxwbyCtZdkHpoNoLdSSUPBn
         +hIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788464189; x=1789068989;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ycFh0f47IuceK21rmhYjAzxurWXaF92SY8dhiJMI5DE=;
        b=V9SKSVW/huLZ1ZHXoBPotLhv8OgqA+lN2qc/vEknYaf8gM46He1pmKNaSKB1NYy3pI
         pjNx5EsvLjbLPeHrz258H/NgkX7X3ArDqmD4o5lARiCFwFSr+3pEj0dDdh9nU36pSPfS
         sxafShXkS/iNepj6u7oG/15D63SRsR8kXc3PGwZf1saKU6vdNv6MI+bHaBCIoPwVWvz4
         Z5twZwclKC81ZWWhaxVwNfJba0J+o0Q+mPcw51DK8HyvXAcm//TqVkSC5XSt0sxg3NaN
         191BX89/8do47I2CfxP4mqn/SMoKorp1sZyXbBCfumFksO/fDWnPczAT/7q/X4Wy4bno
         F3rw==
X-Forwarded-Encrypted: i=1; AKwUvBw/QiZhtKnqpQqGE9I7MPXzB2raLGjJQsSHmPQWZ02RHAqG4uUcRgBH+dbpxSIAX5u/DpI=@vger.kernel.org
X-Gm-Message-State: AFuF++m7KK+2Yw/E2wtolwWtNVze3Z2+18d0PcwuK87XmIlOD0KawCF1
	KHTwCOAXQpekHBmKvUE10nNzTJ7VKv7j8jeK+VJPh0kuQ60wHkprjmUj/rSc3NVhzHnR0eTa4E9
	WC6kd
X-Gm-Gg: AYBFou0zmmqKa337Hu4NUZxkRocb9GTAEm0uA4zTakd5DVs+5r2v4Fyd6CZSW8AGyS/
	tKb9e9MeID0cHzicVGe+lp6yskmN2aVbNeoeR8aE7dcVbuMx1eZxmlALflf90GboCRUeZxIPo3Y
	3jKNiOK+2tTwIn0pwClpLdT941NrqVgmDDarqlyLPi55xgjiXnN3GmkmHqivdsGh6M8/fB7W1lp
	LJG72lX5O4cch0XFNxkDhLK5h/L7cHQGOFJLcIUGjxcf76lpUxX31350m+3RzwcXh571vXFsW3p
	YYEgw4QTOTM/E40FerufyQQHczsl3y8pWLMlFUAPuH9n8kQgGiLLmjAnOri/2xcFqIrfwv2NkNM
	FWt5PiXR7bKJPW/L+duDpPQPaYY8P5JLwQqNJ1414esnLH5CIeMGDPgAsiKeZlureV/E96NlpFH
	uds9Z32Q9D1+Ov7Wo7c02wCEWGTqnr4nde6yiEfgkyZJ6afI+6sNIprKTBFCL2TxQNS5K+xO0pV
	47+GxqSx8lksRk=
X-Received: by 2002:a17:90b:3d89:b0:398:9be8:ea69 with SMTP id 98e67ed59e1d1-39b262167e7mr1125588a91.22.1788464189422;
        Thu, 03 Sep 2026 12:36:29 -0700 (PDT)
Received: from p14s.cg.shawcable.net ([2604:3d09:148c:c800:40c0:ec33:6266:c275])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b083e4fafsm6836951a91.1.2026.09.03.12.36.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 12:36:29 -0700 (PDT)
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
	gshan@redhat.com,
	enju.kohei@fujitsu.com
Cc: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	kvm@vger.kernel.org,
	mathieu.poirier@linaro.org
Subject: [RFC v4 09/24] hw/core/loader: Add a ROM loader notifier
Date: Thu,  3 Sep 2026 13:35:56 -0600
Message-ID: <20260903193611.1058589-10-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260903193611.1058589-1-mathieu.poirier@linaro.org>
References: <20260903193611.1058589-1-mathieu.poirier@linaro.org>
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
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@linaro.org>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 hw/core/loader.c         | 15 +++++++++++++++
 include/hw/core/loader.h | 17 +++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/hw/core/loader.c b/hw/core/loader.c
index 5cbfba0a86d2..388f10e828db 100644
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
+            .data = rom->data,
+        };
+        notifier_list_notify(&rom_loader_notifier, &notify);
     }
 }
 
diff --git a/include/hw/core/loader.h b/include/hw/core/loader.h
index d9431e8a8d12..fdfddfa7443e 100644
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
+    /* Blog data */
+    uint8_t *data;
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

