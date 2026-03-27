Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8795930E82E
	for <kvm@vger.kernel.org>; Fri, 27 Mar 2026 13:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774619098; cv=none; b=czE4fytRAPDhBmWFaXA3pYwyWeVpEnQsfQ3eb9OMtJUolBER7QRPLBNphiOvYM0Zxd2qL/EOap38r++G2gc1IsFTwt1PWF6uBMvJo4IpE3bdS8Vv/fQOqfvFww8/uqkcch9uilgue00+pK6WQCviUcfWc6mtt7RJR7IJMxwmj6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774619098; c=relaxed/simple;
	bh=Bx+ScUx0aoshgRXPF/JZodx90P2ETIjlhke8xh9nW1M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LQ3ENG4r0rDxXkGqWvq1jT4hmq7h5qQzsN70M7ItSTS5rNzMc+oeBY4T6IW8Tc+mUiR533YK8a58H2PDR4uHqg6IZfWTt+3DOsWzgeJWJavGp3c7I9nKZNQx1PfcppiMsAC0Zbqo5JjL0n2mNCIq/LNKdCcVyhMsNEt7/0E/Y1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L670YR6H; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L670YR6H"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774619096;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AR+sep0luI+DD5MyOrfuehNm1J5XGS2aRpMrMqNwkbQ=;
	b=L670YR6HxyjjEyYTKp75Y/7/5KlEHYzTgc7B72EOFqb73+7WMLHWrzoPyNZf/GFxS53cYa
	VavybwqPRLt4rWjLXi7VN/57Tk5DYFxoGm06ifC5SpYqk5bWJ9fwSbwR6JK2QD5P1ssALr
	DsgVFXtzuI+g8qA+bT+vzgfCyqamabc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-663-xJUuhVajPDWUly-Un_mzhQ-1; Fri,
 27 Mar 2026 09:44:53 -0400
X-MC-Unique: xJUuhVajPDWUly-Un_mzhQ-1
X-Mimecast-MFC-AGG-ID: xJUuhVajPDWUly-Un_mzhQ_1774619090
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5A99C1800359;
	Fri, 27 Mar 2026 13:44:50 +0000 (UTC)
Received: from srv1.redhat.com (unknown [10.44.32.150])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 61CEB1800671;
	Fri, 27 Mar 2026 13:44:43 +0000 (UTC)
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
Subject: [PATCH v2 05/15] hw/arm: Use glib2 instead of strcasecmp/strncasecmp
Date: Fri, 27 Mar 2026 15:43:51 +0200
Message-ID: <20260327134401.270186-6-kkostiuk@redhat.com>
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
 (2) we want the comparison on boot names to be a plain ASCII
     one, not to do weird things with "I" in Turkish locales,
     so g_ascii_strcasecmp() is better as it's explicit about that

Signed-off-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>
---
 hw/arm/xilinx_zynq.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/arm/xilinx_zynq.c b/hw/arm/xilinx_zynq.c
index d43f36b718..e3cfeb4c08 100644
--- a/hw/arm/xilinx_zynq.c
+++ b/hw/arm/xilinx_zynq.c
@@ -186,13 +186,13 @@ static void zynq_set_boot_mode(Object *obj, const char *str,
     ZynqMachineState *m = ZYNQ_MACHINE(obj);
     uint8_t mode = 0;
 
-    if (!strncasecmp(str, "qspi", 4)) {
+    if (!g_ascii_strncasecmp(str, "qspi", 4)) {
         mode = 1;
-    } else if (!strncasecmp(str, "sd", 2)) {
+    } else if (!g_ascii_strncasecmp(str, "sd", 2)) {
         mode = 5;
-    } else if (!strncasecmp(str, "nor", 3)) {
+    } else if (!g_ascii_strncasecmp(str, "nor", 3)) {
         mode = 2;
-    } else if (!strncasecmp(str, "jtag", 4)) {
+    } else if (!g_ascii_strncasecmp(str, "jtag", 4)) {
         mode = 0;
     } else {
         error_setg(errp, "%s boot mode not supported", str);
-- 
2.52.0

