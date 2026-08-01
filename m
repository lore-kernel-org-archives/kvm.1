Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E7B7262B
	for <kvm@vger.kernel.org>; Sat,  1 Aug 2026 00:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785542423; cv=none; b=laoP0xYEg69n7xgmicFYCZoT937FhzE7XzfIzx3dNifTuf9L1G4j01bHWroxMRoT0XNTjd8eUo94FRb8JUb4Y0Q4EZlkjVRo4AaerX+/e9Q5UqJmp+veMVAjafD62SyHbEuauylEz8xM2u2IdWmZnUNknMRvusj8NlT+/xmK9d0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785542423; c=relaxed/simple;
	bh=O8HqmJQWZA1nfUBNMj9sxQRGTvaC1yJRVK0bfgHcTrY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iJSQS9Hx0ppq7hJmscM8r9m3hsnHlpuvT4Bw6hbH/a8mYYeWxqbJpjjfWkaPqarYsdSmpJRn+gmOmLAZRVgRC9NSnJzsZhxXsDL6u/LsyxQL2OmwLCisXYeTmTmOdNTIEY2DKtDj8lod+9ulhVSsVF38jW0m9fVZejphl/pJL0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OVafTl4e; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=laVcCU9D; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OVafTl4e";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="laVcCU9D"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785542420;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=H0eYF5OZd5Mj1htNYojskxEZwjl7/C9yBVDIfFNOInU=;
	b=OVafTl4e7n9t5YKhPD+8IajHWu7a4YBNP6/vV4hjzpAHJcN8kOg34w6JthVhWUvWM29lpD
	XjEixjqZGaRI1baMySq5HD8u0fEmOuzuS+U8wjq40yeN+mwCZ4XLg7NyeIPyHg5xbx7TQv
	AljCpzZKpDhF1rgrj5YuO6WaxaSEimk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-688-rYhkcqv6NQu7rw7miyCAng-1; Fri, 31 Jul 2026 20:00:18 -0400
X-MC-Unique: rYhkcqv6NQu7rw7miyCAng-1
X-Mimecast-MFC-AGG-ID: rYhkcqv6NQu7rw7miyCAng_1785542417
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4955b84e25eso2021435e9.1
        for <kvm@vger.kernel.org>; Fri, 31 Jul 2026 17:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785542417; x=1786147217; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=H0eYF5OZd5Mj1htNYojskxEZwjl7/C9yBVDIfFNOInU=;
        b=laVcCU9DWjNxIeKBmrEPilAP8c9LzvZKUb40q/xfrJeNvkYHAH7XfBw83Wnfw6+KLI
         3c1bRRxR7o+4Im4AaeA/4rm+LN4WS/cRYyuQK7IOTR/oab11JgdimMe1jGtN97DcyR4i
         K+f/somufouLzLVPft8k5i4vDWXZxsFtpJZLZOU48XiEQlGtc9dDjHLKbVPO3E9A4xZP
         W9ufSa/aXhGnSBc6bBZocXtjM2+9SoIJodAmcIF5Q0JAjOPkl4obZtn+P7zx/QLwSALB
         wPFvLuVVO8GICzHZOjH/okVkvT0v9DhoDVo7ryO8NuTpHdpDzQvQo172haf3gSc+zEgO
         c5mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785542417; x=1786147217;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=H0eYF5OZd5Mj1htNYojskxEZwjl7/C9yBVDIfFNOInU=;
        b=CGORgNAq+ojD6mWhpCMMy6pq/0eOhvMp3sc4F5pRDN2nzU0GjJkFe2mVoohnriDeBZ
         84OxgmwEbFFw/PzmGAjf63ZdfyA63ruqCsMPHyOMyyulVe6hto3GRaP8bwWegI5z/Yqp
         WsXAkU+8yEspO5u2O2IaG9ioCg70AZGdQw5iGO2Q2d6+YBIyeD6v4vr4Ac4atwa3IGev
         NYIwOtFX5CBp3RsWcZaGov0x18uruwKUYR3sGW4FXlpYBaXWNWoz1nFZl5J5fu8tVisU
         U+ZD+oYMLOHhjS0hNBR/s5gCQx+sGjNEtEKBc+588QlXM/juBWkYYvWcQT+59PcIjfQg
         A7ag==
X-Forwarded-Encrypted: i=1; AHgh+Rpcw/M/OiB+3zOgk/PwAPMkoLbGMR1Usk9oULBRm7WGtlQzBIw4Zb+HkQ90cn2Qos2cghE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1qH7WuhYGT3q2vi0UQmP33MJeRBLUDlx2wcWZ5b/NhCCN3me6
	KtMj64IXzjF3FEkieXDX7goNhOz3gb6rtrTDdrHcjOrJkCGWjP1xngC6c8TViOPoxSLuvOiNT8D
	LzvP8jRaajVIw1S4OsnVo7R2ziM0bUMng880ycXE9PmJara3Lrq+5UA==
X-Gm-Gg: AR+sD12rixNL284tPT436Ytjt5PfMUUIXA5ZbCzWoNK8V6ZUoL23PDtaUheHErzboPw
	wStvGWMTz2u3h1vdAW+w6TkvP1MignD2P2OfUgLjfIMSz13n/hFIX42PY30UF+tou4TrNQM4lsD
	sZKbIGKBU32mjhLpI9AKwVWtJZNSlkM37lIQWnjLzX1QEsSCevjRhkEwljq8HPi4NOuWDVC16Id
	8evc1TdF33h1K6xU4J9yGGqTJbe/FE3zBDwve16drHL2ZwTOvXhqYk/1WBmmVPj3AggzgUx85w4
	AsVFz990PLCP6O9lJFaqQbfTdeDZOcrxJu1xJV5UI/Z057AJnack+pSUID/nn4eAm3EcAGzOGtH
	ifD6OQKHCWlN8LvK+beM232I=
