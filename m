Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6BE33438A6
	for <kvm@vger.kernel.org>; Wed, 30 Sep 2026 18:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790791688; cv=none; b=ElB5Xt/L7jXVAollCuX+OqnrSfYQaQza0mh6u8fjEN4OR+F9wb6ZW8JiEZOfafIzVyeO4DYBjF/KdDR4KZVfLSD9ZgNjTvgr70NMVXeHpY4ElKxRb+O5W6AF6KYyJtSWFhDW7KAy8rWXnYBrsQ5S28l9afFujArjKcF1jDeGBtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790791688; c=relaxed/simple;
	bh=NiiQJkuccUczGrWh0LiomR77FtCqDVmyxyxwHTvsd7A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Qf0Y20E97EoY8gqqratGCtJ1eU0+pDed8hDHmMEz76tJS8EGlgYo2V0GSk1cM3NfGodMgG/SnK3E7kdh2ooiMQQLYn7MVkPhJtf6llmfENypp4uANBmrJbW6EQ8o0cD0MpKpRSHG1rE7ZD8GNNlr5aqJIOdIW9nLNA2Sbrcy1PE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XU2U4Yqb; arc=none smtp.client-ip=209.85.215.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XU2U4Yqb"
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cbe77d6864dso5082602a12.2
        for <kvm@vger.kernel.org>; Wed, 30 Sep 2026 11:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790791686; x=1791396486; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6NNX44iKkcgMJ1PQ5IbJDGYTLu046lxpWsr4gvHBYXc=;
        b=XU2U4YqbmvLAjqoAAnEDWOL54SEK/0n8l9b2+NGwK3JdAXxrXGxHgGB+1srgyifJBJ
         xOsv9DJ/KcZaWfWvNp3RpNRIkNr4i/mdlCEmgdIiDG7WkO19FJdmakKT/OY4tcgf8ttl
         11+nGfaZqSCKv7Fbbsp0+/d525WJsHHeIBWpWQX1wgpu+Xq15HOScrO+Xnl6y9pHwcMI
         NY9vEpBgOB6avvtTBkC35yJfpWxN7y7nIgnJ296ByzN+Q3yS+RTOIE+IKQJFmN7itP7e
         IskND9eL2LndAaiMcAKs1ysPiJYjyXlTPP1ExsHQU/HB52vsNRN65f4MKS+DkJlUnLYb
         bvGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790791686; x=1791396486;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6NNX44iKkcgMJ1PQ5IbJDGYTLu046lxpWsr4gvHBYXc=;
        b=bqsX9/OpDzLmOiHdF7qSmglZO8KrVvQd9M3AUjpezpEwibCZdHGoGVmbuL2n2aIplm
         YyduZSu0M8MJbLynV1PGNJ3Ijw47eRlFh6KRc++MMMJMRCv07AZnsFyyRrOYyqIud8J8
         R6cMOZ11rSGVDSSEBrAhY/zHNKBDF3r8agmItQ6SXmQoRoV0Elbw9sgtHdHMoewQsCKK
         YyhfrN4AwpOTd+oJCbQ96KYhDng+JgjP1DoOC7qlAB0p7sq694hX/YlUPa3i9W7AQ2w8
         UTytLe2Z6aKBrauApv2luXOguhpqUbl4IV5f7lkoBeeAaV9YcYMe0jguClqf4srk5saD
         2Lnw==
X-Gm-Message-State: AFuF++l6Iy82tPXGZYD/5HJHXtv/ZRXhAHAgCymSxtvIlLjnDQJBMd/t
	SavmBTskIIOWriou4G4hXUGWWA0GDPcghmKJTjA2AI0c6sAjdJFZKSQC8ewmtsG6PJSOLnnxrvN
	8lb0ZJA==
X-Received: from pgte12.prod.google.com ([2002:a65:688c:0:b0:cc7:d698:697e])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:9218:b0:3de:5ce4:9e55
 with SMTP id adf61e73a8af0-3de9e8e0dc0mr2432459637.59.1790791685923; Wed, 30
 Sep 2026 11:08:05 -0700 (PDT)
Date: Wed, 30 Sep 2026 11:08:05 -0700
In-Reply-To: <20260930175237.A8FD21F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260930173635.3362655-1-seanjc@google.com> <20260930173635.3362655-14-seanjc@google.com>
 <20260930175237.A8FD21F00898@smtp.kernel.org>
Message-ID: <ar1QBSKMGJUFBExK@google.com>
Subject: Re: [PATCH v3 13/21] KVM: selftests: Use KVM's reported TSC KHz as
 L0's frequency (sanity checked)
