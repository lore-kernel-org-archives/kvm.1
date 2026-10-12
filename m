Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE7027E049
	for <kvm@vger.kernel.org>; Mon, 12 Oct 2026 05:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791782260; cv=pass; b=H6kDHjvnr07zIE2uM87cIT4M9g7KC++TyPW076/snO5+7XO6kQU4c0fVJviGrg13RMv3CrfssxtIFlKVZCfcS1CaHvtU7I2yR/rQC7OUyU3x2/UWuWW3CQcihusY7zrcH/aN6s27gWKbMuot3QiuIoMTH+pae7NiiIDUE85+4XE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791782260; c=relaxed/simple;
	bh=eR+fmL22lupP1pDQ/Am7C6byc7i0RQGsHO+PHaoUMS8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HQt6+HAz8ctdKSNpzS5BcU6k30eYsoLx87+3kGOA80HbKFxJ4OxJ833GogBV43ialqP3DbBASRgWdOyTon2pWxl3EfOzsG6PhFq5AuYZujUcTiol3+K6ayw342PWvKAI1a3kk/9jZHUBvF4ZDSx9RseWsj/bM+89KHZ1FJ1bRJg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lcAmHqGf; arc=pass smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lcAmHqGf"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-93a40a9a01aso837607685a.0
        for <kvm@vger.kernel.org>; Sun, 11 Oct 2026 22:17:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791782258; cv=none;
        d=google.com; s=arc-20260327;
        b=SxLcIqvlW2Tht5Lc36FvMGM8WN0uIpI6DC2khdAi1pUDpHbDhBtJK6Gf4K0phVDIvf
         xoM/Tl5kS1RCFvuOjSG349DP1KOsvABOuqdKVEow+oMJ7yobBC7yoGfFlQvfVTcyGJkU
         kwCW3ZgcaIqmPYClP45lnYvTvEdPXXrma+zBYWoX4FkLJDcCkeQN70P9x+qtN21zZH08
         12n64fJSOb9ZrUWzKInJzj2Oh1ir98zneFTdevZQhC0frT2vxLYB+f5PkquWSIPosHHW
         1N+1kA/LRUHUex4mY63T4Ghnhhe5tIY0G2CNx37UGJqlqH1HoOyqtMbIBn40nAFO8Obw
         A1Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fgfFsidpQQCyeZD6VQBMcPL9jH+HS8umBdgVKZVkXdA=;
        fh=OPodQtRfxswI/NbS8A8iGyzkz35O4tFmxXbvZDO5cfw=;
        b=sHiXde5p5SwLWWL+4zfhBTUEP4Vmlut4x2GUjXBOsOZIDywjULMt6/+e4vCj0jFjZa
         NFeqB/RwbXexa6Zz0XxuL3G9Dlp1V5T/7XM0cGhkvhLe1gr5W1jbuS+zSXYi5oI2mCmI
         pnYbRcvPaxGS/fywDv3aSzYvdUJAPMdkoNnT0V7ZGqnty4iUHLwx4ZoCFDrkjKpfAOHv
         cH7qzg6yzUivS+2tY0a1haInW2gHqWvH4xQs8CTLFbsQu2czD4c11hoD6a9qdaP9g/vm
         mwv1lmssa0RWF3DuK/lWBsIfaqZihdDQ9yeOFGphxU/yrN6FuVBPgu8M1Efq2/GaLjA7
         b9Ww==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791782258; x=1792387058; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fgfFsidpQQCyeZD6VQBMcPL9jH+HS8umBdgVKZVkXdA=;
        b=lcAmHqGfTtb5Jssv3FS60q+gS6WbL9qbpJutqX+Fxn0rTukoQXEOxMXicndEY6HKLj
         DIm/dZRABZla73El/wqEp7KTHEVdF9mOG5Z3egFePj0oQlzt5PRTk0uYMu3sVCuWlp69
         a+pGSbFyjgoFWKesJchc+aR0o/nOGyHzqYQe+GZTUfaPaDQzyJXpB8yQMY7+Ay0Uurcd
         2ujNch1ShU52ntYElMTz0cbPNqtKOA2cCME9EnDep+S+0do2zrJrH9BP3EQthVRxgqZ4
         LtPpvHT6NKne98RNonu6C197aOd0IHJi/Q/viZzmqvNOScn5HGuoMlV1H7GfLEzYXZb0
         n+TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791782258; x=1792387058;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fgfFsidpQQCyeZD6VQBMcPL9jH+HS8umBdgVKZVkXdA=;
        b=Fwzkwsp5f1lXmgpGvfF3x4izGy/JZ2XsWsoWV1J1X/mWrOD2YAza6sO8QrK3SJ6wwj
         fKVf4hCVOjXfY/M/NhuMRwryHYEpYgvKLkHhaW8U0XvMLcCpQ73ZPKsmAmadZgANePzf
         cvWoirC7xJa3q3eRdinndcYLgL7hl69Yyywil8DBDewfYgmwQL/WPKSFfg+LYUxB1iTi
         wRQLVDwCzh6565ruMC/1cXynhI5uSnZ+Emiz7KjTPcblTnJqJiEPZ1QWoOw3DyAdbJWG
         BXUCfjpnaMncVgVzTA5BA1uBbW248wGZwfNiZO4/mu+z43tjkFyor0PqY0S9Oy4GM3s3
         UPSA==
