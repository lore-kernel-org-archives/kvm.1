Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793884302;
	b=v2BrkAPv1xjMXf09OZ3JkIsF1w2tBUfwvUwp4/B7zJAfRlZ77iJY0gmJ24gosQbSjleP
	 +BSSYOpitcQMqMaY1SC/Euyq8gZY1AbXqnhkkApsi4lTG6ZoiYI42G/MDisjahR9yUYPK
	 jR+H60QBobqn6Gat+s8Nk7zz3tQ2u/o8BstUTGEgYHvYsGZdIbwAUUY3CSB1X5sz26NZf
	 iQSSRT8CfkedEwICuq7GhZ+mtIcjO2P88s2NZMSReuoEp9espfX/e2ojL6nuntfQqwI0B
	 5pSJlm4g5GHcgsVGj785dGH+QDwGZGtVTIq2RY38wd+gZsJ3ewr2Grd5ph2lLRiUv6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793884302;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=cFWG6Sga3Lp6k+n+muTvwPlAdm13M1aYQLJn0cvv/Mc=;
	b=gOY6Oqkro797niO4re0txmMKbKmIuxCfSj+D217m8HXP+hQHF6And4+7pweUvNoGis3s
	 OXRd+gHq7TTTrJ+oxSUFNrvYFo51X1DRVVlvMuc5dDFZiY+/nqJeu17GNHbfnTA2zM39I
	 5TZa9QCxprqIeZ8aQfK3AFROuM0+2rmEST2IHwgPoUxHJ219j5EAzLPkvVwyHjqX7CVa6
	 L0XTLlBpQw6YlsUxVR/pVLDbuxNNZCTjagLbSN3TjTa6iaIkiHbsnGE3kaDqE2u2ACqy7
	 0bnvMDvoclMr5Q9y04f29lUq7jW6VmG2HHGyg1jT9MO0PY8PCiIIEUBido52wQVRVIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=resnulli.us;
	spf=pass smtp.mailfrom=resnulli.us;
	arc=none smtp.remote-ip=209.85.167.53
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EC76606EE82
	for <kvm@vger.kernel.org>; Thu,  5 Nov 2026 13:11:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5EC76606EE82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=resnulli.us
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5be42ae8eadso1205962e87.3
        for <kvm@vger.kernel.org>; Thu, 05 Nov 2026 05:11:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli.us; s=google; t=1793884298; x=1794489098; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cFWG6Sga3Lp6k+n+muTvwPlAdm13M1aYQLJn0cvv/Mc=;
        b=O/WK73xDQgKKqiq4d4hHESILJFUUZ9SW6N85AxaK3rE7ZySNU3qEhKNIEYD1O9eQqI
         95fjFpuc79ZuTRElQ+h02Wj9E5V0JdSNQuaGTA2nDcJfjwcR6SkYbmUTwtS+3MD4FVai
         ypADZ2qW/Q/jvYffnvPAfE4QHI637QdVgl4zoT9tCL8MI048zRl+q75E6+KPj4p4A6Zx
         8ziMQe+vSfe4gTBqJH2XsnQLmfKmDFpDC5GOmuyWNS93SOEMOgYVkUvZ+fTkwWIqFQh4
         8Bfsje7zWlYV6r9bYcca0QX0n264DtY3WiqEOGm9x9Zo+Y7muxa/sL0dJGq9PlVpHr6A
         gqZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793884298; x=1794489098;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cFWG6Sga3Lp6k+n+muTvwPlAdm13M1aYQLJn0cvv/Mc=;
        b=XWmPpf89CDqdSQBpfzCvpQAkVcrUsgO6rqqa+B6qGv8xBTs25uavvbDnPhwMeAE5Di
         11kkkhMM8QhAXJFoPRDCOmlEFq6PzqOceP/zM61XcSAgK1zPFWFqJxlevpR4o8RuuSz7
         qHcFOQIi+1WroVfeYBWbNsQZwmgCm4wbjMyGhPG+Svzkgmu6MpF8VfA+f6b+iuzJ476W
         JIXOUznY0yzsratr88LM5ugtiNz9Qt40rDtMmBHoORvBqDWihwMKA7aKpGNTKxDzElJv
         TRKGJkat+A5CHrhCs8uvH6QAqXdKJdABeCuT45BHaQB4FybYrwAraYReKy4hIG9q0NEZ
         iIhQ==
