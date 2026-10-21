Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792600368;
	b=Q/N5vgxOS55VoXloR9VaFpgfQsfTp+wv9zmiTQDApxGsp5rj2T6s9eGCcBUnCixCgrWR
	 HijuFE2qvPsESSkiXrZPpkpG3T7bJUJiPPxzNDIDErIPkLIfy/6JY37upIzYnxq5IuhTZ
	 ulBj6I45Pvjj0fX9psdGB4W8BzdQhxyURGQxkyYa8jqL9uMH2eSFgWuoFt6kUrbZk0laU
	 wxnclpF8uYI04ef48dNAN3LFOkxck1yqnTtOSWkFBUUuwxnusgdWZsvQQoOXrWDUwF4g9
	 qpHPy2IFZJeW69h5wLa1nNugwx7ZXPp0C9MkRIHvWO2mJCuaZ3bl+76V1D4ff08/2Tg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792600368;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Scanned-By;
	bh=mx3NJOt7EtEZ3D64HV5SqRuwJTZwQpbp8v/NGhoKJls=;
	b=WZthCXXoUZkSvloOlLMBdn3NICVIwhMflbmBq1vb3Jknl0HUmjGquHPGx3Tc19/E4C3a
	 SU5IWpTkPEmSJ5VZ+aVAD1oXV9Xs+G+i1VMytPOV9vITHzJNoj2ekMSAQ7eCIkHc7akdt
	 rJqkLq6OZz2MrwoM4WdMblXjVdWxIxGxflQtZN1UzM96/C6Lx7MOPCtzwRWM9cH8OurxN
	 Ch+Xk93tXukmozarOaKZiBcIJpGCkMs6Xkr4XQw3U4LqtTYx7MkbElXsvojClhARCreS6
	 PLZu6papkFst4zCe1Ic+saofseH2Gowd1RAzbvfZz3DFouG9XS/Vs+eTERKiwOc89Tg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=i0d54Smd;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF83606A323
	for <kvm@vger.kernel.org>; Wed, 21 Oct 2026 16:32:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7AF83606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=i0d54Smd
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792600366;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mx3NJOt7EtEZ3D64HV5SqRuwJTZwQpbp8v/NGhoKJls=;
	b=i0d54Smd84PDCwm74ptwQCtjLSCObxL9OJ+X28PfWqw3shSCIclfDY5tAjFFj2wie8oeJc
	ZzOQlD0yBol6LtZOpvm8AgLwk0vGL8iRn7atDIOndRm53jyZZyhjJVAbeOeHU077rCFD84
	WZuusrqig3uM1LfEOTFyUY51vd22k24=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-374-paQ6od0dMEOAiay9-J2iVQ-1; Wed,
 21 Oct 2026 16:32:45 +0000
X-MC-Unique: paQ6od0dMEOAiay9-J2iVQ-1
X-Mimecast-MFC-AGG-ID: paQ6od0dMEOAiay9-J2iVQ_1792600364
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0318F19560BC;
	Wed, 21 Oct 2026 16:32:44 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.44.48.54])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B1BC618004D2;
	Wed, 21 Oct 2026 16:32:43 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
	id DF9C31827593; Wed, 21 Oct 2026 18:32:39 +0200 (CEST)
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
Subject: [PULL 05/10] igvm/sev: forward the IGVM guest policy to the platform before launch
Date: Wed, 21 Oct 2026 18:32:33 +0200
Message-ID: <20261021163239.1131460-6-kraxel@redhat.com>
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
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

From: Luigi Leonardi <leonardi@redhat.com>

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
Message-ID: <20260907-fix_igvm_policy-v2-5-c8c50f1dbfda@redhat.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/system/igvm-internal.h |  3 ---
 backends/igvm.c                | 27 ++++++++++---------------
 target/i386/sev.c              | 37 +++++++++++++++++++++++-----------
 3 files changed, 36 insertions(+), 31 deletions(-)

diff --git a/include/system/igvm-internal.h b/include/system/igvm-internal.h
index b3b64cb58444..d88268bf602c 100644
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
diff --git a/backends/igvm.c b/backends/igvm.c
index 2ee60ada94b9..ef45794744bc 100644
--- a/backends/igvm.c
+++ b/backends/igvm.c
@@ -821,8 +821,6 @@ static int qigvm_directive_snp_id_block(QIgvm *ctx, const uint8_t *header_data,
     ctx->id_block->version = IGVM_SEV_ID_BLOCK_VERSION;
     memcpy(ctx->id_block->ld, igvm_id->ld, sizeof(ctx->id_block->ld));
 
-    ctx->id_block->policy = ctx->sev_policy;
-
     ctx->id_auth->id_key_alg = igvm_id->id_key_algorithm;
     assert(sizeof(igvm_id->id_key_signature) <=
            sizeof(ctx->id_auth->id_block_sig));
@@ -851,6 +849,13 @@ static int qigvm_directive_snp_id_block(QIgvm *ctx, const uint8_t *header_data,
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
@@ -910,7 +915,10 @@ static int qigvm_initialization_guest_policy(QIgvm *ctx,
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
@@ -1011,15 +1019,6 @@ static int qigvm_supported_platform_compat_mask(QIgvm *ctx, Error **errp)
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
@@ -1145,10 +1144,6 @@ int qigvm_process_file(IgvmCfg *cfg, MachineState *machine_state,
      */
     retval = qigvm_process_mem_page(&ctx, NULL, errp);
 
-    if (retval == 0) {
-        retval = qigvm_handle_policy(&ctx, errp);
-    }
-
 cleanup_parameters:
     QTAILQ_FOREACH(parameter, &ctx.parameter_data, next)
     {
diff --git a/target/i386/sev.c b/target/i386/sev.c
index f11fdb6590ef..11072b00dce7 100644
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
2.56.0

