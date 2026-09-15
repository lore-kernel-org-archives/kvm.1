Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34AEE48032B
	for <kvm@vger.kernel.org>; Tue, 15 Sep 2026 23:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789514869; cv=fail; b=h/jXuFcEULHBNReFyxplYqmO+NU7tNPehahUeN3eNLhr269tgozmwkgCsLdT5Dq/Xo7/m6P93nYK4ylkv08pUl2eQrnbKeEyTf9cnFKFHVxykIrOk01UA3xp12LZ5SclIKq88LSF8T1IjolpDp2k36eyG1lNMBHsl4wgvYZCoyU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789514869; c=relaxed/simple;
	bh=660xTiVCFMGhryydhz3t8ZyEjYsku0AbA68go+LIyfs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kyT+Dh3J9cH6N22MhH3Zdj4aTonDPlu9AceETXtMjq6/rQb9A9bFmop6N+Q0emT3AkTo3veSJhwzxV4HzhcjSEbA6BIlq6gTzlXW34Fal/aNYw20Jf3F0ecg7fKt+rO/rNQ63BroschDrQUO7PQwUSoF/xkBvvD1uHGcDrXnyQY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=P7LdrCN5; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="P7LdrCN5"
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68FMOiKA1671135
	for <kvm@vger.kernel.org>; Tue, 15 Sep 2026 16:27:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	pps82601-s2048-2026-q3; bh=puTYzaznhw4+fIfX1uaMmGMJC1CZW9OyuJIqa
	VoOjFA=; b=P7LdrCN5RlHrQAwR3lh1Sw42HEUBPv6LyCl+r8hwB62t5uwriMQbD
	rm3NHwvD0PaefgR6OLHyroy5wHF4NVm+G4W63yP3NyZYHZWKoV3mbJ6JwD/WzgDa
	RCeXKORnF3xngXyoH0nHuBfJCW8zHXhDCn33h+JKiHawytHEapppS8dI22J6V2E6
	w+wP3sWCpYGwv46N0moEuenEzZJXV3cz3DJ4nWBpzrkR/rAXp/InbRpHQnm4a4Mq
	Krw1zm+PNYoHvCoper3L8ztW3x3PaHAyJrFmTd5OAYW7ZeVhs4ef8tPXRuwdBjYQ
	kousKyfTwk1c3s9n+5u7EB3H7XOriOxrw==
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com [209.85.210.70])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4gptaqrj34-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Tue, 15 Sep 2026 16:27:46 -0700 (PDT)
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-8056a93e0e3so6885780a34.1
        for <kvm@vger.kernel.org>; Tue, 15 Sep 2026 16:27:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789514866; cv=none;
        d=google.com; s=arc-20260327;
        b=kxB6hDKTNZ8Y7hBVHz8dbp4Cuhnl4voqNxDBAKnj2thVhF9Kp3YLCSn9Qpf8imOMlu
         lwqLEYQ+CR8PoL0OQ/EqAeefBmWYOC35+sflm4XSrMtZNpQmv73dtsaM0AYcUJHsjAb1
         UfLTj8TgIt6XQjdqZUJorPKPoN0LjfAtuCd5UgLvndiONJJT0LlUBVsiFlo139MokPhf
         1XRKu96psjfyqxKlsx6VpqOf97GORTFsl5JHXyvwr38kigtX2mQEQLb7MDtafsN9OSVe
         CyzSXG/Ck3CER/bJEf/dZKOroLptk/VLVvC61HIettGCV8ChEPcUmDRpzOQtMV4Npxet
         rM0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=SJKC0cK2PwsxosA12SybEYsbNkrOGaDMLHL+9hzWLps=;
        fh=eB5y29HvSpkMrY7/PYHDVzXQhcb3xwuNP0+fVQoV6c8=;
        b=Pd6OSx3yEowVZVOppv33fFNK586AL5gv1n7r1kjKG4HZeK8tUsLi3ueonkHEbg2Jx+
         JKPGlY4hP7/1yXk3eyPlPuU/rFSXJmt4cvvFyh6H8M9t3KrXzo+++tH3oocI16CTdFnV
         MS+IbmdFJgdSBmNuki0xjjR16l7FKdmYbtXnq7NjV4pOAMSaYbCQRpUBgpAcvpIVF9Zj
         A2isZUp9vGYGg6ufGLE/+oeQlgVC2YMtetUNdn9qBl8luaRZ1boXbifpal6iDXw34Xvx
         NzrmueAph9mP050FKKGK11z2wPsnR42nVRI7cA5o2SODNhxRwUcr/gdYQqHu/1Orhb/9
         Zyng==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789514866; x=1790119666;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SJKC0cK2PwsxosA12SybEYsbNkrOGaDMLHL+9hzWLps=;
        b=20xRyxyYF9A8RKzQlGZcmhymiCy+kuS0DkINEKVsd7xymZNoEhnEJS9e7N8b5RxD6H
         Wub0NG2YRGoXvEHQW6qXXqaGtXr6V1w6JDXqY9GkOD+qoNRAE4k6eQF01A9QOo4y/vZ/
         7QqYmRpGf4R0qpPF4+J0870PkynoxO5Xrbi2J2OkneXS3aKgs3UVYoL3HNxnj69sj/Ws
         8+jdYtTAwhxrdlLLvQ4YP2mO5yG52hY9hKMywc/c/+aQyonol5Uc6uYIwGNTehBSfTGB
         /2zUnSY4i6zfDSgqmHAaL8wumiKxdI7nTtUDlFXnzDFTKZYj4+oDKypJYB7wV6IY5lVm
         AvZQ==
