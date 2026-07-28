Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67C503B961B
	for <kvm@vger.kernel.org>; Tue, 28 Jul 2026 19:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785266557; cv=none; b=ds0NubtxzneQZRC/LF7F2wdeomcodU7JO596hx1bJs33+be7R0G3iywInWDm04wBEHJW2kIQWyM3v11JBdm6Ru3uiihvL6cgLOJeaHSysrsJ13MofN33/WYm5kAGoReWYxmiGA48ANuFaeOw8CZtEwKIHXjkIM8C8+lR91hclDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785266557; c=relaxed/simple;
	bh=R+zgHjbzWHNJAJSiByZoxeBoJx0H4D0oao8AmHjSzv8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JtVd/I+eMXXwdLNds+zoJypo4N0hG32LaM1TgbTojv2Dt29QXQUxQRS8tr+z8OlMsfyVrhzR3KrH5id5nxFi6RAOyNTjspZXTw7Ft95M8+xgMVUy28Cqd4V4ZsMC6YZN2yvOA5i/B5tA2kJ/793SrrtapraMm14DTa/T5riziiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YUsuxc/L; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZmAYyNef; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YUsuxc/L";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZmAYyNef"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785266554;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xHDeYJjbxDxQ0a8+BXenwk1PFl2CLayk3cj54C+//40=;
	b=YUsuxc/LD/Cdb0ir5kKJ7Pd4nJlGSnDsv05SC7+l7XgFcefj/hw5PWgNSsC+1QuOZkJK9N
	5aE6F5PkyrQp9UHQ39ImNUdrmuOMf0z7pgYbUW/y3AjBxk5N6mZV1jo7W8XRbMICLJ85Yf
	l6HrIElmzTA2w2+a2bgYAbAn3UfDYww=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-185-gSo30-GwNza7LOzpPxeqiw-1; Tue, 28 Jul 2026 15:22:32 -0400
X-MC-Unique: gSo30-GwNza7LOzpPxeqiw-1
X-Mimecast-MFC-AGG-ID: gSo30-GwNza7LOzpPxeqiw_1785266552
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-490a767b782so1109695e9.2
        for <kvm@vger.kernel.org>; Tue, 28 Jul 2026 12:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785266552; x=1785871352; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xHDeYJjbxDxQ0a8+BXenwk1PFl2CLayk3cj54C+//40=;
        b=ZmAYyNef6hfH1A29wQ0a3rJG3AqRb/61mozxJpJVo/TVou6pvJbQJKqcIPcdt8j5FW
         CC0DSndAMIjtNXxpKrzAdL8qj6E5P5390pQbEsmcwm+9Sda1XGVDiOnGU+1oyPtzIHUY
         F4legdo1V9LYUqG0/SEoQ7XN4+HO4f6M+LmOydoPXegqQxLRrDj+I9ZJlt/mgQ/wc/MW
         OzEjHtFAWGkCDSEjj2s7Z1It0zMTZozeLLurDqpnPtTdeSoK6QrI3O4iNLUvre4OSEa7
         nWce7RBt+Ka+P/5YfYfsMcLLzCDcjB++ZQr6nNRC9j5jHUzqwsyI5tjPVDRzjGoM8ox5
         FEMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785266552; x=1785871352;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xHDeYJjbxDxQ0a8+BXenwk1PFl2CLayk3cj54C+//40=;
        b=CvrWSekHjZxku1FUmCn5g9nQqot7H5z9KaoNuG6xDZ/D6rOb7sYUOT2WJJjUujsp2z
         3+Hrb8GLmiM3jVNx7u6LbY1lWdpj93RiuI6kNz71d6Ohj4zk8Q8WPvBzVankpC4Qtg6Z
         656wAlkBc5UyGJI5NvSyexSWGnNJwsFPOSgmxgnYl68MeDP8uD7LuPdj/hrRHUE6wi8d
         PQvCF788qyGbffho30OnuDv+MFkGwx+7Qp/kiIhs1M9UbvStcAWV3qo0llWlkBGWF/Me
         p7k9q6y6HkFMiB/+znslsE4Md7QNckBnu5w51FyKA3liaz3uhYXeXky8jDdaKBQ8l8+Y
         HquA==
X-Forwarded-Encrypted: i=1; AHgh+RpKqWpbr/RzHa/zJBZGwPq5tCOYxrDl/GDmCxg0hbmPcxScApMcJV7ZQ2+3hVOwOWBK5y0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8FhYlwVXI/U3AQEEVh013os8RiaXvXCRP7Emth1STT4JpSGCp
	UyHMaGYroKe3hnrSCVFsrSsfhxLOJ7RnHx66STtGiV9nDxJV3DxmKR1VRy3CWU163o4FPZi2hdC
	C8yoOeYKESiQU9bSS9McMx5dVKtZSyIbsq1Ud1Sj0V7zg+WMbKQU7IA==
