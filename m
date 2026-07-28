Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF49035975
	for <kvm@vger.kernel.org>; Tue, 28 Jul 2026 23:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785279759; cv=none; b=QLCa5nqHQv6HzR4xNw41rH4yITsxxSZ5lH154UcmI0NOIcln2m+z2bL+rA3AqnL6wZstm7IgPhBX5YGdtBpwoEQoo4t3jJ22W/GMrRgUB4sb0p3WyzIBBrO3tITCsO4U7j0cqTfXRkYHcxkV16ES56k8YDdGjtdSHzRI4rO2VQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785279759; c=relaxed/simple;
	bh=xMnrzk1LQYBwnBKbjf9OW8PBEYsOhsuT5RKQZqm7/HY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=shMBosk9aXQPLE4I1QE+WE/HSJWpgg+/YCbTVpok98gRaJk0wveI5Bh8XeCwDd99cY1J3JOHPRJYuNUtB/BclfQse7jyonKWy77J3w05KtmT6J/j9ecOYS1LEYCqY3nqI6XGuJ2CzWkiAON1OS3gv8ob6R0VSU/rGXrY6WXKoTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pRVwmbxA; arc=none smtp.client-ip=209.85.210.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pRVwmbxA"
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-847a00bcbd0so427579b3a.0
        for <kvm@vger.kernel.org>; Tue, 28 Jul 2026 16:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785279757; x=1785884557; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kPvY+6bN8WcKGck+zbxkmEYx8w80GVrHMYTrnyPGblw=;
        b=pRVwmbxAFiJnojrgFhl/b6kqJwaAFdB0OHubvQwCmLw12keb412X8g9Ckkh/k9fNX9
         xqLEmG6LBgcv5Z8PweK7o8jP/uLGFAnjXjovghMuV68hqgMTh5V9M6kVEyn8BnNHh0F4
         zebawxbltCS60Gl8wCeaMtWpCmbFO3z1fEeJmbmWu3HqTdICJUvDfwJZ5g0Y2j5Fw2Xs
         3w3Y759cJ+ribUeaERRtb8Ojq9igFpvn9Sag4bvyJZjDtxl4SKplBoI7HGjtyUbfGvor
         KUSsGM8WD2gAWO4LKcS62aaNkF5S53K39tuBF4CyTLAlVu8sZpu2DdYvE4oWFPJcDEP9
         RW+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785279757; x=1785884557;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kPvY+6bN8WcKGck+zbxkmEYx8w80GVrHMYTrnyPGblw=;
        b=ACv6Jtj/O76l5xcY6U0eq5PprtC5kR9SCEYSwwZMuKBZpwk8eei2HsIaC9bQDHBJKl
         t6TY6LwRBG6FjKTeNGitkT8OgfHzfKKmfqYONiCr63WT4OZzPD8WLAAdSFJZevTm+NbA
         xCJfwl7aOWTB0FcejTWDkaJV7OlpxT8hnHdCkE1B24wM851ZbOAMw8ej1WjtO6j5FAH9
         x8S3EYuSFG7PGKBAWNIFm5Bzzzxrck2I79idu5EPj7bENpClG7UEm67eKp/b3C7Fo3vf
         x1va7HxKl5BKWU/MyylVoHWLuBYDVL3OTWa/ZEIf+mhRFiqaWKIaKeStDHdbutNWAoqy
         ROcQ==
X-Forwarded-Encrypted: i=1; AHgh+RqlmZjLpr792/nbGT4Yp8kRC4EB565LQoCd9DZXJFRvDAhWR1D5anMtVNlpQMMm6N+GIos=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaiyPWrni/l0Ki1y4FXlhzmGZYDGarR1NV3ugkaDRfETcM6Uck
	1pjiVYh5ka9lIyf8usiJhdXZRq6copsWy/CH0HL7tbySyaEDCvZQ8GSuc6X87QwWYTZKt4gMfCV
	hP65qig==
X-Received: from pgbcf14.prod.google.com ([2002:a05:6a02:84e:b0:c99:aff5:7092])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:44c8:b0:3c0:fab7:bee0
 with SMTP id adf61e73a8af0-3c8ba627b22mr5336104637.62.1785279756967; Tue, 28
 Jul 2026 16:02:36 -0700 (PDT)
