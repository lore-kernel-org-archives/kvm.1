Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E72EA3FE35F
	for <kvm@vger.kernel.org>; Thu, 15 Oct 2026 22:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792102125; cv=pass; b=BiVTh4m6fH0X7ZK5YRK9toyrPe4KX3gsYD68s8PihzRIjy3sOud1Hpk4tCSQVrS/pyI26X/CBu9NFPs135fevqrYSiMF3VgLRJxZhMlSO28cktBEr74Yjwm8EikCPA1Ac8C/YAbiWf2O8WXuTM6MgooeVr3KzVq9lbLbnm8pTxU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792102125; c=relaxed/simple;
	bh=PWLpWT9C786BylCeGeYU8YwdUELYM748aZYSZN0Ww1A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JX5JYnfoTRpy5ok2kIM8f0ZGZHJSD4vvMOGDdfSBP+qSfWT+RaUs8MUoAtUp56b24Hks+FwysDuvjdWnd7BWZFTpokXStKMIOfd/Td+u2V3URShxN3XjMYkKaB7OJ6EXi6Xz4oww021g2ujz/IfHgFUH8xO6PhRhJntmDM3RAGw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MhoPnhnu; arc=pass smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MhoPnhnu"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-533202fe429so116001cf.0
        for <kvm@vger.kernel.org>; Thu, 15 Oct 2026 15:08:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792102123; cv=none;
        d=google.com; s=arc-20260327;
        b=X3FF9YJfaHC6Y+1i+Z2cD3CaoFJPsNYgMzsSmU1t6s8uvw1/gYI7fvXS8BfGY7zV6S
         4tIeJ3pdn29Egkwo4LDQs7t4AD/m+jFn6+09AiGZTfxKqOJms9dPDMZQA12EcTzId4Hn
         stt4RcPgSrAWQ2smxcLhCn6smOOnp51WULFbFoHpxoEXpXWmQ2lyH/ImXAhZEsA3TdAQ
         jyskWT81GPioH6JtV9sTAYcdwKsDp+2hpHwXbCo4vwehrKdjSHMR3+bIcsu0w5r85ubq
         8wPL/YQJ55FPdkxkpV3qz5u/XF4LdMwUayzlu6UzIPF6t9UuOllTQLVZnB2uXgnTlMo3
         Te+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PWLpWT9C786BylCeGeYU8YwdUELYM748aZYSZN0Ww1A=;
        fh=yPXXDRDcFn+czRPGK2rye7nMg92ULWSjxhPUeu6AIsU=;
        b=FZ9kYhrOZSf9GR7g6gN0HnzAvdBbR76Cl43/N3DxVdJBQ0IVtLbMZhiFKCuvK5UGcD
         XHEc20s9ys29agdpWQLdAb09t/A0vH1pw1K6k4Cb9dhEHwGgACICRyUNtMmSWu8tlVoE
         MdnOyVPUdZtHBUozeq+7b1Bk+eyILSFK6+H68MgXgKC9cw6HN0Lx/SJTQIJ25iP7htUb
         Nwhkx4NWyyDCBfH/KHDtoTlHnVZKr6jnx/UdnOtla9QpmaPBfVyDabAlYwWUZ+sp5BnR
         9jFxFHmlEBut3E+xxlmI0lpQX3/85fWBg2UgbVDPvqr//L/0AnZq6TZ8XC/IoQEukhxP
         81aQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792102123; x=1792706923; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PWLpWT9C786BylCeGeYU8YwdUELYM748aZYSZN0Ww1A=;
        b=MhoPnhnuq4C1X5zitZ2iVormUUWfE0ohRCo9lTZKV4H8ihR6hNDx8c9phHLa4zNSdl
         AD6cYYEtVQROMqbRjwNF6kUSZaS5HU91JqY2unFffHaWc39fGYeIRH0gz4Cjp7iUca5W
         gDKaaRv9sq3l6HHe1JpQzmp9TmvKMkIB41BbWnuG46iK97cwIvcS4BsqzjcQzN6yieuO
         vpf0Tv7Q7cPotnZCFIi/SGJLAkXlmDk3Vwj+tFvuUyBSl5K1jjgzDuM1iaM9uy47XHDy
         dBLe90WTSbCt+Dp3a3Zl/TbNw8zJQBDU0n1jB1yehgPpeJq2SbGAeNEqn8tJj4B/5wiQ
         zk9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792102123; x=1792706923;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PWLpWT9C786BylCeGeYU8YwdUELYM748aZYSZN0Ww1A=;
        b=Yhieq8Svz4bNnc+myf93eLJveFhKWu25qg+gw4kQQazVj204qJfZ/nMLCnfo1lILo2
         1VpSkZErKFy0dZ0UUYkfWhEatAYg7pjjPXKKHdwMa2/apzmuc+e2Yf/ZMe45Cw22Eg9f
         UnAtgvxQ41hhg93kKzqQM/mnuGgzMEcNpPn9+GlGFoIE8mzn94BHgR5i9xZLhDIXgEuL
         3y6K+IROaqPe5zPgu83LGxj6asR7HDfHLgDZZwM16x0SwItXo54Rh+IVYxu/6oJO847X
         y8bPWLPq6w3efd204FNn3f7RsO6OwCv9yrTJU48NhKz4QyS5VRl7i5E++9rs/5tzAk5c
         FR0w==
