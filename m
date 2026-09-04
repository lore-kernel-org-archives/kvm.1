Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B31CC4EC67D
	for <kvm@vger.kernel.org>; Fri,  4 Sep 2026 19:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788551992; cv=none; b=Eb3S0jEVSCSF40xD4xM4xi4G0K4VyzQjEogwFG6Z3eJXd/sLzopYUgbE8lj+48kmwmwK7AAiqWd4881hYFUFDitvZa0FkG+TLHJVOCR6xvqQeU+/tCxxKTucrVNzu90ECNJYgps6pWTF/VGu+B7h3w1R2WDNmlmx9CfGMyW6FI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788551992; c=relaxed/simple;
	bh=pBhxWaKYyHBx9ZkVP2bH1ohKdCKTnUGjTGeRf5Z8Jaw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rx67gE3pb4U3AVEnUNnmVYk5gjg9YoN8gb02/s79WS97+YkLOQff5GLM7EKrpHvivgByW7g2sSkAiab86wJFYabmAdzkbQc6bpGeHUVoeN0oCzdXP3UuixoWZXENidUBShkgTywXH+21E/W3koFA28iedV9JuGP2ntE2eQtorhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y3mU8XXb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y3mU8XXb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788551986;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=774JTQE9fhFJYG5Yl825DuZO/ePui9QPF2Hyr3EDJC0=;
	b=Y3mU8XXbS2x9fEwGpS71aVdcsjUEgIWPSkZ6bqRh4SVQybv8N5r7VKUh2JPG74EOE5HUdB
	tw9lL8ZhuzoByXYlBUpQljDkovqxPh/hWt6KT+xFRB0XtlkwhrfLlbrSf9tcpHwIjvKLSr
	BQDR9qWK7W6XWQpbn0tAI+rqhdVnALA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-262-GKfpf2pXNtGHTkqHkDc73Q-1; Fri,
 04 Sep 2026 15:59:42 -0400
X-MC-Unique: GKfpf2pXNtGHTkqHkDc73Q-1
X-Mimecast-MFC-AGG-ID: GKfpf2pXNtGHTkqHkDc73Q_1788551981
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2164218E9B1F;
	Fri,  4 Sep 2026 19:59:41 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com [10.2.32.117])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0FC9D18005B5;
	Fri,  4 Sep 2026 19:59:39 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 04 Sep 2026 23:58:08 +0400
Subject: [PATCH v4 25/75] sev: convert OnOffAuto legacy-vm-type property to
 QAPI-aware registration
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260904-qom-qapi-v4-25-a985f168e938@redhat.com>
References: <20260904-qom-qapi-v4-0-a985f168e938@redhat.com>
In-Reply-To: <20260904-qom-qapi-v4-0-a985f168e938@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Michael Roth <michael.roth@amd.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Zhao Liu <zhao1.liu@intel.com>, Marcelo Tosatti <mtosatti@redhat.com>, 
 kvm@vger.kernel.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=2878;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=pBhxWaKYyHBx9ZkVP2bH1ohKdCKTnUGjTGeRf5Z8Jaw=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqmyLJWYqOlOzUsa+tkot3difFdzObGXEd7adbW
 I6Fk1mLvqeJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCapsiyQAKCRDa6OEJdZac
 5YRMD/9DXtHutOu6gOoZwXIyIFx1xL19mRPJ1ca6TItIaUXKFteKjmz9GNqI9ZXYv1T4CXKClVH
 dm9ir9WT2NxpfBxk3UwvPHHn7YCYrtffx3qdAPPfz82aOprdPDZzzl6jDltOvJB2PKJ0yJ//wSm
 Fc4GJKzovbjPzgAblKcSMAJkcPTIUSGbexQMsVdY2CmF+1HvJh9iUEitdz7LeEsZGZEipzGrK06
 wZZ83aVIrxQMG8b6fh/bdD01Y3JG+Rd4xLw9rfSXSofKTA/q/vKOyn4ycqkyjXcPaYHHM9lWPzO
 1SUbM77fd/8KLBhcfXtUN9FlGuYVgFb6+z4k7171XSxtrERagKMDK8eyazLCY2Z2xwpIajUTsW2
 BIb0n82Cy3CZMqqAfxxRyw/TdcXPecmMDkPu6HAYH4Qhn+tiUPXs6Eqdlyc74is86ksHSXmnHjc
 aZNTIBM0rLD2wr4jTHr9K68ig8+u1B+pPVVEkaZLOwJj9o+uRzYhu4WfBbY9qC63WyW/piUaUWp
 wXvehkBvq4Yu9rAOxT9nIBTYq3ZDs3fNZnkikVpH7xkywmX3W6e6QpUIUgmUoLwcddHh3omv984
 WDIgcq2Qv85rwhoX+RNfVctIYCfccrtPmVw9HzwMr4qe+AzohR7s4m+I7ArdRmhjGi1eRPXoZKf
 I7IrISiFTiQT64A==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Convert the legacy-vm-type OnOffAuto property from manual
