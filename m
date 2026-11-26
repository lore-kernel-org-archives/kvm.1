Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.156
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795672188;
	b=EBHbHq8GAklWqFXX/CZ0vzgY7QMMSbTaA4+qxfhpubyHL9+mlnBenTAXaqN9tlRzV50i
	 x44HCX9MZOwNprvdKVBq3ANWh8a1B2KLbj8qJ46HA43o84afjaWjRBYkdZhQ0l0BGP1It
	 XwmUK+bJ569fsM0JLn+f6LYS3ZmsXpg3elYRLkFlWCp+UI/6LUznDScH+cV/Gs/wWq82e
	 NA3BCEzPGmhRrOWM539ZiRKZ4I/f9Lc9XeW542rcllcmmI7ApmeGk2xfetzIoP0+KAORk
	 8V196XHKOjXlPYuo3ukHcVScxCHBOZ8oyvbL3e3uqCFm0HmYQidxCrvzfhH1gzXtzaw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795672188;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 X-Mailer:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=1W6L+i1ya/wzwT/1nNyBP+WJhxgFXbjhgpBiEoeaWAs=;
	b=pt0E2/5RJ9nD0GHv8RMgWRL0W6SAKTEfL6X3HzdWvABK+Fj6A9zZWtBxE/jOpvmXl+TS
	 ZLr6lv9Ue1TQJbTbno+aGmh9XjQUdh25VcfigzLMiYsAPErdRiqO3FN0w4FQ3q79bNjCl
	 y47xOpRZxPRJxT52uGbGJnRfc4F11JXe2Rrel5jnjIzLVZgjIlQ9CZvGitxDYaBU+2DP6
	 Lc4telu6j6INCN/MgFlvIRu7QnoSNw+623xlh/Zh2o5sLyrxqN8JNrLmM/LpY2D59HvLA
	 W2ds2cjF+UhCPCWCqvR/Jwhdz0QG/nwO7gK8G/s81OCxjl5wVRSIvjIP+IBYPv99m9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=shazbot.org;
	spf=pass smtp.mailfrom=shazbot.org;
	dkim=pass header.d=shazbot.org header.i=@shazbot.org header.a=rsa-sha256 header.s=fm2 header.b=ryGBWt3E;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=gHJcbjSZ;
	arc=none smtp.remote-ip=202.12.124.156
Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A11B606A336
	for <kvm@vger.kernel.org>; Thu, 26 Nov 2026 05:49:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0A11B606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=shazbot.org header.i=@shazbot.org header.a=rsa-sha256 header.s=fm2 header.b=ryGBWt3E;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=gHJcbjSZ
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 5A8B37A059D
	for <kvm@vger.kernel.org>; Thu, 26 Nov 2026 00:49:47 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Thu, 26 Nov 2026 00:49:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1795672186;
	 x=1795758586; bh=1W6L+i1ya/wzwT/1nNyBP+WJhxgFXbjhgpBiEoeaWAs=; b=
	ryGBWt3EXag1TZJMq8JNqgjJVl+IKj8hodd8zhZWzmXk2Yv70ncN1X0scQ2e9jBh
	ziE18fSBa5e0v323/06unthZ01SScriQl0m/ZWE4zfPibhqdikIsOtA3x6NURKgf
	Va5ZuwWNTclZQiYeGMTMPPnbv58CyN4rDGazS5bwH6yMvztGRDyCRyZh5Ir7Tjmp
	sB/FUrXbyiQ80TUTxZdGVhsXt1dDlqqj48ujy0l8db2BxzZzSWhZcshU5NUg1Mpa
	0mWTK8rZFIZjhmOiZrWA8nJpjBFN7heyu2ycAwrr0UnWaHqsvpS8JU3BeUqRwITq
	AfzkHc+aJbwk0Z398iN5fA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1795672186; x=
	1795758586; bh=1W6L+i1ya/wzwT/1nNyBP+WJhxgFXbjhgpBiEoeaWAs=; b=g
	HJcbjSZ5655q7bVAmnnxHwz8wvFb+WENI702j4ZwEPZ2eCZEN5HcNorCCUHYOBmE
	pai52YIgXBR+ldDcdQtLBY0NQka7O6ZJkS9/MORi+77tmiBxeuwDuRHzeaVjZFUl
	FH8blUGrjpRnIBEixGwvXquf/uS0Hy6DSbicw6l8I3tJufQFu9XaiIdN4iC8kXuO
	VU4dRyWwnqp4bXWhnthDWktxfxhTow62EFLj3hx4U9Ho+B9I87NLvI4tNMIqcRXY
	9Kw/Lnv5oJDuZKeXZhURfe4kXYHXcUj2rBS5/brgoGefK0iFRcNGLBgt+ycesoxl
	KjXDvqkTlJvH9eMsyDfqQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=shazbot.org a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795672186; d=shazbot.org;
	mf=PGFsZXhAc2hhemJvdC5vcmc+; rt=PGt2bUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:OHbxR6J4XZHRlRleZloV9FIm3SqcLfAziiZioD/Io3UZjq/
	SoPxWSNWUTUmqTBBtTtUnPOBNv0sd/9uTFU5duwep2BnmXYwUBCZszzoNfyISdQp
	XljfiB/hR5K00IyV+yizvTDKa2is47oCyOPlA3hegfQHqMC/B74qd71i1LzC+J0Z
	zqFNikWCSJd1CDt+pvf9AbSXWGE+pTwXibtUAM91VmG2XE7iiRrCjS4wHm9G2FPt
	q2v/ZqxzRLXK9m/3vnoQf+8MQVXRSziTbSlFCVgrMZ65OU1Gt55ijLQvRIf5iDCP
	YR/inDDm14EVZgLv4ENjP36boCP2OYwuFnYwP7g==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:C0hImMyGxrE1I0Kz68j2mZds+cnNl5tUlkLv7KyNWaY=:3RlotjlO5quFf8BGEXED9YG7/vj/m1a0KVBAh5LlnYE=;
