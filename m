Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793139151;
	b=d8OKhd58X61RQqw04DCl5OIqsr40pmQOhIGQ/K1jS5BbW2Cdx37i0jJeIidMSIyKU/ST
	 9L0qYiJSZRPHt5lB33SiBGugeaJXqg/3DwlAa+lXZTXdhbWbh7kmwscnUNtAqRcPCpPzT
	 kNy+4YzRWkE+fuc38K+wF4NOM3JYvNodCCLTr5rNYzo4fzG88ufjildm37+pxztKBaBKy
	 otJGZIygJbqRqI05pComwCKAehMRw9iemc8mw3/VrazsjaQANipvnI+4a5kKT2NL48qTK
	 HiIuYTGBd8QIyKtPIN5CFfZzS8OChN/5pAW+MPhmcvqj9POTH5VI2/uLzfUR6p7wkVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793139151;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Reply-To:Date:
	 In-Reply-To:Mime-Version:References:X-Mailer:Message-ID:Subject:From:
	 To:Cc:Content-Type;
	bh=LqllTjpYQ11cpzSrufXwFEGHtiXKk3/xQbrtXOylGNw=;
	b=MkmwLAl7JM3oeFi77rcvJzKETCCy2/TDJtfLOzo9sBH1ZRlrgyNn23fc0Yi/6NvMFXZc
	 96cJ88e1QhI22ndUNe4G4o2AMwQU18EjpnD8gkvoFMEmAXjrU3xSt0kxBDeNgT9/6gfiw
	 O7nWmanGEnBdDaMvpKbuxFYiKQHlonieDGAjpH+oy10REMbJaICKA+aRGNxT4zBfl5uFK
	 BPbDSE6wgGgKKZuzdqpH1bm0Oz3VBjgjw3LGg8p8pmhQG52AaVKmiK+bPDM8O2EcrxpEn
	 gMZhM9kifiESHd9buXT8oSoR01Q6YuWHT42M4gOpwQZnHwFaIc9HXA0HZWHbiVW2uSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=d19UgqAD;
	arc=none smtp.remote-ip=209.85.214.197
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 514DB60A262C
	for <kvm@vger.kernel.org>; Tue, 27 Oct 2026 22:12:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 514DB60A262C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=d19UgqAD
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2e9501034c4so4515355ad.0
        for <kvm@vger.kernel.org>; Tue, 27 Oct 2026 15:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793139151; x=1793743951; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=LqllTjpYQ11cpzSrufXwFEGHtiXKk3/xQbrtXOylGNw=;
        b=d19UgqADgC6U2cESx5MzU+hCmxDBdWJ3uEjVLoJGeG2L15dxk1qNRLy2px6bnFxpKI
         RKlBo4+tlFlKaensG5eSh9wHStNUDypfAmxIfSHiZDJrIo5Q3ACfnhGtYKRFomD9cXVE
         Z4vUHw/pkzlBxL0YCG67aFuiDUoAE5nDJZPh+AL/EM0k4A4PfeHhu6hlm5vAFT4DW1tZ
         CiCkT5cAPeDLeEtJP13/XIw2UrWkpjQbk5/yBdKPzDAzcEGWgTGJkAkDqyeZyoSrOYEv
         bTNFx1fO9j+fn9y8RALukhSIZX7ToRb3llkEZs2/lwsl8n8ffTCy1VwswwQFhn5zcJYa
         d8xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793139151; x=1793743951;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LqllTjpYQ11cpzSrufXwFEGHtiXKk3/xQbrtXOylGNw=;
        b=0HgaMZOlHMJjMXso37DhGCT7GPc3GWSVBEhie0Gw6zzzQqyINxnvBiwcGGdMHJjMzJ
         9y1lLYpzLdUd9lve+Lyxw7Hw9TuuFa3BhdLMtzw+6/ZqJSf5pT+dTXdEJGbMZaYIKEKe
         jOzNxJRfYuksa3f1Ja43vnVTdLRTsnNJ4X3astcMxSl+UAXv6whqR7fNhwnhTo0iLo1K
         XF5efVmO8Idodx2uSyXuyLUBAu6kXCvT45gFwdZQ63WQHdlSEGYvd4UsOdAEfOQNEvyM
         ejEyjsF8TbSWlVrEi5DgQ585A3nWPiU9TGp15xzKJixToNz4HYFA6LZ8IkSBdEKIURNB
         0+Aw==
X-Forwarded-Encrypted: i=1; AKwUvByGv69JYNwQBDFy9ic/0z3a1ChgCFlxpZhoPLuzL4GZBjfidM2CKlNs+D9GyshKoMbEyZc=@vger.kernel.org
X-Gm-Message-State: AFq9FYI+cLLz2Cjhr00CCnPiJ08W8IafbRxcQQ5s2vBs0v9xtBuUS4ou
	HaaSTnNqHPPHtU82A6pOhCzzKN0OVBOJXIO8MWp/llCCFA9Nl65A3k+o9rusMDkfr0FUVL03y9s
	etQzhFw==
X-Received: from pjni9.prod.google.com ([2002:a17:90a:8389:b0:3aa:ee30:1a72])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4e83:b0:3ac:7556:8eec
 with SMTP id 98e67ed59e1d1-3ae580dd96bmr289174a91.39.1793139150524; Tue, 27
 Oct 2026 15:12:30 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 27 Oct 2026 15:12:07 -0700
In-Reply-To: <20261027221209.1560865-1-seanjc@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261027221209.1560865-1-seanjc@google.com>
X-Mailer: git-send-email 2.56.0.307.g5fe7bd680c-goog
Message-ID: <20261027221209.1560865-15-seanjc@google.com>
Subject: [PATCH v3 14/15] KVM: nVMX: Don't switch to vmcs01 when freeing a vCPU
From: Sean Christopherson <seanjc@google.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jim Mattson <jmattson@google.com>, 
	James Houghton <jthoughton@google.com>, Chris Mason <mason@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Now that neither free_nested() nor vmx_vcpu_free() relies on vmcs01 being
the active VMCS, don't bother switching to L1 and thus vmcs01 when freeing
nested state.

Temporarily keep the vcpu_{load,put}() pair even though the only reason the
vCPU needed to be loaded was to be able to do vmx_switch_vmcs(), as there
was at least one *known* side effect of doing vcpu_load() that KVM was
subtly relying on (taking the vCPU off the PI wakeup list).  I.e. defer
dropping the superfluous load+put to a separate patch so that there's a
dedicated bisection point if there are more lurking dependencies.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/nested.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 553915015a75..4a8f57eb3277 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -393,19 +393,9 @@ static void nested_vmx_do_vmxoff(struct kvm_vcpu *vcpu)
 	free_nested(vcpu);
 }
 
-/*
- * Ensure that the current vmcs of the logical processor is the
- * vmcs01 of the vcpu before calling free_nested().
- */
 void nested_vmx_free_vcpu(struct kvm_vcpu *vcpu)
 {
-	struct vcpu_vmx *vmx = to_vmx(vcpu);
-
 	vcpu_load(vcpu);
-	if (is_guest_mode(vcpu)) {
-		leave_guest_mode(vcpu);
-		vmx_switch_vmcs(vcpu, &vmx->vmcs01);
-	}
 	free_nested(vcpu);
 	vcpu_put(vcpu);
 }
-- 
2.56.0.307.g5fe7bd680c-goog

