Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75AF739C014
	for <kvm@vger.kernel.org>; Mon, 27 Apr 2026 08:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777278321; cv=pass; b=eLSSY7isNOgEyB9dqLTkNS2Okk0Qe+vY2CPzs6WDjRbS2K1UyKPGZzJIOpchXwogdpVGyDwtaQIbtaBUoQ840ru22NWDIWxVjItcFfvU0N4b0jBv+rJ3QrNeMLU9VCEVXEhcZs2whuDvU+CDmgRcb1brCI1D1rw6N9vhc0W+5PM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777278321; c=relaxed/simple;
	bh=DP0xPFCiQhucJ/Dny2Ys1P7F6Dt30IATMKjguKpLelE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q9ULc/5CMATUrAtoPx7sYtjKt6l4O6J1pi/8qiTfYk+c6qp3SDclCRX2vFaJLOl/NU6CWuTEoykfyLvpX8XYCv6s7pH2ObDlkHq7RP4bpT1mkrT1ikSj85+8ZlIvjX0fyKwIN81XRs0ZF1xMJJHf2ap9nYMN3/SyLLs1teiG7MI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WhJICaba; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q27J+ZAV; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WhJICaba";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q27J+ZAV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777278318;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5xaAdwH/ZvqVlM3qFB/XtL+Aj8QOREix0lRLn2M7hBA=;
	b=WhJICabarKVkFaH55TDW0G4KtCHrcoMoOus1ugNRjM9JbwH/NaUVajKkN6dqQNazFJUCJt
	FMGOFiI6x27wMMvy+t2DxVyc+jMhrtbb9IWGyJq6V4+oY6TKhbk7bwT9/pf0AhyoLoVGzl
	T+Xh85W0oBZ58v/Sg8R8KoHHZIp5WLo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-685-btuHrW3uPNWbOejGGQRldw-1; Mon, 27 Apr 2026 04:25:17 -0400
X-MC-Unique: btuHrW3uPNWbOejGGQRldw-1
X-Mimecast-MFC-AGG-ID: btuHrW3uPNWbOejGGQRldw_1777278316
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-43d7d03e1e7so7877870f8f.3
        for <kvm@vger.kernel.org>; Mon, 27 Apr 2026 01:25:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777278316; cv=none;
        d=google.com; s=arc-20240605;
        b=XCq/DJvaFS/1DlAkAceeFuXq1ijBZ9Ub3ijWmJKFBvtCYMUAMWFG7UzRCaVyTm9Jcv
         w0leqy1tY+Nm3U3nUBfTZUev7/JqjK28BmGZL7MSBAgKWvILbMyF4UT7N1ZK7S3i+6Zd
         rmIDID9UUgP4dxPK6eeHo/cqlWBOSb/deOI2WOWEGvBCvDA3JS1Vb556TW2sBWRclWUu
         ZXpGV25vFxgeC/Vpz1/qi7UJCWd9lIFoPeNjlIp5/S1M12yvtErIAn9oxE1pYjs3nZQw
         ROzRpFwbgTJtvI36RNgp1n34X8B9MtgSCp9wcTBFDMiyxts5u+DsJycgup80AsYfPWB0
         1iMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5xaAdwH/ZvqVlM3qFB/XtL+Aj8QOREix0lRLn2M7hBA=;
        fh=QLaDna74SSElc4n7tm5kg6um2jp/ALsVloRvJCgGSws=;
        b=hwZe2SkaKkLK+KUWGr/jLnXDCdcTxdA1SJEZLavvLlFEY5SVMXHhIC8j5Pi+czh7Z/
         lxQ/mHHB7C6T4M8zTX3Y5kG2hgP2pVdSqH+6nYu5rvdFuflwcpynotw6/v3qZ4CoEy4c
         LUUvnP7k5Re/yWUihniITF4DlV91OOV3dOGJda1hltMC9l8IZkRNgvpcaV8N0sBQ1H19
         f2Udl6PuokR/5fS5V7bLJtZfzEbhuqbSKF51MM49iEIG4/iYVLm/qd0j6WjBHiUqiCT0
         XUbhiKdj5Z/sO2JqthmNxBQjkOpmGHXNOHE7BCGR5gOG0kK2p+3wOQhWpdehxrR6/A5O
         rKAQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1777278316; x=1777883116; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5xaAdwH/ZvqVlM3qFB/XtL+Aj8QOREix0lRLn2M7hBA=;
        b=Q27J+ZAVja3QUxO61mDh5kMnREh7FkDI3mEKmZtxHT3MOoJlxfWqgyq2X+PXeIV6Iy
         IN2CD8tWC9miyuqiOxV3Tj9oneIrbbYTJv7MUKHv3EWQhCGo+BSg/CCM4NJjBxXbb7pV
         KiJQ6aw2wgcwlzXlkMHvTkRLKGxJvzCHhs1gfX7EsmHMgwiCxIoIazv6DWHouoCpEkFb
         PFmWEn/cA+cAk+J4yFNZP/HFJfVJGgmrTIamCHH/qn7vUZTUB0yxWhA6fdFcxUtyH+N5
         G6mKxaWMDhoFfezHIi48ddQQBQswfcpStOX8+Al2ZQ7/fpytx2GatoemkQxJzGJZE3wk
         +hGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777278316; x=1777883116;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5xaAdwH/ZvqVlM3qFB/XtL+Aj8QOREix0lRLn2M7hBA=;
        b=c1CXhScDxzuoKYsoK+vuQwUMOF9Qt+VCs1Rq0TGJmjZISdV8BJ3y1rpRKeAe6cl692
         KVphZH6RYnJa7lbwHoTgD07m3SgB25jAe2xGF40upxRETTIT42Brju3Uct93pUtTMNsr
         ki+QFb4xjNZ0ka2KZIrn/HpXOvyGOY5oC05t4We3RSP2A62yjjYS/Xn5zviaqk/hiR+d
         xmxEeBYVPIcafHO9+X+gqHOrMchacA3wasE6YYL5wWVgwgEGeE3CWsbdPvgr0eU2vpjM
         Vm+ZteivyBjW0wOgCh9s10kYQr9DFO8lg2Gp2b/8LHPEHhN7CNrE1PYg6+m7fxb4IDOk
         EG4A==
