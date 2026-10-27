Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793126062;
	b=0tfDExEGA/2+ye/BBL3AtNQ/+ff7Hdt0dLI2zJ2Ja62R8Br3xvW/ljyDv7ivgANDQ7qB
	 7nPq9HZt6eiqVAmoSnmMd+8E4agbHTLGRYOyFXZu5Uv9x9cjuVefjA2R4sNgzQNIzmMwS
	 m5JBTlH+jfQ3E84VGjLZ0cchjiHO4fOc330haqc2IIo4YGaFKIaUZ69p1KyC7TR2phcCS
	 Vb1ES/Hv+LfrTI3AH4Uq8VQGdKWfG+mWdAxAvx3UlqukWH2ffG244Zf3lr6Lu2Qa921Sd
	 FijTYWjvBbNk4e2kwM/jVo7BVh4qZwkUzIg16C6DANCr21u5Rdut1PmhJPVoxU8Gn+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793126062;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=BcXyn5Pt3Ud5pWl9ffP7/JMMW96ISxtzbbqlGIIDb20=;
	b=kei5nKE7iGHYjoNwQ+5Zp/1VGczGS2bbH9JtNTaA0Gih2p3NVPrntZ2GDxhOp9r292Yz
	 PCenfZjvgq/tEOZ6Z/l82v8cEr945mVTVXogIvVaZtir0zF9yiQTs0JRm2g/htJhmnKyq
	 Y40g0fpuffR+3gtDTRF23QtUucMsFglPouIXd6zrh3R3Is2oQqAth5RxzmevY0oPohU/l
	 6siOllFgy3rFeODWl+YGbav+AgqNq/jiXlK0ySpJ++my4QxEH3ZnagQnEDHTG0INyWXId
	 +P4ArwNo3i6Nboy+axcoQCRnZaBPNDchTHHonxYR88Xip+JVY/mGdOM50Q8y1one0kw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=nmgeP0Sd;
	arc=none smtp.remote-ip=209.85.160.178
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A40C3606A31E
	for <kvm@vger.kernel.org>; Tue, 27 Oct 2026 18:34:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A40C3606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=nmgeP0Sd
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-5363c8de563so3260471cf.0
        for <kvm@vger.kernel.org>; Tue, 27 Oct 2026 11:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1793126060; x=1793730860; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BcXyn5Pt3Ud5pWl9ffP7/JMMW96ISxtzbbqlGIIDb20=;
        b=nmgeP0SdWfa2tzbuqRiyYonKuXW0nk59qgp/qUPB6taLSZg8kWKK9At6O2Ajgmb2YC
         lbLxDvJC0SIP3e/877Va0sLwnAIob1QYjqCI2C6BskQWwZaYT9QFpUmyF/PAOg79QBxa
         BgpM0eh/MvHQfaR/MV8LfX4qyFtxm02fUmeK+3culcJ6RAaAhZD85utDK3rgmst9J1nq
         GmMsomXLYHk4WY/N/+1acL7TT0cruXiXjV4yvffzOLHTKqdBYumYz5p3M5BFv564m37D
         l9ayGnZcZkyCtgJ0zi8QhEkOALXxQsYIb2ifQ4B8ZCXTvhuMgj2feIVj8nsgLH2M4M6j
         2pyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793126060; x=1793730860;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BcXyn5Pt3Ud5pWl9ffP7/JMMW96ISxtzbbqlGIIDb20=;
        b=fe2Hb2MKTs5l7c7hvMxhBzybBbrPFLXURjMaGBn7wvKA4Z4qhTaOnt2BbsDMRkmGd/
         xfSAYYzsrUgyOSj7V9x4aZUTIFKp9NQuhEa/vnNWZBqqrAOfSbNgzIaJ4ovSlEeLUhTZ
         QnUt7SQjtsVTOPXSHXWREH0/GwQwtJHLvZjVy/eVAMjn8MwP3vi3p2YETPwjYyHEZomI
         RiAjOht83+Tj5wfjM5THkxiWFhsP6tSFWq8MCvsMypLtaje7cZo1ucJ3iE1sVjY6hPFp
         LxylUw/Bw77IFOd7ilFmBW4y9XrtiEEzX6U2TQoYjve1YetGWXYwCUcS2UuIhvQiTIVU
         gW4w==
X-Forwarded-Encrypted: i=1; AKwUvByz4k/7If5mbClaZpnwdcEkLM1LW1fUCRf6ACc4wGTCMSFCKQF87iAHx6+8Mfzxb+sK2VU=@vger.kernel.org
X-Gm-Message-State: AFq9FYIaSaizHb5nMMNbszwiYRBC3IRn1IqJOthY/la+46ejsVfHLmuI
	LJiMic5QRlo+D6sjhlZn7tc0M3KaJbPmdsthff4sw0GeqHci2wsZF4v/zUD83W3OJ1g=
