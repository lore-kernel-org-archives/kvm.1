Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C9804A482E
	for <kvm@vger.kernel.org>; Thu,  3 Sep 2026 12:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788440283; cv=none; b=DoSdGGjp8MV4PpZn1Xjran+ihS9DzMsys2EVTSXSsaxEpuG7AMSqG8HmZl0gSeSLGFHtChRzD500AriTimxTObhilV6HKymypMKdxAV2RdtBTxHhjMVhh+ceobxbSdgPCtte1BHMozo4lAd5uTIcJGuNvB3/d5zzmJb28rsm0ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788440283; c=relaxed/simple;
	bh=UECByAsiLsg8VzQtIyDKYKguG/+f168CyeSsBDdvyy8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FqHjEzVon5LUcUDJP3Q1n1jNvjyURHCSl4UhuBG/+BhL9dyokvodwPv9U1AN7R1D/1/R+rjOAsSu3pXWQHvyeOO62MOlx8/s5JxrWihjfZCZDKIIoe1aRQF/an+x6+7Dc1BnFs8jXmapIODTs3akRHnh8fIzNp9BYZrrDu8tlhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QYK4TVQg; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=DjfFpeZ/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QYK4TVQg";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="DjfFpeZ/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788440280;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dFw4kmpiXgnJgYg/MdJcXbpa7WDv+OilNPqzeDo4f/c=;
	b=QYK4TVQgoRTg0NEVSzybgwn2cugajmmQWnrIRUnvUOjl5S9RTxVM0dytGeJsgvObrk/Y8+
	Dzk7aK5ewkR/uns0ydN84c4ZRMt/jM9P4pVXM2xqmNNt3wN8CVFE1wAy2EkTQguO879hxy
	MNLBzA9dvqdv9JoOHREovT7ywHEQ4BM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-131-9_xFd_ZlOZ6VZxRzkD1mQg-1; Thu, 03 Sep 2026 08:57:57 -0400
X-MC-Unique: 9_xFd_ZlOZ6VZxRzkD1mQg-1
X-Mimecast-MFC-AGG-ID: 9_xFd_ZlOZ6VZxRzkD1mQg_1788440276
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-49ccb223bceso6316545e9.0
        for <kvm@vger.kernel.org>; Thu, 03 Sep 2026 05:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788440276; x=1789045076; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dFw4kmpiXgnJgYg/MdJcXbpa7WDv+OilNPqzeDo4f/c=;
        b=DjfFpeZ/XkPdkDcJnPrbDWKpkNiv/YeBmGEEVJZWxLzDpjnP/x9n80IH5oXk7LAlxk
         uiSOGEblLl1/Ok7FCPtKZd860Xidw407KUQV84N/CxPDrCGS3fqt9LBTNUT/QBANkOog
         9ZvQkSQPci0lhPQdJdv5oeiUd+LoRYBHYEnHm9P9TU5IblF3tF4v0Kk8Q4S4JLrf6XP0
         O2oNQU3obayk2OGMQntZvcCkceOr2xnSWvvMWpKvA4ljpKjqP8cXc3TbquiL0DIa0bXy
         u7Hu26yxtCztdsTOTyD32mADFvkTxNYtl9nGxBi/959gcXralEvrELOSaYYs7BDO7aED
         FgFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788440276; x=1789045076;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dFw4kmpiXgnJgYg/MdJcXbpa7WDv+OilNPqzeDo4f/c=;
        b=n5MCGHah1WBJ+CreEw2XK/qaDC6DLSOnFCw9amZLonPDzOUhEhg4uo2FGeuo4MRR9i
         zxxn4LClHQKzysRf1VUw/+asNypuJ/RLkDlpGsN3y+/qRm8E4nJEcVzf6kweS3wT3NA8
         ELE9gqCEOjFE9wHlYDVM62uB/0bXhBvFs2El+jZWa85wnMYyOVOg5I6i3IYcD06qzps4
         QQUcqhNlRZn/38arWTv2jg5iNHQDFRfCFBoxsUz4vm/aTkxaaeqqlLuvJ+tzDtUJhnRH
         HdGk16XeogOUnVevUMdHdol8g/PbYEKR6Zaj3HabP92QBQvlNfl+GKjfCzsDtW/MCp9z
         DgMg==
X-Forwarded-Encrypted: i=1; AKwUvBy7Ad0rlh1+c7uFWVzzn05DG2bJ8xtzXetoYT2xIuwLvcA9WwWi3W6oapSyV4dxScpvaWU=@vger.kernel.org
X-Gm-Message-State: AFuF++lS2Xt2nhBz7nL/GXJzWGkqGdxbvThw8KcUc/g48ki10x102oe7
	fyTLO4NquXtMgdd1Vazve0lywMxGt1CbmpAeNQmp2lIanAuXPugUC7bN+AM4vKnbViIpBQWlEaA
	tLZdkS011xeFVNtSL0kATOWBKoeIJWIgiT+mw9xy6YEvbFEwDJ03pEQ==
