Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794267781;
	b=IRL0Rlm2qmyHIkG3P9is7My6Yw6FSBJqGsVt0iIYnJmfr+0sc3Z1U/IJQ0B8GhtT8uUP
	 KqDtsTJg53QqzrpQi+xXebMto5xD8UjS8hcCMMqsNTfVOlcMn9HpwZQkDoyPdCw/QhmXE
	 prrclvvBHSd6WW5owWwKbXYenORFN+qaHOeKRCgQ0Sfjlfun3+V6+nABi/J8dxOMhCbmZ
	 d8U/4eKWixBPkewuGEWgSoe+OT4HNO80OO3b8IZAy8Y8xZhBvJ9GncoPu2A+Y5qlpZW5/
	 ChfgaxuhWJvmDowgbEgzQAANa+A1i6i3oPUfDKay7bm2QHRY9BC7eS7Qn5GrvO1Qhpw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794267781;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=sa2+WBgF5hKTZoECa+jNwUyW/NRKAyVaKXS151Xizdw=;
	b=PFMSj/JCkyIBKaYbiZayXtXtg7JCTRhAN2ZOX4fysU9d5OQGUoxg7SiN+vp4muGM1w0H
	 TAEc8OqXog64ry5aKbdQaUrxnLMzBxgc2stmJQiSXSu8ewoXdP2pZfx1HB9HHG6vqR4O7
	 spPnibGkD3svj9CBR+C9SOgAPc0w/ptTwi5kS7VRvekB8A/hIYXrQL13RC4UtyJBWgaRI
	 aYdYYANg0/SnqIVgTXyYOrDaRAKt2m8YAyP8UBSGFtxDkrT3VCrdVPf412qKB0+oKGrpf
	 XqYNloevZvs9zC8Hjb+yORahHCenh0KIdZ/2I60oWO65xbckVUUXqpZPBcd8X0g84IA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	arc=none smtp.remote-ip=209.85.222.170
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A36E1606A31C
	for <kvm@vger.kernel.org>; Mon,  9 Nov 2026 23:42:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A36E1606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-93cc1ab5f6cso180010985a.0
        for <kvm@vger.kernel.org>; Mon, 09 Nov 2026 15:42:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1794267774; x=1794872574; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=sa2+WBgF5hKTZoECa+jNwUyW/NRKAyVaKXS151Xizdw=;
        b=eyKmq1RFBX1cY34faaTMzv+/jmqnlovGkEDQpCZQqhyzSEO/Mh4Ah+2/XemgZcilwx
         r7QXK4z9UnKSByvGCN92EOz4EBespGnJaamquIv7w1SsCgShVQQfMrfnlYV1tEgeK6HV
         2B5o8kdrBIYe6QPc5lyMukLOCQdNn6gBE55kDgEvfddkM7zX4OUho5lEDRsvrmLP0Q1i
         PpB05POLoChpg3yyFe9/zbzhb6mjvSg4kazE7vfNzIkd3uTssiSXOj0qE/K00STYbiNd
         x+UX5n2+IWg0I+ugcD6ZhpacgkAm95jl9HqxBcjjLp/HHNC4nBc2R1vdlwOg2DeM5YRn
         58bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794267774; x=1794872574;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=sa2+WBgF5hKTZoECa+jNwUyW/NRKAyVaKXS151Xizdw=;
        b=R1vEPw09OrIG3wioO2y6uK1DFdODXg4AR8UoMAwHtDXCJflllO3+44BImsWrqf05cn
         Kv9uyaW4bjC899hiUf481PY2yknKzkriq8/lWw123JiwoVL+VTMTOwzNGcVNYWu3gG6l
         3YcN8GmzqhSataGqXHUNMsqJ92aUoXqSfdYfZk8LeeE7Z5MgZ2bNec1jpcddosNHCBbx
         Oqkpzt8i8sXbxFa9zNlZA8wMWk+k4UHkPASDMZYkFhQBLUMC+FdyKUG4ZjxVgSvT7oGf
         YtIJFNAS0nbdQTwbHSZnVLBLIoDKnoJrVr40nDobla5I0zNCQYSaJzmuTINTxPsV/EN5
         tqag==
