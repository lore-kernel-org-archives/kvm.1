Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB6A3DDAFB
	for <kvm@vger.kernel.org>; Fri, 11 Sep 2026 16:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789144748; cv=none; b=gezeeTwQmN9xxje1oKAR7yPNIhI9tld2f5uDYYbypSmpDo+6GqFpLG6LHnkp1pAJ3KrUnaXrP8gNT/4s+ThRfpFPeQSTw58gmkjF11L3jH/Q61LeFFQ0Qnhe+LjBd4fbGh6n/5vJED81wKixNJLzyAmCAD69WmKjJKDulEOSJfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789144748; c=relaxed/simple;
	bh=pBhxWaKYyHBx9ZkVP2bH1ohKdCKTnUGjTGeRf5Z8Jaw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tzUmMKOEGTwuKErJWiJm9O1h9P4SNUbEzSmoDsJNU3VURUW9weSLCVxnHsToO3kes1iFtQkhSYnCsPAoLxH98kCLgua/JGxyDF/25dwGLf8ryBRKqmjkDUGxrVjXJD1T4ElPE9/cne24mEaeX8JRvODHsu5uSoWuVdU/GB/dcy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SjejDJ85; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SjejDJ85"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789144746;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=774JTQE9fhFJYG5Yl825DuZO/ePui9QPF2Hyr3EDJC0=;
	b=SjejDJ85aRqlwG7f3dR6NKY5fPe+ZTG9dYKk2RuA4H5iY3FVlYpNSKNrJICOeD6mJYC3oW
	8XGyXZDnnN9oLHR65CF39mL77DahAH5xar7W+oTOnP9VxcBlNVpjEZTr5vl9dEP1Bd6t9N
	OhvVXobr8BtwwMawMZWEXq2ohmwUt/4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-29-heiQtx9APsquJXVwH4zRNQ-1; Fri,
 11 Sep 2026 12:39:00 -0400
X-MC-Unique: heiQtx9APsquJXVwH4zRNQ-1
X-Mimecast-MFC-AGG-ID: heiQtx9APsquJXVwH4zRNQ_1789144739
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6C20919560BC;
	Fri, 11 Sep 2026 16:38:59 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com [10.2.32.117])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9C612195608F;
	Fri, 11 Sep 2026 16:38:58 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 11 Sep 2026 20:34:59 +0400
Subject: [PATCH v5 25/62] sev: convert OnOffAuto legacy-vm-type property to
 QAPI-aware registration
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260911-qom-qapi-v5-25-7732a55b7760@redhat.com>
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
 Zhao Liu <zhao1.liu@intel.com>, Marcelo Tosatti <mtosatti@redhat.com>, 
 kvm@vger.kernel.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=2878;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=pBhxWaKYyHBx9ZkVP2bH1ohKdCKTnUGjTGeRf5Z8Jaw=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqpC24mHOWV8nmdnaMmebPMtRlNq2lIP+U4Q9Nr
 WW+iORi+TeJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaqQtuAAKCRDa6OEJdZac
 5RugD/99ysEL4XCJKNgrFsFucRle6qBYg/BkI2PXbeTgDUE9ZuoAwumSJVG4rFKZJEHI1cTBebU
 KwMwAmCMThqWXvNwfghqHlW12u7Rc9hKkmtYb9qhmFZyA5t7k15Hnoc7dg/SSnEWqMwIZfR/fr/
 fKILard5zTmO4+/W3CYqloBtlDlWJLMCUCo3WUSfS/H7DSRD9xhu+MjdjlYbdSfL1Vp5OaXxbUb
 GD0lPFDVw1Lek29wnlb/khZ5AdqvwYLtOVTAZg2guzWdv6iS1W8FCXmh5wRtOaaZ2xogR7FIgti
 OsBQaR+GD9R/sQ85nAAtjV6Z/EvFMZwwal+0/2yCbBwHg9scOAd6kAfdH0h+CL46IadrPoDjJF4
 MLLXawVhXEAWFTPR+fChhcaOM4D9PqHSxTVZaEww8KBa01yk/XmoCzK67R/DmnEwf9wjFIQSh4t
 RoPuFwIriHzIWH9x0Rr1kHDRiitsASeXmG3DCzPq4fCfYZvG+/2EY050sa/tZdq1MIGQhMCuTcD
 fJhRPKrSnRegbPHVmR+RdGK92osiL1j8188qavg1NbfQZo68hYAyJh+cXrcUF/RIwUKCPggmnfe
 ilEEJALJwzyM1doHD7pvP4GsII4dHB6okBh4imdDVF8QY5VQtCsqURN/eDK2XkZ/w+sB8tA8qrU
 8a6V2Ui8aBmVzYw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

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

