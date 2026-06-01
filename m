Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E7D12D7814
	for <kvm@vger.kernel.org>; Mon,  1 Jun 2026 14:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780324307; cv=none; b=a5eeqTnUsg5ZIeeaFx+9570o0JNKNis/oe5lx/ctC0zG00WttNDu61mnwNE25uWQku35FtI3bJsMnMf0S/duy4Ws4MaO1UBSjcU3gbn67dp9D0Ye7x0nxfThdleTuFgG3GY4YaxmGmt2lLl7mnZ2JK+/jipGMfdqa645n1Bykb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780324307; c=relaxed/simple;
	bh=5+eRi2P0IhQkVffVIzXnn4OZsEFB83MX7U5Varec24o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bQBFPGQr3AzlYw4mCmFuM2PbcVkahNGi1C2UJgvxcdzEJ0pIZHfA1vD1G3XQWfYqadwFgTGHLCrHQvnkDQaf87qSsIP39Dcm+KeKI3R5bIzEP4Rn2anwkhyInWynXd9YyVaVWO2k/l5Lw7bG+ZDZ5sJGAh6saTdWDKFAbVi440w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=JdyJJ8sx; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="JdyJJ8sx"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-8ce65629acaso19507066d6.3
        for <kvm@vger.kernel.org>; Mon, 01 Jun 2026 07:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1780324305; x=1780929105; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xvsjMwD/preuv2Qmrdbeq0ug8WdJ2lDONAxR5Koyc4Q=;
        b=JdyJJ8sx6DPMY8MKUH6D6u6nGE9il93ad4F9Ngrlt12PIvA3JTcyXAAtZMiBJPBVd/
         MJlsm4OdJU/jsLyDYTgRjx8pyAq1NJJC3ODYltMiKfAK3muEpooRie5U4KLvheM5vifD
         6lWXEqD+Ngl52sqfFwkWcY7w7W9Mqv+dUm0ulVtMvILOoapPmK9CwatLIRhBwiWMoPZa
         o2C2G71CyPo/TLc4/ExB0pdU7IGzy4M+Vlvtd84hzgLtC9H4PNOJta8v6E81V808wigO
         vGdjvTGcKuQZqbTY/9llS5XFc/BmPusmh5LkYTPlrjIuvzaRGh53gL28L6U8s9hB3EWA
         2Akg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780324305; x=1780929105;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xvsjMwD/preuv2Qmrdbeq0ug8WdJ2lDONAxR5Koyc4Q=;
        b=YiPL7mjVUL7frq1ikuuBpoWqT7BtqW1SFRYN1fFxHDrmq46e1C8eeEsNPXX+tFnjoQ
         6zE6yntLTMxerS2+Kld7M0O6clrf4rqj0HLIj5DCKhHucJk/FsJl1LxMfXElKY9BW3US
         QHq5V12g1hG2v5j7t0hi9HBLLPTIuCRFiapMbL1+hspBqMFuL8+DPZoY388lNGxH3jlQ
         cPv7HFLqic3vp7xv+gV7T2H7V4CCWdkSp7hvsFjHTvLAkob0To/W8m56POZ9BQ05IVHa
         uDpfJjulZk6NXc4Rf7nYeGTrz7DEglvu61qIWN1sGOMWuJIsG28malBqicHdFGYTBuPN
         E4rw==
X-Forwarded-Encrypted: i=1; AFNElJ+/HPkqry+JiAzs2dHtESowbmYzypyW5IGhz1Qoc/rM7KqwtmgnHBsDm+kGfm4uwwIP94Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfgTkagDA3jSKQNnufFNyBgxOBNPUrrvqdCoEriW0vevJX2L6m
	D0OnMJwmVD41EksSt4VzOLXG30fuqtPFVFZOiF+3nWYBC0fAs0VsygVwG6cweQOCsZM=