X-Forwarded-Encrypted: i=1; AKwUvBxKTihFXnzVoEN+jKQmSXgg5MMLXmdHmJrznZA9qHflwhk0lu+uZBv5PU7pg+0waSrPjDQ=@vger.kernel.org
X-Gm-Message-State: AFuF++l5aq7zMBsZTWPhrsBWS7P9lxrj1UkFjMfYzKhshOYA7rY31Pi+
	6BA7zABPBJMPawyGsJwo/npB3hBYF5Ye1l/3O/3w8a2le4RxXVgfOtU+BrMhvQun4SoyuvBotCM
	hccpx3wS6W2xEGSjJttt7qVTlDVObKRu3aS0WojNTVMxFkZQn/XcxHHS8crxQU3Ch4bj52n5eAC
	J7s7JTzRl982TZWCQSrG8neCRaHyU=
X-Gm-Gg: AYBFou2EMuL6tN8Tkdhf0rcg0hGfV793ECNhzFL72tjWIxsYJoVDDpON2Q2PprU1b17
	Td+9jNgbjgnjaVgZC8mlMaDU5lLxsM0+M8v4wInDyx73pPYQGWbotaVWI5fog8ka7A3MO7uO/lj
	aVaXdRPHVLAfIwlmYBiGIkHefyTWXTL4dpdaHB0pzoAuu/kEQE1zEP8m1scfbgp+uDOxVjS9eJ
X-Received: by 2002:a05:6830:6602:b0:806:75db:bb32 with SMTP id 46e09a7af769-80b2df3d962mr1439105a34.9.1789514866344;
        Tue, 15 Sep 2026 16:27:46 -0700 (PDT)
X-Received: by 2002:a05:6830:6602:b0:806:75db:bb32 with SMTP id
 46e09a7af769-80b2df3d962mr1439055a34.9.1789514865867; Tue, 15 Sep 2026
 16:27:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260731211601.3033906-3-zhipingz@meta.com> <20260915222303.GA877199@bhelgaas>
In-Reply-To: <20260915222303.GA877199@bhelgaas>
From: Zhiping Zhang <zhipingz@meta.com>
Date: Tue, 15 Sep 2026 16:27:34 -0700
X-Gm-Features: AcwNN1Ur2HGTwLfzS3v5GCfBM43O6loZu_h11eJ9ffO6Ol-LlJuiRokJ9Mq3XW4
Message-ID: <CAH3zFs1hpotRvvTziNhSSNR1fLiFekSAMCA7oKsNJbobgeckRw@mail.gmail.com>
Subject: Re: [PATCH v13 2/5] PCI/TPH: Add requester/completer type helpers
To: Bjorn Helgaas <helgaas@kernel.org>
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
X-Proofpoint-GUID: K8ccRMnZp7bZ6LPVInXhnlrdi45XIwZG
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE1MDM0MyBTYWx0ZWRfXxZ+l4R7O8Nsw
 xeS4lIgfFtMRg9lgtnnYr4ZAlpUY9ztzv9/x1Cum7JFFkl5Huk4JXN8tKMlTxQvZ8ntv5gjHBQu
 v/VBteJ2lkykGp16gS9KxnPcKFtNFto=
