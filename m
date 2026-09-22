Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 100A94A5EA4;
	Tue, 22 Sep 2026 19:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790106234; cv=none; b=DtU3kGIfqnvoPnTZkQrvVMCPfswqZCoIDIt2mve+X64nyQo0MXcgktykALmUB3/5ZuiD/4/nH58Zve79s8LIdl6NLj+3vkmdCcJ6+Ep1Cf3yXzG2GfBrkrGpPNFH8mOLJ8Z6pBFYMulBQ4MrtWPv2DQYgUJx+p2py1hEJ44tJrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790106234; c=relaxed/simple;
	bh=uCvZ7bTAg8w9npwX9WKlBmfs1GlyOLwQZiJI/14kD1A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o3xPRbmqL+s3uSU8zKDm91F2MN6L9P3rOt6xH4DOS3au36vSwWzDLQIhtB3Rx4qSk+AW9vu/Kh5QM6IJ037F9qyoyT6aFHRQ3zd4WHKGucpzJzj9U1oJcUkuBD7RBjTLNuBPrBJqBKXOHb89ZLtJKNRTIm7nJ6zHs3NK1L8Z8Zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=rqKUhMJ2; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="rqKUhMJ2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1790106214; x=1790711014; i=w_armin@gmx.de;
	bh=wYj1hrPTkXIpz4QxokI/qN+ZMgqPLqvdISQ6aFZFcM8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=rqKUhMJ2OQTdldrDOcTaaUypRtgM71XCW8x1z4xzq/bN9zHi/adeKGWPQMfzXpnw
	 ckWaaBB6K2uhMASRdT8SHE1mZa7amDY60m8bi3iOEmxMD/gWhDQKElYoiXoaeTzgo
	 V7gAKyGnF0oEmMUMR9Ugc3YcK69JOJ7Z1CXcLDKhkZfaf9g0az4rz6J7+GnGrQfFJ
	 JBYYKrmBHGYKqZ4Wut1QP24bVp4Q65uGC9TwyvFWV3mehCbv9Ac9PhLtNq0aML5pj
	 Rjsjl8KUU3UMXY0diq7pehWKjShEaprKMqtohbGvLyznY+UKhglcIl5AQB2fSJ1Oh
	 FAjbfN5R5PPiNBcycQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M26rD-1xBZNM2nkn-000NKN; Tue, 22
 Sep 2026 21:43:34 +0200
Message-ID: <4e7fa4ba-56fd-4d47-ad1d-78cef70f24fd@gmx.de>
Date: Tue, 22 Sep 2026 21:43:12 +0200
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/3] <linux/mod_devicetable.h> deprecation continues
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig_=28The_Capable_Hub=29?=
 <u.kleine-koenig@baylibre.com>, Tianrui Zhao <zhaotianrui@loongson.cn>,
 Bibo Mao <maobibo@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>,
 Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 Takashi Sakamoto <o-takashi@sakamocchi.jp>, Raag Jadav
 <raag.jadav@intel.com>, "Martin K. Petersen" <mkp@kernel.org>,
 Heiner Kallweit <hkallweit1@gmail.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, Ingo Molnar <mingo@kernel.org>,
 Josh Poimboeuf <jpoimboe@kernel.org>,
 Jorge Sanjuan Garcia <dev-jorge.sanjuangarcia@duagon.com>,
 Jose Javier Rodriguez Barbarin <dev-josejavier.rodriguez@duagon.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Alexey Gladkov <legion@kernel.org>, Hasan Basbunar
 <basbunarhasan@gmail.com>, Hugh Dickins <hughd@google.com>
Cc: WANG Xuerui <kernel@xen0n.name>, kvm@vger.kernel.org,
 loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-kbuild@vger.kernel.org, Sudeep Holla <sudeep.holla@kernel.org>
References: <cover.1789988540.git.u.kleine-koenig@baylibre.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <cover.1789988540.git.u.kleine-koenig@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/CEsBNx/OWulGQSIUfR7s2WNR1rhcGITTcqHvPwYg+K5U1GPQ9R
 seedvLJFrQB7ZHsu2H5WYk3assehUn/pWM0jzEMpLE3DYqehWV54TMJO3Ln9LRJtxE5uRA6
 E6AnisFfeTImsyrxeccRJZGmG6dzTnf+KCSM1K+vMUgZQew0pYUXMHR/hezLuWr88kBZvx6
 R7AD4OCbLcGRIylkE22kg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:T7iizWULDaY=;aHonCGMLb6xLndCuhjkPFepMC21
 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

Am 21.09.26 um 16:18 schrieb Uwe Kleine-K=C3=B6nig (The Capable Hub):

> Hello,
>
> this is a next step in the deprecation of <linux/mod_devicetable.h>.
> scripts/mod/devicetable-offsets.c and scripts/mod/file2alias.c are the
> only users of that header that use more than a few device-id structs. So
> their number of lines actually grows when unfolding the needed includes
> into them. Still it is a reduction in build dependencies.
>
> I suggest to take this via kbuild during the merge window. Would be grea=
t to
> cook in next for a while before.
>
> Best regards
> Uwe

Acked-by: Armin Wolf <W_Armin@gmx.de>

>
> Uwe Kleine-K=C3=B6nig (The Capable Hub) (3):
>    Move struct cpu_feature to <linux/cpufeature.h>
>    devicetable-offsets: Include the needed device-id headers instead of
>      the catch-all
>    file2alias: Include the needed device-id headers instead of the
>      catch-all
>
>   arch/loongarch/kvm/main.c         |  2 +-
>   include/linux/cpufeature.h        | 12 ++++++-
>   include/linux/mod_devicetable.h   | 13 -------
>   scripts/mod/devicetable-offsets.c | 57 ++++++++++++++++++++++++++++++-
>   scripts/mod/file2alias.c          | 56 +++++++++++++++++++++++++++++-
>   5 files changed, 123 insertions(+), 17 deletions(-)
>
>
> base-commit: 93f51579e7df248780214094418f205253383cc5
