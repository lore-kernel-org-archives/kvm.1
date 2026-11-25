Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795566258;
	b=OupyGJ4cSCfkuBTL+LwOQHfEvIT8wRo9ifiFQt3uteO+mqdJA5yFj+ARQqhVza6n5+Ow
	 nTP/wDFTkX3dadsw3yCArS9OsJZn52xQ7o87JwLhb9bZh6IIpdUQSWFmLRA5wJ+e1lDhP
	 j5ra+x+ENUVjRANyYoatqYpQfIALK4fugYgjzhB+F+bGTlXNpXfW52oHtKCLw84JqZqO7
	 Y6bv2oaowssxEYG0FQ8igbkZE81X05T/QSzaVGEp3RNjuVXkwi3aw9yCWy8tuZ3U7huzc
	 MssmhSQdYtBRkJ3M3aOeLluwYyy4lvuT56Bhv/5vnbG6D18DosUoYo/NP47GRSyBFSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795566258;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=YMO/Q4LHoS6IxvSYVAkwFpWA6bWqlpOH+BNCvhBFP1g=;
	b=0rMSdaLq3XHHMJ1yAuyz3IWwMP0+K3LX/DRqWp/QC7lpWyuybrlu1LA3DRnaX2zjqlBQ
	 Unw4PmylG+6xmQ3A0JW8TzPBgcwHJyy9Ly/79nXr4t1lkeV6VbGVQ1tX9hnAl9JIdMpNe
	 j3vPxl2u+PJ+gElsd7IRXOYw+mEtIc2mTWp9WqSXg2h1hhvPRr+BsSJ+3XYPHrolMhZgm
	 PVRrjMwucz8OzchRHOXVQDOUZNZEqhRGMhtS3V49dlSxQGIwH0AIUE5iNQrwheInnP6xi
	 XC5s95giZivC2zV1h8ckSokVaLEsolW1kvPoVMxAd2+jkB4a/wtuKyJOFkWEJ3KHR1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=nvA4xsJY;
	arc=none smtp.remote-ip=209.85.214.174
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48777606A32A
	for <kvm@vger.kernel.org>; Wed, 25 Nov 2026 00:24:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 48777606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=nvA4xsJY
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2f048bc09d7so242505ad.0
        for <kvm@vger.kernel.org>; Tue, 24 Nov 2026 16:24:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795566258; x=1796171058; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YMO/Q4LHoS6IxvSYVAkwFpWA6bWqlpOH+BNCvhBFP1g=;
        b=nvA4xsJYbyjlVUxR+uk4yXS/M0iXumDNQvEFcjik+fzfX0hxCUG8igTP+aEBUQKhWU
         01rPlsYZxijr1nIFh0HnhmIqvQDte+9GB9vgwkcgoDmEZlgpGqs5n719qFTdxZxpqmHD
         smlvTgzd2MsCxkh4iC3Pj3xgW0A8Vxl/d+etRiBo7TyLfUmGaEDmFSkc1zKYBT1NH1su
         QsnQAeJzEmHi0cQJ30I2MOkUNe8XLlufgoLeZ9DETN2Ob5Y/qQNwZctS+bf7T52hpQPK
         WciL243GxjFlJ67fODnf4z60/dH9j68n9GubZQYbMlxniUpHCzE0u2iUedJtX7wAGNLR
         a8KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795566258; x=1796171058;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YMO/Q4LHoS6IxvSYVAkwFpWA6bWqlpOH+BNCvhBFP1g=;
        b=DK8ZKmOvBtMXWiQJxHJM8bqpYYLF5rptViNIPV5e0tiZ+rLJ+0LUXE/E+FxQ+aZq1D
         hqfpKaeaOXU0epCxW7LLKyhRGV0PoPxTG5do8ezOPtfLNHGVl5pj6atmv/cGQqcWcM8h
         YhM9ZyzlGA6FzG1fdVTsn0GaV9Vt6Wzof+qtMP7V1g+g7y6ZVOR/hK9Oud9YO5fzlhYN
         E79YRA8W7TZQEFwWEwg5HDSTG6ZBDUOvtrx637valtG6t75fScC2/arze4auqbZqvM67
         ubyt/eQpDgzftytHgFWpeknhMz9tMd84RYlC0RQgN3fPTEeAPUlKskEJby0CqGXg6Ody
         ISpg==
X-Forwarded-Encrypted: i=1; AL+hErEi5nK8umTwc6QMWlC9xPOwGizDNXe1EzgdYTJSDsyS9cTeX9O3asWNDpRoZa+l//ntRaw=@vger.kernel.org
X-Gm-Message-State: APuU4Z8sE5i5c6KQKP7yo+biBO3Fb2V5Bk3AzWtpYatKKHIieCirsHWk
	+4x9R6iqBPBoPNTrfaq3YGYKEMEe+2YXqNDvHQ832opwjZkfByUqpuK6ZE4rHAjNCA==
