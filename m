Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA01A31717C
	for <kvm@vger.kernel.org>; Tue, 14 Apr 2026 19:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776194078; cv=none; b=Bjp3e/pgO6Y4Y4uUzJw9DkKUSQ/teJBvN3+GEL0HPI1IzbK4SuG9tnUG/sSK+5mBU2nbksc/eokfY9N35WcCp/NjE+ikyli7LvoFp86uFO+Y5U7Pt5YUcrdUbmXacBzOA3PjnlYz3icHgIPBDAsc4fnEsLxNRZY/U95IIntXvw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776194078; c=relaxed/simple;
	bh=d9A313GV9WgaQHzZDmV8dxWqw2AWoUgVAlRQ4qRl5Uw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Z3rDWcQqUpD9+oAWvbpgB59lFxba+9p+a0V5XDeNXhzQgw1CgcaUM7rFy0QAXxKVoM3Oo3TeeaSnkUObyyFwmWJQO8sZzVNpn3zsGTI7pnF+XXJ4hzyg+ATRcgubbEHumIsbaxh5HCwse95fAERvd2yjdbI6Fwm+d5gIjUM1b60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=auM/Bm5h; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="auM/Bm5h"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2b2e8bba2e6so46289885ad.1
        for <kvm@vger.kernel.org>; Tue, 14 Apr 2026 12:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776194075; x=1776798875; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=EDNdHgefY9I1l6kvBzLoX3J+XQ/bw8PLks7K5tWj/aE=;
        b=auM/Bm5h37D+P/F1KK+5Q6amUxpUr6D8+0DN4NjvKfFtZz7yYo80rCs02pWAI3QyZU
         jLwmTo0zGdmewBEmr7xQAa4yFrg/ho6+QazOPa4NeG0b8HcJBpWhCToG/oWwfsefiVqe
         h9F+vn2BND+DFggdMOdaxbvTW8z6XEhTTdq31AbYyK4srz8/uCVIwGBM+tndehiglWZl
         WzcL/G827GEg9uQr2WYGg0PfV6qGIb2uxv8C2Q0eU8dAQph7OAAG8NamytkEnPWsidBX
         GnWYaqPVH0BvDom28KpJTlsHX3IIvzvGSU3EnomocOkSRv5Orps8xZ/ahx36tFIk1yD6
         0Zvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776194075; x=1776798875;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EDNdHgefY9I1l6kvBzLoX3J+XQ/bw8PLks7K5tWj/aE=;
        b=LCHWUzyndfqMYmqYLRDg4l4MIEasc6TE/4pcs8v8aE62B8m4sYT0uej7TYF/zeuUcq
         1+BHVNbP0QjAa9XDZPn6x7uEKIy3AIvJ2aIQ2ZO2g8LsavwcungzCQOSazfp3rKmIaJN
         KcBpqA7nK7uOc32dkXFqy7Swt7m+tEOJneGwav7w7sbO+PfpeWnXVcEMQKxIcfDc0oCq
         O3oHf7BJDZmDHqS6cf9X6KWSU0xcBZHS/9mf4ZBlEI0mmEPBQhQ7QCa8MsAqUEytSQ0f
         cTO61tIpBjkiFDc2xACztGh8jVHGRQdodcedz3diczxyRr0yi2FpOncOH75Vo6E6KKTI
         PRwQ==
X-Forwarded-Encrypted: i=1; AFNElJ97cRh9T8zBE+qhsqTmTDiwKPmuYWAX30dIoe89VF8XOPlRFBlpIcEp34j8sBpC+kEkPDs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNl/Zr0JswDNAfjD/oaCKR/UD8lfIqruWiBPXrVIVOXfgSaj8Z
	0ASqUZhfHdLlIi9H1f3ZQPbazVgLV003DwGCJUCrxgpuJ22jtuLB0fzDqTvgfhP7OoGgkxieVl9
	AzEfzoA==
X-Received: from plnz12.prod.google.com ([2002:a17:902:834c:b0:2b2:4cd5:e119])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:38cc:b0:2b0:60f1:de58
 with SMTP id d9443c01a7336-2b2d5a95893mr194326015ad.45.1776194075229; Tue, 14
 Apr 2026 12:14:35 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 14 Apr 2026 12:14:24 -0700
In-Reply-To: <20260414191425.2697918-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260414191425.2697918-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.rc0.605.g598a273b03-goog
Message-ID: <20260414191425.2697918-4-seanjc@google.com>
Subject: [PATCH 3/4] perf/x86/intel: Make @data a mandatory param for intel_guest_get_msrs()
From: Sean Christopherson <seanjc@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, Jim Mattson <jmattson@google.com>, 
	Mingwei Zhang <mizhang@google.com>, Stephane Eranian <eranian@google.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"

Drop "support" for passing a NULL @data/@kvm_pmu param when getting guest
MSRs.  KVM, the only in-tree user, unconditionally passes a non-NULL
pointer, and carrying code that suggests @data may be NULL is confusing,
e.g. incorrectly implies that there are scenarios where KVM doesn't pass
a PMU context.

Fixes: 8183a538cd95 ("KVM: x86/pmu: Add IA32_DS_AREA MSR emulation to support guest DS")
Cc: Jim Mattson <jmattson@google.com>
Cc: Mingwei Zhang <mizhang@google.com>
Cc: Stephane Eranian <eranian@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/events/intel/core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 20a153aa33cb..9a78731deea2 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -5038,11 +5038,11 @@ static struct perf_guest_switch_msr *intel_guest_get_msrs(int *nr, void *data)
 	}
 
 	/*
-	 * If the guest won't use PEBS or the CPU doesn't support PEBS in the
-	 * guest, then there's nothing more to do as disabling PMCs via
-	 * PERF_GLOBAL_CTRL is sufficient on CPUs with guest/host isolation.
+	 * If the CPU doesn't support PEBS in the guest, then there's nothing
+	 * more to do as disabling PMCs via PERF_GLOBAL_CTRL is sufficient on
+	 * CPUs with guest/host isolation.
 	 */
-	if (!kvm_pmu || !x86_pmu.pebs_ept)
+	if (!x86_pmu.pebs_ept)
 		return arr;
 
 	/*
-- 
2.54.0.rc0.605.g598a273b03-goog

