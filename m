Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4166A3164D6
	for <kvm@vger.kernel.org>; Thu, 25 Jun 2026 13:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782395343; cv=pass; b=OBxd/m43LQuEW+aAZThXga3hWRP7d7tksGUnfxgxl9aD9dTYyjLoEu60Ns8KDsYqL62kTRl3QMaW32d0p/0GBoPVx775EPdCD0H9bwcEM+SDKiydeWBSp0EXiq3sfPUlHWcnK72nl5Q+ng2t+hxufOU1j5ntd1ju/2MRWhkiV38=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782395343; c=relaxed/simple;
	bh=FyKAtny/z3K2aOAcLJ07FAa4Lo0Z1QSMYiY1kmIuw6k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZTiBM7rVwYIMkoTg5zSG6gRqF0yJFU+dJeW656ayCVkfFdqgWxwdGReBymxUFQ1VKusHzVdpkD96QYo3fGqIr9lxwjrkPkiJx6UgfKA7ch5Q0As948qYWf0G4K8Uwcd49mfk+P9hzpC/QiZ3W+9yCUvZxUp7k9UkuMt6Kz8cPGM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TEg25zpA; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=NoLjEyTd; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TEg25zpA";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="NoLjEyTd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782395341;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W13IHKSrmFxYZTcAI1XOj4ABHyKjyq7rqzl7Q9cJsPY=;
	b=TEg25zpAIlyqfAcSnY6IGCBMeeR4P72s31lpVcNlp2iwAtQAtC6ZsZECcRjOsUmxHbLpbK
	sUPkHY7UaOR1riRGM2E1+jFQSVP4tjYMEkjgQKJ1egnpcu0rPgeugp+55aWb6FAMicNfoK
	a/wdzDcz3c3qpW57eyIFe2gps17KTKU=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-481-R-h2JZURPxGfEngT_4Njog-1; Thu, 25 Jun 2026 09:49:00 -0400
X-MC-Unique: R-h2JZURPxGfEngT_4Njog-1
X-Mimecast-MFC-AGG-ID: R-h2JZURPxGfEngT_4Njog_1782395338
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-399919e5fcaso10858221fa.1
        for <kvm@vger.kernel.org>; Thu, 25 Jun 2026 06:48:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782395338; cv=none;
        d=google.com; s=arc-20260327;
        b=mOoIqI/0ERFJjJ/COlw/+XONHAIvzI8I25vpYdzu039sqzKSbSAMO4NRIaOJeWzk4a
         4V/5c2q0YkIfkKrpLHqVWpAn6PvAp/vJflQkbEXDZhAQyTTvhpt1S6uL2WSO3PD6Px69
         IiI92f3V5ku2BtNUHyhkNVpFc4IF5/jIIID32VaPnFusOuy8hZDbjAsxRarVHbpx5cry
         RG31vKuTupUSKaLVm17IXTyglC2/Mm8xJn5tP6Z2plIdojPOwRhy4e5A+LOeD5NqeqoD
         WxBxZ29wDLebdo6RWcgypKCSVHxuK8RtD0qRCqp0dlzxwTvG11/ELIB/YTLLOaI6KuWl
         GP6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=W13IHKSrmFxYZTcAI1XOj4ABHyKjyq7rqzl7Q9cJsPY=;
        fh=Q96lfgysPUebJpgWI6CUkqfSWxielcsw1hz47ME52xY=;
        b=E98+cRXZBQdvomgpdmaoTtl6NxPNvuJwGX3r/RtdV9QjsJIDIWd7wPyr2gV1C5TKYa
         H/iYH3ggHg8TFpQNXCPQSGHnaU9V8UCxJTL8QPjBqr6M5Dq6UJQ6Ar7QVKDH2re097aJ
         8LuPn5dUUGLZatnEd9bFsqLgpXp8Z3JOjn5AENVWuGOY1fQwbxc0FiVUub0OgTMrF4WH
         Lrch3kNj3MWIQNG7nq3PWH3Cnng5kAARmTMYKdI+0sqNPUVuY9eGKlhRFi3+dVUInehy
         NkB2O/fai4eKbhWdLt/daI0OW+JlweqG8SmpTH6JdImzMHoV+MZj1qO/PbQCnExxXmFn
         gdqg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782395338; x=1783000138; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W13IHKSrmFxYZTcAI1XOj4ABHyKjyq7rqzl7Q9cJsPY=;
        b=NoLjEyTdNIvkbGlQv1osN6qdpKu1oCfQFAFTfUV05wIt7puWn+57MO5UZy1jTR8Y6Y
         d+M7t5a7w/CmBD2k++aIY4C861NbfuqkRZEYjrkbNLeJud1JXvNo5fbJmiBmLlERSWjM
         a9OzX/ibXbumN7aEMw/O0NgNJL6eaD0SqiqYPtBKMAxNhCPy1GAxGNtWevn0ZRcNSTP/
         oq6PIj3k2z2tp5gKssF7J8VynU09a0DrqxRF+lRYMIiG5xTPdz/p2EOtYlStT2LtgDcO
         wm2DV9mHd4gs8UCmFJrL1s3deNkF0nbFjv7NkXPJft7VMUKW3jlU0AX+JlIiKa5NJEQV
         weaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782395338; x=1783000138;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=W13IHKSrmFxYZTcAI1XOj4ABHyKjyq7rqzl7Q9cJsPY=;
        b=sDsicjdUIUVuw9Qn/ZB/+cVwfVwRMDdk1o4du3ENLj+VaNMBzxzt+K5CKGPFa82Ij4
         6uZh1kDJw3oICwTbWthug0X9Q0Lv+4hn8E397SdU1fwH+pUSIjRwZLSSUFTf7QpHfFqd
         psvmEn0msd44xMzJIbqqiJE7kBJV0AX5UouQfUQ2b3rsTWFhuiVuQxYkMYb+bSbRlSvj
         fSnMoH0za/2NDxk4aSSVmeGkv7SE1l0+N2nX6ngNt0ex59HQAt21Q3kUiWQdY2JwtXWz
         +5Ph6Qx2HD5SuRPXAr2A7uwcWSI3iSPbtUQSX6JzdgarHuMCcEQz5JIWtdkF6cvSwqQv
         4+Hg==
