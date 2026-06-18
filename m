Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A724F4192F5
	for <kvm@vger.kernel.org>; Thu, 18 Jun 2026 18:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781808833; cv=none; b=bdztzcsJcANHXcW/Egvz3t4bttpEAXq5lQU/1Cu89CnjSiKqe6d4EQp2mAGpmXj2pyg4+2FXIs2IHutgt7TD38AbU++RzxqUK7pcJC78wDDalurze4xgghZWxiAveLS6spmczBKKwmQnVBMLZTZFuvpActVyMGZS9u5WyQ/9T9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781808833; c=relaxed/simple;
	bh=ybD9jZBXCqB4UsvTDfL84tsRbZKiP6NIMn8m6YurzhY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=baLweoxBh+gTl9pnIDBBKDzn0cIH2DOdh/qi1xqmpH7e8Vbz7Xvk04nBr7/37qP5k/YmrlmjUhJWRd6aIvQ/qhW2TpchvNLaXjnfeERvaH3vfwONpBWKeP18DPWSfm81ubeU308MCwxIHCUl093c1dcaOIjYanhStvAiGUXeDjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pY5qefCL; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pY5qefCL"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-8428384f31fso874853b3a.3
        for <kvm@vger.kernel.org>; Thu, 18 Jun 2026 11:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781808832; x=1782413632; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EV2jRPRYUe5DqipArutJ7o09RVfE+m4fdZaghLzNKlY=;
        b=pY5qefCLa/fen6rUBOYFAAKK8jlErvxvgUxcxhIPGdqkqx+s9NbIKM580LzMysg5xc
         lCRH1iMhrQ+tLMYnBTE/SziDBUSZp7wIg62KHpYfOkqOzsS7JnBW8AJcpa+f0E6dR6e8
         Kh9LdfwkMwBv5RQI4Bvs/PkplUpykbRLVHD9hRGp3p0ketwXLRVz5Cv70lwM1V+d7YK0
         Q8whUA6MQLs2ikZPjjY9xeWwFTCGsMkjPkqLqA8Cjb4lb+APfmC0u+FE5MkgPYbW7hPI
         CqZ4t5vTaXIVnp+82oxoV/X7YGTushApXpuQWdrLgVNDlJ39VJf0S+GoBAmoEnIU8fht
         Qy4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781808832; x=1782413632;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EV2jRPRYUe5DqipArutJ7o09RVfE+m4fdZaghLzNKlY=;
        b=smikivaV5PseFSS6uoLSFQNN7Oh1FMZDMfNgKdkFXdyrTgHgUU9uOlFXmSmwcHNmqb
         WkCF6NlyVYb8BfCdyvQ8J7JQKJTADU89WHnTGbGbRKzZgavvSswL7nox7si55dLbGivH
         dgU959Aq47kG1Xv6tEHMOuZiPBSiKFbA8ds4PhmKct1XO6TB3jzYY4unMs8jNOx2QFdB
         aXw6yA4oJ+vVsMpG6BtE1mo4it/Te11nmJ45K7v/q+aICWQtTbkO42MmVx+62l6KV3zc
         xE05+gLWjI++f8hmKmKBXoUactf6VGpI4nERp2uvLQ3jLhFZan4BVYGq7oSVJijdH1bG
         XIng==
X-Gm-Message-State: AOJu0YwDfg7uOeoJQVuWlLASuxSTyGKDMlZ0v9Jn5MTs1bmsTISowc/n
	FmdJcxqkU/zYO6YQu1+sGH3NVGnWEkfhaITrc5QL90O1BxEv28SVf5EoCMVe7ubt1G5ofZZGbII
	78gdI2A==
X-Received: from pfbfm11.prod.google.com ([2002:a05:6a00:2f8b:b0:83e:b5cc:11c3])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1707:b0:838:29b3:9ed1
 with SMTP id d2e1a72fcca58-84550900333mr136338b3a.41.1781808831693; Thu, 18
 Jun 2026 11:53:51 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 18 Jun 2026 11:53:50 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.rc0.738.g0c8ab3ebcc-goog
Message-ID: <20260618185350.2020845-1-seanjc@google.com>
Subject: [PATCH] KVM: x86: Bug the VM, not the kernel, if the ISR count {under,over}flows
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Bug the VM, not the host kernel, if KVM's ISR count {under,over}flows when
tracking in-flight ISRs.  There is zero danger to the host if KVM messes up
its IRQ tracking.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/lapic.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index 9d2df8623f6d..e733ca6b9792 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -767,7 +767,7 @@ static inline void apic_set_isr(int vec, struct kvm_lapic *apic)
 		kvm_x86_call(hwapic_isr_update)(apic->vcpu, vec);
 	else {
 		++apic->isr_count;
-		BUG_ON(apic->isr_count > MAX_APIC_VECTOR);
+		KVM_BUG_ON(apic->isr_count > MAX_APIC_VECTOR, apic->vcpu->kvm);
 		/*
 		 * ISR (in service register) bit is set when injecting an interrupt.
 		 * The highest vector is injected. Thus the latest bit set matches
@@ -808,7 +808,7 @@ static inline void apic_clear_isr(int vec, struct kvm_lapic *apic)
 		kvm_x86_call(hwapic_isr_update)(apic->vcpu, apic_find_highest_isr(apic));
 	else {
 		--apic->isr_count;
-		BUG_ON(apic->isr_count < 0);
+		KVM_BUG_ON(apic->isr_count < 0, apic->vcpu->kvm);
 		apic->highest_isr_cache = -1;
 	}
 }

base-commit: 9d4853b044beefa21c4ee3e18c40653601a64ced
-- 
2.55.0.rc0.738.g0c8ab3ebcc-goog

