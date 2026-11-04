Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793815030;
	b=mkLK+d0nLi8SiXOCImjX5aSTGBZkjwwkK/yayWN3TlswbUPEHSCoWIGc7bvT23G57dgQ
	 K+E7v+eHejwfHXcLdrHeyrjdeMIA7RJ1RYXqHrKvtbrc2V4VOsexjU+vCJrnieVtwKjDE
	 J3WuDLuULns9g1gjAjkYgV5VXaLx2ZNwRaz+B3pYjYSyRDqJqxXcSQIrHc2GZDxl9j7ui
	 cOOIHdDFHFpHTxDIdpCm13sMNg6HJevep6J3q1JfAvsIJ+lbHKqJWtjgvBDTBfY+nFyQR
	 jMoHKk6wY4ipUW/ruOKwDWKWY21zagrunJZ8Tzb+WUG8mvSJ+wg6WGiytgi5U7S2ZdA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793815030;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=u6+Lf/8gHZf1IKHjq4H+ss02XIxxzMA/c7y+z6oAgJc=;
	b=CyQxZGwGW5zU6bihfE4AR/RWLrM5jMH5/Oxy7ucJUNuASyDXMV3PWFDVV3gJEkQqflVA
	 sFaqqc+iCrbuySP31AXpYiPgVXGgY3JHJ0d/FkwpaSWJvVbhEkvyzpe39wGRdtDasJEDF
	 UkJXrCUF8fc8rDHP3zv9VZsCyjIgO1+y6QQR/CS4ashpJNwGna68zCtvPF+Ri/n82Td1G
	 T4kIED8C5dWq2D0HaZucNAjyYV1PkWC6PYbbEA/ix9W0kTzn32ENgKyFE22+JVfPJEBWq
	 k/fwdSqEHnp89ZyGpsDQF++0fguBjm+NcdTxj/04pSJE3msSazJlbwDuavIA6IB3keA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=jSpTFwGr;
	arc=none smtp.remote-ip=209.85.160.179
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A49D607AF06
	for <kvm@vger.kernel.org>; Wed,  4 Nov 2026 17:57:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1A49D607AF06
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=jSpTFwGr
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-536c8f958d7so7584311cf.1
        for <kvm@vger.kernel.org>; Wed, 04 Nov 2026 09:57:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1793815029; x=1794419829; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=u6+Lf/8gHZf1IKHjq4H+ss02XIxxzMA/c7y+z6oAgJc=;
        b=jSpTFwGrGxYp4V4QZz2ba5dYIoDJJuxWjxKzx8KifYjFiBa0ODGbZD1ZEEW7S/WD0T
         Uh/eSnAdhC0igsZSTinaNwZ4d/bVNxNVLR0SLBhFpcfR//v8TwO6mWhjarmiAGHvyd/R
         eexkK+c4Gy+NJuptHuPNZ54oZFyCFRniuibxorEQrulnSaF5/g4Ne6nK4G/A+pa2SYyO
         6VfYSM9ZMa476+obumWFBoY+RomdwnrNryQ/m7ngxfEuyZ57ZyO3Quffa1K8yWwxMq9m
         PI1/0vFyzZ7alsgF2rxdyGUkXrbSK26XBu/pXg8rzUuwGjiFyUH5CdTcpJmTHMDmmIvS
         oFLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793815029; x=1794419829;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=u6+Lf/8gHZf1IKHjq4H+ss02XIxxzMA/c7y+z6oAgJc=;
        b=uzT5Ey9xei6eB6LdQ20S2Xg2IJWe7MBdET7VKo79s0uNZafTIFY9ObhLPu35Pca3VL
         3VAg7eZducN/ZUC/S/lwU4FojA/t7K1xcmK2kUfeYpbHHrBcxIYGsSzut1SYa9pijrmN
         UDNePql+Rzoqo5F9Dyr/OPmvqd8Gc4PydVjVYhQadae3RQBv7QDQVe8JQ9Awf3/TE9DV
         Pkg7OlGoQi5wNaJGCbbqncJ6EQhQT0kRUL61lHQ+dggH0EYApU9l3tpTMM7Me/LK6tL5
         YBkOl2u2GBcF4jUKA0IhQ7vAj8k3/e2N30nTPoeiaZSsxmKY8ZF3WAYC59ScznIaX+VU
         uK8w==
X-Forwarded-Encrypted: i=1; AKwUvBwPFkT2ziaqX9+67cqvoYZK16aF3Qh5XSCgEcJHMVawJ2p/dbSQMRbi0MT2ulqz0bVA/TQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z/RdId6NtUev8fYN4GBUvb5kSYgJdzj58ab7mJutcsKLmaGcKQb
	X/FdXy7N1s6EjCqhzazz2cBMVpYTBH1ArMiEkbJKSGacVRBENlHOm2TV6gKPVkDtZDA=
