Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE0F53594A
	for <kvm@vger.kernel.org>; Tue, 11 Aug 2026 00:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786408080; cv=none; b=itc4RJcnpIhylj0kWP4l0lHbfN/IGozHK4j/RNhjZ50M9QntD+8HZvy61uyqNxzyf+Fqqz/nierZm9I3rnzZBztWokh4u/arDRFDcdnxkheKmO92B98vqgKBNvYCFcuGQvym6/l7T2iuEvcDSWo6gpAJNBlLfdGAQJPDT2vqLrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786408080; c=relaxed/simple;
	bh=Z3/m4TkqL/dv/HUc2AANkOLODQvUR2RTnqXEuVw/xLs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QxbOPq+CDCAMh8GWPDsvmn+0dxXRzwtK+AT2hoKTESqLzUv0AYe4JZUCmWgkzZS77WaUNnxkZH0XBW9Q9JK2ggAkj0psE7Z3fPEQfivCGbhYIDlQFsZpXYwT3hChaA1WOv3E5318UooDQDGasf4bxzecYKm6lMySRYMg99YTlZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=K1qXzL9t; arc=none smtp.client-ip=209.85.214.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K1qXzL9t"
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2ce7dff6253so4218665ad.1
        for <kvm@vger.kernel.org>; Mon, 10 Aug 2026 17:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786408079; x=1787012879; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=LEmG05/qyAp4ekJGUu3plZzNKZ0Z1vbporsI46eg3PM=;
        b=K1qXzL9tQ/GOltgREmpmy3R9IPh2YHCEq8YNYbxgXnx4TJlJLukasmcGagSU0wAZOI
         odpGJj2ciR/htNh9bqH4G9L6WK1KVvi9r4e69PNA/JcpgmxwTuAdC8xd/NtZ6MEb7AWl
         UgQc8wygalg91v/k2p2F3Ilv8PnMTd2op5qDzky54ZE2RNB81lshkC5Jl8/Q2JHJQ8mA
         1LD/b+Uv0aLx+uxholOAS56xI2+nqScYAUpeq6GpU4N7dDGY4ZNTJ3yzsdE3rcEkrU2u
         4vGzxZal4iMnWBaTJbcJb2TVj3ztGpYIIFvVYcWZtCRgzXi+J9IsvAyLwppdH7Ma3vBg
         uNGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786408079; x=1787012879;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LEmG05/qyAp4ekJGUu3plZzNKZ0Z1vbporsI46eg3PM=;
        b=HZpxsHonOFUSRf+R+ds6b7ux0vJggplqA5JWw2LjprR3sfein6KSjRNccU3CgTtVqY
         wZyjOe7xeegR276MYlPjWgXxAfFFL8C0pbeq5mzzHIe8vFN801JcMF1CX4W0dqiuJPrI
         kMAtoLVwlODeNvjSP3TbfLmTeuUBm2AHzN8ytZXuAkebMt02UiSMLRWgwfI3RVr3Ibkx
         nTf09lqKsXs3D3envyhy6WJ42wlus4eN4x4Qh5l7EWAtWyCZWoQ81fbUNotX3CGkmh+K
         5t89bw9UHK46p/p1zLAoUpiEQU/4BtAHK8eu3Iqg5zrPLr5gj6djpEQs+z6J2wioGTM7
         43KA==
X-Forwarded-Encrypted: i=1; AHgh+RoWjU2Irtu4vfJkJq6f2lAldvXTo4I/8cLDaKeWbXXXZnHJ0UV5V6rulL0aOM8jYsI/Svk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrTEZhBZZqucIU0c0Jmq8913d038b8vn7ombO6o70onXZ9pfH6
	/S1F4aWLrKyyOeWN9YZJeXz0V8o/AfKu1sP4zEwnEmrEiMUiikzqwMGc6sFfJAsWCR+eyHxI+aX
	h1ywQ2w==
X-Received: from pjbnm24.prod.google.com ([2002:a17:90b:19d8:b0:37d:95c5:815d])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2d0e:b0:390:b3c5:e2c9
 with SMTP id 98e67ed59e1d1-392d61cf225mr980360a91.17.1786408078835; Mon, 10
 Aug 2026 17:27:58 -0700 (PDT)
Date: Mon, 10 Aug 2026 17:27:58 -0700
In-Reply-To: <84113ba5-ddb8-47aa-abe0-c6968feb3fea@amd.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260706063035.1139-1-sarunkod@amd.com> <20260706063035.1139-2-sarunkod@amd.com>
 <20260706065212.CCD741F000E9@smtp.kernel.org> <84113ba5-ddb8-47aa-abe0-c6968feb3fea@amd.com>
Message-ID: <anpsjpCQHjJCH7TU@google.com>
Subject: Re: [PATCH v2 1/2] x86/uaccess: Extend CMPXCHG user helpers to
 128-bit operands
From: Sean Christopherson <seanjc@google.com>
To: Sairaj Kodilkar <sarunkod@amd.com>
Cc: sashiko-reviews@lists.linux.dev, kvm@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 06, 2026, Sairaj Kodilkar wrote:
> On 7/6/2026 12:22 PM, sashiko-bot@kernel.org wrote:
> > > diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/ua=
ccess.h
> > > index 367297b188c39..123755d471099 100644
> > > --- a/arch/x86/include/asm/uaccess.h
> > > +++ b/arch/x86/include/asm/uaccess.h
> > [ ... ]
> >=20
> > > @@ -551,11 +594,18 @@ do {                                           =
                                 \
> > >=20
> > >   extern void __try_cmpxchg_user_wrong_size(void);
> > >=20
> > > -#ifndef CONFIG_X86_32
> > > +#ifdef CONFIG_X86_32
> > > +/* Always fail on 32 bit arch as it do not support 128 cmpxchg (i.e.=
 cmpxchg16b
> > > + * instruction).
> > > + */
> > > +#define __try_cmpxchg128_user_asm(_ptr, _pold, _new, label) (1)
> > [Severity: Medium]
> > Does this 32-bit stub correctly signal failure?
> >=20
> > Since this macro evaluates to 1, won't the surrounding unsafe_try_cmpxc=
hg_user
> > macro treat this as success (true) rather than failure (false)?
> >=20
> > This could cause the wrapper to negate the value and return 0 (success)=
 to the
> > caller, falsely signaling a successful memory exchange without actually
> > updating memory or the old value. Even though there are no current 32-b=
it
> > callers using a 16-byte operand, should this evaluate to 0 instead of 1=
 to
> > ensure theoretical future callers don't encounter a silent atomicity br=
eak?
> >=20
> > --
> > Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706063035.=
1139-1-sarunkod@amd.com?part=3D1
> Hi,
>=20
> Right, It should return 0 instead of 1, will rectify this in the next pat=
ch.

Is it possible to fail the build instead?  Attempting to generate CMPXCHG16=
B on
32-bit should straigt up fail.
