Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3260B3E1223
	for <kvm@vger.kernel.org>; Tue, 17 Mar 2026 14:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773756420; cv=none; b=I/bdFyS2Rgka40pZfKzdh76+KZ3i0MDtJndl8u6LLGbHGspsG02JyfE7cvuRkKhvZ6O0DmvrwZzm5Z3f+NA4vRfkNoZxL9dcUXaAJTFLoG6Yr4KebCvQCVAv6tOJckE77j80NRSFoNgDZrex+jBFFIEZAgP9UzKZECLRTTT5608=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773756420; c=relaxed/simple;
	bh=LtZ1bq1gVGIgYyrHcxJSzToFhL4N9a110AW2KpClHR4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jBbvXVFvmQV+SmCBREwBbcePoMNRevgf6sOSpgSb0vEEBLX5Jw+8ineL6a7Auuuk1f/2h25h/PRlTy/GrXvCryeqWgMvOhkvBfhqCkLG8r5kDd+6SOyB5Sj+kWRyQrkA2WZpr6hw6HUE6Cgjp6DIw4QRUMadGOdegGNjId7NWmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EwAcDK+3; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=IQV5uVCX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EwAcDK+3";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="IQV5uVCX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773756418;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FYCriDWPGTLULEfwAIJ2oqQfVTihZkCcI5obnKPCotc=;
	b=EwAcDK+3fNu4+aGgf5B9P8ZNdk+EZ0H6bkJdLhwrY4KKOrB1Uv9MIo5DhkzFHLyssyVNLJ
	9gFbs2cNxXwZd8nTMYXd1mtBrKe5pNPOCq++hW2XfRBWPaerJSxQqhXGVnOtPM9s0nH+Jc
	i09E8MALs4SnS5/zjXwzoyhsfvuF8eA=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-678-iRz4qMuZMkmD5C8WOWrRRQ-1; Tue, 17 Mar 2026 10:06:56 -0400
X-MC-Unique: iRz4qMuZMkmD5C8WOWrRRQ-1
X-Mimecast-MFC-AGG-ID: iRz4qMuZMkmD5C8WOWrRRQ_1773756416
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-5094741c1c1so67061761cf.1
        for <kvm@vger.kernel.org>; Tue, 17 Mar 2026 07:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773756416; x=1774361216; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FYCriDWPGTLULEfwAIJ2oqQfVTihZkCcI5obnKPCotc=;
        b=IQV5uVCXx4m4tJZBF8PNDFRAfTcxyJfRcjHHQ/7TgBW/2Gk6jc5Q1lA/Zw2//qb3yw
         LovQYMcN/0QOivYR0QyhgaXA6hWDAoJIt3Ab20Y52jhOD1vnUqgO7pwJHKUNaLEyqeOv
         5+KoS7N+T+H++ButJPrK7dvfVGS5Sg2K4hkg07w68BDkYFZqtTBXxskaXslHmrZYnt0s
         ja9UyyIgJdwg6p+1PrZBzgJc/HIlaT1V9aAOu5x6mLv8M4xHITKeg7fvT0LAmxDRriuW
         O2P/mSJb1rAEREiwcWIQ3nTL5nrS8v10A+I+AirEpBovNzqhZGpn/75+XpP8x2vOas6Z
         wVcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773756416; x=1774361216;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FYCriDWPGTLULEfwAIJ2oqQfVTihZkCcI5obnKPCotc=;
        b=FgIJKPw/Lweb7yL4GP0/8FalFvIO+JruIvmDfvEPYnalm6OqZtJF7QQJEGUMwOKWpW
         d6OBS115eThqAWeicadMMKO7nFRtay+0xvQAfFZNS5LeOOXPVVl4tG4isjH3hTzVLJ0E
         Wtd+ZkfK/BolxXYGVVKbnqkeSkhCc0rFQV4dXWpD6uk/4wUKbkooP7gGetxuzAk0+YzV
         Q8VsP6ODvq8CWGsm7ki/IJhcLh+1rUsLJissLUQ2JyRwOkFO6gg4Mv8bKIZAy7yy5TC/
         rFb0xWIk/JUmpv9ld3zGbYoFrJaHqKrBwyPwEYNMN2Bj+70wly8iUqlID9/BV8BwuFRY
         pQPQ==
X-Forwarded-Encrypted: i=1; AJvYcCXvSX0O+e6bq9TFdyKiGEfXvZTo7zGuBuSL7tghAruGwVW0uqT6XxmG+RB06bWwLC3HDas=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5ZuY9G/hnqqibAae6gdtudZ6h3x1sWpQ2V1+S8ut03Y9s87v8
	T0YaP68quYaAsvreUxWoTZDBNKpm2eY2xJdWsF8sgvSlpdErTvVgBgHjhLUnQ5q2UXgyl07xQxE
	6C2Vd4uomETHLGrx/xFvkkcoxWowypEtceRHAyzyGAaY0ftXfMpLbgg==
