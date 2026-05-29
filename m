Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F03923E7BAF
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 22:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780093380; cv=none; b=O7sUkKj76lkER9nCZYkGOV9Vwsr4oJv7h1zvKo66S+MGJ6ZwvDG3OFMtTqnjGciiVhMpZbyLop2VUJwGtgGNPx3WfTpcQvXgcymkjXEqgA3wTE7/oU41O3A8lKkfWVwmCH48xCbGNkX4heqKvIS7/KOUIvHU+WnxLix5imSKlaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780093380; c=relaxed/simple;
	bh=O6sCALoH9EmCcgisAiG+6wKleryQICAogURF+M73YgA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZcaZ9XyISqhUez9TnmLNKoTuqfc/+jH+X+GhbMy3i9jcIpDWhtIyb5IzFsot8YL6g0qj3wb+vE8WCSkfB6PAtX9+/1iTsEhSzWtSDUFO0RebozpRspZnzH6vPLSJs1Vcu9NMEAaY+1NXfJf+NmYCLF6t9saBhL+qbsZcWQvePeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cOh/ReEf; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cOh/ReEf"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2bf32259e0eso6849265ad.0
        for <kvm@vger.kernel.org>; Fri, 29 May 2026 15:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780093377; x=1780698177; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=YESkxGyiczq5Z97XVWhBBl+heltge9f5w5uhIKBe0e8=;
        b=cOh/ReEfkJwKeVn8l2OTNCWPqm43yFH4HPdtGNZkT3jiXK5SFU+fHT3vSV4tpZecz1
         TDgy3s53T2VPP5kBx/UR87YcYkTXEMw6wR29GaBgHgBHe76fMkINhnTtzx86EYmvFeZi
         FreVb0k7TDYr7MaVfz1iChqH9SbeVjM0TTIUX5kFSXN7ULgSmj7HCKa7U/miCzJPGjkm
         acfnI7Q79Ijdm8f7X3yWoz+auYYeo8DqnFzWrklMtkDVuaNZEsWNIHalAMZ4HP8pC8pg
         rmGiHvpeMFh58QJmIogotxanjH/oxQQ0hrS1avIFp3A7sooYNK6Qrog3I+cTGrRnHYX+
         kegQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780093377; x=1780698177;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YESkxGyiczq5Z97XVWhBBl+heltge9f5w5uhIKBe0e8=;
        b=YmeAmB9vxUGKvyn5KK+e0NWv6PYDDoPawIg8GvxGT+8A1SLdnZanxgmyRkX0bvBLpu
         RAnB+kh+3Fz/q3+k/YBViyQpjxAk2Z3EVQk2QyKnXtp0Suib4j8n/jyma3prTwbSkPD6
         64L6s+Fx1xzLZxJxWb1VmYpypqpKOrrW8a7Gx5xm/VrYYCAvg9gJzBAmv7PbdmA1mBM9
         L4XDCSZlB2HtfWPY3EeWJN5j3WQFH37LACBgsDg1xQK/Kp22SmYxx0On1eH6mweGnZxs
         /u4FtJ3lfI5v5MJ4ZBs5GZGqUWhXdBazM74Xev+fIjqO4895qEj3s8CSmZT8ehRFeslr
         CBzw==
X-Gm-Message-State: AOJu0Yy5H1li9MmIwMrNrUJxXTverMDYr42277gGwgtDmogJHdiLDPCo
	5tvFMCwSavmPkOHLLo40T+MDPW8+aL5wx378glc2Wca1iXGmWJRjflZ09JE0wB8bpjqVv3lo6iT
	trNXjTg==
X-Received: from plbkn8.prod.google.com ([2002:a17:903:788:b0:2bd:25ca:82e9])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d4c4:b0:2bf:e42:2a94
 with SMTP id d9443c01a7336-2bf368a4096mr19964205ad.38.1780093377142; Fri, 29
 May 2026 15:22:57 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 29 May 2026 15:21:55 -0700
In-Reply-To: <20260529222223.870923-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260529222223.870923-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260529222223.870923-13-seanjc@google.com>
Subject: [PATCH v3 12/40] KVM: x86: Harden is_64_bit_hypercall() against bugs
 on 32-bit kernels
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, David Woodhouse <dwmw2@infradead.org>, Paul Durrant <paul@xen.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosry@kernel.org>, Binbin Wu <binbin.wu@linux.intel.com>, 
	David Woodhouse <dwmw@amazon.co.uk>, Kai Huang <kai.huang@intel.com>
Content-Type: text/plain; charset="UTF-8"

Unconditionally return %false for is_64_bit_hypercall() on 32-bit kernels
to guard against incorrectly setting guest_state_protected, and because
in a (very) hypothetical world where 32-bit KVM supports protected guests,
assuming a hypercall was made in 64-bit mode is flat out wrong.

Reviewed-by: Kai Huang <kai.huang@intel.com>
Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/regs.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/kvm/regs.h b/arch/x86/kvm/regs.h
index f22b3a8cd483..a57ba26279ed 100644
--- a/arch/x86/kvm/regs.h
+++ b/arch/x86/kvm/regs.h
@@ -39,12 +39,16 @@ static inline bool is_64_bit_mode(struct kvm_vcpu *vcpu)
 
 static inline bool is_64_bit_hypercall(struct kvm_vcpu *vcpu)
 {
+#ifdef CONFIG_X86_64
 	/*
 	 * If running with protected guest state, the CS register is not
 	 * accessible. The hypercall register values will have had to been
 	 * provided in 64-bit mode, so assume the guest is in 64-bit.
 	 */
 	return vcpu->arch.guest_state_protected || is_64_bit_mode(vcpu);
+#else
+	return false;
+#endif
 }
 
 static __always_inline unsigned long kvm_reg_mode_mask(struct kvm_vcpu *vcpu)
-- 
2.54.0.823.g6e5bcc1fc9-goog

