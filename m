Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C4C21AE877
	for <kvm@vger.kernel.org>; Fri, 10 Jul 2026 00:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783643144; cv=none; b=kse03imOre8ddh50bTYMqxhAjIJBWobHmQDRczHHRLN927IFz+wAhvVppNJiVyvCBuWimsxAPsWwBIKEX6I1FU5oKoSldSJQK/jKfBQbvr40GsdhFCleZ5kkpLFrgJ5KR0ktXckNtSXyd9kbUudaAEM16njxzTEpRUb1TBUZKHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783643144; c=relaxed/simple;
	bh=5gcO9X4cHp3LegWOGHxzdvsxNFJhssC0N0h7pVqnIC8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HMG3HT5rETnCO3MAdjXIRZso1qwoL7YdTtruWjeJIQeCZ24CqdOPQ3gd/CP8iYd8/RtTbnzqprclz1PfBkAIOPGToNeZmJve7E1LOF4FtSiprU5/jKEtxi9c9Ti6osfjk2+0vsiHhZcu41OjpDl0I5LP41VZRl3/693/+ZMeJZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fQ5u5G8x; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fQ5u5G8x"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2cc6dd43737so7288045ad.2
        for <kvm@vger.kernel.org>; Thu, 09 Jul 2026 17:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783643142; x=1784247942; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eZiwlb8a1N6Ld/q6Sfz9GUl1NAaChYVFY9uXOs83HCc=;
        b=fQ5u5G8xGfc6A/op3bEjjT84KOfWFo9yaRu0ywYbyZEpmJ1y/NhpXishhBb889C0af
         3RgxBnl7DUB41E2zS6fekpaY8ZSZWgIRyc0DP0SJEm7Y4ISpkFB/+C50SO77zoCvcdJO
         NW11sfSgVqeuLQX/LmoEs82eEL+Vv9smVRNiTbsuSaC+33jml7/OmtRuEIr8vY1ldLi1
         egsTLc6yQi5O5ydUTzNs2V+CGq+4/bAf1/eJydvzyKpYK+nJv7+h6s9kUzqd5rpLL2L2
         cQKUi5YSGayaQFuV+DYVOODVlq4Q0WuA4SXLre/1l6FOT8PCgyx1l8AebyOoAdFHKg21
         WUkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783643142; x=1784247942;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eZiwlb8a1N6Ld/q6Sfz9GUl1NAaChYVFY9uXOs83HCc=;
        b=A2c91dD7rBmugKuNldRIWo4du+9UKz81N8P0gu8jUt0AtHKo+FXlTJ55eKK2X+hrsG
         eJdVt5iwbewrb9EnKOVAKR4QnR73vo4bjq6R7o5CrNTxH3HOv53rBoooYgr2hWr6/wew
         Ciz461J183PDAgQSqspXDDD0ltgzfxF1Q5unz+IXcVQx2Dm4Z2KRXWS5FLruUahXrECL
         nn1bUwuR+a5jESUH04HXHZ2OhJyPsCZxq41AZv98w7KxGSJyI0wmJhjMLz4HKCVbt4EO
         OOVQOsgOntW7mywZazcubaORqZzi7Aw55FKjs2P9v99drqfuGhBZbhKiGLVZH4P6x9Hd
         zEhg==
X-Forwarded-Encrypted: i=1; AHgh+RrDCS8Sb1k2cCmb6fd7EqYBjCUkNBdRMYlGU8kubEs3949LCX0w8QiPynwFVusezd0Nx5o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3ngJV4wi+kg6NMGZ26FfX5mGE0eQ0BtcNPQ8iXwEuZTLQwwTO
	qRp7r0RLQUtn1AY1ynh4UeTs32nfNhtzkn5GKK97elefD8+AJevr6P4bVrN7MhzsO+KNyinH1oi
	WQH42Rw==
X-Received: from plgf18.prod.google.com ([2002:a17:902:ce92:b0:2ca:d6d7:6943])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2b0b:b0:2ca:2753:f3cc
 with SMTP id d9443c01a7336-2ccea45a3a2mr94666045ad.33.1783643142249; Thu, 09
 Jul 2026 17:25:42 -0700 (PDT)
Date: Thu, 9 Jul 2026 17:25:41 -0700
In-Reply-To: <CAEvNRgFfRe+1LDVR+YqWcQ=ho4gPz2Ac9jU0Z55yU592b3AUog@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260709204948.1988414-1-seanjc@google.com> <20260709204948.1988414-5-seanjc@google.com>
 <CAEvNRgFfRe+1LDVR+YqWcQ=ho4gPz2Ac9jU0Z55yU592b3AUog@mail.gmail.com>
Message-ID: <alA8BWWvOu7qaHZF@google.com>
Subject: Re: [PATCH v4 04/18] KVM: SEV: Wire up kvm_x86_ops.gmem_xxx() if and
 only if CONFIG_KVM_AMD_SEV=y
From: Sean Christopherson <seanjc@google.com>
To: Ackerley Tng <ackerleytng@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Michael Roth <michael.roth@amd.com>, Hyunwoo Kim <imv4bel@gmail.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, "=?utf-8?B?SsO2cmcgUsO2ZGVs?=" <joro@8bytes.org>, Fuad Tabba <tabba@google.com>
Content-Type: text/plain; charset="us-ascii"

On Thu, Jul 09, 2026, Ackerley Tng wrote:
> Sean Christopherson <seanjc@google.com> writes:
> 
> > Wire up the SEV-SNP guest_memfd kvm_x86_ops hooks if and only if SEV is
> > actually enabled, and drop the now-unnecessary stubs.  Leaving the hooks
> > NULL allows the static call infrastructure to elide the CALL+RET, and more
> > importantly, referencing the hooks if and only if SEV support is enabled
> > will allow conditionally definining the hooks using their corresponding
> > HAVE_KVM_ARCH_GMEM_XXX Kconfig.
> >
> > No functional change intended.
> >
> > Cc: stable@vger.kernel.org # 6.12.x
> > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > ---
> >  arch/x86/kvm/svm/svm.c |  8 ++++----
> >  arch/x86/kvm/svm/svm.h | 10 ----------
> >  2 files changed, 4 insertions(+), 14 deletions(-)
> >
> > diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> > index ef69a51ab27f..79c818d91dda 100644
> > --- a/arch/x86/kvm/svm/svm.c
> > +++ b/arch/x86/kvm/svm/svm.c
> > @@ -5448,6 +5448,10 @@ struct kvm_x86_ops svm_x86_ops __initdata = {
> >
> >  	.vm_copy_enc_context_from = sev_vm_copy_enc_context_from,
> >  	.vm_move_enc_context_from = sev_vm_move_enc_context_from,
> > +
> > +	.gmem_prepare = sev_gmem_prepare,
> 
> Here .gmem_prepare assignment is gated on CONFIG_KVM_AMD_SEV but later
> the definition of .gmem_prepare is gated on
> CONFIG_HAVE_KVM_ARCH_GMEM_PREPARE.
> 
> CONFIG_KVM_AMD_SEV selects CONFIG_HAVE_KVM_ARCH_GMEM_PREPARE, but I
> wonder if there's a chance due to config disconnects this will cause
> compilation issues? Like .gmem_prepare will get assigned but it was not
> declared? Or is that actually intentional?

Intentional.  If we end up with KVM_AMD_SEV=y, but HAVE_KVM_ARCH_GMEM_PREPARE=n,
then I definitely want the build to fail.
