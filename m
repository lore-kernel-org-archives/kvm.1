Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A07CD35C687
	for <kvm@vger.kernel.org>; Fri, 14 Aug 2026 07:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786693987; cv=none; b=R3jkfyd32Uuuns3oMLj3M53suzjcAHw8XoZfY1SpeNvLCr1qIBWeeTu41iZ42EuyfkXh6Jl3SH3qf+dMl3BoSYe3MkWyj0EcWbRfdoEVJylEYsPTHOU9iD3oFOStgVrkqdGaxL0RMD2GGWruK6dDkoqH+/o2QmsytU1k4qWHYS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786693987; c=relaxed/simple;
	bh=H+L3QTFFkyCFXwrBvc0mOg6GVJz81+DSixh03RV0aKI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RxCiZMURTXh1J1XVE0et56iZr5R23O69/KHkTPS/cgjmgkgxP24DaUa/Ux/ke8NpKU7SaACazdk0TlnHQtVKIzX3CXaeIbGHztE0zf2tUXM6f6DTw319jsNiOUpdgfqzTlUT2speJYWjsw0VIz0NgykU6y5GsTyDdb48zy1kVXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MZnWbMks; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZiY/drJf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MZnWbMks";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZiY/drJf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786693984;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IBgk91sGaugiFnpdKSnVzGaySlJCzjj+raiMAVYJqa0=;
	b=MZnWbMks08HsznDqliDTAs1YoUyyXhBJWO8Mk38vZfOWwJWoaEBp073Ng6AI27qELDWAOb
	UFmQA0XrqjBeuOdyvLIe2cnEi4bsQM52xANZHfLly69ygOPCRPyU57nF8yWiR2JU4uO+XI
	c6m+JoL3LZFmdnDr3saGjkFmVWAX8E4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-530-HZLVghP5P-WL8X3_E2mozg-1; Fri, 14 Aug 2026 03:52:52 -0400
X-MC-Unique: HZLVghP5P-WL8X3_E2mozg-1
X-Mimecast-MFC-AGG-ID: HZLVghP5P-WL8X3_E2mozg_1786693972
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-47f7039fa59so528214f8f.1
        for <kvm@vger.kernel.org>; Fri, 14 Aug 2026 00:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1786693971; x=1787298771; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IBgk91sGaugiFnpdKSnVzGaySlJCzjj+raiMAVYJqa0=;
        b=ZiY/drJfZEBM3NZxD1R0lKRhFEO48TeHnVV4YWHs5wU5NmiIdrmnN5h2PzgbB6nlwJ
         gOJO7mvPkD4AXrb741H1fFIMHh6Dl44umsgNcGmoCuiv2rhqQVrDhT+JhquioP6sewSW
         4khZMXfyZNW7Y01k0vLMTjrvGBmGHXsWZJ4d7vdAsuBWh/PCY+v0JoPxI1KyyQ1uY0/6
         E3jL2s31LCypig5n+OFRFhTNrXalSpgRz3Ou8cODM6mY7H+BJ/KhYuqi7Yvnu3zjIxyj
         YDhekuLVAWo7dziF0yzB6EccraHrU6d/2VrOhyjYAYxvoiSlPAeOffuuiPw5aZ6XQ+h/
         a3gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786693971; x=1787298771;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IBgk91sGaugiFnpdKSnVzGaySlJCzjj+raiMAVYJqa0=;
        b=Ivo27Q/i2GYWyFiUncPYQZE734UsDQdV477eET49e/69YO75CUrSK6JC8PR4alxK38
         CauQduNtaTn0u0iA7S3pH9n6/XhH9+xeU9PTQKdf8r826EutTWS80bcI/oSXaIPYsXNm
         9YU+uWie4h0C1erQZh0cXdPHNzImmjPTrIFW5WM20IYepG4aQ6Gpa2EpUdc+7dgVDpJd
         u+oRFuMHMoc1fy3iJ0pczt5Tqtc4CwNaECQ/a+JIH31z60kvaVJ1B4Sl42x95EGIUKBb
         /2MjEg6kHL37hRsmlSG7nNHJ9ch+Enc9XCRsH8nMS8s906OgkK1jPFEz0lgARaEyXhj7
         PJbg==
