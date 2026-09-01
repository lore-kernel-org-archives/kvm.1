Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC73347A0BE
	for <kvm@vger.kernel.org>; Tue,  1 Sep 2026 10:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788257381; cv=none; b=uBuh/nx7vjOqhnIifYlx1uJXi4kcafli23cC93KQODJN2+luKKTPys8jv6agutAK9s+mjzcZQ0LiKn1P3K5ANJt0mP4+bdI+Uz2jzsDnaKwArc+f1MltkBWXwf0sd6mAYxdB4JZmgqCPs1gHh4sN0Tcax171Buk2nU/mE3If7vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788257381; c=relaxed/simple;
	bh=W+yhO71RGy4FJs1aO7VhSyOd5YO65mO9p6WSDOjyrzg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iAgDN6geJ0nZdyokBr+t8UbTAHLprcOJZayDAxr+4VWGqA26jHSe8FkFV8nsMShcO8tScJ0YNMZg5hHwvdgZNYAEWlJWx8Kf+qTxbShxhU6sGIThtSqGGnqKbc7/YAKgubpduz1CoTAldIdR0r27S3To1TISGAPI3DxbKHbh3i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e+bbZNdM; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=A0Efv8g3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e+bbZNdM";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="A0Efv8g3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788257378;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1q8tTUm5QcHyiu9DXLZbI88hsaICvNBYvi0zuGJw3GM=;
	b=e+bbZNdMSNWPnKjW4fwYx4RsuSJiaQH9HaPvCjZUmIoYRCau97sB1flpl2jfaLK1ep1eKq
	cVzJesTjVVJXMi3MgbMAPJcmOvMhbkK3+PeRZHnlpOuuFKruYnP1nkmMfXYOSy8ikETTNT
	hsxK8MeZcghWzo281SwJXIw3dVwtLVU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-569-ykDOiWVYPZqhaafVMTd1kw-1; Tue, 01 Sept 2026 06:09:35 -0400
X-MC-Unique: ykDOiWVYPZqhaafVMTd1kw-1
X-Mimecast-MFC-AGG-ID: ykDOiWVYPZqhaafVMTd1kw_1788257374
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-482f41ca436so4031954f8f.1
        for <kvm@vger.kernel.org>; Tue, 01 Sep 2026 03:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788257374; x=1788862174; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1q8tTUm5QcHyiu9DXLZbI88hsaICvNBYvi0zuGJw3GM=;
        b=A0Efv8g3lxLlPb3cFQKao/egMi4IRJe7Qd2Pd8/w52DooPDTwhfEM33ZZxt2qFgT4C
         EOZf06ouSoLCOhxDhiSsF+OdHa8zrfPxDXqftkNpZF6P0B5jzPPKw2HNZeAbP/l1RQrQ
         040WaJvS20QXFJsQXFnUMGsz011nZMflDs0vJ+9RaCcD81BnQMdU3C5WBO/zTKZNZvkz
         ZKw+DG86kn3dG4uw6L3phETBFgKCTnuFpdlHqwWIcwMec5t5rlfw3wzfAAlHSYJqxSoI
         bdpvkhWgvgBXMV5ShU8bzNYgqDn8KkTPx6oSLpaBNevvvsGmcuKL6MhPcJw/zrVqRpJR
         qUDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788257374; x=1788862174;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1q8tTUm5QcHyiu9DXLZbI88hsaICvNBYvi0zuGJw3GM=;
        b=NXEd5f8RVvu3Pvi4aUQq6cvfuH6NtmbUEgiSkcCL8Lds7WENvr70dcvL8h5WtpXmc8
         y0W5QVTt/hsIDcjHKWH87yjJN+unbakfKzmujqg9w1NQzLYvS8t1dXACmbWOnMnQeskt
         E/9MMBBBZSIW/lS19JelW1hIQEcqDZje0fWyrg3h/fWCbFqPzNXmirHEap8T9Vxl3bhs
         SyUtnrD6fxydKE5u8/Ckr/YNxJdFINtamimxikiyZ7am73CruAHGN6iyLwrgx7xJx4cz
         f3l5evEW0lJP8m/qXzs7sPW+EMViHSE03xJmHOj1Sjw1x0sQLYwNIlDBwuiF25KSXO/N
         uPwg==
