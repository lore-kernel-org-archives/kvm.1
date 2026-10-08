Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C84A33242BA
	for <kvm@vger.kernel.org>; Thu,  8 Oct 2026 19:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791488302; cv=none; b=f04qbale8AKIyJAzhFCc5VmXdLUd0WeeEQcX2NxShYKHGwX3X4KesbwPniWb4yg1x2atuSG/IssVmFrqxrzmpWms1F43ZT8YGt0JGqGS0hb9Yu0/vs97ov1MF9uU3wJ+8CPEstvAOiNtW5vGoW8fGd3VZ9lx4dzkfvjoHAP3wxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791488302; c=relaxed/simple;
	bh=NruCxccqYa4WnllkTR/ySgyMG7iljIwgkVM72ZrRuZ4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=D9cMcLGp+WSMnfPZ+3yQ72wLXC+qT09boCj7akUk2LDO0gWmVr3Td0wqXyzL5GaBmMprZkxqW18pnheyzo+IRQc/EPAsPeWsef5S0v29pCmfHaYMNqRhWsphdLxLj2oX2gS43u0OqROShld3iA4wCwKfqKYTiFZhK6GEJeDoO94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I+RUE2So; arc=none smtp.client-ip=209.85.216.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I+RUE2So"
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3a7fa5e0442so6860754a91.0
        for <kvm@vger.kernel.org>; Thu, 08 Oct 2026 12:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791488301; x=1792093101; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zcp9URpSHfjRRNAT7YkMh3EnVtR1YkqcNhRFJnkm2/w=;
        b=I+RUE2SoCe9HwkdIBBSczEKnXUgpppHbXQMOkfp0z7lamMOhSbYqwNLzdDQJuSlSRT
         BH09fXmJwMOzwtVTPBuHdrqdqQ+m4rZZgXxJ/sM15BQ6t39jIqc04SlKZEoyAxnamOge
         vdCRi+71GhMvRM/gGRZJxfvKs/DW2jkCW+dbDCtdWeIO1tqhte++mZu9OFrQydlh7PsC
         pJH83bwnSS1Ap4+YOCLUQx+49BksllPLkXSb0s/P+Y3YzAO9X1LXe4nlfCV2hAjRP/VA
         aY/B+aEC2fF4+2UMWqgzCcsQi0919yrLBp2DAcmCDat35q/89S+cWQsuey2o6eO6SmjW
         81+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791488301; x=1792093101;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zcp9URpSHfjRRNAT7YkMh3EnVtR1YkqcNhRFJnkm2/w=;
        b=MgdRuBrIhUH9RmJCpBSlCdTyw6Bmw0Tc/NfhgrABGz0TnNf0sGvF7ZcPbXTa2GMTjv
         nRSmXRBAkTi6sucY+Gg8p3nBYscojwfcQlilN45cI+1E/vzdO/oE2iPyYx/Qe/yixMWV
         RFpXOn7dEfQqmAP1ZZGHfg4Acfxwa/lYvd9WgcSOqJCvzMH7Z4opsvV6frsv8vIck23x
         l74xVBRQPILZbXD2AJ1QNNu9FeIN6E/cl1sRJqUFPJloDmrkShPZCOQeB9VtTUnA4wmE
         O2L7PPGF2UoCXrPfddVFv5qJD9VOYLoMK9GMB0dE/TD/qc7PQVNRLm/D0GY33BtEq1Wu
         HGEg==
X-Forwarded-Encrypted: i=1; AKwUvByvxvRXWq/eiyssSdc8y024zp+Bbrj1SuEweYz9t8/4/N64yVpph64wXhNxvPtlJi7oFpk=@vger.kernel.org
X-Gm-Message-State: AFq9FYLZB3b3QIG6Dbwe3jpx6FJm2C5O3L56Hd631yH6sYYPZIx3WTPi
	acgdjZH4iFtADyHQcpoaFq/6WSvCoO9Yp9h2hfxtHg1L8YIpPdu8OyUH5q2CIc8ojcV3YPj5oFz
	iOx/RasT7dXUTuQ==
