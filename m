Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 536663624CF;
	Mon, 16 Mar 2026 21:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773695340; cv=none; b=heSh73tQz7Yrldkdq8knLLc1by3puzcWIhsWxewJslYIbIyadlxvxckeydI5jkLpLxtLn2Dr3k+Oz3H+zkhJ6MBHa58giuH+CL84bcEk2U6Jq9kvFPJ7m52Oc7T/hQ4koV3NjSqRDE5xs4+moT9Y5MHysjujABq1RvxLcPc9jM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773695340; c=relaxed/simple;
	bh=qWGrVBaoYj/aKcWCy8dzzgV3adeFXct5+MbFY/DnY9w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=amXn4Cf/2P6T74Hfy9KNo2w/VE5JKfK2KLqhEfHfIyKE0yovCd9ngX8/9vatl/DhYayAzNG1MMvxfioY1qfogru8xIR+2dViGKBc9ikGaMAVdYknouhFUSPzmYhmR4+pZ1C2h9Hop8bNXte5e4x+tSgILe8AJZTjXBvdjVos7JA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=WfwkOAla; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FqFXwESJ; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="WfwkOAla";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FqFXwESJ"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 5E1C914002A4;
	Mon, 16 Mar 2026 17:08:56 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 16 Mar 2026 17:08:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1773695336;
	 x=1773781736; bh=F19cSU3nmmuLBrIsVvofnL9FVy4n58PucEuAq5SxfJs=; b=
	WfwkOAlaw5Q9s9kWOr67Qqaz4DlkUmBT5W/VBv0dmCjgS2KMpeJx+y8D+yA+Yznl
	QPkuJLkE6igixlhEUbXyEApjzpROZ4gqRcpLaf5xNVreBOuQhX+/c9fRCHwHRF4l
	7LXLighCgQOCfVkup/+CuhconCk7CnA532t7OFWVZuUz67YA786xWLJ/Dx9V4w8x
	GrcBW0SUF0PquD9phKms4D0LbqkcN+mvwrwp7n4UW7k8Em7v0grTfgTtz4dJ/FE4
	ec8J5CycD2OQHsk5mVvPhPBKXNUoAnp81wiP6tPTNm/42hUYOfz7Y+KjcV518gA9
	DdVMuksCIQGhIerCB62N9A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773695336; x=
	1773781736; bh=F19cSU3nmmuLBrIsVvofnL9FVy4n58PucEuAq5SxfJs=; b=F
	qFXwESJ6+6tdrAKIaP5/o/sWIntxp8fFSz84RzxIvvm4aiucZX7+zlPo3pNgtztz
	I8k1NyMTztJUKqUVR1DEeJG8bANsaA8m/kGxr7xAehVfJy5/A1MYdRvaznUuwjR/
	LK0P7GUhx8zd2C+J26DqEZ0MxUwX/2+Qc/3CRAFhMS2YysKZl5LPJgZZZeGLqPzm
	f/MN2CD/too9uf4V682DOb9wukWe2J7/rU07kznETSlm0jxr2gtLLTnltgyJtCHg
	QGYQYzstaeGFeC/Ov0UuZ83yGneSbngpjGcK6zWL9d/5HzJ2fKfCdDW86W4Pg31E
	e3ZEwfwfJksfJTx1ibQ8Q==
X-ME-Sender: <xms:Z3G4aWjM5YQ0UkPQVbTTTiuNaUaFWJHzIWFkzSjA55x7KMeeQx44eg>
    <xme:Z3G4aYii_jAy5VQCX5UgnL6fXxNrBTvUEUC_j2w7m4BsmvGXI435AwjGgJMo5qihg
    GftfxYOKIoEfnVJcrlLyXLMWAexfJHClsHX6E_WBT-Whz0_ayOT>
