Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 791413E51EF
	for <kvm@vger.kernel.org>; Wed, 15 Jul 2026 10:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784110578; cv=pass; b=tjaZM5hhpqTDl+Cc43RQf82Ei9ZyFd3GStIpKJwsvlQ/7pB5aGff4tgswoRGSty0Y8gJSySM2VDzJBTi9qSwdoJsqzB8A2LxSQuFKlHLhE4QqeahHcxt2AnLrR7Jaor3MHv6ZnIWZHuRlE8FA6UlA7FiUYbVVJIAXSOxLya/CM0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784110578; c=relaxed/simple;
	bh=TeXan7JGFfsg6yrmywwHvvL9MdAl1Bc9W8Rbhlw4hmU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S/lFEbAim3Kp0jysB2s8e0E+pkCRJREd16hmM/FQqVfoYAK/PTrg1xw5Ii+xrqC+hXGu1/bcaNrmKZRhGtI8oWIqtjOvqaeEWHfxVsjSXAqvNgmeTtCBlTqVIpPrVOsklghTpar/5kp9dVU85joRTkAfOR3hglm5UKPceHH3bAs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fpIpP8fZ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=chi+lize; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fpIpP8fZ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="chi+lize"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784110576;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5Vl9QN7NrDMgbM574d5FZjPwxnbkejsp2FCaMY17Kxg=;
	b=fpIpP8fZdfWzMF7oUui4FOieyjKDAqAITmYqrs8EW92zdLyPvd9bKz9vEby4wqPUPfDZhx
	wuF9+Ej0av+ATIOrd84Ix85Q+sCV3r4Q+3+NA3b+YeN1l9pT9EODLYqy8BwJJOoqZhqS7A
	59OFtbancJ9817btSpws9SfeSpi79tE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-85-iYPJQfTNMq-SgDmV8I8MMA-1; Wed, 15 Jul 2026 06:16:15 -0400
X-MC-Unique: iYPJQfTNMq-SgDmV8I8MMA-1
X-Mimecast-MFC-AGG-ID: iYPJQfTNMq-SgDmV8I8MMA_1784110574
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-47e9f03e80bso2048869f8f.3
        for <kvm@vger.kernel.org>; Wed, 15 Jul 2026 03:16:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784110574; cv=none;
        d=google.com; s=arc-20260327;
        b=KFCWIe2PD8khEeJsn0UHf71pFM+IxdxHdqhRcSU/P4Z2Qswkch1KYHMa/7s2bfDUNg
         cutBLS3gsnS3KOrjKewrUmlSGp1ggSJK13JoPBexQj7tUaembFF/BQD975STeOmXBwM9
         jEbyN/DG3BnNBoTxJEqW4wFKkFBbIoO593H0DOmTHLGAO5xcME/WgGc3YF7Sf7/0lQvr
         RYbK5vbpTp3JeOBObeARCNnuJ768Laqjd3yyJLPh4XIzaK5G4luk52Bbuo/I6ZwExRxm
         7kUFx0O2/lcBbqwkvKD7qjrdtx87sleCGJP/QwKqKf4ghrjSw7/c28c6vdSl/y8BCdE6
         Px2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5Vl9QN7NrDMgbM574d5FZjPwxnbkejsp2FCaMY17Kxg=;
        fh=6mN4cZZ09xaNaFZ6MoaNFvNj8shmcdFGAfxbTn5x2/A=;
        b=RB9T57ou1zd1CHblImctY73l4EGj2XhuQTTHQxBkHoWVutWb1txU5X0nIbNQuHkDw9
         LepKA2vHNlITPI7upWmwsTOUhRj9GLuKp8IOHZykdZhzDkM0CKo4TRSQIPWSeTuC24NJ
         hnmZeyZQfxNqCgcB4bd32V1ixMeNzkAtfeJRXqD5E10gidRwij9pAu9VR9FoDxswbbWa
         4UGKu+yOAsxAkb8e22mJjXm21OAVl/WNrHFBRKsG+w88aKyvz0DN+EpuPGiXWUyXPd+j
         QdGIQJLHNnjefm3BBMZjCXZaOqeBSMUqlxCFgUthCdynIjcI5BZB3XsOCdkzlDr/4xLn
         xtOA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1784110574; x=1784715374; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5Vl9QN7NrDMgbM574d5FZjPwxnbkejsp2FCaMY17Kxg=;
        b=chi+lizepEe7PIAyGY8WQ7fmPu7STRFl+x5IkLsFEb9GvEYz4pJ30Y1uT5lH6kN1ei
         nHEfuQ/fFafpC6L7YrJySEqrFrp0pkZrx2lYMlHLzoLM9rG12VCtB5KKliwKmmJPGJ9F
         hKvBYYpTjC0qkuI4xSvP82legWmHU8LhaJtlo1w6yCH9jZfHxXtMMy8EReeBHlPTjtFO
         qGNYQ2phPqAcYhg6erF50ij57nUm9etZ9tHmRymAt8Oevy/OnqS5raDu63LQuo/FVHf2
         kSDjRnhJ4oRZyyEDncQpL9J2XzD2WEzwxh638RNEoy75hBwj3shGIz4tW4miGXjSgux6
         666w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784110574; x=1784715374;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5Vl9QN7NrDMgbM574d5FZjPwxnbkejsp2FCaMY17Kxg=;
        b=I3XvN37vhXq32VqYbVsz16RNM+tfpmK/Xghc5nWZriQZ7ASxlhBHgOS567m+F+6y/D
         36s5JVS6g/AFdoDYombd98X4RLbkb9gychmCa1OB1PhSAoOtqiohW6NoiqKQC32r0mWK
         70JfM1HZGOQz3cMg9rPJQ+r3MBxv19tbO9fPr2xaY1qFnMX6hfozthwst4QU5TPX6Og4
         eTioxBf8oqHRBdUJGQpGtClv07tgTEKs9pDwUmBWKIvplOAQ+lBTFEcckxkubHycPOrn
         6Mz+OXLZKFpqit03ZuA93C7rzmsfwJ9SRC4TmSP1++BOHZJIJoQ7rO9/4tnex8OwiiH6
         SvOA==
