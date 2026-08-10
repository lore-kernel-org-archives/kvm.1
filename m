Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B69F409295
	for <kvm@vger.kernel.org>; Mon, 10 Aug 2026 22:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786402519; cv=none; b=LRKZgow91VudLXwFhRDOg0DfewfQphWPnCt2IrVQoT1g34QY9PStmT0RslKm8QZV4/4OFcdqwsXPgt3wsQVJPCgoSe2USrx6vMxBPilnwewzlwe05QgAbDBpnpinIO/LTPO6Y9RJGpsPXvPrqYLfLqC9m2H+fZkPm+1Id/1oWrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786402519; c=relaxed/simple;
	bh=CVnhoSX+qbZJfZo5pFMAK6JiunEH6jHp8TBgm6WOvd4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KTBDzt6vQDvIj17XfzrcaO/vjtZPQuLcWRThtSxTtvKPuu4Bh5fy5ZXBUH9Copgy8i+6fQ/wcyU5wMWNoB9ED8A/nakUT6ay3FzvAWVyDku++7kSdsNeRndPcMw0p9XnCKr2uO9UwWQHk2oeB+w3W/YqxfEpWnh6qXxQmkQazl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MdkUwrYq; arc=none smtp.client-ip=209.85.210.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MdkUwrYq"
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-84a3514f912so254321b3a.3
        for <kvm@vger.kernel.org>; Mon, 10 Aug 2026 15:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786402516; x=1787007316; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=yh0HMLDRPnv1g8EvjLjzH3sEAJckmpo3zknzdaSQGA0=;
        b=MdkUwrYqwbEjvaa2hHVkhcr5GcewoRf6eeL+KaP6g6GCI80+rWxQFkvmnVv5WH2i7e
         gcuLGK3mq2eQIbreTPAxg0m9AKXpSpEzmQqv95WAn+W8oPiplCWQYDgkTCpuU4DpZEnC
         AaYYfdl/3uDQxCm/Iw06JA77L9hS7lFezbUO9oeQIs1nUsSHT11aPJAt+O4GGoY1JI34
         IaLovgm+FwYlE8giABRP7pXx5gwvKNeznoLIcJrleVwgXlNBlfglrCfzfeDXtu+WOwqH
         Rjbf36Oe+LesMUnKt11mKCu/CgLnc01or1CKZzIW2Oo376N+Xh4rjRtro2j4ZmU5YTAU
         zZzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786402516; x=1787007316;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yh0HMLDRPnv1g8EvjLjzH3sEAJckmpo3zknzdaSQGA0=;
        b=LSrbXcGbi0u0OQRPcMUs1gz4742vM4OucHZVJDgkjA4Mhu7e00kj5oD2YUyIfXHTJM
         BoEh+HsUZAyhAlMcBqkNqTJPM2iLbIjJSz4THsCxSbXPdq6JU9cP0VQT16yRaIQyQw1s
         OiEbJgymv8fyMSTBGDtsZ6gLoq+Q7JbIfc1Vp5q+Vj2vKAQy2EdSRklN+NmxdeScInyx
         fuc97829O8JLBrhRA5URlBl3SMY4Of6GXf5fJaqydTBc/Ocsy+P5cjQ0/nkWmwm1XxhA
         2EOToLLI08l7r35VfHFVNnCMS80EKcELFHHEI/c6A0rnCLo2YKFbTK5xFnQg4b3SKFCA
         wz4g==
X-Gm-Message-State: AOJu0YwNyxf/5sAkNZYgdDpilIoqkch1RsAEBYtl+RuQb2B7NH+QJtZ+
	1kYFMzO39dS/iEH02ZxCuzPngFkBD6K3bu63l7TyuiwHGrC+Zpy607hpAYnhMTKH/Dmwb6j1tfF
	v+MkEcg==
X-Received: from pfbc4.prod.google.com ([2002:a05:6a00:ad04:b0:848:478d:6efb])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:94e7:b0:848:3f91:da82
 with SMTP id d2e1a72fcca58-84f2e12c1fcmr51167957b3a.32.1786402515490; Mon, 10
 Aug 2026 15:55:15 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Mon, 10 Aug 2026 15:54:48 -0700
In-Reply-To: <20260810225500.869288-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260810225500.869288-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
Message-ID: <20260810225500.869288-11-seanjc@google.com>
Subject: [PATCH v9 10/21] KVM: x86: Fall back to non-master-clock if clockread
 fails in get_kvmclock()
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Paul Durrant <paul@xen.org>, David Woodhouse <dwmw@amazon.co.uk>, Dongli Zhang <dongli.zhang@oracle.com>
Content-Type: text/plain; charset="UTF-8"

From: David Woodhouse <dwmw@amazon.co.uk>

When computing kvmclock and it's currently in master-clock mode, fall back
to the non-master-clock path if the clock read fails, e.g. if the kernel's
clocksource is transitioning away from TSC but ka->use_master_clock hasn't
been updated yet.

The rdtsc() fallback was added (well, kept) in commit c68dc1b577ea ("KVM:
x86: Report host tsc and realtime values in KVM_GET_CLOCK") purely to avoid
uninitialized variables and compilation problems on 32-bit kernels (already
addressed).  In hindsight, keeping the rdtsc() was a hack and a mistake.

Link: https://lore.kernel.org/all/CAOQ_QsgVqS_PuJo8F10Gg5Xw+tKt+5gDx+kJf1j3CiPO4MAOqg@mail.gmail.com
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
[sean: isolate from refactoring changes, write changelog]
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/x86.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 304e078cb899..33ba840d3267 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -1674,14 +1674,13 @@ static bool __get_kvmclock_master_clock(struct kvm *kvm,
 	if (!tsc_hz)
 		return false;
 
-	if (kvm_get_walltime_and_clockread(&ts, &data->host_tsc)) {
-		data->realtime = ts.tv_nsec + NSEC_PER_SEC * ts.tv_sec;
-		data->flags |= KVM_CLOCK_REALTIME | KVM_CLOCK_HOST_TSC;
-	} else {
-		data->host_tsc = rdtsc();
-	}
+	if (!kvm_get_walltime_and_clockread(&ts, &data->host_tsc))
+		return false;
+
+	data->realtime = ts.tv_nsec + NSEC_PER_SEC * ts.tv_sec;
+	data->flags |= KVM_CLOCK_REALTIME | KVM_CLOCK_HOST_TSC |
+		       KVM_CLOCK_TSC_STABLE;
 
-	data->flags |= KVM_CLOCK_TSC_STABLE;
 	hv_clock.tsc_timestamp = ka->master_cycle_now;
 	hv_clock.system_time = ka->master_kernel_ns + ka->kvmclock_offset;
 	kvm_get_time_scale(NSEC_PER_SEC,  tsc_hz,
-- 
2.55.0.679.g6767b8d81c-goog

