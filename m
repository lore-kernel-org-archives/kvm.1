Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C3E47ACC5
	for <kvm@vger.kernel.org>; Thu, 30 Jul 2026 23:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785455368; cv=none; b=FtPYkTvz3wYXVi3AzAeD7P2OsgGYVvSj/dJMYC+j9r8txyANPqkrekNpKrPgU4zsaywiqDCnwOyiDnZ6+uyeQhZcwxAZWmtwT/hsh/wMOECi83hlW/HHViE6DZ1+Fmpjzywc4aNClTcjBloqoBftBzqm7GddNUWDr/KHnPcnJxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785455368; c=relaxed/simple;
	bh=QBPX2FlNZdNHfPS9xAx4hnsjicFqelsPaGbARid3Jq0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nCPjW58fABxuRg9gOoNuvoQ1O8Ftcm96yqfGd2b3g5AjhzMQhy/nvveEypKnV5NFAFZd7kdKL3InWuDN8xqqYrmzb06toNuz22H1scH5FnYtJyfvz6RDabpYi1SKTWKOXOUHsGhVNhDFwmbHDgGjKlsJgMWWCugnNpLvnyu6MBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f2esO6pB; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=FkpE9nji; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f2esO6pB";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="FkpE9nji"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785455366;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0imh//Ln8azssKsT3gHIO0joG70m1DE2os+hdd9glB8=;
	b=f2esO6pBuSTskpTrlJwnmloS9d2CO+BqdRzMIpLINGq6RM3Qr0wmoKGVqT8+TQ1AGB/YUI
	WIBpSSAcKwDYVYoOXxQEf7t59ewZ4D7Qx2b+rr12RIy1ToZByZzFCvf8Rk+Wh2/Px3BAMm
	pdFwYWgE9X7o6qQlUOi3jqhHOhwue7g=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-63-pKleY929OKusB1btVFRi9Q-1; Thu, 30 Jul 2026 19:49:24 -0400
X-MC-Unique: pKleY929OKusB1btVFRi9Q-1
X-Mimecast-MFC-AGG-ID: pKleY929OKusB1btVFRi9Q_1785455363
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-47f8398ed9fso186451f8f.0
        for <kvm@vger.kernel.org>; Thu, 30 Jul 2026 16:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785455363; x=1786060163; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0imh//Ln8azssKsT3gHIO0joG70m1DE2os+hdd9glB8=;
        b=FkpE9nji4wxkpUe3Ffk+MOlVK1tC0jcQ6whLGoly6zFl1V+YfNevc96l2sQ/ze3Sbm
         /P0ajtlK+Wc9eD/02B5NibY0itmzNXSraB9ALjqF96uCR5lwpisCTHozLbVw9g18bJxR
         g7upksgpvxHK1awXbDb09M/7pJxifyVwBkntBynXJ/2VEAYyVhPXBm4MbqMwQ1aW14y5
         xZeAUp3+fOKIQR5uXEUF6XQa9zr4nVvO/Pb3xp09TCjlGbcw9+lObIOWusDcx4RxxurS
         MDJkuTQXvtt5LJposciLGDtaJO1FWuO9Jv1byHaULiLN41Vs36l1J3844vuW/e/PoQcX
         RYQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785455363; x=1786060163;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0imh//Ln8azssKsT3gHIO0joG70m1DE2os+hdd9glB8=;
        b=jU1c+JmL2zSJEyRXuixzK/UZZoAnHiCdB1rXp0CGjrMozWZbbFJuzJbmL9WeVu0mRs
         VOdMerBC3Ma32gIjh8zj2cp+Qem585SOBKFk5SH63O2mdBgW6sji20qfD/BhQ6HTvc+N
         BZY8/GyzJ0+Xsu66CpFr8Md6uNQy26Rdt5UgG7CxXCDtKnOnykuV+nIQNBfpvFvm/FWu
         5nUGJ541vp546Zrd14dJHyA6Hy1oDv0pCDWSmFagYlbvNdFJzNmr9asbRDPPgqZ/zqEh
         oen/ib1oNsPDSjBKcSYwkZ+mQFg1ke8vqwZh5gJSL5YNpXHPcC7zF/8mHM7VxEy73Lol
         PYgQ==
