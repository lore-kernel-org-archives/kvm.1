Received: from mail-qv2-f12.google.com (mail-qv2-f12.google.com [74.125.230.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B623BB670
	for <kvm@vger.kernel.org>; Wed,  9 Sep 2026 22:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788993713; cv=pass; b=IWrig3zTukN1LysUURq0WvjXfxSd7sdyHbcoRdHDUyGQ+sbDTi79ywErRhoEREM2obDvqZTjV4gyRyapNztvyCQ1NIlyOu5rDS8mhIY9CpGiR1hioKV3ujEJzO777tW5njQLETwc6OdKb/86XyWlVw6NwCAvxUwCJh/do1uoecE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788993713; c=relaxed/simple;
	bh=NTWMXK3qBllEwS5xxNNJmOXFEuix2lqI2KW5LUWH0nk=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=szgeAsOcESTiWUv6YsukGrdcVp6Z7wM7F3KG9f8VLF0Wb/JjxG4i+TN2Rrtl6UHE6nQjGm2z4XVbS6x8Yoe5fcS+1zWau/WIrE0WnhifCY4KkGcZK8DxT6EB6V44fwuDuY1FM2rvp2olkHOcyDabW7R9NdcPKFaijLNMd+HX2D0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=B1wsTIOp; arc=pass smtp.client-ip=74.125.230.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B1wsTIOp"
Received: by mail-qv2-f12.google.com with SMTP id 6a1803df08f44-9106feddbdfso11168716d6.0
        for <kvm@vger.kernel.org>; Wed, 09 Sep 2026 15:41:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788993702; cv=none;
        d=google.com; s=arc-20260327;
        b=XACMcUL4MsjhN8L0BEWCT9usEg9LL1UK/DxJiLWIWjxr2q85zoQufp+u3IyEfiWAmy
         Eo8ZA9sdF4QdIvMU/6Xfw7aj0HXtvioKhH7Vi5edeUIRl1CKcyu1pd/nmWO850V9d1i0
         giTBC9avvTXdzOtUV+bqqOvYWd1gMK7jNCVPxpigYx4BmEtVeAQZ8nwLUN+FPXM1Nz2q
         V865g6bQh2bHyhAykpR92Udc+8eduufGwsOo8SbLYp8vEQn7v3xAKekCEGAUdYrlYdf5
         QsizQHmJDOfZ3FmOniMqmzjVdTtyOhvBsLKjwyYV2R2vx+Mi+E4qX+YbpIGkpwJT9hAy
         GZ/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=K7y90OKfcw5Kem65C7oA0LNo0uX7jIHf03YJVGFM0dg=;
        fh=6ODpmutqqNYbUev31tvz0Dhullk8wqpDJ2vEGerOgPo=;
        b=SOE+j7v2QlBS/ZHgt6PA5XPi+ERa9e1NBlUwM680Nr7wwv/u9xFUbtFqx+4+kvx+52
         u+vjHWZD8d6XQEYoYr1k2c3aBsiN0FwRI5fiUnBbxBMTPGtNg7KGgqB+xKZxYl6xVK6D
         5eUg+yt2ul1DjuIUJEyUQnHmw3g+4vGBsBMCsEFLDBNTO6h1O1egCUXQXaDxaOmmuIA6
         j8gKkYZaJ7EtbBdsKaIzJKGJXXRrHN5hsfkGvOnirktofUZCTDgQVBoeYPlD1P7rj3NZ
         JE8zZSMY2abCsn7CQMZjShBXgC/BwdT8YZIOUL8jBboW5CJKVdc3qefwQImTWH0+0n/p
         MXOg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788993702; x=1789598502; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=K7y90OKfcw5Kem65C7oA0LNo0uX7jIHf03YJVGFM0dg=;
        b=B1wsTIOpTTLlRdyo7iOhxu0xe7fGNCpeKh3IhkHQfmjdIC4vSh6klkJjA9Hw9ARivp
         cD7RzR4wahiryhTPoisN++V70pgym/VMBkIJzv9kKixE0wDdeXx+6ORRFW6qHEcj0a9F
         9IduYeH5U5u5+iHrDCciPTIE95Tc4Fla3FRLWBN86FLKfL8xAxru/Pn8g3FMrb2INcMP
         O0Jmn4RtYzNY+YjeDk5WduALFQWr6lL8i5G8FVHJRf1LcoR331P/MhaP2kEHDaY4ltlr
         qlC5KyzMf19Le8nP/1i3mz3ERyJu2AqimoJpTNK4CSNRxRoQe8J/aaNEaAY4nZRrCXMA
         jArQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788993702; x=1789598502;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=K7y90OKfcw5Kem65C7oA0LNo0uX7jIHf03YJVGFM0dg=;
        b=hth9jTo5okuWaAJ2fplBtTxfoALs5UvCL+DHqcN9RI/A8ySR6kdUM3b39gSDDzqLti
         hPEYgtNK4wPnJopZgGf8KLjwHaUsM/EhXsrPObpqmQ4IKsWmGTeZWeC+oMaBlmamuUDt
         fcoPoeuJ3nUjfq+2ZKQEMIhLDOXYc5tf/7Usm4iL2fQpBY4wZrq9quIBH5EsGaBdPPJY
         D25n7go3DmL4k4hiV2/Dwmqpzwj8wxE4xTjXqpNDZA598R+o+9fduK7OavNFxbPhrqov
         pd1/8FHJ+loBlQNUHlLtsxHn6nE+47rFOBRaUdDBVa+1GGvcMyy4I17kl3TWsVNdNCcU
         phew==
X-Gm-Message-State: AFuF++ks3ObuXRglIwO2oFD0cp8Ryjkj5W097DJfAHIuLsYvZWGUMis+
	DL5UKziEtU5jPAXAP2bMJ5IhorsT9uoz2804gpTqVMX+WQthPCjJSeps2qvpvqVy4UROR2A74KK
	BaklsX4U7On5TCXrm5LgiHAxwe8LppJHSh4/gZ+MY
X-Gm-Gg: AYBFou3PZUIiXC1ScctwlQrQx0ivmDsXt2mf0XDJ9UPGTwyzUmIVf2/jAqNOSQJZbsY
	YENGBuUV6AwgTiOQIBs0JwqKPOpdZJTLaOfvXA1jJ+n1OOo0OXYPungJJG5N5gl7G47/HAGasf9
	UYPT/cfccBbJIi2sVtJLyiMh4ZjSoMQxJSSJUNz5ZyrguF3llKIe6XJ328IKN64PVYmibHDFcpG
	UdunkxCvnjhZQUCwxbasXN2rpA9VxyUnmVoIZTOGa776cJFcQxbsss9w7kjlr+cUZxQApu9M/1Q
	yKyRgf9iyvzECk7ulEeSqA18S7wDf+FBcMZDSNWx+aITUZpBjZNZVMIb0IyjKHnQ0Wd4VYk0adr
	jipEnzePPm2kdtA/esf5ezAPTIxszbklC/3fTLQLw
X-Received: by 2002:a05:6214:4891:b0:910:345b:954a with SMTP id
 6a1803df08f44-9106b448140mr149416676d6.37.1788993697090; Wed, 09 Sep 2026
 15:41:37 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 9 Sep 2026 15:41:36 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 9 Sep 2026 15:41:35 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <20260902194657.79075-1-gourry@gourry.net>
References: <20260902194657.79075-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 9 Sep 2026 15:41:35 -0700
X-Gm-Features: AcwNN1WgHJXiyXU_ZBa_1-DE36OkQO7Bg_jMLCkg3DfJNHdXNcM4XNk-5IPdjJI
Message-ID: <CAEvNRgHWyBaBpZ4Bem1Eu86b-cuEA7NkyjxTJ4D3FnpGe1B2Yg@mail.gmail.com>
Subject: Re: [PATCH 0/5] KVM: guest_memfd: bind backing memory to a NUMA node
To: Gregory Price <gourry@gourry.net>, linux-mm@kvack.org
Cc: kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel-team@meta.com, pbonzini@redhat.com, 
	seanjc@google.com, akpm@linux-foundation.org, david@kernel.org, 
	ziy@nvidia.com, matthew.brost@intel.com, joshua.hahnjy@gmail.com, 
	rakie.kim@sk.com, byungchul@sk.com, ying.huang@linux.alibaba.com, 
	apopple@nvidia.com, shuah@kernel.org
Content-Type: text/plain; charset="UTF-8"

Gregory Price <gourry@gourry.net> writes:

> guest_memfd allocates its folios through a per-inode shared mempolicy.
>
> Today that policy can only be set after the fact, with mbind() on a host
> mmap of the fd. That requires the fd to be mappable, and it cannot reach
> folios that are only ever guest-faulted. Neither holds for a
> non-mappable (confidential) guest_memfd.
>
> Add GUEST_MEMFD_FLAG_BIND_NODE and a node field to struct
> kvm_create_guest_memfd. When set, KVM builds an MPOL_BIND policy for the
> requested node and installs it over the whole inode, so every folio is
> allocated there with no userspace mbind().
>

Instead of a custom API to ensure all guest_memfd allocations come from
a single node, how about these options?

1. Using cgroups/cpuset to constrain allocations (could be troublesome
   if the guest memory is not preallocated, unless the vCPU threads are
   running with the cpuset config)

2. Process-level NUMA policy

3. Why not request the guest_memfd to be mmap-able just to be able to
   set a memory policy?

4. How about something like fbind() that takes an fd and offset range
   instead of mbind(), which has a prerequisite on mmap()?

This doesn't exist yet, but I'm hoping to discuss this at LPC 2026:

5. What if you could pass an fd representing a mount to guest_memfd at
   creation time, so to make all the allocations come from a single node

    Step 1: Create a tmpfs mount, specify mpol for mount to MPOL_BIND
    Step 2: Get some fd representing the tmpfs mount, hand that to
            guest_memfd at creation time
    Step 3: guest_memfd allocations will always come from that tmpfs
            mount, and abide by that tmpfs mount's memory policy.

May I know more about the use case behind this new feature?

>
> [...snip...]
>
