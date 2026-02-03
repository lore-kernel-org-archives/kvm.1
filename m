Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A453112DC
	for <kvm@vger.kernel.org>; Tue,  3 Feb 2026 12:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770120255; cv=none; b=WlTa+Dfd0bVkwRlft1EdaqL8nM9HJfYQ3P1wKA8PIuJP6Kb5p0NqDGFc+/MeUR6pnEe61UsxZzFxmOCmdhF3jUWxFs4jbNCCgg9H2T3arEebseYODuug9q8T2hTgaYaPRq8V2C1iKxYj2qeLM5WB4gBi1e6vBy8rSITbfdvp0+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770120255; c=relaxed/simple;
	bh=hMR6mYoVC7qp0T8yGj+ta6O6WqMRIbMcxdNJezdw3Ok=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nTXkLLfeSz8s5qn05LDBYX21tnlMteL9rme29toKl/fiCztplDYnIB4jMyc7cDxaaEt2g8tyf3dIcWxlObP+IF+a1Ct/qS2MIn4I3CasLyxNnUUDjAaq7AS/Z8+abSFqWfGrqQG+TiVvpFt9k8Mxl8+ABmAvCVaBAr3VSSaZwPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hezH9QTW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hezH9QTW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770120253;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CnOXJUc/BoLbPslPw3aPQeYYdMXvaRXwx5lRglNofE0=;
	b=hezH9QTW5un5GRf92obsnOYX0JWIVT94H1uAF56IVrdgzFOr+YQLAQQhorOvkLSXLMRD37
	LbEMJ69nDMgysZpIbYp/l8lxSZ/XbwFuAdvuA32FdLrMZ3U9fcI8hWZL4oIFH1zRUMynFT
	hppjoWVlD6/4UIuY0+pdRzlq7zv0pUM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-468-USztDpaWNaq_aozul2U5dQ-1; Tue,
 03 Feb 2026 07:04:10 -0500
X-MC-Unique: USztDpaWNaq_aozul2U5dQ-1
X-Mimecast-MFC-AGG-ID: USztDpaWNaq_aozul2U5dQ_1770120249
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EECEA180047F;
	Tue,  3 Feb 2026 12:04:08 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.44.34.28])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3D91030001A7;
	Tue,  3 Feb 2026 12:04:08 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
	id C324A182626E; Tue, 03 Feb 2026 13:03:44 +0100 (CET)
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
	Gerd Hoffmann <kraxel@redhat.com>,
	Oliver Steffen <osteffen@redhat.com>
Subject: [PULL 17/17] igvm: Fill MADT IGVM parameter field on x86_64
Date: Tue,  3 Feb 2026 13:03:42 +0100
Message-ID: <20260203120343.656961-18-kraxel@redhat.com>
In-Reply-To: <20260203120343.656961-1-kraxel@redhat.com>
References: <20260203120343.656961-1-kraxel@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

From: Oliver Steffen <osteffen@redhat.com>

Use the new acpi_build_madt_standalone() function to fill the MADT
parameter field.

The IGVM parameter can be consumed by Coconut SVSM [1], instead of
relying on the fw_cfg interface, which has caused problems before due to
unexpected access [2,3]. Using IGVM parameters is the default way for
Coconut SVSM across hypervisors; switching over would allow removing
specialized code paths for QEMU in Coconut.

Coconut SVSM needs to know the SMP configuration, but does not look at
any other ACPI data, nor does it interact with the PCI bus settings.
Since the MADT is static and not linked with other ACPI tables, it can
be supplied stand-alone like this.

Generating the MADT twice (during ACPI table building and IGVM processing)
seems acceptable, since there is no infrastructure to obtain the MADT
out of the ACPI table memory area.

In any case OVMF, which runs after SVSM has already been initialized,
will continue reading all ACPI tables via fw_cfg and provide fixed up
ACPI data to the OS as before without any changes.

The IGVM parameter handler is implemented for the i386 machine target
and stubbed for all others.

[1] https://github.com/coconut-svsm/svsm/pull/858
[2] https://gitlab.com/qemu-project/qemu/-/issues/2882
[3] https://github.com/coconut-svsm/svsm/issues/646

