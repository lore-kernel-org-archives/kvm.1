Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACDE3435503
	for <kvm@vger.kernel.org>; Tue, 11 Aug 2026 13:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786456774; cv=none; b=PC6igrPWxY2VgIDPGwtp4NJZ6AEnus4QiOvCUsvcf1cubiLOWLSdmPwhR6hHOLXFkAfy14q0DaUM9vAsd+HCHpRC2T70oktoeFBP9WL238KUNgynopfOdYLMhtSJQZqY+04ru5dfDef1lpr2eTOPh/usa94AzpPA3fZkAga8Xyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786456774; c=relaxed/simple;
	bh=QBMfK3eIkZi/jJl/oa48IFZJDBU0kclwX3To9OnzWTY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D6KFBuOnQvONqvh/O8QhICcq1pAJWvOKz/BCzug121uXUorWPS0xtCUt3SMNPxMEOSNaFxzYO9JGfodg/DVI2Pz3KnE64DZtBhJf408PjC9LXCvRRGDN+/7X+PXv+5WguAQiO7GnmZ+9o3ARGCypVRJDoJyPjgO87int+6jfy9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=SB6P4UpH; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="SB6P4UpH"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-51c05dcdf49so29794951cf.0
        for <kvm@vger.kernel.org>; Tue, 11 Aug 2026 06:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1786456766; x=1787061566; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=t5rMEoFMyC39ciFQHolbpCiBeUsGRE4zV/d+AHYh648=;
        b=SB6P4UpHZQaNwfylzE8hF3fIRSOI75D48jq4WZGphlHrA8t/ZruyQNpKz6NiinplLC
         HxC4IoH7JVnQ7JVY7/V6uZkKqZJf3elMZQ245c/0vrVzJN8O54vGgHIRWIiyaeR1iNBk
         MKh8BF1JalRqNsO7eQKC3bJ6ZYqegEeYlFyldjuvw6A5rwqtX2/r/mgxMrukhHKJo98U
         CyzFDOA1VIYDMvWmPXqsyO27o4RW7HKhF5tx1JdUh0VMA/bQ5/EBANgjnEB91Nt7nu5v
         02Um7gihTQuSTk7fBPKNUbz01WHtdjAadhkE4g7hdXP791vdu1TGqIM/HUMFQfW7Bt0q
         DOeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786456766; x=1787061566;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=t5rMEoFMyC39ciFQHolbpCiBeUsGRE4zV/d+AHYh648=;
        b=koXEcIdzNYTJGKQOeBE4q50FnTIo9GMTJqlSmbAbTRYH7ZLRAhA+93lRPrIK/azJx0
         HoGmQyfXgBaDBiEGwv6O/F0Fl0RJrs7l7irdVHHPjTuIF6sWyLClpBH5jHbewFmcI4CF
         kA2wZp07Jip6rCfLpX/2IvAt7w5YES5sZYA2wbkrdcI6LW9qpXKUdeYHynH2NxP7n+Jz
         BPCOiTh9OZulWPR2Mhq4GvdglIrkurfjNCCPXglIowhX0LL3uFyLj6yXuFc6zJKgPlVe
         tItrv2IaigMVTeRFHHy811ISN+ivS81WqrhqRMllKa0yZD5KsPV+4peT7ckz+JCA7w6J
         Whug==
X-Forwarded-Encrypted: i=1; AHgh+Rp4RvKTdfC3rYxRixEPlFdlcXl6y0gSBTF/Q7FVDny3O3Xsu1Yk7GspYSkYJrFOMi9Hljg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzG3Zp2b0AOz1ZF5Sc8rrdTKnpt58A+vss2CAlUyEEfkRHeWgv
	WDl/9XqHS6RyWSJByizdF8lS1oD8hbTwTH0ApM45RwPBCrfRwuyzXhPENKUrTxcJIG8=
X-Gm-Gg: AR+sD129uIpnVWhJyVlqMCiqGdSn6LEM2fp8zEk4pt//p7Xx6iCDChSkuKSaGqSfT0X
	M4K+nb2XdpEHyPj/rr24JVrxe968efCQfm2pMPbeDxmVdgpVk1obW6BTJuZlHS3dsXwPrYL4EiL
	Sh8uILGW3loFdY23n5RehtE5M4YayXNJXUOtV4XXGRX/RVGziz4NWLbQLZr2dBesn8E+Ag70y5c
	GG3MzEu+n/xxIEfLvlqcwPi4L7F9BGANsIr6O1UBEskvCN5Ao7y9YCQlz72PE3jACibdDCM7NHu
	mpmz/jZf7+zY0TSpfY1C9rDb+GQ2OxqVoEPxGOLLlVyjEaw1fFVO/Q1SMWMBzxdc54EUtsw8G9P
	WXjPXZf1tjrwlPVVIB4PiNIv+++cO9gyu0VsoRet3tjbJ4w+VejofdMzX1PSIPHkbo0YsLfSesz
	ndwLsKHzy8JelB9Ix5YwDNH9YpQEYtXsXnZOGaMKhb3gAvmzp/
X-Received: by 2002:a05:622a:118d:b0:52c:dde9:5cd5 with SMTP id d75a77b69052e-52d585e7a53mr29953211cf.21.1786456766228;
        Tue, 11 Aug 2026 06:59:26 -0700 (PDT)
Received: from ziepe.ca ([142.166.156.215])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52d57bd2bd5sm11528161cf.17.2026.08.11.06.59.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 06:59:25 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wtn0m-00000002Une-3ZoM;
	Tue, 11 Aug 2026 10:59:24 -0300
Date: Tue, 11 Aug 2026 10:59:24 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: Alex Williamson <alex@shazbot.org>,
	Samiullah Khawaja <skhawaja@google.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	Leon Romanovsky <leon@kernel.org>,
	"dmatlack@google.com" <dmatlack@google.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 1/1] vfio/pci: Disable sriov on PF device close
Message-ID: <20260811135924.GD544626@ziepe.ca>
References: <20260805003355.728299-1-skhawaja@google.com>
 <20260805003355.728299-2-skhawaja@google.com>
 <20260805090323.01b1a36f@shazbot.org>
 <20260806194739.GH28508@ziepe.ca>
 <20260810093223.50dbc8d0@shazbot.org>
 <CO1PR11MB48350170CB4BDC89DB1FF96F8CDD2@CO1PR11MB4835.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CO1PR11MB48350170CB4BDC89DB1FF96F8CDD2@CO1PR11MB4835.namprd11.prod.outlook.com>

On Tue, Aug 11, 2026 at 09:52:37AM +0000, Tian, Kevin wrote:

> Before closing the open on reset, does it make sense to first fit it into
> the coming trust infrastructure [1]? e.g. initially set to TRUST_NONE
> for any VF with a PF owned by vfio-pci, preventing any bind to
> in-kernel VF drivers. Then opt-in is allowed to promote the trust of
> such VFs to TRUST_ADVERSARY, allowing driver binding but also put
> it in precaution with IOMMU protection. So a malicious userspace
> PF driver cannot indirectly affect VFs to do dma-based attack.
> 
> somehow VFs in this scenario feel akin to Thunderbolt devices...

That's certainly a novel idea that could make sense for drivers that
support the trust level

Jason
