Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D45194FDE4F
	for <kvm@vger.kernel.org>; Mon,  7 Sep 2026 15:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788796631; cv=none; b=ThtksC7IRU5I9WahPs26c7l7Szddr7iNtaIoMKCkBzZxJfUKvWF8tht+lNMeZdjgm3Wq0Wg67esEs5NW5FKPPEOt8kniJtGMdzq1BQ7ZttaGyGRkZlZ+AwRKcbTHpYEkMoN8rFB0TnY7g0xFRG/xg9tHxqkO7o0VW7HnZnM/s3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788796631; c=relaxed/simple;
	bh=kbNwhZz8ozt4jaEWIOvEfhE6u1HUXbdWUI8HSgN6/os=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=exaay+kuG0Kok8bFJaUK/dz/WXXKP39mZDISD/k8SGQKu3vkluA82mqH3SoHRxxlk78wEg7EBfT1VCFjkdILfTptE2vy2Yv0lLz9PpI5LqzKmZL6cS7SHIoB8pefpx8J5K5O3tlFzROeyv6+ki6vAkRH1sjY4Z/s7ycUwASYZ6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VLIFJenq; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=FLFEMxq+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VLIFJenq";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="FLFEMxq+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788796629;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8EQ1Hp/5/EcMqD759ADXm85y9O+auBS8uFJpNUQOG/o=;
	b=VLIFJenqj0WSljKs8QlCauDeOeY/wALOsF1ILJktvPChoWzo8W7Qiw4WyqvrE0Fe1O4ciM
	jeu0xnhk3Tqv4BSh+3/aVXSfeNjIdhcTp06z/XJxgwqDQJIJ2Yo4uOLHAb1odOeNUQF/7y
	cgjZMdjMOkQcG4pGAT/dLLZKoPyB7To=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-685-LY10HDoENECCbILpn1yU0Q-1; Mon, 07 Sep 2026 11:57:07 -0400
X-MC-Unique: LY10HDoENECCbILpn1yU0Q-1
X-Mimecast-MFC-AGG-ID: LY10HDoENECCbILpn1yU0Q_1788796627
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-49cc954a3edso29247285e9.2
        for <kvm@vger.kernel.org>; Mon, 07 Sep 2026 08:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788796626; x=1789401426; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8EQ1Hp/5/EcMqD759ADXm85y9O+auBS8uFJpNUQOG/o=;
        b=FLFEMxq+XOe50GgFtQwamF6ZiEhCdfUVpVW/HDXB9CWLmvcPtyo4Yu7vDjrCvH1UfK
         4mg+TGc/sZ+LnP2J3rbBDiauRPgB7dQ7gm9YE0eUVsMW02+SfAwwdOIWdXWf49BiQbGC
         OGya1wKxdjs6hRFCaNfV//9Cj1pazNuQewewdt5/sT9hU6jL8CruBLRqw7j2buFJQ5YO
         a1hO99uq/ZcUs3jE020UjIKBcmh9OMYKXv2LCrcrp7T3+uIUcz8yQCvSifziZeG9Jv0s
         EMPfdb7Olo251AdkEW45pW/fJfAfGZcLYui529No6rm8t1caP2oQpCBp902t0h+P0Hbp
         GrFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788796626; x=1789401426;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8EQ1Hp/5/EcMqD759ADXm85y9O+auBS8uFJpNUQOG/o=;
        b=ZI+NGAhr7cECL/kj9JaBBq3ZbS/b4YB9vlphG4jG/GAdcH+zYSeXofjKc0PF7Btvco
         TIfPtippYr+4djKngZOZCTElYtvaOTE3Vl1ji4TTstMTScKhkJj2fZPKATBig2R75Cfi
         FsDKuePaWT5ZywOvwv/OcPT3bviLRVKuTMWXtF5pRzrx3EfI+etjDNnl34EwSOrM+7dk
         geKv/pAZAWMN4ZHdUB8FNbwIF0xT5uCuWpEP6W8QiewRGuH/eu9gdNnxA/ImkGiKcAeZ
         56SJrSGVYL/tHcOxDTuOTd1QDyY4nstnp3cfw4yMxA1zVoI93qr8/NPMoiADZAd5X7lm
         LJew==