X-Gm-Gg: AYBFou1aY1Mj2FzC02whk//qOIlTqo0QOGqGPvpMKinN5NxnzBSWcwcI77lYPm8IPLr
	mWOgy58LjGKwRCKzva+Tba5sWCeDDuo2RCR/QrRoJVk4wuP6Gjcqbf3AbjBAHdhXqtDjLU27jat
	dE3fA758IT0e2ut/mX9lEgl7olVwpUoSkaRCYt/+HwHuI3eVw7m2qAxc+HuZ55wA0204cddAS3J
	kT8EDQqJ9wFXuX6W9JYQHmOI1gfRySexp5G4v7D35u+RQVYtv0KL3MLporKXyB/E9xVAUeGHAZx
	UhYhIBVaJgsSDsTeFxz+fWHNNIYIFy8Q09p1wkFk81S6QvF4W7jzBUZxopImDppZESc+Vfti2jU
	66H7Ru2jDQdsWv75dp9KAk8FjLjq/ybBkeKOiq73WK+bReg==
X-Received: by 2002:a05:600c:46c6:b0:49c:799a:177b with SMTP id 5b1f17b1804b1-49cf1576df1mr34980945e9.2.1788440276346;
        Thu, 03 Sep 2026 05:57:56 -0700 (PDT)
X-Received: by 2002:a05:600c:46c6:b0:49c:799a:177b with SMTP id 5b1f17b1804b1-49cf1576df1mr34980545e9.2.1788440275769;
        Thu, 03 Sep 2026 05:57:55 -0700 (PDT)
Received: from sgarzare-redhat (host-79-53-30-11.retail.telecomitalia.it. [79.53.30.11])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49ce58da3acsm259684435e9.0.2026.09.03.05.57.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 05:57:55 -0700 (PDT)
Date: Thu, 3 Sep 2026 14:57:44 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Luigi Leonardi <leonardi@redhat.com>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, 
	Ani Sinha <anisinha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Zhao Liu <zhao1.liu@intel.com>, Marcelo Tosatti <mtosatti@redhat.com>, kvm@vger.kernel.org
Subject: Re: [PATCH 2/4] igvm: move set_id_block call into the SNP ID block
 directive handler
Message-ID: <aplM8ZVCrsjuELHT@sgarzare-redhat>
References: <20260901-fix_igvm_policy-v1-0-e93a6cf8c5ac@redhat.com>
 <20260901-fix_igvm_policy-v1-2-e93a6cf8c5ac@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260901-fix_igvm_policy-v1-2-e93a6cf8c5ac@redhat.com>

