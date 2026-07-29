Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE583FBB7D
	for <kvm@vger.kernel.org>; Wed, 29 Jul 2026 22:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785362570; cv=none; b=Ld9bUXCjqIHBJsunqi2WPah4S4csyFXDcGpPOztbgBFLac2qyvkRh7l8YDyKGtg6KEvWfM4aDcWQQWhDsTVmCYYKttKDy3VZ9hrSr9L46Y/z/ZFb4C2G11HkqQZixpM5rLvQlglLGnzbSLe+TTzjmS4M5DbcA5tK0qYY6XjzBbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785362570; c=relaxed/simple;
	bh=hbViafOYqhRMhoIhV1CPXJLL46eqKjH8lhi0DEacPKA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I3bkiwyk6t3FQBtbejSf6xjSECbjPmkklVUL05a7JzVBOzuwd2ISo2LM3Zm6grlcTV2leE09jcEBIGPRUKialB7TGUsn8nbe1SoyZiELTftlqk6qxfLuFQvNfbdgxeqG4MPz5gBaMseDaqwdMxz6nTCVesI9RWePWYUXiOnOxnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=S8iBhwDc; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="S8iBhwDc"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c1f5208b38dso277692066b.0
        for <kvm@vger.kernel.org>; Wed, 29 Jul 2026 15:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1785362566; x=1785967366; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bOXuVA9IQ/SCsM16N2i7N/Co9J/EhIwsCI3ISc+pMvs=;
        b=S8iBhwDcefCkppr8QFQUbWLqUCpbMMr9aiYAISOF6Y2u4miWoe6BIbazO3Diw3kkq+
         4pGa4qaaSMLVvYUlC1u2xQStCb8PXSAmeyM7suBpTxSZWT50xYd+94TBPqh51cUfLQVp
         5isGJ4tHkDtwcv8WnHOuGZF6bKykHpbtfgK60=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785362566; x=1785967366;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=bOXuVA9IQ/SCsM16N2i7N/Co9J/EhIwsCI3ISc+pMvs=;
        b=ZaE+hisLOIb4iC2msPpTo4SVmPPsH8LgV/HSj9KWBANZzAymvdXKyjdiVaL6rlhUPi
         BMxeJ3ZOHbO2vrvBrXCyYtuLgCtOe8G268lDUtgSjC6/Se0if92OoVhb8OFyfwyORweV
         sQ1k1vbHn123Ookp/LW+IPIdYPrp1FYQKHOdtmyPijNcdWQ1yCoN8d+eacJWQgj/O9fm
         mACdE17gpHyGNRfLmyGKaqFCbsTmqDpzzySpfEUUB+1diIBnIn6Tw07Y+iI9oiTu0SeZ
         /cTT8dYEmyjTUrl2pabxQ72FtQJUtj8AmG1HPzbuSnnxS9UhYCsjtVwdW0/Csb7GyOED
         ecBg==
X-Forwarded-Encrypted: i=1; AHgh+RpAnH4h/DXJN1OtpW+Mbx4gt4YFhFWc2V+Q4PDPUupFhn8Hcnx4qO7yibIMhzxJeU//zA0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzo9kRbnO2JoZpcnyZSarlG+5/n/wD2oXcRVbBN9c0lS/ujzneg
	uFIMGfQF2bo/1h1xEd7r6HUurPKrzDEt2ZPBgZyqtP3qlS9JXgKuDo20t3qeUj6pqMSiNWRgXTt
	4gWsvEWw=