From: Sean Christopherson <seanjc@google.com>
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Wed, Sep 30, 2026, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [Medium] kselftest: random test flakiness due to strict 1% tolerance on sleep(1)
> - [Low] kselftest: masked ioctl failure check due to u64 cast and multiplication
> --
> 
> commit 44c3625d55f5d8d3232ad8e1eb92f5cad1eaa9ab
> Author: Sean Christopherson <seanjc@google.com>
> 
> KVM: selftests: Use KVM's reported TSC KHz as L0's frequency (sanity checked)
> 
> This commit updates the nested TSC scaling test to use KVM's reported
> default TSC frequency instead of trying to calibrate it in userspace via 
> RDTSC. It also introduces a sanity check to ensure the observed TSC 
> frequency roughly matches KVM's reported frequency.
> 
> > diff --git a/tools/testing/selftests/kvm/x86/nested_tsc_scaling_test.c b/tools/testing/selftests/kvm/x86/nested_tsc_scaling_test.c
> > index d790ab36a198e..a78585af0ffdf 100644
> > --- a/tools/testing/selftests/kvm/x86/nested_tsc_scaling_test.c
> > +++ b/tools/testing/selftests/kvm/x86/nested_tsc_scaling_test.c
> 
> [ ... ]
> 
> > @@ -212,18 +209,30 @@ static void test_tsc_scaling(u64 l0_tsc_freq, u64 l1_scale_factor, u64 l2_scale_
> >  int main(int argc, char *argv[])
> >  {
> >  	u64 l0_tsc_freq, tsc_start, tsc_end, l1_scale, l2_scale;
> > +	struct kvm_vm *vm;
> >  
> >  	TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_VMX) ||
> >  		     kvm_cpu_has(X86_FEATURE_SVM));
> >  	TEST_REQUIRE(kvm_has_cap(KVM_CAP_TSC_CONTROL));
> >  	TEST_REQUIRE(sys_clocksource_is_based_on_tsc());
> >  
> > +	/*
> > +	 * Create a dummy VM to get KVM's default TSC frequency.  All CPUs that
> > +	 * support TSC scaling should have a constant TSC, i.e. there's no need
> > +	 * to calibrate the "real" TSC.  But do sanity check that the observed
> > +	 * TSC is within range of KVM's reported TSC frequency.
> > +	 */
> > +	vm = vm_create_barebones();
> > +	l0_tsc_freq = (u64)__vm_ioctl(vm, KVM_GET_TSC_KHZ, NULL) * 1000;
> > +	TEST_ASSERT(l0_tsc_freq, "vcpu ioctl KVM_GET_TSC_KHZ failed");
> 
> [Severity: Low]
> Does this properly catch an ioctl failure? If __vm_ioctl() fails and returns 
> -1, casting it to a u64 and multiplying by 1000 results in a very large 
> non-zero value (0xfffffffffffffc18). 
> 
> Since TEST_ASSERT only checks if l0_tsc_freq is non-zero, won't this pass 
> using garbage data instead of failing the test?

Eh, yes and no.  KVM_GET_TSC_KHZ existed long before TSC scaling, and while KVM
doesn't sanity check tsc_khz, i.e. KVM_GET_TSC_KHZ could return a "legitimate"
negative frequency (when those ~2.17PHz CPUs come along), in practice checking
for a non-zero value is sufficient because any bogus value will quickly fail the
functional checks.

Heh, actually, kvm_arch_vm_post_create() *already* validates KVM_GET_TSC_KHZ:

	r = __vm_ioctl(vm, KVM_GET_TSC_KHZ, NULL);
	TEST_ASSERT(r > 0, "KVM_GET_TSC_KHZ did not provide a valid TSC frequency.");
	guest_tsc_khz = r;

so this is a non-issue.  I agree it's not the prettiest, I just don't care enough
to clean it up.

> > +	kvm_vm_free(vm);
> > +
> > +	printf("L0 TSC frequency is: %lu\n", l0_tsc_freq);
> >  
> >  	tsc_start = rdtsc();
> >  	sleep(1);
> >  	tsc_end = rdtsc();
> > -
> > -	l0_tsc_freq = tsc_end - tsc_start;
> > -	printf("real TSC frequency is around: %lu\n", l0_tsc_freq);
> > +	host_check_tsc_freq(0, tsc_end - tsc_start, l0_tsc_freq);
> 
> [Severity: Medium]
> Could this strict 1% tolerance on sleep(1) introduce random test flakiness 
> on loaded systems?

Yes, but that's pre-existing, and no one has complained, yet...
