Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7101A3BD246
	for <kvm@vger.kernel.org>; Wed, 23 Sep 2026 17:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790184452; cv=none; b=ksidkVYj+OxVcEiFrLDc6BLLG8pF2iRAaVdgpL+P5vK77iUXutQv6UWCZpt+eEN5CYsVcYMzKOBo7XGNKVUBH+jeJfldCZlV8/7IrOsprdik7ChmXr680OWJh1vpIhY2dOClxbPz620H3pROK6cF938sQ4Jz/E2d7f0ONT7Tj8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790184452; c=relaxed/simple;
	bh=ohhh4GeReoXqlie8n4KfNmSMcuvcMAlJTHky9MGmbYg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GVPD81pqqc4G3yChKdKnd1KDertrO3rvPerG+jUMnlAoezlQBtB+2JLJnf5EVVHcpB7R9EmaS4Wn+Wz4xh1HkGrN/+MBSXhNHV45U/KKqLaXTR7UhvUB18AvtwQPXnFOz4fiUJvf58Y35RaARGCiNNT+I79iQ+vG6vxMrJCIjfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TNmyoQIT; arc=none smtp.client-ip=209.85.216.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TNmyoQIT"
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-381250979d5so1040408a91.0
        for <kvm@vger.kernel.org>; Wed, 23 Sep 2026 10:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790184451; x=1790789251; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ivQ/PauxsngIEfdEX/Gkp03t093uOowh/SUB9gD9AoA=;
        b=TNmyoQITx468V9J9KU1J4Fdhrhkf3TFRUSomrqmWB0dW4f4heHjW3emNiY3UssHgZN
         K6sOB+lAaUxRZoyG8A//EyN5VU+ydnhNCJmjOWb8GgdS7QyNTUcytEKf6ykRQVBvSqIN
         JoAnyALbKHOwc1BoVMQAppveZfquBFwo8ugmQVDa5R/62k4gHaHTtTQCJVXb9UNdzCBD
         PDtC1f/alyP9ee8PNpZdl3ZSDLIG1AQnKStQP47cebc5Prm+PpiMYCi+zzp0G1y8FrtP
         NziAlBv5of+GGCM1eDKTePxs9nfWeXhVaPBcSNXf1AIOkuoxen/InB3IkKwRyJAd3g2t
         dVIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790184451; x=1790789251;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ivQ/PauxsngIEfdEX/Gkp03t093uOowh/SUB9gD9AoA=;
        b=fec/c1j/EPbZ1M29mbNyfQGJjwDEBPRI711YXbM8Sn9mYCED53Tlmfz1Z/M3vDr65t
         KCfqXmQ24g0j5TudiE+cIM/+5Vmo02dERxzt9FC5SUHLCh8KnYd34HOXeLQzu/MIYO38
         Y4B/EaTLvs06FgjOchVJpo1+0TtLrmUI8h2XKj2aObpKFNX78h4206FtpWCgPnrq77Lg
         sHSUs7M+DfB2P8IsU2meSlhMA9ZF6wzhRsH9jH3/y1WpfuNUeiyU4I369qnlxcWqGCXL
         ujNhCuTdVZpucEiaeJ3GNZcFK2lQW8/y2M7mLUkoS1W6AjcUdY6ULMZn0FOR1ywYl6le
         girw==
X-Gm-Message-State: AFuF++nTc0PIRwk0pPY3NbfsUS/JQ4HiNIglks0b4jKaGyHT/8Fk+Uz/
	8dU4vSPLQDurQ+qlFjxYFKUWQOFD8KheEiwBHLAKDrDAw5HusMqqnwSRpHLW28xgQ181FabC2F+
	hsEqYyA==
X-Received: from pjbmr8.prod.google.com ([2002:a17:90b:2388:b0:3a0:8047:cc01])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4fcf:b0:3a0:352d:4cb5
 with SMTP id 98e67ed59e1d1-3a07e565a13mr3239733a91.13.1790184450511; Wed, 23
 Sep 2026 10:27:30 -0700 (PDT)
