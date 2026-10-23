Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792782054;
	b=np1Z7/NFB5Fgq/uvWcAykrQBkG6l82VbpArGLG8h42fxDLalSyqAnXfcDVS63mVSmyKv
	 AeFnQCOiCz50+SvRzbYcpt6SgqTyx13A35XLF+9JZ3d4CeOOJfnoY8GpDJCgVmDEVQuBj
	 n8IzJaLDtqA2g1iCFBwy01HbvOb4on5hbwNVtOOiLS2SEtwYC6Va57PqPv+FxFot+/wze
	 g70V0u71KQTYw6eCyRXC2kp5pZmNUwYo4UrIPRvngaZXxKC6sijnkhIcmDKkxHTsyTjB/
	 zAfZXlG9z4f0bfORhNWzkW488W8ae2tM70SN6pYOyAaHlgyJqDk1xHl5xw7lrEcPzRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792782054;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=5tf4s8d8+MZT/ng3kYJALwtT1EAbBRaxelT7QvlTQng=;
	b=jHUWkG5x/0KeUyHTNjXxrgf1IkiOgqdLiO3GzPwVOd5JU9K9yeP79uvPpoOasm7rGBEJ
	 7tTRzF1KQ1pPej0RDkwPg/0YxvdYKKBJmgekmFA4nqPPSg0ZPUH2EpbMTP2pVZmGGqbUH
	 5lDtXQde8SaPQek0EIZegE2C2t5bLB13vBkBN9HBpv+D4ExRtUFnEeka7BiEnmsTUrWR/
	 ieDQEqNH2wC4FrcrT2sZGPu9U9VH965TbE8Y4fRpp1Lfr+cCe+3vpxoNJyWjeAfKo+Bi+
	 ppwNXF1d6MLJENzG2sDJg+I8OmdRT9mJdAqaCIR4JNrjxg8kuB8WJW0f84dy6B0vSfA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=bzc4Cg9j;
	arc=none smtp.remote-ip=209.85.160.178
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE7A8606A325
	for <kvm@vger.kernel.org>; Fri, 23 Oct 2026 19:00:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EE7A8606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=bzc4Cg9j
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-53397554beaso12640421cf.3
        for <kvm@vger.kernel.org>; Fri, 23 Oct 2026 12:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1792782039; x=1793386839; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5tf4s8d8+MZT/ng3kYJALwtT1EAbBRaxelT7QvlTQng=;
        b=bzc4Cg9jHc+EwZ+EF2GHA00SaE7XNzyRJ2jPm8VaHgqzKDLrehIHY+5e8wqB1yH17y
         sndSYk22aMmceP9P1fMLTu0Z4V8EzlM2RGsFmTw4gK3j741dLn2NCvrwBRx9Zs2Y9Nrl
         IH1Flz0MwkfAlUgvicHD3GXb1HCVFF/PCxVAEn/OVSguv9eR9Zs++ljRZWXpHTqI+xAr
         rfcFCA7qmIwN9IxX9GeYG2HRZ3YRwMSM0MH1BmgGZbTGcamONR+rAGI29PTmp5avInXD
         sAUAnL9pEXhpYTml9nJyCuJ6EjWQTeYXwbhCn5SvYnMgGcHEU9aguEL9UamXbiSuNSk7
         hQSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792782039; x=1793386839;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5tf4s8d8+MZT/ng3kYJALwtT1EAbBRaxelT7QvlTQng=;
        b=jHC2Mw797MHy8Q1Sp5rMMf/waFauhbNLIRfFmiQ/JORDayB//0Czp/1MmW9/ZebUKN
         MLsjMOA6EPKwjbUSV1GZKEZ3AB5fDdoDLwB7ukp4uL4LjUQeJFDLHJuRFU9bCP2vsyVe
         o8k7pL0e4XAQTrEQfG9tTASevHKRhY2gbVYFECLpJJKNFq7yQWCZzr4oXcOq4p0LnboN
         T3ljq/PLaPOjBXJo3xvclE+jgckp2nOaMfiVOfy5VCfmC15RDdCtBGRf+y8P5JFBvbTn
         NNWHKdU4gM25scsDbB7ChvlCGc0JMlR7VVCjpcTJyrPOO89cAItQ6mNG65selguaLa9k
         XCLQ==
