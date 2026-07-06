Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB804229C4
	for <kvm@vger.kernel.org>; Mon,  6 Jul 2026 11:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783338914; cv=pass; b=Jqg4Z1BLKVvhWgS+A0viRfv4gkAWB3KPjm6i6/fd38MDAnXgFNpTG2CsiKAVTKHwcrIUcm64uSBhfhHmu6YMQBvTD+AjZHsEehthM3f0ivf3PMJgkrufVZNgNYhxlBIupS7MNYvjEN/VnKlGzeiQb4speE1KtaUvHt9NdCzs0B4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783338914; c=relaxed/simple;
	bh=oELiRmArb5ClQEoFheQBb03GBeALw9I3nDP+vOH+JTI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QLOBTLx4Vjpq2fKKk/B1pnAlzzwqgTrcopKGmpczOz1IDurwcuXNeOn3QWAPh8ShgMrgspM4tAGsG4eV5ah9qlNj63WqEXkZL3LMVW3QRKpso9kjg9xOVkFs6lpbeIuinlUhEKHXr/vd2QThd3ONPrvkK79R+60Kfu+ZWlKQi6s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GCAHVPGC; arc=pass smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GCAHVPGC"
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-44868d6a066so881497fac.3
        for <kvm@vger.kernel.org>; Mon, 06 Jul 2026 04:55:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783338911; cv=none;
        d=google.com; s=arc-20260327;
        b=OUpYTWKEWc0w4vhZc0CDlA9secNDyoBVwmQtDRtteL21QtOPu0sJy4lYYhCbExGt3J
         si+5ko3pQL4cGv6yAIT+28DOsQhciXDG0jd+BvAUBno7XUF7pTLAHZvtsX8vw1GsnST9
         QvYxhviIBwUGd0AmjFxwfqKgfEcrmCsfbnhCV5I+Ew7hOrYVzY6CB1pNn9sarDYk/mAP
         JfdocpNUaTict2dUS4CZqpRweYHa519O0efWMp5Y35kK4IOd1raARb75NvjYD3sHnkXD
         Jj8xXwWDI61GJvhQl6Ar77ZiCcNNt7OniSNHkpzcnNEWsswfiIPLk75O/GTQkbYK48uA
         H4XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7IUJO7hHDOl/XD/w+GraDDTln5F69OzxpzwVyfa1liE=;
        fh=HpHjicq1W0MynENNZSPT+N81sQER38MGlQxLX92JNoU=;
        b=KPs/aqAmkhDVIIM7LuGdmPlAncZnoNBIwONKOKyfboE3PGxlScQcKv5SDFFxdzV02n
         tqxJf+w8Zk9FWhKN18uiyCPeQFAFgJ/OsDYmNlmJSmI2Fi3y1CCEIVsq+oNkxeld0Y54
         26vuchWGNEAGCd7Awh9hnCL5ugHl1Sw97IjQPI2kyJOfpWlKieLM1PTJyrSTb+wW2d4F
         XQCmRTYS/wU2PTQq7xoajM9nF0+rLAiFt17Y0ukM41kweaCKVZDJCRIBUi3nWRkGz3td
         zbAb+ELj2KuBZZ281x7QqF5dc9wly5DmSMQBXlYUbuUy8XtByjW3qhG7+IAuWV4vqtxZ
         bFCA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783338911; x=1783943711; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7IUJO7hHDOl/XD/w+GraDDTln5F69OzxpzwVyfa1liE=;
        b=GCAHVPGC/J2QBLFvoEQQ8w2XGA9ryMaslj9JRMTQQPgzqmLZjKwDv3uRJobdvnjtEo
         kdFCXznyOSb7t5nyRDIq0DIam5BdSZFMph3lThae30hNMJ0tSziYZ/jZD+cDkkpXa+iG
         9inbYf+XGttiH2YlgQBqLC/mtv2cA69MNtm6G8uHR1mZbB2MSxy4fzgneiJrYZK1Xop5
         fhEe39p3iwZshntVcn2WUW619NXpXr8QuaGnPZ2hrd5fVJskaKf5CK1OQ+RuemJMI498
         Zpd5tu4WnwbHgcHpVYmDbVccjBnXMMco8NstB+WFWz40xzqKdFEbQ/zJqelEQEnXUeiC
         5y/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783338911; x=1783943711;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7IUJO7hHDOl/XD/w+GraDDTln5F69OzxpzwVyfa1liE=;
        b=Zr0yqY9+Q0XKYzbYAjabkxqwboT5SF+l6C3XA2kvJppX0qkKDNmuS4rm7Ogy0teLPz
         G3Ib4RkqlsefX4xfCq+ePnQZWB7LMve68Mu/jz81x/iFgo66qyM6EMb6GnJ6e5oecI2Q
         ZhhlxeS9vRAyLFR6r0qVaQGVv0vGAhkXMLzknf599O8QrF2mqT9q0niV5OHU022i92zE
         mFHq11JyN+Aoiwzu1woL6b3p8B0s15Vy0LqTcxn0wN6brAm6Xv04HF3V9Rc5PbUpfRac
         UqYK4bA4J2JMWwbcndoZ91NlrqSXal25w5LUgmq33XA3C36M98ZE+W7Z3DK6FzdRxBRr
         5ivA==
