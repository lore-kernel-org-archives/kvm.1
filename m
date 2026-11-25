Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795617527;
	b=K7MXU+EROu4AQtGWs/08m2SjVAL/5FzPc7coHfMC/guwQk2Uj+HHAbWj7xjmMy8Hq+2Y
	 Q5PmLw+04vDxHAuoKn6YfBV8qFQsjjZyj9eJo3T5JVu3LZz0gxryF5KFGgyWUQzrMiqMI
	 VlEFdNaLsf7ePcdSj3oI38YCGDnA5OvoGSrvNyTKh9LgqJBj3JbtVIfhEUrYNy8LcpeXf
	 RvAMOgyGmexiVHJtpTJf5pR+stkIOljJsctIFmXsIqc0NV6EtD9Q3Rg/hISPMt9bR00v4
	 uT8KNKpIdsfo7BywxokjeVGJV6Itt+U+bfm2v3wFyO+ma4Mc3lYaB1ZTueodBzWng4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795617527;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=dCtVGEXy/TUgxCZ9qLhPI3rUEmqk4eMQKQPU17VUyZ0=;
	b=P1/jMBVX2YILJ+1OyCUt5rDZbut+qznSCbeaj97iKopSMDTTE7fksIR6xk4aRXbun992
	 NerUgcDHy4Wf4EQrlrAL4gcVaTi4nmn/y7gwBjDvq24KBqDZnRCv8iGuAXYg94dBvRZVv
	 XH4pH5h6bWTr8EFaQVlfoPyeYS9CNN4/CVUrpOjDEoXAaska7swQRHVv106Jlo0SmwOBs
	 pXvcntnpFs2nkBlepp7PKFVMiBX/7ES/eVlpwp68ewICHGKXSoCo7fj8w3jRLs6n0KlLy
	 +IUHVkhItH3MpqG24kjd1c0Ed1tUWYBMIo08LbytkYYO1gcp+60CeS1/o0gGxGwDwHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=Mq7gvBej;
	arc=none smtp.remote-ip=209.85.222.42
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55BB2606A32E
	for <kvm@vger.kernel.org>; Wed, 25 Nov 2026 14:38:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 55BB2606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=Mq7gvBej
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-990a39ba4fbso1552550241.0
        for <kvm@vger.kernel.org>; Wed, 25 Nov 2026 06:38:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1795617526; x=1796222326; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dCtVGEXy/TUgxCZ9qLhPI3rUEmqk4eMQKQPU17VUyZ0=;
        b=Mq7gvBejM/RZvujAB/JEcfBx2K0Fd39qIALvDchjS4ryUUcG3H9YRSXurhg5IBj3yz
         pkqGPedd7Rg81VzihlHF8Yhb//N3cQ2Bd1Y3QxcEN7BdJjVo6NcJnhvz8CXwlQrGZAi9
         fq3nyncoYkZygD+C/eIJWMAfqikOC06+TglwefSzPx8/q92kqj86RrOIHHyvQOy2QBIy
         HFvePBB4Esu4O5rGc0YNu4Y+Er34fdIqA3I7AgIq864JDxVezm5GySWGVdkJNFQkpyIq
         GH3wLNUTu5pBqY/Smk0GeOoyOhV7L8RdVevHK/IfPSAAvxqGnZlM53TpNS7ql2b7sPBz
         rQIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795617526; x=1796222326;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dCtVGEXy/TUgxCZ9qLhPI3rUEmqk4eMQKQPU17VUyZ0=;
        b=tDwehRQJOtV8Xhlnd+vKw3QtrEsgnwuJZ2kfCSGt9dHCqsa6QLLfKph/HT/AOfFJ6s
         WTq6N6MCewzYgWMYQM97BRCW87Pw9LPJLr0vQIwWR80MDaeYy2E5aj2UjelXkPZmX5g7
         ptfhlVNAyXSg0+QTQBrJY1LujHvu/KxFxSJDXX4QH516VwGnuNGBNimACzjZVoCHzeU4
         hLdHdBqzSntEAWlbCdy0cMwt3EkOXnh0myYuUagtv6J2vjO6YU7Seqkm1fg4CT7feEdC
         elXx2Zwo+juVjnumdRMnfSU7sFBptKnasl3KxByCpSilf+Nh2pPe0TNfNWF/0xKMEA0X
         eIbA==
