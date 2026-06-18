Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFDC6331A7E
	for <kvm@vger.kernel.org>; Thu, 18 Jun 2026 06:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781763006; cv=fail; b=S2F26OueighnA5H8XqYTuvXTHpnvKa1MrluRlbxqbKUpsLns0MfhMwUNJLu2ltxdf0LFZuse3IqlaJvUOJa5JLfj6m8ruvyHUZ+nO/FcX2ymRVts0lhgn/Q+z9MfJS8pUleb5Hz6il0a7p1HjJ5FncaGSywbkSW0eub6bToAIwk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781763006; c=relaxed/simple;
	bh=6/T0Dclshlhmnc1UxrEhCEHM4cymDyecbTC6Ux8+uFA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dPIyHUXHNfNdorHc/GRLPRIXB6d97OCRzJUvQdKqyIdDOMx1sNxN+SN1J3JuV71FFcI6wui/o2JatU3hoMd9b+iyDt+NDOyaGfEY/jZAwCPboRNIsqmjUu8AEwdu5xq5Nze1OuAHj046UV3z3UtEN8LH8U4CojD7zaOF3DvS6jE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=v/PNqA1x; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="v/PNqA1x"
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65I39fVS1662230
	for <kvm@vger.kernel.org>; Wed, 17 Jun 2026 23:10:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=6/T0Dclshlhmnc1UxrEhCEHM4cymDyecbTC6Ux8+uFA=; b=v/PNqA1xBXvG
	hxasA0LzJ8yq94mP/vLG9ehEDNugAO22PhggvV4w6bqGrDNdz+I5GVtpeVimerEm
	uQBbADRTqFkt4j39n2wuBQO0TJMx0k/Ngsr/XypO3PKVRwiKmvh4Fej+Aga7MC9b
	SW5npdoy0mfJQ2gKUZm2NjxDs+U6T2IMmgYmFXjYTvdZIOpbnaLPBLLnoXNEvfc7
	iabwsALTLrmBCaTpNjhGZBs9JP2hcI6hMQgOEm5TRf/VAIkH5wj2q3y76PUcwfDQ
	7Jhe6K6dHnRe/0Myi50bJqPCe/2OBqPV5juk7YchPYXVwYkfOdTu4kMRyv7cWYYL
	TS+Mvy0faQ==
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com [209.85.210.69])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4eueg79upu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Wed, 17 Jun 2026 23:10:03 -0700 (PDT)
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-7e6d439842bso933894a34.0
        for <kvm@vger.kernel.org>; Wed, 17 Jun 2026 23:10:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781763003; cv=none;
        d=google.com; s=arc-20240605;
        b=byLipaxwoawfF00ELP+5xaf/ftrznI5DfswFTAw/fZa2QHMWZ9znzClscaPJ+uAQ6Q
         Y0HtN9sW9LqlAn0wOP2E8A8iRK8IzE8Z1UAzNZwk0bm5BB4jpzTC1In8CgT2WGnY665g
         Y1rkj86mR1SfEsMr9PTf54+kMA7nJ4xCNdqjCGEK80+OuFQGEmGpE40EoBxW46bL3MI0
         RxKQPcJeYpSR1gediWCMNx7CFkZXDkWQ/12G/No+MTuj/GPXIAGjmc1AKiIgGggO2s+j
         P0eZc3yy8DTBceb8L7iCe3+oFmvXIYmud2PDDGnkCPOcvnf1Zh5OwzV2F614enOY7uPO
         XAAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=zpTmQ37GmXWdpWUeDrqTjiaqwbJfjoWYHVp4s39Z4p0=;
        fh=daHX+gfrDqKfjCCH3UtorSCtJPdtlfxJZc1jlnBOiDs=;
        b=GOLVHBTAE2qY9p7DQp0l52wksSFZOdlyVs5Q+nAW8HuRw3yG+ZGF2qfB5vui35xdgP
         mHzSX+OCiDMxt2yCG4jPaUBYmg+VMxkUNOBSpPDmcN8QFV7FCpzkWQLCbkVz0AIPcUiZ
         qCeJaoUFWoigP90dzbjHX7UH/0rfo3R+SIZp9oKT7WF3FeeKEX3t+ZW4qorTKz8z3KDn
         yU1P71VtoFIZdpiInq+XzZ9+ZLgHrDTSnrOZwPfTkeMiiMCZT2kF1X/441kAdZrd9n+B
         5FIZFDbhjvFZCNlJjkMzJV3PGFcDzWH/le2ptjRFgrfqvKLeZ+KhA0R7/wzrBD+/dQBM
         xu7Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781763003; x=1782367803;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zpTmQ37GmXWdpWUeDrqTjiaqwbJfjoWYHVp4s39Z4p0=;
        b=cOPw0IU7SzzcPQ2hSS24gdybO7oiRnJ8YawnJVZDm9OD7fm1A6jm8HYSMBb8yI7pgs
         1RnphwMpLuGFqSYk5Og6JkTTxaHbKI4qxSnfgaBbl+4zxivk0Lk9Nso54hD7HzVL64xk
         kxLXez2MqscEMEMZt6JEK7oBuKP/NhWODIl0x5TxwLdxtpF12/5bUJx068hlw/zgrOPE
         m+cKgXiVK7SzSQjo+t2QyAyoq8XZj9dC+7RKtdZ2wl0YzfvyV5+fOWyu1+tPzg1JR0mG
         Ezp0twONqnsGev3DxIwswQwqf6xeILJPbvKUllHRo+gxzIVnF5p2JiAe9kovLFVVLBRi
         aOmA==