X-Forwarded-Encrypted: i=1; AKwUvByZSbInKkXe9uM1lEi8RXOb/Rc52TP8q4koUHo331Id6UYIvO8I3JjzzNn5tQp81ZeU5KE=@vger.kernel.org
X-Gm-Message-State: AFq9FYJzu0jsQ53mlOECcnmm3Fl9gGbsffjJ6y6c0TnrZgmj39MYtrQp
	Dqtr6SSXncf4elNDAKT8L5X5R4e1XlJLN8YmCwUxk8luJr5mKuNQY4fthKTNfGVhxd84hndg81w
	x/T9KVuxSm8BjNVMCuTFDoCjN7J+z1KyMSWMv+IId
X-Gm-Gg: AYBFou0tVifX1YCYaiU232lKjGnJGEDr/5F2koMG935O6kN5Ut1ac5M6JxcP0/rq29D
	IHAfM4WPR2jAeOspUT/ZE+xf8P1g5Gm4NL4dJ2NIOGbZlHuMwfspmlSTzDpzmSq/FI3qVON0YLo
	uuxTGoVa4CPE30YlkWY/g++raDDqCdHcVo9lYhTbu/I8lWnf1tHEtic4lpbCsFLS/fjYd1Lg95l
	XA8dXR/nIPGCEE3Iq6gbGNG3Ua9yGXbui+sJokbaWESeXWLjLwy7tQcbsxls1BTr/eu5wsEmaNo
	rUxqmxh8bnpTrtxdeM+PkS14SnTrOl2IFjxhkMCqmSfECIskm6DCF8s=
X-Received: by 2002:a05:622a:481a:b0:535:fd6b:1c11 with SMTP id
 d75a77b69052e-5362986146emr5726131cf.4.1792102122196; Thu, 15 Oct 2026
 15:08:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261012233638.2546339-1-yosry@kernel.org> <20261012233638.2546339-18-yosry@kernel.org>
In-Reply-To: <20261012233638.2546339-18-yosry@kernel.org>
From: Jim Mattson <jmattson@google.com>
Date: Thu, 15 Oct 2026 15:08:28 -0700
X-Gm-Features: AclHuK8_0LbH6j_WeX1v21_TtgStVz7uutnfAORXSKaBZVmBkBYI90seP3yuzXs
Message-ID: <CALMp9eTq2HOq2M3VRVYF2u50BCP4FOEqG3Sff2LW0nb5et+GFA@mail.gmail.com>
Subject: Re: [PATCH v3 17/27] KVM: nSVM: Always switch VMCB before leaving
 guest mode
To: Yosry Ahmed <yosry@kernel.org>
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Maxim Levitsky <mlevitsk@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 12, 2026 at 4:36=E2=80=AFPM Yosry Ahmed <yosry@kernel.org> wrot=
e:
>
> Move svm_switch_vmcb() calls ahead of leave_guest_mode(), as nothing
> between the calls depends on svm->vmcb being set to vmcb01. This makes
> the nested VM-Exit path consistent with the nested VM-Enter path, and
> having the calls to svm_switch_vmcb() and leave_guest_mode() close makes
> it easier to reason about incoming changes that depend on both VMCB and
> guest_mode context.
>
> No functional change intended.
>
> Signed-off-by: Yosry Ahmed <yosry@kernel.org>
Reviewed-by: Jim Mattson <jmattson@google.com>
