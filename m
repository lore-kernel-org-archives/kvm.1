Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE543AE190
	for <kvm@vger.kernel.org>; Thu, 24 Sep 2026 06:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790231112; cv=fail; b=KVB5S24Rd2Tm+b/CFubrW6Bw3FvnqXCJ06KxjyqtpJo7hzgNiaux1Pu7CmTpJk0gTCOyTAuxH2s5ndgbQ8W7toGluAgVmEOoqfGow5uh71vl6G6vKGDxJoMexoy2vyuV96Ncb6++4lroy73ftEw+R+D37VlPl2T3VJmHfo5fCW0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790231112; c=relaxed/simple;
	bh=dumiTwGbMEgraHXzScODaqcrl57xN/pkOOLYCcmVuK0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cs1iGCSLcAKfF0ATsQNUMGxxlOkPIL4z3zAShr9psGOWDNgkdVlN1L1jwPYn51biAm4vocd1N4M2KT93ehJaDDneOTmVPe0XU9liFQwy+PDH8pEGKvYlVYB59eGb4KgV0g7j4/QR9QenfpCMb/0NSVPjrckBevfcHexCV6y12KM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=kVpR4J2c; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="kVpR4J2c"
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68O5dRPW4191602
	for <kvm@vger.kernel.org>; Wed, 23 Sep 2026 23:25:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	pps82601-s2048-2026-q3; bh=dumiTwGbMEgraHXzScODaqcrl57xN/pkOOLYC
	cmVuK0=; b=kVpR4J2cMlHzqIDDgIwDNRJKn8dds0XKZoAj3OuhpAobjcceNl0Bu
	lbg5D+lbA8CbPmTwKFk7+P9ILanDRGAi05aIxnTFuZ43UVMM/4+qDIBkN6C9YRFG
	IHueetZOt54ETnH+qsE4FIKotfPKQDH8rt4NVkm1+3IL6jolTyEOLLwJmpBn0uju
	gZkmJJjhBdcR/w50XWF7pn04IJiaJvS+3p3s6euzs154NtYbjvGfGPrlSbJ7kNRv
	rLyGbzA42lxnnIsp7gJ8tDUTh1gq3l85Sch1Tuo75/IOWkwLClaKgleRjE3hVug1
	TUvXeAqjqctf8mUTc4IxwuMOWegiHDbEw==
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com [209.85.210.69])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4gv0wtw8vc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Wed, 23 Sep 2026 23:25:08 -0700 (PDT)
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-80491594629so1003088a34.1
        for <kvm@vger.kernel.org>; Wed, 23 Sep 2026 23:25:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790231108; cv=none;
        d=google.com; s=arc-20260327;
        b=PsoW//fNWED39olMRXH3DW3BWdvIGD580r/glx2XNffR/O64+KenZQMpJRcFXJ8kwV
         P4bF2eJmXnIDpK60xz9iNqRfdW7cOlkc9GyvQGrNFkJN+jfmebE1aK9YfsMNBpsINE8d
         OXrKuwTd1tpzLjdvq7429s/DJBVVNYJ0Olo9wr7H2jWSfK71yzHVjCOt+2J9c/bEWi0i
         Ct37chDjJWR3mPGCoH45QAvysqtmYngH7qOH6Fssl2xFoGb4Z3KAWKpMU1BDJPQol7nq
         nmlLvWVd60ugNLlpes4fnauUTZW5mPEvOt5HYWwxd58kT+WwVOjBSoo6Yy0fVfWnAS10
         buRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=RHSnVwj4ta4xwY4ZaPurv5a8QLd5HiVRVFjxaoUelIo=;
        fh=B+QftwIgLE3XIfVbbrfF7MvajmaKUylznKVUnriPZ6w=;
        b=Qop1gD7TNXuUOtu18VuYiOX6sCvPlLBR+itveNkvt+F3slWK30Yxv7+X4MqzMrzE2L
         qbQK2MM1+48GWVs/agEtcMJqsMtSFiCUQL4U4pGSxG0dUX4hcvwcxUqdaPgky9+59fhL
         z5RFKcuOqcgbI2z5QOf39DRbqdhoVyZ3IS3Yyjmjp3+IiYr7fPUB1/9Bj87XaTJR5MM8
         kG4PtWfTYWJ/268LLkQdIvKCIv6uoYnhvmHj8I3utRwAuBaiUJMmBqlL3EGaHe4/fNxW
         fLzMSxBbBecLxy8M/tdrj84l2QNMAzXByAyTRb++hZHPuMr4ngBG6xOF/7kyNPRmxwdZ
         x65Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790231108; x=1790835908;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RHSnVwj4ta4xwY4ZaPurv5a8QLd5HiVRVFjxaoUelIo=;
        b=unOC8WOvb/P0qnpyJJj2bzo6FENd5gY9CXWLTZRELdjH1o2orVlqZ1crhFysSLyYSq
         tvT7mIol2l1oN6Beu7ATU6sr8r77Pqps2k74mGxqZg5AmQ0V24TKpRJQX6pv/eCR0mXQ
         3x2OBc74HL0bdOR7L6N43CoD/HsZFIWLFvy5ALFuFueY+yV15kI5finsaSoqh6Wo5Qed
         eRQf3nR+Hx2naP2yZ8ZqsJEd6bOfsTey6N7vJgkxP+0flWhq9Byb6spViSL14MsJs2qn
         M9Rp1FhBj7u4XrHoHDSPUIvVujhLZG4o2gu8jNqmqhgBpNJ2k2OlGBoxmkpkyuMSitJK
         yFCA==
