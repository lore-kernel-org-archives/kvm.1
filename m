Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F753537F8
	for <kvm@vger.kernel.org>; Wed, 30 Sep 2026 01:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790730800; cv=none; b=cwyGjtJ+eLM4VEKkkLJbrpXwI17405GxoNbKSCWdy1HtKri1nNbjOImm1eQfKcbWOfpUSL880cPB6qyItRBUh6NTDC7ReDvDNQkd//nsOnSQR8sCRKLH35xRPrko9VrwRtGtssxSO0ShJ2YlnAP+2/s+d0Etw132CAExxnHBAeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790730800; c=relaxed/simple;
	bh=IG1RFG7JM2igBgdTr4qbALiuJCKa94wBRCLlp9vz/Yk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qWa8ExVUtuWYmGxWm4JvDe/lr43xsgEMJ+8heJiHyvBrYlTt3rjU+O7G//yanMikW7m8WtMzreeo3Ae8rWX68wJd0JfSunBdTabmIPR8c/QzoU3HHto2ZU3tB/s1Ic/9Ip9QZqZiP5PTIUhcExw+OlvFFVICPn0JzTzNWq+P77w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gXKt5LOe; arc=none smtp.client-ip=209.85.214.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gXKt5LOe"
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2db87f759c5so47826025ad.1
        for <kvm@vger.kernel.org>; Tue, 29 Sep 2026 18:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790730799; x=1791335599; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Zf6V7qVlBg/9H6Aj6n5GwJRdbCo9HKQWheBBXTou4EY=;
        b=gXKt5LOeOO0pSXN/x9+LAr73y18XH1yKpclrIC3R+e/pE2I64fsyDYtbVsRkuOhfpG
         iHzSi+sFo5ybG61EawuXHDSYIvQ7FWAO56mpzUI/6SbntqMqh5H4Ww8aQORo8ESNpaiP
         4i4fBnmesvjRIF6n3GyMmWSOFyKq2dx/lAz7DIhexO7gXwOfSQ9yL5F4xMGDcvHtwmZr
         5VMKFLQy6BPjqHeTl1yoCikYVI7xUtaIT0JURVoVIsjfnjmXdR1uOplJaMeP6hqtOnLf
         /vCG85w6KxTHlYrSWbGNVHNBAQEnVG9pL2wdSJUCXsCIjmDWeP1cBDWZEFHG/GzzjguD
         3fyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790730799; x=1791335599;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Zf6V7qVlBg/9H6Aj6n5GwJRdbCo9HKQWheBBXTou4EY=;
        b=hojePLjYvSyRGcs2D/fWyWGf8F1D6bHHfDbsOhhZkBMRolA+aJ8dX0vh7b+366YiCR
         IqsR6s1pFjCcUV8cYeu1PWsvp7fQllNwYWZ5Co3I+Bqr0spnBOdJNiU96qmrg4Kn5anX
         dLAORCd90rD9FCD/BjMJX7PWH9Wr5ro6YIEwLrJ3A1NhX66Geg3I0YQArktc80Xhm8XA
         kff5MnwTxwxKMKQ9KtAtISIrpvs8qtBgKNqX55zYyajIS3/ULujhQghV9uX3iR92kH5F
         SRDv5haMjJur32Ung1ukSbVqgdSlPtLQQkFPP0sbZO/V5sStPw4Y1oUsIW65s2+CUnUD
         6HCA==
X-Gm-Message-State: AFq9FYL6Ro0rkYeAo7kHyK4QMdwErDKgxPdp1+LOh0n6uQMsVqI16yu1
	DmCzSXAeHNhOzMnLjphw6YNPmqaJAbQNTlC7ECr3bl4zbbS8euaQi9Xy2fb9VuO9vIPw/gcU3W+
	Rbg56Tg==
X-Received: from pleb21.prod.google.com ([2002:a17:902:d415:b0:2e2:bc36:1c75])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:9cc:b0:2df:8733:f229
 with SMTP id d9443c01a7336-2e2de5030ddmr5634365ad.24.1790730798615; Tue, 29
 Sep 2026 18:13:18 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 29 Sep 2026 18:13:04 -0700
In-Reply-To: <20260930011313.3197688-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260930011313.3197688-1-seanjc@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260930011313.3197688-4-seanjc@google.com>
Subject: [PATCH v5 03/12] KVM: Return an "unsigned long", not "u64" for the
 fixed-1 DR6 bits
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosry@kernel.org>, Shivansh Dhiman <shivansh.dhiman@amd.com>, 
	Nikunj A Dadhania <nikunj@amd.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>
Content-Type: text/plain; charset="UTF-8"

Return an "unsigned long" instead of a "u64" from the helper to get the
fixed-1 DR6 bits, as debug registers are natural width registers, not
64-bit registers.

No functional change intended (the fixed-1 bits only set bits in 31:0, and
the sole caller truncates the value to an "unsigned long").

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/regs.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/regs.c b/arch/x86/kvm/regs.c
index 62075443f6b9..f74a29621661 100644
--- a/arch/x86/kvm/regs.c
+++ b/arch/x86/kvm/regs.c
@@ -772,15 +772,16 @@ void kvm_update_dr7(struct kvm_vcpu *vcpu)
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_update_dr7);
 
-static u64 kvm_get_dr6_fixed_1(struct kvm_vcpu *vcpu)
+static unsigned long kvm_get_dr6_fixed_1(struct kvm_vcpu *vcpu)
 {
-	u64 fixed = DR6_FIXED_1;
+	unsigned long fixed = DR6_FIXED_1;
 
 	if (!guest_cpu_cap_has(vcpu, X86_FEATURE_RTM))
 		fixed |= DR6_RTM;
 
 	if (!guest_cpu_cap_has(vcpu, X86_FEATURE_BUS_LOCK_DETECT))
 		fixed |= DR6_BUS_LOCK;
+
 	return fixed;
 }
 
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

