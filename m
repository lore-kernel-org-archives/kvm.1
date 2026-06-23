Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF2D3D5666
	for <kvm@vger.kernel.org>; Tue, 23 Jun 2026 12:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782218298; cv=none; b=dCqcIRSo9eu3lZMkKfYuQOqqEOc7qL0JHv+H9F0doCN+QhyBq005iKlOp9aDOiayqaQdMNgmmMlvOwoA7g1S/u0BCiGzO01WNaGQCf5lIjJavnmaoAyDmuC9e3IWA1kq5AFLL0Tr1ZjVRHvahwt6QsOaOYrMhPTordHRFMwkBQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782218298; c=relaxed/simple;
	bh=0r+J+xSFPVTDu03hM9HofRSVjf4b9CkdYvs63DmWm7s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DC3UxAQfxbkEjLNaXqHUu13o1bruwNx4VvtYgMJK26ZADSIae3cyAUTDCoGoAjW70jsCUbmShRGQTHfTIQH4q+7DiDKeWiD2Jp/Gqt5pUU3C9UQhA6tEdAiOpuyyqoiIz1vXCAAsinTe5UgAdb4aWGGdA1XNRckpdfY50l3eyD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Yg3sRbg4; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Yg3sRbg4"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2c6b7bd4e8dso46065ad.0
        for <kvm@vger.kernel.org>; Tue, 23 Jun 2026 05:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782218296; x=1782823096; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kRyC6uc9PiBbjK9ZqA0DFvnVffsSMfHhakITg77vSEE=;
        b=Yg3sRbg4JcgakwmVfurdoXfjSEBxkvQUvrGes5NXfUKDFWt+W+dLi61pcHGBIzlJ/f
         eKvld8j2snhn0VdxWAGJWsZJxkTde3rC9QvL4/P5Yrsic0c3LHmetJNsr3fjxsBi+0GH
         4bnUr/NIcg5FFT0fhdMdngy9o3gL4jozOs3FLKvNbfyOOh9NSwjkPKT++hwaFdvY9AKv
         JBSzZXvkPB2sSrkhBQjCq+fEPjLlubZh/B41aNOIpxnEZkjzWuazxkuU3AW5lZbpmQqv
         0wu5Q9OUGn6pMz9lINaWM9nBDbZ+S3OJBtPebRTgLzLLMkQ9vLRfEKlRqfAW8ISqwdTH
         VFkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782218296; x=1782823096;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kRyC6uc9PiBbjK9ZqA0DFvnVffsSMfHhakITg77vSEE=;
        b=Be//hnuwcfGzptVYMrlvGqynUGSEP9jjm1GKdv3C7mNYqvwxi4NM4zakfVk/+Ht6Mq
         ewGneQkBfQEk/SlpYtlMxTHY8ZESv+xomqdJAgxyFiD3hrTskwlRzRS5H5Uq61Z5kwVS
         j8fQSEBYNr/ccwQSOyJFuroz1CgcTallsmNS4HZRrTWQ0mftQl8K/WjbKoFdu00+0FNp
         oHosK/8QRPoz1HMBXGim8cI7CG5cuJ+aPS1pUi9YGeyt7ieZ7orjHD4j9Ku/kfwfzUj3
         GsPofsbl6Bkp3u8RAlhyshcx48QXLAQ3pej9/wd22r/7p46L/OHU8h3Zsu35D2I/ItrB
         WNKg==
X-Forwarded-Encrypted: i=1; AHgh+RrjU1rp0ijCbiapXCCv9MtNnghNPEGZpYtCHGcod3L9UYTUmbePOR8vKu8rZnAVOlx3Yro=@vger.kernel.org
X-Gm-Message-State: AOJu0YwktAeSXbHRtWDA/5+xuvlOFpr3T7ov0t4Q253fwVXrWqNHMihe
	Swv2zFEadC1yEDizVNXnkh7NbdY4nteYinO5ncpXffE1xcog5ZkbAIEi2ufImi64Lw==
