Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E265D53F6B7
	for <kvm@vger.kernel.org>; Thu, 15 Oct 2026 14:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792075942; cv=none; b=ibrTrHthU3LSspwljm1gsemkI6AmSwcDmE+av3HByoC5wli9P8dr3441WKp0l39ktTIjsanEAjwXltqSFBccpBD+vpPU0gydqHUUsuCNmKF+cC6l0Sv7fQ4qqifrqWN4QP82wpdHmykvLfgxUDKShqeongOwm+D3BWqaqEJTC6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792075942; c=relaxed/simple;
	bh=lSmZcd98LmtWHL3GmrxnUEDZTHTJ5CdcCyQPbe6MJfE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dxYTUxWP6pTaHubUIlaO5ozIi/RMwVbQ7Te5BKCxw9PJfZiqp7t11FR+iBeoLtDCKdqLeoyWxz9xVmu99GJFFUkCExcYzP/CTeO+eejPmE621VshZ5773nESyu1qvOptOhEN/CFt5umjPhC3hsEiZqwzruTf4b5iERBSQD+HZ/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=F6InlA1w; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="F6InlA1w"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c247f6687dcso817733266b.2
        for <kvm@vger.kernel.org>; Thu, 15 Oct 2026 07:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1792075936; x=1792680736; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6yrHsN44XnhBGCcA9EOfWc6RZwmZTowMBhuPNpcmyRI=;
        b=F6InlA1w9estJrRZGGvtYXjrvqNFgvOyf0bZ0+yNsyrXMeedmH62q56cLVzCTTEJCG
         wqrtyd+6gfcCL+kwlRdfeBWyXP7O5AsOtGdTmEoXS6HOhnfQdjGuh3lPvOvFacm0vi2F
         nJjXvUssG+aANS356Q/MxDOXXt57DUlQ/RASGuuuGntW/ThxP5jDG62VOEgj6w5HtwIV
         P9APScXfUnFR7HKgYBatvR8ub/Cy5glhIyX0HvNbU2D5UAJIEThSIhEaFOswYlrLSNC4
         F/9zqDPj2zeaKy/961XEyYIegu5jy2gTdEfUzLARXHjPdZi/0kzRQ5Afic1WYHaoR2mz
         oeIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792075936; x=1792680736;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6yrHsN44XnhBGCcA9EOfWc6RZwmZTowMBhuPNpcmyRI=;
        b=EUQmO/YBI+sSlUkxsIMSwFJp2hh+bvSwLzmR0hzeyBatthaiexoig4ZO1WO5M7SAh4
         p8C3brkNxvPohEeEWnB4aRO9KRQnTVruYSj6Y8DNWfZuxk5xFUBUCkoUYps0Oa3O+nmL
         9mooaD/oRPyJu3nclTyx92Q7meoy//EHQvrRoq5jFxXtzpNm2fybtckWvgbyLk9of5/b
         THA3m4KsVJqgW40bwGgV2xrBLgzjFgQBqF02pYYe7NSISelDVgtwmc/cd7FLEZJOcTiC
         nGKWWumtMDAEsOMPR3DWm8VDBeO6gHPClvJCGOJPx0kZ2L39QwdLk5kRzzTdI4SyLDfL
         NNmg==
X-Forwarded-Encrypted: i=1; AKwUvByK2LrjpTu6FJbkOGmlUs/grXFSAWNJMQgmzvWPBtXdbAyhO70lgo0G/E/QM3BSMR9T550=@vger.kernel.org
X-Gm-Message-State: AFq9FYJIzgVuVF8TW8UkkL1ZDAbX9hGDB3Juz0bp2bIlv37t4yc67g3y
	os/Zid1hRQH4PXtE8R25GyNCEKjmSgDxfM0AIwEyc9zR6SmlVG2oLXhSAVpePzJWpFs=
