Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C13872857FA
	for <kvm@vger.kernel.org>; Sun,  6 Sep 2026 01:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788659225; cv=pass; b=sKmK/KjzY/FV3jnOr0GhaOamJ74ZuqqaTR+Q9g54dPrqEaCBzNEEz199ExcFgfpqLe0KLk9YbDoHTm1SvVoWcCakTtM4HUikFq7WG9punnTZ2r2CVdRrDb9zqx/S5C3//buwsmUryEydYhekHwL8jb48sLEC6+qL0EMO1CZ7sNQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788659225; c=relaxed/simple;
	bh=8p128yWcOOgvfc5rvLcd5R3DTRB7J1JcVPGCpi4fpqA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e45ZjdnibCEphPfEUGpoDX2KAcCL4IhwYLf3+urr1zELkzkwig93gCQQ3Q+fwUJChERlSrLCrrZE9mEaJBo2WykK4VokVmnis/InwaXksPpKHgRQP9u5adpeZW8vpFO7J+KGiZoklEhXB4k0UbT38s9+IceLQ3v5Pw+E5/mgFEg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Myqhruen; arc=pass smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Myqhruen"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-90cd8e45460so36876476d6.1
        for <kvm@vger.kernel.org>; Sat, 05 Sep 2026 18:47:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788659222; cv=none;
        d=google.com; s=arc-20260327;
        b=ptw0+PKkZI8D38Ym23q3q2yl/JIn9TLsU/NveOl0GbR3zK7N91eJxI5uMO9de5difA
         cZL2pWRD+2lEITXTa5bSo9b7uq2vPmvOhkgz//RKdFmZjJgRDZyju7sof+mb7Zmtc5gC
         6s8CUwL+2mRBX6EFW+EMAKfoQ+7IuLl2kD9lHnJnFoJIGxa53sL9xv/nhEy3WgkKzdXG
         LW6q740lELFbtycL2unDsfXNGASv7HVef1Avk87jnOILu9kzGrDZxNBdOYZT/jNPNOx6
         RJ8X4mnXCU2+wlTotUPw1YnEi1hfF8e7GmvkM5YWRe+xcwRAt57SuoDuBUBWiqwDR8z+
         bx3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QxmMh7HdE3ykc1Lqfns8Sc2JU4iSRDsi8vOQrQ4w9vE=;
        fh=fItrUtV5UsY1KSNx1ZNnzv3miYMbODbRRQWQ18AP5Zc=;
        b=HKgpK70LRuy66iAtrar3DiBd+L268wp37d4G63XqA9b6Qu4+GoqApEE6sLP1cMsznH
         nW5X0uY+S3mUPRrAN4Nmqbm5ebntdlA65NKkjCEwYQYiG7bPlxg5atZ3Nsy0UsKYDg2D
         yLPo7Lxd8Ue8743Uc3HmI0LYHXngfUt4X+qbTPZ9EHAWA54eHKFctmwEkQYCgorXjmMp
         Lfdi1DRJ+/A0vK5l09Zx3WpHFLCajba60K3LVtp+lcfRIkwBsdV/v9T0FDowxEtiEtPt
         xRxM37itn6GbS9IbnZ6ySVZJXqOMw7D54CSY2vOYjBjbahrL7W66mVzPB1Hquecy4yhH
         4fVA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788659222; x=1789264022; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QxmMh7HdE3ykc1Lqfns8Sc2JU4iSRDsi8vOQrQ4w9vE=;
        b=Myqhruen958Ll4YECq1LfWYwkjd08BbF2DuaOWS9Fei08M07ky0Jmup2EVYOcTn/G5
         Zf0pjyOVrC5pkOTGWc0C/eoGxmzUDO0VXFskZEUY6AnznM9WShWX6lRiIarWywvA4qEh
         4nkpBszy0Uj3ij5oCTGiNM33OslyCoyCjS0z9e4hmPt7OeyHLO2BZk/AQZo1c/uB8KfQ
         9l+u9wR7NRfjoYlCzlJ++ElWaOxG/1shE5EdDCRItt++IjC6Yt80GiLBic98dCGS6WF3
         iEj2M9gcVGvut5l6W2FPLOOSRe1pIvcXLxqpV2Ig9Ut5doPfIBzwyBZ9HLiNxr/J3/sM
         XvsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788659222; x=1789264022;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QxmMh7HdE3ykc1Lqfns8Sc2JU4iSRDsi8vOQrQ4w9vE=;
        b=MggRa2d1yKWcBIXFOhfAJ3XU9a3xunzyIGVbaeKizpLFVL29aaDN51zirambucLIsJ
         rizra2xmjW8gZysogNc9NlOO+hDUJss89R/RVyVWOpZQyxUgAybiA2YpnBZ7AHfkpxgu
         Vj6JABeY8UAp1k/syHF5nMGBxbD9+mxd61XxfJVmL9gKFAZ8Vz3akHJlX9WpwunDYZTP
         FzTx/5GUdeQq2gkWGjz9OwaS8JUg9jVpgcTq5Rn5F9iiWnXZ7EQI+NpkOd9ys1uffACc
         YLSQpX2Y2Kb+pI+4siZpIj66PnP41t2ANgbzkVzWJ+MjVB9CJkI6C25SwB9ewMo/CX9L
         haIg==
