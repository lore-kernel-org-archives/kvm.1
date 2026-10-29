Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793305711;
	b=r85A/kiJ06eBxd11NLpXqyLd1Gk5oeFEwNW7oP8VYOhjpoHnvAftzrBw1iKCshPoEnjm
	 WhehgCyVYEe/1TXtuA2wv4UJDacLMAHSVkqnhVzBZsp7HVclDLDnBhbgQN+FpQiWm+/yf
	 vcIY/NzE6gRyZCMdDi6X0ywP071UrFgO8jqpWLaTGt6LJ3DG8hGTbc/ip1NFV/jmjh7KD
	 2TdJr00/F0OvX22NzgcDuLdRHbHw10GXRLL4OJfExPaRV9VThpHr3/Ojsc9SDHUIVSisN
	 mVtujuIAxqBU7ANC7sVKM2rPd68sKnVC4ruNtZznPc6Rgz2Qt4HqbObpP8fpEhUEf3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793305711;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=6O2eAJSUXZ4itbfWSmtZjRk1vi0Y9zhxx9kPbocHe2s=;
	b=rnhfxl4tX45lUF239RUlqB4xB9EcmZoITWWSQHxvSWYGsqunqpdWrSUKCmU0+11pxdN/
	 2pUcS8WvVzQRkjblhy/vwAg3ihMmJTKybDXKh+uUdA2qfN+Uz0jIz123TT+0KdAd/O/m8
	 NEQ+/aZ8X/GaIASGabF0qRMHAjg0kpsWIMg4yehzKOGwQY3lBmYx1mSNuH1uYsj+xoRQL
	 HXhPvEgBRBAOF/U1G5/A5dujhPB4ezzXtt6aW/7h3Qc2p56FaCYAKqinNBq2vHH5YeyKK
	 Yc91SfzJM7f/jDH5NeoLLLu0y6FlReesZpxUEvXFZY5KsRGVj8hLOoS3wRXBeYr7ahQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=JQsIYhm9;
	arc=none smtp.remote-ip=209.85.216.70
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96FCF606A31A
	for <kvm@vger.kernel.org>; Thu, 29 Oct 2026 20:28:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 96FCF606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=JQsIYhm9
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3ab2cb8d5dbso6366a91.1
        for <kvm@vger.kernel.org>; Thu, 29 Oct 2026 13:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793305710; x=1793910510; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6O2eAJSUXZ4itbfWSmtZjRk1vi0Y9zhxx9kPbocHe2s=;
        b=JQsIYhm9nNhmPFm3tJTbecq1sCv4VIao66kAnI89b7oKMxSQGh2O9ZDmAgaStEkKF5
         OzKm3V8EQ1/DuiMFY6XgTdRkTmg9VefYEi2c2CEMW3sCNZ+ehoVV1BBq6w3sGmClJx6z
         AAIdpB1TyuZYEjrKGaR1jg9wMAa903CEjhrhXfvo9J34NT72TIOKzKAiM1FvqfqysD5l
         /IlnWcrAH83UnHxinZ0jSyLK5aLq++Whx+ios1uCTMgXNTvwLqPi2UP2iBwXwRh6QQeL
         IvHNDNdZenB3Q+ghKGWy2y3V7j4cLYC8gDIaMeYu/QhrCcNv2urkxgzOkteBql/JNEGW
         Z0xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793305710; x=1793910510;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6O2eAJSUXZ4itbfWSmtZjRk1vi0Y9zhxx9kPbocHe2s=;
        b=V6BPQHAP/A0fClf5//5MC0TlCcoDvwAswNYYMWbnSd+TyyulkdVeK/qxrzNJih7XSq
         OCbLLwLLUL8Seq/GDFR+sr2TkfYaTt3059Jg11J2OgKt2IsHpEuBm6pGfzSbK6CKWPLN
         eUIbX1unPNIUb6vLHmqDol96QvNI8SOeyAPgLwLl+T9xIAo5Rz9VSEjrkK8S6Ktuvrse
         lagistI27LluaOzQ2usZcXsjIPE1NHvZR7k26LWaGec6B/ySMeGjsBS5lLptJqMRtaDW
         Cq/cq0nMWa1MwiL1l2pHrLgVIC9mNotlKdxmqlMrICkBLoQ6wfAwqy2ZVgsFD02FbMHS
         /t/Q==
