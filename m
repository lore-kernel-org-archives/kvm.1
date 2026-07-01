Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A33D39EF39
	for <kvm@vger.kernel.org>; Wed,  1 Jul 2026 21:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782940041; cv=pass; b=pW9fjel87L+R/0zJuQSqdayQLrZiBnBF+jyARPQNg3/esSU3pPaysXo/9iEavrT4f8bEPOCWWzztytnVNtLGgs6GwZGRb4rhBB4qWMlMPU3zsnraAUIq4S5fHJhFsu8hvypULYgqe9Tl8EHA16jd+UmJB6waSqIX+UfKKh3q2dI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782940041; c=relaxed/simple;
	bh=Ceo/eQzTqKQOw6VV30yrUBdtzlEqkC/54DauyHODWuM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EsRxo4n75EiIQmWlMLmeKM43cmL7dpLlDbma/Aywco+CMLVsZ/ib05R7uFUvZKKrVJqhKYU5W3R1/F6fIH+UQgRY6lNGf6hK5CXrdRIKirJRsuDw8OxSR8Drsqp5MZvC9griO8U+Uy9H+AfH4J//W2/PpgWXiASR6bBS7p7zyLk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=JriekQid; arc=pass smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="JriekQid"
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 661GqUFD512042
	for <kvm@vger.kernel.org>; Wed, 1 Jul 2026 14:07:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=24aInYXtnwOY36q1nTcGx+GLSA67zMg6UsmTMMOvEvo=; b=JriekQidIHFn
	3OZIro8QTgAFnzTOmG7w3ybAxj4FiStpeTTRGBLMAMypxTBXO/RGcUhrKlV7/8+I
	NGp2k1oxd1md4lnH8eLkzcoRP6bO/irin9BMsg0lfaoBV8svypOfCmDIAXLNW5sK
	GtZ3MwaSl62Wu0/6dVeDLcyETxRKmxu3+aaDSQG1+4lqXzSIaR/Z73n1wWbswdiY
	JS+tG40E48v0uq/02iJ0qwE/0HOR2lWNrkfJif1YbJnyfmSRCgkJvV3Ifv5Qcrni
	D5okVxBynFuMB98gOqC6WhFZmaUI875K2RzzzSTr2Jczefn/3aJenaP3WDlVdFCR
	x47wIFjeLg==
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com [209.85.210.71])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4f48k5qh30-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Wed, 01 Jul 2026 14:07:19 -0700 (PDT)
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-7ead3468408so785685a34.0
        for <kvm@vger.kernel.org>; Wed, 01 Jul 2026 14:07:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782940039; cv=none;
        d=google.com; s=arc-20260327;
        b=h0HZSOyOJfa7p8y4s0VhRjHKrc+TdxS9c3KpXrUc6pFAg3EJVMxVzSUWNpV1tGsi9N
         gcbwfGx2hLRsiTRFA+a9w6fZAE1e2ZRQu5HG5EGubADAXpfjgM/gRRr9meTLCLoaVPqe
         +5DbR54DLvk8cNUT4byMzQ1Z3AJ3C7YzdiGB7fjV/vg8th/ihDGCPVoHVPRThBqIV/x6
         mUofLVKNS0YsK5nB1vn4DfnoCnDZlXNfb5kDiIImgpsJj2ytgg1msSx4xoB0R+WYJ49s
         qyByiDdXmU9koCbDcpV7+8y77zIBXZYeRofCMdW/Zl7E3DBWqO0eVbX7gIz7MQHf9Zri
         hGeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=24aInYXtnwOY36q1nTcGx+GLSA67zMg6UsmTMMOvEvo=;
        fh=HyywDZ3O5hrVTiJJyLN+JfjiQtXGNjujOZ//6+wlTW8=;
        b=WN92kFGVHAOBy6QW0bVucCPixm4hhjG5ir4i0rs79T/cji2lpjx+zfTz3TeyQc5X0B
         O65CIYm4BstJlTV9Pidzx9l0YmAmPnC04kANEinHAVipn06yL40eXWXMQC/XWOeGIESp
         kNY54/jJ2p+WTPkmOniWBVdliDfXwfrBkQLE8dUFa58YT7rn40Nx0SbAu+LD7WCg/M1u
         exc82w1oQcOy7iS/BucW7/9RNpExjJqs+/dnXlTd+bNGBvK5j5RrlISXV/js2nfyogTy
         Vujb8v85vWVgxlSnxKlxcXlKT5M55Zo7xeWxZfp2Bo5vpG8NqEwxXPLdy/6RQ3nGvgU/
         dIuQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782940039; x=1783544839;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=24aInYXtnwOY36q1nTcGx+GLSA67zMg6UsmTMMOvEvo=;
        b=owGlIcGA2Jj1FMpNIwxB79qx6I/IMVY3262cmQNVaPt5iWABsLZCiHomtPPZxFdn3g
         tehkAVelXzL1MUsgUEXEBv7vxQS4IJ0Sg/bOb7prT6QChslGgWiHTnxuIJHBDVpIq84t
         h2igrB4e07AGVCSPDulSiR6u3rIG46BxxnV6xt++MptiwJvSMz3DOgoXJYA0eA+551G3
         bg33vn4JnDVSrzR31tvoOQvCofYDZPDCOMo1ibenBFJQeq83+dyxLGWtq3I9VfR/+Bua
         5MwKWI/eUukoAG2EWetHo9/4nqkZZu0LnOmUi2mLUjFmS+w5q6jap4ZF0+9LNdVRkLhF
         Pvvw==
