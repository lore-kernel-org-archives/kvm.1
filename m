Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7567450EBF3
	for <kvm@vger.kernel.org>; Mon,  7 Sep 2026 15:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788796633; cv=none; b=iZm7ZfayyyTX8PATf/HEWrr/fc6a7Eh9rS9hBW8R0JgO2U2gYZCFRg8FlW0T1yCiEsYRvEg2r+Tchra8H/6dYO8VNLWOaQb2eHX3gtVFAxCTAwjd3DY37Kms5Sv5HeF44irnuoa2GD0rivVXL56rblviWW/0QnM1XFHyOkzIpY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788796633; c=relaxed/simple;
	bh=YED199b63twZPfVPlCX7botRj/pf2l2Uaa6HoA0Enk0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=euS8ZPeu/PrmQw5gS3DwKyQIh+lvo/3I2w0nDrGfU5BUAtQQXad2f5YKg3u0FO8CTHcxOERGy0PdK9tSj1kDslS9OEj930qrJvdLoQ/oKPFljgPTSXcJKGj57VInLJl+WWiqvhjeQbO+D7zOub88509UoX8Sp15UWFOhFoNBn4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DC0qxUvQ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=LFNsBg6L; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DC0qxUvQ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="LFNsBg6L"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788796630;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LNEHRJDHdcdZeT0Nz44zT2pq9EwMvgRWKA64S1eEvDM=;
	b=DC0qxUvQBdA8ny5wqkJA77TiePQ+V8C/U1jcOnN9ow80cLcjznF9ZGkVbdOnlV9FzIm0dP
	qlfOzSZb+HqQqXp+k6sOY8CMlWA2uBa9LK7Ompz7RNcyuTSGaDyGbJ83JUPDlT06MyVUcz
	Ahi2rxUTRYlfs7B72E4dzePV5t7mSns=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-41-COnlybD3ONCoE0kty6T_qA-1; Mon, 07 Sep 2026 11:57:08 -0400
X-MC-Unique: COnlybD3ONCoE0kty6T_qA-1
X-Mimecast-MFC-AGG-ID: COnlybD3ONCoE0kty6T_qA_1788796628
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-490a767c7dcso27377825e9.2
        for <kvm@vger.kernel.org>; Mon, 07 Sep 2026 08:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788796628; x=1789401428; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LNEHRJDHdcdZeT0Nz44zT2pq9EwMvgRWKA64S1eEvDM=;
        b=LFNsBg6LEFyc6ej5sRVNUZajtroxkcUwBlSAFsuZ/Tj6hhp4i4G5561c+kPqsdRzLq
         t5+IyBspAlpemLsAvnxP+YuZPTchRTIDEXUQYm46SbIvA98PdCw/M6SKRyqnaes4baMs
         tQmc1oqC5KLjiufMKx/4dOPeFCKznDj6j6DvmoNuQkAOzb9q3q87nzyJdlSQ2fL23A/s
         Yku3iodrjpIY7Vt3AvUkaUZ53iDg/hunqrv0U1JrAmtofcspoY6jNmP1abTegKFTrt19
         Lt9Ht6uHyc+rgt/l62QjkYHWgzRDqWNt+TZ5mLbzNbnaEbJRZeryMUoBP3qlEfbvegcX
         OkEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788796628; x=1789401428;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LNEHRJDHdcdZeT0Nz44zT2pq9EwMvgRWKA64S1eEvDM=;
        b=ZErWYBzO4UTpceHoRSpBhHIwjDwl3V6+6m0aVe9eYIYz6/WwCJ7d268gV2IG/z/b+T
         uwnJJBiutuXROcSNnrIAwtuUjLQkGwgTOt7De42T71M23g+m7p6hS1isvD661W4I/MA7
         3RF2jIXfDyERRkVrNjiEHkQ/xTcmHylZDsBnPh8FJ+O43zHsQxXPDOAFcrRXnnRT22lu
         lQd0kQS1z73dB8purO0ksE6uRGHIcEzq9UyPWzo8EnNR4SgEYDGVTLvtuWQW7K5C2UqE
         tWW+2wQjuB/VPK9vdZOMJuSw2i+wJV5wiIephOka9N16PLSGKbZkxLrZAl6GipPt7BFT
         KdIA==
