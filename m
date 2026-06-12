Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 397DE38F65D;
	Fri, 12 Jun 2026 16:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781280937; cv=none; b=P1+ErurwD4uNkk6wE71Lf/xptDcR48cVzdRmqGn/57kFkj7aZS8WR7+lr+ILORaWwTtzItOnJrYFQRaRa5/CS4yZZozvOOBn+IlRgbSklmy/xY8L/FdH2I/X8J94sMcTLNE2xZMQCWudWIU7z+zqLayscI3yjmn3jJrWQc3G0TQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781280937; c=relaxed/simple;
	bh=ATSFQEY1CwJTUmDSVrHb5jYDsiewUQH5akD/gAFtuaI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PPNKsB3rCwiPsrkzsT8Vkj56rRzinu5CFoQpGWsFKF8GS6w5tUb11lXJXQpXtKOZ6Bd2BB9or7FoO6vRbB4zX34REJcSnGYvvq/oBNhCz28X/B8PQ2xN8l1KarbJHYSosdSCeEJsNShHZ+97OGEAlAQsG1fm2HA30kIU13tZMdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=KDvBjBXd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gEJjyj/y; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="KDvBjBXd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gEJjyj/y"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 4EEB4EC00D2;
	Fri, 12 Jun 2026 12:15:33 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Fri, 12 Jun 2026 12:15:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1781280933;
	 x=1781367333; bh=xeTSG/mCGy+BW58099UUh/T056uih+shAh7IocLtPVU=; b=
	KDvBjBXd4xOSmtd9u1aXf01jRAka3wwPZ/1HqD92nJi1daVljb1uLnLNFDtiWrH+
	4ptQBBElnYEOHMlctvLETOIo0/8zujlXbYzbvDxHeHCKxc7UaMxPxQmGsTWm7pAM
	8TbyFgPMuYj8mXR3uNcANMoJM5g58S8kXyIlMpHxaivL9p5amwd5WzwKwQtfB9wp
	LS+QYVdXd6gk46dhJMs983P/l/KxoiDqflPMe0nkZXwKYvAmtaLtOFUZOD4deS9v
	mvgkXwIwM5PaACFbnrBbz5j7oUkymtIC0zadV/bXjsLLvm2Sck/hGl9imgtu+oUV
	JNWLh9/BIPFOjHBah2zcXQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781280933; x=
	1781367333; bh=xeTSG/mCGy+BW58099UUh/T056uih+shAh7IocLtPVU=; b=g
	EJjyj/y8q+w5kaQT30q2gDMTOLmrCzEXK1cRcWz/kMWnasClp9qZveO3Rjxk1AEk
	zX1fApoVPSyg6NJ8lBxIvjgD+niCheTLSl0kVVqrIWyarLFI6G5zGU7y/t8YkvOA
	HTEUv64dQeICBL7LyW7u8mCm9sKm5kcdWn+BP/mHJP7uuozGW+Gl7UDHI245W5tc
	gUdppL8hNguNZo5Io3ERodeFldCJ1giFPjbnLHAArK+OZfq7IjvfZ8dQ8yG6cpqw
	8va7mDIj1lQMMLgFvkeDmKFKceYd5+yV4qnewsxerzCe4Zrm8UQ4tEkNvrREEjgY
	GWICq8s+aOUOEcMDhTYzg==
X-ME-Sender: <xms:pDAsavO93LspFkOsImwaJa4qPV72ZXQWyAlR4GXeIdZ7E1NRHaWqbw>
    <xme:pDAsaqqgWLTISBULgP1Jp8n6KEuZOV6cbzCpz4oit40MlUku3sg0FkeabOCxj-ypA
    CBeYOuJ9PAbZm5ENqjc6aCTWv3TPNAeFrHW5Mf6SDBWQWrHHvzP4A>
X-ME-Received: <xmr:pDAsasf4gToBrouIS6O6ZaIEBFkpi1Wjoumvz0qT0e1W058jsjq6n-cNDiE>
X-ME-Proxy-Cause: dmFkZTEJDJBgoZkVbm/VrMJvAc/nMv88yLNbS1SkaMsmSV33O6AliIoQ2M4udPNcgML2/D
    nrFvHCmWvHvGH+UxzbCp6giBKqc2a41aH8biqOlA2BLHE4aW69mw2aSnqctkR8p6OBfisV
    UkQLM6dJ0g9rH5AR2vc7642JSKaShH57gPrxaZ24SOzrAh70H2+gWt9aUGfqOstS0RbVLf
    ar0qftDsC9fyYdUYdc4EvMKZ1b7B9kKgb4LvBnw432KyOYllftaT7YMrMhS9PR3x9yK9GF
    HUg6NvkNaqHgRmUwvwx5BJd8h//ZFJhk5kAadh+ep353P/OXE136RD7yV+fcIMrnGOzxVU
    e+9X99leCtQW+1chG1xQ3rl+6Bip41cl1tYcYlHX6e2whp/Z7a11gVSI1nFWCGYMsZ0kmS
    rQ3dJW08N38eZx9QwPnu2jHokGxGdkUhXIr2ObEwariFTcNK7egr6BXANwyXruLIdFHPCD
    Qtx2c7uWQuNS/Oxd5UIWJ1JD4Bgw0GKU7meW16YhYcR0pZnFeYU0BphzIVrR2vaw7wRzXu
    OwSEIbiKd66wIFHAQYnWvu2DYqhDkqEMGeZ9d7dEAbZ1TzJuR9pacn/5UfK0dJs+fRNbkX
    DJs5F6DW8Pfw06gOwxulHqBrzuoqB6jxJqZ/AOUsC81CJO7Yu/TpYV3yrqmw
