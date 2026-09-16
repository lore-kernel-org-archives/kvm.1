Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C06118DB2A
	for <kvm@vger.kernel.org>; Wed, 16 Sep 2026 00:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789517842; cv=fail; b=l3YvmR0E6AvDCn4JhoigvYeVemMUnvFiOjzSSfzy7kFwqsxzkp0VkRLTQ0sSNiS1LEvVxiAwSqoN6oIHNqkUfhteuOHXapjmlcHyr4Td1XUy9OhHubZ3Zn+V4cptIejTLP7Vq+93g9K4ooNThN8gndcMZESR75TslyHdX7tE8Kc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789517842; c=relaxed/simple;
	bh=5av3QgEhikSP0tSNbBAG2bZkciaGDEOrmy5hau/6dIY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rLV/xwpivrqzDM4+4r3Wr7AdSHMDEG/8BLrzHi7Ld5cGHqRe0SfnsI7zP4U5U+pR6GareXPevvIrA5Vs8aDaGQy1WE9nJvRm8GxabmFAER4SBOGUVzaSoB9Zm4pxp7P7o1LoqbRbz5hcBqmTlMvlZFMdLWfFRlwpZeWi1TEefj4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=SV3hPlDn; arc=fail smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="SV3hPlDn"
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68FMOdV11472567
	for <kvm@vger.kernel.org>; Tue, 15 Sep 2026 17:17:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	pps82601-s2048-2026-q3; bh=y4AfS6tr9HrRnC6D4zpOkbqwXmfmGihLXHO3T
	H7isxM=; b=SV3hPlDnkLVLzLZ5wbnt0LfyWojFDHoTKaL9JlUmAXLtdCh4GpdZ/
	SKD174SCvrUikKcMBYauckYS3JgM+tWicqg6Oj1Bmcs0oYCNvfbaKfuYGlrVLJKf
	r6OwvK9Qe/f4pBy01MEWp1c9CWkCnaxUkeQw8Qd9+jvYiKtQS4cVfUVdETDA7xaZ
	i02VojdTANK3f3sj2LsPaRR7E9gJFNv8lt86XsIF/4fC95eqm/hGduydG7DxeyJK
	pir0xIEvbcfyHKR1q53dV/4//VMrQo9fK9ExB2hkeqKevwM0hhR489OnIDrdaCGJ
	MkoepWkx0zrAKKuQkN2Vqp+EvaVdA5v5g==
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com [209.85.210.71])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4gqdwn941j-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Tue, 15 Sep 2026 17:17:19 -0700 (PDT)
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-8064fadbb1dso2472180a34.0
        for <kvm@vger.kernel.org>; Tue, 15 Sep 2026 17:17:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789517839; cv=none;
        d=google.com; s=arc-20260327;
        b=nseAMCKa30KBGJ9py+Qy4v1JXKcktJr1LsvaGahHTvp98meRjvGhGtQGgAKpY9u5lD
         b4sn93hFxGC9e7brO1mZW6AgFz+mTpSdc8+FXuWEaYBDMYg0SvVIFZngcqnGIParMlOa
         BM/alxKmaKZXoOUOl8jboF3lHY/jzftKdb2qn6MhtpihqdenwuiZBu8/PZb7nyM3jcE6
         CQean/gfrhw3Zk6WqQznft9liySXEbwU3zffSXxWI3kvxnjrYiyvnhj3qd+s8jiUQkbN
         feV5sXLNNuSS/B9BHPYSkYs0ojkIQVIIA4+3RP+C78Hy+vF5AnLP7EpkU7ZirLNW16F0
         7ciw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=Kw8qhFcrPQrG+D+0UL2QgWXn6zGjS5meCnbxBsS+WIw=;
        fh=iik6P5S9GeerxSRPc6FW1XY6E0dhN54kve0QWOiNmSY=;
        b=P5pSen24fSJBrd7IifSI4qjqFtxROtvyOSYRnAswPuvzKVhBzu2x1q32GOkSo4kYD/
         lSnrRuk/+6l8Wl1JwrJaGDDcBC4XFj7q5UyzHOJ7tlQ2+hoaNZWhqgopnTXxBg7JOMX5
         OvEjv4LrKegBqQv4KpwZ3AbZCKJgOKvH0Vs0ZZvytQzkrZAzUaNJWXWEYW+e3fJI9u0t
         Vi1mm+Vpj+BamR0LhhIR3WdlpjHgPdPbSaaYdlNHU7S550dhw9wea4dZy1OZaiXMKcek
         9Kw0w/WPygYW1DjVpS4RoklEsLT4USoe0pMSWfLVD/3O8O19Z5Te5305WOZy3+VyrZYj
         kybA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789517839; x=1790122639;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Kw8qhFcrPQrG+D+0UL2QgWXn6zGjS5meCnbxBsS+WIw=;
        b=zr6so4cmu+APWAvqRXUiT4xejkpJmq0JNSsO/GJuWE6dZWFdFxH4gpWxtTigS6bUx2
         dexT8PN+5xCR/Ffm60cvF6GDGfClmv7sxby3rp8V4uIG07cCFdghKYwssFR86UBIUHSu
         lRwCaz6OrA29LbJwIPIx8NX5eVIdxfvlOMQrs1/6kVnMadXEecwTELsGvl8fCXlX8y5f
         z8J/GwXHjlRhxRiyIO3JztAC/mkqKFOJrSFUcfsc7gjB47EdCWdPa2v+1SdaJCXgXr6G
         ptN7M5BY6Gw+NIWlZrbwqZunQJFHj4Nd/CmHPwz1912UrxZAXm8Yi7zyFlZJB/tgSCTm
         l2XQ==
