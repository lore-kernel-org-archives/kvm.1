Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D21FE51118B
	for <kvm@vger.kernel.org>; Mon,  7 Sep 2026 15:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788796634; cv=none; b=VDKxgDAX/1jXfPlHivUX3kp7Q06YZKtYkuGKz2Ho3mBw219o8qBSvmyono4NCgiaKtgICf/ULz3bT5iFBxI0iFVrwysmajFQyNFRiUJDZefbKBt+3d42/49GiOqpq7ldtHZ2GlLdKFurvhWoaogI75m7+PhFV1yxcz4KIAiJ7Jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788796634; c=relaxed/simple;
	bh=VhSl+vgqLGjB+IiD1F5Uur29XSqE4XnTA0yGCHgFzzA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CuarjPg1v3Z7uTQcgHbDp652w8kG63m9U+YlZ2q/MyZxPGkhG0VIr/DUdDrOfjiLQLrrCmVlyEzkpFDj4AW13/EQ6jKIekpssYQatEUy10xEyURRm+O44/SfS5DSuYn/N1ua2YyLJneAfsoA2oXl8G8NACyAQVkSaPacAeYh9TM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YNgiTlnb; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=baqMxXko; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YNgiTlnb";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="baqMxXko"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788796631;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z5hdb76LHaeRDjiMZ4Xz5jIByuQ8SJeJucbeRZQQXsU=;
	b=YNgiTlnb+NgBHYZRFzUbmQR8CLa7uGE/gV1aOq+rgHa3yQsF7CPOKORDFM83AVayj8a1UL
	xTrLaOv6nJYaMIFg9vUCOQBhT/5KmMP16yr7bpfkUYg98ZdW0e+mVzMvyTkKtDjsTdywoE
	DEmUOghl7ur2aIuND1qQS4/nDgJ+ywc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-194-47fUUlPBMM6JlM0ZERbBfA-1; Mon, 07 Sep 2026 11:57:10 -0400
X-MC-Unique: 47fUUlPBMM6JlM0ZERbBfA-1
X-Mimecast-MFC-AGG-ID: 47fUUlPBMM6JlM0ZERbBfA_1788796629
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-495529a93f9so36479125e9.3
        for <kvm@vger.kernel.org>; Mon, 07 Sep 2026 08:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788796629; x=1789401429; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Z5hdb76LHaeRDjiMZ4Xz5jIByuQ8SJeJucbeRZQQXsU=;
        b=baqMxXkorh68JWhyUj0rAW5c4uqsKSM1Oi+IB38EDgoePY/s7A6s8UlWZkyBtRYHSi
         OYfH9zA0aC3PcsiGF/NKEBBvBdVKFQnYbxpFWZA4r+F+bmusjwBxRDXlflMDYS0XsY5M
         qm430iU7fkfEDdOh5G2UDyYwoaMmA413+GD+ko3vkVgPJujxgr7+G30Qhq0DH948mBB0
         xsz3shQUxlFFi+O+V1HtS2L7oU3QZ+f6kcV3xxv+aicFEI59IHmjC3HZBC9Pkb+OCJtG
         l/HAIZ/iqU1zzK24Vn6ERub/9qsOzEVGn5pnJaS5U2OnlNy57D3t+dbtv85h2OGMnTk6
         zf1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788796629; x=1789401429;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Z5hdb76LHaeRDjiMZ4Xz5jIByuQ8SJeJucbeRZQQXsU=;
        b=dOM+OSJEw3FpQO578u9mli0S6Pb1yvyUAUAG/OUMfWKEGhYrlBdl6gQQPH4PJRYv/6
         qKDTv7tgJrv8pSHI2XlgSyDsK7yXUH3sJeaimRy0brXLL9Lhlmu7yoW6z67wmXv+a8sR
         1W9zbFDYO7Rts3HuaQaIcef4Yvv5952Ni56A4ZDnJiN6FSFsdcgsPG4sVk6SbpOOQSgy
         oHZ/ev7pbcvS1Ibg8Ac6D6DGlGcIHb8j1sFk1BHDRbl3YUewsIVur4jp//i6LXQWGSme
         q+kV28xgaMEUopuhAY0go347sCYhaWj9F5BdyZcxyrHKWZGIeWEYg6EY1qczNE0Dmpmt
         +P8w==