X-Forwarded-Encrypted: i=1; AHgh+RrbrTafHSpRhlvtFjSZZyZ33YlvrK7/xZ/n6gCumHHJ2qOMUETL76SNq0d+rqz3DX64yB0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzM0yj817TVWDPEeljhTzj8ondfltALXAtNUuzxGiAR4fv9YmH
	9WpPaZ119lgPM4j0uj8KDVBg3NVEj/bUEJ+iaoVvqUEHOgQUmp8l9uL2/IEYrRS0zLA2Ek18/L4
	1La4KLy1k4sufF4+zYghcvYaNaWEcRMRnHzrJOm4XFIeeARm3C2YmdQ==
X-Gm-Gg: AR+sD13OZeHty9BT96ly5ZS+evmst5WAV9ptRdKIBofU0/C3PGoQlqpePCGI/dnk5mk
	LTHMLPOpGbw3icarKlktaqFThgv+5yc3XXqF0UDDvOYHyBKcINpqGJKBBdNi198hLo2XYokAQm4
	JVt3WWv8DNjAVUqgdIOcC50BRkAQ1fnedsuc0m/f3DOg8KMV/QPbWTT7HvGiRy3zM20+D4aYG7o
	FBKninWhsp65q3qybE4D7gmxdHcb7cS61Y1BtnsknA0AlxF/8C4EOFPO2+1gHXjZzmcTofBmB5H
	FqIFX8wqx7XU9gDSj8f+Ftnm42MqtbqAl83Ktu/llaxKZ9zQT7L+hzxP9P/66ZWtFmZK1L7Z4xL
	9WtD8gybvCJsmZirw4nYNnSsuVADnZ39Ioa0ELCXRWl5ztmF1PCgQ
X-Received: by 2002:a05:600c:1da8:b0:496:bbce:fc with SMTP id 5b1f17b1804b1-4998798467amr50729605e9.12.1786693971592;
        Fri, 14 Aug 2026 00:52:51 -0700 (PDT)
X-Received: by 2002:a05:600c:1da8:b0:496:bbce:fc with SMTP id 5b1f17b1804b1-4998798467amr50729125e9.12.1786693971141;
        Fri, 14 Aug 2026 00:52:51 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-135-154.retail.telecomitalia.it. [82.53.135.154])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49988b1d33asm33182265e9.10.2026.08.14.00.52.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 00:52:50 -0700 (PDT)
Date: Fri, 14 Aug 2026 09:52:44 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jia Jia <physicalmtea@gmail.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, 
	"Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/3] vhost/vsock: fix device IOTLB feature lifecycle
Message-ID: <an7JAlFpRVOiC4WQ@sgarzare-redhat>
References: <20260814072903.124991-1-physicalmtea@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260814072903.124991-1-physicalmtea@gmail.com>

On Fri, Aug 14, 2026 at 03:29:00PM +0800, Jia Jia wrote:
>vhost-vsock leaves the device IOTLB attached when userspace clears
>VIRTIO_F_ACCESS_PLATFORM. It also replaces an existing IOTLB with an
>empty one whenever a later feature update keeps ACCESS_PLATFORM enabled.
>
>Patch 1 adds a common vhost helper that detaches the device IOTLB from
>all virtqueues, clears their metadata caches, drops queued IOTLB miss
>messages, and frees the old table after all virtqueues have released
>their pointers.

In the v3 you mentioned that this could be used also in vhost-net and 
maybe vhost-scsi. Would it be better to include the other patches in 
this series as well, since we're basically fixing the same issues, or 
have they already been merged?

Thanks,
Stefano

>
>Patch 2 uses the helper when vhost-vsock clears ACCESS_PLATFORM. The
>acked_features update remains in the vhost-vsock-specific loop.
>
>Patch 3 avoids replacing an existing IOTLB when ACCESS_PLATFORM remains
>enabled across a feature update.
>
>Changes since v3:
>- move the IOTLB teardown helper from vhost-vsock into common vhost code
>- keep acked_features updates in the backend-specific loop
>- add the common helper as a separate first patch
>
>Jia Jia (3):
>  vhost: add helper to clear device IOTLB
>  vhost/vsock: discard IOTLB when ACCESS_PLATFORM is cleared
>  vhost/vsock: keep IOTLB across feature updates
>
> drivers/vhost/vhost.c | 24 ++++++++++++++++++++++++
> drivers/vhost/vhost.h |  1 +
> drivers/vhost/vsock.c |  7 ++++++-
> 3 files changed, 31 insertions(+), 1 deletion(-)
>
>-- 
>2.34.1
>

