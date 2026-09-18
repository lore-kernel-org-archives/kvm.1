Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E3C3AAF7A
	for <kvm@vger.kernel.org>; Fri, 18 Sep 2026 02:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789700394; cv=none; b=b2efTd9wS2q+NWYQn7BH2TgDOi4EtVvEYT+90Tx7nn3H/oVMUi2/TyNXsYs6xJRdci8cwm0ICGpDSYILDf5vxMZUQUNSFZkpBOxi6LHVOikLscReXnHneN1x0K5cR6VJpQ0YwCnVJt0xmUnKV6bdd746QJOfS4xFBSZEBhWoCLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789700394; c=relaxed/simple;
	bh=IA0A2RgVsub/BbYG7H2jzk5weAVNHePmc5M43c0YUF0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UhmQDOSq6dy7PAmy6GOOlFJq5k3YiKcue4Cw1bWFDmKRmlqAwUa/HD48Ml+99x3adQIvN2bnryJ0fNm5RAgYmI5RMDmQHiuCc/fR5voGDnlUgpvwm9kXKgUjuVf/uPPoezPAh9w69DWjILcHNRMxofaJ7ibhtjT2Mau/QAf2cy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VZ4YAcoE; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VZ4YAcoE"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2d8fd7a3f38so35185ad.1
        for <kvm@vger.kernel.org>; Thu, 17 Sep 2026 19:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789700389; x=1790305189; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IA0A2RgVsub/BbYG7H2jzk5weAVNHePmc5M43c0YUF0=;
        b=VZ4YAcoESXMR1y7IzOkXzB6P/7dzuq9f7uY9pGfvgr+8tO5CbQMFOpQObOTgtCSbeV
         oe4sOlpyMbUbhCUJmDSLVUjCnDQXACNHrfrAxWa6CQ9HpPxiMORqNPlpIZsUPvzbZ59Z
         R+x4mVCH27/enXK/7KKRWOBCiXIFFNgpexLto4hs8mxWIMstcSRxFsJwAqVYvYVeDHYZ
         gk+TBeCUZ4g0ofbz71aXfqS/KfdW0PAzJJWrQXDuV3eXtMml0cXpXxlRvrlX8HkuFdzd
         GHnXPCxrrgyHvfn8etux7OhtDTyUIrQ0kRUjBxnW7G0PQgfjyeYE8Z3uIP09xUCv3rf2
         knlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789700389; x=1790305189;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IA0A2RgVsub/BbYG7H2jzk5weAVNHePmc5M43c0YUF0=;
        b=RUrxjOOkftUJTv9xqI0fRJqEvRrbnXmkZyoYrkm1HGtZvwm1Z1gOrwUeNZzBAdqxsM
         gdMqUuptqquTfszM6cPbQ/fBs2a4cS8sPM1iYkWcE8bkYSDOcEVqz28sDDoj89effJk0
         LEKmK3UFEubK76rallu5rlB1hAmg7eHAjYR4wpMjVymXIz5ic1SjJums2pczSxqVNNL8
         WlCzlhhX9+zes93jmGTcn+kEzBiA0WgYr9hNxHLstieEpSWi6RlhmzemMlkBVgnrsq19
         KmQpdO3gak7YMhi4gVkqo6zbSkZ/lGVgrvbd4IMeU3g7z/p8x+Te6OBILcMF+QrCY5TT
         7peg==
X-Forwarded-Encrypted: i=1; AKwUvBxvTvPAt8cL790xOWoPiVxsVvLEc85BiBy2Ozb1c76znLTgX/RUaCRAOS8Yjs7bJCwhgNg=@vger.kernel.org
X-Gm-Message-State: AFuF++k3wQg5F7S+mB+VpJa4Itjy16eeoows6llYANa6KYn53M0ayZwe
	8aEfffFDEs7IY5ueNgwtigIeYK54pAnoad0J7HnpRoTBw1Ep5Ts03PsbUTz5dTJ/hQ==