X-Forwarded-Encrypted: i=1; AKwUvByFOBIoHgvV+rd82Govdy6ddJbYfBYNB3TLVvl/ldx1S5j4Ws7szM4BKvXbm2CEMyUbyng=@vger.kernel.org
X-Gm-Message-State: AFuF++kgqpwgg9ypPO3wSUSmA5BcveH6s9SLg1WOT62xpnkgyR138KWv
	1EDmDvwBzw59p4QFRmGoGBtzlyxW15aM5l0KuzlDV3cogHzOmssWhlKv/9HI++/DKI1wQ3yV9Jq
	t9ZNF4s/tovfh+lv6e+mqyEwbW9PzOMiww0XJr53Adg7jVgvID2ZXqw==
X-Gm-Gg: AYBFou2P1HCc7203RqLEcme2m55PBdY/DkWByLCLTF41nwZx6ldqtO8VFyPPfDNxxHY
	HU7z6+rt5ygrhHIOMuwC0SBBD0XHmMkCdxgMYtezMlPRiuuUAC4jiF7dzdNG6EGNNWqyk5vIUiD
	1tBnYhsnLAsCNofG54bbdXLcYFE64lHZaF+RCcJ1Qfs3/7Ds72Gv85GvAvL681pO2rEw1XQ9x0I
	UGR7ZWP3ixuQO4UF31EbVpePLywjccDMrOEjgLgxQPhfE0A8RbJXV7fpWQa8w6KX/3JvPMfIoOF
	rP0sbKH26tzziydY5N0ektCFoYWonG/J0ZG2NMb55/ZR6uFptzO34OSAIyvnp/S+6VDm3N67CE+
	jQXoZLjTZzzlZOuVLI9C5voaYUFVJnszVenckWIi0NVSAd2/H861E9XRQZ+IHoSyNykZg
X-Received: by 2002:a05:600c:1d1c:b0:49d:91d:d192 with SMTP id 5b1f17b1804b1-49d091dd358mr118096885e9.5.1788796629256;
        Mon, 07 Sep 2026 08:57:09 -0700 (PDT)
X-Received: by 2002:a05:600c:1d1c:b0:49d:91d:d192 with SMTP id 5b1f17b1804b1-49d091dd358mr118096055e9.5.1788796628557;
        Mon, 07 Sep 2026 08:57:08 -0700 (PDT)
Received: from lleonard-thinkpadx1carbongen13.rmtit.csb ([151.29.41.106])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cf755c22esm320477955e9.0.2026.09.07.08.57.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 08:57:08 -0700 (PDT)
From: Luigi Leonardi <leonardi@redhat.com>
Date: Mon, 07 Sep 2026 17:57:00 +0200
Subject: [PATCH v2 4/5] i386/sev: add a get_guest_policy callback
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260907-fix_igvm_policy-v2-4-c8c50f1dbfda@redhat.com>
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

The next patch populates the SEV-SNP ID block's policy field.
That value must be whatever policy is currently in effect on the platform
but there is no way to read it back: the policy can come either from an
IGVM GUEST_POLICY header or from the command line, and the command line
sets it directly into the SEV/SNP guest struct without going through IGVM.
Reading it back from the platform is the only source that always reflects
the value in effect, regardless of where it came from.

Add a get_guest_policy callback to ConfidentialGuestSupportClass for
this purpose. It is not yet used; the following patch wires it into the
SNP ID block population.

Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
---
 backends/confidential-guest-support.c       |  9 +++++++++
 include/system/confidential-guest-support.h |  8 ++++++++
 target/i386/sev.c                           | 24 ++++++++++++++++++++++++
 3 files changed, 41 insertions(+)