X-Forwarded-Encrypted: i=1; AKwUvBwLwVXAPr21xV8UL9OPs9SnToVSzZeRraSE6VtLAxTsOZxtNtCidFn5Fsiezp7N4MIdnC8=@vger.kernel.org
X-Gm-Message-State: APuU4Z+kZOi5LUdpb7n2LKDJ2VXo6g4zPTQlfpoMaVB76QdJzjQVRRuP
	qOONukFIB5AxK1vIBmvMuqf5HJozUKDGfAc3rfQR1QaEpaA4HvZSC1yLIPWSOVf3sls=
X-Gm-Gg: AYBFou1EiCkoqicYs7lPbhx3oQedQR7i3frbEjVub6rGUbrA3V2KPGrr6Eqe1snfmT0
	FAnvzKmuX41kttjq6hqF3jZnr0F1YzxffTiItRYrR7myKc/zQHFJztt3LjW7luXv7VauWqHVpK3
	YzsV/Vwr+8hhdPl+vktNiYjVpnYN3KKgnwBPWF5CczmVgStkPtaxlAfwBiyS0Cll6SsTD4RJeL9
	XTTwepWJZQcMR5yBCOZZKxkEGahB/2r+iz9XXUvn4Hv+BTQvhkW1ccg0nMBzJiblr4RTGsPNjKw
	bEustrWjVnDNWMwH2ymRal+BfixIqcEgRdfGKyHX5m3kmlE7VMZCg2dEve3db474lt2+sDo47As
	MRyIfbt0ygyic5hugCSCo3OVMIrrcKT+hvwExCbjvzFIGnxonryNpy9qMjT3LkgJYg18gD2wHuy
	ZRkg94GR66Bgu3rfwAnwyEuVnktrquvH4kHR0D84t8vPImujoUpQW7loILequ3dZLWVRft912IQ
	0+iSfJ9gW5nJ86I5g0m9DJ7xNWCx7ZDBIaunPmPKnX27a8v38mU0KExhxIYhi8CZk6XSBByMco2
	lSt71PhSELKUgDRSvsLnTlo1oUSDJqtvoDUAEf9Nu4GL7lzpEeLjUjTGjv4=
X-Received: by 2002:a05:6512:128a:b0:5b8:fa05:e49c with SMTP id 2adb3069b0e04-5bfd9569d40mr7209047e87.34.1793884298157;
        Thu, 05 Nov 2026 05:11:38 -0800 (PST)
Received: from localhost ([140.209.217.211])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5bff38ab798sm817490e87.23.2026.11.05.05.11.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 05:11:37 -0800 (PST)
Date: Thu, 5 Nov 2026 14:11:32 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Yeoreum Yun <yeoreum.yun@arm.com>, linux-coco@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-api@vger.kernel.org, x86@kernel.org, kvm@vger.kernel.org, 
	linux-doc@vger.kernel.org, david.quigley@intel.com, lukas@wunner.de, ksinyuk@kernel.org, 
	rodrigo.vivi@intel.com, cedric.xing@intel.com, sameo@meta.com, drdeeglaze@gmail.com, 
	James.Bottomley@hansenpartnership.com, aik@amd.com, jpiotrowski@nvidia.com, qinkun@google.com, 
	pgonda@google.com, jic23@kernel.org, alistair.francis@wdc.com, ankita@nvidia.com, 
	suzuki.poulose@arm.com, kas@kernel.org, rick.p.edgecombe@intel.com, 
	elena.reshetova@intel.com, dave.hansen@linux.intel.com, 
	sathyanarayanan.kuppuswamy@linux.intel.com, peter.fang@intel.com
