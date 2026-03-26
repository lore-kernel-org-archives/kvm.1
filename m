Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88F6E39D6D4
	for <kvm@vger.kernel.org>; Thu, 26 Mar 2026 14:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774536645; cv=none; b=CceSkFskYQuVCSb9WKGP7CASQ28yiTY/FiEXmP56Lwn43nqhTLTEqF5iPWqNWrrYnwatERXBNu+IqM+lAoztXWX7et6MaV+UI8gARYZx662SWg71+gXS4N0xFABMCnUOinxpMcqtQ62iF1UMmTwQQaf0ysiIY/+5OU0XWaxkXAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774536645; c=relaxed/simple;
	bh=lbqnWFfnX3DEFiM+Hd0zDysMR3CCnut49Rw4sKDomYc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AvhYsulQt6V92sJKy8X/nbBdlzjGZvvowZZ6s/MugQJg+8n65Oe8fAEKNdBaqF4eqb+uK1Bz8cyTQpm8vy/2vKBCgH3RF2A2eXeBYoPBKOIY7bOlXZ8/HjGiejOqof9GhTablIxloOh/3BV1zcajIqPpgftJpTRT+UG4qkJsixs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Qzsbk5J3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qzsbk5J3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774536643;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=YFwCezYc7JOXAs1GZqWcmwWHV7H8a9hZ6dEAeComFf8=;
	b=Qzsbk5J3G8hUM7titQMeiO+Lh0fESAVHwmzvLRIcmMLEW2CE/M4vAn4guiPuTuIVu/VM2o
	XteQ08Dbo7DNFmdrfeXsYJ1IM56dN4LKeyGDj4iWHZ7MHxFYr0ZH2Hz+SYJtwtCye1sRpI
	KcECUtS+OfBwSURQWT3r7BPgxWbkzz0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-292-5MP0qcLVNKmvJDy4M4Lv0g-1; Thu,
 26 Mar 2026 10:50:37 -0400
X-MC-Unique: 5MP0qcLVNKmvJDy4M4Lv0g-1
X-Mimecast-MFC-AGG-ID: 5MP0qcLVNKmvJDy4M4Lv0g_1774536636
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C748F195608C;
	Thu, 26 Mar 2026 14:50:36 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com (virtlab701.virt.eng.rdu2.dc.redhat.com [10.6.68.74])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 14E50180036E;
	Thu, 26 Mar 2026 14:50:35 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: kvm@vger.kernel.org
Cc: Jon Kohler <jon@nutanix.com>,
	Nikunj A Dadhania <nikunj@amd.com>,
	Amit Shah <amit.shah@amd.com>,
	Sean Christopherson <seanjc@google.com>
Subject: [PATCH kvm-unit-tests 0/9] Combined GMET and MBEC tests
Date: Thu, 26 Mar 2026 10:50:26 -0400
Message-ID: <20260326145035.119519-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

This adds new tests for both GMET and MBEC.

The code for MBEC is roughly based on the previous submission at
https://lore.kernel.org/kvm/20251223054850.1611618-1-jon@nutanix.com/,
though with pretty heavy reorganization and fixing work on top.

The existing EPT tests now test execution on both supervisor and
user-mode pages, with different expected outcomes depending on
whether MBEC is enabled or not; on top of this, the last patch
adds tests for XU=1 and XS=XU=1.

For simplicity, the tests always enable MBEC when available.
A new block in unittests.cfg ensures that both non-MBEC and
MBEC is covered.

I will shortly send a new version of the patches that passes
the tests.

Paolo

Jon Kohler (1):
  x86/vmx: update EPT installation to use EPT_PRESENT flag

Paolo Bonzini (8):
  move PFERR_* constants to lib
  add definitions for nested_ctl
  svm: add basic GMET tests
  x86/vmx: diagnose unexpected EPT violations
  x86/vmx: add mode-based execute control test for Skylake and above
  x86/vmx: add user execution operation to EPT access tests
  x86/vmx: run EPT tests with MBEC enabled when available
  x86/vmx: add EPT tests covering XU permission

 Makefile            |   2 +-
 lib/util.h          |  10 +-
 lib/x86/asm/page.h  |   7 +
 lib/x86/processor.h |   1 +
 x86/access.c        |   7 -
 x86/svm.c           |  19 +-
 x86/svm.h           |   4 +
 x86/svm_npt.c       |  83 ++++++++-
 x86/unittests.cfg   |  21 ++-
 x86/vmx.c           |   3 +-
 x86/vmx.h           |  32 ++--
 x86/vmx_tests.c     | 414 +++++++++++++++++++++++++++++++++++++-------
 12 files changed, 513 insertions(+), 90 deletions(-)

-- 
2.52.0