X-Forwarded-Encrypted: i=1; AHgh+RoBNiM1dUzFppnIzNX+aRIabPvgyiE8cn0fWmpb3MhQEdV7jiQkLD50CuZ2lyxBL+XkpgA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsPqrTJufVcr+QAWECuRCA2mfFv0jTZHRLLfNvQmiuq/aE+KBQ
	Njsd2dzjDQc04GwkJhG3VxrcLKB2P4TkevsZ5rmx/bjRxWfKibrVOr9LBGB1yLGHQLurX31X0d/
	k9k3QQFLx/kiaCmIGk0tZnG28OEbWHag2iYefTpni
X-Gm-Gg: AfdE7cnT4qSLxb7m1jdRKEVKiOThilx+cMnETIpHi4rHjrha6wIs3DL58erHjAfuL1Y
	ntu1iRmp+40jZgH62dF1KQpUTnyHYlRXpZu3ICqTTZMXoURoVLAUBn58HGzIHFt0q3Me6P/5eSv
	erCedejoCK9CJ3fIUwTUIG4RVHgtZuEMg9ujYuGqGu0Xm3KO2W61ksm7E4CukIY9H2npvowDcI6
	Bxqy+m9MNTmijhdZ/InW5nQ5R4pT8lgnsJ36+j+hMsJOV6PEKtQFFmQg/RZWHKmN4U3v4EwZxls
	2FgnSlwZc5lnUohbskgk/ffUNS7ylx9YpFb+zly3Wl4sjDMrL9Fby+qKP033keWg2LhWAf1akAN
	h1xerXpBERELY79rFfaxbSZx6M3T/REqQdEOoC0W9sMzhzG5pKA==
X-Received: by 2002:a05:6871:2016:b0:448:84c0:fcf5 with SMTP id
 586e51a60fabf-45106080959mr17902fac.20.1783338911104; Mon, 06 Jul 2026
 04:55:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6a3c3ed6.80e5668d.5d0ef.0001.GAE@google.com> <d1e9d389-affa-4d12-aaf7-3fcf3218966c@huawei.com>
 <CAGxU2F582RpWGOUxTU783zZuxWj7e4eZtiDcNdUmWobLSFSq2g@mail.gmail.com> <0e51efaa-24b7-4a19-97f4-0669fd92d513@huawei.com>
