Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B92C33BBCF
	for <kvm@vger.kernel.org>; Tue, 19 May 2026 15:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779205975; cv=none; b=ixaVM1SNLja2IJUYk3MYZvhD3n2Wlqz/z367czlGCw3DBmGWIOmADqDRk9V61baJRKt8vmYsz80TyiwAPs0zb/4umCIi+5KXy5sIbRZYi08SVLPSiC5TcoczfFdgc0/dgOTuaPZKXHEOI/F9VbfRTV/cadDr5gl+O3hc9wy6hgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779205975; c=relaxed/simple;
	bh=ObUUfsifRjlfBoeZadT6dAQY7dovdxNlTYoFkj2FnrY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gVN3DMsWcuyjPWbhBA5mq0zI3qnaymqtEBsAYFNWuv2blyWjuhxst1tTDp1fm++S4l9bc+BggFHT5jPSt8is1fj4C6U3QcdCA3HOor3e1/5e9Q+8MSN1AANICwwlPxFlq3OahtveeFqD4ovIRnrPw1nh7qzvv0NgVBQWnsXfsVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ojUUegpp; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ojUUegpp"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2ba3b9bcf69so85ad.0
        for <kvm@vger.kernel.org>; Tue, 19 May 2026 08:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779205973; x=1779810773; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4yDtPc7IVu74fsWc9+gkWocaidYIl1HHcjSh1//EIiI=;
        b=ojUUegpp514TpqUNrGtfjNVG/3kkzJSp/gB5Ls3Mu+CUcoCNsU0aKkUIDaT8NG970Z
         W8fD5tgWJL/gewBoeZMm/Kjo68gjBDEbUjZOkdJlDrsp+WUp2lELtZm1nlP5Pivmn4Mt
         MwuWe3TSEu6hFeJ+z6rgqsSAJli1tFKjKw+OrbjZkS+IUKLYv0rmn2FHlGrjcuGb74gf
         od/BGnio58FXxbtLFeSuDrcc/dd2FyalmPeFyuv4PMP3vQRL+RtnDdJEwUkfRpUaLpus
         dzMGnUsBEyCM3ucJWyA4AyG2VpHOsxOBuPxQ6PZk9DDem8bKc5+30e/vRvQvtk8iAVHM
         6QFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779205973; x=1779810773;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4yDtPc7IVu74fsWc9+gkWocaidYIl1HHcjSh1//EIiI=;
        b=MG4n4RX0G9zwWiOz7jMUrEhxB6jYaIPzd7zpswr6IYJmYh0fE+v7wuCLDIOOgtYaFZ
         4GXuWQRNoPmcYPZYoiYX30ufscJUrlZlIy3kKvaxZ3Nm6hy3ZMlGZEBTtNDHWzCDFHff
         gvFsWDBGxAYpuTi0G2LXraHSFFHSzgP9PUg/rk/VIDk+SCdfWj0OUcuPlfKIo2gWC/Xr
         CCR0D+3oXzjZCJGQLoZdBHpziSUtpiREgujDgjxAmckX4SWGT6vi0noCEU/zKtmh4AnM
         tioOoUZamgGVK/GBkpcNNlVyLx9JK0GXrQIRdYU8b6uhXS8r97ZIvIKG6nXsnv5Hb1Do
         +hTA==
X-Forwarded-Encrypted: i=1; AFNElJ+UsRLcZSmdM1hWjgo7WWuPVy8KDhJEITCFY4Lj0rsLPGvzDPVXAzVgL1lBZnXizUlT+ns=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzyX6sbO2/q0T/8fJu9ymLy0L+4Am7RgQTLJ6FnoW5jE79QVHl
	CK0yvXPcAMTXJ5irPeoTcjtTHiEIWTZMX9r7AvYJIU/whPg201Pk3mU5CRqPDzuweA==
X-Gm-Gg: Acq92OEJ8R5xxgmZZ7RU6cWBoNEqYmrUuxao8no/Dig7O9vMHNWqm4DRhRPm5u0HVnM
	zmMGQwCsD+02JWu4q8tgLp0jrOVuQ35L8SyQ7L0yHz3XTY+6q37oMxEx39hjMw+YWffGSGPwjxJ
	OrP/SNLPXR9nOPSPKtC7G9eicDBFgKvcf9yIBPOiDGjdCmIYI/4RY28VP0Y65g9mGC4VuaSR5oC
	2QmjSgx5dXfPOcVG1tWW5h0JnQZz7KoueVXF/wNdPl4Eu1744BoKWLG/MszU8PAvXkmd+p02leD
	jtpc70Gk0wVocIxbfNWmTi26AUUZce7Jmvpc0c/oAmfBhAUpYQmBzBwFBlUBW9Mv5ZN5E30qxFE
	NweJH15t3NaepnKCchQU7FEWaEM1x2+A6afJxwiIcLM7AH3YWgzEFbZSQc/Z5sMoPydTnsOCcun
	3Ydg9ca5XXFeJ97CMkPrRr4jCIDyaDHyfcTYcvcUsd0Kc0tLxhOSptKrst6pbfL7yA+L7i
