Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B0213815E2
	for <kvm@vger.kernel.org>; Mon,  7 Sep 2026 15:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788796631; cv=none; b=OS18iKR7kcVfThmsfEcL9c4oz9MyXGSJns0QpuWqnv0rkIdNssd1yDP0dHzvwjsi6dYhTA6fWaqcjJOjsJqRXWbVOmqLXhtJpEgumMPlk1fs+Bu/WNA8pazsXMzwxHxkamY8dagcHZoP//XglizHo9nE5N2eFJvaZmEa4jMRqQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788796631; c=relaxed/simple;
	bh=wDMpzgdqBNNnsDowSuAqWJ7uAFBKh4rfNt9SRQWesOc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GfwPCtgcIGUW7QyUj/lj7SGw9blSEqo/SuPHFflA10sn7tTe3cC8xCKplQkhcR9GVsEFPGLal0J81iVfaj274rgKOELCp47or08CVV1qWWSYMRuEQ+Zs8klkXkFRopRXM+RnbLX7Q6+kCNxOOcyb1PrPPkdP24hPUvUM1uJgLtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gOP+0tAB; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=gm+FI6wQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gOP+0tAB";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="gm+FI6wQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788796628;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UtTVcX+HkxAOGfacRObZuM9p/FF3OrW8RisRppHIXLs=;
	b=gOP+0tABGKOiQEp8nIyrcoaLU2pZKnRLVJug+NrfzRptZjzCgiZK0lv0dh5ggviyNoFvcK
	3uDhQzJxpn4MRIvw3NpkkE+oncU/PDPVbaGKN3zVwPItSzAZszr52IAGL01yE0Hx+oyU1T
	6N1sK8Z8jvzoyD5fxNEv1XzZDKN/hYU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681-LQEhNdmoNCaUVFEK-FGUTw-1; Mon, 07 Sep 2026 11:57:06 -0400
X-MC-Unique: LQEhNdmoNCaUVFEK-FGUTw-1
X-Mimecast-MFC-AGG-ID: LQEhNdmoNCaUVFEK-FGUTw_1788796626
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-49b8c651ac0so54170865e9.2
        for <kvm@vger.kernel.org>; Mon, 07 Sep 2026 08:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788796626; x=1789401426; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UtTVcX+HkxAOGfacRObZuM9p/FF3OrW8RisRppHIXLs=;
        b=gm+FI6wQBIs6K/lHj/2SKlA+I3Ih3kNZZ4aWrZOCHdlVwRN80p6MqCWVQIh1FF1NkD
         oEbXInoo5MQDhTfzKqseMgF2eUGicrLpYg1znz6JoYGWAc0xrg6k6Z5+QmupSR7rM0mS
         tw5BJTxqX8oBDXU16GWXFr+UgudEYXMShBUpEuZQGtYcH3LHYWtkW8Yeos45tlK1OQeD
         eQ14cKUBsfM0xXj3mTT5Lt7+Xx2zjU1CCfTbncjbOx9eZ/w2c1YUR/28LKZxbFH6bkf7
         Zm7v/USpSS81MqZ/FWZwpU+jyl6RX0BVHazFfWZXCC32wc1/xwPIt+2M/DH3119Ij/Ph
         cTRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788796626; x=1789401426;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UtTVcX+HkxAOGfacRObZuM9p/FF3OrW8RisRppHIXLs=;
        b=RDZonbiqo/eZeKpkwR+dHaA1FkeSDSJBPeivqvKVUh/RMIWBr6LAoHEtIpMRThh5KN
         VuL92Je2CdXZN4gSZtEdTmyrDZozHayVj9rA0+vZh0OsQG4immq+G0HNv5h2B3iCiDpR
         yUr0F/PT7MDWt4D+1Y2WMxrczo6uLthWel7dMqT2hWJDUcQrJnNHkWdX5yKotAFilnOb
         M3Ppl++XlvPXodZ3yf1BjG09CmC3HLXn5riv/NVUHaomdbSYrc3vit1Chly8iKrTfuQz
         DEV7tTAvYc5xe/CKpYKilDb/VVf0Ru6lp1yb0im69D7eSJi3FBwJh8iIg2xZLQZJ0ns5
         7Pvw==
X-Forwarded-Encrypted: i=1; AKwUvBznFghZ2PEKvfymGG3YBe7KjOa6fNsW6ifXDwe9jGde4IgT/KhR1aKECuHM47MOKEyMcCc=@vger.kernel.org
X-Gm-Message-State: AFuF++nhm9zjiX2TObM9WiacQ3Q6MFWtWvT+REUxShgjImIB7NQtKYE+
	Mdevc5mli/wotjck2WuKQk7kf0I0MkPi66iiUp2Bz+eoSj1w0bEicr+Mtk3CCcpY/HILOzMZPGY
	sFeMrW18vFn6haHlSb8UN8uOfxhKUL6NWcnQhCdMytDTBR1+xWHfqhA==