X-Gm-Gg: Acq92OFr7Va8/y33yMuwzsT2REjMBZrieg8fo/0n0Pk0YopTCjLFaAHHMgqhPXoJkxK
	O8dFhHwU2/IN8+XhjXyqTKveCwLPnrJCWZ4bgDtlYJ39PjUybyamJnNM18BSFasp6mecSXiioco
	Jl1MDx8+GCO8eJeJ9tUyDQk1H1kYsiDbzEHosKSEEo2Z3wzjfh0A+97LlaDNNa4MHhx/m40AsSr
	tY0NKnDMugYl0KwEB4ZAfOYdopN8w/qLstTHF03Ofxw5XBZz/uQPCwvS656XULXWXCDyIs+kNLt
	FkKZesoQGf2zCPiNSGRUN6GkoZHjuuC/FgKq/9F71LJFFpa9AxENLToa5jLzLSykWm13K1bu9gb
	XfE8WorbfY8TzlUeE9bQQnnzbGxYEgcmi9QRNqEAcj8b6pGG1UqNdfIBU6plQ9R5Afmf0/nK73S
	93w2/dQYk3+4AawebqN1+S6LrTADUruePvYGnzJ25Sox/ZnK6s20K1uv7zU5IzSNfuVQeNeC15f
	hbp+T1So7HvjO3B
X-Received: by 2002:a05:6214:2502:b0:8ce:b2e9:a4b9 with SMTP id 6a1803df08f44-8ceb2e9a80cmr38343386d6.12.1780324305009;
        Mon, 01 Jun 2026 07:31:45 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ccea064f97sm94142866d6.13.2026.06.01.07.31.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 07:31:44 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wU3g7-00000001mzs-39uT;
	Mon, 01 Jun 2026 11:31:43 -0300
Date: Mon, 1 Jun 2026 11:31:43 -0300
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
Subject: Re: [PATCH 1/9] iommu: introduce iova_to_phys_length in
 iommu_domain_ops
Message-ID: <20260601143143.GZ2487554@ziepe.ca>
References: <20260529115116.GR2487554@ziepe.ca>
 <20260531093637.3893199-1-guanghuifeng@linux.alibaba.com>
 <20260531093637.3893199-2-guanghuifeng@linux.alibaba.com>
 <20260531235148.GV2487554@ziepe.ca>
 <a0875d9f-4aed-4164-861c-6fbbdfe04080@linux.alibaba.com>
 <20260601134322.GY2487554@ziepe.ca>
 <ff2a4364-8463-42cb-9a2b-fae1ef64c423@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ff2a4364-8463-42cb-9a2b-fae1ef64c423@linux.alibaba.com>

On Mon, Jun 01, 2026 at 10:14:27PM +0800, guanghuifeng@linux.alibaba.com wrote:
> 
> 在 2026/6/1 21:43, Jason Gunthorpe 写道:
> > On Mon, Jun 01, 2026 at 04:41:48PM +0800, guanghuifeng@linux.alibaba.com wrote:
> > > > > +/**
> > > > > + * iommu_iova_to_phys_length - Translate IOVA and return mapping page size
> > > > > + * @domain: IOMMU domain to query
> > > > > + * @iova: IO virtual address to translate
> > > > > + * @mapped_length: Output parameter for the PTE page size (e.g. 4KB/2MB/1GB)
> > > > > + *
> > > > > + * Like iommu_iova_to_phys() but additionally returns the page size of the
> > > > > + * PTE mapping at @iova through @mapped_length.
> > > > > + *
> > > > > + * Return: The physical address for the given IOVA, or 0 if no translation.
> > > > > + */
> > > > When introducing the new function I would like to fix this 0 error as
> > > > well, it should return PHYS_MAX for error
> > > Implementations such as arm_smmu_iova_to_phys/DOMAIN_NS(iova_to_phys)
> > > all use a return value of 0 as an invalid state, so 0 is used as the
> > > representation of an invalid state to maintain compatibility.
> > I know, but this bad choice has already caused bugs so if we are
> > changing everything I would prefer we fix it.
> 
> OK, there are a lot of changes in the current commit. This issue will be
> fixed in a subsequent series patch.

If you follow the plan I gave you then introduce the new function
using the new return code and only support it in iommupt, then you can
convert the other drivers to the new function one by one including the
return code.

Jason
