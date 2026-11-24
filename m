Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795528380;
	b=C1Ld/z5MgnI00C6J4rl/u6WwR3aCeJbKHYkEU2mVbUi7wLr77/sUR5cJ7mYGlQjYvxo7
	 dlH5vEj+tUxl4hi7Y+HivKC2mcqmsr1PjxtbUc726UDhd+EAEix9hwZyNzWgtBMPvhF1Y
	 FWDYl5xLDCuIpsFx+BkL0GXVt8Mw8HvaMCKxNn/UQGge7giwy4QtEIxEf6vvNlsfnne7d
	 iLU6sJNGNqZrFU/amYvCP314ygmpj3Hd11KgqXZPAAwwLZ37OW+mig+mX3w1BIOjUB082
	 znp2nhc9bHi98Jjlobaeik3imvlv76TOWxtveN/NTou0DsSBOoy15YTCupyvbqW720A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795528380;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=ervTDQvCqZVrcHY/akwPcAXB3ZloIorGLfgD/yjQ628=;
	b=E3U126sOZbzA8zVqmLRqXvZltmlSRUSMlqG7a2BE2pZ20zNi6vmzhoJQYreG3WtjfcOV
	 YXATjvGMKhmURn9WhjWvzeMxI9UH9h8leiYAvpJIPFlQwRq9GbqohCaBUhuoqWImcX5nJ
	 qVdy7LnAQKpprnbGhZ14eZSvGt47xnI4euaJ0pAYYjH+99ekz9YJr19LPHMDyIo5DWeLv
	 vO6DR3amOQWFw1EIgJl9lv7cNp4hd93M5weekDhatOlPgXFzxWv8jRorIwEDMVGn2Wzb0
	 Gljz8NKVxzHY4oewqmjYgQSGox/3gAFUy2Gy7ZfMkzdV7wysnK2PdQXY6V4PGnL/Hdg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=kAV8M+WE;
	arc=none smtp.remote-ip=209.85.219.53
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BFFD606A31E
	for <kvm@vger.kernel.org>; Tue, 24 Nov 2026 13:53:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6BFFD606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=kAV8M+WE
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-921342fae7eso49576966d6.3
        for <kvm@vger.kernel.org>; Tue, 24 Nov 2026 05:53:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1795528379; x=1796133179; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ervTDQvCqZVrcHY/akwPcAXB3ZloIorGLfgD/yjQ628=;
        b=kAV8M+WE2u1z+iDbpRaYLaa8uAZIhKoPynLBqtU0x6yNPd8+/UrQBkICZIdrw80/N1
         uymx6XmLYdbrYNuKeDAhPwOyiI7Krg8e3gz/j/5uE/ZqyzLiDGJ2mai5T9ziVaU8Myp2
         qyTSr8GIk4jYAvQr6LYQP3tas43VCSX89kJcV3C3kYxyP7NfnOETpkRLCB/eDsCVi8/i
         O+6Fgql9pEzuMdNbB7bDfZtyLrKApScI/SBJ/XvQ4ldfeWNxvFgwTbW3JRJuZNVbSImG
         /6upRkGe9TbcTavRepmjIAHaFZ/pN6U/gb++Csl9I69uDHjWA5nwM0QFLDP60AS6fhaw
         cNdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795528379; x=1796133179;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ervTDQvCqZVrcHY/akwPcAXB3ZloIorGLfgD/yjQ628=;
        b=Wf/R0p1PVufj9s79pFKzJtyTRBEDHbrwNFHwELkIrkvbbJ4/tuSEy1mdCI36D8qI/d
         v4VfuN1879wFAWN3objH5aViIRB5XOeqAyqqPyFByWF35CVMzr7kjSfqTgf8JVgwKLE3
         Sp72XlFTDGs/gFNCTFfshg62PQAJNWJkI1x5H3pyL4JDZN9fZMygYuXal5yn6B5xKLq3
         7G3lfYbszoNVd+L6l6mDiFptsZicwVhvOxj81phwa2TYujIsVF9XsLOSQsb7cQgffl/u
         W4i/3EPUsf67Xr/Wba2jQl/COQCQsI9gQXYBKSt4rjuSFEvPFhVqtRTrEOCqKKNwjB9w
         IzeA==
X-Forwarded-Encrypted: i=1; AL+hErHEd22iIC5ghloVcSEFkVR/DKbZNSjkMdKXfeKjSQMxStjRF+m6ek/fPnDVqbBPlo2S32Q=@vger.kernel.org
X-Gm-Message-State: APuU4Z/qjj7ikRcVHL+38FDGG4K1fxZ2EIeyb5pe+gHAyQp8J7lb4YYp
	f2TN0lv0XfZqwCS4QpYf52cEt8faSBG5snWXsCPwLETSKpXr/M9aCq3AezuqO6wznMw=
