Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 713223DDDB2
	for <kvm@vger.kernel.org>; Thu, 11 Jun 2026 23:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781221562; cv=fail; b=lw4nwQ67ZWbxXOD2D8nKCgMPtfs73mT7kFnib4zTShcqt/ondAhKX6npyv0XDhN5dWXvjFjhf0gMW8sDAMjVF92UG9jnOUcGQypjH8JpRR0nYLn1xWHDlMALPypPDDQ5Elz5NdZRsdOIE8LDU+K7QmsEeYM3SOrlu5OFVZmBcqA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781221562; c=relaxed/simple;
	bh=wM82CBZM/T/B4tXhf63AjAwD1f2VxLY1SoQyRorBE9I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CVkTZgoIESYK1EERC93b1KBUVaHOSGarTBMxPLlpxNR2LgLiVbTIrBXO8ceNvENHGyiKBosZtaQihbUlm5O3g/JExsRTNjHtwAWVGESOkyu3LyK6QqDcVeP7X5Io2TzESL+O5+MWZZPr76Y6wgN5XUIW2Sm+LAX9wDkFfC5tj+w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=C/D5WLO0; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="C/D5WLO0"
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65BMALLd3301531
	for <kvm@vger.kernel.org>; Thu, 11 Jun 2026 16:45:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=wM82CBZM/T/B4tXhf63AjAwD1f2VxLY1SoQyRorBE9I=; b=C/D5WLO0mmbA
	Ud0JqF5B+NiRYogOXFY27nmYpBJEirm9IRllvwozXjgx8OIFD5ZV8faeqTA3bkPS
	QQWZkebPb05AEUyMH8P16H5UX/fEBtNpeSpSliXT4oXjzyno6ILLCxFInu9/96z5
	1EJj/KLr2YVNpfd/nUoJ5mhagh5nM7sa5TvPfzFUJ71l8C1p7W0tPydae6CxTcqV
	tYwT6puC45+P6mMcS1ezBsA7Os1dhZQGhyxQyH3i47tvMD+VBY2zLGJ1L2IC/Muy
	9fS62yBoiRy7/k9VAoZ+zz+a3YlY8q3mXa4pSOy8Nssbs4fwqZWQUMQUW7GP/2Hm
	q3IRLexocQ==
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com [209.85.210.69])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4eqe78hqge-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Thu, 11 Jun 2026 16:45:54 -0700 (PDT)
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-7e6fa8bba1dso944278a34.2
        for <kvm@vger.kernel.org>; Thu, 11 Jun 2026 16:45:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781221553; cv=none;
        d=google.com; s=arc-20240605;
        b=cvtonEYo/ctHpiO/wKGbc7KaZbA6ylA/0JG0ErbRy45uZEKGvwrjzkhoCy2S7HrgrN
         7qsHwUFueMJVgyu/cPXNP2l97EB6HddfdVE2dxBXINTXWVLQ+qqejNW0ZESVLGJClYVf
         sPlzPgq6adx4GgjaVOVqYYOMzGhU6lJB36MGY0K2v8Acs6+GR0jg2tLm1tjSe4JQuS1m
         ywiFaUwllJy2IHUYas/V8GIv39YUTrhgBRw9Yy2+5HZjr926CQoRcoxvtWWsDppdlxWf
         omT3beTX5ddIDwAlAW5KmpTf2JbkuiGjVealr1PRibQ3zBaa9M2aQeT9SEO8rtXuGYKg
         Tzsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=1UnBtkB8A80kDFmam85CYV9Oy02dqYtmeBOXBtV1LT0=;
        fh=ceOQv0OKn4VCvirBk1bskm1rxmCcbJvAbR7SVGx/2LQ=;
        b=RLOtAYRrpe364lWSGEfCTyT4Ly1SywPEJ/g/by6IZw9c+QNHOPMcpS/Bq4XYYZ9rnv
         DRIkSg1THzCWCtW7lOUXkP6hkY81cyF+fTJo4/DkP5eNqo2NIrV6g7DQcQIg0h/SCnfm
         68X+8dSyZ308aA135QoIfPXrnRMw3Dmdb0E7ntZtGP1fcwdMWw9jiyQuITCuLDdLQRIe
         e8ZZEFNP1MrsDu7JNMezKvgA93fQ1jF6F46+qO4oDYju+uFlaXHRjE7dlkldTbYbzeIq
         ltaYJcVvZ30sl9LgreYxKDn1kuFvNfhUtwDrMRQl4JP6qKx3cTCFhPZjAsfZK/wjFphc
         fXUw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781221553; x=1781826353;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1UnBtkB8A80kDFmam85CYV9Oy02dqYtmeBOXBtV1LT0=;
        b=Q8X9cxcdGSju8j3AmszJhOpG1dmMT64SEsxkSBpIqETSw19iFNm7OWBln2aTTJndDL
         i/Mmw8iowXTKRMUX25b4aCfwvc+/xJh6MQAo1HgOOfA1GhgMDA3B9QUD8b+aQ7BZjhHU
         MvBJFXOG/9fJtWgfB/3YIMrGsuM46xqdyY0ml5wssj/trTiQRnM9ig1WRfdVuGkElIeA
         /nUQ/N2abH0EwtfUyv/+Hz0v7r+kP0BQyeT/ofF2o79d3RLlpV//4mu13sT/nWjzCLdC
         lp3kWqm9XEtlZDq4JOvFT5PkX/pAiH3HrEWLnyn4nwvDgYVyYzd+84gdvS9pL8hkLgDn
         m0dw==