X-Forwarded-Encrypted: i=1; AKwUvBxk3yZdDU1+cBJ678nOzacPxrvuZuuQi1yozmXMXo1I44TLeQqfyKH0CV49GGjH+2sUL5w=@vger.kernel.org
X-Gm-Message-State: AFuF++kq26DZ3a2alwtbD5CTNV+94MHrx+fezZwgvfDbWLPY9mW/9lor
	FwC/V58oEqErXWQIP+2GTnc7rRQl3YzzM3bWK5SsecsqopBlAgp94qO7mAG8wNFIMwqmJvADT+s
	wcBzvOxy/KqA44mJ0SO4c18PtFuOd54vPYMX39aPwoPW+DzF0yE5B8e29q1s/BClztRQ1bKIJbY
	y24Fw2MwpnVcOwFJ9sRVZ2Q+EhRMA=
X-Gm-Gg: AYBFou2bOUvGl9gXxPV50NhMCybioFDFYW75p//FuFIE6vxxsH2WQWeVKeyzvsAyq0A
	FRYxFGesIe9fwsPvbR3k80qY5wtIKEO2Mh42XE3cEUDT5kKRdNyqUCr8nXa2d0F2vgt9Nv0LN5G
	maFwQ10sYQ8VvzMtehpPvqUf+RC5pFDiOMqjm973kU0Hagt5JsPMAeOZogYfPViW2Ll5gFwF8+U
	M/n3Cn3R+Zzpaai0AQ=
X-Received: by 2002:a05:6820:a07:b0:6bd:f79e:5022 with SMTP id 006d021491bc7-6d43f4b92f1mr1105072eaf.23.1790231108079;
        Wed, 23 Sep 2026 23:25:08 -0700 (PDT)
X-Received: by 2002:a05:6820:a07:b0:6bd:f79e:5022 with SMTP id
 006d021491bc7-6d43f4b92f1mr1105058eaf.23.1790231107597; Wed, 23 Sep 2026
 23:25:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260731211601.3033906-1-zhipingz@meta.com> <20260731211601.3033906-6-zhipingz@meta.com>
 <f4ff7ced-63b6-42e6-8e01-9f01d2e59843@huawei.com>
In-Reply-To: <f4ff7ced-63b6-42e6-8e01-9f01d2e59843@huawei.com>
From: Zhiping Zhang <zhipingz@meta.com>
Date: Wed, 23 Sep 2026 23:24:56 -0700
X-Gm-Features: AclHuK8ihUvHi9sCYY6U80mehJKIocBbXx4TYk849EeeC-OYipx5xqfc_idP75U
Message-ID: <CAH3zFs24esHCGA=wPrkiH8oKQCv7SnOwcBbkMxrOEvOVtwstYg@mail.gmail.com>
Subject: Re: [PATCH v13 5/5] RDMA/mlx5: get tph for p2p access when
 registering dma-buf mr