X-Gm-Gg: AYBFou3mvgqpplSAhZz/rYBiJI2ZUbn5c+H946tMX8aWGe+WroUtdpX3g5RR8h/OGXJ
	Cgb6UNXsrzj2ZOvojHXKrP5JoL10pZrqp4YGu/carkHeDzZy0iIXiEmWLFFh3s7I3m6nM6P6nwG
	PmAWOTd2NvhC8mrEhgHnhCvpDs92U4VKzbyZxjww7RQwuS4lpcFuGpyTYjPlnIOy2LXXLWMUdFj
	mqSHU9uPvLWo4kIqxSsHLrXHhQecxJAWWm0Y8XaUxuiu2+OODLXs9AcSDE7Lv+XZWLprRlFe6tS
	ZIw3itoat1EOaBsmNJ0Nwg48JvKIQLjeh/PH8+QjqrGWb4VGCjRoEJziwE4xry2I/TVUSI5nxkH
	hLkffvK7pv+UoebqAsoMAA4y3SFBExBgYKg9bbHbHt+cNrdqN99gqKV5RaLjSJLJ8uMYeOA/g0Q
	zjDPbAY/y9eVuNn69jsu4dLKSOtmpJ5PKvOgwIchHjKWSiwS1m1SLvlxOZbjUa/BGrDUkCikaFY
	GI6kLPP/LtPGpmNJwlCnw9wEnktXjgopx69HEJn1jSmip9XCxvZ298UJVMhueE3THiO0l1h/QDb
	ErWgUEKWreBdPV2gCqiTkOWxeJBTDqhnBimpFA==
X-Received: by 2002:a05:622a:4d07:b0:536:458d:525e with SMTP id d75a77b69052e-53fcc5c17c1mr1974831cf.37.1793126060344;
        Tue, 27 Oct 2026 11:34:20 -0700 (PDT)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-538394c518csm84854701cf.8.2026.10.27.11.34.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 11:34:19 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xLm02-0000000AgqP-3BXi;
	Tue, 27 Oct 2026 15:34:18 -0300
Date: Tue, 27 Oct 2026 15:34:18 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Guanghui Feng <guanghuifeng@linux.alibaba.com>
Cc: alex@shazbot.org, iommu@lists.linux.dev, joro@8bytes.org,
	kevin.tian@intel.com, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org, robin.murphy@arm.com, will@kernel.org
Subject: Re: [PATCH v4 2/2] iommufd: Add IOMMU_GET_PCI_MMIO_WINDOWS ioctl
Message-ID: <20261027183418.GJ1685504@ziepe.ca>
References: <20261022193359.GF3381610@ziepe.ca>
 <20261025133000.205508-1-guanghuifeng@linux.alibaba.com>
 <20261025133000.205508-3-guanghuifeng@linux.alibaba.com>
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
In-Reply-To: <20261025133000.205508-3-guanghuifeng@linux.alibaba.com>

On Sun, Oct 25, 2026 at 09:30:00PM +0800, Guanghui Feng wrote:
> +
> +/**
> + * struct iommu_pci_mmio_window - a PCI host bridge MMIO window
> + * @start: First PCI bus address of the window
> + * @last: Inclusive last PCI bus address of the window
> + *
> + * A memory window claimed by the PCI host bridge that a device sits
> + * behind.  These are PCI bus addresses (what appears in the TLP).
> + * A PCIe switch could misinterpret DMA to these addresses as
> + * peer-to-peer traffic and route it to the wrong device.
> + */
> +struct iommu_pci_mmio_window {
> +	__aligned_u64 start;
> +	__aligned_u64 last;
> +};

We already have struct iommu_iova_range, don't need another one.

> +
> +/**
> + * struct iommu_pci_mmio_windows - ioctl(IOMMU_GET_PCI_MMIO_WINDOWS)
> + * @size: sizeof(struct iommu_pci_mmio_windows)
> + * @flags: Must be 0
> + * @dev_id: The device bound to iommufd to query
> + * @num_windows: Input/output number of MMIO windows
> + * @out_windows: Pointer to the output array of struct iommu_pci_mmio_window
> + *
> + * Query the memory windows of the PCI host bridge that @dev_id sits
> + * behind.  This is advisory: the kernel does not reserve these ranges,
> + * it only reports them so userspace can choose to keep its IOVA
> + * allocations away from them and avoid accidental peer-to-peer DMA
> + * routing.  The reported windows are pessimistic (the whole host bridge
> + * window, not the precise BAR ranges that may actually conflict).
> + *
> + * Windows are reported in host bridge resource list order.  They are
> + * typically non-overlapping (host bridge address decoders are exclusive)
> + * but no sorting guarantee is made.  Userspace should treat them as a
> + * set and compute the union if needed.
> + *
> + * If an IOAS has devices behind multiple host bridges, query each device
> + * and take the union of the results.
> + *
> + * On input num_windows is the length of the out_windows array.  On
> + * output it is the total number of windows.  The ioctl will return
> + * -EMSGSIZE and set num_windows to the required value if num_windows is
> + * too small.  In this case the caller should allocate a larger output
> + * array and re-issue the ioctl.
> + *
> + * Return: 0 on success, -EOPNOTSUPP if @dev_id is not a PCI device,
> + * -ENOENT if @dev_id is invalid, -EMSGSIZE if the output array is too
> + * small.
> + */
> +struct iommu_pci_mmio_windows {
> +	__u32 size;
> +	__u32 flags;
> +	__u32 dev_id;
> +	__u32 num_windows;
> +	__aligned_u64 out_windows;
> +};
> +#define IOMMU_GET_PCI_MMIO_WINDOWS \
> +	_IO(IOMMUFD_TYPE, IOMMUFD_CMD_GET_PCI_MMIO_WINDOWS)
>  #endif

I wonder if this should have the word PCI in it..

Maybe this is 'recommended reserved regions' or something?

This is also lacking a way to send the ranges back in so they create a
restriction for the allocator.

Jason

