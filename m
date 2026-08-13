Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2BA943F4D9
	for <kvm@vger.kernel.org>; Thu, 13 Aug 2026 09:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786614259; cv=none; b=cNukcZtt7DJgFUqvRkD7Z4A5Vgok7gIgguONPJOcjqm+LlfZSciltSz+l1Rh0ht3lYiyz/ZPW7vAbuxQ3I1zUZKyMQurmKlWDCS+H5lxPcPqcOTIH5hF/l+RovxDiEjmYNyDsYIHDD83lbRjtH2lNnB+X7hzCbVQOxYyDElkO/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786614259; c=relaxed/simple;
	bh=vgzaF3qPw7XT8z3S/p3BGnzqBFJxnHBrEI32qQLtUnA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Oa+DTAiffHNoNgQnWA1lc1WWfvfFve23mbOL6gBQSETT3LJ0IhW53v++AnlNhiHbo04a7NqoJoq9NqEVO3l0NMNmlEGs1I5S7g2LXNs8mpWu5sh+dkK+TShPfGTpp9CfVUCc/IGSfN9R7t2lEz5G2dtAwuiCHXNXjXQPGcwyRyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gD0SgOMi; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Hgj3RKT8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gD0SgOMi";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hgj3RKT8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786614256;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8D9Deqo+ItAekvrmdJrfUPwAZJZl2cNIOe034Qvr694=;
	b=gD0SgOMiTrWVTo+TEOnhWChAEQNO7gYVDxbPczvGe5x+pIABHiXMyFHbXpNhOurH7BPW/q
	irdpSopPoEOtxb2+kY9O4pcXowxQFlxnaOcjW3AMbbWgAM2vqmym7I2Ztd+t7iSiH1orOg
	VjVLOw/GEPQh8Ymgkrdccu0RbtP1Sko=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-435-aAFDJ0RPMAWuYmuc_-k0lg-1; Thu, 13 Aug 2026 05:44:15 -0400
X-MC-Unique: aAFDJ0RPMAWuYmuc_-k0lg-1
X-Mimecast-MFC-AGG-ID: aAFDJ0RPMAWuYmuc_-k0lg_1786614255
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-47f2de3ba47so1292545f8f.1
        for <kvm@vger.kernel.org>; Thu, 13 Aug 2026 02:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1786614254; x=1787219054; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8D9Deqo+ItAekvrmdJrfUPwAZJZl2cNIOe034Qvr694=;
        b=Hgj3RKT8yzVl0dmnvaoJ/RmOT0bVF1Ag2CrcpvBBw4f2fUriA4pkgun3v+mxr/wTGC
         T0dGKFLEZ34PyMcatkvf3SHl532NhNNL2R+YHj7PvJUsr6RO3N5xCRVLDabcNHScNFWM
         k3xNADqAbxlUgRGvTp4vmo8aIO/eY8GnJEru78EO8VIC5QvACZ0VmG7JUc7tais5HCii
         neksxOLUN9MmJ0OYHTbw2BrUSDXuf4XxfgrbSPI4G3xvl8dGYUL0aocrG7UqE8Mo8FYk
         XNrzRuYC+d22+FHAFbVGmhZqQ+99WNuPk1q4s9R+wB3KzcVnBfn+3K5+zkh/smarRBAB
         RjnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786614254; x=1787219054;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8D9Deqo+ItAekvrmdJrfUPwAZJZl2cNIOe034Qvr694=;
        b=Nl38ZacOjMv5GgapCV91xpGzQZ827wMK9MWkbvd7jrhIicwiiwTKNDmElx93iMt9NT
         LxBdss9Qf3aFONRpzm3/gqZwgJWIy1D+8qGhNW2Xvakvn1K0xZvV6m5ALtl5sZ339dQ3
         Wt37s3TEQIJEZ+9D8pArNyM+YSnxjOEwLf4m1WTSuwialSPfukeNLsj3iY+XO1MWpAg8
         iPpVxCo5uc5OiccEPf32CdcRJ37k1wSaaKtb5wVN9CX3OpMOQr9CyMCc+JdzzhNG0KZA
         8s6M4HccElPztvXfpuAbHjR2LE2Uha2IQ96H5uGJnFhTT1CqugPU+hSaxwVF0iOxEKn8
         4fDw==