X-Forwarded-Encrypted: i=1; AKwUvBwdrD8yEiV2Z45AKIW7imsZUyOwoqNIqxI90pOPc+3K/bVTbVxySCeWXbo7TQqxluVRON0=@vger.kernel.org
X-Gm-Message-State: AFq9FYI7h7c53tAWUpYUJlu+N8GMa6ckTX8FDh6v2iK0iDKHEprpL8r+
	6B94+1TGQfN3gd61LY2R51WbPcL+1RTmKtrsRkPNhZbE/lPtNuzPfgnyw6m6V0rRCMyomBkMYpw
	WisvOvQgHHfqo0gXqcUi7SDc1qmTVLwxP6iz9
X-Gm-Gg: AYBFou2G9+74vV75PS6HDjvExl4MHAXS4c83eBVvZrwyJsL6v6ia8+yJSYwT6ox7RYd
	6Uk0Q7O6cRsfVwbqhFZFd/UAQmiMKiET+UDG/vofLQgs4bjKka3eRtdfbJIG/2QOv3bO+veAjif
	+HGSW9/s1/dfj4RqkybZgyTqdqs72HkcE0d+rgygVf6zsxTOpY0h0MPbCEwI2tg2T89QIFYumBj
	pEco689bc9g2Iit5AX/R03WMtMZDazwpMrqorDu0t5xw6W8ztMS6NAOfNi99O0t7P3GA9cA6see
	bpenC5DvCi80C4l3nVa/Hu+Vvkf22m9GFy78pBpQkQGvvD4pjKNyz1rcqMR1DeqMrk4=
X-Received: by 2002:a05:620a:468d:b0:93e:c173:f694 with SMTP id
 af79cd13be357-93ec173f895mr1213489685a.40.1791782257577; Sun, 11 Oct 2026
 22:17:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261011014803.100454-1-physicalmtea@gmail.com> <sashiko-outbox-167544@kernel.org>
In-Reply-To: <sashiko-outbox-167544@kernel.org>
From: Jia Jia <physicalmtea@gmail.com>
Date: Mon, 12 Oct 2026 13:17:00 +0800
X-Gm-Features: AclHuK-lnMJpW1Hk4QztCSGXZUH1H-mtHMg6D6LOi_sK5vUMHTywqi2KmYQFORE
Message-ID: <CAJwVaMK8MOfKjhWHH_MA3WqxxraQkQyeeN1RqUoANxZSnDJ2Dg@mail.gmail.com>
Subject: Re: [PATCH v2] vhost-scsi: do not count PI bytes in the data length
To: sashiko-reviews@lists.linux.dev
Cc: Eugenio Perez <eperezma@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Critical] vhost-scsi: missing validation of prot_bytes alignment allow=
s OOB access
> --
>
> commit a2683cd412935b122ac2e93ce16af9655a892639
> Author: Jia Jia <physicalmtea@gmail.com>
>
> vhost-scsi: do not count PI bytes in the data length
>
> This commit updates the expected data length passed to the target core
> by omitting the protection information (PI) bytes. It adjusts the length
> so that protected read and write operations take their length directly
> from the CDB, preventing issues when the data scatterlist is smaller
> than the total length.
>
> > diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
> > index 885fac5ed042e..8b32caa7ec294 100644
> > --- a/drivers/vhost/scsi.c
> > +++ b/drivers/vhost/scsi.c
> > @@ -1534,9 +1534,13 @@ vhost_scsi_handle_vq(struct vhost_scsi *vs, stru=
ct vhost_virtqueue *vq)
> >                * vhost_scsi_queue_data_in() and vhost_scsi_queue_status=
()
> >                */
> >               cmd->tvc_vq_desc =3D vc.head;
> > +             /*
> > +              * exp_data_len is the data sgl. prot_bytes already sit i=
n
> > +              * the protection sgl. Protected READ and WRITE replace
> > +              * data_length from the CDB in sbc_check_prot().
> > +              */
> >               vhost_scsi_target_queue_cmd(nexus, cmd, cdb, lun, task_at=
tr,
> > -                                         data_direction,
> > -                                         exp_data_len + prot_bytes);
> > +                                         data_direction, exp_data_len)=
;
>
> [Severity: Critical]
> Does this code allow an out-of-bounds access when prot_bytes is not align=
ed?
>
> In vhost_scsi_handle_vq(), prot_bytes is extracted from the virtqueue ele=
ment:
>
>     prot_bytes =3D vhost32_to_cpu(vq, v_req_pi.pi_bytesin);
>
> There doesn't appear to be validation ensuring it is a multiple of the 8-=
byte
> T10 PI tuple size before it dictates the length of the protection scatter=
list.
>
> When the target core later processes this command, functions like
> sbc_dif_generate() in drivers/target/target_core_sbc.c loop over the
> scatterlist length using 8-byte increments:
>
>     for (j =3D 0; j < psg->length; j +=3D sizeof(*sdt)) {
>
> If psg->length is not a multiple of 8, does the last iteration read or wr=
ite
> past the end of the mapped scatterlist element? A malicious guest could p=
rovide
> an unaligned pi_bytesin or pi_bytesout length, potentially causing an
> out-of-bounds access into an adjacent physical page on the host.
>

This issue is not introduced by the current patch. I have previously
sent related patches to fix similar issues. I personally believe that
this kind of issue should not be fixed in the transport layer.

https://lore.kernel.org/all/20261006093338.27342-5-physicalmtea@gmail.com/
https://lore.kernel.org/all/20261006093338.27342-6-physicalmtea@gmail.com/
https://lore.kernel.org/all/20261006093338.27342-7-physicalmtea@gmail.com/

> >               ret =3D 0;
> >  err:
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261011014803.10=
0454-1-physicalmtea@gmail.com?part=3D1
