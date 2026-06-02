Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 319512441B8
	for <kvm@vger.kernel.org>; Tue,  2 Jun 2026 12:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780403552; cv=none; b=AlodJsDJp+E1Sm8lF5Gs3ujD6JpIwt0qEzzdJ7zUGjvN93Aq1eFfDbQ3J+CLIZMyXnoelFQVUyTyjGYRGPrLWGex6lja3LRRldHJxMB+TbC7VWqs/60mCqCPDqLGHbrC2CQh6s9fyoDh+6LmH7GC67ejTuVBpqyGpmbW8I0oU34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780403552; c=relaxed/simple;
	bh=RGYqPBR/VpcBLc8w2RhIcs3a2GH1EopSFsJsqLkkWF4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eosBXkR6hs7Gdy5ExYRQaSWFcx8h7vTuQY7KdS32ra4g4WPpQ4vgX6k+BLKMxaozSVdn0+NpfTPJ0/QQsKlTPpS5ObN+MqGbLEPJHa7PurcGfIacoCX1vaeItUadgS6clRiIzSgqhrX4YjzlDYL+5win5xcUvuW+WaCZ9aZBcds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=nXpLd7Zz; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="nXpLd7Zz"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-8ccedaf0b54so22892156d6.0
        for <kvm@vger.kernel.org>; Tue, 02 Jun 2026 05:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1780403550; x=1781008350; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=c4LbN0qMsJPM0M7wr5pjCmaihB2Av83fU87UeNOOiAM=;
        b=nXpLd7ZzB9GwCA+38Um2rpA9GNIGKYUV/LN++cH9n9gAaDGRDQHmjTooi+PchpzH3L
         COU04Ma0+aaLVQbZNOjuvdR+lsK9m0Lce/rHeIwyMAZhhH8oxB4QkHDBkQ+AckrrmJTY
         ZmO+rfeno0apdTpn5ov7VRHK7YbI3Ku9E4bNzWF1eQMdL+CtfMMczYgwc8/I/AbNDNMS
         Bj0D9Zlonn2XgcJ3mmljlXuOvkou3KajbXQMMYEZXPuBPN7GnJnIdz6KZt3zq3inlVg3
         iwA7AOv/EsCXnBLix//5Egug5Fqt+eb6ZWDEtaArCAsVdhR21WhSZDelO6sf/teVpaUV
         ScbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780403550; x=1781008350;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c4LbN0qMsJPM0M7wr5pjCmaihB2Av83fU87UeNOOiAM=;
        b=krkKDJJS0fjSIAdAKn74+xT7LBbwfBhoJEhjRea6AL6lb07RTqCF1ESypYNSQ6h4XT
         Iu8h2PJwB1asaN3KPzpNV5yJI6o7uxxbCNUyJLnaU8tt7MeZ9j7bCW4OLTnDYPqOZPwv
         u80nMVTrJweaIlpOn8o23KYiVmQZAk2McxjNqWqfGeaKki6rvpIsY7WCZStsc4c4Xu5E
         bB0EGgic8XLKjq67wDUx7vBzUM0IS7CVjWUHxXsGeqrUWeAfMyxfpBMTGQHPjXxfQK0Y
         uUDQruSL8j7r2Hju4RgYZ/ei1MrJVfDPnqwDxenI0qDwdMjUgJKSaJtiT6e2W4tyGPSt
         enWw==
X-Forwarded-Encrypted: i=1; AFNElJ+Jtunkd5tayXC67+CeeanglCUkbFX+iFmXcNijWfPLmII3D/MOK4GmMsmURqQm2AwveEM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHssOdGdhO7nSfxYc5BwYhY+N29sLUV5KS/HZBXNdHBx3jVdgs
	M42BL6MtsHUzjMmxyxHUptC162D9BN0P53im1iNbPjfG8dKMXSrL3/CuMk8CrQ/3cQQ=
