Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792600375;
	b=SoUyCmbgr7sr5WYGMS9iYkSmRl46S0PTKDQ3I4EYkx5K+lJRQlOgzhbNZv7GU+mHr+UF
	 O1oCYjoWFhsjKQhbIuEKgHUqg+r9gdCzoSA1KUQrW0mHRdPmJ+NbgajHQyO+cxIA0pItL
	 VdkuDtMJf/R6TKtJT8L6YqdYQksuPCipsYzuGRLV0vXim2hdEKmBi6ZT0TfoKQIET4vmn
	 cEgnZ3TTd6LC3F012y3wLlFEq5pIo15NuQL89rFiPkU/iisv2v63c9K4aHQkYN+JxfmfE
	 5dijGunE7GZGt8kdv9TwpciD0POCTB0UQJJDzVXPaTj+HrWz4jdMFfJKSwJ1bJUXyiQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792600375;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Scanned-By;
	bh=3yOq+0SmiKD4ABIG/MWGp5EqJWbc1XKSVkbY1vpqHNA=;
	b=LLGqiuGJk8qFD0uvE79TBtyjg2fETU2D1w8EjW80he6vJB5jhWjAjO3qka+jcamZJwc+
	 cZCkAw7+gnHM94GnM7ESfcvgOMYS4da9qD1SZoGzgHqI83XFyUr94zE7P5pYRHQ0PmgbU
	 93DpFGSuwA4je1aHKhJmno9rOZ2+dOLM9/CUcvnIJb74MMeNM3Gj4SID9ajLDVvFa89wg
	 MEilc1xfRgY6PzMvKN84QMrcnHjNwtMUgciXrV/jmYsUn7pW+wTW1ZUc3QExKGK9/sY3Y
	 xSvMq52OhM8ZL2Ayd/eTg3COvZ4yOnl0YoyPjYwX6KqwytkBMqSVhkZ2VASeyiRDrpw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=UpdE8BJj;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA3BA60A2608
	for <kvm@vger.kernel.org>; Wed, 21 Oct 2026 16:32:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EA3BA60A2608
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=UpdE8BJj
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792600374;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3yOq+0SmiKD4ABIG/MWGp5EqJWbc1XKSVkbY1vpqHNA=;
	b=UpdE8BJj8WsqvCgKxYA9UKPGhh5MxbKEgV3hSB7kO0w6o2pbGmqhxs0krVu7cwPi1xKaQD
	7kat56A+HEFObLxeO3xVLQy0re/mVfe3AcgwxU9KlU0puiCR3HDaAETbwW7n6akk1zKawo
	SjvYswBydz2Si0BlmsYUz/74E5Lmo0U=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-342-5FibhARGN1KXE4ZvAFowEw-1; Wed,
 21 Oct 2026 12:32:44 -0400
X-MC-Unique: 5FibhARGN1KXE4ZvAFowEw-1
X-Mimecast-MFC-AGG-ID: 5FibhARGN1KXE4ZvAFowEw_1792600363
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 474A71800662;
	Wed, 21 Oct 2026 16:32:43 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.44.48.54])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 70F381803A40;
	Wed, 21 Oct 2026 16:32:42 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
	id A16D01827591; Wed, 21 Oct 2026 18:32:39 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org,
	Stefano Garzarella <sgarzare@redhat.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Markus Armbruster <armbru@redhat.com>,
	=?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
	Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
	Zhao Liu <zhao1.liu@intel.com>,
	Ani Sinha <anisinha@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Eric Blake <eblake@redhat.com>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Luigi Leonardi <leonardi@redhat.com>
Subject: [PULL 03/10] i386/sev: convert the guest policy properties to custom accessors
Date: Wed, 21 Oct 2026 18:32:31 +0200
Message-ID: <20261021163239.1131460-4-kraxel@redhat.com>
In-Reply-To: <20261021163239.1131460-1-kraxel@redhat.com>
References: <20261021163239.1131460-1-kraxel@redhat.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

From: Luigi Leonardi <leonardi@redhat.com>

Both SEV/SEV-ES and SEV-SNP expose a "policy" object property. The
SEV/SEV-ES one was registered as a plain uint32 pointer property, and
the SEV-SNP setter ignored the result of the visit.

Give both properties explicit getter/setter functions and check the
return value of the visit in the setters. This is preparation for
tracking whether the guest policy was set on the command line.

No functional change intended.

Reviewed-by: Ani Sinha <anisinha@redhat.com>
Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
Message-ID: <20260907-fix_igvm_policy-v2-3-c8c50f1dbfda@redhat.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 target/i386/sev.c | 30 +++++++++++++++++++++++++-----
 1 file changed, 25 insertions(+), 5 deletions(-)

diff --git a/target/i386/sev.c b/target/i386/sev.c
index b53d13e2fa28..38f97fd9b2b3 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -2996,6 +2996,22 @@ sev_guest_class_init(ObjectClass *oc, const void *data)
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
@@ -3004,8 +3020,8 @@ sev_guest_instance_init(Object *obj)
     sev_guest->policy = DEFAULT_GUEST_POLICY;
     object_property_add_uint32_ptr(obj, "handle", &sev_guest->handle,
                                    OBJ_PROP_FLAG_READWRITE);
-    object_property_add_uint32_ptr(obj, "policy", &sev_guest->policy,
-                                   OBJ_PROP_FLAG_READWRITE);
+    object_property_add(obj, "policy", "uint32", sev_guest_get_policy,
+                        sev_guest_set_policy, NULL, NULL);
     object_apply_compat_props(obj);
 
     sev_guest->legacy_vm_type = ON_OFF_AUTO_AUTO;
@@ -3044,9 +3060,13 @@ static void
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
2.56.0

