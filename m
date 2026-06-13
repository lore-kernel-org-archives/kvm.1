Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59AF2257845
	for <kvm@vger.kernel.org>; Sat, 13 Jun 2026 22:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781389386; cv=fail; b=Cz4PXjexAfP71buHHWoA4Q+G5fEmz3v6sHrpy5n/FOzQZ1XunR0aIxbG5GzT4UQcvbaJkxW8Lg1p5vsoj2MpF2GgJXprLhBxQD6OjZwb5X+4oLKApf+OqnznxEQNKjHIRwJAIS4RQgNGNXRjGq9spGbhCbtlt2duEY4TUYjIVqI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781389386; c=relaxed/simple;
	bh=7+UCwdV1ne49cq4fcMibRTQe+zHj7j8TUy7YJPYz0Rk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MQXzmB2+VlTSh8V3y78nj0vFQjk7S+jQO71we89WSf2bf+KtCZAb9BoRkFeLgNXF0dYt4PGGFUK1AC7OZhzmU2bm93NAADM2gPpMcbALa1hmUSnLxmmjGCC1ehQfLmuuV6ReJpHeoXMcv8bHBrAc20FSEfpHo6uCF+/pVRRjnQs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=RXC4frVr; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="RXC4frVr"
Received: from pps.filterd (m0528004.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65DKu3x21636630
	for <kvm@vger.kernel.org>; Sat, 13 Jun 2026 15:23:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=Jwd8bTapbEIKBMHRp+HoohnDcRxDUqI6nQwnmy5apkc=; b=RXC4frVrigul
	2+TPl69gny41YkeXpqOqbJD8TTbXSg8TLF3Mqa8gIyDAaPL1Ca9do2i2HlOHn+65
	CoxCrdgf9qWE8+7MbwigjUdDtdmp1AfYUyFCWoWend8LDbrYFB8tNlx+eS0wmY0e
	XBwyjB+KqTqOCrpMWoYa0NoDEtLtARehii4jUKwa9uklgqAWQAFaJ6LVMcE8YQM7
	alz+Qg7XmM00FAWye9ws7HX8pcHw0/UMPEsTvpByxH2Ie212YLkrrayKib69EdsZ
	UWVGo6QknIJteioPFD+o+4G2J5duEz4k2lDmocBu7Ml/04FaNl4K9dVPzKfy55Vh
	8w9vDSJ9BA==
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com [209.85.210.72])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4es26c2gvw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Sat, 13 Jun 2026 15:23:02 -0700 (PDT)
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-7e6b59d85dcso3707896a34.3
        for <kvm@vger.kernel.org>; Sat, 13 Jun 2026 15:23:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781389381; cv=none;
        d=google.com; s=arc-20240605;
        b=GQbZCt5tMmXHy7VFx16mfel/2oMd2JEW4r/ATR0Nm2/hVKHUjJnUFl0h+Xk84WgPDF
         joj4LEE4xLJYa47esLEgaObljxM6Noxs7UQlj86iRmb6eRjV4FmOJXB6A3tAOnSnNskJ
         3PWl6pXptsUNW778BfGK8Uxe4I/MS/3ADqPaXTwO57c4+38OxxTTtHerO4aaydtU6usx
         EJolqlh1pXoe3spDBqmS0TEuk1Jj5DnjuacbgfVMMMUgeBgrMc//BzFsSaWFl2SXpiUZ
         3/Z2uJ72htkf8KD1vCD84fJvcXzQCIIzW+zN2fIInDn5DVHhbvkLfFSOcXUSKj1jM6ye
         QvVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=h6kN9+j+P+sc+s3Q1KrZzNdCmFSiMsMf2TTL/GK/Pms=;
        fh=jXwe3sZhOhlWYPyE24qYChbk1ht55JPkGmqHaLe6AJ8=;
        b=j0V4cT4gt7iTZIhaCvXka4SX7I4ILWgNdBp6f8qIRenjPybEXDGHdq35TPegbzn/Ch
         IBADewB3Sx4A7o24rmUlYwpWnqELCdghdKgS+Jh6CCbZ7JGBqSLHoCSutg09h3EFkZcJ
         MmGTXQavUpY2QFeEZwQ5FQRcigRfwFAlL3wlipJFX7kHwGbrjo/KUUaKxh5+oEorOdol
         J1tUDbznFSORIICK3Q2q/O1Oi6pIVVwoRBUrA7/uISLeJs0+hmeV7SDSvx8GNrFSYAz0
         SHAH7IgRirwYoy1NPJucH+o5wUbz96lLmlLyeMtRP270BbumZSwQrlSFzV17U46iFriD
         F/ng==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781389381; x=1781994181;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=h6kN9+j+P+sc+s3Q1KrZzNdCmFSiMsMf2TTL/GK/Pms=;
        b=B7cVtFv3UDDoZJDN1dtTrYA29/dfEzA4qXhvN8nYWEw50oiYdbn9W8sALaj4YC7K94
         bizoGAwheP6LsxX+WoR05tJs7pYAezuYlTwppmQQryMrJSpJXeb7hzJQ0d4vAEiv5byY
         n0sndjv1gtIhuzBc+H613MnDWHQvuiadoiMiaP3+iOz78QWkYG9YEZUOdtSBvSNLEdvH
         lKrm9gxlmzKmNBXqMDyUb7zPREeNpa/2Y2zWBEdL5ZcNq+CdRWCHRIdA7U+waaSwtdmM
         Y88UT48NurTKBxxbHReHndAOa9GxVaNB7VcqZfIWoxsL+SXPpOQW8X0nYWieHyet062K
         clpA==
