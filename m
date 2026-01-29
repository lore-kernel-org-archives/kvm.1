Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C51483783C4
	for <kvm@vger.kernel.org>; Thu, 29 Jan 2026 23:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769729350; cv=none; b=i94woows5B/UQxXi+2inXLl9ZhxhkzVCK5EyUDuSkrkOMT0UtlAkjpq9EmYVULlhUKaNQiRV9rz+T+vh9/ETsK7sU9Id0IGcHBkXVMH2bMj4g93veutOYK19Oh54vgW15YzsLkrVGrX756/ZZ9k0VDVBip+zSQPh7rKK4FVnWXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769729350; c=relaxed/simple;
	bh=P2gomgDRGmJ4vLTkCMnRaUel1qN8UOZyfcbTRRVQbSk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=K6CkWepy/upBJS1DsfnK/Ds4fbG1Iz3AXTmzQj86jkgOO92p2CFyoDYUdrktS2sjNjLNN7znlg/ql5U5E5plffNsF+4INPCBpRHApUy4sX/aQj/tZlGxdQg0HfFFfp/DJV2JlXpfOmT4FQ7wQ3FjTpLMfS5O2QEbEohrS0LkCbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vgUiWLR9; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vgUiWLR9"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-29f1f69eec6so16787355ad.1
        for <kvm@vger.kernel.org>; Thu, 29 Jan 2026 15:29:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769729346; x=1770334146; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9edmz9F0+Ueeg69+oBnQppllXkvN4AaYJE9iZBV8Nzc=;
        b=vgUiWLR9Iek13taN1uRGejVzA5lRf+keCf/WSaEZ2kqLOhbP+lydU5A7vZyMclfQlg
         SdEdUZbWSGYHVoooXtNX3nfx8nJHUZDMwp8WsfEmBu7RgfemkT6J8I7gxuIUmhkH1A1G
         baXxGcJkp9EHxIF8nPxNAyCaMSobkszzpLOH5KsOMA5NLIZy+H/PZ1kp7Ds8tKWWi0nb
         /yH3QeTNE1rlYAMTXBCB4/y9U4V/uSWhlyWOkA3mWZGh2APh4/CBhxwzcCwQjc6A3LJU
         Ui67p9gNeFohimae12iFrL7rU/5Ghwi0GtEFDW5lVwncWXRQMqnodXLDAAyXOKwz9jsl
         fuzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769729346; x=1770334146;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9edmz9F0+Ueeg69+oBnQppllXkvN4AaYJE9iZBV8Nzc=;
        b=on8zlgc/PY4SLVMqvxiVnzu/Ad6DHVuQ95PbqsVCV5x4ZV4qDUjsVcPge4pIW41Kwz
         usBcPL1q6gTdShAkmQiNryLNnqlCZaayPTJ+YDJZb8xNCTY2EGHr9dN8HKoFmA970PVf
         rGz6tF0oGfCd5LkVsRjtK66DGHPz37ki6OXE4fpk0RKXoGDlHGguO++qlbI0ozcw+ZqE
         1EbCCo/C0rX9bL7uQ50HXfB92QRF0EqU/C/shvSACuLtD9+bhs5OAdjbpUzvBCPEx6L7
         28MgsoIspp9b9n+5YJbxR6fWV1kXyJSpyzkbuvA3xpk3wZ4ydN96ZxDdJ0oj+Ts8JOXn
         dx6g==
X-Forwarded-Encrypted: i=1; AJvYcCUC2NfDKSViv1e/5up0nNWFHAfDgn+BRH6+0N2T50+d2MkGIzq4qIVbHmA9CHJuhyZXhfY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTZzUbIqRqMaAQ51tW93Idjif31lLGuI3w+aWX+/3crV/ngZym
	9xzawJBELV+0Ut8oJfnDg+UyM3+NfGF9axESLRxy8rhCILW4YnnHlN20dWBk/r46ra6LGxb+7Wu
	j74iQ/9d5vBCJhg==
X-Received: from plbll8.prod.google.com ([2002:a17:903:908:b0:2a8:759b:173d])
 (user=jmattson job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:d485:b0:2a0:9eed:5182 with SMTP id d9443c01a7336-2a8d96a6b54mr8177095ad.20.1769729346081;
 Thu, 29 Jan 2026 15:29:06 -0800 (PST)
Date: Thu, 29 Jan 2026 15:28:09 -0800
In-Reply-To: <20260129232835.3710773-1-jmattson@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260129232835.3710773-1-jmattson@google.com>
X-Mailer: git-send-email 2.53.0.rc1.225.gd81095ad13-goog
Message-ID: <20260129232835.3710773-5-jmattson@google.com>
Subject: [PATCH v2 4/5] KVM: x86/pmu: Allow Host-Only/Guest-Only bits with
 nSVM and mediated PMU
From: Jim Mattson <jmattson@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Thomas Gleixner <tglx@kernel.org>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Cc: mizhang@google.com, yosryahmed@google.com, sandipan.das@amd.com, 
	Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="UTF-8"

If the vCPU advertises SVM and uses the mediated PMU, allow the guest to
set the Host-Only and Guest-Only bits in the event selector MSRs.

Signed-off-by: Jim Mattson <jmattson@google.com>
---
 arch/x86/kvm/svm/pmu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/kvm/svm/pmu.c b/arch/x86/kvm/svm/pmu.c
index e2a849fc7daa..7de7d8d00427 100644
--- a/arch/x86/kvm/svm/pmu.c
+++ b/arch/x86/kvm/svm/pmu.c
@@ -243,6 +243,9 @@ static void amd_pmu_refresh(struct kvm_vcpu *vcpu)
 
 	pmu->counter_bitmask[KVM_PMC_GP] = BIT_ULL(48) - 1;
 	pmu->reserved_bits = 0xfffffff000280000ull;
+	if (guest_cpu_cap_has(vcpu, X86_FEATURE_SVM) &&
+	    kvm_vcpu_has_mediated_pmu(vcpu))
+		pmu->reserved_bits &= ~AMD64_EVENTSEL_HOST_GUEST_MASK;
 	pmu->raw_event_mask = AMD64_RAW_EVENT_MASK;
 	/* not applicable to AMD; but clean them to prevent any fall out */
 	pmu->counter_bitmask[KVM_PMC_FIXED] = 0;
-- 
2.53.0.rc1.225.gd81095ad13-goog

