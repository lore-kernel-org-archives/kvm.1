Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2644377A83
	for <kvm@vger.kernel.org>; Wed, 16 Sep 2026 12:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789562933; cv=none; b=q2zKVCVFNN5rBswXE+FGl11LovVXKby33/Wd1RxgOJfNDPgv/3auXcptY90L1739F265RWeQSw6D02ARrjnvGmo/Hpee3KP3sbjQgcfvxl5FQrEwTgBlDxBbaopoUca1OS31IdIjhLpb5Nrp0hpRg0Cd4krUuSs3uepwuqzpEtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789562933; c=relaxed/simple;
	bh=H34k7SsIUJ0nZ0sEaZhQtlZ3Kbira6446GXQ2UQYvlA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nH4JumJTchjdTE3euHzILLMzWU7iSJXtqndHbPIgYH4ILJVFzFxXkhQoQ0Lxy8yelMBinzE8czzoKPBNtDEZzGmzGSA81c0so/lMsDBgzrNQtNlCwEIFoJYHLxpfOZ6FxUvYg0G1F+EUETht4dLhp7me8wXDs2grAsCQB35cRTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=UYHFLxHT; arc=none smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="UYHFLxHT"
Received: by mail-qk2-f12.google.com with SMTP id af79cd13be357-939922847efso81161185a.0
        for <kvm@vger.kernel.org>; Wed, 16 Sep 2026 05:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1789562930; x=1790167730; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VzaI7ZYbqdoJC4coFReri2t1Bm12kg0MhPi/KYFxqXI=;
        b=UYHFLxHT4tZADRfpps3/kPdRToXmVpOT+yeTerpUx+frrD5S1Vd4xEsnYf2fUNAK+z
         TJej/1g0956DfFk8A0HCE8pk2I0yXGuoBCJ9rRkqvWqECXzOo7Ri4Bz6/DwyL2x1Xwvm
         Vf+HBexeoo3hCuE6HFiL+Im6mQzWPwXv+sOfdbz9EuSW/X1axwSKIvWY6kXcXIapema8
         h1FCrw0ML5RMzigsKcZudElSnwPJbz1HGkEc7IZDAd7dM+4IrbtOAKmrpK97wL7MvWk/
         jP7q1oc7Y9ERG7ZCDWYjtFOHpjuqt1gjg4E/R19mC2Cn8648kFnLgcZdFSxH9qLNXzPw
         0Dgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789562930; x=1790167730;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VzaI7ZYbqdoJC4coFReri2t1Bm12kg0MhPi/KYFxqXI=;
        b=RpXQubOf3Ddc1ryakuxBe7yDqZ5hhCt2BC7uR0qDy1jdh+KRoDkuqujCmWkLk7TPka
         JFSkn+S3A7xQYUNiYUnaKqs4cPD4pRSgwEsSKcU0FENRMbF6CUhg8CoLhq3erDC+TWdq
         94fVbIWv1ZIW7Zx4lXkcP0z/zT/DkmfVIJaPQLUmN26rFQP3OtelpjVA1YGiLNyZBwsC
         tfP82QK8X0ueenWDlZ/H+OGn2hrJt6Zxi48dmP4Xv4VT1MBmqppHKCErxtCP+wzN20Lq
         gg9e6sqkRIFFT/tohFcA+o17XjmwB8JCr+xuZkvXB+W+vWrPrFDv8dMqfAa65G/nhj/J
         9oUA==
X-Forwarded-Encrypted: i=1; AKwUvBxmMwsvXX4ax1tu55cgZZoFfPh1QVM5muqbEr8qz1Lo/4Vgj2kQLvOt9gv6df04SspMxbQ=@vger.kernel.org
X-Gm-Message-State: AFuF++mTxUrdLUAPk2OGS8XGbkydxZVvSdxZD1RESwE+FVpg7tivaVHa
	5NsPW58x0SXDMOGyTnTndeOLpl1hSA1ZqbleTkWxD+YD7AiToRz7jvw+202cICvALXI=
X-Gm-Gg: AYBFou3Se+GMsHBV9JWvDF7D9SP7Tx23B0k7g4NyD4iuAmxHsH6xUTDDNmZbjQSXVl2
	A0WOvrWJIrNz9AOStDDpGSWen0+dp4gnWsDYkcDYx9cb23mBDWkqErhafHB1CgvDAJuYceJF/Nz
	0abhaBr0gvurXBCuB0DBUS7DmiQ5WAKIVjKbpc38/Nx3HODuiNVvNIP7Zii9svT7oTC+Naenmg3
	ljeAKaBMDJJ5LlNua6EEdvLewxbz7gH52gClvhelzHo2DcCsD4wDceTELjGy24d3irCdxeI+f3I
	pAcQ3tdSHRYCRKpIoCL9kRajgXST+ofI4DgeEjGLbF2Gcj5dH+On9EZHhMM0PXOI7ToEbkUktCn
	4MRbwiOSlBF8+pBOFRYPyEtvgeYuYgKhYFTpoGWbobuG7+jflscLEDrxv4WE0PpHmmRIBoKOp8w
	UMX4WLhrwpm+5SAOao1qDS+m9aMmx0Z//vE7LjX3ofTATo5+GZufWx6dmx1HxnRc/ZQd9hGECyr
	UbALNbcHE6u+4PdNtjcz4HejXXcWMwS6t7XtjQAoPQa+O8ZSjRjdCTCeA==
