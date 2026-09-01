Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8AD937F729
	for <kvm@vger.kernel.org>; Tue,  1 Sep 2026 10:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788257376; cv=none; b=c2rsOdl93lxw29cxHWLwjifVzpB+0O2mTefvDhvbLkXWPD83lI/zBoiZH70t1fCcGJxz85q3wf0npneZ/pSw40oB4W+LZAS6lAZjdL7Hayb+jRldD7zWWMY+B66j9ylO7TcndP7Z6VicK2ihnwto5FLWHKzOWPooEzWMwDLpAu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788257376; c=relaxed/simple;
	bh=Meva06Ig7nNVYs9YOZ2tGZo3kglkvkXE/UuGzflEngs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=S3faevlkkBbc0N4PN1rNhJUOQ1jsrZZ3WDQ25iRHCLiWFxFB5qxIO2rPJ6JGTSUci2zTYV+QJPtRPyXwqiwc+ebpy2c4elTfNWcRzTRmPlAYsTzp42hLpAIgHUbrQ8knXo1QgXHMbUFcsEamh40pukLTMBSp90d7c5dbD625FGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZNQHfKDJ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=XJs1/Dmg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZNQHfKDJ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="XJs1/Dmg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788257373;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Kl+pYHx82Tu2z011P+lU27GwkRv+poRAFFh5UTR7T8c=;
	b=ZNQHfKDJNSFLDTzACPcrXFzkCAZVjISUd2ED+g4XY1wXWlFFPWwNs9YFwGkZBOOc92vzrN
	AzOw+GpCUrnhQh/aj0UouipesciTCdQp1LADTCa+j47g3oQzxjXNx7TuwEODn7Bl7GR4U0
	Wu+nNwzfZK8V72l+SGK+K/XohUh2D84=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-33-lYHYw-bAPb2Xh0fwH8uDOw-1; Tue, 01 Sept 2026 06:09:32 -0400
X-MC-Unique: lYHYw-bAPb2Xh0fwH8uDOw-1
X-Mimecast-MFC-AGG-ID: lYHYw-bAPb2Xh0fwH8uDOw_1788257371
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-47f2de3ba47so525848f8f.1
        for <kvm@vger.kernel.org>; Tue, 01 Sep 2026 03:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788257371; x=1788862171; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Kl+pYHx82Tu2z011P+lU27GwkRv+poRAFFh5UTR7T8c=;
        b=XJs1/DmgbuEXKrpTTnZ/KGqTJq91J3MSj0Su8aJZ2LN/p3rDvsSkFL/iHc/Vfhfq7Z
         l1orbTd87ht/1Uuj9sZcMf7bnFF90jDAgjUMAREqjlA807cg7zCMUlze1Ga9//Q3KTM3
         ibAXW1Pzq5eBsvZJ2N3wizxIzYE7oHFc4PwUpSzpZvmv8ZeXQpXJNYIbwEqVOITtbJ55
         zMiGU1vQd3pCp22yIidw0dENNS4fFyd+JupsW890Tu94xxUR11nEntMzAWZqYq0ZR/jp
         DHGLkRRws8rHkQu3RCao3yMbnKG8/PUUu7jjvUqnP5ObKusX51Ia2/lZFe4Y4QVlRQAg
         e4XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788257371; x=1788862171;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Kl+pYHx82Tu2z011P+lU27GwkRv+poRAFFh5UTR7T8c=;
        b=qXER4if1numknirJFzoWqhylETlHwaUA41s2NPJ+c8XCgte231U4TCjE6NdHFxyz9y
         HEamcFUoNEH3V2K4EpPQQFrrAScgtLvFZLtTy45VI8clNxtuUjLSYs8VLdqBOj8Vubzq
         Umb68EED5lC9uEAP17iWMXjXrFOsjf/vpMKg+ER/+MX4UvXzAShm9EtjyWDiDnbVcG+o
         w0XbvfXUQZVElsR+h8AtdHYCOAxOpG2x6dBzS2xGIRP8nCPYPUAtHZlI8QJIG0n6ciku
         FbB+XoiXzhVW1t2dZoH0qgruAibEjA0AcvNhF4ipmqqPfBxj1/G6o7qEhpwLn9/ORxhJ
         3zRA==
