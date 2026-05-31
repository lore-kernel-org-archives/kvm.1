Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98FF3546D1
	for <kvm@vger.kernel.org>; Sun, 31 May 2026 23:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780271665; cv=none; b=tXbnQT6SI8ie2c77ZBLf9X8wJui0YhStfz4VC70g/LF70nY8wfyQvcI1EPpt0eTxedZTZzD5EGfrMFrdGr4Z44rcx4HAixITZcUGQcQwaQsYuM1eWbvt2j+dDlPeoGLyLzgA9hs6/nfpTJW1kTJPAUlVAROZkMfH3T7mnCDKDcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780271665; c=relaxed/simple;
	bh=d3684paRcTf2C8glk0t9ndn+IMrj1dN6riKCd56Zblg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eY94CcQliu8iZXnafeMwZvYO+sTgXYAsKkk+jBJguC+jxSyfpQqmy0LLgQ0nN6yfX049ZvTF/FINvO79XHcZrCSgC59d+owKEV7VzQUUtuPJqGetnxS6owGjKwqJdYJFPIcecFvSj8owJ13RSmyMTHtQav0F9KqnJi4VTIBeVYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Q+4bsvQH; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Q+4bsvQH"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-516d61baff3so105916211cf.0
        for <kvm@vger.kernel.org>; Sun, 31 May 2026 16:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1780271663; x=1780876463; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IrKWJ1NykkXFbiCeCeA4esCrNiqvK/wMlJLwP88BqrM=;
        b=Q+4bsvQHdmm2ecjorVxj+UpuLz6gFEl5p520qSyb+htAM433kS8kOK2YVJrePskJsM
         XW1cIeJLkXOnmRewhK7L1oEsra64U1wyLn6cxN0jwN10jub732QrVxcaLAc6y12Zu30y
         gRRy/eG0r11h1lvX162n/5mNFgzzhoZnpdd2aWVT5Ft5UdbovxRkXNpaVUPW4HepOnYZ
         n7vsLYA48ABSKdIQLxVbMwvbpOaeC0A5/NPIYId0c0sW484kJS+91ACtlf+UjunFQiZ6
         bqTbxJI9rj7HIbsbsOfpGH9m0+Cr+CVCYaNFPdhtvefXkEAL9Lx/M8T3QH+NAjNX/Fs2
         LS5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780271663; x=1780876463;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IrKWJ1NykkXFbiCeCeA4esCrNiqvK/wMlJLwP88BqrM=;
        b=nPbNWrwgAQiWCvft6HImBwSdXpni5sqfIL7VcAAKrg4Ynexxwrx276mS6uYdsu+cd+
         tjhYpcYWlrnOkp4MmOotKDBIaXyi88WXwzbV/cx175+P64P5YAAsZVO4f3i86Gl5xW6l
         4e8OTJF7D2q/tQ4vwMtOBgT2tb2jFDxbsAEcKnJliQbOTPnICFKcfiCVHnPNcMh6ylEb
         ttqfShvwT6SUaEkj9P1SFSuSm1mViuTLERb7M3TTyedU16ctRqMlq3LtAnTcH3E7Kq7Y
         Y1F9JXhEcd/pgKXJIxGnuxNmCKn4gYFuWaXMZyAOG5Hy/AZoEXRio6MMFkjw/52vUiAo
         qgSw==
X-Forwarded-Encrypted: i=1; AFNElJ8tYl1wZ3EP0yTQshm5ADwbLWHyVK7Yap32Cwp1H/YMXI+M7IahZJyURPdtTjX012B5A54=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgZ0hCQehza1/2ifrxhC5mUsWzvmzLh65HRIXbFDTKL6pzTuex
	/tUV/rcaOTeHOh8ax3oNBdzknocdgfE8TeSa6w2MqUXLEwmbM/oHHEscTfdYYT2i+jiipNc7FHI
	xF9eY