X-ME-Sender: <xms:esgHa0T9_yBmLrfrbPXS0dHoGRfJ-BX3kVAZL_znzrnKAN_EVkN0tA>
    <xme:esgHa71Nh8_afcEL7F4IYWCfWV6HxrBbOOr7YmR0ZeAW-3TgvT18g578HuuPxU-E8
    Lu1hK4-m-2z0Ey5bHx7oC37Y8--gcMJaLPp4sQNaQlj1rmcMxM_DTg>
X-ME-Received: <xmr:esgHaxtDivDMcCOx6ZPqJgFqPb64G6iXu4bREVZtkF6F_NJl8UvyNqIEM255Cw>
X-ME-Proxy-Cause: dmFkZTGB8bAKoiZT8MxoI2vUeizcn7RM+st9/dAvmudZJ36Y+ID/SvAOGeEBPbS0olLyXS
    y0dialytkk3ZbY+yVsRTYrUVD4wmo/Z33g895KePOE6bev6TLG/6L9Uew1xZk5Vf1TpdvW
    r3Vwrznm4WG7WLnGOWxckovGjRVYrUfPjo/kJODfwIFMrB0C+Sh7OSG1yalOfetdGLn353
    DSurEgKG4DYQhcCKKQvXrxEXv2nW+16bqK+BS4fkkMkVuWn0wT4mAedowLrcSD2hLWyix/
    81ZZIch1lkCDD5oYPGI6rUHcuJ7Yk3P2SgflCnj8rALmpuuRG5GlGrLbvkBF9F31BmdycI
    9sCL9jMurTOZSCwWUG1LGp442y7vhVoZ5dctpj30Y/WOOMbfMkY7OjreXadMC+n4Z+HBeR
    jH7lNAL4qdpWcQ3A9iDEbMEEbjKjqAyf/AbQvHGfh+fTKASFeDOBdNFKTcY87PIJBf03Cc
    mAbw1sQL/aNEd8kba7mDfNCCt6zfJ32xDy8eHfL2mUWohWNUyInLCxOGNeid+xUOvi5LE8
    lhWc8KPGQ/OttYBZTa1kZuHrEZ6bnyw33bj/hstcUFmWKVsO7+ZDUfy/3WlIzsDglNr+1g
    hBGtN8W7k9Bfc/uhvAegkooNBDBKq5HomUwdEYslm8MKsrgfnGQQRYx9mkGA