X-Gm-Message-State: AFuF++klEwLrIMoa5jQTSW5vpdU7sRlMRBy6EbWjHzZu6r4pa3L17d7C
	E4TQ5exk58JK9nYDQhBF8CDx59vpikeEJcwIQIGflvQl0blyX52bRqoU1L5Bl6/oif3+f5Kuuw6
	ShICTQzwCYuOA0av6J3x/emE/Dfmoz5Ei9ilu
X-Gm-Gg: AYBFou2AgVTBOMnudMDbISJe1yd2r2tb6km9JMBNYbH9WEmTZvB+f/V4h8xAoLqPBa0
	MDHarhm/aX9/FZqGB/EEXJilXMse2QTpwEXmNU392bAqD9rV51JUm0lDhlNjV1HjP2LRD+pjl2q
	/B14XSc1UxbeBOMi32UYg0PDlReKWOgK5HU+p22KoMIhIoweTBU1ED7PS3Vp4yALk7WT0h0EtP7
	Whp5Mn6u7OH8TRcdSXQCp0lKEvu5hEUgjL/wiPz+GWLbLud9YmQQN6PnDqqCOpL1bkljqsPpk3b
	Gf3YhhlrqVWcY8YcfVX2N/pAmUNZvZ0xfO8lDqN6RZLVJjq3CAM8RZ2Z
X-Received: by 2002:a05:620a:25d4:b0:939:6df9:1996 with SMTP id
 af79cd13be357-9398077453bmr1491078385a.50.1788659222531; Sat, 05 Sep 2026
 18:47:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260904005240.502787-1-physicalmtea@gmail.com> <20260905005352.1E5B01F00A3D@smtp.kernel.org>
In-Reply-To: <20260905005352.1E5B01F00A3D@smtp.kernel.org>
From: Jia Jia <physicalmtea@gmail.com>
Date: Sun, 6 Sep 2026 09:46:26 +0800
X-Gm-Features: AcwNN1Uz8wr-epjfsaLBUzBnMwbbmAIBLIa_l8bHM3MEHqc2afAijKPJ2Jb8XE4
Message-ID: <CAJwVaMJsTVYPKhB4-a++=hapn7teFRuf3o-0aHkp-BjvwU8Jrg@mail.gmail.com>
Subject: Re: [PATCH] vhost-scsi: fix event queue iov out-of-bounds
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
>
> Pre-existing issues:
> - [High] Self-deadlock (AA deadlock) in vhost_scsi_send_evt when vhost_vq=
_work_queue fails.
> --
>
> commit c17fff972ec26b541af9ec7b514db052328d64e6
> Author: Jia Jia <physicalmtea@gmail.com>
>
> vhost-scsi: fix event queue iov out-of-bounds
>
> This commit fixes an array-index-out-of-bounds issue in vhost_scsi_do_evt=
_work()
> by ensuring there is at least one input descriptor before indexing the io=
v array.
> It treats pure-output chains as missed events to prevent reading past the=
 end
> of the array.
>
> > diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
> > index 7a1f39a327da6..5a0863d560a07 100644
> > --- a/drivers/vhost/scsi.c
> > +++ b/drivers/vhost/scsi.c
> > @@ -608,9 +608,10 @@ vhost_scsi_do_evt_work(struct vhost_scsi *vs, stru=
ct vhost_scsi_evt *evt)
> >               return;
> >       }
> >
> > -     if ((vq->iov[out].iov_len !=3D sizeof(struct virtio_scsi_event)))=
 {
> > +     if (!in ||
> > +         vq->iov[out].iov_len !=3D sizeof(struct virtio_scsi_event)) {
>
> [Severity: High]
> This is a pre-existing issue, but while reviewing this event handling cod=
e, I
> noticed a potential self-deadlock scenario.
>
> If vhost_scsi_send_evt() is called from a path that already holds vq->mut=
ex,
> like vhost_scsi_evt_handle_kick():
>
> vhost_scsi_evt_handle_kick()
>     mutex_lock(&vq->mutex);
>     ...
>     if (vs->vs_events_missed)
>         vhost_scsi_send_evt(...)
>
> And vhost_scsi_send_evt() falls back to vhost_scsi_complete_events() beca=
use
> vhost_vq_work_queue() returns false (for instance, if vq->worker is NULL)=
:
>
> vhost_scsi_send_evt()
>     if (!vhost_vq_work_queue(vq, &vs->vs_event_work))
>         vhost_scsi_complete_events(vs, true);
>
> vhost_scsi_complete_events() then attempts to take the exact same mutex:
>
> vhost_scsi_complete_events()
>     mutex_lock(&vq->mutex);
>
> Could this sequence cause a self-deadlock where the kernel thread hangs
> indefinitely waiting on the non-recursive vq->mutex, potentially leading =
to a
> denial of service?
>
> >               vq_err(vq, "Expecting virtio_scsi_event, got %zu bytes\n"=
,
> > -                             vq->iov[out].iov_len);
> > +                    in ? vq->iov[out].iov_len : 0);
> >               vs->vs_events_missed =3D true;
> >               return;
> >       }
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904005240.50=
2787-1-physicalmtea@gmail.com?part=3D1

This is a false positive. The current patch does not introduce this
issue, but I will try to reproduce it to verify whether it is a real
issue.
