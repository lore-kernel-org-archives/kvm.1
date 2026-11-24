Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795527859;
	b=tdhpSAlStQvLoEoxlkkcA+4G26VUoeHg/2wvvRYsEnLoSAuJvHc8ejnwSFsyRtkcpcQZ
	 gxi8XmWwqpsBbFdd6Jy5UD1cuI4FJhxfpCVjC5VRgG8bN/B82grawqbrewW+hBVa2SzK9
	 wko5darBclGvmImROQWygR73jyXOg+HfotsSqDmepVmTz0rYYKPBT4I7VMozEN1UuKjlN
	 fz7MqT+v5dMUnaTHS5RMv6Df/BQ4w2xBi78JHqqD/b3QpFomzigUbB4u7a0wXMo5Ab0xk
	 r0HX6EZJNm2zswg+atz1hbAD3jg7uYJYb2pETE5Ett55e/Ry875QHHvM5EV1G06GfAg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795527859;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=GOO2liEeh3ZNTv2cYVirV3xpcqc+Z2dTdYpM4j0pd4M=;
	b=tSH+Egh7BmZTCqS2XfneHuQieohpkKbeiMpWTCcYfH4bpK31LTbQ/Sr94Ff4uXb9/VFT
	 18TL3+2AVS3rGRPQjYFZo21k3SxhD46IwigYdbXz7BXM2I8NxHJdlCBWzjps586fCJZCs
	 icU12789h01iWvIxmipTFyyuSnDuiVT9zDLHtqweudMqTDFmxhvYBA6bJCxT8qpw0V78f
	 z9/JHEZ0MdjPlgl2+aNmZDSdYB6hIbnj0ZoGZubURODj+KaUJrmESMX7d0RhSvjCtJKKE
	 4vRpmFYEctpuX0zvHNL/B1+PUmKDqdylYK+3jiH/nJAUfSqlFeFibHekir0HTqgM5SQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=QFVqpham;
	arc=none smtp.remote-ip=209.85.219.44
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F3A606A321
	for <kvm@vger.kernel.org>; Tue, 24 Nov 2026 13:44:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 05F3A606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=QFVqpham
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-92119da3d37so43083606d6.0
        for <kvm@vger.kernel.org>; Tue, 24 Nov 2026 05:44:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1795527858; x=1796132658; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=GOO2liEeh3ZNTv2cYVirV3xpcqc+Z2dTdYpM4j0pd4M=;
        b=QFVqphamGJ1ouvGn3fy7DcoC6ssGniIZezfuz//pt46JGumakdr+cRGns4bSFps3Qj
         X8b1F0lxTXf+X5dCf0Y0HDXx/Jk1PXjUQCgV6KFAu8CagoWzWdkIWklx6cE4wFSeB9bN
         e9mGCAtBGvFTP5PeM5y+c1two32aaS1vMig5INZymr+NiUvfSEnSGK7beegxMVlf7d/t
         cGIlIhcNn4pE5iQFUBfX7/0TZBeRtLLhpozmoDxRfm/Lp0GZPcMs6trRg8dtYKgSJ/G9
         KQKgVZRVUtZs3pg+Hryz1s5zqC7nE9nUSqjyQ8UBX8YiXIFq3rbsNdg86dvEfsDxpoXt
         59sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795527858; x=1796132658;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=GOO2liEeh3ZNTv2cYVirV3xpcqc+Z2dTdYpM4j0pd4M=;
        b=XuFs32Wb24KRY7qJ21bpNk8LJmlUPW0Got1TN8nDHud0RkJTHjCt7O7xZ2ucif5nyV
         tHg4VKN+i5tXa9BeNFFFzlxdWfXBTWIrru/vmZn2MEjYbFf3aLla58HKYec0tZKaY+18
         W9covH4j4V46n/kdZYZCWdxC4fYVDSAbSwLRu7CxMr/inf7BO5JA1aLTY2TFQvntaAAn
         4zlGxKMeCGxagk3BTfCw3j+6Apve4QldoEthdi95uIrzIPnVJvWZjSmyKi0/UFTpo24D
         RLNPvsusnjAYc+0xhlaWFGVwmX0km5SHHF+Cq4UXaChaw/GT7+oJw3mDFI7D3RBfsIZA
         h0cQ==
X-Forwarded-Encrypted: i=1; AL+hErH0BNKciMMApRRY+r5oGWBXX1NVfOV50VOt2sAmUFu27IUBEtfU2vmcSNP5KivI5t1NOzw=@vger.kernel.org
X-Gm-Message-State: APuU4Z+eGeCDJb1pJviU6F8inoXBdXUSnDAM4wUt4l55m8+pGfuW1ihl
	67YC6s55V/bisX4bKeEqIqOEdxusJ6rK54f6n7ZN5RnJZqVD+fsX1lP5NHEcSybxbMfOGLhYENK
	SwUwv