X-Gm-Gg: ATEYQzxr68rNcS+dOb53AFGZ6VG/qI8QtS8Osq8s2JHa3N/ikNJONSKioUWIxB9GFzS
	0gXOQ6ys0AZJwTTJQ5op34JO1NbAm7Ti56mQPYhXyVfxjQyxbBcBcJOxLMdkaw/RhUlWDj3fgbZ
	mnW4adPGTn63MuleGch2sbrgESURnYGI4Pq9CkoWlhdijzwUl5R1TQ1l1GrDm9HNc552hxAcW3w
	1ga2sq+96AK53Xocxzdra8cld0oOKKfvOWgpMvERZF2GjSZktbvgQcRnFi5Xn83r2AMKWIUc2os
	5SywLhCnOPBmZn61vi8XVNzNo8fD7roarqrpmWCwIvTCc+8CFQQaDUe1qwTaCJJoVmXh3WKv8NN
	G6ASpVhOSbMzMVg==
X-Received: by 2002:ac8:5f8d:0:b0:503:2c16:c1f5 with SMTP id d75a77b69052e-50957e119fdmr216570351cf.48.1773756416059;
        Tue, 17 Mar 2026 07:06:56 -0700 (PDT)
X-Received: by 2002:ac8:5f8d:0:b0:503:2c16:c1f5 with SMTP id d75a77b69052e-50957e119fdmr216569631cf.48.1773756415455;
        Tue, 17 Mar 2026 07:06:55 -0700 (PDT)
Received: from x1.local ([142.189.10.167])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50939ecead9sm144115251cf.14.2026.03.17.07.06.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 07:06:54 -0700 (PDT)
Date: Tue, 17 Mar 2026 10:06:53 -0400
From: Peter Xu <peterx@redhat.com>
To: Avihai Horon <avihaih@nvidia.com>
Cc: Yishai Hadas <yishaih@nvidia.com>, Alex Williamson <alex@shazbot.org>,
	jgg@nvidia.com, kvm@vger.kernel.org, kevin.tian@intel.com,
	joao.m.martins@oracle.com, leonro@nvidia.com, maorg@nvidia.com,
	clg@redhat.com, liulongfang@huawei.com, giovanni.cabiddu@intel.com,
	kwankhede@nvidia.com
Subject: Re: [PATCH V1 vfio 6/6] vfio/mlx5: Add REINIT support to
 VFIO_MIG_GET_PRECOPY_INFO
Message-ID: <ablf_dVtYlZOoIcp@x1.local>
References: <20260310164006.4020-1-yishaih@nvidia.com>
 <20260310164006.4020-7-yishaih@nvidia.com>
 <abL5wKfPGzi88iBy@x1.local>
 <20260312130817.69ff3e60@shazbot.org>
 <abMfLQPzVFK388q_@x1.local>
 <fb6cb519-25d0-4cba-b13f-513349fb49db@nvidia.com>
 <abhZBIe-vR-GX3TT@x1.local>
 <accc2aeb-6ae1-4aec-867c-c9927e98f903@nvidia.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <accc2aeb-6ae1-4aec-867c-c9927e98f903@nvidia.com>

Hi, Avihai,

On Tue, Mar 17, 2026 at 11:58:28AM +0200, Avihai Horon wrote:
> Yes, this is because the VFIO device stop_copy_size may hold data that can
> be transferred only when the device is stopped, i.e., during switchover (as
> opposed to RAM which is fully precopy-able).
> Reporting it as part of estimate() didn't seem right, as precopy iterations
> will not reduce it -- if it's big enough (above the threshold), it may block
> future exact() calls as we can't migrate this data during pre-copy and reach
> below threshold again.

This doesn't look right either. I think we should stick with the exact()
being only the accurate version of estimate() only.  The problem might be
that the current interfacing for both may not suite well enough with VFIO,
because VFIO is so far the only module that may contain stop-only data.

The other known issue (not directly relevant here, but we will need to look
into it very soon) is when VFIO is involved the query-migrate results are
sometimes not containing VFIO data, at least "total" and "remaining" fields.

I'll see if I can prepare some quick patch this week to address them, or at
least raise these problem explicitly so you can have a closer look if possible.

[...]

> Yes, I agree, but it's a delicate flow in QEMU and need to get to the
> details.
> Anyway, this case should be rare and we can further discuss these details
> when I send the QEMU series.

Yep, that's fine.

Thanks,

-- 
Peter Xu

