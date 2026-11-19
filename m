Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795100186;
	b=hzJw1l7AxjEhUT4rKLSLxLZ4mysQ4OhAeyg14ddsp/Dcxe7SiTe9dFTUCNy1ErJ96Wcf
	 6yMFLs0aU5sD7aYNWXKQwknQit13aiiTCkYx0C/nHeAsmJ0a1SICrdSiEn3SxKecY3j9E
	 WfTgkk63XHcMxNf0h2AbXi5VUhrxdazds9xrMhRE55weNX2PFbAESvgPee+jIiXtTFo5l
	 sutmxYvUV3X794LeldTo+7NlLUHF0mPfDdEEGNY+VxMQCBqUevZyb3qddG3C8DprcOdD/
	 1i9vuPLy7+y19EbtO7nqon7saNC4pWZL+N6lZ9tMqFIhje02JR4v5ZzY+LHUYy1YWNw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795100186;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=bMbyjACtLzAau3mHjynkxDTW6eWUIU5ieVZSzXwOIHE=;
	b=RsOQPG+aNljkNFv759Dp2WLb1SVDHz+VGYLK+KilXh0nn+VpyYHFJ5ap2YaowZFviXEj
	 oXNNz2zaIGo5akUcU+nzERv0A2hqkG07Aro/8cnEMt3PRPOHQKpsqjJ555L5ZqSEaZTil
	 e1ZP6zXcjCoUPFcSbaS6ukleH+t2bXZejp4f7MW4NFxPUpUiYLHF/roeKFfRsSRq9lBrD
	 lxvAp9d2NjhrTR/ajb45RZMGXeXoSW57u3Elg5IxOJs5e42LOVjU5KEKMpj0cUI9aSKcN
	 rYjBcgAiS5sar6oG3v6lQU9JrHQ+c0+VGa0hbkmF0ZF5jK2vHuttmGOsVcRrRB30tuQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=b5TUgwvF;
	arc=none smtp.remote-ip=209.85.128.48
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB62606A325
	for <kvm@vger.kernel.org>; Thu, 19 Nov 2026 14:56:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DAB62606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=b5TUgwvF
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4bb5b33e2ffso44715e9.1
        for <kvm@vger.kernel.org>; Thu, 19 Nov 2026 06:56:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795100184; x=1795704984; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=bMbyjACtLzAau3mHjynkxDTW6eWUIU5ieVZSzXwOIHE=;
        b=b5TUgwvFYcVrC0LOg2IULJtqFlnDVpcYRRC0cTfg9QswAYhwPZPDrcQIrzjwvc0wn5
         EzRGpwmbzA4Xmk7HpuJ8jv+2WMpZDpPgeKn3UJNXnnlXY0qdnMCWJfehEc5j9Ljb2oMs
         3IzLQXakIPjzLFv/aL8+6AkfgnY0SvdM93E0JAw3YXjYdV3REyGnxAXXJgAiEQW7ijix
         R1LQpKuwdNosskHSJKsqlyFrXAbR8Ot53tL0esWuTGOnAU94+vKQfiDR+Uju/SvWhVQz
         BYoUvJHfHGz2Xt+gabEjfbYvc16kUz2ROiveyuaRLmHo2qjBMzm9u24OULe1pgf0W0Lm
         E0OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795100184; x=1795704984;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=bMbyjACtLzAau3mHjynkxDTW6eWUIU5ieVZSzXwOIHE=;
        b=VaZu2JuDkUZo6WQ0J8Lpt1yeFQ5xuCnM9MgUja9S204yGpF3tjpvJeWXbsQiYfscBi
         cM7xoE9WBuQeHAs8Cd84fyCUqDjnS7V0SGC7iAitAyPbeHKzmMFMM5ocyQYEHtJqpyxo
         b9K1FhJx+SzL52mTXja7ATkeE2ueM00WrBkPi89vyTwLWdBiRwlESnrJbgT9s4Brd4KI
         qnGoWDxkJSKMFU4l2QjEhnp5ULqwG0Ea4urPKVEItBrEJqHRWOyFak7NAZPq3MeuorJr
         qNX/K+9aV2xjIokSPbqTLeevuB9AhPCCEy2mJkVUhO68pRyQsaPY1EL1j4pKOzXZEL3a
         JiAQ==
