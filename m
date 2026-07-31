Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D282737A83D
	for <kvm@vger.kernel.org>; Fri, 31 Jul 2026 21:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785534035; cv=none; b=kHIo8kqWOexk7HoTGJ7+I7X3q4W2FTgDafs0FzdGfPE3OjTfs0yID7nw/rQO3J9/Hp0wcCb8rCTweefyixVsYiEZpsafXI4U6KXwjF+ocOCmAVpRXpqI0oL/CAzzDK/15Mcg/ouozPWwJ2DKEC4PpPX/6PCkOwmDsRKgQT+iuTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785534035; c=relaxed/simple;
	bh=PbIiAuOFzstU7Cec1rWWvaUvsgfLnbF47nUhljR9eAg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NoH4AY/4zbMPOZrFxHY6M3Muem+Aw+4uSOmR1FIZUqfBJrWe0X0Udk9EGjQ1cveTxesXuZzXdWGlW/gulFRlXycGuc+BlCIuJpIkC3zR26Q6U6jzL/ni5YBrhCwmAU9Q6vYqJBEjcdJegivfcHJgg4PDYIjzcal+sEnvWoPb9Bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=koo5ES/H; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="koo5ES/H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A42B71F00AC4;
	Fri, 31 Jul 2026 21:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785534033;
	bh=gyFC39/rSlAZ2vn0IfwJ4n40wVL2/PEoZ9JURnsOTyM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=koo5ES/H0Va5I9+IV4dS2dI25tuFyUdcemN7bbyZEsZUT4kTIgd82dNecd76GQIRp
	 ct/JMaJAJ57MBhQUsme/5hKHOjs0xzzW5hy8HOR+1Qw5DbNVfgYPaz4+K0Z3ltjAcL
	 bWlIKlHAdTp8s21omjw7E7chR4WyO4/DiLfo/0sHVYVCqDrS4QufkyDIBeGPG0CybH
	 gYiSME7F3I24LbAsCZvPoVWWELY1xy00cGwjztWuS0Id/vUvYujKSziydQW027HBLt
	 kkwcRWAfWwujKc2q+VWwHB8/Fth+jConFjwX1TLcyWf0f6seClI8fbJ7AIZg+ppzhK
	 iX9UZuOPa0xyA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v13 1/5] tun/tap: add IFF_BACKPRESSURE flag
Reply-To: sashiko-reviews@lists.linux.dev
To: "Simon Schippers" <simon.schippers@tu-dortmund.de>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260730213639.726381-2-simon.schippers@tu-dortmund.de>
References: <20260730213639.726381-1-simon.schippers@tu-dortmund.de>
 <20260730213639.726381-2-simon.schippers@tu-dortmund.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Jul 2026 21:40:33 +0000
Message-Id: <20260731214033.A42B71F00AC4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Premature UAPI exposure of `IFF_BACKPRESSURE` flag breaks featur=
e detection.
--

--- Patch [1]: [PATCH net-next v13 1/5] tun/tap: add IFF_BACKPRESSURE flag =
---
commit 43e4cc9000a7c476758fd2aa10db82e86b3c41ca
Author: Simon Schippers <simon.schippers@tu-dortmund.de>

tun/tap: add IFF_BACKPRESSURE flag

This commit adds the IFF_BACKPRESSURE flag to the tun/tap UAPI headers and
enables it in TUN_FEATURES. The flag is intended to gate qdisc backpressure
logic added in subsequent patches.

> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> --- a/drivers/net/tun.c
> +++ b/drivers/net/tun.c
[ ... ]
> @@ -98,7 +98,8 @@ static void tun_default_link_ksettings(struct net_devic=
e *dev,
>  #define TUN_FASYNC	IFF_ATTACH_QUEUE
> =20
>  #define TUN_FEATURES (IFF_NO_PI | IFF_ONE_QUEUE | IFF_VNET_HDR | \
> -		      IFF_MULTI_QUEUE | IFF_NAPI | IFF_NAPI_FRAGS)
> +		      IFF_MULTI_QUEUE | IFF_NAPI | IFF_NAPI_FRAGS | \
> +		      IFF_BACKPRESSURE)

[Severity: Medium]
Does adding this flag to TUN_FEATURES before the implementation is present
break userspace feature detection during a git bisect?

If userspace calls ioctl(TUNGETFEATURES) at this specific commit, it will
see IFF_BACKPRESSURE as supported and might set it via TUNSETIFF. However,
because the actual backpressure logic is delegated to later patches in the
series, the kernel will silently drop packets instead of exerting
backpressure.

Would it be safer to introduce the UAPI flag definitions early in the
series, but wait to add IFF_BACKPRESSURE to TUN_FEATURES until the final
patch when the implementation is fully in place?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260730213639.7263=
81-1-simon.schippers@tu-dortmund.de?part=3D1
