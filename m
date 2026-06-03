Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA58F44A718
	for <kvm@vger.kernel.org>; Wed,  3 Jun 2026 10:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780484305; cv=none; b=DCkRm+Ixvzh8a4A2h1Y8YKEOxL3fYTCoO7ejGUuJth1ti5efERwTXHruCgvQv8UHzvgQWHLXgLU4+kWxbjcarBVBAAOCGgby6xP/J9V55X3typtyBjCjySeYzxi+un5Zedog8gnIiRi6BBV4UCq0hJXSvIDWGNhzez6mHwP6hkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780484305; c=relaxed/simple;
	bh=b0LcpMR544N/isNg3tfPHpqnBsdyM2QGsdAxWjYuI10=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GCS6Gxfg445pobunW+MiMeLIHl4Qz7giirZZjrKV7RVRXOiCdklTJ6ATjFJGMZEXWPJW/e0QD3kMOiXIH+qdfh1oKYQbcBzGq2XfZIJ35tkPwiMfA6HHXQb7YkSgJdu4OW04dunjR5OxWs1I00ECDLP3ER1QNq1mj5/kwinFAZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YnUgr8Za; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YnUgr8Za"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780484302;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kYe3fKfRxXiwypEiyAL53b1qVAEXN1RgGxgN7hKhSQg=;
	b=YnUgr8Zad8GBZwmB/HUZATNwy8gu532dCrcGO4hYTaS24jfkeon68bSEKdMRJ3YJVZD8HJ
	uty8UaKFajctzqp+LHynEoapFRevmdXQRYnYcCxGOcSahZGE6aPLWPBVbnXlHAcLtJelGv
	7njbG9EFQsFt5va+gPXrOBxKMmiea2c=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-90-FRVRSdfVOPuZV1ftrMXADA-1; Wed,
 03 Jun 2026 06:58:18 -0400
X-MC-Unique: FRVRSdfVOPuZV1ftrMXADA-1
X-Mimecast-MFC-AGG-ID: FRVRSdfVOPuZV1ftrMXADA_1780484297
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CFB95195609D;
	Wed,  3 Jun 2026 10:58:17 +0000 (UTC)
Received: from virtlab1023.lab.eng.rdu2.redhat.lab.eng.rdu2.redhat.com (virtlab1023.lab.eng.rdu2.redhat.com [10.8.1.187])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6AB66404;
	Wed,  3 Jun 2026 10:58:17 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Subject: [PATCH 04/24] KVM: x86: check that kvm_handle_invpcid is only invoked with shadow paging
Date: Wed,  3 Jun 2026 06:57:54 -0400
Message-ID: <20260603105814.10236-5-pbonzini@redhat.com>
In-Reply-To: <20260603105814.10236-1-pbonzini@redhat.com>
References: <20260603105814.10236-1-pbonzini@redhat.com>
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
index 48f259015ce4..6897b9f4ce7f 100644
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