X-Forwarded-Encrypted: i=1; AHgh+Rrz4qKF8YYNNfEe9TwYgMuqF8rKg1UpgTg0G/GZJ5k4b0gDmjypCXETj5ROG2s9DKz9jTc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZcfU0YI8cODhgtrfbUWmJb35orbHdIyFd+nfccBmubdyf0CTU
	gMC+dZoMguP1UT+b/3xrwoB8WlzaIjAmRT5BG1ZTZbMFzHLMWeR0l/+T3MuV6NoJbAR5itq/SjB
	eRmOM+m/0lSXv2xlqMktnj3FAhh+F5Hb47fOn3XORmDPHqptlE4Dcv5ZGTdCEf+cbvk6R7PEPo+
	p26324MiKlhvASPlBJy2MlUSWOETri
X-Gm-Gg: AfdE7clDQJq44q9RK9Xa5aa3RlzDFGs0t+OPAXOXv93W+q6+vuN4NK3tSqBvGH4ob+y
	7L9MJOIapbxe0ZXj392xsF/aNoXvRZX/md2hXqjgJxpKV70XXESr3Uh3P4KmlQstRJ4bwwBGUGs
	c863DMZmRq7vI/eRIt1G4OtOMxtVDBr6PjQxkuvR3mDudzWI16ZAEWJbsreazeaoBnvVg=
X-Received: by 2002:a05:6512:20da:b0:5ae:a021:6b37 with SMTP id 2adb3069b0e04-5aea1f648edmr586221e87.40.1782395338356;
        Thu, 25 Jun 2026 06:48:58 -0700 (PDT)
X-Received: by 2002:a05:6512:20da:b0:5ae:a021:6b37 with SMTP id
 2adb3069b0e04-5aea1f648edmr586207e87.40.1782395337730; Thu, 25 Jun 2026
 06:48:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260526080336.61296-1-r4o5m6e8o@163.com>
In-Reply-To: <20260526080336.61296-1-r4o5m6e8o@163.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Thu, 25 Jun 2026 15:48:18 +0200
X-Gm-Features: AVVi8CfV4sl2uVjBO80B06iwl-K1gPbYL0GUC3qWAw99NMlfQNPKKN6RpIXYBRI
Message-ID: <CAJaqyWcFm0A5ucL5TLP8+T8JNOiZyaL-_mb747_fKhH9Qm83ig@mail.gmail.com>
Subject: Re: [PATCH] vhost/net: fix clear_user start address in VHOST_GET_FEATURES_ARRAY
To: "rom.wang" <r4o5m6e8o@163.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Paolo Abeni <pabeni@redhat.com>, 
	kvm@vger.kernel.org, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Yufeng Wang <wangyufeng@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 26, 2026 at 10:04=E2=80=AFAM rom.wang <r4o5m6e8o@163.com> wrote=
:
>
> From: Yufeng Wang <wangyufeng@kylinos.cn>
>
> The clear_user() call in VHOST_GET_FEATURES_ARRAY incorrectly starts
> at argp, which is the beginning of the features array, overwriting the
> data just written by copy_to_user(). It should start after the copied
> elements at argp + copied * sizeof(u64) to only zero the trailing
> unused space.
>
> Fixes: 333c515d1896 ("vhost-net: allow configuring extended features")
> Signed-off-by: Yufeng Wang <wangyufeng@kylinos.cn>
> ---
>  drivers/vhost/net.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> index db341c922673..70c578acf840 100644
> --- a/drivers/vhost/net.c
> +++ b/drivers/vhost/net.c
> @@ -1777,7 +1777,8 @@ static long vhost_net_ioctl(struct file *f, unsigne=
d int ioctl,
>                         return -EFAULT;
>
>                 /* Zero the trailing space provided by user-space, if any=
 */
> -               if (clear_user(argp, size_mul(count - copied, sizeof(u64)=
)))
> +               if (clear_user(argp + copied * sizeof(u64),
> +                              size_mul(count - copied, sizeof(u64))))

The fix looks good to me, but why not use size_mul() macro for copied
* sizeof(u64) multiplication?

>                         return -EFAULT;
>                 return 0;
>         case VHOST_SET_FEATURES_ARRAY:
> --
> 2.34.1
>
>