X-ME-Proxy: <xmx:esgHa5jPdXgaSpUu0--CUPlDUSFI-305FrCs8L4boFtEZ0D0rXqFTQ>
    <xmx:esgHa6-xWOax3o0dhmRF3qjMQgCtp3ZSDI3AnRqeck62dCOIVioDaw>
    <xmx:esgHa0v_o8cVp4F2ynfqFS9_sPaOyr__omZq1fQaN9MmqE-XEJJ3jw>
    <xmx:esgHa2qjk-P8ZPGf7QqQ-C7142ljiP-6DyStqM12GUbyPkQWggxBQA>
    <xmx:esgHa3NFhRRLxJWVjbf7iwKnTCdkPzf9Q3LMd3KQCxUJJQSSplrAEtnZ>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Nov 2026 00:49:45 -0500 (EST)
Date: Wed, 25 Nov 2026 22:49:14 -0700
From: Alex Williamson <alex@shazbot.org>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: David Matlack <dmatlack@google.com>, Shuah Khan <shuah@kernel.org>,
 kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, alex@shazbot.org
Subject: Re: [PATCH v3] vfio: selftests: Remove libuuid dependency
Message-ID: <20261125224914.0730097c@shazbot.org>
In-Reply-To: <20261103220337.3578111-1-skhawaja@google.com>
References: <20261103220337.3578111-1-skhawaja@google.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  3 Nov 2026 22:03:37 +0000
Samiullah Khawaja <skhawaja@google.com> wrote:

> Replace libuuid with a minimal uuid_t and uuid_parse() in libvfio, and
> drop -luuid from the build. libvfio only uses libuuid to parse VF
> tokens, so pulling in an external library is not worth it.
> 
> libuuid is often missing from cross-compilation sysroots, which causes
> the VFIO selftests to fail to link:
> 
>   ld: cannot find -luuid: No such file or directory
> 
> It also complicates building against glibc alternatives such as musl, see
> https://lore.kernel.org/kvm/c2f7e904-2646-4b01-864d-d185221c7f56@gmail.com/
> 
> Reviewed-by: David Matlack <dmatlack@google.com>
> Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
> ---
> 
> v3:

Applied to vfio next branch for v7.5.  Thanks,

Alex