X-Gm-Gg: AYBFou3aa/27+ZN4KKjC7s4G/OQwrEdWvznNjtJt4YaSsUYFLiPyvfjo51j9paZ7adh
	7y8WoUsKCuhVaVillmf+wx7Kqw4lJJwMRijAfMZ2d+Wd2fKZ53ZnWQy2DzP3c7SxzbMU/uYrsyD
	KSimiGWCSe6Dvf7dDGNQpgGRNBqI5OYoHfzu5R5zb+E+rr2nG6qZh5NsGpXshSxfY0IPwEZWyGh
	JzntupbANeU5ldqG4qDEUu9pt1wZR+efy7CDm3ihajjWIKT4E6LjzwKKl0mHPxuXJkuQFCgw1gu
	cOqCoVYhk0CJuqc9rQqkf3+28RlgK3ptfagHJwOdoS3xnc19PTBf4jDthu/2hBqghNxFruTzJeH
	psuBrUXNppFUO9c6+bhy81tJ22BKtGXUZiho08/LG8buBDhldZmE4iFrSOoU6wcfyaEs1
X-Received: by 2002:a05:600c:4fc9:b0:49c:fc6e:8cb9 with SMTP id 5b1f17b1804b1-49cfc6e8e1emr206321655e9.29.1788796625590;
        Mon, 07 Sep 2026 08:57:05 -0700 (PDT)
X-Received: by 2002:a05:600c:4fc9:b0:49c:fc6e:8cb9 with SMTP id 5b1f17b1804b1-49cfc6e8e1emr206321185e9.29.1788796625161;
        Mon, 07 Sep 2026 08:57:05 -0700 (PDT)
Received: from lleonard-thinkpadx1carbongen13.rmtit.csb ([151.29.41.106])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cf755c22esm320477955e9.0.2026.09.07.08.57.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 08:57:04 -0700 (PDT)
From: Luigi Leonardi <leonardi@redhat.com>
Date: Mon, 07 Sep 2026 17:56:57 +0200
Subject: [PATCH v2 1/5] sev: split set_guest_policy into set_guest_policy
 and set_id_block
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260907-fix_igvm_policy-v2-1-c8c50f1dbfda@redhat.com>
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

The set_guest_policy callback on ConfidentialGuestSupportClass mixed
two unrelated jobs: writing the guest policy bits and providing the
SEV-SNP ID block/ID auth for LAUNCH_FINISH. The two are only related
because both come from the same 'policy' section of the SEV/SEV-SNP
launch flow, but they need to be set at different times: the policy
must be in effect before LAUNCH_START, while the ID block is only
needed before LAUNCH_FINISH.

Split the combined callback into set_guest_policy(policy_type, policy,
errp) and set_id_block(id_block, id_block_size, id_auth, id_auth_size,
errp), keeping both call sites exactly where the combined callback used
to be called from. No functional change.

Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
---
 backends/confidential-guest-support.c       |  15 ++-
 backends/igvm.c                             |  14 ++-
 include/system/confidential-guest-support.h |  28 +++---
 target/i386/sev.c                           | 140 +++++++++++++++-------------
 4 files changed, 111 insertions(+), 86 deletions(-)

diff --git a/backends/confidential-guest-support.c b/backends/confidential-guest-support.c
index 156dd15e66..d60d1f6eaa 100644
--- a/backends/confidential-guest-support.c
+++ b/backends/confidential-guest-support.c
@@ -39,16 +39,22 @@ static int set_guest_state(hwaddr gpa, uint8_t *ptr, uint64_t len,
 }
 
 static int set_guest_policy(ConfidentialGuestPolicyType policy_type,
-                            uint64_t policy,
-                            void *policy_data1, uint32_t policy_data1_size,
-                            void *policy_data2, uint32_t policy_data2_size,
-                            Error **errp)
+                            uint64_t policy, Error **errp)
 {
     error_setg(errp,
                "Setting confidential guest policy is not supported for this platform");
     return -1;
 }
 
