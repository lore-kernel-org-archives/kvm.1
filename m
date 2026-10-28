Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793194026;
	b=KWTsfngxcrSfSNKMnrfVLTXrhvG5BmmVKmVJwhoJXpgdCa7+9J6cpFs7Tc7UTD/2bVEF
	 lMyttKfZ6HK1VlK02ubuaK4TyXfXaYBi6a539psQX6Bv6nbPDeihFiCLjruEXcM/HYaxa
	 yG3oniYjkepU/+8se3K7JOptjf6MtdMk1kIhf4dK6eygdN/EH3U2EVfBKCVd9N1YZrTBk
	 6lrsZmJmwDV6gu2RqrG0PBMzfdGNg8zoAlBL8ebSv+EO1oYI7g4wMnpu7JTD935FNp89b
	 hYy47hT3RxiNv7pCBlUYorbjPcbmfNYo8/zQHBK+qyI4vyNo9BNlXDhQP8+fTYu+50A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793194026;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=tf7OmJ6aFCP7UVyB60ZS3JuIzhVsrK4m0LoABXWpn+s=;
	b=QQIcbPpvR7zmoTInEDLeQdletUEfRnxJwcqOaKaf6j4uXdAGISiqHSNac2Hf+o2L3/Xv
	 J2KYhYRZ5+h0P1lRLifDANCTwCzCRjY8Ky9QaYRk1taURVLJp5jO0wqp5IV5O8sNsqaND
	 LYchKsXt1desu2pCqERoKvzeY8ZtR99s8h5qwdepb48lPFoU7IT1eolyjy1MGKvZw6yvQ
	 HMjAy4V6unWxreZ3s4B8C1h7yzSrV0vVQopnhXncurQCyVJqm41lkA9PAvGcnIAPEOs6L
	 /Uj36vCa+Zim2edFWbw8ofC+NtmPETvd8WqKCP+wl1DYF0QCib8SJYo//GqKE5ATuFA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=k4DHAWk9;
	arc=none smtp.remote-ip=209.85.210.197
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB0260A2609
	for <kvm@vger.kernel.org>; Wed, 28 Oct 2026 13:27:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2EB0260A2609
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=k4DHAWk9
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-8a0688a43d3so807833b3a.0
        for <kvm@vger.kernel.org>; Wed, 28 Oct 2026 06:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793194025; x=1793798825; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tf7OmJ6aFCP7UVyB60ZS3JuIzhVsrK4m0LoABXWpn+s=;
        b=k4DHAWk9rRyub8viRoyNE9VSCSdkCB4ff4ukkRKe4H5HSWa5/qjQVOAN9iJdQT+ay5
         +4YlXlNRC8uBxHAj22ar9dlt8Hbbe7Aqicyg78J5WblqaQlqyr8LZ8sLHaaNQ4Tk4kWc
         44SG2L86XEI6OhfiP0zupGDtzsLFdhmhUuAs7s+eOkWCK5B7aoG6HB5fMjZhtidHCwka
         4nvlmMgXsiSfOeCYeJrMJnbs0cVcJMMmUVdclQu9RfsY95gldO/N77oHn94yrDcn1rzj
         YdmkWvlADrWo9FTYZcbSMc3JN4cWiXcRbFavwL40Kue3c93j3/oTf1hGoig2sWEeNDF2
         MzjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793194025; x=1793798825;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tf7OmJ6aFCP7UVyB60ZS3JuIzhVsrK4m0LoABXWpn+s=;
        b=BFaGXQvczt9bfVfGD2Pcm63V9zkB+BSQF1DEN8qOA2vBY428fng+5M8j/bdh5x6CZx
         /pV4yxoisZtTUXHDbhMSRwPvN1Uy6aKkPsXBA1qn5lVxFt35e6pKkJi5vlvoZLiTGIIb
         HNu4jTTUPAoYt7QjvWqYwrR0yyyXkOoEWFeEzvKZwyUoOtuTWdbc7BSBqiZmvmfYPfkj
         HtQz1ZQO/today5F6g+I0B1fHLUNMP4S8zVOzF7NAnVgjw1jtc2/kt+cichgfKtSKqhL
         pNtn/DOgEGJzZz7JGkPgCu57CNdCxCPN1krk9kxZdrjVl/7TlGHxmcl3BkJyB8rrhk9d
         iQhA==
X-Forwarded-Encrypted: i=1; AKwUvBznjKQvpYM7scOSBSlGWQnSO72xRuynqQK6X6HHgVb+oy0nIcf2FzxBhK+VjgpP4XwFCXo=@vger.kernel.org
X-Gm-Message-State: AFq9FYI3ZNu9/7QvhN0JWPdJfMWf0LFUwE2NGtBFWE0jKDqY4fwgJT+U
	I0FikDsGyPdlrMHCnue7/xMK2yWmq6dp8XMfny0o+8rnRLzUBoTpzcrJ+wPt9hHUAxy1qZPnDCY
	4v6+hCW9jmX+YTw==
X-Received: from pfbbd40.prod.google.com ([2002:a05:6a00:27a8:b0:8a7:b2ee:e219])
 (user=jmattson job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:9e48:b0:3dd:a195:dd55 with SMTP id adf61e73a8af0-3e9023e52c4mr2092511637.55.1793194025273;
 Wed, 28 Oct 2026 06:27:05 -0700 (PDT)
Date: Wed, 28 Oct 2026 06:26:53 -0700
In-Reply-To: <20261028132657.1416783-1-jmattson@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261028132657.1416783-1-jmattson@google.com>
X-Mailer: git-send-email 2.56.0.307.g5fe7bd680c-goog
Message-ID: <20261028132657.1416783-2-jmattson@google.com>
Subject: [PATCH 2/2] KVM: SVM: Set NMI_VECTOR in event_inj in svm_inject_nmi()
From: Jim Mattson <jmattson@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Jim Mattson <jmattson@google.com>, Yosry Ahmed <yosry@kernel.org>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Include NMI_VECTOR (2) in svm->vmcb->control.event_inj when injecting an
NMI in svm_inject_nmi(), matching vmx_inject_nmi().

Although hardware ignores EVENTINJ.VECTOR on VMRUN when TYPE is NMI (APM
Vol. 2, "Event Injection"), omitting NMI_VECTOR causes
svm_get_entry_info() to report vector 0 instead of 2 to the kvm_entry
tracepoint, and causes svm_cancel_injection() to copy an exit_int_info
value with vector 0 into the active VMCB.

Fixes: 95ba82731374 ("KVM: SVM: Add NMI injection support")
Signed-off-by: Jim Mattson <jmattson@google.com>
---
 arch/x86/kvm/svm/svm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 136069dfcd44..41e85702b380 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -3914,7 +3914,7 @@ static void svm_inject_nmi(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
 
-	svm->vmcb->control.event_inj = SVM_EVTINJ_VALID | SVM_EVTINJ_TYPE_NMI;
+	svm->vmcb->control.event_inj = SVM_EVTINJ_VALID | SVM_EVTINJ_TYPE_NMI | NMI_VECTOR;
 
 	if (svm->nmi_l1_to_l2)
 		return;
-- 
2.56.0.307.g5fe7bd680c-goog

