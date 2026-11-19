Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795132627;
	b=C4qZfQUe9kJNku1cMiikYrbU3/Xknq/N+HuWV2TbQTy3Bilv3IQuGV/8+oOTr1hKL/St
	 F25U/I0tdYW5bAdVmiMb4ayFuvNENXJ885lfIgJl2TF6ymLlXVUR4nBXVjFgwmmPKHENh
	 VWFtYfyELJWNDyWa5M2le0o/v7Ni9QzO7s5BXQ1h+94I8F7eo7//QWgb7SiIHwsVAbihx
	 2/NsjSEf9fztjJFu8sF3UEO/yR179D1dvQTR3U6OwQtHutd+SvaZNk7GuiAkrW230PGU4
	 5fAx2e235lU5ghoSApo5PLg1LVAMNs7lyyChaEEBsSEBbNvrFkTo8K6vGLFe/7655UA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795132627;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Reply-To:Date:
	 In-Reply-To:Mime-Version:References:X-Mailer:Message-ID:Subject:From:
	 To:Cc:Content-Type;
	bh=gM4vnmwuXxpV8g+fimXi6z6mdMxlZfIoGvYynlO1wGY=;
	b=YDtrpCKyFn64+tUnf8FMPw6HbnMQs82OkjQZIuknwwZhgH+QaWqDB14IlGeGmCbMWO3P
	 KZaBn+zf/5jlbtKaYlh9wBtJXpUp93jPaBK0iyXXPotIJK7y6pO/WGjSib3etrqdzlpz2
	 x/WeiydyFNCekSNcqmwpsJDZ/AsJQnzPZJ4TpMLYDspY/BpK0TqNZ6zcfctugPR4EE7w4
	 P+zosLnP5hFP57dVEhzai5qoKZIle6KgN8Lpe0lNzwnhyDzAGpRyo7JOCCxvrrgqOBIXu
	 pdKRN8pHSPGJL50hCuCKVHqW/E3kTXfbzfqTlqwZ7K5YbyjC9Lhfgf44OyGIE2I88eA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=dpdh8jTz;
	arc=none smtp.remote-ip=209.85.216.71
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2911260A261C
	for <kvm@vger.kernel.org>; Thu, 19 Nov 2026 23:57:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2911260A261C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=dpdh8jTz
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3adeba76cadso290711a91.1
        for <kvm@vger.kernel.org>; Thu, 19 Nov 2026 15:57:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795132626; x=1795737426; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=gM4vnmwuXxpV8g+fimXi6z6mdMxlZfIoGvYynlO1wGY=;
        b=dpdh8jTzYcniWZVv6EBc0/fsVLm+8auPPCEyGd0B6GbEwJWtzDVAMtJPQkqJvWSAqH
         V9gxdpo+x0KtPAaIqqSJ5EVSAqGcxkaYxJWmbvhgPfd3dV33DTu0Fcv4CjmXiCSlZX2e
         jsTr+0bv6evtFRhw3AzEInm/ubhW8N2JKql6eBywabPXwy2u/WlxTbWdemW1TmM/kL0i
         L4bAd6nYEj/sgBLSs4S8dkJ4jI9VcspG0kiUpVOfLtYxZl32IYbNtcEm+6yn1rX3FfID
         o4/OJmQlKe5rJP1ZTYUMsecrDfgLWMR2EaGOW9whyJQWprY9qDbxqWeWxwlzQieu8/uw
         /BsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795132626; x=1795737426;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gM4vnmwuXxpV8g+fimXi6z6mdMxlZfIoGvYynlO1wGY=;
        b=Z9V5fcMUEfo9ymJ9OXkYu2rO6f7X3EnuSJ4/G1CTtGBoyA/8V9zG/r7UEwA4uHOLvx
         iCfKNwylHQ/KtgAHTlXJ483ddmiusl+s/MqmXbr2iiypJHAXgnBhcmSzz5M56dvh7SRQ
         eezvEEk9Jt7MigIiZJ6KWyE6xlqw8I6Z7ccWXyOpOxCrViiRJ4tsPLJocH2WdX1GSRN4
         wf1H+75F9Tz6JyhWrGeaG8ahmSQhTYQRD6IgvjbIzIQj6xz7eCfYRq0kqgwnB626/Ybf
         VXDUJgKKIoOgXGFBcyQoFNp4cmXuKntakRo8rFBrs3mSYT/SeNKg5KHmF03Dzi91QQiZ
         m9Bg==
