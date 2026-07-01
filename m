Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39AB137DAAD
	for <kvm@vger.kernel.org>; Wed,  1 Jul 2026 17:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782928426; cv=pass; b=PoxkhL3oCg4BtDpAeP/geQBL8q/kKA6t7cTcpHlGTZ23TgARB44vq+FVDRQi2kk9K1cLn7zT1HoCeddTzpS74nAaIM3QXdkFbQ5/xyowNd6L0371yy72RASoOdvwOCUMM9Y2TN5bCfklr2SOCEA2o45QZwogmtDlGoNi/7mLMM8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782928426; c=relaxed/simple;
	bh=6RtQ4aX4MIiDBOUtFN4cE0U13b1ydyIimdMtAEGn2wg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jxygj+bmqtXMFg3/7EOpJu7CB1AuZ1l9c6m9eNG/Op1o+MEL9CLJ+ZORwRx8Wb584AI8INAb/4ZdZsgTe76v4novxBM0UxEqpfrbBHbD/Ya39RT64cTVTxLQrO9nR1H76fZNrnJyCAxKJ+5+NLNs51/llnRp77VymFEGy6Bs9kM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=te9NKp0K; arc=pass smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="te9NKp0K"
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 661GqLqc600642
	for <kvm@vger.kernel.org>; Wed, 1 Jul 2026 10:53:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=e7kmcvrJXFeA+SwUp+Q4JZ9GBs/Tu0VczqJ6zfGHtFQ=; b=te9NKp0KSuAB
	gJAStcqVmXyO90PdrOMhuz1QH+omYd4+Mw3B8TEdXPLJtkYQrsX/45BVNWyEblz+
	JCUQhK20eJ/NvICPYCtpkvbiKi0EHSaSmpoWEug8KslbHuTVqxo1Cyiq8npvWq8O
	iWJN4c+SNKe9prCgyypFFuDT+2fW//iCpWAfn5FZiHT3Ma+UfgQldfxu1JwL3wjT
	puoEMSaFB2J+gLTdLoKhlZdm4JHFAsQvSKn60MMl3h0pRepyXYCBK4DH/emUGdVP
	7d65A6CTugo700ojlRhKudPV6DZBXhMFm8x8LUWJmnAbgYzkzF4XYX6nodZkJ3HT
	F2Y7Da8ekA==
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com [209.85.210.71])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4f48n3x535-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Wed, 01 Jul 2026 10:53:38 -0700 (PDT)
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-7e7624e584dso1347167a34.2
        for <kvm@vger.kernel.org>; Wed, 01 Jul 2026 10:53:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782928418; cv=none;
        d=google.com; s=arc-20260327;
        b=hF0Dxg075Da8KhXEQnt58Ne1xrjAs9FKKBK54b4TtCSocT/EYmJ2AP/0vfQMtU9ZfF
         MhptbaQYkbFmWbro3njePzPYIpGfCsGwnfsPex4KasnPwp4Th6XJE4yfiwvvrLtpbfag
         beR9dGnx6TuGJ6kawpBiqdWqGkYtAbjGIEgQHwjG/WTVXLLsdQUOMIZ1bgLBgZO4WH8L
         MbKaokESWefD4NWD7RpVzm/IBsdDW3R2kk9ScNbqs7vE21Xu5Du/ZmWkv7l5Kk2vVhZK
         /eKGLAxIkm56+j3BRPxyzT6yQamoDHQ6VgO6C7yD6/ahbLOEw6wE5+IBL5LLrZyfw4we
         0/1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=e7kmcvrJXFeA+SwUp+Q4JZ9GBs/Tu0VczqJ6zfGHtFQ=;
        fh=otB2vlEUxIeixCycL9YcGAx14LdLYNjsWppH4fhHDa8=;
        b=dlY0bhNU6CmHblLr2nDxUZ1Il+yEmYJjqJX0UplJIyV7fEPU4cwKQkS5bPV1m0D2nA
         N20tOF7vbL2o+EDPNT3RPQ4W4/j3jVYMHKZ9hJq7eVvLkVXTfI3bUy9+Z06ZE8wwTOMV
         HVESb8uDp8tub2j1yGyeMF7AYq2zlEMPS61zVhU5zoCvEGquCV7RwA1I5gMbnCHDG3XU
         Y44uof8R+53pqyNNBbM54TDqwKU0ORYyzi8ffdZnst7DVgVWMvUMGE7iCVZmxGZIMU5W
         byguCmvSu1p5yUjJQxOraB/Rg0byyu+vMYH9GorNMlzQLfDm+HyLrestMopvo3W+DqDs
         YOow==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782928418; x=1783533218;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=e7kmcvrJXFeA+SwUp+Q4JZ9GBs/Tu0VczqJ6zfGHtFQ=;
        b=WZvtLpo+wJF2Fv9Hqq7MbkUf3pj5bRaqECY2nrEI7wqf9e1TmRlt2ad714lkQVnM5h
         g7HeOdOB3FnkZzLXKjFJm9MVhtDI9t5U3H3bj9LiJnI+H4hQSbBZKI2YWD5lVHy1xoxk
         RPb/yiVN8ocez7dzcOsq4omzfAH2EmqFGYTtlPtHYBLLl6bPfe7nkLr3Kv3uUYsp1i9F
         oLTNpwUTMdWnUnYbsDWPiWO4YNT8fvjtWa2yonhjukvEGDXQEN6XBwbAOTpcoFNWKgc5
         W1zL/eQzHGLmrJz7J9bs+LfhXXSmrTK09pyZCtnusp7obxK9c+4dBvt67rXVnc0VX+HF
         bVXA==
