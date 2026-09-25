Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 294743B4EB6
	for <kvm@vger.kernel.org>; Fri, 25 Sep 2026 06:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790317092; cv=fail; b=RaDpkFr6QQl9uTMA+UXWKd9PsmBWqYg05w9BIkbMujfdbQc6mr3dAOo1e3XlmvnqMxiLElwKvTR5RohkDgMs/bBcxfxD74HpOrFvNJxCjejzwytBDM++wLAT7DMLGUCDOTQcuX5B4rd5fLRDNFh9Isir+genCYqsihpyo9M9r9U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790317092; c=relaxed/simple;
	bh=0AVGPwlCP/rKCizJXy2PxvsOo0tEzaFbIQ+vb3RNhAU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q6jfya+TCBtdrtKUkr8Bwzj1i8LYYFFGXhZgdKEhETLOCgK82tJvlRxxagSuSZ7bM6W2/UvRV7q91QdH41XEGUHKDDpMAvKj+a9fZcXRLNMUXW9wWjpvzzC8bkjUib8Y57dWGbmnfNC3hap3IERBOzJvXEd8+3SJ1XE5ewADJtY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=VfSJh7OB; arc=fail smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="VfSJh7OB"
Received: from pps.filterd (m0528008.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68P4YoKP2326917
	for <kvm@vger.kernel.org>; Thu, 24 Sep 2026 23:18:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	pps82601-s2048-2026-q3; bh=3WDgA1GYWRcpEGSy8oblmXJsMBCT00PLjmGyn
	aUkoWM=; b=VfSJh7OBvNbRoHKtuhy9uNErUyzn+eXZDk8BcC/sRvPHfo7UivGiP
	ay2EkQdik72AZ4/j3b9dO1FG2s9xbABwemWI/8eZnf7GYlLCfMsMveUicB9pesps
	pHVAdBkf03Cz/QMuoAkhwCADtF9iVETfdMMnafULPSVJy76Ix5dk+ZddV7s73A2Q
	TE3Diy1OC2LINh817TszuzJLVaJgSvFTRyPmtfbL7NTf5ymTr4Exg5n/swBTvdVB
	zbjF5jpGrPfzYsUCxpFMYCEXPmOLaMDPEQ3w0UXneN3pt1rS3WoC+mECEgewPE/g
	0caJ3yDapKjnQ76nm7CV8mod/GZ19creQ==
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com [209.85.210.69])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4gwa4vc5bh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Thu, 24 Sep 2026 23:18:10 -0700 (PDT)
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-8064fadbb1dso402135a34.0
        for <kvm@vger.kernel.org>; Thu, 24 Sep 2026 23:18:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790317089; cv=none;
        d=google.com; s=arc-20260327;
        b=QlPeAubf/rcelX2b5ywfGRqf9nznRjuXoEgZCU8b391BivdfhEZxYM6FUXQZlo3jnK
         tVcBGUL/9mtUc4hyBQqrCLzJlAB5EoD9O1dmThL/O0enXuKks59hoUf/hJRZB2dHDQDe
         9WXZ/IgFIqHeJEecPqPDjrAeyvroikLvzYJQ6f3b+yc43tRF3VMpvVo8cnTdxj48gvLU
         TUOOB5IkBgCXKwwEFs961/vIkEIeG+zMuhjotnZ0tZ7yhvV18Ka24JGAypltxDJdUmp1
         TN+gjJVoJQDOcVd9zhfQeZZjmNehlnGfC87A+qzwO7SIwKCqhRqNc2QvbBJDXt3dZ05f
         aGlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=WWSTTsacYSgu4KAWVY5Awo+LzcWeh9/1ap1jJZvGOTk=;
        fh=Ksrd6wj79wqItpsOh2sV9GVxZ74s6M/6wzCEa5xBdfE=;
        b=Kac6e8N0hkyMbFVzf4GzO5SkvJgJvUPDvWLU3N8rrbW2WOYErd7fcSkOK6bQ2nUpZM
         rFFfdndq1k3VCXyVLtpFqqcZf4iwrVZMx56GlmlVI5OSoweLb5EK2KEcldtYeBCTPxMG
         f4UU860oWCqBL42njNvzvLsxJqpmHG1cZMcWCLgbf/0jIBJ7Kdfk+n5GK9wfAaIxIP0V
         VGFKGKhx9zuXq1oJrEfEuLmR9ti9J0/4biuwZZRddXYm1YbyxI8mOrY38JUJzfwFhBRq
         xyBsM7U72vIchkvAvZsAmHW8ikTW+jLTPGFQzMf/Jyzs7J6MTTKATzdOYqRGHjVarBYv
         Ek8g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790317089; x=1790921889;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WWSTTsacYSgu4KAWVY5Awo+LzcWeh9/1ap1jJZvGOTk=;
        b=k2drcIP+PKkWlCyQr21E9rCubvQSXSV98FuMWVxBQ/HGO5PkgxzYauTmPwtmdMv6+4
         ixPwus2uO+Hf5os/vW+SZNY+xOqY66dr62AC9LC1fcOBuU8jxtBNcLisBNegWispgs6t
         50xnddIZwx+jQpdJt5OKEu1jbj9M7JutivXEY5U3ilQA6EpvhtzamZDZVBoQvmpcMn8K
         KuRd0zf08uL9Imvs7co/kHnHFhjErz1lp7XUtYDlomeZJBLNyRyaqqdkUhX4rSbvwcjJ
         wUCyzh0t+YfGx8IarHj9oWs+cuHXM8zjRvxGdaKJWdHUcGtlA4IcRRLVlSF1ovCIgc7x
         dByQ==
