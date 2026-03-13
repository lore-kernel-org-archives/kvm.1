Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC843019A6
	for <kvm@vger.kernel.org>; Fri, 13 Mar 2026 18:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773426216; cv=none; b=eHqOkcOebfosZkmtfv1p1loAHmsUik653Ta9zjnOHmrPufe/w9eOyD+KvKMuJiAyMumW57HYDx+kgyZmEoQF2UQo7w7VZ6zk0EyGgcb1n1g/tJQECM50t0COR/TOgUSNJGKo8u1pjNVDt9z5FLI46mdIOe7fZSmXIPy8VsUsR88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773426216; c=relaxed/simple;
	bh=VWTGYPVk/kaUT4pC7bkXW7KRy6vNq4oJSoI3IobWNo0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y/TtQ6SClTTzoRfRklN2UvSGqjTjSEpw6d1YuoQirnPAuaRGfv+aPOlftjNqd1LK4R6GQut240I5wu3iWC4gG6YCv1lwLy5LZrQhmevkrYx0PpNuMjyI3P6oQE7bLR7W9NYPvjWXVbI8Xx0bOtEg2luHs/3ualXiz7NTvbuYuKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nM3TS90o; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nM3TS90o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1BF7C2BC9E
	for <kvm@vger.kernel.org>; Fri, 13 Mar 2026 18:23:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773426216;
	bh=VWTGYPVk/kaUT4pC7bkXW7KRy6vNq4oJSoI3IobWNo0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=nM3TS90oO0c+Tss8kbBoqh8rxnFw7WAdmB8X6KCaeWbKbvPuZ5VuZ2Lp23XJ47CHJ
	 CLRaobYuVYqYaad5k8WbDjs1V/iAM52mrgH72toks8fyT1j1aFbAhtc+bZd+pJw8S2
	 1pDZOQvqWEvLAAST6V0Zg5qmVgxBNaDGL2c5/s5w9cxSWbVAway+uhgkOqoLjvhYR6
	 3lQOprg07a/z75/RsaZTiZ+G7ub4ij0phUaBXVHn1sy2do2aG/Mujrylmcix6sEbpp
	 m6/Je79tPqinDUZgAX4Ok3bnU/pb3KMq0O+VVpuz6if4RVa+tl1+VQHyyntWGNEIYe
	 +2y00nAa7mJDA==
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b8f97c626aaso399672166b.2
        for <kvm@vger.kernel.org>; Fri, 13 Mar 2026 11:23:36 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWo/HJvHAUH88rq86v7ZHN+YgM7aIv6/PW7jfbuHtg7TgVasQX832dKXRkNhieqcrCQ4l0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJPVDFv+vi+/d8xnLjSUyaK2DHk0kjiaJFfOmXbNFFG7vY+5Nm
	5LVbfZ16C5QmlMHmdPQv2BGh5yCU2OgiuxiH5bxBysPQ4LgZnDp8uYvMnDVpNaLPTqqnbNh9P+M
	8TMT2yEEoBIzgTczpdb0fkaif+SfYSyc=
X-Received: by 2002:a17:906:fe4c:b0:b8f:9dc5:4c83 with SMTP id
 a640c23a62f3a-b97650f1c18mr312597366b.13.1773426215321; Fri, 13 Mar 2026
 11:23:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260310220414.2569208-1-seanjc@google.com>
In-Reply-To: <20260310220414.2569208-1-seanjc@google.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Fri, 13 Mar 2026 11:23:23 -0700
X-Gmail-Original-Message-ID: <CAO9r8zOu=CzDeUi0nxukfvKXeE5m+tn-gOsoTVMJ=rHtncx5cg@mail.gmail.com>
X-Gm-Features: AaiRm525D-bHA0IYnHccppTuqLNekghu_qhjC-7x6xZ1LHLI0-Ag5p-YgokQqNg
Message-ID: <CAO9r8zOu=CzDeUi0nxukfvKXeE5m+tn-gOsoTVMJ=rHtncx5cg@mail.gmail.com>
Subject: Re: [PATCH] KVM: SVM: Add a helper to get LBR field pointer to dedup
 MSR accesses
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 10, 2026 at 3:04=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
>
> Add a helper to get a pointer to the corresponding VMCB field given an LB=
R
> MSR index, and use it to dedup the handling in svm_{g,s}et_msr().
>
> No functional change intended.
>
> Suggested-by: Yosry Ahmed <yosry@kernel.org>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  arch/x86/kvm/svm/svm.c | 48 +++++++++++++++++-------------------------
>  1 file changed, 19 insertions(+), 29 deletions(-)
>
> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index 3407deac90bd..88999b6fc8a3 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
> @@ -2750,6 +2750,23 @@ static int svm_get_feature_msr(u32 msr, u64 *data)
>         return 0;
>  }
>
> +static __always_inline u64 *svm_vmcb_lbr(struct vcpu_svm *svm, u32 msr)
> +{
> +       switch (msr) {
> +       case MSR_IA32_LASTBRANCHFROMIP:
> +               return &svm->vmcb->save.br_from;
> +       case MSR_IA32_LASTBRANCHTOIP:
> +               return &svm->vmcb->save.br_to;
> +       case MSR_IA32_LASTINTFROMIP:
> +               return &svm->vmcb->save.last_excp_from;
> +       case MSR_IA32_LASTINTTOIP:
> +               return &svm->vmcb->save.last_excp_to;
> +       default:
> +               break;
> +       }
> +       BUILD_BUG();
> +}

This actually fires for me with clang (from both callsites):

/usr/local/google/home/yosryahmed/dev/kernel.org/nsvm_fixups/arch/x86/kvm/s=
vm/svm.c:2766:2:
error: call to '__compiletime_assert_1058' declared with 'error'
attribute: BUILD_BUG failed
 2766 |         BUILD_BUG();
      |         ^
/usr/local/google/home/yosryahmed/dev/kernel.org/nsvm_fixups/include/linux/=
build_bug.h:59:21:
note: expanded from macro 'BUILD_BUG'
   59 | #define BUILD_BUG() BUILD_BUG_ON_MSG(1, "BUILD_BUG failed")
      |                     ^
/usr/local/google/home/yosryahmed/dev/kernel.org/nsvm_fixups/include/linux/=
build_bug.h:39:37:
note: expanded from macro 'BUILD_BUG_ON_MSG'
   39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg=
)
      |                                     ^
/usr/local/google/home/yosryahmed/dev/kernel.org/nsvm_fixups/include/linux/=
compiler_types.h:706:2:
note: expanded from macro 'compiletime_assert'
  706 |         _compiletime_assert(condition, msg,
__compiletime_assert_, __COUNTER__)
      |         ^
/usr/local/google/home/yosryahmed/dev/kernel.org/nsvm_fixups/include/linux/=
compiler_types.h:694:2:
note: expanded from macro '_compiletime_assert'
  694 |         __compiletime_assert(condition, msg, prefix, suffix)
      |         ^
/usr/local/google/home/yosryahmed/dev/kernel.org/nsvm_fixups/include/linux/=
compiler_types.h:687:4:
note: expanded from macro '__compiletime_assert'
  687 |                         prefix ## suffix();
         \
      |                         ^
<scratch space>:102:1: note: expanded from here
  102 | __compiletime_assert_1058
      | ^