> - Reword the changelog and drop the testing note from it (David)
> - Move the libuuid comment to uuid.h and explain how it differs from
>   the kernel API (David)
> 
> v2: https://lore.kernel.org/all/20261102200624.1570562-1-skhawaja@google.com/
> - Move the parser to lib/uuid.c and lib/include/libvfio/uuid.h (David)
> - Drop the vfio_ prefixes and add a uuid_t (David)
> - Mention musl in the commit message (David)
> 
> v1: https://lore.kernel.org/all/20260925013110.3447626-1-skhawaja@google.com/
> ---
>  .../selftests/vfio/lib/include/libvfio.h      |  1 +
>  .../selftests/vfio/lib/include/libvfio/uuid.h | 16 +++++++
>  tools/testing/selftests/vfio/lib/libvfio.mk   |  3 +-
>  tools/testing/selftests/vfio/lib/uuid.c       | 42 +++++++++++++++++++
>  .../selftests/vfio/lib/vfio_pci_device.c      |  2 -
>  5 files changed, 60 insertions(+), 4 deletions(-)
>  create mode 100644 tools/testing/selftests/vfio/lib/include/libvfio/uuid.h
>  create mode 100644 tools/testing/selftests/vfio/lib/uuid.c
> 
> diff --git a/tools/testing/selftests/vfio/lib/include/libvfio.h b/tools/testing/selftests/vfio/lib/include/libvfio.h
> index 07862b470777..e9d513c3a08e 100644
> --- a/tools/testing/selftests/vfio/lib/include/libvfio.h
> +++ b/tools/testing/selftests/vfio/lib/include/libvfio.h
> @@ -6,6 +6,7 @@
>  #include <libvfio/iommu.h>
>  #include <libvfio/iova_allocator.h>
>  #include <libvfio/sysfs.h>
> +#include <libvfio/uuid.h>
>  #include <libvfio/vfio_pci_device.h>
>  #include <libvfio/vfio_pci_driver.h>
>  
> diff --git a/tools/testing/selftests/vfio/lib/include/libvfio/uuid.h b/tools/testing/selftests/vfio/lib/include/libvfio/uuid.h
> new file mode 100644
> index 000000000000..5c4ebe5ae3d3
> --- /dev/null
> +++ b/tools/testing/selftests/vfio/lib/include/libvfio/uuid.h
> @@ -0,0 +1,16 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +#ifndef SELFTESTS_VFIO_LIB_INCLUDE_LIBVFIO_UUID_H
> +#define SELFTESTS_VFIO_LIB_INCLUDE_LIBVFIO_UUID_H
> +
> +/*
> + * Minimal replacement for libuuid's uuid_t and uuid_parse(). These mirror
> + * the libuuid API, not the kernel's: uuid_t is a byte array (not a struct)
> + * and uuid_parse() fills it in place (it does not take a uuid_t pointer).
> + */
> +#define UUID_SIZE	16
> +
> +typedef unsigned char uuid_t[UUID_SIZE];
> +
> +int uuid_parse(const char *in, uuid_t uu);
> +
> +#endif /* SELFTESTS_VFIO_LIB_INCLUDE_LIBVFIO_UUID_H */
> diff --git a/tools/testing/selftests/vfio/lib/libvfio.mk b/tools/testing/selftests/vfio/lib/libvfio.mk
> index eff95828719e..d1d1b2b05af1 100644
> --- a/tools/testing/selftests/vfio/lib/libvfio.mk
> +++ b/tools/testing/selftests/vfio/lib/libvfio.mk
> @@ -7,6 +7,7 @@ LIBVFIO_C := iommu.c
>  LIBVFIO_C += iova_allocator.c
>  LIBVFIO_C += libvfio.c
>  LIBVFIO_C += sysfs.c
> +LIBVFIO_C += uuid.c
>  LIBVFIO_C += vfio_pci_device.c
>  LIBVFIO_C += vfio_pci_driver.c
>  
> @@ -30,8 +31,6 @@ $(LIBVFIO_O_DIRS):
>  
>  CFLAGS += -I$(LIBVFIO_SRCDIR)/include
>  
> -LDLIBS += -luuid
> -
>  $(LIBVFIO_O): $(LIBVFIO_OUTPUT)/%.o : $(LIBVFIO_SRCDIR)/%.c | $(LIBVFIO_O_DIRS)
>  	$(CC) $(CFLAGS) $(CPPFLAGS) $(TARGET_ARCH) -c $< -o $@
>  
> diff --git a/tools/testing/selftests/vfio/lib/uuid.c b/tools/testing/selftests/vfio/lib/uuid.c
> new file mode 100644
> index 000000000000..906a5db70ce1
> --- /dev/null
> +++ b/tools/testing/selftests/vfio/lib/uuid.c
> @@ -0,0 +1,42 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +#include <string.h>
> +
> +#include <libvfio.h>
> +
> +#define UUID_STRING_LEN	36
> +
> +static int hexval(char c)
> +{
> +	if (c >= '0' && c <= '9')
> +		return c - '0';
> +	if (c >= 'a' && c <= 'f')
> +		return c - 'a' + 10;
> +	if (c >= 'A' && c <= 'F')
> +		return c - 'A' + 10;
> +	return -1;
> +}
> +
> +int uuid_parse(const char *in, uuid_t uu)
> +{
> +	const char *p = in;
> +	int i, hi, lo;
> +
> +	if (strlen(in) != UUID_STRING_LEN)
> +		return -1;
> +
> +	for (i = 0; i < UUID_SIZE; i++) {
> +		if (i == 4 || i == 6 || i == 8 || i == 10) {
> +			if (*p++ != '-')
> +				return -1;
> +		}
> +
> +		hi = hexval(*p++);
> +		lo = hexval(*p++);
> +		if (hi < 0 || lo < 0)
> +			return -1;
> +
> +		uu[i] = (hi << 4) | lo;
> +	}
> +
> +	return 0;
> +}
> diff --git a/tools/testing/selftests/vfio/lib/vfio_pci_device.c b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
> index 4063a0e2b3df..4ae6ac1f8ed8 100644
> --- a/tools/testing/selftests/vfio/lib/vfio_pci_device.c
> +++ b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
> @@ -23,8 +23,6 @@
>  #include <linux/types.h>
>  #include <linux/vfio.h>
>  
> -#include <uuid/uuid.h>
> -
>  #include "kselftest.h"
>  #include <libvfio.h>
>  
> 
> base-commit: 2637bdec0535a2044cd830eba9a79363651d9043

