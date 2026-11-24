Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795526204;
	b=meVmgLP62BDQjL+L2b2xt4TVf/ft8H4rlf0gxW9sZOdYqZN3LqdlPh4gSZ/EH7tHcfpK
	 SwQIJwux6TVdehNrD4Lq3gBc3CU/NhJSbDiDPEEv7nCJjPKb3QAENo0mey2AGrMFm0Rv5
	 c0/szvf9Cjta9CdwuTI7wLhBHj5M7GyfZPz9Hk/lq6cwsbBI+W3xBXKeeueZL+7pmiOPU
	 bpNZGwChUPLItnvauYtBadwS9D4dOTb8OJ5ncjSY8fJrttwiEVqxwnjdLuFx4mBXap+f4
	 DjXSBiVIyWAx+i4TcM58P4P/cnv3bUczeuPh9HKt6vM1+N8vUv6yIp9M49QT+gtUOuA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795526204;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=0prXWPyKnaONv+XVyeK4p1EFWEfFGuwvhH1CWWabhJE=;
	b=UR0PG4jxBOa5PPyWYY2a+AhBDJMRa/EUeCPZYhAvh1MuCOigNg8lxUlVk+nNDjTvJ9+4
	 G3me898wsp4ARHXmAxQI6HD5bPxGn/RhFYT7c2p14fjE1etNggQTlnexCCtRZnCU7DHbK
	 kFFzmkxlCfUfRAYZVOXm1v4U+emgmPBEtMFngwLuvaQkfj71rvdrDJERzgGTUmZDap+5v
	 QnWkKniww8+RbxG8zS/6PSBUSIXM5P+qwMcNCewFyopH2OOowuoowXM97tarIRD7+jB4t
	 ++r/1qMY9s6gw9GU4BBLYGx/mR4LDMfHTfXh75cQpDxTUzd8pBCCccWVcmkloJxUOuw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=d8A3Qew5;
	arc=none smtp.remote-ip=74.125.224.44
Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 384A8606A326
	for <kvm@vger.kernel.org>; Tue, 24 Nov 2026 13:16:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 384A8606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=d8A3Qew5
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-67da564d9f2so5995291d50.1
        for <kvm@vger.kernel.org>; Tue, 24 Nov 2026 05:16:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1795526203; x=1796131003; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0prXWPyKnaONv+XVyeK4p1EFWEfFGuwvhH1CWWabhJE=;
        b=d8A3Qew5zvLqzK7ifhPLlfqioCREpmfJ/ufDuC7F/5ssCfaC3RpCNWa/U4ObBLRPEb
         KmqKnykDd74s/kautjmAq6jdO1mO/FbnQocM5D2xgQhQ1BW6Lw6XgRtoXRqeyrXZ3xcD
         Ph1VN1Rz/NYbJRwEDCdCZ1TQ9c3VIX1TBeS7HbtfSHJfjiwZLFR21T8hoNoNTxjKB+Ls
         rgchTnplgcZJCVCdMBPsAQRXQUNz71A6BIj/EiT6AU9TQ9tlyHswlU+glWC8BqAOp7nC
         4b2Nqrn315qd5jC3dKSUwS1nElkC7FvegoieImbo3tWNzHIHrGZ45Bn6NiNNol/I73qZ
         aTzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795526203; x=1796131003;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0prXWPyKnaONv+XVyeK4p1EFWEfFGuwvhH1CWWabhJE=;
        b=OBFCx35Q8nPETyS+fHiLPVlcrGSQ0bVXIQAJ3uXvCta+XfZC4KoA+u+1tWx6DqWKCr
         LC4wq4OZaMAL1SRlaQp2BmsjLr0Q0Oec1ZEU81ht833PQHDYDe4la47rDak/rGQHZBRe
         NwS9pJ/S1/Ksh8kpmxQxSAXn/yNDUkNyM5g5Cbhr4xXaphGxPOUvu9BXAq+GCXzqcxzU
         76y+JpL1/oevj3ja18KSU6eD4B5bNNSKo4ZnJqILCDN4IM4dSd5Qwg+f027VJkgmSYyo
         ae4HgtOFQsmY1Yga4lhYiUKyr/9qB6NkC9NKFUzpf28LHnck+QWftWm8YOgVIlmNczB2
         erSQ==
X-Forwarded-Encrypted: i=1; AL+hErF970t/MPBDt0r7tU9pf0xbMSiNkSkdzLXUsKNXQ6km6dR1sFvgOmU4uP0BtuQyvnRRvuM=@vger.kernel.org
X-Gm-Message-State: APuU4Z8EguBgwNWoXPIiKgBGZaKJm9nFnMqhkAdyO2d7EVeboN7xUjSH
	YyEnojdJtMO3Zpq/nMor8uCGGGgfsg0UI0LOLXLBduUfnLDzCUfefDrxzwEtdJnWgVI=