X-Gm-Gg: AR+sD112NQARKLker2xmoPyswspk7p0xormlDMnluuzOlLncVKRWEaTJ2wSdmi9Sam7
	RBd6p2j6XxPFBqiO8L1iVjYKgzMet+fshDziS+elb04ex9bwcKb0d53WRIj96VOoclUppVlVedy
	7XpmZbBgD605mmKQYq01xkBAofCBgZoIMW9UgLmvQPYCQmVlRxRbSl/fUmtfaTAhi8LnES7IukI
	aKNin8lrl5kPxowpmbuhGjzWFLY2GNQ3BMVmPuKeEa7wjJYbuRic2aBvANcRuCwuySjWs38/wKR
	TU+QjBdRJ8HmbVx2QIVMYrdcSKhkTeYMvY69FWzmijn/wwzvEGeEHzN+hDCkEEScmJm0xcWpF/M
	8YMov74/yhQKTFYQFVkVqDDUdm+BTa3aMAideezXmH2yr749a7BdmbvnE1Bynjjrcc7hJyufmVk
	yW7jnWIv6Y69DPgzfp/BA5+oxxkzOu15QD7KhLEP6gUJacyaJ/3kBQSe4AcEknP1+WSZ/23FOHC
	eg6NZ6/AqCcd1QHfgMwaUDnfPt/kKqGLgzmJw==
X-Received: by 2002:a17:907:9812:b0:c16:6c84:4b8e with SMTP id a640c23a62f3a-c1fa56e2010mr10271066b.14.1785362566635;
        Wed, 29 Jul 2026 15:02:46 -0700 (PDT)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com. [209.85.218.53])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1f8f981705sm104867466b.9.2026.07.29.15.02.45
        for <kvm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jul 2026 15:02:45 -0700 (PDT)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c16794450aeso185677166b.2
        for <kvm@vger.kernel.org>; Wed, 29 Jul 2026 15:02:45 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RooOYKoHqk1+XdYvL6L/M6l0ZPWYS39ruJRQnstjk8xy/B341WahcTTNiPhgxHyOzJFpG0=@vger.kernel.org
X-Received: by 2002:a17:907:a09:b0:c1f:6f31:2880 with SMTP id
 a640c23a62f3a-c1fa5b00896mr12153766b.50.1785362564767; Wed, 29 Jul 2026
 15:02:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260729214500.651377-1-pbonzini@redhat.com>
In-Reply-To: <20260729214500.651377-1-pbonzini@redhat.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 29 Jul 2026 15:02:28 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiK2vQfiex3JG0ZiBPfWqc=JnTOyyJBF86+GoEcKJ=3Cg@mail.gmail.com>
X-Gm-Features: AUfX_mzukRyTaBXqRlnha0Lx4WroqfWuBLvd_kAdv-nX4M3y-sX9SDF0pw1j9K4
Message-ID: <CAHk-=wiK2vQfiex3JG0ZiBPfWqc=JnTOyyJBF86+GoEcKJ=3Cg@mail.gmail.com>
Subject: Re: [GIT PULL] KVM fixes for Linux 7.2-rc6
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 29 Jul 2026 at 14:45, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> - Add memory clobber to asm for VMX instructions; without one, the compiler
>   could reorder them in troublesome ways because "asm volatile" and "asm goto"
>   only protect against removal of the asm.

This is simply not true.

"asm volatile" is not just a "don't remove". It is an ordering
constraint too. It cannot move wrt other asm volatiles.

I've merged this, because that added clobber won't really hurt, but
the bug is simply not what the description says it is.

You have to have a memory clobber if you modify memory, or read memory
that you didn't tell about.

So asm volatile is very much a "you can't re-order this asm or move it
around significantly".

But at the same time it does *not* necessarily protect against the
compiler re-ordering *other* things - like regular non-volatile memory
reads and writes.

So I think the commit message is misleading and actively wrong, and is
stating things that simply aren't even remotely true.

In fact, I think the "none of this has been observed" probably means
that the code wasn't actually even buggy, and clearly the people
involved didn't really think things through.

If all accesses are to memory that gcc isn't aware of, and all of
those are done with 'asm volatile', then the code is fine *without* a
memory clobber. The asms won't be re-ordered wrt each other, because
you have told the compiler that there are side effects.

But if you do *regular* memory accesses to some memory area, and then
you use "asm volatile" without a memory clobber, then gcc may be
moving those regular memory accesses around the asm.

See the difference?

               Linus