X-Received: by 2002:a05:600c:48a2:b0:496:bba5:33a7 with SMTP id 5b1f17b1804b1-4980c6824e7mr1432165e9.27.1785542416738;
        Fri, 31 Jul 2026 17:00:16 -0700 (PDT)
X-Received: by 2002:a05:600c:48a2:b0:496:bba5:33a7 with SMTP id 5b1f17b1804b1-4980c6824e7mr1432025e9.27.1785542416366;
        Fri, 31 Jul 2026 17:00:16 -0700 (PDT)
Received: from redhat.com (ppp-94-66-118-61.home.otenet.gr. [94.66.118.61])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49807eb12c5sm3178825e9.3.2026.07.31.17.00.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 17:00:15 -0700 (PDT)
Date: Fri, 31 Jul 2026 20:00:12 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Dongli Zhang <dongli.zhang@oracle.com>
Cc: virtualization@lists.linux.dev, jasowangio@gmail.com,
	michael.christie@oracle.com, pbonzini@redhat.com,
	stefanha@redhat.com, eperezma@redhat.com, kvm@vger.kernel.org,
	joe.jin@oracle.com
Subject: Re: [PATCH 2/2] vhost-scsi: reject invalid max_io_vqs module
 parameter
Message-ID: <20260731195756-mutt-send-email-mst@kernel.org>
References: <20260731221116.236791-1-dongli.zhang@oracle.com>
 <20260731221116.236791-3-dongli.zhang@oracle.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260731221116.236791-3-dongli.zhang@oracle.com>

On Fri, Jul 31, 2026 at 03:10:24PM -0700, Dongli Zhang wrote:
> max_io_vqs is currently validated only when a vhost-scsi device is opened.
> This allows sysfs to show values larger than the driver will actually use,
> e.g. writing 2048 succeeds even though vhost_scsi_open() later clamps it to
> VHOST_SCSI_MAX_IO_VQ. This makes the sysfs value differ from the value that
> will actually be used.
> 
> hv# echo 2048 > /sys/module/vhost_scsi/parameters/max_io_vqs
> 
> hv# cat /sys/module/vhost_scsi/parameters/max_io_vqs
> 2048
> 
> [  315.630495] Invalid max_io_vqs of 2048. Using 1024.
> 
> Use a module parameter callback to reject out-of-range updates when the
> parameter is written. This keeps the visible parameter value consistent
> with the effective queue limit.
> 
> With the parameter value kept in range, remove the duplicate validation
> from vhost_scsi_open().
> 
> Invalid values now fail with -EINVAL at write/load time instead of being
> accepted and silently adjusted later when the device is opened.
> 
> Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>

why should we change userspace visible behaviour now?

> ---
>  drivers/vhost/scsi.c | 27 ++++++++++++++++-----------
>  1 file changed, 16 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
> index 0c0634eea144..c138c29ce3dd 100644
> --- a/drivers/vhost/scsi.c
> +++ b/drivers/vhost/scsi.c
> @@ -210,7 +210,20 @@ static const int vhost_scsi_bits[] = {
>  #define VHOST_SCSI_MAX_EVENT	128
>  
>  static unsigned vhost_scsi_max_io_vqs = 128;
> -module_param_named(max_io_vqs, vhost_scsi_max_io_vqs, uint, 0644);
> +
> +static int vhost_scsi_set_max_io_vqs(const char *val,
> +				     const struct kernel_param *kp)
> +{
> +	return param_set_uint_minmax(val, kp, 1, VHOST_SCSI_MAX_IO_VQ);
> +}
> +
> +static const struct kernel_param_ops vhost_scsi_max_io_vqs_op = {
> +	.set = vhost_scsi_set_max_io_vqs,
> +	.get = param_get_uint,
> +};
> +
> +module_param_cb(max_io_vqs, &vhost_scsi_max_io_vqs_op,
> +		&vhost_scsi_max_io_vqs, 0644);
>  MODULE_PARM_DESC(max_io_vqs, "Set the max number of IO virtqueues a vhost scsi device can support. The default is 128. The max is 1024.");
>  
>  struct vhost_scsi_virtqueue {
> @@ -2273,22 +2286,14 @@ static int vhost_scsi_open(struct inode *inode, struct file *f)
>  	struct vhost_scsi_virtqueue *svq;
>  	struct vhost_scsi *vs;
>  	struct vhost_virtqueue **vqs;
> -	int r = -ENOMEM, i, nvqs = vhost_scsi_max_io_vqs;
> +	int r = -ENOMEM, i, nvqs;
>  
>  	vs = kvzalloc_obj(*vs);
>  	if (!vs)
>  		goto err_vs;
>  	vs->inline_sg_cnt = vhost_scsi_inline_sg_cnt;
>  
> -	if (nvqs > VHOST_SCSI_MAX_IO_VQ) {
> -		pr_err("Invalid max_io_vqs of %d. Using %d.\n", nvqs,
> -		       VHOST_SCSI_MAX_IO_VQ);
> -		nvqs = VHOST_SCSI_MAX_IO_VQ;
> -	} else if (nvqs == 0) {
> -		pr_err("Invalid max_io_vqs of %d. Using 1.\n", nvqs);
> -		nvqs = 1;
> -	}
> -	nvqs += VHOST_SCSI_VQ_IO;
> +	nvqs = vhost_scsi_max_io_vqs + VHOST_SCSI_VQ_IO;
>  
>  	vs->old_inflight = kmalloc_objs(*vs->old_inflight, nvqs,
>  					GFP_KERNEL | __GFP_ZERO);
> -- 
> 2.43.5

