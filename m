Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3590035DA5B
	for <kvm@vger.kernel.org>; Thu, 11 Jun 2026 22:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781218426; cv=fail; b=q3e9k6Icvb8vWFJfmsviGsX3alVz1ymPEEKzN2llMAr6zqK9hAgTmkCab2uywRoWZdWRLfvlpG0hqVm6116NjiM+dXfq9ENCahMS9+BLWXxiePbrMSaVEVU1oTIKCUvfREQpUro7UTJ84EUpYSSV78IWF4XnZGYefH9gnYAgpdU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781218426; c=relaxed/simple;
	bh=PxRZuLlxPed7g3+uVJRSQh6h+tl2QKNm0St8ryyYUCM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RGt43mYYmdpRHW9BiUao4OieRO1B/INIFsJzOHkb2QuthHEwxmdaUKc5AWTJ5TnA8cZpuLG2vC4pnwYWxLZNJdAhAoONFeU9nmVSl4wJQikgPmJ1QFyC6MW+WnxgPqwj39caT6vuEAbC/k3JcTHJAMXUOmgSwhEpV9BC6UEaRnU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=FDSJxjU9; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="FDSJxjU9"
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 65BKte6n2341144
	for <kvm@vger.kernel.org>; Thu, 11 Jun 2026 15:53:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=PxRZuLlxPed7g3+uVJRSQh6h+tl2QKNm0St8ryyYUCM=; b=FDSJxjU9lKGB
	zYwQmQEO00hYYEJ0A/ovopPo9d7CqKqD1XADgRLIn8Vqp1BtdkAsscjzjFBtTOm5
	diVk99kItK4XNYmeAXC4rJxohR1w4XfXN9Bp6eaanw4NKiAW4gyJmERZSpkYpCSp
	omOvIhSNxK+sDVYMbPZyhsgC+FkoO1ml34CzJ/gxKRcU8wmkmA9aQAC3EODqW0kl
	lDxIU9Q+19d3J+fSdA/QNT4u7oggrCXALTCFp2seGU1YuaR3sFJx91cwBUas6m4P
	Q7RVyD542fkWdg5hhoszqMfbGG+JSljRyZ8BmrK8G5dKPiI9D7qpr9eZb7kxJzyG
	Yl+tOZEnCQ==
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com [209.85.210.70])
	by m0001303.ppops.net (PPS) with ESMTPS id 4eqe7a9ghq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Thu, 11 Jun 2026 15:53:43 -0700 (PDT)
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-7e6daf5d8f3so474940a34.2
        for <kvm@vger.kernel.org>; Thu, 11 Jun 2026 15:53:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781218422; cv=none;
        d=google.com; s=arc-20240605;
        b=PLksPQvCvpLDYavpohuLbXfZC8vunpj4hM3a6NWSLoVjk4m4HoX+icBrBEZDXuGABr
         QqkfIfM8V6ngqiZBgAZhPR7agX6O4pMsxB94W+N2fgSzvMvxGZKL2oTzQf0SSS22v3nj
         ikcP63TXyiL6mkBvTS4NKf7PtgZGXThvANRnIavuekSD04quYx5LUBy8AVSvfHRbodep
         nOFiuB+x7bFJserqQ0do2PNCbN8mDssCUvInJn8K0+VFxqDqFD/UgciPBUO6ue/ugHN1
         jZFuY818sz+dClEimR5HZbZ7w3s766PeasAnDyYX7BBDt6BAJGtTdjUfFBgYplQEfmXA
         bbPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=bKpoPiSG0O/ElHpWyO7hVkQGPwY3Ah43xb7s+p7XAkg=;
        fh=G+CdzYHPqP5KhKS7uQXD8QRTH29yO88StuxI2PAg190=;
        b=Q20zQnG92VOo99wn3fXu5ko4I7HGYjcOQtCkE0fgT/KBeYjyZ4q81C0zFlkEjB1F1F
         yve5CeGBrDdscoG0VvHgcC8lG7MloeEFApXsvPKN0U5zGw0k1CJ1isN2UjDFJh4sn851
         FpFmLqIMpgJTmaOr8Wu7dBXJ7pY4pImPprPWuaxdrJsrJPj/94Z/ztBiLJ1nqaaqquoN
         TILmpV04OexwzMnDdLEAEPg6x1Fpoo+DJzfcZ0G7X46vyQK2d/SK8E0PD/8OJCqrDyKP
         G1pWcRUDSjy7GRaA0JS4aG4xzTcwLLdWOIy++jAoMt/FmAaBo6YtgmutYo752TH8Nbde
         Uehw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781218422; x=1781823222;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bKpoPiSG0O/ElHpWyO7hVkQGPwY3Ah43xb7s+p7XAkg=;
        b=c/wN0yJIOgeB32DkAzWIlY2g53V53Ft17aG2AjMVXb42ceRhGDiaGAG2qPVJBqpRNy
         fOivob3kR7MOMW5Gb4JSEvi8MNRJecehx4NSyK7q9OAZMTxu1G4IrZilw/WWgZ82BsXy
         qwaNrXWSiKs6Yx6+/wnv+u2CnMM/ETPTZeEqAt1jIUupYVZmStketEg1Rek3+sFNYt9l
         48WmdjGLy7xOL0ONIH9Y2PAVFI/tbKfcnkqEybWVBJONMb649u5y3DyLrG8MKXPaVxhi
         ESiVonKnNrDJF+VcW+W8IftffsWGqMW9J+xVIC4SKufUJ51JzHmK9tR9Ij4OfPWn7IxT
         baRQ==
