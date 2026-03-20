Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C3336C9C2;
	Fri, 20 Mar 2026 21:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774041561; cv=none; b=UKwrwFDauG4AnFhiiu32RQq81eAA5se6BgimIMN1qAXtJGCPzWu1QGD42FV1YeCEGQxTHBKwAtPivDXUMK+AGaV4giHDdZZQRqj1HnM+sMzcGXitDPeXLk//X3dUBigJ27+t2W7az0MzZiKPTbEB3FyBn2k24sP57gemkjKsPxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774041561; c=relaxed/simple;
	bh=9cnC3SeeLwuW3KRpkyoV6iArsF3iHDDV9pCYBgu9shY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Vd6ELUVGVqxUaS2YSeQ2oEv6lJsG0zsXnrxqWIpcq9j6hAkd/3OnkhcPp9e5GSbGZIT2LGquQoCleYMJipjr5UzUlm3+mf2p7oIFYCFBxGARVCryMWVng4vJtLzRMSximacwYU5C6GVrUXtgZY9cN1IDGKEsDk+foe+0DzZ8kvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=hXxu9hMq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dVCJw+Ts; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="hXxu9hMq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dVCJw+Ts"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2F0431400274;
	Fri, 20 Mar 2026 17:19:16 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Fri, 20 Mar 2026 17:19:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1774041556;
	 x=1774127956; bh=pJNIBLgIdbJWCrylIElQAGqPfeSAMI8p6teUIynux0E=; b=
	hXxu9hMq4G7PEei3YV1xn+cJe/o2ddNwxMpC8Ypz6zIeUc0Y4ZAunzp62YqMBfCw
	qpQGpPr8vs0PjQk1FJRRhD/s4uqURdEfPvVMlrquy/aIFxzFYADEFLOr9UvDVkn8
	zgqx1h/6Y3b9OD3I6rlBljBTxoFgOZGKbKnx0QZzvTIxpobZ22WUOg7Jub/hrp2r
	46Lw2kddPzvaRL5+Z5vkt88vI/eW7C8CAyKXysh1YJauKH0Tr5Vd9JsuRf77CGkP
	JbE9RVGPeEMTGj9LSzFV8XI6AK3uHkJbzgr12gDt48VueQ0a6mP4qMC/YKS+gehv
	tddgWDa1qBYXNRAzzhywfw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1774041556; x=
	1774127956; bh=pJNIBLgIdbJWCrylIElQAGqPfeSAMI8p6teUIynux0E=; b=d
	VCJw+TsM8Jq3asuc6H/vvsVlgvYnKnBELMiTxj5fRpO+r3TgmTD8rCL87zHpzY1D
	avuLEPAKBHgGd16zV2A/K5WVyxetFML6df6aApC2AQfq+mW3u8RPcc1P6aAOnn+I
	1uKO0bLLKse6DoHd0DXurZKDLc2fStHlKfeC8AfXeAmhY5EnvMLv1fXLnNuG+bzW
	S86PWycGFx78r1ENpoNNw6WSMS7qEY21LTF33DacmuTvxdx/3/nFq3C4mQOBUE93
	xXQeAHbFqw6U5DUpg+LfJXGeSaJv9adLJVUykEv8/j6Vf//AYsM1tzsqoUF3juh/
	krN4oDjRwYGyxsyNlgtHA==
X-ME-Sender: <xms:07m9acV7dpa3KLUJqeMdQZlyGyfYa6G5a_JIujsZWqhrDCL-fvFhFg>
    <xme:07m9aRBn44TkMRM3P6iPJusAOuJJkhrt0yz_iwNOsvo9bKfzVyaAKjE5ssGQpodHe
    f-6lCUBjWlTqXz5ycQDHjKXdQ7BppYgml3EP8wkN5oTqqKD2Wk5jQ>
X-ME-Received: <xmr:07m9aRE-Mo9zaH-6dV-UjgCjB-mdq_Dcc-ELKYlFkpqwnYR5ZlWJLOlhdF0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefuddtleejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkjghfofggtgfgsehtjeertdertddvnecuhfhrohhmpeetlhgvgicu
    hghilhhlihgrmhhsohhnuceorghlvgigsehshhgriigsohhtrdhorhhgqeenucggtffrrg
    htthgvrhhnpedvkeefjeekvdduhfduhfetkedugfduieettedvueekvdehtedvkefgudeg
    veeuueenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grlhgvgiesshhhrgiisghothdrohhrghdpnhgspghrtghpthhtohepledpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohephihiuddrlhgrihesihhnthgvlhdrtghomhdprhgtph
    htthhopehshhhurghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegumhgrthhlrggt
    khesghhoohhglhgvrdgtohhmpdhrtghpthhtoheprhgrnhgrnhhtrgesghhoohhglhgvrd
    gtohhmpdhrtghpthhtoheprghmrghsthhrohesfhgsrdgtohhmpdhrtghpthhtohepkhhv
    mhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkshgvlh
    hfthgvshhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidq
    khgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghlvgigse
    hshhgriigsohhtrdhorhhg