X-Gm-Gg: Acq92OHO4AnZU/MAQDCPWaeCDy9GFiqZCWLfeMxctQXVY9m3HsXL8qaMlzCrPj4DY0A
	makpmjtp/6mTYH1q/vYwac6ue1hDuNmRwJBm2niSfjgZ1kAY0bfHIRmWfrNGIZ8/fiPT5TevoST
	11u7aJ+SFTExXMwToDk4ahmLbYGQAgjZMutHQR/qocFtVXXquu/F+yKBPE0yRSIR7XFVVkNIp1g
	jw/alBmjs4Zt29vmSIQbrnUqAlXq6VL/Mh5WXowVLFPcBVTDG6tfQD0sj/ZZ5EpO1OcE2eCbIEU
	La/DvgjoTVXnqqXmUEU2vDx33zFQHzrVz7A0/0/5SUOtmrfdx984yxTAXAzJb4x0q2lzzI/c2z+
	AQZg7MAd+be2RBX9VgEaTuC98R+ou5cafeQPH3JiqEL8JXB1urln/2iPVYKvdS7MYosSVIfutRm
	cGaVdH8edtsTNTzkKq76fM/8PQAemytaD6XvMRrMjnKNGbhRDnfoWNZT6/ax43/8sxKTtqa9b5g
	PSgP4jBcHtlfeRSSq3vGtNQwKU=
X-Received: by 2002:a05:622a:646:b0:516:d943:175e with SMTP id d75a77b69052e-5173a77ad04mr129763061cf.25.1780271663054;
        Sun, 31 May 2026 16:54:23 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ccea1ca972sm78588116d6.30.2026.05.31.16.54.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 May 2026 16:54:22 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wTpz3-00000001Lqf-3yz5;
	Sun, 31 May 2026 20:54:21 -0300
Date: Sun, 31 May 2026 20:54:21 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Guanghui Feng <guanghuifeng@linux.alibaba.com>
Cc: boris.brezillon@collabora.com, robh@kernel.org, steven.price@arm.com,
	adrian.larumbe@collabora.com, maarten.lankhorst@linux.intel.com,
	mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
	liviu.dudau@arm.com, joro@8bytes.org, will@kernel.org,
	robin.murphy@arm.com, alex@shazbot.org,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev, kvm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kevin.tian@intel.com,
	baolu.lu@linux.intel.com, suravee.suthikulpanit@amd.com,
	dwmw2@infradead.org, xlpang@linux.alibaba.com,
	oliver.yang@linux.alibaba.com, shiyu.zsq@linux.alibaba.com,
	wei.guo.simon@linux.alibaba.com
Subject: Re: [PATCH 3/9] iommu/generic_pt: implement iova_to_phys_length
Message-ID: <20260531235421.GW2487554@ziepe.ca>
References: <20260529115116.GR2487554@ziepe.ca>
 <20260531093637.3893199-1-guanghuifeng@linux.alibaba.com>
 <20260531093637.3893199-4-guanghuifeng@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260531093637.3893199-4-guanghuifeng@linux.alibaba.com>

On Sun, May 31, 2026 at 05:36:31PM +0800, Guanghui Feng wrote:
> @@ -159,45 +164,51 @@ static __always_inline int __do_iova_to_phys(struct pt_range *range, void *arg,
>  	case PT_ENTRY_TABLE:
>  		return pt_descend(&pts, arg, descend_fn);
>  	case PT_ENTRY_OA:
> -		*res = pt_entry_oa_exact(&pts);
> +		data->phys = pt_entry_oa_exact(&pts);
> +		data->length = BIT(pt_entry_oa_lg2sz(&pts));

BIT is the wrong function, it uses the wrong type. log2_to_int() is
type'd properly

This also needs to keep walking and accumulating length for
consecutive PTEs until it reaches a non-contiguity.

The other drivers don't need to have that complexity.

Jason