X-Forwarded-Encrypted: i=1; AFNElJ9bJCq4F8Pn7Xi0X6NGWNjGPWxCbFH505o2bhCU5VqOZNQIn2sbPfXbUy7ECFtPFuds8CA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmwDNHnmMpJzMDpHUY9DqjSJNGsGCN85b7fKB0EY96s3Ivutwa
	a5SpDXUNy7Y61CEr3DsfO/MwjDhwmXRkMC3wXIO8zh5yVti1iG7LxujPqauku/yz8OB/8lPFhuZ
	onkTWCZooCPkwS2IIzwnVE04oh20X5ma8rUoEGZW7zMnJUwH2Gzj1ByMb/EcMe7khIZr5pJe9aS
	sLWulZw6GU1R+OvoiysLltSg/uthY=
X-Gm-Gg: Acq92OFt/0CUqgmgee581P2aMZtci8Sq8VT1FVvbF1mNirjNjwOCqWYy4J5vlWhhX9E
	6+2iwLDrnXwzQVru8NtKzoqYqD2Dld9/pL8tm3B4CmfuD64QDhzPQ+OE6MyLSqniqg+EXaOuwU7
	+aXqvVCgyZco7ZmFVXkIzWjTgWZ7JnpmJY0pN17EGavmg4QG4pNJ15kdZaJt3dlXDvurmRe2VSb
	F8hONjgReTpkZNWH8ZzvQIsMJJzNw==
X-Received: by 2002:a05:6830:67f5:b0:7e7:57d8:a8c2 with SMTP id 46e09a7af769-7e90b3b9930mr6882350a34.12.1781763003228;
        Wed, 17 Jun 2026 23:10:03 -0700 (PDT)
X-Received: by 2002:a05:6830:67f5:b0:7e7:57d8:a8c2 with SMTP id
 46e09a7af769-7e90b3b9930mr6882279a34.12.1781763001909; Wed, 17 Jun 2026
 23:10:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260615065912.2177918-1-zhipingz@meta.com> <20260615065912.2177918-5-zhipingz@meta.com>
 <20260617092550.GT327369@unreal>
In-Reply-To: <20260617092550.GT327369@unreal>
From: Zhiping Zhang <zhipingz@meta.com>
Date: Wed, 17 Jun 2026 23:09:49 -0700
X-Gm-Features: AVVi8Cd9LqQxIAml-YNLrnCpxwyq6SYcSY7qEQ2JpeKmDJHK_hh3DSp6GvPOQmk
Message-ID: <CAH3zFs3xfc5k0fhgedCpNAfgfoAvfk0V2pF-xqA1_Q2sGkLnig@mail.gmail.com>
Subject: Re: [PATCH v8 4/4] RDMA/mlx5: get tph for p2p access when registering
 dma-buf mr
