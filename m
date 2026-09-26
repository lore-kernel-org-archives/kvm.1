Received: from mail-ej2-f42.google.com (mail-ej2-f42.google.com [74.125.228.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1F90396D28
	for <kvm@vger.kernel.org>; Sat, 26 Sep 2026 06:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790405041; cv=pass; b=K+8+ly20OKP3tL5gow6W3kTUaBBh0prjeGeLfXyNoYoCRlCp76U9TxyCQJMrW9RwSVai+n6/A0jIGKJ1IFOjh4Ng4MYzGpqkrawiC5gdtY3Rkvl8vZytQsq9ghl5RbbqR4Uwb8S0cXP8kF2gcejwfLD2ymWcgkYsBxQZwyn1coY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790405041; c=relaxed/simple;
	bh=L/x/MsSpsPMPwv6hmc9szKtWP8yzSBXJpWyuSwDuuXg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ehqk20dQunVHIyXcfpgNvSX2WetJJRsM8BhvUq0j8C1qhxUL0rKYBE2Cj71k1dhOYB7oD24cZ8I8VcUlcuSCMbs8Mu0xNOhxwQpM55sRMiqWYQOvSR/InKK7pcwey1LqvYKUosDRDYOMWUkCmFmwwAnNLy7bX8RUqgE08JYY5gA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jq6u1nQH; arc=pass smtp.client-ip=74.125.228.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jq6u1nQH"
Received: by mail-ej2-f42.google.com with SMTP id a640c23a62f3a-c2afd63c3e0so105585466b.0
        for <kvm@vger.kernel.org>; Fri, 25 Sep 2026 23:43:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790405035; cv=none;
        d=google.com; s=arc-20260327;
        b=d+mberovqqebRzY7VkYYKOQ3J6yFQoo9Cw4NzdEsSai0iaZ6UxFP9xY30tTaxjDoen
         iEfinptcc8gE+jcWxa4y11JYlFFJBHnjw859p7pN7S9okhDNtG2X9U/taF5pi0GU/0c/
         nq2V36BqtbB8/o4BmrkAJ+oimUaJJnyVd4tWtXaYe+qIopcPSsk26RSksuwhOzZRTA8p
         QXeRYfQ50SPYHfW+nenGbvWyDWcOeerWdJjHLBRXvdBllSZx0I3Kttz2QPzlgtEmvcZM
         qtNS471BDU1BV59HPgyASXbXjngZHWOGwr6No5zDje/AQFlmXOfe7T2W6IZS2sedvMY4
         muwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=m19pIzxq/CLGg8+DYWn+q04ehTCniHZwasxO+AvM9gw=;
        fh=8RSmKMLR/rWCP81M7BCABnfkLpkNkR1yU8WZjfLibl0=;
        b=PDcMGTvlMiHzBDEPlN2smeGo2vjpJr9aQ/a/tpb/y+fg3xwaRiGdAO6Y/ox8hDTRJ5
         Qd/DnZr8TJpDvO8ecoQdjyioXNaHq6O8UohnAqH0HnqUEsinfn0TyF6m0KJ4RO9qPGHT
         llPfArpNQ5MPtG+ZT1GjZOkllNun2PQtp8fzBFl+P7f22wb6S8oBBBizkZgOT5nXBgdc
         xH705aFZ00nBKDB795YGBT7m+01BxeAwsh8oV8K4nKZLif3D0f32EE9xNyxIc5lgffFR
         8ygQdQYJk/oiEkJB82A0725XzWBgnhSK8Rm6/OBkbps7e9pmj92pry/dfWx6Yrjeq9tK
         fozw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790405035; x=1791009835; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=m19pIzxq/CLGg8+DYWn+q04ehTCniHZwasxO+AvM9gw=;
        b=jq6u1nQHEYh8t9O/sL0lF53go1obYIzbU7c7HNlYeQH6JvuJRyEJSUrjEB/vOwo5qn
         uesatFnTPfnN9YvYFfBYym7F7JiJRFYkhGITALnNd7wAiRc05YDg4c2dm7GCqBh847BN
         y/exse6jDQyJdgVdzyMDoQu7q7oGTaFCqvoms74GWosmPkhj74h2bzkmK4xF9F6NvKqG
         GoMxX56VXXgRkRvvT3WP7p1PwjsPBmveAxnSTuBVUM3vPcfsLEPQrCulGfBQwlw/zIq3
         oUQjLs7hMkYMA6mxlhE1ypwRyDOfoyXnM0I7O63VKA41BHrDa6luVp51BfAEmALjmToN
         EPGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790405035; x=1791009835;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=m19pIzxq/CLGg8+DYWn+q04ehTCniHZwasxO+AvM9gw=;
        b=SGfRxBO5jYL5vSZEJZBl86VR6jea9r5zowycnzvv3T1QXznBW85ZB8FtRT07jc8g6P
         RloxSpMp8gOZJ7GyT5QieDq0QtVH8A/xIsPvyy+5Ko4f8o5Az710QLuA0GHbjiFNGBN7
         HZL0Zrce2+CdXllzs3jnexOxk6DS55MqAT8Z9zejJUbLuNfDrmntDh6nk6ciP134AdTK
         1zPTQNIRLYYAGcQEQzrb9b5E/aoKk60EqZthX8NE4/SvStE7bjthbkfQM/wezJS1vf2r
         6sm7y4z8BJOM0E4XNBBv+KmSGhMrxir/uO13+AChxrcm9E8Y5osjPPAPnZa1F3JEwoUV
         Q5qw==
X-Forwarded-Encrypted: i=1; AKwUvBx/bV1skftVyaO+PFLgpBrSAk6vEtebU2tTKNvrKmhNZZSwvP/UDlZE05KTedzTal3goy4=@vger.kernel.org
X-Gm-Message-State: AFuF++lk7FrGc658kQuprqLyqUVJ+fcj9ev0gOxRLNags7d0OOwT1GtT
	UKX3N/brbaYBF/4/kXoeA04gvFJf1/bgwHhL8zndw4wMHDWko5L7Ik/LyTadYAVTMv7ayBKWcfS
	mOugWLr9dzcBtWGXQVgbBbFhfm0eEiGk=
X-Gm-Gg: AYBFou31r+7MHV/XfxDwOJhJVSYtkr1upacVbnq5TpBiNxdknlbqMZVwR0Y/jt5iicl
	m/bgCPRCvPivGs+CeM9H1cFQsDQO0/AhTihF5VJqzdMJqZR+yadG4rZs6wCUbvXA+NnQ5tY6iWu
	3TakrEJfMXyvz2i7mLK6VuTMdeYecblh1hl5Xc+sZh1aJbrwb6iFwAvOK2TYkjO/H8fR8gCdkU2
	jZtsp5YQrDk+cAyGJ64qy0u4xh7NXJTVy0M1iY9iPh5Igxs6vHPfVMABIyL7zbM0aMT2eVzRoOf
	SYh23dwV4nRL4FG63npw17WfJ04iuJ63Fp3s7AiqK4pQqxdsDC9IIvkAXn0e9NunPiRiDavCDHh
	XUFSJXNwVBulo+cwTVD/BW4o=
X-Received: by 2002:a17:907:d408:b0:c29:3821:ae6c with SMTP id
 a640c23a62f3a-c2ac2606943mr702009466b.37.1790405034922; Fri, 25 Sep 2026
 23:43:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260922122955.69433-1-fangxy@xiaopeng.com> <20260922122955.69433-3-fangxy@xiaopeng.com>
In-Reply-To: <20260922122955.69433-3-fangxy@xiaopeng.com>
From: Jason Wang <jasowangio@gmail.com>
Date: Sat, 26 Sep 2026 14:43:42 +0800
X-Gm-Features: AclHuK8xFsvc4j73hXtI-ilJ3XzgO5FqQXk1LCo83q1Fcp__nagIQq7skCOkqq4
Message-ID: <CAAf7B_NbjMu-9CEPwN2HD8+P=L4Nkk=tYO7Ga5-dHq=CVneBwg@mail.gmail.com>
Subject: Re: [PATCH 2/2] vringh: add regression test for cyclic indirect descriptor
To: Fang Xieyan <fangxy@xiaopeng.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Xie Yongji <xieyongji@bytedance.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	stable@vger.kernel.org, virtualization@lists.linux.dev, kvm@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 22, 2026 at 8:30=E2=80=AFPM Fang Xieyan <fangxy@xiaopeng.com> w=
rote:
>
> Add a case to tools/virtio/vringh_test.c that builds a top-level
> indirect descriptor whose NEXT points back at itself and checks that
> vringh_getdesc_user() rejects it with -ELOOP.
>
> Without the preceding fix, the walk re-enters the same top-level
> descriptor without making forward progress: count stays flat, so the
> traversal limit is never reached and -ELOOP is never returned. With the
> fix, the top-level count advances on each re-entry and
> vringh_getdesc_user() returns -ELOOP once the traversal limit is reached.
>
> Use index 1 rather than 0 for the self-cycle, since returning from an
> indirect table is only performed for a positive up_next value. A
> self-cycle at index 0 would instead terminate the walk and would not
> reproduce the bug.
>
> Assisted-by: Hawkeye:GLM-5.3-flash
> Assisted-by: Qoder:Qwen3.8-Max
> Signed-off-by: Fang Xieyan <fangxy@xiaopeng.com>
> ---
>  tools/virtio/vringh_test.c | 41 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 41 insertions(+)
>
> diff --git a/tools/virtio/vringh_test.c b/tools/virtio/vringh_test.c
> index 84961b9..2a5d7f7 100644
> --- a/tools/virtio/vringh_test.c
> +++ b/tools/virtio/vringh_test.c
> @@ -458,6 +458,8 @@ int main(int argc, char *argv[])
>         int err;
>         unsigned i;
>         void *ret;
> +       struct vring_desc *ind;
> +       char *data;
>         bool (*getrange)(struct vringh *vrh, u64 addr, struct vringh_rang=
e *r);
>         bool fast_vringh =3D false, parallel =3D false;
>
> @@ -755,6 +757,45 @@ int main(int argc, char *argv[])
>                 vringh_iov_cleanup(&riov);
>         }
>
> +       /*
> +        * Regression test: a top-level indirect descriptor whose NEXT
> +        * points back to itself must be rejected with -ELOOP instead of
> +        * looping forever. Use index 1 rather than 0 so that returning
> +        * from the indirect table re-enters the same top-level descripto=
r.
> +        */
> +       ind =3D __user_addr_max - USER_MEM/2;
> +       data =3D __user_addr_max - USER_MEM/4;
> +
> +       /* Fresh ring and host state; resets last_avail_idx to 0. */
> +       vring_init(&vrh.vring, RINGSIZE, __user_addr_min, ALIGN);
> +       vringh_init_user(&vrh, vdev.features, RINGSIZE, true,
> +                        vrh.vring.desc, vrh.vring.avail, vrh.vring.used)=
;
> +
> +       /* Single-entry indirect table pointing at valid data. */
> +       ind[0].addr =3D (unsigned long)data;
> +       ind[0].len =3D 1;
> +       ind[0].flags =3D 0;
> +
> +       /* Top-level desc[1]: INDIRECT, and NEXT loops back to itself. */
> +       vrh.vring.desc[1].addr =3D (unsigned long)ind;
> +       vrh.vring.desc[1].len =3D sizeof(*ind);
> +       vrh.vring.desc[1].flags =3D VRING_DESC_F_INDIRECT | VRING_DESC_F_=
NEXT;
> +       vrh.vring.desc[1].next =3D 1;
> +
> +       /* Publish head 1 on the avail ring. */
> +       vrh.vring.avail->ring[0] =3D 1;
> +       vrh.vring.avail->idx =3D 1;
> +
> +       vringh_iov_init(&riov, host_riov, ARRAY_SIZE(host_riov));
> +       vringh_iov_init(&wiov, host_wiov, ARRAY_SIZE(host_wiov));
> +
> +       err =3D vringh_getdesc_user(&vrh, &riov, &wiov, getrange, &head);
> +       if (err !=3D -ELOOP)
> +               errx(1, "self-referential indirect: %i not -ELOOP", err);
> +
> +       vringh_iov_cleanup(&riov);
> +       vringh_iov_cleanup(&wiov);
> +
>         /* Don't leak memory... */
>         vring_del_virtqueue(vq);
>         free(__user_addr_min);
> --
> 2.50.1
>

Acked-by: Jason Wang <jasowangio@gmail.com>

Thanks
