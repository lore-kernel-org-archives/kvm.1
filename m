Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6BA0453A4F
	for <kvm@vger.kernel.org>; Wed, 29 Jul 2026 18:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785349154; cv=none; b=ilJx20eO9lflldnKOSs5FytTiqzIr2CIJJP2YGOBrppggSjGCyvmPi7Dy5qjtN50zD3LjWYyZ9983kVmSPKkeR0qh+6GAOOVBk9rDG57HeOyZUpoGYCxkbFgpejbUmcSzJoMSlassFMJ1G1tBb2y3znItJNtEOI/gwPnU2998fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785349154; c=relaxed/simple;
	bh=gXvDQmDnVr6OE7oYWu88IugIvt9fOy8iiTsQetL+410=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r+GzV7gFGNh+3VoynCgUwbhxAdSB0BjnGPN7jTE0wwt5jZhnvKac9wommRFrxFiZzCZ01zWZ5UZpKRkRnzQ4sJU0XCpg4borYK5ptoyXtDxVP/IiANVRRBkkvSXrowHsA7aw2rTLd43j2ldp0jK36LsbSGj+MiqBlZeiSOavxGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SVKQHhRJ; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SVKQHhRJ"
X-Forwarded-Encrypted: i=1; AHgh+RosfFYLSya3OoTx09CRo8TTd7plt4fqyZnqkIU2f07zrTuZ7XCMaxDpK1I58642XuKUZ7g=@vger.kernel.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785349140;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lQfSKZP/hCCmm/JkjqLE4pUKx2XQfDJnU0jPCvkwDAU=;
	b=SVKQHhRJyBUbV74RPeFQqpFgas7zuf5h3REJqIYNdXbZjIRXCFLRk8Kdg0prvClQcZwdT3
	gQ9YZDsQTUa96TPNXGB+F83ceOD4jVY7kHIusAQ56D3Mp6RGV/Aq7Dze0GFswzJyLAXJEX
	RY5FAvSdjyCnMQ7VKHyX1zFwcTvha6Q=
X-Gm-Message-State: AOJu0YxGT8IEytsaE29xPe1CoxbC4aXIQK26yPZ1mxnRHRWGAzFg2DzK
	YeqHLaii4k9BE8XA4d1oPZ/PHssUEoiwQPBzXF8Vj1OBSV/uerFT7MB+UYP2agd47ECXw1EEo+j
	W4wUTYzKa3uGSHsaR+WyyFoNBcU9VhvevRPVvf1qC
X-Received: by 2002:a05:622a:684a:20b0:528:3186:5781 with SMTP id
 d75a77b69052e-52b35089f0cmr4050731cf.6.1785349127162; Wed, 29 Jul 2026
 11:18:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260720-hybrid-v9-0-2b713ca1b5dc@rsg.ci.i.u-tokyo.ac.jp> <20260720-hybrid-v9-14-2b713ca1b5dc@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260720-hybrid-v9-14-2b713ca1b5dc@rsg.ci.i.u-tokyo.ac.jp>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Fuad Tabba <fuad.tabba@linux.dev>
Date: Wed, 29 Jul 2026 19:18:00 +0100
X-Gmail-Original-Message-ID: <CA+EHjTx0zNQ_yPCz38vGYpBssshE4b3KWaoUxjzuerGgzB=JSQ@mail.gmail.com>
X-Gm-Features: AUfX_mxyRATQUT7wjn046sqG_VDzxdGritkO_zqsOb5Kz7zkeUPamYRcZ06tFIY
Message-ID: <CA+EHjTx0zNQ_yPCz38vGYpBssshE4b3KWaoUxjzuerGgzB=JSQ@mail.gmail.com>
Subject: Re: [PATCH v9 14/16] KVM: arm64: PMU: Implement fixed-counters-only emulation
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>, Joey Gouly <joey.gouly@arm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>, 
	Shuah Khan <skhan@linuxfoundation.org>, Yury Norov <yury.norov@gmail.com>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Steffen Eiden <seiden@linux.ibm.com>, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	devel@daynix.com, kvm@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Migadu-Flow: FLOW_OUT

Hi Akihiko,

On Mon, 20 Jul 2026 at 06:39, Akihiko Odaki
<odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
...

> +/**
> + * kvm_pmu_create_perf_event - create a perf event for a counter
> + * @pmc: Counter context
> + */
> +static void kvm_pmu_create_perf_event(struct kvm_pmc *pmc)
> +{
> +       struct kvm_vcpu *vcpu = kvm_pmc_to_vcpu(pmc);
> +       struct arm_pmu *arm_pmu = vcpu->kvm->arch.arm_pmu;
> +
> +       if (kvm_pmu_fixed_counters_only(vcpu->kvm)) {
> +               do {
> +                       arm_pmu = kvm_pmu_probe_armpmu(READ_ONCE(vcpu->cpu));
> +
> +                       if (!arm_pmu) {
> +                               pr_warn_once("kvm: Unsupported PMU variation detected.\n");
> +                               add_taint(TAINT_CPU_OUT_OF_SPEC, LOCKDEP_STILL_OK);
> +                               return;
> +                       }

Sashiko flagged that this can leave the perf event out of sync with
the sysreg, which looks plausible: on a pCPU with no registered pPMU
this returns without recreating the event, so a guest event-type
change there updates the sysreg but not the event, and after migrating
back to a pCPU the original pPMU covers, kvm_pmc_enable_perf_event()
re-enables the stale event instead of recreating it.

I know you treat the no-pPMU case as out of spec, but the dropped
update lands once the vCPU is back on a normal pCPU. Is this intended?

Cheers,
/fuad
