Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE9F28C2A1
	for <kvm@vger.kernel.org>; Fri, 12 Jun 2026 07:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781248808; cv=none; b=SVVIrmxb7TjYPaQ475Vjza24ID4W05FDVduUUtQKxVywkpmmpozUFSxt5CW4O9vaViWLgcudPyXgi1lxfWmf0wcRQcc8v7tTUQGVWjeHz4k7dKhJqobrvIz6VVcQZjSaIQZKAEDs/8H8f4l3GB6SwRfojM9I1w/MVoX1bf7FTCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781248808; c=relaxed/simple;
	bh=ryjtoG0uLs6In8rMlXtesQlQV0v+v56LEyi7wV0/72g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VPyGEFccnyhuMJ5I/MeDgM82fPQkpF6sOjlWBHLEOlc6zMdq8oGxRSM5Om4Us8ijNI912s5hjuWzVxTnHAmEH2kZAHmD8j809kqJHGuG6rO4DiXLWjNxtqEy72AV+/Pci9cjZtvYLFIw99tNER5kQfbsEK6NZI0EGpd3XHqxVJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Gs0bgZrZ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=rkbu9tnN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gs0bgZrZ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="rkbu9tnN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781248805;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=HMwwgD3Y2QW5ihjJpxtmbt/g9FkYngqzy+ZuQY8Cug8=;
	b=Gs0bgZrZwvUqu69f2nCS3G+Z4LsfI0ps7bv6/VdxxkaDLgGszA10/Bdq0B+KKoRwRVZBmB
	yzwdTOnpJpmG1PgpELV6ZWnjmwpIMCUUJt3LZVv1ANAtEnV6Efe1JR6kL6HjvZkDZ5LwHG
	Orzge80Y0kLYZvPBNUOjXAhhM+12saw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-156-1Xv3o27fPwSng0vNC7iaoQ-1; Fri, 12 Jun 2026 03:20:03 -0400
X-MC-Unique: 1Xv3o27fPwSng0vNC7iaoQ-1
X-Mimecast-MFC-AGG-ID: 1Xv3o27fPwSng0vNC7iaoQ_1781248803
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-490bfd70b0fso6080705e9.0
        for <kvm@vger.kernel.org>; Fri, 12 Jun 2026 00:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1781248802; x=1781853602; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=HMwwgD3Y2QW5ihjJpxtmbt/g9FkYngqzy+ZuQY8Cug8=;
        b=rkbu9tnNjwlDWEwLSg/95RXJCsAECT6FjhPqUP6WpvE/i5ntrhABGDidp7gib00lfI
         BHLcwL87MKi+V7FgLY4YTY6CNkoa87qNVPMIXj2r9A5FBZI969OLV7uvLvh/gvhgTy7R
         pAHtFefby3UrgcaHP22WYTRHVEfhP6KiasiSHdj5HtZGuARkkCiTC4ht1+WzNGx19hCe
         LjiPKT0UKbdExo0UJNxqLjJpZl5VRpj1jtua+APJyKIOE6TPSUBUxFZlDaore2PhAPM1
         Og50BPAL9Fjxwk/rqziHfW5eDwNllosP5MwWYAba5VOEiF8jxpr6Oh58CM+ED+if++kT
         QynQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781248802; x=1781853602;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HMwwgD3Y2QW5ihjJpxtmbt/g9FkYngqzy+ZuQY8Cug8=;
        b=rqcV9/z6JCX5SKaSCtfEogLh29+/qgUFPHnJ6bm4TT5Y0H3CQAjOAr7GeAPrNFVhaI
         ULakBT8ulDHvBlSU5zCCCNd2IgVNjRunUfRWG6E3qTxNRNxNb7oCVRD+43qFN5ONMqta
         hBsCqMyhncpi/WgusSv51k5k4PTU/GPbiSLi0CIY3BgukdjOQxJoENfPuSZM2pEhy+dP
         9EKmyccek19Z3//ORkAlxiNR5OXVjnNgSrw5rxBP+b5GkFYjonNVBGweQTxdhvnpkGIf
         39J7pxZ0woxhwuloAmLZ3JOXJoXmCifSJLAEimCyaBlUyYDuv94qt7dIevnwbOd8K7tA
         f3Kg==
