Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E349476CDC
	for <kvm@vger.kernel.org>; Thu, 30 Jul 2026 23:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785454400; cv=none; b=Tod8MAJMSXSr59SwbouHLrRy0bADcse4QQCOe3M8wabdoqGSAwdQg4vtQHPktzxGXJb0UdpUa52LSML5wPNAYpMc8uj9JeBFDyxzAV50IoX9AbQ5duGpb+JSwaj7yl0iOrz3WwJP1a+jnsn6K7DJTDHpEVXdBr1HNAkM7l/AZws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785454400; c=relaxed/simple;
	bh=Iq9ol7OXU1ahRu/wapfwTXujNB5WFM05r9AjxlRtuJo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IGmySabPJHTsP2h/CzdbyO5wapHaq+n8RbfZ1FRPzqtGzN60CBsP7W2IfuMa8VaeQeA4d6Sgm9XlYZPXj3sNsfDnW0TqDlfdLzNmXzajJXYaq0nFt/Yn37Jt4FknvgQ8ekivt0fBIGW/pStFdaMmu/24Pf4DxlLc0RQwaml3ohk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cjqlfTNA; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cjqlfTNA"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2cede6375caso43175ad.0
        for <kvm@vger.kernel.org>; Thu, 30 Jul 2026 16:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785454399; x=1786059199; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Dg+/alpKqQYpNCx1oouhanYFhK3x1/3K8PlW/VCS3GE=;
        b=cjqlfTNAiSvEl5DjFzjhn2TZHWvD/qPUKQkzC3qE2q52M9I+ieIrMU+iTI3KyCVZky
         wyrWozOwOzCROIWE6TEN4BH+GfAuloUBOU9XXU9xW5n32SwwIl5kpVU3Vv4xUzI9wYSp
         NfkHO8p740TS0M5wlKByt+mU1Gm+7ipDwuIIO6TLcBYw1+TGtAhKXXDnrtgvKzgPuDHP
         H0n3QsfEz4YKkRXd4oHNyv7CPqGjuDbhDcIkK2zJCkHmnCMMsnzx9NFqil/KnrgH8ULm
         3xbk4OgmJlSC4EPtGRCKabo/3/Gg4W8Wud1J0JU7TiHmaslv5SJAMfEczrTOLd68lCCc
         w4hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785454399; x=1786059199;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Dg+/alpKqQYpNCx1oouhanYFhK3x1/3K8PlW/VCS3GE=;
        b=ifXJexCNfezpW4ggt8lGPRD98cTF2i3apVSLmrHwM+XXZhFO6ar/LrbGGZYB8JNMrr
         +F8rCtrQXUhwaIQV1B3dgIASpSG3Z0fTf2O3hl4KFs2Hs6a8wYN6obQeOAy6c/Fc57G+
         7KJ9H46353rSEz8Ppbib4G3ZKzsFctWWe/fljQL1BVocmrJtMZzLZ5NECEBld+cTuq4F
         3zC/Pz4XDf239tEOY/cfJd0C3H/We5//XbVG0WeCnAwVBzUxDFdHeax2YlM+4KN1CddV
         OsxiWZW7DSvUj0pfB0csdb/Re3ylC+iv/251YWywoOtcVBwS5dtufI26u0WJ/bMePSqp
         DfFg==
X-Forwarded-Encrypted: i=1; AHgh+RrdksqTPL7JTxsSSEfrZpDn7V+UG37npCOe7QLKSPD+96CsMUs7U5ew53//BUvKs0UBud4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwF7zEnB9gRitI9Mr33S/5l01FS9nHDQBW1/uX0J95Zc/YTPcSO
	ATJQa65gS3woPSKuueXqzOMzOcWYU/UjxTEuuc2eq57z9k3HSkZJ5YKMak7LbWksygIi56KNQw9
	e2yl/4w==