X-Gm-Gg: AfdE7clopy4vsi6ADx2hlzfm8iB6TZfe3EjIoyl1CSor52MfIE+20Sx/Rm7QH7tIN6K
	V+/tFVxR9WYPkAXDflQ2eLQ2IDXO102yuJR0F8lDYYsMqOIw08EJ+hl/DLIqz0wDot2L3Wp2vPp
	fZMSS53yt8AOm5LpBhQQOAVF5eNkkHVVKcRVucEaiFw/NiCXcKo5WpupoR4/GxiiTm6gJMF0NMw
	vqV7f/BwxuexfxlxIeFLSbPhjDuBroAYkAcBu81fUd5IhbcHX9pOrvL3o56fIwTATGobeGwGGyW
	+rR/dgTN1kBBX10rqMdBWu9ZIfEa2AIHYQAKbWPJg2aXDxnkA347uxsxNuL3UJa010oSCY5yLrW
	OdPA4uoIx7/Rh7zI52LyCnkcimtYWjcatgvZlo+nRKNsFJt3dG4jzF0NW9oaov3nrSogme4OXKQ
	Tp5GOTCJkQIrzCREM1Wm2hgdoCvZcZ7du/wjRX1D9xPgPcZOjxrWeHiDCoA6S2
X-Received: by 2002:a17:902:e5c2:b0:2c1:4a67:5f31 with SMTP id d9443c01a7336-2c7c70efd4emr1597435ad.9.1782218295641;
        Tue, 23 Jun 2026 05:38:15 -0700 (PDT)
Received: from google.com (199.255.142.34.bc.googleusercontent.com. [34.142.255.199])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84564d6c2cesm13106102b3a.2.2026.06.23.05.38.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 05:38:15 -0700 (PDT)
Date: Tue, 23 Jun 2026 12:38:07 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Matt Evans <matt@ozlabs.org>
Cc: Alex Williamson <alex@shazbot.org>, Leon Romanovsky <leon@kernel.org>,
	Jason Gunthorpe <jgg@nvidia.com>, Alex Mastro <amastro@fb.com>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Mahmoud Adam <mngyadam@amazon.de>,
	David Matlack <dmatlack@google.com>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Kevin Tian <kevin.tian@intel.com>,
	Ankit Agrawal <ankita@nvidia.com>,
	Alistair Popple <apopple@nvidia.com>,
	Vivek Kasireddy <vivek.kasireddy@intel.com>,
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
	kvm@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v3 6/9] vfio/pci: Clean up BAR zap and revocation
Message-ID: <ajp-L7wHQ2rQFK97@google.com>
References: <20260610154327.37758-1-matt@ozlabs.org>
 <20260610154327.37758-7-matt@ozlabs.org>
 <aixgZQiBQKgS7yIM@google.com>
 <62970f4b-e624-403f-9cdc-02438c820d23@ozlabs.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62970f4b-e624-403f-9cdc-02438c820d23@ozlabs.org>

On Thu, Jun 18, 2026 at 05:06:27PM +0100, Matt Evans wrote:
> Hi Praan,
> 
> On 12/06/2026 20:39, Pranjal Shrivastava wrote:
> >>

[...]

> >> diff --git a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
> >> index 86362ec424a5..51990f6d66d5 100644
> >> --- a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
> >> +++ b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
> >> @@ -1692,6 +1692,14 @@ static int hisi_acc_vfio_pci_probe(struct pci_dev *pdev, const struct pci_device
> >>  	if (ret)
> >>  		goto out_put_vdev;
> >>  
> >> +	/*
> >> +	 * hisi_acc_vfio_pci_mmap() calls down to
> >> +	 * vfio_pci_core_mmap(), so BAR mappings are still
> >> +	 * DMABUF-backed.  They don't require a zap on revoke, so opt
> >> +	 * out:
> >> +	 */
> >> +	hisi_acc_vdev->core_device.zap_bars_on_revoke = false;
> >> +
> > 
> > This seems to be happening after we vfio_pci_core_register_device, which
> > could be slightly problematic if another device in the same group races 
> > to trigger a hot reset before we can set this to false. Could we 
> > initialize this flag before registration instead?
> 
> Remember it is a safe default, so in the event of a driver not managing
> to opt-out before it's required then all that happens is a redundant
> unmap_mapping_range().  The default-safe was a nice suggestion from Alex
> on v2.
> 

Ack. I see. That makes sense.

Thanks,
Praan

