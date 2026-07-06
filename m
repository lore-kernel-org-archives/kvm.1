Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63EBC41613F
	for <kvm@vger.kernel.org>; Mon,  6 Jul 2026 12:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783342477; cv=none; b=ElpNYR9d912IYltOkoELvIinoXMn7f/6lQZ9HQ/PaJ+C8fZAl4gosQMldM1du1IbBeY/mhErwDolzNpUTUsNkyFHhuxGKzL14SfPXyTdE4DNPvLDj7/dRZqSszXFLUFaP1EiRFKPZpNF0Y5DCzwwCjDpNI67SvXxmybisbSNIHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783342477; c=relaxed/simple;
	bh=EjMMSMFPquxQrS+GcZzjNBPDu5vs8Wn1NWzHRFE/Sbw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MI2bPkjWucsODLTUoCp2hSG2p5AFHPxfZZNIamwFCrPAVufX3Zj2ExrWKdt35887Pf0MR5PMqB9rBHyehGyT8g3SHuUgsRHxTIfeBXQS21As9/LiVtgqDkW0Aplk33/MdfL0IzCHQGMVwICTMdvs60tuU5lNWBIyuGtwl6N/LWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ioxPt6KC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ioxPt6KC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783342475;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d+6znSRZg+Ltzq923NDQMZPCBTPsFuburG+TydhPNpk=;
	b=ioxPt6KCOCI9QjJmM1OzBnn9FeVLiEdFVnZq713j9t3+FPWX22TmfhlFg1LsRuVvme3rNu
	9Ba5Fi4cWgZ+tM0pRI2C2Sgx9R5HltZkXaL+0GTVtnQups0t5il0IKNmyX5ge3TiBXqJDm
	z04UzElZFidqq3TJDNiuGgV3GJGao44=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-620-VIYyhgoENPyy-hDNTOofWA-1; Mon,
 06 Jul 2026 08:54:32 -0400
X-MC-Unique: VIYyhgoENPyy-hDNTOofWA-1
X-Mimecast-MFC-AGG-ID: VIYyhgoENPyy-hDNTOofWA_1783342471
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 54FF818007EA;
	Mon,  6 Jul 2026 12:54:31 +0000 (UTC)
Received: from localhost (unknown [10.44.22.3])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6A7403000715;
	Mon,  6 Jul 2026 12:54:29 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 06 Jul 2026 16:53:52 +0400
Subject: [PATCH 5/5] ui/input-barrier: fix off-by-one in keycode bounds
 check
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260706-fix-v1-5-4b83a70e9f3b@redhat.com>
References: <20260706-fix-v1-0-4b83a70e9f3b@redhat.com>
In-Reply-To: <20260706-fix-v1-0-4b83a70e9f3b@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, 
 Marcelo Tosatti <mtosatti@redhat.com>, kvm@vger.kernel.org, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=908;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=EjMMSMFPquxQrS+GcZzjNBPDu5vs8Wn1NWzHRFE/Sbw=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqS6Vn6YI/duKo1sMaBQtRkjBpfCvDpcEW7n4D1
 Pl4ngwcOS+JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCakulZwAKCRDa6OEJdZac
 5S5IEACfDbZl29bgFSqQqEIOQaBDr5n6Be3OBrP9rY5d4MiuDGKUJ0nAlqgvGGEAcngEdbZVstd
 UyOhDzZMrgnsLEw+SFybYm9UoLsczIs047XLRkNd5xr5hNdCNsgEqpgNcuFq74GHh+AxfrJB0l8
 oOx7YtP6mAsm5lLK2ShWn/FwO2WGCbv8uV4kV1nXb39dVQoR85uWhkj8Jmvg+2Kje0Gh9VAVt5t
 KcKNhbJuRiGQwXdlbQoVVRX7wVW3cggvBoEkfStBtpbCX65flr2Jh2AzYFFFyTe9DxzDrAZZZq0
 vnq2D4z6dyLU3xN56/OTFJ1ABsIT11ZkFr50uggmIzGwMHtHLGbuGW5ljGda8IbcWBFll5GoQMM
 f8qKwoB99tV+Bhz0vSjPZldvKcBenGECy5Tr/AIvpVQsFNi20a5U/pjbxg+yf2f8blf5SiBgBgh
 1T0D6flXu3GwdLreYAAPcRzEenBiGNY7ZcjWswXLj69+GJ1tK2Ut6D2qYwrPK8u26YMTDqls3/V
 v+bLTIGSB5LylLXM+b+MC/ndUVXrKZAFAdqmXiapd/IEVsiLmYcIqW/KD1n10KikdX9s6h3JSwT
 ojnlAUQD7wjMWbPb4IzqyTVXZr11i4iR4YWCt7xbiR+0oXENn/1iQ/qCurJejPOSBytctyWlGza
 zeJe0RIcCkG8aqg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Use strict "<" to fix the off-by-one.

Fixes: 6105683da35b ("ui: add an embedded Barrier client")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3951
Reported-by: huntr bubble
Signed-off-by: Marc-Andre Lureau <marcandre.lureau@redhat.com>
---
 ui/input-barrier.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ui/input-barrier.c b/ui/input-barrier.c
index d07027114af..0a238d4010b 100644
--- a/ui/input-barrier.c
+++ b/ui/input-barrier.c
@@ -87,7 +87,7 @@ static kbd_layout_t *kbd_layout;
 static unsigned int input_barrier_to_linux(uint16_t keyid, uint16_t keycode)
 {
     /* keycode is optional, if it is not provided use keyid */
-    if (keycode && keycode <= qemu_input_map_xorgkbd_to_linux_len) {
+    if (keycode && keycode < qemu_input_map_xorgkbd_to_linux_len) {
         return qemu_input_map_xorgkbd_to_linux[keycode];
     }
 

-- 
2.55.0