X-Gm-Gg: AR+sD10/MmqgxkG0/Qc1xM5Z/rfQ36DPy6jAqfZympYSvbrxNtMM8DVRs1tcQ7fIJyh
	4cTSBPcT4Hlk8I41MyCVrwisfLE8doHFMOX5rYFuagdmwyoEHtq1wf13Cz9R8k9jPYLMBbfoK8O
	Dr6x+2DcGyItheupq0GQQVmaZ/onXSCWwlxLhdmJA25XkdnS6OEAEC6WDY7zgQcQRQ9i+rASnYS
	aMYPaUY51g/PeW6NbXxMvYa2jtcRqZlWkqVdyMb4VU0ZGaCrsuqZJf5jWC/osNw/mbQ+NxK14Nt
	BGhckXV6oX5o33L9ORQskrh1ZtwQvPoDW0NOQ5yV1VGu5Q7oWaD/SIneJQ9u0s1dYi9AhLFa227
	WfgNTjvxBShNIkA2Dkn/FQVA=
X-Received: by 2002:a05:600c:1c1a:b0:495:5fdf:2075 with SMTP id 5b1f17b1804b1-496c60c1c4dmr38408215e9.0.1785266551639;
        Tue, 28 Jul 2026 12:22:31 -0700 (PDT)
X-Received: by 2002:a05:600c:1c1a:b0:495:5fdf:2075 with SMTP id 5b1f17b1804b1-496c60c1c4dmr38407915e9.0.1785266551088;
        Tue, 28 Jul 2026 12:22:31 -0700 (PDT)
Received: from redhat.com (ppp-94-66-118-61.home.otenet.gr. [94.66.118.61])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-496c44afaecsm112946795e9.2.2026.07.28.12.22.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 12:22:30 -0700 (PDT)
Date: Tue, 28 Jul 2026 15:22:26 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Simon Schippers <simon.schippers@tu-dortmund.de>
Cc: netdev@vger.kernel.org,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jason Wang <jasowangio@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Tim Gebauer <tim.gebauer@tu-dortmund.de>,
	Brett Sheffield <brett@librecast.net>, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 0/4] Revert "tun/tap & vhost-net: apply qdisc
 backpressure on full ptr_ring to reduce TX drops"
Message-ID: <20260728152204-mutt-send-email-mst@kernel.org>
References: <20260728092240.250257-1-simon.schippers@tu-dortmund.de>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260728092240.250257-1-simon.schippers@tu-dortmund.de>

On Tue, Jul 28, 2026 at 11:22:36AM +0200, Simon Schippers wrote:
> Commit 1d6e569b7d0c ("tun/tap & vhost-net: avoid ptr_ring tail-drop when
> a qdisc is present") did not show a relevant performance regression in my
> testing, but on Brett Sheffield's librecast testbed it causes a
> significant throughput drop in an IPv6 multicast testcase. The regression
> can be pinpointed to multiple iperf3 TCP threads sending: for 8 threads
> the throughput dropped from 13.5 Gbit/s to 9.13 Gbit/s.
> 
> Therefore this series reverts the qdisc backpressure work.
> 
> Making the backpressure opt-in via a new IFF_BACKPRESSURE flag was
> proposed in [1], but a new IFF_* flag needs more review scrutiny than is
> available at the moment, so a revert was requested instead. The opt-in
> will be resubmitted for net-next later.


Acked-by: Michael S. Tsirkin <mst@redhat.com>


Thanks!

> [1] Link: https://lore.kernel.org/netdev/20260709095511.168235-1-simon.schippers@tu-dortmund.de/
> 
> Reported-by: Brett Sheffield <brett@librecast.net>
> Closes: https://lore.kernel.org/netdev/akVnoOYQOrt8k-Gu@karahi.librecast.net/
> 
> Simon Schippers (4):
>   Revert "tun/tap & vhost-net: avoid ptr_ring tail-drop when a qdisc is
>     present"
>   Revert "ptr_ring: move free-space check into separate helper"
>   Revert "vhost-net: wake queue of tun/tap after ptr_ring consume"
>   Revert "tun/tap: add ptr_ring consume helper with netdev queue wakeup"
> 
>  drivers/net/tun.c        | 109 +++------------------------------------
>  drivers/vhost/net.c      |  21 +++-----
>  include/linux/if_tun.h   |   3 --
>  include/linux/ptr_ring.h |  20 +------
>  4 files changed, 14 insertions(+), 139 deletions(-)
> 
> 
> base-commit: b14361aca6350ff7907b0e9903c7b94dc7d5d4a0
> -- 
> 2.43.0