X-Received: from pgfd21-n1.prod.google.com ([2002:a05:6a02:6555:10b0:cc7:84e0:e066])
 (user=jmattson job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:5486:b0:3a4:9c30:425 with SMTP id 98e67ed59e1d1-3a8a117a9e4mr5551973a91.44.1791488300805;
 Thu, 08 Oct 2026 12:38:20 -0700 (PDT)
Date: Thu,  8 Oct 2026 12:38:15 -0700
In-Reply-To: <20260310060022.15120-9-manali.shukla@amd.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260310060022.15120-1-manali.shukla@amd.com> <20260310060022.15120-9-manali.shukla@amd.com>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
Message-ID: <20261008193818.839995-1-jmattson@google.com>
Subject: Re: [PATCH v3 8/9] perf/x86/amd: Remove exclude_guest check from perf_ibs_init()
From: Jim Mattson <jmattson@google.com>
To: Manali Shukla <manali.shukla@amd.com>
Cc: Jim Mattson <jmattson@google.com>, seanjc@google.com, pbonzini@redhat.com, 
	mingo@redhat.com, bp@alien8.de, kvm@vger.kernel.org, x86@kernel.org, 
	santosh.shukla@amd.com, nikunj.dadhania@amd.com, Naveen.Rao@amd.com, 
	dapeng1.mi@linux.intel.com, ravi.bangoria@amd.com, peterz@infradead.org, 
	Sandipan.Das@amd.com, Yosry Ahmed <yosry@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, Mar 10, 2026 at 06:00:20AM +0000, Manali Shukla wrote:
> Currently IBS driver doesn't allow the creation of IBS event with
> exclude_guest set. As a result, amd_ibs_init() returns -EINVAL if
> IBS event is created with exclude_guest set.

s/amd_ibs_init()/perf_ibs_init()/

> With the introduction of mediated PMU support, software-based handling
> of exclude_guest is permitted for PMUs that have the
> PERF_PMU_CAP_MEDIATED_VPMU capability.

This software-based handling applies only while a vCPU with a mediated
PMU is loaded (perf_load_guest_context() through perf_put_guest_context()).
The core PMU also sets AMD64_EVENTSEL_HOSTONLY for exclude_guest events,
so the hardware excludes guest execution in all other cases. IBS has no
equivalent, and nothing in the IBS driver or in KVM stops an IBS event
while a guest without a mediated PMU runs (for example, when
kvm_amd.enable_mediated_pmu=0, or when the VM is created with
KVM_PMU_CAP_DISABLE). After this patch, perf_ibs_init() accepts
exclude_guest=1 in those cases, but the event does not exclude the guest.
This seems like a problem.

> Since ibs_op and ibs_fetch pmus has PERF_PMU_CAP_MEDIATED_VPMU
> capability set, update perf_ibs_init() to remove exclude_guest check.

s/pmus has/PMUs have/

As I said on patch 7/9, please squash this patch with patch 7/9.

> Signed-off-by: Manali Shukla <manali.shukla@amd.com>
> ---
>  arch/x86/events/amd/ibs.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
> index e075c5ed136c..47f4dc0b6341 100644
> --- a/arch/x86/events/amd/ibs.c
> +++ b/arch/x86/events/amd/ibs.c
> @@ -327,8 +327,7 @@ static int perf_ibs_init(struct perf_event *event)
>  		return -EOPNOTSUPP;
>
>  	/* handle exclude_{user,kernel} in the IRQ handler */
> -	if (event->attr.exclude_host || event->attr.exclude_guest ||
> -	    event->attr.exclude_idle)
> +	if (event->attr.exclude_host || event->attr.exclude_idle)
>  		return -EINVAL;
>
>  	ret = validate_group(event);
