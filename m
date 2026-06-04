Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E6E3408015
	for <kvm@vger.kernel.org>; Thu,  4 Jun 2026 14:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780582383; cv=none; b=Bkqeenl+cVG23hgWkuWxezkIQmFnELDXmiVzgiexfOJFTZ5jDSuSxb1wBIFyUvpROMpcno50ethVzzwyMRcjq+OJyqgdigLPx+n/2MwR7DuUD9PHuz4LgyLb5SfC9qbAWJhRKWYLu1EIRrFhoCoQnsTUgwA8/hKCEmhxMtk5jvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780582383; c=relaxed/simple;
	bh=gpdnwV2DnbeS2Luujuh3pWY+HT/ULmOQY1sUF7OfAQU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VUb5KUqmyKR+6vgxaNo5U8+LxJMg/lvQmJmZ5T7Mi/pl60zVfnl4mKVYki5NNqgLL+GBcj95t8bjOk3LVFJ0WroayRZtF8tKoFyMOvj8X8DVM6ooRErrFaYY716Mf1q0F5AIlZSQq1mSBdRn2VT/xyHLRApfwZ/tus7ZQfPUu54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=c67tRG3B; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="c67tRG3B"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-91550dfc11fso86498985a.1
        for <kvm@vger.kernel.org>; Thu, 04 Jun 2026 07:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1780582381; x=1781187181; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6SN06MWYgnamNhN1ZWgRIcR80dI4EtU2wUgYpm//Klo=;
        b=c67tRG3B3PAGKlTxgPGjuzy6sp7oF3VdFIH+8eW5D3ETaVXhpD9bmHa9E40giBNASg
         sXWlqXBf7AGX5d798/dw44Pd9Z76mpCs8vDhSRyMPTfezHcfxQCZVowz2qgDuV6TjVoy
         Ykwk2xDUyZFZo5IuX2m6OvED3jgkNYNeEpkbeaSe6+DSqqhj4R/dCwOllSdjFuhwFzKk
         dg6aQPuWyzFnSVC0U91Nz8bU4sws190YXgGP14qkC7o6/08mUbzj36wErfK8bX4ML5I/
         R/TdkeUUGkrYbZvJJ7telR5Gak+6d9sq6zqAK4O/7/ibdfxNJhZtY89blfWXhTQ3cmo9
         pAiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780582381; x=1781187181;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6SN06MWYgnamNhN1ZWgRIcR80dI4EtU2wUgYpm//Klo=;
        b=XOmQAoq5AiaEjSwF9U4ISYL+QOOk0nNyczKDIW5EVl3YEnIUIE79DMfb5XSs9IL/ZY
         Tm4eNXYf7Cik/w99o9RonCo4n1CjPkiBUcY8WLXVbaVJ37YWGyYkjKlZF43xKYE9LrDc
         aYJeH8kXxFwerscQb0QF2vtK5rSGb+ELREG5SM7tLqPGKbJqF3SPMBF6E3sDG6SiViLH
         ko3iyJ0MxObNplgEsOpSXclbEfd6wFjHUf96YqXfjd5sVuOtlhpq4rj1OavA6IfBeiqO
         3qaeDhzC04DDKtotTFUv8PIL19ttfZ0dmY89DX8jAZvO4OaKb9iMfkFVjlLGfGYGkqx1
         KBrA==
X-Forwarded-Encrypted: i=1; AFNElJ8z4slcGDyhV+z2/osOcTtViBhMECPu+7WylCwmvSAsjEA773VmzIit3XFyzKAFo6juHPk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdSPrb4Ux4TSBbgPF9sqsGgqQxi1fznYeI+PLchzRUza7KCtZA
	ymjP5181dQnBL42h95ZHY8ThrK5bvIfMadZnsRy9reWadf+DW3jhke9iL8YkvvPgnKQ=
X-Gm-Gg: Acq92OEaRmPHxcNUBbDUv4SsZrcmtLvdLDAiYp2MVSN0GjdxOuem00eK1i7Rn+l0Ph/
	U1GY+MrR01yAWFp89ug9jc6DvrdFSlDu/Nkh0AJNjMYW0Y1Gmda/fp3d4ART+9g8ZLys+vGRYLT
	+9MSyOgJc0Mr9DoLk2BzrdiO6CWcdtj4Ouae1KzX7ZaKcdt+vCnQsBPbnuCIu4adGPAysEpF7uC
	aeUxBLa7b09UHB9g8WeUcUoKx4od9+r6gDUwOw8hCTI/Yxp+aLpGHdzPj2qME0CGBXwJDZArQMQ
	C6o5zmFMv7d10CPGdWnT2Ja+sSIEeHjzge5VMBS6ZJQGi5CDwhY3rntj3DrcMGwfLSSU7841wUb
	zov2bR+hxnuyWDPO/S2jmJxBLNZ+fuYLzBDX69rrRlMlToaytF2bk6xvJY7pTs8mWg5q7CFvYuY
	S4aNF5ekkCtOXB3/JXm5qehM+kU6yKkSh6IdfYi4dw3WQv/wY4xki3FlO9FL5vbOHj8W6oGS57j
	yuSI7XrXRsR+aRhPMba7Lkw+bg=
