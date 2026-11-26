Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795713360;
	b=ge7BcTFLBBmK0vfsh0xObU8p/M7Tu098cJyggjjoIHzIIsBvjMqt2ZZ/VekosXqvoshR
	 y/qv94BzPWR0bGah44T9Gef6KekIXQNl2J+7hVdLyMPdMiGl8A111aZi976eSukOnrpmN
	 gm8aLg8VNSGT8/SFIe7kzjFtNYzzXAuK/dNMiRNtT12pi+wMiJfGV9BBicABuVsYZ9DBA
	 T8GVv50E+Jf8PqgKIOFvQEQxQEwYMzv6PBtylMWa1r6FWMX8ArkDiiFGBck9kXii2SQmA
	 ZFv4Rle6WQZ9sO0n6F94m4wvxmmvlwPzK7RjbOHZwcJU5ml1+pYphtOYBwS0EsPM2dA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795713360;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=BRO9cmEwKofDlfOxSsKnsN6tv9PzeIUclDwnefSi50U=;
	b=1E+MEfNUnx7WxeU0DSNIQ3OpW4x0O/Dzq/4CuWAIKbm6Lj5rP+F7O97P1Jb+eskyVuIL
	 eyn+5Qb+ct3KW6rtup3yq7gz3mJt3inbv12O+n6HxY0t/7ewZNbqINVRU2wE8TyC4cqCR
	 E6f/yCryv0STdhxdiIz9F65mQTGYS1BiVubHWZJwX6jR8Zqzc6Fi8poI/1oQj5Yt92Jme
	 ZYul8ZOeL3MA8sRg/FM5K+18nLehLUXhiOzX2gDKjo/63TpKWPyvRGJFcdUhn1FRVOYPW
	 MZDrFkhxdTHReZ213Qki0RT9pzQhvBHNpsG/x8466ur+UgXTpzZT1Fwfc+eTyebBmBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iGYz+JFv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0172606A31C
	for <kvm@vger.kernel.org>; Thu, 26 Nov 2026 17:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iGYz+JFv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F28401F000C4;
	Thu, 26 Nov 2026 17:15:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795713359;
	bh=BRO9cmEwKofDlfOxSsKnsN6tv9PzeIUclDwnefSi50U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=iGYz+JFvdbbkM80FrwiMIKCq8SNaouheubcXzFxHM/4Oiz/3R2NRkVbNM5fcHgLR0
	 Y0Tex0eaNKwZZXcDsoogmV0vzp89ny9cPu2qRODIijDzAkwaQm0EtW2uK3R8jHHMBP
	 6GAhhp42z0u2SlCn2PW7c+JVTB43RknVcHcQmAGrXZ0JSsHmJ60plKBe1LFLnnC05m
	 VYodwePrfgbqZA6qPs75G9kZ4WF1EtkEqbABhosFRBPAhDAhaO/HvZ5eECN5gVmjrd
	 N9ebBLZbOQ7H7QnwcsAMcxhAvrnm96Skn8kcA1YSsRcVQviUTc4Ihy4NBqBUlevbzM
	 IRPWjV2AZrN0g==
Date: Thu, 26 Nov 2026 17:15:55 +0000
From: Will Deacon <will@kernel.org>
To: Giulio Benetti <giulio.benetti@benettiengineering.com>
Cc: kvm@vger.kernel.org, julien.thierry.kdev@gmail.com
Subject: Re: [PATCH kvmtool] include/linux/types.h: add __s128 and __u128
 types
Message-ID: <awhpSxXK7e8G2hE-@willie-the-truck>
References: <20261124163248.782815-1-giulio.benetti@benettiengineering.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261124163248.782815-1-giulio.benetti@benettiengineering.com>

On Tue, Nov 24, 2026 at 05:32:48PM +0100, Giulio Benetti wrote:
> kvmtool's include/linux/types.h shadows the kernel UAPI <linux/types.h>,
> so the __s128/__u128 types it provides are missing. Starting with Linux
> 7.x headers, arm64 <asm/sigcontext.h> and <asm/ptrace.h> use __u128
> instead of __uint128_t, so building kvmtool against them, where
> <signal.h> pulls <asm/sigcontext.h> in, fails with:
> 
> .../sysroot/usr/include/asm/sigcontext.h:81:9: error: unknown type name '__u128'; did you mean '__u32'?
>    81 |         __u128 vregs[32];
>       |         ^~~~~~
> 
> So let's add the __s128 and __u128 types the same way the kernel UAPI
> <linux/types.h> does.
> 
> Signed-off-by: Giulio Benetti <giulio.benetti@benettiengineering.com>
> ---
>  include/linux/types.h | 5 +++++
>  1 file changed, 5 insertions(+)

Thanks for the patch, but I think Kajetan beat you to it:

https://lore.kernel.org/r/20261113153847.60183-1-kajetan.puchalski@arm.com

I'm just sweeping up kvmtool patches now..

Will
