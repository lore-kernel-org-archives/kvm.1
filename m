Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF3C3ACA5D
	for <kvm@vger.kernel.org>; Wed, 22 Jul 2026 09:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784711674; cv=none; b=OZYUk6G2fZ2JyvQSwEERHBwcmg+btyVRjJNV3Uyf6AaLxdOeBGEIipEDXjiI8si2BMwSdSs7JSjssKrtplIxrDQ+ACe8TMSjzYTSmKbRJKpnlxRJBodLS+Hu/5xfkS/SHNsD3Y1XmPkw7oNAyExmk2aPkmhzBDCqUV5QAgaC5LA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784711674; c=relaxed/simple;
	bh=sHMU9orKt+3dFz7svwzy6sHxokwx9yHspoPZi9pCSqA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GWhqV9+hQTi7DfubB0cCM0Gn/c+mbpVwXQYzd9wof7M/3JhpjqyLP6L+0/UXATHWev3ZHZUxWCogMbvkhtvObQBT5yRqZMhz9XsQsQ2mjs9j+OpQ3LJWMvmaWViFCCTJFm/zozFGnL3/we6VqzXBz9Muy5WIeDacmFX93MqXQBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=djMFIeKo; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=hWPNkyaD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="djMFIeKo";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="hWPNkyaD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784711672;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=COubnejOb/3v47cpwE+v+WjurVSix4Lp7TgAJigf9YY=;
	b=djMFIeKowtH+eFrj2v6EHIW269Aa1BPf4DSEYSOBNEmXipXnb6ahYoNYe+kCEi8ydfdi5R
	6D4w7KiNs66ORoOqQ++2tQCwSl58Tz/pJ7n3mE5WVGtGN1EJaBr9VCt7h7yhqYzw8akxG7
	qTIKxgWIGY8j2ypdmxQiSeeAzA8p9E4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-462-3wADWfCpOca3WD0Jp_dXyg-1; Wed, 22 Jul 2026 05:14:28 -0400
X-MC-Unique: 3wADWfCpOca3WD0Jp_dXyg-1
X-Mimecast-MFC-AGG-ID: 3wADWfCpOca3WD0Jp_dXyg_1784711667
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-47407691804so8570906f8f.1
        for <kvm@vger.kernel.org>; Wed, 22 Jul 2026 02:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1784711667; x=1785316467; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=COubnejOb/3v47cpwE+v+WjurVSix4Lp7TgAJigf9YY=;
        b=hWPNkyaDEFJEKapwJ9fmMDKRMqZvCAauA7pN2YDBaiQccPZSS587ZAX3WOkkvWRKNl
         FcgCGdcrOvp0+h4dyM3vhPPV8lkr2Ybd4SnxfP2EQIEde/fvM5GnjCzeIIkD8rhjUTHe
         kWZcyn10bSU5XSdU37Ozp8EfeSIL6s4N3zAA0Jrj1gJ3ji/3e6uRQEcCo6i9O/luCRsE
         loCJ6FpMHTXza/4MaZIja4eJcJUHJOkypf3F4OxHznF6VnoS82phR1RHhFuspmtK+Wq7
         WKWACUOkgCamqUTCNmi5P3nmjs4h+Ftgt1LlrHEGvJMSWBDozaeILE5LwIAwSbcQsMjk
         JX+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784711667; x=1785316467;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=COubnejOb/3v47cpwE+v+WjurVSix4Lp7TgAJigf9YY=;
        b=WU+2dT603VuQiOPqm4l9YItBFlN6MHkSy9AS1s+ENYFF86U8s9SETlfoxPWnQUJafr
         ZeWjw+IOvt2V0MgZ5XFFWvkf8xX4u/C9wz/39d5HnJ7eyg7YEQ/TZZD8Hi5znFQslJf0
         WE4rfurX7I54xfxOgyKgKYPFwZSFbOSNR5WbLbaKHTFjMXAsYVC9+nxTany2FkjuDDSg
         A3RyYhUj+A6jzS5gWXfYWEmJz2t8OrIZy6+CcyJ3xlTVNDgj8hyPZoK5nRJwhYde7imJ
         limk9CWU2rbYPX2UzMGzhqkdDzT+KxZmO84Qctl3DVg9J0oZ6KDAsm2iNEaca/UwSvbw
         V6QA==
X-Forwarded-Encrypted: i=1; AHgh+RqQMGFUoQ1jFqTGNT9e2Ua/YR2aZnxBlJ0huSWr9wKIcY9Iesecc8IOfMt9f/kcYRAK2pA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzhyg4IEMefvSZz8jnJOKZ38dzOYCS/1ZfEIIRIuGPNzR4vHtba
	g0oN8vKMZ4ZAe7MZTEv0Db1j1FV4/jc1s3viLxBNMob0v5XHlQJVYh6h4QvsV42VHqvHZNptqXb
	7I0ko0xbJQl3bDiZHeqQpy7GgnI8I13Higqjv0DPe/9+lzvRinZtCyQ==
