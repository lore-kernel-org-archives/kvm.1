Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9594F4DE70B
	for <kvm@vger.kernel.org>; Fri, 18 Sep 2026 13:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789739989; cv=none; b=nTFVi7rgNZrnZDwBdWfn9QA1KTAf2G2VtyRsV9XN/AnjqTKxVU104WXP8f5oT4E7QazdaNvJLZIfdUr1hqPsB7oKvEmNwVUxprogb+Uq3kCwcCYPRIxjyyjKFfTG0/11IRlinC9pVa1bzT8Uk85IrWLz3NsqCqaycMo+gsVqHTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789739989; c=relaxed/simple;
	bh=aivAK4Nb0pN5lZtUki8wXBnU8M2jDRpB90Nrxcx49TU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kXJvnMAXF1KlWUPyL3sn/Hj7DcNb/W35ORakm6Vc7Bf4hw8/yH8rsqHcjbQF96JPvq/6y08SkFrb9aQt7f6EPqEsstgAD32Y/hbt56AWlpxfopRPxYmxgITdaZX6X+S4+J9tbWGntzCoUILJEWwwZ10PbjRpgbDNg/xPgyqkleU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sOFWfalh; arc=none smtp.client-ip=209.85.216.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sOFWfalh"
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-39deb05ef51so1329558a91.3
        for <kvm@vger.kernel.org>; Fri, 18 Sep 2026 06:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789739987; x=1790344787; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UmTysDn4nll757dspZkZb/n39UP8Vw3WfecA74ZmN5w=;
        b=sOFWfalhIEo3SloeFIRPSunyHqlpKxjKyLb3UwmfeUUvuXE2W6ONS4q+7960RzbI1I
         tf3iQAFnpAMchoYfbHrYnLpxjpUJt6F5tPQ2gwYeyhDmoQW/mRqOP/MS1tbK0uQvCdM2
         g6MfxvH9OyVU4Lk6KH5TKPmiR0HTNEyXfVkZe9DZiy183meseiUjqC3n8BTMOb4XAlwC
         VzUjcodIex3JVbvOijF5hV4gu+OiGW3xcrAOiGKOo6Zh2yJpvIxa55ji6J8wbgK/WN8r
         cEWblskpuJKxCgi0qTVRPkCqt8TpqIR0FucoBY/ntJWaz9BEcc7Q+quks9tPgRbYD0fR
         1ZFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789739987; x=1790344787;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UmTysDn4nll757dspZkZb/n39UP8Vw3WfecA74ZmN5w=;
        b=Sf8JYe8g2d1uENQE3Nw4Nsjv3zPVBtwS2gIPXSype8oJNsFWGqtoSVZgNtoCmFT7KJ
         t8FupI7jeKMnRSF0pn0AsOK8glk9cl4xHwJigAep/COdTl6uQ3XlUeecXa3Cm7q+cq9O
         TRqC2U3UbyNvQx0Yu+7z25KbhW3NC9N69ePblplQOYPSRmrc0hJXg6tiw8fJkst+NdQ1
         JDHplOYjeMgkoZs/rNF4Ow1DmBFuPCfLeDyRhcIj4L/hyu3z9/fTy09qPneYlWGrF3ae
         HdjoaKDKHP2P7Gw56UQnRJCn5m2qKyGBdd+/R3+b6v76GtRqLON7UuODwFgOghHguMVk
         UXAw==
X-Gm-Message-State: AFuF++m+qiSklDa6J4BLxnjjQAL5Md9iFCvehE6CVvE1jXkkk76X32mM
	CaoVnK6Pa3by1Xuqh0cEzLpSUoQTeHqv0zgvXIONw4JOqHIHVlcu3vyaU9GpvkZ5yZX0ycbgFFD
	HF3k+AA==
X-Received: from pjrv21.prod.google.com ([2002:a17:90a:bb95:b0:39e:5090:e9b7])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2686:b0:39e:6a81:c91e
 with SMTP id 98e67ed59e1d1-39e6a81c997mr11996a91.17.1789739986633; Fri, 18
 Sep 2026 06:59:46 -0700 (PDT)
Date: Fri, 18 Sep 2026 06:59:45 -0700
In-Reply-To: <20260918033658.21842-1-kylebot@openai.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260918033658.21842-1-kylebot@openai.com>
Message-ID: <aq1D0Qxsa7IMX6ea@google.com>
Subject: Re: [PATCH v4] KVM: x86: Restrict saved GPA writes to hardware write faults
From: Sean Christopherson <seanjc@google.com>
To: Kyle Zeng <kylebot@openai.com>
Cc: kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Oleg Boiko <oboiko@openai.com>
Content-Type: text/plain; charset="us-ascii"

On Thu, Sep 17, 2026, Kyle Zeng wrote:
> @@ -2036,6 +2037,7 @@ static void sev_migrate_from(struct kvm *dst_kvm, struct kvm *src_kvm)
>  	unsigned long i;
>  
>  	dst->active = true;
> +	dst_kvm->arch.has_protected_page_tables = true;
>  	dst->asid = src->asid;
>  	dst->handle = src->handle;
>  	dst->pages_locked = src->pages_locked;

Hrm, I think in the sev_migrate_from() case, we should clear the flag in the source
to be consistent with the other fields:

	src->asid = 0;
	src->active = false;
	src->handle = 0;
	src->pages_locked = 0;
	src->es_active = false;

And with the vCPU tracking:

		memset(&src_svm->sev_es, 0, sizeof(src_svm->sev_es));
		src_svm->vmcb->control.ghcb_gpa = INVALID_PAGE;
		src_svm->vmcb->control.vmsa_pa = INVALID_PAGE;
		src_vcpu->arch.guest_state_protected = false;

I can't imagine it will ever matter, but it leaving the flag set looks wrong,
being consistent costs nothing in practice.

No need for a v5, I'll fixup when applying.
