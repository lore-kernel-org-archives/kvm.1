Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF61397328
	for <kvm@vger.kernel.org>; Tue, 12 May 2026 13:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778593938; cv=none; b=BJOJoa49lShAF0rX60iOw/Bz6oDPuNt7DENOTOmHYd3k9AnA2qQ4g/j3CdmHTK4wQXHG00aC4JPAoPWEht0PO0KtiF2Nzy+wjrTeAbpyYh24gt43HG3Uok+/2VC953ZPx7bwCP59aEnhoM3Xd138yWsb4QCob7h94GhNQqQ9EkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778593938; c=relaxed/simple;
	bh=uL93vXpHpqKCsIGgq9Bj+K9slRWvqHY4YGtrj7e579Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FIQpGyMmdKFdJ/wupCQazkrONEAy5GX4999om3fGkLfX7/YVeAC+pt5lPu82d2S2MhosapYtmHwvJhJwqX6H5O98LlYb5YXtaXZOYfRN9hMUAfZZj0X4u/Hl3uyXq4zP/qD3y2Z5C8AVptYTIvl2V7FwKB1mDQfcICbBZiWQuok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=W996ew54; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="W996ew54"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-36641bb3d97so3356716a91.3
        for <kvm@vger.kernel.org>; Tue, 12 May 2026 06:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778593935; x=1779198735; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Xp2eTULm+es8Wu3cc+9ip/4cUy4gWIHFr5oWFmkPRoM=;
        b=W996ew54WeD7stfdGjMyZpdT7Z6GX/3jyMeK9paaKEocEjIbAseULStIf8HhB/j7dJ
         Q6VWif9N9CWf4Vg7QB3NFdtcn409GzwArpfqGyWYC/CwTqAmPAKu8wRe7k+FUvNdkDgb
         CfOqKCE6cRKQmCUlDZF0v1pR7MQI96Bgg5W6DoVeoXoM9frJ4UmX8B0EhqUzhu4Ro53f
         c+v5KrVnflafnnIP3knzY/RgBaM0t8SUfUoPD94woJojySSd5Dn8a5ZyhN8ZPrt20K/x
         1aJMyrwc+BJAIcBs5EgELW3PNzyUb7kmhDpVfmyltzquTr+wri6Je9DNzoScMbs1fkOs
         ZLCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778593935; x=1779198735;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xp2eTULm+es8Wu3cc+9ip/4cUy4gWIHFr5oWFmkPRoM=;
        b=GDEGhvb3iTi9W/bEcOdwVY1nREzohbTbz2UpfzimlUJEOhc+i3xR3hUE3JfA5D3XHM
         j8MkIn/E0e7cAy9KuP1KzuDggf1JFNS/1RlOZaIlVUrFc9PzJXXjqkfaoRKw43sdmskO
         /WxPiFhOsNVAJ8xPzipQN8hFkORzZ0uMCXllPzcACX1iZl2/tID4mFBgYnRBi9hkfscL
         J3neE7trjSlYQqbmIojDMCUCeYRr1EoFNJZ4SQXYVIe5g3mw9HiJ2uPWKmPYSUvaWole
         lflTsf4XDg5xdU14rHv08vnTYdWFGFLnhYsVPK/ghFETN+0LHkEr0cuGGbalcTm+vZNC
         YG1w==
X-Forwarded-Encrypted: i=1; AFNElJ/GZrgN6Wh39GlrnuLh5awHKzudMaqAEHLAi3fb+33qVrIBWFn7JboEy/fbE+dcmqsgpHg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyC1eTXAo4O6300UdBucvG/YfHt90+ddLBCD/ZPkCAFfc+Di5k9
	Asec6n338i3uO8Dw7WDYSahtO1z8ZmGR7T7EtD+lntKp7gdORcTtHn5fSlxG5Ix9JPJGdHHS+sG
	7lbFO3g==