X-Forwarded-Encrypted: i=1; AFNElJ8Zk7I+2w54z9bDUQMhzPXzsVKYcCT5ebujBG0D8VOytsjf+oHgudQbeZ66f4BxG56D/nY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzco83kiy56hIPFZ1gpm4OxvXgaY4ycjmTuGdbWoFWecPM5vvUm
	ht2S8OhnLn0g/0EuIzvbWjaOrvvvN73rV9u3DuhNKh/JcdcoX2e/ui7I7YJlN7lsOTKxd110CFS
	VVS1KRS81NlFPOcasdgcfQr9FH6YWXi/JckeZz15PxAZ0dgBzlhIRkxIsVMsgwW4MSN8A1GuiPN
	Dwsi9eD+Mq7EXRZqnTnU4VWyFHbok=
X-Gm-Gg: Acq92OGa/fjrQn+DzBhmXBlJu6kwUVFT59R3AJTU3SdeZiWVq490HLB4+l+zWMC1aVL
	zNlHxyk/5gj4IutBMNFByZNwfkfd+0r48xLhDv7JyGgmisZ3wh4cqnEbL/qKEG59GpKUeoV/BvZ
	VFmL2c5wBIg8wci8RNuS6AuE0opGsR8XKzsbo68kD79GVW+uEbn8eP4k2tU23RJI7eXnmhM7b81
	mt3VOqq/BnHOpPkC/3zaA==
X-Received: by 2002:a05:6830:6b03:b0:7e7:16b9:e274 with SMTP id 46e09a7af769-7e7846b44b2mr6299911a34.8.1781389381583;
        Sat, 13 Jun 2026 15:23:01 -0700 (PDT)
X-Received: by 2002:a05:6830:6b03:b0:7e7:16b9:e274 with SMTP id
 46e09a7af769-7e7846b44b2mr6299886a34.8.1781389381161; Sat, 13 Jun 2026
 15:23:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260611161546.4075580-1-zhipingz@meta.com> <20260611161546.4075580-3-zhipingz@meta.com>
 <20260612105248.7d8431f2@shazbot.org>
