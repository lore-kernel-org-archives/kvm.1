Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1DEB3B9DA2;
	Tue, 29 Sep 2026 20:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790714189; cv=none; b=di6QnL6M3HUmzPMjFZBRaODKAUg3icwPCcqP2OmAAEuh/fw2bQ0A35YI0jqpSr42cPmJ/3Ps2lEG073srXf2x593tWNH6KONzQqHwxQdKHTHR7eHPdfkxLvKlthwzGvwXfta/rBe1XFRwJrv9X0Tofir/Y1U7YiGAAbnGMxUT60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790714189; c=relaxed/simple;
	bh=Bal+15pWIXPbOBMDO0JB6y85o6OXOA/w+zuFR1fOkVU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=efEld1EmHG3RbSgPwc7rc/rUMtCQVp4QQP6mO4GrMfKeOOjxiViimZqEiPU/w37vxTIl3xZADeocFAnIRBTR2ly4dONDexkPoYrPazTE/Xy4UWFYcLX3ipNXQn7db57TmxrGR1aBrOWPq3I2gDMPcOrgqe3uevfmNcrPaxparF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=kZkrKxH/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=X2GWcpKP; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="kZkrKxH/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="X2GWcpKP"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id C4FCCEC03EC;
	Tue, 29 Sep 2026 16:36:24 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 29 Sep 2026 16:36:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1790714184;
	 x=1790800584; bh=hPljVbvi9YmYO5n6/3vPCJL28ZVMOVnjPDx3oAhNDf4=; b=
	kZkrKxH/tcJ3Bwe3yKzFjma+sc4cU9QyUAwGFAjr1qZUde0THh7TOAj9cZEvIXWv
	YemftTI9MR0cax2QO0VttIzqudrSTDx94jZPM4ypy2bFmJCNValDlJmfUseNrDEy
	7QdaQJ0w2iU3UOniRxy10B5DU8cbsy33C9Uh8tOkhxa/C56JjlSyfAb6ljTttQDO
	TUCfhbbKnSKDJ+TIzXtUQd4diQJG4b0a0DVBOvk13qzaYxjpI2onpYEumwKksoch
	a37c2u2dhKIdJ3rvdKrCm3AC7DHSmvdkcyyCsW3HC0PYMtphwLr4b/LBgJL99h9X
	odM+65FsldD40w9Ye13mkg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790714184; x=
	1790800584; bh=hPljVbvi9YmYO5n6/3vPCJL28ZVMOVnjPDx3oAhNDf4=; b=X
	2GWcpKPwSTO2CGt3Wyap0FicJYE65Ge1DbcoXsiJhiFGEPxMRWZHUzd86/L/B86y
	soflAHjzi+I7XNhx9RcghSFHgBV/AXugPotbH7KsjZknn9QXclN9Z5OLHEFAejUB
	RxnsNXuTNHHxGk1vUPMHEEk27cK6KuIxz0w0SDiJ/jPJAMQkDPbuwQB2jUdiT4+C
	12we8CX3Qy9/1bclynLqlN0UofJuADHDvcIIZwfsAuGb928mRqyuJS9BNd0/Vgrg
	cSY1PotamYUNmT4hQDnqweV2wnxvBRd2NSRHgmhzFwKIYhMzL2NlXmbH60Y6Cyhi
	PYz4yf1muUbUWV4j1V2Hg==
X-ME-Sender: <xms:SCG8amBQNgBNv6ByTqvsLozMjp6ElmOFkyL8CM_eggtdep9bGP-YAw>
    <xme:SCG8ajl6S2xvJpsboV9xEoemYEoizn2FIZtXHyQnzg0HFbbl8MmhlmY53GfUmRmCb
    pDmqPmJuaQf52O21KIG1jFxu9sTQ_DeWX9gdgi70uayh_AQ9BOnHw>
X-ME-Received: <xmr:SCG8akMYnGIP5N-48uRHdqFyIOrdI4bPY9E5bBT_rZ3axrk61hYS08-tK9a0Kg>
X-ME-Proxy-Cause: dmFkZTEF7y/Vd9T7x0lvwKUs+zAlBpBJBmZOrI5bicHq7BacDUrtEVBdsb5un5RsTkgvSB
    fRtMFGKkDKE8DS/DisoEcnVefJST+rlZFImVxTIq5lpt0ypiAGg/EK24XXcp6pmJKDJyUJ
    GbZkQdCCzlmi2QdVqYxEr9n5BnPqgbYDuuSGUnAh+0+twh2PDwi6HbNRiomNaW1F6C5kL5
    hns15P83zYEHn9btkdeA/+C3zP+ff7S6sZKsX2e7vDWX7iM+YEVjqjcSRpLRBRPv5TC5T3
    slVHt2US7n9VbP2Jpm+RrGPopBw7z9AIatbBN2S/dtkOpwiZtBdw+h/YfcMs7M/S4c6GCO
    j5lAXOoin6L307XBEOKLkggK3FD9aYqSrw1uP/kNzd1eZdqYz0+D5LvHMMVUHm3s0YaDqS
    BjSdB2jtrVHLPlVfltsyJbvERWiKHpnTNSaWi0W9iHrBQ9ciXA2qn1y4gwsx0ospYFyFvs
    wtnFgVDvQ3XU2N+7rX8sXjqmyCJSeqphvVr8KwzcPlEiy1aLt+RTVuiBY4jgWxxG3bbg8b
    sU3a2tRsX+G+6Mt0ANE3RgPhc7MezvT8eNeAb+F11Gvb7axHCIxGgg/ndiC8O4JLn6PrAa
    pYVYzMFKey08lXK3sgOeajHQmjVF/QG+Y1ndjHLQfh4DiTEgg+v3kIBjifVQ
