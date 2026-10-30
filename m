Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793395646;
	b=dz8hXfMfvlPE1GtoTwisTc6cZ2/lZ6vuvxUKRud7BXPHywSAkv8Hwv1tlVehu/jcv92n
	 Nm7YS9dql5l/+ni/w+Lkev9LVWYgKAzkg7zy+La5l/xllu9WHczP+Mnl5Q80xQARMavjO
	 lo90/yv9Sms7J+L97fscabiY9PufbvhQKY672mxV3JtRINMCmha+dlIncxiFdnKs9G4eq
	 4QvfNrOfTlTr7z9WKoiNWLPhrtln5OGsRco3ga3HXUOY+aLjyGhxuo+v4liXYpZC/jMLU
	 PUm97lUcQSovZiGgu/bjh+VGIfnO/FZtcImtQYhfiaX3+0QXVQeJW7dD16jU15xEULQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793395646;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Reply-To:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=W5zoDi+lqoWp4CLBy/QM3flMWtfsfcrQPm2tl0mqVEc=;
	b=LKUS+zCZOgJMkRjyMBpLSTma8ZW1O1AUI4ehh9+Wwx1weaWuZudLIs4i1jR7cTtoOQ3q
	 jk/xn8Edf4OeR/ZPUDCYhb/jGNtNzOt05Q6nfXaAsILQ4MXZorrif4Sshxm1qAIC+IV6M
	 jBuPsypDmQKU752RJuqN4lT9k2n7l//JbkqBOPZurIK14PUwDQCgL3YvTPXahrJIAqjOv
	 LDgJtN95kw1Lzq9hZI/AbC3+EjwhASPXXi52HB+uDuLE6kNblkFhbCZrxrzupjAKZbLNy
	 oVK61q/JIU8iAJ4hZE30BSW8rAl/RHhOba84/CK745mlgfqeoY2Xsk4f5+KBJtVcxcA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Qw1935dI;
	arc=none smtp.remote-ip=209.85.214.199
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF8DA606A33F
	for <kvm@vger.kernel.org>; Fri, 30 Oct 2026 21:27:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DF8DA606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Qw1935dI
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2e93f67358eso13123105ad.1
        for <kvm@vger.kernel.org>; Fri, 30 Oct 2026 14:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793395645; x=1794000445; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=W5zoDi+lqoWp4CLBy/QM3flMWtfsfcrQPm2tl0mqVEc=;
        b=Qw1935dIWvunHPAzysmMCqH0fVyqmM2NklGUJyoZtgtLGyI3lKoMyGVjUO7axIe7/3
         1fpL8vFv9VItXfCECwjLHwLmFWAGVAmYnH0Co4xfjL865DdhExD3dIN0gItUGKSgTTZM
         NLKJ5gVmKpDdWrjO646sDbbQvVWAWiHjMiNsaGHbAlc6vQd+rbEvIJWWtHfdnvCp6Dcl
         qb4kHjY6UCQ8xnnFdUTF2JD6g4OT6lPddjLwLwXCOh+j5AyJvY/YngCDDH4UwaCw7Tr3
         P1WlErBPTpqOoNTVjNmRceW+5e7+G1sGIP9vP7oYewPpTIRXdcDTpkxs1PhK/c4XPWJt
         9vlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793395645; x=1794000445;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=W5zoDi+lqoWp4CLBy/QM3flMWtfsfcrQPm2tl0mqVEc=;
        b=GYZCYRdZpDE1I1mm60bInauVrZhh6rGBL4jjcm741jCgm4VP2A+v9c7cemzOLP4zMt
         oHSmnIHPHTbvHze+WRwlTwm88rqvg424mvKppRDvFq5pCAIB8zftXqPm+CoTaywzsUrI
         N9f5/IaOhCi6GeknNz6vUfa11/25B3bVQOLI29azxsjZk//S7ymbr26spivUht9TuqYe
         L1AibqezRR8x+AmgF/esCUndy0siZnN06K9CvvvTV2HbtRMDT4T1Qy5OxUNIGUzY6TC7
         G5EysZKaggmVrTjekducsYHrnCtmb8C5Dk8bM8U1vuLm39Wc53zd21ncEgiiU78Eh+zm
         ppkg==
X-Gm-Message-State: AFq9FYJGkIv9lylfn1naX05BiMmXHs67Dwm8f4HQEu7iR+KaxBCeFZdo
	csG6Ehz6pTbws1Mh0Nl4Jiwp4AfN0O2+G4hWg/QBYdwId04VqzUhtwkvrodxk51+6nu6L3nWz+9
	9s/wxrA==
X-Received: from plbnb8.prod.google.com ([2002:a17:903:15c8:b0:2eb:15a2:31f2])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e74f:b0:2e9:4175:3073
 with SMTP id d9443c01a7336-2eb364a2804mr36189935ad.28.1793395645207; Fri, 30
 Oct 2026 14:27:25 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 30 Oct 2026 14:27:16 -0700
In-Reply-To: <20261030212721.2606393-1-seanjc@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261030212721.2606393-1-seanjc@google.com>
X-Mailer: git-send-email 2.56.0.385.gac671c819a-goog
Message-ID: <20261030212721.2606393-3-seanjc@google.com>
Subject: [PATCH v3 2/7] KVM: x86: Treat EFER.LMA, not EFER.LMA, as an EFER MMU
 role bit
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sashiko Bot <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Now that KVM now longer lets userspace violate the architectural rules when
stuffing EFER, treat EFER.LMA instead of EFER.LME as the relevant EFER MMU
role bit to ensure that the MMU context is reinitialized if EFER.LMA is
toggled without EFER.LME also being toggled.  EFER.LMA is the actual bit
that is consumed by e.g. kvm_calc_cpu_role().

While the _current_ code never actually toggles EFER.LMA, that is a flaw
that will soon be fixed.  Furthermore, checking EFER.LME was essentially a
hack to fudge around the now-reverted, misguided commit 11988499e62b ("KVM:
x86: Skip EFER vs. guest CPUID checks for host-initiated writes").

Reported-by: Sashiko Bot <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/all/sashiko-outbox-187201@kernel.org
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/mmu.h b/arch/x86/kvm/mmu.h
index 2ae7f9ed4cf8..2c3f777f78d6 100644
--- a/arch/x86/kvm/mmu.h
+++ b/arch/x86/kvm/mmu.h
@@ -61,7 +61,7 @@ extern bool __read_mostly eager_page_split;
 			       X86_CR4_SMEP | X86_CR4_SMAP | X86_CR4_PKE)
 
 #define KVM_MMU_CR0_ROLE_BITS (X86_CR0_PG | X86_CR0_WP)
-#define KVM_MMU_EFER_ROLE_BITS (EFER_LME | EFER_NX)
+#define KVM_MMU_EFER_ROLE_BITS (EFER_LMA | EFER_NX)
 
 static __always_inline u64 rsvd_bits(int s, int e)
 {
-- 
2.56.0.385.gac671c819a-goog

