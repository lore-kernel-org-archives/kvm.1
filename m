Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50BF147989E
	for <kvm@vger.kernel.org>; Tue,  1 Sep 2026 10:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788257382; cv=none; b=mRA4EMy5uMDdoTfr+lFf0ff2Ie3VYn3rjw20Vx3qQw0oBaHsHWeXaD1AmbmCqrNPBiIIyelNdt8ufjwrG5ebSX7cH9DjXELppEHEICGe734zU4Y1n0AXDpKY06DXVDiXKLpHtXeTJhNa40t0AHejD6l50rAYj8CQd+p72QUmwhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788257382; c=relaxed/simple;
	bh=cbm6MB2Y3g/SJML74YGkeRFZslsgPpMX0LQlGoLqKrk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=j4NthvG81rGwZEVt5YufBUdmfGuydC7vMLy3lo+6kimdXqFTKCUaqsWLRq+YCXRKIjSGDLoEC1xZlyuKTxn1O1YczYVZDfraOYFqpAuV4gPp7nzWXMD3OFhrndMdZcR95er8PQ5RAGA8EwMrpQOpwuRaZVXrkhpWWXMsJo0iYDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OmsDzJy1; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=TVIoVFbw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OmsDzJy1";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="TVIoVFbw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788257380;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QIEprrdH7LZapW8zVSYHVi8VsanTJW2FyNSSrivNz7A=;
	b=OmsDzJy1DRXBh0da4+OfwS9MaY8JK/CGvuqX5cXxgj/TuKbR6D68lWf5ltzlZ38FQV94aI
	fp4MVHvAe3NEPxcHypLq4gXniCPl9yIpgOrsWRCnX8MM6w/pn4h+8Q5VeC+8TH2GhgiTTE
	VQXolCWpoigknpTtTnUa0rxrNbtqN48=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-coUbpW1hNTiDQkFbfy7TMw-1; Tue, 01 Sept 2026 06:09:34 -0400
X-MC-Unique: coUbpW1hNTiDQkFbfy7TMw-1
X-Mimecast-MFC-AGG-ID: coUbpW1hNTiDQkFbfy7TMw_1788257373
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-495689bfcc8so30812845e9.1
        for <kvm@vger.kernel.org>; Tue, 01 Sep 2026 03:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788257373; x=1788862173; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QIEprrdH7LZapW8zVSYHVi8VsanTJW2FyNSSrivNz7A=;
        b=TVIoVFbw6CTxK50tuhF7AlcHeqMPt/ZpGNV+KthB3Z3p1zv32ZaY9/Vwozd3yJizFO
         /O3LbK+NE53ukvNAUxm3cyKMdgaOOqilM1erVMwmI0V6oEeIbDfGNxIK15PszXEZaGkI
         MAWmtWYpwrqsy20zqxWJBoL6pguQ7YqKAoAqptdSpLXrKdVGQ+S/5Tv6CODrZeTSas+E
         PUFpe+NeMUbc5tu1YCpMQkyAGIO5HUx50VhidrCrT+AFOCL0DX9fde1Ka6enNd5pPkO1
         uB1PAOdnlaJKI0M0+FsT5+Rt60gaoj/lfD+flYM9oDgUVlHJn9g1MCzQD47Zg5/5B70s
         PTCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788257373; x=1788862173;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QIEprrdH7LZapW8zVSYHVi8VsanTJW2FyNSSrivNz7A=;
        b=gaXePMZ9HXVI+WwdECr39aTkCZC/c/I0XIns/y2Qh+nqF+V2xqtHKgEVA7ojkX8OX/
         tPaJ+XWJCcyNgE6Xm/MRotQh7YATEo3wkSpDizjukUAsvtKkQ4oRGgzhTqvgWJpxEkYD
         6a93iKEUlOshKfvMkuLtMSNHH1Rmbt7fCMUaOwlET1xDduoK2UdWF0LAZpDfnlEAc/RR
         9/dTHFnd+dqR6laRVRhwNMfbthYUL62dFISwbC8zhO8E5ft+vnqrNeDoGZqorcVWmluh
         uGi5/fxoHZt7kY8mrcCwSIb1UQAb8ywnp/MBSEzUWvT1kSouzsBRLKeNu5G4fe5hhcNY
         6OYg==
X-Forwarded-Encrypted: i=1; AHgh+RqJp0dPtPTTQ8QPo5v160LKLy4MrVAN2PpcTde2FlCeqfz5iAxJ2MnX5Q6z8vaDaXGQWpM=@vger.kernel.org
X-Gm-Message-State: AFuF++nRmRScmji/689uGBLNYa8/73CBvk7Lw/GOumBVkZLXf0+XI+qb
	4BMKTT89oapkpOOOi/5WPrCVRfIg8XWEp3Stfrz6/8CowYtCneaiY3b+KJvmbat4AWustCrz3Bz
	LaLBb0lBZo2WBPkEOaPQ78+tjURs2xjLbSoEy5kELF7aOcDu6a6aG4gW42ANKXY173xZoAzyH3h
	mW0u5CInxVLe2k3XWUEUEhiGZyhgaWTwwWpf62d0Rh
