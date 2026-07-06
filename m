Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 166513EDE53
	for <kvm@vger.kernel.org>; Mon,  6 Jul 2026 09:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783329670; cv=none; b=YQKquw2gCuIBu+QTk4qo228v0nG2WXAE9XfbzRWlPtzuXiwXJLC3/C9qS3jdrkgcoRPLkCqmVo4Xd8pm9SXu6HNExHNEHn9g3b2ptka8D+ri94ieCcjroY6eLrQqNLhtlVA3xyDdoqwl/OsARPp4LxJLLIiSCa11ybjOZ9e43uQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783329670; c=relaxed/simple;
	bh=KjcopUNlY+OmscekZ2OqnksC9aMwzNvbaA5DnVw0mxQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NtlCFogIkOfMX3kWoqgvlRkmbyClKZ+tHNQ2FHsRffwYBFNacJ0YPCGJFfBZgWi8764KkWRnHZ9EqhuRt5Inq667dTTEOfyQcpVGB6cvNkUNd8119Rg9Yk+JuJorL8ItvWsozSpsUr7eSVLgmwp5vfQuz/WepG3qhy9+9w83BsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QLItA1YR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QLItA1YR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783329665;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1j6A2O/BGq6jGENA1TFXaRuYm0nHbsO4IcEPGdinAng=;
	b=QLItA1YRgHvUCmsZse0Lw3EjMKhE1Ktti8sCgMGmIUSISZDoQg19eBnDoxrh9P9+w76pEF
	U2IBdeIhmufQKI1DhisLZ2HPEpOch+NNSeamRv54s8vsi2uUA6OSFAfZHAlqAy6KvgZZtm
	5gHrXlLDf6BYGb8vOlQONHyyOFw01ds=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-328-ZXnJng_rMrGYHGmHqsonuw-1; Mon,
 06 Jul 2026 05:21:01 -0400
X-MC-Unique: ZXnJng_rMrGYHGmHqsonuw-1
X-Mimecast-MFC-AGG-ID: ZXnJng_rMrGYHGmHqsonuw_1783329660
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6A7FB1955F1C;
	Mon,  6 Jul 2026 09:20:59 +0000 (UTC)
Received: from work.fritz.box (unknown [10.44.49.159])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 68662300070A;
	Mon,  6 Jul 2026 09:20:56 +0000 (UTC)
From: Tim Wiederhake <twiederh@redhat.com>
To: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Tim Wiederhake <twiederh@redhat.com>
Subject: [PATCH 3/4] KVM: x86: Reject KVM_CREATE_IRQCHIP if APIC base is already mapped
Date: Mon,  6 Jul 2026 11:20:18 +0200
Message-ID: <20260706092021.3625908-5-twiederh@redhat.com>
In-Reply-To: <20260706092021.3625908-2-twiederh@redhat.com>
References: <20260706092021.3625908-2-twiederh@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

User space must not map guest memory that covers the default APIC base
address (0xfee00000) when using an in-kernel irqchip.  Currently,
KVM_CREATE_IRQCHIP does not check for this.  The violation goes
unnoticed until vcpu creation, which fails with the misleading error
-EEXIST.

Add an explicit check to KVM_CREATE_IRQCHIP so the conflict is reported
at the point where the constraint takes effect.

Signed-off-by: Tim Wiederhake <twiederh@redhat.com>
---
 arch/x86/kvm/x86.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 0550359ed798..07f348232a72 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -7336,6 +7336,10 @@ int kvm_arch_vm_ioctl(struct file *filp, unsigned int ioctl, unsigned long arg)
 		if (kvm->created_vcpus)
 			goto create_irqchip_unlock;
 
+		r = -EEXIST;
+		if (gfn_to_memslot(kvm, gpa_to_gfn(APIC_DEFAULT_PHYS_BASE)))
+			goto create_irqchip_unlock;
+
 		r = kvm_pic_init(kvm);
 		if (r)
 			goto create_irqchip_unlock;
-- 
2.52.0

