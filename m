Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D1D23D2B1
	for <kvm@vger.kernel.org>; Thu,  4 Jun 2026 23:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780616958; cv=none; b=uXrzEqd2vzrA9e/lbmMuiS/dwwqWYU6PrrSRRiaEX2EF8SYSkjgShWbkqnSmhv/5675OwbXvKdjeMHI0dKCbwJQfjIaAw0pJGtpWSKPAt13HKcSpoQFMMWrvzasepJmY5Dcih7hEEt6xss2sUFhfkIyf4uOyLXnEICvawOx6zO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780616958; c=relaxed/simple;
	bh=oJt2fFfQbIMLj8oKYfu7svnYMm4cuFXCaciuIc/eOAY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lznE7g33ed39a9+cR3DdzMvPHUHw4W2ABWwiSGxBG3ObsbfvpLudR3qrodlNQZPy+bwcYngLG4QiMehNwXuglbkUJpYr2mVhoMvUBVGTREJpRJfG28wvM+QCJpHJIqjCVn2EBAcGTZ9M8bQZ4UbM6YRcw1tYQLC84eFgdlPYm1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sHQYVQM8; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sHQYVQM8"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-7dca5a81be2so12753697b3.2
        for <kvm@vger.kernel.org>; Thu, 04 Jun 2026 16:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780616956; x=1781221756; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FnTnrGN1rDoPr2XWYDmMjIU6l0/cMGNmMp999cHq+3Y=;
        b=sHQYVQM8rcz8KhCQL24gtXa2eymMfA3tX+eHwmyfuefT/a3jbaBE6rK7qs/+9AT7Es
         8/2vdM/nH2WyPuez7CBTVeJ1j/jQDErhdqEzVA0CNNUeJ+eEfdD5krdV7+/ldYmk9b2u
         AtRopFOcphlnfzA7JQmlha7sWpzs62pNvyYqhY0FKzcTbC/CJ8aFtN1BIf/j0+0jtclV
         Qsb8sTMJvo3qjxqmLwQ88VTbylsbpUBvHoPqnM2sRHgE5wAf/JtlxVcJpBEk7dT4nLEa
         oA/Xd4zRKQECiHV0alLAQc1zsEaeZt4kFB7NR9ebw8rJacDHhzXGtSQPFSwzz4CUWjkx
         LX6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780616956; x=1781221756;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FnTnrGN1rDoPr2XWYDmMjIU6l0/cMGNmMp999cHq+3Y=;
        b=WbaA5kAFGEs8JEI/2NQ+KfKM29ngSYI8y1kDL7vzK1fMtQl4ilEANsTbQLtRhIDYNM
         3WhICR6tPSkOnrAbovnxfmLxvl4ygYr7GkhISi3YGNp86DjO1VJXD4FXo/Twto08P5LN
         UtzFQ/xAqK/g2lmB+pOtfpHjGJn7x9n+xW4RZ2vARyefkqxbGyxQaVOVUGyJXEJf52yy
         VJToJ684WkV273q7N/XW/lb0nZ6tkRCazH3G8yOZVADDBBNXJYlIlpetKbPL4lsgU0Ng
         k9f1gfBWtN+KCHJ0ny/kVMoS9yPQpxCsAu93pB2YjTcw14+UrYw6rPz9So2L9IGeXiQs
         sSZQ==
X-Forwarded-Encrypted: i=1; AFNElJ+vHOxD7WDChm3lpuwerSr/7t3v+YwK+bvroRwW8iYtroQJaBkc+ckqJF16koKoV1CMh6A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1ySxWNLsxx08LEeReFFRuxF+zSpGon3t3CSlo37J1tlUs2d3H
	uYKtPLA0ec1J3P2SIrPF1A1RAwfAs3gUaeWf48hSkVHYES9VBAJk46Ll
