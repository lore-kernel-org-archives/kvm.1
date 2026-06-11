Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 728943803EF
	for <kvm@vger.kernel.org>; Thu, 11 Jun 2026 23:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781219175; cv=fail; b=V4hJRGw/toKBrBEt5LcmUwI9Ia6/YDX05A08eTMjyehhKxdCwrPNAndq0cBEiKoqyYhNbphST8mr4Dp5BxOr6RySFbbwvzgGgxFhEWdJp9fms55RBxdjZVOGCxG32WtJ3F11XfqNbXsb5YHH2pq7R4pFGRJ2mvuGwP84/lqj0t0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781219175; c=relaxed/simple;
	bh=8tl/mJ3jeelSsPisncFYTPJxxSNwXHFa0O0MaGwSjBs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kSOp31irxiRBaiKW6c5YPchOZ/aTaO1EBb3S5FqQ0AM6LoUhIn6eHioTbAPrj1UcbcFbN/oiHhF6NmTdZ8QQbx+jDxJpz5dD7V0kByne5GtuhScGV+zJeJ8QcUnNk8cmTXptlLbsC45EOnN7AqaNxfMg0eOV+rlsbshaUxUQfdE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=aAliD7hP; arc=fail smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="aAliD7hP"
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65BLgkcu3194399
	for <kvm@vger.kernel.org>; Thu, 11 Jun 2026 16:06:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=efsnF3+1jWR8pvzMYJfBE7lVlQMbzzxbwMqOReRrznE=; b=aAliD7hP4Pnb
	sDHga9w9vOIaX4gPrLDH9CxWfUDul6tHQH4Xi0x95taVkfEY+GcuJ5llY9o7rdU/
	6IxhrOtNRPf0TZXzirIqsi4bvN0RdnQAebO3TXTwQ1ciy0nZK/Rpu2xM5w244SPJ
	RXgJk7lo9T1WisKqszJAd+5MNgI/KlpyBjNrdHxIF9RMJjY3r8Q959ivZHAEzgoG
	khu0ku8hPaoN7AYRRbn9WFZIlTuHEdyYgbXmb7kn2o0lgBqUwRaYgCIBG8ogF9SH
	Vazr4Xq0IrMxhXUedk59GhVrJIceY2weOoGa+2aM1YsFU9fskt3OQlTECK6T/8pJ
	mXSX9Zuhtw==
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4eqe7ds9t1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Thu, 11 Jun 2026 16:06:13 -0700 (PDT)
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-4865626337fso484564b6e.2
        for <kvm@vger.kernel.org>; Thu, 11 Jun 2026 16:06:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781219173; cv=none;
        d=google.com; s=arc-20240605;
        b=b2xrVNs70V3I5o39bJpLQd19+TanOEtIFEaTuxIeRe7GVHz7wnPzJOEvlW8o1ZIITl
         MZCvZSFSlgfM+S7TuTE7097yh4HI0PjC7EjEZS3ziEL1iv5FTv0twjH3gyhJUvmiJMig
         02JymGs4KWcTLfoc1gEUKciZhbvB3AaYK3w9YDG8HahDTSdPxwNBU5EoHR4VVvrugVpO
         Ju29TIojak+zGWgdH6iINOa1F1xPTkTL8mdW0EscFO4nRGyfESPTh2Ln3iqhgEjRFy5W
         evYmUuqQ1rrvmW9SZ25UX+PGRKQas1e9O1un8qo6sour+J4cFPIZbb/6xLxk3BFjwVXo
         HNhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=5o88lgTdR3UljadKJlYcq0XYptrmydXykEVU7qCr7g8=;
        fh=Y+KYivgtax/z85gVt76uyK1ORwE9fQMGlYAlHdz9B0Y=;
        b=Jx2x/E/x2gZ/4Y2xBq98Du7rk5XWLoC9ALXohhgJlqO4kLCoMcC9SzD4DiFdbYBAAF
         aCzYSSXCSPCQsOA/IUbgRv0SvyN1rglBMog660DBk74CLwFVLsLhEhjfBDoR413J+uR6
         kiBJtdN29T6Bh0myosrE0Wv6pgpJ9oqYSSGpm4tCTEHn0ijoOqAu3AkBFktdGqvTLG4Y
         gl0vD4gdRKeLA26hJ4g1zcUfG8fTRK1aC0iZnttox70E6DmI0cZxPQiIMXqkATbGgCAz
         UUkUecxDMmd4FVDtkra0oavndOLuok6toP8KLXxmGiUlofVV5uQWuOO5yvGj0h5+q9Sx
         0LWQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781219173; x=1781823973;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5o88lgTdR3UljadKJlYcq0XYptrmydXykEVU7qCr7g8=;
        b=Dc8Us4CjUDwoyCMyMTbaLFjCjR9pFw4a7HqXueEa04KTiKPLxqAJ8aeDGpT/UjEDH6
         GPvWfsVNAB87x0ff56cxYuNxTskzayTLG7znOTFDtC7Ylk34zuXrGycMudlHWgb3xT6w
         CPGfGM43M30lre+3RJ38ToHLxnNK+IRQSU1biaw43pTQuquvqqUKYjGAPOmJFGi7JShj
         0Vj3/ZeskLMNsK82jYBTHYNeF+TaKbMBaJ/heQPb7UDF6lsK8GVXIP1uyt16EBmQePdH
         1uvDGNbVpfAoG/q5ApTd6zEvNJ3FmjINmenRiGxTMvKBV0hMyXDZCjQtcKkPfpTQJnzX
         YVUw==
