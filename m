Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11C3C43C061
	for <kvm@vger.kernel.org>; Thu,  4 Jun 2026 14:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780583166; cv=none; b=q9alu7sGB2GWXgLo0NYhTqFOm32ggDliHYgxo4aszpqiX2o3QL4w7YkgAzzdSoEvctIwiJWhjsgoAHQE+uUT+foydngqJJBYOWjLANT4jPIZXfDkFEi3Stg1kYKVHsSb6u/FTI6QCcUXdQXV3Xkdo7NxSU25VERXezkwCBUwAD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780583166; c=relaxed/simple;
	bh=mnlWgWQJQm99oBAcDBt7QyMPdj+bUA7QcfWckKOm6y4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CD2s/8h1asryMgPCldsA0hk9ZcjHCyS5GyPX/xK+BX3+Qc2xOHLKDkf1GByNW2jJeCCBK4GWEl5vB30kFR0q5gDqzRXNZ98cXQ8ujgBMZ5GlFPGzCwgxzo59SvLjr0ohjDrXsKrLGzEpCVsQ2n57eWe8LiTwX8bj8UuIp4DGm3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Tb/pnLw0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tb/pnLw0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780583164;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=7MxkAQRU6HYWczIxY5m+m/c8f8Yg1B+fwSoYzcVjpTg=;
	b=Tb/pnLw0Jm3QljEBOTvpzbK15buehHs8TigYVxBSfEf2u+XBkZ1263GIVSzuYn6JUPB/40
	PXg092c1FHBmCgtF/vZC5F9n0TSbRyuMX9QfTWcZRYxODEc56YQINp+5WqIHpgVI/nWL8R
	abo+ZDhFapmGBYVCabufn+IzJAeKUk8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-251-5LhQv91YNje57tWstnu9Aw-1; Thu,
 04 Jun 2026 10:26:02 -0400
X-MC-Unique: 5LhQv91YNje57tWstnu9Aw-1
X-Mimecast-MFC-AGG-ID: 5LhQv91YNje57tWstnu9Aw_1780583162
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2384418004A9
	for <kvm@vger.kernel.org>; Thu,  4 Jun 2026 14:26:02 +0000 (UTC)
Received: from virtlab1023.lab.eng.rdu2.redhat.lab.eng.rdu2.redhat.com (virtlab1023.lab.eng.rdu2.redhat.com [10.8.1.187])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C82B3180049F
	for <kvm@vger.kernel.org>; Thu,  4 Jun 2026 14:26:01 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: kvm@vger.kernel.org
Subject: [PATCH kvm-unit-tests v3 0/4] add reserved bit tests for 32-bit guests
Date: Thu,  4 Jun 2026 10:25:57 -0400
Message-ID: <20260604142601.7440-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

VMX and SVM tests are only running 64-bit guests.  Add a test that checks
the reserved and ignored bits in CR3 and PDPTEs.  Improved version of
https://lore.kernel.org/kvm/20260521101723.101100-1-pbonzini@redhat.com/

Paolo


Paolo Bonzini (4):
  vmx: add a test for 32-bit guest PAE paging PDPTEs
  vmx: add test for 32-bit non-PAE guest
  svm: add test for 32-bit PAE guest
  svm: add test for 32-bit non-PAE guest

 x86/svm_tests.c | 226 +++++++++++++++++++++++++++++++++++++++++++
 x86/vmx.c       |  10 ++
 x86/vmx.h       |   1 +
 x86/vmx_tests.c | 252 +++++++++++++++++++++++++++++++++++++++++++++++-
 4 files changed, 486 insertions(+), 3 deletions(-)

-- 
2.52.0

