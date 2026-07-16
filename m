Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 696B633F58E
	for <kvm@vger.kernel.org>; Thu, 16 Jul 2026 20:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784232554; cv=fail; b=u73mXG5oouJf4TbpWZ00GJmIeSJVfqa1jtQTycb3jcBTwbNSrXqAxEvaYoIgcnqKx7xSXShDYdcKTdkYTWTsuUU8XC2PvB5a1nlEffl0gzaWHXFbQ0Tsn1mtbHd/a9JoLoHHBedlJ6zoQlZ36cgnZW7RptKbHv54OKA9PXdoGbM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784232554; c=relaxed/simple;
	bh=fyZCLJIQW6xH8mOeeNx9UNPdCdkhruJNt4u6M+kl3Po=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UKyKzYBZArmYXKDfkax4Q3tb9HiYctSbM3rn+DBWJuBRebk1cMWu84t2c/uPxqusmhnVCoF6GKd3sPlLvDYsDq9ibFy2CFy2QL+cd9g5s4Mx/GziFi1NTBrG2oFyANwqznsxkqOl1HcK03EK6U4kcx9aMyLZ8dMpkLIxM5sNDgY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=G0tBoJWd; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="G0tBoJWd"
Received: from pps.filterd (m0528006.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66GJtxvY4009169
	for <kvm@vger.kernel.org>; Thu, 16 Jul 2026 13:09:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=fyZCLJIQW6xH8mOeeNx9UNPdCdkhruJNt4u6M+kl3Po=; b=G0tBoJWdvaDk
	Wz4me9U9EmzdxbVYlbLVAfjJCP27d6V5CRGhDCsQxHd1wC51VEIW5NDlLtPdhtid
	Y3QFaqMgURyUh0GfmaRtX7cvFRuYL/eUy7XWGSK3W1UnNuGcmMhoDVxFZhjVwFdj
	Y0SJW4IzIYBm2nOniFrlhPh4CgIXlUL6NYUYlHM5wq/J4bRwQDAxtQyQEQjDAlw2
	I9nTh3mwe1qX+xfUsDbEtUHrMMFEyBk5OmI7ZaemvGPdpXU1zn1/SUSGNVDz9JhF
	gyGozHXiVdrg4wtKnjIXepWNvHOqU/PxZvm4VTQ9a9r/fvoy4pXcJNqU6imFJJms
	GDfW2AvWUg==
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com [209.85.210.72])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4ff2wt1c71-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Thu, 16 Jul 2026 13:09:11 -0700 (PDT)
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-7eb711362a2so5157359a34.1
        for <kvm@vger.kernel.org>; Thu, 16 Jul 2026 13:09:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784232550; cv=none;
        d=google.com; s=arc-20260327;
        b=BuhPeLECOT5nVQ6nosbHlTen5BZACPufCR5t1qk9dB+5IAwbTPIQb3+328IjW2nsoZ
         bHRJ4rx7Lsnh4FIGC1aPlRJGWWlnqUPkQbUvXa/x4oX/d9OK7QvJ0l8WdpVIq5MUWzZE
         HvpnaP9LTkHnzb3RtW5iVtlUvhl1WDApLKHE3RWXb1B1xPyasBzjwiLvAIY5QHQhbFYr
         qSsCXbA+egfdnRRsBUr2lzt8VDEzLkYoE6YmnRxc0lEKA4aZJmjFg15ls+VJgEK1zQm5
         ZrjfS+44r+i07wWGjnEL7aMpZnf+fGylk3PeoKlmeqP4bWXswA9tqiUTmu+lZgmHy/Ug
         Kpng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=A/MBU9UxYJ0LTf7N8/pjvYID5QVas5vE3ImYU9370R0=;
        fh=Pb7b/Rbr7Xosft4h0aYnKN1DtNQx0gXSnooUkPSO0WA=;
        b=SeTS2HYtmzbQeXvWrf4FP6R7ZPekbCv514hAYvhQX89mgmXwTDP7v1wdRs7ZI0Nxlu
         RfCsnYnt5GDKmktgRavijUM7J/eZbhbAdFVZ+43P7tMjLdYmiAyBLftMSkiBJPosR5LG
         qlf54waqax9lg5gcpkItoZqigqbkQhwVr/JcMXQFSo08QmKhMCsrdmZnnU1c4cb3rrUI
         GCTK+s46ddMahQllOzcsykb4d+QiXnJ4H6H+Vxzf3lAHqgft6tgCzhThtu1vfUfTE8gi
         obm64s6eWv406PQlbtx9kbOg0SRQSpCx9/lfTC0o+mpo8S4uax87SCVzABlKfV6rTyit
         QEkQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784232550; x=1784837350;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=A/MBU9UxYJ0LTf7N8/pjvYID5QVas5vE3ImYU9370R0=;
        b=aAqR51Y+jJJlsMTXOD2R7LkU3vLb1lpqoj7+sdfQC7AyzCokSbkHJbqLByS16k0Tzg
         fwsFdJPur6EQOf3U6+kCdLcLzEOc1sf/3brpfbRZlEu11tk4C09eOT4xo2reVwMV68qF
         bdx8A2I+/4N+rOw9pFjAc1GWuu79LIAyLO9QwQ6rzRAXbXTvtzY8Ylmpwxd6KUwNbVIj
         YrYcT0O+3dY/ck//eN5Q+sFc+XtQCb74BU0Cun8R6znnssHlLBHpTXi67ukuIoJUjI9x
         qkkot4pmhiPfsha8bE25Qp0q7MuSR8M5wVCKmlUZgnIJsPqzemEl3zvX9XCzXvPZD7qR
         I9NA==