X-Forwarded-Encrypted: i=1; AKwUvBwPicDMIrEeCOoGCk0KcHwcsmxnUKcZwVBcm3zsdEZRj12rT6dugN0/prf6d554qSuAnKk=@vger.kernel.org
X-Gm-Message-State: AFuF++mso+0gTAAx16MBVBqb8d9pMI3WqzxuIrcAQrRuX1clgYCFdd6F
	NPOU72oQ8SLrFcX2OCe+CikBtGOR0NtHP1HMfcqVvZ43F4BHHX4sRwOW9o6DEx2JY7TRENzjqOg
	f6HzjO+/6WDKcqekcznPR4P5bcFeUcOljXf5MRFG3CuEgmnDpRSpOlfRM2fgdpA4rwVVeSSuC/m
	lEUQfNeDc773dvCh6p8/cR4BAVPbI=
X-Gm-Gg: AYBFou3rPlcsKVGH0T0i5ugPZqglYkHoWSZfKpmcfWmZAEWmgZT17Rl74YdREgbq/Js
	ABBZwv6vQ/J7CRF5g624NGo14J3JX+L84AOGA9tN3inKkG5U6+6lYPLlvh1DqA2urZxmoDk91/9
	htVj4HTt3wL3iWtYEVnPHedgfh4lZ5TUgWSMwvBCDrvN9NJzzCo98swjGn4RHtbKvMmtKy6ExpQ
	XwT4uhT03Xd2YamSrY=
X-Received: by 2002:a05:6830:82f9:b0:7fa:ab72:9e04 with SMTP id 46e09a7af769-81917b2db88mr973115a34.28.1790317089427;
        Thu, 24 Sep 2026 23:18:09 -0700 (PDT)
X-Received: by 2002:a05:6830:82f9:b0:7fa:ab72:9e04 with SMTP id
 46e09a7af769-81917b2db88mr973099a34.28.1790317088755; Thu, 24 Sep 2026
 23:18:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260731211601.3033906-1-zhipingz@meta.com> <20260731211601.3033906-6-zhipingz@meta.com>
 <f4ff7ced-63b6-42e6-8e01-9f01d2e59843@huawei.com> <CAH3zFs24esHCGA=wPrkiH8oKQCv7SnOwcBbkMxrOEvOVtwstYg@mail.gmail.com>
 <20260924233058.GA163130@ziepe.ca>
In-Reply-To: <20260924233058.GA163130@ziepe.ca>
From: Zhiping Zhang <zhipingz@meta.com>
Date: Thu, 24 Sep 2026 23:17:57 -0700
X-Gm-Features: AclHuK_a6wmm00-FfvYFNpJ3gDBJ82g8ChC1_PoUtBfo_Ku3z4dlkY61TNU4smg
Message-ID: <CAH3zFs2rhg6-b-pVDps1V8LsM4Dn48t4J4LFVyKOZtT4axdY=Q@mail.gmail.com>
Subject: Re: [PATCH v13 5/5] RDMA/mlx5: get tph for p2p access when
 registering dma-buf mr
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: fengchengwen <fengchengwen@huawei.com>, Leon Romanovsky <leon@kernel.org>,
        Michael Guralnik <michaelgur@nvidia.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian Konig <christian.koenig@amd.com>,
        Alex Williamson <alex@shazbot.org>,
        Bjorn Helgaas <bhelgaas@google.com>, kvm@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDAyNCBTYWx0ZWRfXzOxpWF364hR7
 pod6vFxOveUXwKkOK3uqOYtewDcaX7FmYWhJCnLVjNmX4YzWnN2u//8sPSopLwVl3YI9jz8EgQS
 f0Pt21VTzXMgsWv2HUXC70KNYOO4WZY=