X-Forwarded-Encrypted: i=1; AKwUvBxHzqGzbK6ylQyelYDIJk/eRxeMf4MrJF0IRJtd3V+B3sXoxQzWfFVpyTbyFs9iqDLzaEA=@vger.kernel.org
X-Gm-Message-State: AFuF++mDAsMu+xvJg+lvEgQNwHKEbpjX6N2FaOVFHomuYqONfL8bWvnb
	y2/zLyd9N55boFRQW6pVPqfaztKL1IxagEBmIOvs1Sf4mOTAR5z0owr+3wyxxkgQLOyfur/Jzf2
	Er/vmN68NDYQOhATkCacpvBEMnMnxsCqPsoYgshFoOCy9Z4J9GPRVqY9Q6csJe6HxCb6X1TNr09
	z7AeItFSrHuzbx4xcQLhgoiyhMk6U=
X-Gm-Gg: AYBFou2ss7EXduofvX+pTpRCLVzmpH0YK09xg5T64IIMhskBAxJxJTmkjGvSMYWhY9C
	sCMC494DO2rhpsGdFJPL9RfAe/ZM0vMpEKhanNKNEAEZUeUGNEAFqWptkJoJv9MS+YfWb/PwFB4
	T0w+ENXn8b2YqIDDyY8iA8Y5hvW5mHuaOm4LatzSPu4HnDYMBDYiZmbgAXrEU5c36TombMoXfm
X-Received: by 2002:a05:6830:d0a:b0:7e6:d54e:8fe3 with SMTP id 46e09a7af769-80b2d408fadmr803753a34.9.1789517838983;
        Tue, 15 Sep 2026 17:17:18 -0700 (PDT)
X-Received: by 2002:a05:6830:d0a:b0:7e6:d54e:8fe3 with SMTP id
 46e09a7af769-80b2d408fadmr803625a34.9.1789517837178; Tue, 15 Sep 2026
 17:17:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260731211601.3033906-1-zhipingz@meta.com> <CAH3zFs0vQidHOWif_LmS0=65S9iiCo7yGibqLvFT5jadjj8wVA@mail.gmail.com>
 <CAH3zFs2XnH6gT0fO4=WLi4x1SL2+Y0S=Jo45SWkR=unPegQ8Hw@mail.gmail.com>
 <CAH3zFs2X8=x-XMXhwC7_aUZivCCPQOSuyXMy-ryKqxLEFY9u-Q@mail.gmail.com>
 <c0c8dea4-1571-482e-be33-f965c7c357d2@amd.com> <CAH3zFs3=t3rNDDjUsCAekfhEGOJPyx-YXKta7NdHy3kBKU_RHQ@mail.gmail.com>
 <20260915144901.554f905f@shazbot.org>
In-Reply-To: <20260915144901.554f905f@shazbot.org>
From: Zhiping Zhang <zhipingz@meta.com>
Date: Tue, 15 Sep 2026 17:17:06 -0700
X-Gm-Features: AcwNN1UDllFH7fZheftU62Oc0zcY8368FZvRR7u05GnfBjshQDxnxMnIHm9x8No
Message-ID: <CAH3zFs3MwpxLNL+qK9e-jPBLasjfxeMvudhgz5XzwrtvL1Dz=w@mail.gmail.com>
Subject: Re: [PATCH v13 0/5] vfio/dma-buf: add TPH support for peer-to-peer
 access - ping
