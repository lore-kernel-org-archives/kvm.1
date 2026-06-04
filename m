Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AABDB4DC522
	for <kvm@vger.kernel.org>; Thu,  4 Jun 2026 21:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780609076; cv=none; b=Y8Z7FGO7faI4c7PvsxE2fDj8fftIiQV9FeLXucTyGCQthuQdR/HyQ7OLC4cWREgXADW3f5sh9wJsX5NIyiBNig5f3stmOzzQEZ2zm5pV+Ix1rb0aTKmH/JiXQ3jyPmewxpNdMnp+Yc08cTrsMRii7yUMmtyT5zI/iDNLTYzSRHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780609076; c=relaxed/simple;
	bh=RdARIrsL4d3wMj4gObHhASuoGP1uqqTyUSoZT66WTtQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qakULvq5YomHE31Cm9AzoMJ40gcKBy7LlU+aUub5G00SOuOVVywwwlcw1SeUt0KIFSRIkLn28VIariKLxJJK4geL6oZn1LDUhaewnVwKzvBtkOFf+yzxOiKq3kQ3LjmSV7LUe+y87+GUxPML4QvNHsx8oFzSCRybecmZj6/+8L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g4LA7kNy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g4LA7kNy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 120A71F00893
	for <kvm@vger.kernel.org>; Thu,  4 Jun 2026 21:37:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780609074;
	bh=hIAVBU8zFqw+Rho/q24j0JAjEDxqHS+EV/shAvn34RQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=g4LA7kNyb6Wn+JG6IEBkL/v8KIw253wmriTkroAvY0Kt6Av/JRVjr5dSW/lppRasT
	 3Dfng8CsnF5WBCNk5eIKDRY+XP0QOW4ZXpEDfiWZGEnbNYX4hKOE5zCpsYn6treGVv
	 usJqSXyB7Dv2+PmqRWDEKLvNCYssRUP3/o853zNj8F72KqoroWR2J8DceAPmbPRcvm
	 j9Thi/Z0IjfVbZDV+FYyRF29S1PWOL8CyCCpY4aryHWA/gYTtr95uvMnMC4B5uhBj0
	 Bl70ZheEoBLfB1Mx0QLbDP5MDDaVySk3VhyznnnpL9QpmUKeeBQ9H4G+/LkfY88eIq
	 qzBgShsnBAFTw==
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-bec423a5265so193937166b.1
        for <kvm@vger.kernel.org>; Thu, 04 Jun 2026 14:37:53 -0700 (PDT)
X-Gm-Message-State: AOJu0Yw0H3Qe2OYhVTi+uhtXwwF1h4Gv0Ra/lfGRtpNniZ3B6oW3xdkq
	TIppJXKM8Stm/qqvPJZ9BjjkuTBHgwi3lDyRAvge4/tzqz13DomIWYihrd4eATTj4TTYJfShmO5
	I5Uy5znNlE5AmMZ5blg8HWvlanKcXitk=
X-Received: by 2002:a17:907:1c0d:b0:bd4:6c96:f87b with SMTP id
 a640c23a62f3a-bf37234998fmr29169866b.28.1780609073020; Thu, 04 Jun 2026
 14:37:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260604203546.365658-4-yosry@kernel.org> <20260604204415.9FE0F1F00893@smtp.kernel.org>
 <CAO9r8zMQYYkjW6oxDOPvH9PO173RPfWSpNWdw4oLz=Z9Zns3ww@mail.gmail.com>
In-Reply-To: <CAO9r8zMQYYkjW6oxDOPvH9PO173RPfWSpNWdw4oLz=Z9Zns3ww@mail.gmail.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Thu, 4 Jun 2026 14:37:41 -0700
X-Gmail-Original-Message-ID: <CAO9r8zPz8WbijVN6mgLb8OaU6=tNSSz1NgNBjZCsC36D4+TO+w@mail.gmail.com>
X-Gm-Features: AVHnY4If8_bs-LcnnQJtK7WlQarj8ZNmeu9NowIHE0muL-UkGdzgMdvdS5JJMgg
Message-ID: <CAO9r8zPz8WbijVN6mgLb8OaU6=tNSSz1NgNBjZCsC36D4+TO+w@mail.gmail.com>
Subject: Re: [PATCH v2 03/10] KVM: selftests: Use an array for guest_regs (and
 fix offsets)
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> It's ironic that the changelog says:
>   Also, the last offset in the struct (R15) is 0x78, not 0x80, so
>   the code actually saves and restore beyond the end of gpr64_regs.
>
> Yet I reintroduced the same exact bug lol.
>
> Obviously NR_GUEST_REGS should be defined as GUEST_REGS_R15+1.
>
> I also failed to document why an enum cannot be used here, which would
> have been ideal to avoid such problems. The preprocessor doesn't seem
> to be able to use enum values, passing an enum value to
> GUEST_SWITCH_GPR_ASM() causes compilation failures.

One thing I can do is create macros like __GUEST_REGS_RAX, and then an
enum using those values similar to enum kvm_reg, something like this:

#define __GUEST_REGS_RAX 0
...

enum guest_regs {
    GUEST_REGS_RAX = __GUEST_REGS_RAX,
    ...
    NR_GUEST_REGS,
};

Although this might be too verbose and the only real benefit is
getting NR_GUEST_REGS right.
