Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6965238A71C;
	Thu,  2 Apr 2026 22:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775168977; cv=none; b=DBps1QLoa3jqBrNr5WRgvjetYHo0BClwqCEaVBofrzQpKt+vnoX3K195MRnKLDlvypJiBG9wD2VFPrmtB62DZpvT5TZyQnni/caHFA0M4GxDQCKrZmEPYWol+tOJwLEnjbC7QcGpQZD7hVs79DTUwzhDrDr2gbKTHAlNkgcw750=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775168977; c=relaxed/simple;
	bh=rEZCEC5WCBJLrcRl6GsNpDI3e2jqbNc2qolUvPRhdSE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P1r12rshDamdKBio8mo1+3ri7QzTwTiUIwrFAGVWfYKj3DGs80/RMinUuhnOWPO9XjSo0kFcZrF5KGoToVWsw/hP0J5Y7JlssyZnjrBrAj2hPa2R/iVWRVUh6Q4xLflN4+f6zkW+2S6ywlVhfH56aVSZKHOunHvIUMzKlE738fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=azqyXW3J; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=inqZoFgr; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="azqyXW3J";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="inqZoFgr"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 860F314003B9;
	Thu,  2 Apr 2026 18:29:33 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 02 Apr 2026 18:29:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1775168973;
	 x=1775255373; bh=RYPWk4ThIXYzYZwhvD5RXbJ5DH6vPqNq58KFt+C7erI=; b=
	azqyXW3JZEcHirYpRKkGnHOQvz6D7SVhfd+wstxUxBrB+x4BIa5PJlLEeZAiKUR/
	GLdxZ6l8FBqpHK6EPaozrz3TrpXTB68nBX8Sn8+qNgWuN62RxUhYn/XVLV4FnslC
	uHgktFzjSdhaLW+kTpSUobwBUZjw66hgipmMC4zwmeD8DXeZs7l88kl6x2tuCrLi
	qh5MjBkC19hHao64OQjD8n52HdSbB6LGQ0GyHAV9S6h8rm47bYSlLG0gHFJA8S/N
	juJsWSvAteNwOIOUE7pqx70IzRkSp1nbOjjAn/NUn0YYpZzICpgjgsWi9fts3c2R
	NqBciuTI5iL89g//B45fiQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1775168973; x=
	1775255373; bh=RYPWk4ThIXYzYZwhvD5RXbJ5DH6vPqNq58KFt+C7erI=; b=i
	nqZoFgrOp1thL0OHzGPn/n8vbMvQBCRp57VTp6wao+D5WjtyWBAXhy84+hzvnBG5
	Ew4Q/cf0+Ckc0WVaFcZKq5lgO9sZRitl7DFfdmJim0G9rEKC8Bz7L0VwCK3gr7HN
	fGEkTzkGfGqbLHgte2+935FciGxE5JtoWRYJ3Scp/6RDIo8UJEms0zDSlSC/S5ib
	kUntgskW1nyQ0FJet3JaKG4liNBXOmwxzrr4ta12/1DFoEGTpC11Fz9iXy2994SK
	UnWkF1hIOF1eJSosuwUnIUCEd8K6Rm5DPeCSTXqfPHPMSU++mCxOA5mr7QwrnHdm
	TEUXmsXqJjq1PyJmq9BgA==
X-ME-Sender: <xms:ze3OaWjTmqKctDrLOxOqwVyTqIBkwpl-ks3b4j0ykemNU0LaOP6VgA>
    <xme:ze3OaRCRpN6Flknyv3mXGgmJc0otuD-cLoKRvrUqRuh7VVyttrGOE8p1PnmU6gHdO
    YBPIa0WDPQZBeJBLEscB6p1YXFy4aHfZdKLl2BHwd6zt-EHwKMWsQ>