Date: Tue, 28 Jul 2026 16:02:36 -0700
In-Reply-To: <20260728151120.EC0931F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260728144954.355376-1-dwmw2@infradead.org> <20260728144954.355376-8-dwmw2@infradead.org>
 <20260728151120.EC0931F000E9@smtp.kernel.org>
Message-ID: <amk1DH-Z1opxVDJS@google.com>
Subject: Re: [PATCH v7 07/36] KVM: x86: Restructure get_kvmclock()
From: Sean Christopherson <seanjc@google.com>
To: sashiko-reviews@lists.linux.dev
Cc: David Woodhouse <dwmw2@infradead.org>, kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Tue, Jul 28, 2026, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] Removal of `get_cpu()` reintroduces a race condition between `rdtsc` and `cpu_tsc_khz`, and triggers a kernel warning for preemptible `__this_cpu_read`.
> --
> 
> --- Patch [7]: [PATCH v7 07/36] KVM: x86: Restructure get_kvmclock() ---
> commit c5c131ac2510f7641714a694b1cf0192a9da9749
> Author: David Woodhouse <dwmw@amazon.co.uk>
> 
> KVM: x86: Restructure get_kvmclock()
> 
> This commit wraps the use_master_clock block in an ifdef for CONFIG_X86_64
> to resolve 32-bit build issues with unused variables and host_tsc_clocksource.
> It also refactors the master-clock success path to use continue, allowing
> the fallback computation to become the common tail.
> 
> > diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> > index ee115dc6df6e1..d68d00cdbea73 100644
> > --- a/arch/x86/kvm/x86.c
> > +++ b/arch/x86/kvm/x86.c
> [ ... ]
> > @@ -1636,34 +1636,38 @@ static unsigned long get_cpu_tsc_khz(void)
> >  static void get_kvmclock(struct kvm *kvm, struct kvm_clock_data *data)
> >  {
> >  	struct kvm_arch *ka = &kvm->arch;
> > -	struct pvclock_vcpu_time_info hv_clock;
> >  	unsigned int seq;
> >  
> >  	do {
> >  		seq = read_seqcount_begin(&ka->pvclock_sc);
> >  
> >  		data->flags = 0;
> > -		if (ka->use_master_clock) {
> >  #ifdef CONFIG_X86_64
> > +		if (ka->use_master_clock) {
> > +			struct pvclock_vcpu_time_info hv_clock;
> >  			struct timespec64 ts;
> >  
> >  			if (kvm_get_walltime_and_clockread(&ts, &data->host_tsc)) {
> >  				data->realtime = ts.tv_nsec + NSEC_PER_SEC * ts.tv_sec;
> > -				data->flags |= KVM_CLOCK_REALTIME | KVM_CLOCK_HOST_TSC;
> > -			} else
> > -#endif
> > -			data->host_tsc = rdtsc();
> > -
> > -			data->flags |= KVM_CLOCK_TSC_STABLE;
> > -			hv_clock.tsc_timestamp = ka->master_cycle_now;
> > -			hv_clock.system_time = ka->master_kernel_ns + ka->kvmclock_offset;
> > -			kvm_get_time_scale(NSEC_PER_SEC, get_cpu_tsc_khz() * 1000LL,
> > -					   &hv_clock.tsc_shift,
> > -					   &hv_clock.tsc_to_system_mul);
> > +				data->flags |= KVM_CLOCK_REALTIME | KVM_CLOCK_HOST_TSC | KVM_CLOCK_TSC_STABLE;
> > +
> > +				hv_clock.tsc_timestamp = ka->master_cycle_now;
> > +				hv_clock.system_time = ka->master_kernel_ns + ka->kvmclock_offset;
> > +				kvm_get_time_scale(NSEC_PER_SEC, get_cpu_tsc_khz() * 1000LL,
> > +						   &hv_clock.tsc_shift,
> > +						   &hv_clock.tsc_to_system_mul);
> 
> [Severity: High]
> Does this code trigger a preemptible __this_cpu_read() warning?

Yes.  And my suggestion to isolate the change was "bad", but also "good".  "Bad"
in the sense that we can't simply drop the pinning, "good" in that it forced me
to dig into why the code is the way it is.

Happily, I ended up with this, which segues very well into "KVM: x86: Fix KVM clock
precision in get_kvmclock() with TSC scaling".

---
From: Sean Christopherson <seanjc@google.com>
Date: Tue, 28 Jul 2026 14:57:58 -0700
Subject: [PATCH] KVM: x86: Drop unnecessary CPU pinning when computing/getting
 kvmclock

When computing the current kvmclock value, don't pin the task to the
current CPU for the entire duration of the master clock path, as the
CPU pinning was never about ensuring rdtsc() and cpu_tsc_khz would
agree.  As pointed out by David, ka->use_master_clock can only be true
when the host clocksource is TSC based, which in turn requires a stable,
constant and synchronised TSC across all CPUs.

The CPU pinning was added in commit e2c2206a1899 ("KVM: x86: Fix potential
preemption when get the current kvmclock timestamp") purely in response to
a CONFIG_DEBUG_PREEMPT=y bug due.  Despite what the comment would suggest,
including rdtsc() in the {get,put}_cpu() section was opportunistic.  In
fact, Paolo even said exactly that when suggesting that KVM guarantee the
rdtsc() would execute on the same CPU[*].

 : Also, rdtsc() should really be on the same CPU as __this_cpu_read.  We
 : know it's not really really necessary because the master clock is
 : active, but since we need a get_cpu/put_cpu pair, better be clean.

Nothing has changed in the last ~9 years, i.e. the rdtsc() still *should*
be on the same CPU, but super strictly speaking, all will be fine if the
task is migrated between grabbing the frequency and doing rdtsc().
Dropping the CPU pinning will allow dropping the rdtsc() entirely without
having to resort to a large "rewrite get_kvmclock()" patch.

Opportunistically add a comment to explain why KVM needs to snapshot the
frequency, because that _is_ a hard requirement to avoid reintroducing the
bug fixed by commit e70b57a6ce4e ("KVM: X86: Fix softlockup when get the
current kvmclock")

Link: https://lore.kernel.org/all/ae8de642-8f14-a70a-1fab-57e2c4093cd5@redhat.com [*]

Suggested-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/x86.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index d5a05acf20ad..f64726e08f00 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -1638,13 +1638,18 @@ static void __get_kvmclock(struct kvm *kvm, struct kvm_clock_data *data)
 {
 	struct kvm_arch *ka = &kvm->arch;
 	struct pvclock_vcpu_time_info hv_clock;
+	u64 tsc_hz;
 
-	/* both __this_cpu_read() and rdtsc() should be on the same cpu */
+	/*
+	 * Snapshot and validate the TSC frequency as kvmclock_cpu_down_prep()
+	 * zeros the per-CPU value when a CPU is going offline.
+	 */
 	get_cpu();
+	tsc_hz = (u64)get_cpu_tsc_khz() * HZ_PER_KHZ;
+	put_cpu();
 
 	data->flags = 0;
-	if (ka->use_master_clock &&
-	    (static_cpu_has(X86_FEATURE_CONSTANT_TSC) || __this_cpu_read(cpu_tsc_khz))) {
+	if (ka->use_master_clock && tsc_hz) {
 #ifdef CONFIG_X86_64
 		struct timespec64 ts;
 
@@ -1658,15 +1663,13 @@ static void __get_kvmclock(struct kvm *kvm, struct kvm_clock_data *data)
 		data->flags |= KVM_CLOCK_TSC_STABLE;
 		hv_clock.tsc_timestamp = ka->master_cycle_now;
 		hv_clock.system_time = ka->master_kernel_ns + ka->kvmclock_offset;
-		kvm_get_time_scale(NSEC_PER_SEC, get_cpu_tsc_khz() * 1000LL,
+		kvm_get_time_scale(NSEC_PER_SEC,  tsc_hz,
 				   &hv_clock.tsc_shift,
 				   &hv_clock.tsc_to_system_mul);
 		data->clock = __pvclock_read_cycles(&hv_clock, data->host_tsc);
 	} else {
 		data->clock = get_kvmclock_base_ns() + ka->kvmclock_offset;
 	}
-
-	put_cpu();
 }
 
 static void get_kvmclock(struct kvm *kvm, struct kvm_clock_data *data)

base-commit: c9ed17959337edfc904f59e7ed1f569918f260ca
--