X-Gm-Gg: Acq92OHxqZ/gKeOXEN6IJB1jlFpy00ogMCHnPYQ8FwXhg0w2DbW3U7ZMcYTMnz132Cv
	Iax9P3ZYNx2fFsRNo7Ir32HGA6lxFVzfRHOVnvNKCSHImAjR6N6rCOB8Nk73Gz912Q2QzSin1KA
	tS11FbDvzY/jJir89ggD43EEj6rb/FBn+i6UEPhe/gPoM+XpbgoHbSlLQF7A/+2hTWNYiGXMkK7
	o4WUgdjfWEEVwUvggCWHpR7Rjg8UQpYh5wcqvpgeHIbdiZdv7JfcCjtmVm7rzjscw8Kff7Xfbgk
	l1NNDrvLYfPNs5MeNkDwWpHittvTkVQ2iwHHZhKaTep2+dUlkL79fovrko+l3Zss1x8QwpLphXb
	jDnU/UVv7xE1OuJHlBi1Bf/VHVNlwl3FJI9l1M15IjDJ+maI/N2Dkigcc3/tjA3sg1r6J/MFXFE
	wWBeDwmfOF/AxbtxqX6gEAg3/NymP23PYg9bM/46nWFIvEKNEHHJGhXetoMo4G8LNRiU75WT7YL
	eSGLvTkiUqbKuQ+InR1amBk7JE=
X-Received: by 2002:a05:620a:2587:b0:915:5576:df09 with SMTP id af79cd13be357-9155576e1ebmr1554899685a.3.1780403550019;
        Tue, 02 Jun 2026 05:32:30 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-91532445a83sm1272224185a.10.2026.06.02.05.32.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 05:32:29 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wUOIG-00000003lvt-3BeT;
	Tue, 02 Jun 2026 09:32:28 -0300
Date: Tue, 2 Jun 2026 09:32:28 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "guanghuifeng@linux.alibaba.com" <guanghuifeng@linux.alibaba.com>
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
	wei.guo.simon@linux.alibaba.com,
	alikernel-developer <alikernel-developer@linux.alibaba.com>
Subject: Re: [PATCH 3/9] iommu/generic_pt: implement iova_to_phys_length
Message-ID: <20260602123228.GF2487554@ziepe.ca>
References: <20260529115116.GR2487554@ziepe.ca>
 <20260531093637.3893199-1-guanghuifeng@linux.alibaba.com>
 <20260531093637.3893199-4-guanghuifeng@linux.alibaba.com>
 <20260531235421.GW2487554@ziepe.ca>
 <605cbc0f-dcfb-4edd-8756-1c376c9bb6ef@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <605cbc0f-dcfb-4edd-8756-1c376c9bb6ef@linux.alibaba.com>

On Tue, Jun 02, 2026 at 03:20:05PM +0800, guanghuifeng@linux.alibaba.com wrote:
> 
> 在 2026/6/1 7:54, Jason Gunthorpe 写道:
> > On Sun, May 31, 2026 at 05:36:31PM +0800, Guanghui Feng wrote:
> > > @@ -159,45 +164,51 @@ static __always_inline int __do_iova_to_phys(struct pt_range *range, void *arg,
> > >   	case PT_ENTRY_TABLE:
> > >   		return pt_descend(&pts, arg, descend_fn);
> > >   	case PT_ENTRY_OA:
> > > -		*res = pt_entry_oa_exact(&pts);
> > > +		data->phys = pt_entry_oa_exact(&pts);
> > > +		data->length = BIT(pt_entry_oa_lg2sz(&pts));
> > BIT is the wrong function, it uses the wrong type. log2_to_int() is
> > type'd properly
> > 
> > This also needs to keep walking and accumulating length for
> > consecutive PTEs until it reaches a non-contiguity.
> > 
> > The other drivers don't need to have that complexity.
> > 
> > Jason
> 
> pt_entry_oa_lg2sz has already considered continuous PTEs.
> 
> Does this mean that multiple PTEs need to be traversed additionally for
> consecutive PA address mappings?

yes

Jason
