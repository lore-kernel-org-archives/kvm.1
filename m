Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 296D018C008
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 06:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780036493; cv=fail; b=M/7YVbD1MGo41ePQH8fy1ONuw9fmuTr6n4RANCKgv+03L3eG0QIC1Z1S85Dn9g884XRSGalKRWEuuh9sOX4e19uDuwRo/1+QByFbu9uR+agalpOkCawNDURHuG6cRyrmQYKPwWdy/dYi/L+IYq7J2pzS2J/XLT4JeMvxDyHGv64=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780036493; c=relaxed/simple;
	bh=ZiT8x+cfHgSyrwMnA66rNUoxHkXDnwIwkwrIcOdA0Bc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HuBic7kaIy62AS8xr/2mLCmK/uGgUWk8MQ6T2rQsicOIPxSGL4eUKkEUKWjJrdDKEAbzBROmniwgnHmpTfpWO6SJQn0rgaDXeIIHGMBFiMy5tkC2CR7WaVHVDqR8xm3Dz+YIH/E0TzU11cBC1rfBU413wc5pJhvuaunGum/hs6s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=tE2F1C3+; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="tE2F1C3+"
Received: from pps.filterd (m0528006.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64SNwMP32772630
	for <kvm@vger.kernel.org>; Thu, 28 May 2026 23:34:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=ZiT8x+cfHgSyrwMnA66rNUoxHkXDnwIwkwrIcOdA0Bc=; b=tE2F1C3+IWIc
	hD6uPAo9NgDmLx3SiAIqN6xdU/vi1BTlNSH50fpgV8+w2z56TbYNWRvwyATimLcQ
	6gBB7u+bSsBhHZxDEcSgqK3/4LhMs0I3XhEpCctNiBQjacxzZ64Ht3GAKINKXsRe
	2a4b6ZZDgp7DFIXB6NZzeM/x8uiRnSviRZdPNOFY+C+No5faqHXGRxg3ix2FcSdL
	ETSBtsgPPA9Za6p83WxjzQ6xcL+i2YajrLWFKyrDiNGr07q5cwUoyo4ikTdnEkY3
	yiwI4qfRPsWTAFXgnVqxw2XBZSbFpE5+g2k/neK+34pAldo7nom/u4tzd6ac5WIM
	FzG4O2F7ag==
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com [209.85.210.71])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4ee7x8t4wa-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Thu, 28 May 2026 23:34:51 -0700 (PDT)
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-7e61d8d99dfso9961754a34.2
        for <kvm@vger.kernel.org>; Thu, 28 May 2026 23:34:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780036490; cv=none;
        d=google.com; s=arc-20240605;
        b=fBcTND51DkjntNO7Lo/1Exuj6IsO5De0olz39utfrX29tw/cRu8mAh57w64LdIkfaq
         wWVttsP8XtRSxtZ8eQMV8wwwjxDtQ1APeNN7h3jxvBVZJcafQEfmiSXijFSbFCAZsz59
         ZnSvGuBqcpS3Dy6DiLBTL1XEkYMbZwuJd4cXtAVPsYsw/KGvdMNM8+twe9kx9RK8X0RO
         GlhTLUkY4jFJZYSkQjR+EbOkRW890aXANOdSlUw3HtZtJReHDcRzNtUZiKVejYGW69Sg
         Uc08s+v/pLgyXIbYLbOUIolGzJePg6QAgkvCx+iTQ/qZHEPQNMl6uEYMA2CjPBeDIPCN
         XSSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=sjBZwiGe18mw6X67+Um2SWVYDlncy8HfxAJKV10muTE=;
        fh=SFdi7vRGmpEjTb+V8Ai//6JfcaJ46uSKFwzy1M+op64=;
        b=J+rbp7GtqcdyC+m3PXK5SvNq4pyL2qtVCOfoDhjboFpnWIFY42V59jtHG6w1/ahEn9
         Y1BPsm2r//e4APDIzgqqfuUJfgmF0absYpxiyYAm8yIcpx4taF/6KPcqHJqNGfU+jjnf
         HRcvt6DWx+/ATFdqKabZe0DlVNmbzr/eypVILnRjkGWXOqCmWTE/J5cXhUMp52F8Pwre
         cxo0RxxXqnauh8NP+cZp2HUH1zwGOJHSdbqB82J3aoNPpJX87UIX13DMJZUP9+qXAHui
         maq19Y4EwmbWg1UbYdltxIQSxqYokiQ/omkE/hHQDr8lGXLYTKXGVALdWohnBzNJrP6v
         myEg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780036490; x=1780641290;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sjBZwiGe18mw6X67+Um2SWVYDlncy8HfxAJKV10muTE=;
        b=kSmMQNjZsmihMOGu10oHdPNgEZ4673Jix5PwAHL6hfvzNHWhDxo6AFaMYf/seYPQgR
         /B9bW6hxYtEVWcKv/gM7ijnWn47FYrUalDGbfk5EGD8Tc3L06ZAROoAIqEHfYLXwsTzE
         Zi5nXw/rpDBmbCMaQmbviXcVH8NyLS4QeCq654WeT4EndvWQeqVPHYaTa4lp0IkcNHvd
         73quf1h+hgFkDWOKQ7sN+kkrXmJD3xGwLJRJs4uQdcne/hbwcIOrk7/nWlgjLJWccjQt
         BFiC6JZJNuHCFhc2uzcQAXROZMrU0roMQmAEepJaOGTneSjo1vdjg0LOD19I2BZlB5U+
         poVQ==