X-Gm-Gg: AYBFou0zOG9P5ysdw9FLCdqR/IogARadJrTz/lKHILraODDQT8z2j3bT5u+8KuZoIZk
	ASAlH6tRuqN5exlGSMZBL1KjH29mRAAjStTYyAT6oRMYzXbuekSeSGqpMhqy19I80B934FRnfBA
	27enTb+Gt+zCJmpmDvbhEI90Yb7zzaFii+PE9wgDc5VHaR7bFUN/lu1DfHVIiX2ZUzwx7pBpScM
	DDGfnmeBb4Q11G8ZT4xEdJLf1un2e5oW53BferPSi536CvAWuijdmGjHw1lNME1FA2U9n5GN8Jy
	A46AoS4ImJEivKPcXFrPER26ngmKiZw+A3sIxeTVE6Iyo5KGRWs3WoMQnDZLxBNI4PDHVcNBtbc
	t24Rqtj1uAic1WozP489DhI/afyG4kp/kEPkRLpIpNA+2UMlmOgePM3a/I9JtiMC8bicOsCmcKn
	EV2KGCXCPb41YkIIwjYimixpXAnwCaU2+y4n8zaGqYDr8W03Bqjqsj38ai5RZg6MfRHoH3rpC/C
	Dc6furlAMMrq79ln7yGUPDP11pMcCZ8s4dFYiEBwwOE2qi3gThUH+PNhBso1PvXYMHHn55RjxHp
	SD4h3QxPjbb3b6YcuQRGd617jopzPE6VHnbK8bYpV8KgbXl3Nrb5yp2joiT3GA9YPpOh0rNWV6m
	b7t5c9ezU0g==
X-Received: by 2002:ac8:5f08:0:b0:535:baa:a78d with SMTP id d75a77b69052e-542b3a728c4mr272645741cf.10.1793815029017;
        Wed, 04 Nov 2026 09:57:09 -0800 (PST)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-54b10a6ca24sm30262291cf.14.2026.11.04.09.57.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 09:57:08 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xOfER-0000000H210-48gw;
	Wed, 04 Nov 2026 13:57:07 -0400
Date: Wed, 4 Nov 2026 13:57:07 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Jiri Pirko <jiri@resnulli.us>
Cc: linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org, x86@kernel.org, kvm@vger.kernel.org,
	linux-doc@vger.kernel.org, david.quigley@intel.com, lukas@wunner.de,
	ksinyuk@kernel.org, rodrigo.vivi@intel.com, cedric.xing@intel.com,
	sameo@meta.com, drdeeglaze@gmail.com,
	James.Bottomley@hansenpartnership.com, aik@amd.com,
	jpiotrowski@nvidia.com, qinkun@google.com, pgonda@google.com,
	jic23@kernel.org, alistair.francis@wdc.com, ankita@nvidia.com,
	suzuki.poulose@arm.com, kas@kernel.org, rick.p.edgecombe@intel.com,
	elena.reshetova@intel.com, dave.hansen@linux.intel.com,
	sathyanarayanan.kuppuswamy@linux.intel.com, peter.fang@intel.com
Subject: Re: [PATCH RFC 11/20] ctlv: Prepare runtime introspection
Message-ID: <20261104175707.GA3889730@ziepe.ca>
References: <20261015145053.3664509-1-jiri@resnulli.us>
 <20261015145053.3664509-12-jiri@resnulli.us>
 <179302367452.58760.11808905856343064399.b4-review@b4>
 <auRmMPfaFINUIchi@FV6GYCPJ69>
 <20261103010537.GI3889730@ziepe.ca>
 <aumogVKtYnY0QJ2r@FV6GYCPJ69>
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
In-Reply-To: <aumogVKtYnY0QJ2r@FV6GYCPJ69>

On Tue, Nov 03, 2026 at 10:29:45AM +0100, Jiri Pirko wrote:
> Tue, Nov 03, 2026 at 02:05:37AM +0100, jgg@ziepe.ca wrote:
> >On Fri, Oct 30, 2026 at 10:53:11AM +0100, Jiri Pirko wrote:
> >> >So.. how about could we drop the sets, use a direct description of the
> >> >layout and do something else for the ID numbering? Maybe the numbering
> >> >can be solved directly by only listing the names in:
> >> >
> >> >numbering:
> >> >  - device-get.reply
> >> >  - device-get.reply.caps
> >> >  - device-get.caps.evidence
> >> >  -[..]
> >> >
> >> >?
> >> 
> >> I'm still committed to implicit numbering. For "inline records" I
> >> resolved it by having it encoded as a tree with 4 levels:
> >> 
> >>  63         48 47 46 45        32 31  28 27  24 23  20 19  16 15               0
> >> +-------------+-----+------------+------+------+------+------+------------------+
> >> |   family    |kind |   index    |  L1  |  L2  |  L3  |  L4  |      field       |
> >> +-------------+-----+------------+------+------+------+------+------------------+
> >>               |<------------------ record ------------------>|
> >
> >Fascinating idea. Sort of like an oid
> >
> >I guarentee we will run out of bits someday :) I saw recently we ran
> >out of bits in RDMA :\ 3 bits seems like quite a small number..
> 
> Well, this is just for inlines. I think if user comes to the point this
> will not be enough, he can use named record, as he probably should with
> more than 8 inline records anyway :) Also, we can introduce "mapping"
> mechanism to allow inline conversion to named record without breaking
> userspace. I just didn't bother to implement now as it is a theoretical
> problem now as I see it.

Oh OK, thats interesting.

Jason
