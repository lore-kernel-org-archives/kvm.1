Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C82352C58;
	Fri, 20 Mar 2026 21:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774041561; cv=none; b=mv/4vzQ3yB7xl8lteW2CrG3wAb6jo3uubFQsL4ej/GDHGoVWbuVnL6MB/+ALzj7C+gHSM+b9Af/PQ5aZhGv5VerG3MmIBCf6A953Tg/2EQgP9TWcH/3kCo1GGJfgBca/f3Kaci6vgE4oQSb4WBMrDrSxj47uebwLk7n7/XcyWjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774041561; c=relaxed/simple;
	bh=cHPxWmUQCW0OGjONm+0ATWYFHtiKrwFaP74Jw2QvcUk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uJNlsoRRXGO0W6MdchzAO+lrskFbfz/063SMG78TmSvrehLFfY5Km6tnxItFrTXS4napSZM1sf2rYytotsvpoxw4v6avwVoW63HJ5B4tpJOsneB1jwAse5hqLF/c8g7WT9eLLb9k4BL0hND41ZvzrrFrRxYYShqCNwbQ6q1TswE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=ThMDAt8p; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=217cv47C; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="ThMDAt8p";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="217cv47C"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 02FF51400275;
	Fri, 20 Mar 2026 17:19:14 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Fri, 20 Mar 2026 17:19:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1774041553;
	 x=1774127953; bh=7OkcGIC7RuGIkDJJhjm7ZPFlO126MQ8vzH/zf/jBsS4=; b=
	ThMDAt8pIWL0Ccyj8Yug95ofcvtR+lXloze2l+HX5NEbDV7g0wIk/S3TdRovKnwp
	kTR78qpS6D795xCo43yWJEwiAPnl1cjwgs/PPGxdeXtwv2mJ2vo6YvdNSbTx/d+2
	N8ErCgVC0TkAnheqzcBeWZ9eQGEotAxXvDiAssqeCbKjJs86ouBBYwZ4TY2xgcde
	xGU23Wf2LQC0I6HIxKh2sVGLz49UxpaPZVCj5QTtUCnjwvZuh7kcknkbhPLqN5Z3
	MreE1dtthcjEAdJ2Um1Sl1TVJbGbd09Iws9k1YjL4n9IJSmpMlH1sVjiqqV3Juh9
	OccGCM0Aj6lY2hNDh0cPRQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1774041553; x=
	1774127953; bh=7OkcGIC7RuGIkDJJhjm7ZPFlO126MQ8vzH/zf/jBsS4=; b=2
	17cv47CMxWHPzE4oWrWhuDFse0IJtbq8ZsAPkSTkYqNgqgZ4q3aC+X1DRa7aPpUa
	27w4YuOQpJZrrcc8gp4ur7e+PCDVEM8dEpRJOTvLmVOr0PyCG0vq7w4DCjVrKr0s
	2onJGITU9VsvYPveW2r5DhI3oWXvm4gF7FqSv4qVZJmwoU3vPdAGZPH4r034O6Uy
	EX61Px/KediXmtGgsPPq9930eFwWt0FbFAC2f1oDUb+blU3UqmAWNI/yH3CNRvHb
	nBpam32sQOPLoZBZETmXM02M+QlTdiOPyeSbnfdtTUGrinHlJSPNogenvIhDYGNb
	7fr9eoEPC210k0sIlNesQ==
X-ME-Sender: <xms:0bm9aREm-SKE6oS_yYz57Lmgq9t6oKoUZkfpBLii0xTJTgiKy6VuxQ>
    <xme:0bm9aSV5rHLIUNZQrf6IxtjE5UnBp4wBBwuEbpAhQtxYiZ_c5owvXvh5bJi6PUG0t
    9IuI5UfALKBNDl2rb57_bVwNPn7TeL80o9wJ9CEPPyhgtDBG5mf>
X-ME-Received: <xmr:0bm9aVUjJg_fFwz3PB7vFLBXCvc_tMOOEPTiRkM2aICYu3I4xkqH2CCVL2c>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefuddtleejucetufdoteggodetrf
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
X-ME-Proxy: <xmx:0bm9aYJJCzJ8UXM1ngmQ4qCad5k5R0doEvt_Qs9JL58o0vixDjcsmQ>
    <xmx:0bm9aVDtznl4DN1HWuakQLrLgyuPUMqT_hkRAkv8yq6eYUBWveSYmw>
    <xmx:0bm9aYegnfnnTGE_tYthak5_HnLjnhQhunKW1Lg91XQEZEC_sif5xg>
    <xmx:0bm9aU3TSnZhtbYpP70hIYTOVyPyAWIqu53trwSXJR9hxqLD4iq8Qg>
    <xmx:0bm9abEDNihA-VLp__ukacEHsFRWmZtlxuOIZsqZjTd0MbDU9EtDDudv>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Mar 2026 17:19:13 -0400 (EDT)
Date: Fri, 20 Mar 2026 15:17:04 -0600
From: Alex Williamson <alex@shazbot.org>
To: Ted Logan <tedlogan@fb.com>
Cc: David Matlack <dmatlack@google.com>, Shuah Khan <shuah@kernel.org>,
 <kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, Matt Evans <mattev@meta.com>,
 alex@shazbot.org
Subject: Re: [PATCH v2] vfio: selftests: Build tests on aarch64
Message-ID: <20260320151704.4cff8a83@shazbot.org>
In-Reply-To: <20260319-vfio-selftests-aarch64-v2-1-bb2621c24dc4@fb.com>
References: <20260319-vfio-selftests-aarch64-v2-1-bb2621c24dc4@fb.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 19 Mar 2026 15:58:47 -0700
Ted Logan <tedlogan@fb.com> wrote:

> Fix vfio selftests on aarch64, allowing native builds on aarch64 hosts.
> 
> Reported-by: Matt Evans <mattev@meta.com>
> Closes: https://lore.kernel.org/all/e51b4ff2-13c4-47d4-b781-3dcbd740d274@meta.com/
> Fixes: a55d4bbbe644 ("vfio: selftests: only build tests on arm64 and x86_64")
> Signed-off-by: Ted Logan <tedlogan@fb.com>
> ---
> Changes in v2:
> - Add aarch64 to the list of allowed architectures, rather than trying
>   to maintain a new architecture substitution.
> - Update wording of commit message.
> - Link to v1: https://lore.kernel.org/r/20260317-vfio-selftests-aarch64-v1-1-2266077563e7@fb.com
> ---
>  tools/testing/selftests/vfio/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/vfio/Makefile b/tools/testing/selftests/vfio/Makefile
> index 8e90e409e91d..0684932d91bf 100644
> --- a/tools/testing/selftests/vfio/Makefile
> +++ b/tools/testing/selftests/vfio/Makefile
> @@ -1,6 +1,6 @@
>  ARCH ?= $(shell uname -m)
>  
> -ifeq (,$(filter $(ARCH),arm64 x86_64))
> +ifeq (,$(filter $(ARCH),aarch64 arm64 x86_64))
>  # Do nothing on unsupported architectures
>  include ../lib.mk
>  else
> 
> ---
> base-commit: 96ca4caf9066f5ebd35b561a521af588a8eb0215
> change-id: 20260317-vfio-selftests-aarch64-636abf0f7674

Applied to vfio next branch for v7.1.  Thanks,

Alex
