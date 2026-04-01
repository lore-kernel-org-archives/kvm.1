Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0624C3C9432;
	Wed,  1 Apr 2026 22:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775084366; cv=none; b=bn0wL5D6qoKyxdA5FDM9BV8EfFfuW0zTQ8H0SpIaf+1iAy6b4VbpvghFT815jJ6hMTpZljoZQHhquIJn0MPOu/CTQLujuv/1g+qiiQ9kYTvXUy4yoWQNBHWqnChEgeAp9siJeqdzmHTzLVOTVKYROooc7wv3h92lmsB4U7IOHmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775084366; c=relaxed/simple;
	bh=GGmXEXEs/wcuF4+qrxDFGQ+I1Y4CCW5QWiOt3n4q1ek=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=at+oYfuWHDz+rn8DdBB3Q9OPLn+meeL+FDlDchwrqtweyGkLrRiAj1pWvTUGkK4e26kXEctyZuQEgj7hYkMkkG9TWlHCc74NXVDS9L6fa+hofqljJxXK5J2EI98NdW63P0ybQm2cFl6iQWGiNXbb6m51s3YSbvAN1cVpvQHj0+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=IzCyhgmM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nC0pVnmJ; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="IzCyhgmM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nC0pVnmJ"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3502E1400164;
	Wed,  1 Apr 2026 18:59:22 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 01 Apr 2026 18:59:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1775084362;
	 x=1775170762; bh=tVGoQ/SKdLaRtjfSRVaI9gemZl6yQxXC/3UoQFv4Zls=; b=
	IzCyhgmM/h3IjnluBY2opvuewBE0o1Dp2c70IKa6Onr4TM0JsqBAZFevjRgc6OhA
	MWHR9IHvxjfBWMGBlzgIaiUMxKqyXg/ZSAUhd6oud3KJBXR9Gkyd3uGp+o4kJrr4
	YBce9dMm3vKYKpkm882XsE3w4H0NkSUylXZ4qirAGDjApqI1AYh//RXUZnfNNp2c
	4ZdVEaG08BQWThs3SDVBN4ayAEpmjA84OVZVNobFRspBokLiXvSQ3CCjI5R1BZF8
	LOAYWMeYReuzdJS1M3Rfd1T3y6y+t22EISt0kh7al9NaOx3rVrlxLIdv/cSXymqi
	l+sGYD+YCXVfFGY1HJu1fA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1775084362; x=
	1775170762; bh=tVGoQ/SKdLaRtjfSRVaI9gemZl6yQxXC/3UoQFv4Zls=; b=n
	C0pVnmJv6Ss4VD0qxS9gQWyTb+eeOzvzvaTQgdkl4dDbfPaC+xAlkheLR0S0GkVn
	323nm3PFxYlHKXe0mtcyoSwWJRlKJ06I2jK1jINFVXo5Ac/W+inTT2smCrR/uF7g
	fi1xUGz9qgPMRW4GtPLZcEbUiUH29E4VGbqbEimrlvkLTvrCyRmxUqcBWB9inelv
	1dKrz+vUCsPA4tPSMcN0NTIez6xxbnB22uWDAtcj3MnIm0Cvu7+YkkDICi8X+MHZ
	kAmOVE0IDkmh9rHgcT0K5PV7lW5AA9UOrJ96XgyJDdum05OYMflUrcJOk6bvUNte
	ov+k4Wj9xfuG3ygmqbcAA==
X-ME-Sender: <xms:SaPNadi72LYokSLnQNS4OkvcH7ISjQvXAHxPkfHiUWtDAM2U2McxUg>
    <xme:SaPNaTg1zZND-JBmzG28LjlGKrVXXqVOa1jyz51BsbTgHRqpwLR3iAbcM4MuRWewk
    sX-5wzFswVPEbYQVcbZjtyYS35HRXM1EHgUCs0lAd5YhKKTRS_gcA>
X-ME-Received: <xmr:SaPNadK15SBnz909Q5D3qV0CwILM_VqgXtWqAMjGyTUtTBOED2UTAEhY9-I>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdegfeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epfffhvfevuffkjghfofggtgfgsehtjeertdertddvnecuhfhrohhmpeetlhgvgicuhghi
    lhhlihgrmhhsohhnuceorghlvgigsehshhgriigsohhtrdhorhhgqeenucggtffrrghtth
    gvrhhnpedvkeefjeekvdduhfduhfetkedugfduieettedvueekvdehtedvkefgudegveeu
    ueenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrlh
    gvgiesshhhrgiisghothdrohhrghdpnhgspghrtghpthhtohephedpmhhouggvpehsmhht
    phhouhhtpdhrtghpthhtoheptghhrhhishdrlhhonhhgrhhoshesghhmrghilhdrtghomh
    dprhgtphhtthhopegtlhhgsehrvgguhhgrthdrtghomhdprhgtphhtthhopehkvhhmsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghlvgigsehshhgriigsohht
    rdhorhhg