X-Forwarded-Encrypted: i=1; AHgh+Ro1QKsIX/NUERFE8zLepvodI4QnJWQWgl4QreWhN3b8a6+LRbSPiPAMPbF1rKlc+GgXA00=@vger.kernel.org
X-Gm-Message-State: AFuF++lFFSi/nOCW66Lg/yXJ0sz5/r1E50xt72UD96qk9olcpexY7e3i
	mgBKHp3ffHQAVByfJbVIggxlJGHShdOiK9yEgoPwPZTHhTMTciNkuryBAzp22KLIkf9HBZrkB+1
	JeJSqY2Dkbc64PjgDch8T33+Jjnv4+qbCzWUX2lB7FaJXzt6f0DjAjmaHHHSLbCLRFQj2xZvDms
	1mekN1KxgtUV/C+EtdHbEUbcKWoXPxGb8y6ywz923N
X-Gm-Gg: AR+sD10zaiQgNRXFjUZXipUg0wUFsmieTMc5Kdll4P25yOAe3Jc8/EJWUqu8/JGa5a8
	OfbLU5biKmlRawrdhHkZRvT8oAMYUtake9S2u3h0MVwK9IVr2hRrbmQOOtih7gJRZUZQn/oAXmK
	4XkrkonxGG/F1pQCsI1MtFDW0dO+f99NcPOKbGBXrtFRUKyI4NDtyXTL5NBogYzyPg/N08cmppS
	p4AnFQVKtlge1vLkURgCWcMDca8U3GmI+75w3RRqQscjbfJCQPhlTkKcSTDM1yL1D3h+Uh9L0FK
	wn0WuQK3oDEiZ2Fp4WPl3xAYKoHwu7YhG+mIj5tD/sjvoHezqcQdbRlfrNPuwBY6QCt+OZHoUbW
	+EwT4eOI3a288JnXLAGAhnN+XipriM0+12dLZTWJHvSackYgC3Tt+LS0m/5jyj0I9NXHQ
X-Received: by 2002:a05:600c:1c13:b0:49c:df2b:15fc with SMTP id 5b1f17b1804b1-49cdf2b179amr72531285e9.8.1788257370820;
        Tue, 01 Sep 2026 03:09:30 -0700 (PDT)
X-Received: by 2002:a05:600c:1c13:b0:49c:df2b:15fc with SMTP id 5b1f17b1804b1-49cdf2b179amr72529995e9.8.1788257370267;
        Tue, 01 Sep 2026 03:09:30 -0700 (PDT)
Received: from lleonard-thinkpadx1carbongen13.rmtit.csb ([151.29.41.106])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48442d7c1c0sm3941620f8f.32.2026.09.01.03.09.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 03:09:29 -0700 (PDT)
From: Luigi Leonardi <leonardi@redhat.com>
Date: Tue, 01 Sep 2026 12:09:18 +0200
Subject: [PATCH 1/4] sev: rename set_guest_policy to set_id_block and
 remove dead policy code
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260901-fix_igvm_policy-v1-1-e93a6cf8c5ac@redhat.com>
References: <20260901-fix_igvm_policy-v1-0-e93a6cf8c5ac@redhat.com>
In-Reply-To: <20260901-fix_igvm_policy-v1-0-e93a6cf8c5ac@redhat.com>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, Ani Sinha <anisinha@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>, 
 Marcelo Tosatti <mtosatti@redhat.com>, kvm@vger.kernel.org, 
 Luigi Leonardi <leonardi@redhat.com>
X-Mailer: b4 0.14.3

The guest policy must be provided at guest launch start: LAUNCH_START for
SEV/SEV-ES and SNP_LAUNCH_START for SEV-SNP. See the SEV API
specification, chapter 3 (Guest Policy), and the SEV-SNP firmware ABI
specification, section 4.3 (Guest Policy).