X-Gm-Gg: AZFdTZe2UpxQg/9OKZfRuf+/ypnkqcwrtPuoVcNsNXRJDEffBqhoESczy2H6V/U2frU
	zT+XlDIFGuOcIaqhKcHau3xhlA4gv8G/lD1LSDBaJZMTP/WKK4bVOfOymGvhmeSlKGohlQBOdA1
	9SyDj0MiPv3JyMty31w3ee/Co4Y5deqOxKo+ZG0RKYsukmy8cW57IDd0GQ7wknVVFJKrsLkYU2/
	HrkbBNkAjagOT6Ao99cLf5LiFmPLM7y62yV2oSuTpJ+6YrC/dYXshHZR7DRBSzMVJVVDZdttPMt
	zCKMUbTLSTXFGVzj2XbfYnT+9Lb4JfZxXFUqAhWtDFS4o4ayDfyJAuCitdZGRlcaokYXri8NyZ5
	8USxzPoe3mgglwh94adWWJ+X695KcCs1KRmaBjni8TrhUxJgiMgeJJd0Wo7BHtwjy5+W92f4rhm
	jYnhIgI4lbX2zXqCgtnYx9lbYMUx2uagnHe04AtQeXj/10Vv/Mf26XxmbUaUsEjhsPCjO9+2yGQ
	pI9AxhEYW22dvQfGsX2XBKSxKwzKW6UQXGiyCIkXwxecyX0okelzHaXwk2RMP2JyP1oByFP51j4
	VBL3oue9mF6iPCo2A3XokImJfbT6tzone+YAC3VJchorSCzu1ADO3ETQ8cbnyyWcCIb1w5scloP
	Qh6PFYt28EpzK
X-Received: by 2002:a17:902:e950:b0:2d5:c090:3810 with SMTP id d9443c01a7336-2f06242bd42mr16475105ad.2.1795566257244;
        Tue, 24 Nov 2026 16:24:17 -0800 (PST)
Received: from google.com (176.13.105.34.bc.googleusercontent.com. [34.105.13.176])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cde6cff4c1asm7632022a12.15.2026.11.24.16.24.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 16:24:16 -0800 (PST)
Date: Tue, 24 Nov 2026 16:24:12 -0800
From: Vipin Sharma <vipinsh@google.com>
To: David Matlack <dmatlack@google.com>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org, linux-pci@vger.kernel.org, ajayachandra@nvidia.com, 
	alex@shazbot.org, amastro@fb.com, ankita@nvidia.com, apopple@nvidia.com, 
	bhelgaas@google.com, chrisl@kernel.org, christian.koenig@amd.com, corbet@lwn.net, 
	graf@amazon.com, jacob.pan@linux.microsoft.com, jgg@nvidia.com, jgg@ziepe.ca, 
	jrhilke@google.com, julianr@linux.ibm.com, kees@kernel.org, kevin.tian@intel.com, 
	leon@kernel.org, leonro@nvidia.com, lukas@wunner.de, mattev@meta.com, 
	michal.winiarski@intel.com, parav@nvidia.com, pasha.tatashin@soleen.com, praan@google.com, 
	pratyush@kernel.org, rananta@google.com, rdunlap@infradead.org, rientjes@google.com, 
	rodrigo.vivi@intel.com, rppt@kernel.org, saeedm@nvidia.com, schnelle@linux.ibm.com, 
	skhan@linuxfoundation.org, skhawaja@google.com, vivek.kasireddy@intel.com, witu@nvidia.com, 
	yanjun.zhu@linux.dev, yi.l.liu@intel.com
Subject: Re: [PATCH v6 12/27] vfio: Enforce preserved devices are retrieved
 via LIVEUPDATE_SESSION_RETRIEVE_FD
Message-ID: <20261125002302.GC3545683.vipinsh@google.com>
References: <20261102153656.1431701-1-vipinsh@google.com>
 <20261102153656.1431701-13-vipinsh@google.com>
 <DMZLVV5YW6GW.1HMW8L8NIQ1XR@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DMZLVV5YW6GW.1HMW8L8NIQ1XR@google.com>

On Thu, Nov 19, 2026 at 04:19:34PM -0800, David Matlack wrote:
> On Mon Nov 2, 2026 at 7:36 AM PST, Vipin Sharma wrote:
> > diff --git a/drivers/vfio/vfio.h b/drivers/vfio/vfio.h
> > index 12557d45dfee..e6ca4c3fda06 100644
> > --- a/drivers/vfio/vfio.h
> > +++ b/drivers/vfio/vfio.h
> > @@ -11,6 +11,7 @@
> >  #include <linux/cdev.h>
> >  #include <linux/module.h>
> >  #include <linux/vfio.h>
> > +#include <linux/pci.h>
> >  
> >  struct iommufd_ctx;
> >  struct iommu_group;
> > @@ -446,4 +447,21 @@ static inline void vfio_device_debugfs_init(struct vfio_device *vdev) { }
> >  static inline void vfio_device_debugfs_exit(struct vfio_device *vdev) { }
> >  #endif /* CONFIG_VFIO_DEBUGFS */
> >  
> > +#ifdef CONFIG_VFIO_PCI_LIVEUPDATE
> > +static inline bool vfio_liveupdate_incoming_is_preserved(struct vfio_device *device)
> > +{
> > +	struct device *d = device->dev;
> > +
> > +	if (dev_is_pci(d))
> > +		return pci_liveupdate_is_incoming(to_pci_dev(d));
> > +
> > +	return false;
> > +}
> > +#else
> > +static inline bool vfio_liveupdate_incoming_is_preserved(struct vfio_device *device)
> > +{
> > +	return false;
> > +}
> > +#endif /* CONFIG_VFIO_PCI_LIVEUPDATE */
> 
> No need for the ifdef here and 2 definitions here. If
> CONFIG_PCI_LIVEUPDATE is not enabled then the compiler should be able to
> optimize vfio_liveupdate_incoming_is_preserved() to false.

Okay, I will remove it.
