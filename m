Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D9D6469845
	for <kvm@vger.kernel.org>; Wed, 29 Jul 2026 16:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785344287; cv=none; b=qDU6C3hColL0U0+MV/j8D4s72qp3/S2pGeCJ1oHqhyX3vaIj7x7AopS4wULwE3Vaz9um0H+zNEo/lW7xX3KgXT99GAxFeMCtMgV4kEgVU6KX67EpZpDXmrL9JP8J04tWvu5tO07M9xPPXnDUZgJeqLZVAT8bBzRcJCsq1tXxZEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785344287; c=relaxed/simple;
	bh=8fA89PK9z5I6GQoA8Pvaip9JaaozQM+Zq5pnMNviiqw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X8O3dRZi3pvZoBiLx4cZMBmf05Tnjju158hL8Z9Hu+XYZS/2S2/lDtwq5JCgeDEjMJtzxqVC6e2u0w3rRL4vP9srIAPVWJDAhO80n8zpw97aP60SPXxZHdA4QAFFxDQ2/JUwU/Dg/BG+DaowyCMuGeUez0abTOfSx9VDUIc0SZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JSBp0QsZ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=r41CYuRK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JSBp0QsZ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="r41CYuRK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785344285;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4349OjOM4tqMiVdkoifOGbiGi3KfrSh42jsIQcBbS9k=;
	b=JSBp0QsZICrYgTi+HUkGbH9oAau5Epiesc+41azZQSg3vb3tnh+l/dXBd3YojNh3eYSHLP
	HHY2l/j8hFQ3h62I5yjMd/R3Xjr3XmabGF3W1JEJfeELy9RB6C39Hy/HuNN8BPd9APwpBZ
	9YMLwiHoVSmSXxrZCBwWehP2l4KWIMU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-guL0TqeJN0C27VNCT60Rug-1; Wed, 29 Jul 2026 12:58:03 -0400
X-MC-Unique: guL0TqeJN0C27VNCT60Rug-1
X-Mimecast-MFC-AGG-ID: guL0TqeJN0C27VNCT60Rug_1785344282
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-47f83416551so1331913f8f.3
        for <kvm@vger.kernel.org>; Wed, 29 Jul 2026 09:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785344282; x=1785949082; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4349OjOM4tqMiVdkoifOGbiGi3KfrSh42jsIQcBbS9k=;
        b=r41CYuRKR13xPJR2vi0FGOlCCESw49qDF0oAeY+T8Xgf+bSjmUgWXTR/A7/ObnDDT8
         SNLIvEJvjcp5vQsteF4gTjkNq2Tr33AiLlnQq/I6gsJc7nogzqJP6rtJg87KAOE9ojBe
         3A26fpZO9XAOmrlXg3xVs0VCf1DfSsni/383+i2J2T44ReEfRfW/pmW8CXsxWtpDgF2m
         EY94XAdYLZRJEzNmlV9pLjGmZ4uVoQsEp/hSZiGUmEzqO6wRQ1drLn7vyqnXU3RWrlxY
         J8L/yAvvAzfHa92jJoGt8WtWdzJVEEgnVxv9TIWY7NEDX4JZ0ovObInUFJ/Kr83szEfM
         ySQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785344282; x=1785949082;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4349OjOM4tqMiVdkoifOGbiGi3KfrSh42jsIQcBbS9k=;
        b=YufscEOZa+64pN1gqTyQqUmclBHyqoJvQyddT0BrQZTeYiVqdxUeS5L0lQwVAKdt3L
         3eZEgI8qC1bqgxxeIWpGy7T8sQavy1PU8mLIGsLecL+gwvjCNtnIJL8pHdcLeKXd54i6
         3bkpAQI4bzFe+VujZ2C2kcPdaKpldhwkJ250gxkSJH6Ck+innfT1lEyUF+aBkNgKTKJU
         GuN/eB0ZJ5I90jjCbuYL+bpEBiXZ0WiNGtdsz4GQHS0MiAB4S06V/DN3Rp1PPFkg+ZWM
         xgDqOmoNSj9BoeC8fzZYofqxRrX+WCldOLS+xul99wersVfA4wT9P5z4kkSBAnBEYbCC
         4cPQ==