X-Proofpoint-GUID: VrCu_kHAyk101T5Z7DMDC4mKv6wMy00F
X-Proofpoint-ORIG-GUID: VrCu_kHAyk101T5Z7DMDC4mKv6wMy00F
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDAyNCBTYWx0ZWRfX6RF/pQfEr6JE
 tBkclQ+qvNNoVO9aZWoutSrFvnSLwO7V9Z5WR5Op5dVg53A7ndF1sU4rqC23XOSiMR2GIkqpipI
 62KayvpCAKvdwaD7evErztByvh3+S+Hf7xmxJEnT36R3RzzvxJF4DSs/xTrq/Icmc4j4+WdW2Rb
 nx96LS7ZpxF10m5yuEMVYADy+o7uAFTAj9VtfTWh07DYJEnVjdb9i8tM+nRBhqHpsId7hXXFFyJ
 ZHC4r2RxFGfqz5ArIu3nfdLEnZtW8YTRYMiP8wTrzhTo04t2vd/y/tg/S1wBjKvR1DJ9TqcYapH
 cFfKMcx5Ni2T+26sNjD2zP+0sr6Q8mp43IDc946u3RSrR0v3RuRd45My/TP3ahqsmv8NgERobM1
 JS676AhlikmXZ4yNSAmWLLLen1MI1uO9YSKRjsTpMnidQruOruNBtOlP5zorq7RoL7DQGDBAKEF
 p38anpSDkB72fL8G85w==
X-Authority-Analysis: v=2.4 cv=B4AsQ+tM c=1 sm=1 tr=0 ts=6ab61222 cx=c_pps
 a=z9lCQkyTxNhZyzAvolXo/A==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=_1IyUuN4QrATX339ibzo:22
 a=9jRdOu3wAAAA:8 a=5X87G3sW8SDPY7NpsN4A:9 a=QEXdDO2ut3YA:10
 a=EyFUmsFV_t8cxB2kMr4A:22 a=ZE6KLimJVUuLrTuGpvhn:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_02,2026-09-21_02,2025-10-01_01

On Thu, Sep 24, 2026 at 4:31=E2=80=AFPM Jason Gunthorpe <jgg@ziepe.ca> wrot=
e:
>
> >
> On Wed, Sep 23, 2026 at 11:24:56PM -0700, Zhiping Zhang wrote:
> > I don't think this belongs in the importer. Every in-tree dma-buf
> > caller of pci_p2pdma_distance() is the exporter, in its .attach,
> > clearing attach->peer2peer -- amdgpu_dma_buf.c, xe_dma_buf.c,
> > habanalabs memory.c. There is no importer-side caller.
>
> Right, and they shouldn't be doing that, but it still has to be
> checked that the st is going directly to the peer device not the host
> bridge. Not using the distance, but by the PCI_P2PDMA_MAP_BUS_ADDR
> indication.
>
> I fear you will need some of Leon's series to make that happen.
>
> So probably the proposed change to dmabuf ops is far too simple.
>
> Jason

Hi Jason,

Thanks for the comments.

Agreed -- the tag should not be handed out unless the routing is
PCI_P2PDMA_MAP_BUS_ADDR. That can be enforced conservatively on 7.3
with two changes. I can fold both into patch 4.
```
In drivers/pci/p2pdma.c, make pci_p2pdma_map_type() callable from
tristate VFIO_PCI_CORE:

    EXPORT_SYMBOL_GPL(pci_p2pdma_map_type);

and in drivers/vfio/pci/vfio_pci_dmabuf.c,
vfio_pci_dma_buf_get_pci_tph() gains:

    struct dma_buf_attachment *attach;

    if (list_empty(&dmabuf->attachments))
        return -EOPNOTSUPP;

    list_for_each_entry(attach, &dmabuf->attachments, node)
        if (pci_p2pdma_map_type(priv->provider, attach->dev) !=3D
            PCI_P2PDMA_MAP_BUS_ADDR)
                return -EOPNOTSUPP;
```
For the query to succeed, every current attachment must therefore be
BUS_ADDR, and an empty list fails closed. The walk is protected by
dmabuf->resv, which vfio_pci_dma_buf_get_pci_tph() already asserts.
During initial registration, mlx5 treats -EOPNOTSUPP as no TPH and
registers a plain MR.

On the current behaviour, for the record:
PCI_P2PDMA_MAP_THRU_HOST_BRIDGE is a successful mapping path, so an ST
can currently be returned and programmed for host-bridge-routed
traffic. The mapping remains valid because TPH is advisory, but the ST
is interpreted in the root complex's own ST namespace rather than the
endpoint's; consequently, the endpoint's steering hint would be lost.
Returning -EOPNOTSUPP is therefore the honest answer when the route is
not
BUS_ADDR.

Two properties are worth stating explicitly:
 - The metadata and its callback are per-dmabuf, while routing is per
attachment, so this deliberately uses a conservative all-or-nothing
gate across the current attachments. It may withhold TPH from a direct
importer when another attachment is not BUS_ADDR, but it cannot return
a tag while any current attachment has a non-direct route. An importer
attaching later does not change an existing importer's route, and
future queries reevaluate the current attachment list.
 - I kept this on 7.3 rather than rebasing v14 onto Leon's unmerged
P2PDMA/ATS routing series. Any route that 7.3 does not report as
BUS_ADDR therefore falls back to no TPH. This keeps the set
self-contained on merged code and avoids queuing it behind another
series.

I plan to send v14 with these changes. Please let me know if you see
any issue with the implementation above.

Thanks,
Zhiping