X-Forwarded-Encrypted: i=1; AFNElJ/nF4ZPgFcuCYQGxi3J+1hCRCrq2xlHlCwDd6Jc/WEFYoOymdo3Ge3V/WRur3lppN4am4Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcTNxaK4Z+5XqVrCuh8Wx1chDHwTuYfi7Nk52X9TL27/uqIVag
	Bv+Y4SOKXN1amsvMZxCY2OokA1dLmardf1H79ufyu/rCQV/cxp08JPBFqlJf2JeuNDUdyM2y835
	AzUhuOeQIA1u83bWv9fdqqwpIG+1bfUZ8s/XVPugoGGqZsrbMOsEQaH7LhVydO597K6cV3KhwoH
	6Jd4++xyxvdWaVeiL+UhmwNfr1PSMPKYomZgi4cg==
X-Gm-Gg: Acq92OFz2Zx09OZW1p/2WGsD23vGGZrsQWoeNq37vaK5d7pbOvHil0Iz205lfdmD66M
	lAP5ShU+s4hLhuWyUtTs13FGTJXSRaV/ixbvUurtcHH9bQKFGi8zFcBDy8TgjwM66hJ2JDuFxSl
	dOxhMGmJtkUerBcYfzJtBHBOqLCuC/EfyrPFGR4M7GDDiND7/NToYKl0Ij2jvCkJI/TH53q4H5I
	ou6qoz/donUwYkigsRO+w==
X-Received: by 2002:a05:6830:6d29:b0:7e6:d8ea:7dd9 with SMTP id 46e09a7af769-7e7847e1560mr60106a34.22.1781218422494;
        Thu, 11 Jun 2026 15:53:42 -0700 (PDT)
X-Received: by 2002:a05:6830:6d29:b0:7e6:d8ea:7dd9 with SMTP id
 46e09a7af769-7e7847e1560mr60099a34.22.1781218422119; Thu, 11 Jun 2026
 15:53:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260610193158.2614209-1-zhipingz@meta.com> <20260610193158.2614209-2-zhipingz@meta.com>
 <555912e9-818f-4906-a883-6f14e0790672@amd.com>
