Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B1D365A05
	for <kvm@vger.kernel.org>; Fri, 20 Feb 2026 17:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771608757; cv=none; b=S6YFyUNhb4PIh0Npx46jNU/fagsNtHNFnGbPOAY9dqNW7cQA6GDAQpqB42pnviAkYyZYuoidFZtDJuE8uhSG2pXzGN+hKa0z1Dp8sdlMY0DN+KTrIoIsJ8Y1Ai867uwT7u3LtfY+vHw6gSFTw7kasJwdzlIXUIZGuvaXYKdm6Bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771608757; c=relaxed/simple;
	bh=W1JRdh80NWjdF11Um7td9iykQID8FxM/VZmtOgW1UoI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jMVJ9/GYfDjfAmmhEk8cOwHXuWBQPc4CCqEaTgOqZfh9E3fXOG1b48p3ymP1mtaaM45RRwTsSESa5xYLBmstjZrq6lqJUr8c8sHlPTPp6wsPTDQ6SOOHKnEPFh1vZXezkQyGpkmjlDs0tn5Wo8UHLE3uKiPa5sXSb0M8RkDBFn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=z+uhQbce; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="z+uhQbce"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2aad5fc5b2fso20469215ad.1
        for <kvm@vger.kernel.org>; Fri, 20 Feb 2026 09:32:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771608756; x=1772213556; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=onVkE6V+AcjuNo4zB3rjSlYJ7NJfRJxk0ClpAWsnPUQ=;
        b=z+uhQbcezG6YrW8mTTC61pke7IQZwWYgPpJucKeyZuSRtmHfOX29d8BaVtw5qtZZrr
         WIFacfpbq+mOZvUShdGUnn73BV+IMEDLVwAuEzcUbKmUExaMZxsnmO08bLaUgjGbsVTP
         L237AKnH975xccu26XhPJm7A+B9KdnaEfLUhuQI8TxdX8Prf3PMVF7yIvdEgKk2fFhxP
         av0SV5gc2SLFHh9CVgrSs4te9xMDSg9ex3LrKlfSPur6LgYUF1SnDqtR3bab2QDOkPAx
         0lOrbWtjjXcXJVRKgUxvs0meVyh7gh1sNfRiX7uVxMzEFNG2VZswTFi0FxdDcR/wQtC9
         veRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771608756; x=1772213556;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=onVkE6V+AcjuNo4zB3rjSlYJ7NJfRJxk0ClpAWsnPUQ=;
        b=NtsG15TZR4LORG5+KymiMoOmMWFH8ED3ubsJIJ06+A2pJok7dkpR8V6fB4Spr5dSQ0
         MDAz+qMO3x//YlKZqwk8GhYZVkM/Emi/gZfk5LnWM51E7QjFqVW71f4LJhJeMcqH1UvQ
         th1Zie5rjveM1emEb8FDpjZrPVhlEv37sduJ700+7z3kzosnpn7BZy3UEC7c8ay9+toz
         Bjh3WNHnyyVushpehULeT/N1Jb06VhpOsgTha1dnEJduO5nuxukKilSYbOgRWFN487p2
         8YmsLW8MjKYI4DDJ7jNgsWHLp32I8M7pArslo7ELm53CCn2xGiHZWeEgaCCfb26FRnqv
         O6ew==
X-Forwarded-Encrypted: i=1; AJvYcCUf9W9aGQRiFVvZjjqcsFLdbGfFARVNCoPmL8rDg9Hq8Z2vlVN0oK/Af8d3b/rcw5xpv+M=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywl+D8nHJhPtqPIkaMz1elRsT0OF9Kw+4aVJbPFhfzET5Upho9q
	ZLStmEEZs2usxTbpwQ/honNvs4UqBvcuZxGTyeoQhGRTxnHIGhQ8H7IgqnMJqVoMdScZNdjcJlO
	IuIpakw==
X-Received: from plhz1.prod.google.com ([2002:a17:902:d9c1:b0:2a9:1508:533a])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1a03:b0:2a9:104:795f
 with SMTP id d9443c01a7336-2ad74531fd5mr2612385ad.46.1771608755709; Fri, 20
 Feb 2026 09:32:35 -0800 (PST)
Date: Fri, 20 Feb 2026 09:32:34 -0800
In-Reply-To: <437EC937-24B7-4E69-B369-F9FAFC46F1B1@zytor.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260218082133.400602-1-jgross@suse.com> <20260218082133.400602-10-jgross@suse.com>
 <aZYoUE7CmrLg3SVe@google.com> <e05a65a7-bf8e-420b-8a36-2d76e56b43b0@intel.com>
 <d622a318-f7f8-4cff-b540-38d159ca87f4@suse.com> <437EC937-24B7-4E69-B369-F9FAFC46F1B1@zytor.com>
Message-ID: <aZiasvKpOHSaNuQ5@google.com>
Subject: Re: [PATCH v3 09/16] x86/msr: Use the alternatives mechanism for WRMSR
From: Sean Christopherson <seanjc@google.com>
To: Xin Li <xin@zytor.com>
Cc: "=?utf-8?B?SsO8cmdlbiBHcm/Dnw==?=" <jgross@suse.com>, Dave Hansen <dave.hansen@intel.com>, linux-kernel@vger.kernel.org, 
	x86@kernel.org, kvm@vger.kernel.org, llvm@lists.linux.dev, 
	"H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 20, 2026, Xin Li wrote:
>=20
> > On Feb 18, 2026, at 10:44=E2=80=AFPM, J=C3=BCrgen Gro=C3=9F <jgross@sus=
e.com> wrote:
> >=20
> > On 18.02.26 22:37, Dave Hansen wrote:
> >> On 2/18/26 13:00, Sean Christopherson wrote:
> >>> On Wed, Feb 18, 2026, Juergen Gross wrote:
> >>>> When available use one of the non-serializing WRMSR variants (WRMSRN=
S
> >>>> with or without an immediate operand specifying the MSR register) in
> >>>> __wrmsrq().
> >>> Silently using a non-serializing version (or not) seems dangerous (no=
t for KVM,
> >>> but for the kernel at-large), unless the rule is going to be that MSR=
 writes need
> >>> to be treated as non-serializing by default.
> >> Yeah, there's no way we can do this in general. It'll work for 99% of
> >> the MSRs on 99% of the systems for a long time. Then the one new syste=
m
> >> with WRMSRNS is going to have one hell of a heisenbug that'll take yea=
rs
> >> off some poor schmuck's life.
> >=20
> > I _really_ thought this was discussed upfront by Xin before he sent out=
 his
> > first version of the series.
>=20
> I actually reached out to the Intel architects about this before I starte=
d
> coding. Turns out, if the CPU supports WRMSRNS, you can use it across the
> board.  The hardware is smart enough to perform a serialized write whenev=
er
> a non-serialized one isn't proper, so there=E2=80=99s no risk.

How can hardware possibly know what's "proper"?  E.g. I don't see how hardw=
are
can reason about safety if there's a software sequence that is subtly relyi=
ng on
the serialization of WRMSR to provide some form of ordering.

And if that's the _architectural_ behavior, then what's the point of WRMSRN=
S?
If it's not architectural, then I don't see how the kernel can rely on it.=
=20
