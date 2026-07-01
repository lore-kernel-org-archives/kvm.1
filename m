Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6041D1F0E25
	for <kvm@vger.kernel.org>; Wed,  1 Jul 2026 06:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782889040; cv=none; b=J/V+hdsNTYzWxdEtDvjvxTP1fAzSGWW93tfspIcWsaom9bPav2ArftmKwz3plDbZuv8NlrmHRUoaKpDHfo43kGGrSStIicZuFXu14EKv4Dxheo/ifN4x+Jyup42g0g/w1SGnL+qw6SNiG0Weg9C75/kKiH/vlO3wJx4x1xV1CkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782889040; c=relaxed/simple;
	bh=v5hqlUAqqqIWuqB8AKVxFDVbPWO9Yr1oiUSORsVrU8k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gg2IibdM5k2C9i87TwGmgQLiA/5tFS6mx6FUHg6cHQWC6hoIHQUou14IFR5YXwCInDqHiyZvnwRT4ioXeKg4xhWdT5uEztaACd3Ip2duJQo12VGndERxi5JbiSNoVa+gmPJCKzsS1DH3ol2dfOvXxtOjoqNT2aRgp5bl0GdthM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M5ZSs0Wc; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=bv20BlP2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M5ZSs0Wc";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="bv20BlP2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782889038;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OsPLZhthgeNTmosmvhtfLrcyUwQKZWXNpePOYSm6rBc=;
	b=M5ZSs0WcSfRjFKjJHX4QdmAOLMBjz94XtSV+Tet+hoenuWC5VDl29O/OuGpn+gphcGPGna
	YhcXX7gxjgU0wibSROr6HYTRPUrEqG3Dpv5S/zV441djXMeKfdwMLx5jMavTErttFvJ0ZM
	ZIG8dnFrC0aVgVJ6BZF7P88KelBoboA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-194-3m1DvGuVP3yGycPUllwiQw-1; Wed, 01 Jul 2026 02:57:17 -0400
X-MC-Unique: 3m1DvGuVP3yGycPUllwiQw-1
X-Mimecast-MFC-AGG-ID: 3m1DvGuVP3yGycPUllwiQw_1782889036
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4926d371224so2678385e9.1
        for <kvm@vger.kernel.org>; Tue, 30 Jun 2026 23:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782889036; x=1783493836; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OsPLZhthgeNTmosmvhtfLrcyUwQKZWXNpePOYSm6rBc=;
        b=bv20BlP27tI4T2IA+W8Aecn6i69YCpcuFBwqxWx06D8APxDhuN5mSIuKmfWwigLxuM
         dJEGj2wqrP8x/GIHzCBYMud+oPapYS3GJZeymKt9E0EtnZdvW21G83j+Rek0BxnEEWWP
         Gnr/iLcC87fICXqUC1jZlwZoEulH5i1NhpdAnA0XBkT1b8RDkrqbixz3FSzYkjCxi49p
         8zDTycOcK4U3wl/M0i+nfOGaoMe7uAuAvutepfEhb6Kra7VIFwjFGrjJJ8XuUXXC+oF/
         65VNLCLg/r6m+pFrYZjzSJ8Ro99vA83nT80kcLBg1DwwTp7rz3YueHoFptV/MXQlLfuc
         d8JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782889036; x=1783493836;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OsPLZhthgeNTmosmvhtfLrcyUwQKZWXNpePOYSm6rBc=;
        b=dHxvI1kLNrWUk/G82kEmPLRmX+2qNTEIAcn8zzpwkOR9lqscR8q1e664OpnWP18o2c
         VkAHIBggy727jyCTUEH4Pow7TDNe7K1oG0byqe3GHMJFZv3+8sNDW5vox6+rSM0qdY1B
         bHXDA+6kM/jA+VFoMRIL/zaDxbeumTNVw74L0dzu6IKRafVnJQhU38SEGR+qXidmhqST
         wtAZgKWFDJ5HWeeUOsNlDuo+l471JLoLxXQxZn28MV3kJSM5gr3vrVcrBqtGFPKt4YyM
         wwTIlRXOUeHSW2qoNVjGNlHWQJ1pifLF13Z8aAi/RNqCJcI7FeNop/jHefAaigtQ1b6G
         AAaQ==
X-Forwarded-Encrypted: i=1; AFNElJ94M5DgOH/4H+OZuLnTZ4N1g6aa3Iaxh4JTFyOoaUn+btC2c8Ii7AoXgXlGcsAdHJPgA54=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzq3rBY3gpT6IIBRjGTesVy7+zfgDjxQD58QrPBYYNGQBO76JAp
	22Up+DvINfsTqjWPYXB70N5cbj1donNYMtcPn5b4WJHQekjtQmDD5/tdZP3w+sAS9KVrt5VIKkN
	y3IxifaVv8SYgKFyEveW9qyvxyIjCVDQDWK2rxWK10+YEXF0693bU
