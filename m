Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E928511E8A
	for <kvm@vger.kernel.org>; Mon, 21 Sep 2026 19:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790018064; cv=none; b=CBgYWNgx59PYxEiIdInFtKTr6p6WKFvNgyoogcI7jD8MviIBvmWGFxcyZyPLwVfOEkOb+rUEWhmfUsza1m1dQn9SeRWLKUJYGGuxq/6xb988bLNeq4dUf3Fa315wujS7lNlOYXXxhQnfIFgMfA98tWoO35JbRsgiIo2ySDozcpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790018064; c=relaxed/simple;
	bh=vAIXgaa3DfXA+KfQ7T0dYWQlch3LEAa8mJXRZ7psQFE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OIo2/fGrHSxCA9xevuKDZTlW8t493FioMzHehhZmTzzaSUwlOe4jY8O4lNVd17i0qNcCFG+8Fa99qu/OxsgeRxKEyMFPRJBzYhK2KKJPBkf6tfPeAlyK+No7QszVMUpccufYcNYbdmlZpUFwjgCupOXSrre/w4oGiW93rxQIedk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Cjfmm1cJ; arc=none smtp.client-ip=209.85.215.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Cjfmm1cJ"
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cc1ca15334cso3969475a12.1
        for <kvm@vger.kernel.org>; Mon, 21 Sep 2026 12:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790018062; x=1790622862; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ie4lRRGMB/QtuXR80ZTHBxhVpLqodwwh8z23GPtWOvk=;
        b=Cjfmm1cJvfCsFtfC/K9TJ9Pa/LZKm2ng0tenSA2FRdLeZ/dD2aP+l6yZQHh7vnfmww
         0hC2KksVA4MHTmBAyg4RRX2+WaHbYuch9lcdZ4XDkJizYOBHwzL3pw14tg9In3rgM50a
         9YCrWo6HCTWOU4Q0g9PWVxDMzj3vjj3G4ROYK/n9DMKZ49lyIySWeTGaZtqk4Cqn1G46
         AMJLLh44tB184TkTTAxlKRMYj5f7TISpqGPWBx2issSxcS4/UUXBR9wSXeCy3u0kIm8g
         GDNsFwvwkU1I06NLO3vQT9pFo/ulTLtRPEUm/b8IbYUOqNdG7gFInoRGap5nIvMXJhQn
         HvOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790018062; x=1790622862;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ie4lRRGMB/QtuXR80ZTHBxhVpLqodwwh8z23GPtWOvk=;
        b=Cjo2xPs0BQZkA+7eG4R+H5f2chWP6SZadagOIAgq+G1rOKjqV/b2ynXKtHI2/D+Eri
         RLzQtIjWxFQd89jtbdUNnji4WMG/2dOfwPVTB1n0GJI/PjeloImcLAj4EecjEE/M7G58
         VYpsTBEiZ9NuywnZB0vCjVECvPJdOsmrQg4Ru0o1eizyVsE1I07oi3oi09mPx7R6Up7u
         BLLM1I/ICJD4lc/3dtKyRzBXak4z9n4G1awEhNrW3E8dCzgJnX9pwaZG63Gbw7DZnxF+
         DOA7zNqdn2GZguopALfdHZC67W2KqcGoIGUWi3f57l4DkUSHumacaJx6ryzp2ZGECh/D
         eYVA==
X-Forwarded-Encrypted: i=1; AKwUvBwSnUooDtFF4zHggi5Sv6MsSbeCuUcHmyFMWHTyBMCDgcf0y0VJA426cxR1nRcnza+ZFHQ=@vger.kernel.org
X-Gm-Message-State: AFuF++m04TS21I+P9Nc1AigW+7Jq7Mp7z78pVHwGi8hoynhjsB7/YFLi
	WpqFWcvOGj3Ziq0Hm936FgjPHYv1u6txCPwAJIoXxLEvGt6iO7gLVnwqVTzeB6XkzZHuEnueHh4
	FtbE7mA==
X-Received: from pgdj21.prod.google.com ([2002:a05:6a02:5215:b0:cc7:4a9d:af5f])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:140a:b0:3dd:a196:69ec
 with SMTP id adf61e73a8af0-3dda1967806mr11525924637.71.1790018061422; Mon, 21
 Sep 2026 12:14:21 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Mon, 21 Sep 2026 12:14:09 -0700
In-Reply-To: <20260921191418.950933-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260921191418.950933-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260921191418.950933-2-seanjc@google.com>
Subject: [PATCH v4 01/10] perf/x86/intel: Ensure guest PEBS path doesn't set
 unwanted PERF_GLOBAL_CTRL bits
From: Sean Christopherson <seanjc@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Jim Mattson <jmattson@google.com>, 
	Mingwei Zhang <mizhang@google.com>, Stephane Eranian <eranian@google.com>, 
	Sashiko Bot <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"

When reinstating PEBS counters into PERF_GLOBAL_CTRL for a KVM guest, mask
the value with perf's desired/original PERF_GLOBAL_CTRL value to ensure
KVM doesn't unintentionally set reserved bits in PERF_GLOBAL_CTRL.  E.g.
if the guest's PEBS_ENABLE value had bit 63, "Enable Precise Store", set,
then using the raw guest PEBS value would propagate bit 63 to the guest's
PERF_GLOBAL_CTRL value (which thankfully would be a failed VM-Entry, not
a VMX Abort).

The only reason this bug isn't reachable is because KVM doesn't support
"Enable Precise Store" (which is probably a KVM bug?), i.e. bit 63 can't
be set in kvm_pmu->pebs_enable and thus not in arr[pebs_enable].guest.  In
other words, this _should_ be a glorified nop in the current code base.

Fixes: c59a1f106f5c ("KVM: x86/pmu: Add IA32_PEBS_ENABLE MSR emulation for extended PEBS")
Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/events/intel/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index e36f340e2dc2..f4674d93a5e2 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -5392,7 +5392,7 @@ static struct perf_guest_switch_msr *intel_guest_get_msrs(int *nr, void *data)
 		arr[pebs_enable].guest &= ~kvm_pmu->host_cross_mapped_mask;
 		arr[global_ctrl].guest &= ~kvm_pmu->host_cross_mapped_mask;
 		/* Set hw GLOBAL_CTRL bits for PEBS counter when it runs for guest */
-		arr[global_ctrl].guest |= arr[pebs_enable].guest;
+		arr[global_ctrl].guest |= intel_ctrl & arr[pebs_enable].guest;
 	}
 
 	return arr;
-- 
2.55.0.1082.g2b9226bbc0-goog