X-Gm-Gg: AYBFou1AIPr2uy16TvAok4863w7mQL2CANsUHdqhwCNcUtn+lWUOmu75IIPLWAdAT07
	gNukV9+q9vbBMpUQGpOUwkM6Zw3E6QOvPPlEo/7XYpCWDQISXErVAWhpomWmMIjHlDV0a368x4Z
	/Dhvui9/yzMzUpOo0rA693LTIoQzQKZy6EjLIo1TxkiURWXda9URGgUdJeB+Yn3mAssPxAsJHpO
	dvMiipaP8Kb73CUT+FiSq4LB610pz/bVZnetk4IvekXarPxeFWDkQYXCIcLoO00J2qmLXdi0LXa
	oa80EaKRRFwml+Do9xBv2kwCR83gTHGH8uRKiW55zPzKOuE8MXja4MJIJ+X9i2UgAC61Vx5v80q
	JaJhYh9DrOSfLfaPIpG1IJpAwZWeBm6llvEHjcgGhCyk5RDCuchXLWz3d1yivaUGjaeE676Z5L0
	VZM7P1sQ547PZ+J/vGe28khBe4UiRI3ZtTy3KBrUsz8plxUxeycmveFS7XGWxy0CEZ8re1pIVPp
	ccLPCN5sQ==
X-Received: by 2002:a17:907:3d86:b0:c3e:34fa:6115 with SMTP id a640c23a62f3a-c3e34fa6bbfmr314175566b.19.1792075936110;
        Thu, 15 Oct 2026 07:52:16 -0700 (PDT)
Received: from localhost ([140.209.217.212])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c3ed9b3ec57sm137862466b.39.2026.10.15.07.52.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 07:52:15 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: linux-coco@lists.linux.dev
Cc: linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org,
	x86@kernel.org,
	kvm@vger.kernel.org,
	linux-doc@vger.kernel.org,
	jgg@ziepe.ca,
	david.quigley@intel.com,
	lukas@wunner.de,
	ksinyuk@kernel.org,
	rodrigo.vivi@intel.com,
	cedric.xing@intel.com,
	sameo@meta.com,
	drdeeglaze@gmail.com,
	James.Bottomley@HansenPartnership.com,
	aik@amd.com,
	jpiotrowski@nvidia.com,
	qinkun@google.com,
	pgonda@google.com,
	jic23@kernel.org,
	alistair.francis@wdc.com,
	ankita@nvidia.com,
	suzuki.poulose@arm.com,
	kas@kernel.org,
	rick.p.edgecombe@intel.com,
	elena.reshetova@intel.com,
	dave.hansen@linux.intel.com,
	sathyanarayanan.kuppuswamy@linux.intel.com,
	peter.fang@intel.com
Subject: [PATCH RFC 19/20] attestation: Add the TDX family specification and generated files
Date: Thu, 15 Oct 2026 16:50:52 +0200
Message-ID: <20261015145053.3664509-20-jiri@resnulli.us>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261015145053.3664509-1-jiri@resnulli.us>
References: <20261015145053.3664509-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Pirko <jiri@nvidia.com>

Define the TDX attestation family and reserve family ID 2. Add its ABI
snapshot, registry entry and generated kernel and UAPI files.

The ABI is intentionally specification-first. The generated descriptor is
linked with the provider implementation in the following patch.

Assisted-by: Cursor: GPT-5.6 Sol
Assisted-by: Cursor: Claude Opus 5.5
Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 .../ctlv/abi/ctlv-attestation-tdx.yaml        | 22 +++++++
 Documentation/ctlv/abi/families.registry.yaml |  1 +
 Documentation/ctlv/families.yaml              |  1 +
 Documentation/ctlv/generated-files.yaml       |  7 ++
 .../ctlv/specs/ctlv-attestation-tdx.yaml      | 30 +++++++++
 .../generated/ctlv_attestation_tdx_gen.c      | 61 +++++++++++++++++
 .../generated/ctlv_attestation_tdx_gen.h      | 66 +++++++++++++++++++
 include/uapi/linux/ctlv_attestation_tdx_gen.h | 44 +++++++++++++
 include/uapi/linux/ctlv_families_gen.h        |  1 +
 9 files changed, 233 insertions(+)
 create mode 100644 Documentation/ctlv/abi/ctlv-attestation-tdx.yaml
 create mode 100644 Documentation/ctlv/specs/ctlv-attestation-tdx.yaml
 create mode 100644 drivers/attestation/generated/ctlv_attestation_tdx_gen.c
 create mode 100644 drivers/attestation/generated/ctlv_attestation_tdx_gen.h
 create mode 100644 include/uapi/linux/ctlv_attestation_tdx_gen.h