Signed-off-by: Oliver Steffen <osteffen@redhat.com>
Message-ID: <20260130054714.715928-10-osteffen@redhat.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/system/igvm-internal.h |  5 +++++
 backends/igvm.c                |  2 ++
 stubs/igvm.c                   |  6 ++++++
 target/i386/igvm.c             | 32 ++++++++++++++++++++++++++++++++
 4 files changed, 45 insertions(+)

diff --git a/include/system/igvm-internal.h b/include/system/igvm-internal.h
index 1d36519ab082..38004bd908e7 100644
--- a/include/system/igvm-internal.h
+++ b/include/system/igvm-internal.h
@@ -74,4 +74,9 @@ IgvmHandle qigvm_file_init(char *filename, Error **errp);
 QIgvmParameterData*
 qigvm_find_param_entry(QIgvm *igvm, uint32_t parameter_area_index);
 
+/*
+ *  IGVM parameter handlers
+ */
+int qigvm_directive_madt(QIgvm *ctx, const uint8_t *header_data, Error **errp);
+
 #endif
diff --git a/backends/igvm.c b/backends/igvm.c
index 3e7c0ea41d14..b01a19ba46a1 100644
--- a/backends/igvm.c
+++ b/backends/igvm.c
@@ -128,6 +128,8 @@ static struct QIGVMHandler handlers[] = {
       qigvm_directive_snp_id_block },
     { IGVM_VHT_GUEST_POLICY, IGVM_HEADER_SECTION_INITIALIZATION,
       qigvm_initialization_guest_policy },
+    { IGVM_VHT_MADT, IGVM_HEADER_SECTION_DIRECTIVE,
+      qigvm_directive_madt },
 };
 
 static int qigvm_handler(QIgvm *ctx, uint32_t type, Error **errp)
diff --git a/stubs/igvm.c b/stubs/igvm.c
index 17cd1e903e35..47d5130d9d74 100644
--- a/stubs/igvm.c
+++ b/stubs/igvm.c
@@ -12,6 +12,7 @@
 #include "qemu/osdep.h"
 
 #include "system/igvm.h"
+#include "system/igvm-internal.h"
 
 int qigvm_x86_get_mem_map_entry(int index,
                                 ConfidentialGuestMemoryMapEntry *entry,
@@ -24,3 +25,8 @@ int qigvm_x86_set_vp_context(void *data, int index, Error **errp)
 {
     return -1;
 }
+
+int qigvm_directive_madt(QIgvm *ctx, const uint8_t *header_data, Error **errp)
+{
+    return -1;
+}
diff --git a/target/i386/igvm.c b/target/i386/igvm.c
index 457c253b030c..f41b498b8924 100644
--- a/target/i386/igvm.c
+++ b/target/i386/igvm.c
@@ -13,7 +13,9 @@
 
 #include "cpu.h"
 #include "hw/i386/e820_memory_layout.h"
+#include "hw/i386/acpi-build.h"
 #include "system/igvm.h"
+#include "system/igvm-internal.h"
 
 struct IgvmNativeVpContextX64 {
     uint64_t rax;
@@ -178,3 +180,33 @@ void qigvm_x86_bsp_reset(CPUX86State *env)
 
     qigvm_x86_load_context(bsp_context, env);
 }
+
+/*
+ * Process MADT IGVM parameter
+ */
+int qigvm_directive_madt(QIgvm *ctx, const uint8_t *header_data, Error **errp)
+{
+    const IGVM_VHS_PARAMETER *param = (const IGVM_VHS_PARAMETER *)header_data;
+    QIgvmParameterData *param_entry;
+    int result = 0;
+
+    /* Find the parameter area that should hold the MADT data */
+    param_entry = qigvm_find_param_entry(ctx, param->parameter_area_index);
+    if (param_entry == NULL) {
+        return 0;
+    }
+
+    GArray *madt = acpi_build_madt_standalone(ctx->machine_state);
+
+    if (madt->len <= param_entry->size) {
+        memcpy(param_entry->data, madt->data, madt->len);
+    } else {
+        error_setg(
+            errp,
+            "IGVM: MADT size exceeds parameter area defined in IGVM file");
+        result = -1;
+    }
+
+    g_array_free(madt, true);
+    return result;
+}
-- 
2.52.0