X-Forwarded-Encrypted: i=1; AFNElJ+1aQtrG9tf3jkwWEv/c9V0VdTCTY9NXrIgZDybpPVOMTLhaSJyvVO+HDqGJ6iMVv8VyXA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfBEKEI/cIlXedIi2ruYcU+RKQcw9eVghRiubyDGwEbjZQYkXi
	2BHvfcHNM0J7w4Z8gQQtN3RaFhlBGx/L2HRQ9Kj+djWi06P0+Hug+2BaG+b3HXDCzFkTUDrwgOk
	vhHKtgl0C/2lfwDiY7IeA6SPG4opa+D0k9gTmIA7DhTf2EuoqXMha7d/zXxI6euaWo14jfDIHnN
	fY2K01lwoU66u4noTxr0TjsRWQx3o=
X-Gm-Gg: Acq92OGLHsVPrr5f/dnPxEz9q3RVnJapXgOVjh2JFdkG2oNwgbmtC3/+mbMgPcsF+I3
	YRrJNyLkVw/pmo4kKKchFXialIo7pDZsXC9MCFRdo35VkswLUcnR3iTd7Ll9Bc7O1jVYAzY3G3e
	eKXfChN7m4Ak9WiyPYNmkPOrsXMx8NdM1tc4d7naSurdH4qBq69Vp5F6k9VmpIcLNoDH+bHbSm8
	pUPeCqudbrl58RYBk0M5jF/y0T0NmQ53+ODl0f7L3h/Zl0cFdI=
X-Received: by 2002:a05:6830:8285:b0:7d9:d2b6:1568 with SMTP id 46e09a7af769-7e694dc2b7cmr1101940a34.17.1780036490374;
        Thu, 28 May 2026 23:34:50 -0700 (PDT)
X-Received: by 2002:a05:6830:8285:b0:7d9:d2b6:1568 with SMTP id
 46e09a7af769-7e694dc2b7cmr1101924a34.17.1780036489896; Thu, 28 May 2026
 23:34:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260526144401.1485788-1-zhipingz@meta.com> <a8cd01ab-d7aa-465d-bfa3-431f78f33ee1@amd.com>
 <20260527121438.GJ2487554@ziepe.ca> <ff247643-73e7-44e2-b3d5-8ac0a8efb871@amd.com>
 <20260527123634.GK2487554@ziepe.ca> <a5ff1930-e9fb-43f5-82ab-9875d7a28421@amd.com>
 <CAH3zFs2KALuHXReLZG_uoqvBBWvBzU6rHKakmt6HBV7PZEsD=w@mail.gmail.com> <71302a7a-6b9f-40da-af81-b1862dbd637a@amd.com>
