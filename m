Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3414B3BE65F
	for <kvm@vger.kernel.org>; Thu, 25 Jun 2026 22:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782426998; cv=none; b=Eu6G7VDHjvHj8oqqJPNJ1yeEMbeEODbbgL6R/oPePE08Rb4UudY5bIus3/FYKb4TKC3efHlW/MzWKEaxazgvgrxJhwnoXxiNgWtHU614MxU6CD4UJ2xlhryVZMBLhoC1Z5mHxz+K1SdHsMfLEBbtWgKZY+xvZo17gcIzwe1xCv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782426998; c=relaxed/simple;
	bh=tkgAWenidxTobeaXVYo+mMrBXgxtirWy7FTikA/UKtM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=m1fUzV6hNEnbNFVd2qUsBkaxiL6PslYLUD5GErhD7Io7/HU1qZhLxrtiYk3z5Gy2GMcKMkaxb+TfRlf3XigjvNqXOAKV2jy1gt2MYpRJLssYWq0ga7Jx6LvlSbYdORv5jbLlYIpaMhwYIhUdsfSJaf9bcWOW2pH0qcPcc5TCfSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fYLQh0Hc; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fYLQh0Hc"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-8422ca754d8so125858b3a.1
        for <kvm@vger.kernel.org>; Thu, 25 Jun 2026 15:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782426996; x=1783031796; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=rL8s0hiiR/lgasxkfz+QkDIPhc5NRPLZb5qejoLSFFI=;
        b=fYLQh0HcFp+E55JPi8S3Dp1/71wLuuLUErHF2wowyn4JhNIh+i167bVbTV8vpC9BYR
         3mRccxtA6esn8ubuj6aPIWZ4TkzhZg8UgCEupHZtI4ZC9b6XCMEqiKnfS6zEPF4G+GDx
         56sl0pGFO2kCi/wnaKu3Mrfr7YPEV5mRMkAGRGQicBjsZc/t78KVmtXREXnoTUYKF831
         AVLAStZWrBd2ZpdMQdwiF7JpmAoaJBmkZ7W9la1NRuzEtlrHWQbzLbS8sr7hhbfd9F2X
         ZbUbPGAGlaDnNlY39wlSuCIwW7Wifn8RgUiEFv31rMlz+TsX5pg35f9sSOiTu51juRnC
         n7nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782426996; x=1783031796;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rL8s0hiiR/lgasxkfz+QkDIPhc5NRPLZb5qejoLSFFI=;
        b=cp1ScoEl8ysZdEa5pQlpYKaLoLbAtcVdqPufjLQb4u4h7wVgVHTFImoUzDXfp64zpb
         EMQChPyJtOpt35e1P+rCQgwpmVMXCbE0AdSrwMKRqu0GSl51oJy+YfHXZM/2ejr9F6wU
         7c1K/Zpt4LLQc4U0OQNczL5EoXMh/LDJqfA6AKM3r64tj1dv5hTJ4PV8Zc4J23hpveTJ
         0xXQOXdOwthkeKUIcrtU1Y2/Rf5f1E3lZY3E/3iJbb62SveXUxQG8q+ANRdYrNujl93u
         WyY8kGn8laflaw3BX7lDxuZ66+imvE/nbWzXsdmz7Fl6PETAUuqzZbREQfzg/77+U3pL
         zqqw==
X-Gm-Message-State: AOJu0YyzhWp9A8d4vcpiTi7ShTBnuL3EhzkDSvbg8aDbPW/rwFBO/0QZ
	kUxnnfODXbj65XaG869xw0zuvWqMB16QLOT2iKZhKM91GYbtTH+z+qi8/Owr0rh6m84E0StRJCX
	7zm3q6A==
X-Received: from pfnd17.prod.google.com ([2002:aa7:8151:0:b0:845:b6eb:1852])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:4c10:b0:842:4b88:20ee
 with SMTP id d2e1a72fcca58-845b3b0313fmr4805272b3a.44.1782426996227; Thu, 25
 Jun 2026 15:36:36 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 25 Jun 2026 15:36:23 -0700
In-Reply-To: <20260625223623.3376478-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260625223623.3376478-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260625223623.3376478-11-seanjc@google.com>
Subject: [PATCH v3 10/10] KVM: x86/hyperv: Use {READ,WRITE}_ONCE for
 cross-task synic->active accesses
From: Sean Christopherson <seanjc@google.com>
To: Vitaly Kuznetsov <vkuznets@redhat.com>, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, David Woodhouse <dwmw2@infradead.org>, Paul Durrant <paul@xen.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+5b32c49cd8f005e65654@syzkaller.appspotmail.com, 
	syzbot+5d2b94b77112148d1744@syzkaller.appspotmail.com
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

