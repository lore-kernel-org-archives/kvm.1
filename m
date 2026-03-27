Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFEF43128D9
	for <kvm@vger.kernel.org>; Fri, 27 Mar 2026 13:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774619105; cv=none; b=axKfur2PPcmH/bkocxrzxrnXoryUb6x/48icxbOiCfsGpgGBqJCh0QDPtSQpEFGyH4a+QsnduOdjS9UKUKt3UWRqD2aNx3tUQk0fPE7IKD9Z9XO4suNJ4QjiSFdcibeeRDvsWiefQi+BnasJ1vAOupDTSolDA6zujmxI9rvgCDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774619105; c=relaxed/simple;
	bh=rmH50mlXFctItJxUYf6IhN5duqqGL9Gyb2aMvIETHzI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LgW1vJy9w0SKQUJjsHH97lEKIuJNDFAkXp8qzqRV+8JG2CnkSIwqqNWyDAezSNPaCyr5fCPXByMkEyHTSKDbWbUZGESBDK48gdzFP177KOg9EiftLIynSW2WQhfwnat5KlGABCu6YFzv1ijlBlGRKw666sZCRABi+L0mtx0PPIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PVHGXsDf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PVHGXsDf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774619102;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S64lHc8nDcDVXki4gsEE1CO0XdJngbvvtfp4BSK2uts=;
	b=PVHGXsDfoJNtPwf/Vrz8khrH+3hVKbgDwYiCTFCDbyBcO7og+JYrlCvUGS7psgJ1ujC5h0
	DdbCDE782d7qygXvRZMdPMCGvqR3yjJ+prGPAMQGtTmoXrNw0P0DxMf19K84hqu9HapRye
	uZ4kZfv7SpyFz+b31O2h6dYCWiutMdk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-503-pR8oze6NPIeb-CDJB9r1aQ-1; Fri,
 27 Mar 2026 09:45:00 -0400
X-MC-Unique: pR8oze6NPIeb-CDJB9r1aQ-1
X-Mimecast-MFC-AGG-ID: pR8oze6NPIeb-CDJB9r1aQ_1774619097
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 541481800281;
	Fri, 27 Mar 2026 13:44:57 +0000 (UTC)
Received: from srv1.redhat.com (unknown [10.44.32.150])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C548E1800671;
	Fri, 27 Mar 2026 13:44:50 +0000 (UTC)
From: Kostiantyn Kostiuk <kkostiuk@redhat.com>
To: qemu-block@nongnu.org,
	qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	qemu-ppc@nongnu.org,
	kvm@vger.kernel.org,
	qemu-riscv@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>,
	Hanna Reitz <hreitz@redhat.com>,
	"Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
	Alistair Francis <alistair@alistair23.me>,
	Peter Maydell <peter.maydell@linaro.org>,
	Nicholas Piggin <npiggin@gmail.com>,
	Harsh Prateek Bora <harshpb@linux.ibm.com>,
	=?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	=?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
	Chinmay Rath <rathc@linux.ibm.com>,
	Glenn Miles <milesg@linux.ibm.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Weiwei Li <liwei1518@gmail.com>,
	Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
	Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
	Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
	Artyom Tarasenko <atar4qemu@gmail.com>,
	Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH v2 06/15] target/sparc: Use glib2 instead of strcasecmp/strncasecmp
Date: Fri, 27 Mar 2026 15:43:52 +0200
Message-ID: <20260327134401.270186-7-kkostiuk@redhat.com>
In-Reply-To: <20260327134401.270186-1-kkostiuk@redhat.com>
References: <20260327134401.270186-1-kkostiuk@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

This is a change in semantics. g_ascii_strcasecmp() doesn't honour
locale but strcasecmp() does. But this is OK for at least one reason:
 (1) QEMU always runs with the C locale so there's not an actual
     behaviour change here
 (2) we want the comparison on boolean property value to be a plain
     ASCII one, not to do weird things with "I" in Turkish locales,
     so g_ascii_strcasecmp() is better as it's explicit about that

Signed-off-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>
---
 target/sparc/cpu.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index 1493336e7a..7704610428 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -174,10 +174,10 @@ static void sparc_cpu_parse_features(const char *typename, char *features,
              * TODO: remove minus-override-plus semantics after
              *       warning for a few releases
              */
-            if (!strcasecmp(val, "on") ||
-                !strcasecmp(val, "off") ||
-                !strcasecmp(val, "true") ||
-                !strcasecmp(val, "false")) {
+            if (!g_ascii_strcasecmp(val, "on") ||
+                !g_ascii_strcasecmp(val, "off") ||
+                !g_ascii_strcasecmp(val, "true") ||
+                !g_ascii_strcasecmp(val, "false")) {
                 error_setg(errp, "Boolean properties in format %s=%s"
                                  " are not supported", name, val);
                 return;
-- 
2.52.0

