Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4806343F08C
	for <kvm@vger.kernel.org>; Mon, 10 Aug 2026 22:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786402517; cv=none; b=VoCv0P+bDg1IhreSt1x6YSQcXaxQfuQEYdb2mtKhjqCTlsyjswGC1gx4kx0fnCHBr9Q7dME6igF7+AaHOmZquGSmbS83tZ3e3gCc/qv6ygf9uHmD3uniqDYP8zgrJ/BI0t7IsDyg80HkDNzNxP08O1RHiNOXjK77aKDFnjNP5lM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786402517; c=relaxed/simple;
	bh=qNv8wRrrsf5etbgikyiwqNy77PWXJvJYdvTzSRxJjfI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZLeK3WO5LyVllxGizCqysKhqLJ7JlQS04UxqvOCkkut4flbjqxs/GIw90Rzpe34c4mDZAUCfFdsZLkdGvv2FdkjkXBVBf8u3jttZvk/jJZvX9c+cO0t/b5mBTr5wQZnBAKMnjRdYaOpfni0dUlp1qMrc9/vouF8lrPt2uzlWKcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vFTdQYRL; arc=none smtp.client-ip=209.85.210.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vFTdQYRL"
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-84a67b16217so4065068b3a.3
        for <kvm@vger.kernel.org>; Mon, 10 Aug 2026 15:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786402515; x=1787007315; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=NF22hvAqvnv8oGw6Z0I6Swu4/ndBgLj6LoZAVm+Ye+k=;
        b=vFTdQYRLANcV5cHsLh/BSMEcbtqgeF864QqYobER6f8IHw/Zua5gfgLw8xpkYI6SRb
         oBSy8eb31mLsLJA2cqCOd20qqKWRIZvDCp8z+/lzJuobGwmV73n9xUlqt/cbBNcOkYtn
         uNAyrvAuRwG7ZOsso4NrKsfbJXC+eNnPcOXS0ZpFdmRCpJ6qxvv6tZ5kgbFa16R7us6z
         iStA10aOWc/EpKHxUHbhG5rkD4lUu6TmpPQH7GUw1l+8BNGeL131UGfyFv0kkZj0wt61
         Vhu38O3Q0YE3wevAVKhjFCJ0/Nh5EweXQBt2ateAgNudaA+I9Sgs06+1WkXKBc5Ya5gF
         GYvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786402515; x=1787007315;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NF22hvAqvnv8oGw6Z0I6Swu4/ndBgLj6LoZAVm+Ye+k=;
        b=dfUEy7aLkSiRmPT1daFPlqUVAEIR1Zi28jwndGpHYaUlmNa8RU4bQMIaY5XmoRKYB3
         IYW5cJQ1SPIQv+vlakrzPPLzpoHelcB3IS25UUjqAtSxqePEcUP/DlcSWXm+iVFQffqF
         1Ia5+0AXidsL2IVkWoLLI7hRY3lwI8ZsWZRahzIssWdluUT8hOCntx1faE39LLMIHZ56
         XsMiEyhe4O4khS+5vyl5Bobo+8L6COMyeRggsIg+58ky5+CmZU+0IGLOcCMmmGXphaqa
         wd7TBrM5gaFCKRwvvpeQa6t9cJ+J1DPPy+/dmM9myWxi40O41MT4JtjwsCI0/diMebj0
         pGQg==
X-Gm-Message-State: AOJu0YyCyimLLgOupFYZ5uPHhyUDbCfVIMX0r/t5AilFwmVS6HJ9xnV1
	mcgA/kXMbFZE0sKTi0djj5Cd0MBWPI1c8Q2IifEn1tYuaAgGImcij8byyVhib3bd5jaJGG9qOjo
	bswXDwA==
X-Received: from pgja13.prod.google.com ([2002:a63:cd4d:0:b0:c9e:142c:425e])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:6ca4:b0:848:7e85:f208
 with SMTP id d2e1a72fcca58-84f6977b09emr29265155b3a.37.1786402514421; Mon, 10
 Aug 2026 15:55:14 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Mon, 10 Aug 2026 15:54:47 -0700
