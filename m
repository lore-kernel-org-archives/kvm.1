Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795132628;
	b=TDfPEob5/+rDHOQBrad+YTyQ2AMjEwIedrMhi2jHK4ohfitfweq6ujqf9JnWs9Ymjth4
	 HoywK3gVu6TzvuqMQ351e53Iui1pYlcod4TuQfrYe/fdIt8HBT/7bYNe6X5UddtHYi7k0
	 ORomwEIeMTnsHsiZUCI+Y8n3DYBPFY0no24piXO54TZjzzLoDWAzHZT6KOjCfCrZWVHNK
	 d+2f4INm+D6BMNnwqvyVnf7LuzryegkYDw55bjsE8ecEF4ftvG1XzuwvK6oD8oaBeg8XT
	 Qi+Y33VmiSileBjz+jydA4k+0WMUxGG/gQ/6bu6JZ5cV4+Y7HpxYPrxfZxZDtTFBzFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795132628;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Reply-To:Date:
	 In-Reply-To:Mime-Version:References:X-Mailer:Message-ID:Subject:From:
	 To:Cc:Content-Type;
	bh=KJ7L7t2XkwXbN55oUV9T341zq8HWLMHHi697Po38iFc=;
	b=MMP0uyGUU5Gcv8W3Zi8SejYRZfQ1ehmomWZWWs6DI8pd56pJd/Q77RrA4fF3voPZRL8P
	 rLDrQwxqlCTkz5sHO5Jw/njjQ9GE3Her67fPdk2mw0oCiuTEBBcMJ6ZFLDEJ+OSlaBgbD
	 MdpA3zjlxffLm/GMviSPsiCyh9c3gsNT1whE3mTYJ53xEhjDoNsCT/Mw6rwqVIzjeG4Y1
	 ngRn0B3ryNS0BjNdFX6gVMqG+oRAbP2haEjzYELmXobGFZekFpUuspFOPdExNR0II+K+E
	 VbGBE5wUMQuxtM4wgLeuq2ewiE9GUzHuUp92zQsKx9pX29hW+gF9C9eqL2GFaJIuMdA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=LgsNRIRQ;
	arc=none smtp.remote-ip=209.85.210.197
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7064260A262A
	for <kvm@vger.kernel.org>; Thu, 19 Nov 2026 23:57:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7064260A262A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=LgsNRIRQ
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-8b5d8de9619so473870b3a.0
        for <kvm@vger.kernel.org>; Thu, 19 Nov 2026 15:57:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795132628; x=1795737428; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=KJ7L7t2XkwXbN55oUV9T341zq8HWLMHHi697Po38iFc=;
        b=LgsNRIRQ2lW6CRcKZV7zZ49mGDzz9VVKYvaXF8FR3mf2repJai0r0Tro41POpigvgA
         Br7hKU4KNzd2nlfUWRjjxsHca25sbsAmyg8Rl5X3SRvjzVcYQuIx2UnCgcEKdrxUn2RM
         CVOuBN3e8T3cbm8zU/EcVXCejUn+9c1sm4mGW9//6/TxLtVVXXWN/RGT7wzvd0PLNV/V
         XtaRulgN28OrXqPlMFA5U286RTUf/i/50EcTvBBrJZS0+0rNmaj80YUjFeP6H5WboJyD
         Ggowuafoz6a4eoSXl/g0TEo6TYvgQ+oah/TEBf4xgXUVf2GxTQJrIkiEc9adQfB8ewa/
         Pxog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795132628; x=1795737428;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KJ7L7t2XkwXbN55oUV9T341zq8HWLMHHi697Po38iFc=;
        b=dkN9RhoaOBi2e15iUzwngQyLSWvjZD8cq9IDIZO3xD54pMw4LVFUE0FZ7GNC9FR1cE
         sb00DJAOU775X0T/Oyjy74BYqfngD+DDaVtv8WOLfLR01TMqHaH+pFIQj21XJkq88kck
         KE2K5KcH3ssiXtwy2F3y/wNlVfkYplXQtZT46hBYgdq+Lg7mITPwcO+9wPrmtK4r2dgU
         HkuBru5CKGbINEu5GELMrtOiIAWrYYZLb+UMj/XTiaJzhqXiWHH8p8UjGnxnNr7HqDEU
         ApDzGg+F7l4Eafy7yMJbRypLf1Fl3j08OtZG8IyXLWs4oyVZIzZ6AIRx+U2z7LzxL2Y5
         Wyxg==
X-Forwarded-Encrypted: i=1; AL+hErHcKnX1GpUpU/nA+s2WV1ttQKIr9ABVXLLJKn67V83ZRHk6FTKSmNVGHVT3ZeCMjIzPTKc=@vger.kernel.org
X-Gm-Message-State: APuU4Z9H3baVWa5J/JHFlYn6liYzPtEnslHT71DERw1ceM/u/B1toFTP
	agEk2tObIvYV5cP4wrC/+uGcsDS005pq3hh1MyTSvDgpp1BV3KCRc3zvnGOZq2olbNrTGofT72d
	pteTE6Q==
X-Received: from pghq11.prod.google.com ([2002:a63:e20b:0:b0:cca:d82:9104])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:117:b0:3fa:8c02:b425
 with SMTP id adf61e73a8af0-4014e063382mr1285522637.71.1795132627605; Thu, 19
 Nov 2026 15:57:07 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 19 Nov 2026 15:56:54 -0800
In-Reply-To: <20261119235656.70315-1-seanjc@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261119235656.70315-1-seanjc@google.com>
X-Mailer: git-send-email 2.56.1.708.g77570a6a1d-goog
Message-ID: <20261119235656.70315-5-seanjc@google.com>
Subject: [PATCH v2 4/6] KVM: Don't kick offline CPUs when making a multi-vCPU request
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Satish Kharat <satishkh@cisco.com>, Sashiko Bot <sashiko-bot@kernel.org>, 
	Oliver Upton <oupton@kernel.org>, Marc Zyngier <maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Don't send IPIs to offline CPUs when sending a request to multiple vCPUs,
as it's obviously unnecessary and sending a reschedule IPI (spoiler alert)
to an offline CPU will trigger a WARN in x86's native_smp_send_reschedule().

Note, as explained in commit 85b640450ddc ("KVM: Clean up benign vcpu->cpu
data races when kicking vCPUs"), checking for an online CPU is inherently
racy, but losing the race is functionally a-ok.  I.e. the goal is purely to
avoid tripping x86's WARN.

Suggested-by: Satish Kharat <satishkh@cisco.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 virt/kvm/kvm_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index d2a858d4b8e9..07cc0dd10b71 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -265,7 +265,7 @@ static void kvm_make_vcpu_request(struct kvm_vcpu *vcpu,
 	 */
 	if (kvm_request_needs_ipi(vcpu, kick->req)) {
 		cpu = READ_ONCE(vcpu->cpu);
-		if (cpu != -1 && cpu != kick->me) {
+		if (cpu != -1 && cpu != kick->me && cpu_online(cpu)) {
 			kick->need_kick = true;
 			__cpumask_set_cpu(cpu, kick->cpus);
 		}
-- 
2.56.1.708.g77570a6a1d-goog

