Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA9237BE70
	for <kvm@vger.kernel.org>; Thu, 30 Jul 2026 18:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785434819; cv=pass; b=XXjICpk7AdL8iqwAlaNeiF1rclpGP69dH5ekmQTup2Bm84NHk9+pqr2lx+YCBFeEhWrse8s7Hvk5doMir/YVy7FEisWj17WRU2FnVTJiZhQ9hrsR4tb+IJlkfdhqf+Xdkx03f+1oUajtK2chtVgoZVdXCi4xp3rNpQqj/PSvBzA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785434819; c=relaxed/simple;
	bh=dEihRTHtQ5+rqzTB5gZENLrIKf/vdVkf+94K6FYyTic=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fWc5sF0qy4GeS8rKd1gH9evTVpWI03DASnXGamkvJ1I3FlLDcY9UE/ehUfGWljvaiBk6OnLP8Tyruak8QX8CsuoAV3NrsEarJNcpHKewPMgyk+WQ4bdFC51xpSaHYo/Ci4cnLe5kKh1yrJfANV9mGwD3ZIsQyyQY8tU2ywXG654=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WxrUM/lP; arc=pass smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WxrUM/lP"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-38e347638adso273227a91.0
        for <kvm@vger.kernel.org>; Thu, 30 Jul 2026 11:06:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785434818; cv=none;
        d=google.com; s=arc-20260327;
        b=ZfQ2xxMvx6gT6cz0HG5fh9kz6gju0PBPcbyN4ymCy0pQmYKFGZBGvDTdTxBX+4r/vz
         Xu/I3a7M2JTIH8zvMQsax3kSEQyLxbOXFNtQsDMDCjrGIs4DpTGCDSRan6SI71ZxcTL3
         Z5qWsxQw24IgSuyaHW5YQ3MVXUV6bgsaxvI+uRPJPeyQsnZO6OTM+lIuMCDAUaGjOIP8
         +sjOP6+WKo62WY+IKBn8hsH+TkNm8VmPgBn8NHprkg/oFgWw63j/lpsxdLpbn+hNit7W
         2RfSEe6w6Mc97EV4vGKkfeM31/GdYwgLOp32SzX5mt1UYzvt0q828DoPckbgYGW5ZvSx
         khgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date
         :mime-version:references:in-reply-to:from:dkim-signature;
        bh=ksA4Cb+zc98xgjMVnrwp9nVxjWZKE5S3Fc2xP42UsGM=;
        fh=tiz2sWbDPPsLahhiZ1KQAdEMgPLocV7jB1S8kZKnHXo=;
        b=C6hbLX+tzHft7W7K3Q+5tnMYGB81AB5Rs5gQ2dDVXoodpfF79Qgd7s1FrqYEOybIB9
         8KSxVbfwx2tA2XKLPy+dO27pbeEC7CYj2yPU0HBzHl1AUPP77mK5NPAvlrkpULB2lYia
         9bg050RwkXeArYSf6zufqma7tBPN5T1LJJCKOCU9+N5yQY2Pf7BU7R13totXJ7A7nU2s
         nfb5msTVbLhVtMNo38ZK5S9nL8GKisFQafieBmP/6ZYPQRI7K3Ea+yMfb53TMTKSBZS6
         JHdB90SRQ3N6JOC6YklmYnKegDcw4aLbCsBs9/i/5WLk9m47EZ2u1B+sQVq9zDoaKqGW
         92FQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785434818; x=1786039618; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:mime-version:references:in-reply-to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ksA4Cb+zc98xgjMVnrwp9nVxjWZKE5S3Fc2xP42UsGM=;
        b=WxrUM/lPcAapFRGZbXH6xJgozHhdz2yAocZbk61fongUT978uD6Uzq6SHSCx+35sUr
         BTLX493gkQqr9BV9BVVdhBteLmmkz9WGvAKsWyK3UmcwTccOUQfQmw91pRhpBKQmb9ZK
         VKmrQCDjdLeh8z+GEeqrqQIJu1iKIXI9dx9TUJw+C+vknYyplcpM9v864OdxinSlwCnY
         VgQuKOKS1up1K5t2pq1hY4c2AFAEClyEYvdW9WsK2TNq9thuMJUfE5/lw6QCVYZe4T/9
         iht+FYaqE5Alqhk96DrytFjpim2twGvOyGTDVPUvHU1fI/B85peajMjyypYmFZF/Aspa
         FfTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785434818; x=1786039618;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:mime-version:references:in-reply-to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ksA4Cb+zc98xgjMVnrwp9nVxjWZKE5S3Fc2xP42UsGM=;
        b=L4m0cVJGV173HlYaOXld8bE7esKRN3CpeHJxJHsV29aoXTCZWR26jyXqim7jOooNMh
         6qNsNi51CTf3lkXJ4If9ExB5PKwaD2R5jsRCKZO6V9K1Ell4jKzCbrrGC5KCdxhC6GCX
         HPADd+4sH5JexAb1jrUw2rNJ935AQ6mGUi0JLEP5GBWKV6OunnbIwsl5MO/UXOC2In+K
         Vz6PBcjcleYqZu1fttovc6/vRtCv+lYsg33j2eSyzRC6WGxzAZPfdWPaNW+vUdhNPlUu
         1yJwSpPoRa9IyOOIThLak2zdIIwG+dtpnGhy4JJtNGqC/rH4utjAe3pvpOxse8ToRjQx
         WUbg==