X-Gm-Gg: AZFdTZebSq1+Em+UMEfnMsLX5fupVvjg8Lj6DA3EK0385GLuzIyRDnIImfLEiYAxDje
	2ob7q3QMtrxoC/c+V1ICq8Tuy1hhKfFVyNV1Rnu+BGFNlfO2WwTZIKupJoc0RTOJPLCwO4ypEDg
	Bfz0AWFo9hIfTBmZwq9+rKshjj5e9rY1sZqWmQbE9UPJdywFdIq8r8jniSDwORtfVIOsO7kmuBB
	IgeWHzPJBZMKKcTGNUDxAdaa+qiMdHE/8ohB9svhYZVdtWTqBzEN2PuudrbrqKh4Wwnd4F+g5aZ
	RUq4mztnFrdKXEhiRpZhSGXVAuOHFRgTYuwaYTtxv3+Pqkr10uhBbWCRl2cITpyhyMJdQ20jU2h
	xdyGci7Z8ellDpFvahS4vEIgg2b7HBvY/yFz17+WTAnJRC97pKUDYdgXECSJrmozlqwqSVWv4Ou
	NpcXrfKRDNcZ8sXaW5gDznpZD7U9DanKDpw8fnSS4rlajlxqtGeLsy94WpES+5t41Vl3PttWYKF
	d7RZOFBSc2+hbRVMTLbV/tQFLjQlDoZ6SiprmH3kKzDcbhQ8/R7oJmCsPi0U7NHagNSzmGqD9Rq
	iO+DPg==
X-Received: by 2002:a05:620a:6c01:b0:93e:c12c:43f9 with SMTP id af79cd13be357-949bab6e243mr2406376285a.70.1795527857835;
        Tue, 24 Nov 2026 05:44:17 -0800 (PST)
Received: from ziepe.ca ([142.177.118.84])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-949bb3ba04bsm1055445785a.24.2026.11.24.05.44.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 05:44:17 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xVqoi-00000000QDP-3RBH;
	Tue, 24 Nov 2026 09:44:16 -0400
Date: Tue, 24 Nov 2026 09:44:16 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Leon Romanovsky <leon@kernel.org>
Cc: Nicolin Chen <nicolinc@nvidia.com>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-coco@lists.linux.dev, Dan Williams <djbw@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	Alexey Kardashevskiy <aik@amd.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Lukas Wunner <lukas@wunner.de>, Ashish Kalra <ashish.kalra@amd.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	driver-core@lists.linux.dev, linux-pci@vger.kernel.org,
	kvm@vger.kernel.org, patches@lists.linux.dev
Subject: Re: [PATCH v1 00/10] PCI/TSM: Support guest TSM drivers
Message-ID: <20261124134416.GH9566@ziepe.ca>
References: <2026112325-emit-squeezing-5d96@gregkh>
 <20261123090623.GK14811@unreal>
 <yq5a7bi3riha.fsf@kernel.org>
 <20261123115803.GN14811@unreal>
 <yq5awlq3pto0.fsf@kernel.org>
 <20261123135638.GO14811@unreal>
 <20261123152533.GE179082@ziepe.ca>
 <20261123185826.GP14811@unreal>
 <20261124131754.GF9566@ziepe.ca>
 <20261124132536.GS14811@unreal>
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
In-Reply-To: <20261124132536.GS14811@unreal>

On Tue, Nov 24, 2026 at 03:25:36PM +0200, Leon Romanovsky wrote:
> On Tue, Nov 24, 2026 at 09:17:54AM -0400, Jason Gunthorpe wrote:
> > On Mon, Nov 23, 2026 at 08:58:26PM +0200, Leon Romanovsky wrote:
> > > On Mon, Nov 23, 2026 at 11:25:33AM -0400, Jason Gunthorpe wrote:
> > > > On Mon, Nov 23, 2026 at 03:56:38PM +0200, Leon Romanovsky wrote:
> > > > > > >> >> But it should not, as you are making driver core changes that will
> > > > > > >> >> mirror the same thing that that patchset is attempting to do.  Please
> > > > > > >> >> work together on this.
> > > > > > >> >
> > > > > > >> > +10000000,
> > > > > > >> >
> > > > > > >> > Greg,
> > > > > > >> >
> > > > > > >> > This series came as a surprise to me given the fact that device trust
> > > > > > >> > series is exactly for that - allow confidential computing.
> > > > 
> > > > Device trust's primary role in enabling confidential computing is to
> > > > give space for the userspace to do all the TSM and attestation stuff
> > > > to get the device into T=1 private DMA mode.
> > > 
> > > <...>
> > > 
> > > > Getting the device into T=1 should influence how the userspace decides
> > > > to set the trust level, but it doesn't interact inside the kernel.
> > > 
> > > The point is that I’m describing the reverse relationship: the trust
> > > level should determine how the device is configured, not the other
> > > way around, as you suggest.
> > 
> > They are unrelated. Neither influences the other. The user gets to
> > make orthogonal choices if they want T=1 DMA and if they want
> > adverserial. All combinations are useful and valid.
> 
> Our proposal is to represent these combinations with an internal trust-level
> enum and manage them in the kernel through that FSM, rather than maintaining
> two parallel sysfs flows that permit every possible combination.

We already talked about this when Dan proposed it. Combining entirely
orthogonal things into a huge enum is not a good idea. It creates a
combinatoral explosion, there are more security related knobs than
just these two :\

It is not even a FSM, it is a bitmap of enabled functions, and that
isn't an enum.

They are orthogonal subsystems, they should remain orthogonal in the
uAPI and we definitely don't want to use trust level to control the
TSM, that would make a mess of the SPDM flows.

All this was already discussed, it is why these two series look the
way they do..

Jason
