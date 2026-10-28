Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793194025;
	b=4VM6tCkzaIwtBVQPONm8WBB1M4mRAyflr+9cxBTvZvs+buhR9d0DXbkI+ovNTpbBeuaG
	 32Qa+bcAulDqXFMW1QtzK7gRuJS8KUdfFLfwxEA7AazhzjRDS+sWIKLr31x6mFc1vvMiH
	 3cp82qDK2bavd/2lxCLGNG5eM/wNbtCq5bD2iDDeljZdLpm7dWXlwpqIuG770pEPb4ShF
	 Ddc29nYtr0IpVrXCkd12RHbv8YQwOx7q3fBI8AOhtFpRCcqREo9NXipeqXiZlhOZsuXuD
	 L1oan6Rc0tfx2abtfRiOILFz6xGDmE4ojN+5jaYhvS7zdCQzJY5oCH8e/A2xijWbsXg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793194025;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=EleQ4DuQvqyeRIQHJ+IbAvoBHmxUKc+6S8HOtpfcYzg=;
	b=o7gP4+FpY65/+0mUgAh7eHrnwdiB63zbuiKS5UQ1z8zb9OHFFhTzFe43reViny4tOdPU
	 Fadj01Y5+CpCdkx7VgqYMmzX6VdLlHW2AGk71ga9rQIVgft+MdU/kCstBHQwkljzUynJU
	 F4ioGUUC/Tg6j3VGkenNUq/7fptM1oExkJuE65Gii4N0AaefdS+mM0ybMJ9aeNbV6BEhF
	 tMi8u4xcbtzmwKrYXrBXbYl+R3V3anOuaVH7ix4j4dtMsZ3vy23YYWkGv9nWwcBlmLJ7q
	 fq/9y9hmnVE/RnXVrBU55MGpgh72PvIpEu6EfVjHJW9XkrDbGQfbNB1WOA1U1lJsuqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=paYgznU+;
	arc=none smtp.remote-ip=209.85.216.71
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E67606A32E
	for <kvm@vger.kernel.org>; Wed, 28 Oct 2026 13:27:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 13E67606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=paYgznU+
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3adf71ee6a5so1340733a91.2
        for <kvm@vger.kernel.org>; Wed, 28 Oct 2026 06:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793194024; x=1793798824; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=EleQ4DuQvqyeRIQHJ+IbAvoBHmxUKc+6S8HOtpfcYzg=;
        b=paYgznU+zD8wUb5jfI0oqMlHcNPxhid+Cw1jqHcm23xn2ap3D6Ni2JbLxC96GLWBDl
         bo1qK2t2R1yRq3MVl19Om49xrGO0mlN3G6PlFFJ9Etz5MfymCIW43YkzSLlvoOTogcvf
         8TS5xORBFwSrIU+/FWK386IQopn6Q0oyT+O5PtO3/jCG27FIosfsKG4RNBlMjcgUiV42
         cd/ULCJ2sY8xOkBr1au6LfMjMvszfbjQnHu24+IAxrnkiGt8p2N0AjZaQmgyeuvtD6St
         y6gwewT/6qZIr3uo3VSBXFJKuJ02/gyFj1KaXnpHIKae8k7OlRiy0diaqP34n9oufmFI
         jFFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793194024; x=1793798824;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EleQ4DuQvqyeRIQHJ+IbAvoBHmxUKc+6S8HOtpfcYzg=;
        b=dTTCxvS8uBW3YrFoRW7fsKWQebloCZ8+b7OpWa5kuUnvyKr6HqlPfIcRRwF3AcqjOs
         eACXXqiwVpnpMNz91TIYaBxFBN52nStenGIcF/yOoSvytVtgpMuCFVx8TDrlWzt96piE
         /yzq3d3OeJBOVuaHJoxaIWNXPFW00kfYECK0rXTZFNuuDgFGjE1/sDDOfSJpgTFvA0No
         ogIZQkONE55/wfOiS4mv9c+kLPg/1zxHWWtUmJgKLX9/nn0Ix/yWwKpfpemYK7jJp9F3
         Xf1YzCGnPtZ46UNOk9o3rb1njTKoSkqI0viagv8HSwGqmz9uFDMg7XJdrA8O20NWBXF7
         0xNQ==