X-Gm-Gg: AR+sD13U8R47RIGv7ODO1mKoFYl/krh1cLHeC9ED3LhqLNzotNPFjG/MqyOQQeoGHdY
	ahURcfe30xwIS5y6puFn9Jj80ckTLk8egxX+AYokFiuWnSrU/vVeaTpiK7LCMrd1fJ6A002/3tW
	agQhUloK3tck7L0ABXXr06jVnSo3EouyptO0oCrxMfsPm+lLjtVGo9wH3YYId4xbk9eSSguamJi
	p3f3YNKXXiZzcUpgeiYCe3RfW4CpJSrOSHpVQ3jLHQi9WiiR5h5WDsif0EatdjUeBMMhb9lKYPe
	rZ6pWgb24w63+jg2yBHxVesq4U56ZypuwTTYxE4K+7Q/uIM0rsi47Sc4xraB/jp8PUf2b0f5N3g
	usMvoENVutmUXVUUVBscMMoniruS+Tukg7i9OQhOYfJ4QIed7UvNHdkSgjraTEBAgKHnh
X-Received: by 2002:a05:600c:8411:b0:499:bf0e:95c8 with SMTP id 5b1f17b1804b1-49cdc405494mr133905275e9.1.1788257373064;
        Tue, 01 Sep 2026 03:09:33 -0700 (PDT)
X-Received: by 2002:a05:600c:8411:b0:499:bf0e:95c8 with SMTP id 5b1f17b1804b1-49cdc405494mr133904365e9.1.1788257372560;
        Tue, 01 Sep 2026 03:09:32 -0700 (PDT)
Received: from lleonard-thinkpadx1carbongen13.rmtit.csb ([151.29.41.106])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48442d7c1c0sm3941620f8f.32.2026.09.01.03.09.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 03:09:32 -0700 (PDT)
From: Luigi Leonardi <leonardi@redhat.com>
Date: Tue, 01 Sep 2026 12:09:20 +0200
Subject: [PATCH 3/4] i386/sev: convert the guest policy properties to
 custom accessors
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260901-fix_igvm_policy-v1-3-e93a6cf8c5ac@redhat.com>
References: <20260901-fix_igvm_policy-v1-0-e93a6cf8c5ac@redhat.com>
In-Reply-To: <20260901-fix_igvm_policy-v1-0-e93a6cf8c5ac@redhat.com>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, Ani Sinha <anisinha@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>, 
 Marcelo Tosatti <mtosatti@redhat.com>, kvm@vger.kernel.org, 
 Luigi Leonardi <leonardi@redhat.com>
X-Mailer: b4 0.14.3

Both SEV/SEV-ES and SEV-SNP expose a "policy" object property. The
SEV/SEV-ES one was registered as a plain uint32 pointer property, and
the SEV-SNP setter ignored the result of the visit.

Give both properties explicit getter/setter functions and check the
return value of the visit in the setters. This is preparation for
tracking whether the guest policy was set on the command line.

No functional change intended.

Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
---
 target/i386/sev.c | 30 +++++++++++++++++++++++++-----
 1 file changed, 25 insertions(+), 5 deletions(-)

diff --git a/target/i386/sev.c b/target/i386/sev.c
index 465415c535..c76cdba8d2 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -2956,6 +2956,22 @@ sev_guest_class_init(ObjectClass *oc, const void *data)
             "use legacy VM type to maintain measurement compatibility with older QEMU or kernel versions.");
 }
 
+static void
+sev_guest_get_policy(Object *obj, Visitor *v, const char *name,
+                     void *opaque, Error **errp)
+{
+    visit_type_uint32(v, name, &SEV_GUEST(obj)->policy, errp);
+}
+
+static void
+sev_guest_set_policy(Object *obj, Visitor *v, const char *name,
+                     void *opaque, Error **errp)
+{
+    if (!visit_type_uint32(v, name, &SEV_GUEST(obj)->policy, errp)) {
+        return;
+    }
+}
+
 static void
 sev_guest_instance_init(Object *obj)
 {
@@ -2964,8 +2980,8 @@ sev_guest_instance_init(Object *obj)
     sev_guest->policy = DEFAULT_GUEST_POLICY;
     object_property_add_uint32_ptr(obj, "handle", &sev_guest->handle,
                                    OBJ_PROP_FLAG_READWRITE);
-    object_property_add_uint32_ptr(obj, "policy", &sev_guest->policy,
-                                   OBJ_PROP_FLAG_READWRITE);
+    object_property_add(obj, "policy", "uint32", sev_guest_get_policy,
+                        sev_guest_set_policy, NULL, NULL);
     object_apply_compat_props(obj);
 
     sev_guest->legacy_vm_type = ON_OFF_AUTO_AUTO;
@@ -3004,9 +3020,13 @@ static void
 sev_snp_guest_set_policy(Object *obj, Visitor *v, const char *name,
                          void *opaque, Error **errp)
 {
-    visit_type_uint64(v, name,
-                      (uint64_t *)&SEV_SNP_GUEST(obj)->kvm_start_conf.policy,
-                      errp);
+    SevSnpGuestState *sev_snp_guest = SEV_SNP_GUEST(obj);
+
+    if (!visit_type_uint64(v, name,
+                           (uint64_t *)&sev_snp_guest->kvm_start_conf.policy,
+                           errp)) {
+        return;
+    }
 }
 
 static char *

-- 
2.55.0

