Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792600368;
	b=O+lOKLkJUC5JXznGLHPjOB9po25Dn8t0OgmfZmsi4VYjA3QZhvuuqXmLg7vKpu+nvtJL
	 6Ly3hQzQY2kSTLBccfuiwWpc9GgJSdc8y5skbMOLJwESLdVOlr+jNGHYkh49TbqlAKnIW
	 ht7zT/IF8H4MSu2/xjTupiPBeNWhs8RdCRRkHb1APVRL/vzh8eNvDkkSz/WA6G4R8y1lx
	 zgwhSShg/Vg37FDy7NM7gGymTuCi0meG6GiW8MqJ6wdgwajebTN7Zf+umQCO1v5SQygVV
	 eVBQk+K4hrnw/Q2vBRaDfS6RCMHAlfNa1XQ71Woz2+bc+Ix5UBjY+dDya1yvZi8gdzA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792600368;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Scanned-By;
	bh=q2MrFdc6Sie1JbwGOY2VkttNuMrZ212OJNslhmZssDs=;
	b=vPFvr4KE/Upj/pC62vmWIL3e7Df3Et1rCV9PUsyDDG4l8I7dDH7yT2BbSKK/vVxqhhkS
	 NwPveAQwcRmqLUTygE1AxrRnL893sM2i4GUr3WY53b6vu5lTHkiMG+ysUrz+yzaMewFVi
	 ernKrX7SmgBs5Z/Ilo33GcvBmhxW16GPOEAA1ibaL35RTakdxS0mMChNCkq8y68LlJnG/
	 bNgFo0p755xUzPl9QH4NN6Pg5GCMKNJx8oXdD3Yk2MuqLoeCDGtrNImH0qHxPGkDKQyUo
	 eKP0547GSmFi8UayU32UNt/KGDbckmxwLzP1WGxcY7d6yhtgqFJrIlH6sO+ffKkUXUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=M86Tzh2o;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 406FE606A319
	for <kvm@vger.kernel.org>; Wed, 21 Oct 2026 16:32:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 406FE606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=M86Tzh2o
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792600367;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q2MrFdc6Sie1JbwGOY2VkttNuMrZ212OJNslhmZssDs=;
	b=M86Tzh2oBG0FMmnALk4pp/MYorgU/g2SCucqVC62EGB9pxuAKEiAqytvT+j7HnpOzqVne/
	Jqpfx+NLe01JYanXmViIqsVQyx47jUr8jHk1P7hStmI9tw7GzHjKWHkU6st7dw5JDSvUqE
	y2ll6MexCKa3KsUTbGXu9FLkYUV8bW4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-691-z1vvkXVMOdSkHPsDkU7_6A-1; Wed,
 21 Oct 2026 16:32:43 +0000
X-MC-Unique: z1vvkXVMOdSkHPsDkU7_6A-1
X-Mimecast-MFC-AGG-ID: z1vvkXVMOdSkHPsDkU7_6A_1792600362
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AF4E41956094;
	Wed, 21 Oct 2026 16:32:42 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.44.48.54])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D849A5BC;
	Wed, 21 Oct 2026 16:32:41 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
	id 668911827590; Wed, 21 Oct 2026 18:32:39 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org,
	Stefano Garzarella <sgarzare@redhat.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Markus Armbruster <armbru@redhat.com>,
	=?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
	Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
	Zhao Liu <zhao1.liu@intel.com>,
	Ani Sinha <anisinha@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Eric Blake <eblake@redhat.com>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Luigi Leonardi <leonardi@redhat.com>
Subject: [PULL 02/10] igvm: move set_id_block call into the SNP ID block directive handler
Date: Wed, 21 Oct 2026 18:32:30 +0200
Message-ID: <20261021163239.1131460-3-kraxel@redhat.com>
In-Reply-To: <20261021163239.1131460-1-kraxel@redhat.com>
References: <20261021163239.1131460-1-kraxel@redhat.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

From: Luigi Leonardi <leonardi@redhat.com>

set_id_block only makes sense when the IGVM file contains an
IGVM_VHT_SNP_ID_BLOCK directive. Move the call from qigvm_handle_policy
(which continues to handle the set_guest_policy call) into
qigvm_directive_snp_id_block, where the ID block and ID auth are
populated. This avoids a no-op call to set_id_block when no ID block
is present.

The ID block embeds the guest policy, so the policy must be known by the
time the directive is handled. Process the initialization section (which
carries the GUEST_POLICY header) before the directive section, and
copy ctx->sev_policy into the ID block in the directive handler.

Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
Message-ID: <20260907-fix_igvm_policy-v2-2-c8c50f1dbfda@redhat.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 backends/igvm.c | 80 ++++++++++++++++++++++++-------------------------
 1 file changed, 40 insertions(+), 40 deletions(-)

