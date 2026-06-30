Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7578731E830
	for <kvm@vger.kernel.org>; Tue, 30 Jun 2026 22:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782860199; cv=none; b=ifuWCJ4FPb/h9T0sDCsJq5SbClkqStnbZx69jSxm8SXyQL9RGUWLdKaDkVUwiNzYz0c2upDRVgPBlQ8+ON8JdlpMaw8+Au5nwGpexC3zvJzi39TNFf4fvfJxfNGii7jRoa9pwo7XiSRXqlIQl7tjmSrEoGQLLQhUvAmfb2nb1Vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782860199; c=relaxed/simple;
	bh=tkgAWenidxTobeaXVYo+mMrBXgxtirWy7FTikA/UKtM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rA3BTtxWuDQfMvOorSjhOEJHk7VwnIcfQWRoTXHUYa8kSUQQiOyesGRRHKK+mzDuOjRzYNYRNz/M90UiFx6d9aNLoYydo5L2JPr0k14HGONZ5Zm6006FgCImxH8yBs7R1C7HkMcuDjVWx4kGL6u3GETtg+3GnihVF6UkXONDPH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=E8Srj2Wh; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E8Srj2Wh"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2ca0481106cso547025ad.0
        for <kvm@vger.kernel.org>; Tue, 30 Jun 2026 15:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782860193; x=1783464993; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=rL8s0hiiR/lgasxkfz+QkDIPhc5NRPLZb5qejoLSFFI=;
        b=E8Srj2Whr+u9zfORboMvaH8Ta9QsJjUL2QgHEHzob2/urR3Yyp1CuRBGYE0OHwJYwe
         4cLIerMsUT69z0bk+V4Z+Rl749z0AJIB7ktjhs8qwls4KDc968sL/jFb6+Ft+938sb5v
         9vQV9sUVzh1se8MD4wzyKFlkhJ7ULOTdS13qn8brnCUHtm4MFWTj2QQyQmyzRiGU7Hz5
         ki8pk3SMq1Uuw8ol0+3m+2y2g9Vfbz61zkU2Qw18VISZd1OPBA5eZwg1uLLYVco9Yiib
         kab3ikMCmj0D+sdaNujtRXFBPzvB5Fh1UjSt51VeeArsdh8i3Hb1LeDDUijm/dTd9DvT
         k2CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782860193; x=1783464993;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rL8s0hiiR/lgasxkfz+QkDIPhc5NRPLZb5qejoLSFFI=;
        b=CvZrTsg/m2ocTQp5pLUHMVb/DBiTP8AISbb0kT3pG41fZj8ysVbQLn7HWE7qSCA+36
         VeiFkhjb2aYRB4rxHBdxpPILvlmwwsrocWU6mmkELCW0kHgIEnE+Csh9KtOJVKTn02As
         QTJwYLg6+75He5B3cyNPf1x49UjJNw8cI3meiw70ovNOQBaxcBWzKXbbhv20a/f+HXrI
         IphHe9T42gy3GimHrQNJBsjfMDl5zcSPOE7Mktyo6YjO2MnuAvunHrELzlEs143KymA/
         ylXPVPHTWtt42hDJJ5txtEAtRaLSfN5LHvm+gIlSL8kEctSrFdPofpasC0xgXsnFejjQ
         f8gg==
X-Gm-Message-State: AOJu0Yze2YTg2jF8kr0KJzSE25lVD9d8iU95kb+CO+A0bMgjbLTibctu
	xL6kbvNJln+x2SACrjYZyI0YOYbV1+2UlyCRbUt9IMNUVwmFcR27hv6s3eBMowkjkBTPaAUbPct
	IG0MALw==
X-Received: from plfn8.prod.google.com ([2002:a17:902:e548:b0:2c9:b419:c25])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1111:b0:2c9:97a8:aff4
 with SMTP id d9443c01a7336-2ca2ec301f4mr46392185ad.45.1782860192643; Tue, 30
 Jun 2026 15:56:32 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 30 Jun 2026 15:56:18 -0700
In-Reply-To: <20260630225619.511632-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260630225619.511632-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260630225619.511632-12-seanjc@google.com>
Subject: [PATCH v4 11/11] KVM: x86/hyperv: Use {READ,WRITE}_ONCE for
 cross-task synic->active accesses
From: Sean Christopherson <seanjc@google.com>
To: Vitaly Kuznetsov <vkuznets@redhat.com>, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, David Woodhouse <dwmw2@infradead.org>, Paul Durrant <paul@xen.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+5b32c49cd8f005e65654@syzkaller.appspotmail.com, 
	syzbot+5d2b94b77112148d1744@syzkaller.appspotmail.com, 
	David Woodhouse <dwmw@amazon.co.uk>
Content-Type: text/plain; charset="UTF-8"

When activating Hyper-V's Synthetic Interrupt Controller (SynIC), mark it
active with WRITE_ONCE() and query it using READ_ONCE() in synic_get(),
the only known cross-task reader, to document that the flag is accessed
without holding the vCPU's mutex.

Note, there are no data dependencies on the SynIC being marked active,
e.g. the vector read by synic_set_irq() is set (usually in response to
guest activity) long after the SynIC is initially activated, and a false
negative on the SynIC being active would be benign (ignoring that such a
race is likely to be problematic for the guest irrespective of what KVM
does).

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/hyperv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index f765c3bb9b1f..9d38cb644668 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -219,7 +219,7 @@ static struct kvm_vcpu_hv_synic *synic_get(struct kvm *kvm, u32 vpidx)
 		return NULL;
 
 	synic = &hv_vcpu->synic;
-	return (synic->active) ? synic : NULL;
+	return READ_ONCE(synic->active) ? synic : NULL;
 }
 
 static void kvm_hv_notify_acked_sint(struct kvm_vcpu *vcpu, u32 sint)
@@ -1013,7 +1013,7 @@ int kvm_hv_activate_synic(struct kvm_vcpu *vcpu, bool dont_zero_synic_pages)
 
 	synic = to_hv_synic(vcpu);
 
-	synic->active = true;
+	WRITE_ONCE(synic->active, true);
 	synic->dont_zero_synic_pages = dont_zero_synic_pages;
 	synic->control = HV_SYNIC_CONTROL_ENABLE;
 	return 0;
-- 
2.55.0.rc0.799.gd6f94ed593-goog