X-ME-Received: <xmr:Z3G4aeIg55wLN8rk_kImHWGDi0yG4ZeNfuyrwx1W4kIvCZc_Cu0LTmdsthE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvleelgedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkjghfofggtgfgsehtjeertdertddvnecuhfhrohhmpeetlhgvgicu
    hghilhhlihgrmhhsohhnuceorghlvgigsehshhgriigsohhtrdhorhhgqeenucggtffrrg
    htthgvrhhnpeekheejieetffefueeiteejtdejffdvleelvdeuvdffvdefteeghfevkeeu
    vdefvdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomheprghlvgigsehshhgriigsohhtrdhorhhg
    pdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehjkh
    hoohhlshhtrhgrseigshegrghllhdrnhhlpdhrtghpthhtohepghhrvghgkhhhsehlihhn
    uhigfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtohepkhhvmhesvhhgvghrrdhkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhk
    vghrnhgvlhdrohhrghdprhgtphhtthhopegrlhgvgiesshhhrgiisghothdrohhrgh
X-ME-Proxy: <xmx:Z3G4afFlSMZr8yOQEmUqe-ogNqYmE9o0nC4Wui2C6JieLdhPKDCK5w>
    <xmx:Z3G4aaQ1z8aMo7QavX_IBf0g0KF00bprEYNx7nc3q06x086S4EBzaA>
    <xmx:Z3G4aTdwDHNK9KVH_SxbtCPeXQ8Z-jeZtEfbnRM1eQa1VZRysZlLBA>
    <xmx:Z3G4aRqMlJZndDgl5RxYuTiVgn83ZQFs6zEUzfZIlDIm6r-UGKq08g>
    <xmx:aHG4aSs8oaM3sLvMGqqliaI-rjKDV51_fkdU9qIecqiGL8Cl3vNj-ZlK>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Mar 2026 17:08:55 -0400 (EDT)
Date: Mon, 16 Mar 2026 15:08:53 -0600
From: Alex Williamson <alex@shazbot.org>
To: Jori Koolstra <jkoolstra@xs4all.nl>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, kvm@vger.kernel.org
 (open list:VFIO DRIVER), linux-kernel@vger.kernel.org (open list),
 alex@shazbot.org
Subject: Re: [PATCH] vfio: replace vfio->device_class with a const struct
 class
Message-ID: <20260316150853.68d37089@shazbot.org>
In-Reply-To: <20260306204032.353452-1-jkoolstra@xs4all.nl>
References: <20260306204032.353452-1-jkoolstra@xs4all.nl>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  6 Mar 2026 21:40:31 +0100
Jori Koolstra <jkoolstra@xs4all.nl> wrote:

