Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792695935;
	b=l2g83gcPqJjeWc9lJN4z6slIyIlX0Ro1iGGPXfuElWa4SRunkuC1i6FLW4xKBCMDw7w9
	 lh+5QRFQxHgecQF921J103f07ro0gJ3mR0qCqgY35jnxZ/Tqd1TSBqD3t+Iy+TV3TQT3z
	 69MypjjZwOMPpqKIWXMnNXz3PjEPYPNq7OSNnw5WyMhkpPJkUjcX1KlCMn/zGEZ1dVF7Z
	 PTXLennMBqgfK+eqGH2IVk78Atppmi8BawTxmah2/kH4Nw4/z2ExLy/TlyFI4OoXpAcuX
	 fULerqKvKLwUJDr8/gkB+R7USkhmqDXezeENoNycDOdf4wJtSUP1MT6C0bZLPY2+9Ag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792695935;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Reply-To:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=jCmupRclUZjg6uDzOj3iAY4OufXI04zNlbOPQFCZiKo=;
	b=LKH/xdjZtQV8VhiiQUPe8t/ZE7EJAsoJBDexrv8UNsaoyd8BJjjtkAlrC6k8qhb6ALCu
	 ptg/M4POZk7i8y7AZ8gqga0SvuwP9Vw1m9ebBBsDkI6llQHMyeZJNkBJmwC0wFDYXXWBs
	 Zo8aTOWShjfJQ3F+j6mIVJeo4g05Cd4S0mMkgk0BOHUi9l+q7Q+uj4xaTQ5XXx8xaK78T
	 SMz6HNJTtbo/f7mehBhlXF7b8mpYx3WV7OTV0WgB0rz8by36xgw1EZ6EJ4BhYGd7119Y5
	 tNAmIYcrYV7caAV99GX4iW8u9m6hLxOHUtxWz7iYzeAeTSeLgoSI3wBvmKHqMbdR5FA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=EDvs309B;
	arc=none smtp.remote-ip=209.85.215.200
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C0FB60A2623
	for <kvm@vger.kernel.org>; Thu, 22 Oct 2026 19:05:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2C0FB60A2623
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=EDvs309B
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cca35cf9f77so78565a12.2
        for <kvm@vger.kernel.org>; Thu, 22 Oct 2026 12:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792695934; x=1793300734; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=jCmupRclUZjg6uDzOj3iAY4OufXI04zNlbOPQFCZiKo=;
        b=EDvs309BltviMcC2y+ka57czDeasQX4IUzXK6oQgX8ifsDVBN29tEfKn0MMklz21tJ
         sr+zjBegAoxErhcmxm2ZTTISgL6tbaU1AUAofv/UsboGBj19OSm53AZWL0KPLteKUAfQ
         kmpUePe1oroIMazgkyxKUMQ0lkzbtAIB4jvT6osoBsTm/ntxDdvboy/GWAGbeqjZz7iW
         jZIBlIU+rkN/uK8B72puzwvldylVKSylx97HfLTwmTdds4Ij9oPRzMbTIS8ystgSUuCL
         o7tfULMCDmYADO53U9tji7wi7Rr2avN/wg8Xa2r9Abrve0le826QBOsnoVwQVm5P93MD
         KmMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792695934; x=1793300734;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jCmupRclUZjg6uDzOj3iAY4OufXI04zNlbOPQFCZiKo=;
        b=B1KN65jr+4Q1ysRctGzRzDTz4+74jZBI7f3iIJG9MW8MV7jObuvt6wKFBcd1IRb6nf
         fkW6k14NHLeojY25tuzHa2dOUelpcWhdJciGNEORoDj3FL4GwECDa95vZs1u4JcLej4X
         ckSOiR0yKFaEV5o05AE4oOkg1Xs7Chbe0xPjcNjNuaKipA0JJPsw7LvHy78s4BWrds2A
         3ulhErw/GHC5YCUrZs8PXQOqEdypHe93TfxFjNH4r/Hff7JST+9J0YqBqsdC8LJpHVwF
         J5zRFCcv3JDyrAxMVyR7gBcZP6pLXYqGbNLx/txewyA9CAG8rZeVSU4rWoUkRclpKT9m
         AQ+Q==
X-Gm-Message-State: AFq9FYJwveCcwH8ORRZCi1UVv7crDfNBEN6p62/xX2gOiGgKKnERxWLq
	+nswT6gmfLL0tEEeJpl2UU7eFEdCweuzxpEUEZRgOQ3ishO5YxNGGIng+hCoZa2b6PGvs+E8B++
	+WYy70w==
X-Received: from plbjk4.prod.google.com ([2002:a17:903:3304:b0:2e2:f517:75b])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ffcf:b0:2ea:7180:3ab9
 with SMTP id d9443c01a7336-2ea7c18a456mr2829515ad.43.1792695934246; Thu, 22
 Oct 2026 12:05:34 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 22 Oct 2026 12:05:30 -0700
In-Reply-To: <20261022190530.541789-1-seanjc@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261022190530.541789-1-seanjc@google.com>
X-Mailer: git-send-email 2.56.0.257.gf7497c7d27-goog
Message-ID: <20261022190530.541789-3-seanjc@google.com>
Subject: [PATCH 2/2] KVM: VMX: Dedup VM-Enter error handling for VM-Fail and VM-Exit
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, syzbot@google.com
Content-Type: text/plain; charset="UTF-8"

Dedup the error handling code for failed VM-Entry as the only difference
between the VM-Fail and VM-Exit cases is the source of the failure reason.

Other than clearing vmx->fail on a VM-Exit failure, which should be a nop
absent other bugs, no functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/vmx.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 29aa93cea963..a15cdad5c06a 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -6741,21 +6741,13 @@ int vmx_handle_exit(struct kvm_vcpu *vcpu, fastpath_t exit_fastpath)
 	if (vmx->vt.emulation_required)
 		return handle_invalid_guest_state(vcpu);
 
-	if (exit_reason.failed_vmentry) {
+	if (exit_reason.failed_vmentry || unlikely(vmx->fail)) {
 		dump_vmcs(vcpu);
 		vcpu->run->exit_reason = KVM_EXIT_FAIL_ENTRY;
-		vcpu->run->fail_entry.hardware_entry_failure_reason
-			= exit_reason.full;
+		vcpu->run->fail_entry.hardware_entry_failure_reason =
+			vmx->fail ? vmcs_read32(VM_INSTRUCTION_ERROR) : exit_reason.full;
 		vcpu->run->fail_entry.cpu = vcpu->arch.last_vmentry_cpu;
-		return 0;
-	}
 
-	if (unlikely(vmx->fail)) {
-		dump_vmcs(vcpu);
-		vcpu->run->exit_reason = KVM_EXIT_FAIL_ENTRY;
-		vcpu->run->fail_entry.hardware_entry_failure_reason
-			= vmcs_read32(VM_INSTRUCTION_ERROR);
-		vcpu->run->fail_entry.cpu = vcpu->arch.last_vmentry_cpu;
 		vmx->fail = 0;
 		return 0;
 	}
-- 
2.56.0.257.gf7497c7d27-goog