visitor-based callbacks to property_add_qapi_enum().

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 target/i386/sev.c | 29 +++++++++++++----------------
 1 file changed, 13 insertions(+), 16 deletions(-)

diff --git a/target/i386/sev.c b/target/i386/sev.c
index cc16c6b07123..b2c7260c80a4 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -20,6 +20,7 @@
 #include <sys/ioctl.h>
 
 #include "qapi/error.h"
+#include "qapi/qapi-type-infos-common.h"
 #include "qom/object_interfaces.h"
 #include "qemu/base64.h"
 #include "qemu/module.h"
@@ -2939,23 +2940,16 @@ sev_guest_set_session_file(Object *obj, const char *value, Error **errp)
     SEV_GUEST(obj)->session_file = g_strdup(value);
 }
 
-static void sev_guest_get_legacy_vm_type(Object *obj, Visitor *v,
-                                         const char *name, void *opaque,
-                                         Error **errp)
+static int sev_guest_get_legacy_vm_type(Object *obj, Error **errp)
 {
     SevGuestState *sev_guest = SEV_GUEST(obj);
-    OnOffAuto legacy_vm_type = sev_guest->legacy_vm_type;
-
-    visit_type_OnOffAuto(v, name, &legacy_vm_type, errp);
+    return sev_guest->legacy_vm_type;
 }
 
-static void sev_guest_set_legacy_vm_type(Object *obj, Visitor *v,
-                                         const char *name, void *opaque,
-                                         Error **errp)
+static void sev_guest_set_legacy_vm_type(Object *obj, int value, Error **errp)
 {
     SevGuestState *sev_guest = SEV_GUEST(obj);
-
-    visit_type_OnOffAuto(v, name, &sev_guest->legacy_vm_type, errp);
+    sev_guest->legacy_vm_type = value;
 }
 
 static void
@@ -2981,11 +2975,14 @@ sev_guest_class_init(ObjectClass *oc, const void *data)
                                   sev_guest_set_session_file);
     object_class_property_set_description(oc, "session-file",
             "guest owners session parameters (encoded with base64)");
-    object_class_property_add(oc, "legacy-vm-type", "OnOffAuto",
-                              sev_guest_get_legacy_vm_type,
-                              sev_guest_set_legacy_vm_type, NULL, NULL);
-    object_class_property_set_description(oc, "legacy-vm-type",
-            "use legacy VM type to maintain measurement compatibility with older QEMU or kernel versions.");
+    object_class_property_add_qapi_enum(oc, QAPI_ENUM_PROP(
+        .name = "legacy-vm-type",
+        .description = "use legacy VM type to maintain measurement "
+                       "compatibility with older QEMU or kernel versions.",
+        .qapi_type = &OnOffAuto_type_info,
+        .get = sev_guest_get_legacy_vm_type,
+        .set = sev_guest_set_legacy_vm_type,
+    ));
 }
 
 static void

-- 
2.55.0.543.g5ebe2ebe4ea8