On Tue, Sep 01, 2026 at 12:09:19PM +0200, Luigi Leonardi wrote:
>set_id_block only makes sense when the IGVM file contains an
>IGVM_VHT_SNP_ID_BLOCK directive. Move the call from the removed
>qigvm_handle_policy into qigvm_directive_snp_id_block, where the ID
>block and ID auth are populated. This avoids a no-op call to
>set_id_block when no ID block is present.
>
>The ID block embeds the guest policy, so the policy must be known by the
>time the directive is handled. Process the initialization section (which
>carries the GUEST_POLICY header) before the directive section, and
>copy ctx->sev_policy into the ID block in the directive handler.
>
>Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
>---
> backends/igvm.c | 81 +++++++++++++++++++++++++++------------------------------
> 1 file changed, 38 insertions(+), 43 deletions(-)
>
>diff --git a/backends/igvm.c b/backends/igvm.c
>index 85de0d54ec..6545382546 100644
>--- a/backends/igvm.c
>+++ b/backends/igvm.c
>@@ -778,6 +778,8 @@ static int qigvm_directive_snp_id_block(QIgvm *ctx, const uint8_t *header_data,
>     ctx->id_block->version = IGVM_SEV_ID_BLOCK_VERSION;
>     memcpy(ctx->id_block->ld, igvm_id->ld, sizeof(ctx->id_block->ld));
>
>+    ctx->id_block->policy = ctx->sev_policy;

Is it fine to copy the sev_policy in the id_block in any case?

I mean, what happen if IGVM_VHT_GUEST_POLICY is not in the IGVM file, so 
IIUC sev_policy is 0, but the user set the policy by the CLI?

Maybe this was pre-existing and handled in the next patches.

Thanks,
Stefano

>+
>     ctx->id_auth->id_key_alg = igvm_id->id_key_algorithm;
>     assert(sizeof(igvm_id->id_key_signature) <=
>            sizeof(ctx->id_auth->id_block_sig));
>@@ -805,6 +807,14 @@ static int qigvm_directive_snp_id_block(QIgvm *ctx, const uint8_t *header_data,
>     memcpy(&ctx->id_auth->author_key[76], &igvm_id->author_public_key.qy,
>             72);
>
>+    if (ctx->cgsc) {
>+        return ctx->cgsc->set_id_block(ctx->id_block,
>+                                       sizeof(struct sev_id_block),
>+                                       ctx->id_auth,
>+                                       sizeof(struct sev_id_authentication),
>+                                       errp);
>+    }
>+
>     return 0;
> }
>
>@@ -958,23 +968,6 @@ static int qigvm_supported_platform_compat_mask(QIgvm *ctx, Error **errp)
>     return 0;
> }
>
>-static int qigvm_handle_policy(QIgvm *ctx, Error **errp)
>-{
>-    if (ctx->platform_type == IGVM_PLATFORM_TYPE_SEV_SNP) {
>-        int id_block_len = 0;
>-        int id_auth_len = 0;
>-        if (ctx->id_block) {
>-            ctx->id_block->policy = ctx->sev_policy;
>-            id_block_len = sizeof(struct sev_id_block);
>-            id_auth_len = sizeof(struct sev_id_authentication);
>-        }
>-
>-        return ctx->cgsc->set_id_block(ctx->id_block, id_block_len,
>-                                       ctx->id_auth, id_auth_len, errp);
>-    }
>-    return 0;
>-}
>-
> IgvmHandle qigvm_file_init(char *filename, Error **errp)
> {
>     IgvmHandle igvm;
>@@ -1032,6 +1025,34 @@ int qigvm_process_file(IgvmCfg *cfg, MachineState *machine_state,
>         goto cleanup;
>     }
>
>+    /*
>+     * Process the initialization section first so that the guest policy is
>+     * known before the directive section is handled. The SNP ID block
>+     * directive embeds the guest policy into the ID block, so the policy from
>+     * the guest policy initialization header must be available by then.
>+     */
>+    header_count =
>+        igvm_header_count(ctx.cfg->file, IGVM_HEADER_SECTION_INITIALIZATION);
>+    if (header_count < 0) {
>+        error_setg(
>+            errp,
>+            "Invalid initialization header count in IGVM file. Error code: %X",
>+            header_count);
>+        goto cleanup;
>+    }
>+
>+    for (ctx.current_header_index = 0;
>+         ctx.current_header_index < (unsigned)header_count;
>+         ctx.current_header_index++) {
>+        IgvmVariableHeaderType type =
>+            igvm_get_header_type(ctx.cfg->file,
>+                                 IGVM_HEADER_SECTION_INITIALIZATION,
>+                                 ctx.current_header_index);
>+        if (qigvm_handler(&ctx, type, errp) < 0) {
>+            goto cleanup;
>+        }
>+    }
>+
>     header_count = igvm_header_count(ctx.cfg->file,
>                                      IGVM_HEADER_SECTION_DIRECTIVE);
>     if (header_count <= 0) {
>@@ -1065,28 +1086,6 @@ int qigvm_process_file(IgvmCfg *cfg, MachineState *machine_state,
>         goto cleanup_parameters;
>     }
>
>-    header_count =
>-        igvm_header_count(ctx.cfg->file, IGVM_HEADER_SECTION_INITIALIZATION);
>-    if (header_count < 0) {
>-        error_setg(
>-            errp,
>-            "Invalid initialization header count in IGVM file. Error code: %X",
>-            header_count);
>-        goto cleanup_parameters;
>-    }
>-
>-    for (ctx.current_header_index = 0;
>-         ctx.current_header_index < (unsigned)header_count;
>-         ctx.current_header_index++) {
>-        IgvmVariableHeaderType type =
>-            igvm_get_header_type(ctx.cfg->file,
>-                                 IGVM_HEADER_SECTION_INITIALIZATION,
>-                                 ctx.current_header_index);
>-        if (qigvm_handler(&ctx, type, errp) < 0) {
>-            goto cleanup_parameters;
>-        }
>-    }
>-
>     /*
>      * Contiguous pages of data with compatible flags are grouped together in
>      * order to reduce the number of memory regions we create. Make sure the
>@@ -1094,10 +1093,6 @@ int qigvm_process_file(IgvmCfg *cfg, MachineState *machine_state,
>      */
>     retval = qigvm_process_mem_page(&ctx, NULL, errp);
>
>-    if (retval == 0) {
>-        retval = qigvm_handle_policy(&ctx, errp);
>-    }
>-
> cleanup_parameters:
>     QTAILQ_FOREACH(parameter, &ctx.parameter_data, next)
>     {
>
>-- 
>2.55.0
>

