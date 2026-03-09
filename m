Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B4131F03D7
	for <kvm@vger.kernel.org>; Mon,  9 Mar 2026 23:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773097374; cv=none; b=XRgDavuz7kVwdFpdaZ+I+k3Eq7xDMHcflpOotVpfPYwLcJ5YKOqkeGS4O5VnuztBRgBcOwa8IG5EHq4FA4w038LTKmKksV2VUz+TdVoX3tiXrE7Qm05lVwrNa1HH4uzgMzYpo6hZVfDp81+GTEgKXtH9y4ulwrNUwS4XDDgX/pY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773097374; c=relaxed/simple;
	bh=46ojE7ub3NikZu06fNrPU7TbW5ICTow3JhkRPWroNME=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NWc150Qyz4NFUNFPnDB3wBEYkFA2Hg40HidwLudHUdDemO2PMP4I/urLW4L5g3gdXqoABRHS9wVPgCrl6+OQjx0zumrQ1qJFgZFQZan1b0Q1kT4rDB9ZdSUygYjOILMk0PiWoOFQcSGfBMalVdKezTRpiW70/KENZiCwY04/ico=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=Zm+4v/l+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=B6yGj3rD; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="Zm+4v/l+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="B6yGj3rD"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id B3A3AEC02EA;
	Mon,  9 Mar 2026 19:02:50 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Mon, 09 Mar 2026 19:02:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1773097370;
	 x=1773183770; bh=5u523kejBO028cHk2FR7XhN0EcufVz5twjaS8TosreQ=; b=
	Zm+4v/l+hCGCSnTyorcJPepTTMPhwhwE+6IDZGGo6LHgBEtTmcbVA/XN+sX63U6t
	SFSCWnn1X/QppycuPgTxeWAgP4zU1jqzypy6BT4Uzpt5QfT8oJAXIH/ULrK0qYUv
	1gwSa1W2eMEYUln7dIj8uzfjJjAo0nutOzU7Mh2BiJwoGwb/9uV6eWMKb3ctjo7P
	lL/eU3bQGOeUYk84MWs2cPYBbWX4LONAvxDrPJkPPovN+S90U7et2VqfOmfCnljp
	CmaxzlnP1jnTuhpJUVDY7OYvinghT+aNnbx1O6LOEIu3oDoDS+Qaoa6uruDQpYGc
	TeEAUIrOayfcU5y48hxRnw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773097370; x=
	1773183770; bh=5u523kejBO028cHk2FR7XhN0EcufVz5twjaS8TosreQ=; b=B
	6yGj3rDfRmVAdrj8A7kdY1JLxplMt37EDKkRRTiudWN9pEP+Z32mrbbFuU3zvX+O
	ht0JQ3mNoWoaaVb+mlcCbmBKCVE4hoBEbh3q3ueDXrk+ACYrQ36cu84sQMtHLjLI
	l9R2k0QZRDCSJ1XMJEu1n1mLrPIrcb2UIZq+lsStRXNBTI3DHYvP2Hu1wyPEgBk+
	t6n6NEvOBO05sUUSjw1Oy1vpPhGgTRQZq6J6ltonEmY+E0yvzg035w5ATv72GIOc
	aUDRHLqfe3JIOlnxTQHLNuWYee8L2Cr5GT636+fWkbdX68V2706o9dX5D7k/5r/y
	BtGm0Dguhgnx94MFYQ6VQ==
X-ME-Sender: <xms:mlGvaddg6pTo-HE6QHZwumzcxcu_XlNMfxANIuH1tmUEV0dmuGxdyQ>
    <xme:mlGvadxFtOWdUT5hhTaBusLahMmiS_kXFeSKbyKbvki0c3dGxMw_XwZC7NeK6SPc9
    7URIDdCNGLriM53sD4W77CLrpZVwpZ7S8tc4ejgnU21fvxSZEcK1Q>
X-ME-Received: <xmr:mlGvaaI7c3pGit9o9StS_EO4Ihc4ReY9PKKfGwJSRRcJBPuW3I-YOuhLVVI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvjeelgeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkjghfofggtgfgsehtjeertdertddvnecuhfhrohhmpeetlhgvgicu
    hghilhhlihgrmhhsohhnuceorghlvgigsehshhgriigsohhtrdhorhhgqeenucggtffrrg
    htthgvrhhnpedvkeefjeekvdduhfduhfetkedugfduieettedvueekvdehtedvkefgudeg
    veeuueenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grlhgvgiesshhhrgiisghothdrohhrghdpnhgspghrtghpthhtohepledpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepshhumhgrnhdrkhhumhgrrhdrtghhrghkrhgrsghorh
    hthiesihhnthgvlhdrtghomhdprhgtphhtthhopehjghhgseiiihgvphgvrdgtrgdprhgt
    phhtthhopeihihhshhgrihhhsehnvhhiughirgdrtghomhdprhgtphhtthhopehskhholh
    hothhhuhhmthhhohesnhhvihguihgrrdgtohhmpdhrtghpthhtohepkhgvvhhinhdrthhi
    rghnsehinhhtvghlrdgtohhmpdhrtghpthhtohepghhiohhvrghnnhhirdgtrggsihguug
    husehinhhtvghlrdgtohhmpdhrtghpthhtohepkhhvmhesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehqrghtqdhlihhnuhigsehinhhtvghlrdgtohhmpdhrtghpth
    htoheprghlvgigsehshhgriigsohhtrdhorhhg
