Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C5F2AD37
	for <kvm@vger.kernel.org>; Fri, 11 Sep 2026 16:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789144757; cv=none; b=O525gPNBb4Uogax5zueRXWD2lySMnTd9VrDCWchNp9ZMOdH02oBNqRAga01ycXc/Se/GwEWBkohA3X9IIOE8PcA8Za6JAJIn6fWa+YsaaGyxtU5Q04sNJWjEtPYFSTsaWfXbWwAIEv0EvZWtpnWqz7kOpu5XhBb79gYsdx/zQfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789144757; c=relaxed/simple;
	bh=zjd5b/7UtrJcexJ7ZEgc0BXA9ixM3XyWJFnBq9YLcUU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=idY1sLWq9iQIByIPy7cdzw3+dbzttZB2+/veINR9A1mdRViqX8Ilk/1Z43PIMSipyw8VjAcCCqlnLxmO3jIdF4gR+Hl3Uo+/PaD3BPHQwqqwqwT4V+fcX7+dEXt98IlnVmrmxPGGlyNlYli9pb2Ms8fSMB0pEnFfKXC+k1+al7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gnbwzHtU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gnbwzHtU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789144753;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QDNDYwMd+sicJrNeQLwCkPpcMo5x0mg7HS77Hu2tB3c=;
	b=gnbwzHtUylWiVGMpgfwBNw49nSeAEQclYWo1XL/Sy5uV9/1H1HVqus98DS6hi8EywESdin
	h6KL833nzNV0UOYN9ehvxznn4rsq5qY8Is8vacip11BnR/tOaiGwSLxeGM4LrPm5SX222W
	5ISLoYh9MKdU27GWMTnraUyQIb1jnng=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-214-9De6hxvcP7-d4kD-hUwgTA-1; Fri,
 11 Sep 2026 12:39:12 -0400
X-MC-Unique: 9De6hxvcP7-d4kD-hUwgTA-1
X-Mimecast-MFC-AGG-ID: 9De6hxvcP7-d4kD-hUwgTA_1789144751
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E517C19539B2;
	Fri, 11 Sep 2026 16:39:10 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com [10.2.32.117])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1925B180034C;
	Fri, 11 Sep 2026 16:39:09 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 11 Sep 2026 20:35:02 +0400
Subject: [PATCH v5 28/62] accel/kvm: convert OnOffSplit property to
 QAPI-aware registration
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260911-qom-qapi-v5-28-7732a55b7760@redhat.com>
References: <20260911-qom-qapi-v5-0-7732a55b7760@redhat.com>
In-Reply-To: <20260911-qom-qapi-v5-0-7732a55b7760@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Michael Roth <michael.roth@amd.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 kvm@vger.kernel.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=2729;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=zjd5b/7UtrJcexJ7ZEgc0BXA9ixM3XyWJFnBq9YLcUU=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqpC25CxJ4xEHJLvxJhaHYnIycAp0qraAcc6cI3
 Xcpn82CiXKJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaqQtuQAKCRDa6OEJdZac
 5RH0EACf1M4aVMk9P2eEktkHlLqlaQdRuqWYVtFHmfbNFnL1vO/wZ2M4Aba/4ygc+MBbDEOJdds
 3/28LzWiL+AMdOazOalSYfBFnEWvDFBQEx+K2pQIgjsRA2q1nTXzgWZT1MfKWDbHX9wYmpUpuYx
 38AHMRr59mtrGBIAeB/IQa42bRW3nDghRn50xJ1HjLkJwA/R4juIexRubqEUUcl6GVWRTHaI5NX
 WgNwYZisHed93SC4IO+o7Hl2m6coThM8I4qOoZH8S/+jlJ4n3KnBnh0BMlHTepQVqG7BsVWfG1d
 1TLJ4lZjru+DQslA1k9KBJa8UVPTwaocKK1RqtbbxI911470wG0+L8byw1MprPgiTTjX1I9Ngjh
 mmg9aYhmOTi8F4cOVTIkdsh/TXc0rQXqb3ZvjdG75i7qCmAk/FuQhrRwtVzXj2APTom9eF3qtvG
 e4emnnftnFg84kywvXDqGkynVylv/0TEuoBQgA9VUyIMj1KKNZl6sE6n+vD9A4F7HzNjqaTwV2K
 5OBrC81Ad69hAAKRtIzSMKF2VFty8K6rs+6ojxLHdRTOP5mB6dNHpBx8mALrSqeAc1/wBNC9Ix9
 mTsyxhtmTRg9pqoFf2B6dlyihKa9vVpZIr1N6m7+GJxQs7NByEKclIiHCJJXt4zUT52+tH1BPJw
 3eV2vav+zPpw8xw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

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