X-ME-Proxy: <xmx:07m9aS6an4kkdNn10wlb-hhGcuFFGHTGRx54J5b7YWn-Sq3gBDJIuQ>
    <xmx:1Lm9aXkyiHc20I_gG6mw2PtV-bdvO9PDBtrSM4lewVk74Oxv0GI5IA>
    <xmx:1Lm9ad40V-iOnuSebRIJViG0LTQa4kFPJEW8xm3EYmQtDjorOch6vg>
    <xmx:1Lm9aYTOZuO0tpoZ80WO3LM94x4fmXoqu48yLevMHgXZjCG-NvTQmg>
    <xmx:1Lm9afGKyY2l7ayhSz3PaDbw5didjqO7P1k2sMNgTL7gAZvx2JBxk0iR>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Mar 2026 17:19:15 -0400 (EDT)
Date: Fri, 20 Mar 2026 15:16:54 -0600
From: Alex Williamson <alex@shazbot.org>
To: Yi Lai <yi1.lai@intel.com>
Cc: Shuah Khan <shuah@kernel.org>, David Matlack <dmatlack@google.com>,
 Raghavendra Rao Ananta <rananta@google.com>, Alex Mastro <amastro@fb.com>,
 kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, alex@shazbot.org
Subject: Re: [PATCH v2] vfio: selftests: Support DMR and GNR-D DSA devices
Message-ID: <20260320151654.60f0cf65@shazbot.org>
In-Reply-To: <20260320010930.481380-1-yi1.lai@intel.com>
References: <20260320010930.481380-1-yi1.lai@intel.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 20 Mar 2026 09:09:29 +0800
Yi Lai <yi1.lai@intel.com> wrote:

> Currently, the VFIO DSA driver test only supports the SPR DSA device ID.
> Attempting to run the test on newer platforms like DMR or GNR-D results
> in a "No driver found" error, causing the test to be skipped.
> 
> Refactor dsa_probe() to use a switch statement for checking device IDs.
> This improves maintainability and makes it easier to add new device IDs
> in the future.
> 
> Add the following DSA device IDs to the supported list:
> PCI_DEVICE_ID_INTEL_DSA_DMR  (0x1212)
> PCI_DEVICE_ID_INTEL_DSA_GNRD (0x11fb)
> 
> Signed-off-by: Yi Lai <yi1.lai@intel.com>
> ---
>  .../testing/selftests/vfio/lib/drivers/dsa/dsa.c  | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/vfio/lib/drivers/dsa/dsa.c b/tools/testing/selftests/vfio/lib/drivers/dsa/dsa.c
> index c75045bcab79..19d9630b24c2 100644
> --- a/tools/testing/selftests/vfio/lib/drivers/dsa/dsa.c
> +++ b/tools/testing/selftests/vfio/lib/drivers/dsa/dsa.c
> @@ -65,9 +65,20 @@ static bool dsa_int_handle_request_required(struct vfio_pci_device *device)
>  
>  static int dsa_probe(struct vfio_pci_device *device)
>  {
> -	if (!vfio_pci_device_match(device, PCI_VENDOR_ID_INTEL,
> -				   PCI_DEVICE_ID_INTEL_DSA_SPR0))
> +	const u16 vendor_id = vfio_pci_config_readw(device, PCI_VENDOR_ID);
> +	const u16 device_id = vfio_pci_config_readw(device, PCI_DEVICE_ID);
> +
> +	if (vendor_id != PCI_VENDOR_ID_INTEL)
> +		return -EINVAL;
> +
> +	switch (device_id) {
> +	case PCI_DEVICE_ID_INTEL_DSA_SPR0:
> +	case PCI_DEVICE_ID_INTEL_DSA_DMR:
> +	case PCI_DEVICE_ID_INTEL_DSA_GNRD:
> +		break;
> +	default:
>  		return -EINVAL;
> +	}
>  
>  	if (dsa_int_handle_request_required(device)) {
>  		dev_err(device, "Device requires requesting interrupt handles\n");

Applied to vfio next branch for v7.1.  Thanks,

Alex