X-Received: from pjbsl3.prod.google.com ([2002:a17:90b:2e03:b0:368:4cf0:fd0])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2e0f:b0:368:9da3:c496
 with SMTP id 98e67ed59e1d1-3689da3c65dmr6116340a91.24.1778593935072; Tue, 12
 May 2026 06:52:15 -0700 (PDT)
Date: Tue, 12 May 2026 06:52:14 -0700
In-Reply-To: <agHwV8Btww3ku3Xf@arch-piotr>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260511143426.1242013-1-piotr.zarycki@gmail.com>
 <agHuMh96_kDr3ENG@google.com> <agHwV8Btww3ku3Xf@arch-piotr>
Message-ID: <agMwjrRbeuJsi9OC@google.com>
Subject: Re: [PATCH] KVM: selftests: sync_regs_test: use KVM_SYNC_X86_VALID_FIELDS
From: Sean Christopherson <seanjc@google.com>
To: Piotr Zarycki <piotr.zarycki@gmail.com>
Cc: pbonzini@redhat.com, shuah@kernel.org, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Mon, May 11, 2026, Piotr Zarycki wrote:
> On Mon, May 11, 2026 at 07:56:50AM -0700, Sean Christopherson wrote:
> > On Mon, May 11, 2026, Piotr Zarycki wrote:
> > > Use KVM_SYNC_X86_VALID_FIELDS instead of open-coding the same three
> > > flags, ensuring the test stays in sync with any future additions.
> > > 
> > > Signed-off-by: Piotr Zarycki <piotr.zarycki@gmail.com>
> > > ---
> > >  tools/testing/selftests/kvm/x86/sync_regs_test.c | 3 +--
> > >  1 file changed, 1 insertion(+), 2 deletions(-)
> > > 
> > > diff --git a/tools/testing/selftests/kvm/x86/sync_regs_test.c b/tools/testing/selftests/kvm/x86/sync_regs_test.c
> > > index e0c52321f87c..8f9239f9d357 100644
> > > --- a/tools/testing/selftests/kvm/x86/sync_regs_test.c
> > > +++ b/tools/testing/selftests/kvm/x86/sync_regs_test.c
> > > @@ -79,7 +79,7 @@ static void compare_vcpu_events(struct kvm_vcpu_events *left,
> > >  {
> > >  }
> > >  
> > > -#define TEST_SYNC_FIELDS   (KVM_SYNC_X86_REGS|KVM_SYNC_X86_SREGS|KVM_SYNC_X86_EVENTS)
> > > +#define TEST_SYNC_FIELDS   KVM_SYNC_X86_VALID_FIELDS
> > 
> > Explicitly defining the set of fields to test is very deliberate.  (a) we want
> > to detect ABI breakage, e.g. if KVM removes a valid field.  (b) if a field is
> > added in the future, the test likely needs to be updated, i.e. would break if
> > KVM extends KVM_SYNC_X86_VALID_FIELDS.  (c) KVM_SYNC_X86_VALID_FIELDS probably
> > shouldn't be defined in a uapi header; for all intents and purposes it's a KVM-
> > internal details.
> > 
> > >  #define INVALID_SYNC_FIELD 0x80000000
> > >  
> > >  /*
> > > @@ -255,7 +255,6 @@ KVM_ONE_VCPU_TEST(sync_regs_test, req_and_verify_all_valid, guest_code)
> > >  	struct kvm_regs regs;
> > >  
> > >  	/* Request and verify all valid register sets. */
> > > -	/* TODO: BUILD TIME CHECK: TEST_ASSERT(KVM_SYNC_X86_NUM_FIELDS != 3); */
> > >  	run->kvm_valid_regs = TEST_SYNC_FIELDS;
> > >  	vcpu_run(vcpu);
> > >  	TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_IO);
> > > -- 
> > > 2.54.0
> > > 
> 
> Thanks for the explanation. What's the preferred way to implement the
> build-time check mentioned in the TODO? 

Honestly?  Just delete it.  It should be quite obvious if someone updates the
test to add more fields, without actually adding coverage for the new field(s).
