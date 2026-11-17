Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794949777;
	b=QdcWQVpulgUWMO4CkliM5ohL+b4XksfHQKipfs4F1LSQtxlBxI7OpL18DVOKLJVHolUT
	 W/b7qlbuxIu9zUSzyirpeiMm1o+CXOrYwj65sw8WzWIByqTyqnQX1cASNFw1W6Tpqe4ag
	 Ve6qknCd2YoY4d5EX2K7dGViWyvE5FRHefxHtRDCTpd0iGsCjCDYeaeLybTjfWEJkhx0X
	 g3L80S/b7BMkxpnDD9bnekgMYIcslRov1IPgIyImFxcFqXoxSMyKcqQz8rkYXafAlSA9t
	 RgEakuIAct5cjG/fmhuD/5YPYkGjfGCRtBZnsn0Cqce9JOUSWrTpyTboDjLITPHYGRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794949777;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Reply-To:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=pl/LlodUrlcSe5NzIvaRWdb7e6O8SNguoZ2BYDTJJGU=;
	b=mxBMaM205adHKUXwjM+S5345I2ilKIX0+vdHCRpWE2XkIRLh4Ha2+9Y2BUGpIgDDjP5j
	 I2o8aDUWPZ/o3mRnkuxgQQ4pEo6Gw/2JNFEe6x/O40oalSfGfuScK2veCrbuXsMlXcVND
	 Z6mlnzz8ZESekJoltvq9fNFyPxz9mFe8jk3P+xHCyBRZKTbYPjmlZ5T7/XHe+e0Hc+sWk
	 zN4DfFa0WRGurughxtlD5omY7ey5PEOqqOS4sUY+eJ3+MHJ8m7+B6dus9B53SIsKsf8lr
	 Y2eRHLcoLo8hnC+3f8rqIIbGrpWORkHyTrsyE1q+hvKw28CH2WDcK58kfKQXDGKKlMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=RFccD00F;
	arc=none smtp.remote-ip=209.85.216.69
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ED9D606A334
	for <kvm@vger.kernel.org>; Tue, 17 Nov 2026 21:09:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7ED9D606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=RFccD00F
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3b175a69ab8so160135a91.1
        for <kvm@vger.kernel.org>; Tue, 17 Nov 2026 13:09:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794949777; x=1795554577; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=pl/LlodUrlcSe5NzIvaRWdb7e6O8SNguoZ2BYDTJJGU=;
        b=RFccD00F5BJ2TzXW3jVAv0WC0BX0YwUEAt1HbP7B33Bgk+l2s7pC6LfFhk8OI8BIPo
         jRwqnPa/BNn+0jyX9kFixNdJCp6+w9uiOjOejJMxp4I5NLpIhjlB5HRxooF1yiB6rAdE
         3W/8TF8QYrzB7nLTXTUlhRTfRj4bQDtdUU6UhHmvt2K+nJ2VWc8fLe3V3aUGaEzUpbf6
         WM2VFyP81HuaSsZd+QTTMF2XZoMe2CALpwsiLoFsobJRbrNBZobofcq1pBHF22M23luB
         L8rLbmRzpsYnXdaQWLdjnKJp8XlWbybN3C4rKKaHkNsMdo8xVt0H2gsBNyQPx+jH+51V
         YuUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794949777; x=1795554577;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pl/LlodUrlcSe5NzIvaRWdb7e6O8SNguoZ2BYDTJJGU=;
        b=J7uKPTZTKs7dd6gcvSBj2auBgNVVlQybQyYol6XrkmGUoG1rE+LBwFOTBATjP/ewDT
         neSTDLE1tXA6cQrsagvlzQkzRq9nWSxhStu8Obd1QBBLlbnyWC1/4qkvqqpJLKcRMook
         QPBWz4ke+e83HYN9llLfzbqQ15BWKnfoTzNHIb25eNX3pgym80qJh0wR5jIX/qn2m1h9
         UoMBDFus2Vk3o+Wn0yXCAN1kvFjVNjZhQaTP76zwOEgWWry4FKgtnU6QGPeYxGWIaeYN
         G+3dTlPAe1ED0cU6wowrscghhQ+KsYsX92CQlOugpbe0aOvgyq2FvXEIkyYt13QEclq4
         JYjg==