> The class_create() call has been deprecated in favor of class_register()
> as the driver core now allows for a struct class to be in read-only
> memory. Replace vfio->device_class with a const struct class and drop
> the class_create() call.
> 
> Compile tested with both CONFIG_VFIO_DEVICE_CDEV on and off (and
> CONFIG_VFIO on); found no errors/warns in dmesg.
> 
> Link: https://lore.kernel.org/all/2023040244-duffel-pushpin-f738@gregkh/
> 
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
> ---
>  drivers/vfio/device_cdev.c |  8 +-------
>  drivers/vfio/vfio.h        |  4 ++--
>  drivers/vfio/vfio_main.c   | 27 ++++++++++++++++-----------
>  3 files changed, 19 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/vfio/device_cdev.c b/drivers/vfio/device_cdev.c
> index 8ceca24ac136..f926685a371d 100644
> --- a/drivers/vfio/device_cdev.c
> +++ b/drivers/vfio/device_cdev.c
> @@ -293,14 +293,8 @@ int vfio_df_ioctl_detach_pt(struct vfio_device_file *df,
>  	return 0;
>  }
>  
> -static char *vfio_device_devnode(const struct device *dev, umode_t *mode)
> +int vfio_cdev_init(const struct class *device_class)
>  {
> -	return kasprintf(GFP_KERNEL, "vfio/devices/%s", dev_name(dev));
> -}
> -
> -int vfio_cdev_init(struct class *device_class)
> -{
> -	device_class->devnode = vfio_device_devnode;

device_class is no longer used in the function, we should drop the
parameter rather than change it to a const.  Thanks,

Alex

>  	return alloc_chrdev_region(&device_devt, 0,
>  				   MINORMASK + 1, "vfio-dev");
>  }
> diff --git a/drivers/vfio/vfio.h b/drivers/vfio/vfio.h
> index 50128da18bca..fdc918771b05 100644
> --- a/drivers/vfio/vfio.h
> +++ b/drivers/vfio/vfio.h
> @@ -378,7 +378,7 @@ int vfio_device_fops_cdev_open(struct inode *inode, struct file *filep);
>  long vfio_df_ioctl_bind_iommufd(struct vfio_device_file *df,
>  				struct vfio_device_bind_iommufd __user *arg);
>  void vfio_df_unbind_iommufd(struct vfio_device_file *df);
> -int vfio_cdev_init(struct class *device_class);
> +int vfio_cdev_init(const struct class *device_class);
>  void vfio_cdev_cleanup(void);
>  #else
>  static inline void vfio_init_device_cdev(struct vfio_device *device)
> @@ -411,7 +411,7 @@ static inline void vfio_df_unbind_iommufd(struct vfio_device_file *df)
>  {
>  }
>  
> -static inline int vfio_cdev_init(struct class *device_class)
> +static inline int vfio_cdev_init(const struct class *device_class)
>  {
>  	return 0;
>  }
> diff --git a/drivers/vfio/vfio_main.c b/drivers/vfio/vfio_main.c
> index 742477546b15..eecf8a1a5237 100644
> --- a/drivers/vfio/vfio_main.c
> +++ b/drivers/vfio/vfio_main.c
> @@ -49,7 +49,6 @@
>  #define VFIO_MAGIC 0x5646494f /* "VFIO" */
>  
>  static struct vfio {
> -	struct class			*device_class;
>  	struct ida			device_ida;
>  	struct vfsmount			*vfs_mount;
>  	int				fs_count;
> @@ -64,6 +63,16 @@ MODULE_PARM_DESC(enable_unsafe_noiommu_mode, "Enable UNSAFE, no-IOMMU mode.  Thi
>  
>  static DEFINE_XARRAY(vfio_device_set_xa);
>  
> +static char *vfio_device_devnode(const struct device *dev, umode_t *mode)
> +{
> +	return kasprintf(GFP_KERNEL, "vfio/devices/%s", dev_name(dev));
> +}
> +
> +static const struct class vfio_device_class = {
> +	.name		= "vfio-dev",
> +	.devnode	= vfio_device_devnode
> +};
> +
>  int vfio_assign_device_set(struct vfio_device *device, void *set_id)
>  {
>  	unsigned long idx = (unsigned long)set_id;
> @@ -299,7 +308,7 @@ static int vfio_init_device(struct vfio_device *device, struct device *dev,
>  
>  	device_initialize(&device->device);
>  	device->device.release = vfio_device_release;
> -	device->device.class = vfio.device_class;
> +	device->device.class = &vfio_device_class;
>  	device->device.parent = device->dev;
>  	return 0;
>  
> @@ -1783,13 +1792,11 @@ static int __init vfio_init(void)
>  		goto err_virqfd;
>  
>  	/* /sys/class/vfio-dev/vfioX */
> -	vfio.device_class = class_create("vfio-dev");
> -	if (IS_ERR(vfio.device_class)) {
> -		ret = PTR_ERR(vfio.device_class);
> +	ret = class_register(&vfio_device_class);
> +	if (ret)
>  		goto err_dev_class;
> -	}
>  
> -	ret = vfio_cdev_init(vfio.device_class);
> +	ret = vfio_cdev_init(&vfio_device_class);
>  	if (ret)
>  		goto err_alloc_dev_chrdev;
>  
> @@ -1798,8 +1805,7 @@ static int __init vfio_init(void)
>  	return 0;
>  
>  err_alloc_dev_chrdev:
> -	class_destroy(vfio.device_class);
> -	vfio.device_class = NULL;
> +	class_unregister(&vfio_device_class);
>  err_dev_class:
>  	vfio_virqfd_exit();
>  err_virqfd:
> @@ -1812,8 +1818,7 @@ static void __exit vfio_cleanup(void)
>  	vfio_debugfs_remove_root();
>  	ida_destroy(&vfio.device_ida);
>  	vfio_cdev_cleanup();
> -	class_destroy(vfio.device_class);
> -	vfio.device_class = NULL;
> +	class_unregister(&vfio_device_class);
>  	vfio_virqfd_exit();
>  	vfio_group_cleanup();
>  	xa_destroy(&vfio_device_set_xa);
> 
> base-commit: d466c332e106fe666d1e2f5a24d08e308bebbfa1

