Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795526276;
	b=VerzSQidzG4MQOdS9TwV230JAUpJzSc8/hKwVpwWGyDyyw+p+yWmU7BaN5Lk4+BeD5sP
	 eAB9f29s4ui9kZO8ftHdhZhIx4z6KVRssT6ZcfdC49XBAjsk1gZ2BaFmi7lyB/Uu0NMjY
	 I4p3Aatig2Ufco+B9HCezNOdsf8Kn/LE+lU4ff8sS9c66aOMXOzGKMmu2s6w2elOEyXCl
	 HTKdI/uoaBXcVu0xEhAGqY0RDNn5M5pUSnJaZjBb1gk121EFhezQfGucJUR6SeenedKgu
	 5uzODQLEJ8a3RmHLQ6HhyAFR3ncDN9gWhwcR1FWSGkMPApCuG5OUfshbDslgQuhyxjg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795526276;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=JQr5O3TAm0LrUQZ23OaV0ywjiZMgF6OfZ39GqtSUwII=;
	b=GETOawgQp+ER4bvrtLK65c+sauGSfRI+kjsQFk1KLHJFl0qfeB/xTpevwGS4FTqeR5ru
	 69i+R3EJG32DcDGs+wg/e9+0DFTbG4sLW1h/DbTiCoJDENuepcXfsIVp2Gyx/YidsVkLe
	 i0TN0Iq1um9Jnl0ya0haNGHq0OuZd373SvAAdcwPSeNyDu2/nBn8CAt1DEFnzdTbGfaFM
	 rsFK/QImAKS18c9e/MYYEtxUnO47I6c1HFlso5ybtINv8LkrFsOuTZwwHOprO4Z/B81z9
	 k5aeBKXAVwkY41TyQ7IXUNiIJGSuqZXvV0BsrbXeTYuY5E8Gja5TK95faRx1iIvnydw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=XAywAbuF;
	arc=none smtp.remote-ip=209.85.219.52
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 448FA606A31E
	for <kvm@vger.kernel.org>; Tue, 24 Nov 2026 13:17:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 448FA606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=XAywAbuF
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-921276742e3so41912826d6.2
        for <kvm@vger.kernel.org>; Tue, 24 Nov 2026 05:17:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1795526275; x=1796131075; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=JQr5O3TAm0LrUQZ23OaV0ywjiZMgF6OfZ39GqtSUwII=;
        b=XAywAbuFEHdpJgqLJx+wUsQ2Y9xv2xvwJ8cx1D23A/19ETslrZoMGfHL0NL/0BPOdN
         r35Qf6xmAzDpVaLAQdRrQsiMPSqsetc+ml2RXu3vOohu6QDkZUP+Atb7gRh6ylyZ//eS
         /UgL4bwWZfuimVGs93FM+9yw2B8f91282LVGstj1T94xz5p49EHvC75ggBq4CyfH9rJ6
         XnWXrnxMTxgXAWrYGsXDArNzsIJ5Avgu8co/TZiboocNSH1hG0IWgNkW+Qm0nAiMc0O2
         ItAtoxIwIy9fbWjC5UOnUFshs0r4UjZpkp0xioG9e6uuGS0fzR3JkIEj3coXzHd7brvE
         hF5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795526275; x=1796131075;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=JQr5O3TAm0LrUQZ23OaV0ywjiZMgF6OfZ39GqtSUwII=;
        b=MItT11Az1+CYw9V4Q2ZZTcvm7rYBBBIBRs/3wNA1gDghSSHiWoMwSJjOE6PaHwVZDJ
         ux67JN2qCa7SU52fyEiJOec3Qk27DAL/anSd2MPZdqPPIJUxtbNBv/nKkGJq1qdx3ZSE
         pA84K1sMzxe75qceaMYT2IoZDaI6zfcv6fGjo0eCJpTouZpcWNlxw44L2xyIJZ1cTvmc
         cqHK4eiyMQtL/VjVaiLO69/Da9qwssic3Ew5UbJF6YNwCSYoXUnf3zc+b8zceMGQ8Afj
         07iDIZazge3kyc8YoVWJWRCJcY0gPq0U09GXOM1arSzfRUcxurNXhrlbKMYtMRB73RJ4
         PW5A==