X-Gm-Gg: AZFdTZcxGH7aS00p9ojPHa5Wx5SOodxQBPkEDoQNHA6mb3QM2A8ATYLCpEm/UMiC7qd
	TubK/ufSVoW+KhASepywhrM17TAcV9M9Ba6GF0Wq6OZPw/ARNjYG87cizHZAbw2A7mRaooOMnkM
	Jyj3cBhUUPLJIoRIZcaa52orvIzgk9jaFNqjd2ldMTv5PVE4cu2d7yMPFLZ1a8BZMWaGPgHCgES
	In2DXITVrL0dogCs9Jrv23oXzbDunRK12vnuzbmFaTOkx3FtzjwI4Rd7plT8JuY1dkNLaycSpkf
	1o2o5ZwZOUDwEfQB4PoLMN+JXV4b7cypUqvpZemjT/XlMXVPkNWxpxH9x3NBYzaanRsYg+GHszf
	1nmyXYMwcrYbBXT+NYKaH1mK5qHWwxIJhxpdNhlKiK8WH3znFwozhgZ6Ku9bX21sfhrAm5OAWS7
	z9nieXyE8IEpNFnBUvsHSQppxkOSLMS8dW0fC815Cu/fcM3YtWIugGMSXcE0fkR/CkX5msD1al+
	1H01ks+sIhlgJMLebQUJJjmUnBdTR5P3uiBvTGhLDq5mdnwIyyCbNaBRuTlDaf/D6E/vEjkRKjY
	XicKEA==
X-Received: by 2002:a05:690e:813:10b0:67c:11c9:2d10 with SMTP id 956f58d0204a3-67df449142amr3986970d50.89.1795526203028;
        Tue, 24 Nov 2026 05:16:43 -0800 (PST)
Received: from ziepe.ca ([142.177.118.84])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-949bb38322csm1037775085a.17.2026.11.24.05.16.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 05:16:42 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xVqO1-00000000P3N-3lUT;
	Tue, 24 Nov 2026 09:16:41 -0400
Date: Tue, 24 Nov 2026 09:16:41 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	Leon Romanovsky <leon@kernel.org>,
	Nicolin Chen <nicolinc@nvidia.com>, linux-coco@lists.linux.dev,
	Dan Williams <djbw@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	Alexey Kardashevskiy <aik@amd.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Lukas Wunner <lukas@wunner.de>, Ashish Kalra <ashish.kalra@amd.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	driver-core@lists.linux.dev, linux-pci@vger.kernel.org,
	kvm@vger.kernel.org, patches@lists.linux.dev
Subject: Re: [PATCH v1 00/10] PCI/TSM: Support guest TSM drivers
Message-ID: <20261124131641.GE9566@ziepe.ca>
References: <20261123083337.2731019-1-aneesh.kumar@kernel.org>
 <2026112325-emit-squeezing-5d96@gregkh>
 <20261123090623.GK14811@unreal>
 <yq5a7bi3riha.fsf@kernel.org>
 <20261123115803.GN14811@unreal>
 <yq5awlq3pto0.fsf@kernel.org>
 <20261123135638.GO14811@unreal>
 <20261123152533.GE179082@ziepe.ca>
 <yq5aik1n4iz3.fsf@kernel.org>
 <2026112429-expansion-wilder-a0c2@gregkh>
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
In-Reply-To: <2026112429-expansion-wilder-a0c2@gregkh>

On Tue, Nov 24, 2026 at 07:44:03AM +0100, Greg Kroah-Hartman wrote:
> > @@ -617,6 +619,7 @@ enum struct_device_flags {
> >  	DEV_FLAG_OF_NODE_REUSED = 7,
> >  	DEV_FLAG_OFFLINE_DISABLED = 8,
> >  	DEV_FLAG_OFFLINE = 9,
> > +	DEV_FLAG_DMA_CC_PRIVATE = 10,
> 
> Again, NO!  No "cc" nonsense for device states please.  That's an insane
> policy decision that will be driven by userspace crazyness, NOT
> in-kernel stuff.  The kernel will give userspace the tools to enforce
> this type of policy if someone so desires.

This may be the wrong place to put it, but this is not a *policy*.

This is a "DMA property" like dma_mask, coherent_dma_mask,
bus_dma_limit, dma_range_map, dma_params and so on.

The name mirrors the DMA API name for a related idea:
DMA_ATTR_CC_SHARED

Unlike the other DMA properties this one is changable dynamically
depending on how the HW is configured. The TSM is in control of this
HW block.

The userspace policy input is how to configure the HW, but once
changed the DMA API switches to following the new HW parameters.

Nicolin, can you put this in its own patch with a good commit message
so we can have a discussion where it should live?

Jason
