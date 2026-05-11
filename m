Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91E2331F9A2
	for <kvm@vger.kernel.org>; Mon, 11 May 2026 15:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778512017; cv=none; b=ngisFI+NRZLMFuEMUiQSqz6A5HwKy8AjEvPJOjnVRcjvTHRPwVbFJuzaiPVDIWc4H+jifjJTc3B+U1RyfAlSvuhdRFwR+yH/k4ZMJCQZyl7BIqgvCC2TC0u2XNq/mxYmuIlL0FP3xg9aRxzakcVzLdAYKYPIvq+VzbzpxdcEA2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778512017; c=relaxed/simple;
	bh=4Ye+k0/xyzbHlxxMKGn4w+DgKlMKr3lNXTxacABYWRo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=osWSoDLv6IoxJgaoGwBenVmS7oiWLWToKh6XwV3iPXPdWa05ejLP5U4pG7V5i39/94EpYI0E17toU3GhV7jxn2JWIOM2zxoAzwo9JKeLShfiv3Z2lioHwX1W+jXcRqxUdhUx0KZiNMZT+9ODsTKn4ds6WNQ1M2RJXUsdp6WhzFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JvlYsr/1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JvlYsr/1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778512015;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ALrtBQRHnKoboYwo0C1YWlpAqNxRIJONuElfV2E4xD0=;
	b=JvlYsr/1nLnMRrP/BVPC5koUF2QLp2Z69fqb5thBuCG2xeGVSJ1XAO0gmrFlhrpkKXuV3y
	Q5tWycaR4TFyAhurs2D2kdOFnYiGWGCmAOduA7cQNEw+NnRyxE2RVFwQ+HZRFnl70+vIV1
	pAH4phy1AsLnBVkU+Lx/pTPtTQwj8vM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-240-Z742gBqLNjCHHgYbL9zmWw-1; Mon,
 11 May 2026 11:06:53 -0400
X-MC-Unique: Z742gBqLNjCHHgYbL9zmWw-1
X-Mimecast-MFC-AGG-ID: Z742gBqLNjCHHgYbL9zmWw_1778512012
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 307CF1800628;
	Mon, 11 May 2026 15:06:52 +0000 (UTC)
Received: from virtlab1023.lab.eng.rdu2.redhat.lab.eng.rdu2.redhat.com (virtlab1023.lab.eng.rdu2.redhat.com [10.8.1.187])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9638A180034E;
	Mon, 11 May 2026 15:06:51 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: jon@nutanix.com,
	mtosatti@redhat.com
Subject: [PATCH 03/22] KVM: x86: check that kvm_handle_invpcid is only invoked with shadow paging
Date: Mon, 11 May 2026 11:06:29 -0400
Message-ID: <20260511150648.685374-4-pbonzini@redhat.com>
In-Reply-To: <20260511150648.685374-1-pbonzini@redhat.com>
References: <20260511150648.685374-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

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
index 4a2c977a542f..efe54a9c887a 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -14282,6 +14282,9 @@ int kvm_handle_invpcid(struct kvm_vcpu *vcpu, unsigned long type, gva_t gva)
 		return 1;
 	}
 
+	if (WARN_ON_ONCE(tdp_enabled))
+		return 0;
+
 	pcid_enabled = kvm_is_cr4_bit_set(vcpu, X86_CR4_PCIDE);
 
 	switch (type) {
-- 
2.52.0