X-Forwarded-Encrypted: i=1; AKwUvBxZ9kOzTu9JkvVBWidTZM44drWs2fY87+lCi8AWUK97AWK74zIpGnX9unCFYxrtppkFpX4=@vger.kernel.org
X-Gm-Message-State: AFuF++nLXBfWUBC0NKJBvNkql3d0VRT/BmRdYgtrxCGiNPXZ9OGZ/0bw
	fKrmR90G1HkXX4Vig2lgwOKswq9SGGkG/5NNuxsnwWXESs4CeBM5DqMvEfmp/q8bCib27QhKsLK
	98PEYwQtEeY4Zzt/y5uZLWHt9c0MBL5zZ9VGC8QzHgs+iFdX0hNWtnA==
X-Gm-Gg: AYBFou14JWqLcCvXWBAOuSIsNeoBNrXv8ClHuziSR1sRDFYsRLdlci/5yjBtZN1Soma
	0hhvM177NSsvXEmD9ia9TvKLkZlakz2gj6VyTrlRaqPfVltOGWsVVdkRaOO7LD50g6s9BsSgvHq
	vk58v6S1tclhF0eoRUSoaSlMhPKA9mNBMJ1bWx7a/Us4faxlg9Ob57CEw7XVQwexFPU+LYfCtLD
	MRlVspesl/ov9Br16XexNsxadVqn0dUilyudRUs5xwfMJHv1xIvSPSBSDq2MS1r03nHAhqHjj0f
	aX5aprZpFpY+IeBu16nM4T+9olySRy3sxLSAUh5kejJsmS9OQ9p841Ijr4e0oJBuJdG1BP+sjpS
	DfXrFVvFSObArUhFApElo1cCo1GBvaHizzk0mOiGSpw8l0bytgDZDT4vvuYfqbK2NwrKB
X-Received: by 2002:a05:600d:4449:20b0:49d:3a:e576 with SMTP id 5b1f17b1804b1-49d003ae639mr122997525e9.5.1788796627802;
        Mon, 07 Sep 2026 08:57:07 -0700 (PDT)
X-Received: by 2002:a05:600d:4449:20b0:49d:3a:e576 with SMTP id 5b1f17b1804b1-49d003ae639mr122997145e9.5.1788796627429;
        Mon, 07 Sep 2026 08:57:07 -0700 (PDT)
Received: from lleonard-thinkpadx1carbongen13.rmtit.csb ([151.29.41.106])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cf755c22esm320477955e9.0.2026.09.07.08.57.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 08:57:06 -0700 (PDT)
From: Luigi Leonardi <leonardi@redhat.com>
Date: Mon, 07 Sep 2026 17:56:59 +0200
Subject: [PATCH v2 3/5] i386/sev: convert the guest policy properties to
 custom accessors
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260907-fix_igvm_policy-v2-3-c8c50f1dbfda@redhat.com>
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

Both SEV/SEV-ES and SEV-SNP expose a "policy" object property. The
SEV/SEV-ES one was registered as a plain uint32 pointer property, and
the SEV-SNP setter ignored the result of the visit.

Give both properties explicit getter/setter functions and check the
return value of the visit in the setters. This is preparation for
tracking whether the guest policy was set on the command line.

No functional change intended.

Reviewed-by: Ani Sinha <anisinha@redhat.com>
Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
---
 target/i386/sev.c | 30 +++++++++++++++++++++++++-----
 1 file changed, 25 insertions(+), 5 deletions(-)

diff --git a/target/i386/sev.c b/target/i386/sev.c
index b53d13e2fa..38f97fd9b2 100644
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
2.55.0

