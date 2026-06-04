Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 093B8336896
	for <kvm@vger.kernel.org>; Thu,  4 Jun 2026 18:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780597235; cv=none; b=FrXcCU/uIdDsRowQ3GaXOCGb0+JGjDZnd/cFypTNZxOjmxKmsNTh5p3LHTTH1Ve7+gVGtvg2FsxWqQ1zoSyt7lcRtteA3NLjKFEHHAIFQbpDPHhdrnCHvgkFAQDJzChT60I84rmy2YPjpx6+HI9CPgissDwCA1uuXuEWEtRTW5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780597235; c=relaxed/simple;
	bh=ouL5XvfeSLQ6GEaEsqJR0/FGgzHrau6qGhqQ/UmaVCg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hM2mrdLcw9SspWoTZuUPuM72utRbExIo0kSlwHZZVl/AhpyfO84AdYosDAs346FnVEH4IuDlkMA2qB5iIwu5XUKv9e+wOL0JHKcRfyBL8QFeBY+8LbOARkF2A361/LdF+bkLILKlKzhsEHyxtadQFxe0dxPXQ4WiyPrK3/JRtdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=bZJM9Ddc; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="bZJM9Ddc"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-91587626ae1so118827585a.3
        for <kvm@vger.kernel.org>; Thu, 04 Jun 2026 11:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1780597233; x=1781202033; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cznawapF5vO4PWrDdsZF/fc6qNY58JTcnmMkw1TddjY=;
        b=bZJM9Ddc41JZholXg+7Xw13JitkdVXhfvJNIwp+n21XOpUUmaTsj56rV12lxw1bACa
         bymQmIsGk+gklIpxidxBCI7znUxxwGpMRQbMhTQnhzVUhy4a4DhwG+9fldnC/DIENL2x
         uyHazBvUC8NYMS4CL7jeZldX2326HMV292vG7eDsYZptXRoYUa+0cmvE/Zr4vZPGRTo/
         OO4mmsXFif3eGzAvDgoJoHZ6LUculXktoVTDGLHRvotMoqXWb7e4yXv+3b5vw0dQuq1t
         eUbZCTx69hQK5MlkjNHbS+EdHvo8JeBKWNLiTKQHTUmN+hh5PJQSAremU83+Aky1zY+1
         70QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780597233; x=1781202033;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cznawapF5vO4PWrDdsZF/fc6qNY58JTcnmMkw1TddjY=;
        b=AbUoGBl/PKzacCzQ0Va2BBaoVEUExscyZPuEsdmqQT2SvOtTRM7drtR5xOFFZeHFal
         n4oCJTz5SAiq6wKthHYQqpnVOwVTP3FpnibH20JQEejy7+c077jipoVixuq1ncXLsgjv
         VusVCGkxtzgwmZZUoo/or6wGoW0rUxsQyoXZOXjj/DKjLLM9PgXOr5tCB4/O8OHqNoH/
         9ZtpYcI26OD29s1/sFYmXrluZOMzD7Ivr/Rc8W/bNkK0OpygNfdDf8RFEHKFgDGj/xu0
         PxarPQ7GEfiYaMykDhY18QeyTpzxIgU7GFbiwlWbNImmfVeGvge6ycXUQdaZI77t7txH
         KFxQ==
X-Forwarded-Encrypted: i=1; AFNElJ8g9qYEpOTqyLie9IRxReyAjuhrk8Oum3Y82luJt41GaXgeDrOld0yDrkW0TqO3ylxSUSE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsoKB76Fyn3dKQTq+R4GujxZDs4R1mw0GBs4kLZ2fmkqMtPQos
	BiZiQW3Erkv5B7Xdi4yBCT9tzJh/TgU53WhBASlQ8bCD8nTcoU4WGcZXxK0enEPwdxc=
X-Gm-Gg: Acq92OGAM+UasfbGBhiW0ka6FO455UM9FSGJph4s9LJqcnj+eCnptNpzHn9T2aIWqYR
	7sbZjcN9XU04sWoMl5TggqIAUKxEUxatJ1WL3kCUZlhwJDI76Wu0FTF6+yIDKFj9dqZk+S1s71E
	Xgp54BTbEQT0ASCdiDS3rmdtuQKZDIHza9ynqGN4J31PqFAcp2q7yAIW6PFcPEFf23m/FL9vG3W
	OO0ZDFq+YIpI/VrPIMxvx5gZownkv8JmmAtjB+GBQHwj5hva+2nnfV5kwrLE8SnFM07BH4pim2s
	OlSfQFBSw9cF2d8D7EbiiB2jFZ7jgKWJd1h9Bnokq3Fw2K7BRPcdtctIafoTEdJ1KDaeD9LSUEC
	m5mL1KyoHMYtfQhjUwT2StDuW1m/gq5oKyfRS/likKoLbv3ZgPRc+3Z6rVwVw7JlTVZiAi4g+wC
	c7PSbxl8+dpaV+SsdI8mAfH1JYBXOVY7itXMeoWwOfiSHDRxfuYuW3Y0cPeH0svr/W9KAuiCIPW
	uuerDoyAljeLXPr
X-Received: by 2002:a05:620a:a414:20b0:914:afc1:c66d with SMTP id af79cd13be357-915a9c75c96mr40356185a.11.1780597232897;
        Thu, 04 Jun 2026 11:20:32 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cecd051d61sm58430626d6.29.2026.06.04.11.20.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 11:20:32 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wVCgB-00000008erz-2jW4;
	Thu, 04 Jun 2026 15:20:31 -0300
Date: Thu, 4 Jun 2026 15:20:31 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Alex Williamson <alex@shazbot.org>,
	Kevin Tian <kevin.tian@intel.com>,
	Ankit Agrawal <ankita@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	Keith Busch <kbusch@kernel.org>,
	Alexander Duyck <alexanderduyck@fb.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Dimitri Daskalakis <daskald@meta.com>,
	linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
	kvm@vger.kernel.org, xen-devel@lists.xenproject.org
Subject: Re: [RFC 00/12] PCI: Add support for Scalable I/O Virtualization
Message-ID: <20260604182031.GB2487554@ziepe.ca>
References: <20260604150153.3619662-1-dimitri.daskalakis1@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260604150153.3619662-1-dimitri.daskalakis1@gmail.com>

On Thu, Jun 04, 2026 at 08:01:41AM -0700, Dimitri Daskalakis wrote:
> With this patchset core enumarates the SIOV capability and can identify
> SIOV PFs. But there is no central mechanism to allocate/manage SIOV VFs.
> To support device pass through, devices will need to add a vfio-mdev
> driver with IOMMUFD support (or something similar).

There is an enormous amount of missing work to do something useful
with the SIOVr2 stuff. IIRC there is even supposed to be BIOS
components in this plan and there are some missing PCI SIG topics too
IIRC.

So, I'm not sure how much value there is in merging just the cap
discovery without a roadmap for the missing parts..

Also, I'm quite surprised to see this out of the blue, there is an OCP
workstream that was building out a standard that outlines how all the
different components have to act to successfully implement it.  What
is in PCI SIG was just some minor foundational adjustments without any
context on how to form them into a solution.

I think it is extremely premature to merge anything related to SIOV to
the kernel. Join the OCP work stream if you are interested. I think
the general feeling was there is not sufficient interest in the
industry to do this and it has gone quiet.

Jason