X-ME-Proxy: <xmx:SCG8ag_-CItjmffFUtobdRgdhuaQOpwp31kEhYc4P3rxey9DQDs4Xw>
    <xmx:SCG8amEPqhL0-hUo4M7AaBk-RCMbMLD5lv7IJBW1DDhCQUytZxQY3w>
    <xmx:SCG8avjCF8oDsK8Fc2OFMEf4A37maYf0wsCLFrU4SJ1qAk0dxuSOow>
    <xmx:SCG8aruVY7tBFUzfoyT0DleRGh7qGwC8Hi3lxUlEeRbszGSXfQo1BQ>
    <xmx:SCG8arPM4vlPCuvaXg6mQVNr_ebrGlzhU26mOaogtab3f6rxoF97XpF7>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 29 Sep 2026 16:36:23 -0400 (EDT)
Date: Tue, 29 Sep 2026 14:36:21 -0600
From: Alex Williamson <alex@shazbot.org>
To: Abdifatah Suruur <suruurism@gmail.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 eric.auger@redhat.com, smostafa@google.com, praan@google.com,
 ioana.ciornei@nxp.com, nipun.gupta@amd.com, nikhil.agarwal@amd.com,
 alex@shazbot.org
Subject: Re: [PATCH v2 7/7] vfio/cdx: reject non-shared MMIO mmaps
Message-ID: <20260929143621.540f0024@shazbot.org>
In-Reply-To: <20260929094848.7439-8-suruurism@gmail.com>
References: <20260929094848.7439-1-suruurism@gmail.com>
	<20260929094848.7439-8-suruurism@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 29 Sep 2026 12:48:48 +0300
Abdifatah Suruur <suruurism@gmail.com> wrote:

> vfio_cdx_mmap() accepts MAP_PRIVATE mappings.  A non-shared mapping
> with VM_MAYWRITE is a COW mapping, and remap_pfn_range()'s COW special
> case in get_remap_pgoff() then overwrites vma->vm_pgoff with the
> physical frame number:
> 
> 	if (is_cow) {
> 		if (addr != vm_start || end != vm_end)
> 			return -EINVAL;
> 		*vm_pgoff_p = pfn;
> 	}
> 
> The VMA is inserted into the device file's mapping->i_mmap interval
> tree keyed by vm_pgoff, which VFIO expects to be the logical file
> offset: the core links every device mmap to the device inode's
> i_mapping precisely so that unmap_mapping_range() can revoke all
> mappings associated with a device (see vfio_device_cdev_open()).

It's actually vfio_device_open_file() and vfio_device_fops_cdev_open(),
vfio_device_cdev_open() doesn't exist.
 
> A raw PFN in vm_pgoff lands the interval tree entry in the wrong
> coordinate space, so unmap_mapping_range() cannot find the VMA and a
> stale MMIO mapping survives any revocation attempt.  Without this
> check, a MAP_PRIVATE mapping reintroduces that corruption even with
> the logical-vm_pgoff fix in place.
> 
> Require VM_SHARED as vfio-pci, vfio/fsl-mc and vfio/platform already

vfio-fsl-mc and vfio-platform for consistency.

Applied series with these changes to vfio next branch for v7.4.  Thanks,

Alex

> do.  This is defensive hygiene: vfio-cdx does not call
> unmap_mapping_range() today, so no reachable stale-mapping issue
> exists.
> 
> Signed-off-by: Abdifatah Suruur <suruurism@gmail.com>
> ---
>  drivers/vfio/cdx/main.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/vfio/cdx/main.c b/drivers/vfio/cdx/main.c
> index ea55b7767672c..28dc8c8256006 100644
> --- a/drivers/vfio/cdx/main.c
> +++ b/drivers/vfio/cdx/main.c
> @@ -271,6 +271,9 @@ static int vfio_cdx_mmap(struct vfio_device *core_vdev,
>  
>  	index = vma->vm_pgoff >> (VFIO_CDX_OFFSET_SHIFT - PAGE_SHIFT);
>  
> +	if (!(vma->vm_flags & VM_SHARED))
> +		return -EINVAL;
> +
>  	if (index >= cdx_dev->res_count)
>  		return -EINVAL;
>  