X-Forwarded-Encrypted: i=1; AKwUvBwiomzfIy0UFvZb6fsg3Row6fjNciKJleeNHw/YNXg6MPljd59gbxhcpcA5wag6Y0rH4Ak=@vger.kernel.org
X-Gm-Message-State: AFuF++kZGuENmtvesxS1JQx3Zyk5roCI7gsuP+YVkNZmxvwOrz+SQrsH
	zq1YvdbDBMl3lNjv0AK/plWVFJfdF01IzyK/oPgfvBxbPCNoq2QfllMbQ9Ntvb+Rg8PRCmtgNTm
	soOoSXzp8suJlxa9pg/sx756QZAdnaDTyep/r4/epViypqxvTVzawIzSpXxByxlRUyWdBb63wbe
	CJzBUsdBrCP1pEMLhBdZu2bS8HqRuEl4pgjFWd9bjE
X-Gm-Gg: AYBFou28jSmHxKml3figeB6MNHMO7tct9JpdzBjUqlBz7OFrovxPytD8JQzVQ6H3Zsu
	BxM7hFln/axjhuNQQKWiNs9lWQkP0yX7tE+5Ld5nqRf16S7FwlUwec9J1A2n5IqD/+hwxEGaT7A
	ym76miXv8vFvJgF4SG3xGuofg/y0w5ShOTU2NCOfWQhQ+WFHhA2064Lz3CPjpqrObJP+v+G2s9n
	xuUtogzZlf6Ki9MCwCZKIhhgZEFxZiyDh7dRQVk4bDJW89FXNk6w7gt1h3advhax76Mp/ahZQr5
	bwOHl8yrUmGJRlH+aU7ZTOtFaq3JYS6+FPnJQmsZgH1487iZx/FQORuOGmn62hyaB5vubGcxcdf
	3mtYxpfe6gvsOkyFul3YMwOtdkqdBQopJwQHEA8TuvCwXLW0fhYYRdefnicc3168w4Kzl
X-Received: by 2002:a05:6000:991:b0:484:3311:3703 with SMTP id ffacd0b85a97d-484331138a0mr42340523f8f.26.1788257374275;
        Tue, 01 Sep 2026 03:09:34 -0700 (PDT)
X-Received: by 2002:a05:6000:991:b0:484:3311:3703 with SMTP id ffacd0b85a97d-484331138a0mr42340369f8f.26.1788257373745;
        Tue, 01 Sep 2026 03:09:33 -0700 (PDT)
Received: from lleonard-thinkpadx1carbongen13.rmtit.csb ([151.29.41.106])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48442d7c1c0sm3941620f8f.32.2026.09.01.03.09.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 03:09:33 -0700 (PDT)
From: Luigi Leonardi <leonardi@redhat.com>
Date: Tue, 01 Sep 2026 12:09:21 +0200
Subject: [PATCH 4/4] igvm/sev: forward the IGVM guest policy to the
 platform before launch
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260901-fix_igvm_policy-v1-4-e93a6cf8c5ac@redhat.com>
References: <20260901-fix_igvm_policy-v1-0-e93a6cf8c5ac@redhat.com>
In-Reply-To: <20260901-fix_igvm_policy-v1-0-e93a6cf8c5ac@redhat.com>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, Ani Sinha <anisinha@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>, 
 Marcelo Tosatti <mtosatti@redhat.com>, kvm@vger.kernel.org, 
 Luigi Leonardi <leonardi@redhat.com>
X-Mailer: b4 0.14.3

The guest policy carried in the IGVM guest-policy initialization header
was parsed into QIgvm but never forwarded to the confidential guest
platform: the previous callback ran at the end of qigvm_process_file,
after LAUNCH_START had already been issued, so writing the policy had
no effect.

Add a set_guest_policy callback and invoke it from the guest-policy
initialization handler, so the policy reaches the platform before
LAUNCH_START.

The guest policy can also be set on the command line. As it is part of
the attestation report, silently overriding it would cause attestation
to fail, so return an error if the command-line value differs from the
one supplied by the IGVM file.

Link: https://gitlab.com/qemu-project/qemu/-/work_items/4189
Fixes: 915b47078d ("backends/igvm: Handle policy for SEV guests")
Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
---
 backends/confidential-guest-support.c |  9 ++++++++
 backends/igvm.c                       |  4 ++++
 target/i386/sev.c                     | 39 +++++++++++++++++++++++++++++++++++
 3 files changed, 52 insertions(+)