The policy parameter in set_guest_policy was never effective: by the
time this callback runs, LAUNCH_START has already been issued for both
SEV/SEV-ES and SEV-SNP, so writing to kvm_start_conf.policy or
sev_guest->policy has no effect. In practice the only thing this
callback actually does is set the ID block and ID auth for SNP's
LAUNCH_FINISH, so rename it to set_id_block to reflect its real
purpose, remove the unused policy parameter, and drop the non-SNP code
path which was entirely dead.

This is preliminary work: actually forwarding the guest policy to the
platform before LAUNCH_START is added in a later commit.

Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
---
 backends/confidential-guest-support.c       |  12 ++-
 backends/igvm.c                             |   6 +-
 include/system/confidential-guest-support.h |  28 ++++---
 target/i386/sev.c                           | 118 +++++++++++-----------------
 4 files changed, 67 insertions(+), 97 deletions(-)

diff --git a/backends/confidential-guest-support.c b/backends/confidential-guest-support.c
index 156dd15e66..a0b36d2da5 100644
--- a/backends/confidential-guest-support.c
+++ b/backends/confidential-guest-support.c
@@ -38,14 +38,12 @@ static int set_guest_state(hwaddr gpa, uint8_t *ptr, uint64_t len,
     return -1;
 }
 
-static int set_guest_policy(ConfidentialGuestPolicyType policy_type,
-                            uint64_t policy,
-                            void *policy_data1, uint32_t policy_data1_size,
-                            void *policy_data2, uint32_t policy_data2_size,
-                            Error **errp)
+static int set_id_block(void *id_block, uint32_t id_block_size,
+                        void *id_auth, uint32_t id_auth_size,
+                        Error **errp)
 {
     error_setg(errp,
-               "Setting confidential guest policy is not supported for this platform");
+               "Setting ID block is not supported for this platform");
     return -1;
 }
 
@@ -64,7 +62,7 @@ static void confidential_guest_support_class_init(ObjectClass *oc,
     ConfidentialGuestSupportClass *cgsc = CONFIDENTIAL_GUEST_SUPPORT_CLASS(oc);
     cgsc->check_support = check_support;
     cgsc->set_guest_state = set_guest_state;
-    cgsc->set_guest_policy = set_guest_policy;
+    cgsc->set_id_block = set_id_block;
     cgsc->get_mem_map_entry = get_mem_map_entry;
 }
 
diff --git a/backends/igvm.c b/backends/igvm.c
index 7b7bdc72b7..85de0d54ec 100644
--- a/backends/igvm.c
+++ b/backends/igvm.c
@@ -968,9 +968,9 @@ static int qigvm_handle_policy(QIgvm *ctx, Error **errp)
             id_block_len = sizeof(struct sev_id_block);
             id_auth_len = sizeof(struct sev_id_authentication);
         }
-        return ctx->cgsc->set_guest_policy(GUEST_POLICY_SEV, ctx->sev_policy,
-                                          ctx->id_block, id_block_len,
-                                          ctx->id_auth, id_auth_len, errp);
+
+        return ctx->cgsc->set_id_block(ctx->id_block, id_block_len,
+                                       ctx->id_auth, id_auth_len, errp);
     }
     return 0;
 }
