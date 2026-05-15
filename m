Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F9553F6C2E
	for <kvm@vger.kernel.org>; Fri, 15 May 2026 22:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778884026; cv=none; b=pT4qXTzrHZHgNp2QbY/XiJjmni2MRGQ2cKRVOdsrZrR+cvzL0uLCp8L8lLweLc6XaONvmHiCYGH4Ab3l7hvx+3AKnLFSkoLpT7fjv928wIbyTcZga3tSDccrqPGTUcFOg1IzSZ+X92BxNoBXDVCVissV6h3CHW0trZWSLfdwRW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778884026; c=relaxed/simple;
	bh=dh/466QpDRVSYGmRqAV7P39+F84skbkezeHrlcc9ov8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=C6sQY+20KK8vPL2Iue3o/s/GqUORVt7QHcuXOXM3lIzsmAkSPC0CXSQcbu/7Vl2HOPLU/giK1dwHaK0v0ggtwe7kfrmwQ97LfHsl3cq7uDYmowYp/x3srMgQ6i0Mf2XUdKMT8Fxchk50pki5ry8T6GV7RQMOj0tqkCLuOlRXVng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tzn7qScX; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tzn7qScX"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2b99eb06178so7568785ad.2
        for <kvm@vger.kernel.org>; Fri, 15 May 2026 15:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778884007; x=1779488807; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=V6lPUV5IaDfXS6ALjedfGPjBC5QgsmU8o3Ef23dncSs=;
        b=tzn7qScX/Ih0MnLEJhJDUtyDjA96VUnzFVNU3CicDJMUnid069/90nYgKc2SBxiyL2
         JKTFgolxTGUw+qkg3JPZaCa95CRer4MFCzEpKC4KnvY0IDSez2Q2enKrCjuwrBOmBN5B
         zHAxc8Eb1Y6H4CCrZEMCQB3w1RH0xyX9TsINer+Y+n0jOTAZi6EW+lz1XJpWUTArPQF7
         +a2zmloPw5Rc4LyFSQssTKqsvGp1ZYJLryq+AGliMkpBOUjE2mkWUK32unqWEchvup9L
         6ejo+4vu5HawH9qB5BjZO5z89c3r0O7mbpQ42r08WCKg4DEvew5v4Z7LCHnupoYAothI
         W8pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778884007; x=1779488807;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V6lPUV5IaDfXS6ALjedfGPjBC5QgsmU8o3Ef23dncSs=;
        b=kmilYnY54GNFGVCjdT1Z0jJSTQwvmROUFvHr8SCAt85lZ/zUiYN/ptzzKHZQUbtM/T
         C4c9jWD3wRyDgy/y80zYs728AeE6VmV7WR/UN+EvqdatFdM433AAnMTC4jSgmA2xRaKM
         m3Uy2qp9uzREPbHW0oQc0CJlskqZ7JOA1lIBz6+6fibjxBUX5jBtdeldlfQGMuNwzt7p
         iShn0W3+cFF8m/6CtjUfiMd/IhRO/PDNggYjczq2Xaiv0IVk4GunPnJisfSCNIpc/1gy
         P1JcaiR1+k7vj4SLw/87f+VRavA5Wucb0w3Zav+oGFcEz8aW+SXtCKhECsEW3IOq7wAN
         VARg==
X-Gm-Message-State: AOJu0YymLvexjN5erq+4FhMbQWtxDLzB6ibwi8omDgoOMaHdThyXjDxG
	BuHbUDG0sErhCOYxzd5anyrqsdDtwjcNQCOEP497i9xWFqQ2yv1E+EYSPVPX2gRiIkhTrO0+VFV
	IxrjXrQ==
X-Received: from plcy11.prod.google.com ([2002:a17:903:10b:b0:2b0:af2d:2502])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:a701:b0:2bd:5b20:a5b5
 with SMTP id d9443c01a7336-2bd7e951360mr47925705ad.37.1778884007419; Fri, 15
 May 2026 15:26:47 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 15 May 2026 15:26:35 -0700
In-Reply-To: <20260515222638.1949982-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260515222638.1949982-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260515222638.1949982-8-seanjc@google.com>
Subject: [PATCH v3 07/10] KVM: x86: Drop kvm_vcpu_do_singlestep() now that
 it's been gutted
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Hou Wenlong <houwenlong.hwl@antgroup.com>, Lai Jiangshan <jiangshan.ljs@antgroup.com>
Content-Type: text/plain; charset="UTF-8"

Now that all of kvm_vcpu_do_singlestep()'s previously-unique functionality
has been moved into kvm_inject_emulated_db(), drop the one-line wrapper.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/x86.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index ca30a8987f2f..758b99b2fa7f 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -133,7 +133,6 @@ static void process_nmi(struct kvm_vcpu *vcpu);
 static void __kvm_set_rflags(struct kvm_vcpu *vcpu, unsigned long rflags);
 static void store_regs(struct kvm_vcpu *vcpu);
 static int sync_regs(struct kvm_vcpu *vcpu);
-static int kvm_vcpu_do_singlestep(struct kvm_vcpu *vcpu);
 
 static int __set_sregs2(struct kvm_vcpu *vcpu, struct kvm_sregs2 *sregs2);
 static void __get_sregs2(struct kvm_vcpu *vcpu, struct kvm_sregs2 *sregs2);
@@ -9277,11 +9276,6 @@ static int kvm_vcpu_check_hw_bp(unsigned long addr, u32 type, u32 dr7,
 	return dr6;
 }
 
-static int kvm_vcpu_do_singlestep(struct kvm_vcpu *vcpu)
-{
-	return kvm_inject_emulated_db(vcpu, DR6_BS);
-}
-
 int kvm_skip_emulated_instruction(struct kvm_vcpu *vcpu)
 {
 	unsigned long rflags = kvm_x86_call(get_rflags)(vcpu);
@@ -9302,7 +9296,7 @@ int kvm_skip_emulated_instruction(struct kvm_vcpu *vcpu)
 	 * that sets the TF flag".
 	 */
 	if (unlikely(rflags & X86_EFLAGS_TF))
-		r = kvm_vcpu_do_singlestep(vcpu);
+		r = kvm_inject_emulated_db(vcpu, DR6_BS);
 	return r;
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_skip_emulated_instruction);
@@ -9641,7 +9635,7 @@ int x86_emulate_instruction(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
 				kvm_pmu_branch_retired(vcpu);
 			kvm_rip_write(vcpu, ctxt->eip);
 			if (r && (ctxt->tf || (vcpu->guest_debug & KVM_GUESTDBG_SINGLESTEP)))
-				r = kvm_vcpu_do_singlestep(vcpu);
+				r = kvm_inject_emulated_db(vcpu, DR6_BS);
 			kvm_x86_call(update_emulated_instruction)(vcpu);
 			__kvm_set_rflags(vcpu, ctxt->eflags);
 		}
-- 
2.54.0.563.g4f69b47b94-goog

