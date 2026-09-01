Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0173313543
	for <kvm@vger.kernel.org>; Tue,  1 Sep 2026 10:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788257387; cv=none; b=V+j1qhh+u56Z9fY7rxUVQiMSWc0eW2d/ExODshCQc11D7cE8K4jVmXq7t4PovpJSe9+zfmO2vSrHFv1qmAgM8F1HjYTYZN6gSFbNj50OklxDwV/zBPJKj2ThMRu/0SlsMjUNOEi45+0ZBjpXA/En1tME6449a+Tg7gJeatYsl7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788257387; c=relaxed/simple;
	bh=yzEz5mFv54Yk5VAa/ub493f5d0Fpz7/uvmECPA9cCdo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UiAI20dwcrYZoNymgsmTiK/La0o6g7G5ud05z9sCygsNr1Y7KoxEzz29eyvnwE3lkBhjmV3Gny4UdwY7fH/VM5aO/A3CNmDOmWz0FoGqcD4d/QsVAT0EGahhgtASXnJfycb54QykPRB9pm6NpjwTaiZpBoI4qyxD3L7dIlzkxU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GCeNYd2r; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ADuoDn7U; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GCeNYd2r";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ADuoDn7U"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788257384;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ppz2K1vLw2zwdYGAd4h8De7d1adqi3oztEYlXl9z9H4=;
	b=GCeNYd2rJFjY0vSn7wbLxvJKB9zKaw0Iv8vjkWxGC8cxWasXbFIEYpDp7yDMhjI9IJRcv8
	8lY2MqgmvcYFe4tI3V+4Z/zyGt4xaSIppwW15wtxUgb19/F7cO+1ED94WUPJcpf9XTq5z3
	LuFwEbEv3t2ezkMririejkDKoJQjK+c=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-240-WqiVW6UHPrW2N7PfBetwUQ-1; Tue, 01 Sept 2026 06:09:33 -0400
X-MC-Unique: WqiVW6UHPrW2N7PfBetwUQ-1
X-Mimecast-MFC-AGG-ID: WqiVW6UHPrW2N7PfBetwUQ_1788257372
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-4843d9ab895so772390f8f.0
        for <kvm@vger.kernel.org>; Tue, 01 Sep 2026 03:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788257372; x=1788862172; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ppz2K1vLw2zwdYGAd4h8De7d1adqi3oztEYlXl9z9H4=;
        b=ADuoDn7UJs/e5Qlegvx1pt1FnV4iAn0P0G6QdJuEfAavNAg2E6SI/dYdW4KDuDCFLK
         H8DICZawyiE9Qt9WFWI4buW78g2u804art221hPEDoP2nPjWljXDqqhxfaZjyK0vaIh2
         JQSF6bXmGlHrrZuUT/Lzc178JbPdZxxoU+m9dSN1v7UR+EoEptbMsPYECId2BIQxfMKh
         z7JMhgdGPzp0N5K9MixnhiS8BFf8Wm+1NjZQ7JqyiER1s7kmELNgzDGwLOp7UBfi5Jo0
         LCxH2i5hO2dFwf+HG6Mj9989YRco/u95SrBo9AjBPHlx+RAbRBBqubIzvpzC+fgKgKL8
         jB3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788257372; x=1788862172;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ppz2K1vLw2zwdYGAd4h8De7d1adqi3oztEYlXl9z9H4=;
        b=lEzWVmfP7iSTzuTCis2hN5jIo2Xxt2ScnTqg+m0wR0IX9fqdiVLZO1S5GfxuKVBHaV
         sfPaRV8CUMsi13HapBAwWtkDZWLI1HV6Mjt4W59RmTHDah0fgfFVzm/wY4b39CfALElt
         ziqqdzwuG5RMdmbwcjwyVFdb9zpmfNMRWlOcQ5SC8guF9d+MCNtazDwBmr/7EV3Pu/Be
         pbJJJD0uWXnE8nY2izl0nUK/FAEdrSCsdugPQ+9BjNX/x9LT8tKlrQbvp42fItmuNJwa
         WH6gcbjIzt+enyuP9uctNBsP7S5vreN3iQ17StyTLVKAHj6zSdXR2XSrAxQg64sECWQs
         GCPA==
X-Forwarded-Encrypted: i=1; AKwUvBxe+iRW2Y0ah0YWvBbQsuw3/XzuVmNlTMf7BhidoBPRftc0QAcIa4Khzs9oZ8zF+Z8LgO8=@vger.kernel.org
X-Gm-Message-State: AFuF++nF1ZXx7SLXJPKP30Bsz26IBLTww0IacAbKW/hSUvZAj1VB6lzr
	D7K3LXIQQEQCczzHsn1wnT/XMpznuxeFBBhnehCPbXk82VKKVYu4tgCglgZKPNgShjpSS9KZCM9
	fLoyGFS+NuYKHkre2ibxg3+g1xd84z9uMalmyEuWYB7KXdfAY4qsXNULnf01sBGeD5lnIkWVKwW
	Q2DqpRZ9No7TnrcuKtpRUuHzizdbkQFQkb3WyQc6Pt