X-Gm-Message-State: AOJu0YzIlwSp3KSkWah0mxk6pCbgXYbc4E4HrVhDHbX/JWzNs4OkCVwD
	9eY0xQby5C8fqnbfeuZj1s+EdX2eEnZ7dDyBN0jbTI+dp5dQnGONILsti2Jexlpe+RRoUy64WFA
	W6RgIV3Y8hYDEWSH0DlSxK5qAy36L9YnWilqR99oKipAhM2uHeibNHisGVMMyWvXKA05bFtqAJf
	LWZetocemk0Cg9rlSIGRR1Z6RDd80=
X-Gm-Gg: Acq92OEeEw9q8B09b+Bgp4/56o8/HjIGORynbTDtxXNtRzVkqHWvjGZ92sIYnIN+LnY
	UoNUu0ULPrCfs9ryDeXrz+yL7Ebpy2wAy52f07LyCgWYE0xtn5YTbTxN/Ct4TwfhshFKnwlg0Lr
	RbW1IouGxC9lvvtZSwUYBH3RnBTZgg4y5zflGFvOPyLvTon/cdym7OoTxcgFWx+oY1LJ11dWWsV
	9Uo12Q046xgM5tW37V58g==
X-Received: by 2002:a05:6808:3089:b0:486:3498:d1ae with SMTP id 5614622812f47-4872f397045mr351963b6e.18.1781219173080;
        Thu, 11 Jun 2026 16:06:13 -0700 (PDT)
X-Received: by 2002:a05:6808:3089:b0:486:3498:d1ae with SMTP id
 5614622812f47-4872f397045mr351942b6e.18.1781219172624; Thu, 11 Jun 2026
 16:06:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260610193158.2614209-3-zhipingz@meta.com> <20260611202558.09C691F00A3A@smtp.kernel.org>
