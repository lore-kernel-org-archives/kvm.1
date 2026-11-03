Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793698199;
	b=CskyAWbfXqdGp/S3LbXDLKnkeMFpyklF5aBTTetbq+YPeNHelLZaEHHs9yr4Bfw7nYaL
	 ZWAXlzygqwt/IeXRDXspj8EKEvBQrasTDvPJKzxPhT1zAwhZam5Nl4abGMa+W7pZve/Yy
	 N9HKC/FUd1TMbBsdU2j26BAY+iabiltupLU9xysZU3A5jXqeT+IGbeCs+lElk5e7EsR8c
	 1wHfX82EIT/69fXbTXdHICpGOFvzP+ERnN2VqylL0BrdH+qtxfLDMu3vMiYk+nC3SLHXQ
	 Fza1jcmKtVMHl45jtnt5VT8i26eXZLRqxZKB5ZVq9nemZlYvGBGWD+LXNPIL8A0rpPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793698199;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=CkFM9E5nfWdnLbDGQzZA+rThnrcRob04z1+EqW99MTE=;
	b=h90l4qN5x+CDcJnTxQWpZZTsuEJ7WO9iZQzMY4p3EKVrBNrnFXN9cFY7dDRtH2C4gCos
	 O0PS6uXzV+BE3VjbVGutxMNUQbNRXSon8gCQO/PkEvvrrXr+PJKIWVfbWfRhszzEXDjzX
	 qkpm91TrOzgp0vpar4L2H3Nj5vYurqQKcGANuSCRK75KP14sMDh6OEpM/X175vug2GRrb
	 5vWuA6UN+kwQsH4QiiBO+FyrCU/Fk8beEGr2odBOCLkwYMTlnRIeoqsLenqOO6yrfDdkf
	 iNNpA0Sr6yW6JM5kGg63FiBreHgzcq9xuzlIyhbRE7ICm5/8KfOH7FQPjqdvhjsMGEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=resnulli.us;
	spf=pass smtp.mailfrom=resnulli.us;
	dkim=pass header.d=resnulli.us header.i=@resnulli.us header.a=rsa-sha256 header.s=google header.b=nD17MX4V;
	arc=none smtp.remote-ip=209.85.221.44
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C69606A326
	for <kvm@vger.kernel.org>; Tue,  3 Nov 2026 09:29:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 10C69606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=resnulli.us header.i=@resnulli.us header.a=rsa-sha256 header.s=google header.b=nD17MX4V
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-48e4831c028so3430645f8f.0
        for <kvm@vger.kernel.org>; Tue, 03 Nov 2026 01:29:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli.us; s=google; t=1793698191; x=1794302991; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CkFM9E5nfWdnLbDGQzZA+rThnrcRob04z1+EqW99MTE=;
        b=nD17MX4VzW88+nrnz9SgdcaYPQcOIkfh/S0yrXnMfUgiGGl0fkKSlltWyjDbQPyYMJ
         eyJkJVCpvVbC4gP0OT8sEk1TVUj+BlCLU49pQgURFggfuzWLnbpspFwvtmXmiSM7p97k
         Avk1+QdCZOKyymL8Xg/4fiDOAl4JzMdXU+h4yuR2KLxssHGZ1M6W1XKjWStlpIxt+gQG
         EFvhWnv2HNS5oUqS9tj0RFT7ennBps/r5yNAsEvJLGB++paTLGgKMOvxgHjaZHrL2mF/
         ShzDEeNLBnaPa9J3paZGOvdsYyNmHo4uMXZnKOLeuiZJYrrkShVMAtnqhblAA5vTMEZM
         xpHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793698191; x=1794302991;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CkFM9E5nfWdnLbDGQzZA+rThnrcRob04z1+EqW99MTE=;
        b=JB01Gx0KS0azQI5nFtlPwJMnKaDSO7quKjzCSPSqIIqOydF3lxyEcI8nSvWrOBtL1P
         2w9xs96yToc5O+8LTmly9u7Y0BvImDCHyx2guSwzxmwF6qSJ9FVBw8rrrqo9q4YJ2XyU
         CTyKkA/ukWZwwc0PWp5Thza6fa8rWIw8CdfSxj2CvF33u7nlZ3juIDmbwo38fMcBBGZ7
         wyQ9Bxv5a0ps6Xlr0CIZBlnwd1FAPemhOkXqdDUeUO9+qxdi50mIrIeRzp9pyi3wfO6+
         lJZjcruhIAfn4bfbdYzb5TKNSe84c0JtwtvvPVUgqkoAvgpU/D315ByuJHLwS/4GY+5j
         2Jcw==
X-Forwarded-Encrypted: i=1; AKwUvByLEN9ta1jbu9Z244N3As/srl0oOp3t7o59LJQr0RAjR40nilKpFSpvZxd5vd9Or9bln6w=@vger.kernel.org
X-Gm-Message-State: APuU4Z/1cQ1cNuh6aAljNzd/eprmC59+amYUp4F6/6KPJsvtYbMmPRAP
	R18COVD3axquzZy51ynLYyzdO402QspZ8qz5CXVEfR9qEBdC8ms38bskhX9lxBbQewM=
