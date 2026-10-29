Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793266210;
	b=ToLHWG0b+Zli4V+crfNJul+OWlRmtxZU0g3q5xvdYYk5Da/D8XG3WsDoKug1uqLmEPBL
	 Q1VDzojt2Xej8CAdr9dkzWxMVF6hue90UUhfps9dftY2WhVXKJELl0RHA3q+0tLwmxJg5
	 4GIVUlgAIhAXQszVYUZNxalBY0pKZcv7suyFLSA5K127JD4auZH09lu1XySDsqy/tblSg
	 4X1fOHuZNKgOKr9mU3dmB7lp4XwTPZcabMOdnZ8A7GpUFSjx6rQsVmeXeGkAm7H3Yy1hK
	 EvPMp3mesHIiABUbJreN2jb24eN9q88VyVBunIxQoqvHzxE30lsguP7nF8WLFVYcdUQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793266210;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=SxasBSQqzrj10fgfbmH9pq+LqGH/ruAKc1rAsZ6gHrY=;
	b=DbmaRJ0YPELXMXHJNFFE4VWeg1joRDvJ83fuyx0WUyLqp23RmX7NzcP9iAZ2my2D1HTk
	 KGKzjh90CSBgIp1h3jVOUeKB2qXUgh4yShD+70U4dp3BFHSWshKK5k2KIsTr5JGMq1z3l
	 9ccXNcHz0hi3DPpNfhQhL0nuOTWeHIFEvQ5IymKt1Ct6iKrXuTyJI6l3OXo5cgTp1a22P
	 YngNOvQEw+QX+tRj6I78NfhqVLbmXWx7ArZa1smQ4P/ZAU2J0CrSupUUc26bZWdbs5mUJ
	 9wPV7z3YMbK+27L2I1rrvoplxosDE09H/G/Ij+OXDMZk3Yl0NiK4yfe18QQmghQTt8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=resnulli.us;
	spf=pass smtp.mailfrom=resnulli.us;
	dkim=pass header.d=resnulli.us header.i=@resnulli.us header.a=rsa-sha256 header.s=google header.b=quH9pYLZ;
	arc=none smtp.remote-ip=209.85.128.47
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCCE3606A321
	for <kvm@vger.kernel.org>; Thu, 29 Oct 2026 09:30:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CCCE3606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=resnulli.us header.i=@resnulli.us header.a=rsa-sha256 header.s=google header.b=quH9pYLZ
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4a1b07c3c5fso17080605e9.1
        for <kvm@vger.kernel.org>; Thu, 29 Oct 2026 02:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli.us; s=google; t=1793266207; x=1793871007; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SxasBSQqzrj10fgfbmH9pq+LqGH/ruAKc1rAsZ6gHrY=;
        b=quH9pYLZIETR04d3yKmQFTy1ZqTKb6PP40cYO4TwGO4bHDxZVFg1XfSuuw/cJ+9GOV
         6s0JSiO6XSVuxhaXSYJyGQIp1h/4Q2EbGvVtF7mFxGpuOMG4BCW/+ShuvuVMiCB23+Sv
         Bl3oHpiRalOlsDzuoXZwV8CH9JdaDYkiilX7JIPQYGtVqepwEXJiuQHPEC10+3c2p3Pt
         hnDIzFK9kttO9BFinkggUOPnm+39Nv0Vz7t4fEXEWCHfecizU7Za/hbrKdJFrkwS52jI
         p8NYQGUFduovAJ02P+qtE0BTvnmGgcxknifYKHNwpMuifDLSTHBCMuINlRMDvR6DAakd
         KZxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793266207; x=1793871007;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SxasBSQqzrj10fgfbmH9pq+LqGH/ruAKc1rAsZ6gHrY=;
        b=kcjYegZEK+SLjzHCsA63/4JwieInlCkxJt165uxyjLzoWC3WEWybr+KtIL7GctHLok
         NZuc0pDssXjJExNENBSNhD2rZyBTdiPSNl8+rfcCGkC3EU4rZPc/s2Lsy1Gq3c2u9C9o
         LhRmRvND4Arg2L3uDQ6Y3VCqaEqdmaQIEWBrKdrQ8DR7TyKxymr0uY2mGSkjj9sZQw3V
         +nkalReHmK79cdTx4fZrKOIpF9qEa9CVBX2Prj16AnqECnuaZXbd86ZrfO6pfCyOaQGk
         qmDnlFYWHUxy7yWM9nO0wGkjH8KG82xFlQpjB6fLApftTXY/H5qLl9nO4AoeYquvxGuN
         PF1Q==
X-Forwarded-Encrypted: i=1; AKwUvByS4WZo+jS/+X3MNS/coBP5CQxizJov8PXW5biKwe2WSUQPJ/HiGclaoe8+04ycGltsKwI=@vger.kernel.org
X-Gm-Message-State: AFq9FYKsdK0o5oBk5ljL4EBr7QG7R00oY3uTfsf1kqFR33Le4Kh7EtBw
	CQlmsSbj8MnWRiiymZ8Sw6kKd2SQ4HqPuVsgB+x5G4bK1zU2d8KNdoLrBcRBKi9xiSw=
