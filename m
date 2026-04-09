Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B9E23A5E7E
	for <kvm@vger.kernel.org>; Thu,  9 Apr 2026 23:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775778992; cv=none; b=B7mlEXOpPfIO5PDz80uFp141ZaACKY8wyGz8npYIoN753wUYnwv+bsf3Ahonbizd0uTsNjFfljesb8LsP4YUUuUb9Vzve6TV/bKqi2pCjavkBJfv83s+7wm7Cec2VdeN9ZdC11Sp0VnrYhI9Vy9Z5Fe/2Z/XRtdrnLmVxgGGVT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775778992; c=relaxed/simple;
	bh=JsiC/XjSCqKP1Cd9Q+Ix840xnWilFLBQH56lYOiVJto=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nk/rHGLGU2SxY4Vin2FumXiLSuDTWxzMeN0TwiJYfAUfNpIEUWrYlDFlHg+Kiu2XC7NVd8HGzSBGX6LpSXsYVDMsVlu3FBVIDua1SBR56apa+BMIrBNLAAj/t8qYTwseaBTg4lhe56utJ2PGXemj2Izb2Dp1sT0fPziIpz4rNYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CLfOGTzO; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CLfOGTzO"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2b249975139so31468655ad.0
        for <kvm@vger.kernel.org>; Thu, 09 Apr 2026 16:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775778990; x=1776383790; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=deDcu8n2v8p5FlCX7LhW5GUMlSsTJvruPtHOM5dkIxs=;
        b=CLfOGTzO5OnM6wR3Ka/ZjTOzGvIZWIIyGrxm1py1iWEjV2NOV5aUxOAn9W1nzGzoLv
         5f0fI557652bzo4wvhG4I5Co+J03W128+aMGCyI98t6KdD5xvR5No3P2p0h9q2sAMzLh
         3AQxM/xuFzQjVqV5NXTuGbMXKJJ/jq4/RkrZHXlD3QMIk3n7sW2i+6JZFDiCqrhwjOMe
         EQfSwgqVY+TnnSrrBG/2v5FWPG8EI5R9i47zq7HNMi2g1IY8YkkcWzHYbqPSePtVr41S
         6PYhzzygiSO4UL2M4is9aR2CzfLezfjCxGVA/6AiKP6mVZFfwjJe1S4t2WM2NAXRhjUK
         tkng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775778990; x=1776383790;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=deDcu8n2v8p5FlCX7LhW5GUMlSsTJvruPtHOM5dkIxs=;
        b=on7m2ybA5mKK738nzADXZVazi2CQYKFoU6L/3LJTDWhX06GVtGaowJ7ZekjpSX7AJ4
         G0nf7hAwaEBFm6iEccWm/ouhPantLcSzIQsmY4h463lwktNTQx+qRENG/eFcM9Q4cgm4
         dNE7E2TKyPyOX7RXEWCPi24HSRhljvzzroQ4Soa6fy6vjbRYKBSDn2I4+/e82VhuWrHN
         fksJ6qmosyjZJ2KnYSaHrSriDXgdYQXO4UgFVRPjbrnmTLP3BHogjDMmmR3C4n9kvfof
         oeN818LVrpFp6AkrNKSdPUazz8r8z8+Bd+MLzWb9dn0I2jz5sLMjtMLFP14O8sesaxbt
         SqQg==
X-Gm-Message-State: AOJu0YzmB5tfvn5hFJBUx7wGXYy94UyyYQuvkqIP9Wo/cu+ltSoJXvMF
	2qelFqPQm5T2jDKuCghNpurmxHcFuTHbnft/aPdwmXboDFoUZvJLcbayLk1tWz/VT8eeuLvStnE
	9RYQSvQ==
X-Received: from pfzz15.prod.google.com ([2002:a05:6a00:1ef:b0:82c:e899:f08d])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:548d:b0:398:8db5:4131
 with SMTP id adf61e73a8af0-39fe3c9107bmr929718637.9.1775778989753; Thu, 09
 Apr 2026 16:56:29 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu,  9 Apr 2026 16:56:12 -0700
In-Reply-To: <20260409235622.2052730-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260409235622.2052730-1-seanjc@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260409235622.2052730-2-seanjc@google.com>
Subject: [PATCH 01/11] KVM: SVM: Truncate INVLPGA address in compatibility mode
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, David Woodhouse <dwmw2@infradead.org>, Paul Durrant <paul@xen.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosry@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Check for full 64-bit mode, not just long mode, when truncating the
virtual address as part of INVLPGA emulation.  Compatibility mode doesn't
support 64-bit addressing.

Note, the FIXME still applies, e.g. if the guest deliberately targeted
EAX while in 64-bit via an address size override.  That flaw isn't worth
fixing as it would require decoding the code stream, which would open a
an entirely different can of worms, and in practice no sane guest would
shove garbage into RAX[63:32] and execute INVLPGA.

Note #2, VMSAVE, VMLOAD, and VMRUN all suffer from the same architectural
flaw of not providing the full linear address in a VMCB exit information
field, because, quoting the APM verbatim:

  the linear address is available directly from the guest rAX register

(VMSAVE, VMLOAD, and VMRUN take a physical address, but they're behavior
with respect to rAX is otherwise identical).

Fixes: bc9eff67fc35 ("KVM: SVM: Use default rAX size for INVLPGA emulation")
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/svm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index e7fdd7a9c280..a1b2e4152afe 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -2385,7 +2385,7 @@ static int invlpga_interception(struct kvm_vcpu *vcpu)
 		return 1;
 
 	/* FIXME: Handle an address size prefix. */
-	if (!is_long_mode(vcpu))
+	if (!is_64_bit_mode(vcpu))
 		gva = (u32)gva;
 
 	trace_kvm_invlpga(to_svm(vcpu)->vmcb->save.rip, asid, gva);
-- 
2.53.0.1213.gd9a14994de-goog