diff --git a/backends/igvm.c b/backends/igvm.c
index 1aa6803cfa25..2ee60ada94b9 100644
--- a/backends/igvm.c
+++ b/backends/igvm.c
@@ -821,6 +821,8 @@ static int qigvm_directive_snp_id_block(QIgvm *ctx, const uint8_t *header_data,
     ctx->id_block->version = IGVM_SEV_ID_BLOCK_VERSION;
     memcpy(ctx->id_block->ld, igvm_id->ld, sizeof(ctx->id_block->ld));
 
+    ctx->id_block->policy = ctx->sev_policy;
+
     ctx->id_auth->id_key_alg = igvm_id->id_key_algorithm;
     assert(sizeof(igvm_id->id_key_signature) <=
            sizeof(ctx->id_auth->id_block_sig));
@@ -848,6 +850,14 @@ static int qigvm_directive_snp_id_block(QIgvm *ctx, const uint8_t *header_data,
     memcpy(&ctx->id_auth->author_key[76], &igvm_id->author_public_key.qy,
             72);
 
+    if (ctx->cgsc) {
+        return ctx->cgsc->set_id_block(ctx->id_block,
+                                       sizeof(struct sev_id_block),
+                                       ctx->id_auth,
+                                       sizeof(struct sev_id_authentication),
+                                       errp);
+    }
+
     return 0;
 }
 
@@ -1004,24 +1014,8 @@ static int qigvm_supported_platform_compat_mask(QIgvm *ctx, Error **errp)
 static int qigvm_handle_policy(QIgvm *ctx, Error **errp)
 {
     if (ctx->platform_type == IGVM_PLATFORM_TYPE_SEV_SNP) {
-        int id_block_len = 0;
-        int id_auth_len = 0;
-        int retval;
-
-        if (ctx->id_block) {
-            ctx->id_block->policy = ctx->sev_policy;
-            id_block_len = sizeof(struct sev_id_block);
-            id_auth_len = sizeof(struct sev_id_authentication);
-        }
-
-        retval = ctx->cgsc->set_guest_policy(GUEST_POLICY_SEV, ctx->sev_policy,
-                                             errp);
-        if (retval < 0) {
-            return retval;
-        }
-
-        return ctx->cgsc->set_id_block(ctx->id_block, id_block_len,
-                                       ctx->id_auth, id_auth_len, errp);
+        return ctx->cgsc->set_guest_policy(GUEST_POLICY_SEV, ctx->sev_policy,
+                                           errp);
     }
     return 0;
 }
@@ -1083,6 +1077,34 @@ int qigvm_process_file(IgvmCfg *cfg, MachineState *machine_state,
         goto cleanup;
     }
 
+    /*
+     * Process the initialization section first so that the guest policy is
+     * known before the directive section is handled. The SNP ID block
+     * directive embeds the guest policy into the ID block, so the policy from
+     * the guest policy initialization header must be available by then.
+     */
+    header_count =
+        igvm_header_count(ctx.cfg->file, IGVM_HEADER_SECTION_INITIALIZATION);
+    if (header_count < 0) {
+        error_setg(
+            errp,
+            "Invalid initialization header count in IGVM file. Error code: %X",
+            header_count);
+        goto cleanup;
+    }
+
+    for (ctx.current_header_index = 0;
+         ctx.current_header_index < (unsigned)header_count;
+         ctx.current_header_index++) {
+        IgvmVariableHeaderType type =
+            igvm_get_header_type(ctx.cfg->file,
+                                 IGVM_HEADER_SECTION_INITIALIZATION,
+                                 ctx.current_header_index);
+        if (qigvm_handler(&ctx, type, errp) < 0) {
+            goto cleanup;
+        }
+    }
+
     header_count = igvm_header_count(ctx.cfg->file,
                                      IGVM_HEADER_SECTION_DIRECTIVE);
     if (header_count <= 0) {
@@ -1116,28 +1138,6 @@ int qigvm_process_file(IgvmCfg *cfg, MachineState *machine_state,
         goto cleanup_parameters;
     }
 
-    header_count =
-        igvm_header_count(ctx.cfg->file, IGVM_HEADER_SECTION_INITIALIZATION);
-    if (header_count < 0) {
-        error_setg(
-            errp,
-            "Invalid initialization header count in IGVM file. Error code: %X",
-            header_count);
-        goto cleanup_parameters;
-    }
-
-    for (ctx.current_header_index = 0;
-         ctx.current_header_index < (unsigned)header_count;
-         ctx.current_header_index++) {
-        IgvmVariableHeaderType type =
-            igvm_get_header_type(ctx.cfg->file,
-                                 IGVM_HEADER_SECTION_INITIALIZATION,
-                                 ctx.current_header_index);
-        if (qigvm_handler(&ctx, type, errp) < 0) {
-            goto cleanup_parameters;
-        }
-    }
-
     /*
      * Contiguous pages of data with compatible flags are grouped together in
      * order to reduce the number of memory regions we create. Make sure the
-- 
2.56.0

