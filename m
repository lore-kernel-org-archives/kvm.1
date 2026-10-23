Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792781107;
	b=DX3/SR6wV6nj8ANGYAIys+FlUERn9e2S7d0T+xZAzl5LIqgg5Jnq99i/TdL3WPjb2nn1
	 z1rHE+lBxIfwkBAJ03/mIbxoMBla8mZ/RBB5C92qljcmIZDhOXSjpR6QdNjhsiN56WfrW
	 MMKlR72TLF/5iNAC2/wgLtmAzGSFrPbVtd63nZLjEzXqREDrmk5ciXiIcaTSQBeXpYWxx
	 nuSmPaPB8vC+QULfOz7t7mZKeTZi6ZLXvR4wmdyrVfl9oxv3FKz4GV5QrNkIohrop2/t0
	 mk/Mfvn0M6ZstD80cpsNRudIUFvCJESNWza7Ju0znnzCS51Af0HCGt0fAJbdhRlyuGg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792781107;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=OGMzC/xB2rHIgrwqTcZHrvot/a5ZJBE0hOXwBjfDQMI=;
	b=mTkT7T2hX6hn6BcjnYAHNAqu+78Rr8CebJ/B/DiO7i7udGoVvtOtcfonBsEosCuKG8ZL
	 j4WJ10JMQhMutN9fJs2aoW6eYfiFgB28zwhl56zmeeLxU4+GuqosPy6LCmaWJFyw2xtKz
	 sUxOVzI33BakPPJKvmiGIcDvGSAaLPaj/9BgfA1QXDHtAVZAJ0MLLykBz23ky4XYQpjlu
	 t+drgiC3++Z5W6Sao3v2E35Ty/cKiD23wozVnI1YRIIGVewkdMdFhP2UR2CAvXawuKMEp
	 63Iwsyz09Q+G2y1efmBaI2MmtuNuMFUnr7SYfiMG2eewCvESnplwgseMflBaUXMLCOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=Vr0kMnTi;
	arc=none smtp.remote-ip=209.85.216.70
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B77606A320
	for <kvm@vger.kernel.org>; Fri, 23 Oct 2026 18:45:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A4B77606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=Vr0kMnTi
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3ad7030e886so1249239a91.0
        for <kvm@vger.kernel.org>; Fri, 23 Oct 2026 11:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792781106; x=1793385906; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OGMzC/xB2rHIgrwqTcZHrvot/a5ZJBE0hOXwBjfDQMI=;
        b=Vr0kMnTiw1RDlRzaRiVNHHEMjPLGi4JCsYvEMmsefrWFkXb74HLaTyq3TdINA/ZG4u
         rZIODbkH1ujDcRgQdkS1x/YNy8ulIlz8cbKhjVryin1Aq6zh4uGzC+R82WWtRy3Qkg5h
         EqSUOOd5+TEmZCLk0UJLHPtdA7ComEBjbGXJ6Ae5ZWE1j3DjX3TGSYxBqeXNsIfTsKLW
         5dOTcQMtty05KkSob0WTmcRk00j0zc/hTiJbtcl/KzkzPbf2I2Q8zYJVFFbOSoaDjL2N
         sg46d4HlyRQRfdd9HKLdZcgCXkIoqDKvLDU6VB7xNd8vqwb89d/ZJgKoGkP02dwLj4T/
         jUdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792781106; x=1793385906;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OGMzC/xB2rHIgrwqTcZHrvot/a5ZJBE0hOXwBjfDQMI=;
        b=pTawmkhQS+b2+ih1ExbGb4WA7Gn8b4MRWDq9d2wflAgUF5p79dZZ6kRfchSBMAwlQ4
         5ROnr+TysSeSnIWlub1Zo01Lm403c7UfBD2czF3267TBI1+iNWxoHZMo4nfxV0WZN0xk
         PT3XHymrJd21Reh6fxIUfYXBZw6DYoN3Ij/AAJaq2PSruUa26K43wsYnbu6AX5odyggn
         mRXwV0U6b8iHn2M1+8q9n9Zdn5+ShbROVnHrQATSdUt9NWYJemMLL8SoKNLF04WxNq0z
         W1zE0NPpcgY6Mof+maUmPpL++Lo3KlX4oYM17TLEU9ttUgdNmzaSm0XnI58/5XAL4IUY
         BK+A==
