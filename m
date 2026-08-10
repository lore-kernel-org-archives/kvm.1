Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69C7C3B5302
	for <kvm@vger.kernel.org>; Mon, 10 Aug 2026 10:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786356854; cv=none; b=cb/JASuocg9s+Vyr6xxcj2ZnU9mlMejWgJrf8yrbtd11e1hgnh+FDETtsMEgFcmZoHa7ViMi0baj2AuYfrdEkJRdtkOeoJU0tm+eTEvpHyXf1GdDD+gAl4uS2JJ4XAtxr2PR2i4bAhD0G1l+8hN7PeWlAQjFQIObha/pjfHrKaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786356854; c=relaxed/simple;
	bh=KhRqqZzkzINqMrhJjmlawWrpCrwFP6oGdf7PTZcoZUI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=L7/Yr7B2B8otYo2syo0yTyrE+aaBW1bBBWJieUwbarA+flR4VopkWD8Yv29kHpvQ2lnmbreinvyIm9dFPdZMiISfg1pHt5Y6Auv5bAWcaangNh8YZtdVUCbJeO7B8NRpu2VT/P1Rfcx8SkOjBpuPXc/zpk3sW6NqIShegAJafb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tarunsahu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kOxs23Wa; arc=none smtp.client-ip=209.85.208.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tarunsahu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kOxs23Wa"
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-6a0a4f0e0cbso2024287a12.3
        for <kvm@vger.kernel.org>; Mon, 10 Aug 2026 03:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786356851; x=1786961651; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=q7bDX99X8heKfUMDjEOLpp44Kc2HBY4XoCrDNhJpdWw=;
        b=kOxs23WaTkdm0z4kpv+3d+vobW3VA4u++gURekhYwnrq4KhA+9e63+cJBP8Dz5ntA7
         3kfUfnZhD83IDTmYO+blfEwps6kBl9KIcXymFhcl1E2gzfEfB5eyNEZlmpxwNuFu5xXY
         ctieUQCi8rRLVN/t00SQ2a/SXXMMEgpA6lkHZ2EnhdOpyXva8jcraA9F2IildZDNxtor
         VI1nB7AR8IjolCISmLq1FX+if3tysUaNRvfdwbRs1169OotRAmJ6VSZQDd6zj8MA+DKa
         LWtv4WwdgMDo4xfkVfmIaCTWtnkgZD6fgfSAquvOeOhWqN0x3aZu1rr1OMCGQPkOIvnt
         1S3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786356851; x=1786961651;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=q7bDX99X8heKfUMDjEOLpp44Kc2HBY4XoCrDNhJpdWw=;
        b=jUhLLvaWeYdh9m5v6Omji/SEgwx0K5A4Ph3vPGhu4hHz80fhCHHyruwzVaSkbE4VlP
         gmSn+PgNoUhcmdUmmjCx2Y6Gk4hfWuB+dtKdgV/YNaieG6OuvfaIE007jERdKe5lY61I
         DgEDjT7wntNfml2OGOov3SDfWrpz9uOV0XPjIxP52eStnyFi95bUytpSRMMpS4UUztGd
         3xyVG19GJbosukCWxvWvl+jo1lVYQk8vfIIuxuBVpoUq6fdPSeyR1ODg+EPkqOFo0m65
         a9AtNvDKcYvsmh3hbyPBeur9Oxy2iSCwU6+VpaZRJJGuP3Vgj5dx8MVG/lHNDZdxYQhk
         q3Cw==
X-Forwarded-Encrypted: i=1; AHgh+RpvU5GH+ZQd81MyGbO8J5dqi2wszoJ4gn5oDAnjpBwtVgyFFG62rVWVpUeA2DPzqMDKdak=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKLBnUrzT4dxq0WqaQH1uNU0kYH//db99xhUvaCeEVDsx5hkbl
	tnH572AZLmPQBmiHKFuD4I1OFW/TnNCYZOEa+U3BG8/L0CuwriUt2EGRVlEjaoULo5GAer5y3ti
	cvV2anfo511BCISpR7g==
X-Received: from edtp18.prod.google.com ([2002:aa7:cc92:0:b0:69a:bfa3:e91d])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:a00e:b0:6a1:fb92:b3c3 with SMTP id 4fb4d7f45d1cf-6a355e19d23mr437843a12.12.1786356851307;
 Mon, 10 Aug 2026 03:14:11 -0700 (PDT)
Date: Mon, 10 Aug 2026 10:14:10 +0000
In-Reply-To: <CAEvNRgGazT2D-G7sEem4RD5nUEj7dmcg8vx2=3bpatS_o5uE+g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260728121138.1103610-1-tarunsahu@google.com>
 <20260728121138.1103610-3-tarunsahu@google.com> <CAEvNRgGazT2D-G7sEem4RD5nUEj7dmcg8vx2=3bpatS_o5uE+g@mail.gmail.com>
Message-ID: <9huzh5l28eq5.fsf@tarunix.c.googlers.com>
Subject: Re: [PATCH v4 02/11] KVM: Introduce kvm_create_vm_file() helper
From: tarunsahu@google.com
To: Ackerley Tng <ackerleytng@google.com>, fuad.tabba@linux.dev, 
	Andrew Morton <akpm@linux-foundation.org>, seanjc@google.com, dmatlack@google.com, 
	Shuah Khan <skhan@linuxfoundation.org>, Jonathan Corbet <corbet@lwn.net>, david@redhat.com, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pratyush Yadav <pratyush@kernel.org>, sagis@google.com, 
	Paolo Bonzini <pbonzini@redhat.com>, Mike Rapoport <rppt@kernel.org>, Alexander Graf <graf@amazon.com>
Cc: linux-kselftest@vger.kernel.org, andre.przywara@arm.com, 
	michael.roth@amd.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	will@kernel.org, vannapurve@google.com, maz@kernel.org, fvdl@google.com, 
	kvm@vger.kernel.org, oliver.upton@linux.dev, kvmarm@lists.linux.dev, 
	alexandru.elisei@arm.com, skhawaja@google.com, aneesh.kumar@kernel.org, 
	linux-doc@vger.kernel.org, David Hildenbrand <david@kernel.org>, yan.y.zhao@intel.com, 
	kexec@lists.infradead.org, suzuki.poulose@arm.com
Content-Type: text/plain; charset="UTF-8"

Ackerley Tng <ackerleytng@google.com> writes:

> Tarun Sahu <tarunsahu@google.com> writes:
>
>> - Move ITOA_MAX_LEN to kvm_mm.h for reuse by upcoming kvm_luo code.
>> - Introduce kvm_create_vm_file() to wrap kvm_create_vm() and
>>   anon_inode_getfile(), providing a unified VM file creation API.
>>
>
> I think these should be 2 separate patches.

Okay, I will split them. Thanks
>
>>
>> [...snip...]
>>
