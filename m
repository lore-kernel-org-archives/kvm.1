Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 983AD511199
	for <kvm@vger.kernel.org>; Mon,  7 Sep 2026 15:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788796635; cv=none; b=P0sH/qrMfJgzZRqJuce6XMzWxzcLj2X9P7YrzuR207Yi31dw9qS2K4IPpzu5LqvBMJT/7COUdbYAfBEABPnlyVOcUOB6ZtvpJVA0F27ewMs7Nxi8U22igGPi8/71tWhp6CJrsKAYVjFJ+HYcd+N+Wg8v6vxTKuHKSI5P14XOeFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788796635; c=relaxed/simple;
	bh=rhzw1QmmMKLp01fMtqHaTte66tb5uGSZFh3uGCIM3PY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=i9+Iq3//qYGE/QkchA1qw0JwDM4l5YGijzlvWSewHo5Xmw+k0t8qtWuO8UEztx1yplgrctO2m3V4hceH1PMZkNgXJrFehbFwF6tr6uGRVe1Px8/BvqiVNA7CivPEu7aUtxDNt8w/eIKj8hJa9m5z76A3jdZo+8HcxakY7Kddfks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Hq7OvWiq; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=aVnTTkop; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hq7OvWiq";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="aVnTTkop"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788796632;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fQaiA+qhLoVzKtGnL0lSxJUvzGHQNtKK5icFkRaD4Dg=;
	b=Hq7OvWiqusThkDC+G1yOuDZOXWPx5kMio3YDiFctc3LZUpIMxaxBcVv3BrFo7cZzahcOk/
	c3bxK2qvPiYUxUbw0f9vXyKtEfAY5O5IUUlK9g6wJ+oPnUBRjFsR2fg8NjO5ZxLVQKk9HJ
	BzjpLizgi8ZtdsBe575WtBB6WE4rbIA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-KxPb0XULNwCoyhsF6LBn0A-1; Mon, 07 Sep 2026 11:57:11 -0400
X-MC-Unique: KxPb0XULNwCoyhsF6LBn0A-1
X-Mimecast-MFC-AGG-ID: KxPb0XULNwCoyhsF6LBn0A_1788796630
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-490a767c7dcso27378225e9.2
        for <kvm@vger.kernel.org>; Mon, 07 Sep 2026 08:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788796630; x=1789401430; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fQaiA+qhLoVzKtGnL0lSxJUvzGHQNtKK5icFkRaD4Dg=;
        b=aVnTTkop2v2NygB9I/Xa2Ei4vOD5/vgROms2YwG5YWqKMimrkzoytlmn2RrYg8/G4U
         arcS+rdEj7B18/tVGHfBeph+Ju+hInIyoQTY3dyVNi8mmJv4GR1E1tNZRUG1PKamrZVz
         SSB4ZChbPD5rT6Mp7PRWJPqUaoGO+9UwzjBAUyi9da2aHAcyg1YbceLl9HjNrHqv1Mgm
         8/1MgQqJqVYCOjPO3vc/1srvJJ098wLjW9xCg3r3fNl/cu3T5096r1QoStpPX/k9k2J2
         qctyLSMyYKgD3Noy2+zHejDKA16NYHAxmvIO5TIDlRlB/Fd9aywsYQM1+iPrQ1VND4wQ
         E/Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788796630; x=1789401430;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fQaiA+qhLoVzKtGnL0lSxJUvzGHQNtKK5icFkRaD4Dg=;
        b=HYYVlRS5ryET+R0SZZ5BlfPCONJP0V/PO3cQ1U9cOt0/JIvTYjxElFBpOX2zfsxw+l
         yUzr/G2LckOSgdG77R/Yb9kJndJiTEfMeLZM831cyY11GU+8+xfxUnaA8d1kyEVNk2ul
         zCrMreDn8Lg0Fi+xCmkQU/KaHB7uNgMTLgpDS75XF/ns//63P5oj4Mm+pdhQ1dKw7uLD
         u54KouxzYym4gcbENpHKfJaAohjV0DByWlvgYp1YtUt00XrvcDM7ZDMOoha+tHBIwEPy
         2lnvmGRPYeUfdBFJWNjBEcz5H+1Edpyk4h/K2ld74VsJQSvzVWzrqLODn3QVA7j9oKA9
         37/g==