X-Forwarded-Encrypted: i=1; AKwUvBwJz9yFDqBbapBNlvkxLRt13E5Ow9O4XBJ0sb/t9j875AlH3HDmAqNRu7v5QxJIeEKUntQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYI87KJOxB6okgH+QXP7FAqnE5Sv/eJsZKyYLELTzxLD9WRn+Zmc
	pEAGo9FhBSPQXEETVLOAlWaZWiMAf8PiiOrSoyPDLJkWEl9C2bMn0Jl8jHz4E9obS5DQBGVv+Cw
	/Y4kPupUh4wU5KA==
X-Received: from pjbmj9.prod.google.com ([2002:a17:90b:3689:b0:3ad:4377:79ba])
 (user=jmattson job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:4e8b:b0:3a7:9adb:2a18 with SMTP id 98e67ed59e1d1-3adeafc7e13mr141619a91.62.1792781105856;
 Fri, 23 Oct 2026 11:45:05 -0700 (PDT)
Date: Fri, 23 Oct 2026 11:45:05 -0700
In-Reply-To: <20260918193937.569414-12-zide.chen@intel.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20260918193937.569414-1-zide.chen@intel.com> <20260918193937.569414-12-zide.chen@intel.com>
X-Mailer: git-send-email 2.56.0.257.gf7497c7d27-goog
Message-ID: <20261023184505.3284911-1-jmattson@google.com>
Subject: Re: [PATCH v9 11/12] KVM: x86/pmu: Reject writes to reserved
 MSR_PERF_METRICS bits
From: Jim Mattson <jmattson@google.com>
To: Zide Chen <zide.chen@intel.com>
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, kvm@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, 
	Stephane Eranian <eranian@google.com>, linux-kernel@vger.kernel.org, 
	Mingwei Zhang <mizhang@google.com>, Das Sandipan <Sandipan.Das@amd.com>, 
	Shukla Manali <Manali.Shukla@amd.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	Xudong Hao <xudong.hao@intel.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, Sep 18, 2026 at 12:39 PM Zide Chen <zide.chen@intel.com> wrote:
>
> +		if (kvm_pmu_cap.num_topdown_events < INTEL_TD_METRIC_NUM)
> +			pmu->perf_metrics_rsvd =
> +				~(BIT_ULL(kvm_pmu_cap.num_topdown_events *
> +					  INTEL_TD_METRIC_FIELD_BITS) - 1);
> +		else
> +			pmu->perf_metrics_rsvd = 0;

perf only sets x86_pmu.num_topdown_events for the models it knows about
(Ice Lake and intel_pmu_init_glc() users). On a non-hybrid part that
perf treats as "generic_arch_v5+", PERF_CAPABILITIES.PERF_METRICS_AVAILABLE
can be set while num_topdown_events is 0. (intel_pmu_init() even sets
GLOBAL_CTRL_EN_PERF_METRICS in intel_ctrl in that case.)

vmx_get_perf_capabilities() will still advertise PERF_CAP_PERF_METRICS,
but perf_metrics_rsvd will be ~0ull. The guest writes PERF_METRICS
directly, and the hardware updates it on its own, so KVM_GET_MSRS can
return a non-zero value that KVM_SET_MSRS will then reject. That breaks
save/restore. (The selftest's write of 0xdeaddead would also fail.)

Shouldn't vmx_get_perf_capabilities() withhold PERF_CAP_PERF_METRICS
(and PERF_CAP_RDPMC_METRICS_CLEAR) when kvm_pmu_cap.num_topdown_events
is 0? The SDM, volume 3, section 22.8, says:

> IA32_PERF_CAPABILITIES.PERF_METRICS_AVAILABLE[15]: If set, indicates
> that the architecture provides built in support for [four] TMA L1
> metrics through the PERF_METRICS MSR.

So, four could be a fallback, but if the part actually implements
eight, the upper fields would break the round trip in the same way.

Also, since the guest's own writes go straight to hardware, this check
really exists to keep the wrmsrq() in intel_mediated_pmu_load() from
faulting on a bogus userspace value. The commit message should say so.
