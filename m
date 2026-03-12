Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E45739DBE4
	for <kvm@vger.kernel.org>; Thu, 12 Mar 2026 17:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773337676; cv=none; b=IyBrxu/8KTI0Gb+s1GGT5a2C1c6UWIo1mQ2s8jJN+Fu6FzvsW6f73NnAVdmagFlcEHPSrgcaf/2Qa2pwbx/dyV8G+sssvpJ2cntSo/R+zSB5kdOKHKpdPaLcB09WjOKTio8c1vHFJY/uabvr0J1NV/tPORCsCKep3ZPuMgIV884=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773337676; c=relaxed/simple;
	bh=VA6BT2jedBPBN+XKoIFPCHObG2m2rlF5KycQuzDUrMg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DHSeALTigLhMA/pKbZ2dzLpNYU6Yi35NQqLru9p+j0tu/4szsoIHfjqpJwFLAzs8nCuSYflo/b9Idi2hW65LCGBDPygSKpf1B+AQ7LpNx46t3GPVlGKJscDxZNKtnj1cPXGh0YleH26niot3XYWe6XICU2Xjf99jN1dhBVAKsP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=r6wh2oJc; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r6wh2oJc"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2ae6961bff0so102522775ad.2
        for <kvm@vger.kernel.org>; Thu, 12 Mar 2026 10:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773337674; x=1773942474; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uqT4tJ2p9cV0GLfbL9fmEN2SDx66Fv1ImSC2atPdiGM=;
        b=r6wh2oJcajsoVPpQu7Gug78US//c/W4k1pYAzcrljR6G2qS6n7BDowZ0DMl8yZ8wU4
         YfKx36cfqdVd9kh9cDF3VvIfr3pMsNf+OPbAzuNpWxit8+gEqCPh1fHjpc8EfEDutahB
         5Ti+2DVtOmkIQythp3XW1V+LlU+SPi6nKj74mn73N9X3+QL9EqUoYx61L+cMUONEW4I9
         aJl2ExxCl2HFyWir9SUN1gdzHOHj3nBmOnAv814fsu0NgbR5/2zFbWPwgdC2Gkh934Yw
         pVnzvm7Q0VG6AIqObt7eGSmOJ6A+IVjR5FV4o+gi5fkjQrZU6T/R2fQxbc+ULSYX9Xx5
         dRUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773337674; x=1773942474;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uqT4tJ2p9cV0GLfbL9fmEN2SDx66Fv1ImSC2atPdiGM=;
        b=Ur1m1rpsH77fyhco0HzzFQg18PbcuN/7vDb09pUpZB5sJHxWCamqJpduY3aIma+Zp9
         tdL7gX1G1DpC9WeHf6I/ZVrHbQdKvwIcCJ9hrJ6bpP29gZrAK0gfciPryS6OHAOxTq3f
         mv1RRR9WslAITsR/NxG0/49V+RwfFeJSkAGM3rFdIQshl1V85CMG6Icu2flR535Li38V
         TscJNtztyJZjS6kpELJWM3+Ub57Gmev50gbs3uGmWY5360dhqdi1QmQ+02/CMqyJH180
         Bhj3aMpY9O1zlNZYp/+eaW5Jn9Rsb7M8vVRs0fFaxC78w4MZl2oUUSUFMksU/2BmSGX/
         e6fA==
X-Forwarded-Encrypted: i=1; AJvYcCVQM/xLZS+7oq3fIkWYFqzxZ59e0VTAOeok9Zaw9gsLxEt5A1wISLqGDxQpbpe/GeRikWI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnwUcdgKrtg6JCpPuIEnk8D0t1RUA+qlIzcDssvdJKvt0y95Bi
	UO5Ti8E+tiErTXu+T5OfzGGM3hZrvpItl34wvScMl+wR/M+KVKUPJ4a1v/P/6ViRn/Z4WVk1vfV
	0PJejBg==
X-Received: from plww18.prod.google.com ([2002:a17:902:d112:b0:2ae:54b1:87d9])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:c947:b0:2ae:c795:6b37
 with SMTP id d9443c01a7336-2aecaa48f77mr3241095ad.19.1773337674289; Thu, 12
 Mar 2026 10:47:54 -0700 (PDT)
Date: Thu, 12 Mar 2026 10:47:53 -0700
In-Reply-To: <8853f8d5-57e6-4ea4-b9b5-8a0182d0d012@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260311003346.2626238-1-seanjc@google.com> <7ec084f8-812e-42f2-8470-e416fa7ee848@redhat.com>
 <8853f8d5-57e6-4ea4-b9b5-8a0182d0d012@intel.com>
Message-ID: <abL8SW5JS1aV5goa@google.com>
Subject: Re: [PATCH 0/7] KVM: x86: APX reg prep work
From: Sean Christopherson <seanjc@google.com>
To: "Chang S. Bae" <chang.seok.bae@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Kiryl Shutsemau <kas@kernel.org>, kvm@vger.kernel.org, 
	x86@kernel.org, linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 12, 2026, Chang S. Bae wrote:
> On 3/11/2026 12:01 PM, Paolo Bonzini wrote:
> >=20
> > =C2=A0 On the other hand, the extra 16 regs[] entries would be more or =
less
> > unused, the ugly switch statements wouldn't go away.=C2=A0 In other wor=
ds,
> > most of your remarks to Changseok's patches would remain...
>=20
> I think so...
>=20
> If the host kernel ever starts using EGPRs, the state would need to be
> switched in the entry code. At that point, they would likely be saved
> somewhere other than XSAVE buffer. In turn, the guest state would also ne=
ed
> to be saved to regs[] on VM exit.
>=20
> However, that is sort of what-if scenarios at best. The host kernel still
> manages EGPR context switching through XSAVE. Saving EGPRs into regs[] wo=
uld
> introduce an oddity to synchronize between two buffers: regs[] and
> gfpu->fpstate, which looks like unnecessary complexity.
>=20
> So while ugly, the switch statements are a bit of a trade-off here. Also
> bits 16-31 in the extended regs_avail will remain unset with APX=3Dy.

Have you measured performance/latency overhead if KVM goes straight to cont=
ext
switching R16-R31 at entry/exit?  With PUSH2/POP2, it's "only" 8 more instr=
uctions
on each side.

If the overhead is in the noise, I'd be very strongly inclined to say KVM s=
hould
swap at entry/exit regardless of kernel behavior so that we don't have to s=
pecial
case accesses on the back end.