X-Forwarded-Encrypted: i=1; AKwUvBxxKGCfzJa1YTBxP3XatnS5c7396DuuxA1pcOdrqbvEUy/Ybm/j4HLpP+7s4/zPbBDL/Bw=@vger.kernel.org
X-Gm-Message-State: AFuF++nmlY/NEz3ziPOWLQBaqMwmktgWhVcgvLeO6Sryj8sYEbhG4Rn4
	EOFaqULF60YSm2h9Sgq6hHjdyEDJcgCTAdJ9VgYI1KYTH+FGOuZqYv5k6Ld1QZ4QnY72fgKs+Zn
	PLWnWdO16ienlvF6z0bJ767iWHFpw0nrZ7juCnhdcieuXRp/Jq3k1lQ==
X-Gm-Gg: AYBFou1frElyazIXA0SfNDfeBZopCVaXohHoFMS2v6yJXIKBurza4u030xeGGbuBCx5
	xs3lJ3Rsj6zMd181TbP7qGg1lC5XpOaOYZg4eoxcg+TLj70639+tyiVrv2IlvhhJ6DVwY10eisg
	gYIkNKNobYzQ9O/AQTs44UFYa24W8P6Mn63oAI3XjFycQr3wrE/2yfhlgpFGusHtRZsHX00MeVf
	R+hpd8q91qQt+ogU1uyyASrLXDa940FZUDojq2JjS/w42N1npmlGyPujymQLd5V4sp5mwcOeoNb
	EtUl2sIWxu1QRqXxDtG5BNgHcDzzqvdx8mmZqsoh3qwrG6RIzsbSUMuJfo8PUP7th7JyNALsxqd
	iwzoqQiXLba1jpgn1SQYf+NOcpGQGIqpdjtgkp/q1tb8nfaK6F548PbRFncASbeOW9ZEc
X-Received: by 2002:a05:600c:46d5:b0:49c:fc6c:be04 with SMTP id 5b1f17b1804b1-49cfc6cc091mr196551845e9.27.1788796630208;
        Mon, 07 Sep 2026 08:57:10 -0700 (PDT)
X-Received: by 2002:a05:600c:46d5:b0:49c:fc6c:be04 with SMTP id 5b1f17b1804b1-49cfc6cc091mr196551635e9.27.1788796629803;
        Mon, 07 Sep 2026 08:57:09 -0700 (PDT)
Received: from lleonard-thinkpadx1carbongen13.rmtit.csb ([151.29.41.106])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cf755c22esm320477955e9.0.2026.09.07.08.57.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 08:57:09 -0700 (PDT)
From: Luigi Leonardi <leonardi@redhat.com>
Date: Mon, 07 Sep 2026 17:57:01 +0200
Subject: [PATCH v2 5/5] igvm/sev: forward the IGVM guest policy to the
 platform before launch
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260907-fix_igvm_policy-v2-5-c8c50f1dbfda@redhat.com>
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

set_guest_policy was called from qigvm_handle_policy at the end of
qigvm_process_file, after LAUNCH_START had already been issued for both
SEV/SEV-ES and SEV-SNP. The guest was therefore launched with whatever
policy was already configured (the command-line value, or the platform
default if none was given) instead of the one requested by the IGVM
file, quietly breaking attestation since the policy is part of the
attestation report.

Move the call into qigvm_initialization_guest_policy, which runs while
the initialization section is processed. Because that section is now
handled during the pre-launch pass (see previous patch), the call
happens before LAUNCH_START, so the policy is in effect for launch. Drop
qigvm_handle_policy, whose only remaining job was that misplaced call.
cgs_set_guest_policy no longer special-cases SEV_STATE_UNINIT: that
guard used to skip the pre-processing pass so the policy was applied
later, but forwarding it during pre-processing, before LAUNCH_START, is
now precisely the point. The 'policy == 0 means unset' guard is dropped
too, since the call site now only fires when the IGVM file actually
provides a GUEST_POLICY header.