X-Forwarded-Encrypted: i=1; AL+hErFlMA2Pu6nyNfm7FqAhL+8RZ21SXkfMiQ7DCBkFB7IvV8WvhgctkB5TJGvn93+XpNvXobY=@vger.kernel.org
X-Gm-Message-State: APuU4Z/n2oM0z5NYw6noXEk3sKBz4fzEjCX1QklHRUjP2FrRracsRs5O
	mG+zVBuomzMKM+WrfTlvgigH60yNOiM3DFO+9b8NjqK74zZDASkK5HjG7XQ2srnmhA==
X-Gm-Gg: AYBFou2ODL2hRUqxf343B6FVj/0ef4536OQhwN5Anbo7QD/ryazDURoZbiL7JZkOxAC
	/zr9aGNcCP/yyUJC2lCzz4w6w3bwU+LZjZT0mYQ+/DfGLInSA5DeL52xQhvVcMoafgzGZ+Z+Wvy
	i2UZIcEGTgLDmMpqkDBISgXSIJuDiOFSBXvAmZRyMJr7LtLhlpwtnaCict6ztweq/TdMdaClR9V
	Cw8X2XmJIgHBh4jpPnjn0Qg/ZI2ENACjjJhLy8+teZpGVcqs/EqWemfNE5OvZOW1m8Z2B6+pjpD
	AUhQNDoa+jeFq9dMNjjZmyd5eMe8gTPRWiug78Oi9654QoTb3Vtk1SGLYVVBApXC97frIjf7qTf
	JOgyRV2M14cPILDw9XTy4tDoj3l3uCYnRGZM3591pHzO5B43nc0pgyomgZ1TAtJRcZm+OBV+YpJ
	xhicXOeDWem+VrARfCVZRVFq2DrHO8WMm/DxWXp52FFNgWTYz9A7qQZslxP9em00aAIKjfzJbDk
	OAj5WRTc4EUNNMPtUgVXlpdCnOUIdx2mTNiOo54SjsOAUOYcwy2+axmGF3jAWPNMc+svNlG/pjr
	pQksZWJevd9sQEgXVqRwKSac7LK40/Jc1o4ICuWXzEbTUgxLikTWQgFdn5MSz3ZeXu2NRH8=
X-Received: by 2002:a05:600c:1d01:b0:4a1:e384:5e12 with SMTP id 5b1f17b1804b1-4bb85193dc1mr748295e9.7.1795100183663;
        Thu, 19 Nov 2026 06:56:23 -0800 (PST)
Received: from google.com (160.193.189.35.bc.googleusercontent.com. [35.189.193.160])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb853b216esm43338685e9.12.2026.11.19.06.56.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 06:56:22 -0800 (PST)
Date: Thu, 19 Nov 2026 14:56:18 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Alex Williamson <alex@shazbot.org>
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, Johan Hovold <johan@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	David Lechner <dlechner@baylibre.com>, Armin Wolf <W_Armin@gmx.de>,
	Thierry Reding <thierry.reding@kernel.org>,
	Mike Rapoport <rppt@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Karl Mehltretter <kmehltretter@gmail.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Marco Elver <elver@google.com>,
	Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	Jeff Layton <jlayton@kernel.org>,
	Bradley Morgan <brads@mainlining.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Petr Mladek <pmladek@suse.com>,
	Pnina Feder <pnina.feder@mobileye.com>,
	Mete Durlu <meted@linux.ibm.com>,
	Aaron Tomlin <atomlin@atomlin.com>,
	Rio <rioo.tsukatsukii@gmail.com>,
	Feng Tang <feng.tang@linux.alibaba.com>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, driver-core@lists.linux.dev,
	linux-trace-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Longfang Liu <liulongfang@huawei.com>,
	Ankit Agrawal <ankita@nvidia.com>,
	Brett Creeley <brett.creeley@amd.com>,
	Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
	=?utf-8?Q?Micha=C5=82?= Winiarski <michal.winiarski@intel.com>,
	Julian Ruess <julianr@linux.ibm.com>,
	Nipun Gupta <nipun.gupta@amd.com>,
	Nikhil Agarwal <nikhil.agarwal@amd.com>,
	Eric Auger <eric.auger@redhat.com>,
	Pranjal Shrivastava <praan@google.com>,
	Ioana Ciornei <ioana.ciornei@nxp.com>, qat-linux@intel.com,
	virtualization@lists.linux.dev, intel-xe@lists.freedesktop.org,
	kvm@vger.kernel.org