Subject: Re: [PATCH RFC 02/20] ctlv: Add the UAPI wire format and family API
Message-ID: <auyAJ8OMWHUTCFKs@FV6GYCPJ69>
References: <20261015145053.3664509-1-jiri@resnulli.us>
 <20261015145053.3664509-3-jiri@resnulli.us>
 <at-iEMxN98nie1Qr@e129823.arm.com>
 <auBaROC0XdWpILEI@FV6GYCPJ69>
 <20261027141524.GF1685504@ziepe.ca>
 <auC5sw9YMC9NO4wl@e129823.arm.com>
 <20261027151729.GG1685504@ziepe.ca>
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
In-Reply-To: <20261027151729.GG1685504@ziepe.ca>

Tue, Oct 27, 2026 at 04:17:29PM +0100, jgg@ziepe.ca wrote:
>On Tue, Oct 27, 2026 at 02:48:19PM +0000, Yeoreum Yun wrote:
>> > On Tue, Oct 27, 2026 at 09:02:14AM +0100, Jiri Pirko wrote:
>> > > Mon, Oct 26, 2026 at 07:55:12PM +0100, yeoreum.yun@arm.com wrote:
>> > > >[    3.856919]  ctlv_schema_check_attr+0x3dc/0x538
>> > > >[    3.857105]  ctlv_schema_check_indexed_nest+0x788/0x958
>> > > >[    3.857301]  ctlv_schema_validate+0x88/0x180
>> > > >[    3.857482]  ctlv_msg_test_as_deep_as_the_core_allows+0x11c/0x1e8
>> > > >[    3.857698]  kunit_try_run_case+0x64/0x188
>> > > >[    3.857878]  kunit_generic_run_threadfn_adapter+0x30/0x68
>> > > >[    3.858086]  kthread+0x10c/0x140
>> > > >[    3.858245]  ret_from_fork+0x10/0x20
>> > > >[    3.858398] SMP: stopping secondary CPUs
>> > > >[    3.858630] Kernel Offset: disabled
>> > > >[    3.858720] CPU features: 0x0,00000000,00b0802e,9f190bc3,2affe72f
>> > > >[    3.858872] Memory Limit: none
>> > > >[    3.858976] ---[ end Kernel panic - not syncing: kernel stack overflow ]---
>> > > >
>> > > >[...]
>> > > >
>> > > >I think it might be good to configurable according to architecture
>> > > >unless it's not good to reduce the CTLV_MAX_NEST_DEPTH number
>> > > >otherwise, increasing stack size when CTLV is enabled seems unresonable...
>> > > 
>> > > Agreed, will lower it down. I think we should be okay with 8 for start.
>> > 
>> > I'm surprised this ran out of stack though with even as few as
>> > 32 levels.. Is there accidently something large on the stack?
>> >
>> 
>> Nope.
>> 
>> When I see the each functions stack allocation:
>> - ctlv_schema_check_indexed_nest():
>> 	sub	sp, sp, #0xf0 // 240 bytes
>> 
>> - ctlv_schema_check_attr():
>> 	sub	sp, sp, #0xb0 // 176 bytes
>> 
>> Roughly (240 + 176) * CTLV_MAX_NEST_DEPTH = 13,952 (around 14KB)
>> consumed.
>
>400 bytes per nest seems pretty big to me...
>
>Do you have debug options enabled or something that increases stack usage?

KASAN is such an option. On arm64 with GCC 15, the stack protector and
zero-initialized stack variables, ctlv_schema_check_indexed_nest() takes
208 bytes and ctlv_schema_check_attr() 144 without KASAN. With generic
KASAN, which instruments the stack with GCC, they take 432 and 304: the
redzones around every local whose address is taken more than double both
frames. Your numbers are in between, I guess a different compiler or
KASAN mode.

Otherwise there is nothing large on the stack. 96 of the 208 bytes hold
the callee-saved registers, the rest are small locals and spills. It is
just two frames per nesting level.
With the limit lowered to 8, validation at the maximum depth takes about
3KB, about 6KB with generic KASAN.

