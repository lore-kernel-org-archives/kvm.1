Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795447746;
	b=KuclOaNIjrGR3RFyTeDS2nuCIu0WDZM4fg3HVI8eg721Ukg9WJTrJShKM7Oy73rZ8DNv
	 i+ckw2WtgFMLI1Il46NicMAV8kJFjA4rjSDR1FZi31m3FujQ/sx6jaEXZuzymR5cWQM98
	 Uf5QI5uOYRgx6oWEDSYkpz8HfvF2B0jPdbo8Tbi1UWeqe6WEdIofBpHTJguGwKvn22WC3
	 J4BGTdUdAd7tmUG3MA7n5bp+GWYAAoNjzDqy5Tg0zwcthPR3IH5mS8xqWqZUe7I6XGS62
	 ujkHdGnvx1DDBa7gbAOlz+MQZ8gDImh0psfhKyAOjWzV9qdB50B0oz14sQgMr9S4UkQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795447746;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=kjgFR4G5OQ9juZKj9Y5T78qgRaR4MXSjWG7XFR0Z19k=;
	b=0GA4Y9BNkrXnegSFPNrOI910VLlr5LWBT7t8lEEbL3zarzo0nyowzSWQzMH76b0anW1t
	 YDBuMaeJEcZabL83cAFjE1Xiue4tn8FZF73SgsJhB3IKTHOh2y7ximWRHF6jGWtvn13m8
	 cZtjo5dRDjvqMAiR6/EeQKT15+ej6XSbAguvCbzb0bMopJJJ1LF5U+lNl/Rk8OOaxGRiB
	 hL4LUIGKZ6IIdzsa6ZS2Ypok3bIqy1qabFziJBetm/2/E+bhiRe+K+YLQQuhW/4zPMDAk
	 mtJEmqi6aLcpymZyhYlEI0ZTZfWANryvZx8yXB1Yaz2mlJhIZ68qaC0PRCvf7NVb+Aw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b="L+3W6G/j";
	arc=none smtp.remote-ip=209.85.160.173
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6EE3606A321
	for <kvm@vger.kernel.org>; Mon, 23 Nov 2026 15:29:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B6EE3606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=L+3W6G/j
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-55c5b6584ceso26246811cf.2
        for <kvm@vger.kernel.org>; Mon, 23 Nov 2026 07:29:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1795447745; x=1796052545; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kjgFR4G5OQ9juZKj9Y5T78qgRaR4MXSjWG7XFR0Z19k=;
        b=L+3W6G/jOieQwzovuItfiAb5E7wRlUzxvnY+TwLXW1TGcYLkGAT3dH349mSfYhTsXk
         zbsoYNQ9g5VSeDG0hJaG8NSDcl0v7cwqD/7gSneWRdiEe3Q7Uv/R62oODEeZAEZh5fH4
         M8q5GGvjxr53CkrzQ9u8lqCPq5CdUrrN/9YhV7JAFVqI1GZTWqm7oCRU9rRW1+MzaoJ0
         7ucaBJIe7+9jSb7SNOACX7FaWWgS7cA66st2sIa9Kn0p89KtjQVkXQ+jmQEzIwUgruls
         heM9s7fROApxP1jhLYMDO2bIH1TyWS94PkAGXKtuJ7DFJ2FRS5sctF9J54yzhWX//5GF
         4tmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795447745; x=1796052545;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kjgFR4G5OQ9juZKj9Y5T78qgRaR4MXSjWG7XFR0Z19k=;
        b=z0b+sc/t+xZdaPoVQIZ+XT0hMO5eS88bsunKwgMvOvPaAnBEa8gi/WH8W4cXc5dxbh
         qzf90zHPCpHH0vp4r1usfZ4htNNDbXsQV8z2uGaLBxV3N0nb58FNx2Yn0s5Dtr2RszYO
         hFA/xa20t7aasJ7fBzG5dl6sxgd3hxmpg8ln4z8/k/nrIlajCiWygbWUDA/i8eNA5sHX
         cRQwD99zr6lETWAGfHBpA/z3Visrh6lnkpd1RaUPWLlidht/eQYeymBknz6uvcLB5fiw
         ozgVPPnnu8cpQqkD3cDuQBWANHWvmcFgytusOhkKWSfbWe4aoYxX4d9uMQMrZQq0t440
         pahA==
