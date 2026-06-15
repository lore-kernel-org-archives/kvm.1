Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 987D43F8EBE
	for <kvm@vger.kernel.org>; Mon, 15 Jun 2026 15:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781539103; cv=none; b=I01mAr3zy6dqVr/v5En2W2o2gunLU1v/j0LNlnXWmuqz7It2/GIRpN46uyUmeoStuU2PL+VMrstjvkM8dE+tqKYL6O4OnG5rju3jiaQCF9TusW6WlNYqADjjWvu/YIjkNWpWeailIqSqZsKIh34zkUMwpH/6cIFrmrw9Kd3Sv4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781539103; c=relaxed/simple;
	bh=I+DR1pNzXtKcuRbs9Njwc92GwL235DG/3GcS0frKoxk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mbUF+XrnZ3WmktHlTCureT5Hl3l4fbw6WZRbBZ5fxt/NLvdKlEyOhJJBdQdInZ59tzt8aP2vjY7lKN+puCUUyuAQ+jAZZ4JHKanuS+k9u40yUhPRvNwpmJNRuZc2EM5nmmDzkUXV9pdyhXc21PF49TyYDWrwdN6eYeBGSEVKIxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=G4Eu0KU9; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G4Eu0KU9"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c856470fe9fso1658956a12.2
        for <kvm@vger.kernel.org>; Mon, 15 Jun 2026 08:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781539102; x=1782143902; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=33KCjcGTgcv8UBHIf/Cpeyc0cN1DzMaZSJM+rR0CRKo=;
        b=G4Eu0KU90rBm4/W78h5FE4auLIVg5jrqDLFMhJpJtbtH8qhUfQGxk6VbCF345ulmcX
         fnC5J1og/gn+xosxkghIprwzHkC0ZQaIeLJSv8/1sWNRvW8sQ9zU7Jtw+cLrFxRykz2B
         bA9FHqJKlkeIfWyxtB1E5hpLMpvK82iKyY3Xn2uXsWatr95mA2ms+rsb4LVFqhwwj8jQ
         eyx6rYEboe+eUGbONC+gEoJQ93s1XfMkQR/5lCNAmu/yM41XZF52NssqMgO7qIp8Nqv/
         erLKWTQG8tiHioGAQeMzyiqcnOcuVnll7bv6CIN6BJ6pkmwcdClTzKFqx4YUAvE+w594
         RiOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781539102; x=1782143902;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=33KCjcGTgcv8UBHIf/Cpeyc0cN1DzMaZSJM+rR0CRKo=;
        b=X4q68OsPZjl9RW//RUjFq11OUNg7583KMvEdZPxnPkONsFf54Rfu8kESj8Jy9V3Ozi
         Ejevj/wwN9ci7tqlCeH3ol+/HzItCOZamRV5/IzI6Wo76mcwvS8GvGTY/YNw86wq0o93
         np1VfLKn5mjPzZUpkuw6xQpl+e1syqf9+qVgMhzKDEHHWmW8GEYHMKoakByF4MLQjPCu
         YwuyVaNO+U2s4TwTRpbGZy4YWdkfC7EjHBnD5MSF5gy2YlyxdrFR7ZON+cVCA5bx7Dd+
         CC6eImaC++U2kMBNZ8h0EsAgNW5Hs/og7kMSXydpaDucay+AGHDThIyN+HE698nQ4cHQ
         pqlQ==
X-Forwarded-Encrypted: i=1; AFNElJ9P8F1Pgj77kLkgw5axpzCzTSZBEH302FKSSkX01Lue75bITuwIDjvCKGyaLCavWHOcHbw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLZZ9e94dzzDV1rPd2PYNHbMSQftVH38E87PQDh3bHy0oYCo0E
	Tg18rtSkTtwnf/yQIKi3mseINpZKXg59CLBd1e0U9T9QleDL82fNvxVNVYBn21DpFh4eVyPhpiL
	uBVA2yg==
X-Received: from pgck131.prod.google.com ([2002:a63:6f89:0:b0:c85:86ac:38d7])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:144d:b0:398:840d:39aa
 with SMTP id adf61e73a8af0-3b783f0a3c3mr17092834637.29.1781539101803; Mon, 15
 Jun 2026 08:58:21 -0700 (PDT)
Date: Mon, 15 Jun 2026 08:58:21 -0700
In-Reply-To: <01e58880-844c-4e5c-825c-ed7c3ab65454@linux.intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260613000329.732085-1-seanjc@google.com> <20260613000329.732085-4-seanjc@google.com>
 <01e58880-844c-4e5c-825c-ed7c3ab65454@linux.intel.com>
Message-ID: <ajAhHQfVR_uws8Dn@google.com>
Subject: Re: [PATCH v4 03/30] KVM: x86: Rename __{g,s}et_sregs2() => kvm_x86_vcpu_ioctl_{g,s}et_sregs2()
From: Sean Christopherson <seanjc@google.com>
To: Binbin Wu <binbin.wu@linux.intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Yosry Ahmed <yosry@kernel.org>, 
	Kai Huang <kai.huang@intel.com>
Content-Type: text/plain; charset="us-ascii"

On Mon, Jun 15, 2026, Binbin Wu wrote:
> On 6/13/2026 8:03 AM, Sean Christopherson wrote:
> > Rename the KVM_{G,S}ET_SREGS2 helpers in anticipation of moving them out of
> > x86.c (while leaving the ioctl dispatch behind).  Having globally visible
> > APIs named __{g,s}et_sregs2() would be "fine", but ugly, given that
> > __{g,s}et_sregs() will NOT be globally visible.  As a bonus, this makes it
> > a bit more obvious that the helpers implement newer versions of
> > kvm_arch_vcpu_ioctl_set_sregs().
> > 
> > No functional change intended.
> > 
> > Cc: Yosry Ahmed <yosry@kernel.org>
> > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > ---
> >  arch/x86/kvm/x86.c | 16 ++++++++++------
> >  1 file changed, 10 insertions(+), 6 deletions(-)
> > 
> > diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> > index 0f48cd630c32..0fa8a9e3b8b2 100644
> > --- a/arch/x86/kvm/x86.c
> > +++ b/arch/x86/kvm/x86.c
> > @@ -133,8 +133,10 @@ static void __kvm_set_rflags(struct kvm_vcpu *vcpu, unsigned long rflags);
> >  static void store_regs(struct kvm_vcpu *vcpu);
> >  static int sync_regs(struct kvm_vcpu *vcpu);
> >  
> > -static int __set_sregs2(struct kvm_vcpu *vcpu, struct kvm_sregs2 *sregs2);
> > -static void __get_sregs2(struct kvm_vcpu *vcpu, struct kvm_sregs2 *sregs2);
> > +static int kvm_x86_vcpu_ioctl_set_sregs2(struct kvm_vcpu *vcpu,
> > +					 struct kvm_sregs2 *sregs2);
> > +static void kvm_x86_vcpu_ioctl_get_sregs2(struct kvm_vcpu *vcpu,
> > +					  struct kvm_sregs2 *sregs2);
> >  
> 
> Existing code uses the pattern kvm_vcpu_ioctl_x86_xxx, is it better to
> align the pattern?

Yeah, good call, I'll use kvm_vcpu_ioctl_x86_xxx.  In find the effective namespace
to be a bit odd, but that's not a good reason for these to be different.
