Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793628913;
	b=uF7BnpouV0OrYYm4cVkgt7WmUkn+yAPaDC4TrIdwkU5Kj8L3UIUcHv9SXP9Aj4fy//Zt
	 Bkxmghbsw5y/Lr9UFOvh0NIf+eI16qudKfmXu0vod7OeESWSNimMiShh9ZZbqlUZ8rwff
	 pZvcSpXmTnID238ZujEJSt2ZR2HI/RYBWqc5n3G99DHzEpjog8eyTij/jqquuWQoyQnfk
	 xdYLor5YKS4FIwUTWHARtOoLnb9BqzcGq5vSuAoCkMTfbfhyMPjUFVvLMFt6XiyWUzQQc
	 GhjI5rEnbRC0wXacEwDth0+vjdWgPa7Txr0/WD7JU2NUt2PaudT8gRrkcRoNHc0l9eg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793628913;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=sl0xAa/SyZWrBp9CL5o2SaCOERZeomQ7Ndnf7a0XFec=;
	b=XdseWho+AiWpv0d0TcvUmb7iVVHK/14RuftQl8AaTOaVpuSBXBybAoUgJSLkzdoZ8VMw
	 fxnUFp8K6SVRbPvV5mzcZuYyzGzHCaE3IiujymxTL/7wtPvALoZ0UVGaXwj5J460UCQPI
	 tCPd+L1MTN35adlctYlSI17ewQI0FWDbejBOB/UxDQELWCsgZU31au3P8srvezgnG2yH8
	 nqXbrPtzl/N+T5PhrgXVOcH5ToIcE8BaC314UHh4M/1d4/UQf4fg+WuIqt5UhHI5yHr0r
	 5w6KdjqiKwr2h0Z+QA677fYVFlZxD9xjfOiV9Scij8bR9VYs70N8k4HM4R5Wyoymo3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ANkl6KIk;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b="Z/xjjXfH";
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF0960A2622
	for <kvm@vger.kernel.org>; Mon,  2 Nov 2026 14:15:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4EF0960A2622
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ANkl6KIk;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=Z/xjjXfH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793628912;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sl0xAa/SyZWrBp9CL5o2SaCOERZeomQ7Ndnf7a0XFec=;
	b=ANkl6KIkamagzMsOQc7bzoUE/7vT1PeZf4X9EEl4VvwRoD5/G0MZOrgM4GXUPaA5wxkf9l
	bu4bVZb09DuYT+AEoxgjDdbKaxp9nL5F92b9nrA+MwCvCd13em41iJkj21uUDTm/xPfYm2
	oDzx/Fi7wFQBR1OxEyZLz8/12VI3HwE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-696-x4V988tLPR2LuqbFpQf6CA-1; Mon, 02 Nov 2026 09:15:11 -0500
X-MC-Unique: x4V988tLPR2LuqbFpQf6CA-1
X-Mimecast-MFC-AGG-ID: x4V988tLPR2LuqbFpQf6CA_1793628910
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-48c415561aaso2078888f8f.1
        for <kvm@vger.kernel.org>; Mon, 02 Nov 2026 06:15:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793628910; x=1794233710; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=sl0xAa/SyZWrBp9CL5o2SaCOERZeomQ7Ndnf7a0XFec=;
        b=Z/xjjXfHAg5mHAeeadaHPosdzhuRIhd/JdCRjAAxO684gICcOzzz1n4AkNfKUc2KxP
         9l2KjCcLHWS4qY7vvUzP1MCjID1QzBE9mCWDT/2InZlzNMy37WGBea/pBOVx1IuwuqUK
         2LHeVK07QyKj8buNErt3n1Ee0McP3CRTQY2i5etscsCxnCFzCAIwp5oPQtY1AOSrFse8
         9KjxM5t6Bl+T0XMuDD7psiTCjI0FzaIs6r9k3sCBuwJTXKycueQlZjbuVIGNCdwMSqrz
         DJL54Uo8rOFDfYdJUA+sV6LwKdYVDePIktHj7xf0AC7NRC1ckDQskSrX8CH9XxKgKZuD
         yeNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793628910; x=1794233710;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sl0xAa/SyZWrBp9CL5o2SaCOERZeomQ7Ndnf7a0XFec=;
        b=NBZl1vafip/4gOHSJMF/FuqiF2bIeEF0WHIIFPTejLIsc03JCgpnAfy4YgWRN72pxd
         svaEUpzTKLn7rgEcskqJwDnQNddVlrqggp6XjQStuxYVq04MG5XddUV+I/nNzT9d65Rf
         4HPlQK6A0iZSiEFn/NVSU/yZA+5fSZaslD9yqykO4VFdwnRKtxeH6xp1gQwe/pxc/OUs
         MUCrcCndvaQBdFornXSNUzfAtTW+QKAbcJ5FJDLFYO15OEzQBs9DF6MITHJIxM3Mz3Y9
         3wibehbqElEVZnCGGBB87azgsQuo3WEzF3vun4qa/xloYGBHHK1k3jHk+RE5BIy8pMkJ
         o9QQ==