In-Reply-To: <71302a7a-6b9f-40da-af81-b1862dbd637a@amd.com>
From: Zhiping Zhang <zhipingz@meta.com>
Date: Thu, 28 May 2026 23:34:39 -0700
X-Gm-Features: AVHnY4LezOs9bV0UClJoUOHcNCdwbl4qfviQEKqNUnQx0j2Atcq5JV3HHpZqmfs
Message-ID: <CAH3zFs036sr93duQKx613pCyOYw4t0_x_TdSza1xBCaEmqijyA@mail.gmail.com>
Subject: Re: [PATCH v5 0/4] vfio/dma-buf: add TPH support for peer-to-peer access
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Alex Williamson <alex@shazbot.org>,
        Leon Romanovsky <leon@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Bjorn Helgaas <helgaas@kernel.org>, kvm@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
        netdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Keith Busch <kbusch@kernel.org>, Yochai Cohen <yochai@nvidia.com>,
        Yishai Hadas <yishaih@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: jTEwZkP0Wt34ZuKcdLRX3UGoJWeRHq_5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDA2MSBTYWx0ZWRfXw4Ois8Ch1VYM
 7lHhBeGLfwi1jn122MYR5bhzpUmL1t66sqkoU+ClpKECniYo4tqhtjf7FDadjPCUrRBzTW8wPyB
 ABaflyoyzf26AKVgrg5wW0WsutXh7irncxOAlfpMARokR2oJRB/JOrTvfzoEkEoqMKb9ntlMA1o
 oerUhBngS5Lxj9gdhYYcaAJsXGybF/8NZMwDPajewENiUbiELDU9mhToWKqD8IqaQxt/YyL6Zny
 yPiiBCCljtibSEWj2GmC7qdDilj+jVS9mlLyM3oNSTIsGaWuy1Aeo50eCSdyGnVdcvbo9rjaMPM
 Gxxnh6+6Ce5Mtu6pufgestwuoZ/k9awfUDGqzoaferoCZ0VMOvlWxOWnmtlhBD+OvP4IDBk5IFL
 m5mW886Q/8T4kVET7GL7hB/yplhmLNdI2tqZcZEJ3QVhK1mSTcjcTPaVpu+K5d6PeQ4Ecw3XDdN
 jZjnHessYTt1zcTEj5Q==
X-Proofpoint-ORIG-GUID: jTEwZkP0Wt34ZuKcdLRX3UGoJWeRHq_5
X-Authority-Analysis: v=2.4 cv=PomjqQM3 c=1 sm=1 tr=0 ts=6a19338b cx=c_pps
 a=OI0sxtj7PyCX9F1bxD/puw==:117 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=kkcUborcUVj0H7zxAXTl:22
 a=zd2uoN0lAAAA:8 a=f7uq7ceqOUF8L-MFIRoA:9 a=QEXdDO2ut3YA:10
 a=Z1Yy7GAxqfX1iEi80vsk:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_01,2026-05-28_03,2025-10-01_01

On Thu, May 28, 2026 at 12:46=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> >
> On 5/28/26 06:55, Zhiping Zhang wrote:
> > On Wed, May 27, 2026 at 5:53=E2=80=AFAM Christian K=C3=B6nig
> > <christian.koenig@amd.com> wrote:
> >>
> >>>
> >> On 5/27/26 14:36, Jason Gunthorpe wrote:
> >>> On Wed, May 27, 2026 at 02:23:46PM +0200, Christian K=C3=B6nig wrote:
> >>>
> >>>> Yeah that's a good point, I should probably rephrase the question.
> >>>>
> >>>> I'm aware of how TPH works by adding the extra ST to the TLP.
> >>>>
> >>>> But my question is how is that useful to a PCIe endpoint? What is th=
e effect of the ST here?
> >>>
> >>> TBH I've never heard Meta explain what their device is doing with
> >>> it. At least it seems to be super important to their device..
> >>
> >> Yeah I think at least a brief description of what is going on here wou=
ld be necessary for the review.
> >>
> >> Otherwise we have only the info that the exporter wants to give an opa=
que ST for the importer to use and no technical description what that is go=
od for, how to test it etc...
> >>
> >> Regards,
> >> Christian.
> >>
> >>>
> >>> Jason
> >>
> >
> > Fair point =E2=80=94 I'll add a couple of paragraphs to the v6 cover le=
tter and the
> > patch's changelog as well.
> >
> > The short version: in this series the vfio-pci device is the completer
> > of the P2P
> > writes and mlx5 is the requester. As Jason noted, ST semantics on the c=
ompleter
> > are implementation-defined, so only the driver that owns the completer =
(here,
> > vfio-pci on behalf of its userspace owner) can hand out a meaningful ST=
; the
> > importer treats it as opaque and just places it on the TLP.
>
> Yeah but that is not really sufficient to justify a driver 2 driver inter=
face.
>
> Which PF driver is backing the vfio-pci and what effect does sending TLPs=
 with ST to it compared to TLPs without an ST?
>
> Regards,
> Christian.
>


There's no in-tree vendor PF driver =E2=80=94 the device is a Meta MTIA
accelerator managed entirely from userspace via VFIO passthrough.
That's why the ST has to flow through a uAPI: userspace owns the
device and its ST table, so it's the only entity that can publish a
meaningful value for a given dma-buf.

On the effect: the endpoint's PCIe ingress block uses the 8-bit ST as
an in-band instruction for the incoming P2P TLP =E2=80=94 selecting a target
cache partition and, on writes, an in-flight operation on the data
before it lands. The dma-buf callback keeps this opaque to the
framework =E2=80=94 only the producer (userspace owner of the VFIO device) =
and
the consumer (endpoint block) need to interpret the value.

will include these words into v6's cover letter.

Thanks,
Zhiping
