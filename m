Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4947A3D1ABC
	for <kvm@vger.kernel.org>; Wed, 27 May 2026 12:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779883568; cv=none; b=U1Umwy+eJBdC32zsplYqN5a+TWLTdQn5jhAqNRiech5toj6+A70nKbG+vIQmB7BV/yBFQFhpBqshCT3p1MCyEtXSgQppIUc5XDTVDioliKDk9GeR71skd8/daI+grZp/mqFTkq68IItXaoYqtFLRBjemmYtf9nsWRuWvnvbdXpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779883568; c=relaxed/simple;
	bh=0t/PwehJOhkZ25cyQ8uMWFa2qQhoO6sby96IaT7I5cs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZbTlK9qaLpaFFWaShhC33zYwde9qlmQXhzwuGUbP3EcfH62MzWnH1hchE/TlnBmCdD0/uIi9fY3tuABXQ3xNmWraWqR4G9bmqZfuF5NmoUSDjWUpSDzl1feK+III3Tmbu0/swkU4U6OPzjyw7lgrwycb/51+QSCzSvKksGB5ssk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RdduHEia; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RdduHEia"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779883566;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8eLGDCCntmNXCbQ4uxKMEWyY9/qJPquq+xtWLIx9isI=;
	b=RdduHEiaw+8QKk5xwvMDZee0S9GEAJwnPjBn3YKHdqmcuJ5j9T/j2bMU00aTX89f94BBd9
	1FKEXH9jhr1IRX9EQ7qK9Wzu6bczRuFsn63PyhsIZMC4hemtPnlFjNFTeWnGQHaCK0unzX
	OPIteemvbSZ7XQeb6d1m5Kiir4q8OpA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-665-jX1e7Ex1ODOh-bwusQdEcg-1; Wed,
 27 May 2026 08:06:04 -0400
X-MC-Unique: jX1e7Ex1ODOh-bwusQdEcg-1
X-Mimecast-MFC-AGG-ID: jX1e7Ex1ODOh-bwusQdEcg_1779883564
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DF1BF195609F;
	Wed, 27 May 2026 12:06:03 +0000 (UTC)
Received: from virtlab1023.lab.eng.rdu2.redhat.lab.eng.rdu2.redhat.com (virtlab1023.lab.eng.rdu2.redhat.com [10.8.1.187])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 63A611681;
	Wed, 27 May 2026 12:06:03 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Subject: [PATCH 4/4] KVM: x86: check that kvm_handle_invpcid is only invoked with shadow paging
Date: Wed, 27 May 2026 08:06:00 -0400
Message-ID: <20260527120600.20696-5-pbonzini@redhat.com>
In-Reply-To: <20260527120600.20696-1-pbonzini@redhat.com>
References: <20260527120600.20696-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

This is true for both Intel and AMD.  On Intel, "enable INVPCID" is
set unconditionally if supported, but the vmexit is triggered by the
"INVLPG exiting" control which is disabled by enable_ept.  On AMD, KVM
can intercept INVPCID if NPT is enabled but only in order to inject #UD
in the guest.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/x86.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index fc0924389398..1913efef6c39 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -14350,6 +14350,9 @@ int kvm_handle_invpcid(struct kvm_vcpu *vcpu, unsigned long type, gva_t gva)
 		return 1;
 	}
 
+	if (WARN_ON_ONCE(tdp_enabled))
+		return 0;
+
 	pcid_enabled = kvm_is_cr4_bit_set(vcpu, X86_CR4_PCIDE);
 
 	switch (type) {
-- 
2.52.0