In-Reply-To: <20260611202558.09C691F00A3A@smtp.kernel.org>
From: Zhiping Zhang <zhipingz@meta.com>
Date: Thu, 11 Jun 2026 16:06:01 -0700
X-Gm-Features: AVVi8CeJj9q0ez37YfrPTO2KXyhyeT-bv8zCIdToMWZsgp_4cN-UqKdyKzNGj7A
Message-ID: <CAH3zFs24Gs6MSccrNoP-UmowvpcV8PmweegczKU7Ymq+kMtdxw@mail.gmail.com>
Subject: Re: [PATCH v7 2/5] PCI/TPH: Add requester/completer type helpers
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org, linux-pci@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: ZT6iv0Qnpdc5t1NcRnytFuTkNG-S7Yrg
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDIzMSBTYWx0ZWRfX3he/oOBwY3tU
 yFqNnahNfsobqpMhqsmej6XbEPgIg/K2+xXYWI2NJunIvpGZVwcqe7kRzJNsL5B5lTSYBzL5HlB
 DfYkpD7fn2NzN6qYAZ6mF1PaOFASDWk=
X-Authority-Analysis: v=2.4 cv=CeA4Irrl c=1 sm=1 tr=0 ts=6a2b3f65 cx=c_pps
 a=AKZTfHrQPB8q3CcvmcIuDA==:117 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=tpM8CJlwf7uhpglF1g9U:22
 a=VwQbUJbxAAAA:8 a=4OgE2WNpP8yww339eGMA:9 a=QEXdDO2ut3YA:10
 a=pF_qn-MSjDawc0seGVz6:22
X-Proofpoint-ORIG-GUID: ZT6iv0Qnpdc5t1NcRnytFuTkNG-S7Yrg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDIzMSBTYWx0ZWRfXwgKWa3sdnyDC
 8o9x1JfKq4Np3IrmG6Dqp1zosOZcSPgPHyUAPotCSy09hBUb8kTRZchlg9joNwzy4hn8LT8JWTO
 7g1an0etvu25kqY++qGk/bOA9gy/X6IibSCjhdrRQP8jAEcxJVPzsnWeV7X9BKY6U4oCRUCpkMG
 WBrFAaxVH/q12Sr3noGwzySkn5O5ioKAfuYz9t6PEu2XeU/6YbaZ+wh/SJilrog8W1SBMGERdP3
 FPfjMvxkn9ohwixbOtJ0b0o/5Xz3fFbRk/WPwxEs+piitTCgti2EuLAndcKV0uFsZ1hZVlcLtYV
 kvnIguDk95gj6PB9rG/bmMpa9vTffS3Z4jcTuve/XIm+FFsHz5vpu6QElWBXlozw63zrzBUQ/vL
 j8IOdpzanbAVwqQhi8hvAUFI+GkEBDGoSBShJmita4RBJpimGclnUwrYkqtHj9qdOS2lnjCDA/n
 PKcLOYkKAuE5brS3snQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_05,2026-06-11_01,2025-10-01_01

On Thu, Jun 11, 2026 at 1:26=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> >

> > diff --git a/drivers/pci/tph.c b/drivers/pci/tph.c
> > index 91145e8d9d951..4fe076bba953a 100644
> > --- a/drivers/pci/tph.c
> > +++ b/drivers/pci/tph.c
> [ ... ]
> > +u8 pcie_tph_completer_type(struct pci_dev *pdev)
> > +{
> > +     u32 reg;
> > +
> > +     if (pcie_capability_read_dword(pdev, PCI_EXP_DEVCAP2, &reg))
> > +             return PCI_EXP_DEVCAP2_TPH_COMP_NONE;
> > +
> > +     switch (FIELD_GET(PCI_EXP_DEVCAP2_TPH_COMP_MASK, reg)) {
>
> [Severity: Medium]
> If the device is hot-removed, pcie_capability_read_dword() returns succes=
s (0)
> but can leave reg as 0xFFFFFFFF (PCI_ERROR_RESPONSE due to master abort).
>

will fix this one with check like below before the switch statement:
 +     if (PCI_POSSIBLE_ERROR(reg))
 +             return PCI_EXP_DEVCAP2_TPH_COMP_NONE;
