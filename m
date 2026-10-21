Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792600368;
	b=U24Y3V6Qwo6p+hoMIA4Web65BYvB5cVUmH04+91wXVIIkdkSrSCm4ECXO2FxZwoYB7J4
	 BODpiH5BAa5WFK2fdFD7I+X/Gwz1efrkRv/FcmwnqM1/0iPHL7d6vx4SWVXXXjoLOMYz+
	 ewR8pspILf/flqkw6NzZaHJ+YeymSre1KijhYzVVRLjfD5pXQIrRgsU/LGhyEjcH5jtOD
	 Tu09d8myOqxuE/fwgBCnFUuh9WKPdjgDP+WaJTNrT76JXXyKAPHzjN0AhLEOLrTVfZS7m
	 mu/q8r1HsYHzUxe8hfSUVu/NsD4KdYv9EhWhO4q7umhHN59K7S9R3ZwCvD4n7+DvYkA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792600368;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Scanned-By;
	bh=gLTZUdvM7A2N0fyJWg2lNT3PdveXqvyLDgdRIcYomkY=;
	b=kC5dUGaiGb98uQhoxXs9cSlJv9xf0r+zLlA+Yut2iI9zjh1dVnbY7N3+XFkieMhFArft
	 Ym65rtFK2tTM+OkrePIFIEjEVqM/wUlRzkc0tcQ3pAaaHyj59N0gzHhmjUAS9nYvyFyf0
	 NDcVnrLYmSs67JzjQ6z+DShkjBDBETVdUD2jpHbY1gfte5AZG+83cT2SYwOrnF7uszBGK
	 Sf/vjYajBdqaf7jY33zAlyiY3d31pROcUDLFizq0sNt9OMadQtLSbOqCWP08m3Fg6Rr3H
	 f27MAxC0pB/PgoG+OgxFmOK6k+VJbqIAs+mKgNfEBzJsGBiSpATzWmzjV5peI5ei/9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=KA2Y6bOC;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BBD8606A328
	for <kvm@vger.kernel.org>; Wed, 21 Oct 2026 16:32:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5BBD8606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=KA2Y6bOC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792600367;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gLTZUdvM7A2N0fyJWg2lNT3PdveXqvyLDgdRIcYomkY=;
	b=KA2Y6bOCAWIsM1hYVdswE5+sEkU8zJZ3zhMqBaQy0kun+drbXAIRjN9W5oBNLBs/AClt8C
	IFhKNgIB0UgptqBBJb/2jpw3xxfab4Ex+Gm9j6cNKBx9R9wk1FcTtBeigo+p/M6rsHooU9
	Ah+kAMD3VK7HzHK8Vbvf56sgWckiXtk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-361-eafSKQN9MK6VQ6x3s3WKaQ-1; Wed,
 21 Oct 2026 16:32:46 +0000
X-MC-Unique: eafSKQN9MK6VQ6x3s3WKaQ-1
X-Mimecast-MFC-AGG-ID: eafSKQN9MK6VQ6x3s3WKaQ_1792600364
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C07FD19560B9;
	Wed, 21 Oct 2026 16:32:44 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.44.48.54])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 78A1118005B7;
	Wed, 21 Oct 2026 16:32:44 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
	id 0885A1827595; Wed, 21 Oct 2026 18:32:40 +0200 (CEST)
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
	Martin Pitt <martin@amutable.com>,
	qemu-stable@nongnu.org
Subject: [PULL 07/10] hw/uefi: fix ContentInfo detection in wrap_pkcs7()
Date: Wed, 21 Oct 2026 18:32:35 +0200
Message-ID: <20261021163239.1131460-8-kraxel@redhat.com>
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

From: Martin Pitt <martin@amutable.com>

Fix wrap_pkcs7()'s detection for an already present PKCS ContentInfo
envelope: It previously compared byte 15 with 0x0a (ASN.1
ENUMERATED) instead of 0xa0 (the [0] EXPLICIT context tag of
ContentInfo.content). See the original edk2 function [1] where this was
taken from.

Due to that typo, an already wrapped signature got wrapped a second
time, and gnutls_pkcs7_import() rejected it. This breaks Secure Boot key
enrollment with .auth files carrying the envelope, as created by
systemd's "bootctl --secure-boot-auto-enroll".

[1] https://github.com/tianocore/edk2/blob/8f8372439d8ec5f565dbda1548c18deb068e0080/CryptoPkg/Library/BaseCryptLib/Pk/CryptPkcs7VerifyCommon.c#L68

Fixes: 3e33af2cb306 ("hw/uefi: add var-service-pkcs7.c")
Cc: qemu-stable@nongnu.org
Signed-off-by: Martin Pitt <martin@amutable.com>
Message-ID: <atUllV8bSaHylfKv@piware.de>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/uefi/var-service-pkcs7.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/uefi/var-service-pkcs7.c b/hw/uefi/var-service-pkcs7.c
index 8a1f1395a2fb..a47f36492ff8 100644
--- a/hw/uefi/var-service-pkcs7.c
+++ b/hw/uefi/var-service-pkcs7.c
@@ -80,7 +80,7 @@ static void wrap_pkcs7(gnutls_datum_t *pkcs7)
         pkcs7->data[4] == 0x06 &&
         pkcs7->data[5] == 0x09 &&
         memcmp(pkcs7->data + 6, signed_data_oid, sizeof(signed_data_oid)) == 0 &&
-        pkcs7->data[15] == 0x0a &&
+        pkcs7->data[15] == 0xa0 &&
         pkcs7->data[16] == 0x82) {
         return;
     }
-- 
2.56.0

