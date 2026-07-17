Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08D7D33BBCB;
	Fri, 17 Jul 2026 15:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784303048; cv=none; b=P1sFboTg8mQ8CPuB02mK8ZJjjw1xtEUIGSDLiDBOOdMAlHhkzVmJcdG76+/yKWOMx1gcwB+FszchPsJzIkgZRCOY7zhgMk2Hgm5WGH3b98JoGzV13lSfZly+38mMbzvW7ynzPoPL0qC/XvbTT+xpKTIOp7mBvsEtO3gU3cnGmYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784303048; c=relaxed/simple;
	bh=asADGNchxVu0HONbbV+pf/qMEXxQgodIOPxZSeOXvi8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X8m8unZJN0BHa0cNHZXWv4kMnOg2pNg0ITacZEDWyAO5+iNGIxFmcQvBwolE34QUpyD9K6EYOHE7eAUoq/QIZqHCmMOmu/wwMyJbaNkri32gShZ+/s3BRo0H9KH0EgrKbyA513dtKh9nUYJ2dMo4BXVuDuXFvZKkN6uqvYCcsvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=O9ggdr9U; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qAsNhoFk; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="O9ggdr9U";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qAsNhoFk"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 2D142EC01CE;
	Fri, 17 Jul 2026 11:44:06 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Fri, 17 Jul 2026 11:44:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1784303046;
	 x=1784389446; bh=Cx3wM1kOoxCwe0QweWs20VV3ZbFkdoj/04lxX9YItvE=; b=
	O9ggdr9UYKgJ2zDiVFCYmrnsO3Chnp5gxz/VWjW+q/ggC6OU3oyvaazwT8Uf0eEN
	ipbcqUHkGcXslAFw+vN68QDcTEGgNseYqE7sGzVtjzFZI5gEEeeMMe4A8eYl71iV
	c+Z2dsVtwpv6VWOFS9+L8dOHTJmXnWh76URFCxd/QINFzVPjO4bIey2+s8wj366t
	kTyEYatj3TSpAG5T+IQPDKDr/HHDdtEeUAE/y2MTRiTZQgbxQE7x3vjIqxO1M9E5
	XVuqi9Bl+nH8YHrgKH0mvxjx5t/3wURLbaFphv4fjoErZH+VEbKpIvtqfLzHxvMH
	ssj1I6BqaE8y48X8Ol/oag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784303046; x=
	1784389446; bh=Cx3wM1kOoxCwe0QweWs20VV3ZbFkdoj/04lxX9YItvE=; b=q
	AsNhoFkueLvzbK/wz+EsgH9VD6q7m8Gxb/o2oe1zjtGXPkjV9gOhYqigZmxbwYse
	uj1PzjXGDCbCGNL8E+n8xqPuxFgNvOkuELdUVWK76hOQ2bdQQXjFROP/o1boUsQ4
	XcJsY1mHFRor7kbFqqEiEhmqPmFxypGT6h1aRUeH60u6etVFHvkIDXXvtlwf0tvP
	pLG48LQT7wJd55GAXaWD7medujeW3kV5C7EwD4+ANVSk/qFre7z6Yr3jo5AmowGl
	IkCVWU7fFOEJE2Y6uk1fJ46xB2zTE2V/9WdGVd7nmbG/by89wMGgshHCl/GuUiEx
	0H0UXzeNnyWVhJx0V4KAg==
X-ME-Sender: <xms:xU1aamgJDnMAAKg0bp4gK9-lKGdNKPMpW6qWySDivSB5Ue1UJZXKKw>
    <xme:xU1aatDoT05Vh5e-F-xUky3pwcRZ6406BELTtOzGH0BETzAj577SrOWN0n3Q1Zgzy
    sD_0eUju1X_hMfOxCfBCCcGK8iY4L4aXV_5DY7wdU65M6uW3MXGng>
X-ME-Received: <xmr:xU1aao5psbbFCRvVHVUIV5zjVA6ynWn3jejla7rd2m-4cuH-j4iqdrX1Sb4>
X-ME-Proxy-Cause: dmFkZTGtimudHPAbfThGNZ+h80ULP4BKReBQeYGrgBsyON1ztJiWLSAAIZDnG8fToEG3XU
    fB0cHbYtowPGntdAcFDq4GKEfwsNpWYO+isPzGhlQzNrheThNlwPGdswI2Lrk8PTaL2Jp0
    hoQfsEk1tnVAcbMSxs3aqEIk2LYLvvr2aB5CAGNMfHAZIDB9m8rtehdEVDjKrVmWwB9WLB
    5IN6/bSY+39/QkTRPRGEI73E8PLSp1VRWpZZnRHKG/riYrW+X+A+H/H73XzFhKdE4ymJIF
    2G8vDJSZGjHwWxx3kh3VQc+5xaIftx/QAtimz1soPXvtE1hFGBnBDZuf91W4JSWj5iOwcG
    XMosao8AHIjMys3mlDUJL0hrKTekUT08a1vWPl5NLn9LibmJE2JEdH8oVtg387WMXe+J8w
    HquD54Q5CYWUMD9ENKQt1q26SQa0hX9MtmeGmnTwF5PEkvqpQsQbJvE44t9yZWw2ABPX2n
    Q7P8UyVyWVkPWVOAzFiCY2HumHY8Nxdi57IBn1n8W8x//MghhSqCBntNeSiKijrJTWpqwl
    JHHsQh0EcZjNg8FaELS1CQn3aPzuyHLyxjv/ep2dTUSjfR49yNDnRLIkSoNRuCu6qjDaeO
    lf+g77j5d+GVMLFUWKGP1a+tSSvA5iPK9UNf1r+ILjNlPw56zlRU3EjKvamg