+static int set_id_block(void *id_block, uint32_t id_block_size,
+                        void *id_auth, uint32_t id_auth_size,
+                        Error **errp)
+{
+    error_setg(errp,
+               "Setting ID block is not supported for this platform");
+    return -1;
+}
+
 static int get_mem_map_entry(int index, ConfidentialGuestMemoryMapEntry *entry,
                              Error **errp)
 {
@@ -65,6 +71,7 @@ static void confidential_guest_support_class_init(ObjectClass *oc,
     cgsc->check_support = check_support;
     cgsc->set_guest_state = set_guest_state;
     cgsc->set_guest_policy = set_guest_policy;
+    cgsc->set_id_block = set_id_block;
     cgsc->get_mem_map_entry = get_mem_map_entry;
 }
 
diff --git a/backends/igvm.c b/backends/igvm.c
index 7b7bdc72b7..99304d6467 100644
--- a/backends/igvm.c
+++ b/backends/igvm.c
@@ -963,14 +963,22 @@ static int qigvm_handle_policy(QIgvm *ctx, Error **errp)
     if (ctx->platform_type == IGVM_PLATFORM_TYPE_SEV_SNP) {
         int id_block_len = 0;
         int id_auth_len = 0;
+        int retval;
+
         if (ctx->id_block) {
             ctx->id_block->policy = ctx->sev_policy;
             id_block_len = sizeof(struct sev_id_block);
             id_auth_len = sizeof(struct sev_id_authentication);
         }
-        return ctx->cgsc->set_guest_policy(GUEST_POLICY_SEV, ctx->sev_policy,
-                                          ctx->id_block, id_block_len,
-                                          ctx->id_auth, id_auth_len, errp);
+
+        retval = ctx->cgsc->set_guest_policy(GUEST_POLICY_SEV, ctx->sev_policy,
+                                             errp);
+        if (retval < 0) {
+            return retval;
+        }
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
index cc16c6b071..b53d13e2fa 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -2726,9 +2726,7 @@ static int cgs_get_mem_map_entry(int index,
 }
 
 static int cgs_set_guest_policy(ConfidentialGuestPolicyType policy_type,
-                                uint64_t policy, void *policy_data1,
-                                uint32_t policy_data1_size, void *policy_data2,
-                                uint32_t policy_data2_size, Error **errp)
+                                uint64_t policy, Error **errp)
 {
     SevCommonState *sev_common = SEV_COMMON(MACHINE(qdev_get_machine())->cgs);
     if (sev_common->state == SEV_STATE_UNINIT) {
@@ -2741,81 +2739,90 @@ static int cgs_set_guest_policy(ConfidentialGuestPolicyType policy_type,
                    policy_type);
         return -1;
     }
-    /*
-     * SEV-SNP handles policy differently. The policy flags are defined in
-     * kvm_start_conf.policy and an ID block and ID auth can be provided.
-     */
+
+    /* do not reset existing policy if policy was not set in IGVM  */
+    if (policy == 0) {
+        return 0;
+    }
+
     if (sev_snp_enabled()) {
         SevSnpGuestState *sev_snp_guest =
             SEV_SNP_GUEST(MACHINE(qdev_get_machine())->cgs);
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
+        sev_snp_guest->kvm_start_conf.policy = policy;
+    } else {
+        SevGuestState *sev_guest = SEV_GUEST(MACHINE(qdev_get_machine())->cgs);
 
-            finish->id_block_uaddr =
-                (__u64)g_memdup2(policy_data1, KVM_SEV_SNP_ID_BLOCK_SIZE);
-            finish->id_auth_uaddr =
-                (__u64)g_memdup2(policy_data2, KVM_SEV_SNP_ID_AUTH_SIZE);
+        sev_guest->policy = policy;
+    }
+    return 0;
+}
 
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
+static int cgs_set_id_block(void *id_block, uint32_t id_block_size,
+                            void *id_auth, uint32_t id_auth_size,
+                            Error **errp)
+{
+    SevCommonState *sev_common = SEV_COMMON(MACHINE(qdev_get_machine())->cgs);
+    if (sev_common->state == SEV_STATE_UNINIT) {
+        /* Pre-processing of IGVM file called from sev_common_kvm_init() */
+        return 0;
+    }
+
+    if (!sev_snp_enabled()) {
+        error_setg(errp, "SEV: ID block is only supported for SEV-SNP");
+        return -1;
+    }
 
-        /* do not reset existing policy if policy was not set in IGVM  */
-        if (policy != 0) {
-            sev_snp_guest->kvm_start_conf.policy = policy;
+    SevSnpGuestState *sev_snp_guest =
+        SEV_SNP_GUEST(MACHINE(qdev_get_machine())->cgs);
+    struct kvm_sev_snp_launch_finish *finish =
+        &sev_snp_guest->kvm_finish_conf;
+
+    /*
+     * Drop any ID block and ID auth from a previous pass before repopulating
+     * them, then set them only if an ID block was provided.
+     */
+    g_free(sev_snp_guest->id_block);
+    g_free((guchar *)finish->id_block_uaddr);
+    g_free(sev_snp_guest->id_auth);
+    g_free((guchar *)finish->id_auth_uaddr);
+    sev_snp_guest->id_block = NULL;
+    finish->id_block_uaddr = 0;
+    sev_snp_guest->id_auth = NULL;
+    finish->id_auth_uaddr = 0;
+
+    if (id_block_size > 0) {
+        struct sev_snp_id_authentication *auth =
+            (struct sev_snp_id_authentication *)id_auth;
+
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
 
@@ -2881,6 +2888,7 @@ sev_common_instance_init(Object *obj)
     cgs->set_guest_state = cgs_set_guest_state;
     cgs->get_mem_map_entry = cgs_get_mem_map_entry;
     cgs->set_guest_policy = cgs_set_guest_policy;
+    cgs->set_id_block = cgs_set_id_block;
     cgs->can_rebuild_guest_state = true;
 
     QTAILQ_INIT(&sev_common->launch_vmsa);

-- 
2.55.0