X-Gm-Gg: AYBFou2e1A93DzzOK6KjsJARtAt4bmRVv/E+givMzvC7BVTd/jPSEzaw2VVKZ/ViGcz
	a5zxi2MSGzyLzPL39rwxz8WPefU1pK5ObYs0WGEI0I7ruDgajJ5Bv1CETG2OCv/G4gBVq7SGFA1
	AmUIDbXr6ZOQCiltWs9OYua3G+QrT68qJRU5NU1YW9yvF4HyvhltZiv+TrlHQSV059s6Dx5SuYC
	VhrSjsav/u/1L/0O1EXl/J66CRkC2Yi9OuGIVzE3IbESxKAtBAsOnnb3ZxCFmMK6Dficj5gO0WS
	P+ZFfls6qpAR0mXvcFiihyR9IbfuZG/o4MtyJeBFMm/PUFCGEDbwLrYm5LAkEP++kxYrrslm5zk
	vDIKauwXH7+uwOfN6tBi4LgUxhgRxm/wFYZOOJNEZgJ9VfLJvlr5Ce4Zb/8S0tlbcFCW7qMIhbP
	5fX+Dwx1Pbh9Qegtdqh+NjhFFA/RbOwCiBOvLOFgUrJUbtq6/slWeshGT4Q913E/mvrviB5yQil
	6vIAMsjfwvzM689CVyChAiyjGH8gg/NVC0qCPnd/ahuxMzE1mEUQcejYPdeGdVQqWT423baVbeV
	L2/O+XT5MCuBpi8sYp3wuDtPYrepEbjRp3Yxmg==
X-Received: by 2002:a05:600c:3b11:b0:4a1:dade:f049 with SMTP id 5b1f17b1804b1-4a966c41007mr110102485e9.15.1793266206771;
        Thu, 29 Oct 2026 02:30:06 -0700 (PDT)
Received: from localhost ([208.127.45.21])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ecd37f4sm40285265f8f.44.2026.10.29.02.30.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 02:30:06 -0700 (PDT)
Date: Thu, 29 Oct 2026 10:30:01 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Dave Jiang <dave.jiang@intel.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, linux-coco@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-api@vger.kernel.org, x86@kernel.org, kvm@vger.kernel.org, 
	linux-doc@vger.kernel.org, david.quigley@intel.com, lukas@wunner.de, ksinyuk@kernel.org, 
	rodrigo.vivi@intel.com, cedric.xing@intel.com, sameo@meta.com, drdeeglaze@gmail.com, 
	James.Bottomley@hansenpartnership.com, aik@amd.com, jpiotrowski@nvidia.com, qinkun@google.com, 
	pgonda@google.com, jic23@kernel.org, alistair.francis@wdc.com, ankita@nvidia.com, 
	suzuki.poulose@arm.com, kas@kernel.org, rick.p.edgecombe@intel.com, 
	elena.reshetova@intel.com, dave.hansen@linux.intel.com, 
	sathyanarayanan.kuppuswamy@linux.intel.com, peter.fang@intel.com
Subject: Re: [PATCH RFC 00/20] attestation: Add a common subsystem and TDX
 support
Message-ID: <auMR_GztmsRcEHpv@FV6GYCPJ69>
References: <20261015145053.3664509-1-jiri@resnulli.us>
 <592d643f-e97d-4de8-9a87-e47d57dc8457@intel.com>
 <20261027193629.GK1685504@ziepe.ca>
 <5f33aeed-a20d-4881-9ccf-a69bc308d348@intel.com>
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
In-Reply-To: <5f33aeed-a20d-4881-9ccf-a69bc308d348@intel.com>

Wed, Oct 28, 2026 at 12:09:19AM +0100, dave.jiang@intel.com wrote:
>
>
>On 10/27/26 12:36 PM, Jason Gunthorpe wrote:
>> On Tue, Oct 27, 2026 at 11:43:04AM -0700, Dave Jiang wrote:
>> 

[..]

>
>>  
>>> 6. tdx_attestation_test's discovery_and_construction_fields expects an
>>>    inheritance chain of 4, but the TDX family inherits ctlv-attestation
>>>    directly, which gives 3. In a real TDX guest it fails with
>>>    "Expected 4 (4) == ctlv_chain_len(self->dev) (3)".
>> 
>> I would have naively guessed this should inherent from some SPDM family?
>
>The TDX family is the TD's own attestation (TD report, Quote and RTMRs), with
>no device or SPDM in it. In wip_attestation_all_1 it inherits ctlv-attestation
>directly, so I think the test's 4 is what's stale. Jiri would know for sure.

Yeah, looks like the test is stale indeed.

>
>DJ
