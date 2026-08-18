Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB17432B13E
	for <kvm@vger.kernel.org>; Tue, 18 Aug 2026 11:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787051976; cv=none; b=lcpdccdc6dGkqBBaegzte36GWuEjt+Jr4KgR3ZpYfNyfYOTeSneJ/usAajV+VSbYk4V3UEpfbLL94WBlMnPHvHp7gT7ZnK+0/4CN3CwQ0B/DZbpUOR7uooH79kVBcS4ZOJ3kl0AVTorp0O47qvBCxgnpeJbNq56q3amawjjOv2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787051976; c=relaxed/simple;
	bh=zjd5b/7UtrJcexJ7ZEgc0BXA9ixM3XyWJFnBq9YLcUU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eQrwgV6rhqqvmzy9DAm46X4O4o8qoF5pEshu7lv9LQyDiJ9No+zLvKgH9YmDtmamkzEeO41gh6+Tizq5nkWMiorZkx0jOBPwaIQ4Wyj1iLM54+P+RfQMAJitDREY94pkLKJpdgbMDWLILUnJDW0NrONsouVQ6iRyfmX83nGHTNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SrhO8WhX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SrhO8WhX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787051973;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QDNDYwMd+sicJrNeQLwCkPpcMo5x0mg7HS77Hu2tB3c=;
	b=SrhO8WhXIa2KUCufFYU7ExSSRfiZEYUABqYqHobAsPJfVp6RyESPsU6yK7DFwE2I3gD3fH
	qyMndBVjYZcKapp9N1x3MHh1LAo3zSHxlAmnKy/E55BtwLvU2GY5OuRDam6jSC5VpY3B23
	mT5PUQC4WTX5jmYX5Ql0LWFnkwut8Gg=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-615-4NXOhBfKOTm6EoHIlCxb1A-1; Tue,
 18 Aug 2026 07:19:27 -0400
X-MC-Unique: 4NXOhBfKOTm6EoHIlCxb1A-1
X-Mimecast-MFC-AGG-ID: 4NXOhBfKOTm6EoHIlCxb1A_1787051966
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 443121955E78;
	Tue, 18 Aug 2026 11:19:26 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com [10.2.32.117])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0B1C43000239;
	Tue, 18 Aug 2026 11:19:22 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 18 Aug 2026 15:10:54 +0400
Subject: [PATCH v3 27/74] accel/kvm: convert OnOffSplit property to
 QAPI-aware registration
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260818-qom-qapi-v3-27-24b8bbbe3d86@redhat.com>
References: <20260818-qom-qapi-v3-0-24b8bbbe3d86@redhat.com>
In-Reply-To: <20260818-qom-qapi-v3-0-24b8bbbe3d86@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Michael Roth <michael.roth@amd.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 kvm@vger.kernel.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=2729;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=zjd5b/7UtrJcexJ7ZEgc0BXA9ixM3XyWJFnBq9YLcUU=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqhD2575Wv1PRV/gstnzfaIV8DJyMX6f4BnA0o2
 V0T081AAymJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaoQ9uQAKCRDa6OEJdZac
 5f5SD/9mmwoFmzGtRA41397kAHEq0c1NilgNCXg1k6hedDceKppZtBTWOsIL1QMajESJYKSDJtc
 EBhG0OgSiba22sLy1GIMQ/e39fi9nfqSob+JR247jCNqXs4XL51vh0qm653yZLzW23Ivmy70/VC
 la/UTJ1Py5jk/S0aG0+8R9fX0A3H8MJdcqWVPKudMagTPuCds6R8i80Vxpu0DIlIdZaC/itgTp2
 w3xSmtXVMSQj8FivhFbOjNflUxlAo2rqS5s0uYgj8dmzrMvbhPR4NanB1Qr+cagx5Es96jXBhPQ
 mMJcmXgAaJQxd6Sy2cC46CIfcieezsjV5YdWe4PCYNbyywiU9cDqEWnSlQkZ4ZatJjXG/LgoDKK
 D5fXH/riDybjGsNVccRa2oADqz/2I44VyVVKv4qZF0uwRvmzAipJmpnlG2H++nPIdtK01CWEG+B
 OjEPOFWin/WsybgIyeoZEB9fDfMQnn99GVfOBY7vsn9qPekmODRuFECuWcswRIMkB0GRunzPNAN
 jzV9tsm0rtY/uy2JZSFK++w0lGhUFK+ORz9q5fY/eJBcyy7fvw52ar7zLhKLNC7LFdsWFTLBLg1
 t9qSqTDECNgQbiNIbyrmrC3wKjR+db3NKyJMxGrMK+fdUsoWymij2DabujvrE10WW/RhZT2Khxj
 zdOZH2TGYaPWf5g==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Convert the OnOffSplit property from manual visitor-based
callbacks to property_add_qapi_enum().

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 accel/kvm/kvm-all.c | 26 ++++++++++----------------
 1 file changed, 10 insertions(+), 16 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 83cbd120a847..e2cfbcf44046 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -46,6 +46,7 @@
 #include "qapi/visitor.h"
 #include "qapi/qapi-types-common.h"
 #include "qapi/qapi-visit-common.h"
+#include "qapi/qapi-type-infos-common.h"
 #include "system/reset.h"
 #include "qemu/guest-random.h"
 #include "system/hw_accel.h"
@@ -4126,22 +4127,17 @@ static void kvm_set_kvm_shadow_mem(Object *obj, Visitor *v,
     s->kvm_shadow_mem = value;
 }
 
-static void kvm_set_kernel_irqchip(Object *obj, Visitor *v,
-                                   const char *name, void *opaque,
+static void kvm_set_kernel_irqchip(Object *obj, int value,
                                    Error **errp)
 {
     KVMState *s = KVM_STATE(obj);
-    OnOffSplit mode;
 
     if (s->fd != -1) {
         error_setg(errp, "Cannot set properties after the accelerator has been initialized");
         return;
     }
 
-    if (!visit_type_OnOffSplit(v, name, &mode, errp)) {
-        return;
-    }
-    switch (mode) {
+    switch (value) {
     case ON_OFF_SPLIT_ON:
         s->kernel_irqchip_allowed = true;
         s->kernel_irqchip_required = true;
@@ -4158,10 +4154,7 @@ static void kvm_set_kernel_irqchip(Object *obj, Visitor *v,
         s->kernel_irqchip_split = ON_OFF_AUTO_ON;
         break;
     default:
-        /* The value was checked in visit_type_OnOffSplit() above. If
-         * we get here, then something is wrong in QEMU.
-         */
-        abort();
+        g_assert_not_reached();
     }
 }
 
@@ -4278,11 +4271,12 @@ static void kvm_accel_class_init(ObjectClass *oc, const void *data)
     ac->has_memory = kvm_accel_has_memory;
     ac->allowed = &kvm_allowed;
 
-    object_class_property_add(oc, "kernel-irqchip", "on|off|split",
-        NULL, kvm_set_kernel_irqchip,
-        NULL, NULL);
-    object_class_property_set_description(oc, "kernel-irqchip",
-        "Configure KVM in-kernel irqchip");
+    object_class_property_add_qapi_enum(oc, QAPI_ENUM_PROP(
+        .name = "kernel-irqchip",
+        .qapi_type = &OnOffSplit_type_info,
+        .set = kvm_set_kernel_irqchip,
+        .description = "Configure KVM in-kernel irqchip",
+    ));
 
     object_class_property_add(oc, "kvm-shadow-mem", "int",
         kvm_get_kvm_shadow_mem, kvm_set_kvm_shadow_mem,

-- 
2.55.0.543.g5ebe2ebe4ea8

