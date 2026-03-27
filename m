Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27D72D12EC
	for <kvm@vger.kernel.org>; Fri, 27 Mar 2026 13:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774619114; cv=none; b=C3Y62m1oE/VkDlbQlynR2na9nIEAAygl+Q/z6n4I/MsX1D+wsCNnMezhkJsc/i9mQzHjR9JnHqgj8nMcDn3PryKo9gpqC07jFO5d2pU4MmFBBBOscaxGuJo9Xp0eMnlxXvxy9L+I5r+lXCu+cGqE8SAwl3Nb0C/NizS1t0DyrMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774619114; c=relaxed/simple;
	bh=dKX/PaUYAnyDqD/NVv6hB/XA3QVbHwypTCxPwLybnc0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JJ+2CLRdsmVd+u7O2233vQ8+87Q3siI9yJzZOgKlcWA5oedM8KaD4JgY0SzLKZqJXNrxwrF2J3lVCxh1EwF+ctihTLjbXoCSxJy5aStXUn4r0TioXE6y2QtzB9EKNYUwV5xAw0elQNEF60HbJWCnJF6OIMpuxHrBOjvMo+3uDiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QDUQOkZy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QDUQOkZy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774619111;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ca4K08Noqjd4qeO37YQnqMAg5xrqZUVUykdWTjWe6W4=;
	b=QDUQOkZynlfSYJThRsgbjiozqAnZugDzn+TPTXB9PT6eXyuIdg2BR8Oe80xqyZpe223FIa
	U4ddD2nOh1IsqgAdVAzvvGv4zYI4uZjSk1PPG06n994xnKdZuRZx6yDfbxu7+AG//8NDp5
	Q6ofVlAV32b3O8fcJXI+fUfE0tQCDLc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-649-VWg1GV-OOK6OoqH5vzTEiQ-1; Fri,
 27 Mar 2026 09:45:07 -0400
X-MC-Unique: VWg1GV-OOK6OoqH5vzTEiQ-1
X-Mimecast-MFC-AGG-ID: VWg1GV-OOK6OoqH5vzTEiQ_1774619104
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B872F180034E;
	Fri, 27 Mar 2026 13:45:04 +0000 (UTC)
Received: from srv1.redhat.com (unknown [10.44.32.150])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BF26C1800673;
	Fri, 27 Mar 2026 13:44:57 +0000 (UTC)
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
Subject: [PATCH v2 07/15] target/riscv: Use glib2 instead of strcasecmp/strncasecmp
Date: Fri, 27 Mar 2026 15:43:53 +0200
Message-ID: <20260327134401.270186-8-kkostiuk@redhat.com>
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
 target/riscv/monitor.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/riscv/monitor.c b/target/riscv/monitor.c
index a9d3111444..bca04a7580 100644
--- a/target/riscv/monitor.c
+++ b/target/riscv/monitor.c
@@ -303,7 +303,7 @@ static bool reg_is_vreg(const char *name)
     }
 
     for (int i = 0; i < 32; i++) {
-        if (strcasecmp(name, riscv_rvv_regnames[i]) == 0) {
+        if (g_ascii_strcasecmp(name, riscv_rvv_regnames[i]) == 0) {
             return true;
         }
     }
@@ -358,7 +358,7 @@ int target_get_monitor_def(CPUState *cs, const char *name, uint64_t *pval)
             continue;
         }
 
-        if (strcasecmp(csr_ops[csrno].name, name) != 0) {
+        if (g_ascii_strcasecmp(csr_ops[csrno].name, name) != 0) {
             continue;
         }
 
-- 
2.52.0

