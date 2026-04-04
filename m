Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 393B621638D
	for <kvm@vger.kernel.org>; Sat,  4 Apr 2026 18:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775328815; cv=none; b=ZAhe8JlOLXCgbCe1l6NbqAbi/uYLyj8eYkdXvzobxayaUQftcDUiMDj3JIub84bJ7V8Hs2mze8g28GWiTi596MnD1MlHU7zL3WC8VlHDZw4xFriqjg+iEjJ+5fH9K87TKKo0xL7SIazysPidgyBlAKrBcZ2NgQxC2TEKOmHJuuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775328815; c=relaxed/simple;
	bh=dtScXWXhuDldnt6Kvgogigjrvo1FHXnb9GiXekrXjiM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IKNvhgXtLVR61diOxfigkx3FimOddrv3l8cRTwaNqL6AKWzg7QjT+J6vGzzkcMr/oXCh9yEoIJ4LH1GH9rckh9qTSBp2nmNPrlu6boTbNOF5vcwmrqEOyEki17xRuJF2YVMWad8AY1GyHMPjb/zQUTzjNBYq4B+vn9zgukTzTQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=ByDIMUKw; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="ByDIMUKw"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-8d4f78fc9f6so154135685a.3
        for <kvm@vger.kernel.org>; Sat, 04 Apr 2026 11:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1775328813; x=1775933613; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Nck4cGiGZiXSzZzHQhsuUAn9cXTimQB//kh9QdWI6lU=;
        b=ByDIMUKwmTdGCOxitwoHje2n/+PTeyBAv707lgF33j61xnMUcwkFFHQqg/RkbGFaHh
         Zz6yMrfvfJnvp1flwz60AtMoXBTvUV4tbTb4YcH9CxdfZSk5kxULJ8Ifmacf+MQfqZqs
         VWWcDBe9rURqQ9M7dosyV3nNTgCDXz222O6V/tHlKCwsbnzrIcB569Ghy8B6/p9i9nsW
         5tJiNINRpJWSZe0MKlDI+X4ZcTXtdZZtosUT9ATanZKqQvVfbL7H1aJUiHQjy48Qa8OJ
         4uG5XtFt90iMXBenMCAVNAUjfUy0eEjr2qLh2l431Rryhh7wXaNGNfAU/uH1jB8IQ79y
         azmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775328813; x=1775933613;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nck4cGiGZiXSzZzHQhsuUAn9cXTimQB//kh9QdWI6lU=;
        b=F3INjrVu2VJ9HC3AdElxr5Q/ywFdcNZknT/Cgu1Fg0hzRJAQ5xrTJmTCJRfTgtoQa/
         OXGSf+2fiTIpVFfo0tMbcpKcRmAbOsuRiCVnBQW1NQFD/Kr9jWGgO7pyCXWPVQ4lzFrM
         i3DxgH5/hp8eW8QAlmVQPAEAQY4Xx0cKSpcJ+pfQX/7YJ2AiK02loynqS1d0I3psRFDe
         vS3f/fAwJy16aPMK0uCjjE08Sf4TrfUEnXrC5lWkfOwVA7atKpKWZpWz9FQ3jbJqpm9q
         qjwCnshIJSOLWAVCPKNWdq3PxXc5WtpTdAqTSCq+eaKGVe6QmJ0SBt13JvlWkEXmryf5
         PRzQ==
X-Forwarded-Encrypted: i=1; AJvYcCWYEkFfHTMCdhNk0Aw9geH9kFNJ0g0fV9Xa3gAlmR30Sy7AI35S5/ui5gnJXfsCbWdoDbY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzmhtlra8MMhNcdeErZcSKKGyM05DQuK6AcXiXEyjM7OdXm+V7K
	tRJDbCwvOamUftDq0yGEmCipAi1g3iwjVpfHYDcTThOBQZJLCltfchC+IRNVFr5vZEM=