diff --git a/Documentation/ctlv/abi/ctlv-attestation-tdx.yaml b/Documentation/ctlv/abi/ctlv-attestation-tdx.yaml
new file mode 100644
index 000000000000..89b80d84e7f1
--- /dev/null
+++ b/Documentation/ctlv/abi/ctlv-attestation-tdx.yaml
@@ -0,0 +1,22 @@
+# SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)
+%YAML 1.2
+---
+# Checked-in ABI snapshot of the ctlv-attestation-tdx family, written by
+# "make -C tools/ctlv abi-update".
+#
+# The checker compares this family's declarations and inherited stub fills
+# against this file. Updating it is how a UAPI change gets reviewed; an update
+# that removes or renumbers anything, narrows a bound, or makes a placement
+# required is an ABI break, whatever this file says afterwards.
+family: {name: ctlv-attestation-tdx, id: 2, inherits: ctlv-attestation,
+         pre-init: true}
+attr-groups:
+  info:
+    id: 1
+    attrs:
+      mrconfigid: {id: 1, type: binary, length: 48}
+      mrowner: {id: 2, type: binary, length: 48}
+      mrownerconfig: {id: 3, type: binary, length: 48}
+fills:
+  device-info:
+    attrs: [info.mrconfigid, info.mrowner, info.mrownerconfig]
diff --git a/Documentation/ctlv/abi/families.registry.yaml b/Documentation/ctlv/abi/families.registry.yaml
index fa511b709fc1..193e3570ab95 100644
--- a/Documentation/ctlv/abi/families.registry.yaml
+++ b/Documentation/ctlv/abi/families.registry.yaml
@@ -6,3 +6,4 @@
 families:
   - ctlv
   - ctlv-attestation
+  - ctlv-attestation-tdx
diff --git a/Documentation/ctlv/families.yaml b/Documentation/ctlv/families.yaml
index d78025a9072c..d0e1493db498 100644
--- a/Documentation/ctlv/families.yaml
+++ b/Documentation/ctlv/families.yaml
@@ -12,3 +12,4 @@
 families:
   - ctlv
   - ctlv-attestation
+  - ctlv-attestation-tdx
diff --git a/Documentation/ctlv/generated-files.yaml b/Documentation/ctlv/generated-files.yaml
index 669f1f8d51b4..00ad23af7f65 100644
--- a/Documentation/ctlv/generated-files.yaml
+++ b/Documentation/ctlv/generated-files.yaml
@@ -22,3 +22,10 @@ families:
       uapi-header: include/uapi/linux/ctlv_attestation_gen.h
       kernel-header: drivers/attestation/generated/ctlv_attestation_gen.h
       kernel-source: drivers/attestation/generated/ctlv_attestation_gen.c
