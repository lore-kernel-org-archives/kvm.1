Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795447660;
	b=r/pkM9kI/75T6PsfgaBNAUNTEOlpvkvDdL2MDcsU7kIzMeDxNW59nvY9h3QZz0nIzQzy
	 u9piZUI0/IS9auiwFEI+zn1A6DyTLp53+rjc9LRWJCzZVeE4NCPZxv4h/T+j3hBcgenpM
	 UEWnaZfZ6r2vu1akcNjq9i0M7hEIxIMKAWD9UaSqP5xkITs0GKSe34pTRkxSWHigxtlTm
	 tEmC+Ai0CHFt0u6kQIy6YfN2fG+WQ0UIl5PGrAJbh13UMMZRFdxVhPeTER4JqqanPBYdD
	 2MfA0j7TmVe+1JyhEsx687ovOMnwvgPelDzjlUh94/zFKXeBAFywMxEADNNOqZlrRow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795447660;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=rWLsIhN+kxPGKJoMsbdqyApLe79fwWP1AaQIjJntY6g=;
	b=ZJfoCSQeWME4Pbf76UYOTwWO/33VnxyJKNmW/Xx6w4ntd9UCZRDnrxVT2dHtMAztigds
	 WhVEfMTYsF1HahgwczidRVLeAil/EBBaPvtIJCJnyBOsl7kjtIeHdaG/AJcPlfaho21Uj
	 1ouryOf5cLNx0iZmx66MKRzAIH2YmSo9D0WdEp+08aKbglKZahHiq2HjAcNXYw2eGbpoA
	 p+jSNF0+E1dq/ZLbYJWVXag6c/PjST2Ej+SLD+fxce9NVMgnz0Yb56sIrmnZadBIkd4wP
	 oc3SuZctRXWaYuW97gS9v48ZroQCBiarV7eNGL/tpx3nx9lfpqS1iOvMeF0AQ0dQ7vA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b="CUkDJ6/i";
	arc=none smtp.remote-ip=209.85.160.180
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E6DE606A31F
	for <kvm@vger.kernel.org>; Mon, 23 Nov 2026 15:27:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6E6DE606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=CUkDJ6/i
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-55c48582654so40165261cf.0
        for <kvm@vger.kernel.org>; Mon, 23 Nov 2026 07:27:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1795447659; x=1796052459; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rWLsIhN+kxPGKJoMsbdqyApLe79fwWP1AaQIjJntY6g=;
        b=CUkDJ6/iRI6Hw8aeXlh4lVJYEL8gjW9PUvkBPFPhkslWz5B9RS7X5yYMZPPyQ314vq
         +BIj3vtReJ0tZqB/w1ktkfuYIEF8QDXVuoA7XEEqYyBvchOOjc86mvy++NI+cBffNZjQ
         ejJCctA8xiX8JdgZi1RxnIVZmDbwMwzeVExs180iupqpAKi6NJWjQX2Zf8cqSnDS3sqf
         iu9mV5wmW0ysAAjeyMVLsoypnOKVKt1qEBizciKzVnSk8sOuJUTdc2psgpnS/8VLijtc
         qi1R573dFP4Rtq1ACj1X+7Z/J1ucsIwiPPTsDSwTdyopgIHZBHhcoyjLnoKpxAFsmx3M
         6q9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795447659; x=1796052459;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rWLsIhN+kxPGKJoMsbdqyApLe79fwWP1AaQIjJntY6g=;
        b=sV4wtCXHCzhL3DlIe4+OqYsfenrlyd7ogf+DEZwKasg1QeqrX5FN2KAA+W+2m3jRGR
         n5zn73G8foUERmtiUSbyrn3Q3QvLqlEkI2HoOX0cQDuncERmqZuDXi5bxSD36U8XuFrD
         ucN8Jd09J8vo1GcGGcuBPLW9IaAlxno8EanxpxDx9Y7ekzs63gwVNbysIU9/wREfNr1I
         BoywRXiZqo9UISVtZrR+5sBVb312ohDOD5g3BVdI0OH9ZPzuqJmDlVw9hB7UYfCwAv6f
         s688jqqq7gtT+BeLMqMY6DNvhvtQvbo0mYXHdvQRQ2S6gI5zT94dA0t74aUdLn8aK2vl
         3wUg==
