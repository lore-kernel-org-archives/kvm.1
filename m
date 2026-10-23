Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792779327;
	b=uNpjI4cyteNTkT/D7gVb2m+2g+GZtXfS86HCEil+jPpcTZhtSWdn3kkmgLrhgbsO4Rr+
	 Fxie26JRiY1OY42k3PYLEi9rXWftVwxekBxdt1KONJi5Uu6YywVxT2Bn/XOKQcd2Bx2RA
	 wF3TCtBAdXgZxDbznUYbkHmh49H/c88xL+laMU9d4DVqRHiNwl8EMFTWcMujY5EOjbJqm
	 ND3r3VVVptR58PnTIZoOCymPEUHgzwG2ip+MgGqXn+FHFIb0UmPmbIj3NTimeOM04erB9
	 vTUzKkBF09iCuZAhHn9Jnkxtuj1nWrOp21NMQy8HI9fveflKlkxsVv8LZAVzG2cpY1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792779327;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=Qt+ZKJaVNRWLSfsLrt7/fp04EXHG7/fEzwXs7hhdXAs=;
	b=vWtIu6LtzFL4uXs/ytYFJfG7jbZRp/kksHeJZX5qNx4xV6/EQTozueDdg/6sau92rR40
	 m244h1IHG/XAS97yrPnnpGdBWC+SX5Px1wr/LyoeXY/JB5PxtvUIF96UWhbVj6FmAV3sZ
	 t/IKgmglLuSlqDl/JQWXwXIZuwwibz9C+2SFEHDGL/pmSL4s8rFg9RPBUtQ7527tZQdrI
	 gWUDO1ZTSMH0nG8ePEhh89euZqyYknPixCL4GVuhDqfaqAr7p0t3CKChVURU48o0OBpdO
	 9fJ2SprI/hUSfe02mnWBIXWLbQGA6hhDk+gVxkqySS2BtW1EX87XgI/z/NXPYCj6ymw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=resnulli.us;
	spf=pass smtp.mailfrom=resnulli.us;
	dkim=pass header.d=resnulli.us header.i=@resnulli.us header.a=rsa-sha256 header.s=google header.b=O7qkyEr9;
	arc=none smtp.remote-ip=209.85.218.47
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01092606A323
	for <kvm@vger.kernel.org>; Fri, 23 Oct 2026 18:15:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 01092606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=resnulli.us header.i=@resnulli.us header.a=rsa-sha256 header.s=google header.b=O7qkyEr9
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c4322d310e7so178890066b.0
        for <kvm@vger.kernel.org>; Fri, 23 Oct 2026 11:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli.us; s=google; t=1792779324; x=1793384124; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Qt+ZKJaVNRWLSfsLrt7/fp04EXHG7/fEzwXs7hhdXAs=;
        b=O7qkyEr96a2bINpE6/r6kEb0535R1oyjk5PKdiHdWuRqzyQHVAIHlQayFrNwVqaizf
         OZjoFhvrNBBem744hV7PcpwW+uNDtb3Liqy886CyHCC0HM9q+hVxyT5gJpqo6TbWrz2q
         a95iHMVJ6s6hSkLo/uQJLWBpWlQoTZRv51uNA8sKcev0oI13JRo3QqHN9FED4MiFnc2H
         rF7HNHP3bz9cO+eP3RUTAMe+Isc/LhMQXjHhCxfmDpay9QAcYRLsLuHLwdszmyj/HFG3
         K/CQrimbe1zkJJqSM9Lhz/E2y4Bs2mMDqGiJN+StKl+H0kD7/jAOUDp5G+6V4bMpJgoE
         tV6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792779324; x=1793384124;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Qt+ZKJaVNRWLSfsLrt7/fp04EXHG7/fEzwXs7hhdXAs=;
        b=pG5zrRO4gQr5pdQbfP7+kxdBOnG2OCQoLc6kP833WbsJLvJnMntQBXfKvIRSmI3sLA
         dv8OPSCyDz4l/9bVdgG5ujCwn2qFm+2zY6d5rWOcpw6VK3CFVzQvvf/hFCIpNLZqtkzA
         cCVcy5/3ZGkM0J+uoMiuZsMq8RCIQKd+JMQ1ZveBJ1b0gXhgyUc9GSjay9NZpoC5bi6v
         w8NHxgFW7MiGMSCZltzOeDqj9UUZtz3v4xAdRESRlD76K0RiVhsBhv4zfwwxPRFDPBcR
         fp5o0nSpjpWMgWLK05ScdDA9dTyotI5s87wt8Bd4E6ugH94LMVhGdha1jQV4ECLHNrcy
         W1CA==
X-Forwarded-Encrypted: i=1; AKwUvBxAqt4dde/LcqTRdLW7xFtazLjpmpIYupnRXyt8jeGqXJXo8dp6sEm5hPo9CALDPxtl790=@vger.kernel.org
X-Gm-Message-State: AFq9FYIozCcsCq6g4PQVY5+irBMGSeqQHYh9KS/wBlt1HilSxz4cElWv
	RTkhhMTFvWtKQmMLrb1IiPNX6TfLh79YL873RMDKuISDa+UVHDEt9SdSnSCPzGlPwTI=