+
+  - name: ctlv-attestation-tdx
+    source: Documentation/ctlv/specs/ctlv-attestation-tdx.yaml
+    outputs:
+      uapi-header: include/uapi/linux/ctlv_attestation_tdx_gen.h
+      kernel-header: drivers/attestation/generated/ctlv_attestation_tdx_gen.h
+      kernel-source: drivers/attestation/generated/ctlv_attestation_tdx_gen.c
diff --git a/Documentation/ctlv/specs/ctlv-attestation-tdx.yaml b/Documentation/ctlv/specs/ctlv-attestation-tdx.yaml
new file mode 100644
index 000000000000..09f4d9916f82
--- /dev/null
+++ b/Documentation/ctlv/specs/ctlv-attestation-tdx.yaml
@@ -0,0 +1,30 @@
+# SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)
+%YAML 1.2
+---
+family:
+  name: ctlv-attestation-tdx
+  inherits: ctlv-attestation
+  pre-init: true
+
+attr-groups:
+  - name: info
+    attrs:
+      - name: mrconfigid
+        type: binary
+        min-length: 48
+        max-length: 48
+      - name: mrowner
+        type: binary
+        min-length: 48
+        max-length: 48
+      - name: mrownerconfig
+        type: binary
+        min-length: 48
+        max-length: 48
+
+attr-sets:
+  - name: device-info
+    attrs:
+      - info.mrconfigid
+      - info.mrowner
+      - info.mrownerconfig
diff --git a/drivers/attestation/generated/ctlv_attestation_tdx_gen.c b/drivers/attestation/generated/ctlv_attestation_tdx_gen.c
new file mode 100644
index 000000000000..25f03a8d68fe
--- /dev/null
+++ b/drivers/attestation/generated/ctlv_attestation_tdx_gen.c
@@ -0,0 +1,61 @@
+// SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)
+/* Do not edit, regenerate with tools/ctlv/ctlv-regen.sh, from: */
+/*	Documentation/ctlv/specs/ctlv-attestation-tdx.yaml */
+/* CTLV-GEN kernel source */
+
+#define _CTLV_GENERATED_METADATA_ONLY
+#include <linux/array_size.h>
+#include <linux/build_bug.h>
+#include <linux/ctlv_family.h>
+#include <linux/export.h>
+
+#include <uapi/linux/ctlv_gen.h>
+#include <uapi/linux/ctlv_attestation_tdx_gen.h>
+
+#include "ctlv_attestation_tdx_gen.h"
+
+static const struct ctlv_node_schema device_info_fill_node_schemas[] = {
+	CTLV_NODE_SCHEMA_ROOT(1, 3, 3),
+	CTLV_NODE_SCHEMA_BINARY(CTLV_ATTESTATION_TDX_ATTR_INFO_MRCONFIGID, 1, 48, 48),
+	CTLV_NODE_SCHEMA_BINARY(CTLV_ATTESTATION_TDX_ATTR_INFO_MROWNER, 1, 48, 48),
+	CTLV_NODE_SCHEMA_BINARY(CTLV_ATTESTATION_TDX_ATTR_INFO_MROWNERCONFIG, 1, 48, 48),
+};
+
+/* The extension points this family fills. */
+static const struct ctlv_stub_fill_schema ctlv_attestation_tdx_stub_fill_schemas[] = {
+	CTLV_STUB_FILL_SCHEMA(CTLV_FAMILY_ATTESTATION, CTLV_ATTESTATION_SET_DEVICE_INFO,
+			      device_info),
+};
+
+/* The family ID is its position in the central registry. */
+const struct ctlv_family_schema ctlv_attestation_tdx_schema = {
+	.name = "ctlv-attestation-tdx",
+	.family_id = 2,
+	.stub_fill_schemas = ctlv_attestation_tdx_stub_fill_schemas,
+	.stub_fill_schemas_count = ARRAY_SIZE(ctlv_attestation_tdx_stub_fill_schemas),
+};
+
+/* Maximum uevent cost for this family chain. */
+static_assert(150 <= CTLV_UEVENT_MAX_LEN);
+static_assert(5 <= CTLV_UEVENT_MAX_VARS);
+
+/* Extension-point callbacks. */
+static const struct ctlv_stub_ops ctlv_attestation_tdx_stub_ops[] = {
+	CTLV_STUB_OPS(CTLV_FAMILY_ATTESTATION, CTLV_ATTESTATION_SET_DEVICE_INFO,
+		      ctlv_attestation_tdx_device_info),
+};
+
+/* Family descriptor used by ctlv_create(). */
+const struct ctlv_family ctlv_attestation_tdx_family = {
+	.schema = &ctlv_attestation_tdx_schema,
+	.parent = &ctlv_attestation_family,
+	.pre = ctlv_attestation_tdx_op_pre,
+	.post = ctlv_attestation_tdx_op_post,
+	.priv_size = ctlv_attestation_tdx_priv_size,
+	.pre_init = ctlv_attestation_tdx_pre_init,
+	.init = ctlv_attestation_tdx_init,
+	.fini = ctlv_attestation_tdx_fini,
+	.stub_ops = ctlv_attestation_tdx_stub_ops,
+	.stub_ops_count = ARRAY_SIZE(ctlv_attestation_tdx_stub_ops),
+};
+EXPORT_SYMBOL_NS_GPL(ctlv_attestation_tdx_family, "CTLV");
diff --git a/drivers/attestation/generated/ctlv_attestation_tdx_gen.h b/drivers/attestation/generated/ctlv_attestation_tdx_gen.h
new file mode 100644
index 000000000000..d182d04cb086
--- /dev/null
+++ b/drivers/attestation/generated/ctlv_attestation_tdx_gen.h
@@ -0,0 +1,66 @@
+/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause) */
+/* Do not edit, regenerate with tools/ctlv/ctlv-regen.sh, from: */
+/*	Documentation/ctlv/specs/ctlv-attestation-tdx.yaml */
+/* CTLV-GEN kernel header */
+
+/* Kernel metadata and family API of the ctlv-attestation-tdx CTLV family. */
+
+#ifndef _LINUX_CTLV_ATTESTATION_TDX_GEN_H
+#define _LINUX_CTLV_ATTESTATION_TDX_GEN_H
+
+#include <linux/ctlv_family.h>
+#include <linux/err.h>
+#include <linux/errno.h>
+
+#include <uapi/linux/ctlv_attestation_tdx_gen.h>
+
+#include "ctlv_attestation_gen.h"
+
+extern const struct ctlv_family_schema ctlv_attestation_tdx_schema;
+
+/* Family-wide hooks around every effective non-core op. */
+int ctlv_attestation_tdx_op_pre(void *priv, struct ctlv_op_ctx *ctx);
+void ctlv_attestation_tdx_op_post(void *priv, struct ctlv_op_ctx *ctx);
+
+/* Core-allocated family priv lifecycle. */
+size_t ctlv_attestation_tdx_priv_size(void);
+const void *ctlv_attestation_tdx_pre_init(const void *init_info);
+int ctlv_attestation_tdx_init(struct ctlv_device *ctlvdev, const void *init_info, void *priv);
+void ctlv_attestation_tdx_fini(struct ctlv_device *ctlvdev, void *priv);
+
+/* device-info of ctlv-attestation: fill callback. */
+int ctlv_attestation_tdx_device_info_fill(void *priv, struct ctlv_op_ctx *ctx,
+					  const struct ctlv_cursor *request,
+					  struct ctlv_cursor *nest);
+
+extern const struct ctlv_family ctlv_attestation_tdx_family;
+
+#ifndef _CTLV_GENERATED_METADATA_ONLY
+
+/* Reading a validated message. A blob has a resolver instead of a getter. */
+CTLV_IN_REF(ctlv_attestation_tdx_device_info_info_mrconfigid,
+	    &ctlv_attestation_tdx_schema.stub_fill_schemas[0].members,
+	    CTLV_ATTESTATION_TDX_ATTR_INFO_MRCONFIGID, 0, 0, CTLV_SCHEMA_BINARY)
+CTLV_IN_HAS(ctlv_attestation_tdx_device_info_info_mrconfigid)
+CTLV_IN_BINARY(ctlv_attestation_tdx_device_info_info_mrconfigid)
+CTLV_IN_REF(ctlv_attestation_tdx_device_info_info_mrowner,
+	    &ctlv_attestation_tdx_schema.stub_fill_schemas[0].members,
+	    CTLV_ATTESTATION_TDX_ATTR_INFO_MROWNER, 0, 1, CTLV_SCHEMA_BINARY)
+CTLV_IN_HAS(ctlv_attestation_tdx_device_info_info_mrowner)
+CTLV_IN_BINARY(ctlv_attestation_tdx_device_info_info_mrowner)
+CTLV_IN_REF(ctlv_attestation_tdx_device_info_info_mrownerconfig,
+	    &ctlv_attestation_tdx_schema.stub_fill_schemas[0].members,
+	    CTLV_ATTESTATION_TDX_ATTR_INFO_MROWNERCONFIG, 0, 2, CTLV_SCHEMA_BINARY)
+CTLV_IN_HAS(ctlv_attestation_tdx_device_info_info_mrownerconfig)
+CTLV_IN_BINARY(ctlv_attestation_tdx_device_info_info_mrownerconfig)
+
+/* Writing a reply. An append is atomic; a nest ends with ctlv_nest_end(). */
+CTLV_PUT_BINARY(ctlv_attestation_tdx_info_mrconfigid, CTLV_ATTESTATION_TDX_ATTR_INFO_MRCONFIGID,
+		CTLV_SCHEMA_BINARY)
+CTLV_PUT_BINARY(ctlv_attestation_tdx_info_mrowner, CTLV_ATTESTATION_TDX_ATTR_INFO_MROWNER,
+		CTLV_SCHEMA_BINARY)
+CTLV_PUT_BINARY(ctlv_attestation_tdx_info_mrownerconfig,
+		CTLV_ATTESTATION_TDX_ATTR_INFO_MROWNERCONFIG, CTLV_SCHEMA_BINARY)
+#endif /* _CTLV_GENERATED_METADATA_ONLY */
+
+#endif /* _LINUX_CTLV_ATTESTATION_TDX_GEN_H */
diff --git a/include/uapi/linux/ctlv_attestation_tdx_gen.h b/include/uapi/linux/ctlv_attestation_tdx_gen.h
new file mode 100644
index 000000000000..04c8dbc3d07c
--- /dev/null
+++ b/include/uapi/linux/ctlv_attestation_tdx_gen.h
@@ -0,0 +1,44 @@
+/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause) */
+/* Do not edit, regenerate with tools/ctlv/ctlv-regen.sh, from: */
+/*	Documentation/ctlv/specs/ctlv-attestation-tdx.yaml */
+/* CTLV-GEN uapi header */
+
+/*
+ * Constants of the ctlv-attestation-tdx CTLV family. Attr and op IDs are complete; the wire format
+ * carrying them is in <linux/ctlv.h>.
+ *
+ * The inherited ctlv-attestation header is included here, so one include covers the whole effective
+ * schema.
+ */
+
+#ifndef _UAPI_LINUX_CTLV_ATTESTATION_TDX_GEN_H
+#define _UAPI_LINUX_CTLV_ATTESTATION_TDX_GEN_H
+
+#include <linux/ctlv.h>
+#include <linux/ctlv_attestation_gen.h>
+#include <linux/ctlv_families_gen.h>
+
+/* attr groups */
+enum _ctlv_attestation_tdx_group {
+	CTLV_ATTESTATION_TDX_GROUP_INFO = 1,
+};
+
+#define _CTLV_ATTESTATION_TDX_ATTR(_group, _attr) \
+	CTLV_ATTR(CTLV_FAMILY_ATTESTATION_TDX, (_group), (_attr))
+
+/* attrs of group info */
+#define _CTLV_ATTESTATION_TDX_ATTR_INFO(_attr) \
+	_CTLV_ATTESTATION_TDX_ATTR(CTLV_ATTESTATION_TDX_GROUP_INFO, \
+				   _CTLV_ATTESTATION_TDX_ATTR_INFO_##_attr)
+
+enum _ctlv_attestation_tdx_attr_info {
+	_CTLV_ATTESTATION_TDX_ATTR_INFO_MRCONFIGID = 1,
+	_CTLV_ATTESTATION_TDX_ATTR_INFO_MROWNER,
+	_CTLV_ATTESTATION_TDX_ATTR_INFO_MROWNERCONFIG,
+};
+
+#define CTLV_ATTESTATION_TDX_ATTR_INFO_MRCONFIGID _CTLV_ATTESTATION_TDX_ATTR_INFO(MRCONFIGID)
+#define CTLV_ATTESTATION_TDX_ATTR_INFO_MROWNER _CTLV_ATTESTATION_TDX_ATTR_INFO(MROWNER)
+#define CTLV_ATTESTATION_TDX_ATTR_INFO_MROWNERCONFIG _CTLV_ATTESTATION_TDX_ATTR_INFO(MROWNERCONFIG)
+
+#endif /* _UAPI_LINUX_CTLV_ATTESTATION_TDX_GEN_H */
diff --git a/include/uapi/linux/ctlv_families_gen.h b/include/uapi/linux/ctlv_families_gen.h
index 2ea3068868be..25c90509d8ad 100644
--- a/include/uapi/linux/ctlv_families_gen.h
+++ b/include/uapi/linux/ctlv_families_gen.h
@@ -11,6 +11,7 @@
 enum _ctlv_family {
 	CTLV_FAMILY_ROOT,
 	CTLV_FAMILY_ATTESTATION,
+	CTLV_FAMILY_ATTESTATION_TDX,
 };
 
 #endif /* _UAPI_LINUX_CTLV_FAMILIES_GEN_H */
-- 
2.56.0