Subject: Re: [PATCH] vfio: Allow untainted use of driver_override
Message-ID: <av8OEgaW0jEJC1OF@google.com>
References: <DMYH4ED3GWDO.29DGXPK4M82VR@kernel.org>
 <20261118235645.2907908-2-alex@shazbot.org>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261118235645.2907908-2-alex@shazbot.org>

On Wed, Nov 18, 2026 at 04:56:44PM -0700, Alex Williamson wrote:
> Driver overrides are the standard mechanism for binding vfio drivers
> to devices.  With the introduction of the support_driver_override flag
> in the core driver struct, it's now required for drivers to declare
> themselves as driver_override compatible, otherwise driver_override
> bindings will be denied or generate a kernel taint.
> 
> Set the support_driver_override flag on the driver struct across all
> vfio drivers.
> 
> Cc: Yishai Hadas <yishaih@nvidia.com>
> Cc: Longfang Liu <liulongfang@huawei.com>
> Cc: Ankit Agrawal <ankita@nvidia.com>
> Cc: Brett Creeley <brett.creeley@amd.com>
> Cc: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
> Cc: Michał Winiarski <michal.winiarski@intel.com>
> Cc: Julian Ruess <julianr@linux.ibm.com>
> Cc: Nipun Gupta <nipun.gupta@amd.com>
> Cc: Nikhil Agarwal <nikhil.agarwal@amd.com>
> Cc: Eric Auger <eric.auger@redhat.com>
> Cc: Mostafa Saleh <smostafa@google.com>
> Cc: Pranjal Shrivastava <praan@google.com>
> Cc: Ioana Ciornei <ioana.ciornei@nxp.com>
> Cc: qat-linux@intel.com
> Cc: virtualization@lists.linux.dev
> Cc: intel-xe@lists.freedesktop.org
> Cc: kvm@vger.kernel.org
> Signed-off-by: Alex Williamson <alex@shazbot.org>

Reviewed-by: Mostafa Saleh <smostafa@google.com>

Thanks,
Mostafa

