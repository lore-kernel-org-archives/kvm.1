Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792781746;
	b=b/wzl5oTPPYjPyY637hevzjJdmG0dkGaKX8i8a+mBuqzKdly+vStn2gZmp42RLgPOcv/
	 vmy5bIZdAsmGeaUdGjxOBIj8bCQZoi6WVqvw6sPry1vAzoEHApagJ+y+WGMYk5xMs9LPj
	 hUfhuLWAyoPFKArdNxUIa6j3vertfeMJ243KxlHmyxeonsS56N3Ew7konU3g22bxKvR8e
	 ipcY68LYqleI2/yNiQhoUapZ7ZL/6wyw/QM+4KDHdfvhRykgieX9Xq6ChukgB5ih5QX37
	 RCatV3i0QCRDX5AEvXEGpJNmrwsmHEev3sWUh8Usg6GBNcn1F4hyE0Vr6IrsoTB46Rw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792781746;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=H7bF4HrcRDAm1frhSShdaIaUyCju/nDUt7oEcWaxAZo=;
	b=Dk0sLRnJztXdfBIF/hSRLz4OvNF2Okg1mF+cLFKaVsRdAoDbY+IM2t04QQ7ZgFfAXpdu
	 KQLko6P9uUlwExtejgtlma8GN0seZy2Wpitp54whBDiVRZ31A57cJDYKBVJJx9Wlt+b1J
	 A2e8ig5+JUa3SAyW+YJtZQKoIakDSVAFZdM83i4wh9tJMmRQiywM6CZ8oWNpf/V7GCzUI
	 ZgGRLLkRKgz9UoygLWrmqYTShpGR9seiXoZtri4w3IYpDpeFVxvVEWYR1gpbhQyBrarb0
	 LSD38hbbQ77sOkaL3MB7mJ6nUO3Y8v15cHjxK+lNRkh8+QrTFvLHE3kfumXSg4juQTw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=u9OQsGB5;
	arc=none smtp.remote-ip=209.85.214.199
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 355BA606A31F
	for <kvm@vger.kernel.org>; Fri, 23 Oct 2026 18:55:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 355BA606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=u9OQsGB5
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2e94f72fb9fso10833665ad.1
        for <kvm@vger.kernel.org>; Fri, 23 Oct 2026 11:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792781745; x=1793386545; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=H7bF4HrcRDAm1frhSShdaIaUyCju/nDUt7oEcWaxAZo=;
        b=u9OQsGB57/ipLe95e4sVaNu5Jg/bT+PWigJKLHAMDC2LAOUeOW5gqAcaPhvFsMCjnk
         cbPIC1qBjjhgY/S5GjlLmGkol02YI1OJ5+FpNX0e0iA07N/Lq938cgDR0zMDhsRPIoTt
         vijkBJRnNPqjLTTSRy9lGBo+Fauxuk+MTY2aqXQRyCm749jfQck76anwk2jK3xZ/itgO
         Cc4V1MrvvranYhNz1RI1umOtgkhsSJ5FkwfV+wPbKLbGePJVtvAdOeS9gjeyRIWry92Q
         hw8+TYP+Rl5qzu12qdWQIjpayxi3VeRul/C9ZyiIMT971/xPTG19LH+YLqUs6UkM9WC8
         ZedQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792781745; x=1793386545;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=H7bF4HrcRDAm1frhSShdaIaUyCju/nDUt7oEcWaxAZo=;
        b=aG0c/V0H/8BM40DCXYqTRSQZ1iE6dFwE8ObOJEAvaa//835gq4xh5E4wAmIGtbFLQP
         b18VfWyMBX2z+qII6W4GVlA1aQSonCbQsxvqcZh/dHbnYf4nZmaokT3Lp0zkq82FFW6J
         QyALCIkbrtFfJSSJD3zlYclamU2xB9fB+ItcM1NY57uyUjqkyYzWz0EAszplUBK0sbBi
         tticmUg8D6r+0XkZnZS7004s+71ZQgptJH4eUbctCT32H2vV2dnwzpAyOGb0z0K4swVf
         s8zsyrkqP+LlhJELoCln6/M+yr7eOK9w2FU42HESiEwLuQwqOqLCkTjDAX3++JANeWxf
         yROw==
X-Forwarded-Encrypted: i=1; AKwUvBxG92zSW4XGoej8hYGEvL7//8fsTGo0ttlu0z+5oFIMA8JtW4G8v8yn3elpCDQ3n3M5fvY=@vger.kernel.org
X-Gm-Message-State: AFq9FYJqAv97oRJdyykCHwbuFrnzgpNrFvIwwua7j0qyELA8rXod7NCf
	mGKOpKN29VKPBQBKRwUDYP1Gui33Du+i980ACo1Ysl+LAT3DBPv0iJ11WCOxWSp/AgsVM+mTs4f
	ZkyerfphEZLmiLg==
X-Received: from pldv12.prod.google.com ([2002:a17:902:ca8c:b0:2e5:e1dc:c5])
 (user=jmattson job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:2f8f:b0:2db:733c:fd1f with SMTP id d9443c01a7336-2ea7c169201mr30400375ad.8.1792781745065;
 Fri, 23 Oct 2026 11:55:45 -0700 (PDT)
Date: Fri, 23 Oct 2026 11:55:44 -0700
In-Reply-To: <20260918193937.569414-13-zide.chen@intel.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20260918193937.569414-1-zide.chen@intel.com> <20260918193937.569414-13-zide.chen@intel.com>
X-Mailer: git-send-email 2.56.0.257.gf7497c7d27-goog
Message-ID: <20261023185544.3305206-1-jmattson@google.com>
Subject: Re: [PATCH v9 12/12] KVM: x86/pmu: Support RDPMC Metrics Clear Mode
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
> +		pmc = kvm_pmc_idx_to_pmc(pmu, INTEL_PMC_IDX_FIXED_SLOTS);
> +		if (pmc && intel_pmu_metrics_clear_enabled(pmu)) {

If kvm_vcpu_has_perf_metrics() requires fixed counter 3 (see my reply
to 5/12), pmc can't be NULL here.

[...]

> +	if (perf_capabilities & PERF_CAP_RDPMC_METRICS_CLEAR)
> +		pmu->fixed_ctr_ctrl_rsvd &=
> +			~intel_fixed_bits_by_idx(INTEL_FIXED_SLOTS_IDX,
> +						 INTEL_FIXED_3_METRICS_CLEAR);

This should be predicated on the guest actually having fixed counter 3
(and PERF_METRICS). intel_pmu_enable_fixed_counter_bits() only unmasks
bits for counters below nr_arch_fixed_counters.

[...]

> +		if ((data & PERF_CAP_RDPMC_METRICS_CLEAR) &&
> +		    !(data & PERF_CAP_PERF_METRICS))
> +			return 1;

If IA32_FIXED_CTR_CTRL.METRICS_CLEAR_EN[14] is only unmasked when the
vCPU has PERF_METRICS, is this check still necessary? KVM generally
doesn't police userspace's feature combinations unless it has to.