X-Forwarded-Encrypted: i=1; AHgh+RpSsK1k9F5aldQ0S6Bl/sLu9oqPSiUtVn9ibVqvkgtKcRJfLU7YU78sNkyzQV48aaddlH0=@vger.kernel.org
X-Gm-Message-State: AOJu0YynCwMrRTVLuWV3J8Ye65MHKtOOvc/1iZOTVzPLFU9Hy27COw1K
	z2zjwBmwaZb8vh3ocE26ahLGkBQXGJKs0UeUvPMWfrFEmIig9VQKMsruPlQFm1o/EEyHgMQimz3
	FXn+XyBdGRYrGUFh7VvG4gDevJACkwoHsNhXAmTmeyA8oLSb+NfWuAA==
X-Gm-Gg: AR+sD132i9T1uUrWqkm/j/K1OccYb5WMzMGZjDeufrdLFFxfj96m3C9mqBOdhKuiC/y
	ZcVu7Br5w4flrNu33qSO9JYWLWSUqnVYOks43HjMWmHhOwfWejv8Rvc0pDXeCHwfMAT+oeDi0h/
	h8cp9zLUFeW9F5NWSgDHnJrZQF/iySIQrqxpe2M1fKNXz/rRQHgxa4625Uxllbq3jJZiytwJZ4u
	kC3sLOWYjTOXtFZIE9WhdLKH13+q3oPjJdQcGeAxwXLP4nnf1KxnAE9xLc/ZXAnp9+iN/ksn7jt
	t8L5CLcciNXs9ry6207xTQwZlaAkR7vqe6TYXl/lk+zziNprtxXjUbfp5sZAUVqLsB5WJAkrq3B
	nY/N2QcbVCN5GZSXYBVBzng/k46Lhan1zuVCBUn//0bc=
X-Received: by 2002:a5d:64c6:0:b0:47f:7427:8ce9 with SMTP id ffacd0b85a97d-47fb1ee75c5mr9353821f8f.51.1785344282021;
        Wed, 29 Jul 2026 09:58:02 -0700 (PDT)
X-Received: by 2002:a5d:64c6:0:b0:47f:7427:8ce9 with SMTP id ffacd0b85a97d-47fb1ee75c5mr9353791f8f.51.1785344281535;
        Wed, 29 Jul 2026 09:58:01 -0700 (PDT)
Received: from sgarzare-redhat (ip139-137-192-82.pool-bba.aruba.it. [82.192.137.139])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fb6b0ef1asm9778480f8f.19.2026.07.29.09.58.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 09:58:00 -0700 (PDT)
Date: Wed, 29 Jul 2026 18:57:58 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, mst@redhat.com, stefanha@redhat.com, 
	dongli.zhang@oracle.com, maciej.szmigiero@oracle.com, bchaney@akamai.com, 
	mark.kanda@oracle.com, ptikhomirov@virtuozzo.com, den@openvz.org
Subject: Re: [PATCH v6 5/5] vhost/vsock: add VHOST_RESET_OWNER ioctl
Message-ID: <amow-BG29pG3eSCd@sgarzare-redhat>
References: <20260724114542.734623-1-andrey.drobyshev@virtuozzo.com>
 <20260724114542.734623-6-andrey.drobyshev@virtuozzo.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260724114542.734623-6-andrey.drobyshev@virtuozzo.com>

On Fri, Jul 24, 2026 at 02:45:42PM +0300, Andrey Drobyshev wrote:
>From: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
>
>This ioctl is needed for QEMU's CPR (checkpoint-restore) migration of
>the guest with vhost-vsock device.  For this to work, we need to reset
>the device ownership on the source side by calling RESET_OWNER, and then
>claim it on the dest side by calling SET_OWNER.  We expect not to lose any
>AF_VSOCK connection while this happens.
>
>To that end, unlike the release path, RESET_OWNER keeps the guest CID
>hashed: established connections survive, and host sends issued while
>the device is between owners simply stay on send_pkt_queue until the
>next device start drains them.
>
>Since the device stays reachable through the CID hash, the lockless
>send/cancel paths can race with the worker teardown in
>vhost_workers_free().  The previous commit ("vhost: synchronize with
>RCU readers when freeing workers") makes that safe.
>
>Signed-off-by: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
>Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
>---
> drivers/vhost/vsock.c | 32 ++++++++++++++++++++++++++++++++
> 1 file changed, 32 insertions(+)

I thought I had already reviewed this, but anyway:

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

