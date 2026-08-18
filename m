Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26C9138F935
	for <kvm@vger.kernel.org>; Tue, 18 Aug 2026 11:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787051939; cv=none; b=tI3OQVjNTHqd/YV7qkUo8793DD0GPRVcQVWQN2yWNEzVwZC85psscdg0au2ox7iVK7suNH8JwbSEx14e41KENu32XyGUC+tsmfhLSzNwSjlGmU33+v4OQzWGDRCMRiKiYX68NiuGbDVKp58Zw2THk4SNxmEua4jVs5lS82n7Tlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787051939; c=relaxed/simple;
	bh=nkdSCroCL4rc/fXglavopKUEFdlDWMM9nOCJlhTw/EI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JRUbeDdjj5lPOp2MYkGDnrHHzuqBCpQYQxQ7bp8n/gDqBfkkxLZpOlA2M1Bp2pvYpLD4Xcfl/kAXNnLmLdPZc9YIJA3KpxwoGfeKl3+lk/D9qRQwFdcOJzYxG5kWMz0xFymbGLa21I/tH/soi58Qn4rmxA2463E0Un6yGvYUvQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z98ZS2SJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z98ZS2SJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787051937;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BsmdlaFnrsY3I+1UFAW3E5SehDcZ9lldQlqYb3G66HE=;
	b=Z98ZS2SJYOdCa3oTbEmX4uBzqfYCxoQkpFIntwfm9vlVf9O7wU1xv4EqMERo9Ijy01AmLT
	PCRglMFxYDlMxejLx4HsxVlm0qkJdUSj3t2lcxC32An6m4QgzY9KQg+9OlCbDxk5OlgUQu
	Y0170ZL6qC8VslHQDBDSPRmw01YXPnE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-142-g4lL4Jx5PtWwzWiWBlHIBg-1; Tue,
 18 Aug 2026 07:18:50 -0400
X-MC-Unique: g4lL4Jx5PtWwzWiWBlHIBg-1
X-Mimecast-MFC-AGG-ID: g4lL4Jx5PtWwzWiWBlHIBg_1787051929
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 920E61955F3D;
	Tue, 18 Aug 2026 11:18:49 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com [10.2.32.117])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 98A44180049F;
	Tue, 18 Aug 2026 11:18:48 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 18 Aug 2026 15:10:51 +0400
Subject: [PATCH v3 24/74] sev: convert OnOffAuto legacy-vm-type property to
 QAPI-aware registration
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260818-qom-qapi-v3-24-24b8bbbe3d86@redhat.com>
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
 Marcelo Tosatti <mtosatti@redhat.com>, Zhao Liu <zhao1.liu@intel.com>, 
 kvm@vger.kernel.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=2878;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=nkdSCroCL4rc/fXglavopKUEFdlDWMM9nOCJlhTw/EI=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqhD24pvx3ql+ZkehN6RSLvFPXUC4lRQL0xUxPC
 Wn6w7rAZMaJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaoQ9uAAKCRDa6OEJdZac
 5Uu3EACZbJeifRZ/wBI4hxZp9Pmq1hD/nshXm+OLnCOjvOmtwgiluUSPXlR7CwzA3qIGiYC7kuE
 GXEZ+9kJ8wZJ+uz53SoLyYRpXz2nYo6t7yux8jSF4W/YP8J1gisT2qhd2OAOpnwldg89SAv+48k
 ecUim5oFdTsK+PeVHOoWelPilMT8KOuStGcnUYvSVlyK674pekPbWouyDg/Vw9XQRk0+skjaC4c
 lkZKLX259HbG1EQ+c0o3bRmbEC6Cu4M7Lrs1LHVqH6MqjOSkMPXhbhd5bKiKr+aV1QdjUV2nZ0f
 B4JdfqVtEMFguc37IzrFTHrzvHp5TwM+aAXcrqS3pauB5Tp4F2zXz+DQxMvs5EagKwqZwYZTPkp
 E67vg0vakMYvcRZIp9UOUAEJyYm2mrGw+ymRFwGApcqF//VrD7ITpZ7bmiD5U23mRA0gIMHWL7d
 whkMdZZWYz+eYsEERiGTpS4MMt0QQCvEiiKCICwOUjWgV0+D43ZJvgH+8tKmoAA7N1ur+2QWmMK
 HdE3NVteRTqgJ7Y4hSaoD+A/PKDVZFMQPue/ajwcn1D/vpHAkcfloD7XRkLL8qUYONKuuzF2ZVe
 i4YhNibDRiDrTGxq0Ihv1DvzpO1vI5bQaK0LddS+pSOlcXgIPGXF0QJQe2kz1zTjjvwRItYoRLs
 ytHCUr7G4yLNzIQ==
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
index d7dcefc8ecf5..335a504af4db 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -20,6 +20,7 @@
 #include <sys/ioctl.h>
 
 #include "qapi/error.h"
+#include "qapi/qapi-type-infos-common.h"
 #include "qom/object_interfaces.h"
 #include "qemu/base64.h"
 #include "qemu/module.h"
@@ -2880,23 +2881,16 @@ sev_guest_set_session_file(Object *obj, const char *value, Error **errp)
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
@@ -2922,11 +2916,14 @@ sev_guest_class_init(ObjectClass *oc, const void *data)
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

