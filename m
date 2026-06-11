Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B0D2F25F0
	for <kvm@vger.kernel.org>; Thu, 11 Jun 2026 18:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781202727; cv=none; b=JHM3z1/CdIdG9xKwA0cDl/xH35bj2fZB9pvfQ1ggzfvieUnZ5tYmgWJe0/4BdRcy81yQPJ7aLZAIczL7Tcklx3Oo8aD+ux3cs7KEJz+AV54+o4si8mQ3ly1C/qPp1ioR1WxjP5UPR2tufYwmJ6+eskXz1bIAsB+aDIEybyiPdSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781202727; c=relaxed/simple;
	bh=z9HCVPCLhqPWk/FUcvQBVGbl8gbtkxmDCDKSnY0RFaY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AkS66lRpslYJp66Ei7P7IQURvC0/7rp7uRk4qFapWLQFaze8SkzPtaNwk/SX60G7TlhLvQYWudpuAZRMV/C4tLPPfiR80nodDzuZBhNsKkOQFa1w+b15V64O7qbAYany8EWJgneW04GAriKtZclGRy7p5HjY9/Q6u06myefzxZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=MmrO5fVP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NnUm6jSO; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="MmrO5fVP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NnUm6jSO"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id F3747EC018E;
	Thu, 11 Jun 2026 14:32:03 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Thu, 11 Jun 2026 14:32:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1781202723;
	 x=1781289123; bh=RlqKt5CZ62rV4YN4vr/Ag3WJZOUKrkEvyJKuDAZJNfs=; b=
	MmrO5fVPDS/usi79W/1nA03/ENvrom7zYPwLI07qDG4zRq78mxYWb4DC4nQz1obg
	2MLGFkCyDiv5Pl+qJExcnZQW7a2n1zqMEkg6TpyQTeH6YE6sEq3P11+fn0nsREZr
	i8szajTPiBEUKHCC57nKf2cNbEJxyNJ0iQWKJzNUKcFTgzX/SbkOAVfBqgTKmAT6
	+VDuBU8VZPuvu/5WWUAYGcjAqViMWwpaQX1+ooOsOId573b5GtJvV66d+BGQNCrf
	pZ2Erjs0ickjxhMpTDGSNffyahnKG0OqB8JL8aY0pRrrIX9g5fo4hz8B/XwPsXcA
	zUonrGfIVL9JPiAGtkZ8sg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781202723; x=
	1781289123; bh=RlqKt5CZ62rV4YN4vr/Ag3WJZOUKrkEvyJKuDAZJNfs=; b=N
	nUm6jSO8MzVu5dYKM7P7PFmZKDkragTwDG1YH38PUxalFCXz4LdlJXV4pURHlAIs
	/1An9EbP0Qvs6uKZhvBSgOEHEFXCEyFpdy7GZkh2oJHL2MLEjhTR22QYObFmJU8N
	Zov+Azev0Isr2B4EmilmmFmpOSYYJxpkHbe14hBnpRloHnnksQdw7tgjF0z78U6D
	AfWz9r0D9OpvQZXVx8LW/Ml/2xCC/gb/3xMTG91iblAYiLYMsoqWeF2pfpIidbNW
	3yqBhhr6P3FoM2VCm8QWOTZsGg8CrM1ows/y/qa9DKse7AyKldRTF2XuxoYh5MXC
	0biZzchhUwgMubqyBjSoA==
X-ME-Sender: <xms:Iv8qapv8PuMCIyEDNXzZAu2ftIv_bMrGuwvtssuopg4WD2JblrCcXw>
    <xme:Iv8qaqrgGmT7fHXIr-b2I4IBLDfcyivQdmnf0QVG8hDwhYVpMhCRvURmHmeXMsE0c
    AZOmIcxgu60Wd7NEwffWknL0cPWuM5g_U6wKfvtCGdqhvgKH-b9>
