Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 879BF39E162
	for <kvm@vger.kernel.org>; Sat, 30 May 2026 16:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780160154; cv=none; b=cgj+I65KeikP8DByExDNRcYMTC2QFEctrqeyvA+3StP2VaEh/QNoTO1sbcX93Wp3dDfqdxeRekOOlaJvasfj1hmAHF2Idbg+0NDnso3tZGUHObVdvV46tL0MGfq/ppmRxGePNU7SP2ANo0szkSeYjtF9uAQr1YIt7GwpeKjd08Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780160154; c=relaxed/simple;
	bh=0t/PwehJOhkZ25cyQ8uMWFa2qQhoO6sby96IaT7I5cs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FENgX4axg5/scU5FFvmMjFfoxe+grR42xvCDOY/YVOcpnaGUe19e7UkUt2Ly5AhfGYeK7tJx8x/lLAM+K2knvdYJIODNqn2VVs7c3hMd+nDaaHmr5BlT80J4nkfv0zxSlUFweePCJd4mOdGgxbbolivqDbGEw++pyr2liGM89nE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i0m4afQa; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i0m4afQa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780160152;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8eLGDCCntmNXCbQ4uxKMEWyY9/qJPquq+xtWLIx9isI=;
	b=i0m4afQab+U6qRdRuKodis/qgyrvTZReulXpLzcsIM+/DJPpysPlZy9OkoAYXoI/jRyePM
	jGLaXkhFBBBCuXo3GxrPapcTTJbIfAFY9jqK46T8f+xVb0ODI7dxUtdzzIvUu+i5M6AYf+
	Mmq6c38kuoTAjoqV96ohCfG4UMTwXc0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-398-ZyVnwrMsOlu7O8ekfM-lLQ-1; Sat,
 30 May 2026 12:55:50 -0400
X-MC-Unique: ZyVnwrMsOlu7O8ekfM-lLQ-1
X-Mimecast-MFC-AGG-ID: ZyVnwrMsOlu7O8ekfM-lLQ_1780160149
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A15AE1800344;
	Sat, 30 May 2026 16:55:49 +0000 (UTC)
Received: from virtlab1023.lab.eng.rdu2.redhat.lab.eng.rdu2.redhat.com (virtlab1023.lab.eng.rdu2.redhat.com [10.8.1.187])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 254281800465;
	Sat, 30 May 2026 16:55:49 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: seanjc@google.com
Subject: [PATCH v2 4/5] KVM: x86: check that kvm_handle_invpcid is only invoked with shadow paging
Date: Sat, 30 May 2026 12:55:44 -0400
Message-ID: <20260530165545.25599-5-pbonzini@redhat.com>
In-Reply-To: <20260530165545.25599-1-pbonzini@redhat.com>
References: <20260530165545.25599-1-pbonzini@redhat.com>
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