Date: Wed, 23 Sep 2026 10:27:29 -0700
In-Reply-To: <20260923165349.CAAF01F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260923163721.1584779-1-seanjc@google.com> <20260923163721.1584779-2-seanjc@google.com>
 <20260923165349.CAAF01F000FF@smtp.kernel.org>
Message-ID: <arQMARDUTSjbWpMX@google.com>
Subject: Re: [PATCH 1/2] KVM: SEV: Free have_run_cpus during VM destruction
 even if VM is no longer SEV
From: Sean Christopherson <seanjc@google.com>
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Wed, Sep 23, 2026, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Critical] kvm: double free of sev->have_run_cpus on initialization failure
> --
> 
> commit 35fcc7370ece167eff16a7738a6c47e4815c1ae4
> Author: Sean Christopherson <seanjc@google.com>
> 
> KVM: SEV: Free have_run_cpus during VM destruction even if VM is no longer SEV
> 
> Unconditionally free SEV's "have run CPUs" cpumask in the VM destroy path,
> i.e. even for what appear to be non-SEV VMs, as an SEV VM becomes a non-SEV
> VM if its state is intra-host migrated.
> 
> > diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> > index 63e8cfa9bf559..c9242c936a401 100644
> > --- a/arch/x86/kvm/svm/sev.c
> > +++ b/arch/x86/kvm/svm/sev.c
> > @@ -2981,13 +2981,17 @@ void sev_vm_destroy(struct kvm *kvm)
> >  	struct list_head *head = &sev->regions_list;
> >  	struct list_head *pos, *q;
> >  
> > +	/*
> > +	 * Free the mask even if the VM is not *currently* an SEV VM, as it may
> > +	 * have been an SEV VM prior to intra-host migration.
> > +	 */
> > +	free_cpumask_var(sev->have_run_cpus);
> 
> [Severity: Critical]
> Can this cause a double free of sev->have_run_cpus?
> 
> If a user issues a KVM_SEV_INIT ioctl and __sev_guest_init() fails after
> allocating the cpumask, the error path in __sev_guest_init() frees the
> mask but leaves the pointer intact:
> 
> arch/x86/kvm/svm/sev.c:__sev_guest_init() {
>     ...
> e_free:
> 	free_cpumask_var(sev->have_run_cpus);
>     ...
> }
> 
> Because free_cpumask_var() receives the mask by value, the pointer remains
> dangling. When the user later closes the VM file descriptor,
> kvm_destroy_vm() calls sev_vm_destroy().
> 
> Prior to this patch, the early return on !sev_guest(kvm) prevented the second
> free. By moving free_cpumask_var() before the !sev_guest(kvm) check, won't
> we unconditionally double free the dangling pointer?

Ugh, what a pain.  Ideally, free_cpumask_var() would nullify the pointer.  But
for a KVM-only "fix", it's easy enough to do the mask allocation last so that
there's no need to unwind and figure out how to nullify the pointer when it's
off-"stack".

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 96b4ed220eaf..4cbd38a48c5a 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -545,16 +545,16 @@ static int __sev_guest_init(struct kvm *kvm, struct kvm_sev_cmd *argp,
 	if (ret)
 		goto e_free_asid;
 
-	if (!zalloc_cpumask_var(&sev->have_run_cpus, GFP_KERNEL_ACCOUNT)) {
-		ret = -ENOMEM;
-		goto e_free_asid;
-	}
-
 	/* This needs to happen after SEV/SNP firmware initialization. */
 	if (snp_active) {
 		ret = snp_guest_req_init(kvm);
 		if (ret)
-			goto e_free;
+			goto e_free_asid;
+	}
+
+	if (!zalloc_cpumask_var(&sev->have_run_cpus, GFP_KERNEL_ACCOUNT)) {
+		ret = -ENOMEM;
+		goto e_free;
 	}
 
 	INIT_LIST_HEAD(&sev->regions_list);
@@ -566,7 +566,8 @@ static int __sev_guest_init(struct kvm *kvm, struct kvm_sev_cmd *argp,
 	return 0;
 
 e_free:
-	free_cpumask_var(sev->have_run_cpus);
+	if (snp_active)
+		snp_guest_req_cleanup(kvm);
 e_free_asid:
 	argp->error = init_args.error;
 	sev_asid_free(sev);