X-Received: by 2002:a17:902:d4c4:b0:2ae:80a3:98a9 with SMTP id d9443c01a7336-2bdb32c2d37mr5627525ad.11.1779205972767;
        Tue, 19 May 2026 08:52:52 -0700 (PDT)
Received: from google.com (44.234.124.34.bc.googleusercontent.com. [34.124.234.44])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5bd5fe44sm195003525ad.11.2026.05.19.08.52.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 08:52:52 -0700 (PDT)
Date: Tue, 19 May 2026 15:52:43 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Parav Pandit <parav@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	David Matlack <dmatlack@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Chris Li <chrisl@kernel.org>, Vipin Sharma <vipinsh@google.com>,
	YiFei Zhu <zhuyifei@google.com>
Subject: Re: [PATCH v2 08/16] iommu: Add APIs to get iommu and device
 preserved state
Message-ID: <agyHS2Tmje4LWogY@google.com>
References: <20260427175633.1978233-1-skhawaja@google.com>
 <20260427175633.1978233-9-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260427175633.1978233-9-skhawaja@google.com>

On Mon, Apr 27, 2026 at 05:56:25PM +0000, Samiullah Khawaja wrote:
> The preserved state of the device and IOMMU needs to be fetched during
> shutdown and boot in the next kernel. Add APIs that can be used to fetch
> the preserved state of a device and IOMMU. The APIs will only be used
> during shutdown and after liveupdate so no locking needed.
> 
> Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
> ---
>  drivers/iommu/liveupdate.c       | 57 ++++++++++++++++++++++++++++++++
>  include/linux/iommu-liveupdate.h | 31 +++++++++++++++++
>  2 files changed, 88 insertions(+)
> 
> diff --git a/drivers/iommu/liveupdate.c b/drivers/iommu/liveupdate.c
> index 765d042e22e3..60ee29b0c6bd 100644
> --- a/drivers/iommu/liveupdate.c
> +++ b/drivers/iommu/liveupdate.c
> @@ -17,6 +17,14 @@
>  #define iommu_max_objs_per_page(_array) \
>  	((PAGE_SIZE - sizeof(struct iommu_array_hdr_ser)) / sizeof((_array)->objects[0]))
>  
> +#define iommu_liveupdate_for_each_obj(_arr, _obj, _idx)				\
> +	for (; (_arr);								\
> +	     (_arr) = (_arr)->hdr.next_array_phys ?				\
> +	     phys_to_virt((_arr)->hdr.next_array_phys) : NULL)			\
> +		for ((_idx) = 0, (_obj) = (_arr)->objects;			\
> +		     (_idx) < (_arr)->hdr.nr_objects; (_idx)++, (_obj)++)	\
> +			if (!(_obj)->hdr.deleted)
> +

Nit: While the usage of this macro is safe right now because we use 
goto out; to short-circuit the scan. Such naked nested loops inside an
iterator macro can be a bit of a trap for the future. 

If anyone tries to reuse this macro down the road and uses a break; 
statement, it will only break the innermost object loop and continue 
scanning subsequent array blocks.

We could nest two macros or it as a helper fn to prevent such bugs.


>  static void *iommu_liveupdate_restore_array(u64 array_phys)
>  {
>  	struct iommu_array_hdr_ser *array_hdr;
> @@ -201,6 +209,55 @@ void iommu_liveupdate_unregister_flb(struct liveupdate_file_handler *handler)
>  }
>  EXPORT_SYMBOL(iommu_liveupdate_unregister_flb);
>  
> +int iommu_for_each_preserved_device(iommu_preserved_device_iter_fn fn,
> +				    void *arg)
> +{
> +	struct iommu_flb_obj *flb_obj;
> +	struct iommu_device_array_ser *array;
> +	struct iommu_device_ser *device_ser;
> +	int ret, idx;
> +
> +	ret = liveupdate_flb_get_incoming(&iommu_flb, (void **)&flb_obj);
> +	if (ret)
> +		return -ENOENT;
> +
> +	array = phys_to_virt(flb_obj->ser->device_array_phys);

Nit: phys_to_virt doesn't return an error for NULL. While we shouldn't
be in a case where serialized ptrs are NULL. I'm wondering how painful
catching such bugs would be.. should we check for NULL phys_addr here?
(and at other places)

> +	iommu_liveupdate_for_each_obj(array, device_ser, idx) {
> +		ret = fn(device_ser, arg);
> +		if (ret)
> +			goto out;
> +	}
> +
> +out:
> +	liveupdate_flb_put_incoming(&iommu_flb);
> +	return ret;
> +}
> +EXPORT_SYMBOL(iommu_for_each_preserved_device);
> +
 
With those two nits, 

Reviewed-by: Pranjal Shrivastava <praan@google.com>