X-Forwarded-Encrypted: i=1; AKwUvBwM7eRkScdPr2gHYdvKkmTWeWHahMxeDsboVuLvyEBmhAeRMg0CSGc07J8Hr6IYZSiI21s=@vger.kernel.org
X-Gm-Message-State: AFq9FYKl1+gwkiEgWODDzWbHSmaFQ9N8j1Veu+2KY7TfH6RiS3OaTxJ8
	9FGmCVMDBZHHr9DHXKY4OCkfOPhaWPPv7jatxrKPyIIsixE+L5g6gc9SeFP5S+dHjrY6zqifX1R
	Nx7qyuHZTneb8Fw==
X-Received: from plte1.prod.google.com ([2002:a17:902:7441:b0:2e2:f305:e980])
 (user=jmattson job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:32c4:b0:2e9:658f:c33d with SMTP id d9443c01a7336-2eb00085db7mr24881635ad.4.1793194024058;
 Wed, 28 Oct 2026 06:27:04 -0700 (PDT)
Date: Wed, 28 Oct 2026 06:26:52 -0700
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.307.g5fe7bd680c-goog
Message-ID: <20261028132657.1416783-1-jmattson@google.com>
Subject: [PATCH 1/2] KVM: nSVM: Set NMI_VECTOR in synthesized NMI exit_int_info
From: Jim Mattson <jmattson@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Jim Mattson <jmattson@google.com>, Yosry Ahmed <yosry@kernel.org>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Include NMI_VECTOR (2) in the vector field when synthesizing exit_int_info
for a pending injected NMI in nested_save_pending_event_to_vmcb12(),
matching nested VMX's idt_vectoring_info_field synthesis and the APM.

Per AMD's APM (Vol. 2, "Intercepts During IDT Interrupt Delivery", Figure
"EXITINTINFO" and Table "Guest Exception or Interrupt Types", and "Event
Injection"), bits 7:0 of EXITINTINFO hold the 8-bit IDT vector of the
interrupt or exception, and injected events are recorded in EXITINTINFO as
though they had occurred normally in the guest.  Although hardware ignores
EVENTINJ.VECTOR on VMRUN when TYPE is NMI, EXITINTINFO records vector 2
(#NMI) if a #VMEXIT occurs during NMI delivery.

Commit 36e2e98363e6 ("KVM: nSVM: synthesize correct EXITINTINFO on vmexit")
replaced the raw copy of vmcb02->control.exit_int_info (where hardware
populates vector 2) with nested_vmcb_save_pending_event(), now
nested_save_pending_event_to_vmcb12(), which sets only SVM_EVTINJ_VALID |
SVM_EVTINJ_TYPE_NMI and leaves the vector field as 0.  As a result, L1
hypervisors that check EXITINTINFO.VECTOR == 2 for NMIs (e.g. FreeBSD's
bhyve) or inspect the vector field of exit_int_info observe an invalid
vector 0 on nested #VMEXIT.

Fixes: 36e2e98363e6 ("KVM: nSVM: synthesize correct EXITINTINFO on vmexit")
Signed-off-by: Jim Mattson <jmattson@google.com>
---
 arch/x86/kvm/svm/nested.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index af0ef678433d..9b62113f0cf6 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -673,7 +673,7 @@ static void nested_save_pending_event_to_vmcb12(struct vcpu_svm *svm,
 		}
 
 	} else if (vcpu->arch.nmi_injected) {
-		exit_int_info = SVM_EVTINJ_VALID | SVM_EVTINJ_TYPE_NMI;
+		exit_int_info = SVM_EVTINJ_VALID | SVM_EVTINJ_TYPE_NMI | NMI_VECTOR;
 
 	} else if (vcpu->arch.interrupt.injected) {
 		nr = vcpu->arch.interrupt.nr;

base-commit: dea4f6380f4ec96e8f3b0aaf2343764bd0d25ef4
-- 
2.56.0.307.g5fe7bd680c-goog

