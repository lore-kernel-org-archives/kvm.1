Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795616401;
	b=0qg/omzplXdSTf6FR9u0oZiy+3HC2IssAcKC9FrpTeQDE79s5xffxlp9nSniD4tvhe0A
	 qT+757nSDejFvE2Iq9z7/1gLx+9klBVdImdQhy5YP0NXHMqszuR7+teFzrtrk6ibWBYNr
	 GdN4FFshGgb3X5iVePeiVz+J8NZKX8UGPIUaIwWV0qfaLGJvev/DUFLnbkECFogyYlMxf
	 CF5aJ1r6qeDtikglYh1b+EHfxZndy1GzdrK0QkzFAVJIKdLbdgC4Ta8RS136JCii9Mje7
	 wzRXV5NQ+6RlWoxlpLxS/fYht9PE+aR9ChlP5g0Arp2g4m0NeyubJpVHgcMkNdpENJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795616401;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=/sE+cARi5XYpGFmCaYKKwUnoyCBvBLnkQPGNB1SpCIw=;
	b=rN1A+g6aHZ1SJpwcS/q41XaDhyNp2Z4PwoYpw5S/tZmHQ+ARblx1OSLXgdA1v/KyafZp
	 of4kSCJGaxRfR911S/NGj5e8ICQfbMlBe++jiCNnKMPQXaQMmHioYwEUFlO3BoACPlWUj
	 /OdDuAve6VdyaZi8Yi5Z57T80KNf+l8Kq38RG2ZspMWisHD2AGx/gHFtaCLABMmyl1TYF
	 YC0+sJbca603ZAxQmkdfyaQC/2dKOZyQofoduqySuO/miNiaSVxTIJ88QMm9fsUjLSBOV
	 Ae7QEn6D+Zm9QIC8x4+64Q1KSBvWK2LYtsbrOru2XO032UKcYOHgIEkdw28he/EWXaA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=B+jz9sYU;
	arc=none smtp.remote-ip=209.85.221.182
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D54606A330
	for <kvm@vger.kernel.org>; Wed, 25 Nov 2026 14:20:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 41D54606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=B+jz9sYU
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-5ee3a3d281fso3720648e0c.3
        for <kvm@vger.kernel.org>; Wed, 25 Nov 2026 06:20:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1795616400; x=1796221200; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/sE+cARi5XYpGFmCaYKKwUnoyCBvBLnkQPGNB1SpCIw=;
        b=B+jz9sYU0bMSgYLF6SYO0ghpxNXX8P9tTs2sFW7yrBXotxK22OAClFOOlo+Ugd0Hef
         6ZOcx2k/VaxDbG4PXOUVjbWRS9eRQR03hLkMAd8ry6wSAAqtu4vZAwJwcRfUdAuszmA8
         CNzI3Ca7ozY3H4YMujsHSkcb84IjVt98TNL7TawrjMfj3/iocPF7lujJMIU/eutHyNdd
         1RNWbkVYvzY+yjFmiXvCTdMzZyeoQjsJWgU3fKFGxDD1PaIpQViqL90nmaPTbytWGQq4
         j6kd3sCHPGzYWyKe3vaOSjOWXg9PHZ1v3ePg9dLHCKj3jyAy0cVjaQ4tYfc3Lgqxk3kI
         UczQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795616400; x=1796221200;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/sE+cARi5XYpGFmCaYKKwUnoyCBvBLnkQPGNB1SpCIw=;
        b=Fo9R8yYcee3vShS6FEAi5Y/2XDznYJ/fQoOAd8+YSnQ3bu6s1C5LtA4KQXD3/dO0eG
         cSSwzUzawaSazM99MxGxqYxqV3a0uNPLVevjhq/V5kzKFd4E6P4ZR5NQ6Nwxe/JWoJAJ
         b5jWxSZZK2SZF18Ra1MPHjintKXy3OJysy/akXtxq3feX1Ha6EWm/HL3YtLUY4iIM/ts
         sfX50dz/eU7g8X8/tJOQeHUOlXyo80LO2H1NtnvgmV3GBEZG+R6GRrPoec2rlyru1Ece
         Es8lJ4fpFahbCESFOP9W534SQOfOgZ4+Kd9+vUW4P8O8qQlrzWs/P3FmAcnDJ5enqCZB
         Jewg==