X-ME-Proxy: <xmx:SaPNaSFwvSDN90iORJyCkm9w0Xj-MI4VFXvT9QSV4FST1Kcb2S0oFg>
    <xmx:SaPNaRSsC3Zvs7Qr80Glaoyfv7nIo1Vytu2Jtt09jdAKIO3IVakRsw>
    <xmx:SaPNaed9c7GSesh_LxjdlUAaZ6dEfp4tlJAYqw_t7p-guPszukPCeA>
    <xmx:SaPNaQqAAf3vFpVpkTG5peiEJu-9J8m3NU9wrFxPgm4PjZsTAMTDiw>
    <xmx:SqPNadAVv88cjFIiWxfJ4mQHwV6N2hlVy3vU4dpqZjOK4rFmjyM1NVet>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Apr 2026 18:59:21 -0400 (EDT)
Date: Wed, 1 Apr 2026 16:59:20 -0600
From: Alex Williamson <alex@shazbot.org>
To: Christos Longros <chris.longros@gmail.com>
Cc: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@redhat.com>,
 kvm@vger.kernel.org, linux-kernel@vger.kernel.org, alex@shazbot.org
Subject: Re: [PATCH v2] vfio/pci: sanitize bogus INTx interrupt pin values
Message-ID: <20260401165920.373e7584@shazbot.org>
In-Reply-To: <20260328230126.73230-1-chris.longros@gmail.com>
References: <20260328215808.16108-1-chris.longros@gmail.com>
	<20260328230126.73230-1-chris.longros@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 29 Mar 2026 00:01:26 +0100
Christos Longros <chris.longros@gmail.com> wrote:

> Some PCI devices may report out-of-range interrupt pin values in
> config space (e.g., 0xFF when the device is in an error state).
> The VFIO PCI config virtualization layer passes these values through
> to userspace, causing QEMU to crash with an assertion failure in
> pci_irq_handler() when it computes irq_num = pin - 1, which exceeds
> PCI_NUM_PINS (4).
> 
> The existing code already handles bogus VF interrupt pins (set to 0
> per SR-IOV spec 3.4.1.18), but physical functions with out-of-range
> pin values are not caught.  Extend the condition that clears the
> virtualized interrupt pin to also cover values outside 1-4.

The description has taken quite a change in direction between v1 and
v2, which makes me wonder what's actually happening here.  v1 suggested
this was an issue with a specific RTL NIC where the pin register reads
as 0xFF, but proposes a generic solution.  v2 proposes the same
solution, but drops the reference to the RTL NIC, instead suggesting
that a device "in an error state" might have this trait.

If the device is in error state and the PIN register reads as 0xFF,
does all of config space read as 0xFF?  Was the PIN register valid
before?  How did it get into an "error state".

If this has only actually been observed with this RTL NIC, is it
really an error state or is the hardware non-spec compliant, trying to
indicate lack of INTx support with 0xFF rather than 0x0.

It would be surprising if a device in an error state was only broken
relative to the INTx PIN register, and exposing a broken device only
masking the INTx support seems incomplete.  If we're dealing with a
specific broken device, maybe the right answer is a quirk to set
pdev->irq to zero.

Please elaborate on what's actually happening here.  Thanks,

Alex

> Signed-off-by: Christos Longros <chris.longros@gmail.com>
> ---
>  drivers/vfio/pci/vfio_pci_config.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/vfio/pci/vfio_pci_config.c b/drivers/vfio/pci/vfio_pci_config.c
> index b4e39253f..ed75c1cc3 100644
> --- a/drivers/vfio/pci/vfio_pci_config.c
> +++ b/drivers/vfio/pci/vfio_pci_config.c
> @@ -1829,8 +1829,17 @@ int vfio_config_init(struct vfio_pci_core_device *vdev)
>  					cpu_to_le16(PCI_COMMAND_MEMORY);
>  	}
>  
> +	/*
> +	 * Sanitize bogus interrupt pin values.  Valid pins are 1 (INTA)
> +	 * through 4 (INTD); anything else disables legacy interrupts.
> +	 */
> +	if (vconfig[PCI_INTERRUPT_PIN] > 4)
> +		pci_info(pdev, "Bogus INTx pin %d, disabling INTx virtualization\n",
> +			 vconfig[PCI_INTERRUPT_PIN]);
> +
>  	if (!IS_ENABLED(CONFIG_VFIO_PCI_INTX) || vdev->nointx ||
> -	    !vdev->pdev->irq || vdev->pdev->irq == IRQ_NOTCONNECTED)
> +	    !vdev->pdev->irq || vdev->pdev->irq == IRQ_NOTCONNECTED ||
> +	    vconfig[PCI_INTERRUPT_PIN] > 4)
>  		vconfig[PCI_INTERRUPT_PIN] = 0;
>  
>  	ret = vfio_cap_init(vdev);