X-Gm-Gg: AYBFou0Mf5X1iHX6eo5XMv8f4M3o/aIWhAPzcX0RD6vjggtPOmiRyVAhuLtsDFwJ90G
	u8He6r3LkIP1N/HKXrfXTwR/oBE9UWafk0UP+hGSMHub8Ua3mSeCehPDCx1srxH46w7aBrbppvs
	aa/XmyBOOLI4RurCdQde4FYxcNl6KWJaj/hjEBBNZlK63gZuYNj7rP7bPyLhMkZoI7Q0BZ7Stl1
	UP+zt4KmCPPHUor/VVRei/cN1smYxABJ0nVGSwsuRMThWin46bcS55S6DAkRGJ3KTiWhJ/K9E/E
	f7U/WE58XO5VysbVZa57s5RRAa6cwfY9cErZTlLo3kfiFlf06I5KTEV98ue6hNQEy80DNf5v50i
	73fSCrkuya5Uox89aQXO2IAITP+fcvnh3t5J3cOPuFF7Ygbk/1yhicDrc+WAMrAU5khvM
X-Received: by 2002:a05:6000:2510:b0:483:ca4a:6b9d with SMTP id ffacd0b85a97d-483ca4a6d9cmr36047429f8f.20.1788257371944;
        Tue, 01 Sep 2026 03:09:31 -0700 (PDT)
X-Received: by 2002:a05:6000:2510:b0:483:ca4a:6b9d with SMTP id ffacd0b85a97d-483ca4a6d9cmr36047329f8f.20.1788257371394;
        Tue, 01 Sep 2026 03:09:31 -0700 (PDT)
Received: from lleonard-thinkpadx1carbongen13.rmtit.csb ([151.29.41.106])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48442d7c1c0sm3941620f8f.32.2026.09.01.03.09.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 03:09:30 -0700 (PDT)
From: Luigi Leonardi <leonardi@redhat.com>
Date: Tue, 01 Sep 2026 12:09:19 +0200
Subject: [PATCH 2/4] igvm: move set_id_block call into the SNP ID block
 directive handler
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260901-fix_igvm_policy-v1-2-e93a6cf8c5ac@redhat.com>
References: <20260901-fix_igvm_policy-v1-0-e93a6cf8c5ac@redhat.com>
In-Reply-To: <20260901-fix_igvm_policy-v1-0-e93a6cf8c5ac@redhat.com>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, Ani Sinha <anisinha@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>, 
 Marcelo Tosatti <mtosatti@redhat.com>, kvm@vger.kernel.org, 
 Luigi Leonardi <leonardi@redhat.com>
X-Mailer: b4 0.14.3

set_id_block only makes sense when the IGVM file contains an
IGVM_VHT_SNP_ID_BLOCK directive. Move the call from the removed
qigvm_handle_policy into qigvm_directive_snp_id_block, where the ID
block and ID auth are populated. This avoids a no-op call to
set_id_block when no ID block is present.

The ID block embeds the guest policy, so the policy must be known by the
time the directive is handled. Process the initialization section (which
carries the GUEST_POLICY header) before the directive section, and
copy ctx->sev_policy into the ID block in the directive handler.

Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
---
 backends/igvm.c | 81 +++++++++++++++++++++++++++------------------------------
 1 file changed, 38 insertions(+), 43 deletions(-)

diff --git a/backends/igvm.c b/backends/igvm.c
index 85de0d54ec..6545382546 100644
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
 
@@ -958,23 +968,6 @@ static int qigvm_supported_platform_compat_mask(QIgvm *ctx, Error **errp)
     return 0;
 }
 
-static int qigvm_handle_policy(QIgvm *ctx, Error **errp)
-{
-    if (ctx->platform_type == IGVM_PLATFORM_TYPE_SEV_SNP) {
-        int id_block_len = 0;
-        int id_auth_len = 0;
-        if (ctx->id_block) {
-            ctx->id_block->policy = ctx->sev_policy;
-            id_block_len = sizeof(struct sev_id_block);
-            id_auth_len = sizeof(struct sev_id_authentication);
-        }
-
-        return ctx->cgsc->set_id_block(ctx->id_block, id_block_len,
-                                       ctx->id_auth, id_auth_len, errp);
-    }
-    return 0;
-}
-
 IgvmHandle qigvm_file_init(char *filename, Error **errp)
 {
     IgvmHandle igvm;
@@ -1032,6 +1025,34 @@ int qigvm_process_file(IgvmCfg *cfg, MachineState *machine_state,
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
@@ -1065,28 +1086,6 @@ int qigvm_process_file(IgvmCfg *cfg, MachineState *machine_state,
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
@@ -1094,10 +1093,6 @@ int qigvm_process_file(IgvmCfg *cfg, MachineState *machine_state,
      */
     retval = qigvm_process_mem_page(&ctx, NULL, errp);
 
-    if (retval == 0) {
-        retval = qigvm_handle_policy(&ctx, errp);
-    }
-
 cleanup_parameters:
     QTAILQ_FOREACH(parameter, &ctx.parameter_data, next)
     {

-- 
2.55.0

