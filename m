Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D4893F39C2
	for <kvm@vger.kernel.org>; Tue,  4 Aug 2026 23:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785886777; cv=none; b=FCy581MYryZ0YHRseqXxk+eYaw5SPOOg1Nv/p6tP3URHUbvvlA8bP+RlaeO+GJPFXVnG9Oj7MyL1LqWAXO3iu77UVl2JXJ54OCDPC6yxQPmVQCvB4JLDx/UFMEY26bDBiurEhZtye7+sZzERLFKEB1ML9vOykdVgzuQW/UrFbAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785886777; c=relaxed/simple;
	bh=Kup2G3UCXJcE6WDasVFeEURcowEkQTfg5NMp3OJqWbc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hjKh8Uu4CJaEFTRuDGUpnF8boxw4HhjLavj/0S5fYPK426EAdQNtYcRBozrl7Go81mnfNx0IYmh7N2z/JKvjDyyoal41bEDGz1CPEojdmjOmz8ZWNSWettaXBkBXPMLjk8BlXX46kYGFQa+b7EmM87gSqmw75bJLk0cwtfHC1r0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=l7zHVuRn; arc=none smtp.client-ip=209.85.214.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l7zHVuRn"
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2cd01a14e81so4888375ad.1
        for <kvm@vger.kernel.org>; Tue, 04 Aug 2026 16:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785886775; x=1786491575; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Kc4cuBPkf5R+4x5JgDFzYooIArHsuaUyhf60HYNtLL4=;
        b=l7zHVuRnb4prtQmTkrHYR1tmqgmH3JQsa9JisQoqgkcK18Vtx3g2n0aTm6ATSWfAou
         B3efsqcFaJk69i46r03npgwoSo/bhKRQHh9YNANWTaVWI419HG/1se6f4hYFu2fAhKbc
         KVtPrTsViA4cKwCAgmzuVkwLQBRssmLWa7OU0T8GpcY2oh5geAAqyh8bU6IM2KDDAHEe
         UQtdtbArPFJQCwq4jSCNWX9QVLB/8BmWrl0NE5sxlLDQJ3QkMlrl9E9G6iKjZzKfj5Xf
         8rb8gFfxjhrD0HBm5L8j9b5bHkYT5buWKt6s32e3w7ACkkjrFImdXAuG6NqwAAeMiPkc
         JBxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785886775; x=1786491575;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Kc4cuBPkf5R+4x5JgDFzYooIArHsuaUyhf60HYNtLL4=;
        b=AMZo9I0RhOv7Ak+tZoaSwNG/oIluU2+EUeUTHiATz8HIprPaZlj4CW7yR7qWrHkZAp
         +oiruSqNtskvjW0EgAgxPaXQM06DBH1NfsY/mZo0Ti7W1SADbaljVS8Ec/Deh6yozUp7
         lq8cGwyuzdnjwfpGCvwMvxHdKZRPu7jaNFVny4jjfXocGvASQJCDi4lWje6wtAGiF5sG
         4Y10d9tmeNPvpFqEZX5GVcgQTbABoHCJBogXkkyoXYzJU1zn/D1IhEjhxTy6PI3mc2Pb
         4yABARDdROH/gPtnVDJgkguqqpjH2llBEmAvJ/KszJE3cUqsWt9xiITiTypOaewmtmxM
         A8rw==
X-Gm-Message-State: AOJu0YzE88/adKCaSPwmV1XTuNUusBGl7XBOpgcENSX3tIosd6Jo8TvW
	F9jga9NepjI4vpqtz8ho0u4B6zGsuD+w6UfD8o3Ffw86xVFSyZFKjMv9yk4CXDZG1v2UIKU84MD
	y85OdVQ==
X-Received: from plge8.prod.google.com ([2002:a17:902:cf48:b0:2cc:89b8:4244])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d48b:b0:2c9:cf62:6f61
 with SMTP id d9443c01a7336-2d0ca78de48mr20399625ad.17.1785886775089; Tue, 04
 Aug 2026 16:39:35 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue,  4 Aug 2026 16:39:12 -0700
In-Reply-To: <20260804233923.3504629-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260804233923.3504629-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.571.g244d577d93-goog
Message-ID: <20260804233923.3504629-9-seanjc@google.com>
Subject: [PATCH v8 08/17] KVM: x86: Wrap all of __get_kvmclock_master_clock()
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
 arch/x86/kvm/x86.c | 35 ++++++++++++++++++-----------------
 1 file changed, 18 insertions(+), 17 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 8666bd0337b8..cd2a140e8e63 100644
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
@@ -1672,25 +1674,24 @@ static bool __get_kvmclock_master_clock(struct kvm *kvm,
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
+
+	data->flags |= KVM_CLOCK_TSC_STABLE;
+	hv_clock.tsc_timestamp = ka->master_cycle_now;
+	hv_clock.system_time = ka->master_kernel_ns + ka->kvmclock_offset;
+	kvm_get_time_scale(NSEC_PER_SEC,  tsc_hz,
+				&hv_clock.tsc_shift,
+				&hv_clock.tsc_to_system_mul);
+	data->clock = __pvclock_read_cycles(&hv_clock, data->host_tsc);
+	return true;
+#else
+	return false;
+#endif
 }
 
 static void get_kvmclock(struct kvm *kvm, struct kvm_clock_data *data)
-- 
2.55.0.571.g244d577d93-goog