In-Reply-To: <20260612105248.7d8431f2@shazbot.org>
From: Zhiping Zhang <zhipingz@meta.com>
Date: Sat, 13 Jun 2026 15:22:49 -0700
X-Gm-Features: AVVi8CfDNU1g_5HOJkneMc79yczUqiaSKei6CEAn7F8ZvFdakbFhyfrfCnrLCmw
Message-ID: <CAH3zFs0+zF2JQMpVZMM9ndh+07KE1ULQNOkKrLozWq+_kRdMyg@mail.gmail.com>
Subject: Re: [PATCH v7 2/5] PCI/TPH: Add requester/completer type helpers
To: Alex Williamson <alex@shazbot.org>
Cc: netdev@vger.kernel.org, kvm@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-pci@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: -xFjH2fJkY30PaC6YaHTAGoGYU344Jx9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEzMDIzNCBTYWx0ZWRfXyUHM0go3mKUN
 Tua/L3gEpYM0/m71zsG42yzo8jhkP8ZrDLrsMBOJP12FA6N93IMYzzfXIAARwmQd5SrvFzaWOL3
 QgO8lfEPUzjG30jSzoArBJ8UfF3aPcuDDEHhycRVtB8u8CbLmq9csp+Jv+aLIoTa+Z/qxFoLEpK
 N1Zx4+qnt1LFxCi1ZAzvKG9ReMOI/XHdAgAVHzFkk94pY99AcIq/CPXyjrddUi8uAf7DY6sHVPc
 wOaCqRlcj3FChK1HlAJr5/XTgTUooFE5cbjQIEQgjtKcYQfloiD6NLc8hm7SEfxvogX0DA6bcGA
 5u/0wXHcW0vvFtaKaabg9+MIPkzX1L+oUvGwMPo+6OFujA6BYkcHiPddKCNqcoC372ZAJXMn/hz
 qKmDYyOHZVI5GrFCG//kLm8Ak/5CaCJztgfef2dAx8oT41qa5wbq+rZbTI9vJJG8ZTBvd0qTI0J
 i3MNkEXr8sPfnDqR+OA==
X-Proofpoint-ORIG-GUID: -xFjH2fJkY30PaC6YaHTAGoGYU344Jx9
X-Authority-Analysis: v=2.4 cv=QpVuG1yd c=1 sm=1 tr=0 ts=6a2dd846 cx=c_pps
 a=+3WqYijBVYhDct2f5Fivkw==:117 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=GbPsI2Ihf5RTnMjR_gZv:22
 a=r1p2_3pzAAAA:8 a=VabnemYjAAAA:8 a=1XWaLZrsAAAA:8 a=JzgkHKIk_dV2mhMsj_sA:9
 a=QEXdDO2ut3YA:10 a=eYe2g0i6gJ5uXG_o6N4q:22 a=r_pkcD-q9-ctt7trBg_g:22
 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjEzMDIzNCBTYWx0ZWRfX04tSTfQI4RwJ
 ciVw0GP3Le/i+RGs0RYUrDjTsTobe4iyXjC/MBZRY9NNp+OlmC7me3XEZ0FPxORG9q4TcjnaASC
 elNDPjSqlRiKnW/GL3FA29A36QqzUb0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-13_04,2026-06-12_03,2025-10-01_01

On Fri, Jun 12, 2026 at 9:53=E2=80=AFAM Alex Williamson <alex@shazbot.org> =
wrote:
>
> >
> On Thu, 11 Jun 2026 09:11:17 -0700
> Zhiping Zhang <zhipingz@meta.com> wrote:
>
> > Add pcie_tph_enabled_req_type() so drivers can query the enabled TPH
> > requester mode without reaching into pci_dev internals.
> >
> > Add pcie_tph_completer_type() so drivers that publish TPH metadata for
> > a device acting as a completer can gate on the "TPH Completer
> > Supported" field of Device Capabilities 2 (bits 13:12,
> > PCI_EXP_DEVCAP2_TPH_COMP_MASK) rather than reusing requester-side
> > state. Fold the reserved 0b10 encoding into NONE so callers only see
> > the defined values.
> >
> > This keeps pci_dev::tph_req_type and the completer-capability decode
> > inside the PCI/TPH code and provides !CONFIG_PCIE_TPH stubs for
> > callers.
> >
> > Signed-off-by: Zhiping Zhang <zhipingz@meta.com>
> > Acked-by: Bjorn Helgaas <bhelgaas@google.com>
>
> This is carrying forward an ack for v6, where half the interface here
> was dropped and changed shape.  Thanks,
>
> Alex
>
Good catch, will drop in v8 and request from Bjorn on the new shape.