X-Forwarded-Encrypted: i=1; AKwUvBxiMirKWsdR/C7K+ig35ZlzWe0vMI6o166b22R6k8pWrAqnj8LCpmUpZJkdEZHueWgLP9s=@vger.kernel.org
X-Gm-Message-State: AFuF++ltqWp23oHkWfNvngpZSLYiy11nAZnBmoPLTbABFvAoIOl/kM3J
	lDRKDY3dPcd7mUyXITyd7Z8anIGutRuW7kjzB+P6Y9P8d6J8EwBZGfqmFdS+exmkYrArmVUET0T
	jovwawPeBh18/GLWSqXBJ2Y71gx9aP3S8Hf2jF+dId6ZDUnVu6Ke10w==
X-Gm-Gg: AYBFou3ORe117th8/hLD+GHP6PtH04p4VU7+mlhT6ag4OZKnjL3Ah0IGOWh6vBOxPrF
	0CDrlpWKEKG6FbmpHWQcFQAjbTqHJrCFaa63NQtGZGuJ4dtarNGnKn0PttczLNgA3JS80ymb++x
	bxlWCD9mPRHpi8PvTYm7zBLR0ik+odXJKTTaUgBolpmSJZv+y7JqMp9YQV3qpdBGJW2bPxf3yq5
	/lpVARB9ZhZ1Il+M1vsWMFyGCNNwOVAB/sZujV1kUdMN2+20g1rOAx+8ho5xdwtft/i94Qv25oX
	FuncOTeAyUN8u4MuwkVEwICqypYJ6wpsB8+QrT9fS0n+vcq2IYWm3LZz0NToi59H4bP0Aqf7mfB
	KXC6hBTl7x1DPVShfIdF/vYae76tMHHmWg9BNnPyAJpLDmlmCciMEhVtdyjsh+yQCA/4r
X-Received: by 2002:a05:600c:c162:b0:49d:16dc:e721 with SMTP id 5b1f17b1804b1-49d16dce7aamr27511835e9.24.1788796626592;
        Mon, 07 Sep 2026 08:57:06 -0700 (PDT)
X-Received: by 2002:a05:600c:c162:b0:49d:16dc:e721 with SMTP id 5b1f17b1804b1-49d16dce7aamr27511415e9.24.1788796626179;
        Mon, 07 Sep 2026 08:57:06 -0700 (PDT)
Received: from lleonard-thinkpadx1carbongen13.rmtit.csb ([151.29.41.106])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cf755c22esm320477955e9.0.2026.09.07.08.57.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 08:57:05 -0700 (PDT)
From: Luigi Leonardi <leonardi@redhat.com>
Date: Mon, 07 Sep 2026 17:56:58 +0200
Subject: [PATCH v2 2/5] igvm: move set_id_block call into the SNP ID block
 directive handler
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260907-fix_igvm_policy-v2-2-c8c50f1dbfda@redhat.com>
References: <20260907-fix_igvm_policy-v2-0-c8c50f1dbfda@redhat.com>
In-Reply-To: <20260907-fix_igvm_policy-v2-0-c8c50f1dbfda@redhat.com>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, Ani Sinha <anisinha@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>, 
 Marcelo Tosatti <mtosatti@redhat.com>, 
 "Daniel P. Berrange" <berrange@redhat.com>, kvm@vger.kernel.org, 
 Luigi Leonardi <leonardi@redhat.com>
X-Mailer: b4 0.14.3

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
---
 backends/igvm.c | 80 ++++++++++++++++++++++++++++-----------------------------
 1 file changed, 40 insertions(+), 40 deletions(-)

diff --git a/backends/igvm.c b/backends/igvm.c
index 99304d6467..521560822a 100644
--- a/backends/igvm.c
+++ b/backends/igvm.c
@@ -778,6 +778,8 @@ static int qigvm_directive_snp_id_block(QIgvm *ctx, const uint8_t *header_data,
     ctx->id_block->version = IGVM_SEV_ID_BLOCK_VERSION;
     memcpy(ctx->id_block->ld, igvm_id->ld, sizeof(ctx->id_block->ld));
 
+    ctx->id_block->policy = ctx->sev_policy;
+
     ctx->id_auth->id_key_alg = igvm_id->id_key_algorithm;
     assert(sizeof(igvm_id->id_key_signature) <=
            sizeof(ctx->id_auth->id_block_sig));
@@ -805,6 +807,14 @@ static int qigvm_directive_snp_id_block(QIgvm *ctx, const uint8_t *header_data,
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
 
@@ -961,24 +971,8 @@ static int qigvm_supported_platform_compat_mask(QIgvm *ctx, Error **errp)
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
@@ -1040,6 +1034,34 @@ int qigvm_process_file(IgvmCfg *cfg, MachineState *machine_state,
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
@@ -1073,28 +1095,6 @@ int qigvm_process_file(IgvmCfg *cfg, MachineState *machine_state,
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
2.55.0