X-Forwarded-Encrypted: i=1; AL+hErHyX0N3zUThsk9SlPqvRCAemEba0banbTMkSTXV1V+rXREExhuB+OuEh93RcdvnPi9mFXI=@vger.kernel.org
X-Gm-Message-State: APuU4Z8BHS15jFhjPMmZhKoDXrkVbdDbrb/5xq02V4iNT6xujr12+69g
	W1UmvL5zKfOkLlN6VWdSz+tsJZD5/yoUfQzMXbUOBZDF8Prcbsg/yps/M3/pi/hRdyQ=
X-Gm-Gg: AYBFou0WehcOrQbgl2HA+taqPnwZB8LpnE7WW7lnk0xZbWvMl6pOZpH7R8klSqdB7u+
	UJlj1WMI/evOu0rADUlKwwNwzFr/QELRFQbcNHof4VKOdw2T6qcsKdizyn0zg31ZClFh+51BOXr
	Uj1p0BPFZfl3P3PwolcyKXAs8EK2IhrcSd6ggY4c0jt5pNl3Cqz30CVGnqZcuy61ayTtPH+Z5Vi
	FnytM+GxJ2qb8H4Zg/QS0YpetPp2ynD74lmQwmKinx9nRUSQAXlFceTjZb4v4R/B65gphTgz9lU
	75ArkMTh8ntS0hU5e/YzDBfoRHyxCzIddQWZcFQ+PPT0lz2lp2Br86wDXJ45FE4n5VOex6NAbT0
	Tcg5b51YUthFz9JZ5TIpzs2wzsgrD//iaYqfvzHgjlqRr+ctVahb6kche34A5q/SCpEGQZns2X+
	LafBzLinSQHCe+o6UXDwSvSQyZtMf5qTnmB9QgUouKX0cqBnf72Pr8817wytMuZOJw3uAixafJO
	vAbpJfDNh8U3VfsGN3AVFC1MLqSIvqYyzB6M7XUbC9WYpP5MEGpgQmlCTbdjzM1Rq2aHVQHC2jq
	a/G7NEZq//3NhJFG83oXjkHTcTN8qLZaVw9wygcyqPST23pk/AHzcRfW/r5+KF9eXlC04LJmeqT
	QsfvdMbq8Dg==
X-Received: by 2002:a05:620a:2725:b0:93f:4cfb:2a8a with SMTP id af79cd13be357-9479f2fa688mr176463985a.26.1794267774479;
        Mon, 09 Nov 2026 15:42:54 -0800 (PST)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9479e784b90sm91815285a.22.2026.11.09.15.42.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 15:42:53 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xQZ0m-000000033Ka-0GQE;
	Mon, 09 Nov 2026 19:42:52 -0400
Date: Mon, 9 Nov 2026 19:42:52 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc: "Fang, Peter" <peter.fang@intel.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"drdeeglaze@gmail.com" <drdeeglaze@gmail.com>,
	"James.Bottomley@hansenpartnership.com" <James.Bottomley@hansenpartnership.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"Xing, Cedric" <cedric.xing@intel.com>,
	"alistair.francis@wdc.com" <alistair.francis@wdc.com>,
	"linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
	"Reshetova, Elena" <elena.reshetova@intel.com>,
	"ankita@nvidia.com" <ankita@nvidia.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"jiri@resnulli.us" <jiri@resnulli.us>,
	"kas@kernel.org" <kas@kernel.org>,
	"Jiang, Dave" <dave.jiang@intel.com>,
	"Quigley, David" <david.quigley@intel.com>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"qinkun@google.com" <qinkun@google.com>,
	"jpiotrowski@nvidia.com" <jpiotrowski@nvidia.com>,
	"suzuki.poulose@arm.com" <suzuki.poulose@arm.com>,
	"lukas@wunner.de" <lukas@wunner.de>,
	"Vivi, Rodrigo" <rodrigo.vivi@intel.com>,
	"jic23@kernel.org" <jic23@kernel.org>,
	"ksinyuk@kernel.org" <ksinyuk@kernel.org>,
	"sameo@meta.com" <sameo@meta.com>, "aik@amd.com" <aik@amd.com>,
	"sathyanarayanan.kuppuswamy@linux.intel.com" <sathyanarayanan.kuppuswamy@linux.intel.com>,
	"pgonda@google.com" <pgonda@google.com>,
	"x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH RFC 20/20] attestation: Add the TDX family implementation
