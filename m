Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26627CA45
	for <kvm@vger.kernel.org>; Mon, 27 Apr 2026 18:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777315809; cv=none; b=tPgUOdUUeld/Ez6TWnGd3PcoqDocqE33YeybVT9UpLwk1i4bYLhkNvBeh0rxb97HuABAxz2aT74mL1hnYiYOUAyd1uoG0bRm1zp77MlopgNn9b5eILdtwlv+5mVBoBubH4PMV5aMbv4pE+enWeY51iN0JZX6EK+9duVXsjQ/glc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777315809; c=relaxed/simple;
	bh=PpEEh35ily420vdYFXkjffKY1Am2rkbKm+8YIHOFl8w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=h4Dl+L9YwAx0QPNsqaDs8T/sttMTwloQ8AiVnKLmLaGmizVU9OwM7cmJ2CxnXMsJMCo4PuzUEwlY9ifFij9g59xIPaGbIrAQHwBtmw/1nkvFd43wb5fx6VlqXRWq3auA2cHqrW6lllKNrtUw5gyNAf6yulsxKlDY3tm442wVrmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=baGs/0d6; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="baGs/0d6"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2b241be0126so203790405ad.3
        for <kvm@vger.kernel.org>; Mon, 27 Apr 2026 11:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777315807; x=1777920607; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1D0uMxHq1T6Kl6m57IkABPQ2Xq65sMA6twQ3v835jKo=;
        b=baGs/0d6yAVbnHuMp4ofoCMigPzoscV4a4IVDNl1/AVIgnhIsWpDY5ochrAP3Lw8AA
         JPyfVdC864w0tC2fbAtbvNQYYXqvKBhpXJuS9raHeBseR4VX1FlkmRggODin+EWt52lF
         6ZC0dk6WUeFz3UJ5VO78KppFfdAsUr5/VJJsEIbJ+UyDCrN9az/rN32jmf4eFAZO9Urw
         m3K9ZLaqiIaGg76aK4pkWvhs7mGNOdfoCBhLTzoyz+CTimQoNY/ZF3erPEtzHYOST6X9
         9LAxUwYBsB+FYGtHHzTCsh5umamEmpB7dib4xtZbYRfat7fHDu3zOg4+MsAGnuJfSlh6
         ifxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777315807; x=1777920607;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1D0uMxHq1T6Kl6m57IkABPQ2Xq65sMA6twQ3v835jKo=;
        b=UJfOdxcKrE5pWA5BqADw1wfzueny3TP+hEuhIfFl8WNqTAlsNPU9Ragm0nEFL2Behb
         NTALNLO08Mf+DCcC+m6VigAFyjONAzrNWuGWqCtzPH0yRIJafkZR/4TuMgXEpZQKIswy
         4QsJjuLK0EL0dDaXT3ok0DvK8Fd3jeRne9pGpFoyIwBSGnLY8nD1jnM4SK4NhtegaJWW
         yubXqn7MgbXpr8fqXa6kG1GWxi/T+7dQL5Kd8bH5zROpneiKt46ME5gGi3jnjyJv6e/n
         kpMd9pXkfruKUtL3V720CDLfQ+4c16dbc6iGynB8wFmnHxS0rYpocqXJgchKFpvBRCNb
         fwxQ==
X-Forwarded-Encrypted: i=1; AFNElJ/ZRsR/Va9wlXwGeCqHR/+70KHhG55NBGsfnx85Iakwci2ZM8F5HSLxdjDp8+0Z3KdiM/0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwR7sVtvXjIJp2TNVSHh9Ir4CKBYyO+KOlx96N2wjLY8Sqme0v
	6sw4kHqm0blo7v1SH7OxLJ+U+X2fpdfS0X2k1A4wQaiRGGbHyqyzVLCXeRkboYPJfYcIMC/J+7L
	FvEp3Fw==
X-Received: from plnw7.prod.google.com ([2002:a17:902:da47:b0:2b2:4c1c:26de])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2c07:b0:2b0:6f21:8289
 with SMTP id d9443c01a7336-2b97a9459b9mr3932515ad.25.1777315807355; Mon, 27
 Apr 2026 11:50:07 -0700 (PDT)
Date: Mon, 27 Apr 2026 11:50:05 -0700
In-Reply-To: <aesRPt5Vpco29vAt@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260326031150.3774017-1-yosry@kernel.org> <20260326031150.3774017-4-yosry@kernel.org>
 <adReHbkVRDGOihb4@google.com> <aesRPt5Vpco29vAt@google.com>
