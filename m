Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795616245;
	b=FACdDv1zdK30fPA8rWlewQD7r6/SioIeGuUYvM2BJxKXbDL8sy7cUvNeEC3aOBjF85fk
	 qIHbsPtnEhs9gCX05ZDrLUB1vsuBBcZlebTLILi0tLi68/oE5NSpO4+pGckj4DvWcp3TU
	 5sXQX51b0nwLo+j9Acro1Q//GkN6IOu/PWlo3HKUO0iwYsHiZOib3lBOP3bKO9wJcLTw9
	 /FHpSgxsRT07ASL/c6pbwPUtNF62WQ3C/TpbUr+eOnhTwqCgDdOp11RKb3TXU14uOsrMq
	 xKOo3IvmUPEz0oS++2jHe1YLIsFYPhjlN/LiqwrOtQ0jYngxt/qdw6CZ04MouNIxc2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795616245;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=82OlthbTcf764s1+nsFlIqp1XEt+X8IqMsOwsuhDROg=;
	b=Lr7C4X08yo7f1spIdIlRvq4dsXNakUSop/kG5gEdhyQiT5PB7YuQR6zcY/gYIuxsbN8Q
	 EEtozW1LpnSDMAGftfJAwOzNoIXMISwNvvhchsNeHAD50HJGm5U021oz5tPPBAdfWG6sV
	 ErN28Sd8vX33bECK/g0dgeV3Gj4cfZWNOQfaVDJhXd106f+HHUKOJEdb/AaGLVRcM9J8w
	 osHJDyX0ie/GPugSd0uOeYubi7obc3n/GfnTSp+PKi+tEaDEXPlRLwo12tnJOe2XV7tiK
	 z/xtIRNJgUu1uIchb37hwUcCKWIPSRxuA/z+LD+/1YMtEPY+p2eb+Icz5on5M5NvtOQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=KddeLS9u;
	arc=none smtp.remote-ip=209.85.217.48
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E394606A334
	for <kvm@vger.kernel.org>; Wed, 25 Nov 2026 14:17:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9E394606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=KddeLS9u
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-7d2ccd3c7a2so1970526137.0
        for <kvm@vger.kernel.org>; Wed, 25 Nov 2026 06:17:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1795616243; x=1796221043; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=82OlthbTcf764s1+nsFlIqp1XEt+X8IqMsOwsuhDROg=;
        b=KddeLS9up5mvCSfJdm5fK0ipO+yq095aye9y0p15L5JlAkHX9DbgwuDUdNKrNobXeB
         nqywtiZOYZsmjds/xQ4YRmxPnBA6MGWE4xP/x1WhKA0FewNf9h46pShomX2MqJEHuRtx
         sDx/VduWtpKHevJG9BFB7vgzn32UYgg6eiQx+tH8x8enfIcrvbbbAmCxCqB+39SEMmUC
         eoaSSQTrh+qgfxGrkl+Nwrzq77nIJbhYmqENWe0H4pKcRbobW4NpCvi7EYIdlPbIGPq2
         9vhJx8Bk3mUMIfBjdgNn8cXW4vdOBRiSKwhHAo/pBNkTzu8RfbN0fKu22t7cZ+jFV0nA
         mVjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795616243; x=1796221043;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=82OlthbTcf764s1+nsFlIqp1XEt+X8IqMsOwsuhDROg=;
        b=T8fVfGLylwxPTRAZm7sn8UkcDbPKLc4wdQJGlisfMZxXd4OzeVBzsTvrkcEf8G5oLA
         x0lD8kdq62eg7qQMPmp8OPkANvwhjN/Yw8tvf+s+mJ4swtrWyCFHzoe+ZINDbmOqiXD6
         u7iDPEc7RqAGIB7XJ/4a5urjYX9sU6l6XzyLSScACcK9Vwt14g35ME6RmQxW7b/HLiCy
         Ne4n+fY+RVgRkG00XItYAYgbmDcQXoKvq2AA3HFK1Zck1XZA+KOwqsr64Qc9UIH0yilf
         sVoOke78aqabX4Z8QAjMGKM2Qlag/4bRqluV42PIb29II9EVeQR1EK7zY8NXz1Eo/3xj
         aECg==
X-Forwarded-Encrypted: i=1; AL+hErH1F61C7tfuZSqfGQ+j58VDMRPH0aX2pT+ru2BTK7BgUYzn04mYDGPCqDqgN2bXrVqKS2g=@vger.kernel.org
X-Gm-Message-State: APuU4Z/tSAjiG+7f9xxequl3C8J8uLAYPrXoZL0vmzEA7TDOIOXXiVXe
	iCiT1hZtRsv5Ck8KdE7uA3rIKuqDW0sE5v5ydl+LlXOBpBVMsuNPvzqijJ1xxTS4h8U=
