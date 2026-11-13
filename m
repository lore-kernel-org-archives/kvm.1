Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794590603;
	b=yRGfNpZIKb6tOzLyQ8BU8F7uBwoFgvf2XuABGVAgf8E0vmm1vYMOo6u+LB777Qi/1qc9
	 8uP5FmgkA4K+Yl3pJCLhCaJc8NX8ILCcnmIRB3ANw7hBm9WlVGwMxHtrJvjJtI2lMESMi
	 rCO+Co5kItMjmK/zCfVPrgeE2NzxuQyQi1JStVWZQEkQ/SXLY2Hj49/Pm1Gox1/pPRkjR
	 SLUTwzB9Nrj7r2QwYy0t0MXSjZq4K2/v4e6BVB8P8488st0BykMxyhUUOztZ9BK0bCp1o
	 YiGIuQ4sYNXZbm1BpZXGaRaKW4lySeDlX4mBRXk21CDlB+NOH5Ob/6FiET+yy8WRyjg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794590603;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Reply-To:Date:Mime-Version:X-Mailer:
	 Message-ID:Subject:From:To:Cc:Content-Type;
	bh=6p/cpLmwtBMtzqB9Ka32YEX11P0LpkgIf0A/bPbuKMU=;
	b=u1qlOhrUGIY118miMD8OLiyWTIndT1Fq9CyYqbXQqQ9jWPJ7i3gCxTC+jYdo7uJNJFWN
	 yOt/ivv+t1FEfXJ6iEwT0CAgJRADHEmE8BXTNhQdtGJmN8LnoJnvIzG8iD9tV7UOhNYr3
	 BXe6ixpr3UTDcIgB5NG/PG53uWlhymG4tvhHXE+7akVCSa+yLlczvjeoLo3a3ie5Zh1ic
	 yX7BAlmAZNcsqO8YMzobPhwrMmfYbSjW1TY5o4Jt6wnHPXLVd5kVr++ec/Cgt2SLbo4wx
	 JLwBgbsV8z42AsUJdReeHUkVAZsQ1gGkuHufpof3LjEkB4poRgEothVTwGWNyCl4VDw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=e48lHNPR;
	arc=none smtp.remote-ip=209.85.216.72
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD9F606C0B8
	for <kvm@vger.kernel.org>; Fri, 13 Nov 2026 17:23:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EFD9F606C0B8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=e48lHNPR
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3b18165dc53so1779568a91.3
        for <kvm@vger.kernel.org>; Fri, 13 Nov 2026 09:23:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794590602; x=1795195402; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=6p/cpLmwtBMtzqB9Ka32YEX11P0LpkgIf0A/bPbuKMU=;
        b=e48lHNPROZUMj2wUwF/qjHZ4xPfCPLyxzMu+/mP8MLIzp6v3m0qwW3VGAGjcaJYUtk
         7yaxdPw9t92ib+wUTpuK4FAU+hCt2nEXgxdh9MyyP9Bvymo3dYfgxjlsK1t1eMVHu2eN
         7xuannnYF0BhDsm8m514feGa4gQFAIgRayac5EfdpaoKyquabDCE1aptrU9qEfFaTXKD
         0kiVy6VgZunHxwPVry9+T0MUaswehQmNPiUphCVQQV606XIvIL7HzvNgRoMUEMRR8H5C
         F3yv0L6+9D9//oaGTqRTPuMlMKpMiWp/87S4y4/0zDuLkZoheMWVShiLyXEI2+ow3JRf
         zPug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794590602; x=1795195402;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=6p/cpLmwtBMtzqB9Ka32YEX11P0LpkgIf0A/bPbuKMU=;
        b=CqCuEFvP0LIphXxOVHxEhH5ijPtAG9rDP3ERfoK8G7kZ9g+RgK540QeB/4jru9RTGC
         AzbpPHmEM2/j1rZHT1bHaN9QDKRIdzkyjW4lszZKweMsUXqazFE2MbtnM4bSoBZVEm2R
         WqFA4bPilPw9eySZwP4E2sLF2KgkcVkJQOwY+vp4ZI2josV/V6SyS2BwcG96S8jwnpvP
         U7p/S8JuZq08O1axkgmv0WopLnYOWzW4U/LGAEYAdHHBCTLXO4p7kkn5lIGG++wBH5bo
         Ssc1XRbQFifN3SZir0f5gzMpIPNuFaoNEFi9nw/+C1vN8nT0uZ9V4MDqANXxxv+Pwo14
         5tBA==
