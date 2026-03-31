Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D488332ED39
	for <kvm@vger.kernel.org>; Tue, 31 Mar 2026 17:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774979041; cv=none; b=MlXjVlSdzysOHm62AIsx2Q0JoDF42yz/CClXpLrp/m5IBnsV4jiMuInlmDS1Lu7c9tU/W2qQHm8Jj3uuESxE+2KoYXLreymmOF2pgawSWxAImT7NFbvEF/sK2mcIyq6P8U/3ylSxhtMiw2pkG9AB6SX5ovFFzQLaM/bb7pDQfAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774979041; c=relaxed/simple;
	bh=O/84EN5YYoPM1+5xtE3R1wBAPsRMRFS9tH2mD4pprKE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f0h0llSFTYzeSLyA4a+eSW/IwYcFkY3U56u1EWoSBd+OkoLAZ97EnqHDmdPll2/OTmvXVT7Jg2hAT/estXF9bNzCZG42Gti4GKNFRo4JjHQD17PkB70H8k0qsfcE3cSpKXvwyY2FD8SmdxMtGF0jk0Oe8ljGmVE226DG7nTbgJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IIwuR2om; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IIwuR2om"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-35d9f68d011so2043208a91.2
        for <kvm@vger.kernel.org>; Tue, 31 Mar 2026 10:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1774979039; x=1775583839; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DfoeEFvtZcN/vD2OkIhN1RR2rBv2unDxcoeXhDGEM9o=;
        b=IIwuR2ombtOhx456yiMGpr7omxR8Nx/09sWeniI2pSPI4oZf+sRcuv3IZY9OZdcw9v
         /3HgTZnX49U2VlfBbqwUZvWhsBvgfZdhaAtZcoin2ea2cLSuMHzVXWD8UGuRGLfHDTyU
         tpqCujQ1eTtTI5kQbLFYb9tbhYJ7rRczoV0nnyg3QTr3sDfLqyWAv/Iz1nNLpPR0hD2C
         BJuYHQmyCxGFMq65FVrEUy8gAHpAf0C6JfB5gtwOMV8yxmV3BU2NV9FHXIe7mAI3/jaE
         XtTRCz7ZdggfM389Vu2Y/Eg0NZjRYMgjMsDFFP8oItofmK5m0bb4UnPKA/Kz7EjMyBw4
         Dh3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774979039; x=1775583839;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DfoeEFvtZcN/vD2OkIhN1RR2rBv2unDxcoeXhDGEM9o=;
        b=nPjmXzt+mjihDFipJ0Zj09Nf1SICHDuILqLrKLgIWajfDcdzEmTg1fH/z6MKBCgcpb
         mgsLaNPeL8BlZevvai2YB16KLAYs0gdwSWxAxdKA/kwlggEbpXqj+JpZad/Ph0V6prTI
         Xc/afsmWDUUQGXMn3PK2JGsxXkXC2XYKlW3QucYCRe1BiUfpNAnExZElnNNpDnOPjmMy
         7iuVnCCtYj4j5A2KKqAexgTO5j62gXcNR0xYX88p4OrmL05aQ5ApWZ9GfyaRWQxXVv6F
         C4iIWeMd2v7Pp7m/daNKHS9U/YOO0++zWk6KhKUjSNzIXhtkMqgp+Hxmfj/RMNNNm0Zf
         T2Iw==
X-Forwarded-Encrypted: i=1; AJvYcCV0nBdwyi4oas/f1H0YvsQFCa409Qxeqhcey9ccvFYif2qMGvAGhvm/OQ3Xg6ZC9HxCfIc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8gkFsXpN/olDlTYA2y5I+Jed6Z+KOvRIFxW8J/R7FvvWSddF0
	pW+D3eYaTBzZc1ZXkpQYsosJadI9lo34saWKnJ8nulBa/SdfefqbNN57T8Kl8u1Jt6w=