To: Leon Romanovsky <leon@kernel.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Michael Guralnik <michaelgur@nvidia.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian Konig <christian.koenig@amd.com>,
        Alex Williamson <alex@shazbot.org>,
        Bjorn Helgaas <bhelgaas@google.com>, kvm@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDA1NCBTYWx0ZWRfX5pZJsqOrSXdh
 /sugB7G6k1TkiaKgovqKj7BNJaBpZ3nk4nUyYVdkXiT2hh8NpyHRTDW0lIEgAR0FyiPmx1uYSH5
 ic0nkRcNw75tgrPtN8vVJHKZ/ckoT5k=
X-Authority-Analysis: v=2.4 cv=NZfWEWD4 c=1 sm=1 tr=0 ts=6a338bbb cx=c_pps
 a=z9lCQkyTxNhZyzAvolXo/A==:117 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=wpfVPzegXHpEFt3DAXn9:22
 a=VwQbUJbxAAAA:8 a=wthcJ2XvByERRjf4MtwA:9 a=QEXdDO2ut3YA:10
 a=EyFUmsFV_t8cxB2kMr4A:22
X-Proofpoint-GUID: AMufA95s2wojnLzKA9elMqaBWhOx5UuB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDA1NCBTYWx0ZWRfX6hUVR7mmkLtW
 zVRuhEqN+yIx4e6Y7Ev0B4IA2IeaFMjl1rT3FvfB8+z+XyCw0KQZIYI6YlFtLrrhj6qu9Wbn0P2
 3LmpO8LnkBGXMOMFw4DNv16f1CSonro+SrIszCkpLt3JrQlBQke1Y8nraMCGmgxTxd1y6rU+qjW
 1CePLQIuBFQ/HOqtZgzwqCX2Yn3r8CdJ2yDQcrxfNiF/L+YYpNwfodDNXSlsIigRQYBCN9hHSy7
 SJib77S9INERxbT0ELnFrAxwy27S/y7lEqWqYu+dq+iXgRiZJKFBOwoZnpgeqwAa3IxfnM+3ZhV
 2SDTCGq5wqOPcHr5deHwBTNtU2ZlKDzbs3S4MnXvtCffNOYeh5Gy/I3A+Ifz30adb3mvfubtTZj
 a8i3JMf7qCm0CboCZLGQgb0uwffNxFfejim6xDuLz1TAqZj8MXOGepfoaLStUeLLbIpbzzhgJCm
 OCE17EaUA/i4rTU5LpA==
X-Proofpoint-ORIG-GUID: AMufA95s2wojnLzKA9elMqaBWhOx5UuB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-17_02,2026-06-17_03,2025-10-01_01

On Wed, Jun 17, 2026 at 2:25=E2=80=AFAM Leon Romanovsky <leon@kernel.org> w=
rote:
>
> >
> On Sun, Jun 14, 2026 at 11:59:01PM -0700, Zhiping Zhang wrote:
> > Query dma-buf PCI TPH metadata when registering a dma-buf MR for
> > peer-to-peer access to a PCIe endpoint and use it to program
> > requester-side TPH on the outbound mkey. If the exporter has no
> > metadata, fall back to the existing no-TPH path.
> >
> > Use mlx5_st_alloc_index_by_tag() to translate exporter-provided
> > steering tags into local ST entries when table mode is active, and add
> > mlx5_st_get_index() for DMAH-backed flows that already carry an ST
> > index.
> >
> > For TPH-backed FRMRs, keep the extra ST-table reference tied to MR
> > lifetime rather than pooled mkey lifetime. Acquire the ref before MR
> > creation and release it again when the MR is returned to the pool or
> > the backing mkey is destroyed, while leaving the generic FRMR pool core
> > unchanged.
> >
> > Import the DMA_BUF namespace for the new dma_buf_get_pci_tph() call so
> > modular mlx5_ib builds link cleanly.
>
> The commit message explains *what* the patch does, but it lacks context on
> *why* the change is needed. The 'what' is mostly clear from reading the c=
ode;
> the important part missing here is the rationale behind the change.
>
> Thanks

Noted, will change the msg in the next version.

Thanks,
Zhiping
