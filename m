Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C784C175A9B
	for <kvm@vger.kernel.org>; Wed, 11 Mar 2026 01:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773193562; cv=none; b=KqiKizyaA23658i9oZLwbH3Yvl8jm41SA8GtSc61kmVP/MhF3+v4/G8Gkr9MBgwRbYyHL1sYphxrkpXQwzY08h8N8R41umC5hkjZjjCdo91Z/P9iPSczSOcipf6t06XnKyMShebSxLMDvXx/RQeRpNoAn0Bv2nFrMczYLfjvFX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773193562; c=relaxed/simple;
	bh=tmLE/eCe8jy9/MJ6B6bzlVEcFKzjDryP7BZJeMrOyis=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CT55kI4m/SkW1Ok+7yJ2CSpkJgpeiVHU0cHD3I72J5E244LFBBvbBPdfBwwGnU95Sob74upE4MNWPpwmq70gRBC0D74Hz/Awg73FZCWpiEI0CJEdECeCLgQ84Ps6OrPbR8/cMrqDSqHF1N1Q4Fztf45Jk/szykhK29CPhXDuaD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cpAojPHL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cpAojPHL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B931C19423
	for <kvm@vger.kernel.org>; Wed, 11 Mar 2026 01:46:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773193562;
	bh=tmLE/eCe8jy9/MJ6B6bzlVEcFKzjDryP7BZJeMrOyis=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=cpAojPHLzSOrmmWWgIC/KQHJ0owHR9/jbPNi3V9dCFn22rg0ARS1LO/QBglhFIWUg
	 dwuhAUoUIJZ/+4I2eS/abxdiu+otz8R7K1SOSJe4HAyKjXGZJY0lV1/77HCvPBitNQ
	 zA9XBtwAU6HgRdexG/+hpOcB/V699hecplscqzRJrAQjTonwApbjj/iBfJkWU73Xs9
	 TohCWvTnROjeefj7eVZdcgzPGU+QwB4wtAwbt3WwcHZS7DgCvpCph1gN41HW4XEwV3
	 DBIbY9YSKslAA4h1hl+CrnVxPRLpMEyDawU6HOHlt8MjPdmHR41i3jir7Ucjj7ueZs
	 lPjowPf13zLCg==
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-660a293515fso14632327a12.1
        for <kvm@vger.kernel.org>; Tue, 10 Mar 2026 18:46:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV2mTG3nTOIwM5+GR3hUeuIhikXkzaBhlDZiA+wDqQXmLCpaWWW5k5gT2sR1NYcESo2mWU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9fZFqjrx6aXOLxiv4tCTqjRI8eCvmRBWH3yLJxTEHLcQyc3c4
	TX5//37Ht1LQVYrn0A7gPdYFhF4DanVRrBhShTPA8vM71Ek7AQME/dSn2kxeiAtBtjkddeu6gij
	LJnb/F+ZCIVA4ZUEGFf2aTQSMBkaNtw4=
X-Received: by 2002:a17:907:7b81:b0:b92:7cc:2776 with SMTP id
 a640c23a62f3a-b972e4e2ba8mr31184866b.31.1773193561265; Tue, 10 Mar 2026
 18:46:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260310220414.2569208-1-seanjc@google.com>
In-Reply-To: <20260310220414.2569208-1-seanjc@google.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Tue, 10 Mar 2026 18:45:50 -0700
X-Gmail-Original-Message-ID: <CAO9r8zOY2BX27AmWHT5jzL2ys1jEeGFfGCPNQhwP6WJZtYqwTQ@mail.gmail.com>
X-Gm-Features: AaiRm50grm8dC_Ha9Dar4EeHMCuunFdDl56ur7RwixmKt8vMaY4yu-TES1CNqwM
Message-ID: <CAO9r8zOY2BX27AmWHT5jzL2ys1jEeGFfGCPNQhwP6WJZtYqwTQ@mail.gmail.com>
Subject: Re: [PATCH] KVM: SVM: Add a helper to get LBR field pointer to dedup
 MSR accesses
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 10, 2026 at 3:04=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
>
> Add a helper to get a pointer to the corresponding VMCB field given an LB=
R
> MSR index, and use it to dedup the handling in svm_{g,s}et_msr().
>
> No functional change intended.
>
> Suggested-by: Yosry Ahmed <yosry@kernel.org>
> Signed-off-by: Sean Christopherson <seanjc@google.com>

LGTM:

Reviewed-by: Yosry Ahmed <yosry@kernel.org>