X-Gm-Gg: ATEYQzwzJaM41P5GlFfjTHSimqnEE35JHi+16+MH8ZwIFzugwRkpR+wirJbDMWuhaBp
	W91KLHV8UC4Kez6LUmhveftWi3trL14/akDLd5sCmEP+PCgyX6Gv1o4DUiwtzkXBWhgdvpTFkai
	XBEc6veBHtNwQEMXTayL+/Ckx4XLhVGSuMMkRD+nlCLblhKSODja3j75OL3hKqyfjtA1vaE4FGV
	HNX+xiW/d1i0QcdhNg3Jmn6q0r4j4JJaaZTVRPunTPPoJvR1EDZJZxlvnQXYXG+ssIdOGlY8nAo
	g+LcafgzjVaASSOvn7T9YISxq9U2niRugcYmRv5rKZRpdKYpcGYwdAe6Sd7zQilBUksXbUuhkq1
	oTU34Y3zvQEHCfZ3g2398/s63m2BJTseTtcKj23DOq2PiA6mWVMNtkfqWLaDme59n3ppJDK6mRS
	B6w63d6YB5G075zKXfVcfurRaytQ==
X-Received: by 2002:a17:90b:3f8b:b0:35d:a2d3:5c2f with SMTP id 98e67ed59e1d1-35dc701f81amr175346a91.24.1774979039033;
        Tue, 31 Mar 2026 10:43:59 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:3147:ec27:349:39db])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35dbe9377b7sm3173953a91.10.2026.03.31.10.43.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 10:43:58 -0700 (PDT)
Date: Tue, 31 Mar 2026 11:43:55 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Steven Price <steven.price@arm.com>, kvm@vger.kernel.org,
	kvmarm@lists.linux.dev, Catalin Marinas <catalin.marinas@arm.com>,
	Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
	James Morse <james.morse@arm.com>,
	Oliver Upton <oliver.upton@linux.dev>,
	Zenghui Yu <yuzenghui@huawei.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Joey Gouly <joey.gouly@arm.com>,
	Alexandru Elisei <alexandru.elisei@arm.com>,
	Christoffer Dall <christoffer.dall@arm.com>,
	Fuad Tabba <tabba@google.com>, linux-coco@lists.linux.dev,
	Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>,
	Gavin Shan <gshan@redhat.com>,
	Shanker Donthineni <sdonthineni@nvidia.com>,
	Alper Gun <alpergun@google.com>,
	"Aneesh Kumar K . V" <aneesh.kumar@kernel.org>,
	Emi Kisanuki <fj0570is@fujitsu.com>,
	Vishal Annapurve <vannapurve@google.com>
Subject: Re: [PATCH v13 10/48] arm64: RMI: Ensure that the RMM has GPT
 entries for memory
Message-ID: <acwH2_2b7bdOSsOd@p14s>
References: <20260318155413.793430-1-steven.price@arm.com>
 <20260318155413.793430-11-steven.price@arm.com>
 <acrj-cKphy4hJsEG@p14s>
 <152f5070-fda6-4381-bc40-4a70908c27c1@arm.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <152f5070-fda6-4381-bc40-4a70908c27c1@arm.com>