X-ME-Received: <xmr:ze3OaUuyZGnHmoqZICUAGbu4ghaNfmFb1jkqa05pXzrphiJO6-tXHDHlaUs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdejvdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfgjfhfogggtgfesthejredtre
    dtvdenucfhrhhomheptehlvgigucghihhllhhirghmshhonhcuoegrlhgvgiesshhhrgii
    sghothdrohhrgheqnecuggftrfgrthhtvghrnhepvdekfeejkedvudfhudfhteekudfgud
    eiteetvdeukedvheetvdekgfdugeevueeunecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomheprghlvgigsehshhgriigsohhtrdhorhhgpdhnsggprh
    gtphhtthhopeekpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegrnhhkihhtrges
    nhhvihguihgrrdgtohhmpdhrtghpthhtohepjhhgghesiihivghpvgdrtggrpdhrtghpth
    htohephihishhhrghihhesnhhvihguihgrrdgtohhmpdhrtghpthhtohepshhkohhlohht
    hhhumhhthhhosehnvhhiughirgdrtghomhdprhgtphhtthhopehkvghvihhnrdhtihgrnh
    esihhnthgvlhdrtghomhdprhgtphhtthhopehkvhhmsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrd
    horhhgpdhrtghpthhtoheprghlvgigsehshhgriigsohhtrdhorhhg
X-ME-Proxy: <xmx:ze3OaddJ65-b2SCo6kRCrrkan8upGahQDGPVF20t3x3NDOBGzbuMbQ>
    <xmx:ze3OaR_rfIIXfnt6t1eVWiPenpN2stAkOzialZq6EuHZZmsrW9-PPg>
    <xmx:ze3OaYTWtZ8UN63z1CNybhTJbrniMi9_tXWjvTbuuiWcZOHqWg34Nw>
    <xmx:ze3OaSrD9B8HT0kwADfp1T_xWZz4GWhB9YGEYB9zVO_Gu7Q1PN2BqQ>
    <xmx:ze3OabAgBhjVI2Aubq1XhKbxTJx55CuUpUo8CEeSFLdHSoCKxrX5ZSuJ>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Apr 2026 18:29:32 -0400 (EDT)
Date: Thu, 2 Apr 2026 16:29:31 -0600
From: Alex Williamson <alex@shazbot.org>
To: <ankita@nvidia.com>
Cc: <jgg@ziepe.ca>, <yishaih@nvidia.com>, <skolothumtho@nvidia.com>,
 <kevin.tian@intel.com>, <kvm@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, alex@shazbot.org
Subject: Re: [PATCH v1 1/1] vfio/nvgrace-gpu: Add Blackwell-Next GPU
 readiness check via CXL DVSEC
Message-ID: <20260402162931.23df3c5a@shazbot.org>
In-Reply-To: <20260330054220.620049-1-ankita@nvidia.com>
References: <20260330054220.620049-1-ankita@nvidia.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 30 Mar 2026 05:42:20 +0000
<ankita@nvidia.com> wrote:

> From: Ankit Agrawal <ankita@nvidia.com>
> 
> Blackwell-Next GPUs report device readiness via the CXL DVSEC Range 1 Low
> register (offset 0x1C) instead of the BAR0 HBM training register used by
> GB200. The GPU memory readiness is checked by polling for the Memory_Active
> bit (bit 1) for the Memory_Active_Timeout (bits 15:13).
> 
> Add runtime detection by checking the presence of the DVSEC register.
> Wire a wait_device_ready ops pointer on nvgrace_gpu_pci_core_device,
> which is set at probe to either the Blackwell-Next (CXL DVSEC) or
> legacy variant.
> 
> Signed-off-by: Ankit Agrawal <ankita@nvidia.com>
> ---
>  drivers/vfio/pci/nvgrace-gpu/main.c | 80 ++++++++++++++++++++++++++---
>  1 file changed, 72 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/vfio/pci/nvgrace-gpu/main.c b/drivers/vfio/pci/nvgrace-gpu/main.c
> index fa056b69f899..8b6b3577a8ea 100644
> --- a/drivers/vfio/pci/nvgrace-gpu/main.c
> +++ b/drivers/vfio/pci/nvgrace-gpu/main.c
> @@ -34,6 +34,12 @@
>  #define HBM_TRAINING_BAR0_OFFSET 0x200BC
>  #define STATUS_READY 0xFF
>  
> +#define CXL_DEVICE_DVSEC_ID		0
> +#define CXL_DVSEC_RANGE_1_LOW		0x1C
> +#define CXL_DVSEC_MEMORY_VALID		BIT(0)
> +#define CXL_DVSEC_MEMORY_ACTIVE		BIT(1)

