Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C36CB8634C;
	Mon,  6 Apr 2026 21:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775509960; cv=none; b=pc8t4wExBD2hbHHRCuJiNwneY2Oz7MexMTqs7kunPx87oSBVRWAbeWpL4u28vuTT4jXqP5OWFqQtHt8O8zwGCCrE4QswrwG0rBe6Uz/rFgZ+XTGbbd+EGFU92J7w5q2u1vdIzIAB884D6rCQCa7e2Sy5aYg2p1O0tMzGpgLyNas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775509960; c=relaxed/simple;
	bh=B4+VxGv1IXNMLvlNQ4SsgQN1RpDOsyAqdMUm/Zu/8rE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hJZPoIB5Wkv2jIrtv/+PopDMyvQtGXGIy7XpaL09FYzf4i7k6AdhRxDyjox7gW1UsnAsLLhWF04HSVsRezuGVgh0CpwKJEtxdX7CVYUT5o4Z3C3JOKVewf2crQDU5TxVW1FLYZcmfYRx8Rca4m3BuKTNGwRVVX2WdoqQ5EAUHwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=B8a0vD9g; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AkKiTN9u; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="B8a0vD9g";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AkKiTN9u"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 0E3F2EC000B;
	Mon,  6 Apr 2026 17:12:37 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 06 Apr 2026 17:12:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1775509957;
	 x=1775596357; bh=GkID6dnoYCY0W416Khudkh9brOmkcz8bvqZa8HVsuMM=; b=
	B8a0vD9g4F1F/DNsKS2aBs14yD1aop6Sh0o3vrscVuLcpSfTLStBbZFx1D/CrHPF
	vZgPM6WqYLV40fbpqJQb86VhHnkAF7xyYUCcP8UI9nLBa+WoX2RrEiPcHxBhBup6
	yC1wSGg1v9oLzX4Nv3e8Cg0HxwcJbQI2C8oiPBgcdUhSczSE3UXtn+vR0ePSMkV5
	RCwfLcK9vLjr5yWC5Fk4zr36KZFUkg3b/ViMb+TjGwsuWg4l/xwSI3NWTn1bgttV
	Ymumuz9H+zp6DTHdrR9yotZYTEw2K3LgSlpsOwyzDBfRlVDGKQGV0RZZVUaa7XyV
	annvYtNXxtwXO5m/H1NYAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1775509957; x=
	1775596357; bh=GkID6dnoYCY0W416Khudkh9brOmkcz8bvqZa8HVsuMM=; b=A
	kKiTN9u5fH/dWSj3wFMl1HM+eEwG9NAw/XowCVIWoYNzxXktM6j7zlUsbLtC3Sc3
	6Vb9S03rYlDbqlqIOdJ9W1GQ/1LfY4r1bIHXOp38YvpFLvRRNlGt9qVur+SmHno/
	kqGPLBlVwB3HzaEYM6drd4BiRTZ4xghIx8YHjy4XoJSIIfQgsdHaE46mwcCtDEvr
	ib+/dt6ZtpU7VhogUeK/1pu9lnTPPhrn0wU0u5WQGT/lRad2eUO5Z7u8P08pJMy/
	9213lN08atxNnp/6R3tORdxgpve5xfoio7gWuF5fOynXt/QjgpLqUr6oDv1RFOWp
	gKrQwe8qnLhZG9L9UR0fw==
X-ME-Sender: <xms:xCHUaUyoI4GT-Jko_hpDce-DjzqoGeABZo5oAFE3yHAkaKaBWpPXRg>
    <xme:xCHUaY9eIqJHUsSY1b8JTApNp26CT62RggUFbJcGd7ZPc6mifBkdfFZWsr8IsQPJp
    42s4QJdE43UDrumohqlSNibojJhMxk3iy1BW-nJWDU5RWaR6ANQ>
X-ME-Received: <xmr:xCHUaUiRH19lOzsufkDKOxRUMkuNH0PsQY_nYltipKxDOKet-4eW7qCZwTA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddukeejlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfgjfhfogggtgfesthejredtredtvdenucfhrhhomheptehlvgigucgh
    ihhllhhirghmshhonhcuoegrlhgvgiesshhhrgiisghothdrohhrgheqnecuggftrfgrth
    htvghrnhepvdekfeejkedvudfhudfhteekudfgudeiteetvdeukedvheetvdekgfdugeev
    ueeunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hlvgigsehshhgriigsohhtrdhorhhgpdhnsggprhgtphhtthhopeejpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehrrghnrghnthgrsehgohhoghhlvgdrtghomhdprhgtph
    htthhopegumhgrthhlrggtkhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepvhhiphhi
    nhhshhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepjhhrhhhilhhkvgesghhoohhglh
    gvrdgtohhmpdhrtghpthhtohepkhhvmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopegrlhgvgiesshhhrgiisghothdrohhrgh