X-Forwarded-Encrypted: i=1; AFNElJ8xtiGEv6ivKzbi7OT6VagVHEzGn7NbzFPtFJTA3voICHEiCdCG3NCPKeRYF+DuzQVjFWo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAP1tvb1mPY4pZ6yx47tfM662a3dVprSZbkztDvkyrg9uivp++
	CsCMFz6wYqf8rau6JFR75WjnSs3kagF2Op2MBlwbcs/OaBVAVvc3uFPhlTW2dTjAvZAUKOWtcng
	edjik6+21Y3A9wzABQSg7MBWsOnHsNAumrGoKLHqafuRs+c0C/WHx/6ENeELKx4p+irgugBDXRX
	FP8KhXVJKcFLrJA0+hQBjkIKr0lsk=
X-Gm-Gg: Acq92OGV+ICHdydUqysx4yj35cF02qFPXJzEkOjDAPwC+qYbeO8MOPzZyqUogGoitvI
	qqJxrZbgbijCY49Kfou73OF6xcG9BZ+6AgbY9OAUkaSI2qBIx8Yiak+oSTddvHq72llzzlLmreC
	/c0Y4XK7uFPUZFnzS521He2biXE3138Oju64+E3cwx1Dre7YlRwq5EBkcLz7zIzyK4/UGtu+OFe
	ocDMzkPXqBu/SHIRWfWZg==
X-Received: by 2002:a05:6830:6734:b0:7e7:571:114e with SMTP id 46e09a7af769-7e784871fe1mr152182a34.20.1781221553614;
        Thu, 11 Jun 2026 16:45:53 -0700 (PDT)
X-Received: by 2002:a05:6830:6734:b0:7e7:571:114e with SMTP id
 46e09a7af769-7e784871fe1mr152160a34.20.1781221553208; Thu, 11 Jun 2026
 16:45:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260610193158.2614209-1-zhipingz@meta.com> <20260610193158.2614209-2-zhipingz@meta.com>
 <555912e9-818f-4906-a883-6f14e0790672@amd.com> <CAH3zFs2UeZfqm2M5tX5bBA6VRw2DjcyT45oGJJag5oT2WvKPJw@mail.gmail.com>
