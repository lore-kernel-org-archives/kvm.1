Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F149232B120
	for <kvm@vger.kernel.org>; Tue, 19 May 2026 23:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779231914; cv=none; b=qNc/++E4H+JNiReORoXnXPJqg40dL0sWCrc3X14Gc/Tn5R+jOcfJ0fA74HnC4oA8nO3B5+BrvVbzq2ByY24kBI23qSihloL7tLA79VSJvOD47CGYMe0uD638fwIciDhzO2FlGF8HwdHRJz/yaWZ82xQXz7j6apZNGtEv9up2Jnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779231914; c=relaxed/simple;
	bh=rKw+Gy2B3liLRrb1+batkgbRplDfelqd2XM3nHk15tE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KbKnnEa1a8FwhKrcn29+pS7OCnMk4YM3YBPhQyI05wPoS79ZL2BbaLKaqclfMQFQhi55dlFx2Lzke64iIrSVD/5MG+X6jm96FHkR5Us44nezcRj1rNdHq7OB1wcMDWFh4HZdyMA7VHQp0wcVbBHUJ3MBAxXNPYr08XRWY4IeIfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ruS6ELLU; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ruS6ELLU"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2ba3b9bcf69so735ad.0
        for <kvm@vger.kernel.org>; Tue, 19 May 2026 16:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779231912; x=1779836712; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/JGKe5XSqhMH1qT1WplE0RQlM2euEqwriUAGETdhTiU=;
        b=ruS6ELLU96jH1l2RCCGxDM55Gv90OFvTn9+Sg6YQ5Me3RAv3IVnCNfc7M4CVphvYof
         sgzx3TcHiWloh+W9IkxiheZCNhhrpG91qgmyxrymo8mJbMOrGnZjV5uBT9GWMkucXDQG
         m95bZsS+ymswv5zmtqjs8mWUCs3abiBJa6pZtvvsC5Z3exy/RL3/UdimmYgesLGkoCwd
         XekjriLDl1Kvg/i7jHm+0bv8Wn3JyvPLNJeJvpE02lu2v2miSl2BRe3Ysr6UkMTm3Yr5
         lJ++73BSuas44quSJ4/k7Km2AMNuwMqRHniebiN9tIulr82B7lCpPvCQS/fX3mJRdxMm
         2IDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779231912; x=1779836712;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/JGKe5XSqhMH1qT1WplE0RQlM2euEqwriUAGETdhTiU=;
        b=oGmD1Xq8U1LDEqx9yp+zDyTojdey/YJVZFvst9MFGzBRhW4oHPuhxHxQMDfoLFt4yk
         dc1p2s0/9zWOcnEjzAk0+CSBzeTC84+E3OCWp0Y0K08DEl/2gWjxuGn1XBmjbuoeJy32
         K9NzBhctYAF5WrkOTlcq3fVvKiGlEI5VMQ4Q953Vb1N48tr186K5T39DJbAoZ9rTyBBk
         0Q9aRWbs97DG+GMOBxTAr96XOEs8rzLz4kas5JYSuw+eZhOwG+rrRdvlyXsZrtGF/6Nz
         SfAQRyM9n1HwERVYMK+JZvgAotqiT8udVJRidj6JW82hhSRsSRV0HVIF9bZuRDdtPtOb
         /Gzg==
X-Forwarded-Encrypted: i=1; AFNElJ/BznG0m466LRJQMYz1hs+T19EGvZGntRyIGKRapu4de8UFHhE4QZP22FuoL2AaHvvmWTo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxm45yHfmEoOpgHGoJVR/kKmdvIN2LFrYM7ytjSNLn4u85qzCpH
	1SzXfOmzivMUw4VLCTziuG4FPoPFoktYNH6OdrHX515DYKNtFNV1BMTsiQNajuwk5g==
X-Gm-Gg: Acq92OHl0ReO0iUlhfe9M07KasN7YlFkKAgV9uktMstISF2dQ35+5CtmjBkdB2KatLi
	UqrBWzgeZMeMNCExObP73zZVYvWU/JRJP/JAeIe11w8mXSa8O6a/v86Uc2Hdi7CFiovXyroEibT
	awqno8tR5CGYm3OoR/ZuXKK0YAz2FSTzaqnlveK8O80b6D7DfeIvU806l9MyR9liRZPbSysqOKH
	8rODAYEgsshJccOwhoxax41WEWhWZ5Nv0waoIZ3stNlTWwLfMz9nj31y/MeoRU7kCJgWSwWBjcV
	HN0DAokRzJ3kjv3c5IVMvXT8K81K6MLlj5TDwfV7urOnMhiybyl/Kh1Im91jqekP/GnklLuiH3P
	2WdQAidTynI4qbmiF3XEazojjrv5mH6tJxQ44Fg+kZCQFK4k4s74eQQrbPRxZOGmrFGK046pVZA
	xGdpH69RYW6SoajwVPoiFyjXlCEHBv6XeRj8h0jjIFAMdMZVO4ItJCyRzf0402XT+7XrfJoW/sg
	9K2Lkg=
X-Received: by 2002:a17:903:2a87:b0:2bd:6dad:3dfd with SMTP id d9443c01a7336-2bdb37cf83amr8934085ad.27.1779231911476;
        Tue, 19 May 2026 16:05:11 -0700 (PDT)
Received: from google.com (44.234.124.34.bc.googleusercontent.com. [34.124.234.44])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83f196638d0sm22941288b3a.7.2026.05.19.16.05.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 16:05:10 -0700 (PDT)
Date: Tue, 19 May 2026 23:05:02 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
	YiFei Zhu <zhuyifei@google.com>,
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
	Chris Li <chrisl@kernel.org>, Vipin Sharma <vipinsh@google.com>