Looks like pci_regs.h has all these:

#define PCI_DVSEC_CXL_DEVICE                            0
#define  PCI_DVSEC_CXL_RANGE_SIZE_LOW(i)                (0x1C + (i * 0x10))
#define   PCI_DVSEC_CXL_MEM_INFO_VALID                  _BITUL(0)
#define   PCI_DVSEC_CXL_MEM_ACTIVE                      _BITUL(1)

We should search and replace to use the common macros and drop our
local versions.

> +#define CXL_DVSEC_MEMORY_ACTIVE_TIMEOUT	GENMASK(15, 13)
> +
>  #define POLL_QUANTUM_MS 1000
>  #define POLL_TIMEOUT_MS (30 * 1000)
>  
> @@ -64,6 +70,10 @@ struct nvgrace_gpu_pci_core_device {
>  	bool has_mig_hw_bug;
>  	/* GPU has just been reset */
>  	bool reset_done;
> +	/* CXL Device DVSEC offset; 0 if not present (legacy GB path) */
> +	int cxl_dvsec;
> +	int (*wait_device_ready)(struct nvgrace_gpu_pci_core_device *nvdev,
> +				 void __iomem *io);
>  };
>  
>  static void nvgrace_gpu_init_fake_bar_emu_regs(struct vfio_device *core_vdev)
> @@ -242,7 +252,8 @@ static void nvgrace_gpu_close_device(struct vfio_device *core_vdev)
>  	vfio_pci_core_close_device(core_vdev);
>  }
>  
> -static int nvgrace_gpu_wait_device_ready(void __iomem *io)
> +static int nvgrace_gpu_wait_device_ready_legacy(struct nvgrace_gpu_pci_core_device *nvdev,
> +						void __iomem *io)
>  {
>  	unsigned long timeout = jiffies + msecs_to_jiffies(POLL_TIMEOUT_MS);
>  
> @@ -256,6 +267,52 @@ static int nvgrace_gpu_wait_device_ready(void __iomem *io)
>  	return -ETIME;
>  }
>  
> +/*
> + * Decode the 3-bit Memory_Active_Timeout field from CXL DVSEC Range 1 Low

Is this range 1 or range 0 bits?  The pci_regs.h macro suggests 0.
Same for the commit log.

> + * (bits 15:13) into milliseconds. Encoding per CXL spec r4.0 sec 8.1.3.8.2:
> + * 000b = 1s, 001b = 4s, 010b = 16s, 011b = 64s, 100b = 256s,
> + * 101b-111b = reserved (clamped to 256s).
> + */
> +static inline unsigned long nvgrace_gpu_cxl_mem_active_timeout_ms(u8 timeout)
> +{
> +	return 1000UL << (2 * min_t(u8, timeout, 4));
> +}
> +
> +static int nvgrace_gpu_wait_device_ready_bw_next(struct nvgrace_gpu_pci_core_device *nvdev,
> +						 void __iomem *io)
> +{
> +	struct pci_dev *pdev = nvdev->core_device.pdev;
> +	int pcie_dvsec = nvdev->cxl_dvsec;
> +	unsigned long timeout;
> +	u32 dvsec_memory_status;
> +	u8 mem_active_timeout;
> +
> +	pci_read_config_dword(pdev, pcie_dvsec + CXL_DVSEC_RANGE_1_LOW,
> +			      &dvsec_memory_status);
> +
> +	if (!(dvsec_memory_status & CXL_DVSEC_MEMORY_VALID))
> +		return -ENODEV;
> +
> +	mem_active_timeout = FIELD_GET(CXL_DVSEC_MEMORY_ACTIVE_TIMEOUT,
> +				       dvsec_memory_status);
> +
> +	timeout = jiffies +
> +		  msecs_to_jiffies(nvgrace_gpu_cxl_mem_active_timeout_ms(mem_active_timeout));
> +
> +	do {
> +		pci_read_config_dword(pdev,
> +				      pcie_dvsec + CXL_DVSEC_RANGE_1_LOW,
> +				      &dvsec_memory_status);
> +
> +		if (dvsec_memory_status & CXL_DVSEC_MEMORY_ACTIVE)
> +			return 0;
> +
> +		msleep(POLL_QUANTUM_MS);
> +	} while (!time_after(jiffies, timeout));
> +
> +	return -ETIME;
> +}
> +
>  /*
>   * If the GPU memory is accessed by the CPU while the GPU is not ready
>   * after reset, it can cause harmless corrected RAS events to be logged.
> @@ -275,7 +332,7 @@ nvgrace_gpu_check_device_ready(struct nvgrace_gpu_pci_core_device *nvdev)
>  	if (!__vfio_pci_memory_enabled(vdev))
>  		return -EIO;
>  
> -	ret = nvgrace_gpu_wait_device_ready(vdev->barmap[0]);
> +	ret = nvdev->wait_device_ready(nvdev, vdev->barmap[0]);

A bit of a nit, but it's a little redundant to have both cxl_dvsec and
.wait_device_ready on the object.  It also presents the problem that
each variant has the same prototype, but requires a different
parameter.  Wouldn't a wrapper be a bit cleaner instead?

static inline int nvgrace_gpu_wait_device_ready(struct nvgrace_gpu_pci_core_device *nvdev,
                                                void __iomem *io)
{
	return nvdev->cxl_dvsec ?
		nvgrace_gpu_wait_device_ready_bw_next(nvdev) :
		nvgrace_gpu_wait_device_ready_legacy(io);
}


	ret = nvgrace_gpu_wait_device_ready(nvdev, vdev->barmap[0]);

Thanks,
Alex

>  	if (ret)
>  		return ret;
>  
> @@ -1146,8 +1203,9 @@ static bool nvgrace_gpu_has_mig_hw_bug(struct pci_dev *pdev)
>   * Ensure that the BAR0 region is enabled before accessing the
>   * registers.
>   */
> -static int nvgrace_gpu_probe_check_device_ready(struct pci_dev *pdev)
> +static int nvgrace_gpu_probe_check_device_ready(struct nvgrace_gpu_pci_core_device *nvdev)
>  {
> +	struct pci_dev *pdev = nvdev->core_device.pdev;
>  	void __iomem *io;
>  	int ret;
>  
> @@ -1165,7 +1223,7 @@ static int nvgrace_gpu_probe_check_device_ready(struct pci_dev *pdev)
>  		goto iomap_exit;
>  	}
>  
> -	ret = nvgrace_gpu_wait_device_ready(io);
> +	ret = nvdev->wait_device_ready(nvdev, io);
>  
>  	pci_iounmap(pdev, io);
>  iomap_exit:
> @@ -1183,10 +1241,6 @@ static int nvgrace_gpu_probe(struct pci_dev *pdev,
>  	u64 memphys, memlength;
>  	int ret;
>  
> -	ret = nvgrace_gpu_probe_check_device_ready(pdev);
> -	if (ret)
> -		return ret;
> -
>  	ret = nvgrace_gpu_fetch_memory_property(pdev, &memphys, &memlength);
>  	if (!ret)
>  		ops = &nvgrace_gpu_pci_ops;
> @@ -1198,6 +1252,16 @@ static int nvgrace_gpu_probe(struct pci_dev *pdev,
>  
>  	dev_set_drvdata(&pdev->dev, &nvdev->core_device);
>  
> +	nvdev->cxl_dvsec = pci_find_dvsec_capability(pdev, PCI_VENDOR_ID_CXL,
> +						     CXL_DEVICE_DVSEC_ID);
> +	nvdev->wait_device_ready = nvdev->cxl_dvsec ?
> +		nvgrace_gpu_wait_device_ready_bw_next :
> +		nvgrace_gpu_wait_device_ready_legacy;
> +
> +	ret = nvgrace_gpu_probe_check_device_ready(nvdev);
> +	if (ret)
> +		goto out_put_vdev;
> +
>  	if (ops == &nvgrace_gpu_pci_ops) {
>  		nvdev->has_mig_hw_bug = nvgrace_gpu_has_mig_hw_bug(pdev);
>  

