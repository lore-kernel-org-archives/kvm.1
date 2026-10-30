Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793396274;
	b=fq49vRIYUCBIrMrfv6PpWhhYS7ZWATtPKLGCnkP6FekXWLPvl68EWyzas0dE6oocomvw
	 r4uGURY73AjAKRMrvQjVEiWCil9x1iH/DWegVKASXqB+oxXxZw+JnmmXXjIQbLr/m1+dy
	 ust5g8eVMxFQp9m9cot/T6ffE9pMoMbZA3qwy4tW+qxhxYo/QmOW9nHdQDRuMJls+YYQJ
	 xal4oD2r+NTNoaA34TkcRiiJjPL3aIvP1pY53mddKD+6FucfCalO2s0vgGIhwHd1Bv6KM
	 EWTRXuiMAItmwM+vpFuUj7bZnY/tY3Yx4uFfDeJCv1NpjWYoQMUWNndd6YIui2RDxwg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793396274;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Reply-To:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=nJFBxVgZV9XoDCRLOfNtMREStn7w9nRhV8Ti5t4DrDE=;
	b=3qwEnGncL34OPtpQmO+nuBJjVAQIJDhFzxgu6d/q/HWLbuAMd23pMbWJbGkYJcJKHs/U
	 TTgDjCDqZaQ+pd3oljum+3dwHYy/IHyVz2ncFVazYXKni8oWNVi+sHXAfHM+n1NhuMZ34
	 kBfXmDug9XWQOjI8JwwSiEkwe6CzuuvUwvDRrntWVGc7IGIftY7zsGDJi460dO5tqoBgG
	 rDfd2+LJM9Qj6taTW/eaCcCcHTVOxEK0pYPEfg7FaY3831H9wnbHxqdEFKJazQDBQ0OQ5
	 kvJDrr47QI6SHut0FDx2eqVH+QKJ4crIa3U0yoFxVnARxU/ePnh6LmpTXD2Qf9F0A2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=a0bT5Dv4;
	arc=none smtp.remote-ip=209.85.214.200
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F9660A260A
	for <kvm@vger.kernel.org>; Fri, 30 Oct 2026 21:37:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A1F9660A260A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=a0bT5Dv4
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2e601800e58so19554285ad.2
        for <kvm@vger.kernel.org>; Fri, 30 Oct 2026 14:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793396273; x=1794001073; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=nJFBxVgZV9XoDCRLOfNtMREStn7w9nRhV8Ti5t4DrDE=;
        b=a0bT5Dv4tnQJLo+zXr0DZjQeChZehYxal1FAWzrM5nrFjoBDyvDpdHYbg2Ve3BRSpU
         Hyk2rn43LnfIAqmn0qcpaRUbOVOiSLIDQufOLYYHeXmttmB7VuWqmfvtMAHHxcQQrwbu
         gfANODgEbnOzavhYxoaKw9T3g/OMkNmbtxaZl1GQ5e8ECFCct4tuf49aeZyatJR0wMF4
         pw0xrCNCUMFqURY+veRifUco4AaM/McYV5z5i9rDVVGO7DV7MKp09H/hePMzxHyVHowy
         QfMp/Tl00CrqNurOEpxqWBzKEf2NFWMGxAx4/gg+MymFondvF5v9/VdrnA8mtugv7bt6
         Ckqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793396273; x=1794001073;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nJFBxVgZV9XoDCRLOfNtMREStn7w9nRhV8Ti5t4DrDE=;
        b=NtVl8VsMHZy3NpvNEoZLL34/SRrB6zGsdMfxEUmLmgibvKs4quiDtFUk2xhL8V2+5u
         34JTYDNG5eaAjwWGANq9uPhIyo1NyT+bgm2qKG+NthG0XcQj+QcaNPfTgyrbrfD8lhCc
         03ZVvIydNTR/HrsdT2+1WDh4gObKdSi/zzpLw3638dCDZuXO8bzzjylXz9vlAIe5x5ba
         zYWLf9XCQcoadPmrEwrrsau+1kHZhxr04pf6vs93kaqeuIjmovy3RfWFsv/UN0Fb7CfV
         DAn6AdXEElYLZWMulAwFpyhW5XlY7KIvhuau3S1/sD+rE5OU4TCSphPsagp9RzP2AOXY
         967A==