X-ME-Received: <xmr:Iv8qaoUmfdfN6_9z02R56D0o5l1t1vQwEAYAcS6Z1OHFXGlYYC3vb0hwfD4>
X-ME-Proxy-Cause: dmFkZTFWjpIp2C0dtYOnLxug+V7e4rvxNdB03pN7ozgvRSof1XYsPo+1r4EghJZzdDrkK/
    6rs7JzU9akUGF9XYNXy6nysY2XZiYyMoM3Eh+Z2AkdbD1LPCDRBMAlNW3IpdHdX63Lpqd2
    RnQkA3S2Ed55yXadIq2lTSVWWY30snu9dnS7K+oCTWmlQqx+TLd1rIk6JFsdTKJPr9gO9H
    SS/0BkUqoQHdrZkwiZsxZBiXi4HHgv0V4eV/0m8FXwsGWkOmXwC13/FV9ibkCCzjp2KVnn
    3hCyD+WuLvbJ6pcDMjh1ujdWCMOO/rCFItodwgKxTkLgGsa838Q/HYH2JA1Js/7gYrahff
    vrjOaelTTgtJIOZjT7lbs8R9OhVvFkeswxFhBpLY93ddSsvC7WyvMcckbQubocDzzFMMou
    sBHqBH87r836YLoz6D7sSk2ZNC7Duf4rqx8ZH9RV7K5YcKQE8qd3HSUc3OYT7WK0pzr8B6
    +sYQFtiseIGi2zKO2mipa7TvJy+wV4lTJPvC4RiA70zJw3ThTiIv/S4LpndGa0Jtw7sO9W
    sEddNwC02orSQPgY9UPzF1Pq+vC+KPcGU7Uf4WEqTWTdixQrlIsz+p7dlIGGDlJTdCT3LU
    8b7cVmg+TaTIdO1vEYntXW6A/PJcEksgsrn649dl5l8isrEeun2eEYCsFWtw
X-ME-Proxy: <xmx:Iv8qaq1q-Wv7RmSJX89J87JLdzbpYVfOVbu_l_zI9qfVscQVEoRrIQ>
    <xmx:Iv8qalsd1GONvwYuNf51UeBbDfMWX5cjtWZpTfaq46-j5qCIw4X7_A>
    <xmx:Iv8qaqUUeQRCKbSFAabw3-O5iTbL8LkpGUWZK9GXWkZ7qcUFemrd9w>
    <xmx:Iv8qalwjAZ6tzOnHOJG2HXAuTX0IKnM4chsWteUqeNkpMQoUkke29A>
    <xmx:I_8qah6rJOHLWJ27duO9Ni8gD8dYgsBuuk86RjEkfAWEE4ifv0Y7zXWN>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Jun 2026 14:32:01 -0400 (EDT)
Date: Thu, 11 Jun 2026 12:32:00 -0600
From: Alex Williamson <alex@shazbot.org>
To: Guixin Liu <kanie@linux.alibaba.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>,
 Pranjal Shrivastava <praan@google.com>, Brett Creeley
 <brett.creeley@amd.com>, Leon Romanovsky <leon@kernel.org>,
 kvm@vger.kernel.org, xlpang@linux.alibaba.com,
 oliver.yang@linux.alibaba.com, alex@shazbot.org
Subject: Re: [PATCH] vfio/pci: make nointxmask and disable_idle_d3 module
 params read-only
Message-ID: <20260611123200.4765b9cb@shazbot.org>
In-Reply-To: <20260610054734.3591169-1-kanie@linux.alibaba.com>
References: <20260610054734.3591169-1-kanie@linux.alibaba.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 10 Jun 2026 13:47:34 +0800
Guixin Liu <kanie@linux.alibaba.com> wrote:

> The nointxmask and disable_idle_d3 module parameters are registered with
> S_IWUSR, exposing a writable node under /sys/module/vfio_pci/parameters/.
> However, writing to them at runtime has no effect on driver behaviour:
> 
>  - Both values are copied into vfio-pci-core's own static variables via
>    vfio_pci_core_set_params(), which is only called once at module init
>    time.  A later write to the vfio_pci front-end variable is never
>    propagated to the core.
> 
>  - disable_idle_d3 additionally gates paired runtime PM get/put calls
>    across the probe/remove (register/unregister) and open/close
>    (enable/disable) life cycles.  Changing it at runtime would tear
>    these pairs apart and leak or underflow the runtime PM usage counter.
> 
>  - nointxmask is latched into per-device state (vdev->nointx /
>    vdev->pci_2_3) at device open time, so a later change can only affect
>    newly opened devices and yields inconsistent behaviour.
> 
> These parameters are effectively load-time constants.  Drop the write
> permission so they match disable_vga, which is already read-only, and to
> stop misleading users into thinking they are runtime tunable.
> 
> Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
> ---
>  drivers/vfio/pci/vfio_pci.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Thanks for the patch, I think this actually highlights a broader
problem.  Making disable_idle_d3 a read-only module parameter in
vfio-pci doesn't change that vfio-pci can be unload and reloaded with
different parameter values, therefore the gap is not closed.  We need
to use per device setting, latched at device probe, which actually
also returns some value to these parameters being runtime modified.
This feature was inadvertently lost in the vfio-pci-core split.

I've copied you on the broader fix:

https://lore.kernel.org/kvm/20260611182528.4004073-1-alex.williamson@nvidia.com/T/#t

Thanks,
Alex
