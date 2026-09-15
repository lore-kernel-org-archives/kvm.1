Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA4B94AE104
	for <kvm@vger.kernel.org>; Tue, 15 Sep 2026 15:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789486949; cv=none; b=TWCNhcCXF0iZ7bhWyOKXz+8HSRnOF1BEzuGydlPCENMwmpB/i9V/pEJsOqIdW/4paN3uIRzuBmXG+7bJAjwgB9yHxuNGNYj/ZPLkb1jJjUMF0C9CVI2pKJ2tqVADxN3XjFUyEBKH5oO4PmNQgPLJgixC9iUgT8pyox/I2tmb7sQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789486949; c=relaxed/simple;
	bh=E+BuIG99Fs3gW60ZhBJoousphtXqpfMPQp9AyvW4hbQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AoFO/lON4GDk+f6E0AQy+g45Jdwv+5Vwva5+KhIWGCMBtxfxkHIWuMVgCsIXbLyRNCa44qklEOITxsT6wybbVLboMKfDbhvSZth7IYWr8EarDjlOP1WBXFJft10tPCjlMpYWKQxGw7LIK41rUvNdWY9bGJ0tCrq84P7k75uRWZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Fbws5wZu; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=DlOX6hOI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fbws5wZu";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="DlOX6hOI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789486946;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=piCn16bJNZqtD+Ea5Vr8Xw4q1fEfx3gnyjZeao+goZc=;
	b=Fbws5wZuCHHnVtsMo3PN2x06wM4v5ZlHrFaxaSm6SSYCwevxgT+SRIeubaKowLEQ9kIZFS
	qddHAxfeYJEix8TmlMsxwoAZ23lGhNgaAffNpRZYkfgF4WDa3QBYWWTJ0VlU+ZIqkQ1K/X
	YjQOWwHS+eBuBE0lYLJ6JkoGaxH/q7M=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-346-V7SCytFZPZiL77tZ6sxpbg-1; Tue, 15 Sep 2026 11:42:22 -0400
X-MC-Unique: V7SCytFZPZiL77tZ6sxpbg-1
X-Mimecast-MFC-AGG-ID: V7SCytFZPZiL77tZ6sxpbg_1789486941
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-49cf4cc2125so19798395e9.2
        for <kvm@vger.kernel.org>; Tue, 15 Sep 2026 08:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1789486941; x=1790091741; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=piCn16bJNZqtD+Ea5Vr8Xw4q1fEfx3gnyjZeao+goZc=;
        b=DlOX6hOIOTQudbeylDTBlu/1eLr9D/e5UdJ9lUKctUFbOHE1dWtRspL03jEZThfnZK
         2r9x2G6W/KEs+Taf4kKG4JW04VUulVg06CzD60FHprlShrmlQBgygtTPIfwi23cu+CJn
         WUXykqvUdumij86ZGAFuDTDMOhs77zJSQAgidBG6cAb1/40T6XBMmY6L86zK1nS9NZqV
         X7NqNE0mQdI+pah/MqDGkf1n/BO8uRmbebbrYyS6C9PwdtL3QxWpVsw2vj2cdA83uyoB
         aWY+SuOz1WLFZy8WQ00FwStPAcp3qcZk7ThKX4P2+r9UYRi5FJmngKRxfMQeKB9amC8G
         v0cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789486941; x=1790091741;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=piCn16bJNZqtD+Ea5Vr8Xw4q1fEfx3gnyjZeao+goZc=;
        b=2DcfHEIQLL5n6S4x5DNRzPA1opRJsLPQ7fFQiEXTvRH4A0ogNxwE7TKYAbABhpko84
         lrjQuxDMzZZTKB2N6QZ/6fKaLa4ImPIrRsYrg98nx1NgPPOIMm9mja5DvqKKXmvJNc3W
         RzOMos1jIjs8HMjcwXGsZ0L2aiYLTnoRXWbWRw3962T4r8XWrqpALCbZXiORltVYyzsH
         F3cgfIv88fFvyrfYinA5AmHnrr5eb7kMkUGFJQ/6m4NmF2BntZMP7/csCdjiQ4/0Tldh
         lCETI3tvyYdFNABOlfb+6I9skMM+ZSQF5wj/LAX375rO7msm08pnFuJsfbAwS1vvRtWQ
         FSRA==
