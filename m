Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792657392;
	b=IkIZ0IOR9PRqYE4IEGW1Dqd00bkDV9aXaKtnGx8rttlrtMVpdNygwu1eaIegtuNIkNnD
	 /fFUn0+6Bz0D7nxZfK7QGMnBtbzX5rA17+zV5+R+SSEe7lboakpHU9vY2hFTH035XBr02
	 VOh91GJHge07ia+xlY/g8ZBGVPZld7J5FmAKxzU9tPoZ0gbTz72wfDWfDJuhZf3YNSTWl
	 6+qghHQ4hHfmmMjgr2bJG5H2eJdnN28/1d+WZ4hSrns9tJe9D+hZw0JnHowsZJMhXYNc5
	 7P1W32M1Cb+rgcOiW8LenE0C+iDpvHN9AJTVQ++oplbKE9oq9rhOCP9VNTWh1j9e+aw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792657392;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=jBzwZmEglaCeHy9uWRO0K+mSZ4Ex83WBJUpJNZMKjxY=;
	b=yeHOaMIIsN64frZf3XDffvnQQgIjhETZSMuc3koHuNI9XLA63N/J7q0SbSa/aIyWnm7U
	 iWDxr9c8C2IsJ3jsDEBsqWwgKgTVFOn7BD2DHSBPyO3fOayaoo70HY8PX1bo3CkHWcNRH
	 GIF784bfzkE8creKFwJ109F90BZwstiqaavFDz+v7qn1U1fO740Ly38f4SMtgNYvfQkE2
	 PvYZKi6WYXOYlj9pBOhSzvyisRTLMWEuLQJqrVLBcrUQ4+123J2url9Mru3Qo/kQ2AIT8
	 B+3pw7klwNX26KsFpnc0YlG9b6EKEctMab+7GmUIerWAOourGfA+42asYQiZ+b0dNoQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=resnulli.us;
	spf=pass smtp.mailfrom=resnulli.us;
	arc=none smtp.remote-ip=209.85.221.54
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76ACA606A329
	for <kvm@vger.kernel.org>; Thu, 22 Oct 2026 08:23:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 76ACA606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=resnulli.us
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-48b001cd92bso876486f8f.2
        for <kvm@vger.kernel.org>; Thu, 22 Oct 2026 01:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli.us; s=google; t=1792657385; x=1793262185; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jBzwZmEglaCeHy9uWRO0K+mSZ4Ex83WBJUpJNZMKjxY=;
        b=Kk9LAzaeohWWgjO7yOkoJiNXX0TzdzSZ/V1pSBH+WZZGAMzm+UyKX9kpWlf8CnmM1V
         vKe5hMis8H/B5q06XHV9CxdwFaPMvRFdq9eypt+YDGqVZGlXQ8ZWd/tlx/D8Tgnuy1TP
         r17zRtgzxdLTGYfdyHh7OOtZups0QoOmjy/FDCWhB2kq1rkuPtD8+W0b+Tnb3gjqb2tc
         oQ3x3eTAu0kdKTQRjyq73EAs4fNfbtFPhCl1+uTRYsRNI76x/uekofEGCX+5XMFIaNtL
         zKRFbrUKqKtbuSQWq2idDCNSmN9Kom0u5oOsxJAwvJMVbEYzxaKlhJbdyt8vzzDUCX1j
         GJeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792657385; x=1793262185;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jBzwZmEglaCeHy9uWRO0K+mSZ4Ex83WBJUpJNZMKjxY=;
        b=x7IS9fIpA5MmMIm0x/KY9xEZ/72WIRyiZej54L84A8ETEJzCBuGefwV4yllruvVA+w
         bAPAuylXFeg9Hdo/XdylYnq+x+B88OnBcNhAVtpZ45jrDl8I6huslkB3K4+zyWv/xG48
         zjWeJP12sC2YYd2U8ouVEUUtlejkpJLB4QKOmPW1vvHX/PF6L3qke6yy9WOJP/MNrTPy
         ciCwQAe9WEpoI3lGtl5aOXI2NBAlYG6n03u/M07WdEEQrpaeGcjk7lq8TvZg6n52v2OZ
         EbzG4tEl1FB0Cx8xf0JUGT+vbZups16CcBy4qcmfxxsgBnciKEplrVIyLADDdnugH5yL
         /Baw==
X-Forwarded-Encrypted: i=1; AKwUvBySNIGtdO8Z/NtxyEfjkLfwx0x8cHx1622yf80tDsksg0B0UKgdCWJJGBe9f50e2uY4hOk=@vger.kernel.org
X-Gm-Message-State: AFq9FYIGcxFpvy4RBvEqWD8qgkE2RT2EVpb0bge0IXPubaInZM2LbEkj
	hUVB9YojuId8NLvISG3iZasDbriA09HZVeLbYbwocaUzNaT0zeE39UYj5rtdIdFT7AM=
