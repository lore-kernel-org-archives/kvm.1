Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A19304976
	for <kvm@vger.kernel.org>; Wed,  3 Jun 2026 01:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780449099; cv=none; b=j+6L1fqKd/DFNPBGazh7IiZDHy0Rm0Cel5yZWnVGr4xX/080lBB5HAwh9rEe45Y4fWnQQ+1CepXqQPqrcvgd3htB9yWc+/fOhQ2M3MM7a548nkqlNHFKtXdWOuh5vVRZYDvpm6Ro7SgM71Pl6IRwb+/lOq/ntN551ERcXKKY7U8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780449099; c=relaxed/simple;
	bh=Mo+6uIwlljg7HEKWxoRbh7QUYcSwJ8ALJpeg6fpri34=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rKMAcTid7+759dYnO8ClFPcHH2TjGByiEoWgfPzHbPvbpVBGoAHggqxkFikJIvh2HXIaOnRWO5CifKbk9EeNOanCTy+ifz9K4O0Wxv5zMO9N6aiU7dJlrmteqncnvjb1iW+zoFyl7tPxfS9s45XzmpU8f4dro/mNx6Hnp0xqDyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=DOnBB6U1; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="DOnBB6U1"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-8ccef9eabccso1505786d6.1
        for <kvm@vger.kernel.org>; Tue, 02 Jun 2026 18:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1780449097; x=1781053897; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OkcXxIwae3ZkBqRFobExjF5BmBij71a6Agx7B+x/coo=;
        b=DOnBB6U1Rg2PNCKs9kDlHSd4c8Zgs7IaWdvgKEC4rFYZpdzVDug79o3cijBA216PDK
         zPLzzAdVpzl6+a72LdkwZWQ+b26+OUNstNz1SJWHIBMzzxc/nE2CvQXN6oDsM5ljDafG
         ne1srcVCOrL7H6E1cJos1Kvle4jDss55FNX9V455LcC/Wxjz/tDygEWa/2CReq0jR60x
         f7yZgO3e4+PjLFupkADsw7HPT+jSF7YJvZnp+E9eyDJU6oOUcF77JUbM1o2IrYUWNOrH
         WDGFOM9UHI6Zgkxf5bgexMqYso5jpK7WiHguYkD2LZAVWPt6VRbC3/8Oi1QglGInhFQx
         gdwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780449097; x=1781053897;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OkcXxIwae3ZkBqRFobExjF5BmBij71a6Agx7B+x/coo=;
        b=gE+FtcwMhDZADJA/oiOdqJFvhiTIJT4nUHIWS3gANX0wZw1ohnZieUkhoitXyXeaD4
         niiBDFl7ki0EqMeyVmbuQUsVnVEw2tBBxdxJhlQ8GJ7slJJQGlCLu5I8BPztnailARpD
         KuXhYYZlO30yFUyqCwOdZSqbnqjncgSdQ7bWguYAgBHO36wITZlWP3mCtLJ7h93GYZ1+
         C1JOQqr9Z9mH+CE4Ek569VInmVpsiSh6IGmU/AMq2TjtZ1reBU+hcDtLWpc7t/f85UKI
         FVGxbKnz0VRKc8O56SnTLQbVrgfpoxGWVk6Q6QS1lIOnpzz5RZwjlNBKIy4sOwYp+3IO
         FeWA==
X-Forwarded-Encrypted: i=1; AFNElJ/keXNvKaM3YZIzpEXkVWl644DoyUDIhli9u9gRSxmjTYZJKCVtC894Z9y0llCumVULgSU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTmi8fJGa1j8y9kX9figoTJLi4FdDEcWU9jIveSD269+TUtEOv
	2hNCMnNeoT0+vwMm8wbbzZnf0Epbe0UOokYEyRMbM+913bvSr0E/sgoxIHOd8tF9Zsg=
