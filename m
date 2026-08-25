Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D9933DCD86
	for <kvm@vger.kernel.org>; Tue, 25 Aug 2026 22:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787695286; cv=none; b=AFT2QDiZCe58CJE88DLc/ICzUgwY/fSj190QDD3+x6fTOAaS2dhCfx+NAznk17vD6D6jTeIjCFzNhM0i8sL8j+5KvkBqNIfuRtAty0n/8hye6iluvsNWW4WxED5MzCkXX9MCtBMRp5ub8K3u9ZbBhfTfxBBCmMJjNzBcGIKNKGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787695286; c=relaxed/simple;
	bh=TRVI0rDWsxNGBTz6qm81OE3wXj63LYZ+zuMZKUW1KSo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ACzjA/BXZkccq3MAu7m+gtKGDcEdMfMKmF+nKRCqz/e1aSlXPz6SHswEh9uCBDts1uIPtJVoV8+W0TPly45RH9PgGN9aA0aqmDckeF9EnjMQQZQZpBUys0LjMRESRjuDo3wYJAtzwPRRBxAFNhMNODGER5peprNAy3ECgx7XF4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SPBWrg4O; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SPBWrg4O"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-38fdeaed181so666068a91.1
        for <kvm@vger.kernel.org>; Tue, 25 Aug 2026 15:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1787695284; x=1788300084; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ycFh0f47IuceK21rmhYjAzxurWXaF92SY8dhiJMI5DE=;
        b=SPBWrg4OkUPw1DSOu8m9NlwjiBT/6v9drdGk/Q+jEauPxdNfLe9CeS9a8WFSr/jMlT
         ScM460TZgC0EPy8mlsrFwvClWkVtL4XZUFv9Pkf6Yzrb7SS9UmgkI99S6KaeuC2P9zsa
         MTNuE/gRd6rkq76ptHRp5TxTeWIXgE/y4n2LdNxS+acK7+r3HzjVprTr+B2BPePvhggV
         Fc36dKbXqtsSLMcoKcxQZm1mOcupJZ7pqd9W6o8nXPnJrWuGlqJhj3oJLEzUVVG0WvXq
         khMAy56Tqy2Vd7UpK6gXJUBEsSF1Efsb8ZSlVSv9AFFPNganWemqE9x9MvARSmLPS2sa
         S2KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787695284; x=1788300084;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ycFh0f47IuceK21rmhYjAzxurWXaF92SY8dhiJMI5DE=;
        b=G3RXezN4bZ/Au5TOTsO+80W8kZKZ0ju3FFBQ4r36xBEOkUvX/hdvlvwuWIP1Xh0jUr
         77BunixMs1CBT5gJHc0+Mdh9EwluNnrBFfmoMEaTCyJ7Pma80PcqjaHq8mkPTGYh59Vq
         jSlW9YBIoyLp6KKvWiIkLCfK7LdTnycxpckOlSEETfVfjVTdTi/iwtMxbGgUQP3ZVH7N
         juB0zp7uEXJliSNkGR2gh/ipUPR9qme8re7P0pkTYbQAxnqstLNf3HPye7yblMt8XvVY
         KuB7tSPGoxwq6bxkh34OLvIxumPf9wCYYjECCMHxoHqGlu3rlfgtK+f++gEybDtAnSUx
         poSg==
X-Forwarded-Encrypted: i=1; AHgh+RrGlhb8aEJWr+YneVu8Ro+wqe3TzKPTsA25MxvLOwjudzJkU07UKXT+uUHPQ35EM0SbMFk=@vger.kernel.org
X-Gm-Message-State: AFuF++lxd9hNq96uvfI4y1tphmwPHj9qeRvai6Pb/SRcus+Lpe92JKC7
	OkRmRFnXOR4HpdAIn3HLWqhgb6xLFaqzCytLu6k7U02ykaViiplw5NSorxoxoF749NY=
X-Gm-Gg: AR+sD1310WcAH02cKjKC86Z5tqn30g3cqket4LSTaBbhryhZfvU7vX8OGCqUTRcNLhj
	93WHRNTVpCDprO5jC7nkii3Mln6TS5DZUglikzthdnJHIGNvER23IbztdfCZxwQsYdphRW5S9PI
	we13kU2D52F4J2Ttp49Wk1Pp+sfSuQM58Udkj9/1+uj2zr1FxsCjIz7hfXH5bsLBm0/4lBlmTQK
	SPYuzi/wqR/Ke3QNASaZ3raUCT9bY7+Jq7hvQcXGmeaF37sWBUTqz4ABmvczkjYQIPNfTJjn36A
	FM8qW8MlOM6/LTVU3r4QpgESHtuE0fUO9l0qoAWgokUUmwVaH+zQcyLEMY+y1wx3ujW7bBwzTqW
	e1kYEpkXu92EtNHC51KCuoDE16g37qY/apO25csE8ozm2GVUf3ZbqpdeXL8tDlr8IBaCeO+Cbry
	QhsjbYjlOXY2N/s7R8dZDVo/13Rg8bZlj+aY1HdJ3V9wavhDpQN8jN3GkTQTMRrdg4KFcL4f7Fs
	rXMf1etmsn+JY033MaPG245LQ==
X-Received: by 2002:a17:90b:17d1:b0:38e:8300:af51 with SMTP id 98e67ed59e1d1-3966d20b09fmr3611610a91.8.1787695284101;
        Tue, 25 Aug 2026 15:01:24 -0700 (PDT)
Received: from p14s.cg.shawcable.net ([2604:3d09:148c:c800:a37a:292f:1363:c0af])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3965d119724sm3090120a91.2.2026.08.25.15.01.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 15:01:23 -0700 (PDT)
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
Subject: [RFC v3 09/24] hw/core/loader: Add a ROM loader notifier
Date: Tue, 25 Aug 2026 16:00:46 -0600
Message-ID: <20260825220101.3443954-10-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260825220101.3443954-1-mathieu.poirier@linaro.org>
References: <20260825220101.3443954-1-mathieu.poirier@linaro.org>
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

