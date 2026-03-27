Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25A783F9FB
	for <kvm@vger.kernel.org>; Fri, 27 Mar 2026 13:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774619135; cv=none; b=hgMcdY6NdzeRtt6ez54rMqfwdQb/i63jqEAvJrNPsrtfWpdDg+mzqqLDofbQe+JD25MXknQIN+QGXRXzxR/JqPReKxSbKy1tjmo4w/Iln0ix9OPhuN1BDC5CNQc7Ebvv9SPARAOvvsN/EgWloIhbozSC/3TRVOxX9UAqoVhBnC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774619135; c=relaxed/simple;
	bh=4ZP0aK6Af5K0iHPCE6OX/U5NsCexHaSzThCSpWRuPPY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eb50t1kKhpwK1o7XemMLjFyvCBgo8tKrqX3CfF+3rYdn95lQ/aZ1s6YvDh4jfntg7nX1BQFWYQF8+oEVY5ly2oumkcGV8gMSyulX4iKXnR91clxYX/nxvgoQzXjuKjYE3if3X4Io93Vww1M9DZpLW/2U4gE4sLV1IJWaBavadFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I2afZ3Or; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I2afZ3Or"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774619133;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H/XDk77uMM0K3ipW2XJci7E6+UCDLhxSXeqP3bT3a4k=;
	b=I2afZ3OrYJZ/6Gn8mCU1Ujxy5w4bZFYocma8BxczXMqfr6KQxTc5RW96WDFBM3biNGs3d6
	wNdaDZdWW05k1VFS969AKLYpRr0gnENIcwycAwOCWPIndhHK8iAiPv0v7S9QZRwM0OKFwV
	1qP7E5PlrKh9UPjjkUmKWD0EX+EEZ9Q=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-68-DOJP0ZnzNQusPNRZ2L7tGQ-1; Fri,
 27 Mar 2026 09:45:29 -0400
X-MC-Unique: DOJP0ZnzNQusPNRZ2L7tGQ-1
X-Mimecast-MFC-AGG-ID: DOJP0ZnzNQusPNRZ2L7tGQ_1774619127
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1D6E21956094;
	Fri, 27 Mar 2026 13:45:27 +0000 (UTC)
Received: from srv1.redhat.com (unknown [10.44.32.150])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0681D1800673;
	Fri, 27 Mar 2026 13:45:19 +0000 (UTC)
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
Subject: [PATCH v2 10/15] hw/ppc: Use glib2 instead of strcasecmp/strncasecmp
Date: Fri, 27 Mar 2026 15:43:56 +0200
Message-ID: <20260327134401.270186-11-kkostiuk@redhat.com>
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

Signed-off-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>
---
 hw/ppc/spapr_caps.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
index 170795ad6a..f4a26a85b5 100644
--- a/hw/ppc/spapr_caps.c
+++ b/hw/ppc/spapr_caps.c
@@ -129,7 +129,7 @@ static void spapr_cap_set_string(Object *obj, Visitor *v, const char *name,
         return;
     }
     for (i = 0; i < cap->possible->num; i++) {
-        if (!strcasecmp(val, cap->possible->vals[i])) {
+        if (!g_ascii_strcasecmp(val, cap->possible->vals[i])) {
             spapr->cmd_line_caps[cap->index] = true;
             spapr->eff.caps[cap->index] = i;
             return;
-- 
2.52.0

