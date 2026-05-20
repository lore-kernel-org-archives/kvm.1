Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7226237B003;
	Wed, 20 May 2026 21:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779311548; cv=none; b=bI9hxPNunQB8Z79XP+u1Gch0wUgScVRS7aL7EljBbgu9Q7eq0R1L0TAICDeQfNGnt2HMHvWRvj5RjXfy/wPOJk17/Hdd9yryagazyNZmmTig9KBN4T9yqCZy4ogn5zRed44L8xg2voOFwnolCcuk9Tmr5P8Puup3iKsZtqKICEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779311548; c=relaxed/simple;
	bh=C+IAh/zF8A6o6VJMSDEQF7SPq97C79ZPz4Ro4qwIidc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s2rGbgbaGU8HRFpd9Ny//FfMSaY67+5JK7Ju5Vixxc/YJng07+b6HYZOntl3jTDaEfkO6c+xghc6knIGZWQPGuNiIgmK3Bwf2/dGiiPzAxrHnY2MkDMhgnos9ys6HsBViz8ervDBQ6smeOebyOYKBf0n+dGFOyf01v1V8C5WLYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=QANcxtUE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=okXLuzBJ; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="QANcxtUE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="okXLuzBJ"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 98E0B1D00084;
	Wed, 20 May 2026 17:12:25 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Wed, 20 May 2026 17:12:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1779311545;
	 x=1779397945; bh=27HQMtNLOynHli6ERCsKSkX1nDFg7At34kuyLTNI1Ug=; b=
	QANcxtUEczrd0Sjmr1WlgtTo9VA4dD6mRys0mFQPYJToVlA3rhPNArgYHYMAeSkQ
	o3bxgM6IndwumXDSHrigXxrRn5Y1xeo2RyhVE1enJO8tYlKrVC0W8uIHt3qCrAVW
	qxaYBmZrVVL/Ytaj38dv+uxf4keoc27iy47MbwEfKXwRXt9sdJpL5N/gbgaiZKtb
	gZ1P7FNnaKdakOF1W8cEha8sX/CaX2u7rYcMCnj7YST+c73Mp0hIBDX4WCxHc+hg
	FZQXiAjcm1y/+Otf3vCzNQo7gZ7yS5A8g5TN/Okch5j5kVKqYFKOipZfFNqrJ4r7
	6ZVMnzEfv3NEgby+AkQ14Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779311545; x=
	1779397945; bh=27HQMtNLOynHli6ERCsKSkX1nDFg7At34kuyLTNI1Ug=; b=o
	kXLuzBJ6KeXlmKhKV6WeRuq7xsO9g4et2y9WuWRAwwb6H/sR73zuSOmkadQI0FH6
	TjIrthnqL3PPSesvUKNrtCp/r0IkWq5q+urV0r0HNEiG/snS/5InOlj1RYnbSoJK
	JTes66CaZ2aXfbb1tfY8PN5QPKto4zhhep9mtlr5TYjCE7Ai1ZYFNYWfFUa1t4QN
	Fy4ov5vo6oDAjkt/vcNhB2lkTe8arLESFb8t1b8THTyKVNXxIriDHgdxR9ptGbuN
	zcM8F76M4kKszFiA0bfyksV5z5TqzTRc6OH3nLBf5U1OjytXKV1xJLLb6Ug6ETj/
	/QpBAz5htZPdydiJu9ppQ==
X-ME-Sender: <xms:uSMOai3M6HqiMniW4sFhTrcT4Mu9h0fTiRmCFvMGXo5ol6eRKBhGUQ>
    <xme:uSMOampZEoXyAU7To0R2bJ6yS0zcT5GvlmiOoDSHqHgtUM1MktnjGJVHsba0TBRMG
    8oCAKicJ-ZYzGOaR0ucmi5UT8DG-8q5dsVeUGoa9sSWpU-o3zBbqA>