X-Forwarded-Encrypted: i=1; AL+hErHi88SzIoTWVsH464t5Ut+f4lHMKsDzdcjjQ47Q7V44KxbPbZj0nSV3gv5G4LwXGFiBkCg=@vger.kernel.org
X-Gm-Message-State: APuU4Z+7maQstxgVb2MEWq7eGrMkdghF1cQDczLDfAz5paIDM/Y6D0iH
	8p5bVqBXXt7b2pLD22K/NEgFbgPY326IPM9kZhTB2sn6p+gNrlXwt6ZiXKrtXo1Atak=
X-Gm-Gg: AZFdTZfbUuEI1fHHG0VMae0XEiap+OAMXqBXXjErEMakCxK6KHAQV7Nif3ZLzogCZKF
	yr1+ICkZ+wk4K2FzgZWjFR8mjvXfFxc/0IhwWseC+dNbZ+P7M4YBv8R8eJMr7krY7AtfLO2qtMu
	WweIs1uj6lbLfulnWK7PhoiIVuRb/+/0EvHAvwZosDzRsv3Rmv6+UHWU/jjCtE/4BVT4H06nFuA
	RzjJT6zFWEwmeBOzjuRKoFgafQ7HhsatMQh9VnN9RH2Y51USXN5QJHGKSv5J/Vu+XhA14UNdnFe
	so0Gm7Ah3g4kNhk5D8VxnwuapHPmaQ+9aZvLvSS8EiNHHB/IoHH60vIu0etz0fGUgGa6jMxK6v+
	07RW4Ysi2yusM3ZcWXe8jmDbQD8TXKewx5S/wBrnSsDppLRmLkboqfzTmpvhP8TTGsDLXcH3NP5
	UhpKVx+Uga31qn8ISiQkaVwPpoNIz+pyj9XD0B8EMp/61mFyoEeGSwaPwZIAumh7sMR+sqi3gxc
	pWctjVgzm7/b+8HWmeqMpUz+XPBgmvwg/fqFkj1fUC36qSd/9jjondJ1hK97Ogt4XpTUxYXD6EL
	y3H6xW25OnXPaBwTvDdqp0ytHB6oX31qIcwrmVxtpNg85kcaJWP7qlXn+dRAa/Q9UpUEgPO6m2g
	MqYQ=
X-Received: by 2002:a05:622a:248c:b0:55d:3350:d270 with SMTP id d75a77b69052e-55d769f5705mr226617451cf.35.1795447744614;
        Mon, 23 Nov 2026 07:29:04 -0800 (PST)
Received: from ziepe.ca (stjhnbsu6iw-159-2-142-59.dhcp-dynamic.fibreop.nb.bellaliant.net. [159.2.142.59])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-55d784517casm101253631cf.3.2026.11.23.07.29.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 07:29:04 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xVVyZ-00000000sUM-05ni;
	Mon, 23 Nov 2026 11:29:03 -0400
Date: Mon, 23 Nov 2026 11:29:03 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
Cc: linux-coco@lists.linux.dev, Dan Williams <djbw@kernel.org>,
	Leon Romanovsky <leon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	Alexey Kardashevskiy <aik@amd.com>,
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
Message-ID: <20261123152903.GG179082@ziepe.ca>
References: <20261123083337.2731019-1-aneesh.kumar@kernel.org>
 <20261123083337.2731019-3-aneesh.kumar@kernel.org>
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
In-Reply-To: <20261123083337.2731019-3-aneesh.kumar@kernel.org>

On Mon, Nov 23, 2026 at 02:03:29PM +0530, Aneesh Kumar K.V (Arm) wrote:
> Register the built-in TSM class with subsys_initcall() so it exists
> before a platform TSM driver probes, independently of object link order.
> CONFIG_TSM is boolean; remove the unused module exit path.

Why isn't it modular? This is going to force alot of stuff to be
non-modular.

Jason