X-Gm-Gg: AYBFou2bjgZoO2EYPXGcc7FSkatVWiaZXgsH+b4xTf2AExK+qtpbbuqnupoGdPaSc5B
	YgaNE4G+KoPnSsMe8fbeeFouJSI/5BVq/h87THE/9JIYtHXNRVaVMkII6uuOGw6sDFumHLkD7m0
	xCrHK/KcuSkjUPiJ4tQ9CnDNOrELH5D/V66MTHEXNmrKIe8uI86flzfh28qmIGcQy7e4Gf7KrOy
	Yv7se2hLTG7HNUTlrP4CipFQAded/C+NgfHRdD9DgmD3fm1j7U2jSW3Z9BurNExSsf91mspMdpj
	AMfue3Ekrm/aWJ6ZPi1DnuX6HxzHbkJoa/F8PTgORtV0BzK5mOo+6s97JPrXFewStuwO84CWEYH
	mPnfkbybDYWkNKEE1WiUUCCCfnGGPIFd+mq/sQ4R2mNEJLstNTSMPD4Jk7An4qzNQGL8y67Ugyx
	4/a8cnkwp4inhnp5t6uNoc4JxpE5XTsN1PS1mrQHSW8CJtzTzt0TgOI33YNnCWxE2JH4KbCcKmQ
	MHaydFFRkMILlnDsOs/TBO6C0qKhPuPOr7e0gg2sUD5eq2JWXLQm5XBcAUhWlVZ3pS8MYhPyv4h
	4TRt
X-Received: by 2002:a17:903:4b08:b0:2ca:6bf:5bac with SMTP id d9443c01a7336-2ddb13465cfmr4177465ad.8.1789700388427;
        Thu, 17 Sep 2026 19:59:48 -0700 (PDT)
Received: from google.com (210.87.127.34.bc.googleusercontent.com. [34.127.87.210])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e55412d51sm555950a91.2.2026.09.17.19.59.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 19:59:47 -0700 (PDT)
Date: Fri, 18 Sep 2026 02:59:43 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Baolu Lu <baolu.lu@linux.intel.com>, 
	David Woodhouse <dwmw2@infradead.org>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>, 
	Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, Pratyush Yadav <pratyush@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, David Matlack <dmatlack@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Pranjal Shrivastava <praan@google.com>, 
	Vipin Sharma <vipinsh@google.com>
Subject: Re: [PATCH v4 12/18] iommu/vt-d: Handle reattach of the restored
 domain
Message-ID: <aqyW3RzBGQyZebsG@google.com>
References: <20260808022723.3893618-1-skhawaja@google.com>
 <20260808022723.3893618-13-skhawaja@google.com>
 <5b920299-260b-4025-ac4f-e8f83beebf95@linux.intel.com>
 <apBso6So7UqwR3AX@google.com>
 <bb7052d7-51fa-42e0-9eb5-ba4743956688@linux.intel.com>
 <20260828143546.GC3769797@ziepe.ca>
 <apGpHv8vy4SWIEaV@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <apGpHv8vy4SWIEaV@google.com>

On Fri, Aug 28, 2026 at 04:15:56PM +0000, Samiullah Khawaja wrote:
>On Fri, Aug 28, 2026 at 11:35:46AM -0300, Jason Gunthorpe wrote:
>>On Fri, Aug 28, 2026 at 09:55:18AM +0800, Baolu Lu wrote:
>>>That looks reasonable to me. I have no concerns about keeping ATS
>>>enabled on preserved devices across kexec reboot, as long as the
>>>software state is synchronized in the new kernel.
>>
>>The new kernel should issue an ATC flush when it changes away from the
>>inherented domain.
>
>Yes, I will make sure this happens when we do the retrieval side. It
>should mostly work well with the existing replace machinery.
>>
>>>By the way, is disabling ATS an option?
>>
>>No, many devices require ATS.
>
>Agreed on the ATS requirement. I had Nicolin's patch series for CXL
>devices in mind here.

Having implemented this now, I am thinking about this again with respect
to the scope of this series. To limit the scope of this series I am
going to refuse preservation of devices that have ATS enabled. Once the
base preservation logic goes in, I can add a separate series on top of
it to add that support.

The ATS adoption would need new helpers in the PCI core, handling of the
ATS state in the context entries, and the disable-to-enable,
enable-to-disable and STU mismatch for a live device. That is worth its
own review rather than part of an already large series.

This essentially means that preservation is supported if pci=noats is
used, since by default ATS is enabled if the device supports it.

Thanks,
Sami