X-ME-Received: <xmr:uSMOahM1qfYTlIO-UuOsEcy4k24QQWWHdw4WiAMRO3aVy5R4kwLcewISzwg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugeehieekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkjghfofggtgfgsehtjeertdertddvnecuhfhrohhmpeetlhgvgicu
    hghilhhlihgrmhhsohhnuceorghlvgigsehshhgriigsohhtrdhorhhgqeenucggtffrrg
    htthgvrhhnpeekheejieetffefueeiteejtdejffdvleelvdeuvdffvdefteeghfevkeeu
    vdefvdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomheprghlvgigsehshhgriigsohhtrdhorhhg
    pdhnsggprhgtphhtthhopeelpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegumh
    grthhlrggtkhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepkhhvmhesvhhgvghrrdhk
    vghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrd
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkshgvlhhfthgvshhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshgvrghnjhgtsehgohhoghhlvg
    drtghomhdprhgtphhtthhopehshhhurghhsehkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehtvggulhhoghgrnhesfhgsrdgtohhmpdhrtghpthhtohepjhhgghesnhhvihguihgrrd
    gtohhmpdhrtghpthhtoheprghlvgigsehshhgriigsohhtrdhorhhg
X-ME-Proxy: <xmx:uSMOavrj5OadnJR-ao3r8Pwc-nt1WTKtyD2OD2ZSBG4XUEduwwpXfQ>
    <xmx:uSMOasuuNBv61T4ZOda81iNWQGL1Fka1aCg-LiRAF4uyY2FuapP22w>
    <xmx:uSMOam2munPrYAnboMvp5Yh5fo1lVE0G-807V48W_nnP73ZmKDeY_w>
    <xmx:uSMOavFBfcM7lAerojsc-SnUOqkuicbBrVNlOYcH4xvfO2NkEqMcCw>
    <xmx:uSMOardU4Mawwk-3-4qoQakVKfaf8cVORb4qdyyhKVn6G-Ybma0PNHa0>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 20 May 2026 17:12:24 -0400 (EDT)
Date: Wed, 20 May 2026 15:11:58 -0600
From: Alex Williamson <alex@shazbot.org>
To: David Matlack <dmatlack@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Sean Christopherson <seanjc@google.com>,
 Shuah Khan <shuah@kernel.org>, Ted Logan <tedlogan@fb.com>, Jason Gunthorpe
 <jgg@nvidia.com>, alex@shazbot.org
Subject: Re: [PATCH] vfio: selftests: Allow builds when ARCH=x86
Message-ID: <20260520151158.37f13c20@shazbot.org>
In-Reply-To: <20260428232707.2139059-1-dmatlack@google.com>
References: <20260428232707.2139059-1-dmatlack@google.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 28 Apr 2026 23:27:06 +0000
David Matlack <dmatlack@google.com> wrote:

> Allow builds when ARCH=x86 since the top-level Makefile can set ARCH=x86
> even for 64-bit x86 builds.
> 
> Note that ARCH=x86 could also indicate a native build on a 32-bit x86
> host. However, it doesn't seem like anyone is building selftests
> natively on 32-bit x86 hosts these days since KVM selftests allow
> ARCH=x86 and fail to compile on 32-bit x86.
> 
> If someone reports an issue on 32-bit native builds we can harden the
> KVM and VFIO selftests to explicitly check 64-bit (see the discussion in
> the Closes link below).
> 
> Fixes: a55d4bbbe644 ("vfio: selftests: only build tests on arm64 and x86_64")
> Reported-by: Jason Gunthorpe <jgg@nvidia.com>
> Closes: https://lore.kernel.org/kvm/20260427231217.GA1670652@nvidia.com/
> Signed-off-by: David Matlack <dmatlack@google.com>
> ---
> Cc: Sean Christopherson <seanjc@google.com>
> 
>  tools/testing/selftests/vfio/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/vfio/Makefile b/tools/testing/selftests/vfio/Makefile
> index 0684932d91bf..40165d087a0b 100644
> --- a/tools/testing/selftests/vfio/Makefile
> +++ b/tools/testing/selftests/vfio/Makefile
> @@ -1,6 +1,6 @@
>  ARCH ?= $(shell uname -m)
>  
> -ifeq (,$(filter $(ARCH),aarch64 arm64 x86_64))
> +ifeq (,$(filter $(ARCH),aarch64 arm64 x86 x86_64))
>  # Do nothing on unsupported architectures
>  include ../lib.mk
>  else
> 
> base-commit: 2a4c0c11c0193889446cdb6f1540cc2b9aff97dd

Applied to vfio next branch for v7.2.  Thanks,

Alex