To: Alex Williamson <alex@shazbot.org>, Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Bjorn Helgaas <bhelgaas@google.com>, kvm@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
        dri-devel@lists.freedesktop.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE2MDAwMiBTYWx0ZWRfX9ipnWfks2awx
 xP6bZqcBm8/59ftrdnhT8O7N5Uei+JgtOhC1MLKNjn3Ln0tzsY9zNBiK54+KyVG0ZwMSG4rbzHI
 3+2MTAqAHwkUGx6mHpT8fKzMmzirHVw=
X-Proofpoint-GUID: Rjvd4ZabTDMyB3iqPcZlpScZx4i_1NwM
X-Proofpoint-ORIG-GUID: Rjvd4ZabTDMyB3iqPcZlpScZx4i_1NwM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE2MDAwMiBTYWx0ZWRfX8mh+g/pEX9QP
 GAe41hcJ3HbeCQUvmDAWx+jdBY4/84nXkfcziU2IomV58L1EdRTPnRN78iXz3+CmDNTIdeL3ODP
 vzsiMRnry5CuXXvGb2zlK0aO3L4V+cdWNhNWo53C2ZvHqEQTac2m19TPP/cCNjdiHW1LL+IJdMu
 p5a488xxEcHmm2zz/5YReg88Si8J4Bh0DusX/CCLpG2/KRcBtrzyZH5/zywaiEBuLJt6y20c2z7
 xEfUiEAJBA9dXzvgekflOJfmplOOzV4+a15IVh0Oz5XnHxh+6byAKIykZcnm+dyWn9muMHsO9lU
 yndlEauGECNjWYVgfYy3zQKZg0rzgthnzA3RJ+oEAAvofLHHmKSCKcrap5eWOnkhIxv27WXiYTu
 IyPc4pKE7UaZybu5/XXB4J2qDJfGGAPbOwGwlLCA6G69khh3iZ2ML4lB2AUQLILJNkfQRvPkvAo
 yxtiPEBWWmsbxC/vaTw==
X-Authority-Analysis: v=2.4 cv=LpEHWXdc c=1 sm=1 tr=0 ts=6aa9e00f cx=c_pps
 a=OI0sxtj7PyCX9F1bxD/puw==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=tpM8CJlwf7uhpglF1g9U:22
 a=VwQbUJbxAAAA:8 a=VabnemYjAAAA:8 a=r1p2_3pzAAAA:8 a=tEdGRIS0mffteslzfD0A:9
 a=QEXdDO2ut3YA:10 a=Z1Yy7GAxqfX1iEi80vsk:22 a=gKebqoRLp9LExxC7YDUY:22
 a=r_pkcD-q9-ctt7trBg_g:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_05,2026-09-15_02,2025-10-01_01

On Tue, Sep 15, 2026 at 1:49=E2=80=AFPM Alex Williamson <alex@shazbot.org> =
wrote:
>
> >
> On Mon, 14 Sep 2026 09:44:57 -0700
> Zhiping Zhang <zhipingz@meta.com> wrote:
>
> > Thanks Christian -- no worries on the bandwidth, I'll add the Acked-by
> > to patch 3.
> >
> > Hi Alex, Jason, Bjorn,
> >
> > Could you help with reviews on patch 4 (vfio/pci) and patch 5
> > (RDMA/mlx5), plus acks on patches 1-2 (PCI TPH core) so the set can
> > travel whole if it goes through the VFIO tree, which is the route
> > Christian suggests?
> >
> > I've also rebased the set onto 7.3 (base 5225b8eec4c9) and retested on
> > hardware -- PCIe analyzer captures confirming the requested ST and PH
> > on outbound TLPs, no splats.
> >
> > One thing to decide: upstream took 13 for
> > VFIO_DEVICE_FEATURE_ZPCI_ERROR after v13 went out, so
> > VFIO_DEVICE_FEATURE_DMA_BUF_TPH becomes 14 in the respin -- let me
> > know if you'd rather it be something else.
> >
> > I'll post v14 after I hear from you. Delta from v13 is the rebase,
> > that feature-number move, and nothing else functional.
>
> IIRC, we're pretty well settled on the vfio-pci front.  The feature
> number does need to be iterated to the next available.  We still need
> acks from PCI and mlx5, and given the extent of the mlx5 changes I
> expect I need to provide a branch for Jason/Leon once I merge it.
> Thanks,
>
> Alex
>

Thanks Alex, it is great to know the vfio-pci side is settled! Bjorn
acked patches 1 and 2 today, so PCI is covered.

Hi Jason, Leon, could you take a look at patch 5, the RDMA/mlx5 consumer?

https://lore.kernel.org/linux-pci/20260731211601.3033906-6-zhipingz@meta.co=
m/

Thanks,
Zhiping
