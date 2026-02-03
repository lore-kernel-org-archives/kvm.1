Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C0C233B945
	for <kvm@vger.kernel.org>; Tue,  3 Feb 2026 12:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770120242; cv=none; b=uv+7nMG8gu/knGk+kkwHpF0rJJk8xFwF4WUhgbXqIZJDgSB5gnj/SX1lvpr0/xyjFsj+eaEt9eZGcQMeqhq9OTzL9SWu8x10aMxEfiOM4ciM7bw/5CbZhuH/Ijyn5ACdwKwVRQxVOgEU2u7upQdXOpbIhGmjv7m9j2u+cJTIan0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770120242; c=relaxed/simple;
	bh=15/YEa4uT7EbZpgyF8eBnXAObR64If6JUOh2MQusWrI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aZxP5S2wUW/87KbGZv/w6wCQSxvrOcYI7FgfVaBONKm5YMornqe2/1gQxhy9yeB/PPeBzWLp+4ZvBjZx1gJYlcORLHqYJafzB27f9tPGy0oELZ4VcsadeQiNiM17pMe1Xd5lN27ucH5QWOi1HN+ca2QnxRJ0Gthu1kPqX9fuMDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WDqZFfNg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WDqZFfNg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770120239;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RmXmcEqa3262D5qIjCHLmaAOTgx6BTKLMY37a3LazWY=;
	b=WDqZFfNgxE1/VLXl+CdKlIMzN+kgDqaHNtACCsD0lvukAgQH1UqEY+oxaryZYgZvadF9Ru
	fbCm0MpympdyMMRlEXKnUDkcn++pMnDpYO6KI82ZD8JZADwncjY0fcR7HJQuN5bSN4p1X2
	3lp2asHdW+JpicnfVbrvYGpDN/1BHHs=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-32-mTO2un3sPhi48GGBvGocSQ-1; Tue,
 03 Feb 2026 07:03:58 -0500
X-MC-Unique: mTO2un3sPhi48GGBvGocSQ-1
X-Mimecast-MFC-AGG-ID: mTO2un3sPhi48GGBvGocSQ_1770120237
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9D18619560B5;
	Tue,  3 Feb 2026 12:03:57 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.44.34.28])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 53EDE1955F16;
	Tue,  3 Feb 2026 12:03:57 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
	id 116741800990; Tue, 03 Feb 2026 13:03:44 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: Igor Mammedov <imammedo@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
	Ani Sinha <anisinha@redhat.com>,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>,
	Eduardo Habkost <eduardo@habkost.net>,
	Zhao Liu <zhao1.liu@intel.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Richard Henderson <richard.henderson@linaro.org>,
	kvm@vger.kernel.org,
	Gerd Hoffmann <kraxel@redhat.com>
Subject: [PULL 08/17] igvm: move igvm file processing to reset callbacks
Date: Tue,  3 Feb 2026 13:03:33 +0100
Message-ID: <20260203120343.656961-9-kraxel@redhat.com>
In-Reply-To: <20260203120343.656961-1-kraxel@redhat.com>
References: <20260203120343.656961-1-kraxel@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Move igvm file processing from machine init to reset callbacks.  With
that the igvm file is properly re-loaded on reset.  Also the loading
happens later in the init process now.  This will simplify future
support for some IGVM parameters which depend on initialization steps
which happen after machine init.

Reviewed-by: Ani Sinha <anisinha@redhat.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20260126123755.357378-6-kraxel@redhat.com>
---
 backends/igvm-cfg.c |  7 +++++++
 hw/i386/pc_piix.c   | 10 ----------
 hw/i386/pc_q35.c    | 10 ----------
 3 files changed, 7 insertions(+), 20 deletions(-)

diff --git a/backends/igvm-cfg.c b/backends/igvm-cfg.c
index 4014062e0f22..f236b523df3b 100644
--- a/backends/igvm-cfg.c
+++ b/backends/igvm-cfg.c
@@ -16,6 +16,8 @@
 #include "system/igvm-internal.h"
 #include "system/reset.h"
 #include "qom/object_interfaces.h"
+#include "hw/core/qdev.h"
+#include "hw/core/boards.h"
 
 #include "trace.h"
 
@@ -45,7 +47,12 @@ static void igvm_reset_enter(Object *obj, ResetType type)
 
 static void igvm_reset_hold(Object *obj, ResetType type)
 {
+    MachineState *ms = MACHINE(qdev_get_machine());
+    IgvmCfg *igvm = IGVM_CFG(obj);
+
     trace_igvm_reset_hold(type);
+
+    qigvm_process_file(igvm, ms->cgs, false, &error_fatal);
 }
 
 static void igvm_reset_exit(Object *obj, ResetType type)
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index fea158fc4bfe..878db5721b78 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -320,16 +320,6 @@ static void pc_init1(MachineState *machine, const char *pci_type)
                                x86_nvdimm_acpi_dsmio,
                                x86ms->fw_cfg, OBJECT(pcms));
     }
-
-#if defined(CONFIG_IGVM)
-    /* Apply guest state from IGVM if supplied */
-    if (x86ms->igvm) {
-        if (IGVM_CFG_GET_CLASS(x86ms->igvm)
-                ->process(x86ms->igvm, machine->cgs, false, &error_fatal) < 0) {
-            g_assert_not_reached();
-        }
-    }
-#endif
 }
 
 typedef enum PCSouthBridgeOption {
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 4d6046e47b0d..6e5a23d718f1 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -328,16 +328,6 @@ static void pc_q35_init(MachineState *machine)
                                x86_nvdimm_acpi_dsmio,
                                x86ms->fw_cfg, OBJECT(pcms));
     }
-
-#if defined(CONFIG_IGVM)
-    /* Apply guest state from IGVM if supplied */
-    if (x86ms->igvm) {
-        if (IGVM_CFG_GET_CLASS(x86ms->igvm)
-                ->process(x86ms->igvm, machine->cgs, false, &error_fatal) < 0) {
-            g_assert_not_reached();
-        }
-    }
-#endif
 }
 
 #define DEFINE_Q35_MACHINE(major, minor) \
-- 
2.52.0

