Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A555E4963A2
	for <kvm@vger.kernel.org>; Fri, 25 Sep 2026 23:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790377314; cv=none; b=gj9iANcNka3WpvV2XB4sz0mBy5u/mK3vbiiOGSVXmp7jAWJdQBMX7sxAOKVn2T3CHMhJ9ZzxpH7QbFFXNIea5PiBtsVisuIbHdm9j8kdoh9N2khjorq+KDj+y9WI83kpmZjbdVCB0wrLcLoocpP91xDkimi0jY2xbt9tTLq8SmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790377314; c=relaxed/simple;
	bh=L3J+56zlEdmpnO5WabCL8ZUcxGQhEmYvE3avTDz5tHc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rNikb/6b4LPPyK60WkP9eHUJbTwqFH65UUn+FMSENz4EFnyxJYhqXdYyXnM3/i3+84ekRaj0CWazQvCpt89ug8eSIx/YuzAEiYX7lUKUbsVk+jmIhIyY1/ln90giNxqzfKPazOnscS+sUT7xXjCBYA+Va6d2icDGPmqEKPYGbMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EHa/xRqY; arc=none smtp.client-ip=209.85.216.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EHa/xRqY"
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-38f57e31b6eso977756a91.1
        for <kvm@vger.kernel.org>; Fri, 25 Sep 2026 16:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790377313; x=1790982113; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+IUXo0bspbCxY9/f+4hZTH/lcGhDMRDgtO4PG9sYyF0=;
        b=EHa/xRqYG3d9EgEqgxREts+AAHnLvIuEhE90WoNPI854JjMHJaPTXq/Dgipq5XhmLG
         dBR/qeBPiE3Ij3SNjLgAmkxA+HVm8GChnGEY9az1MUJ9Py22lFoN3xxl370gakf0H/NK
         1gCSkqcYr/n7ZljjbQQGqB1VShWGpsKPPzsRjGH3KLOH6B6rQSjOmA18kGmo0cmn+9Gs
         eKG/HJoqZRCo4MdtJWD2VsmoW+Cue7heAz6uyjGUy1VB7N/ssN39kL+4wreGq3Ptt9Lp
         WSTUlR5X27LoyHGmvAC9iUkfo0gUlbLXIVNRRXnBGoS36KGOLxj7mC58vyQ4xuwaTPIY
         X7YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790377313; x=1790982113;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+IUXo0bspbCxY9/f+4hZTH/lcGhDMRDgtO4PG9sYyF0=;
        b=NKdHD9pqfo0V4r0kPpcVI9MWUlm9dVRnPwCyRmct/YiotlB2XyjQrEKYkKr9JEmxdE
         4nsZiQbfHj45b2Bqt7+3t3rqSpSkF5gXnu1/zdLTPAlt+9e9wpNUeGQ0ApUTvjCQDDph
         8Ux+aPuTZ+ZC4RFvj2Jh/X2E5gnnSguL6YK1DkCRkrWWrzfkrerdKxw/7dbfq4kk2MgE
         /mrnJs/EeGV0mGOq3HElubIdgHsLWji9UYq3/TPBeKmgNkmdnhw5cPYBYHhL0EqqwUWs
         z2bXZixaMmnWHy1fHH/lTJ1QWAcqeQDcoDnh5uIm5PatM0RXwWpWBhOYW0SJ5awRfWhd
         BY7g==
X-Forwarded-Encrypted: i=1; AKwUvBzYGUD+PWjIGkyV8lPoK5Ja0i9BsbLdO0+P3Bh5fZ05ReXBVQDflOuaG4QUWWEmflcvWOg=@vger.kernel.org
X-Gm-Message-State: AFuF++lJLWSlIPfLtS+219By1WdoLgiw8ETcvz10gqmFHGvbVCTiWI31
	mAJ8/sJhcHWKlgq6etFG25fMYYzNWRoRnmdaZUdyCC5L5eTveX9HO1y2mlb9sZFbFDOnnO4XMlG
	zUTsy+Q==
X-Received: from pjbiw1.prod.google.com ([2002:a17:90b:4201:b0:3a0:c6bd:3eb5])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2686:b0:3a0:e0a5:dbc9
 with SMTP id 98e67ed59e1d1-3a0e0a5df00mr124309a91.62.1790377312819; Fri, 25
 Sep 2026 16:01:52 -0700 (PDT)
Date: Fri, 25 Sep 2026 16:01:52 -0700
In-Reply-To: <arazNV7Y93gnflU2@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260721050600.87268-1-shivansh.dhiman@amd.com> <arazNV7Y93gnflU2@google.com>
Message-ID: <arb9YBIW8C5KXuXK@google.com>
Subject: Re: [PATCH v4 0/5] KVM: SVM: Add Bus Lock Detect support and refactor LBRV
From: Sean Christopherson <seanjc@google.com>
To: Shivansh Dhiman <shivansh.dhiman@amd.com>
Cc: pbonzini@redhat.com, tglx@linutronix.de, mingo@redhat.com, 
	kvm@vger.kernel.org, x86@kernel.org, yosry@kernel.org, jmattson@google.com, 
	thomas.lendacky@amd.com, nikunj.dadhania@amd.com, ravi.bangoria@amd.com, 
	santosh.shukla@amd.com
Content-Type: text/plain; charset="us-ascii"

On Fri, Sep 25, 2026, Sean Christopherson wrote:
> On Tue, Jul 21, 2026, Shivansh Dhiman wrote:
> > Shivansh Dhiman (5):
> >   KVM: SVM: Refactor svm_update_lbrv()
> >   KVM: nSVM: Disable LBRV in nested control cache when unsupported
> >   KVM: nSVM: Sanitize nested DR6 using kvm_dr6_fixed()
> >   KVM: SVM: Turn DEBUGCTL_RESERVED_BITS into a helper
> >   KVM: SVM: Add Bus Lock Detect support
> 
> I'll send a v5 as I have variety of changes (I already responded to each patch),
> and I'm not in the mood to deal with another version as I'm quite grumpy that no
> one bothered to follow up on Sashiko's bug report, or to write tests.
> 
> I'll also post a KUT testcase, which I created to verify the bug Sashiko pointed
> out as well as the fix. 

You know what I *love* doing on a Friday afternoon?  Debugging ucode bugs because
apparently hardware engineers are also allergic to testing.  Or maybe the APM just
sucks more than usual.   But the behavior fundamentally breaks virtualization, so
IMO it's a hardware/ucode bug.

On Turin (the only AMD hardware with Bus Lock Detect I've tested), hardware/ucode
forces DR6.BLD=1 if DEBUGCTL.BLCKDB=0, even on software writes and even on loads
of DR6 via VMRUN (this last bit is what really throws a wrench in virtualization).

Software can still read DR6.BLD=0 if DEBUGCTL.BLCKDB=0, but if anything touches
DR6, DR6.BLD gets clobbered back to '1'.  E.g. if the guest gets into a state
where DR6.BLD=0 and DEBUGCTL.BLCKDB=0, then AFAICT *any* #VMEXIT will end up
setting guest.DR6.BLD=1 on the subsequent VMRUN, which is just a wee bit problematic
because it means asynchronous #VMEXITs, e.g. for host IRQs, clobber guest state.

I'm still going to post v5 because I'm fairly confident the KVM implementation
is correct, and the bug is easy enough to workaround in the testcases, but needless
to say, I'm not happy at the moment.