X-Gm-Gg: AYBFou2AL0lHTPHLgjsoIWKejR+UXoZOxxHFtW5+ob28LLAkPVbfa3iyWZY3ospj79s
	tH6uKdsiy9nza/KmLRbesGgrw8vqvyZkaNe3AWFYGXByHelCjMRPu5/dvUfjxSMtWBzn98o99VM
	x5dvU0SDz3dQ0fZa5/LfekCKfuJpl90Aokq6iL5BMu1g3M/1qQ7uO51B46IJ6tDktx/Ij9wFYhV
	70O9Wfw2rAqZ4LJXeEWsp3UTQ+k+3JsVNqLnDw1bjkoFhvF1mk2wr3/nc2ujP26fkW0PT13Xb2F
	HtfXK9YdaZ2nvRNjeTgH8BzCzT3P5+cnwbhiNaV4FSC4zF0D4s7XzMbSQtbXpPwYNcajk9M6wRe
	J10iXfORmcvV0DNkaQ5x+QTd+FBqBgi1skQocXLTg/jbzMnkaAIJJSwdSQRribRA7HaVmJM2rFY
	OEn261cCtP+l/JHwu7gF3ws7BEu7hhsPQxm/iG/3rCCj+3KSykC1UgF4mHePXSUG2UAYfUjqrjG
	1vzYLHpBkHo2R06YarWbakfzHnTv32/xOVHfrObeAb9gnp2zHogwRS7fZY/IkM9G7HDQdnBzXEF
	WexYnZEpEw==
X-Received: by 2002:a05:6000:490f:b0:48e:23e1:35ec with SMTP id ffacd0b85a97d-48e264db0b6mr9339116f8f.47.1792657384555;
        Thu, 22 Oct 2026 01:23:04 -0700 (PDT)
Received: from localhost ([128.77.52.125])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e254ef1casm8493784f8f.7.2026.10.22.01.23.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 01:23:02 -0700 (PDT)
Date: Thu, 22 Oct 2026 10:22:55 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-api@vger.kernel.org, x86@kernel.org, kvm@vger.kernel.org, linux-doc@vger.kernel.org, 
	david.quigley@intel.com, lukas@wunner.de, ksinyuk@kernel.org, rodrigo.vivi@intel.com, 
	cedric.xing@intel.com, sameo@meta.com, drdeeglaze@gmail.com, 
	James.Bottomley@hansenpartnership.com, aik@amd.com, jpiotrowski@nvidia.com, qinkun@google.com, 
	pgonda@google.com, jic23@kernel.org, alistair.francis@wdc.com, ankita@nvidia.com, 
	suzuki.poulose@arm.com, kas@kernel.org, rick.p.edgecombe@intel.com, 
	elena.reshetova@intel.com, dave.hansen@linux.intel.com, 
	sathyanarayanan.kuppuswamy@linux.intel.com, peter.fang@intel.com
Subject: Re: [PATCH RFC 13/20] Documentation: ctlv: Describe how to write a
 family
Message-ID: <atnGniIHxIV-vzVC@FV6GYCPJ69>
References: <20261015145053.3664509-1-jiri@resnulli.us>
 <20261015145053.3664509-14-jiri@resnulli.us>
 <179245258505.58760.3972297562218204862.b4-review@b4>
 <atjEgLYpgbZNzfkZ@FV6GYCPJ69>
 <20261021144951.GR3008132@nvidia.com>
 <atjiW8bnqDZ8zb5t@FV6GYCPJ69>
 <20261021164857.GT3008132@nvidia.com>
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
In-Reply-To: <20261021164857.GT3008132@nvidia.com>

Wed, Oct 21, 2026 at 06:48:57PM +0200, jgg@nvidia.com wrote:
>On Wed, Oct 21, 2026 at 06:24:12PM +0200, Jiri Pirko wrote:
>> >I haven't got that far in the patches, but I think it would be good to
>> >spend more time here explaining the fundamentals of how the extension
>> >mechanism is expected to be used..
>> >
>> >It looks like RDMA to me where you have some 'common' and some
>> >'driver' parts but at this point in the docs it isn't clear how that
>> >is reached. Like does each driver gets its own family? What is a
>> 
>> Depends on the consumer/subsystem. But esentially yes. That is what I'm
>> doing for "attestation". This patchset introduces ctlv-attestation-tdx.
>> Next we will have ctlv-attestation-tpm, ctlv-attestation-firme,
>> ctlv-attestation-armcca ctlv-attestation-spdm and others.
>
>Hmm one of the things iommufd does is to have several different
>drivers active at once within the same FD. There is only one char dev
>for the whole system and the VMM would operate all the hardware
>through it.
>
>So in that model individual calls are marked with the driver's
>identity when any driver specific data is passed.
>
>I guess that doesn't quite work in this model with multiple-families?

Nope.

>
>But it does work well here, and matches what rdma and fwctl did as
>well. So maybe iommufd is weird.

Well, one CTLV chardev is always backed by one device. I think this 1:1
mapping is clear in the device model. Iommufd indeed looks weird in this
matter.


>
>> >> >What about userspace, it "knows" somehow what to do?
>> >> 
>> >> Userspace sees the family chain. It also has ability to do introspection
>> >> seeing right away which op supports with attrs in which nests.
>> >
>> >I was hoping the introspection would not be essential to use the
>> >interface..
>> 
>> Depends on the user/subsystem. Either families_dump op could be used of
>> udev uvevents that also carry family inheritance chain:
>>     CTLV_FAMILY=ctlv-attestation-tdx
>>     CTLV_COMPATIBLE_0=ctlv
>>     CTLV_COMPATIBLE_1=ctlv-attestation
>>     CTLV_COMPATIBLE_2=ctlv-attestation-tdx
>>     CTLV_COMPATIBLE_N=3
>
>I wouldn't try to link it to udev either, by the time some userspace
>uses the cdev the udev information is gone, and may be unreachable
>from inside a container or similar..

This just gives possibility for udev to work properly. Depends on
the user/usecase if it's going to be used or not. Not sure what you mean
by "udev information is gone". Udev might use these uevent info to do
aliases, similar to dev/disk/by-*


>
>So there should probably be documentation in the subsystem how
>userspace should learn the driver family via introspection.

Okay.

>
>Jason