X-Forwarded-Encrypted: i=1; AFNElJ/cHwLe0Yj8fK5vxSje7wo6mMpV/Z9+7xmzMBNBbWS+27EfKGACqEQYQXulFyb5mGVwPuI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwU+Gq4k2s8flfz3zzdbI7tVOgi/f6JgYn7MsJSv39rpDAjMIjE
	HTHsYkKBU13Z8+QNOjoavhYLo4KGEX4sSJ+VjjMgu5I4svSnzziPG3hHwO+JqkhuUpajkmdczmE
	qHkFZSKiqBIht0qCrCnsV5fb4ba6g60oV2wUwPVn6bBZsyQSkqhPLriIEaWeDYUCe+EO5utR/Tm
	7KtVxB32lrSbxpRY4ETpGKIxYY4Yc=
X-Gm-Gg: AfdE7ck8bA7iLJFRoeZlLrSpQURo8x3PL3vQI7JgR5eZOGqURvnkAQUuARrzaAvkWzT
	ooo6iNV6KSU/yNXHGTn+HqNEN50HRrZ6HEeIY2J0UW8h104j/QdeI0WvfQRJbeNRpzWkbBjVUMi
	D7uDG5m9EXgyc1VbKpJkw23rc9GP4+Rp0qrYo/JllCk28sYSsvu4AEJbzme32IZAu+VymvIxCeE
	XyFp6JPJw==
X-Received: by 2002:a05:6830:348f:b0:7e7:62f:727e with SMTP id 46e09a7af769-7eb505175d6mr1172068a34.22.1782928417970;
        Wed, 01 Jul 2026 10:53:37 -0700 (PDT)
X-Received: by 2002:a05:6830:348f:b0:7e7:62f:727e with SMTP id
 46e09a7af769-7eb505175d6mr1172044a34.22.1782928417437; Wed, 01 Jul 2026
 10:53:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260630224328.3218796-1-zhipingz@meta.com> <20260630224328.3218796-3-zhipingz@meta.com>
 <e132eb91-554e-493f-9da2-aff5a538da6a@amd.com>
