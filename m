Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DDF43E3C69
	for <kvm@vger.kernel.org>; Fri, 13 Mar 2026 20:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773432912; cv=none; b=f54NrZVVpduWozj1GAM2Q0ZLl43qbPPnvIkKig4nwgiyqlWNwwoBZ/M9SpllPfkDosTjVhVTEXg4BLBSW4g3QUaTG+QDCGltE1uwJn8oplFBPmBPa+AlBBz3Y/mucV08b5wguEzfUpXYkc0dyD2eMPO+N+BDLk7Lljt0T3KBPfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773432912; c=relaxed/simple;
	bh=LkigBfXP5nrSt/NKbbp+xgEZiGCPNHPaXyp+DB1ZbzI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bYS2/crNIvDMTbTYPVglZiZhajTBWcqurE/n8AR1Lxmrun/Sfbdwer+/LZn2RY4zRGFhKEFJET0SvyXXDA+Yat3iNUiOjiZkTK3uzyQHNE8lxQE4I+OEanSqna2WUACkRNUkknPV3UUjzBLhSuX+UkZ38+Vu3UTq8W+A54ZnH78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IgE5R+qn; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IgE5R+qn"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2aed1beaa73so9633985ad.2
        for <kvm@vger.kernel.org>; Fri, 13 Mar 2026 13:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773432906; x=1774037706; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OKUIDpXb1mJZD+DhKRM7mcbSyQnuN8VP7LdvA9q+E84=;
        b=IgE5R+qnnmvEHQENt8VTtKtiVPnE0EktUcFDftTQytA2tz4yTa0DsgOQlazlVjy+dw
         ibT4OP9DYPVZ9hmNi3td8ZNGHRXgUMYl1T/Njdm7bBB2LVGJ1HDaKom2UiOwc75BN3aU
         cvK9Ew28kQHM9L2cH6sg2AcsiM8BJ6Aml+9kSNZ2OvHVmDmv2lbIY58JxnthXjHmq+Np
         WLW1lJ1Rgu8e3BGJ7FeYoGelQzA04vg5AD83i+Bnf4EqH66nzqdQOKr+5NwfrIObIDKb
         y0u/ibQdG0pA03yin7qluhPmTcCgXiSJQehwmhQ2Ml31eb8krid3pyFgSlF973bCRNBL
         qaIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773432906; x=1774037706;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OKUIDpXb1mJZD+DhKRM7mcbSyQnuN8VP7LdvA9q+E84=;
        b=LJfwQVQ133VnGiTo5JIwTZgBvjuXjdfYIYIaig5yGdgeCMusO+aSc7j2Ni4VdSRv6K
         Rg3gb/tgsnhzTnavn7XE8aF7YP2nbJGAzoEvzDd9w5cg/B9q9H3uGA487LkZzeZ0tzmN
         QyrtQ/dU7Ih+XIROvbNIuPWza4/txXhFHAnHnXxBFvEzee9amIeyx+W3poD/ruQipoWi
         bQxAuWg+YiXOtzaJbEE5pcqEtiYqCCTutznhTh0GwDyIptQaPO+lA5WzYAz75TlqT3t4
         SVVR8bU39WqLUWjzfKK9bxm3H/I1pOh/Knxa2IpxZPsGQ1V1f7fGTJl0khRKYzdPRinD
         dflA==
X-Forwarded-Encrypted: i=1; AJvYcCWBiHg63Ez9bYpPqrsU4mnbz5ARgQtgTx3od08Q7R7rQvpl7s62d5HlMq5/qQl6m8YlLbM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrxRyVQOK5RrnnI6Y+yLkcRjNa6erAk4BhPnMbF2F+amwqNVC9
	x79ZIpEN35J8GXW4tVf8RJUqCw0Qo2ijg1Bk/5oVoHageVCigTv0zcrvJjRcQb2WjQiEbKjIETA
	rMthACQ==
X-Received: from plzt6.prod.google.com ([2002:a17:902:bc46:b0:2ae:abe9:b38b])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1503:b0:2af:c7c:afbc
 with SMTP id d9443c01a7336-2af0c7cb19amr22428855ad.31.1773432906364; Fri, 13
 Mar 2026 13:15:06 -0700 (PDT)