The command line can also set a policy. It now takes precedence: if it
differs from the IGVM one, print a warning and keep the command-line
value instead of silently overriding it. Also reject a policy that
doesn't fit in the 32-bit SEV/SEV-ES policy field instead of truncating
it.

Finally, use the get_guest_policy callback added by the previous patch
to populate the SNP ID block's policy field. The command line sets its
policy directly into the SEV/SNP guest's own struct, bypassing IGVM
entirely, so ctx->sev_policy only ever reflects a GUEST_POLICY header
and is 0 otherwise, causing SNP_LAUNCH_FINISH to reject the ID block
whenever the file relies on a command-line policy. Reading the policy
back from the platform instead always gets the value actually in
effect, regardless of its source. ctx->sev_policy is now unused and
removed.

Link: https://gitlab.com/qemu-project/qemu/-/work_items/4189
Fixes: 915b47078d ("backends/igvm: Handle policy for SEV guests")
Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
---
 backends/igvm.c                | 27 +++++++++++----------------
 include/system/igvm-internal.h |  3 ---
 target/i386/sev.c              | 37 +++++++++++++++++++++++++------------
 3 files changed, 36 insertions(+), 31 deletions(-)

diff --git a/backends/igvm.c b/backends/igvm.c
index 521560822a..5360a2575b 100644
--- a/backends/igvm.c
+++ b/backends/igvm.c
@@ -778,8 +778,6 @@ static int qigvm_directive_snp_id_block(QIgvm *ctx, const uint8_t *header_data,
     ctx->id_block->version = IGVM_SEV_ID_BLOCK_VERSION;
     memcpy(ctx->id_block->ld, igvm_id->ld, sizeof(ctx->id_block->ld));
 
-    ctx->id_block->policy = ctx->sev_policy;
-
     ctx->id_auth->id_key_alg = igvm_id->id_key_algorithm;
     assert(sizeof(igvm_id->id_key_signature) <=
            sizeof(ctx->id_auth->id_block_sig));
@@ -808,6 +806,13 @@ static int qigvm_directive_snp_id_block(QIgvm *ctx, const uint8_t *header_data,
             72);
 
     if (ctx->cgsc) {
+        uint64_t policy;
+
+        if (ctx->cgsc->get_guest_policy(GUEST_POLICY_SEV, &policy, errp) < 0) {
+            return -1;
+        }
+        ctx->id_block->policy = policy;
+
         return ctx->cgsc->set_id_block(ctx->id_block,
                                        sizeof(struct sev_id_block),
                                        ctx->id_auth,
@@ -867,7 +872,10 @@ static int qigvm_initialization_guest_policy(QIgvm *ctx,
         (const IGVM_VHS_GUEST_POLICY *)header_data;
 
     if (guest->compatibility_mask & ctx->compatibility_mask) {
-        ctx->sev_policy = guest->policy;
+        if (ctx->cgsc) {
+            return ctx->cgsc->set_guest_policy(GUEST_POLICY_SEV,
+                                               guest->policy, errp);
+        }
     }
     return 0;
 }
@@ -968,15 +976,6 @@ static int qigvm_supported_platform_compat_mask(QIgvm *ctx, Error **errp)
     return 0;
 }
 
-static int qigvm_handle_policy(QIgvm *ctx, Error **errp)
-{
-    if (ctx->platform_type == IGVM_PLATFORM_TYPE_SEV_SNP) {
-        return ctx->cgsc->set_guest_policy(GUEST_POLICY_SEV, ctx->sev_policy,
-                                           errp);
-    }
-    return 0;
-}
-
 IgvmHandle qigvm_file_init(char *filename, Error **errp)
 {
     IgvmHandle igvm;
@@ -1102,10 +1101,6 @@ int qigvm_process_file(IgvmCfg *cfg, MachineState *machine_state,
      */
     retval = qigvm_process_mem_page(&ctx, NULL, errp);
 
-    if (retval == 0) {
-        retval = qigvm_handle_policy(&ctx, errp);
-    }
-
 cleanup_parameters:
     QTAILQ_FOREACH(parameter, &ctx.parameter_data, next)
     {
diff --git a/include/system/igvm-internal.h b/include/system/igvm-internal.h
index 9e9fa1d9af..041f77586a 100644
--- a/include/system/igvm-internal.h
+++ b/include/system/igvm-internal.h
@@ -64,9 +64,6 @@ struct QIgvm {
     struct sev_id_block *id_block;
     struct sev_id_authentication *id_auth;
 
-    /* Define the guest policy for SEV guests */
-    uint64_t sev_policy;
-
     /* These variables keep track of contiguous page regions */
     IGVM_VHS_PAGE_DATA region_prev_page_data;
     uint64_t region_start;
diff --git a/target/i386/sev.c b/target/i386/sev.c
index f11fdb6590..11072b00dc 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -128,6 +128,8 @@ struct SevCommonState {
     bool kernel_hashes;
     uint64_t sev_features;
     uint64_t supported_sev_features;
+    /* whether the guest policy was explicitly set on the command line */
+    bool policy_set;
 
     /* runtime state */
     uint8_t api_major;
@@ -2729,10 +2731,6 @@ static int cgs_set_guest_policy(ConfidentialGuestPolicyType policy_type,
                                 uint64_t policy, Error **errp)
 {
     SevCommonState *sev_common = SEV_COMMON(MACHINE(qdev_get_machine())->cgs);
-    if (sev_common->state == SEV_STATE_UNINIT) {
-        /* Pre-processing of IGVM file called from sev_common_kvm_init() */
-        return 0;
-    }
 
     if (policy_type != GUEST_POLICY_SEV) {
         error_setg(errp, "SEV: Invalid guest policy type provided for SEV: %d",
@@ -2740,18 +2738,31 @@ static int cgs_set_guest_policy(ConfidentialGuestPolicyType policy_type,
         return -1;
     }
 
-    /* do not reset existing policy if policy was not set in IGVM  */
-    if (policy == 0) {
-        return 0;
-    }
-
     if (sev_snp_enabled()) {
-        SevSnpGuestState *sev_snp_guest =
-            SEV_SNP_GUEST(MACHINE(qdev_get_machine())->cgs);
+        SevSnpGuestState *sev_snp_guest = SEV_SNP_GUEST(sev_common);
+
+        if (sev_common->policy_set &&
+            sev_snp_guest->kvm_start_conf.policy != policy) {
+            warn_report_once("SNP: policy mismatch between IGVM and CLI, "
+                             "keeping the command-line policy");
+            return 0;
+        }
 
         sev_snp_guest->kvm_start_conf.policy = policy;
     } else {
-        SevGuestState *sev_guest = SEV_GUEST(MACHINE(qdev_get_machine())->cgs);
+        SevGuestState *sev_guest = SEV_GUEST(sev_common);
+
+        if (sev_common->policy_set && sev_guest->policy != policy) {
+            warn_report_once("SEV: policy mismatch between IGVM and CLI, "
+                             "keeping the command-line policy");
+            return 0;
+        }
+
+        if (policy > UINT32_MAX) {
+            error_setg(errp, "SEV: policy 0x%" PRIx64 " does not fit in the "
+                       "32-bit SEV/SEV-ES guest policy field", policy);
+            return -1;
+        }
 
         sev_guest->policy = policy;
     }
@@ -3034,6 +3045,7 @@ sev_guest_set_policy(Object *obj, Visitor *v, const char *name,
     if (!visit_type_uint32(v, name, &SEV_GUEST(obj)->policy, errp)) {
         return;
     }
+    SEV_COMMON(obj)->policy_set = true;
 }
 
 static void
@@ -3091,6 +3103,7 @@ sev_snp_guest_set_policy(Object *obj, Visitor *v, const char *name,
                            errp)) {
         return;
     }
+    SEV_COMMON(obj)->policy_set = true;
 }
 
 static char *

-- 
2.55.0

