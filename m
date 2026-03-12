Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A580A3DA7C2
	for <kvm@vger.kernel.org>; Thu, 12 Mar 2026 18:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773340191; cv=none; b=Myl0Mr/sDR/4mZIQq6ePU6genS3SfJsVYf5q0LjBBvI1cKv9hxnjjyIbcaaot2q7ijWVvDIjD8go/SNdRTpl+6frcTQfQcqfPxCI9jNtfDbhmSs6OQPmBwJfiCL5+toBle/VJfQ7GIui0txmxs1TUlVH0Uc5gxfWJf9448z9UYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773340191; c=relaxed/simple;
	bh=ZJ4I11P1rRBeHSfpG+I/A2zkE2tdQV3uTy0wBAdmlHY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DmDKpZnseo4mw2x3bm0qXELG++KL6HjGipj1qicx8xpIoznHu+BY+9s0PyZVYKE76VMgCUXEWgUVrdOElCh8772B88yetv6r0KmTVvX9wdU6NIDxY4roNtfv47fvpBUVM43zHYmNpian7cwVe2KHDDvUCMhjOK4pBhH1Wr/swIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bV+hiOth; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bV+hiOth"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2ae59e057f1so17359365ad.1
        for <kvm@vger.kernel.org>; Thu, 12 Mar 2026 11:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773340190; x=1773944990; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X5OTYERPzegYtQwRPBPu0VS5xjQRDHb8V88deRQ7mWM=;
        b=bV+hiOthcNEYPBJlvECvYwE0QSM6ezShIRVCtubvrJ2UG5wJyLqxBVHqS5HuFn6PtI
         gCW+sLyX1hr4QiypTJVJuRhq7LlAdgy+mEHAbA2wOTgdUc8/FH+hcFpO7sxsmJQGYEcB
         6+pBQ/Tk2k7odSHY8pIwfTFLa6Mupe4C85g6vyMZYpWkpjBN8J3ufSr5DiTFHMNtzbGj
         hSGEvIexEzMq9KqXnnEWWV1kCjOJNE4qY5+fxsyWlY80DkBWCC+c0iL4IuXTNU1ygzT9
         ho9wzj6ByY74PDXs01RF0Zu4U5FBmglcwnpw+IsjyuHWFQgCnnSkb/dI8jhnaZ7a7Y4x
         DgJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773340190; x=1773944990;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=X5OTYERPzegYtQwRPBPu0VS5xjQRDHb8V88deRQ7mWM=;
        b=cvtVyQpO5XIxxHHb/uPusarmAwpPVLvEhfe31diLkM3fqAJ5gyql8QkJZaNH5iQ+y0
         amvxJ7jZlDZ6sMDcFqVlcKnZCYaU954Fdo5Tgf5+9s/n/xFx4c1c4YhYF8U6ZrwyYtbf
         TKPyHL3GHPZR+Bst0TL0oQb6FJw6RfFC53gqPcAGBEaOFhzLpW1Y2SRBwAUW6tJKrC99
         oftKq7eEdUCQM6UEqV3Cq8nL1qepCkcQck11x6IxHBpEwF8HZ8M8cY8cJDwDv1FKiJGd
         5riEhyOn6YvBkJutts51DnZtjAhaX26QNUmcjz0I2blZKbeG6l3yU5r8QhxOfJF9M4SN
         XwWw==
X-Forwarded-Encrypted: i=1; AJvYcCXwDwGmARAc/40+MXWfGPxzBmK5ATWXRO0nqzQRS0+WsWt9U8mvJ/5rvCtQk2oGOo6ZJRw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxV0uaVl104df2VNxqO3zoCkRbspCqTIqT+tiYLTwxLAVZ/Z6YL
	rbqw+wwqx4q1eEuAl5ehQtw6nLaGtc7hC0jv2q0mh9NVDmZqSB5FXXpxkzyM8xi6nmk8LNG6oki
	rYMDnBw==
X-Received: from plbkv16.prod.google.com ([2002:a17:903:28d0:b0:2ae:a2f6:cc35])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:41cb:b0:2ad:da28:98d
 with SMTP id d9443c01a7336-2aecaaf546emr4752605ad.37.1773340189875; Thu, 12
 Mar 2026 11:29:49 -0700 (PDT)
Date: Thu, 12 Mar 2026 11:29:48 -0700
In-Reply-To: <e76107e3-b93a-4154-859f-d22de0ee6f78@citrix.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <abL8SW5JS1aV5goa@google.com> <e76107e3-b93a-4154-859f-d22de0ee6f78@citrix.com>
Message-ID: <abMGHGMTfz-qaPxI@google.com>
Subject: Re: [PATCH 0/7] KVM: x86: APX reg prep work
From: Sean Christopherson <seanjc@google.com>
To: Andrew Cooper <andrew.cooper3@citrix.com>
Cc: chang.seok.bae@intel.com, kas@kernel.org, kvm@vger.kernel.org, 
	linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org, pbonzini@redhat.com, 
	x86@kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 12, 2026, Andrew Cooper wrote:
> > Have you measured performance/latency overhead if KVM goes straight to =
context
> > switching R16-R31 at entry/exit?  With PUSH2/POP2, it's "only" 8 more i=
nstructions
> > on each side.
> >
> > If the overhead is in the noise, I'd be very strongly inclined to say K=
VM should
> > swap at entry/exit regardless of kernel behavior so that we don't have =
to special
> > case accesses on the back end.
>=20
> I tried raising this point at plumbers but I don't think it came through
> well.
>=20
> You can't unconditionally use PUSH2/POP2 in the VMExit, because at that
> point in time it's the guest's XCR0 in context.=C2=A0 If the guest has AP=
X
> disabled, PUSH2 in the VMExit path will #UD.

Oh good gravy, so that's what the spec means by "inherited XCR0-sensitivity=
".

> You either need two VMExit handlers, one APX and one non-APX and choose
> based on the guest XCR0 value, or you need a branch prior to regaining
> speculative safety, or you need to save/restore XCR0 as the first
> action.=C2=A0 It's horrible any way you look at it.

Yeah, no kidding.  And now that KVM loads host XCR0 outside of the fastpath=
,
moving it back in just to load APX registers and take on all that complexit=
y
makes zero sense.

> I've asked both Intel and AMD for changes to VT-x/SVM to have a proper
> host/guest split of XCR0 which hardware manages on entry/exit.=C2=A0 It's=
 the
> only viable option in my opinion, but it's still an unknown period of
> time away and not going to exist in the first APX-capable hardware.

+1, especially hardware already swaps XCR0 for SEV-ES+ guests.

Thanks Andy!