X-Forwarded-Encrypted: i=1; AHgh+RrgsJLBhfUQa3hYLX6uLpW79dyWvUesMC1Mgly6HXtpdc0IMQ9qXx85XyovPQsRMmtCrhA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOVrF2VHPxlqYa7DJv7/hbrZJP6vQfO74Pg1Or+uZIxlZf/Mru
	3apTb61ypU/ZnB0MiuBcqZm2vIhS6HmQN6pogqrc37Gw1J+ouqvM6Sc1P7ZVyR/YjqLcz1UyIN2
	Sf/AuIWBZEyfufl8/uUhXQ9kxEIHTY7F9LCvcmyyQeocAIW0+3ASeXQ==
X-Gm-Gg: AR+sD13E2ewUZfUWFxCpv1wa7B/q5kX8pbl4SvriUMkKk2KBZ5WYGDh3O3/t4xvFGrJ
	WEGdo5UKOto6C48zGZFZ7J50W29UfjL6RuwuBhdRev4F1IYg0Ui7pvAhbScQgytF4KI5mq6RMWR
	oJKWOpFPSN5xJfjgxkseVoUslgBtkTEZtydNMkslIr1oL6TCN+iD+29CcMes7IKUbIwGzCfwSnB
	/eG6Hn9kN/ohAjJb7Ov9hE6TsWpClAvMR9NS1m+WwDIg6T+/cqAz7yUEkwIIkYOuAR0g9LrMj6i
	6xU1kpKcddB4J0m4AMO26IkKOup217qfUEh8i3U/lbuzvvMw6VCkJ1xf+uG7+dehujBgfCH77Ap
	IbFlf72v4J+CiNUSExif9zjU=
X-Received: by 2002:a5d:5f88:0:b0:474:cd60:1154 with SMTP id ffacd0b85a97d-47fc8200021mr6660272f8f.41.1785455363411;
        Thu, 30 Jul 2026 16:49:23 -0700 (PDT)
X-Received: by 2002:a5d:5f88:0:b0:474:cd60:1154 with SMTP id ffacd0b85a97d-47fc8200021mr6660223f8f.41.1785455362999;
        Thu, 30 Jul 2026 16:49:22 -0700 (PDT)
Received: from redhat.com (ppp-94-66-118-61.home.otenet.gr. [94.66.118.61])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fc88e3c73sm10792795f8f.10.2026.07.30.16.49.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 16:49:22 -0700 (PDT)
Date: Thu, 30 Jul 2026 19:49:19 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	sgarzare@redhat.com, stefanha@redhat.com, dongli.zhang@oracle.com,
	maciej.szmigiero@oracle.com, bchaney@akamai.com,
	mark.kanda@oracle.com, ptikhomirov@virtuozzo.com, den@openvz.org
Subject: Re: [PATCH v6 0/5] vhost/vsock: add support for VHOST_RESET_OWNER
 and CPR migration
Message-ID: <20260730194858-mutt-send-email-mst@kernel.org>
References: <20260724114542.734623-1-andrey.drobyshev@virtuozzo.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260724114542.734623-1-andrey.drobyshev@virtuozzo.com>

On Fri, Jul 24, 2026 at 02:45:37PM +0300, Andrey Drobyshev wrote:
> v5 -> v6:
> 
>   * Patch 4:
>     - make sync+flush conditional by adding a bool 'sync' param to the
>       chain, as suggested by Michael:
>         vhost_dev_reset_owner()
>           vhost_dev_cleanup()
>             vhost_workers_free()
> 
>     - reword commit message and comment;
>     - drop Fixes;
> 
>   * Patch 5:
>     - add 'sync' param to vhost_dev_reset_owner() call.
> 
> v5: https://lore.kernel.org/virtualization/20260720102241.371610-1-andrey.drobyshev@virtuozzo.com

does not apply for me is this for net next?
in that case

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> Andrey Drobyshev (3):
>   vhost/vsock: suppress EHOSTUNREACH fast-fail during CPR pause
>   vhost/vsock: re-scan TX virtqueue on device start
>   vhost: synchronize with RCU readers when freeing workers
> 
> Pavel Tikhomirov (2):
>   vhost/vsock: split out vhost_vsock_drop_backends helper
>   vhost/vsock: add VHOST_RESET_OWNER ioctl
> 
>  drivers/vhost/net.c   |  4 +-
>  drivers/vhost/scsi.c  |  2 +-
>  drivers/vhost/test.c  |  4 +-
>  drivers/vhost/vdpa.c  |  4 +-
>  drivers/vhost/vhost.c | 26 ++++++++++---
>  drivers/vhost/vhost.h |  5 ++-
>  drivers/vhost/vsock.c | 89 +++++++++++++++++++++++++++++++++----------
>  7 files changed, 100 insertions(+), 34 deletions(-)
> 
> -- 
> 2.47.1