X-Gm-Gg: AR+sD12b2rIFtqNRbLwqPuFBHlJF5wkE6bbrU+Mi76qSnuqgE6okHWDMrI5+8VrlK9Z
	Awn621L8s+Kdw6YiuVK19Uks3cHv6ZwQRPiXILwVFx5h3JWi3LWBnm+eL358MkmToR3KEgKac05
	dPmjJHybFxHXjtvvJtfJI3mu699bxoqK//dwKiuYWM4kmkPpJhT8Gi81jipU08XDUYUjo2g5id2
	/oWJRn2YKdq32kVuQZJGZBQQIlDwD59xbJ0XMCWCWFUXncWNeFtluJi0icF0AZlGOj9IBcwfV/3
	fEd/GjbbbpcByOD8guwKgFotyAnpkQpgVVP1hth3Peqhx3Yxq2bke4vOYcffBTON1jt+Loa4iXA
	kOD7lftSq0vXzuIYj21QFz79L/EOvrlMiBogfMBrapvZc2WdQrcMJGjRzn7nqeSW23SxVG9BYmQ
	H1fu3uoeFX25VZAgUgAHD9EdpD1cZ3Y+n2BOY/GzPOK7GpubHZ8K94Z2NfmwCcrjR+DUsag8e+v
	zIBZ2BrgPzP4X9mHPPo+6Y=
X-Received: by 2002:a17:902:f2d1:b0:2bd:3bfd:74f1 with SMTP id d9443c01a7336-2d041127ae9mr3387895ad.2.1785454398363;
        Thu, 30 Jul 2026 16:33:18 -0700 (PDT)
Received: from google.com (21.168.124.34.bc.googleusercontent.com. [34.124.168.21])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13e72643a12sm39399784c88.5.2026.07.30.16.33.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 16:33:17 -0700 (PDT)
Date: Thu, 30 Jul 2026 23:33:10 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Matt Evans <matt@ozlabs.org>
Cc: Alex Williamson <alex@shazbot.org>, Leon Romanovsky <leon@kernel.org>,
	Jason Gunthorpe <jgg@nvidia.com>, Alex Mastro <amastro@fb.com>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Longfang Liu <liulongfang@huawei.com>,
	Mahmoud Adam <mngyadam@amazon.de>,
	David Matlack <dmatlack@google.com>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Ankit Agrawal <ankita@nvidia.com>,
	Alistair Popple <apopple@nvidia.com>,
	Vivek Kasireddy <vivek.kasireddy@intel.com>,
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
	kvm@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v5 8/9] vfio/pci: Support mmap() of a VFIO DMABUF
Message-ID: <amvfNhagavtGqZ-W@google.com>
References: <20260715174737.15287-1-matt@ozlabs.org>
 <20260715174737.15287-9-matt@ozlabs.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260715174737.15287-9-matt@ozlabs.org>

On Wed, Jul 15, 2026 at 06:47:31PM +0100, Matt Evans wrote:
> A VFIO DMABUF can export a subset of a BAR to userspace by fd; add
> support for mmap() of this fd.  This provides another route for a
> process to map BARs, in which the process can only map a specific
> subset of a BAR represented by the exported DMABUF.
> 
> mmap() support enables userspace driver designs that safely delegate
> access to BAR sub-ranges to other client processes by sharing a DMABUF
> fd, without having to share the (omnipotent) VFIO device fd with them.
> 
> Since the main VFIO BAR mmap() is now DMABUF-aware, the new mmap() reuses
> the existing vm_ops.
> 
> The lifecycle of an exported DMABUF remains decoupled from that of the
> device fd it came from, i.e. the device fd could be closed with DMABUF
> VMAs present, meaning a fault on a VMA could happen concurrently with
> vfio_pci_dma_buf_cleanup().
> 
> To deal with this scenario, the fault handler now temporarily takes a
> VFIO device registration to ensure the vdev remains valid, and then
> vdev->memory_lock can be taken on it.
> 
> Signed-off-by: Matt Evans <matt@ozlabs.org>

Nice note on locking, enjoyed the lock dance!

Reviewed-by: Pranjal Shrivastava <praan@google.com>

Thanks,
Praan