X-Gm-Message-State: AOJu0YyVFEycw0P2N0IoEaOUhnnw1jnwFGD71n/gUTm6ijpVqF5zSyaJ
	fp8F5PKCsNPXvrZwpKp/0/mThROEgCGXqNVI/dn27VqyiU3IVQvHQALe+dYGEZXIEnWr13F0ipQ
	TupJvpbUyz1jrCinGXkdY1Gw7iyX5vIuX6NMcmnAsK0ty3CP3phGIIkIIkArJ+egFn1VusQtAiE
	FjF+BDFIMM5sqrjIGxefrpeKQeNMV/
X-Gm-Gg: AfdE7clVt0VLy/jZb15LiJ79cerya8UANkTCtdq2zSFjJAmTptT+FGbFnOmDDrN0E+M
	fH5Ybq7iOL+bWNNjVrYA+RwHJobSQBthA8586cHvmI4sWtgDYxvK12/uz84yuO7xcC7KZ/BH+2c
	ef/rVQ38lFSl3eoe6WmStWOIuLwJyVMFH7TVV/i8iKHz2LOItwjquEw5h0YK+O3L5mNyRMC/zQW
	Ea+dplaqIc9g8cEPwYRR2HYBbGNW1e5myH2Och/Dap6t7z8ylC1EX/sYVHoSbqyx/whlg==
X-Received: by 2002:a5d:5f48:0:b0:470:3edf:e28e with SMTP id ffacd0b85a97d-47f488486f8mr7258361f8f.10.1784110573798;
        Wed, 15 Jul 2026 03:16:13 -0700 (PDT)
X-Received: by 2002:a5d:5f48:0:b0:470:3edf:e28e with SMTP id
 ffacd0b85a97d-47f488486f8mr7258297f8f.10.1784110573180; Wed, 15 Jul 2026
 03:16:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260713083007.65863-1-borntraeger@de.ibm.com> <03826018-1116-47be-8ad5-4a07e6f96e67@de.ibm.com>
In-Reply-To: <03826018-1116-47be-8ad5-4a07e6f96e67@de.ibm.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 15 Jul 2026 12:16:01 +0200
X-Gm-Features: AUfX_mzZPDV3voE9ojgWKY5KKQeCQr88BqFgkW4Ss6eDq4suBzMoKlrmVBh1WBI
Message-ID: <CABgObfZ9OmQ_MZy7F+g0MVMNM8hypP6Ya75OrCEm5nKX75=A+g@mail.gmail.com>
Subject: Re: [GIT PULL 0/5] KVM: s390: Fixes for 7.2
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, 
	Janosch Frank <frankja@linux.ibm.com>, David Hildenbrand <david@kernel.org>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Matthew Rosato <mjrosato@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>, 
	Eric Farman <farman@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 13, 2026 at 1:34=E2=80=AFPM Christian Borntraeger
<borntraeger@de.ibm.com> wrote:
>
> Am 13.07.26 um 10:30 schrieb Christian Borntraeger:
> > From: Christian Borntraeger <borntraeger@linux.ibm.com>
> >
> > Paolo,
> >
> > please pull the following changes since commit 8cdeaa50eae8dad34885515f=
62559ee83e7e8dda:
> >
> >    Linux 7.2-rc2 (2026-07-05 14:44:06 -1000)
> >
> > from the Git repository at:
> >
> >    git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git  tag=
s/kvm-s390-master-7.2-1
> >
> > for you to fetch changes up to 3e3aa6da87d30a0064a17b836685cd43c90a3572=
:
> >
> >    KVM: s390: pci: Fix handling of AIF enable without AISB (2026-07-09 =
16:23:10 +0200)
> >
> > ----------------------------------------------------------------
> > KVM: s390: Fixes for 7.2
> >
> > - more gmap KVM memory management fixes
> > - PCI passthru fixes
> >
> Paolo, FYI the PCI sashiko findings are independent from these patches an=
d Farhan and Matt are
> already working on additional fixes.

Thanks, pulled these ones for now.

Paolo

