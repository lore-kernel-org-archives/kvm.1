Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C8D0241CB7;
	Wed, 18 Mar 2026 22:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773874519; cv=none; b=gSFnP5Aso8cdkU5xIjut8V2q2DwWe7hh4dO8Gb8YdRasSgVU52nOlwGBzIQY/ylCGSlBrJmXflGBGN9xY0sxfKVFSdfc8HFm3pY2yuArNwvZdWPm1yAL+mKkzbKERCLtfYPi4guTmK/pKa1iSHZpwaHfylEUa8nuPEPJAklAKwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773874519; c=relaxed/simple;
	bh=m49UWEim2RSLrDXwf17yEXG0je2aSXpyWxW5bWpRCYU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TMR/Fk5jTbVcAne5+Zcv+/TTH01uVQHwac84SRLquPLMiuD6Irp06teKs7rhqmiKGbX1+HmupjOV73gAHYAb3WJAsTI72lQFLF27UzK2I83FZmR3o/XDxWztwWopC2rg3vLKphR8A45ZxwRmmorWgfyEAtgiH0GB4+VozmxIYkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=sxhfXUtV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kbOr+UkD; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="sxhfXUtV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kbOr+UkD"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 89A1CEC0113;
	Wed, 18 Mar 2026 18:55:15 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Wed, 18 Mar 2026 18:55:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1773874515;
	 x=1773960915; bh=f7/EJSeIqZSMvL2vCp7MAbeNnvAF9CxjB7jDB48hDcw=; b=
	sxhfXUtVGjnt2kDZPWG6EKqisA69FMI9944QmIJ/7kFHvgQYMQM952jgujhz0ed9
	sGwqQZO03Uz6EDFJKG1m0jG3IqqFq2BrNWi+ksy6ycZi9PZbmR01Gkrh/uBHEmMG
	KT85iu46npOlFc0vGb5uuXsGkzI4YMUZ9nb1ytySiGFnXOysrhVra9eZA0nQ2boZ
	8NReTTxrD/vOkvsAvUhqmWr5wQ7BrQkiSW58NXPLOSaLVdcPIJTPdmgye+KRlxbP
	m6LdRP1aDbe8SI4yaFgCQ9LhWpqsP39lFKnDTkBXvfHgq61rpBfqp+ApACewC5ZH
	Z9U/SO3vx29nIMio3BVpVg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773874515; x=
	1773960915; bh=f7/EJSeIqZSMvL2vCp7MAbeNnvAF9CxjB7jDB48hDcw=; b=k
	bOr+UkDMGozMlz1mz8sb8G7aOAg79oK0nYLUnOaacM8WunBYMwWWCoMhCs2XK7VB
	aROIY3mAnaeiQnLisYsY059OvS0sL8eV2+tcn81ersnIwtXjZc1Q32Pjt2ly06z7
	qiMQmZpNMOJO1ik6qJOjpq1iA0grVLFE3JGjRqhdqV9krwEHzoW+qAO01BZXrKKU
	rttSo1XYCYkZUhJp+5EhA0g8H+rCixeyu2tUUibCcDSE9aKic9zQNMM+YB0Wm5Un
	saE3CKR86iqHGmM7LPBE5sB7kZvOqD4VWaCwYQ6g6xa4zAyjlIN2Sue5WmkoVF7i
	Cz3gjGqDOXJVd3gc1H75Q==
X-ME-Sender: <xms:Ui27acjVQUe_hqotpz853aVLypr1AXxYUOwHbLM1weMRM6ZSoquS_A>
    <xme:Ui27aRC0MeKyYzzm9IAu-CaeTkijeTD53ZUMNePuT32YPIyd0LjpsJHzOmY21qQBn
    b7tKe_wUmp8ACdethmgUHBcISCNRnitn9wbZCINY8Zw-XRqOjw-zg>
