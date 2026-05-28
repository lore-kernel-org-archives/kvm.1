Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A912F3C18
	for <kvm@vger.kernel.org>; Thu, 28 May 2026 02:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779935133; cv=none; b=OcxSQbKKSq568EkyOJZ4v6m3uQ8S6/tRrtXiJlef0nevV+83ZLXf+cjdctlflkF8c6ALQU5gIL5uyml+3BdGtTtONj/wF4dtPfo1/OW0uLiYLVz9Gfji24rljbSVc1nWKBJ0sg/5VYif3R8h0poVYU8eAFCGywMEoWXwaBGLwww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779935133; c=relaxed/simple;
	bh=RtoCWqOrG874W5Zl+3ahOMFu8XhwOJUoMHM8lStfWK0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=In6XdM53hGB0bM+IMdNKT45LCrM2fzSlPwMZOEnw4kVtWr1ewoXZB1vBUQbwEXCPgDExNQOiYGnJhXHCKgKQnPC5SSOfy9WX3DPuWlxqLiZ+bGSFmMSOEADEMFgrT8pz131H+FRtYdrJi2TJgQIPhp5SwJy3qyRXWGV4skKRISM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Q/3HSqTJ; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Q/3HSqTJ"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-365d4d2fa04so11447471a91.3
        for <kvm@vger.kernel.org>; Wed, 27 May 2026 19:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779935132; x=1780539932; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=j+6hXAGsinkLM4tFpg7kCHTNUeNBAxzveih1+rVtcWQ=;
        b=Q/3HSqTJ8afUIlfcz5QM8SRDBneZqSyXhKdksUg6SuFElZB+Nt0VuAz7YiRcAyzHjr
         LzoUCDoxYCpB8EY4rnwWBMgRX0dz72o6RRK3ful9+RHYR9mS/qIOOYHjsg/Xpr2+CfxN
         b04LdhkUMP/KaFUpkg6KUuzZQ0434M0REBfgSiUkMlBV4HwwroH/bDDsEs8/lMlggFCb
         YOpZH4YEsD0oL7gD6YAgtbWliYjBg6lXYnNPFGWhTjb3OxJzdCv7Ck+UzN0Q+2ASzt+K
         bX/A6ZZnHkToLuRbIuqqNa3njSo2weS08mgQMIZFSZ08qU1Ttt9vWOiIh8310rPA1khf
         29qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779935132; x=1780539932;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j+6hXAGsinkLM4tFpg7kCHTNUeNBAxzveih1+rVtcWQ=;
        b=UV6mhyNwYpM9193ynTmWUOH1r8G8U1H/tl70nAGhu0jCyQiCA5mQV3vJyle1Eol365
         381ynPJac+z1t+/6PvFqmSERKbtUUTn1w43+sEIdkVflPu14DAhL9rz2PJ83PQS/DU9U
         brd1PTi17VtmA72uirfzRs8IfKLwn5ncyiILp3W4EFmymLAoWFpipSuHKOZY4gSmS0un
         GTdQD0pxIi9/XZY0BaXn+/iXplHOgev+0d7w7loVfOhhqsGXOLCVzQKlVsUyvEYuvYmG
         CzGY9WoZAyx12M+J87VylvQhjp5RRTrMMhyBKYGgyXAIYdVlLhhWNOM+ziS9nz6ecZYH
         649w==
X-Forwarded-Encrypted: i=1; AFNElJ+HVVa0ZsFvJjqIE5KlBYrvB8pfLvrS6Cuw0ENc6qnx2nSRNmw6nonWzdnRN3bT2baPLX4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzxP5mbS7ggbL0KVGl31vUUpd5m3vKEImQ7jc9Ei5WtcOZYJh3
	Uko0E+zwvN+QjILPcp0Mqfw2PUmX/V8bfYYebRZIEL73XUI3u1ZwMPPAWFI97awSysJvA1INQq5
	vTtcxQA==
X-Received: from pjbgz20.prod.google.com ([2002:a17:90b:ed4:b0:36b:8abb:86c4])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:380b:b0:35d:a3b4:2f0d
 with SMTP id 98e67ed59e1d1-36a6773cb46mr23074897a91.6.1779935131309; Wed, 27
 May 2026 19:25:31 -0700 (PDT)
Date: Wed, 27 May 2026 19:25:30 -0700
In-Reply-To: <20260527234711.4175166-18-yosry@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260527234711.4175166-1-yosry@kernel.org> <20260527234711.4175166-18-yosry@kernel.org>
Message-ID: <ahenmnACHMNKO3WC@google.com>
Subject: Re: [PATCH v7 17/17] KVM: selftests: Add svm_pmu_host_guest_test for
 Host-Only/Guest-Only bits
From: Sean Christopherson <seanjc@google.com>
To: Yosry Ahmed <yosry@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jim Mattson <jmattson@google.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Sandipan Das <sandipan.das@amd.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Wed, May 27, 2026, Yosry Ahmed wrote:
> +int main(int argc, char *argv[])
> +{
> +	struct kvm_pmu_event_filter *filter;
> +	struct kvm_vcpu *vcpu;
> +	struct kvm_vm *vm;
> +	struct ucall uc;
> +	gva_t svm_gva;
> +
> +	TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_SVM));
> +	TEST_REQUIRE(kvm_is_pmu_enabled());
> +	TEST_REQUIRE(get_kvm_amd_param_bool("enable_mediated_pmu"));

This can and should be handled in a helper, using either host_cpu_is_intel or
host_cpu_is_amd_compatible to choose while vendor to query.

> +	TEST_REQUIRE(host_cpu_is_amd && kvm_cpu_family() >= 0x17);

Why the family check?  Actually, why check host_cpu_is_amd at all?
