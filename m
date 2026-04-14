Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 433763191D0
	for <kvm@vger.kernel.org>; Tue, 14 Apr 2026 19:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776194075; cv=none; b=kVC3OZ5n4NthzQqVxwYWxI9Qe6vpHRpiF8KKSE3GElO5ZTCh6dKVRVDC1glFb2OF5ZNe2tppOSiCu9fHzCBWU9WCnv1ZjD4NYOacBomUkDqpulTUxOqEMcwHJwSOw7gRgZnD905qCHz8slh2dqroLgPLwnk6wJjMIxmH27VPzbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776194075; c=relaxed/simple;
	bh=KvIG1l/WweA6fzYjmK6M8jEGrTyoO4PTSmR+fEG8fq8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kQbz8XR4v6k+Jx2cE+Ur3atfluZOFvWzRIw44zyCc32ww4XUbz4BA08AeDmhmUt3/03YjFjJbYy/grF4YI32Sztn9e62cBWN9xTipI5tTLs+Wfbuq6b/KEh5NVAVuF+2DpdgoVC4IXhZSs0sXeZZhoFqXLQ78JHVLVgnMBwBsXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Bpg3D5eC; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Bpg3D5eC"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c709551ec08so7509413a12.3
        for <kvm@vger.kernel.org>; Tue, 14 Apr 2026 12:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776194073; x=1776798873; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=zD3eOn27bjJqO09iUaVSsE+WSP9GPb4HLOOe5wuJNrI=;
        b=Bpg3D5eCNq2Hm8PSmF3I6MT/t5SnpRJGPSFyuo5vbwmCJSsvg22BnJZtCzrEjox8jk
         Sr9ovUI8PuDDfUm1gdJ70tukRqq508V1hL0+IT2FWTngaP/yApbhTdSxsIaAxXlqbvDo
         RpmE/e4KTrWRThj7WtEkWL6EIXkbtWGWnC0Aeqi4l0Dfyy4MQ6QTym4dRmivlfEGzO3b
         y8BIgDVVrPWvXHP+m8aRLs6NeKjgqKkqjMTyimwLmltglXW8zPv7qzrCQWNqzDpGd43e
         vO7i81RrCYXCm4OpUg1yOoeQxuL3kmWXkf3/+GxrARyTMdokrQU4txnX12j0sK7SwEi1
         sQkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776194073; x=1776798873;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zD3eOn27bjJqO09iUaVSsE+WSP9GPb4HLOOe5wuJNrI=;
        b=fXwXKgkONywuerd8Htx1YD/w2ZliLt20mXpamwATqTpGvgRReVIiTJS3GhvLl3GjjI
         iokawqAdD7vz2omZXj+7Txz06WwRNU+YUeXpcj6lBKOnhG6phVhz31/6dzxlqosx7YI/
         nwMHrrtJtT4FYSncQ3xU97AfCFAUjbkykwjsZiy30Sy7h7eh7W1iO+1XB+ekwvoqJKe/
         9sxDtyi46RUpNsfFOWpxYivzf2G1uhujKceG3Te257dYUYsn2SesQktAP/Qp9ZNCid1n
         UKK+4P2a4SFf7KLXFI7guabFjgLt9Y6e/MID34v/9B6c0XEQUNg5Nr2VrG4zI3gCclqC
         ijAg==
X-Forwarded-Encrypted: i=1; AFNElJ9SVczd5hQVJrImaTrmVtKuR22PBqIgcs6Zly7B67drP3dhOzlSNlgcxCDKG1XsrOAMxcs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLpHVHlo0DlBWRhsThza4JKDeJtbr5jFcwEzUHQOTkAi256IQC
	KdM3K3pBhRVnABtO41nmSB+unOUIX7QQrnV/8PZAahgw9xlH9SYbqgr4UK8J0O7TaAruPEfALmz
	D8m1q8w==
X-Received: from pfgs24.prod.google.com ([2002:a05:6a00:1798:b0:7fb:ed58:5e4b])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1306:b0:823:d2c:b156
 with SMTP id d2e1a72fcca58-82f0c2691e2mr19192062b3a.5.1776194073165; Tue, 14
 Apr 2026 12:14:33 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 14 Apr 2026 12:14:23 -0700
