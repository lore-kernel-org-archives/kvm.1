Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06856175A75
	for <kvm@vger.kernel.org>; Wed,  5 Aug 2026 00:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785888143; cv=none; b=IXdk5CObAZMzmgVECkabfl2BiEj/tMd1ru6CvEuYGgcZwxjIx+RPh2G8JsVDJNT95LVbAM2INLhr/Lh8U5VnAHc+C/8WnYhQrd3dLItpKNNz9CrB1QiDjL/0nsb+SmD1VAfBFLqfofzVXIXm/aX+0yQG1sDfW0OlzVF0koqQWvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785888143; c=relaxed/simple;
	bh=HkFTEojO/qOWc882xu2RTxBLNCxBGVUcme35OU96djM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EtF4DQ+bovMf0zrakjZE60BuxpDTg6YIe2CnNdOjeVz5oBXNhl5e+9Jbg2uyi65PA7B+r8Jn3ggm+O80UT8vZ/9c7KSjZRiHdCr8rtANKCT7NBFspCTp4W0M2Xbi0m2cDN2swv/vnmqWRt5/EhmqNUB/94h6oOrRBO4T2/qExLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E3hmSG97; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E3hmSG97"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B63F61F00A3A;
	Wed,  5 Aug 2026 00:02:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785888141;
	bh=wahHLNLvQqDiAuqIsyKHGQsG9kt9ncT9He9I3+NG+Vg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=E3hmSG97xTX5p6KtRFycnEwwOjdSKeVYdVGzrqr1KmhiCZwEVhvghchcHF0zz/iF7
	 ckqepHUeFj1RypQrRUgOirceBRF0zG0plkMYOPFy6yMExfPUMBsxg0WxjHb+QqMNrJ
	 7+hNeCC4MGfrHSpHMcf0Y4bt3zwngPk5rORUwucat7wrTGcc2B1idjB4m9knsG4A8U
	 NcAqN+fj7tQC1VwfuIIo8N03FLiaJ/xUH6+NARt7+vO0GrHfNZQaj2v7YhpEVpcgpc
	 oocl/AD0Q0PpGEMEP1XT6fxFVh1c0rKBpa94hMQLuTocWNs44F68sSbS94+ubwSyxb
	 R7J3Dd3VgYVlg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 05/17] KVM: x86: Avoid NTP frequency skew for KVM
 clock on 32-bit host
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sean Christopherson" <seanjc@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260804233923.3504629-6-seanjc@google.com>
References: <20260804233923.3504629-1-seanjc@google.com>
 <20260804233923.3504629-6-seanjc@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 00:02:21 +0000
Message-Id: <20260805000221.B63F61F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Unprotected 64-bit read of `pvclock_gtod_data.offs_boot` introduces=
 a strict C11 data race and will trigger KCSAN warnings on 32-bit systems, =
though functional tearing is prevented by the freezer subsystem.
--

--- Patch [5]: [PATCH v8 05/17] KVM: x86: Avoid NTP frequency skew for KVM =
clock on 32-bit host ---
commit f1da2e2df5faddd4d0dcc9a823e72cc243ff1f13
Author: David Woodhouse <dwmw@amazon.co.uk>

KVM: x86: Avoid NTP frequency skew for KVM clock on 32-bit host
   =20
This commit removes the master clock check restriction for 32-bit hosts,
enabling the clocksource notifier for 32-bit builds so get_kvmclock_base_ns=
()
is unaffected by NTP sync.

> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 3107878a6fe5d..8f469fd9863f9 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c

[ ... ]

> @@ -915,13 +914,6 @@ static s64 get_kvmclock_base_ns(void)
>  	/* Count up from boot time, but with the frequency of the raw clock.  */
>  	return ktime_to_ns(ktime_add(ktime_get_raw(), pvclock_gtod_data.offs_bo=
ot));

[Severity: Low]
Will reading the 64-bit pvclock_gtod_data.offs_boot without seqcount
protection or data_race() annotations trigger KCSAN data race warnings on
32-bit systems?

By removing the ktime_get_boottime_ns() fallback, this read now executes on
32-bit architectures where it compiles to two non-atomic 32-bit accesses.
If a KVM vCPU thread calls get_kvmclock_base_ns() while a timer interrupt
runs timekeeping_update(), it overwrites offs_boot.

Even though the value only actually changes during suspend when the freezer
subsystem guarantees vCPU threads are frozen (preventing functional tearing=
),
overwriting the identical value concurrently with an unprotected read still
introduces a formal C11 data race.

> -#else
> -static s64 get_kvmclock_base_ns(void)
> -{
> -	/* Master clock not used, so we can just use CLOCK_BOOTTIME.  */
> -	return ktime_get_boottime_ns();
> -}
> -#endif
> =20
>  static uint32_t div_frac(uint32_t dividend, uint32_t divisor)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260804233923.3504=
629-1-seanjc@google.com?part=3D5