X-Forwarded-Encrypted: i=1; AKwUvBxRMZCGFxglBpdm/2d4eEgrsMsvi9zgXPKX+RXFcFoCHK6nC+1H2tjdgWlODotZVJ5Q/WA=@vger.kernel.org
X-Gm-Message-State: AFq9FYKdj+FfnsMJg5g11yAWngOmbULFQsw2e6wJTXs8NcNhUV/W5heY
	kC4K+3/s3w9i2nZdmhORF8da/PTvxV8FONT7wxz7rt/ZZNKP0mjDlAL9B7a7ecVJzYkmEGyffgM
	TYLR4qkTo+HGiag==
X-Received: from pjblt21.prod.google.com ([2002:a17:90b:3555:b0:3a8:74c5:5a5c])
 (user=jmattson job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:17c1:b0:3ac:7556:8ed9 with SMTP id 98e67ed59e1d1-3ae8970e52fmr76939a91.10.1793305709732;
 Thu, 29 Oct 2026 13:28:29 -0700 (PDT)
Date: Thu, 29 Oct 2026 13:28:14 -0700
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.317.g454f8302e1-goog
Message-ID: <20261029202817.901145-1-jmattson@google.com>
Subject: [PATCH 1/3] KVM: SVM: Check EFER.SVME before updating MSR_VM_CR on
 guest writes
From: Jim Mattson <jmattson@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Shuah Khan <shuah@kernel.org>, kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Yosry Ahmed <yosry@kernel.org>, 
	Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="UTF-8"

Per the AMD APM, setting VM_CR.SVMDIS while EFER.SVME is set raises a #GP.

In svm_set_vm_cr(), check whether EFER.SVME is set and the value being
written sets SVMDIS *before* modifying svm->nested.vm_cr_msr. (Host-
initiated writes are allowed to set any valid MSR_VM_CR bits.)

Fixes: 4a810181c8bc ("KVM: SVM: Implement emulation of vm_cr msr")
Signed-off-by: Jim Mattson <jmattson@google.com>
---
 arch/x86/kvm/svm/svm.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 136069dfcd44..3a0a507c94b2 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -3015,14 +3015,24 @@ static int svm_complete_emulated_msr(struct kvm_vcpu *vcpu, int err)
 	return 1;
 }
 
-static int svm_set_vm_cr(struct kvm_vcpu *vcpu, u64 data)
+static int svm_set_vm_cr(struct kvm_vcpu *vcpu, struct msr_data *msr)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
-	int svm_dis, chg_mask;
+	u64 data = msr->data;
+	int chg_mask;
 
 	if (data & ~SVM_VM_CR_VALID_MASK)
 		return 1;
 
+	if (msr->host_initiated) {
+		svm->nested.vm_cr_msr = data;
+		return 0;
+	}
+
+	/* check for svm_disable while efer.svme is set */
+	if ((data & SVM_VM_CR_SVM_DIS_MASK) && (vcpu->arch.efer & EFER_SVME))
+		return 1;
+
 	chg_mask = SVM_VM_CR_VALID_MASK;
 
 	if (svm->nested.vm_cr_msr & SVM_VM_CR_SVM_DIS_MASK)
@@ -3031,12 +3041,6 @@ static int svm_set_vm_cr(struct kvm_vcpu *vcpu, u64 data)
 	svm->nested.vm_cr_msr &= ~chg_mask;
 	svm->nested.vm_cr_msr |= (data & chg_mask);
 
-	svm_dis = svm->nested.vm_cr_msr & SVM_VM_CR_SVM_DIS_MASK;
-
-	/* check for svm_disable while efer.svme is set */
-	if (svm_dis && (vcpu->arch.efer & EFER_SVME))
-		return 1;
-
 	return 0;
 }
 
@@ -3262,7 +3266,7 @@ static int svm_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr)
 		svm->nested.hsave_msr = data & PAGE_MASK;
 		break;
 	case MSR_VM_CR:
-		return svm_set_vm_cr(vcpu, data);
+		return svm_set_vm_cr(vcpu, msr);
 	case MSR_VM_IGNNE:
 		kvm_pr_unimpl_wrmsr(vcpu, ecx, data);
 		break;
-- 
2.56.0.317.g454f8302e1-goog