In-Reply-To: <e132eb91-554e-493f-9da2-aff5a538da6a@amd.com>
From: Zhiping Zhang <zhipingz@meta.com>
Date: Wed, 1 Jul 2026 10:53:26 -0700
X-Gm-Features: AVVi8CfUmWw3yG8Q376o8lxaFsAzKao0Cd3LEJcq9dJNu4sURoDLmPjujqACaso
Message-ID: <CAH3zFs2tkxA9w-oCr0N4ixe2VupXXQF-cA2o8-fToj6uFyuMJQ@mail.gmail.com>
Subject: Re: [PATCH v10 2/4] dma-buf: add optional get_pci_tph() callback
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        Michael Guralnik <michaelgur@nvidia.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Alex Williamson <alex@shazbot.org>,
        Bjorn Helgaas <bhelgaas@google.com>, kvm@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDE5MSBTYWx0ZWRfX1Vz1hQAfIekZ
 8ZP8f0+4BoQWkRfaJQEYYEz4eFCMrxUoC41d89D1bZnwBC58yHq8MKZFH/vnkBJamX/G6zv7bnF
 RiAE9bJAGRAelktrf7aeIxwiwaXRjCM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDE5MSBTYWx0ZWRfXw+q5aY1NshUU
 t+bFqWFpl4otM1tI+hKUfjHC8xONFxoXLU59urf9jlGeTImonZ8mzmWAF+yw+7dWWqzafilA6OA
 SS986Jtd0wZ0iJBMQ8ZZqI9xV3uY6SEZZbqZs7m680vKyIKoapzceakv52LNYge/FfqpMZBggwM
 NGcoTW132JmW7CtuITXcmtFe/XIZKlCXk4xmrQdSRMIA8vddtxqwVPZS+f8gr1EhcNNVFnfjIEU
 wVsENVFX02d/K4q18cxFIMUnWxHWcT3SS5qCi4G8Z6ztHRIxFFwW6xhoOu9nanFvUYStHtgMyNV
 sKancFYu4v8knOq7zgsOajrIeDCh8HjOtBSLFO2zwCJ/3D5nGzjatic1uahE282l6Za+xM2sl1n
 9X8jqF4a5Ez95nanRL6XrhKF3LwOS4pqSf7znb4R0W8mFG8h+yNI/S+iTrPysatHh9EdBV2FnaS
 h8RVxkfqg8akPxPJrhA==
X-Proofpoint-GUID: 64AS8TiyZ_3vlf2eWjyvTyyvstnbL2CM
X-Proofpoint-ORIG-GUID: 64AS8TiyZ_3vlf2eWjyvTyyvstnbL2CM
X-Authority-Analysis: v=2.4 cv=VOPtWdPX c=1 sm=1 tr=0 ts=6a455422 cx=c_pps
 a=OI0sxtj7PyCX9F1bxD/puw==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=03ozwUkBphtHgyqjj1sw:22
 a=I4J65MU22ScPYueRrkgA:9 a=QEXdDO2ut3YA:10 a=Z1Yy7GAxqfX1iEi80vsk:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_04,2026-06-26_01,2025-10-01_01

> > diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
> > index d504c636dc29..7a4c9b0d5dab 100644
> > --- a/drivers/dma-buf/dma-buf.c
> > +++ b/drivers/dma-buf/dma-buf.c
> > @@ -1144,6 +1144,31 @@ void dma_buf_unpin(struct dma_buf_attachment *at=
tach)
> >  }
> >  EXPORT_SYMBOL_NS_GPL(dma_buf_unpin, "DMA_BUF");
> >
> > +/**
> > + * dma_buf_get_pci_tph - Retrieve PCIe TLP Processing Hint (TPH) metad=
ata
> > + * @dmabuf: DMA buffer to query
> > + * @extended: false for 8-bit ST, true for 16-bit Extended ST
> > + * @steering_tag: returns the raw steering tag for the requested names=
pace
> > + * @ph: returns the TPH processing hint
> > + *
> > + * Wrapper for the optional &dma_buf_ops.get_pci_tph callback.
> > + *
> > + * Must be called with &dma_buf.resv held. Returns -EOPNOTSUPP if the
> > + * exporter does not implement the callback or has no metadata for the
> > + * requested namespace.
>
> Please add something like this:
>
> * The returned information is only valid till the next invalidate_mapping=
s() callback from the exporter and should be re-queried when a new mapping =
is created after invalidation.
>

Thanks, Will do in v11!

> Apart from that it looks good to me, but I still think we need some kind =
of example that this works for other DMA-buf users as well.
>
> Just demonstrating that this also works with some simple FPGA or similar =
PCIe endpoint should be sufficient.
>
> Regards,
> Christian.
>

On v10, I have validated a second importer: another vendor's NIC
(driver not upstream yet, so locally patched to
call dma_buf_get_pci_tph). A PCIe analyzer confirms the TLP steering
tag matches the exporter's for both mlx5/ConnectX-8
and this second NIC =E2=80=94 two unrelated importer drivers exercising the
API end-to-end.

Thanks,
Zhiping