In-Reply-To: <20260810225500.869288-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260810225500.869288-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
Message-ID: <20260810225500.869288-10-seanjc@google.com>
Subject: [PATCH v9 09/21] KVM: x86: Wrap all of __get_kvmclock_master_clock()
 with CONFIG_X86_64=y
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Paul Durrant <paul@xen.org>, David Woodhouse <dwmw@amazon.co.uk>, Dongli Zhang <dongli.zhang@oracle.com>
Content-Type: text/plain; charset="UTF-8"

From: David Woodhouse <dwmw@amazon.co.uk>

Wrap the entire use_master_clock block in #ifdef CONFIG_X86_64, since
use_master_clock is never true on 32-bit (host_tsc_clocksource is only
set under CONFIG_X86_64), and declare hv_clock inside the block so it is
not left as an unused variable on 32-bit.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
[sean: keep only the CONFIG_X86_64 ifdef, update changelog accordingly]
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/x86.c | 33 ++++++++++++++++-----------------
 1 file changed, 16 insertions(+), 17 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index e0d623a122eb..304e078cb899 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -1654,8 +1654,10 @@ static unsigned long get_cpu_tsc_khz(void)
 static bool __get_kvmclock_master_clock(struct kvm *kvm,
 					struct kvm_clock_data *data)
 {
+#ifdef CONFIG_X86_64
 	struct kvm_arch *ka = &kvm->arch;
 	struct pvclock_vcpu_time_info hv_clock;
+	struct timespec64 ts;
 	u64 tsc_hz;
 
 	if (!ka->use_master_clock)
@@ -1672,27 +1674,24 @@ static bool __get_kvmclock_master_clock(struct kvm *kvm,
 	if (!tsc_hz)
 		return false;
 
-	{
-#ifdef CONFIG_X86_64
-		struct timespec64 ts;
-
-		if (kvm_get_walltime_and_clockread(&ts, &data->host_tsc)) {
-			data->realtime = ts.tv_nsec + NSEC_PER_SEC * ts.tv_sec;
-			data->flags |= KVM_CLOCK_REALTIME | KVM_CLOCK_HOST_TSC;
-		} else
-#endif
+	if (kvm_get_walltime_and_clockread(&ts, &data->host_tsc)) {
+		data->realtime = ts.tv_nsec + NSEC_PER_SEC * ts.tv_sec;
+		data->flags |= KVM_CLOCK_REALTIME | KVM_CLOCK_HOST_TSC;
+	} else {
 		data->host_tsc = rdtsc();
-
-		data->flags |= KVM_CLOCK_TSC_STABLE;
-		hv_clock.tsc_timestamp = ka->master_cycle_now;
-		hv_clock.system_time = ka->master_kernel_ns + ka->kvmclock_offset;
-		kvm_get_time_scale(NSEC_PER_SEC,  tsc_hz,
-				   &hv_clock.tsc_shift,
-				   &hv_clock.tsc_to_system_mul);
-		data->clock = __pvclock_read_cycles(&hv_clock, data->host_tsc);
 	}
 
+	data->flags |= KVM_CLOCK_TSC_STABLE;
+	hv_clock.tsc_timestamp = ka->master_cycle_now;
+	hv_clock.system_time = ka->master_kernel_ns + ka->kvmclock_offset;
+	kvm_get_time_scale(NSEC_PER_SEC,  tsc_hz,
+				&hv_clock.tsc_shift,
+				&hv_clock.tsc_to_system_mul);
+	data->clock = __pvclock_read_cycles(&hv_clock, data->host_tsc);
 	return true;
+#else
+	return false;
+#endif
 }
 
 static void get_kvmclock(struct kvm *kvm, struct kvm_clock_data *data)
-- 
2.55.0.679.g6767b8d81c-goog

