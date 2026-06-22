Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A8F534C130
	for <kvm@vger.kernel.org>; Mon, 22 Jun 2026 20:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782159806; cv=none; b=TWmNc7CeslPWpIv+JJxK1+X6D3uOhYAzXx7Y+LZaoZnpLXQuqTuQVkBGVATU8J3BXJX9MdT3C0kHCrLSkI0+gGv5+Wnw01TqmUrPZAkKEBJ9OznkNPDKIDfC3xZN9W+HAsvyo7MfglJnDx58vD7f79uI5fkiQ3ilbqjEKZzqmeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782159806; c=relaxed/simple;
	bh=GOCXVxUweLMnCkGmSJWoVQbh5WYUAviYOfgNB9Y2gbE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f9nsyz+QrsgFnKpw9GYIXdwP6Ifrd/EYPP1ItM51AeA8VsBOUnCA5Zc5Nbg81jrOnZElyipxGYQIkVMBG8kOOjvu8tZ+PAKP0GJMMaPkdGw5271RV7ljpRy+Cm588/jCoWPZjZbjhi/6G7oXblfqGvSDqYz5k/4FEPZIv5UDeCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KJWrlGZq; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=hKgRajIy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KJWrlGZq";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="hKgRajIy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782159804;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CPEP6gHhqNKJhrtW+PUpBGCpELK13U8EoAVNjsbwg7M=;
	b=KJWrlGZqIc6M/vOsPByFkrbbCjhoux+zabjb0Es+qeSNZTHrkIPGKLtUDHmMSsotefms/y
	nGPBWZdNYYENxAI7wB3eEC6XgmVCsJQdkst8ucmOfgWwVsRLZeok2ru2ufRuwWXyDIqV+j
	taDwcueRY41bUncb1AYAGQg6M5OeIqw=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-21-WZecYUCxM2q3HLbokIyV8w-1; Mon, 22 Jun 2026 16:23:22 -0400
X-MC-Unique: WZecYUCxM2q3HLbokIyV8w-1
X-Mimecast-MFC-AGG-ID: WZecYUCxM2q3HLbokIyV8w_1782159802
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-8cecf8bb835so81579286d6.1
        for <kvm@vger.kernel.org>; Mon, 22 Jun 2026 13:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782159802; x=1782764602; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CPEP6gHhqNKJhrtW+PUpBGCpELK13U8EoAVNjsbwg7M=;
        b=hKgRajIylfdD70gdbvaOAyCQme3lE2ui0P/3t1fhL/MTtjWs6pm6N8MApfrYs/3zcb
         jYup1nQxQfTJg0eYXlwrAqGvGH2pp2TCsK0iqxPr/YStl+jk0lXBE/YRd5ZfegqZXjm6
         JYPanCaMRVaVl8TdUgcJXXlrgErmEjnYqfDhFfibWBqv/zVE7BmEJp+FW30WH+nJzCX9
         HKwgcHZzZQ5q0BHVFqaZp7fKaHyY2zxPD0lMNs3kBqjKwnIXrt5j2q5BOWZHkj5eGEtl
         Mhda9buIIy75040R2WK5nI6/xM9+qmqvGkQAez31NmvOby4wjepT7EWVOO3xCqsqEg+Y
         ikDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782159802; x=1782764602;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CPEP6gHhqNKJhrtW+PUpBGCpELK13U8EoAVNjsbwg7M=;
        b=iE2jibEdJ07xZKKpDXQHPav/jDOgYRF0MbW23q9YfFeNGoy8e+V5sd0kPL5vj4e7D7
         Gb19JyIPs4MxvdCOOhOr9RKe2baoIkMANrOn726zsD/ZKTajFOOSukOYHQdSZMXYu6Dd
         yCH49vHWHkfAvUWMrkEyrJcK7J5j2WVUmnQ0R8SEqwGoiCKxUdceBPU0oKP/XicmK3/X
         YbKx3tNbaVKfS/FMl5ySzpyCdRjSFftFvODTHaKLYL6RwtjYvvYn/2Aq8LL7ekX4b9eX
         IvG7EfHJqgaheMoLqsGrLvGjpxIM4dMIFZAdjU9hNb6HUbaZIXVCpyPjpIF8xMmW9o/a
         enEw==
X-Forwarded-Encrypted: i=1; AHgh+RpU0szqsmvCaq+ybayhKTeyjvfCq1gSWIdx98zDk9IvyjdVYNW1u4pyZuq2VjQWNvXLNyU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQY0QHr9a8/ZlT+GSKrm2rKWA/vYsyMCpgaV80HafdtLxDbSSK
	AvFBg32Jm8PLz+GhYy0tQJB5Sws1z0mW/d9zSxd6U+KMyhWbdZ69XXSxsltvXZWoZpElh0q2L+d
	ltIfK7LFy8pZxRhVP8+yVlmYmXN5arqO37xImpj5D95qdXzrEowzJ3g==
