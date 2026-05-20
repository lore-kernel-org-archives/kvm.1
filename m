Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA3A34D4EA
	for <kvm@vger.kernel.org>; Wed, 20 May 2026 08:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779266754; cv=none; b=ra9OqnXL2ZkVfMg4BddbXNii2j2KIxhvMB6BR78vsoQ8wGnn7vUujYGNqClw/iFybChyaJr+vUiPHR/gt2zm2tPPZw4v8qlieO0v+nuqH7USZIYB+kygSax4FwV8WNhFrXkmTetvIsFG/+Hbh1BdZBlbuUCRgQECT43gg9gcyEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779266754; c=relaxed/simple;
	bh=C2PgX3u+x4+roReTjIqkd9GS3PFPhkB33QRpUR6etgw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=YYmVgwIY7P9UXCXdT5RC/vPFNjV5IXDO4zazYfvDCjE57M37jWL/GnTQVPNaioUrJ1ScPVb1+UFv5y+nmKGI4vZNbOhrr5V6LaPyLUdRBXaLzHvMi0zRACDducAcVr90KNZdvawRcNmonQu2V2wEWHGImKb/xHht+EL182j6aX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ehX/gSg0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ehX/gSg0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779266751;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=kDOONiVOO+nm0GTV7hJlvcom4JkxwFXrK8YNOZqfe+c=;
	b=ehX/gSg05fJzLXITb8TinICJm6MinWV170Yyhyo6ysDvjdK3BZGWFRIDt4hHdvEC9rvxIW
	QUM/UOVvYcBbNgvg6ewVcpGgaFwVH3Wcuao+Gv0RuknFfTIswjJ1Pzk6D7EOkF69e1dLgu
	wISWLgsGWTsphsBhZjRv/+jDz0jRJw8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-252-NTOi6O8mO-W_XZrQ1g1_3w-1; Wed,
 20 May 2026 04:45:49 -0400
X-MC-Unique: NTOi6O8mO-W_XZrQ1g1_3w-1
X-Mimecast-MFC-AGG-ID: NTOi6O8mO-W_XZrQ1g1_3w_1779266749
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0D0E31800371
	for <kvm@vger.kernel.org>; Wed, 20 May 2026 08:45:49 +0000 (UTC)
Received: from thuth-p1g4.redhat.corp (headnet01.pony-001.prod.iad2.dc.redhat.com [10.2.32.101])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 195E519560A2;
	Wed, 20 May 2026 08:45:47 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
	kvm@vger.kernel.org
Subject: [kvm-unit-tests PATCH] x86: Work-around failing intel-iommu test due to bug in GCC v16.1
Date: Wed, 20 May 2026 10:45:46 +0200
Message-ID: <20260520084546.365816-1-thuth@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

From: Thomas Huth <thuth@redhat.com>

GCC v16.1 has a bug that causes the intel-iommu test to fail:

 https://gcc.gnu.org/bugzilla/show_bug.cgi?id=125180

Add a work-around for the time being until this is fixed, so we can
get our CI green again.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 x86/Makefile.x86_64 | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/x86/Makefile.x86_64 b/x86/Makefile.x86_64
index e5db2365..5b221a48 100644
--- a/x86/Makefile.x86_64
+++ b/x86/Makefile.x86_64
@@ -65,3 +65,8 @@ $(TEST_DIR)/hyperv_clock.$(bin): $(TEST_DIR)/hyperv_clock.o
 $(TEST_DIR)/vmx.$(bin): $(TEST_DIR)/vmx_tests.o
 $(TEST_DIR)/svm.$(bin): $(TEST_DIR)/svm_tests.o
 $(TEST_DIR)/svm_npt.$(bin): $(TEST_DIR)/svm_npt.o
+
+# Workaround for https://gcc.gnu.org/bugzilla/show_bug.cgi?id=125180
+fno_fuse_ops_with_volatile := $(call cc-option, -fno-fuse-ops-with-volatile-access,)
+$(TEST_DIR)/intel-iommu.o: CFLAGS += $(fno_fuse_ops_with_volatile)
+lib/pci-edu.o: CFLAGS += $(fno_fuse_ops_with_volatile)
-- 
2.54.0