X-Forwarded-Encrypted: i=1; AKwUvBwmrTUaGrTqlDPmS2wD6dK6zB1wzyh61RVnsHWXm1dRiLw4Us0J5vVP3gXiAnD/VzXnbrw=@vger.kernel.org
X-Gm-Message-State: AFq9FYKRlwwZM/91BXHmo6vjvklvBH2OHRfqCFL6cwKh/mXcshzvCqPi
	QRtkNdwUEhAb8iiHmFKf1yjmrrlPOHZjVYJKJ9Bitoe1pr+WyXPgiSAwGz3y66VZrJM=
X-Gm-Gg: AYBFou3yPXgGXBDZpOtBr1/dW1Xcq+av0WBhdfQ9WFK3f4lND2RRlI1/LHYcK1cdT+n
	N1o/LGWQjGmqk0fy4kEuwXWg75V1RT+/h5zYwpflgH39CD3q63cVdUCqbYbWvhlg5KFpxG9lyEe
	HsgHJIJ4DnSR16w9KNLvi63RvG2iuVuPj0N+AjOgk6u8bSxtTwuvvEem0uyto5W6qaOY3BxHGkV
	NwkXtOT/bFJbNDaivPGlFt/VzkrGFHAgxvSv9o3y0RmNgzwY1HLbT0c4jKxyPhOZV2wT3CQCGyk
	RAEFLBI6r5F7deAdPw5NHq8F6JxF1MmWCBGBQi/qzXFA4nMP1j8tPRQ/kyvPOyJuFtiKmIzVQl4
	FdnjjPvaui1Y+1oxNiyNWJ5wH2XVkudDIpnC39K1pBl3DYARJwb6pIiop/n6Xji/+ehmGx7c1JB
	8veUf++AZS91oN1nUGzPQbOZ6m6n9oyB+kJawSKQARnr7sFjTqvnCd8BHTwILptnw3SKolei4Ul
	ogK5tpiYx4PQaUWIibKUk7mjmrMnNz2Yhj7NX/Mtam4MblWrOj3FX6UR6G3lAAPfQNR9mK9Hvmn
	P3VFhss8axhZESDjAcArugz7hnZW5LTP20Yi3g==
X-Received: by 2002:ac8:5d8e:0:b0:535:a5f9:7520 with SMTP id d75a77b69052e-536c26e2168mr47897061cf.63.1792782038589;
        Fri, 23 Oct 2026 12:00:38 -0700 (PDT)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-53839709ed6sm1185741cf.16.2026.10.23.12.00.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 12:00:37 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xKKVI-0000000GxzN-4BG5;
	Fri, 23 Oct 2026 16:00:36 -0300
Date: Fri, 23 Oct 2026 16:00:36 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Leon Romanovsky <leon@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
	Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, iommu@lists.linux.dev,
	Tushar Dave <tdave@nvidia.com>, linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
	linux-rdma@vger.kernel.org, kvm@vger.kernel.org,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jens Axboe <axboe@kernel.dk>, Alex Williamson <alex@shazbot.org>,
	Ankit Agrawal <ankita@nvidia.com>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Sumit Semwal <sumit.semwal@linaro.org>
Subject: Re: [PATCH v9 02/18] PCI/P2PDMA: Derive routing from directional ACS
 controls
Message-ID: <20261023190036.GL3977851@ziepe.ca>
References: <20261023155914.GK3977851@ziepe.ca>
 <20261023182715.GA2798722@bhelgaas>
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
In-Reply-To: <20261023182715.GA2798722@bhelgaas>

On Fri, Oct 23, 2026 at 01:27:15PM -0500, Bjorn Helgaas wrote:

> > Yes, the ACS combination is selected to avoid ordering issues
> 
> Does a user have any way to know whether the configuration is safe?

No, unfortunately in PCIe so much is really difficult when it comes to
deployment :(

> I'm wondering whether users might use "pci=config_acs=" to configure
> ACS so things appear to work as they prefer but may not provide the
> ordering guarantees drivers depend on.

I imagine that could happen, but on most practical systems the root
complex will blow up if you do asymmetric routing so there is an early
indication.

I know this because I've help debug such configurations at
customers. Some servers helpfully MCE if you do this. Lovely.

> If that's a possibility, do we have any notes in dmesg that we are
> depending on fabric behavior that the OS can't discover and verify?

Maybe, it could be interesting if the P2P logic found asymetric paths
it refuses to permit it.

Jason