X-Gm-Gg: AR+sD13eMBoBXK0bk9345wXsFVt74YFq+yCQg5cppb3qHOrg/R7QwjPcyWLDEErAFbX
	Hdeieda860hjW77FVxyGB5UtypRllzXag58wixUMm5AWVSeHkMcDu2yqM12xdIPpHfzxO+scuea
	3WMVNPI1+s7HLXt3IbOuF3C5/LYBR3ys9xeFri69+tggBEnV9cVPxBAnUs1s//ci/Qn6bAb1pzE
	ljnI7y9ZifdxZW5dtBhV9FCkzfsTjiSo90dNiCqmpFXQxkW43bf9EmVTdlwOkwx/yyKpbsBlMwv
	JUXz8cLgdBVDJcIBJAEL+RRg6wDnFHm4/Noit4p5KBWIQvJs9eySlx6Ua/lTkm7uO5PdhExvNMv
	138887JUkWWY7hD/BQtOpVol+lwb7s/py6Vel4jvQWFLeHMSmXw==
X-Received: by 2002:a05:6000:402c:b0:47f:7759:89df with SMTP id ffacd0b85a97d-47f77598aeamr15702368f8f.3.1784711667387;
        Wed, 22 Jul 2026 02:14:27 -0700 (PDT)
X-Received: by 2002:a05:6000:402c:b0:47f:7759:89df with SMTP id ffacd0b85a97d-47f77598aeamr15702319f8f.3.1784711666793;
        Wed, 22 Jul 2026 02:14:26 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-135-65.retail.telecomitalia.it. [82.53.135.65])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f8635c8d7sm3212686f8f.21.2026.07.22.02.14.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 02:14:26 -0700 (PDT)
Date: Wed, 22 Jul 2026 11:14:23 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, mst@redhat.com, stefanha@redhat.com, 
	dongli.zhang@oracle.com, maciej.szmigiero@oracle.com, bchaney@akamai.com, 
	mark.kanda@oracle.com, ptikhomirov@virtuozzo.com, den@openvz.org
Subject: Re: [PATCH v5 2/5] vhost/vsock: suppress EHOSTUNREACH fast-fail
 during CPR pause
Message-ID: <amCJ4x8EGtHjVRM7@sgarzare-redhat>
References: <20260720102241.371610-1-andrey.drobyshev@virtuozzo.com>
 <20260720102241.371610-3-andrey.drobyshev@virtuozzo.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260720102241.371610-3-andrey.drobyshev@virtuozzo.com>

On Mon, Jul 20, 2026 at 01:22:38PM +0300, Andrey Drobyshev wrote:
>Earlier commit bb26ed5f3a8b ("vhost/vsock: Refuse the connection
>immediately when guest isn't ready") added a fast-fail in
>vhost_transport_send_pkt().  It rejects every host send with -EHOSTUNREACH
>until the destination calls SET_RUNNING(1).  The fast-fail condition checks
>whether device's backends are dropped, and if they're, the guest is
>considered to be not ready.
>
>However, there might be other reasons for backends to be nulled.  In
>particular, when QEMU is performing CPR (checkpoint-restore) migration,
>device ownership is being RESET and SET again, which leads to backends
>drop and reattach.  If we end up connecting during this window, an
>AF_VSOCK client gets -EHOSTUNREACH, which is wrong.
>
>Add an 'ever_started' flag which is set once in vhost_vsock_start() and is
>never cleared.  The behaviour changes to:
>
>  * When device was never started -> flag is unset -> no listener can
>    exist yet -> fast-fail;
>  * Once the device starts -> flag is set -> we don't fast-fail ->
>    we queue and preserve during any later stop / CPR pause.
>
>The VHOST_RESET_OWNER ioctl is implemented in a following patch, and
>without RESET_OWNER the problem we fix here isn't manifesting - thus
>this patch is a preparation to support RESET_OWNER.
>
>Important caveat: after the first start, a connect during any stopped
>window is queued instead of fast-failed.  That was the behaviour before
>the patch bb26ed5f3a8b, and we're restoring it now.  However we still
>keep the behaviour originally intended by that commit (i.e. fast-fail if
>there's no real listener yet) while fixing the CPR path.
>
>Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
>Signed-off-by: Denis V. Lunev <den@openvz.org>
>Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
>Reviewed-by: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
>---
> drivers/vhost/vsock.c | 22 ++++++++++++----------
> 1 file changed, 12 insertions(+), 10 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