X-Gm-Message-State: AFq9FYJ5t9e2KglHhrNWwgQG5nhwKupLx/xVn98zMDQOtm0mvTeI1T9u
	9KO1CrmqNbVjhtiiKfwgupROXO5ptYswsQFrLQEDUfsbJUTjMASJBAlIdFxPonkl09XJIb1CjDe
	DaeV3+A==
X-Received: from pllj16.prod.google.com ([2002:a17:902:7590:b0:2e2:ec03:928c])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:db01:b0:2e9:a16b:c251
 with SMTP id d9443c01a7336-2eb36415052mr38618865ad.3.1793396272864; Fri, 30
 Oct 2026 14:37:52 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 30 Oct 2026 14:37:45 -0700
In-Reply-To: <20261030213747.2611815-1-seanjc@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261030213747.2611815-1-seanjc@google.com>
X-Mailer: git-send-email 2.56.0.385.gac671c819a-goog
Message-ID: <20261030213747.2611815-4-seanjc@google.com>
Subject: [PATCH v3 3/5] KVM: nVMX: Synthesize #GP if L2 writes a "bad" CR0
 value via LMSW
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Mahmoud Abumandour <ma.mandourr@gmail.com>
Content-Type: text/plain; charset="UTF-8"

From: Mahmoud Abumandour <ma.mandourr@gmail.com>

Synthesize a #GP if writing CR0 when emulating LMSW fails, as it's possible
for LMSW to #GP on a bad value when executed post-VMXON, i.e. if LMSW
attempts to set/clear bits in violation of MSR_IA32_VMX_CR0_FIXED{0,1}.

Outside of VMX operation, LMSW can only arbitrarily modify bits 3:1 and can
only set bit 0 (PE).  I.e. LMSW can't modify any CR0 bits that are
unsupported or are subject to additional checks and thus should never #GP
due to a bad value.

Note, KVM has a virtualization hole where it doesn't enforce must-be-1 CR0
or CR4 bits that KVM doesn't intercepted.  E.g. if userspace marked CR0.TS
as a must-be-1 bit (while post-VMXON), then the guest could clear CR0.TS.
That hole will be plugged shortly.

Note #2, with the virtualization hole plugged, it *should* be impossible
for LMSW to #GP on a bad value.  Unfortunately, KVM's save/restore ioctls
allow userspace to load a CR0 value that violates the must-be-1 masks, i.e.
userspace can make the impossible happen (and plugging *those* holes is all
but guaranteed to be a waste of time).  Ideally, KVM would WARN, but since
userspace could trip the WARN, take the easy route and handle failure
appropriately.

Fixes: eeadf9e7558c ("KVM: nVMX: Handling of CR0 and CR4 modifying instructions")
Signed-off-by: Mahmoud Abumandour <ma.mandourr@gmail.com>
[sean: split to a separate patch]
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/vmx.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 2d5feeb8a059..68c1361a92d1 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -5746,9 +5746,8 @@ static int handle_cr(struct kvm_vcpu *vcpu)
 		val |= kvm_read_cr0_bits(vcpu, ~0x0eul);
 
 		trace_kvm_cr_write(cr, val);
-		(void)handle_set_cr0(vcpu, val);
-
-		return kvm_skip_emulated_instruction(vcpu);
+		err = handle_set_cr0(vcpu, val);
+		return kvm_complete_insn_gp(vcpu, err);
 	default:
 		break;
 	}
-- 
2.56.0.385.gac671c819a-goog