X-Forwarded-Encrypted: i=1; AL+hErFLVMXHZ4aV2a9OzUEZel2KOJJjMwo5V2cihtTHaDZqM4pFYj8ej7fzbowKeLX3RjsPZDE=@vger.kernel.org
X-Gm-Message-State: APuU4Z/Pn6cZzUR8xExi0fEVvgUtK0Gfc5WOQ3x3Wt2fh4XYghm2jbFg
	RQjz+0DLLFDRyzBXNdKAknzJ8Fcd9SOHyLhy4MzMvYBZDnx3NeGgXUBpk1gy3pB2uS/svBDkm9E
	TcxJBzg==
X-Received: from pjxi18.prod.google.com ([2002:a17:90a:d352:b0:3ab:4cf:7b95])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:17cd:b0:3b3:ab8c:c7e5
 with SMTP id 98e67ed59e1d1-3b41c95f65fmr916458a91.56.1795132626293; Thu, 19
 Nov 2026 15:57:06 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 19 Nov 2026 15:56:53 -0800
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
Message-ID: <20261119235656.70315-4-seanjc@google.com>
Subject: [PATCH v2 3/6] KVM: Add dedicated flag to track if multi-vCPU request
 needs at least one kick
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Satish Kharat <satishkh@cisco.com>, Sashiko Bot <sashiko-bot@kernel.org>, 
	Oliver Upton <oupton@kernel.org>, Marc Zyngier <maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Add a dedicated flag to track if a multi-vCPU request needs to kick at
least one CPU, so that non-waiting requests can avoid using the per-CPU
cpu_kick_mask by immediately sending a reschedule IPI instead of populating
and processing a cpumask set.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 virt/kvm/kvm_main.c | 22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index c2231a130c4c..d2a858d4b8e9 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -213,19 +213,11 @@ static void ack_kick(void *_completed)
 {
 }
 
-static inline bool kvm_kick_many_cpus(struct cpumask *cpus, bool wait)
-{
-	if (cpumask_empty(cpus))
-		return false;
-
-	smp_call_function_many(cpus, ack_kick, NULL, wait);
-	return true;
-}
-
 struct kvm_cpu_kick {
 	int me;
 	unsigned int req;
 	struct cpumask *cpus;
+	bool need_kick;
 };
 
 static __always_inline struct kvm_cpu_kick kvm_init_cpu_kick(unsigned int req)
@@ -242,12 +234,12 @@ static __always_inline struct kvm_cpu_kick kvm_init_cpu_kick(unsigned int req)
 
 static bool kvm_finish_cpu_kick(struct kvm_cpu_kick *kick)
 {
-	bool kicked;
-
-	kicked = kvm_kick_many_cpus(kick->cpus, !!(kick->req & KVM_REQUEST_WAIT));
+	if (kick->need_kick)
+		smp_call_function_many(kick->cpus, ack_kick, NULL,
+				       !!(kick->req & KVM_REQUEST_WAIT));
 
 	put_cpu();
-	return kicked;
+	return kick->need_kick;
 }
 
 static void kvm_make_vcpu_request(struct kvm_vcpu *vcpu,
@@ -273,8 +265,10 @@ static void kvm_make_vcpu_request(struct kvm_vcpu *vcpu,
 	 */
 	if (kvm_request_needs_ipi(vcpu, kick->req)) {
 		cpu = READ_ONCE(vcpu->cpu);
-		if (cpu != -1 && cpu != kick->me)
+		if (cpu != -1 && cpu != kick->me) {
+			kick->need_kick = true;
 			__cpumask_set_cpu(cpu, kick->cpus);
+		}
 	}
 }
 
-- 
2.56.1.708.g77570a6a1d-goog