X-Forwarded-Encrypted: i=1; AFNElJ8uf12iZgnJligsZv4MZF03is3KkP7rFDGxagSYk6ei9mJcec1WriMYwBczgVlhaUwIy7M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvU5ukWTDYsldLbs6udjaZVY1vZ7nnNlhW12+CAq87qslfiPE6
	zKO/vbf/A1wBaEkSGnHAL609R8e3N4Zo/YVBZJn+TSJ4rgl4EmztZ+ZfKLRtHExiKrcjXyKiUQ0
	G08l40qAdgBk02IItDjXQ3kjJNA2kYDprlcEekvgvnoin8mWDOaJGrslh56G633y0yYFG2pDPgB
	1qHg0xqYKa2KMeL4/krQv69x6vags=
X-Gm-Gg: AfdE7cnYQiA3UReOqn55giCQGMIR7PFr6oc+UVdPXQtl8CEZ8TfZEonNhjI9XiJU4j6
	hGs7ee1ybh3lAHQXQquzY+CDr9Cv31aaDgHMBcZrv97IhBo/Qr2noiD7ubknnz8hA5qZJ2nH99K
	qKteZX/I3ehklDYoWDqoIHj3xIhC2oWe0k897/72px9cQioE55HRIhcogD/rocssmCpSnR1ZfkV
	soA4oJtlg==
X-Received: by 2002:a05:6830:82b5:b0:7e9:c481:ff8a with SMTP id 46e09a7af769-7eb48b0dad2mr2267489a34.11.1782940039009;
        Wed, 01 Jul 2026 14:07:19 -0700 (PDT)
X-Received: by 2002:a05:6830:82b5:b0:7e9:c481:ff8a with SMTP id
 46e09a7af769-7eb48b0dad2mr2267473a34.11.1782940038625; Wed, 01 Jul 2026
 14:07:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260630224328.3218796-1-zhipingz@meta.com> <20260630224328.3218796-4-zhipingz@meta.com>
 <20260701120700.58bcafa1@shazbot.org>
