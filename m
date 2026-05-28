Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A94D6367F45
	for <kvm@vger.kernel.org>; Thu, 28 May 2026 23:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780010050; cv=none; b=t6krEO5ZQqSLKhnWqzXD6zlnySBsdBfYYWNO86kfJ1UHvhvJ8EaXz7RDtBygeORYdskdZRbSi/clNEJn0YeMHD1RlIThWN2jZ9CbEKr1QGtWKh1eTt3GDvvskfIqH6jq5iavDivCBFxnanBqb3H7ij1uGJQ19DXIOcbdBGy2Y7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780010050; c=relaxed/simple;
	bh=AXhVk+k68NDO877j6vfyI3k9axu8UA9UWPHybBF1ZQo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gj8DI0dH+IhoQPB11tuTS6GUDAyMg2sQZ3MfOiUv3Xn4BbA/ujM8jZ2V94hSkg+thHyXbSOJ4fW0UXD9UNuAdouuZbG9t6/QrIiOfIkRk/bwbUC9aliimszFcHZUm8yGIg+NbTJ3B3EbRngL7+ODLoFt5eFNPC6TomiKp7qczzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XjL69tzu; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XjL69tzu"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2beff6b6e74so19168365ad.1
        for <kvm@vger.kernel.org>; Thu, 28 May 2026 16:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780010049; x=1780614849; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wsC+LCajCg1t59+zt6iIt3qMuixyj1fPVjF6TGvJZ8M=;
        b=XjL69tzuzTavimvRMO/3sn2Df+AKlYUekga4H3zuTFuHQUXf32eo/aujWpOLpXEvOQ
         9loOVMTQyfWM5w+7kq0xSnlFazloNT752bG1nSc9erZVqffbJhIHDPwV+3Yw5K7MzNLz
         2VMxza0F+vkdM5FAwoBup89I85O0+LeeZMr4PeHfLyKPn+BzI4yFzCfsdlMAw824jkVo
         hW/8OP3J5DXhWRqfMeJyZcPW9BS+ZbPZkdHZg5OjP8732fesCp/atakrUbeIq3NwzB9u
         E3S/KxuIFWD4RSjVdT66g15IeoNL1lsQW2Qz9zYfR5XEm1RMvkcY97WLSEMHseXRNZPm
         r6yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780010049; x=1780614849;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wsC+LCajCg1t59+zt6iIt3qMuixyj1fPVjF6TGvJZ8M=;
        b=GHclBweJxCZTgkNPqGbIgkquKoJa5jprcEDvcwSOiioISO+qMKa48x2yl5gA6u1Hql
         /MXGJYeSfjc1uK4x7zBzjL9jEptJxKZIvW1DmtZS0m5iPVoSaMr5gl/2n2bNI7kRLLCr
         zIlayVK45qqpPMuj3aeGcm+ABNotxg8fz5ig9X8l+Y2XJZt628tQ9yyDxrKhbPJ3iP8f
         fmMbU1iBHAQ/CH5sOGH8NCFnYKewql36S1h8fdINtHJKQIdeIxYx3XG28NzidDDeToU6
         gznUbYUKZ2vAGXFGlMluKIWquqok4lSJC0yyjUvqucIOxnNZJYq3ca5q54yJ9jje86uN
         zGew==
X-Forwarded-Encrypted: i=1; AFNElJ9ASmDPizqckWIxLoDDdNEE45ZyEywkrzPusrizHJBob1vuQ45u76PxM2/cR2YS2pRxvFE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqTcTLo3QP51BpIMlHgslh9v4910rFJ6Gcp6PXW8nlINR7r/YC
	39sJvAkn5qG8w+zT979E0/PMtMcyjUUEiPEWYCJgl1WU5gYjimu566SEf/z9fHJ20Dg4rnXe8KS
	ith6/XQ==
X-Received: from plim16.prod.google.com ([2002:a17:903:3b50:b0:2bd:3ebe:ef7e])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e890:b0:2b7:aa20:3c61
 with SMTP id d9443c01a7336-2bf20bb2911mr4909125ad.33.1780010048831; Thu, 28
 May 2026 16:14:08 -0700 (PDT)
Date: Thu, 28 May 2026 23:14:08 +0000
In-Reply-To: <CAAdrzjs37a-hEneORNmzOvOkh4TX4Dmn6bWKEm5L4hgmkUO0wA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260421231557.1254270-1-jrhilke@google.com> <20260421231557.1254270-7-jrhilke@google.com>
 <ahZQA1HO0wNG6MeU@google.com> <CAAdrzjs37a-hEneORNmzOvOkh4TX4Dmn6bWKEm5L4hgmkUO0wA@mail.gmail.com>
Message-ID: <ahjMQCqJzqJgSs1-@google.com>
Subject: Re: [PATCH v3 06/16] KVM: selftests: Add IRQ injection test
From: Sean Christopherson <seanjc@google.com>
To: Josh Hilke <jrhilke@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Matlack <dmatlack@google.com>, Alex Williamson <alex@shazbot.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

+lists and cc (I assume you accidentally replied only to me)

On Thu, May 28, 2026, Josh Hilke wrote:
> On Tue, May 26, 2026 at 6:59=E2=80=AFPM Sean Christopherson <seanjc@googl=
e.com> wrote:
> >
> > On Tue, Apr 21, 2026, Josh Hilke wrote:
> > > From: David Matlack <dmatlack@google.com>
> > >
> > > Add a new test, irq_test.c, which verifies that KVM correctly injects
> > > interrupts into a running guest when triggered via an eventfd bound t=
o a
> > > GSI using the irqfd mechanism.
> >
> > Can you add some color explaining that this will/should work with IRQ b=
ypass?
> > I assume it does right out of the gate.
>=20
> I think that explanation should go into patch 7 where we add support
> for routing interrupts from a real device:
> "KVM: selftests: Verify device IRQs are routed to vCPUs"

Yeah, I belatedly remembered that the test initially only supported injecti=
on.
Can you expand the changelog to call out that the initial commit is intenti=
onally
"barebones", and that support for things like real devices/VFs and IRQ bypa=
ss will
be added in the future?  Doesn't have to be much, just something to clue in=
 the
reader that they aren't missing anything.
