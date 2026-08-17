Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14AF93C4171
	for <kvm@vger.kernel.org>; Mon, 17 Aug 2026 12:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786969096; cv=none; b=HrhBtIzN/LbQNzaeJwmJ5F6TGP2B1k7AOicmTv83W4zsMW/Ox/yQZz8ZTszG38Majrj23sbTJA11L7T6U/mjlMlH5dPmH8wFZWCmGjw3WmBMxR5rkMUA0t4tcKWKOFALGu650UMFm/QdJs00mDgIB6Aa07sihMPcQ2JBLDiiUxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786969096; c=relaxed/simple;
	bh=RG1WQKYzwFHfo9x/GFB8G0epwHF+rFnfAREYEUuqHv8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AdmBcqA2EvfnQ+Ea9vsIY5kJ2piikTVeDH1MzcOpPumC15ImtjaFg5wSD97nso0Okza0+iywx5I6XM3dOhkGPgSSKeimyJgpv1aUJ0SB0uwOKd6yglBCp4Al8BrJZno6NFCylLgR6vScUmj1WSFdTiWCmL/CDGSR0KpcVaoF8CE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=FlpoiiRT; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="FlpoiiRT"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-92ea24a2dbfso271824085a.0
        for <kvm@vger.kernel.org>; Mon, 17 Aug 2026 05:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1786969094; x=1787573894; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ssGSkvbB7xNlIkXjL7DRTJtJS9sZVm2NXMnYSqtWYgk=;
        b=FlpoiiRTdQA5bsaPw4RFj6uqEJdFDrfnXvUx3MC4WTB91SCMIAm+Tfm8U4AvHJK+Oq
         ClySINGGqjpEcbmJCITSDRLsCUtPD0pWgakkufi0iFLhKrpdFFwLUAqr27AhhdK86n1p
         nbng47gHBK9BffTnCEliXonDUBF2i++Okn4uVaGKXVVENH24447k0M0+vKUS/7osljeR
         bdSddS34v5mLFrVY7A/7u2HXPIsCrF54X14EbXRtxkcLQKYDvdvcobRNZ5iyTFUX+YLM
         QMDea8fxSzaj/g99KbXRtlDn2zOGrturounpLNVjCS0fyvU0a1qLROqofg+Dsc2ZxjPN
         SY8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786969094; x=1787573894;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ssGSkvbB7xNlIkXjL7DRTJtJS9sZVm2NXMnYSqtWYgk=;
        b=r2zek6X68EBIRANITimbV/z7vcIgLdCZK2rTNjX4LvnV+bOZsZb9tXaj6PYd+WINyO
         C1d+xmkWAnLOrcF5LPO5kbPh/KJpgy3VrVDVrt9QITUwq8LqBk6RoDosoh8ogh+GqRm4
         e9vQfL/sFXoZ21XIl/ivlqo196HhXIi3Z1akhAw08iN0O+LlDms47Tn5EYnt2FIBDtzE
         Z2HvhVQJEjbvBNrybXbaKPL13I23eDo1rxUIcLLzAvgyRk1jQzPgIciIHCQ+FxvUBoz1
         qWKJHdSn2YSg/m3uKvxjQD+htGnIrBYp+RBHgxXMZxsOzx31/rHuo2MtxvQerLMS9jQn
         C1qw==
X-Forwarded-Encrypted: i=1; AHgh+RprNq7lVWS17xg3UXQQmHjWxkSlwWr/yJijhjpHUwOwllkP44J3Nv1+dwr8W9zejDhKEsA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxywpnh6hVx3XZ/z/eJfD+r9rG/nYV4CPOM6ktKJRCe0JTlOs62
	hIA7KVIPsz3rrqp9V7eoD8BqzQI8p2Y/JUVdLbwc8lySPWRNYGYPJ7gG1na3/P4urvc=
X-Gm-Gg: AR+sD10zZvrjNWXGTMNKRB+l1YNNk8U1BbAZS/mjRJsz20JVAVw297E/FxxfQ4RRQ9O
	ksdkZUHOm2xKJAaBtmfP2XFGMVdwbLy33L/uBjOGFz8d09IQi8AzARh5v+stVo2PTRqZ+mevvRD
	RCuSayaYv1gzUENGybzaaIsbQZomYKVCwSKzA7ToA6Um4dGZtNpO0oWCRZ5OE12zFZxa946BzKb
	8L5zWhzNu1DA+wmsQaAxZyuQWz9OD3ZHnsgS5tKMMrU7X2xmzG8GhQI04PMEQjmMSyG5CmCv0uU
	RpOcEwho6Qfvr4bNWIWJesXkYzFfzCl/HTIlKrKPCkarT7CIIkXHndXt1/GWn0/GgDSRLOqZPlS
	Fh6Z30mYvm7V79tv0vq5hSJoO7MAiL0TwxcOUiXqkeBLaBlRDblwZRaOlbyp8QBLA41ye8B3Pap
	poxjvQMwcUxQFzfWd1Zf+nL9GL8/iV/9XsB7qqvg==
X-Received: by 2002:a05:620a:2904:b0:915:de68:1802 with SMTP id af79cd13be357-936d231eb4amr2766839485a.41.1786969093885;
        Mon, 17 Aug 2026 05:18:13 -0700 (PDT)
Received: from ziepe.ca ([142.166.156.215])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-937033fae8esm30006185a.39.2026.08.17.05.18.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 05:18:12 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wvwI6-00000005tDu-3DCL;
	Mon, 17 Aug 2026 09:18:10 -0300
Date: Mon, 17 Aug 2026 09:18:10 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Alex Williamson <alex.williamson@nvidia.com>
Cc: Samiullah Khawaja <skhawaja@google.com>, kvm <kvm@vger.kernel.org>,
	Alex Williamson <alex@shazbot.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Kevin Tian <kevin.tian@intel.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linux-pci <linux-pci@vger.kernel.org>
Subject: Re: [RFC PATCH 1/5] PCI: Refuse function reset of an SR-IOV PF with
 enabled VFs
Message-ID: <20260817121810.GC933791@ziepe.ca>
References: <20260812045325.2733631-1-alex.williamson@nvidia.com>
 <20260812045325.2733631-2-alex.williamson@nvidia.com>
 <an5JbIzz40svS3xe@google.com>
 <20260814083737.66bb83fb@nvidia.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260814083737.66bb83fb@nvidia.com>

On Fri, Aug 14, 2026 at 08:37:37AM -0600, Alex Williamson wrote:

> Devices are only ever opened into a user owned domain, the IOMMU
> context switch happens before this and regardless of the reset.  Close
> also disables bus-master regardless of reset, so there's no risk of
> ongoing DMA if the device is placed into an identity domain between
> close and re-open.

I've been told by HW people that bus-master isn't actually a strong
fence for stopping DMA on most real HW. More of a 'dma will eventually
stop' kind of thing.

It does reliably prevent DMA during the post-FLR phase only.

If the device hasn't been reset it should be kept on a blocking
domain.

> PF, I think there are arguments both that the user implicitly opted in
> to the best-effort reset, as well as a use case that allows the PF
> driver to fail and re-open the PF demands this behavior.

I really think we cannot alow a device to be returned back to the
kernel without a reset. VFIO should be keeping things attached to a
blocking domain as long as the driver is bound. It should force a
reset during unbinding as well if the device FD was ever closed
without a reset..

Jason
