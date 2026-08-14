Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D683822B7
	for <kvm@vger.kernel.org>; Fri, 14 Aug 2026 16:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786724551; cv=none; b=FkgqwGfkvULFy9dm2oHfXgTr2PJJMEI0P0hdbRJ+7gzQ43OfjBoOn25dy5Dl0u27dSGSAKA2NCi1NP1c6k5LlMEJHbfzp0RK2rK/h6X0fL7Q47S3awb2DSSlgkiW5O1Pe2M7HSh1ZR5XD71217c1K9gjMayoS2r1ZrgosHszN2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786724551; c=relaxed/simple;
	bh=KH7dFySbXlcN2p/xeodlN6wUzyw0iKCSzl5adxkvQDM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VG0XpV49eCtHoaFjGnoOqAYfAPi+wzLaW71LLdfG4Y2lOqD7WuSeRe8nQB9/kK0iA0I84iqp2V0Gmr0Z88gBHgMW2YTwF8bQoQUaOyuUMRG3akiWNuTFOkmw/PumK+X9JzvpElzsPdIM3DRIpQfGp1aLOSYlXp6o1SDCKempNOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ah8ix21y; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ah8ix21y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786724548;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=DIV3ESPHWZHWTP/39EDpQjrS0S1Q18Piic27WrFpl3k=;
	b=Ah8ix21yhQNA/2XCe0YqLwFqctQCkAalXwBxalFS7BheJpmPnzHX0ey8pkrRnnhvH9lcTX
	Gaisd49tg//CaQ7P0AcdlrmOo0mX/0vxsK9XCwOeu/mbIXL5mh4gsaGUiUaakmzzL04tTb
	fO/Y+vr6tx/pac81tIKYedOVCBww6YQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-251-hwC0LzgqMMCEu-kMnAo0ag-1; Fri,
 14 Aug 2026 12:22:26 -0400
X-MC-Unique: hwC0LzgqMMCEu-kMnAo0ag-1
X-Mimecast-MFC-AGG-ID: hwC0LzgqMMCEu-kMnAo0ag_1786724545
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E9A1D1956046;
	Fri, 14 Aug 2026 16:22:24 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.48.234])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 10073423;
	Fri, 14 Aug 2026 16:22:22 +0000 (UTC)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: kvm@vger.kernel.org,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Cc: f734222792@gmail.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] KVM: nVMX: Adjust VMPTRLD/VMPTRST behavior with active eVMCS
Date: Fri, 14 Aug 2026 18:22:17 +0200
Message-ID: <20260814162221.2144473-1-vkuznets@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

It was reported (https://bugzilla.kernel.org/show_bug.cgi?id=221841) that
KVM's emulation of VMPTRLD/VMPTRST instructions when Enlightened VMCS is
active is sub-optimal: returning '1' does not make the L1 guest skip the
instruction so a hang is likely to happen. While TLFS does not really
specify the expected behavior, genuine Hyper-V seems to return #UD for
VMPTRLD and eVMCS pointer for VMPTRST. Alter the behavior in KVM and check
it in selftests.

Note: this is not a security issue. Misbehaving L1 can only do self-harm
by doing VMPTRLD/VMPTRST when it also uses eVMCS.

Vitaly Kuznetsov (4):
  KVM: nVMX: Make VMPTRLD result in #UD when eVMCS is used
  KVM: nVMX: Make VMPTRST return eVMCS GPA when it is used
  KVM: selftests: Adapt to the updated VMPTRST behavior when eVMCS is
    used
  KVM: selftests: Check VMPTRLD with active eVMCS

 arch/x86/kvm/vmx/nested.c                     | 22 +++++++++++++------
 tools/testing/selftests/kvm/include/x86/vmx.h |  6 -----
 .../testing/selftests/kvm/x86/hyperv_evmcs.c  | 18 ++++++++++-----
 3 files changed, 28 insertions(+), 18 deletions(-)

-- 
2.55.0

