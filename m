Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795132624;
	b=hCVn2lbsUxgymrUY13wrCg5H7JPZSkYoeARmxtIpCg+RJuDSAOE1a6KFxFHx8+SbGSHk
	 /kywQae3dtSPFgl3w/lbtgcUJ2oK+OX6KQ9eoc/eJBfTfzp/0q3lNLMREe0jjuNsGqe7x
	 YdoRvbFrlLb36mHi/+EG+n67RC6ZDSXPgHFdRsBPrfFYqafj6yypIR1+3ASf4MERJqbau
	 HJbzkAzDIrpOBZvykMAna/tiz4vQgpRIHSLY7kkrPkm8F78P0UPENCsEAM3Ll3GDn4183
	 28EXvT1qC5nwHpdlPkmZO5wj3zMlvLGL5LmXyZ95CEx5bg3SKhhpoGO4eg87U5uK0QQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795132624;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Reply-To:Date:
	 In-Reply-To:Mime-Version:References:X-Mailer:Message-ID:Subject:From:
	 To:Cc:Content-Type;
	bh=L/9YEgi/3sLjfpLI8+sqz7+JmJz5Um7hXKDEJ0PhXdM=;
	b=legyAdAgwqM1TgFkqMwPJ3aNKadECEsQNpLp8pAg/iMSDKk1A5Cra37E0r+jTT6Ql+lk
	 +8zPhqLeTnF1aKK5H+b8uNT8b2ryEbBnNbgOhFVNwX7yPJvRmQ4YwKaMO8tIX22gyrkXM
	 hJ4fxWGvGeiBOuMr3wFZrnAN/9ylRgu0kcmIEBOMFSGqlsXU+/sFjbRi+01BBSA8ZjxPY
	 l03tyoEc1CZmFnGgJRAJxpK3RvzLBdoDQQ3BPrJKDcPv2+B+p8UrH601LYOZtJrnLocH3
	 9ZzPaWk/dtXF8Xj7DkYmU25l4zr8KghKc+eV9utq4wtz+kZDy6mLpmhc9psYAw6z9yQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="PAry62/4";
	arc=none smtp.remote-ip=209.85.214.197
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E408D606A337
	for <kvm@vger.kernel.org>; Thu, 19 Nov 2026 23:57:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E408D606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=PAry62/4
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2efe8f2bdc0so2341025ad.0
        for <kvm@vger.kernel.org>; Thu, 19 Nov 2026 15:57:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795132623; x=1795737423; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=L/9YEgi/3sLjfpLI8+sqz7+JmJz5Um7hXKDEJ0PhXdM=;
        b=PAry62/4oxVzFZteaU1fyEqCyJ4HTfY8Y3WDPQyXP8vJAuk6zhwziep7jga5ANXCmT
         ezsg5LxIGRW2xKgElL510fHB5GyGDKcdo74HKDovUNxs+WVVlJjRRxqzi2tSRt8nqF36
         xByfXdevU/I+rnYrWtCyDh5yD50DdfKgG2HfbhIecj39qwjyM6M8KUDROkjcTnjq2vyg
         fnuIjb7VMC8xjKR+8ma2Dw3/gBP0H14BcTizlVCaKLTplk8Yz49QzOEucmAaAPnpZSDa
         YtCXYSgtYWkZHYgOu7h2RZTdJyJcDJk9+sAfw+6zzV+bzJqtq9tZdCb3unNLoVI9jPBV
         xT/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795132623; x=1795737423;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=L/9YEgi/3sLjfpLI8+sqz7+JmJz5Um7hXKDEJ0PhXdM=;
        b=Jth9r9Gvar1aZXEckEus30vr1+VZG1Be8lPjZAKHhWuSx3Pk7IOZnWtgMCvREDJXc0
         X/qYsr30H3kki84qcpvdc86WyRb/7sfjxLJW/XbUpBPd1fT5sBOWyZkPEMecF2vMA2O5
         eKF5PNyZ5B+4TJK6a46RXl93z3dKuL12IDiP/80cEfz4y8ztrOuD52KEIsdBD9uq6dlz
         tRZZv5PXOFL74YAlyKUp+6tEss0/FxGIOQ2BDReU3gxKNOUoNGxjkKPDHYH0Cy5WGrXP
         GJJsFSi7CStafu1krOsUHYogHlsaIDiF0QKm1PUuK9Ebt8cnOTdDirIMRvNQozhA/oS6
         +nQg==
X-Forwarded-Encrypted: i=1; AL+hErHqU53rRVG3pSMahymSz3qkvQDqq0rM9FiresGaIOEXZ80QbfcI8HNao18B8D/HaABpLyE=@vger.kernel.org
X-Gm-Message-State: APuU4Z8Ud7SDzl2/PcR28y0p5DNjOiy0J4E1UJx8wwkEcLRCqldd53r/
	XY+y9TBaDljlWggYvmXSIslqxXxZE/paqIjscz47BeU6TXqf5VnftjtoJXTrutd4jCKUrWM1B1Z
	hF0jaYQ==
X-Received: from plgy16.prod.google.com ([2002:a17:903:22d0:b0:2ef:d980:1df7])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:c410:b0:2e9:87a2:b4f8
 with SMTP id d9443c01a7336-2f03f17003cmr14915865ad.29.1795132623137; Thu, 19
 Nov 2026 15:57:03 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 19 Nov 2026 15:56:51 -0800
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
Message-ID: <20261119235656.70315-2-seanjc@google.com>
Subject: [PATCH v2 1/6] s390/smp: Export arch_smp_send_reschedule() for KVM
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Satish Kharat <satishkh@cisco.com>, Sashiko Bot <sashiko-bot@kernel.org>, 
	Oliver Upton <oupton@kernel.org>, Marc Zyngier <maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Export arch_smp_send_reschedule() so that KVM can use smp_send_reschedule()
in common "kick vCPU" code without running afoul of build issues on s390.
KVM currently uses smp_call_function_many() when kicking multiple vCPUs,
but several KVM architectures (at least arm64 and x86) kick vCPUs with IRQs
disabled.  Using SMP function calls with IRQs disabled is unsafe as it can
lead to two CPUs waiting for each other to respond to the function call,
i.e. KVM needs to use smp_send_reschedule() to avoid potential deadlock on
other architectures.

Alternatively, KVM could go out of its way to avoid smp_send_reschedule()
on s390, as KVM does when kicking a single vCPU, but given that all modules
can reach smp_send_reschedule() via kick_process(), forcing KVM to dance
around s390 adds no practical value and would add non-trivial complexity to
KVM.

Note, thanks to s390 now building kvm.ko and kvm-arm64.ko, using
EXPORT_SYMBOL_FOR_KVM doesn't Just Work.  Exporting the symbol just for KVM
would also complicate backporting the upcoming fixes to older kernels.  For
now, keep it simple.

Cc: stable@vger.kernel.org
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/s390/kernel/smp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/s390/kernel/smp.c b/arch/s390/kernel/smp.c
index 32499cad86f0..39318aa7ab7f 100644
--- a/arch/s390/kernel/smp.c
+++ b/arch/s390/kernel/smp.c
@@ -531,6 +531,7 @@ void arch_smp_send_reschedule(int cpu)
 {
 	pcpu_ec_call(per_cpu_ptr(&pcpu_devices, cpu), ec_schedule);
 }
+EXPORT_SYMBOL_GPL(arch_smp_send_reschedule);
 
 #ifdef CONFIG_IRQ_WORK
 void arch_irq_work_raise(void)
-- 
2.56.1.708.g77570a6a1d-goog