diff --git a/backends/confidential-guest-support.c b/backends/confidential-guest-support.c
index a0b36d2da5..c0d15b4a76 100644
--- a/backends/confidential-guest-support.c
+++ b/backends/confidential-guest-support.c
@@ -38,6 +38,14 @@ static int set_guest_state(hwaddr gpa, uint8_t *ptr, uint64_t len,
     return -1;
 }
 
+static int set_guest_policy(ConfidentialGuestPolicyType policy_type,
+                            uint64_t policy, Error **errp)
+{
+    error_setg(errp,
+               "Setting guest policy is not supported for this platform");
+    return -1;
+}
+
 static int set_id_block(void *id_block, uint32_t id_block_size,
                         void *id_auth, uint32_t id_auth_size,
                         Error **errp)
@@ -62,6 +70,7 @@ static void confidential_guest_support_class_init(ObjectClass *oc,
     ConfidentialGuestSupportClass *cgsc = CONFIDENTIAL_GUEST_SUPPORT_CLASS(oc);
     cgsc->check_support = check_support;
     cgsc->set_guest_state = set_guest_state;
+    cgsc->set_guest_policy = set_guest_policy;
     cgsc->set_id_block = set_id_block;
     cgsc->get_mem_map_entry = get_mem_map_entry;
 }
diff --git a/backends/igvm.c b/backends/igvm.c
index 6545382546..5131ee7829 100644
--- a/backends/igvm.c
+++ b/backends/igvm.c
@@ -868,6 +868,10 @@ static int qigvm_initialization_guest_policy(QIgvm *ctx,
 
     if (guest->compatibility_mask & ctx->compatibility_mask) {
         ctx->sev_policy = guest->policy;
+        if (ctx->cgsc) {
+            return ctx->cgsc->set_guest_policy(GUEST_POLICY_SEV,
+                                               guest->policy, errp);
+        }
     }
     return 0;
 }
diff --git a/target/i386/sev.c b/target/i386/sev.c
index c76cdba8d2..533ea4b54e 100644
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
@@ -2723,6 +2725,40 @@ static int cgs_get_mem_map_entry(int index,
     return 0;
 }
 
+static int cgs_set_guest_policy(ConfidentialGuestPolicyType policy_type,
+                                uint64_t policy, Error **errp)
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
+        if (sev_common->policy_set &&
+            sev_snp_guest->kvm_start_conf.policy != policy) {
+            error_setg(errp, "SNP: policy mismatch between IGVM and CLI");
+            return -1;
+        }
+
+        sev_snp_guest->kvm_start_conf.policy = policy;
+    } else {
+        SevGuestState *sev_guest = SEV_GUEST(sev_common);
+
+        if (sev_common->policy_set && sev_guest->policy != policy) {
+            error_setg(errp, "SEV: policy mismatch between IGVM and CLI");
+            return -1;
+        }
+
+        sev_guest->policy = policy;
+    }
+    return 0;
+}
+
 static int cgs_set_id_block(void *id_block, uint32_t id_block_size,
                             void *id_auth, uint32_t id_auth_size,
                             Error **errp)
@@ -2848,6 +2884,7 @@ sev_common_instance_init(Object *obj)
     cgs->check_support = cgs_check_support;
     cgs->set_guest_state = cgs_set_guest_state;
     cgs->get_mem_map_entry = cgs_get_mem_map_entry;
+    cgs->set_guest_policy = cgs_set_guest_policy;
     cgs->set_id_block = cgs_set_id_block;
     cgs->can_rebuild_guest_state = true;
 
@@ -2970,6 +3007,7 @@ sev_guest_set_policy(Object *obj, Visitor *v, const char *name,
     if (!visit_type_uint32(v, name, &SEV_GUEST(obj)->policy, errp)) {
         return;
     }
+    SEV_COMMON(obj)->policy_set = true;
 }
 
 static void
@@ -3027,6 +3065,7 @@ sev_snp_guest_set_policy(Object *obj, Visitor *v, const char *name,
                            errp)) {
         return;
     }
+    SEV_COMMON(obj)->policy_set = true;
 }
 
 static char *

-- 
2.55.0