X-ME-Proxy: <xmx:xCHUaXHrpI0ua9dHdi3JMzAmXIUgZi72OlfxxONQ9z6gT65gs4K9bw>
    <xmx:xCHUab8gxvguet0fi6k5TuyCIuMI6zz90hYo-u_AX69oC_HQ1JWNHw>
    <xmx:xCHUaWyGRE6i3pSFwxVR8AGZGJ7ZHTRbCcpePYDaun8b5mIQpIsP0A>
    <xmx:xCHUafMBDwv-GRfui7QkusRohaUfwdiDTilx22WGjg1seRA_KWz5UA>
    <xmx:xSHUaVQtGhUSpRgsuaKUCxFBJrLT624zGpk2KgoEPXLXjcXJYTYpOHlM>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Apr 2026 17:12:36 -0400 (EDT)
Date: Mon, 6 Apr 2026 15:12:34 -0600
From: Alex Williamson <alex@shazbot.org>
To: Raghavendra Rao Ananta <rananta@google.com>
Cc: David Matlack <dmatlack@google.com>, Vipin Sharma <vipinsh@google.com>,
 Josh Hilke <jrhilke@google.com>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, alex@shazbot.org
Subject: Re: [PATCH v7 3/8] vfio: selftests: Introduce a sysfs lib
Message-ID: <20260406151234.7bbca348@shazbot.org>
In-Reply-To: <20260402173059.1018805-4-rananta@google.com>
References: <20260402173059.1018805-1-rananta@google.com>
	<20260402173059.1018805-4-rananta@google.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  2 Apr 2026 17:30:54 +0000
Raghavendra Rao Ananta <rananta@google.com> wrote:
> diff --git a/tools/testing/selftests/vfio/lib/sysfs.c b/tools/testing/selftests/vfio/lib/sysfs.c
> new file mode 100644
> index 0000000000000..f1e6889556527
> --- /dev/null
> +++ b/tools/testing/selftests/vfio/lib/sysfs.c
> @@ -0,0 +1,150 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +#include <fcntl.h>
> +#include <unistd.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <linux/limits.h>
> +
> +#include <libvfio.h>
> +
> +/* Enough to hold MODULE_NAME_LEN */
> +#define DRIVER_NAME_SZ 64
> +
> +#define readlink_safe(_path, _buf) ({				\
> +	int __ret = readlink(_path, _buf, sizeof(_buf) - 1);	\
> +	if (__ret != -1)					\
> +		_buf[__ret] = 0;				\
> +	__ret;							\
> +})

Not a current issue, but the use of sizeof() here is a danger for
future users that might pass something other than a stack array.  We
could avoid this by adding a build time test (untested):

    _Static_assert(!__builtin_types_compatible_p(                       \
                       __typeof__(_buf), char *),                       \
                   "readlink_safe: _buf must be an array, not a pointer"); \

Maybe overkill for an internal helper, but we could avoid the hazard.

...
> +char *sysfs_driver_get(const char *bdf)
> +{
> +	char driver_path[PATH_MAX];
> +	char path[PATH_MAX];
> +	char *out_driver;
> +	int ret;
> +
> +	out_driver = calloc(DRIVER_NAME_SZ, sizeof(char));
> +	VFIO_ASSERT_NOT_NULL(out_driver);
> +
> +	snprintf_assert(path, PATH_MAX, "/sys/bus/pci/devices/%s/driver", bdf);
> +	ret = readlink_safe(path, driver_path);
> +	if (ret == -1) {
> +		free(out_driver);
> +
> +		if (errno == ENOENT)
> +			return NULL;
> +
> +		VFIO_FAIL("Failed to read %s\n", path);
> +	}
> +
> +	strncpy(out_driver, basename(driver_path), DRIVER_NAME_SZ - 1);

Nit, I'm not really sure what DRIVER_NAME_SZ buys us other than an
artificial limit.  We're already bound by PATH_MAX and could just do a
strdup() for the return.  Neither are blockers.  Thanks,

Alex

> +	return out_driver;
> +}
