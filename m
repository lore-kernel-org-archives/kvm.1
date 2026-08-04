Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6717743E9D5
	for <kvm@vger.kernel.org>; Tue,  4 Aug 2026 09:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785836745; cv=none; b=OXOde8uOiVOGUq2kLZU+h+fYGDPo0yRrEX9946yO0vgjmnQo1sidBTlqRO6McBFh3z2NiDkd2nqJ5khpabyJInqST57LH1Peo4F9AbCMG/QQQlJYWOB/TokcOLKlXDC8A9T8pvFog28471Dnt1okN95ol/sdhApvWaEzc1Ntvqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785836745; c=relaxed/simple;
	bh=dDky39zYJMrArXt7rlDyNBxmEhWZ3ij1bJVMuJuX4U8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QeFBOW0v7PoKv9TrG67UO5zEJk8E2l15DFgyHoVty9J0oYU76eCATY5OI3gJJ2t+hrDohYO/akfla6VtESUB+yLpUM6BMubrsE4inz2m1BKNF+bJIrObvAZS2TYw0pTZFH4q5tcFkxgqSlCfZaG+rNN23SKMRk5w7B4zcYTdVow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KpWWbeDZ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=RAHO7eZl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KpWWbeDZ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="RAHO7eZl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785836740;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=p0Vr+6epLbEBl+Ut6IFtBIqkvpbRQNZ+42wTzBOY/ns=;
	b=KpWWbeDZ7ndT/xceTwb2ePCjmoR6aisDDPnJPkJlEpybhDHe4COnCOxxOSy1Lcq1Q74cJs
	oUgbljMWaXHKORjr03jEI16bceeKHg3NPZUyukxImU1PpEUJWutgBAH32zb4v7HopwHeIh
	HyMBgTz+9ZFcrq8QlMZOF5ao8EtNhq8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-138-IzmugsYAN0SwsdYu5tzKlw-1; Tue, 04 Aug 2026 05:45:39 -0400
X-MC-Unique: IzmugsYAN0SwsdYu5tzKlw-1
X-Mimecast-MFC-AGG-ID: IzmugsYAN0SwsdYu5tzKlw_1785836738
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-474170b59dfso2484012f8f.3
        for <kvm@vger.kernel.org>; Tue, 04 Aug 2026 02:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785836738; x=1786441538; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=p0Vr+6epLbEBl+Ut6IFtBIqkvpbRQNZ+42wTzBOY/ns=;
        b=RAHO7eZlXxm3+DhbWaeuItMifNgK7E8YWD+a7vjY6noqh4uSwdXeGPx/SWrHlRlSst
         T8ACswvPgPbRQTawlxDpo+5Yps/b8dwGSgKB8eGtcUzBKUZbUuqxesYL4pJVnULHCBqO
         A0Y0PSITmLrsqdDqF16JeRlxKhKJSFpvTkhaQRLSeISURRJs3D9WMEJZMo53j33csv/B
         qiHiypIzSMdFVwMncuIrsG4ml4znDhwdLQ1UNI93w+g1WXwOHCCBoCMnUakP3vLgDNa7
         GShz6tIGpETemktY3aVQOpTMy3CiUTcaLRk3yfP+g8gkk068vgEitohFy7rkdePxiaSO
         4Xzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785836738; x=1786441538;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=p0Vr+6epLbEBl+Ut6IFtBIqkvpbRQNZ+42wTzBOY/ns=;
        b=l7e9JMSLuJsJra3K3GQlgixq+VpIsmkki8aw5yuUBVO4CozXxE9L1husmm6EF7rh5K
         /RIAUVLT6+LB96vsb+vvQ2Z8RFDTVzISF86t0oCJzvtRt7+xhpOeKhr4GEahBVG+Cquz
         yAaeIlsubtQ0Z1TccCdjEFVULABO6b6t+irws12+hrnp8GVSYMQbKcjfsJVfD0KflYtr
         dsmdbD6lnkAAgQZK/LT+La2pxguwJymXvxvjx7JqxRqxw5a2eGWnjhz3GbrMlgLASj2O
         BSupDJ/h8xNEQ3XtzVJ4AaPH3uxbKhhEwtF0YvRSj0uIgQycT9hTyyPkLpJ31Lb0sen0
         a51w==