In-Reply-To: <CAH3zFs2UeZfqm2M5tX5bBA6VRw2DjcyT45oGJJag5oT2WvKPJw@mail.gmail.com>
From: Zhiping Zhang <zhipingz@meta.com>
Date: Thu, 11 Jun 2026 16:45:41 -0700
X-Gm-Features: AVVi8Cfn8yu04sl-GzuR397tWS6RCJ76opDbk_4XDQqGmuG536f9nq5T-lNoRa0
Message-ID: <CAH3zFs21OjkJtYKSqV5rjnEqOU=221LQLY2qXo9pMb79kRSQgQ@mail.gmail.com>
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
X-Proofpoint-ORIG-GUID: cOJ1Nv0SdmHxo2xpj1ZcAK00eitYeHw-
X-Proofpoint-GUID: cOJ1Nv0SdmHxo2xpj1ZcAK00eitYeHw-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDIzOCBTYWx0ZWRfX0IckoyAMqG5Q
 ETpOUrtQJ/uweWS9V0PWIYT1/WAM7OgIjYka33dgG3ffko+hXiJnfGcpmDAp2z8W7GHoxxKJ9fE
 +RQzRzH2HVl3QpdYKHDVurBE6bAsv3Imf0nqNlpIgbyDmP950+s4c8dJpoF71jMu5saveOy4+Nb
 2xBbl3xiy/LnqG5nAIta0cdxolruDoRSKDvlAC6dFZ6XDveWsPHOxugF+tqhkSm/2lGJcyb3if8
 XSD0+jjivYk3z2rZctFzML695b5GwJtkoVBCyGGm/llxIMGaFEsczOXilz1WvtWg7+sJ6ApS9BL
 rdUIuQiGamK1vD8pDZUucbqKVxzG1pcZqIM8BxIArDIFuQprwOMTck5DAgVg7jXX01MKqatxH03
 z+p8OzpqOVcPDSUirHfTOJkb/N8pdi+M3AO51I+p67YF01zNwzDRfLcRDHG4QHUjzHI0PhDuPed
 5tmU5XvpfbkRtTAZxHw==
X-Authority-Analysis: v=2.4 cv=L98theT8 c=1 sm=1 tr=0 ts=6a2b48b2 cx=c_pps
 a=z9lCQkyTxNhZyzAvolXo/A==:117 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=JnKecZnUtZousrUlYMGU:22
 a=VabnemYjAAAA:8 a=zd2uoN0lAAAA:8 a=iziE14hG8lcdKKJlCxoA:9 a=QEXdDO2ut3YA:10
 a=EyFUmsFV_t8cxB2kMr4A:22 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDIzOCBTYWx0ZWRfX0w2aEam5Z1nC
 Y77T2JO30fmiSJd99S/J9xTV9UOsGD1xgS467GuRWL2Ef1tvyGpA4CI5ZDg0T0NCQwrGzHX8Ya/
 XdwdrTHGHbUn95sPh6QBxC2SjpEAk0g=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_05,2026-06-11_01,2025-10-01_01

On Thu, Jun 11, 2026 at 3:53=E2=80=AFPM Zhiping Zhang <zhipingz@meta.com> w=
rote:
>
> On Thu, Jun 11, 2026 at 12:47=E2=80=AFAM Christian K=C3=B6nig
> <christian.koenig@amd.com> wrote:
> >
> > > >
> > On 6/10/26 21:31, Zhiping Zhang wrote:
> > > When the last reference to an ST table entry is dropped,
> > > mlx5_st_dealloc_index() removed the entry from idx_xa but leaked the
> > > backing mlx5_st_idx_data allocation. Repeated alloc/dealloc cycles
> > > therefore accumulate one struct mlx5_st_idx_data per cycle.
> > >
> > > Free idx_data after the xa_erase() so the lifetime of the bookkeeping
> > > struct matches the lifetime of the ST entry it tracks.
> > >
> > > Fixes: 888a7776f4fb ("net/mlx5: Add support for device steering tag")
> > > Signed-off-by: Zhiping Zhang <zhipingz@meta.com>
> >
> > Since this is an obvious bug fix I think it shouldn't be part of this p=
atch set and go upstream completely independent.
> >
> > Regards,
> > Christian.
> >
>
> Sure, Michael replied that he has made a patch to fix it, i will rebase o=
n top.

Never mind, it seems Michael's patch did not contain the fix, let me
submit a separate set.

Thanks,
Zhiping