X-Gm-Gg: AfdE7cmdnS+ujpfIDokt8bhdihmIxVKCEcpyW/NpHTLDezSOpJPmpbWd16VoQZAuKTP
	3g3xnl+uKcy8M62cM6xZtpREA2vpXnWCExvY1PJcfmOuCzWcqQjNmT1a4+J5T8f4nZEtnqlWEvK
	uZOlE9h/dqp3HDCTJc0Q+ULVUY3KejOph7SW8DUfE8QSgzgwP5TwhxOfIkt2OXPWKvx1bjbNQy0
	LFi35TQYiQsHwj4Zc1jZlU2SSYB+w3UaXBHGpfyfMaCHvPQ/QoiHtLL8CEM12oE+cWo7P0yvJR5
	pUhEEIS3924KbusRr++OXVmAKxE/p85ABwm9Hry1yZNvz25/Dw5Je4G+5ZkMFOn6X9WC6C1UZZM
	UdWo0
X-Received: by 2002:a05:6214:e6f:b0:8ce:f1b:74ea with SMTP id 6a1803df08f44-8dea3ae3fe8mr249639356d6.24.1782159802118;
        Mon, 22 Jun 2026 13:23:22 -0700 (PDT)
X-Received: by 2002:a05:6214:e6f:b0:8ce:f1b:74ea with SMTP id 6a1803df08f44-8dea3ae3fe8mr249638636d6.24.1782159801550;
        Mon, 22 Jun 2026 13:23:21 -0700 (PDT)
Received: from x1.local ([174.91.117.157])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8df81cde303sm105884836d6.25.2026.06.22.13.23.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 13:23:21 -0700 (PDT)
Date: Mon, 22 Jun 2026 16:23:09 -0400
From: Peter Xu <peterx@redhat.com>
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
	Hanna Reitz <hreitz@redhat.com>,
	Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
	Zhao Liu <zhao1.liu@intel.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Anthony PERARD <anthony@xenproject.org>,
	"Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
	Fabiano Rosas <farosas@suse.de>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Reinoud Zandijk <reinoud@netbsd.org>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Alex Williamson <alex@shazbot.org>,
	=?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
	qemu-block@nongnu.org, xen-devel@lists.xenproject.org,
	kvm@vger.kernel.org
Subject: Re: [PATCH 0/3] migration/ram: Abort on unsupported migratable RAM
 changes
Message-ID: <ajmZrT1d0QXCWTNq@x1.local>
References: <20260611-ram-v1-0-a2dacf699718@rsg.ci.i.u-tokyo.ac.jp>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260611-ram-v1-0-a2dacf699718@rsg.ci.i.u-tokyo.ac.jp>

On Thu, Jun 11, 2026 at 03:35:47PM +0900, Akihiko Odaki wrote:
> Supersedes: <20260604-migration-v1-1-cef4a5b1bbdd@rsg.ci.i.u-tokyo.ac.jp>
> ("[PATCH] system/physmem: Assert migration invariants")
> 
> ram_mig_ram_block_resized() already aborts migration when migratable RAM
> is resized. Extend the same handling to other unsupported changes to the
> migratable RAMBlock set, such as removing a migratable RAMBlock or
> changing a RAMBlock's migratable state.
> 
> Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> ---
> Akihiko Odaki (3):
>       system/physmem: Pass RAMBlock to RAMBlockNotifier callbacks
>       system/physmem: Notify RAMBlock migratable and idstr changes
>       migration/ram: Abort on unsupported migratable RAM changes

Thanks for looking at this, Akihiko.

I understand this is a protection to the system to trap error use cases.
The question I have is do we have any possible way to trigger these.

I worry we add a bunch of code and notifiers, and then there's zero way to
trigger, essentially add dead code.

Logically we could already add assert() on things we don't expect to
happen.  This case might be slightly risky, but still I think we can also
consider things like error_report_once() instead of introducing slightly
complex notifiers just to cover what we think shouldn't happen.

Or do you have way to trigger any of these notifiers?

PS: today I went back and I wanted to try how the existing resize()
notifier would trigger, I can't even reproduce it with David's example
here:

https://lore.kernel.org/qemu-devel/20210429112708.12291-1-david@redhat.com/#t

I can trap a qemu_ram_resize(), but that's invoked with newsize==rb->size,
so it didn't really notify a thing.  I don't really know how to trigger
ram_block_notify_resize().  If you know, please share.

Thanks,

-- 
Peter Xu