X-Forwarded-Encrypted: i=1; AHgh+RrCYeKePJ87eY/r1a000RlT7KcHs+zuoJZg0wuy+oWD+xiVl6craOBvyPWBn8uLRXAVg9w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3RQ9zRaHh+inZaox8Xw92Keah5Iq9CpoV7QIk4Kf0V5Hlu7Xw
	5HotHzXdUpj/AB8lj0+cPZjeYeqYPyIZ3n9o61SXrYrkn2KaFGDWvdzhitYUOJY7khtx0tEcZNY
	ROqUoziv6M25mmTOiShcGdVdeWWXJ1+Jbzq+O64eOajPuo7usUsPcmg==
X-Gm-Gg: AR+sD13Rq4b7NdL/NPghIsTSQUDVHC1RgDjuTfDpFch9CO9M8KsaKwIVzTJwCXJsZUH
	TDkbHIbKsKVNegBvfO8ztF1lVrrKIioQCv+XUEsnHhi6FpPG7xvMAx7MIEh861XrjXkzc6gqInh
	Mwxrbt9t/E7Vgs2sIk4F9hEVOxpYVdbCq8aMVfz/OfWmYeoHNSZwnJVeXrcsocH1CQG0Y5Lif5N
	9JhXB14urztS0mlNgYKca9d1d2UBoC1E/B7opiMWP8WffPVQVdPi47NzGxtfJ0N3SzrK+7Ctmgf
	5KEjYAXn9tcCX/2sNrJ0ltGeuhcr/yIoFDfnv4JLVXzA1ATcF+yv6oMoFIyrB+KUPOm2KtDj4OD
	k2bM=
X-Received: by 2002:a05:6000:1886:b0:47f:b622:fcd2 with SMTP id ffacd0b85a97d-47fd72bef88mr33977915f8f.25.1785836738277;
        Tue, 04 Aug 2026 02:45:38 -0700 (PDT)
X-Received: by 2002:a05:6000:1886:b0:47f:b622:fcd2 with SMTP id ffacd0b85a97d-47fd72bef88mr33977826f8f.25.1785836737765;
        Tue, 04 Aug 2026 02:45:37 -0700 (PDT)
Received: from sgarzare-redhat ([5.11.104.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd41d0064sm40802768f8f.5.2026.08.04.02.45.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 02:45:37 -0700 (PDT)
Date: Tue, 4 Aug 2026 11:45:04 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Weiming Shi <bestswngs@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowangio@gmail.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	virtualization@lists.linux.dev, kvm@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Xiang Mei <xmei5@asu.edu>, 
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH v3 0/2] vsock/virtio: fix worker access after virtqueue
 teardown
Message-ID: <anG0WA8cvB_TnPbZ@sgarzare-redhat>
References: <20260729185831.3247971-1-bestswngs@gmail.com>
 <cover.1785352330.git.bestswngs@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <cover.1785352330.git.bestswngs@gmail.com>

On Wed, Jul 29, 2026 at 12:16:53PM -0700, Weiming Shi wrote:
>Virtio-vsock workers can remain queued while freeze deletes the
>virtqueues.  This series prevents workers delayed across freeze and
>restore from retaining pointers to deleted queues, and prevents the RX
>worker from refilling its queue after teardown.
>
>Changes in v3:
>- Resend the series with proper email threading; no code changes.
>
>Changes in v2:
>- Split the worker pointer changes from the RX refill fix because they
>  fix different commits.
>- Use bd50c5dc182b as the Fixes tag for the worker pointer changes.
>- Keep b917507e5ad9 as the Fixes tag for the RX refill fix.
>- Use the suggested out_nofill label when rx_run is clear.

Thanks, it's already queued but sice you fixed all my comments, just for 
record:

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

