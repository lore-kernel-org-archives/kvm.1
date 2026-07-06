Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3CB2414A2B
	for <kvm@vger.kernel.org>; Mon,  6 Jul 2026 09:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783329882; cv=pass; b=hqE7eZnBLfiOycKSmQvyEsPDv30o1q02qcMpZHM5sTvxhxR7DpLrqJediJ8K1Bsb+j11qAiJzemCD2HCis3O0dQnxuQmjDlo9z2WEgwzqxa1ad4xwbuBlV4l7++wZeYNDIE4WfRkkd5PIWO8wxTT/UNh0TCLpWcsr9OSjAN1xcY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783329882; c=relaxed/simple;
	bh=bjF0BZXpIAjW/Uu1wH2j5e53ZR+HCAlpR+B3xXBi2vY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QbxDUTvo2u01yjgtJiuQ/B+XsbG1SEUhfaE4B4AJATPaZePCym9uV6WP+04Wh6CLyWnr9WluEcNYXxbmQCr42HmBzcuC+OX71CM8inIXgSjH7eK+WqP70YKoiPGCA3bNGbfSPvNzg6dkjEA93pXbh/u26RSUN49YLOW7xn9FEoI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Qu0sfzs3; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=JYT3ZlxP; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qu0sfzs3";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="JYT3ZlxP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783329870;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Yn0KzcK21NnwKHwgbzUJWvl8KnNJxuskf2Di9W9STHQ=;
	b=Qu0sfzs35LqlFGeInch5gaxB4uuOKILwNlKyHKosOPx1l0sRCaR6H+dN/JLKxcayuYyRLz
	vxIa3Rq6ka/m3bHSfMzSfew/tBN5Ob4YwyBM+CEEVxOIdLzWkKbiMG4RmG5ZtUe1nR7J4i
	dNd5IiOzI4vhZqCYV3CbLF6pwqE5pYQ=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-364-j_Uhbr95Odyq62zYgVaHDw-1; Mon, 06 Jul 2026 05:24:29 -0400
X-MC-Unique: j_Uhbr95Odyq62zYgVaHDw-1
X-Mimecast-MFC-AGG-ID: j_Uhbr95Odyq62zYgVaHDw_1783329868
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2ca5d2474c7so66499175ad.2
        for <kvm@vger.kernel.org>; Mon, 06 Jul 2026 02:24:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783329868; cv=none;
        d=google.com; s=arc-20260327;
        b=YsC2KPs6WzK2NiG/P6+6P39PEsXjLWjrTU9XKx3ZBUvszWmPoKw3g/CCMQEgj776Vh
         esaOqN3VL/SaB/yJU/UPD25fYXjiw1Y990m8queLpApNRNbUr6dgSGH9qLAYE6J7iAPe
         3icBwmBYpYpO+90dkuGKDyblRnw7ssuruwfg0IzA3pcMGDDizrNWoRpxpCaBnZnQxx4q
         3gAlZi1kjImAs1eUTKTFf2tkdz2oP3iOdxdMAp2QnTyvSXGhfB17aoRaaBczDziSaTZR
         CTkutvUNEgkPWjDPrOnT/+3VD+YZmOcgcgmmkVuZVaf072CNFmntMT3EcGCs8bxJaX4b
         bU4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Yn0KzcK21NnwKHwgbzUJWvl8KnNJxuskf2Di9W9STHQ=;
        fh=mviFPyJijdtv1mLpuTFiIo/Bqvea8N5c7tkWYTfbx6Y=;
        b=gKPkefNxR+KR+pyN0YocF4bwu8kUpDKLyoIPiXW5t8TZ/3aENiGYcjoqPOSRP1I7MS
         kP5RmYICMYa5SnNIMzBxdOPKE5nED/T+TsavV2g716RixxyKL0RhcNMjBUYoYXqtNQAK
         CnR3piy7z/5VvdhG+b80GMfcxNZqi9rctJNd2Ky/982ZUaZy7Ff5/XK1MNHc9AQrAjTz
         HZV2FQUPcSqndpk8E75h/Oofpds8ysU0NXt7zsTo8JIbIbods3/1skimUBC1Eh0Fh87w
         wXjiEkR66zGdaLyyNlXGbxuZJE2hP+o6lhGae8FXvlfk2aAwQFfcC6K4d9Fp/mKlKieT
         mFLg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1783329868; x=1783934668; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yn0KzcK21NnwKHwgbzUJWvl8KnNJxuskf2Di9W9STHQ=;
        b=JYT3ZlxPYv/7ppjF0mUZQXaCOFGeMH1Mv9PSZd+vQJw7oLXueMVLqUjnJW+0feVzNm
         pjWzq5pdK/6lTgju6h9lTopCCeGCrzTH1DUC80L2CQ7iT0HX87AhVGuLU3hOnRBFK0yT
         y1afpLHR/Uc4NYThpJ6OuPVRSfPFKRlLVxpIZUi+YYCmWSdcjcuGDU9OWTTdgtnX/lJy
         rtQJG9lWU2Y0h5itAx7WvbhE/YwVVP+zWiS76ASKISJfmXX2Ap7TuyM+ZYUdJEZFzC3G
         mfSZmPLo7PcupR+13wD9nK2+3OMld9UKSU65+mEnaA6Og5d6xLV7bsobPMaz/kqJbKvQ
         Wm7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783329868; x=1783934668;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Yn0KzcK21NnwKHwgbzUJWvl8KnNJxuskf2Di9W9STHQ=;
        b=NIV3T0tIK1o4/HlUj/7d9P8fvNh1j1/GVqIa/vjQwjfDb7tX3bGr42Ez8clzcKawiV
         gIBioQ2NrGCDlwp0Ou4JWvqkz74feWL96RweH3NjvFX8HqKEvEsLCYUZrYrxkdbI8kPt
         rQCyLMOe+qLf4xx3NwCBpaANzvjrBq7uW7ib7X6KLVP98mABQZW9rUhb17lcJ+kPTa28
         ZONKsM/rIw/EZ80dPB6bh3qLCiriQ0YQtjh7KYt8DPbg6U5KzU6XFTVwzAMqTcFiKU9Q
         fW8ZxsHO9wOi4M0OcwMf8XOu0PGrE3I6bj3Ufpc8MDRYFCKEriOODHDXEuDezOd/H2eO
         JGwg==
