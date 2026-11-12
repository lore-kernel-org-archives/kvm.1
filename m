Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794442126;
	b=kuxmDDTlDwKdg2AuYopxf0+dIweq3OA3zZdbZsVvAzNOf0kW00BP0+FP2QKxdkVluI/n
	 Ibtd0gD1Jm9xvq1dCAa06iWf0irlOcRAZ3fdfIwmwJPzGhFxwO4HqHWGZBr+y7h+Gw/I1
	 AqMUgUdFiE7M0Lc5jD2C3VyEyLO6FpyU7sqMXCvYAMqluk7+1dVhVKu9yQuiA7HHhOOcg
	 L/zBGvShLF+KyVK7XteuDV0UnTT+M3QDcBbKrTUPVGGV7Na+aLPKwp6HNMtNYBUIgVv9q
	 88X75zSskPXUtWUpm+METOUKGJeAwB700b+3SmLkDJmj6gyEQzfIVxyWkOaFkXarH0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794442126;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=deHK5iaGQ16uFonBvAPJyDuQf3J5jqXGDNfUZjZLMXo=;
	b=iJOJ7VrEOErDgGrXoMY5Kq5jnV4l86otzYQQrkV/MFarb8KE3LBfWkxXrWDb11FY3g2Z
	 TFUP/uQBJZMB/cqF1GN5kzrvZ3aPKnyyjZABqSLIQC2AiUN1fhetoLWHBTDIDTWh/klvW
	 KGppvy8LayX8QBk8Abs144wrDbZlX4iNWo7tG0a+UXpdkdxnZ/9/IiAJ9z7Qsw1jDIIB0
	 HV18rUYj7WJSAIvuTqxPiYqM8J0BQ1JnLL8KCozsfc9r6XRgFE/8TAQ6PSphAVOPvqh9f
	 jlbzFDSHOcFNY7eqR3hyIDPbBcRDcX1JO8I6gsGqysfLf/AXvSpik086SZuwORqNbQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=VIdsIopc;
	arc=none smtp.remote-ip=209.85.167.198
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com [209.85.167.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB230606A321
	for <kvm@vger.kernel.org>; Thu, 12 Nov 2026 00:08:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CB230606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=VIdsIopc
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-4c55ba309c2so4560053b6e.1
        for <kvm@vger.kernel.org>; Wed, 11 Nov 2026 16:08:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794442125; x=1795046925; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=deHK5iaGQ16uFonBvAPJyDuQf3J5jqXGDNfUZjZLMXo=;
        b=VIdsIopceTRxZSn5lZP/j7PhHpzTe5M7Wj3xajq6FrRjrQhFwByIu7oyAPblgJXHmV
         jNph+KDfNbafA7m4DOZsUkJsw5V2y4t03jgGzrEBQwtCAM2hSr1muHhcCLV+lAqS/F8U
         5h1XTpIzZSxAb3/5H1W3oK2a5hGt4bUmmg8VSy0Tl8XLH9ANiMHWXrsqzrgfmisb1ks8
         VC/bH7pSc5zGnzrWSkOSio+Rase2Sd77psbglQzCrj319djV+/96y9Du36EtzIvlKbt4
         95MEorimc8ru4A6R6ypWgO9WhFEISl8OX1Sd4yNnzrYiquvmv0GHRs2831U8uDLL/PTI
         ZUfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794442125; x=1795046925;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=deHK5iaGQ16uFonBvAPJyDuQf3J5jqXGDNfUZjZLMXo=;
        b=Z9TM+jsjhlsGh0ifO71BgxmwqcDICpqVxONEADEE+RrzjqmaTkivZQ8vpc5keWXdHq
         sFFpNWda5gqZxvBoWV9qrcriYdJy2dRSPU+pk9Ls1Bo3rUw5+1Rqr9Tn7Q6iCp05kPON
         wqUkqjDTDZOTVOKbZu3VqJNJL/gMHFeMY6dOen9AdFPDGLbuqo8bEfcvJ18uRmvqmIoQ
         7ACtOz7v7lzv9YuYY8HonQapJmAyuicg86wKww/cj+qjdYoS6SHiBcWTjM4Jwm1/L99d
         j0rNhdHB2P5ITz0VDTKyQlwYb0IOnNTUVdhwC8SMQz/97tD/39iR0EEY3ARWfZOT14Xz
         ujMg==
X-Forwarded-Encrypted: i=1; AL+hErHN7uILm5/h/FaGcVUhheNsfS0eBNRP6GwlOzpzden6iPerk7kI36v+Y5PjT98jhFuYO6Y=@vger.kernel.org
X-Gm-Message-State: APuU4Z+pG70hx7UAghAsGRpM/uK9IDhKxgGXu2N91L4lP1AU+mKpR5id
	E1JbCzEI1IN/k9UKlZyJALoLJAGF1o8XiIqd4nKp00g0t71tglK1UhpgRepzcZB0zyxDjf/oXOT
	MO/aKkZcy+rvAmA==
X-Received: from ilbdw15-n1.prod.google.com ([2002:a05:6e02:410f:10b0:51a:346:d73b])
 (user=jmattson job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:c168:b0:4d6:90f4:48b7 with SMTP id 5614622812f47-56b986255cbmr3796223b6e.57.1794442124402;
 Wed, 11 Nov 2026 16:08:44 -0800 (PST)
Date: Wed, 11 Nov 2026 16:08:41 -0800
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.567.gdb80ae8cd5-goog
Message-ID: <20261112000841.3013324-1-jmattson@google.com>
Subject: [PATCH v2] KVM: nSVM: Add missing CET VMRUN consistency checks
From: Jim Mattson <jmattson@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Yosry Ahmed <yosry@kernel.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="UTF-8"

Per the APM, "Canonicalization and Consistency Checks,"

  [t]he following conditions are considered illegal state combinations:

   - CR4.CET=1 when CR0.WP=0
   - Any reserved bit set in S_CET
   - CR4.CET=1 and U_CET.SS=1 when EFLAGS.VM=1

Check these conditions in software before trying to VMRUN vmcb02, so that
the illegal states result in a #VMEXIT to L1 rather than an exit to
userspace with KVM_EXIT_FAIL_ENTRY.

Fixes: c5ba49458513 ("KVM: nSVM: Save/load CET Shadow Stack state to/from vmcb12/vmcb02")
Signed-off-by: Jim Mattson <jmattson@google.com>
---
v1 -> v2:
 - Warn and fail VMRUN if reading MSR_IA32_U_CET fails [Yosry]

v1: https://lore.kernel.org/all/20261110004037.125692-1-jmattson@google.com/

 arch/x86/kvm/svm/nested.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index af0ef678433d..6298160458bc 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -469,6 +469,21 @@ static bool nested_vmcb_check_save(struct kvm_vcpu *vcpu,
 	if (CC(!__kvm_is_valid_cr4(vcpu, save->cr4)))
 		return false;
 
+	if (CC((save->cr4 & X86_CR4_CET) && !(save->cr0 & X86_CR0_WP)))
+		return false;
+
+	if (guest_cpu_cap_has(vcpu, X86_FEATURE_SHSTK) &&
+	    CC(!kvm_is_valid_u_s_cet(vcpu, save->s_cet)))
+		return false;
+
+	if ((save->cr4 & X86_CR4_CET) && (save->rflags & X86_EFLAGS_VM)) {
+		u64 u_cet = 0;
+
+		if (WARN_ON_ONCE(__kvm_emulate_msr_read(vcpu, MSR_IA32_U_CET, &u_cet)) ||
+		    CC(u_cet & CET_SHSTK_EN))
+			return false;
+	}
+
 	if (CC(!kvm_valid_efer(vcpu, save->efer)))
 		return false;
 
-- 
2.56.0.567.gdb80ae8cd5-goog