X-Forwarded-Encrypted: i=1; AL+hErHvMYrucmS3UojrqfWryTVCo6cnvDc/NFWRTTBQTvVnFQM83DQqXmegcGQqE2HEC83GatE=@vger.kernel.org
X-Gm-Message-State: APuU4Z99/m4dtu/+LSE+UFQfXXlQ9siv/fY+zcpXs8oiY8sXDQEdtEZq
	NQAEXOADdFLMx9vEYeh3nU63gfy3T2yA8IT9ugB+s1Twg4+aQjic/qt+dVEi5HvMFaQ=
X-Gm-Gg: AZFdTZch89Zr9KFNttCvgfaLQxld6qxejzQ4BZY0p/0ozTvQxoSzTjDIw6ul9JKOFd6
	IpMVZ2OZnsWl3NwJ1mQmgnuyyltc0ag0TkkgWhU68UHoie8ckSefXWG9wZAYPxWphf6TMXmwoKa
	G5yHA9t9sCcsdzy+Rl3/0BbNYHsJyrIlV43mVHr9dT0KLHbK/nMG1nSEDNvMLFQI3Ef0h3fUa68
	jT+3ECA90OsuTMJhuanIjlN2Su3I5hyh50MZIis9JXaeggpMTDgOv8e3BfxaxHfVN96JqRsm8SQ
	XY0AGyp20WYvwqURWxKZCAwxqEKd8twTqkUgF2BQ6//BEJTnrkNW5VNMsVZGzjiu2z2kdOkvdWx
	jaH3ncGEVOV3wcLjFuuCtqI9Pj0oxbDGGwC+X2WV4zycFCBu1dZY8pR54Qux3e1ZZ+J2faeNaum
	X8cSDngeFPtY3yDsjTdc7ku7K51RSOvYkHR/kH03Wshpv4Ao6vFABlD5cNj3ZYjlNFpLhin9924
	bTJsOVPdt15OMPwgBsDBil70tQyZl4OqVuicPXwulY9mUBWj6RwbrJJH1u1rfOJ+LGlbCorI9YB
	cJNVNZm1sma8dpRxRB595WDG++AEJj1AvoxWSsNG3fFHCGNJ/3I7fxZGxXwzi2ZzMS+ONWBS7RK
	TLCE=
X-Received: by 2002:a05:622a:1a8e:b0:535:2794:851c with SMTP id d75a77b69052e-55d76ac54famr221466701cf.39.1795447659366;
        Mon, 23 Nov 2026 07:27:39 -0800 (PST)
Received: from ziepe.ca (stjhnbsu6iw-159-2-142-59.dhcp-dynamic.fibreop.nb.bellaliant.net. [159.2.142.59])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-55d7882bf70sm102842001cf.11.2026.11.23.07.27.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 07:27:38 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xVVxC-00000000sQR-1ESr;
	Mon, 23 Nov 2026 11:27:38 -0400
Date: Mon, 23 Nov 2026 11:27:38 -0400
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
Subject: Re: [PATCH v1 08/10] PCI/TSM: Add sysfs lock and unlock for
 guest-assigned devices
Message-ID: <20261123152738.GF179082@ziepe.ca>
References: <20261123083337.2731019-1-aneesh.kumar@kernel.org>
 <20261123083337.2731019-9-aneesh.kumar@kernel.org>
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
In-Reply-To: <20261123083337.2731019-9-aneesh.kumar@kernel.org>

On Mon, Nov 23, 2026 at 02:03:35PM +0530, Aneesh Kumar K.V (Arm) wrote:
> A confidential guest needs to lock a PCI device before collecting and
> verifying evidence about it. Userspace also needs a way to unlock the
> device after use or when verification fails.
> 
> Add tsm/lock and tsm/unlock sysfs attributes for TSM drivers
> implementing devsec_ops. Writing a TSM device name to tsm/lock calls its
> lock callback. Unlock calls the matching driver's unlock callback

I thought we agreed not to do this in sysfs as we worked through the
SPDM stuff?

LOCKED should be the 'start SPDM' action in the guest
RUN should be the 'accept SPDM' action in the guest

And though we didn't talk about it there is likely some 'destroy SPDM'
action that is UNLOCK and UNRUN.

Jason