X-Forwarded-Encrypted: i=1; AHgh+RoULVJeOswJKJ8i5mnFnwEVZ6AWMCB6YKJlK6BrXdx4+ywFjKLAzAtcSoNL/tzhNKewZlI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsO7JHDmvZ69nufDsIRzOMeIz2Li/7JVfvCrqh7EuRHTIJSYr9
	uW4zmmgQ7DdSF10AI4Zn0gzDSJ3+DFLi9xRgCpArdvx3/vQAGUJrvi77Uk8OwHine4UPRIGmOKE
	FdK4C5tVB+yrvgDSWzlahHZZAcc6Svf58zgT4jtf6U3Y9MuoZh8WTcQ==
X-Gm-Gg: AR+sD11rCNcajZoMClgSYt1ig8L07U7H9AZkA6QZKzBad5qs+Fy+cicgqnlVpG/4Bp4
	S9U4SuuhtI6Ah9wtRXY6M+GRQD26YM581mXm8ztErf5a5U/jvCST0d3I1mMYsjGTdtLsS2EJnN5
	mi/LjMQsZt/UAFIU5ZotYSNDgospbVKNzkXYtKV1J73rGBI9+2uZs2wb4DUN+yTMZDGI3pqmCoO
	goY1N2DOGqSypHLAp1Gwys6viwN0arKeiblIbQWDnyA1Dwm8vIqZYipbME9hG/GAGDnOCUCRZH/
	gZqQvF0NckN68nja+SC12ogchE71heY2aKoAJSBqY/wEQ509uEHVM1AaNJp5qkA3L297UdXDZUN
	X6FDYFVwUeev9i1Nv4V9Nr5JpnmVS4ShG0K7+dDleF+D7JnDx59dI
X-Received: by 2002:a05:6000:2304:b0:47f:81c4:36a5 with SMTP id ffacd0b85a97d-48159fe3877mr5877717f8f.15.1786614254505;
        Thu, 13 Aug 2026 02:44:14 -0700 (PDT)
X-Received: by 2002:a05:6000:2304:b0:47f:81c4:36a5 with SMTP id ffacd0b85a97d-48159fe3877mr5877650f8f.15.1786614254041;
        Thu, 13 Aug 2026 02:44:14 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-135-154.retail.telecomitalia.it. [82.53.135.154])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4815a5613e2sm6594939f8f.6.2026.08.13.02.44.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 02:44:13 -0700 (PDT)
Date: Thu, 13 Aug 2026 11:44:11 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jia Jia <physicalmtea@gmail.com>
Cc: stefanha@redhat.com, mst@redhat.com, jasowangio@gmail.com, 
	eperezma@redhat.com, kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] vhost/vsock: keep IOTLB across feature updates
Message-ID: <an2RzeZ2zI8mWFRM@sgarzare-redhat>
References: <20260810134018.143973-1-physicalmtea@gmail.com>
 <20260810134018.143973-3-physicalmtea@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260810134018.143973-3-physicalmtea@gmail.com>

On Mon, Aug 10, 2026 at 09:40:18PM +0800, Jia Jia wrote:
>VHOST_SET_FEATURES is also used to update logging while a device is
>running. When ACCESS_PLATFORM stays enabled, allocating a new empty
>IOTLB on every call drops valid translations and forces avoidable
>misses.
>
>Initialize the device IOTLB only when one does not already exist.
>

Do we need a Fixes tag here?

>Signed-off-by: Jia Jia <physicalmtea@gmail.com>
>---
> drivers/vhost/vsock.c | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)
>
>diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
>index 7372c22691de..1beae7f5b9a9 100644
>--- a/drivers/vhost/vsock.c
>+++ b/drivers/vhost/vsock.c
>@@ -889,7 +889,8 @@ static int vhost_vsock_set_features(struct vhost_vsock *vsock, u64 features)
> 		goto err;
> 	}
>
>-	if ((features & (1ULL << VIRTIO_F_ACCESS_PLATFORM))) {
>+	if ((features & (1ULL << VIRTIO_F_ACCESS_PLATFORM)) &&
>+	    !vsock->dev.iotlb) {

Do we need to do the same in vhost-net too?

Thanks,
Stefano

> 		if (vhost_init_device_iotlb(&vsock->dev))
> 			goto err;
> 	}
>-- 
>2.34.1
>