X-Forwarded-Encrypted: i=1; AKwUvBx3Emx2PuLdcTY2ug1NOHfHUHwdNEK4W5UzdhswKXDkuZfXxEWm6Jm6T/d68xcpgsJ37gE=@vger.kernel.org
X-Gm-Message-State: AFuF++kgIfHFbUpLaGN1olWTAoE0dlXTvPFwOZEIwBKqmkmeKl6T36kw
	fRLrajHqOLrli6A4dPpBejXuL6MXR5s+6jRlAj8nJuXDwF8AHFkCnHP4qGaKwItZhmD36WbrsiE
	63i2q/KKlUXPk24DaRz/t2oNbjaHs8BOqyrJQeZWUR83iAwzruisQYg==
X-Gm-Gg: AYBFou3PIgmbkWq+M8vJlEb9oeL+EpecAyn/AcA0L95/wER1zMEXVYcNW+cZ7yjZayE
	vUkIccyEovq21s4G17W7HJxCsE9dubEMJte30n0lb3VNzdaaxR455SaeP+n0riYT5b/7RK2A/c+
	JYtK+os8PR4u1X2+E5u0SRTTWHyLrT/nPP+VV1FEJzPbrPxih4QPOHEq+3nX6HbF+sJpjaK2YnU
	sMzt4LtdkAghInoSsaQ5ExY3wrfO7ItB/PZyJpwttgrdvvqiu/O+120jDj4639OaP1yo1A4vkug
	RGSuzrkPYBVSamar62tmdOkFE9d/BzkKVeJbbHc/F8+QpVr2l00s6W0Sk3cZgq+NAj45f+WgPDb
	Wcb6ayqfgFc9Nvr4s8t2UP6GrFwprP7rYGyZXZm4XkHvuFQ==
X-Received: by 2002:a05:600c:8b74:b0:49c:ee20:e787 with SMTP id 5b1f17b1804b1-49e7a658021mr197081115e9.1.1789486940766;
        Tue, 15 Sep 2026 08:42:20 -0700 (PDT)
X-Received: by 2002:a05:600c:8b74:b0:49c:ee20:e787 with SMTP id 5b1f17b1804b1-49e7a658021mr197079685e9.1.1789486940213;
        Tue, 15 Sep 2026 08:42:20 -0700 (PDT)
Received: from sgarzare-redhat (host-79-53-30-11.retail.telecomitalia.it. [79.53.30.11])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4870b39ea31sm949332f8f.23.2026.09.15.08.42.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 08:42:19 -0700 (PDT)
Date: Tue, 15 Sep 2026 17:42:17 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowangio@gmail.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Randy Dunlap <rdunlap@infradead.org>, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, sargun@sargun.me, jlinbox@meta.com, 
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next 1/6] vsock: constify the transport in
 vsock_for_each_connected_socket()
Message-ID: <aqkcd_oMWK-QtXWQ@sgarzare-redhat>
References: <20260902-vsock-guest-ns-v1-0-9995383e9a8b@meta.com>
 <20260902-vsock-guest-ns-v1-1-9995383e9a8b@meta.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260902-vsock-guest-ns-v1-1-9995383e9a8b@meta.com>

On Wed, Sep 02, 2026 at 04:00:47PM -0700, Bobby Eshleman wrote:
>From: Bobby Eshleman <bobbyeshleman@meta.com>
>
>Allow const transports to be passed too. The function only compares the
>pointer against vsk->transport, which is itself const, and never writes
>through it.
>
>No functional change.
>
>Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
>---
> include/net/af_vsock.h   | 2 +-
> net/vmw_vsock/af_vsock.c | 2 +-
> 2 files changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