X-Forwarded-Encrypted: i=1; AFNElJ/uAfZqbI+FXRkHGr/1zZSv1L8o/m3KOxF8eLr+HzRrtob22+ACVxbtxFL64eITveOGbtk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXiHIz0ZHQELQ24pLMNwYlO+usdh/V8LsKDswh9cMchhnLC4yC
	qG+MsOrNMuPIB3nZ4ggWS1A+lP7IhiL/21+Z3skBz/ZXxsIcCsCAnPaBliqJY4lDqARTElfziXn
	uipnuervgsUwELqXMdEYUvgneLIMFg+2EJMC3PHwF+1mwgxEtJrAirKMVXIJwQHjWq/F3S5+2pE
	e+J5v1xp0aJBJk+/Hq77yKb4Pd2lMN
X-Gm-Gg: AeBDieskp/KvGu+e09VEXhfLmXU4qkXztPzErHcwhPj8rP7kH/K40Wql+4iGaRXKuPV
	lEqykIPHwdl9dzIRR2rc0G2CIyYbGKWnWkpfhfQxjdlSOCWXJhcqt2TmvcQ8WNS6zxVNBpOJ9pR
	52DOZIZ6agqujkevKznZ8w5pa0B/B4CSSSnFziwvHwV718LhqwnIJbo4pJKWuItBudReufjv6gH
	LwnS2kj0OtpI33D4XbwJRxJS30gNX9cbT9IzX7XO0DqyoxesFm8qI8xPd4R11o5yTowq6RMUH2s
	wgWdn6BFljhh7sU=
X-Received: by 2002:a5d:64c3:0:b0:43f:e266:4c9c with SMTP id ffacd0b85a97d-43fe3db2e62mr64527654f8f.3.1777278315514;
        Mon, 27 Apr 2026 01:25:15 -0700 (PDT)
X-Received: by 2002:a5d:64c3:0:b0:43f:e266:4c9c with SMTP id
 ffacd0b85a97d-43fe3db2e62mr64527575f8f.3.1777278314785; Mon, 27 Apr 2026
 01:25:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260424151443.750077-1-maz@kernel.org>
In-Reply-To: <20260424151443.750077-1-maz@kernel.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 27 Apr 2026 10:25:03 +0200
X-Gm-Features: AVHnY4LX4zIbvkokFvwRe85hWW9vU3Mi4qKP1vkFGw7_g8t-wfUHl7-fG7neYpg
Message-ID: <CABgObfaBf8NMM_vNKy5gPamp1gbsT7CEv=SA2X9yQ10gekgMXA@mail.gmail.com>
Subject: Re: [GIT PULL] KVM/arm64 fixes for 7.1, take #1
To: Marc Zyngier <maz@kernel.org>
Cc: Ben Simner <ben.simner@cl.cam.ac.uk>, David Woodhouse <dwmw@amazon.co.uk>, 
	Fuad Tabba <tabba@google.com>, Quentin Perret <qperret@google.com>, 
	Sebastian Ene <sebastianene@google.com>, Vincent Donnefort <vdonnefort@google.com>, 
	Will Deacon <will@kernel.org>, Joey Gouly <joey.gouly@arm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Oliver Upton <oupton@kernel.org>, 
	Zenghui Yu <yuzenghui@huawei.com>, kvmarm@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 24, 2026 at 5:15=E2=80=AFPM Marc Zyngier <maz@kernel.org> wrote=