X-Received: by 2002:a05:620a:d8e:b0:939:6de9:4cff with SMTP id af79cd13be357-93bb7907fecmr386232885a.45.1789562930363;
        Wed, 16 Sep 2026 05:48:50 -0700 (PDT)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93b7821dcfesm208481285a.18.2026.09.16.05.48.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 05:48:49 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1x6p4D-000000099Zm-0Jbp;
	Wed, 16 Sep 2026 09:48:49 -0300
Date: Wed, 16 Sep 2026 09:48:49 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Alexey Kardashevskiy <aik@amd.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	linux-crypto@vger.kernel.org, linux-pci@vger.kernel.org,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ashish Kalra <ashish.kalra@amd.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jini Susan George <jinisusan.george@amd.com>,
	Kees Cook <kees@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>,
	Nikunj A Dadhania <nikunj@amd.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Eric Biggers <ebiggers@kernel.org>,
	Kim Phillips <kim.phillips@amd.com>, Joerg Roedel <jroedel@suse.de>,
	Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	"Tycho Andersen (AMD)" <tycho@kernel.org>,
	Liam Merwick <liam.merwick@oracle.com>,
	Michael Kerrisk <mtk.manpages@gmail.com>,
	Suresh Siddha <suresh.b.siddha@intel.com>,
	Xiaotian Feng <dfeng@redhat.com>,
	Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>,
	Andi Kleen <ak@linux.intel.com>, Kiryl Shutsemau <kas@kernel.org>,
	Tony Luck <tony.luck@intel.com>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	Carlos =?utf-8?B?TMOzcGV6?= <clopez@suse.de>,
	Jonathan Cameron <jic23@kernel.org>,
	Jori Koolstra <jkoolstra@xs4all.nl>,
	Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	"Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	Ian Campbell <ian.campbell@citrix.com>,
	Jeremy Fitzhardinge <jeremy.fitzhardinge@citrix.com>,
	Petr Tesarik <ptesarik@suse.com>,
	David Howells <dhowells@redhat.com>,
	Haavard Skinnemoen <hskinnemoen@atmel.com>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Michael Kelley <mhklinux@outlook.com>,
	Ilias Stamatis <ilstam@amazon.com>,
	Sumanth Korikkar <sumanthk@linux.ibm.com>,
	Simona Vetter <simona.vetter@ffwll.ch>,
	Toshi Kani <toshi.kani@hp.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Vinod Koul <vkoul@kernel.org>,
	Jiang Liu <jiang.liu@linux.intel.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Palmer Dabbelt <palmerdabbelt@google.com>,
	linux-coco@lists.linux.dev, xen-devel@lists.xenproject.org,
	iommu@lists.linux.dev, linux-mm@kvack.org, aik@ozlabs.ru,
	Santosh Shukla <santosh.shukla@amd.com>,
	"Pratik R . Sampat" <prsampat@amd.com>,
	Scott Soule Cheloha <scott.cheloha@amd.com>,
	Ackerley Tng <ackerleytng@google.com>,
	Fuad Tabba <tabba@google.com>
Subject: Re: [RFC PATCH kernel 10/17] x86, dma: Allow accepted devices to map
 private memory
Message-ID: <20260916124849.GD3196566@ziepe.ca>
References: <20260916115159.1938195-1-aik@amd.com>
 <20260916115159.1938195-11-aik@amd.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260916115159.1938195-11-aik@amd.com>

On Wed, Sep 16, 2026 at 09:51:50PM +1000, Alexey Kardashevskiy wrote:
>  bool force_dma_unencrypted(struct device *dev)
>  {
>  	/*
> -	 * For SEV, all DMA must be to unencrypted addresses.
> +	 * Require unencrypted DMA unless the device has been "accepted",
> +	 * enabled by a TSM driver to DMA to private encrypted memory.
>  	 */
>  	if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT))
> -		return true;
> +		return !__device_cc_accepted(dev);

I want this out of arch code, after Aneesh's recent rework Nicolin is trying
this approach:

https://lore.kernel.org/all/abddd433493324a6bfdf8ba9710e96d90f0d1ccc.1789010941.git.nicolinc@nvidia.com/

Jason