Message-ID: <20261109234252.GR663069@ziepe.ca>
References: <20261015145053.3664509-21-jiri@resnulli.us>
 <ed52bb6d48c87ab8023bf2165cadffa259e21725.camel@intel.com>
 <20261023141218.GD3977851@ziepe.ca>
 <343e4a12f2fdbb4e9a19c4afe49cf2b8908d6739.camel@intel.com>
 <20261023220030.GM3977851@ziepe.ca>
 <7843a833723e3aad40f8fc4de3a83f5a5059280f.camel@intel.com>
 <20261103005851.GH3889730@ziepe.ca>
 <au5LCE1jau0yDo5S@intel.com>
 <20261109171236.GP663069@ziepe.ca>
 <cbef9bda9241ffe98652172edb67fab3eb1c35ee.camel@intel.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cbef9bda9241ffe98652172edb67fab3eb1c35ee.camel@intel.com>

On Mon, Nov 09, 2026 at 11:20:22PM +0000, Edgecombe, Rick P wrote:
> On Mon, 2026-11-09 at 13:12 -0400, Jason Gunthorpe wrote:
> > I would be very happy if Intel came with some plan, documented in the
> > ABI comments around their labels down the road.
> > 
> > What I would like is that given a specific label any userspace can do
> > a verification and full dump of that data, including signature
> > validation, without need of any further external information.
> > 
> > Ie it is entirely self describing under that label.
> > 
> > So if someone has to say externally 'oh this was a legacy VM' to make
> > parsing work then that needs to go in the label.
> > 
> > Think of it this way, you should be able to run a command, lets imagine:
> > 
> > $ attestctl dump report0
> >    intel TDX A:
> >      - Field 1
> >      - Field 2
> >    Signature VALID
> >    Certificate chain
> >       A
> >       B
> >       C
> > 
> > It must not be something like:
> > 
> > $ attestctl dump report0 --kind tdx_legacy
> > $ attestctl dump report0 --kind tdx_dice
> > 
> > Does it make sense?
> > 
> > Whatever labeling you choose has to follow these goals, and there is
> > some trade off between making thing self describing forever into the
> > future and exposing protocol details into the guest kernel driver.
> > 
> > The future scares me so I would always design to include a description
> > of the blob from TDX module to the guest driver :)
> 
> So we have this SGX based quote format that is fixed because it already exists
> in the wild. Going forward we are moving to DICE, but that is a standard format.
> So also somewhat fixed. I guess the question is: is there some combo of bits in
> each blob we could check that could deterministically distinguish between the
> two? To do this we would need to analyze the quote formats.

You guys really didn't make it discoverable when you added DICE? :( :(

> If there isn't, I'm not sure what we could do at this point. There is a library
> Intel publishes (right Peter?) that can verify the quotes. I'd guess it must
> have some way to distinguish between the two. Can you check how it does it
> Peter?

See this is exactly what I'm talking about, I don't want to repeatedly
get into this situation down the road over the next decade.

> Another option would be to teach the whole stack to request specific
> quotes types from the guest. Then this new component could only
> request DICE and never be surprised by SGX quotes.

Is that an existing option? It seems OK?

Jason