In-Reply-To: <20260701120700.58bcafa1@shazbot.org>
From: Zhiping Zhang <zhipingz@meta.com>
Date: Wed, 1 Jul 2026 14:07:06 -0700
X-Gm-Features: AVVi8CfZM9KJwSZGN9TaUIufGVTMoHcKZ-xzBFuNkplSBdDCFbtywxUsQs319WM
Message-ID: <CAH3zFs0bmTTTtw-WZsbhFqzdPfriwOOqp4XAgo4TGekA8HYw0g@mail.gmail.com>
Subject: Re: [PATCH v10 3/4] vfio/pci: implement get_pci_tph and DMA_BUF_TPH feature
To: Alex Williamson <alex@shazbot.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        Michael Guralnik <michaelgur@nvidia.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian Konig <christian.koenig@amd.com>,
        Bjorn Helgaas <bhelgaas@google.com>, kvm@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDIyNiBTYWx0ZWRfX+G7ZPMYuyX8F
 GY4WrUNAi1NHedo6CwEfqHUbXy98dw6GwlX9EkZsxEn01F+2EAWso4ex+0yvQyP1l+O/uVlkNjt
 D9vWZ0C7Oqaj+K+mbI72V1Jl2NlcJkA=
X-Proofpoint-ORIG-GUID: U95_QjKI0Tv3Uvb-dC6UGYthJAJqcpCq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDIyNiBTYWx0ZWRfXzzd6fQZJ/lnh
 Hdm+d4j+vmZK7d7yvj1FXJnqK5lMdC8Ec5Uc017QZDyRYoReaCxRL8GldKIVHKHEirprzxzLEmi
 576Ylt9ASmZCmXruMyDV7YXYwURW+1IKMFMenljHzUEAdNw//5XKLfscYXcRn9r7/fMaQk3XzCy
 wUv9NkzXJybqRLT3G14yu7pWPEwWY4vPTnWZyIeLMELlbZuDUkyooMuHsokvu+doqbrY46SnDmT
 NXiPwcK7MNe1WPBS5VHQ3B/WMudjwWRPFA8aRQ93HrBb6dMbIPUvdIu36zNBp8/1K+EOF6urHRg
 y1h2Fw3PnCYNef6P3R6ASdHh5Bv1BiR2ERayxy10bXIbxVJxIe5hJS/V2H88BpXjN2YT3EGnxlj
 yDj7zceI9z79bml84IVxEmaFIWh3d16N0vwaURka6qQ+Xm4Rdxkr3FGw/ilJygMkUPlLDaY4Xgq
 kIh578wEEmh229h/XPQ==
X-Proofpoint-GUID: U95_QjKI0Tv3Uvb-dC6UGYthJAJqcpCq
X-Authority-Analysis: v=2.4 cv=QMtYgALL c=1 sm=1 tr=0 ts=6a458187 cx=c_pps
 a=OI0sxtj7PyCX9F1bxD/puw==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=crHB47gyY4rKiduisYu9:22
 a=VabnemYjAAAA:8 a=r1p2_3pzAAAA:8 a=vGJ5o9TXFsc4WUGASEEA:9 a=QEXdDO2ut3YA:10
 a=Z1Yy7GAxqfX1iEi80vsk:22 a=gKebqoRLp9LExxC7YDUY:22 a=r_pkcD-q9-ctt7trBg_g:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_04,2026-06-26_01,2025-10-01_01

> Since it seems there will be a v11, note again the comment made here on
> v9:
>
> On Tue, 23 Jun 2026 22:24:54 -0700
> Zhiping Zhang <zhipingz@meta.com> wrote:
> > On Tue, Jun 23, 2026 at 11:17=E2=80=AFAM Alex Williamson <alex@shazbot.=
org> wrote:
> > >
> > > Nit, it would be more accurate to say:
> > >
> > >         /*
> > >          * Updates protected by dmabuf->resv, @revoked additionally
> > >          * protected by memory_lock.
> > >          */
> > >
> > > revoked also has an unprotected read, but it's previously existing an=
d
> > > benign, and likely just needs a READ_ONCE() annotation.
> > >
> >
> > Agreed, I'll update the comment and add READ_ONCE() as well.
>
> The READ_ONCE was added, but the comment remains as in v9.  The
> READ_ONCE rationale should be described in the commit log too.  Thanks,
>
> Alex

Sure, sorry for the miss. will do!

Thanks,
Zhiping
