Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 345973BE632
	for <kvm@vger.kernel.org>; Tue, 10 Mar 2026 21:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773179143; cv=none; b=NXS/0YvEcVuh18gVjU/uvGb5PH+kAEcwU0l7SOdh0VLG38Dq2Ee/Kpg9TVJdVISPmvxIcrTlyRzHJCcHgDiwx6uX3DzBhfGToJzsb0nfeG3O5HpJb38X+iZTzO1Mk6+kN0e7Lz4SXDxdmKbYcOE9P7kmv2+1E7nB0H3OkfS3vQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773179143; c=relaxed/simple;
	bh=QlaFgsjDaKMlaefpjq5rttwOzm3rAzssFdyiWIgHHA4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jzc3g0SxYrOKN3A58KwFdpOR9fiTRVCCwughe5ckOvz9tkq+cZBA3q2oFOmskRJwv69OpGV937OMVbGn0BLUiBGZ708wgH8pdq8/SNujyGPGaDQGJ4KrA0H9tYaw5WW4Lm7wemHL/1wFCIKQ5S/p2JeRM1vWWX2/uMaLSjkyfFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qL/Q/kuh; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qL/Q/kuh"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c73a4983fc0so2215262a12.3
        for <kvm@vger.kernel.org>; Tue, 10 Mar 2026 14:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773179141; x=1773783941; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QVjoBlNwavndP4dpYczZRuWnT/XlWExgfJCjkiDhl4A=;
        b=qL/Q/kuhlq506ei0w748I3yKAk0vT9Tup4KmvS+twWLqlxsdLVoKLKRf2T4Ob2XD2L
         F7/0c5oYYPlU8ZuYpCyvURE9CbSyLnaalYbJdb9jwJxlIbQiXkyAiMQcuJfvuuz4OEFI
         9Q1w4LCqUd/4RsNMkZpo9mmmXEqwYcIYwiNk4sDjW6rTJV/3skK68/vl6q9sGfGOdZpF
         A6A9zscb2a29yNmYL6Mw+huRy0ptOrYep2057IwDn7rTRzggjESTPCxwkdBFHMfVv7Ut
         5nSqtOsbzf5Wtubz1gICtB4qi922uspDt2Y4zuJg2u4s5clD5L2OdI7PBGqwgSfl+r8X
         0xhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773179141; x=1773783941;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QVjoBlNwavndP4dpYczZRuWnT/XlWExgfJCjkiDhl4A=;
        b=mM/lwX4uC6zbvyCYRrgADtoaew66r73JUxs8hVeqmc3MyaRY0JJGuXqAjHRoeEeube
         sU6rikFZgXnZanFQ+Rd5FVH/ESTSZ47Kxkvz3EyATWXGwY2E0JTiDwKYdRAA8E6K76vO
         gOmBoLAYyZib6bxLBjpS+Jli5nU7KTH60V32TmE9TbB2ZYjzrSrndN3q0lWyhdKLzxc6
         +jfaPF5n14g0NKohnJ8helv5oiKwXD/JBkUpEQV/Pv6NgDh9AY2u0DjcoA3xH8HzRSoz
         IxlcqGmSbacN62OpbKT3XwowRHdAvtYHOzJUiewSH+DpLe96cYUA+Y7tz9JIJEPmmems
         PGxg==
X-Forwarded-Encrypted: i=1; AJvYcCWyCcX4gcE2LkryYd2e/vvvaLsACiLk5LbPaHlU+vvJsb/xvlIMeLBsumxWgCStqBUrID0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKqnjaPs+hK1B/T2oeAH8uk0louQMzRvRPha/WwmgDJVRFruPm
	x5/WfuD5O5FSFQTQ5PWfeaZEgTMp3MNXSSkFW5jRRW2/z0tl7iFptzXFjsClCAvk6/F+u+edsup
	0dmC7kg==
X-Received: from pfbif9.prod.google.com ([2002:a05:6a00:8b09:b0:829:741b:b07f])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1408:b0:7fc:da5:f85c
 with SMTP id d2e1a72fcca58-829f706cf4dmr320645b3a.38.1773179141300; Tue, 10
 Mar 2026 14:45:41 -0700 (PDT)
Date: Tue, 10 Mar 2026 14:45:39 -0700
In-Reply-To: <CAO9r8zOLc030xTsnkYWvp5yUtnzQgVZnXXhvKZWC__1wRSP61A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260310202414.406078-1-pbonzini@redhat.com> <20260310202414.406078-3-pbonzini@redhat.com>
 <CAO9r8zOLc030xTsnkYWvp5yUtnzQgVZnXXhvKZWC__1wRSP61A@mail.gmail.com>
Message-ID: <abCRA_B2kHp6T7Zn@google.com>
Subject: Re: [PATCH 2/5] KVM: SVM: check validity of VMCB when returning from SMM
From: Sean Christopherson <seanjc@google.com>
To: Yosry Ahmed <yosry@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	xinyang@anthropic.com, stable@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Tue, Mar 10, 2026, Yosry Ahmed wrote:
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> > ---
> >  arch/x86/kvm/svm/nested.c | 12 ++++++++++--
> >  arch/x86/kvm/svm/svm.c    |  4 ++++
> >  arch/x86/kvm/svm/svm.h    |  1 +
> >  3 files changed, 15 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
> > index 7b61124051a7..de9906adb73b 100644
> > --- a/arch/x86/kvm/svm/nested.c
> > +++ b/arch/x86/kvm/svm/nested.c
> > @@ -419,6 +419,15 @@ static bool nested_vmcb_check_controls(struct kvm_vcpu *vcpu)
> >         return __nested_vmcb_check_controls(vcpu, ctl);
> >  }
> >
> > +int nested_svm_check_cached_vmcb12(struct kvm_vcpu *vcpu)
> > +{
> > +       if (!nested_vmcb_check_save(vcpu) ||
> > +           !nested_vmcb_check_controls(vcpu))
> > +               return -EINVAL;
> > +
> > +       return 0;
> > +}
> 
> Nit: if we make this a boolean we could just do:
> 
> bool nested_svm_check_cached_vmcb12(struct kvm_vcpu *vcpu)
> {
>        return nested_vmcb_check_save(vcpu) && nested_vmcb_check_controls(vcpu);

I don't care one way or the other for this particular patch, but once the dust
settles on nSVM (assuming it ever does) I do think we should align the "nested
check" return types across nVMX and nSVM (which is likely why Paolo ended up with
the above; I requested using -EINVAL for the nVMXx) patch.

My fairly strong preference is to use 0/-errno as "return -EINVAL" is more
obviously an error than "return true".  But we can bikeshed later :-)