X-Gm-Gg: Acq92OED6Q1e8cvCfyM2lnDJHobxmh255MEF3t3S72ox4LbjYgF2iEWnObOQwyYRLpI
	5vHj8gjRYttOrXVXirH0zUlicB3OZUJ2EEQLdPUmmRij4RjgYe3Fao1r6unyLqHTuyciWQhAvzM
	ivlnQWNxAH/8a2UvW96mVjfAEOVANKlxB4gvqtA4P0qz0OTPo1sBtIAyPZMky89VeHgHdOy87KG
	uCuXM5x+dTWf84zugzrQiCZ6Gw/J2/rV0FlOg+xHZ5szZaCXfiy3ofTfJW/FFiG9OGLs8tvB6SA
	fYMcnYPAnn/9lzGJvCbnXtqXOzhGm7hXOHmkcRAiQwH7Z9D747Q2NGHUr4Aees/LK+UHq5HiDd4
	AyCWbbT2JnXKZi4mqHiIkP+LcrtcY48QgOHLBknCf5p/aYA4mNkWE//CU/R9g8MczsX4RyDn3n+
	tsxmvhnx6hmR0cVXhXdyLL5oZIBCGqgxrTDOIlBh2r0vsPyqoNUM6HiLU84mR26boxQMzKnidqD
	2TiZhbE+b+MomDwmcaPu2MsPUE=
X-Received: by 2002:a05:620a:31a9:b0:911:c5c0:d5f2 with SMTP id af79cd13be357-9158b5cbe4dmr170236985a.1.1780449097421;
        Tue, 02 Jun 2026 18:11:37 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9158a009fb2sm107640685a.5.2026.06.02.18.11.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 18:11:36 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wUa8u-00000004yOx-1sfF;
	Tue, 02 Jun 2026 22:11:36 -0300
Date: Tue, 2 Jun 2026 22:11:36 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Guanghui Feng <guanghuifeng@linux.alibaba.com>
Cc: adrian.larumbe@collabora.com, airlied@gmail.com, alex@shazbot.org,
	baolu.lu@linux.intel.com, boris.brezillon@collabora.com,
	dri-devel@lists.freedesktop.org, dwmw2@infradead.org,
	iommu@lists.linux.dev, joro@8bytes.org, kevin.tian@intel.com,
	kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, liviu.dudau@arm.com,
	maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	oliver.yang@linux.alibaba.com, robh@kernel.org,
	robin.murphy@arm.com, shiyu.zsq@linux.alibaba.com,
	steven.price@arm.com, suravee.suthikulpanit@amd.com,
	tzimmermann@suse.de, wei.guo.simon@linux.alibaba.com,
	will@kernel.org, xlpang@linux.alibaba.com,
	alikernel-developer@linux.alibaba.com
Subject: Re: [PATCH v2 05/30] iommu/generic_pt: implement iova_to_phys_length
Message-ID: <20260603011136.GR2487554@ziepe.ca>
References: <20260531093637.3893199-1-guanghuifeng@linux.alibaba.com>
 <20260602104637.1219810-1-guanghuifeng@linux.alibaba.com>
 <20260602104637.1219810-6-guanghuifeng@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260602104637.1219810-6-guanghuifeng@linux.alibaba.com>

On Tue, Jun 02, 2026 at 06:46:12PM +0800, Guanghui Feng wrote:
> +static __always_inline int __do_iova_to_phys_length(struct pt_range *range,
> +					       void *arg, unsigned int level,
> +					       struct pt_table_p *table,
> +					       pt_level_fn_t descend_fn)
>  {
>  	struct pt_state pts = pt_init(range, level, table);
> -	pt_oaddr_t *res = arg;
> +	struct iova_to_phys_length_data *data = arg;
>  
>  	switch (pt_load_single_entry(&pts)) {
>  	case PT_ENTRY_EMPTY:
> @@ -159,45 +164,53 @@ static __always_inline int __do_iova_to_phys(struct pt_range *range, void *arg,
>  	case PT_ENTRY_TABLE:
>  		return pt_descend(&pts, arg, descend_fn);
>  	case PT_ENTRY_OA:
> -		*res = pt_entry_oa_exact(&pts);
> -		return 0;
> +		break;
>  	}
> -	return -ENOENT;
> +
> +	data->phys = pt_entry_oa_exact(&pts);
> +	data->length = log2_to_int(pt_entry_oa_lg2sz(&pts));

I really do want this to accumulate the contiguous length if we are
changing things like this.

As I said before only iommufd needs to do this, the other drivers
don't have to, but the wrapper should take care to give a consistent
result so we don't have callers open coding another inefficient loop
on top.

vfio and iommufd should call it exactly once and then move on.

Jason