X-ME-Received: <xmr:Ui27aWRbc1haoc8j5zilbT1AMfxsBnUAaNsZ_iOzwRdBLCsEa9crZU9dXTQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdehfeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkjghfofggtgfgsehtjeertdertddvnecuhfhrohhmpeetlhgvgicu
    hghilhhlihgrmhhsohhnuceorghlvgigsehshhgriigsohhtrdhorhhgqeenucggtffrrg
    htthgvrhhnpeekheejieetffefueeiteejtdejffdvleelvdeuvdffvdefteeghfevkeeu
    vdefvdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomheprghlvgigsehshhgriigsohhtrdhorhhg
    pdhnsggprhgtphhtthhopeekpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehtvg
    gulhhoghgrnhesfhgsrdgtohhmpdhrtghpthhtohepughmrghtlhgrtghksehgohhoghhl
    vgdrtghomhdprhgtphhtthhopehshhhurghhsehkvghrnhgvlhdrohhrghdprhgtphhtth
    hopehkvhhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidq
    khhsvghlfhhtvghsthesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlih
    hnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehm
    rghtthgvvhesmhgvthgrrdgtohhmpdhrtghpthhtoheprghlvgigsehshhgriigsohhtrd
    horhhg
X-ME-Proxy: <xmx:Ui27aeWhHXg7bCl1XS9AsdsDI10b-RRCqXro8ppZkX3oWGJEVtPRgQ>
    <xmx:Ui27aXeBSyCYZSYu0h0ecmOgI6h_GegBzUdpf01A11lMPDE6Je_gjA>
    <xmx:Ui27aSK_ty8f99GquUZcVvpJz14fvgoHvE46qoFXfkaWL7dbzhPvHA>
    <xmx:Ui27aUwdzZdJHxIKMVfb3Gqhp8e9Vyjk5gQTEHCZU8AYtUIqCkuwSg>
    <xmx:Uy27aZOAAwAVwfvAoiZTNyG3IojoVRpblUeE6d4SxexZocuC2wmh20av>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Mar 2026 18:55:14 -0400 (EDT)
Date: Wed, 18 Mar 2026 16:55:13 -0600
From: Alex Williamson <alex@shazbot.org>
To: Ted Logan <tedlogan@fb.com>
Cc: David Matlack <dmatlack@google.com>, Shuah Khan <shuah@kernel.org>,
 <kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, Matt Evans <mattev@meta.com>,
 alex@shazbot.org
Subject: Re: [PATCH] vfio: selftests: Build tests on aarch64
Message-ID: <20260318165513.49c3830d@shazbot.org>
In-Reply-To: <20260317-vfio-selftests-aarch64-v1-1-2266077563e7@fb.com>
References: <20260317-vfio-selftests-aarch64-v1-1-2266077563e7@fb.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 17 Mar 2026 16:25:18 -0700
Ted Logan <tedlogan@fb.com> wrote:

> Also build vfio self-tests on aarch64 variants, in addition to arm64 and
> x86_64.
> 
> Reported-by: Matt Evans <mattev@meta.com>
> Closes: https://lore.kernel.org/all/e51b4ff2-13c4-47d4-b781-3dcbd740d274@meta.com/
> ---
> Signed-off-by: Ted Logan <tedlogan@fb.com>

Careful, this is a good way to get your Sign-off lost in the tooling.

> ---
>  tools/testing/selftests/vfio/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/vfio/Makefile b/tools/testing/selftests/vfio/Makefile
> index 8e90e409e91d..98bc8d6271a4 100644
> --- a/tools/testing/selftests/vfio/Makefile
> +++ b/tools/testing/selftests/vfio/Makefile
> @@ -1,4 +1,4 @@
> -ARCH ?= $(shell uname -m)
> +ARCH ?= $(shell uname -m | sed -e 's/aarch64.*/arm64/')

Are we intentionally enabling aarch64_be with this glob or is that just
carry-over from similar in the mm selftest Makefile?

Big endian ARM64 support is really not on my radar for vfio, but it
wouldn't be our first foray into big endian systems.

If it wasn't intentional, maybe just add "aarch64" to the below filter
list directly.  Thanks,

Alex
 
>  ifeq (,$(filter $(ARCH),arm64 x86_64))
>  # Do nothing on unsupported architectures
> 
> ---
> base-commit: 96ca4caf9066f5ebd35b561a521af588a8eb0215
> change-id: 20260317-vfio-selftests-aarch64-636abf0f7674
> 
> Best regards,