X-ME-Proxy: <xmx:mlGvaXGliC2X7LSQaYTAs0O27Itcfo57YZhv_Hr6F0G8a_2L3NEwxw>
    <xmx:mlGvae8mfitwyRMrEgOeSOuOXA0nlCJskjee1MR0n5SsrfMCqZ6WFQ>
    <xmx:mlGvafIDpxMKf-PzEd9c44biyE5g_W2CCuWlEPc3hp0hprTN-4qG_Q>
    <xmx:mlGvaUsWx7NDyUYvhsCbc8yGED3XOh9-zEIeMj0OkS4Xd1SmChmdUA>
    <xmx:mlGvaf_N1ClRWVT9KmLUuEjqsp79osNikjCN41Y5pY_zN0JnuTos-36_>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Mar 2026 19:02:49 -0400 (EDT)
Date: Mon, 9 Mar 2026 17:02:47 -0600
From: Alex Williamson <alex@shazbot.org>
To: Suman Kumar Chakraborty <suman.kumar.chakraborty@intel.com>
Cc: jgg@ziepe.ca, yishaih@nvidia.com, skolothumtho@nvidia.com,
 kevin.tian@intel.com, giovanni.cabiddu@intel.com, kvm@vger.kernel.org,
 qat-linux@intel.com, alex@shazbot.org
Subject: Re: [PATCH] vfio/qat: extend Kconfig dependencies for 420xx and
 6xxx devices
Message-ID: <20260309170247.2bd96b78@shazbot.org>
In-Reply-To: <20260213091403.72338-1-suman.kumar.chakraborty@intel.com>
References: <20260213091403.72338-1-suman.kumar.chakraborty@intel.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 13 Feb 2026 09:14:03 +0000
Suman Kumar Chakraborty <suman.kumar.chakraborty@intel.com> wrote:

> From: Vijay Sundar Selvamani <vijay.sundar.selvamani@intel.com>
> 
> Currently, the QAT VFIO PCI driver can only be configured when the 4xxx
> QAT driver (CRYPTO_DEV_QAT_4XXX) is enabled. This is too restrictive as
> the VFIO driver also supports VFs from the 420xx and 6xxx device
> families, which share a compatible migration interface.
> 
> Extends the Kconfig dependencies to allow configuration when any of the
> supported QAT device families (4xxx, 420xx, or 6xxx) are enabled.

420xx seems to be device ID 0x4947:

drivers/crypto/intel/qat/qat_common/adf_accel_devices.h
#define PCI_DEVICE_ID_INTEL_QAT_420XXIOV 0x4947

We don't currently have that in the ID table for the vfio qat driver:

static const struct pci_device_id qat_vf_vfio_pci_table[] = {
        /* Intel QAT GEN4 4xxx VF device */
        { PCI_DRIVER_OVERRIDE_DEVICE_VFIO(PCI_VENDOR_ID_INTEL, 0x4941) },
        { PCI_DRIVER_OVERRIDE_DEVICE_VFIO(PCI_VENDOR_ID_INTEL, 0x4943) },
        { PCI_DRIVER_OVERRIDE_DEVICE_VFIO(PCI_VENDOR_ID_INTEL, 0x4945) },
        /* Intel QAT GEN6 6xxx VF device */
        { PCI_DRIVER_OVERRIDE_DEVICE_VFIO(PCI_VENDOR_ID_INTEL, 0x4949) },
        {}
};

Are we missing support for this device and is this Kconfig change
therefore a little overeager?  Thanks,

Alex

> Signed-off-by: Vijay Sundar Selvamani <vijay.sundar.selvamani@intel.com>
> Signed-off-by: Suman Kumar Chakraborty <suman.kumar.chakraborty@intel.com>
> Reviewed-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
> ---
>  drivers/vfio/pci/qat/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/vfio/pci/qat/Kconfig b/drivers/vfio/pci/qat/Kconfig
> index bf52cfa4b595..83f037d7e9a4 100644
> --- a/drivers/vfio/pci/qat/Kconfig
> +++ b/drivers/vfio/pci/qat/Kconfig
> @@ -2,7 +2,7 @@
>  config QAT_VFIO_PCI
>  	tristate "VFIO support for QAT VF PCI devices"
>  	select VFIO_PCI_CORE
> -	depends on CRYPTO_DEV_QAT_4XXX
> +	depends on CRYPTO_DEV_QAT_4XXX || CRYPTO_DEV_QAT_420XX || CRYPTO_DEV_QAT_6XXX
>  	help
>  	  This provides migration support for Intel(R) QAT Virtual Function
>  	  using the VFIO framework.
> 
> base-commit: b10c62483b324e60e45fb27d7fdc09c9198993d7