X-Gm-Gg: AZFdTZfZ7nq/MghXE2Chu6EPxtpyBylFnrh41C7ErYcTZaMBx7VbQwd/p6lE9qWSHyW
	7A4HiZ4pJ2hw6y2xniOBBoymRbOJ9ynJEYxWAfKE8j2WvMNodSe2iWyJYVU6QYK0QOZumDB8PuG
	/ieJcAaXkzk3vzhNsxJ1P/S4D384qN4Ivh+yaABTvCA2uPWHP9/ChDqGFqJEFbs5EpMa1Njx+jG
	4dJulNuHSrizHAhQz5gyf/CldlwnYD4eupA1+yKIDprcLOltKimE5sExxpBqg65d8EtgcZM3I6+
	L50aLXl0XnKB3nsy4Fed/9hT0FZFAjDq1YPyZg08sNrCqxFyAT0jQgsENF+m0fZj5OuLlw8Annt
	MP6njB/2pOKGYwHnUiunlhtjxmldVfIoTjoZbx7cbF0r68IELW0eHbACvirxxicG2GyLAeNIXB7
	/B3yX+q3AfZXJr8iMCwIGFij6UCKqEy8kG0aGwcoGQVp23LCelg31KxfXDKcqgSi3dZHRRnco++
	ZVK7nnlFtTdF43OCQLnDhOWk7X1aL5OczdHQU447fsh4q/P1WZVkdC4ItJCpSRBk9YwR699W9t5
	LVCeHg==
X-Received: by 2002:a05:6102:374c:b0:7c1:75c5:c4c with SMTP id ada2fe7eead31-7d739570939mr8150077137.25.1795616243315;
        Wed, 25 Nov 2026 06:17:23 -0800 (PST)
Received: from ziepe.ca ([142.177.118.84])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-921645f50f3sm60805116d6.24.2026.11.25.06.17.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 06:17:22 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xWDoI-00000001jMI-14hV;
	Wed, 25 Nov 2026 10:17:22 -0400
Date: Wed, 25 Nov 2026 10:17:22 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Alexey Kardashevskiy <aik@amd.com>
Cc: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	linux-coco@lists.linux.dev, Dan Williams <djbw@kernel.org>,
	Leon Romanovsky <leon@kernel.org>,
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
Subject: Re: [PATCH v1 02/10] coco: tsm: Register the TSM class before device
 drivers
Message-ID: <20261125141722.GB246011@ziepe.ca>
References: <20261123083337.2731019-1-aneesh.kumar@kernel.org>
 <20261123083337.2731019-3-aneesh.kumar@kernel.org>
 <20261123152903.GG179082@ziepe.ca>
 <9f92f7ed-5198-45aa-9cef-515ccbf98398@amd.com>
 <20261124170754.GB114530@ziepe.ca>
 <17ee3598-9cc3-45d8-b068-31fafa06268a@amd.com>
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
In-Reply-To: <17ee3598-9cc3-45d8-b068-31fafa06268a@amd.com>

On Wed, Nov 25, 2026 at 02:34:38PM +1100, Alexey Kardashevskiy wrote:
> On 25/11/26 04:07, Jason Gunthorpe wrote:
> > On Tue, Nov 24, 2026 at 11:40:16AM +1100, Alexey Kardashevskiy wrote:
> > > On 24/11/26 02:29, Jason Gunthorpe wrote:
> > > > On Mon, Nov 23, 2026 at 02:03:29PM +0530, Aneesh Kumar K.V (Arm) wrote:
> > > > > Register the built-in TSM class with subsys_initcall() so it exists
> > > > > before a platform TSM driver probes, independently of object link order.
> > > > > CONFIG_TSM is boolean; remove the unused module exit path.
> > > > 
> > > > Why isn't it modular? This is going to force alot of stuff to be
> > > > non-modular.
> > > 
> > > The TSM core registers a class. The platform TSM drivers register
> > > TSM devices of that class. If a platform module loads before the TSM
> > > code - the class is not registered yet so it fails. We could either
> > > teach modprobe or have dependencies in the module or do this:
> > 
> > I understand that and Aneesh's patch is fine to solve that problem.
> > 
> > I'm asking why it isn't modular. They don't conflict, using
> > subsys_initcall works just fine as a module.
> 
> it "works" because it is module_init() in include/linux/module.h:
> 
> #ifndef MODULE
> #else /* MODULE */
> [...]
> #define subsys_initcall(fn)             module_init(fn)
> 
> and then the dependency problem again. Do I miss something?

What have you done to make that a "dependency problem"

The module loader chases the symbol graph and orders the module_init
calls based on a depth first ordering of the graph.

How do you get things out of order in that world?

Jason