X-Forwarded-Encrypted: i=1; AFNElJ/XQR+v3l0GABm6X566mHCpSriOmtgCsevsjyYY/cYue8ayBw6Eyhsx3SKEVzVmjfU5VG4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx24Jw77grzLrRy5o2/g1L6QTTMD8i+z3dLPOyjArMDOcC66PEK
	8ZCHk8XziBzPiIhE5S06WbtEETTP2xT8MpkB69GHbO7gGNqoxEoBjeuBfz3F84u/sfXa6h/K/gx
	O/zmjwbvofdH7/7IjDc2PTC5R4oXpNQDRhZkPZ9dPLn04ANecCc4HkA==
X-Gm-Gg: Acq92OEsBKs9T8MfKjEQY0x0Ys3u4rrgVpqfnsp38q3MdoBKPnls0UaQPXb6MKVvTI0
	kD93xBcd2lwdDz+4NZqQhxM134nMiEneB+1IKKL2jZTFR34ScCyJenHo5VMhuarCe4cvyQ3lfnF
	3+MdG4hwddJmnXA5wSZgkHPldRb/RMw7ZBEQQ9qkP6HpJAsThDgJJxTmOGshruGX7CEw3gdKXre
	hFw1Gfgn3w5e0+bwTaNua02V+pZDWSQhkkdRZe2et5C3RMUKJn8aqqV0iQB3DIMHKtcK5dhQ8oZ
	CbQdx0qf/14k9o27oV9/SF1TTSKzj7N6qj6jMGb1Rh098VHxoHK5YVkLDxFqpuzwMIq8S2vrMHu
	YCXQSLJp0F+rg+qq6xm33m8J6VfgoW5hMAFIGud24Quest1EIESvXg+qD2ZV/
X-Received: by 2002:a05:600c:314a:b0:490:b8c0:d470 with SMTP id 5b1f17b1804b1-490ec504d5dmr17290555e9.19.1781248802448;
        Fri, 12 Jun 2026 00:20:02 -0700 (PDT)
X-Received: by 2002:a05:600c:314a:b0:490:b8c0:d470 with SMTP id 5b1f17b1804b1-490ec504d5dmr17290015e9.19.1781248801990;
        Fri, 12 Jun 2026 00:20:01 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a? ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490ea4b2e8esm33863255e9.0.2026.06.12.00.20.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jun 2026 00:20:01 -0700 (PDT)
Message-ID: <04f37dbe-20e5-4be5-82d2-703cd4a9fee5@redhat.com>
Date: Fri, 12 Jun 2026 09:19:59 +0200
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] ppc/pnv: Replace Power8E with Power11 for 'none'
 machine test
To: Aditya Gupta <adityag@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, Harsh Prateek Bora <harshpb@linux.ibm.com>
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Nicholas Piggin <npiggin@gmail.com>, Miles Glenn <milesg@linux.ibm.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, devel@lists.libvirt.org,
 kvm@vger.kernel.org, Misbah Anjum N <misanjum@linux.ibm.com>,
 Shivang Upadhyay <shivangu@linux.ibm.com>
References: <20260610090800.3672832-1-adityag@linux.ibm.com>
 <20260610090800.3672832-2-adityag@linux.ibm.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20260610090800.3672832-2-adityag@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/10/26 11:07, Aditya Gupta via Devel wrote:
> Power8E and Power8NVL were deprecated since QEMU 10.1, with
> commit 264a604e7163 ("target/ppc: Deprecate Power8E and Power8NVL")
> 
> As Power8E chip is removed in future commits, remove the use of Power8E
> chip for use with the none machine test, and replace with Power11 for
> ppc64 test coverage for the test

yes It's better to be in sync with the default pnv and spapr cpus. power8e
was hardly never used even in 2016.

C.

> 
> Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
> ---
>   tests/qtest/machine-none-test.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/qtest/machine-none-test.c b/tests/qtest/machine-none-test.c
> index bafd7d660ec7..3205df190f35 100644
> --- a/tests/qtest/machine-none-test.c
> +++ b/tests/qtest/machine-none-test.c
> @@ -38,7 +38,7 @@ static struct arch2cpu cpus_map[] = {
>       { "mips64el", "I6500" },
>       { "or1k", "or1200" },
>       { "ppc", "604" },
> -    { "ppc64", "power8e_v2.1" },
> +    { "ppc64", "power11_v2.0" },
>       { "s390x", "qemu" },
>       { "sh4", "sh7750r" },
>       { "sh4eb", "sh7751r" },