X-Forwarded-Encrypted: i=1; AL+hErGhH6XI8ALqybNnDj8de18QmlRR9Akrv8O8VO5kODan9l8kMBKQlXbmWNoDXUumU+PB9p8=@vger.kernel.org
X-Gm-Message-State: APuU4Z8+CBk7eF87knHuL3UxjPKLcwhw9Wxc5iYJL8fZvBthwO5lmZ2g
	gETfA9jtL51cSmKtCF/NesmvLQ19hF+zuUjuyeLMFmZXKMGjWsp4hzp386xz5v0cEKI=
X-Gm-Gg: AZFdTZd8uoU8ARKx4cD3PwKfDLvS16wCdyZl4EDvf3V+FW6k5TIO1ZiUmgCmuu5wu5n
	HzhCDBXJJpjO5c4U26oIqK0qUQ6gxdPlzeGUmwK53j/TYIuA+OFbpFM56lLtvGYpWB6w6y5L2K5
	/a+AOXlPb/DsRf+Ztv1Izz4APCwtNU+16Pkdhv6YuJIu+Ci3UbQH4x/Dtmrli6RIXcNCpzcxTXs
	Mg6QzIm27mY+0rgUFDPxrP8iGBaK2Dg67680PQ4uuwFB0wpWZX9g2R2YElK87n5+uIvkBPOz5II
	Syky+l/8PaYyTPvIk+xHX/PVt5rvW1R/1QdlntGkZmi7+r65Ss/QoRP/ViyQsc5FcR9HRiHEpgW
	/WpDr6JQzqxHrhdN4Q+XEYKEgmA63lm4irGqj20sl9hPA1py/AeZfYvXP8C6Ny5lG0iUuIGQqgy
	OeDoh9qqRAmWCrC1lM7bSTXTCnFVKz/JtI7cT3OfMXQvEzQO5LjxPgRyOwkuzfKP5wp+edVOZrp
	7YckklGIcwvMHqt7Pcbqe6/kx69HqfItLEpDb3Q//dbHoT954rNx7o5DbsAwF9zlfKxDtSSoxQD
	bwhYaDc=
X-Received: by 2002:a05:620a:3722:b0:949:472f:226e with SMTP id af79cd13be357-949bab15455mr2786066785a.71.1795526275080;
        Tue, 24 Nov 2026 05:17:55 -0800 (PST)
Received: from ziepe.ca ([142.177.118.84])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-921349cdfbasm134605646d6.17.2026.11.24.05.17.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 05:17:54 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xVqPC-00000000P5z-0Ouc;
	Tue, 24 Nov 2026 09:17:54 -0400
Date: Tue, 24 Nov 2026 09:17:54 -0400
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
Message-ID: <20261124131754.GF9566@ziepe.ca>
References: <20261123083337.2731019-1-aneesh.kumar@kernel.org>
 <2026112325-emit-squeezing-5d96@gregkh>
 <20261123090623.GK14811@unreal>
 <yq5a7bi3riha.fsf@kernel.org>
 <20261123115803.GN14811@unreal>
 <yq5awlq3pto0.fsf@kernel.org>
 <20261123135638.GO14811@unreal>
 <20261123152533.GE179082@ziepe.ca>
 <20261123185826.GP14811@unreal>
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
In-Reply-To: <20261123185826.GP14811@unreal>

On Mon, Nov 23, 2026 at 08:58:26PM +0200, Leon Romanovsky wrote:
> On Mon, Nov 23, 2026 at 11:25:33AM -0400, Jason Gunthorpe wrote:
> > On Mon, Nov 23, 2026 at 03:56:38PM +0200, Leon Romanovsky wrote:
> > > > >> >> But it should not, as you are making driver core changes that will
> > > > >> >> mirror the same thing that that patchset is attempting to do.  Please
> > > > >> >> work together on this.
> > > > >> >
> > > > >> > +10000000,
> > > > >> >
> > > > >> > Greg,
> > > > >> >
> > > > >> > This series came as a surprise to me given the fact that device trust
> > > > >> > series is exactly for that - allow confidential computing.
> > 
> > Device trust's primary role in enabling confidential computing is to
> > give space for the userspace to do all the TSM and attestation stuff
> > to get the device into T=1 private DMA mode.
> 
> <...>
> 
> > Getting the device into T=1 should influence how the userspace decides
> > to set the trust level, but it doesn't interact inside the kernel.
> 
> The point is that I’m describing the reverse relationship: the trust
> level should determine how the device is configured, not the other
> way around, as you suggest.

They are unrelated. Neither influences the other. The user gets to
make orthogonal choices if they want T=1 DMA and if they want
adverserial. All combinations are useful and valid.

Jason