X-Proofpoint-ORIG-GUID: K8ccRMnZp7bZ6LPVInXhnlrdi45XIwZG
X-Authority-Analysis: v=2.4 cv=dt9OmFg4 c=1 sm=1 tr=0 ts=6aa9d472 cx=c_pps
 a=7uPEO8VhqeOX8vTJ3z8K6Q==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=xtH7KyWI9dI7BmFOsl-x:22
 a=VwQbUJbxAAAA:8 a=VabnemYjAAAA:8 a=1XWaLZrsAAAA:8 a=B6l6obb3YNMg1WPjzLYA:9
 a=QEXdDO2ut3YA:10 a=EXS-LbY8YePsIyqnH6vw:22 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE1MDM0MyBTYWx0ZWRfXyhUNuZcPiY+A
 XsAiJn9ccS6JiTAN3ysCST86e0l0xRqXCId7krYji9JM4lVM1dkE6bPx3yF4Qe9BkxngKko5in2
 4NDZ90qY5e3Ke5jdvNPHBG3jGn91xUfXHb400YApohehv6jvtJV3enwpFPxDAcXkv6UcpcFFFK8
 +J2D5rHyxsQFoQlVuWO2b9jiiPZZ1BrHpLLeiCP0fXPe9VJGyyWanJ5OrwBnfXdmzKfBEwwGczE
 F2o8tGSEDL8+fMrKOMEUCfezEaa2WAihHpSThxPHhCzyCfDPdiH7glsBpFNTnxdsBVYcXB6Bb9T
 4uihEgG47Qkc137YnQCGeVYKGZvOp6tES391s+tXAGbyH28MGjo5Q/5pXw4/fgCAhWzrtBKtTGD
 bflwOxDejPbc4a2BW+4C3Vs3ClOuoPajs1LGsMweU5jOHekWIuvCFtpmWIGqLmIBp35JQm9kREE
 rMnIfiLbyrganyJ8ipg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_05,2026-09-15_02,2025-10-01_01

On Tue, Sep 15, 2026 at 3:23=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.org> =
wrote:
>
> >
> On Fri, Jul 31, 2026 at 02:15:49PM -0700, Zhiping Zhang wrote:
> > Add pcie_tph_enabled_req_type() so drivers can query the enabled TPH
> > requester mode without reaching into pci_dev internals.
> >
> > Add pcie_tph_completer_type() so drivers that publish TPH metadata for a
> > device acting as a completer can gate on the "TPH Completer Supported"
> > field of Device Capabilities 2 (bits 13:12, PCI_EXP_DEVCAP2_TPH_COMP_MA=
SK)
> > rather than reusing requester-side state. It applies the same reserved-
> > encoding fold as get_rp_completer_type(), inlined, so the reserved 0b10
> > value never reaches callers.
> >
> > This keeps pci_dev::tph_req_type and the completer-capability decode
> > inside the PCI/TPH code and provides !CONFIG_PCIE_TPH stubs for callers.
> >
> > Signed-off-by: Zhiping Zhang <zhipingz@meta.com>
>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
>
> > ---
> >  drivers/pci/tph.c       | 44 +++++++++++++++++++++++++++++++++++++++++
> >  include/linux/pci-tph.h |  8 ++++++++
> >  2 files changed, 52 insertions(+)
> >
> > diff --git a/drivers/pci/tph.c b/drivers/pci/tph.c
> > index 5cbb381e2a02..d0202ff7a1b2 100644
> > --- a/drivers/pci/tph.c
> > +++ b/drivers/pci/tph.c
> > @@ -223,6 +223,50 @@ static u8 get_rp_completer_type(struct pci_dev *pd=
ev)
> >       return PCI_EXP_DEVCAP2_TPH_COMP_NONE;
> >  }
> >
> > +/**
> > + * pcie_tph_enabled_req_type - Return the device's enabled TPH request=
er type
> > + * @pdev: PCI device to query
> > + *
> > + * Return: PCI_TPH_REQ_DISABLE, PCI_TPH_REQ_TPH_ONLY or PCI_TPH_REQ_EX=
T_TPH.
> > + */
> > +u8 pcie_tph_enabled_req_type(struct pci_dev *pdev)
> > +{
> > +     return pdev->tph_req_type;
> > +}
> > +EXPORT_SYMBOL(pcie_tph_enabled_req_type);
> > +
> > +/**
> > + * pcie_tph_completer_type - Return the device's TPH Completer support
> > + * @pdev: PCI device to query
> > + *
> > + * Reads the "TPH Completer Supported" field (bits 13:12) of Device
>
> s/Reads/Read/ to match other doc ("Return ... type" above, "Write tag" be=
low)
>
> > + * Capabilities 2. The reserved 0b10 encoding is folded into
> > + * "not supported" so callers only need to compare against the three
> > + * defined values.
>
> s/The reserved 0b10 encoding is folded/Fold reserved 0b10 encoding/
>

Thanks Bjorn for the ack. I'll incorporate both wording fixes in v14.
The kernel-doc becomes:

/**
 * pcie_tph_completer_type - Return the device's TPH Completer support
 * @pdev: PCI device to query
 *
 * Read the "TPH Completer Supported" field (bits 13:12) of Device
 * Capabilities 2. Fold reserved 0b10 encoding into "not supported" so
 * callers only need to compare against the three defined values.
 *
 * Return: one of %PCI_EXP_DEVCAP2_TPH_COMP_NONE,
 *         %PCI_EXP_DEVCAP2_TPH_COMP_TPH_ONLY or
 *         %PCI_EXP_DEVCAP2_TPH_COMP_EXT_TPH.
 */

  Thanks,
  Zhiping