X-Forwarded-Encrypted: i=1; AKwUvBw2HAvA/mWytNNOwbjl6Ns7KlxIMiX5K5rXteJxWO/E5w236Nzqrl/AdpmBVUncvTastV0=@vger.kernel.org
X-Gm-Message-State: APuU4Z97JITxDzI71zzlPsLkq61ZoSX2VAplqGIY9A60NpZ6hDjnBSLH
	ML+BrFD4It7wjI2voJb4tMAiem65cO2n12uwd9eHfGolzl/J8fVsBngcFyeDluN8sT+NVpU1XiZ
	GeEgjjOiWhBba36bv645eHt9h7x/p0WCwO7RZngtWKZtaeNH+cl4LYQ==
X-Gm-Gg: AYBFou21wI/NEvO4wrqq8M17l/QKA1SKYUOYTReSUMZW5oN/QTXCzQN4fVgb7uD6528
	B0tjJuv37lxwE0+K5/DkYfehUCJwfkTKN1BbNUBVVpK1BwcSgeocVR1AU/QBMhqCZ7aogsXYqLI
	mej5vBzfrR6n752UF1KwmcPE6JjQnK6i+veGkwjxU00oQBCyuzNvEgcyeZBK2te/SS/KOX1wdAk
	nvDOHh4e8ChiRVpU/cBqzdlhs7x4O9N+NHWHnGDvvWpy72ILNhqDcWgT+MAwXJ2SI7uX02g4pen
	IuVUB5jL60ugeqBl0/xa1AkmprLe/ATy+wAlS4dBdf+F6clgLKIbV+HN+xIGpFQ3aYf0FLKhg2/
	NAJBAXgnFRVy4YkajP+T7+OktYi0KGpXm1HIBkPprNg==
X-Received: by 2002:a05:6000:25c3:b0:48b:db7:86a7 with SMTP id ffacd0b85a97d-48e6e517f2bmr20529289f8f.50.1793628909018;
        Mon, 02 Nov 2026 06:15:09 -0800 (PST)
X-Received: by 2002:a05:6000:25c3:b0:48b:db7:86a7 with SMTP id ffacd0b85a97d-48e6e517f2bmr20529177f8f.50.1793628908269;
        Mon, 02 Nov 2026 06:15:08 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:1501:b100:9ea2:fd21:b361:8dab])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71a4d425sm20775864f8f.1.2026.11.02.06.15.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 06:15:07 -0800 (PST)
Date: Mon, 2 Nov 2026 09:15:04 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jia Jia <physicalmtea@gmail.com>
Cc: Jason Wang <jaswangio@gmail.com>,
	Mike Christie <michael.christie@oracle.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Nicholas Bellinger <nab@linux-iscsi.org>,
	Asias He <asias@redhat.com>, virtualization@lists.linux.dev,
	kvm@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vhost-scsi: fix event queue iov out-of-bounds
Message-ID: <20261102091441-mutt-send-email-mst@kernel.org>
References: <20260904005240.502787-1-physicalmtea@gmail.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260904005240.502787-1-physicalmtea@gmail.com>

On Fri, Sep 04, 2026 at 08:52:40AM +0800, Jia Jia wrote:
> vhost_scsi_do_evt_work() uses vq->iov[out] after vhost_get_vq_desc()
> without checking that the descriptor chain contains an input segment.
> vq->iov has UIO_MAXIOV entries (1024).  A chain of 1024 output-only
> descriptors yields out == 1024 and in == 0, so the length check reads
> one past the end of the array.
> 
> With a host-side harness that sets VHOST_SCSI_SET_EVENTS_MISSED and
> kicks an event queue filled with 1024 OUT descriptors, UBSAN reports:
> 
>   UBSAN: array-index-out-of-bounds in drivers/vhost/scsi.c:611:14
>   index 1024 is out of range for type 'iovec [1024]'
> 
>   Call Trace:
>    <TASK>
>    dump_stack_lvl+0x5f/0x90
>    dump_stack+0x10/0x18
>    ubsan_epilogue+0x9/0x39
>    __ubsan_handle_out_of_bounds.cold+0x50/0x55
>    vhost_scsi_complete_events+0x55f/0x5a0 [vhost_scsi]
>    vhost_scsi_evt_work+0x17/0x30 [vhost_scsi]
>    vhost_run_work_list+0x8e/0xd0 [vhost]
>    vhost_task_fn+0xe1/0x210
>    ret_from_fork+0x348/0x540
>    ret_from_fork_asm+0x1a/0x30
>    </TASK>
> 
> Require at least one input descriptor before indexing iov[out], and
> treat a pure-output chain as a missed event like other invalid event
> buffers.
> 
> Fixes: a6c9af87363c ("tcm_vhost: Add hotplug/hotunplug support")
> Signed-off-by: Jia Jia <physicalmtea@gmail.com>

Applied an alternative more comprehensive patch, credited you.

> ---
>  drivers/vhost/scsi.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
> index 9a1253b9d8c5..9b5f07f52b0c 100644
> --- a/drivers/vhost/scsi.c
> +++ b/drivers/vhost/scsi.c
> @@ -608,9 +608,10 @@
>  		return;
>  	}
>  
> -	if ((vq->iov[out].iov_len != sizeof(struct virtio_scsi_event))) {
> +	if (!in ||
> +	    vq->iov[out].iov_len != sizeof(struct virtio_scsi_event)) {
>  		vq_err(vq, "Expecting virtio_scsi_event, got %zu bytes\n",
> -				vq->iov[out].iov_len);
> +		       in ? vq->iov[out].iov_len : 0);
>  		vs->vs_events_missed = true;
>  		return;
>  	}
> -- 
> 2.43.0