X-ME-Proxy: <xmx:pDAsaoQWm-oef8kWBkT4uTUxzFke0OorlS1Fo93GB8eeJkkPtLGzjA>
    <xmx:pTAsataJzefBkmYsei_g_ibnHJG5UdGmySKhrdXacVQiLJ7XcyYP0Q>
    <xmx:pTAsajfvCpARYKztMJpv0dGqOjOSRpl2J99Fz4rU0eTe86II-aN3Xg>
    <xmx:pTAsamIC1POHcx6hb38LCVivVnzxdABnjkIZ0tFfnrSKtqduJSt0dg>
    <xmx:pTAsao55JYqA0u8KhBkamx5kPOaGtWqRttKVHsBNJJ_7JYqZd8M1TGzb>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 12 Jun 2026 12:15:31 -0400 (EDT)
Date: Fri, 12 Jun 2026 10:15:30 -0600
From: Alex Williamson <alex@shazbot.org>
To: Yash Suthar <yashsuthar983@gmail.com>
Cc: pbonzini@redhat.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 skhan@linuxfoundation.org, me@brighamcampbell.com, alex@shazbot.org
Subject: Re: [PATCH] kvm: vfio: Convert kvm_vfio_file_add() to use CLASS(fd)
 and guard(mutex)
Message-ID: <20260612101530.7b8b8edf@shazbot.org>
In-Reply-To: <20260523050242.41472-1-yashsuthar983@gmail.com>
References: <20260523050242.41472-1-yashsuthar983@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 23 May 2026 10:32:42 +0530
Yash Suthar <yashsuthar983@gmail.com> wrote:

> Convert manual fget/fput call to CLASS(fd, f) and
> mutex_lock/unlock to guard(mutex).
> 
> This remove the goto based paths both out_unlock and
> out_fput.
> 
> Signed-off-by: Yash Suthar <yashsuthar983@gmail.com>
> ---
>  virt/kvm/vfio.c | 37 ++++++++++++++-----------------------
>  1 file changed, 14 insertions(+), 23 deletions(-)

Sean already took Carlos' series[1] that mostly 


> diff --git a/virt/kvm/vfio.c b/virt/kvm/vfio.c
> index 9f9acb66cc1e..bb3694d9c0c4 100644
> --- a/virt/kvm/vfio.c
> +++ b/virt/kvm/vfio.c
> @@ -144,45 +144,36 @@ static int kvm_vfio_file_add(struct kvm_device *dev, unsigned int fd)
>  {
>  	struct kvm_vfio *kv = dev->private;
>  	struct kvm_vfio_file *kvf;
> -	struct file *filp;
> -	int ret = 0;
> +	struct file *file;
> +	CLASS(fd, f)(fd);
>  
> -	filp = fget(fd);
> -	if (!filp)
> +	if (fd_empty(f))
>  		return -EBADF;
>  
> +	file = fd_file(f);
> +
>  	/* Ensure the FD is a vfio FD. */
> -	if (!kvm_vfio_file_is_valid(filp)) {
> -		ret = -EINVAL;
> -		goto out_fput;
> -	}
> +	if (!kvm_vfio_file_is_valid(file))
> +		return -EINVAL;
>  
> -	mutex_lock(&kv->lock);
> +	guard(mutex)(&kv->lock);
>  
>  	list_for_each_entry(kvf, &kv->file_list, node) {
> -		if (kvf->file == filp) {
> -			ret = -EEXIST;
> -			goto out_unlock;
> -		}
> +		if (kvf->file == file)
> +			return -EEXIST;
>  	}
>  
>  	kvf = kzalloc_obj(*kvf, GFP_KERNEL_ACCOUNT);
> -	if (!kvf) {
> -		ret = -ENOMEM;
> -		goto out_unlock;
> -	}
> +	if (!kvf)
> +		return -ENOMEM;
>  
> -	kvf->file = get_file(filp);
> +	kvf->file = get_file(file);
>  	list_add_tail(&kvf->node, &kv->file_list);
>  
>  	kvm_vfio_file_set_kvm(kvf->file, dev->kvm);
>  	kvm_vfio_update_coherency(dev);
>  
> -out_unlock:
> -	mutex_unlock(&kv->lock);
> -out_fput:
> -	fput(filp);
> -	return ret;
> +	return 0;
>  }
>  
>  static int kvm_vfio_file_del(struct kvm_device *dev, unsigned int fd)