X-Forwarded-Encrypted: i=1; AL+hErH8sQ4m6oc9MPOjAKNFQj8D1sgyxrIi3i2TJrs+skw3iXwz9uif5BT7q/OUNFLcGv4yMcg=@vger.kernel.org
X-Gm-Message-State: APuU4Z8SC6iJzjQRx9t1S6q7tl7Tg8kiGybTgnq1Oli17s5jEm/QJtRb
	GP2deRyaXyMEZD+8o+AtOv65MIbLR4ToVy9nU7z4uIte+VeNzrGJ+rhcEBGMFhR3EIDUVtXmIYO
	XeiFk
X-Gm-Gg: AZFdTZeL3z/8zhgL9DlFbQZtC+uTZYLfWZMu6zr8IWOw0WVDmMLB6VReMXSSDC016Ut
	gcclr3vaWMnoO7aitIraMh7UZ/PlCfFr/Q/xN1rn+kl0m01ECAWQQrXTtd5OyIO4Mc6qiLoXh2m
	plqaTN+VgzCczQ5lDNMxUGV16rcIKutTNW7vsAFxSFkVyxNSnzDxcTnUOFArRDiIZpWmdG8sR32
	qMO3NmRFTaE2nDkmSbpcLzWM6qNwWA3K1ZwLZSd3GQNJzyc3atdKmVgMjAdszgmOFlrlnkC8GxY
	Ooo4/XD+42umVkw00H3yODCII31o0Cz0BsArKwgo3oMBaJVTliBkqy8eCFzaTnPjuCBn66RjXmE
	EC5nnLpoOgwwSG/7c1wM0aiGv9uHLYi+HzBatTU/qFla458cEu5Xs8B9cnr4bxS27/hn+gZ9smq
	AqgseYw3FCjhQcKO6Ctw47ZWMnNRXyJA4y9dL9qX5iVuvrhRbE+UNWhWMavOOXNydVUZJAmLVhk
	773eDqnEyjWILm/5ZHfBwT8J7j2YURlblyhPXTAW0P2ro5JKQt6O5bdFcEfhC//3hhh1JJK9vnt
	xDbjYBKqFUbwW3nLTMQzU6fLBzo=
X-Received: by 2002:a05:622a:258b:b0:55d:3789:8c8e with SMTP id d75a77b69052e-55d769e11bamr337179531cf.15.1795616388597;
        Wed, 25 Nov 2026 06:19:48 -0800 (PST)
Received: from ziepe.ca ([142.177.118.84])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-55d7889f8absm153708121cf.27.2026.11.25.06.19.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 06:19:48 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xWDqd-00000001jay-2IOg;
	Wed, 25 Nov 2026 10:19:47 -0400
Date: Wed, 25 Nov 2026 10:19:47 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: Alexey Kardashevskiy <aik@amd.com>, linux-coco@lists.linux.dev,
	Dan Williams <djbw@kernel.org>, Leon Romanovsky <leon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Lukas Wunner <lukas@wunner.de>, Ashish Kalra <ashish.kalra@amd.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	driver-core@lists.linux.dev, linux-pci@vger.kernel.org,
	kvm@vger.kernel.org, patches@lists.linux.dev
Subject: Re: [PATCH v1 04/10] PCI/TSM: Defer TSM vDEVICE allocation until
 device setup completes
Message-ID: <20261125141947.GD246011@ziepe.ca>
References: <20261123083337.2731019-1-aneesh.kumar@kernel.org>
 <20261123083337.2731019-5-aneesh.kumar@kernel.org>
 <5e04323f-dfdc-4956-acee-bcc09926726d@amd.com>
 <yq5aqzg99uio.fsf@kernel.org>
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
In-Reply-To: <yq5aqzg99uio.fsf@kernel.org>

On Wed, Nov 25, 2026 at 02:07:19PM +0530, Aneesh Kumar K.V wrote:

> That is what this patch does. If IDE setup is not complete but the
> device already has tsm0 attached and connected, pci_tsm_context_get()
> returns an error from cca_vdevice_init(), preventing the device from
> being assigned to the VM.

If the device has not been fully accepted on the SPDM side then you
should not be able to create an iommufd vdevice for it, nothing else.

Jason