X-Gm-Message-State: APuU4Z/LQ8hK6h0BC3vil0qy1ti5MyJwwvzJMDWCfQf90wG44/6wC+jW
	XZnJqJTR9SjkDx8rF6FN1I+AYwLgEuD8z49y5TnmajXWn+V1jatDtqAm8LiThp+ACDDJmr4cyqc
	W9ckzdg==
X-Received: from pgbx27-n1.prod.google.com ([2002:a05:6a02:63db:10b0:cc7:ba91:a719])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:d88f:b0:3b3:c179:45b0
 with SMTP id 98e67ed59e1d1-3b3d07c7604mr654468a91.63.1794949776793; Tue, 17
 Nov 2026 13:09:36 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 17 Nov 2026 13:09:30 -0800
In-Reply-To: <20261117210934.7765-1-seanjc@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261117210934.7765-1-seanjc@google.com>
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
Message-ID: <20261117210934.7765-2-seanjc@google.com>
Subject: [PATCH v2 1/5] KVM: nSVM: Pre-check current (L2's) CR3 during KVM_SET_NESTED_STATE
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Stefan Teodorescu <fane@google.com>, Sashiko Bot <sashiko-bot@kernel.org>, 
	syzbot@syzkaller.appspotmail.com, Chris Mason <mason@kernel.org>
Content-Type: text/plain; charset="UTF-8"

When loading nested state, explicitly check that the current CR3 is valid
before loading any state, as a misbehaving userspace can muck with guest
CPUID to make KVM think the current CR3 is invalid, and thus cause the late
"load" of CR3 to fail when initializing the guest's MMU.  If that happens,
KVM will leave half-baked state in the vCPU, e.g. in L2 with L1's page
walker, and if nested NPT is disabled, L1's PGD as well.

Alternatively, KVM could try and unwind vCPU state if the late CR3 "load"
fails, but that is subtly quite difficult as it would require snapshotting
and restoring the previous state.  Simply leaving nested on failure isn't
an option either, because that too would leave the vCPU with half-baked
state (in L1 with L2 state and a very stale MMU).

Pre-checking CR3 will also allow hoisting the CR3 check out of
nested_svm_load_cr3() entirely.

WARN and bug the VM if the late CR3 load fails, as loading nested state
never loads PDPTRs, i.e. failure is impossible, and KVM doesn't unwind on
failure (see above).  I.e. if the impossible happens, KVM needs to block
all operations on the half-baked vCPU.

Fixes: e1779c2714c3 ("KVM: x86: nSVM: fix potential NULL derefernce on nested migration")
Cc: stable@vger.kernel.org
Reported-by: Stefan Teodorescu <fane@google.com>
Reported-by: Sashiko Bot <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/all/sashiko-outbox-210535@kernel.org
Closes: https://lore.kernel.org/all/sashiko-outbox-205939@kernel.org
Closes: https://lore.kernel.org/all/sashiko-outbox-193903@kernel.org
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/nested.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index 07554089ec05..1e3842851dae 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -2047,6 +2047,9 @@ static int svm_set_nested_state(struct kvm_vcpu *vcpu,
         if (((cr0 & X86_CR0_CD) == 0) && (cr0 & X86_CR0_NW))
 		goto out_free;
 
+	if (!kvm_vcpu_is_legal_cr3(vcpu, vcpu->arch.cr3))
+		goto out_free;
+
 	/*
 	 * Validate host state saved from before VMRUN (see
 	 * nested_svm_check_permissions). Note that the g_pat field is not
@@ -2114,7 +2117,7 @@ static int svm_set_nested_state(struct kvm_vcpu *vcpu,
 	 */
 	ret = nested_svm_load_cr3(&svm->vcpu, vcpu->arch.cr3,
 				  nested_npt_enabled(svm), false);
-	if (ret)
+	if (KVM_BUG_ON(ret, vcpu->kvm))
 		goto out_free;
 
 	svm->nested.force_msr_bitmap_recalc = true;
-- 
2.56.1.703.gf848ed807c-goog

