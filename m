Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F692836B1;
	Sun,  8 Mar 2026 16:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772986819; cv=none; b=HbVrnyGUJeL1n2Mv1h+LJdWXy36KZldLnpPZLpDEVdq+Ugid++sbZUqnpkPQVgEMgCsFxWiVIqYQ/4hzB23YWAPFr8v0pwL8EP6gp3PnTGWykuAkk5JxMwDTLHP+43eO6YdSwIo/12FRF8d7fcFpeWCK4gSswOWb7+fPMEVRrV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772986819; c=relaxed/simple;
	bh=R/Gbmu7EugP+FFr64t/LMc3kWP95ehSCih+5FBcbyjM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VKDFBqfgRJCbcAGHjLCchLcjXnHNnnQJgdYo3TxDVlgutZyXeLkNH5ZlT/ou+nxWeESVG+lwNi5cnEZAb3ZeJueeOBxm/d4GjzmOvwosQxydte0kCLa9xl6AlybJy5uJ/nUJ3t3DcmfKwWg9kCkI9NYfVjL6DeFx2YA+N8OBBdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ckvrrZMm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ckvrrZMm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 211BCC116C6;
	Sun,  8 Mar 2026 16:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1772986819;
	bh=R/Gbmu7EugP+FFr64t/LMc3kWP95ehSCih+5FBcbyjM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ckvrrZMm35Os36QJd9rp5ICd3u4b+3/KrV6HXgsdtsLADujnDSp7b8tbqXjKsStw6
	 xK2npzP96RH4jjnDl9ZAXRfHrgD5Z6rKCxEy+bdsI7j3oQKF+Bg8WcRfxwQgkYGlGR
	 0xOM1uBO1R09IWyDQgDHqAkAIoVgWxRUj5LAhUnY=
Date: Sun, 8 Mar 2026 17:20:17 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Jori Koolstra <jkoolstra@xs4all.nl>
Cc: Kirti Wankhede <kwankhede@nvidia.com>,
	"open list:VFIO MEDIATED DEVICE DRIVERS" <kvm@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] vfio: mdev: replace mtty_dev->vd_class with a const
 struct class
Message-ID: <2026030833-encrust-cubical-61c8@gregkh>
References: <20260308133733.1110551-1-jkoolstra@xs4all.nl>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260308133733.1110551-1-jkoolstra@xs4all.nl>

On Sun, Mar 08, 2026 at 02:37:33PM +0100, Jori Koolstra wrote:
> The class_create() call has been deprecated in favor of class_register()
> as the driver core now allows for a struct class to be in read-only
> memory. Replace mtty_dev->vd_class with a const struct class and drop the
> class_create() call.
> 
> Compile tested and found no errors/warns in dmesg after enabling
> CONFIG_VFIO and CONFIG_SAMPLE_VFIO_MDEV_MTTY.
> 
> Link: https://lore.kernel.org/all/2023040244-duffel-pushpin-f738@gregkh/
> 
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
> ---
>  samples/vfio-mdev/mtty.c | 27 ++++++++++++++-------------
>  1 file changed, 14 insertions(+), 13 deletions(-)
> 
> diff --git a/samples/vfio-mdev/mtty.c b/samples/vfio-mdev/mtty.c
> index bd92c38379b8..792f5c212fd1 100644
> --- a/samples/vfio-mdev/mtty.c
> +++ b/samples/vfio-mdev/mtty.c
> @@ -68,13 +68,16 @@
>   * Global Structures
>   */
>  
> +static const struct class mtty_class = {
> +	.name	= MTTY_CLASS_NAME
> +};
> +
>  static struct mtty_dev {
> -	dev_t		vd_devt;
> -	struct class	*vd_class;
> -	struct cdev	vd_cdev;
> -	struct idr	vd_idr;
> -	struct device	dev;
> -	struct mdev_parent parent;
> +	dev_t			vd_devt;
> +	struct cdev		vd_cdev;
> +	struct idr		vd_idr;
> +	struct device		dev;
> +	struct mdev_parent	parent;

No need to reformat this structure :(

thanks,

greg k-h
