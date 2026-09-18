Received: from mail-qv2-f12.google.com (mail-qv2-f12.google.com [74.125.230.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5046A4F3EA4
	for <kvm@vger.kernel.org>; Fri, 18 Sep 2026 13:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789737898; cv=none; b=d8Jki5sh/RwIoaYD3t0Ndtw9eWNUW03lGBvx00DJRN0IOLkJoDqbhOwEUcHDVVM0g0nIOwdrpPfKh+zGOoFJ6c5RUrIljgw2GLDpRmI60U6SM19zpIpkPrCyxQLX8egG4hDkj/fthHs4K9U/uqRD/vhd7RbYpRhPyeMk4f/Hyqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789737898; c=relaxed/simple;
	bh=v9UdPVY3a3m1N1cQS4DrnsIxV/L+mPyRwqE2xihCRdw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sgioYya785YNB+5FMkYnzsjenQWxWAftmG7QIVJ4GoVP+ripIxZI1fiB2DKjdllupxr4LOjOi79s7AnkV8/8OLmWYgZdQlaFcGw+XxoH4hfJRXLoczBjfcs+wmo++VZClAZiuwl9DeCOoYe2bisQzjJzGc677hzzRwzqPTFL9Cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=R3ySaGL5; arc=none smtp.client-ip=74.125.230.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="R3ySaGL5"
Received: by mail-qv2-f12.google.com with SMTP id 6a1803df08f44-90cdfbd148aso6327286d6.2
        for <kvm@vger.kernel.org>; Fri, 18 Sep 2026 06:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1789737895; x=1790342695; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mn3aKmmmFmyEWeqRjbvgjKGN1x4p/IU34Fpl/53vDbE=;
        b=R3ySaGL5frHpRepuatv5HJ4AikBrYUEgGtgAm/GHfcG/yrpUGPyM6+4Oaua4XAjm7F
         F0pbJG4Zi7+U3QXshaalrCu0SR0bugJWKv2G68cwyiTisVKfL9JLm2U6cmsqsNrHADQ1
         HvRAZBWkIuh/TWITsZhFpRAI2qIrwwvdQBQpN3sSlmk1NT5C/4/hJ6Um+tfzJmADOAge
         JdCPPGebVyeEVZzOgf5VEYLM9gTETJvlw5dWhYih0ksyowVOh4jlFF0mVYwg+ZiBbMiy
         wJ7XSU1zQtllFsmGhRHNi4HLC7Aj0UA66sJkQsCXZFWX6EJvei/OK2+s5mfOs9+RciId
         0svA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789737895; x=1790342695;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mn3aKmmmFmyEWeqRjbvgjKGN1x4p/IU34Fpl/53vDbE=;
        b=PVcNbCmkQJm6xhdLCT+tIW2ajhE/A+8SiLJKwHNeKaJ+WZPQYQYUcDXSoJMOMK7mo6
         mv0oQWKx1Ij96mFgqbVv+2LjZGH3SGdXfg/iGhQrh3m00DF4FGlmkXbxiHv1koIhB7Jh
         E2H6l/ZLqXnTDpmFtaIVTauCMabrc5NfpHKt61WiCkUkXXn9Jr1OgJtGnJ1J5QIOEHyy
         9DEQqdlEuVQpvwDz8R2gaCWcU9z3ftQqqN8uKd9oooM5vmjrwrSxbSrZs+W02MD+xUHY
         qcOgqkG/YKwlQCDb0l9ZEmkjJ1ggYavcTUlduTefZxSkX/R6Fw4nJBSI89HvBwYrODOQ
         TQ3A==
X-Forwarded-Encrypted: i=1; AKwUvBwiT7ZbooUtchw4V14x8+U32e/C5t+5GiCOnDXIEkI1ZMipsDZ/OZg/g3xuvQxnPWSQDt4=@vger.kernel.org
X-Gm-Message-State: AFuF++kX+Fs29BOF7ktlR52MbzE7q6l/6QvxG579xXXkuo+5EPsvn2BM
	O7BbvmNS0CNvQOoCckm8k6SR8lFqCynQPpd4U/OztqQMAhqybvsXZhMJHjauklpNDEI=
X-Gm-Gg: AYBFou2HsTaniuBw4bRi99W5GVdMcpxUcBwc68XVA8WCyTOoKRf0kCVB+EIEucEISEl
	YcpOgNR0ut/cYwue/2yvHOl2jeIBe780wnlLeCqXwluc6G2DMQRs39+o8r7BlxKPj0cbK6yro5z
	iW+KLwjPdLiiHHyiD2kPZ44IRsoUY3sQ7kCSc0ILMEdb7k/f0RV/AcP7/YYir0egAbR2xEWX+Dx
	a7di+hyp6ZAcodACCrYtlYEDD815qMm5oTq/uTqIsjEQwukjFhNkD2lpVu1t8vCcpOo1Rga7Byc
	6x5z7/BT1JsvGHBLWiNAFOiAfu7r8tm3UFG588Pr+oBcyr7pZkhPh8pMB9JdwZ6fl2bwvM/BFKw
	BZD3URT5CXOnbusHSf1Qzu0ltaPyEg8wJmGgbs7nXgbR2sZ9z/T4WXETXYJqAKQ3/SPQLlHZQze
	aSX4XnUK0j0n3WFq+OTddRD+t89N08NBw/ZCvRc5ZYoiVADo5fUOMZ/1qOdj+0sMMblFyzppXPg
	s/5lkLZBgLz/Ns92M5FdtJk6pMQrAtiXruBwBMTSM5CqYuz7bS2eMAl
X-Received: by 2002:a05:620a:6186:b0:930:9091:f0ce with SMTP id af79cd13be357-93bdc70b7c5mr343538785a.22.1789737895140;
        Fri, 18 Sep 2026 06:24:55 -0700 (PDT)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93be0ed258esm134537385a.30.2026.09.18.06.24.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 06:24:54 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1x7YaD-00000001Cw0-3NeV;
	Fri, 18 Sep 2026 10:24:53 -0300
Date: Fri, 18 Sep 2026 10:24:53 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: Baolu Lu <baolu.lu@linux.intel.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, Pratyush Yadav <pratyush@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	David Matlack <dmatlack@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Pranjal Shrivastava <praan@google.com>,
	Vipin Sharma <vipinsh@google.com>
Subject: Re: [PATCH v4 12/18] iommu/vt-d: Handle reattach of the restored
 domain
Message-ID: <20260918132453.GC11599@ziepe.ca>
References: <20260808022723.3893618-1-skhawaja@google.com>
 <20260808022723.3893618-13-skhawaja@google.com>
 <5b920299-260b-4025-ac4f-e8f83beebf95@linux.intel.com>
 <apBso6So7UqwR3AX@google.com>
 <bb7052d7-51fa-42e0-9eb5-ba4743956688@linux.intel.com>
 <20260828143546.GC3769797@ziepe.ca>
 <apGpHv8vy4SWIEaV@google.com>
 <aqyW3RzBGQyZebsG@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aqyW3RzBGQyZebsG@google.com>

On Fri, Sep 18, 2026 at 02:59:43AM +0000, Samiullah Khawaja wrote:
> On Fri, Aug 28, 2026 at 04:15:56PM +0000, Samiullah Khawaja wrote:
> > On Fri, Aug 28, 2026 at 11:35:46AM -0300, Jason Gunthorpe wrote:
> > > On Fri, Aug 28, 2026 at 09:55:18AM +0800, Baolu Lu wrote:
> > > > That looks reasonable to me. I have no concerns about keeping ATS
> > > > enabled on preserved devices across kexec reboot, as long as the
> > > > software state is synchronized in the new kernel.
> > > 
> > > The new kernel should issue an ATC flush when it changes away from the
> > > inherented domain.
> > 
> > Yes, I will make sure this happens when we do the retrieval side. It
> > should mostly work well with the existing replace machinery.
> > > 
> > > > By the way, is disabling ATS an option?
> > > 
> > > No, many devices require ATS.
> > 
> > Agreed on the ATS requirement. I had Nicolin's patch series for CXL
> > devices in mind here.
> 
> Having implemented this now, I am thinking about this again with respect
> to the scope of this series. To limit the scope of this series I am
> going to refuse preservation of devices that have ATS enabled. Once the
> base preservation logic goes in, I can add a separate series on top of
> it to add that support.

That seems reasonable

Jason