:
>
> Paolo,
>
> This is the first drop of KVM/arm64 fixes for 7.1. Nothing really
> major so far, but a rather wide range of fixes for idreg handling,
> long standing regressions, SMCCC compliance and more. Add a few
> cleanups to the fix, and that's about it. As usual, gory details in
> the tag below.
>
> Please pull,

Pulled, thanks.

Paolo

>         M.
>
> The following changes since commit 94b4ae79ebb42a8a6f2124b4d4b033b15a98e4=
f9:
>
>   Merge branch kvm-arm64/misc-7.1 into kvmarm-master/next (2026-04-08 12:=
26:11 +0100)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm.git tags/kv=
marm-fixes-7.1-1
>
> for you to fetch changes up to 4ce98bf0865c349e7026ad9c14f48da264920953:
>
>   KVM: arm64: Wake-up from WFI when iqrchip is in userspace (2026-04-24 1=
2:03:57 +0100)
>
> ----------------------------------------------------------------
> KVM/arm64 fixes for 7.1, take #1
>
> - Allow tracing for non-pKVM, which was accidentally disabled when
>   the series was merged
>
> - Rationalise the way the pKVM hypercall ranges are defined by using
>   the same mechanism as already used for the vcpu_sysreg enum
>
> - Enforce that SMCCC function numbers relayed by the pKVM proxy are
>   actually compliant with the specification
>
> - Fix a couple of feature to idreg mappings which resulted in the
>   wrong sanitisation being applied
>
> - Fix the GICD_IIDR revision number field that could never been
>   written correctly by userspace
>
> - Make kvm_vcpu_initialized() correctly use its parameter instead
>   of relying on the surrounding context
>
> - Enforce correct ordering in __pkvm_init_vcpu(), plugging a
>   potential pin leak at the same time
>
> - Move __pkvm_init_finalise() to a less dangerous spot, avoiding
>   future problems
>
> - Restore functional userspace irqchip support after a four year
>   breakage (last functional kernel was 5.18...). This is obviously
>   ripe for garbage collection.
>
> - ... and the usual lot of spelling fixes
>
> ----------------------------------------------------------------
> David Woodhouse (1):
>       KVM: arm64: vgic: Fix IIDR revision field extracted from wrong valu=
e
>
> Fuad Tabba (5):
>       KVM: arm64: Fix FEAT_Debugv8p9 to check DebugVer, not PMUVer
>       KVM: arm64: Fix typo in feature check comments
>       KVM: arm64: Fix FEAT_SPE_FnE to use PMSIDR_EL1.FnE, not PMSVer
>       KVM: arm64: Fix kvm_vcpu_initialized() macro parameter
>       KVM: arm64: Fix pin leak and publication ordering in __pkvm_init_vc=
pu()
>
> Marc Zyngier (2):
>       KVM: arm64: pkvm: Adopt MARKER() to define host hypercall ranges
>       KVM: arm64: Wake-up from WFI when iqrchip is in userspace
>
> Quentin Perret (1):
>       KVM: arm64: Fix initialisation order in __pkvm_init_finalise()
>
> Sebastian Ene (1):
>       KVM: arm64: Reject non compliant SMCCC function calls in pKVM
>
> Vincent Donnefort (1):
>       KVM: arm64: Re-allow hyp tracing HVCs for [nh]VHE
>
>  arch/arm64/include/asm/kvm_asm.h   | 28 ++++++++++++++++++----------
>  arch/arm64/include/asm/kvm_host.h  |  5 +----
>  arch/arm64/kvm/arm.c               |  4 ++++
>  arch/arm64/kvm/config.c            | 23 ++++++++++++++++-------
>  arch/arm64/kvm/hyp/nvhe/hyp-main.c | 30 +++++++++++++++++-------------
>  arch/arm64/kvm/hyp/nvhe/pkvm.c     | 38 +++++++++++++++++++++++++-------=
------
>  arch/arm64/kvm/hyp/nvhe/setup.c    |  6 +++---
>  arch/arm64/kvm/vgic/vgic-mmio-v2.c |  2 +-
>  arch/arm64/kvm/vgic/vgic-mmio-v3.c |  2 +-
>  9 files changed, 86 insertions(+), 52 deletions(-)
>