X-ME-Proxy: <xmx:xU1aaiGWuWPi8XxvEKWunRIMYnZQzJy4C91g-gIGGWaUTPHyzYDHUA>
    <xmx:xU1aajBUzcDgDH0lTr7tI-DwgMV8LmULreJk_IfMJDBLRxCdfe7DOg>
    <xmx:xU1aanx-yC86MjeFtU49z8SkVcq4mBq3IJ7dfEKToAAEIQj8I5uYwA>
    <xmx:xU1aan6Gn5Oktjg-V4tu3SEUT0pKNdMBGjZDyOGBbqjS_jr-P8uQ6Q>
    <xmx:xk1aao0FtafbVc0FCr4S584gHzsPI-stdjv_Acr-sIAbFQ6rqvpo2gnN>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Jul 2026 11:44:04 -0400 (EDT)
Date: Fri, 17 Jul 2026 09:43:52 -0600
From: Alex Williamson <alex@shazbot.org>
To: Alex Mastro <amastro@fb.com>
Cc: David Matlack <dmatlack@google.com>, Shuah Khan <shuah@kernel.org>,
 Raghavendra Rao Ananta <rananta@google.com>, Vipin Sharma
 <vipinsh@google.com>, <kvm@vger.kernel.org>,
 <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Shuah
 Khan <skhan@linuxfoundation.org>, alex@shazbot.org
Subject: Re: [PATCH v4 0/2] vfio: selftests: Add allocation assert helpers
 and avoid VLAs
Message-ID: <20260717094352.6bb38603@shazbot.org>
In-Reply-To: <20260617-scratch-amastro-vfio-selftests-avoid-vlas-v4-0-b9f52f1e2c5a@fb.com>
References: <20260617-scratch-amastro-vfio-selftests-avoid-vlas-v4-0-b9f52f1e2c5a@fb.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 17 Jun 2026 11:57:59 -0700
Alex Mastro <amastro@fb.com> wrote:

> Add VFIO selftest {malloc,calloc}_assert() helpers, then use
> them in places that open-code malloc() or calloc() followed by
> VFIO_ASSERT_NOT_NULL().
> 
> Use the helpers to replace VLAs with heap allocations. This avoids GCC
> rejecting initialized VLAs and avoids treating a u8 buffer as a possibly
> under-aligned VFIO request struct.
> 
> Changes in v4:
> - Add malloc_assert().
> - Link to v3: https://patch.msgid.link/20260615-scratch-amastro-vfio-selftests-avoid-vlas-v3-0-b3798415c72a@fb.com
> 
> Changes in v3:
> - Add the calloc_assert() helper as a precursor patch.
> - Convert existing VFIO selftest calloc() assertion sites.
> - Update the VLA fix to use calloc_assert().
> - Link to v2: https://patch.msgid.link/20260615-scratch-amastro-vfio-selftests-avoid-vlas-v2-1-4e4df462908a@fb.com
> 
> Changes in v2:
> - Reverse xmas tree variable ordering
> - Link to v1: https://patch.msgid.link/20260612-scratch-amastro-vfio-selftests-avoid-vlas-v1-1-ba3acb635f0a@fb.com
> 
> Signed-off-by: Alex Mastro <amastro@fb.com>
> ---
> Alex Mastro (2):
>       vfio: selftests: Add allocation assert helpers
>       vfio: selftests: Avoid VLAs
> 
>  .../selftests/vfio/lib/include/libvfio/assert.h    | 18 ++++++++++++
>  tools/testing/selftests/vfio/lib/iommu.c           | 12 +++-----
>  tools/testing/selftests/vfio/lib/iova_allocator.c  |  4 +--
>  tools/testing/selftests/vfio/lib/sysfs.c           |  3 +-
>  tools/testing/selftests/vfio/lib/vfio_pci_device.c | 32 ++++++++++++----------
>  .../vfio/vfio_pci_device_init_perf_test.c          |  4 +--
>  6 files changed, 43 insertions(+), 30 deletions(-)
> ---
> base-commit: a26b499b757cfc8bbff1088bb1b844639e250893
> change-id: 20260612-scratch-amastro-vfio-selftests-avoid-vlas-395eb3dcb3ab
> 
> Best regards,
> --  
> Alex Mastro <amastro@fb.com>
> 

Applied to vfio next branch for v7.3.  Thanks,

Alex
