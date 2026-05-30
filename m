Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55563395AE2
	for <kvm@vger.kernel.org>; Sat, 30 May 2026 16:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780160154; cv=none; b=nKoMN2Ga9PSww95KqgtAJrMZK9chGYdH5lzszOLeS8/8qhZL3tRBGpDLEfZ0SOxWNn8iqCJBW/KvfwHUJXznL4w95tdYPczHRuR2T+FMq+mxJFBcivBJincMEwb+UYNR18aQYh4W1QzBMwxjRM1HdgrUmenyk+jBnlIRMM6XMPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780160154; c=relaxed/simple;
	bh=37++IMhnaYjeuQ7+nOeNIxOO0KMkYr5b0Tsr4WuY5oU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PskV0H4ywsqOxEadD9dHhmKKFrBg6DVF9UohyxVds9B3ZMbq9z3LfYk4tSpKRGdxZlKAqsNvNBFl4SKqUL39p2C7X6ziBQ6KUrjcUZygwgx1IiUcfcAOBEdWr249k74MhDlqgSBts974S2lH4g1m3YMet0lTn2XgdXahsyTE1ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Xhp9vRb2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xhp9vRb2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780160152;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=OJVRPImC+oFzqpiNsvgyX25rbgZwpa2UaCN+sKIUGoA=;
	b=Xhp9vRb2ENGtxHXzxRibc93yQy4i0irgeTtL3GlZfJopkOsNNCIS92euVSjIHg2+m/MzGD
	DljEnmLLGfa/33MliSj2u9MkKcv7+3CdPzl8xldzdPjRZNkDVfj0Scg4ZNfnfDtWddiRH5
	miF5l8/bC94qU3rLfo/la5iR2dbdY28=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-360-PxyEtZHjO3uC2VmvKe3yig-1; Sat,
 30 May 2026 12:55:48 -0400
X-MC-Unique: PxyEtZHjO3uC2VmvKe3yig-1
X-Mimecast-MFC-AGG-ID: PxyEtZHjO3uC2VmvKe3yig_1780160147
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2594E195604F;
	Sat, 30 May 2026 16:55:47 +0000 (UTC)
Received: from virtlab1023.lab.eng.rdu2.redhat.lab.eng.rdu2.redhat.com (virtlab1023.lab.eng.rdu2.redhat.com [10.8.1.187])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8A13F1800352;
	Sat, 30 May 2026 16:55:46 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: seanjc@google.com
Subject: [PATCH v2 0/5] KVM: x86: small MMU-adjacent cleanups
Date: Sat, 30 May 2026 12:55:40 -0400
Message-ID: <20260530165545.25599-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

The non-MMU changes/preliminary cleanups from my "separate kvm_mmu"
series; fixed, test, and extracted for inclusion in 7.2.  The rest of
the series can be included later.

The meat here is in patches 2 and 3, which prepare for having a single
copy of the PDPTRs (in vcpu->arch) instead of two (in root_mmu and
nested_mmu).  This is then done in the last patch.

I have redone the nVMX patch now that Sean pointed out that the duplicate
write was a rebase goof.  I kept the nSVM one as is though.

v1->v2:
- rewritten "KVM: nVMX: remove unnecessary code in prepare_vmcs02_rare"
- added "KVM: x86/mmu: move pdptrs out of the MMU"

Thanks,

Paolo

Paolo Bonzini (5):
  KVM: x86: remove nested_mmu from mmu_is_nested()
  KVM: nVMX: remove unnecessary code in prepare_vmcs02_rare
  KVM: nSVM: invalidate cached PDPTRs across nested NPT transitions
  KVM: x86: check that kvm_handle_invpcid is only invoked with shadow
    paging
  KVM: x86/mmu: move pdptrs out of the MMU

 arch/x86/include/asm/kvm_host.h |  5 ++---
 arch/x86/kvm/kvm_cache_regs.h   | 12 ++++++++++--
 arch/x86/kvm/svm/nested.c       | 27 ++++++++++++++++++---------
 arch/x86/kvm/svm/svm.c          |  2 +-
 arch/x86/kvm/vmx/nested.c       | 11 -----------
 arch/x86/kvm/vmx/vmx.c          | 20 ++++++++------------
 arch/x86/kvm/x86.c              |  9 ++++++---
 arch/x86/kvm/x86.h              |  2 +-
 8 files changed, 46 insertions(+), 42 deletions(-)

-- 
2.52.0

