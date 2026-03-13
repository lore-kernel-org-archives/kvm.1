Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB82B367F5B
	for <kvm@vger.kernel.org>; Fri, 13 Mar 2026 18:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773427587; cv=none; b=os6YhPJjcrl96Ovwa8NXbxBjbjXcskCnPhuX7g+57Q2Gpnzht7c6I7+xeSFBpi7JBDOaczdsLX2cmcVqvIQkhyNpN/IDOUhSDiJIw3kIVn5W53eQxA7MiKqAu3kVzxJQG9ej6Six6DtDm/40JeOFHUKtWQsbp74V+DGveKVi+MI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773427587; c=relaxed/simple;
	bh=igi61PaIIZaH3Qas+vZAstXrvDO675CFw3Ylscc89LI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZUTmnlHgr1QViHadPz+GvC8fFTtmT/GAoHJP4lJxDv/BgETDqTToJIBfq1RLR7NEnTOGClXysyPsGXhCMjTTk5V6TIn5FNSlEsccvv5K+nK0Ti4fsmwwvqqOhp4OLg4gpAn7Pi+IWQ0OtRxybBLFNO4eRlRE8nhbfuX4ct/J5so=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Uv0RMwiy; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Uv0RMwiy"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-8cb3bae8d3eso248467485a.1
        for <kvm@vger.kernel.org>; Fri, 13 Mar 2026 11:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1773427585; x=1774032385; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Zy0pIPV9+PAUwjJhdgFY70jKRdcmmf+kMol++AzSeUw=;
        b=Uv0RMwiyhxKu0rXDy42tN1n47dqwGgGfps5bv0nxF0R50x2HA7usuJrN1yx6BOafHL
         Y659qV1zRkYSP6or2IvX3Mu9sl+7/ZX28I8wLMEMN1F8x3tqfhKN5idNGNijrJcA5hq0
         x7IJoTSmFVoRR/mzwZMxwuC+JPCOYfOTqT/la1/h0hOzNaKrSlAhJKvA851ZRhZg3okI
         bGLlmBBdzJDQOqSyDlCf85zs/WS/dvS19CPaxVv1j7HNBU8ICB3lELV8/9Yh+WHWMwuq
         hT+h72n8FRCQi0uKqeU/Bdh5O0kQCeBga9Q3PdroQ59tzxcGBJtV2SPwDFvQFuW0rvgx
         z3QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773427585; x=1774032385;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zy0pIPV9+PAUwjJhdgFY70jKRdcmmf+kMol++AzSeUw=;
        b=X3Mkc6dKMGXSfEMwigWO4I5yshqkE5XpUbLOjkSaSA1yI65s/CZQXvcTDB2qZ7fqPS
         HZhBBV3VDeXOl1xk6+sXjYBTK1ReuGeHEQqhfuavPrlhi2V3ko6SIbKbdlzREOI6/tJo
         yJUrCtNb13zvTwEz5Qc/ii8zI9wiNx2uYeR5EY3jXYjZbCvT7/sHuGznCIgaQS/eghJs
         W83MXwnYFZsUdHbgUmAETWzl7r+hHvhBrP3vcW1VpkmLgRR2RHe00hXm0Mxa+rcHTyDU
         KOEy0eotcgw9d1y6TRZKwpPdG5RHj2yq85178kSRIxzCC7LK6R3hibV6tFx6oRjCnyWk
         sX8Q==
X-Forwarded-Encrypted: i=1; AJvYcCWr6M20K3bbSSobN1ddwYMs75x9LQ68sgUj0qj7LSARnmVpaBAOkoWG/JZeyqHdYFUaY90=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxIFkyMUTG+9KSGVlMuDCZHpCSHtlFiVBzlqSjp8A4USl/iIJb
	jVBJ+gqEPB/Mvdhc4xCWb9Nhhm0lK/ec2FnLfCNn5/5t3GO6+sr+1Q2/lQoiIysGOl8=
X-Gm-Gg: ATEYQzz1zF9lOcSQswQiLUyDnp4sQjb+I5NL753Oc4cNdBvyvIr/g6YMlEpHV6W4mXU
	ENy/5AerfzW1fvKpTc70NxgcTkCWdHnanzbpQYdyUY/jiyKnFgCFQduubIEFS+tEF6fQqNyHvgo
	kiuUmMeGbj8nEdI1lrdVJqiamT7GrPGHb0E8dcCayOmRtzUrpO18dCiONxquCVW7Rghf2AfKsqU
	307KTOsRoxcske6r7EyZYPYy/HIK+0/1m24VDpw8AyPzKD+DI2AA2zGH9kCmPEIQox/7zg52bMp
	dB/HkZmuxBTbpHLtIKXv1PlDywBqsXuNHf0L9U0DqH+0X+8mVNxgGd8DXlVRLAdj0DHyr54LRej
	sb9pxxeP32Xo6lJ+UlM3iTTKa7UgdDjlSLugO0B8RIR0YtIWjhN6GOWLSmUUOZzMqKVFClhDXlH
	TO9a+vyc/aNZSIv6jYEW1awUpRQG89DAhq8aYojEDeFFCGpJQ9/WH9GnuRD2ce03ZRRloegre4v
	/xqpwotjHPrOpMl0zA=
X-Received: by 2002:a05:620a:4625:b0:8cd:6175:9b17 with SMTP id af79cd13be357-8cdb5a3f7c2mr586273385a.3.1773427584802;
        Fri, 13 Mar 2026 11:46:24 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cda1fbcd23sm701747085a.1.2026.03.13.11.46.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 11:46:24 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1w17Wh-00000007M3T-2Qkk;
	Fri, 13 Mar 2026 15:46:23 -0300
Date: Fri, 13 Mar 2026 15:46:23 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, Kevin Tian <kevin.tian@intel.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Alexey Kardashevskiy <aik@amd.com>,
	Samuel Ortiz <sameo@rivosinc.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Steven Price <steven.price@arm.com>
Subject: Re: [PATCH v2 3/3] iommufd/vdevice: add TSM guest request ioctl
Message-ID: <20260313184623.GN1704121@ziepe.ca>
References: <20260309111704.2330479-1-aneesh.kumar@kernel.org>
 <20260309111704.2330479-4-aneesh.kumar@kernel.org>
 <20260311214343.00004641@huawei.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260311214343.00004641@huawei.com>

On Wed, Mar 11, 2026 at 09:43:43PM +0000, Jonathan Cameron wrote:
> > +	vdev = container_of(iommufd_get_object(ucmd->ictx, cmd->vdevice_id,
> > +					       IOMMUFD_OBJ_VDEVICE),
> 
> As in previous, can the object be PTR_ERR()?  Maybe not, but I'd
> be surprised if the static analysis tools are convinced.
> This might work for now if obj is first element but that's not
> elegant or matainable.

The compiler enforces first element:

#define __iommufd_object_alloc(ictx, ptr, type, obj)                           \
        container_of(_iommufd_object_alloc(                                    \
                             ictx,                                             \
                             sizeof(*(ptr)) + BUILD_BUG_ON_ZERO(               \
                                                      offsetof(typeof(*(ptr)), \
                                                               obj) != 0),     \
                             type),                                            \
                     typeof(*(ptr)), obj)

I have a lovely little series 

https://github.com/jgunthorpe/linux/commits/container_of/

For this that I keep meaning to send but then never do

Jason