In-Reply-To: <555912e9-818f-4906-a883-6f14e0790672@amd.com>
From: Zhiping Zhang <zhipingz@meta.com>
Date: Thu, 11 Jun 2026 15:53:31 -0700
X-Gm-Features: AVVi8CcTcZoIZDdh8OjH1IktxPjhUF1A0IE6AmeFSJNyea8GfNww1HwPJ1RCIPA
Message-ID: <CAH3zFs2UeZfqm2M5tX5bBA6VRw2DjcyT45oGJJag5oT2WvKPJw@mail.gmail.com>
Subject: Re: [PATCH v7 1/5] net/mlx5: free mlx5_st_idx_data on final dealloc
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Alex Williamson <alex@shazbot.org>, Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Bjorn Helgaas <helgaas@kernel.org>, kvm@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
        netdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Keith Busch <kbusch@kernel.org>, Yochai Cohen <yochai@nvidia.com>,
        Yishai Hadas <yishaih@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDIyOSBTYWx0ZWRfX1JecJ30zVUCq
 NWVDgggHfulrrUuytsqDCg0NfabV9IQtVAZEISvNF4FVragJqTFilr/+qhzzEWSb4gva9jbMu08
 STozdMbOvmkCptepFDz536dQEfufzfZ0rbD21Inh/xVXpHBIItEAMJwW5/cppnOD57Kkvtphvde
 bG1k4Mm/2wG8G/cO3muViNf0yE2B3S/kB1IGwkqJMlG23BhGJ6tfx5ZE3tikU+Wynx+TqxDi3pb
 CFqut0f3PyCgHxuSC1qu9CMu9sQDv2yKHXMivbsIyR3zT2tXHrZRagiBm7C/TFDo+vOyhhmplxp
 W3rozBoNi/yw17A8wmXg4hZGiWxDb3ZzwEcRywTWRXgcVTa9q3t4Qm+bcso+vwXyOLsYTsT92pk
 30uIwp6yDgP2N9Mg5Sj2qog6BY32IHofMjQPblPL9w3Cu7Jla3UDzzdTfIbndnTLKqYpIAzIezu
 3OZMJi4/wh8OUGns1jw==
X-Authority-Analysis: v=2.4 cv=AKrEjgtd c=1 sm=1 tr=0 ts=6a2b3c77 cx=c_pps
 a=7uPEO8VhqeOX8vTJ3z8K6Q==:117 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=_78whYxrdx1mplLwxq1U:22
 a=zd2uoN0lAAAA:8 a=VabnemYjAAAA:8 a=4OgE2WNpP8yww339eGMA:9 a=QEXdDO2ut3YA:10
 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-GUID: rxcxHIjaTSKgwZk2Brtck8n4g9aOqp2U
X-Proofpoint-ORIG-GUID: rxcxHIjaTSKgwZk2Brtck8n4g9aOqp2U
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDIyOSBTYWx0ZWRfX8k1Nrb7oLtIc
 F146xzD2ABI5E/ATyF3CXgB3UnO9akof8ouxCc9Jez6NrhcSxg+oovo2RHq8a6yIH7AndfKlT1L
 OZmM9Y+hbx7UaKC8X83odhVyZKrypGo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_05,2026-06-11_01,2025-10-01_01

On Thu, Jun 11, 2026 at 12:47=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> >
> On 6/10/26 21:31, Zhiping Zhang wrote:
> > When the last reference to an ST table entry is dropped,
> > mlx5_st_dealloc_index() removed the entry from idx_xa but leaked the
> > backing mlx5_st_idx_data allocation. Repeated alloc/dealloc cycles
> > therefore accumulate one struct mlx5_st_idx_data per cycle.
> >
> > Free idx_data after the xa_erase() so the lifetime of the bookkeeping
> > struct matches the lifetime of the ST entry it tracks.
> >
> > Fixes: 888a7776f4fb ("net/mlx5: Add support for device steering tag")
> > Signed-off-by: Zhiping Zhang <zhipingz@meta.com>
>
> Since this is an obvious bug fix I think it shouldn't be part of this pat=
ch set and go upstream completely independent.
>
> Regards,
> Christian.
>

Sure, Michael replied that he has made a patch to fix it, i will rebase on =
top.