X-Gm-Message-State: APuU4Z/RE0kQthhXa8zQBPzeEx3Vn8I1SdNfHMqG+zvX2hwKAT4c2Wge
	rL1Cdn+MyzrgyFCAzoLPq1kQaaNlu0yg6ZFB2mZl2aBdZuws1g4w/89Yz11DrCYSba/xaYBczEw
	0w8nuOw==
X-Received: from pgba10-n1.prod.google.com ([2002:a05:6a02:644a:10b0:cdb:4f65:709a])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3bcc:b0:3b0:a1af:e4fa
 with SMTP id 98e67ed59e1d1-3b1b09fca30mr3155571a91.24.1794590602170; Fri, 13
 Nov 2026 09:23:22 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 13 Nov 2026 09:23:18 -0800
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
Message-ID: <20261113172318.482971-1-seanjc@google.com>
Subject: [PATCH] KVM: x86: Leave nested if vendor specific logic fails on RSM
 to L2
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Stefan Teodorescu <fane@google.com>
Content-Type: text/plain; charset="UTF-8"

Force the vCPU into L1 before synthesizing SHUTDOWN if RSM to L2 fails due
to vendor specific checks, e.g. because SMRAM was corrupted with illegal
state, and the bad state was detected *after* starting the transition back
to L2.  Architecturally, any fatal error when loading CPU state during RSM
is supposed to send the CPU into SHUTDOWN *before* switching to guest mode,
and leaving the vCPU in L2 is all but guaranteed to effectively corrupt
vCPU state (which doesn't matter for the guest since it's already hosed,
but matters if userspace misbehaves and ignores the SHUTDOWN, i.e. runs the
vCPU even though it's in a bad state).

Fixes: 3f6821aa147b ("KVM: x86: Forcibly leave nested if RSM to L2 hits shutdown")
Cc: stable@vger.kernel.org
Reported-by: Stefan Teodorescu <fane@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/smm.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/smm.c b/arch/x86/kvm/smm.c
index 656a38dad7e7..23cb8211ec74 100644
--- a/arch/x86/kvm/smm.c
+++ b/arch/x86/kvm/smm.c
@@ -639,8 +639,10 @@ int emulator_leave_smm(struct x86_emulate_ctxt *ctxt)
 	 * reasons), and so nSVM/nVMX would clobber state that is loaded from
 	 * SMRAM and from the VMCS/VMCB.
 	 */
-	if (kvm_x86_call(leave_smm)(vcpu, &smram))
-		return X86EMUL_UNHANDLEABLE;
+	if (kvm_x86_call(leave_smm)(vcpu, &smram)) {
+		ret = X86EMUL_UNHANDLEABLE;
+		goto out;
+	}
 
 #ifdef CONFIG_X86_64
 	if (guest_cpu_cap_has(vcpu, X86_FEATURE_LM))
@@ -661,6 +663,7 @@ int emulator_leave_smm(struct x86_emulate_ctxt *ctxt)
 	 * the shutdown, so that L1 enters shutdown instead of seeing a VM-Exit
 	 * that architecturally shouldn't be possible.
 	 */
+out:
 	if (ret != X86EMUL_CONTINUE && is_guest_mode(vcpu))
 		kvm_leave_nested(vcpu);
 	return ret;

base-commit: d21eef2084a9af87ac2a783bc7c2b175ba114e4e
-- 
2.56.1.703.gf848ed807c-goog