X-Gm-Gg: AZFdTZejfVqv6Z5en/r34mF+QSsr0YiZ+M6QAebr2dd2H3En0zHdMSVqOL4QRXLURCn
	W8/oqW3dWaSQ7evlZ45lTXwud1w/B98fkltcnPcYdddTtfN/WKvG1yCeFHJ/MpPkrLPM+IWHqHR
	1gwS5g8EERLUljZDqnwqrxX4o/1pE701X3NyG2mlHsIqzExBCdX1eUnm8ANnd/wRz5xuyT9KlnB
	Io3OpcWfo1nO8o7PUXq9boxfP2EouyUhnVz7Nuiqv0MZzbpKRSYzmJhdHLdwmTdZSf3Nrc579vG
	vzXIqIw8PfS5P4Ifq/QGFEgFae0EidSAKi45kmDQt6pX1xibh9OQPou1WXUjLXM4+XAmiKmRR4o
	a50jTm15qyqiOBXBuZIL0D5NZ8TRoXZlI+iLGR6LmHQURmPWRH9Ao4nwsSr+gB1A5wHJK89/brN
	vaEir6TQieFNEuHt2Tt8ZvMg3T2CxOHicK8lX4C22Qp7LV+dOJ56a/ATBsRHR2DS2DZsU3cZoHG
	fRfx7RDc1snDs86XjIGs3HxICYOo3lkcODGGCFcufYUMvF0rEzST6HKD32ujrM7TJa6YwhmRLOi
	uqmpk0A5/Pk/cAMj0eFwt3apoyg=
X-Received: by 2002:a05:6214:1d03:b0:921:4c11:f6ef with SMTP id 6a1803df08f44-9214c11f800mr175124426d6.1.1795528379371;
        Tue, 24 Nov 2026 05:52:59 -0800 (PST)
Received: from ziepe.ca ([142.177.118.84])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-92134796288sm133191406d6.6.2026.11.24.05.52.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 05:52:58 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xVqx8-00000000QWu-1KcY;
	Tue, 24 Nov 2026 09:52:58 -0400
Date: Tue, 24 Nov 2026 09:52:58 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Guanghui Feng <guanghuifeng@linux.alibaba.com>, linux-mm@kvack.org,
	Lorenzo Stoakes <ljs@kernel.org>
Cc: alex@shazbot.org, alifm@linux.ibm.com, ankita@nvidia.com,
	dakr@kernel.org, fengchengwen@huawei.com, kevin.tian@intel.com,
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, mattev@meta.com,
	ritesh.list@gmail.com, xinmengs@nvidia.com
Subject: Re: [PATCH v2 2/2] vfio/pci: Align BAR mappings for huge page support
Message-ID: <20261124135258.GK9566@ziepe.ca>
References: <20261124073048.268988-1-guanghuifeng@linux.alibaba.com>
 <20261124124004.457441-1-guanghuifeng@linux.alibaba.com>
 <20261124124004.457441-3-guanghuifeng@linux.alibaba.com>
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
In-Reply-To: <20261124124004.457441-3-guanghuifeng@linux.alibaba.com>

On Tue, Nov 24, 2026 at 08:40:04PM +0800, Guanghui Feng wrote:
> +unsigned long vfio_pci_core_get_unmapped_area(struct vfio_device *core_vdev,
> +					      struct file *filp,
> +					      unsigned long addr,
> +					      unsigned long len,
> +					      unsigned long pgoff,
> +					      unsigned long flags)
> +{
> +	struct vfio_pci_core_device *vdev =
> +		container_of(core_vdev, struct vfio_pci_core_device, vdev);
> +	struct pci_dev *pdev = vdev->pdev;
> +	unsigned long align, off, off_end, off_align, len_align, addr_align;
> +	unsigned int index;
> +	u64 bar_len;
> +
> +	/* Don't interfere with explicit address requests or fixed mappings */
> +	if (addr || (flags & (MAP_FIXED | MAP_FIXED_NOREPLACE)))
> +		goto out;
> +
> +	index = pgoff >> (VFIO_PCI_OFFSET_SHIFT - PAGE_SHIFT);
> +	if (index >= VFIO_PCI_ROM_REGION_INDEX || !vdev->bar_mmap_supported[index])
> +		goto out;
> +
> +	bar_len = pci_resource_len(pdev, index);
> +	if (!bar_len)
> +		goto out;
> +
> +	/*
> +	 * Select the largest huge page size that the BAR physical alignment,
> +	 * mapping length, and arch support can all satisfy.  Only PMD and PUD
> +	 * orders are supported by vfio_pci_vmf_insert_pfn().
> +	 */
> +	if (IS_ENABLED(CONFIG_ARCH_SUPPORTS_PUD_PFNMAP) &&
> +	    bar_len >= PUD_SIZE && len >= PUD_SIZE)
> +		align = PUD_SIZE;
> +	else if (bar_len >= PMD_SIZE && len >= PMD_SIZE)
> +		align = PMD_SIZE;
> +	else
> +		goto out;
> +
> +	off = pgoff << PAGE_SHIFT;
> +	off_end = off + len;
> +	if (off_end < off)
> +		goto out;
> +	off_align = round_up(off, align);
> +
> +	/* The mapping has to span at least one fully aligned huge page */
> +	if (off_end <= off_align || off_end - off_align < align)
> +		goto out;
> +
> +	len_align = len + align;
> +	if (len_align < len)
> +		goto out;
> +
> +	/*
> +	 * Find an area that can hold the mapping plus the slack needed to
> +	 * shift it up to the next aligned address, then apply that shift.
> +	 * The shift preserves the relative alignment of the file offset,
> +	 * which is what makes the pfn alignment work out.
> +	 */
> +	addr_align = mm_get_unmapped_area(filp, addr, len_align, pgoff, flags);
> +	if (!IS_ERR_VALUE(addr_align)) {
> +		addr_align += (off - addr_align) & (align - 1);
> +		return addr_align;


PeterX was working on this previously and last time I was not excited
to see all this mm logic open coded in drivers.

I was hoping to see that the core mm could provide some helper scheme
for drivers that already know what they want to map to get a vma
alignment that is optimal for the architecutre.

Peter had a design that seemed like a good exploration at least..

Jason