In-Reply-To: <20260414191425.2697918-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260414191425.2697918-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.rc0.605.g598a273b03-goog
Message-ID: <20260414191425.2697918-3-seanjc@google.com>
Subject: [PATCH 2/4] perf/x86/intel: Don't context switch DS_AREA (and PEBS
 config) if PEBS is unused
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

When filling the list of MSRs to be loaded by KVM on VM-Enter and VM-Exit,
insert DS_AREA and (conditionally) MSR_PEBS_DATA_CFG into the list if and
only if PEBS will be active in the guest, i.e. only if a PEBS record may be
generated while running the guest.  As shown by the !x86_pmu.pebs_ept path,
it's perfectly safe to run with the host's DS_AREA, so long as PEBS-enabled
counters are disabled via PERF_GLOBAL_CTRL.

Omitting DS_AREA and MSR_PEBS_DATA_CFG when PEBS is unused saves two MSR
writes per MSR on each VMX transition, i.e. eliminates two/four pointless
MSR writes on each VMX roundtrip when PEBS isn't being used by the guest.

Fixes: c59a1f106f5c ("KVM: x86/pmu: Add IA32_PEBS_ENABLE MSR emulation for extended PEBS")
Cc: Jim Mattson <jmattson@google.com>
Cc: Mingwei Zhang <mizhang@google.com>
Cc: Stephane Eranian <eranian@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/events/intel/core.c | 41 ++++++++++++++++++++++++------------
 1 file changed, 27 insertions(+), 14 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 002d809f82ef..20a153aa33cb 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -5037,23 +5037,14 @@ static struct perf_guest_switch_msr *intel_guest_get_msrs(int *nr, void *data)
 		return arr;
 	}
 
+	/*
+	 * If the guest won't use PEBS or the CPU doesn't support PEBS in the
+	 * guest, then there's nothing more to do as disabling PMCs via
+	 * PERF_GLOBAL_CTRL is sufficient on CPUs with guest/host isolation.
+	 */
 	if (!kvm_pmu || !x86_pmu.pebs_ept)
 		return arr;
 
-	arr[(*nr)++] = (struct perf_guest_switch_msr){
-		.msr = MSR_IA32_DS_AREA,
-		.host = (unsigned long)cpuc->ds,
-		.guest = kvm_pmu->ds_area,
-	};
-
-	if (x86_pmu.intel_cap.pebs_baseline) {
-		arr[(*nr)++] = (struct perf_guest_switch_msr){
-			.msr = MSR_PEBS_DATA_CFG,
-			.host = cpuc->active_pebs_data_cfg,
-			.guest = kvm_pmu->pebs_data_cfg,
-		};
-	}
-
 	/*
 	 * Disable counters where the guest PMC is different than the host PMC
 	 * being used on behalf of the guest, as the PEBS record includes
@@ -5065,6 +5056,28 @@ static struct perf_guest_switch_msr *intel_guest_get_msrs(int *nr, void *data)
 	if (pebs_mask & ~cpuc->intel_ctrl_guest_mask)
 		guest_pebs_mask = 0;
 
+	/*
+	 * Context switch DS_AREA and PEBS_DATA_CFG if and only if PEBS will be
+	 * active in the guest; if no records will be generated while the guest
+	 * is running, then running with host values is safe (see above).
+	 */
+	if (!guest_pebs_mask)
+		return arr;
+
+	arr[(*nr)++] = (struct perf_guest_switch_msr){
+		.msr = MSR_IA32_DS_AREA,
+		.host = (unsigned long)cpuc->ds,
+		.guest = kvm_pmu->ds_area,
+	};
+
+	if (x86_pmu.intel_cap.pebs_baseline) {
+		arr[(*nr)++] = (struct perf_guest_switch_msr){
+			.msr = MSR_PEBS_DATA_CFG,
+			.host = cpuc->active_pebs_data_cfg,
+			.guest = kvm_pmu->pebs_data_cfg,
+		};
+	}
+
 	/*
 	 * Do NOT mess with PEBS_ENABLED.  As above, disabling counters via
 	 * PERF_GLOBAL_CTRL is sufficient, and loading a stale PEBS_ENABLED,
-- 
2.54.0.rc0.605.g598a273b03-goog