diff --git a/backends/confidential-guest-support.c b/backends/confidential-guest-support.c
index d60d1f6eaa..91701f1a5f 100644
--- a/backends/confidential-guest-support.c
+++ b/backends/confidential-guest-support.c
@@ -46,6 +46,14 @@ static int set_guest_policy(ConfidentialGuestPolicyType policy_type,
     return -1;
 }
 
+static int get_guest_policy(ConfidentialGuestPolicyType policy_type,
+                            uint64_t *policy, Error **errp)
+{
+    error_setg(errp,
+               "Getting guest policy is not supported for this platform");
+    return -1;
+}
+
 static int set_id_block(void *id_block, uint32_t id_block_size,
                         void *id_auth, uint32_t id_auth_size,
                         Error **errp)
@@ -71,6 +79,7 @@ static void confidential_guest_support_class_init(ObjectClass *oc,
     cgsc->check_support = check_support;
     cgsc->set_guest_state = set_guest_state;
     cgsc->set_guest_policy = set_guest_policy;
+    cgsc->get_guest_policy = get_guest_policy;
     cgsc->set_id_block = set_id_block;
     cgsc->get_mem_map_entry = get_mem_map_entry;
 }
diff --git a/include/system/confidential-guest-support.h b/include/system/confidential-guest-support.h
index 6d35ddb97a..27ae0a21b6 100644
--- a/include/system/confidential-guest-support.h
+++ b/include/system/confidential-guest-support.h
@@ -137,6 +137,14 @@ typedef struct ConfidentialGuestSupportClass {
     int (*set_guest_policy)(ConfidentialGuestPolicyType policy_type,
                             uint64_t policy, Error **errp);
 
+    /*
+     * Get the guest policy currently configured for the confidential
+     * platform, be it from the command line or from a previous call to
+     * set_guest_policy. Its format is the same as for set_guest_policy.
+     */
+    int (*get_guest_policy)(ConfidentialGuestPolicyType policy_type,
+                            uint64_t *policy, Error **errp);
+
     /*
      * Set the SEV-SNP ID block and ID authentication block. These are
      * passed to SNP_LAUNCH_FINISH to provide signed verification of the
diff --git a/target/i386/sev.c b/target/i386/sev.c
index 38f97fd9b2..f11fdb6590 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -2758,6 +2758,29 @@ static int cgs_set_guest_policy(ConfidentialGuestPolicyType policy_type,
     return 0;
 }
 
+static int cgs_get_guest_policy(ConfidentialGuestPolicyType policy_type,
+                                uint64_t *policy, Error **errp)
+{
+    SevCommonState *sev_common = SEV_COMMON(MACHINE(qdev_get_machine())->cgs);
+
+    if (policy_type != GUEST_POLICY_SEV) {
+        error_setg(errp, "SEV: Invalid guest policy type provided for SEV: %d",
+                   policy_type);
+        return -1;
+    }
+
+    if (sev_snp_enabled()) {
+        SevSnpGuestState *sev_snp_guest = SEV_SNP_GUEST(sev_common);
+
+        *policy = sev_snp_guest->kvm_start_conf.policy;
+    } else {
+        SevGuestState *sev_guest = SEV_GUEST(sev_common);
+
+        *policy = sev_guest->policy;
+    }
+    return 0;
+}
+
 static int cgs_set_id_block(void *id_block, uint32_t id_block_size,
                             void *id_auth, uint32_t id_auth_size,
                             Error **errp)
@@ -2888,6 +2911,7 @@ sev_common_instance_init(Object *obj)
     cgs->set_guest_state = cgs_set_guest_state;
     cgs->get_mem_map_entry = cgs_get_mem_map_entry;
     cgs->set_guest_policy = cgs_set_guest_policy;
+    cgs->get_guest_policy = cgs_get_guest_policy;
     cgs->set_id_block = cgs_set_id_block;
     cgs->can_rebuild_guest_state = true;
 

-- 
2.55.0