Message-ID: <ae-v3aGftsAQuG5E@google.com>
Subject: Re: [PATCH v4 3/6] KVM: x86/pmu: Disable counters based on
 Host-Only/Guest-Only bits in SVM
From: Sean Christopherson <seanjc@google.com>
To: Yosry Ahmed <yosry@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jim Mattson <jmattson@google.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Fri, Apr 24, 2026, Yosry Ahmed wrote:
> On Mon, Apr 06, 2026 at 06:30:05PM -0700, Sean Christopherson wrote:
> > I would rather make a single call from kvm_pmu_handle_event(), and let the vendor
> > deal with mediated vs. legacy.  I want to avoid mediated-specific ops as much as
> > possible, and I think kvm_x86_ops.reprogram_counters() would be easier to
> > understand overall.
> 
> I think this doesn't apply anymore now that most nested transitions
> won't be handled through kvm_pmu_handle_event(). Also because we need
> kvm_mediated_pmu_refresh_event_filter() to still be called before
> re-evaluating H/G bits and EFER.SVME.
> 
> I think leave this callback as-is and handle everything through
> reprogram_counter(). Export reprogram_counter() and rename it to
> kvm_pmu_reprogram_counter(), and end up with something like this:
> 
> void __kvm_pmu_handle_nested_transition(struct kvm_vcpu *vcpu, bool defer)
> {
> 	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
> 	DECLARE_BITMAP(bitmap, X86_PMC_IDX_MAX);
> 
> 	if (bitmap_empty(pmu->reprogram_on_nested_transition, X86_PMC_IDX_MAX))
> 		return;
> 
> 	bitmap_copy(bitmap, pmu->reprogram_pmi, X86_PMC_IDX_MAX);
> 	bitmap_zero(pmu->reprogram_on_nested_transition, X86_PMC_IDX_MAX);
> 
> 	BUILD_BUG_ON(sizeof(pmu->reprogram_on_nested_transition) != sizeof(atomic64_t));
> 	if (defer) {
> 		atomic64_or(*(s64 *)pmu->reprogram_on_nested_transition,
> 			    &vcpu_to_pmu(vcpu)->__reprogram_pmi);
> 		kvm_make_request(KVM_REQ_PMU, vcpu);
> 		return;
> 	}
> 
> 	kvm_for_each_pmc(pmu, pmc, bit, bitmap)
> 		kvm_pmu_reprogram_counter(pmc);
> }
> 
> void kvm_pmu_handle_nested_transition(struct kvm_vcpu *vcpu)
> {
> 	__kvm_pmu_handle_nested_transition(vcpu, false);
> }
> 
> Actually, if that's desired, we can move this logic into SVM code now.
> We won't be calling kvm_pmu_handle_nested_transition() from inside
> enter_guest_mode() and leave_guest_mode() anyway so that we can only
> defer for the svm_leave_nested() path.
> 
> So we can move:
> - kvm_pmu_handle_nested_transition() to
> svm_pmu_handle_nested_transition()
> - pmu->reprogram_on_nested_transition to
> svm->nested.reprogram_on_nested_transition
> 
> Not sure if we want to keep SVM-specific logic in SVM code, or if we
> want to keep code generic as much as possible. I can see good arguments
> for both stances.

We can have our cake and eat it too.  Add svm_pmu_handle_nested_transition(),
but then also rename and rework reprogram_counters() to support both deferred and
synchronous operation, e.g. something like so:

---
static inline void __kvm_pmu_reprogram_counters(struct kvm_pmu *pmu, u64 diff,
						bool defer)
{
	struct kvm_vcpu *vcpu = pmu_to_vcpu(pmu);

	lockdep_assert_once(defer || kvm_get_running_vcpu() == vcpu);

	if (!diff)
		return;

	atomic64_or(diff, &pmu->__reprogram_pmi);

	if (defer)
		kvm_make_request(KVM_REQ_PMU, vcpu);
	else
		kvm_pmu_handle_event(pmu_to_vcpu(pmu));
}

static inline void kvm_pmu_reprogram_counters(struct kvm_pmu *pmu, u64 diff)
{
	__kvm_pmu_reprogram_counters(pmu, diff, true);
}
---

and then have SVM code pass in the reprogram_on_nested_transition or whatever.