> ---
> 
> Uwe, this should cover all the vfio drivers that expect to use
> driver_override.  Thanks,
> 
> Alex
> 
>  drivers/vfio/cdx/main.c                        | 1 +
>  drivers/vfio/fsl-mc/vfio_fsl_mc.c              | 1 +
>  drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c | 3 ++-
>  drivers/vfio/pci/ism/main.c                    | 3 ++-
>  drivers/vfio/pci/mlx5/main.c                   | 3 ++-
>  drivers/vfio/pci/nvgrace-gpu/main.c            | 3 ++-
>  drivers/vfio/pci/pds/pci_drv.c                 | 3 ++-
>  drivers/vfio/pci/qat/main.c                    | 3 ++-
>  drivers/vfio/pci/vfio_pci.c                    | 3 ++-
>  drivers/vfio/pci/virtio/main.c                 | 3 ++-
>  drivers/vfio/pci/xe/main.c                     | 3 ++-
>  drivers/vfio/platform/vfio_amba.c              | 1 +
>  drivers/vfio/platform/vfio_platform.c          | 1 +
>  13 files changed, 22 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/vfio/cdx/main.c b/drivers/vfio/cdx/main.c
> index 28dc8c825600..fb7679bf92fd 100644
> --- a/drivers/vfio/cdx/main.c
> +++ b/drivers/vfio/cdx/main.c
> @@ -358,6 +358,7 @@ static struct cdx_driver vfio_cdx_driver = {
>  	.match_id_table	= vfio_cdx_table,
>  	.driver	= {
>  		.name	= "vfio-cdx",
> +		.support_driver_override = true,
>  	},
>  	.driver_managed_dma = true,
>  };
> diff --git a/drivers/vfio/fsl-mc/vfio_fsl_mc.c b/drivers/vfio/fsl-mc/vfio_fsl_mc.c
> index 15b05b8c0c90..1603f81e0257 100644
> --- a/drivers/vfio/fsl-mc/vfio_fsl_mc.c
> +++ b/drivers/vfio/fsl-mc/vfio_fsl_mc.c
> @@ -597,6 +597,7 @@ static struct fsl_mc_driver vfio_fsl_mc_driver = {
>  	.remove		= vfio_fsl_mc_remove,
>  	.driver	= {
>  		.name	= "vfio-fsl-mc",
> +		.support_driver_override = true,
>  	},
>  	.driver_managed_dma = true,
>  };
> diff --git a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
> index c82c59246a3f..5c56aff8db01 100644
> --- a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
> +++ b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
> @@ -1737,7 +1737,8 @@ static struct pci_driver hisi_acc_vfio_pci_driver = {
>  	.id_table = hisi_acc_vfio_pci_table,
>  	.probe = hisi_acc_vfio_pci_probe,
>  	.remove = hisi_acc_vfio_pci_remove,
> -	.driver = { .pm = pm_ptr(&hisi_acc_vf_pm_ops) },
> +	.driver = { .pm = pm_ptr(&hisi_acc_vf_pm_ops),
> +		    .support_driver_override = true },
>  	.err_handler = &hisi_acc_vf_err_handlers,
>  	.driver_managed_dma = true,
>  };
> diff --git a/drivers/vfio/pci/ism/main.c b/drivers/vfio/pci/ism/main.c
> index cce3bdf1f070..263b377e87c4 100644
> --- a/drivers/vfio/pci/ism/main.c
> +++ b/drivers/vfio/pci/ism/main.c
> @@ -399,7 +399,8 @@ static struct pci_driver ism_vfio_pci_driver = {
>  	.id_table = ism_device_table,
>  	.probe = ism_vfio_pci_probe,
>  	.remove = ism_vfio_pci_remove,
> -	.driver	= { .pm = pm_ptr(&ism_vfio_pm_ops) },
> +	.driver	= { .pm = pm_ptr(&ism_vfio_pm_ops),
> +		    .support_driver_override = true },
>  	.err_handler = &ism_vfio_err_handlers,
>  	.driver_managed_dma = true,
>  };
> diff --git a/drivers/vfio/pci/mlx5/main.c b/drivers/vfio/pci/mlx5/main.c
> index 18a6d224b1fd..63c89e461be8 100644
> --- a/drivers/vfio/pci/mlx5/main.c
> +++ b/drivers/vfio/pci/mlx5/main.c
> @@ -1451,7 +1451,8 @@ static struct pci_driver mlx5vf_pci_driver = {
>  	.id_table = mlx5vf_pci_table,
>  	.probe = mlx5vf_pci_probe,
>  	.remove = mlx5vf_pci_remove,
> -	.driver	= { .pm = pm_ptr(&mlx5vf_pm_ops) },
> +	.driver	= { .pm = pm_ptr(&mlx5vf_pm_ops),
> +		    .support_driver_override = true },
>  	.err_handler = &mlx5vf_err_handlers,
>  	.driver_managed_dma = true,
>  };
> diff --git a/drivers/vfio/pci/nvgrace-gpu/main.c b/drivers/vfio/pci/nvgrace-gpu/main.c
> index 5ddec340b73b..946da32c61ff 100644
> --- a/drivers/vfio/pci/nvgrace-gpu/main.c
> +++ b/drivers/vfio/pci/nvgrace-gpu/main.c
> @@ -1438,7 +1438,8 @@ static struct pci_driver nvgrace_gpu_vfio_pci_driver = {
>  	.id_table = nvgrace_gpu_vfio_pci_table,
>  	.probe = nvgrace_gpu_probe,
>  	.remove = nvgrace_gpu_remove,
> -	.driver = { .pm = pm_ptr(&nvgrace_gpu_pm_ops) },
> +	.driver = { .pm = pm_ptr(&nvgrace_gpu_pm_ops),
> +		    .support_driver_override = true },
>  	.err_handler = &nvgrace_gpu_vfio_pci_err_handlers,
>  	.driver_managed_dma = true,
>  };
> diff --git a/drivers/vfio/pci/pds/pci_drv.c b/drivers/vfio/pci/pds/pci_drv.c
> index cf7e33d4d17b..1fcef987f1b0 100644
> --- a/drivers/vfio/pci/pds/pci_drv.c
> +++ b/drivers/vfio/pci/pds/pci_drv.c
> @@ -184,7 +184,8 @@ static struct pci_driver pds_vfio_pci_driver = {
>  	.id_table = pds_vfio_pci_table,
>  	.probe = pds_vfio_pci_probe,
>  	.remove = pds_vfio_pci_remove,
> -	.driver = { .pm = pm_ptr(&pds_vfio_pm_ops) },
> +	.driver = { .pm = pm_ptr(&pds_vfio_pm_ops),
> +		    .support_driver_override = true },
>  	.err_handler = &pds_vfio_pci_err_handlers,
>  	.driver_managed_dma = true,
>  };
> diff --git a/drivers/vfio/pci/qat/main.c b/drivers/vfio/pci/qat/main.c
> index 69448fa57df4..8a616f9b6494 100644
> --- a/drivers/vfio/pci/qat/main.c
> +++ b/drivers/vfio/pci/qat/main.c
> @@ -695,7 +695,8 @@ static struct pci_driver qat_vf_vfio_pci_driver = {
>  	.id_table = qat_vf_vfio_pci_table,
>  	.probe = qat_vf_vfio_pci_probe,
>  	.remove = qat_vf_vfio_pci_remove,
> -	.driver	= { .pm = pm_ptr(&qat_vf_pm_ops) },
> +	.driver	= { .pm = pm_ptr(&qat_vf_pm_ops),
> +		    .support_driver_override = true },
>  	.err_handler = &qat_vf_err_handlers,
>  	.driver_managed_dma = true,
>  };
> diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
> index e7c012febe91..fde2c3fc88eb 100644
> --- a/drivers/vfio/pci/vfio_pci.c
> +++ b/drivers/vfio/pci/vfio_pci.c
> @@ -260,7 +260,8 @@ static struct pci_driver vfio_pci_driver = {
>  	.remove			= vfio_pci_remove,
>  	.sriov_configure	= vfio_pci_sriov_configure,
>  	.err_handler		= &vfio_pci_err_handlers,
> -	.driver		= { .pm = pm_ptr(&vfio_pci_pm_ops) },
> +	.driver		= { .pm = pm_ptr(&vfio_pci_pm_ops),
> +			    .support_driver_override = true },
>  	.driver_managed_dma	= true,
>  };
>  
> diff --git a/drivers/vfio/pci/virtio/main.c b/drivers/vfio/pci/virtio/main.c
> index 123ff5193812..1e02a8fd4a61 100644
> --- a/drivers/vfio/pci/virtio/main.c
> +++ b/drivers/vfio/pci/virtio/main.c
> @@ -222,7 +222,8 @@ static struct pci_driver virtiovf_pci_driver = {
>  	.id_table = virtiovf_pci_table,
>  	.probe = virtiovf_pci_probe,
>  	.remove = virtiovf_pci_remove,
> -	.driver = { .pm = pm_ptr(&virtiovf_pm_ops) },
> +	.driver = { .pm = pm_ptr(&virtiovf_pm_ops),
> +		    .support_driver_override = true },
>  	.err_handler = &virtiovf_err_handlers,
>  	.driver_managed_dma = true,
>  };
> diff --git a/drivers/vfio/pci/xe/main.c b/drivers/vfio/pci/xe/main.c
> index 7dab3e024aa8..e0ab61f604de 100644
> --- a/drivers/vfio/pci/xe/main.c
> +++ b/drivers/vfio/pci/xe/main.c
> @@ -592,7 +592,8 @@ static struct pci_driver xe_vfio_pci_driver = {
>  	.id_table = xe_vfio_pci_table,
>  	.probe = xe_vfio_pci_probe,
>  	.remove = xe_vfio_pci_remove,
> -	.driver = { .pm = pm_ptr(&xe_vfio_pm_ops) },
> +	.driver = { .pm = pm_ptr(&xe_vfio_pm_ops),
> +		    .support_driver_override = true },
>  	.err_handler = &xe_vfio_pci_err_handlers,
>  	.driver_managed_dma = true,
>  };
> diff --git a/drivers/vfio/platform/vfio_amba.c b/drivers/vfio/platform/vfio_amba.c
> index fa754f203b2d..2c87caf1b7f7 100644
> --- a/drivers/vfio/platform/vfio_amba.c
> +++ b/drivers/vfio/platform/vfio_amba.c
> @@ -137,6 +137,7 @@ static struct amba_driver vfio_amba_driver = {
>  	.id_table = vfio_amba_ids,
>  	.drv = {
>  		.name = "vfio-amba",
> +		.support_driver_override = true,
>  	},
>  	.driver_managed_dma = true,
>  };
> diff --git a/drivers/vfio/platform/vfio_platform.c b/drivers/vfio/platform/vfio_platform.c
> index a4d3ace3e02d..93d06032cdde 100644
> --- a/drivers/vfio/platform/vfio_platform.c
> +++ b/drivers/vfio/platform/vfio_platform.c
> @@ -116,6 +116,7 @@ static struct platform_driver vfio_platform_driver = {
>  	.remove		= vfio_platform_remove,
>  	.driver	= {
>  		.name	= "vfio-platform",
> +		.support_driver_override = true,
>  	},
>  	.driver_managed_dma = true,
>  };
> -- 
> 2.54.0
> 