X-Gm-Gg: AYBFou2MNeOOsejxxK3ll6yuHkFHTtBfkPdurDcuak9a1XIW2sNqTVcD1z4SNd6p16D
	kAnVD0qokbwo5+OtiMw8EnH4NFcK9b9XIw3yZOtOBayLQvoTPOEb5G7UsOUNvE+hGEbkL014WHS
	vP36NyHg6NCDTcViCnzXkzQT/GumwUUtu/DmjkFGVIfbpkAY8Yj9tYdZoiq3pc2/4Jw+OQrlps7
	ZzwuZz/MrRVV4GjDjm6MjWGfFDQ7tEn10BKQXub8fPiSBrgQCIT3qRP16vwRQDFvCezDfHcTr19
	vNk1xzswYVvNUj1JgSWeqtJhLZCeWTCrHAMN/ogc1l/deODJs0fu6Tfb/6rGaUqWpfI6Pjm7J4C
	cMZpHV2T1AX+p0+77yuwaegVHhzjf/dQsRC4nqtL0Za/fdYRcJbA/+BDcLsnN1dV26ofJrp6D9z
	frYqLBV+JnzD/HKN4VXdi/EjyXeMbmSSdyYWP5N8UGAJiZd0ZUj1N0CSAdjepy+mBVDj6x9A5bz
	xZxtl3sLLiQR+5E9mBVXLIs+lERc0ikOHHlIdV0VkzAlwqr4niEm9S8ykHxiATlbhc=
X-Received: by 2002:a17:907:7256:b0:c2e:3f49:df04 with SMTP id a640c23a62f3a-c46a8eefbdamr488289866b.1.1792779324041;
        Fri, 23 Oct 2026 11:15:24 -0700 (PDT)
Received: from localhost ([140.209.217.211])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c46b8bc2851sm27128666b.31.2026.10.23.11.15.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 11:15:23 -0700 (PDT)
Date: Fri, 23 Oct 2026 20:15:19 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc: "Jiang, Dave" <dave.jiang@intel.com>, 
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"pgonda@google.com" <pgonda@google.com>, "jic23@kernel.org" <jic23@kernel.org>, 
	"drdeeglaze@gmail.com" <drdeeglaze@gmail.com>, 
	"James.Bottomley@HansenPartnership.com" <James.Bottomley@hansenpartnership.com>, "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>, 
	"Xing, Cedric" <cedric.xing@intel.com>, "alistair.francis@wdc.com" <alistair.francis@wdc.com>, 
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "Reshetova, Elena" <elena.reshetova@intel.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "ankita@nvidia.com" <ankita@nvidia.com>, 
	"jpiotrowski@nvidia.com" <jpiotrowski@nvidia.com>, "kas@kernel.org" <kas@kernel.org>, 
	"Quigley, David" <david.quigley@intel.com>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, 
	"sathyanarayanan.kuppuswamy@linux.intel.com" <sathyanarayanan.kuppuswamy@linux.intel.com>, "Vivi, Rodrigo" <rodrigo.vivi@intel.com>, 
	"lukas@wunner.de" <lukas@wunner.de>, "suzuki.poulose@arm.com" <suzuki.poulose@arm.com>, 
	"ksinyuk@kernel.org" <ksinyuk@kernel.org>, "Fang, Peter" <peter.fang@intel.com>, 
	"sameo@meta.com" <sameo@meta.com>, "aik@amd.com" <aik@amd.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>, 
	"x86@kernel.org" <x86@kernel.org>, "qinkun@google.com" <qinkun@google.com>
Subject: Re: [PATCH RFC 20/20] attestation: Add the TDX family implementation
Message-ID: <atui5si5xs5px_Or@FV6GYCPJ69>
References: <20261015145053.3664509-1-jiri@resnulli.us>
 <20261015145053.3664509-21-jiri@resnulli.us>
 <ed52bb6d48c87ab8023bf2165cadffa259e21725.camel@intel.com>
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
In-Reply-To: <ed52bb6d48c87ab8023bf2165cadffa259e21725.camel@intel.com>

Fri, Oct 23, 2026 at 12:07:28AM +0200, rick.p.edgecombe@intel.com wrote:
>On Thu, 2026-10-15 at 16:50 +0200, Jiri Pirko wrote:
>> Connect the attestation family to the native TDX service. Expose
>> TDREPORT, Quote, MRTD and RTMR operations while preserving the existing
>> native interfaces.
>
>Along the lines of some of the other commenters I'm not clear on the benefits of
>the unified TD/VM attestation part of this.
>
>Especially when you talk about a TD report, it is pretty specific to TDX. So
>calling user code is going to need to know about TDX anyway. In fact the report

True. For this case, attestation subsystem creates just unified
transport: EVIDENCE_GET. Nice thing is that the same op can be used for
other evidence providing instances as well, like SPDM, armcca, tpm, etc.


>won't have all the details of the TD either. Going forward it's main function is
>to serve as a nonce transport blob and it only has TD details because of legacy
>constraints about SGX based attestation. So just a quirky TDX specific part of
>the flow on the way to get a quote.
>
>Can you help me connect the dots of why the unification for the TD/VM
>attestation helps us get to a wider attestation vision?
>
>
>One idea... Not sure on it. We are currently working on support for DICE based
>attestation for TDX. This is an industry standard and AFAIU other vendors will
>(want to?) support it too. Perhaps if we could have a single way to ask for for
>DICE based quote, it could make a cross vendor interface more useful? Callers
>could just call and get some standard format they can understand. It might take
>some work on the TDX side to ensure the DICE format quote.

Yes, that sounds useful and fits the proposed interface.

DEVICE_GET advertises the supported evidence formats, and callers select
one through EVIDENCE_GET. Providers implementing the same standardized
DICE evidence profile could advertise the same format identifier,
regardless of whether the underlying platform is TDX or something else:

EVIDENCE_GET(challenge=nonce,
             object[]={PRIMARY(<agreed-DICE-profile>)})

We would not need a separate DICE operation or provider family. TDX could
advertise this alongside its existing evidence formats.

Makes sense?

>
>Regarding the device attestation part of this, DaveJ (CCed) is exploring this
>currently and can share some findings in a bit.