X-Gm-Gg: AYBFou0sj65z05GhcjmDW3fC3Qnvm63NdXGCXrSG8r2JIRdLMtAmyPL/OZ3RqHqiW20
	mHrM0kFJk5SGTsLRjUB4jOluGZnNflL/g92/Rf+hYe3FSE00lxlIAmNoTS/5epULko7TA/VKSCs
	tlNCN7BFj92MrhdjExiq8N2VeLyQQ0sxOvtLMzNhFOKZWO1kXv9xOTnhnpZPGUozryE2B/q5ZiG
	oZDdMuIM02KX4+ZL1l3EXKzxWpD4b8141w57M+wyGoN6ldDRCpIdKApftkqjqOm2UzccCBjSZAE
	qdvJrYzc6CPO2fKLnZC4TEUrbE42aS0PyRJ0nArvfQTiOD3ZO90523Jw08veArmfrgOGxWQd0kZ
	x7fTRdPdptGu6p7qLKo1aRbQgikIEIzTvaohUnKtFQF5Eulqf58QNJAx5+OIJ5TKyhtjJzqdprk
	6dfwGYC40CeHBYKtkVji4Ai2RVEZKOhUfa+6mBOICrfKWuwzncCWSl7T6ts+WFV9PPjfO+Yu5Ie
	1NzyxFjCFqWqO9coIqGh9bZ7Q+0V3MRuB/sVXdEyA0tjNUiJL8xkuub04avpVFpRvap6iFa62mw
	7HuGWzbyt6RpRr9+rVDBBfjf0f/Lpze+jEOg
X-Received: by 2002:a05:6000:26c1:b0:48e:870:7791 with SMTP id ffacd0b85a97d-48e6e30b824mr25816174f8f.26.1793698190820;
        Tue, 03 Nov 2026 01:29:50 -0800 (PST)
Received: from localhost ([208.127.45.21])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b80eb1sm25441683f8f.34.2026.11.03.01.29.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 01:29:50 -0800 (PST)
Date: Tue, 3 Nov 2026 10:29:45 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-api@vger.kernel.org, x86@kernel.org, kvm@vger.kernel.org, linux-doc@vger.kernel.org, 
	david.quigley@intel.com, lukas@wunner.de, ksinyuk@kernel.org, rodrigo.vivi@intel.com, 
	cedric.xing@intel.com, sameo@meta.com, drdeeglaze@gmail.com, 
	James.Bottomley@hansenpartnership.com, aik@amd.com, jpiotrowski@nvidia.com, qinkun@google.com, 
	pgonda@google.com, jic23@kernel.org, alistair.francis@wdc.com, ankita@nvidia.com, 
	suzuki.poulose@arm.com, kas@kernel.org, rick.p.edgecombe@intel.com, 
	elena.reshetova@intel.com, dave.hansen@linux.intel.com, 
	sathyanarayanan.kuppuswamy@linux.intel.com, peter.fang@intel.com
Subject: Re: [PATCH RFC 11/20] ctlv: Prepare runtime introspection
Message-ID: <aumogVKtYnY0QJ2r@FV6GYCPJ69>
References: <20261015145053.3664509-1-jiri@resnulli.us>
 <20261015145053.3664509-12-jiri@resnulli.us>
 <179302367452.58760.11808905856343064399.b4-review@b4>
 <auRmMPfaFINUIchi@FV6GYCPJ69>
 <20261103010537.GI3889730@ziepe.ca>
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
In-Reply-To: <20261103010537.GI3889730@ziepe.ca>

Tue, Nov 03, 2026 at 02:05:37AM +0100, jgg@ziepe.ca wrote:
>On Fri, Oct 30, 2026 at 10:53:11AM +0100, Jiri Pirko wrote:
>> >So.. how about could we drop the sets, use a direct description of the
>> >layout and do something else for the ID numbering? Maybe the numbering
>> >can be solved directly by only listing the names in:
>> >
>> >numbering:
>> >  - device-get.reply
>> >  - device-get.reply.caps
>> >  - device-get.caps.evidence
>> >  -[..]
>> >
>> >?
>> 
>> I'm still committed to implicit numbering. For "inline records" I
>> resolved it by having it encoded as a tree with 4 levels:
>> 
>>  63         48 47 46 45        32 31  28 27  24 23  20 19  16 15               0
>> +-------------+-----+------------+------+------+------+------+------------------+
>> |   family    |kind |   index    |  L1  |  L2  |  L3  |  L4  |      field       |
>> +-------------+-----+------------+------+------+------+------+------------------+
>>               |<------------------ record ------------------>|
>
>Fascinating idea. Sort of like an oid
>
>I guarentee we will run out of bits someday :) I saw recently we ran
>out of bits in RDMA :\ 3 bits seems like quite a small number..

Well, this is just for inlines. I think if user comes to the point this
will not be enough, he can use named record, as he probably should with
more than 8 inline records anyway :) Also, we can introduce "mapping"
mechanism to allow inline conversion to named record without breaking
userspace. I just didn't bother to implement now as it is a theoretical
problem now as I see it.


>
>Maybe increasing op to 128 bits?
>
>Maybe family/kind/index/field spread over the first 64 and then the
>Lx's over the second?
>
>At the very least there should be an escape hatch so that if this
>becomes too small there is a way to opt into some new layout and fix
>it without breaking everything.
>
>Jason
