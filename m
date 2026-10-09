Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96CDD3D9041;
	Fri,  9 Oct 2026 15:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791560234; cv=none; b=bml4wT2kLEo7pVWGxvCrQ9HyPscpUu9bGeoM6JZ2OQbAMYOVk0rJUIuRHVwL+Nb2OHRKiPVQoXSyaufAIS3w3hvby79nIMEqVbgC5F8CvPst72YDyufR5wN0bfLCzEyjYYzUSElCKaIDASuD7dKGzysGSMZYkviV/P6tmbSHA84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791560234; c=relaxed/simple;
	bh=IGlPNmrB/Z90+HzxJnCaiTCIJxJUyx5rp3tKMxTivao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KtXyrrRrvbqmlnYi7P5MNgWI7dWsFVBKgDmghDGvPOgda8LsCb+Y011QxFPpBQnyckXoY61YAEdrUsHqaKP5/0NT8LbXK63sTM314TBt5yQrQGHW9uV0Tm5Lrx3CkwdE0rOV9nT2utWl33oxPIRcr6GZsifVws3cK9MRYw6ldtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hReb8JI9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hReb8JI9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A69E1F000FF;
	Fri,  9 Oct 2026 15:37:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791560232;
	bh=Xv752NAWDTrmgKkOMZ6ZHqlt730yvRMedMOd086PMbc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hReb8JI9l1RQti47ixxKMTdfri9n+Ii2s4XtlPk8OdrTi5VbUr8DBQD3HPj9sh1/3
	 oWrNP67EasnhZ0hszJhksUfa84wGuRW7qe8xWTm2GJTGviWqkJ79dtkTtXKotacCqp
	 0Te+fRiemL0yw3TNZRdkOLEpf1PmFBlENnN7TiJHlewyAj8y924XNAICkzHZWoVOSo
	 UrRPlmkGP4HZ+9D2KY+txPhW3YyKqYB9Si0eaRoVjZxrdll+hkEVmAVdGUlxN8WdZx
	 cKqi1pwoZA2e65gZUfU6hJMCMTVENdhccncbiWe7xGpP1G7B+nGrpyH2SHcoCkCayw
	 o+ECAVXsuAYvw==
Date: Fri, 9 Oct 2026 15:37:10 +0000
From: Yosry Ahmed <yosry@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
Subject: Re: [PATCH v2 11/29] KVM: SVM: Only flush the fallback ASID when
 used by a different vCPU
Message-ID: <askKBLY9vTQSh3uE@google.com>
References: <20261008001425.2458927-1-yosry@kernel.org>
 <20261008001425.2458927-12-yosry@kernel.org>
 <sashiko-outbox-163474@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <sashiko-outbox-163474@kernel.org>

On Thu, Oct 08, 2026 at 12:33:14AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Low] kvm: data race on sd->fallback_asid_vcpu between pre_svm_run and svm_vcpu_free
> --
> 
> commit aa8eca89b8d60f642d17b3f8439f52f2e1ae951d
> Author: Yosry Ahmed <yosry@kernel.org>
> 
> KVM: SVM: Only flush the fallback ASID when used by a different vCPU
> 
> This commit optimizes the fallback ASID flushing logic by only flushing
> when the last vCPU that used the fallback ASID on the pCPU changes. It
> adds a per-CPU tracker fallback_asid_vcpu to determine when this occurs.
> 
> > diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> > index 8f27722bc4faf..0dbb1962d32b6 100644
> > --- a/arch/x86/kvm/svm/svm.c
> > +++ b/arch/x86/kvm/svm/svm.c
> 
> [ ... ]
> 
> > @@ -1422,6 +1424,11 @@ static void svm_vcpu_free(struct kvm_vcpu *vcpu)
> >  	svm_vcpu_free_msrpm(svm->msrpm);
> >  
> >  	free_asid(svm->asid);
> > +
> > +	for_each_possible_cpu(cpu) {
> > +		sd = per_cpu_ptr(&svm_data, cpu);
> > +		cmpxchg(&sd->fallback_asid_vcpu, vcpu, NULL);
> > +	}
> >  }
> 
> [ ... ]
> 
> > @@ -3884,8 +3892,11 @@ static int pre_svm_run(struct kvm_vcpu *vcpu)
> >  	if (is_sev_guest(vcpu))
> >  		return pre_sev_run(svm, vcpu->cpu);
> >  
> > -	if (unlikely(svm->vmcb->control.asid == fallback_asid))
> > +	if (unlikely(svm->vmcb->control.asid == fallback_asid &&
> > +		     sd->fallback_asid_vcpu != vcpu)) {
> >  		vmcb_set_flush_asid(svm->vmcb);
> > +		sd->fallback_asid_vcpu = vcpu;
> 
> [Severity: Low]
> Will this concurrent access to sd->fallback_asid_vcpu trigger a KCSAN data
> race splat?
> 
> In svm_vcpu_free(), when a vCPU is being destroyed, it iterates over all
> physical CPUs and modifies sd->fallback_asid_vcpu via cmpxchg() across CPUs.
> 
> Concurrently, another vCPU running on one of those CPUs will execute
> pre_svm_run() and perform plain reads and writes of its local
> sd->fallback_asid_vcpu.
> 
> Per the LKMM (C11 memory model), if an atomic RMW is used on one side
> of a concurrent access, at least one side must use READ_ONCE() or
> WRITE_ONCE() to prevent the compiler from fusing loads or reordering
> plain stores.
> 
> Should the reads and writes in pre_svm_run() use READ_ONCE() and
> WRITE_ONCE() to avoid this race?

I am not sure if this can cause any problems in practice, but I think
annotating with READ_ONCE()/WRITE_ONCE() is probably cheap enough and
this isn't the common case anyway.

> 
> > +	}
> >  
> >  	return 0;
> >  }
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20261008001425.2458927-1-yosry@kernel.org?part=11