X-Gm-Gg: Acq92OEEnQkmvOepdsdCGWcW8swBzUVqxwq4yya3yad+dNhDuPWFSPmQS30IEIa75rz
	Niqh8TCFCLMeUYpQlr8P/ICRqEZ/wdMItukcZ3mvuotqO4nH0uiF1NC6GS+vs6cV/ZfdIKjv0Xt
	bLe7jDbEdJfWLhJ6GSEb+pQDhYCI8t0a1hFUhNqnuAi0/gPmeWJ48SC3J2HzGQ4fjMIcSrDvouI
	0t1fPWyJ4Qjr00BBjLYTA9adkuiEl27P1vKwBTJ/M6FjQ/MeNMrnd35S1lWg4KNd+BEj2nga+v2
	Qmdcd8RSCB6nn/QQXN6WJBVXf2Y3bUzX+aLUhbf3h4FPJ0tjaD1JA2N7gxdUZ87ZLFvE+DX+tpR
	me1lPn2JgnXnqqzBlDLRUsvUIZEzibmsY1JKsOAIp3R4ttM1V0jXLRtlq4hoM97BMLIwyfuNQii
	M+fNGr8p4YhWUWKymqjzUuUOIyLpeK9yEQvhLC5CUUzjZAvYlrfsNon2DS8uiB7gCnAHwYTwCbk
	Aw+rFgehhRBJP/FcyrJzhqpa7BrHbGvgtCVUIW3hkgt
X-Received: by 2002:a05:690c:c4e6:b0:7ec:5c2c:1d27 with SMTP id 00721157ae682-7ed0afadc30mr12160017b3.15.1780616956146;
        Thu, 04 Jun 2026 16:49:16 -0700 (PDT)
Received: from [192.168.4.45] (76-224-22-216.lightspeed.sntcca.sbcglobal.net. [76.224.22.216])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7ea23492a24sm42082017b3.27.2026.06.04.16.49.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jun 2026 16:49:15 -0700 (PDT)
Message-ID: <a07763e2-aff3-4468-83c2-d50a9e1605c8@gmail.com>
Date: Thu, 4 Jun 2026 16:49:05 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 00/12] PCI: Add support for Scalable I/O Virtualization
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <chleroy@kernel.org>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Oliver O'Halloran <oohall@gmail.com>,
 Niklas Schnelle <schnelle@linux.ibm.com>,
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, Alex Williamson <alex@shazbot.org>,
 Kevin Tian <kevin.tian@intel.com>, Ankit Agrawal <ankita@nvidia.com>,
 Leon Romanovsky <leon@kernel.org>, Juergen Gross <jgross@suse.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 Keith Busch <kbusch@kernel.org>, Alexander Duyck <alexanderduyck@fb.com>,
 Jakub Kicinski <kuba@kernel.org>, Dimitri Daskalakis <daskald@meta.com>,
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
 kvm@vger.kernel.org, xen-devel@lists.xenproject.org
References: <20260604150153.3619662-1-dimitri.daskalakis1@gmail.com>
 <20260604182031.GB2487554@ziepe.ca>
Content-Language: en-US
From: Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>
In-Reply-To: <20260604182031.GB2487554@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 6/4/26 11:20 AM, Jason Gunthorpe wrote:
> On Thu, Jun 04, 2026 at 08:01:41AM -0700, Dimitri Daskalakis wrote:
>> With this patchset core enumarates the SIOV capability and can identify
>> SIOV PFs. But there is no central mechanism to allocate/manage SIOV VFs.
>> To support device pass through, devices will need to add a vfio-mdev
>> driver with IOMMUFD support (or something similar).
> 
> There is an enormous amount of missing work to do something useful
> with the SIOVr2 stuff. IIRC there is even supposed to be BIOS
> components in this plan and there are some missing PCI SIG topics too
> IIRC.
> 
> So, I'm not sure how much value there is in merging just the cap
> discovery without a roadmap for the missing parts..
> 
> Also, I'm quite surprised to see this out of the blue, there is an OCP
> workstream that was building out a standard that outlines how all the
> different components have to act to successfully implement it.  What
> is in PCI SIG was just some minor foundational adjustments without any
> context on how to form them into a solution.
> 
> I think it is extremely premature to merge anything related to SIOV to
> the kernel. Join the OCP work stream if you are interested. I think
> the general feeling was there is not sufficient interest in the
> industry to do this and it has gone quiet.
> 
> Jason

Hey Jason, thanks for the feedback. We (at Meta) are definitely
interested in SIOV-like capabilities for device passthrough to containers.

For those scenarios, having PCIe transactions per RID plus IOMMU
isolation is enough, but I can imagine hypervisors/VMs requiring more
platform support.

I hear you on the broader support story being premature. But on the
other hand, this series unblocks experimentation at the driver level
for basic data path validation.