X-Received: by 2002:a05:622a:598c:b0:517:1465:9167 with SMTP id d75a77b69052e-51778696c8emr120221011cf.28.1780582380950;
        Thu, 04 Jun 2026 07:13:00 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51775df4dd6sm52447511cf.27.2026.06.04.07.13.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 07:13:00 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wV8od-00000008HC1-3PHn;
	Thu, 04 Jun 2026 11:12:59 -0300
Date: Thu, 4 Jun 2026 11:12:59 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Guanghui Feng <guanghuifeng@linux.alibaba.com>,
	adrian.larumbe@collabora.com, airlied@gmail.com, alex@shazbot.org,
	alikernel-developer@linux.alibaba.com,
	boris.brezillon@collabora.com, dri-devel@lists.freedesktop.org,
	dwmw2@infradead.org, iommu@lists.linux.dev, joro@8bytes.org,
	kevin.tian@intel.com, kvm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	liviu.dudau@arm.com, maarten.lankhorst@linux.intel.com,
	mripard@kernel.org, oliver.yang@linux.alibaba.com, robh@kernel.org,
	robin.murphy@arm.com, shiyu.zsq@linux.alibaba.com,
	steven.price@arm.com, suravee.suthikulpanit@amd.com,
	tzimmermann@suse.de, wei.guo.simon@linux.alibaba.com,
	will@kernel.org, xlpang@linux.alibaba.com
Subject: Re: [PATCH v3 05/32] iommu/generic_pt: implement iova_to_phys_length
Message-ID: <20260604141259.GW2487554@ziepe.ca>
References: <20260602104637.1219810-1-guanghuifeng@linux.alibaba.com>
 <20260603151804.1963871-1-guanghuifeng@linux.alibaba.com>
 <20260603151804.1963871-6-guanghuifeng@linux.alibaba.com>
 <c179b999-8c7f-4338-8aad-b61fd09f1329@linux.intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c179b999-8c7f-4338-8aad-b61fd09f1329@linux.intel.com>

On Thu, Jun 04, 2026 at 11:30:37AM +0800, Baolu Lu wrote:
> > -static __always_inline int __do_iova_to_phys(struct pt_range *range, void *arg,
> > -					     unsigned int level,
> > -					     struct pt_table_p *table,
> > -					     pt_level_fn_t descend_fn)
> > +struct iova_to_phys_length_data {
> > +	pt_oaddr_t phys;
> > +	size_t length;
> > +};
> > +
> > +static __always_inline int __do_iova_to_phys_length(struct pt_range *range,
> > +					       void *arg, unsigned int level,
> > +					       struct pt_table_p *table,
> > +					       pt_level_fn_t descend_fn)
> >   {
> >   	struct pt_state pts = pt_init(range, level, table);
> > -	pt_oaddr_t *res = arg;
> > +	struct iova_to_phys_length_data *data = arg;
> > +	unsigned int entry_lg2sz;
> > +	size_t entry_sz;
> > +	pt_oaddr_t expected_oa;
> >   	switch (pt_load_single_entry(&pts)) {
> >   	case PT_ENTRY_EMPTY:
> > @@ -159,45 +167,77 @@ static __always_inline int __do_iova_to_phys(struct pt_range *range, void *arg,
> >   	case PT_ENTRY_TABLE:
> >   		return pt_descend(&pts, arg, descend_fn);
> >   	case PT_ENTRY_OA:
> > -		*res = pt_entry_oa_exact(&pts);
> > -		return 0;
> > +		break;
> >   	}
> > -	return -ENOENT;
> > +
> > +	data->phys = pt_entry_oa_exact(&pts);
> > +	entry_lg2sz = pt_entry_oa_lg2sz(&pts);
> > +	entry_sz = log2_to_int(entry_lg2sz);
> > +
> > +	/* Start with the full mapping size of the first entry */
> > +	data->length = entry_sz;
> 
> data->length doesn't account for iova offset. Is this by design? We
> should document this clearly somewhere.

That's defintaely a mistake, the phys has to be offset by the iova in all cases,
it is part of the API.

Also add kunits tests to the iommupt selftest to cover various
scenarios please.

Also this doesn't look quite right, the walk should look more like
unmap where we just walk and stop walking when we hit a physical
address discontiguity. The stop point defines the result length.

Jason
