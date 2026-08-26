Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22E0B48C8C7
	for <kvm@vger.kernel.org>; Wed, 26 Aug 2026 21:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787779997; cv=none; b=TygPi7KPkDDk17xoTzm/OS0N4U8rEtwA+f2VWbUf5wqWHdRxIh88qpTS8EslCMTzaTTjOBb+LzaZMZ5iA4c9AwSzqUB5N4xYrf41Sr/NRO+GCSBYBswrsGktO9hh0SXgvh/J3EGiqcPqEv5OfAYqGg45+oOrPlv1cPlry0bDTgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787779997; c=relaxed/simple;
	bh=1dubEWiH+wDpaRTr6xDH5FSSCgfhV3tA2a7yb409fro=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Oo7wCRhlR5fo40V266jjqXOoE/poGfmaedNm2SzeF1FcYtQEhdkdDzM0hsDE92uwOP9HjoGEckQ9pMWdmbS7RYsgXGX6vAgp5JPDouHUnJnSBXHNnDo7t8nyYEkiAwIjOcFTNLHQm3d7y/YvP3MtXqUbWLBA1OtEUiysqmpCEWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rvp5AY2S; arc=none smtp.client-ip=209.85.214.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rvp5AY2S"
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2cfe48ca1efso22104495ad.0
        for <kvm@vger.kernel.org>; Wed, 26 Aug 2026 14:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787779995; x=1788384795; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=iaeGWHwlG+AWk9QHVwY9V6qXxKpEzxckDrOJKqWFOA8=;
        b=rvp5AY2SqLRucYy7MFVva3mw9Zl9G3aLWfuJouawTo1NwwhJLPALb4wkkOnClPIYT0
         FRl8ihJQmHzjKHcR7limoh7n6Ql7snRhviz6Afz5/zGeMBao6ZuSJ1EPaVsMWFBUMtGP
         iXaLICt8ucwFsEKfVuj25AUQCJ19e9MXnAvZKQ5h1d+Xe0NfiuKwcaFd7Qc0azlfBrQH
         HJgxtl+wuDwvPROgsFPZmgFeexyTCQjWzdaysgRqJmWso3VMyXz1h1mo4YmD/gEmCi97
         MtlXp7Hip17f5cicXEV76DT5ZbzeEhwkj5Mu8r+GhSkg/5q0C74NdOHjhwFu5m0oa0uz
         YVoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787779995; x=1788384795;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=iaeGWHwlG+AWk9QHVwY9V6qXxKpEzxckDrOJKqWFOA8=;
        b=jRBCtrveIkswiZdXEZ594nFfncLl/mWj0dGCWfYEz3B1LC9MBHJ8yP6Z6rrV3/0MTZ
         pRxl2F4CZPZHbvUtpt1Pvzv1V06M6vUHLS63b5F9OTsLCYnp4PfYT6e7O6fPxSKKriAn
         rJFNdG3/gTVWTF0zvTPJMIdjY/15Hfm7p9YDyv+kJapof/jIRA40kjp0seZUmiDV2NAC
         YFwKz34aQbveYmJVERKUe67tYYjciMnei7H/qmmXw/vpTysccWHS2YB/RV9eb01ohVWH
         GszbWb1F3MtylNrHMQNx9YS5BKvGm341fMuI+axjLErrKsiYwN7vXXSFsU5glV5uYcUJ
         rQew==
X-Gm-Message-State: AFuF++m1CCQMu/vGIGTuhAYSq6kCgDRbY68O/zKb6UFFkgb/MKAjIWvT
	4kyqaRVBVefW808TeVeLF2TVFKyoftvRdaELpBaVGto/o5gGGk8kVspGjf/iYuzJAecuQe+2/qa
	wphwkYw==
X-Received: from plbmq13.prod.google.com ([2002:a17:902:fd4d:b0:2ca:cf09:91ca])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:120c:b0:2c6:90ec:f601
 with SMTP id d9443c01a7336-2d707aaad36mr147369515ad.8.1787779995135; Wed, 26
 Aug 2026 14:33:15 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 26 Aug 2026 14:32:49 -0700
In-Reply-To: <20260826213303.914988-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260826213303.914988-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.887.g758fc8c411-goog
Message-ID: <20260826213303.914988-10-seanjc@google.com>
Subject: [PATCH v10 09/21] KVM: x86: Wrap all of __get_kvmclock_master_clock()
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
index 4f98cc71a671..64df8da3aad4 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -1656,8 +1656,10 @@ static unsigned long get_cpu_tsc_khz(void)
 static bool __get_kvmclock_master_clock(struct kvm *kvm,
 					struct kvm_clock_data *data)
 {
+#ifdef CONFIG_X86_64
 	struct kvm_arch *ka = &kvm->arch;
 	struct pvclock_vcpu_time_info hv_clock;
+	struct timespec64 ts;
 	u64 tsc_hz;
 
 	if (!ka->use_master_clock)
@@ -1674,27 +1676,24 @@ static bool __get_kvmclock_master_clock(struct kvm *kvm,
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
2.55.0.887.g758fc8c411-goog

