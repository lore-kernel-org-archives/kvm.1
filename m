Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97023541E62
	for <kvm@vger.kernel.org>; Tue, 22 Sep 2026 14:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790087207; cv=none; b=Rpzm+oJkjl0MzqtPKwm+1RpYLRPn2pSS/Wq3rmJKaGwZBrJQfjkBcFjcmZ0/5a0eGTo1Vm4vKNgqQVAv/DSSBluOv98aP1874rM+ImAecMEoFexOPcL1HzsuuNjp7p2Zio43L9t3crnqllDrUS5xOaogZk4vn1M3UpHCOFeYGII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790087207; c=relaxed/simple;
	bh=Za4HiTH5fd7ZrTkBdvju5YhW4OO6kkXrdIMnFfEsV8Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uL+GPoafa8Lx+J0OAjFkSnkbET2KdPEvMEh5XhM2dYHNvItZCQJYd+vWhvX96YclQz5ir6KjlG2Tt8E5fjy0ilDcwx4EDSdQdAQ763rpIHsAa5F+/GZCnlzs6UNbe052qoQqscL6LeAvRd8PYT88vmm2I/NZlmcRq7jZbfy1wn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iZ8V4CLL; arc=none smtp.client-ip=209.85.210.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iZ8V4CLL"
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-86a74698972so4837254b3a.0
        for <kvm@vger.kernel.org>; Tue, 22 Sep 2026 07:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790087206; x=1790692006; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=NMCpZ+rBKmM5pPV3/1AGo5Sjpxhi2AiAh3yEFMHYDvA=;
        b=iZ8V4CLL3dBvkO51Ac7lT6ON4T6AJugUsp0w0LevL6H7ecgjRxUfMH4dqIRo74Hv6U
         3itFQIARzrKEg6BonuiwFD/CZxgSsvWB5HSNxbZcPTgWJnUnmsL7G0/VgkUf357hjEzU
         E1XaicRaqIw49vqGIgmXrKrkGpqseB30uSdepPC0B0vKcQZHiKpe2qkyfPPV8omIcMDp
         6v5Dxorq0Zv9bFAueDY3UWIvZ5UzdKEtt9wFsxDN7ZP0gyQ5L2MnO9W74LvlG1PGIvuB
         zoba2PA5z4u7u7hNAZQG8pKU3KIt1Fqf9Y/baDmp7ro7IMZheczIVy/n2XMNIgA9CbJ6
         VpPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790087206; x=1790692006;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NMCpZ+rBKmM5pPV3/1AGo5Sjpxhi2AiAh3yEFMHYDvA=;
        b=l4LLnXJRw4jLqBldRe/4SxS/YiUofMTsZEVP/1C6HsBlpcQIvJgOiUAQJEQ4KTXuN2
         QgHNUXy/aiRMrkUbGDwh3sowk40dNVQqTPKr1F9gfDzK8MKlQSyaz6eIDRzGd6cDcR0W
         7yr5YlgvPkPsL12UMi6aChGtlM0VV9P65/Cp/TbZ4v842QlkSPakptNgkyBe2IY/p6RC
         79daIVwN7jKwiILZsyHpVEKIvmAyd6hFDDYoK3s5uCJ/QWDjfS0rI+n2JX1GNxHWWSoW
         yADz3gPvSAGDtzpteSgGeNayoKdARKwAYjmAUs/e8URw6vm7FiBHOGa8lGva3key7RKh
         I8lg==
X-Forwarded-Encrypted: i=1; AKwUvBzAmZshfLZmjI0sfwzn3PjoSKTKzkdorQkq7qgV3kyynN0gqHdL4UM6CsREgip/6AfeXtM=@vger.kernel.org
X-Gm-Message-State: AFuF++kDQD1HVGIA0anp82IW3h7mV+Cjs3rY4NSoXF30yZQIcDgHzKNk
	r+oLFUCLKfPfcykyCdYoqEVxCFN0fmXDtnQTDQTE6v2LKHnrtAfEBJkSoQOVHl8ZDBoqJM/HAH3
	6XmzFkA==
X-Received: from pfjw17.prod.google.com ([2002:aa7:9a11:0:b0:87b:4362:1067])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:4b4e:b0:868:e6d3:fc18
 with SMTP id d2e1a72fcca58-87c8249eb60mr1475498b3a.15.1790087205245; Tue, 22
 Sep 2026 07:26:45 -0700 (PDT)
Date: Tue, 22 Sep 2026 07:26:44 -0700
In-Reply-To: <CALMp9eQboC6DTQfa3N58XCfOLf-qwJ2L7dC5vtqDerHG80eZLg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260918154530.4129698-1-jmattson@google.com> <20260918160109.E76B81F000FF@smtp.kernel.org>
 <arKJQwAPvApkeESD@google.com> <CALMp9eQboC6DTQfa3N58XCfOLf-qwJ2L7dC5vtqDerHG80eZLg@mail.gmail.com>
Message-ID: <arKQJJJB8HMK0B1G@google.com>
Subject: Re: [PATCH] KVM: x86: Disallow EFER.LMSLE when EferLmsleUnsupported
 is set in guest CPUID
From: Sean Christopherson <seanjc@google.com>
To: Jim Mattson <jmattson@google.com>
Cc: sashiko-reviews@lists.linux.dev, kvm@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 22, 2026, Jim Mattson wrote:
> On Tue, Sep 22, 2026 at 6:57=E2=80=AFAM Sean Christopherson <seanjc@googl=
e.com> wrote:
> > Gah, I hate the negative "feature" bits, I've gotten completely turned =
around
> > multiple times trying to sort through this.
>=20
> Me too!
>=20
> > IIUC, you're trying to "fix" setups where host CPUID.EFER_LMSLE_MBZ=3D0=
, but userspace
> > configured guest CPUID.EFER_LMSLE_MBZ=3D1?  If so, then Sashiko is righ=
t, it needs to
> > be declared with EMULATED_F().  I would even argue that technically thi=
s isn't a KVM
> > bug, because KVM won't advertise EFER_LMSLE_MBZ in KVM_GET_SUPPORTED_CP=
UID on such
> > hosts.
>=20
> I'm trying to make it possible to run a Rome vCPU on Milan or later.
>=20
> SInce this is a negative feature bit, it must be retained if the host
> reports it. That blocks running a Rome vCPU on Milan or later.
> However, a defeatured Rome (which reports LMSLE_MBZ as 1) can be run

So, a partially defeatured Rome?  Because it sounds like the CPU reports LM=
SLE_MBZ=3D1,
but then still allows setting EFER.LMSLE=3D1?

> on Milan and later.
>=20
> It's the same feature-hiding we do all of the time=E2=80=94just inverted.