X-Forwarded-Encrypted: i=1; AL+hErF9Ez3Xekb4nC3a9vzkKjSRpnvwh8mkBPNj8mg//nWelXvIv+HzRZiCpaq6/EKIo8lZKvc=@vger.kernel.org
X-Gm-Message-State: APuU4Z86GcUwQ17JmxEK9ATydmIrbiwDZ+HMCN1Bzgiu5couGXxus+uJ
	ejZ4wUkfsSk4HcmyJHv6sLHVsoOUdk9v+6mBDD+BDDcPLyzCDyIcQMsapD1JDEYX4Gg=
X-Gm-Gg: AZFdTZc9UcZ1fqoF1XQ4+HGf2AUSzW1/6rdJejhpwyMXFUYRUj/dWSvkkt4fYZqDvb5
	ZsiGSCY94rHyZkwEUEzeOP5ZHFM+T+TXS7XPDVjDqtjQwMpqn2zUOj4GtNNo6Fkuy08ixtGvHs4
	YCkUOjtctOl0BhwtalK5MYMuUL4+wwbb86+AMJBcIhgRrAgmecEaGC3DQer5PsMWJjuJKstmBNQ
	BhcHpCbn3AKOP0KwQld0h/W6HlYKFxd6vn39C0u4TPgUhdgKCCDO9qRfBG92VP9pELUvUntjT87
	RxpaJ3KW3/pR+r6Aona+y4TlMwofDN9F6Zv3yvvGzWifBtVB+qEMHjiwPnb84ssru4JHbhD0nPF
	O3BPcHENbVdCfElXCKumr5B/yZgWqEfypWpQ8n6bBxxtlmBjJsgYj/1e1ydJitmzLPcfY/h/1Y1
	gtJYxqjDEX2CyQ8TiSiRxp81eeVlTE8PiV4coH1sk5yI3lEGTfiz+c41ayjtde9TlaMrejN94Pd
	YD5lJt60wNYC4gV7ZZjN6eh5r+h9UAlA428BYrsUCuh52Yt5SYbHxtN+n/WFrHh5f666ccu//bY
	H21xBg==
X-Received: by 2002:a05:6122:1816:b0:5ec:4112:6839 with SMTP id 71dfb90a1353d-5ee8af18034mr9201283e0c.15.1795617526133;
        Wed, 25 Nov 2026 06:38:46 -0800 (PST)
Received: from ziepe.ca ([142.177.118.84])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-921349d383asm163086316d6.22.2026.11.25.06.38.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 06:38:45 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xWE8z-00000001lnK-03Mz;
	Wed, 25 Nov 2026 10:38:45 -0400
Date: Wed, 25 Nov 2026 10:38:45 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
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
Subject: Re: [PATCH v1 05/10] PCI/TSM: Add association locking helpers for
 evidence acceptance
Message-ID: <20261125143845.GG246011@ziepe.ca>
References: <20261123083337.2731019-1-aneesh.kumar@kernel.org>
 <20261123083337.2731019-6-aneesh.kumar@kernel.org>
 <20261123153507.GH179082@ziepe.ca>
 <yq5ald6h9r1g.fsf@kernel.org>
 <yq5aa4mx9nsj.fsf@kernel.org>
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
In-Reply-To: <yq5aa4mx9nsj.fsf@kernel.org>

On Wed, Nov 25, 2026 at 04:32:36PM +0530, Aneesh Kumar K.V wrote:
> Even then, wouldn't we still need pci_tsm_trylock_association() at
> spdm-start? Once spdm-start completes, we can ensure that the
> association remains stable until spdm-end, but that still does not
> eliminate the need for this API, does it?

If you have a valid attestation device for the TSM then the TSM is
guarenteed to be alive.

That is the invariant we need to create to have a sensible subsystem.

The session cookie, combined with a revoked/disassociated attestation
FD guarentees that userspace cannot be confused by a TSM host
plug/unplug. It will simply see the attestation FD it has open stop
working entirely.

Jason