In-Reply-To: <0e51efaa-24b7-4a19-97f4-0669fd92d513@huawei.com>
From: Aleksandr Nogikh <nogikh@google.com>
Date: Mon, 6 Jul 2026 13:54:59 +0200
X-Gm-Features: AVVi8CeBOFPrQ1zTHfcvlgKLuME2AIe_WExrBUVuPzho7a99Z1Y55-T5aiUpW6s
Message-ID: <CANp29Y6QgCh5wc=O_B-qj-t=7f-r5XYWMnbmBNY2E7mSLTn62w@mail.gmail.com>
Subject: Re: [syzbot] Monthly virt report (Jun 2026)
To: mawupeng <mawupeng1@huawei.com>
Cc: sgarzare@redhat.com, 
	syzbot+listbf7b8eeeb8dda31d6de1@syzkaller.appspotmail.com, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	virtualization@lists.linux.dev, mst@redhat.com, jasowang@redhat.com, 
	xuanzhuo@linux.alibaba.com, eperezma@redhat.com, stefanha@redhat.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, kvm@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 6, 2026 at 1:32=E2=80=AFPM 'mawupeng' via syzkaller-bugs
<syzkaller-bugs@googlegroups.com> wrote:
>
>
>
> On =E5=91=A8=E4=B8=80 2026-7-6 17:24, Stefano Garzarella wrote:
> > On Thu, 2 Jul 2026 at 04:55, mawupeng <mawupeng1@huawei.com> wrote:
> >> On =E5=91=A8=E5=9B=9B 2026-6-25 04:32, syzbot wrote:
> >>> Hello virt maintainers/developers,
> >>>
> >>> This is a 31-day syzbot report for the virt subsystem.
> >>> All related reports/information can be found at:
> >>> https://syzkaller.appspot.com/upstream/s/virt
> >>>
> >>> During the period, 0 new issues were detected and 0 were fixed.
> >>> In total, 5 issues are still open and 61 have already been fixed.
> >>> There are also 2 low-priority issues.
> >>>
> >>> Some of the still happening issues:
> >>>
> >>> Ref Crashes Repro Title
> >>> <1> 24      No    WARNING: refcount bug in call_timer_fn (4)
> >>>                   https://syzkaller.appspot.com/bug?extid=3D07dcf509f=
4c013e25dc5
> >>> <2> 3       Yes   memory leak in __vsock_create (2)
> >>>                   https://syzkaller.appspot.com/bug?extid=3D1b2c9c4a0=
f8708082678
> >>
> >> Hi,
> >>
> >> This is regarding the still-open "memory leak in __vsock_create (2)"
> >> bug (#2 in the monthly virt report, extid 1b2c9c4a0f8708082678):
> >>   https://syzkaller.appspot.com/bug?extid=3D1b2c9c4a0f8708082678
> >>
> >> I spent some time analyzing the root cause and the previous fix
> >> attempt; below is a summary and a direction that tested out.
> >
> > [...]
> >
> >>
> >> I'm not subscribed to follow the list at full volume; happy to send a
> >> formal patch (with the af_vsock.h / pending_work changes folded in)
> >> if the direction looks right to the maintainers.
> >
> > Yes, please, a formal patch with a great commit message is much better
> > than a long text to read IMO.
>
> Thanks for replying.
>
> As we conducted more thorough testing and further analysis of our own fix=
,
> we found that it is not as comprehensive as the existing AI-generated fix
> provided[1].
>
> Could you please let us know if there are any issues with this AI-generat=
ed fix?
>
> [1]: https://syzkaller.appspot.com/ai_job?id=3Dcd978d21-2110-4f57-9525-d7=
d91c4a7e02

I'll chime in from the syzbot side.
If anything is missing, please let us know :)

Otherwise, please note that the bot can incorporate code review notes
and, once the patch is ready, submit it to the LKML:
https://github.com/google/syzkaller/blob/master/docs/syzbot_ai_patches.md

Best Regards,
Aleksandr

>
> >
> > Thanks,
> > Stefano
> >
> >
>