To: fengchengwen <fengchengwen@huawei.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        Michael Guralnik <michaelgur@nvidia.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian Konig <christian.koenig@amd.com>,
        Alex Williamson <alex@shazbot.org>,
        Bjorn Helgaas <bhelgaas@google.com>, kvm@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDAyNyBTYWx0ZWRfX/G/nS04r9BvD
 nhmsWLPEypEmHP+V+HkswN1ne/H3mCPHykIKKutfu3prRF3jhMGX+kJClqJaCgOh1MLBWgupa2p
 Ls6lodmHSL1BACwSrZT3o+vj2SYzJK3Cl4rh2FxrbHOvQWX0q455X66tLYw9mn6Fg3XTstWzzKp
 46OUjJe8oEo3P0Iq2UnuYRLfA4EMMUVFc3CiCKbHn7KKNDXphgDVk+voxol5Dr4VR0KDxaM0Gml
 5dunKkF1SWhfpo1rdiNoeE1jBKurYiqiUNF6WosO8Y7vKee71XyTeNZ2C7MEy4eDm05bUfEgbsO
 FWSOommwm2h032D2I/PQdQ4h304bHEutMNlGEqNK93VmtOVXok/X35g1dlmjsNRmee7UYx5Hs5w
 M8JUWJjzjMLcDKvefmN84R1xL+sy+/ogOLjw07CAh61/lJ8XQqbGS8ikAr5v7wMVJtJWvz1ZGhe
 postKBHBrVL9+465dHA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDAyNyBTYWx0ZWRfX6wZpqc04pQ5V
 /Qxnk/6ajB5Pyze/cgFblGA0OBeHSd7aMvPodLbm7JaWOMKdR5J7aXDWM9XR4V/oX1oyBOIhiKh
 C9pveljXw904iVz/kBvXofryUqFlLjs=
X-Authority-Analysis: v=2.4 cv=cK91IVeN c=1 sm=1 tr=0 ts=6ab4c244 cx=c_pps
 a=z9lCQkyTxNhZyzAvolXo/A==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=xtH7KyWI9dI7BmFOsl-x:22
 a=i0EeH86SAAAA:8 a=L1Z5B5hNzKdfmK81vbcA:9 a=QEXdDO2ut3YA:10
 a=EyFUmsFV_t8cxB2kMr4A:22
X-Proofpoint-ORIG-GUID: 4s04FBGlrm-B4gx6WevOyX_FP9vEZLdq
X-Proofpoint-GUID: 4s04FBGlrm-B4gx6WevOyX_FP9vEZLdq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_02,2026-09-21_02,2025-10-01_01

On Wed, Sep 23, 2026 at 6:13=E2=80=AFPM fengchengwen <fengchengwen@huawei.c=
om> wrote:
>
> >
> Hi Zhiping,
>
> On 8/1/2026 5:15 AM, Zhiping Zhang wrote:
> > Peer-to-peer DMA between a mlx5 NIC and a foreign PCIe endpoint
> > (typically a GPU or a vfio-pci passthrough device) traverses the host
> > PCIe fabric. The endpoint exporting the dma-buf knows which PCIe TLP
> > Processing Hint (TPH) Steering Tag yields the best placement for the
> > traffic it will sink: per-endpoint hint selection lets the root complex
> > or switch direct DMA to a specific cache slice / NUMA node, cutting
> > cross-socket snoop traffic and DRAM pressure under sustained p2p
> > workloads.
> >
> > Until now the mlx5 importer had no way to learn the exporter's chosen
> > ST tag, so dma-buf MRs were registered without TPH and ran with the
> > default (no-hint) routing. With dma_buf_get_pci_tph() in place this
> > patch wires up mlx5_ib to query that metadata at MR registration time
> > for p2p access and use it to program requester-side TPH on the outbound
> > mkey. If the exporter has no metadata, fall back to the existing
> > no-TPH path so behavior for non-TPH-aware exporters is unchanged.
>
>
> While working on v21 of the VFIO PCIe TPH series, we got review
> feedback that importers must add pci_p2pdma_distance() validation
> before retrieving ST values from a dma-buf.
>
> Your mlx5 patch follows the same importer pattern =E2=80=93 it consumes
> dma-buf TPH metadata. I think this patch should also include the
> same distance check.
>
> Thanks,
> Chengwen
>

Hi Chengwen,

I don't think this belongs in the importer. Every in-tree dma-buf
caller of pci_p2pdma_distance() is the exporter, in its .attach,
clearing attach->peer2peer -- amdgpu_dma_buf.c, xe_dma_buf.c,
habanalabs memory.c. There is no importer-side caller.

mlx5 also can't be one: pci_p2pdma_distance() takes the exporter's
struct pci_dev, and an importer only has a struct dma_buf. Reaching it
would mean introducing PCI types into the dma-buf core, which is what
Christian's ack on patch 3 rules out.

The routing check is already enforced by the core before any p2p DMA
can happen: vfio_pci_dma_buf_map() goes through
dma_buf_phys_vec_to_sgt(), which switches on
pci_p2pdma_map_type(provider, attach->dev) and fails -EINVAL on
PCI_P2PDMA_MAP_NOT_SUPPORTED -- the same calc_map_type_and_dist()
computation pci_p2pdma_distance() performs. An ST that mlx5 programmed
into the mkey cannot reach the wire unless that mapping has succeeded.

Thanks,
Zhiping