diff --git a/include/system/confidential-guest-support.h b/include/system/confidential-guest-support.h
index 5dca717308..6d35ddb97a 100644
--- a/include/system/confidential-guest-support.h
+++ b/include/system/confidential-guest-support.h
@@ -128,21 +128,23 @@ typedef struct ConfidentialGuestSupportClass {
                            uint16_t cpu_index, Error **errp);
 
     /*
-     * Set the guest policy. The policy can be used to configure the
-     * confidential platform, such as if debug is enabled or not and can contain
-     * information about expected launch measurements, signed verification of
-     * guest configuration and other platform data.
-     *
-     * The format of the policy data is specific to each platform. For example,
-     * SEV-SNP uses a policy bitfield in the 'policy' argument and provides an
-     * ID block and ID authentication in the 'policy_data' parameters. The type
-     * of policy data is identified by the 'policy_type' argument.
+     * Set the guest policy for the confidential platform. The policy
+     * configures properties of the guest, such as whether debug is
+     * enabled. Its format is platform-specific; for SEV/SEV-ES and
+     * SEV-SNP it is a policy bitfield. Must be called before LAUNCH_START
+     * so the policy is in effect for launch.
      */
     int (*set_guest_policy)(ConfidentialGuestPolicyType policy_type,
-                            uint64_t policy,
-                            void *policy_data1, uint32_t policy_data1_size,
-                            void *policy_data2, uint32_t policy_data2_size,
-                            Error **errp);
+                            uint64_t policy, Error **errp);
+
+    /*
+     * Set the SEV-SNP ID block and ID authentication block. These are
+     * passed to SNP_LAUNCH_FINISH to provide signed verification of the
+     * guest configuration.
+     */
+    int (*set_id_block)(void *id_block, uint32_t id_block_size,
+                        void *id_auth, uint32_t id_auth_size,
+                        Error **errp);
 
     /*
      * Iterate the system memory map, getting the entry with the given index
diff --git a/target/i386/sev.c b/target/i386/sev.c
index 4d875d10ff..465415c535 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -2723,10 +2723,9 @@ static int cgs_get_mem_map_entry(int index,
     return 0;
 }
 
-static int cgs_set_guest_policy(ConfidentialGuestPolicyType policy_type,
-                                uint64_t policy, void *policy_data1,
-                                uint32_t policy_data1_size, void *policy_data2,
-                                uint32_t policy_data2_size, Error **errp)
+static int cgs_set_id_block(void *id_block, uint32_t id_block_size,
+                            void *id_auth, uint32_t id_auth_size,
+                            Error **errp)
 {
     SevCommonState *sev_common = SEV_COMMON(MACHINE(qdev_get_machine())->cgs);
     if (sev_common->state == SEV_STATE_UNINIT) {
@@ -2734,86 +2733,57 @@ static int cgs_set_guest_policy(ConfidentialGuestPolicyType policy_type,
         return 0;
     }
 
-    if (policy_type != GUEST_POLICY_SEV) {
-        error_setg(errp, "SEV: Invalid guest policy type provided for SEV: %d",
-                   policy_type);
+    if (!sev_snp_enabled()) {
+        error_setg(errp, "SEV: ID block is only supported for SEV-SNP");
         return -1;
     }
-    /*
-     * SEV-SNP handles policy differently. The policy flags are defined in
-     * kvm_start_conf.policy and an ID block and ID auth can be provided.
-     */
-    if (sev_snp_enabled()) {
-        SevSnpGuestState *sev_snp_guest =
-            SEV_SNP_GUEST(MACHINE(qdev_get_machine())->cgs);
-        struct kvm_sev_snp_launch_finish *finish =
-            &sev_snp_guest->kvm_finish_conf;
 
-        /*
-         * The policy consists of flags in 'policy' and optionally an ID block
-         * and ID auth in policy_data1 and policy_data2 respectively. The ID
-         * block and auth are optional so clear any previous ID block and auth
-         * and set them if provided, but always set the policy flags.
-         */
-        g_free(sev_snp_guest->id_block);
-        g_free((guchar *)finish->id_block_uaddr);
-        g_free(sev_snp_guest->id_auth);
-        g_free((guchar *)finish->id_auth_uaddr);
-        sev_snp_guest->id_block = NULL;
-        finish->id_block_uaddr = 0;
-        sev_snp_guest->id_auth = NULL;
-        finish->id_auth_uaddr = 0;
-
-        if (policy_data1_size > 0) {
-            struct sev_snp_id_authentication *id_auth =
-                (struct sev_snp_id_authentication *)policy_data2;
-
-            if (policy_data1_size != KVM_SEV_SNP_ID_BLOCK_SIZE) {
-                error_setg(errp, "SEV: Invalid SEV-SNP ID block: incorrect size");
-                return -1;
-            }
-            if (policy_data2_size != KVM_SEV_SNP_ID_AUTH_SIZE) {
-                error_setg(errp,
-                           "SEV: Invalid SEV-SNP ID auth block: incorrect size");
-                return -1;
-            }
-            assert(policy_data1 != NULL);
-            assert(policy_data2 != NULL);
+    SevSnpGuestState *sev_snp_guest =
+        SEV_SNP_GUEST(MACHINE(qdev_get_machine())->cgs);
+    struct kvm_sev_snp_launch_finish *finish =
+        &sev_snp_guest->kvm_finish_conf;
 
-            finish->id_block_uaddr =
-                (__u64)g_memdup2(policy_data1, KVM_SEV_SNP_ID_BLOCK_SIZE);
-            finish->id_auth_uaddr =
-                (__u64)g_memdup2(policy_data2, KVM_SEV_SNP_ID_AUTH_SIZE);
+    g_free(sev_snp_guest->id_block);
+    g_free((guchar *)finish->id_block_uaddr);
+    g_free(sev_snp_guest->id_auth);
+    g_free((guchar *)finish->id_auth_uaddr);
+    sev_snp_guest->id_block = NULL;
+    finish->id_block_uaddr = 0;
+    sev_snp_guest->id_auth = NULL;
+    finish->id_auth_uaddr = 0;
 
-            /*
-             * Check if an author key has been provided and use that to flag
-             * whether the author key is enabled. The first of the author key
-             * must be non-zero to indicate the key type, which will currently
-             * always be 2.
-             */
-            sev_snp_guest->kvm_finish_conf.auth_key_en =
-                id_auth->author_key[0] ? 1 : 0;
-            finish->id_block_en = 1;
-        }
+    if (id_block_size > 0) {
+        struct sev_snp_id_authentication *auth =
+            (struct sev_snp_id_authentication *)id_auth;
 
-        /* do not reset existing policy if policy was not set in IGVM  */
-        if (policy != 0) {
-            sev_snp_guest->kvm_start_conf.policy = policy;
+        if (id_block_size != KVM_SEV_SNP_ID_BLOCK_SIZE) {
+            error_setg(errp, "SEV: Invalid SEV-SNP ID block: incorrect size");
+            return -1;
         }
-    } else {
-        SevGuestState *sev_guest = SEV_GUEST(MACHINE(qdev_get_machine())->cgs);
-        /* Only the policy flags are supported for SEV and SEV-ES */
-        if ((policy_data1_size > 0) || (policy_data2_size > 0) || !sev_guest) {
-            error_setg(errp, "SEV: An ID block/ID auth block has been provided "
-                             "but SEV-SNP is not enabled");
+        if (id_auth_size != KVM_SEV_SNP_ID_AUTH_SIZE) {
+            error_setg(errp,
+                       "SEV: Invalid SEV-SNP ID auth block: incorrect size");
             return -1;
         }
+        assert(id_block != NULL);
+        assert(id_auth != NULL);
 
-        /* do not reset existing policy if policy was not set in IGVM  */
-        if (policy != 0) {
-            sev_guest->policy = policy;
-        }
+        finish->id_block_uaddr =
+            (__u64)g_memdup2(id_block, KVM_SEV_SNP_ID_BLOCK_SIZE);
+        finish->id_auth_uaddr =
+            (__u64)g_memdup2(id_auth, KVM_SEV_SNP_ID_AUTH_SIZE);
+
+        /*
+         * Check if an author key has been provided and use that to flag
+         * whether the author key is enabled. The first of the author key
+         * must be non-zero to indicate the key type, which will currently
+         * always be 2.
+         */
+        sev_snp_guest->kvm_finish_conf.auth_key_en =
+            auth->author_key[0] ? 1 : 0;
+        finish->id_block_en = 1;
     }
+
     return 0;
 }
 
@@ -2878,7 +2848,7 @@ sev_common_instance_init(Object *obj)
     cgs->check_support = cgs_check_support;
     cgs->set_guest_state = cgs_set_guest_state;
     cgs->get_mem_map_entry = cgs_get_mem_map_entry;
-    cgs->set_guest_policy = cgs_set_guest_policy;
+    cgs->set_id_block = cgs_set_id_block;
     cgs->can_rebuild_guest_state = true;
 
     QTAILQ_INIT(&sev_common->launch_vmsa);

-- 
2.55.0

