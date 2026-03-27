Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA47730E82E
	for <kvm@vger.kernel.org>; Fri, 27 Mar 2026 13:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774619093; cv=none; b=apkIIRzcoTDntHa/duzR7iY95Q3tCwexoJqUHcBIffYqfbjGuuU1JBX85KoqvMRrd6/o9f0JAqS8JKnDXZv0AOQy/5E8cTw8bDFcXyNclVDfLRh7Yy4k+LmY3Ydr1BTeTIQK9TO3HmfWV/x0rLEnfop6vK9FiTUiteYUhcN88ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774619093; c=relaxed/simple;
	bh=t9TnKRbgthQzrJZeXY47F2KPnucMBNnc7uR4WJTsTr4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RbpvVr0LqO+2hKdNLSMtstv8oXfmdW9AWTwyMRKD2Ut3/Hl0Sqwor7fccMwdatNlhMlsAHFVfKLecmF6nL3j4qfT7xDVCwuWIYte6Wer0bcnzq10QehmbXfxpwoLbXAkzcfG2I84CcvFCQ/BS14ZLud4uJxuhdBmfoIOEaPHhCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EYJQ7F4N; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EYJQ7F4N"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774619091;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Oau2fifASnQbpebMTARmA8OnZaBg3IV2l8eaVyRBc2o=;
	b=EYJQ7F4NqHFR929852W0SvBTtyJOt65qmzlWBzKTH6AWmuC6Xrs2ujVRQ3v/tb5+sG5Miv
	AQn7wtuS1fEqL68t+fGEqdnmtbM1WoicSb7vMIQIwIqf4LsWf/ydmov1Qx803roq3/Asjs
	GIBHUUcljHOLsHU7Qs90EFc1Puowmz8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-627-GOveJysMPtaJS8S-ON0VNQ-1; Fri,
 27 Mar 2026 09:44:46 -0400
X-MC-Unique: GOveJysMPtaJS8S-ON0VNQ-1
X-Mimecast-MFC-AGG-ID: GOveJysMPtaJS8S-ON0VNQ_1774619083
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EA37818005B0;
	Fri, 27 Mar 2026 13:44:42 +0000 (UTC)
Received: from srv1.redhat.com (unknown [10.44.32.150])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 33D291800671;
	Fri, 27 Mar 2026 13:44:35 +0000 (UTC)
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
Subject: [PATCH v2 04/15] io: Use glib2 instead of strcasecmp/strncasecmp
Date: Fri, 27 Mar 2026 15:43:50 +0200
Message-ID: <20260327134401.270186-5-kkostiuk@redhat.com>
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
 (2) we want the comparison data in HTTP header and it should be a plain
     ASCII one, not to do weird things with "I" in Turkish locales,
     so g_ascii_strcasecmp() is better as it's explicit about that

Signed-off-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>
---
 io/channel-websock.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/io/channel-websock.c b/io/channel-websock.c
index 9902b014f7..85b22a8822 100644
--- a/io/channel-websock.c
+++ b/io/channel-websock.c
@@ -457,7 +457,7 @@ static void qio_channel_websock_handshake_process(QIOChannelWebsock *ioc,
     connectionv = g_strsplit(connection, ",", 0);
     for (i = 0; connectionv != NULL && connectionv[i] != NULL; i++) {
         g_strstrip(connectionv[i]);
-        if (strcasecmp(connectionv[i],
+        if (g_ascii_strcasecmp(connectionv[i],
                        QIO_CHANNEL_WEBSOCK_CONNECTION_UPGRADE) == 0) {
             upgraded = true;
         }
@@ -468,7 +468,7 @@ static void qio_channel_websock_handshake_process(QIOChannelWebsock *ioc,
         goto bad_request;
     }
 
-    if (strcasecmp(upgrade, QIO_CHANNEL_WEBSOCK_UPGRADE_WEBSOCKET) != 0) {
+    if (g_ascii_strcasecmp(upgrade, QIO_CHANNEL_WEBSOCK_UPGRADE_WEBSOCKET) != 0) {
         error_setg(errp, "Incorrect upgrade method '%s'", upgrade);
         goto bad_request;
     }
-- 
2.52.0

