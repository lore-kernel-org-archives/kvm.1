Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 260633ECBCF
	for <kvm@vger.kernel.org>; Fri, 27 Mar 2026 13:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774619122; cv=none; b=hziHSYORmLIHL+Yt14ixTdKV5jmWY+Qt+Hs+24RYqdPgxoewYDrmXStXa5qaOHoeMM5SV0mZXIddtjJtK7lqSYP9pCuxe8cC0fXWvAU6RXllV6Fk5dxl+r7cJjpkQdakWZRh/AOGp0R8IlolIABRvBLxFYLYLQDjne18hsq6yF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774619122; c=relaxed/simple;
	bh=a66WhUO1/S5EkcUMmP3d90ka2WpJ8yL23m93i7oI+vU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D+UZt6RVZN8RC/jCG9p0rgS+oiW3ReR4iOyJIsIYkP99sXoiHWqt0o1Z82xjZBsfBgs+ATdT3e0KeKJW57ilKPG1GK0xH3FCMqwISgo0S5xsJXFKe48brUngcxmjQ1iNANxQHLZIZfgBGAqRO45Ex+C/6s5se2AwQ1nrKIbrlSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BpQOXzbp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BpQOXzbp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774619120;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+AC/Rs5aGm9ogD74hTmTObfS5j9a2nU8YQlkEq3pZSM=;
	b=BpQOXzbp/uMjBNWg15Z/XWphjNGfpnCZjHqzHhmYZvNU02ow/sesolUUEpCHvMDdgOLknO
	5uVjXBmbyQ8ztyBlH4GxCtCd/G5t6NjaaCYuWV12WA+mW5lDiEBOqN2id/7gkjfH4V2hDe
	qV6FbUsj1fiC3UvEvks6kziUvijr2PY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-332-UrDfc_izNpWZCPWGhX6nXA-1; Fri,
 27 Mar 2026 09:45:16 -0400
X-MC-Unique: UrDfc_izNpWZCPWGhX6nXA-1
X-Mimecast-MFC-AGG-ID: UrDfc_izNpWZCPWGhX6nXA_1774619112
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A8F9218002DD;
	Fri, 27 Mar 2026 13:45:12 +0000 (UTC)
Received: from srv1.redhat.com (unknown [10.44.32.150])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A04871800671;
	Fri, 27 Mar 2026 13:45:04 +0000 (UTC)
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
Subject: [PATCH v2 08/15] target/ppc: Use glib2 instead of strcasecmp/strncasecmp
Date: Fri, 27 Mar 2026 15:43:54 +0200
Message-ID: <20260327134401.270186-9-kkostiuk@redhat.com>
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
 target/ppc/kvm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 41bd03ec2a..25c28ad089 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -2653,7 +2653,7 @@ static int kvm_ppc_register_host_cpu_type(void)
      */
     dc = DEVICE_CLASS(ppc_cpu_get_family_class(pvr_pcc));
     for (i = 0; ppc_cpu_aliases[i].alias != NULL; i++) {
-        if (strcasecmp(ppc_cpu_aliases[i].alias, dc->desc) == 0) {
+        if (g_ascii_strcasecmp(ppc_cpu_aliases[i].alias, dc->desc) == 0) {
             char *suffix;
 
             ppc_cpu_aliases[i].model = g_strdup(object_class_get_name(oc));
-- 
2.52.0