X-Forwarded-Encrypted: i=1; AHgh+RpucXJAOwxAVOwhG0cplWMOwvL9nHf1Cvw7IQU8Z2xpM8Dgf8HgCnWf1/I/otCW7VLbJE8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5wW/nJ0hWh07klAK19t0IgnK7EXy8pLp2rrVvQakUSnkJeSlY
	NeEmIVooywIIFIF6PlJePCz1+OeMAhwdqcNKtAlXpJmMnVvWHIIpmAjDz6ieQlW6L6yi+vSmVy9
	vmG2AxLcq/CZIP5zAzBF55RgXSNpQeT0sOLjHmT1GkHZlwtqgzEEpKNV2xFMgDPoJs8IV6U7luw
	r1tcE020J76bqFMsEyNruaeFB+mcE=
X-Gm-Gg: AfdE7cmYdJ6JbP3+fqBFmln18wCm/3pT+AUn7qohC7sLLTFC+kv9i23YkWvKaShoRik
	t5gLP0yKLDEcyNN6FPGWrOQcjIqFBx8hKJhoUBb1JEpvwCLyJweJTTioiHQeSGml/cAuyOOXKXH
	XNDtlNhRJfUf0inuHEYVONTT0sBCqRfTPDo5pRFF6yCwFNtLPfWfW/WMcdtbkJSRS+9qc+ten8W
	bv57AUQqPUxT906tbs=
X-Received: by 2002:a05:6830:6aeb:b0:7e9:cc39:2ef0 with SMTP id 46e09a7af769-7ec59cc5592mr5232590a34.18.1784232550369;
        Thu, 16 Jul 2026 13:09:10 -0700 (PDT)
X-Received: by 2002:a05:6830:6aeb:b0:7e9:cc39:2ef0 with SMTP id
 46e09a7af769-7ec59cc5592mr5232532a34.18.1784232549056; Thu, 16 Jul 2026
 13:09:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260715204008.3911275-1-zhipingz@meta.com> <7dd5c995-a23c-4d3a-9ba0-7fc77972339f@huawei.com>
