Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C347364943
	for <kvm@vger.kernel.org>; Wed, 27 May 2026 12:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779883566; cv=none; b=bDPivaF8uba9KsliTcJhzdwxNSd9ObRYsTHwMQcffOhKi08Bqy/NlsxFONV/PucszK3CK4YsuvVC8voindNZlk0FnUo4cddvGabjRkuNhEpQ3ANa9vAeR69iM+UXMUERs46bP+CRhWcjmBGqoha1MLH64cH5zJ/ynuIZ3LTTi2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779883566; c=relaxed/simple;
	bh=sJakOwgoaLmr7JL8jhwO2eFvsJfwpRc6uXqyTIIYn5k=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OUtp1QtsXYR+gutMK0e2L5Xf37IY7EjApRhREQY0MRvcuHpYWqY7NfVm8vElsCOjLdcv4CLHVPsfZDbkvCgIQEEm0KWnp+XMSJd+uvBcvf3WOP2OiQVEUwKDjBdO60nfc3KQTrxg4bLA5MnODPV1lSN4eQNR9EDxQL0xFP+rPEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hxgjA3Wn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hxgjA3Wn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779883564;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=6Yt65Z/rB38Hcv20EinKdGcWgOPdxo/+gdqdBjztFcA=;
	b=hxgjA3Wn6QEd7Rtk09mtCQXE6//HkkhFcBNGFpikx1iaoszNGE7xS8qgBV8e0re9IVUPyv
	Vd/JPQ3w7zeF1upMFhFIcAJdrBPBriVTq+cBRD3X7rGZDP51WNHp8IdTL8g1e1dyuZ6l6v
	gnk/0/Z4dDwT9B9JzxquEcvaRuilm9g=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-111-UaR9gHupMP2dYwnNwFj9Fg-1; Wed,
 27 May 2026 08:06:02 -0400
X-MC-Unique: UaR9gHupMP2dYwnNwFj9Fg-1
X-Mimecast-MFC-AGG-ID: UaR9gHupMP2dYwnNwFj9Fg_1779883561
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 98A80195608A;
	Wed, 27 May 2026 12:06:01 +0000 (UTC)
Received: from virtlab1023.lab.eng.rdu2.redhat.lab.eng.rdu2.redhat.com (virtlab1023.lab.eng.rdu2.redhat.com [10.8.1.187])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 341CF1684;
	Wed, 27 May 2026 12:06:01 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Subject: [PATCH 0/4] KVM: x86: small MMU-adjacent cleanups
Date: Wed, 27 May 2026 08:05:56 -0400
Message-ID: <20260527120600.20696-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

The non-MMU changes/preliminary cleanups from my "separate kvm_mmu"
series; fixed, test, and extracted for inclusion in 7.2.  The rest of
the series can be included later.

The meat here is in patches 2 and 3, which prepare for having a single
copy of the PDPTRs (in vcpu->arch) instead of two (in root_mmu and
nested_mmu).  Please take your time to appreciate nested virtualization
as an endless source of en{joy,ploy}ment.

Thanks,

Paolo

Paolo Bonzini (4):
  KVM: x86: remove nested_mmu from mmu_is_nested()
  KVM: nVMX: remove unnecessary code in prepare_vmcs02
  KVM: nSVM: invalidate cached PDPTRs across nested NPT transitions
  KVM: x86: check that kvm_handle_invpcid is only invoked with shadow
    paging

 arch/x86/kvm/kvm_cache_regs.h |  8 ++++++++
 arch/x86/kvm/svm/nested.c     | 27 ++++++++++++++++++---------
 arch/x86/kvm/vmx/nested.c     | 13 -------------
 arch/x86/kvm/x86.c            |  3 +++
 arch/x86/kvm/x86.h            |  2 +-
 5 files changed, 30 insertions(+), 23 deletions(-)

-- 
2.52.0