X-Gm-Gg: AeBDiettRg0yIASRPhghEKJ19fyenNqVhEHof6a7KlQBvOAnO/uWVDHYJxXMguCQHBO
	IZUreWk5PQ8mzGmZZ4B7ESz8mnf2N3JAV/24CsF64vcPCeN5sNeH2b4BXfT/b1HR2CApmX0OhRI
	aBEbD9t8nwX9cpQBkT9c+TihkxzK8ItbY1kmQ89jgqo42WnMhyXggIjj2kcuIlpDuPAUplKnDPS
	o5QHeHt5tw89vUuvnQrwSMp20LdV1Mp1ZKNuhqAwoNbaGv1taU4dWARW+tpZwTuZ1snI+QuvHRk
	zqpMlggSeSFQg1DXdT1chl3cUpKR07lAOcXUNOch7ePvKkzILwZtCBw4+1R1EPfGY965uXmZBa9
	bPYmE/CllURWKJXjKFuU6Mh+ERyiVp2b67ichI9vb6lND+WPp/Y/em0NQETSJLtGVVKrujvRLQO
	RsQ3vn3fgF8LYf592+Pj35AXPwm4zUvQlh7UsnQIPxkTQPRNBHgXglz9W/mISaUpSLwvc4uw==
X-Received: by 2002:a05:620a:4003:b0:8d6:bd01:a67a with SMTP id af79cd13be357-8d6bd01b3f5mr99323085a.26.1775328812984;
        Sat, 04 Apr 2026 11:53:32 -0700 (PDT)
Received: from ziepe.ca (mctnnbsa70w-159-2-73-22.dhcp-dynamic.fibreop.nb.bellaliant.net. [159.2.73.22])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8d2a864b516sm733755685a.37.2026.04.04.11.53.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Apr 2026 11:53:31 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1w967e-0000000CyRZ-3Zuw;
	Sat, 04 Apr 2026 15:53:30 -0300
Date: Sat, 4 Apr 2026 15:53:30 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Dan Williams <dan.j.williams@intel.com>
Cc: mhonap@nvidia.com, alwilliamson@nvidia.com, jonathan.cameron@huawei.com,
	dave.jiang@intel.com, alejandro.lucero-palau@amd.com,
	dave@stgolabs.net, alison.schofield@intel.com,
	vishal.l.verma@intel.com, ira.weiny@intel.com, dmatlack@google.com,
	shuah@kernel.org, yishaih@nvidia.com, skolothumtho@nvidia.com,
	kevin.tian@intel.com, ankita@nvidia.com, vsethi@nvidia.com,
	cjia@nvidia.com, targupta@nvidia.com, zhiw@nvidia.com,
	kjaju@nvidia.com, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
	kvm@vger.kernel.org
Subject: Re: [PATCH v2 16/20] vfio/cxl: Register regions with VFIO layer
Message-ID: <20260404185330.GD2551565@ziepe.ca>
References: <20260401143917.108413-1-mhonap@nvidia.com>
 <20260401143917.108413-17-mhonap@nvidia.com>
 <69d0169115c06_1b0cc6100a5@dwillia2-mobl4.notmuch>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69d0169115c06_1b0cc6100a5@dwillia2-mobl4.notmuch>

On Fri, Apr 03, 2026 at 12:35:45PM -0700, Dan Williams wrote:
> > +	/*
> > +	 * CXL device memory is RAM, not MMIO.  Use memremap() rather than
> 
> Right, CXL.mem is RAM, not MMIO, so I question why is this not being
> mapped via a RAM mechanism? Can you explain a bit more about why reusing
> vfio MMIO mapping mechanisms is suitable here and what happens when we
> get to questions like guest_memfd integration, page conversions, and
> large page mapping support? 

None of that is applicable to VFIO. VFIO owns the entire address space
and does not share it with the mm or anything else.

> Maybe this is the start of the conversation for something simple, but I
> would actually prefer uncached ioremap() if only to avoid all the
> coherence management and suitability of MMIO mechanisms questions.

The entire thing needs to be mmapable in a cache coherent way since
that is what the HW semantic is. If you try to do something else you
will break KVM support since it follows the VMA.

Jason