X-Gm-Gg: AfdE7cnUW+hY777Z+Z4CKU1MgVsdgDQhTjH7G5SKEKRw37ZZ+6VS11VdypDI3k+rn7p
	TuBQNqb01a/YCXcO9XjqwKxF1q1s7LnhMVkddjBC4bt4rV+Tp1z74YS1KJCddd2HyDonYxbr0gG
	IRId+qFW7W3ddAbt34Lgoz/SYyBFRAQ+RkX8Rphq33jrDzMullE1Gy+ZMBcZLG5ZMSodqCQmBep
	z15sUAZD2o5iDwg9ESi/2VKJ4DSF1QCE0jkHGetAYrjPi94oXEXhjTmSDTas+mSFcnrxeWJOIGV
	7B6C2R11oQLi/SDMkVf4Y/Te8Pl13sw8UIAa3pNUS6vZsbfb/IZ550+T7S4HLwfVATYatX46Xg=
	=
X-Received: by 2002:a05:600c:5749:b0:493:bc4b:b8d with SMTP id 5b1f17b1804b1-493c2bb968dmr2658825e9.39.1782889035987;
        Tue, 30 Jun 2026 23:57:15 -0700 (PDT)
X-Received: by 2002:a05:600c:5749:b0:493:bc4b:b8d with SMTP id 5b1f17b1804b1-493c2bb968dmr2658495e9.39.1782889035417;
        Tue, 30 Jun 2026 23:57:15 -0700 (PDT)
Received: from [10.43.17.14] ([213.175.37.14])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493bef1807asm32048695e9.1.2026.06.30.23.57.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jun 2026 23:57:14 -0700 (PDT)
Message-ID: <45022e92-7840-45c5-ba30-a276d736505f@redhat.com>
Date: Wed, 1 Jul 2026 08:57:11 +0200
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/1] Introduce an instrumented profiler using BpfTrace
To: Aaron Lewis <aaronlewis@google.com>, peterz@infradead.org,
 mingo@redhat.com, acme@kernel.org, namhyung@kernel.org,
 mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org,
 irogers@google.com, adrian.hunter@intel.com, james.clark@linaro.org,
 seanjc@google.com, dmatlack@google.com
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, bpf@vger.kernel.org
References: <20260630141152.3757722-1-aaronlewis@google.com>
From: Viktor Malik <vmalik@redhat.com>
Content-Language: en-US
In-Reply-To: <20260630141152.3757722-1-aaronlewis@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/30/26 16:11, Aaron Lewis wrote:
> I am proposing this patch as a simple way of turning BpfTrace into an
> instrumented profiler. This approach has come in handy for me more than
> once, so I felt like it could be useful for others as well.
> 
> I am not entirely sure where something like this should live in the
> kernel tree, so I took a chance and put it in
> "tools/bpftrace/instrumented_profiler". I am not attached to this
> location, so please feel free to recommend a better place for it to live
> if this doesn't seem appropriate.
> 
> I have included two samples as examples of how a trace can be set up
> (`kvm_trace.bt` and `vfio_trace.bt`). The included Python script then
> runs over the output of these traces to generate the final profiler
> results.  Example output can be seen in the patch itself.
> 
> Aaron Lewis (1):
>   tools/bpftrace: Add a simple instrumented kernel profiler
> 
>  .../aggregate_bpf_results.py                  | 318 ++++++++++++++++++
>  .../samples/kvm_trace.bt                      | 197 +++++++++++
>  .../samples/vfio_trace.bt                     | 315 +++++++++++++++++
>  3 files changed, 830 insertions(+)
>  create mode 100644 tools/bpftrace/instrumented_profiler/aggregate_bpf_results.py
>  create mode 100644 tools/bpftrace/instrumented_profiler/samples/kvm_trace.bt
>  create mode 100644 tools/bpftrace/instrumented_profiler/samples/vfio_trace.bt
> 

Agreed with Alexei, this doesn't belong to the kernel tree. For the very
least, the provided bpftrace scripts depend on a specific version of
bpftrace (e.g. they use macros, which are only available from 0.24). But
we could certainly consider it for the bpftrace main repo [1] or the
user-tools repo [2].

Looking at the code, I'm just wondering what value does the Python
script provide. Wouldn't it be possible to do the same in bpftrace
directly? If so, then including such a tool into bpftrace could be
relatively simple.

Thanks!
Viktor

[1] https://github.com/bpftrace/bpftrace
[2] https://github.com/bpftrace/user-tools

