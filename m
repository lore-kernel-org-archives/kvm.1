Received: from mail-dy2-f12.google.com (mail-dy2-f12.google.com [74.125.229.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB535304B2
	for <kvm@vger.kernel.org>; Wed, 23 Sep 2026 13:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790169605; cv=none; b=Ddh83HfTCEn/hRluaF9evUZNdfRefvQOp0OWdbze9xm4LkidFNBXtUBjKQzwav5MxEMrKPxoeHcbicSkwNRp0Z9/XVFde+zeMKSIVhhosdghjblvGueRrMp/HsoD1aixLeuUeKlMsdvHl3/QNFCkUfy08yqJwMrWZkIKPm3kGOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790169605; c=relaxed/simple;
	bh=2EUVFbDCnYFPueZP8LELQaE2UZirawv35H9FJEqhKYU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bl3/HZIQXKhuXPswzD0uMcl9wpHbjGdno8ubfoLnPQBwYSsFBhZ0GIHPDHW0sMBhPCNCtnT/d3R1ydIh1jmRj9X7X02IDLHmK9Igdf9Wu88uoiIQCRPFZQZqmZFUk6sJndCrw/Oi6h60AuDqIW0Xt2aZq8wc2kSVIO3r7JT4QDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rL3cqWxL; arc=none smtp.client-ip=74.125.229.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rL3cqWxL"
Received: by mail-dy2-f12.google.com with SMTP id 5a478bee46e88-328664c2da6so545086eec.1
        for <kvm@vger.kernel.org>; Wed, 23 Sep 2026 06:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790169590; x=1790774390; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kG8T0B41yOsfKs7+mPQWY4VwYoc5DWh5xeT8YOfa6ig=;
        b=rL3cqWxLzWitq9w6K4ElgXZs+tv9Ecehz8Bn+uHQOFY0VJXt6vRbk6HtL30yrLoEv0
         Csv1lVFIvyP0XocvVSCr73ON5dcd3+DGLgigLU71wTXdm3v79rJFrwvHhFttnbWnnIrK
         kuVhBoD8wlMPb791ExAMLjVuAhbgS8atBNehguFDhSuwokkvNYLtOcE0kxgkh662bJo3
         SvPiOUDWt5wTwUVmUcuABiZTvO+GlHPq0i7XQoXHSbqjRsI0tzRdGBkrKWOskutgcHrN
         PLJhCnK8GuacV+XR52OMqrS684qfBws+psTPPfp0ouIG2vyT2x3KOspUbteroxEAZy98
         bDIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790169590; x=1790774390;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kG8T0B41yOsfKs7+mPQWY4VwYoc5DWh5xeT8YOfa6ig=;
        b=KsqJOdrxlHgftTBYkgnGwEcUlI7R34SaALzs4wPrBusd/A2krEJIVL7LhW/IsQYGKx
         6SrHExaOWU5janjqEo/PaCz84JaLBmmXtNxGgPUF2lMaZxBzmrEmtSJ4e0YR7UZZGUQt
         3QwV7lnAiVQl5v6YR9UGQirKJ8NEUk90KdMb19CSAgOdSqpImVWHV+GaNgUQIdC/xLFK
         C5jChJ3Pb4bcPzsqNS2hQQ0sGnZ+7+6Re/EJs46roFRk4gh5VZgleXin7szOstyu4BPO
         idXm1Qae39u1ppqFR8+MeMOJTZ9nBV5FkahOTaXgtIDXOVh/gcxJmvkwy5O2r2YACyo4
         l2oA==
X-Forwarded-Encrypted: i=1; AKwUvBzallrgl/Fjc5G7ht2UoHH3LUoDHMgQkt93tb8yqKaqHsPMYsznn1VNhkV0zadrMl9oxS0=@vger.kernel.org
X-Gm-Message-State: AFuF++khjZ/VXMnz6qc35Hb0B/4PU1hl+v5Hii4eMVTi1I9LxuBgFZRx
	WiqMz4N7c5Lc3bI4WSzONmA/EMXGDQEhu4n1saTACtYhfbaumvTY7NxC
X-Gm-Gg: AYBFou0faZXMhcGhHRo6MyoAD9Vx+DoVZXpIIiVIbi27WaEe4tvzarLdRNOZX++K+9x
	Tk0+K04zR7f0S2l2RUOsa8rwUjOrXe2WWveI7h322n3BImHJ8iVIRiOL/JcrN5ArN7iOyLI4PyH
	Hd73u93tWFCJxx/t/342fcD+AgkRgPfG0Up+R9cO8eDfHCiiIlROHfv9p2BUyHAufRQy0I2mgid
	khM0AB12l5IMswXJcB0EtQSJKk6J9mLFWdB06cQyHpIMvUP+vRG6m/pBj/BsLIQyYKJP6bbhRCS
	lvyXdBMdHodvZ56QFYuRRxW6nkH5kjaRevbqIah4phj4lU/TL+OQ2Ofk6TpsfDOTnN/XXb7WUvW
	GGfQAK/lcyGic0ePSKem1SbbKqmrHJvgrq+qfFOvwqtyEBTN6DSI5RwO5SRxkmLBVpO2/pVCSVk
	xerPZMz9Trk2/UbsSIm8R3YC2OXkB1D56i7wILlleUeUUp9tuYQmzIZkeb3Xk4dIyidXv4V70Hu
	Ef1t+gkOg60MLTyDReeNY4rqR0GNcU=
X-Received: by 2002:a05:693c:87ce:20b0:33e:5cb6:249e with SMTP id 5a478bee46e88-33e8ddc761cmr2337090eec.39.1790169589850;
        Wed, 23 Sep 2026 06:19:49 -0700 (PDT)
Received: from WIN-BH9M8FJACR9 ([103.94.185.75])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-33e97236754sm5553695eec.29.2026.09.23.06.19.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 06:19:44 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: Cornelia Huck <cohuck@redhat.com>,
	xen-devel@lists.xenproject.org,
	Chao Liu <chao.liu@processmission.com>,
	Igor Mammedov <imammedo@redhat.com>,
	Alistair Francis <alistair.francis@wdc.com>,
	Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
	Peter Xu <peterx@redhat.com>,
	Eric Blake <eblake@redhat.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
	Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
	Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
	Peter Maydell <peter.maydell@linaro.org>,
	Sunil V L <sunilvl@ventanamicro.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Fabiano Rosas <farosas@suse.de>,
	Xianglai Li <lixianglai@loongson.cn>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Max Filippov <jcmvbkbc@gmail.com>,
	qemu-ppc@nongnu.org,
	Zhao Liu <zhao1.liu@intel.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Bibo Mao <maobibo@loongson.cn>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Laurent Vivier <laurent@vivier.eu>,
	David Hildenbrand <david@kernel.org>,
	Richard Henderson <richard.henderson@linaro.org>,
	=?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	qemu-riscv@nongnu.org,
	kvm@vger.kernel.org,
	"Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Stafford Horne <shorne@gmail.com>,
	=?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
	Markus Armbruster <armbru@redhat.com>,
	Weiwei Li <liwei1518@gmail.com>,
	Song Gao <17746591750@163.com>,
	qemu-arm@nongnu.org,
	qemu-s390x@nongnu.org,
	Brian Cain <brian.cain@oss.qualcomm.com>
Subject: [PATCH v3 017/114] module: add before/after hooks and module_call_init_fn
Date: Wed, 23 Sep 2026 21:14:51 +0800
Message-ID: <20260923131635.1894-18-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.52.0.windows.1
In-Reply-To: <20260923131635.1894-1-luoyonggang@gmail.com>
References: <20260923131635.1894-1-luoyonggang@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

module_call_init just walks the list. Add register_module_hooks
so one init type can wrap that walk with before and after
ModuleInitHook callbacks, and add module_call_init_fn so a single
function takes the same path.

module_call_init passes MODULE_INIT_PHASE_ON. A DSO or
module_call_init_fn passes DSO_BEFORE until module_call_init
finishes, then DSO_AFTER.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 include/qemu/module.h | 18 +++++++++++
 util/module.c         | 70 ++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 84 insertions(+), 4 deletions(-)

diff --git a/include/qemu/module.h b/include/qemu/module.h
index 34e05c75348..c10e32731fa 100644
--- a/include/qemu/module.h
+++ b/include/qemu/module.h
@@ -60,6 +60,20 @@ typedef enum {
 
 typedef void (ModuleInitFn)(void);
 
+/*
+ * Where one module_init_run sits relative to module_call_init().
+ * DSO_BEFORE: a DSO or module_call_init_fn before module_call_init().
+ * ON: module_call_init() itself.
+ * DSO_AFTER: a DSO or module_call_init_fn after module_call_init().
+ */
+typedef enum ModuleInitPhase {
+    MODULE_INIT_PHASE_DSO_BEFORE,
+    MODULE_INIT_PHASE_ON,
+    MODULE_INIT_PHASE_DSO_AFTER,
+} ModuleInitPhase;
+
+typedef bool (ModuleInitHook)(ModuleInitPhase phase, Error **errp);
+
 typedef struct ModuleEntry {
     ModuleInitFn *init;
     QTAILQ_ENTRY(ModuleEntry) node;
@@ -82,6 +96,10 @@ void register_module_init(ModuleEntry *e, module_init_type type);
 void register_dso_module_init(ModuleEntry *e, module_init_type type);
 
 void module_call_init(module_init_type type);
+void module_call_init_fn(module_init_type type, ModuleInitFn *init, Error **errp);
+
+void register_module_hooks(module_init_type type,
+                           ModuleInitHook *before, ModuleInitHook *after);
 
 /*
  * module_load: attempt to load a module from a set of directories
diff --git a/util/module.c b/util/module.c
index 6c5980542f6..a007ecb53a6 100644
--- a/util/module.c
+++ b/util/module.c
@@ -32,6 +32,8 @@ typedef QTAILQ_HEAD(, ModuleEntry) ModuleEntryList;
 typedef struct ModuleInit
 {
     module_init_type type;
+    ModuleInitHook *before;
+    ModuleInitHook *after;
     ModuleEntryList list;
     ModuleEntryList dso_list;
     bool done;
@@ -88,14 +90,54 @@ void register_dso_module_init(ModuleEntry *e, module_init_type type)
     module_init_add(&find_type(type)->dso_list, e);
 }
 
-static void module_init_run(ModuleInit *m, ModuleEntryList *list)
+/**
+ * register_module_hooks:
+ * @type: init list
+ * @before: runs before every registered init for @type
+ * @after: runs after every registered init for @type
+ *
+ * One ModuleInit holds both callbacks so before and after stay 1:1.
+ * module_call_init(@type) passes MODULE_INIT_PHASE_ON. A DSO or
+ * module_call_init_fn passes DSO_BEFORE if module_call_init() has not
+ * finished, otherwise DSO_AFTER.
+ */
+void register_module_hooks(module_init_type type,
+                           ModuleInitHook *before, ModuleInitHook *after)
+{
+    ModuleInit *m = find_type(type);
+
+    g_assert(before);
+    g_assert(after);
+    g_assert(!m->before && !m->after);
+
+    m->before = before;
+    m->after = after;
+}
+
+static bool module_init_run(ModuleInit *m, ModuleEntryList *list, bool is_dso,
+                            Error **errp)
 {
     ModuleEntry *e;
+    ModuleInitPhase phase;
+
+    if (!is_dso) {
+        phase = MODULE_INIT_PHASE_ON;
+    } else if (m->done) {
+        phase = MODULE_INIT_PHASE_DSO_AFTER;
+    } else {
+        phase = MODULE_INIT_PHASE_DSO_BEFORE;
+    }
 
-    (void)m;
+    if (m->before && !m->before(phase, errp)) {
+        return false;
+    }
     QTAILQ_FOREACH(e, list, node) {
         e->init();
     }
+    if (m->after && !m->after(phase, errp)) {
+        return false;
+    }
+    return true;
 }
 
 void module_call_init(module_init_type type)
@@ -106,10 +148,27 @@ void module_call_init(module_init_type type)
         return;
     }
 
-    module_init_run(m, &m->list);
+    module_init_run(m, &m->list, false, &error_abort);
     m->done = true;
 }
 
+/*
+ * Run a single init through @type's before/after hooks with is_dso=true.
+ * May run before or after module_call_init.
+ */
+void module_call_init_fn(module_init_type type, ModuleInitFn *init, Error **errp)
+{
+    ModuleInit *m = find_type(type);
+    ModuleEntry e = {
+        .init = init,
+    };
+    ModuleEntryList list;
+
+    QTAILQ_INIT(&list);
+    QTAILQ_INSERT_TAIL(&list, &e, node);
+    module_init_run(m, &list, true, errp);
+}
+
 #ifdef CONFIG_MODULES
 
 static const QemuModinfo module_info_stub[] = { {
@@ -201,7 +260,10 @@ static bool module_load_dso(const char *fname, bool export_symbols,
             continue;
         }
 
-        module_init_run(m, &m->dso_list);
+        if (!module_init_run(m, &m->dso_list, true, errp)) {
+            empty_dso_lists();
+            return false;
+        }
     }
     trace_module_load_module(fname);
     empty_dso_lists();
-- 
2.52.0.windows.1