On Tue, Mar 31, 2026 at 12:05:47PM +0100, Suzuki K Poulose wrote:
> Hi Mathieu,
> 
> On 30/03/2026 21:58, Mathieu Poirier wrote:
> > Hi,
> > 
> > On Wed, Mar 18, 2026 at 03:53:34PM +0000, Steven Price wrote:
> > > The RMM may not be tracking all the memory of the system at boot. Create
> > > the necessary tracking state and GPTs within the RMM so that all boot
> > > memory can be delegated to the RMM as needed during runtime.
> > > 
> > > Note: support is currently missing for SROs which means that if the RMM
> > > needs memory donating this will fail (and render CCA unusable in Linux).
> > > 
> > > Signed-off-by: Steven Price <steven.price@arm.com>
> > > ---
> > > New patch for v13
> > > ---
> > >   arch/arm64/kvm/rmi.c | 89 ++++++++++++++++++++++++++++++++++++++++++++
> > >   1 file changed, 89 insertions(+)
> > > 
> > > diff --git a/arch/arm64/kvm/rmi.c b/arch/arm64/kvm/rmi.c
> > > index 9590dff9a2c1..80aedc85e94a 100644
> > > --- a/arch/arm64/kvm/rmi.c
> > > +++ b/arch/arm64/kvm/rmi.c
> > > @@ -4,6 +4,7 @@
> > >    */
> > >   #include <linux/kvm_host.h>
> > > +#include <linux/memblock.h>
> > >   #include <asm/kvm_pgtable.h>
> > >   #include <asm/rmi_cmds.h>
> > > @@ -56,6 +57,18 @@ static int rmi_check_version(void)
> > >   	return 0;
> > >   }
> > > +/*
> > > + * These are the 'default' sizes when passing 0 as the tracking_region_size.
> > > + * TODO: Support other granule sizes
> > > + */
> > > +#ifdef CONFIG_PAGE_SIZE_4KB
> > > +#define RMM_GRANULE_TRACKING_SIZE	SZ_1G
> > > +#elif defined(CONFIG_PAGE_SIZE_16KB)
> > > +#define RMM_GRANULE_TRACKING_SIZE	SZ_32M
> > > +#elif defined(CONFIG_PAGE_SIZE_64KB)
> > > +#define RMM_GRANULE_TRACKING_SIZE	SZ_512M
> > > +#endif
> > > +
> > >   static int rmi_configure(void)
> > >   {
> > >   	struct rmm_config *config __free(free_page) = NULL;
> > > @@ -95,6 +108,80 @@ static int rmi_configure(void)
> > >   	return 0;
> > >   }
> > > +static int rmi_verify_memory_tracking(phys_addr_t start, phys_addr_t end)
> > > +{
> > > +	start = ALIGN_DOWN(start, RMM_GRANULE_TRACKING_SIZE);
> > 
> > This will produce an error on systems where the start of system memory is not
> > aligned to RMM_GRANULE_TRACKING_SIZE.  For instance, on QEMU-SBSA the system
> > memory starts at 0x100_4300_0000.  With the above and RMM_GRANULE_TRACKING_SIZE
> > set to SZ_1G, @start becomes 0x100_4000_0000, which falls outside the memory map
> > known to the TF-A.  I fixed it with these modifications:
> 
> Thanks for raising this. This would need to be addressed in the RMM
> spec, I have raised it with the team and will be addressed soon.
> 
> > 
> > LINUX:
> > 
> > diff --git a/arch/arm64/kvm/rmi.c b/arch/arm64/kvm/rmi.c
> > index 10ff1c3bddaf..21bfbbe2f047 100644
> > --- a/arch/arm64/kvm/rmi.c
> > +++ b/arch/arm64/kvm/rmi.c
> > @@ -424,7 +424,9 @@ static int rmi_configure(void)
> >   static int rmi_verify_memory_tracking(phys_addr_t start, phys_addr_t end)
> >   {
> > -       start = ALIGN_DOWN(start, RMM_GRANULE_TRACKING_SIZE);
> > +       phys_addr_t offset;
> > +
> > +       offset = start - ALIGN_DOWN(start, RMM_GRANULE_TRACKING_SIZE);
> >          end = ALIGN(end, RMM_GRANULE_TRACKING_SIZE);
> >          while (start < end) {
> > @@ -439,7 +441,13 @@ static int rmi_verify_memory_tracking(phys_addr_t start, phys_addr_t end)
> >                                  start);
> >                          return -ENODEV;
> >                  }
> > -               start += RMM_GRANULE_TRACKING_SIZE;
> > +
> > +               if (offset) {
> > +                       start += (RMM_GRANULE_TRACKING_SIZE - offset);
> > +                       offset = 0;
> > +               } else {
> > +                       start += RMM_GRANULE_TRACKING_SIZE;
> > +               }
> >          }
> >          return 0;
> > 
> > RMM:
> > 
> > diff --git a/runtime/rmi/granule.c b/runtime/rmi/granule.c
> > index cef521fc0869..60358d9ee81e 100644
> > --- a/runtime/rmi/granule.c
> > +++ b/runtime/rmi/granule.c
> > @@ -209,9 +209,11 @@ void smc_granule_tracking_get(unsigned long addr,
> >                  return;
> >          }
> > +#if 0
> >          if (!ALIGNED(addr, RMM_INTERNAL_TRACKING_REGION_SIZE)) {
> >                  return;
> >          }
> > +#endif
> >          g = find_granule(addr);
> >          if (g != NULL) {
> > 
> > This is likely not the right fix but hopefully provides some guidance.  Send me
> > your patches when you have an idea and I'll test them.
> 
> We will send you the update once it is fixed in the RMM spec. The rough idea
> is to remove the ALIGNMENT restrictions and return a Range that
> the host can iterate over to find "regions" with the same type of
> memory.
>

Ok, thanks for looking into this.
 
> 
> Cheers
> Suzuki
> 
> 
> > 
> > Thanks,
> > Mathieu
> > 
> > 
> > > +	end = ALIGN(end, RMM_GRANULE_TRACKING_SIZE);
> > > +
> > > +	while (start < end) {
> > > +		unsigned long ret, category, state;
> > > +
> > > +		ret = rmi_granule_tracking_get(start, &category, &state);
> > > +		if (ret != RMI_SUCCESS ||
> > > +		    state != RMI_TRACKING_FINE ||
> > > +		    category != RMI_MEM_CATEGORY_CONVENTIONAL) {
> > > +			/* TODO: Set granule tracking in this case */
> > > +			kvm_err("Granule tracking for region isn't fine/conventional: %llx",
> > > +				start);
> > > +			return -ENODEV;
> > > +		}
> > > +		start += RMM_GRANULE_TRACKING_SIZE;
> > > +	}
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static unsigned long rmi_l0gpt_size(void)
> > > +{
> > > +	return 1UL << (30 + FIELD_GET(RMI_FEATURE_REGISTER_1_L0GPTSZ,
> > > +				      rmm_feat_reg1));
> > > +}
> > > +
> > > +static int rmi_create_gpts(phys_addr_t start, phys_addr_t end)
> > > +{
> > > +	unsigned long l0gpt_sz = rmi_l0gpt_size();
> > > +
> > > +	start = ALIGN_DOWN(start, l0gpt_sz);
> > > +	end = ALIGN(end, l0gpt_sz);
> > > +
> > > +	while (start < end) {
> > > +		int ret = rmi_gpt_l1_create(start);
> > > +
> > > +		if (ret && ret != RMI_ERROR_GPT) {
> > > +			/*
> > > +			 * FIXME: Handle SRO so that memory can be donated for
> > > +			 * the tables.
> > > +			 */
> > > +			kvm_err("GPT Level1 table missing for %llx\n", start);
> > > +			return -ENOMEM;
> > > +		}
> > > +		start += l0gpt_sz;
> > > +	}
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static int rmi_init_metadata(void)
> > > +{
> > > +	phys_addr_t start, end;
> > > +	const struct memblock_region *r;
> > > +
> > > +	for_each_mem_region(r) {
> > > +		int ret;
> > > +
> > > +		start = memblock_region_memory_base_pfn(r) << PAGE_SHIFT;
> > > +		end = memblock_region_memory_end_pfn(r) << PAGE_SHIFT;
> > > +		ret = rmi_verify_memory_tracking(start, end);
> > > +		if (ret)
> > > +			return ret;
> > > +		ret = rmi_create_gpts(start, end);
> > > +		if (ret)
> > > +			return ret;
> > > +	}
> > > +
> > > +	return 0;
> > > +}
> > > +
> > >   static int rmm_check_features(void)
> > >   {
> > >   	if (kvm_lpa2_is_enabled() && !rmi_has_feature(RMI_FEATURE_REGISTER_0_LPA2)) {
> > > @@ -120,6 +207,8 @@ void kvm_init_rmi(void)
> > >   		return;
> > >   	if (rmi_configure())
> > >   		return;
> > > +	if (rmi_init_metadata())
> > > +		return;
> > >   	/* Future patch will enable static branch kvm_rmi_is_available */
> > >   }
> > > -- 
> > > 2.43.0
> > > 
> > > 
> 
