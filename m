Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB2ED3603D4
	for <kvm@vger.kernel.org>; Fri, 13 Mar 2026 18:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773427383; cv=none; b=odLm6IwzsAmk2rjZ5yySmroT7JiKoBdknv2Uz2Lj9sMee+EF+rgoZdJ401j0v1vVhE6OY+ERaca2fUeIO8/9l9mZRNtwum7L8cgFdQNLZix1QP2DyslQdBEASSRECpvhypYKRSubQLwMvW61yLRswAOQeUp8YioOELXHWJGWP7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773427383; c=relaxed/simple;
	bh=qG79F3bBT6jsj5MyZ+DmjyLvwJgCGA1ee7wOQ7HnB2c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P+cJZTFhDNgNKl559aMKKZSbJXjdHOAeZN3DfdpLqL1dh4lFp3J250j9W2v02pwKdeLL2DgyZg9SLO1Tkgr5VQCROxW0NDYoIRbhNwp4BjbSTzLcXhYjjikFhFUg8Q5sv+kL3gSdCYRgwgZtU6yBZL+yYeKKfrgU7rB+drsjcL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=cY3qvrw3; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="cY3qvrw3"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-5090c48de85so28914171cf.0
        for <kvm@vger.kernel.org>; Fri, 13 Mar 2026 11:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1773427381; x=1774032181; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=33LRHogpGiDAoJ0hSgyq37DznMxJ4ZqKispiDKsO2iw=;
        b=cY3qvrw3kHNCq827Ay7IsttxvYcDfoZefBb5Iz2z0Wr7FEVAlgBK/MApyYSjz6awY9
         mtoqYzyicqfVAOp67mgqcTckmXugw9zu6yVDakthIqJm6vaTxzy19oyz7xU+7A1WLhSq
         uTlovw0ZvQr7ZnBwwC75C3FEkop/yWrGypPhaws241XCBlgNywuS4FJEz696Y8uaAtKv
         yFfsPL9I0ZHtqG9/56U1z8iGlTUawfY4/SxTd0gN8kMg0o6WAjRc4BprffG0vyWURBxt
         K5hDmZh3TLlscATqSZUFbHdqGKVUyZ1vOc0pQ8N6ZeOsl6bfVTNp7ePRjIcKH/wNMLiQ
         CF/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773427381; x=1774032181;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=33LRHogpGiDAoJ0hSgyq37DznMxJ4ZqKispiDKsO2iw=;
        b=V/d6gbXKPABK8N+9C0S0oaBEGlW8sauc4weq0ad/xqOVOUK+1TqChbiHbhxBN5gmWk
         OPa8xDr34JXjMnu87xmqEdTgQdAJfvn0FxNrKhFxgMHUg1fikNHx2rq33xB6XvNuhl4f
         gWISshzy5yN60RQzONGpsFzRZnHQHbgeV5XcTVXcYcuR/bpeiL2uqfkDBjlEpkt7xpgQ
         8mLEUR4ZAF2Xie3Id00K32W2NHzv8WyVApVwcT/0in6kmFYgT8u9rhWgb3+YLIMbVdpu
         MkuLWHcTWBWV0C3XeHUu+L59Jw0pQMhupr7g0d3/9lvtsSQQuPzfLFRb6kyBkjCyTIYy
         cf4Q==
X-Forwarded-Encrypted: i=1; AJvYcCXciJ7Z/TrOaUvAdGe6AnMQn+A/dZ06YTEVeugf/PSSw+wF2AXF6VDEsb3/Ep+ZgpQG3BI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywco1D3lJjL+fEdZHX7hsT609CnYqH7DdoRV7krL4AtixF4m5Yi
	fciu3ZC0ofRNv29RL7VIxjbYhNtiOVWxjUgqU7GzTI/gkVm8hPLQXi4Q8bWa31x8iJc=
X-Gm-Gg: ATEYQzxRbN0GTQmq5f6yBRFLx10AVtGXbQFAfpQII1tpMNOICWtxjH2vMLkyDjDmDl9
	BDdLoxcI57nMjV0euhUV0Q//cLTF0wSAKtXDmi5R+zVTK7GbCofknZsrjtsgiq/zWOFhvVRBufr
	VgsZktrWgskGO0n/uhEdCk4FGi/t8+OnZ2/bM0E3kq1JcqxKU836k4BQHkDKg6nmSCWLMF+r31/
	zSjPlQ+P0TW5QWlF1LMvVPkaGxYa7XahOZkrEsz2RprGobQU0/d2VFH5j6BnH+L2vM8SEIckmJd
	2aHuoQVWTy3hj4ue6yMVYhxt9AKKjPJin2DFs9CeeG1gDxblI2pjyty9VI5Iab5CiKMFGXw9o1f
	UB9R28DDvv2rQua3fE0m0X4Ce15WSEbquaFYgdXxwM5FpJLU6fiuvrXjLEFKBNuBTXV/VItCOrU
	laFIiiJWlBlR25UTY6diViaj5zLfPv/enqWQscnyap6QRFSM80kO9zXhq9qecz0G/O3n6MPL2Y4
	c/lN+ld
X-Received: by 2002:a05:622a:1301:b0:509:2822:6701 with SMTP id d75a77b69052e-50957cc0c69mr54001261cf.28.1773427380808;
        Fri, 13 Mar 2026 11:43:00 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89a65c071d4sm60555916d6.21.2026.03.13.11.43.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 11:43:00 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1w17TP-00000007M0D-311H;
	Fri, 13 Mar 2026 15:42:59 -0300
Date: Fri, 13 Mar 2026 15:42:59 -0300
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
Subject: Re: [PATCH v2 2/3] iommufd/tsm: add vdevice TSM bind/unbind ioctl
Message-ID: <20260313184259.GM1704121@ziepe.ca>
References: <20260309111704.2330479-1-aneesh.kumar@kernel.org>
 <20260309111704.2330479-3-aneesh.kumar@kernel.org>
 <20260311213555.00001064@huawei.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260311213555.00001064@huawei.com>

On Wed, Mar 11, 2026 at 09:35:55PM +0000, Jonathan Cameron wrote:
> > +int iommufd_vdevice_tsm_op_ioctl(struct iommufd_ucmd *ucmd)
> > +{
> > +	int rc;
> > +	struct kvm *kvm;
> > +	struct iommufd_vdevice *vdev;
> > +	struct iommu_vdevice_tsm_op *cmd = ucmd->cmd;
> > +
> > +	if (cmd->flags)
> > +		return -EOPNOTSUPP;
> > +
> > +	vdev = container_of(iommufd_get_object(ucmd->ictx, cmd->vdevice_id,
> > +					       IOMMUFD_OBJ_VDEVICE),
> > +			    struct iommufd_vdevice, obj);
> 
> I'd be tempted to do something with a helper function to simplify flow.

It is already

static inline struct iommufd_vdevice *
iommufd_get_vdevice(struct iommufd_ctx *ictx, u32 id)
{
        return container_of(iommufd_get_object(ictx, id,
                                               IOMMUFD_OBJ_VDEVICE),
                            struct iommufd_vdevice, obj);
}

> Then the helper function can do direct returns on errors given the
> iommfd_object is managed in outer function.

Use cleanup.h ? It is not the iommufd style the break things up into
little functions for error unwind reasons
 
> > +	if (!vdev->viommu->kvm_filp) {
> > +		rc = -ENODEV;
> > +		goto out_put_vdev;
> > +	}
> > +
> > +	kvm = vdev->viommu->kvm_filp->private_data;
> > +	if (!kvm) {

Ah this I don't think you should be doing. That needs a helper from
kvm

Jason