X-Gm-Message-State: AOJu0YwCr8KSwzFPhwR0MpW+3zUxvGfN7AQL7sxG36bQng0yoja0viX9
	LSY9o5kUfnnT1AfxR1JVC7V19fLUjczYRmiJy1zvOfOpczEi7waQJDNPYM2Qa8E3QzJ9Al//IaN
	7uk1USXU5Q8+fGlWyQGO7guftaW1EeBBLqRvkglXk
X-Gm-Gg: AR+sD10mmBdp1uygnkSBuRUvLx0V0QnTyByGv0elwBnN4VBvi7HDz9TQDgZCSe3P/vU
	JDyGqjeSaccv5jgoz2frDP4iyf+3wZ0yPB41rgrvtPfvOaVL8Q680Gj/6CcMIrdg+uWJwZHCaG+
	6lMKjxqZUN+ycER2VmZgUSOciDgR6fJg9eaADrlriDbNbHd96Lhqq71A1jGt0kORw3SqcEURE43
	PoDks/5RpwHgwN8e+/NMTBnCBAi9oQvyKiQY5hUFKY4IRtLVw0MVwey+otJq4NR3/CrLC2SyDeS
	LzOWGwmrTMJJmw8f9QOfEhnZHwBcDETe5eokgFIuZBUielg/I5EdQ0NHbl8IohWBVkgzBd73lBs
	0t5dysacpcm2B/Qith67ve98DA2tVvvRpTdIufMG7IdjI
X-Received: by 2002:a17:90b:4424:b0:38e:2517:5d1f with SMTP id
 98e67ed59e1d1-38f9bd3e096mr2908488a91.9.1785434816901; Thu, 30 Jul 2026
 11:06:56 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 30 Jul 2026 11:06:56 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 30 Jul 2026 11:06:56 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <20260728122245.AA83D1F000E9@smtp.kernel.org>
References: <20260728121138.1103610-1-tarunsahu@google.com>
 <20260728121138.1103610-2-tarunsahu@google.com> <20260728122245.AA83D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 30 Jul 2026 11:06:56 -0700
X-Gm-Features: AUfX_mxg8N6Cgn4jHI_wA550VSPb-h9Q0N7SiD0v3YCrbcFHGVvI1NAH9Wyaw3c
Message-ID: <CAEvNRgGHuiXG1KZ24+kX-ZgTS_rqGPFqJMjoJhqf6GpZh4xN3g@mail.gmail.com>
Subject: Re: [PATCH v4 01/11] liveupdate: Add LIVEUPDATE_GUEST_MEMFD config option
To: sashiko-reviews@lists.linux.dev, Tarun Sahu <tarunsahu@google.com>
Cc: kvm@vger.kernel.org, Marc Zyngier <maz@kernel.org>, kvmarm@lists.linux.dev, 
	Oliver Upton <oupton@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

sashiko-bot@kernel.org writes:

> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Medium] The patch introduces the `LIVEUPDATE_GUEST_MEMFD` Kconfig opti=
on claiming to enable a new feature, but there is no actual implementation =
provided.
> --
>
> --- Patch [1]: [PATCH v4 01/11] liveupdate: Add LIVEUPDATE_GUEST_MEMFD co=
nfig option ---
> commit e0c3fde657d56c548cd9a7467d2143f0f42c5242
> Author: Tarun Sahu <tarunsahu@google.com>
>
> liveupdate: Add LIVEUPDATE_GUEST_MEMFD config option
>
> This commit introduces the LIVEUPDATE_GUEST_MEMFD Kconfig option, which a=
ims
> to enable live update support for KVM guest_memfd files.
>
>> diff --git a/kernel/liveupdate/Kconfig b/kernel/liveupdate/Kconfig
>> index 1a8513f16ef7c..0bbc4037192e9 100644
>> --- a/kernel/liveupdate/Kconfig
>> +++ b/kernel/liveupdate/Kconfig
>> @@ -88,4 +88,19 @@ config LIVEUPDATE_MEMFD
>>
>>  	  If unsure, say N.
>>
>> +config LIVEUPDATE_GUEST_MEMFD
>> +	bool "Live update support for guest_memfd"
>> +	depends on LIVEUPDATE
>> +	depends on KVM_GUEST_MEMFD
>> +	default LIVEUPDATE
>
> [Severity: Medium]
> Is the implementation for this feature missing from this patch?
>
> The commit message notes that this patch enables live update support for =
KVM
> guest_memfd files, but the newly added LIVEUPDATE_GUEST_MEMFD symbol appe=
ars
> to be unreferenced in the tree. Since there are no Makefiles, C files, or
> preprocessor checks that use it, this currently acts as dead code.
>
> Could the implementation be missing, or was this intended to be introduce=
d as
> part of a larger series where the symbol is used in a subsequent patch?
>

Sashiko is right here, I think this patch should be squashed with the
first usage.

>> +	help
>> +	  Enable live update support for KVM guest_memfd files. This allows
>> +	  preserving VM Memory backed by guest_memfd file across kernel live
>> +	  updates.
>> +
>> +	  This can only be used for the guest_memfd that are fully-shared
>> +	  and pre-faulted.
>> +
>> +	  If unsure, say N.
>> +
>>  endmenu
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260728121138.11=
03610-1-tarunsahu@google.com?part=3D1
