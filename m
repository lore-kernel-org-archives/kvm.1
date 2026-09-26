Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2E5B224AF2
	for <kvm@vger.kernel.org>; Sat, 26 Sep 2026 05:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790400782; cv=none; b=ntl2YE8ghhgP5WVY74v9HUNfZ4V2aukolT3hVw46UlR+RWQNApJYwl5HyURpJqP/4fWUOCOl8S81kNoICPrBT52csGDFqjVcAP4r7WInOHYEiqN7cLiH3Vnuvd2HwR2bE06vTnMAh33jqEmCbOUO0kknIbi0Kx48vwKUqxnIE+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790400782; c=relaxed/simple;
	bh=U9RP1rMkHXWK/UQixTce++NvdlWQyxrrUwmpPMCl+V4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FIuYk8YTwkTtTwqpVhKSK1QTRhkkVu0c3H9EoqvtgAqeVUYgzjkAEh80/dBA41lBtKMewr3h2/wifKoTlkyWRTsnW4JkVsW1aRDQ8vTsn9CBk0alUZy4U7P5hhGgHlNF2kRkuZPX3IGlAcOwbOK0P0/vzsMkqKub0wbEUK5Ac/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QuxVlz42; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QuxVlz42"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790400780;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=E68A+IUHE+uxe7V65+WLcJRyKGaRPRk8RLrPS/VOEOA=;
	b=QuxVlz42zqsVPYTaawGcI1pEtMAUIZOHWLV0xLqkUU1reOahgzSn5N5yBrbiXsy34D2o/r
	hP6CyWoq6nu9v8Qov5S0ag100FxmoyPxZOJyCfhl2Vi1GlnnTVAQo5zpR9xwpNeStHyMSb
	1an+afdIdQEiwSM/Zi3i0Tdmc18O8cg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-216-BsGOXMgIM3qmlYCIkAvmWg-1; Sat,
 26 Sep 2026 01:32:55 -0400
X-MC-Unique: BsGOXMgIM3qmlYCIkAvmWg-1
X-Mimecast-MFC-AGG-ID: BsGOXMgIM3qmlYCIkAvmWg_1790400774
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AD56619541AD;
	Sat, 26 Sep 2026 05:32:54 +0000 (UTC)
Received: from virtlab1023.virt.eng.rdu2.dc.redhat.com (virtlab1023.virt.eng.rdu2.dc.redhat.com [10.18.48.26])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 49CC91956086;
	Sat, 26 Sep 2026 05:32:54 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Subject: [PATCH 00/11] KVM: fix issues with stale control fields
Date: Sat, 26 Sep 2026 01:32:42 -0400
Message-ID: <20260926053253.195597-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Fix two bugs where the guest could do stupid things on purpose to
cause problems in the host.

Patches 1-5 cover cases where actions done through VMCB control fields
have to be redone if VMRUN fails.  In particular, failed VMRUNs can
cause pending TLB flushes to be dropped.

Patch 6 fixes a case where eVMCS execution controls can cause the
host to use a stale MSR permission bitmap.  Patches 7-11 are tests
for nested x2APIC; don't run them on an unpatched kernel.

Paolo

Sean Christopherson (11):
  KVM: SVM: Preserve TLB control (i.e. pending TLB flush) on failed
    VMRUN
  KVM: SVM: Update control fields on #VMEXIT if and only if VMRUN
    succeeded
  KVM: SVM: Don't mark ASID fields as dirty when setting control.tlb_ctl
  KVM: SVM: Sync guest's PERF_CNTR_GLOBAL_CTL from h/w only on
    successful VMRUN
  KVM: SVM: Use the active VMCB's MSR bitmap when checking if MSR is
    intercepted
  KVM: nVMX: Force MSR bitmap refresh if runtime eVMCS controls are
    modified
  KVM: selftests: Add x2APIC MSR test for inhibiting APICv while nested
  KVM: selftests: Run the nested x2APIC with and without APICv being
    inhibited in L2
  KVM: selftests: Verify that L0's TPR doesn't get clobbered
  KVM: selftests: Extend nested x2APIC test to validate disabling x2APIC
    virt
  KVM: selftests: Extend nested x2APIC test to validate using eVMCS for
    vmcs12

 arch/x86/kvm/svm/sev.c                        |   1 -
 arch/x86/kvm/svm/svm.c                        |  43 ++--
 arch/x86/kvm/svm/svm.h                        |   1 +
 arch/x86/kvm/vmx/nested.c                     |   6 +
 tools/testing/selftests/kvm/Makefile.kvm      |   1 +
 .../selftests/kvm/x86/nested_x2apic_test.c    | 235 ++++++++++++++++++
 6 files changed, 263 insertions(+), 24 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/x86/nested_x2apic_test.c

-- 
2.52.0