Subject: Re: [PATCH v2 12/16] iommufd: Implement ioctl to mark HWPT for
 preservation
Message-ID: <agzsngLHDmoD3JxT@google.com>
References: <20260427175633.1978233-1-skhawaja@google.com>
 <20260427175633.1978233-13-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260427175633.1978233-13-skhawaja@google.com>

On Mon, Apr 27, 2026 at 05:56:29PM +0000, Samiullah Khawaja wrote:
> From: YiFei Zhu <zhuyifei@google.com>
> 
> Userspace provides a token to mark the HWPT for preservation. Note that
> this token is not the LUO token that is used to preserve the iommufd.
> Once all the required HWPT are marked for preservation, the user can
> preserve the iommufd into LUO. The iommufd will preserve the HWPTs that
> are marked for preservation.
> 
> The marked HWPTs are tracked using a new XArray mark protected by a new
> liveupdate mutex. This mutex will also be used during iommufd
> preservation to protect against any race with the mark preserve ioctl.
> 
> The HWPT token will be used during restore to identify this HWPT. The
> restoration logic is not implemented and will be added later.
> 
> Signed-off-by: YiFei Zhu <zhuyifei@google.com>
> Signed-off-by: Samiullah Khawaja <skhawaja@google.com>

[snip]

> diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
> index 6ac1965199e9..111f4d42e210 100644
> --- a/drivers/iommu/iommufd/iommufd_private.h
> +++ b/drivers/iommu/iommufd/iommufd_private.h
> @@ -44,6 +44,11 @@ struct iommufd_ctx {
>  	struct file *file;
>  	struct xarray objects;
>  	struct xarray groups;
> +#ifdef CONFIG_IOMMU_LIVEUPDATE
> +#define IOMMUFD_OBJ_LIVEUPDATE_MARK XA_MARK_1
> +	/* @liveupdate_mutex: Protects the preservation of HWPTs. */
> +	struct mutex liveupdate_mutex;
> +#endif
>  	wait_queue_head_t destroy_wait;
>  	struct rw_semaphore ioas_creation_lock;
>  	struct maple_tree mt_mmap;
> @@ -373,6 +378,10 @@ struct iommufd_hwpt_paging {
>  	bool auto_domain : 1;
>  	bool enforce_cache_coherency : 1;
>  	bool nest_parent : 1;
> +#ifdef CONFIG_IOMMU_LIVEUPDATE
> +	bool liveupdate_preserve : 1;

Nit: Is this bool a remnant from v1 that made into this refactor? I don't
see us using it anywhere?

> +	u64 liveupdate_token;
> +#endif
>  	/* Head at iommufd_ioas::hwpt_list */
>  	struct list_head hwpt_item;
>  	struct iommufd_sw_msi_maps present_sw_msi;
> @@ -706,6 +715,15 @@ iommufd_get_vdevice(struct iommufd_ctx *ictx, u32 id)
>  			    struct iommufd_vdevice, obj);
>  }
>

[...]

> +int iommufd_hwpt_liveupdate_mark_preserve(struct iommufd_ucmd *ucmd)
> +{
> +	struct iommu_hwpt_liveupdate_mark_preserve *cmd = ucmd->cmd;
> +	struct iommufd_hwpt_paging *hwpt_target;
> +	struct iommufd_hwpt_paging *hwpt_paging;
> +	struct iommufd_ctx *ictx = ucmd->ictx;
> +	struct iommufd_object *obj;
> +	unsigned long index;
> +	int rc = 0;
> +
> +	hwpt_target = iommufd_get_hwpt_paging(ucmd, cmd->hwpt_id);
> +	if (IS_ERR(hwpt_target))
> +		return PTR_ERR(hwpt_target);
> +
> +	mutex_lock(&ictx->liveupdate_mutex);
> +
> +	xa_lock(&ictx->objects);
> +	xa_for_each_marked(&ictx->objects, index, obj, IOMMUFD_OBJ_LIVEUPDATE_MARK) {
> +		if (WARN_ON_ONCE(obj->type != IOMMUFD_OBJ_HWPT_PAGING))
> +			continue;
> +
> +		hwpt_paging = to_hwpt_paging(container_of(obj, struct iommufd_hw_pagetable, obj));
> +		if (hwpt_paging->liveupdate_token == cmd->hwpt_token) {
> +			rc = -EADDRINUSE;
> +			goto out_unlock;
> +		}
> +	}
> +

Nit: What happens if the user calls this IOCTL on an HWPT that is already
marked but passes a different token? 

The xa_for_each_marked loop will not match the new token (so it bypasses
-EADDRINUSE case) and the code will silently overwrite the HWPT's 
existing token?

Since there is no unmark / update UAPI, It can be a fair policy as well,
but maybe we should call it out explicitly, maybe a log like:
dev_warn("Overwriting token to %d ...") ?

If NOT, then we should avoid overwriting the token and scream with
retval like -EINVAL & dev_err in dmesg.

> +	__xa_set_mark(&ictx->objects, hwpt_target->common.obj.id, IOMMUFD_OBJ_LIVEUPDATE_MARK);
> +	hwpt_target->liveupdate_token = cmd->hwpt_token;
> +
> +out_unlock:
> +	xa_unlock(&ictx->objects);
> +	mutex_unlock(&ictx->liveupdate_mutex);
> +	iommufd_put_object(ictx, &hwpt_target->common.obj);
> +	return rc;
> +}

With those two nits addressed,

Reviewed-by: Pranjal Shrivastava <praan@google.com>

Thanks,
Praan