X-Forwarded-Encrypted: i=1; AHgh+RoGfM/tAQqLG+cvgoFd7DnEDgQ+JsB4rmXGBh5H//9wnZMyaMsnyDCVobZ4REex+uAotGQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZg+ZLMaeWpSnZpT/AcbR4bLCjrSceBkefVQ90tFkjz8Pf7EaQ
	v26j/5Ao7FVrdvzGfCyyOXhAHyar0wyk8rdv0lXWRJFkGTK6kwFob+KIBWJxYUhELHzTIBYHeco
	BmAo97JSlGuBE2b0yD3O1PF+j44B1gOv2wSdtnY5aC5FzfUApZVNTtiMhzJfrEZ0e8d59ND/MMl
	DC/qOo7YLjUE3VLXOAWjiSd8RZmDbm
X-Gm-Gg: AfdE7cklfj+XredMD457zFEIPro/e35C26kIARXEbq4NnBskp2DY0InR1nmsAL5uK9b
	qEGjNQRXKtIi8pGEOyQEV19/P4cTQmEwJLOZJbrNBopOX7gqDGxuXl9KGhj2tVarFWMzC1xt7hl
	8h4gRchEZjptJ477N2Ibwa6s1fH4GnotEqWImA1T5/TTCSc2knRQoWPWeq0gZ7GniR
X-Received: by 2002:a17:902:d4c8:b0:2c7:1200:bd7e with SMTP id d9443c01a7336-2cbb7511a14mr91874735ad.18.1783329866771;
        Mon, 06 Jul 2026 02:24:26 -0700 (PDT)
X-Received: by 2002:a17:902:d4c8:b0:2c7:1200:bd7e with SMTP id
 d9443c01a7336-2cbb7511a14mr91874005ad.18.1783329865282; Mon, 06 Jul 2026
 02:24:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6a3c3ed6.80e5668d.5d0ef.0001.GAE@google.com> <d1e9d389-affa-4d12-aaf7-3fcf3218966c@huawei.com>
In-Reply-To: <d1e9d389-affa-4d12-aaf7-3fcf3218966c@huawei.com>
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Mon, 6 Jul 2026 11:24:14 +0200
X-Gm-Features: AVVi8CdUM8gLEd1esj3vEBaF7KM2cPEVYji_lbVGfB2Yvj6K1tMDr3_xJ0gDydo
Message-ID: <CAGxU2F582RpWGOUxTU783zZuxWj7e4eZtiDcNdUmWobLSFSq2g@mail.gmail.com>
Subject: Re: [syzbot] Monthly virt report (Jun 2026)
To: mawupeng <mawupeng1@huawei.com>
Cc: syzbot+listbf7b8eeeb8dda31d6de1@syzkaller.appspotmail.com, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	virtualization@lists.linux.dev, mst@redhat.com, jasowang@redhat.com, 
	xuanzhuo@linux.alibaba.com, eperezma@redhat.com, stefanha@redhat.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, kvm@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2 Jul 2026 at 04:55, mawupeng <mawupeng1@huawei.com> wrote:
> On =E5=91=A8=E5=9B=9B 2026-6-25 04:32, syzbot wrote:
> > Hello virt maintainers/developers,
> >
> > This is a 31-day syzbot report for the virt subsystem.
> > All related reports/information can be found at:
> > https://syzkaller.appspot.com/upstream/s/virt
> >
> > During the period, 0 new issues were detected and 0 were fixed.
> > In total, 5 issues are still open and 61 have already been fixed.
> > There are also 2 low-priority issues.
> >
> > Some of the still happening issues:
> >
> > Ref Crashes Repro Title
> > <1> 24      No    WARNING: refcount bug in call_timer_fn (4)
> >                   https://syzkaller.appspot.com/bug?extid=3D07dcf509f4c=
013e25dc5
> > <2> 3       Yes   memory leak in __vsock_create (2)
> >                   https://syzkaller.appspot.com/bug?extid=3D1b2c9c4a0f8=
708082678
>
> Hi,
>
> This is regarding the still-open "memory leak in __vsock_create (2)"
> bug (#2 in the monthly virt report, extid 1b2c9c4a0f8708082678):
>   https://syzkaller.appspot.com/bug?extid=3D1b2c9c4a0f8708082678
>
> I spent some time analyzing the root cause and the previous fix
> attempt; below is a summary and a direction that tested out.

[...]

>
> I'm not subscribed to follow the list at full volume; happy to send a
> formal patch (with the af_vsock.h / pending_work changes folded in)
> if the direction looks right to the maintainers.

Yes, please, a formal patch with a great commit message is much better
than a long text to read IMO.

Thanks,
Stefano