Date: Fri, 13 Mar 2026 13:15:04 -0700
In-Reply-To: <CAO9r8zOu=CzDeUi0nxukfvKXeE5m+tn-gOsoTVMJ=rHtncx5cg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260310220414.2569208-1-seanjc@google.com> <CAO9r8zOu=CzDeUi0nxukfvKXeE5m+tn-gOsoTVMJ=rHtncx5cg@mail.gmail.com>
Message-ID: <abRwSJHJ9yS4XAx7@google.com>
Subject: Re: [PATCH] KVM: SVM: Add a helper to get LBR field pointer to dedup
 MSR accesses
From: Sean Christopherson <seanjc@google.com>
To: Yosry Ahmed <yosry@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 13, 2026, Yosry Ahmed wrote:
> On Tue, Mar 10, 2026 at 3:04=E2=80=AFPM Sean Christopherson <seanjc@googl=
e.com> wrote:
> >
> > Add a helper to get a pointer to the corresponding VMCB field given an =
LBR
> > MSR index, and use it to dedup the handling in svm_{g,s}et_msr().
> >
> > No functional change intended.
> >
> > Suggested-by: Yosry Ahmed <yosry@kernel.org>
> > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > ---
> >  arch/x86/kvm/svm/svm.c | 48 +++++++++++++++++-------------------------
> >  1 file changed, 19 insertions(+), 29 deletions(-)
> >
> > diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> > index 3407deac90bd..88999b6fc8a3 100644
> > --- a/arch/x86/kvm/svm/svm.c
> > +++ b/arch/x86/kvm/svm/svm.c
> > @@ -2750,6 +2750,23 @@ static int svm_get_feature_msr(u32 msr, u64 *dat=
a)
> >         return 0;
> >  }
> >
> > +static __always_inline u64 *svm_vmcb_lbr(struct vcpu_svm *svm, u32 msr=
)
> > +{
> > +       switch (msr) {
> > +       case MSR_IA32_LASTBRANCHFROMIP:
> > +               return &svm->vmcb->save.br_from;
> > +       case MSR_IA32_LASTBRANCHTOIP:
> > +               return &svm->vmcb->save.br_to;
> > +       case MSR_IA32_LASTINTFROMIP:
> > +               return &svm->vmcb->save.last_excp_from;
> > +       case MSR_IA32_LASTINTTOIP:
> > +               return &svm->vmcb->save.last_excp_to;
> > +       default:
> > +               break;
> > +       }
> > +       BUILD_BUG();
> > +}
>=20
> This actually fires for me with clang (from both callsites):
>=20
> /usr/local/google/home/yosryahmed/dev/kernel.org/nsvm_fixups/arch/x86/kvm=
/svm/svm.c:2766:2:
> error: call to '__compiletime_assert_1058' declared with 'error'
> attribute: BUILD_BUG failed
>  2766 |         BUILD_BUG();
>       |         ^
> /usr/local/google/home/yosryahmed/dev/kernel.org/nsvm_fixups/include/linu=
x/build_bug.h:59:21:
> note: expanded from macro 'BUILD_BUG'
>    59 | #define BUILD_BUG() BUILD_BUG_ON_MSG(1, "BUILD_BUG failed")
>       |                     ^
> /usr/local/google/home/yosryahmed/dev/kernel.org/nsvm_fixups/include/linu=
x/build_bug.h:39:37:
> note: expanded from macro 'BUILD_BUG_ON_MSG'
>    39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), m=
sg)
>       |                                     ^
> /usr/local/google/home/yosryahmed/dev/kernel.org/nsvm_fixups/include/linu=
x/compiler_types.h:706:2:
> note: expanded from macro 'compiletime_assert'
>   706 |         _compiletime_assert(condition, msg,
> __compiletime_assert_, __COUNTER__)
>       |         ^
> /usr/local/google/home/yosryahmed/dev/kernel.org/nsvm_fixups/include/linu=
x/compiler_types.h:694:2:
> note: expanded from macro '_compiletime_assert'
>   694 |         __compiletime_assert(condition, msg, prefix, suffix)
>       |         ^
> /usr/local/google/home/yosryahmed/dev/kernel.org/nsvm_fixups/include/linu=
x/compiler_types.h:687:4:
> note: expanded from macro '__compiletime_assert'
>   687 |                         prefix ## suffix();
>          \
>       |                         ^
> <scratch space>:102:1: note: expanded from here
>   102 | __compiletime_assert_1058
>       | ^

Hrm, I was assuming the compiler would be smart to understand the other cas=
es
are unreachable.  What clang version, and are you doing anything special wi=
th
your config?  Even with KASAN and other sanitizers enabled, clang-19 is a-o=
k with
the code.  And I haven't gotten yelled at by build bots (yet).