In-Reply-To: <7dd5c995-a23c-4d3a-9ba0-7fc77972339f@huawei.com>
From: Zhiping Zhang <zhipingz@meta.com>
Date: Thu, 16 Jul 2026 13:08:58 -0700
X-Gm-Features: AUfX_mzMEcC_t0EX7NJOVZpINMLBmfJ4Fcr0yjX2dQzL33Xd9YvVjPxD4eAksO8
Message-ID: <CAH3zFs0Wbz5EYUMQArmUtT-jdAtisafw6e89RWKZJrJpipYQoA@mail.gmail.com>
Subject: Re: [PATCH v12 0/4] vfio/dma-buf: add TPH support for peer-to-peer access
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
X-Authority-Analysis: v=2.4 cv=HK7z0Itv c=1 sm=1 tr=0 ts=6a593a67 cx=c_pps
 a=+3WqYijBVYhDct2f5Fivkw==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=kkcUborcUVj0H7zxAXTl:22
 a=i0EeH86SAAAA:8 a=G4JgLt0UOHroHTRVxaYA:9 a=QEXdDO2ut3YA:10
 a=eYe2g0i6gJ5uXG_o6N4q:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDIwNiBTYWx0ZWRfXxqMori/UZ8gZ
 rggAKiTgPPfX5ITrJ3yVaQB9Z+yOcgO9sj21ZGKZEYj1ZYM+s2LAhO3q5U8PzvsP20KKwoFMt14
 CEP/67YLJ8Y/PqpumLRu1ItjxE8D5IQ=
X-Proofpoint-GUID: R6DC0HyKyI3EdhI-xAut6K7f_10H8vxK
X-Proofpoint-ORIG-GUID: R6DC0HyKyI3EdhI-xAut6K7f_10H8vxK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDIwNiBTYWx0ZWRfX7ZHQ9MuLoJHB
 KVLsK8nxqsTinjQw1GaeJbaSIjEcs3vE+AssMv7fuIeXZH1jER8YxGReJcdujOeZ8qVj+WKzLad
 SDcXne2EfA5TaBuUHv0r2+4FOXIMRYbEA75IOGhcKUQ4naNBZw0HMW9t43hDMZrIqpqH19CBXkg
 UZGWgdJC3cbmlT+bEkmUTdkktIeguekjNb5UkhNcTXwSjwpRI/eOIgMcdkuZFdOvc3ZszJel3s4
 X+rE6d3ZxHOj1vSekrhslzJwCcMCwiHmVEXd2PQJ7ZIh5NyaJRNHEzKT75LxyFucz3soR+oZ1b9
 AmSTz2TYy1/USN3pPIUhGrr2k3KAAO3wDOs07MIq7Tzid4vP5rhIFEoS51UkdiUkOucjfIsPwhE
 KZDjcfxpqjajGVgs0Qd68RP9g5q+aX+kUq7eikE184YxBIY0vn1mLIZ1WrMhc+5XzuX1vXM8tpI
 7DFkxuzXWr/9Vh/tEUw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_07,2026-07-15_02,2025-10-01_01

On Wed, Jul 15, 2026 at 6:07=E2=80=AFPM fengchengwen <fengchengwen@huawei.c=
om> wrote:
>
> >
> Hi Zhiping,
>
> One concern I'd like to raise is the implicit topology constraint of the
> TPH P2P path. TPH Steering Tag only works reliably when both importer and
> exporter devices sit under the same Root Port (or same TPH-aware switch).
>
> For cross-Root-Port P2P traffic (e.g. P2P devices located in different
> RC or even socket), most server-grade Root Complexes do not forward TPH
> prefixes through their internal routing. The ST field gets silently
> stripped before reaching the target device, so all TPH setup becomes
> ineffective with no error reported to user.
>
> Because cross-Root-Port P2P traffic with ST does not affect the host, but
> merely the completer may experience some performance degradation because
> it lacks the TPH hint. In this case, I suggest adding restrictions in the
> uAPI.
>
> A further step is to check whether the importer and exporter are under
> the same root port. However, this verification will cause the P2P TPH
> to be unsupported in the case of multi-host or multi-root PCIe switch.
>
> Thanks

Hi Fengcheng,

Agreed the RC may not preserve TPH across Root Ports (PCIe Base Spec
r6.4 =C2=A76.17.4 requires all intermediate routing elements to support
TPH, and cross-RP forwarding is optional/implementation-dependent, cf.
=C2=A72.2.10.4.2). But the uAPI can't gate it: there's no discoverable "TPH
routing" capability -- DevCap2[13:12] (r6.4 =C2=A77.5.3.15) describes the
completer, not P2P forwarding -- and a same-Root-Port check would
wrongly reject switch and multi-root topologies where ST does forward.

And it's harmless anyway: per r6.4 =C2=A72.2.7.1 an element without TPH
support ignores the TH bit and completes as if unhinted, so a stripped
ST just degrades to the non-TPH baseline.

Thanks,
Zhiping
