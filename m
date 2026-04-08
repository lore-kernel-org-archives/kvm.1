Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620CC3DCDBC
	for <kvm@vger.kernel.org>; Wed,  8 Apr 2026 15:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775662969; cv=none; b=M7gxo4wCe8ZORdUFdN6SwyvvIqRqjbQl1y9OWbRjeP27Zr6Cxt3Rei8zO0w1w50C2DnmH+wZ2uJYncEnnJeAoRvlc0xytA5MeSKriiHSRI2wxTVzj8pUeVWb7N4DcjNReO7a/0CWprEOfNHwnYzTnF/1GC4zPlTXEIkApqE2mIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775662969; c=relaxed/simple;
	bh=ZC6NCvnfM7WpBsDvG2b0UXeZTe7aYsSUmPg1AtwNUgo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RRIn02DFE2eHNMuBcGMPNHmeJ3y8syIzFBqLUAXLQ++f+AbgIPoEXlZk6AO3RHI2CA/DYSzpHc4lOr9WvgS8w3AP8K7kCIKEFT4NFZrMsrEzYI71QGGKMpo3mUN7OiY+sW4D7SnHZF3+bmjBoqwz3dU8OE2/bQINZaDEao6QRPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AGGIHMFG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AGGIHMFG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775662966;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7JkpVhW/sTdXQFvSvpTCG+JUTud5ztAXKsP5roiWk5Y=;
	b=AGGIHMFGtDYcnOT89gTJMlKzKz0YOeK8FcqA3edlKHyPjGN386+MxSiOZZD9hjRECO6CoQ
	157B42ZLp53LEMbM+1CN1FFvtzfJL5Zg1WCXHneO43Ag3dtzywog8g4T37lk4xJh2PCm4R
	F+JtQ+0ORyx2Tlt7cx6whQGhTbObFqQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-99-w2Gtgh6-NZiQYMG6lisMrw-1; Wed,
 08 Apr 2026 11:42:41 -0400
X-MC-Unique: w2Gtgh6-NZiQYMG6lisMrw-1
X-Mimecast-MFC-AGG-ID: w2Gtgh6-NZiQYMG6lisMrw_1775662959
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C3F4E1800620;
	Wed,  8 Apr 2026 15:42:39 +0000 (UTC)
Received: from virtlab1023.lab.eng.rdu2.redhat.lab.eng.rdu2.redhat.com (virtlab1023.lab.eng.rdu2.redhat.com [10.8.1.187])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id EEC9A300019F;
	Wed,  8 Apr 2026 15:42:38 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: Jon Kohler <jon@nutanix.com>,
	Nikunj A Dadhania <nikunj@amd.com>,
	Amit Shah <amit.shah@amd.com>,
	Sean Christopherson <seanjc@google.com>,
	Marcelo Tosatti <mtosatti@redhat.com>
Subject: [PATCH 20/27] KVM: nVMX: allow MBEC with EVMCS
Date: Wed,  8 Apr 2026 11:42:10 -0400
Message-ID: <20260408154217.458420-21-pbonzini@redhat.com>
In-Reply-To: <20260408154217.458420-1-pbonzini@redhat.com>
References: <20260408154217.458420-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

From: Jon Kohler <jon@nutanix.com>

Extend EVMCS1_SUPPORTED_2NDEXEC to allow MBEC and EVMCS to coexist.
Presenting both EVMCS and MBEC simultaneously causes KVM to filter out
MBEC and not present it as a supported control to the guest, preventing
performance gains from MBEC when Windows HVCI is enabled.

The guest may choose not to use MBEC (e.g., if the admin does not enable
Windows HVCI / Memory Integrity), but if they use traditional nested
virt (Hyper-V, WSL2, etc.), having EVMCS exposed is important for
improving nested guest performance. IOW allowing MBEC and EVMCS to
coexist provides maximum optionality to Windows users without
overcomplicating VM administration.

Signed-off-by: Jon Kohler <jon@nutanix.com>
Message-ID: <20251223054806.1611168-8-jon@nutanix.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/vmx/hyperv_evmcs.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kvm/vmx/hyperv_evmcs.h b/arch/x86/kvm/vmx/hyperv_evmcs.h
index fc7c4e7bd1bf..bc08fe40590e 100644
--- a/arch/x86/kvm/vmx/hyperv_evmcs.h
+++ b/arch/x86/kvm/vmx/hyperv_evmcs.h
@@ -87,6 +87,7 @@
 	 SECONDARY_EXEC_PT_CONCEAL_VMX |				\
 	 SECONDARY_EXEC_BUS_LOCK_DETECTION |				\
 	 SECONDARY_EXEC_NOTIFY_VM_EXITING |				\
+	 SECONDARY_EXEC_MODE_BASED_EPT_EXEC |				\
 	 SECONDARY_EXEC_ENCLS_EXITING)
 
 #define EVMCS1_SUPPORTED_3RDEXEC (0ULL)
-- 
2.52.0


