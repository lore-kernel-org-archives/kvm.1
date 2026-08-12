Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83ECD435514
	for <kvm@vger.kernel.org>; Wed, 12 Aug 2026 15:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786547761; cv=none; b=XP1Bn8A/K24Q7ekU2NKjtrNsKRzygr9PeHetkpjR0EV3ZLYeqCEsf5AAc000yhMTIi4bOs0cE5hkFJQ3unqFGkccE4SKrmFu7PaC/GlRExM6uqXpCp38y9TQHeqWDjBBAHeCatsnf1QKTl9vEMEfVoaI66uTw2+UPm3OCCHYssY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786547761; c=relaxed/simple;
	bh=U2G5S1kTFIH8tXKuK0u+pk+jwp/6jWSIKAU/olOPQ20=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hhyohdPcQzi92Ny30Hdz48KABObh89sOUhcrWsVsAJzvxPJt6VH69Z102/YuzvpQuiAixJcdee3gIbDYNdnP2fY+iNim7Kblb8ME+ZyaYKSDqWMvRloJjHUzGMFrwkBy2pL6KXn3QKWcYR+XoI3hfXMF8hpVZ4tvHBleLtVt33Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Rhf9ziCg; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=It4hp1xh; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Rhf9ziCg";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="It4hp1xh"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67CDbhAF3641682
	for <kvm@vger.kernel.org>; Wed, 12 Aug 2026 15:15:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	BdfscUOJ1exQbIKDJO8Fdd9Yw+KSm+j+ja1ZpjtoaZc=; b=Rhf9ziCgbuGgAjf6
	6XH8dPfZdROJ5mpiII5EEFdiWfDJSY4OJuVovU8xIbQ87dIyHKzdk8jLZJD+Tnas
	WvqrlGhcPaJ8P9VkyB3oc27yObN05xn+NiQuYSbyhII4DkG6lS9zWKApbgpqo0jM
	GGrrE9wpQYBsS4WLcYBK//u7CyBirG8hg0sPr+8sAyVExQmlXKbY8n2CHwRoq0HB
	Me/hOHO6+FQ5nO/pZTsQQHQtlep0bpCc7F6Of6Zjwgy+3gETBp18DTxLRCbQP0w9
	m7TuIoHDUPaniwDQqjQSoSzGlp5p7EAQ2+x8JFFLXD7Eo91N/vkhril/nMB+cHwK
	nDbSqA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g0p3d1fhe-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Wed, 12 Aug 2026 15:15:57 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2cea6a46766so16276025ad.0
        for <kvm@vger.kernel.org>; Wed, 12 Aug 2026 08:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786547756; x=1787152556; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BdfscUOJ1exQbIKDJO8Fdd9Yw+KSm+j+ja1ZpjtoaZc=;
        b=It4hp1xhosodliDb3+ijKjwOr3KXm4enNqAGVR64+SqQ5C4enHbDcoj5kgkkC13DUk
         qSP8ExawrdY0DGJKdWVlgdSrI5sjkO0fUtZJ+O0Tu+VZkgvAGcV/m+COs7UC4PYU2OJw
         Oq+Q0+XNzs8aIGXRVktxtqIOD9I+MMwBE59IEwfVQ7jPWd3QHb8dQmiPDd1xBb/gtX0t
         9M0vUbRUanxfUW2/Bcvfs96iZgNZHJUvqnpHnCvyZu90x0/zhRnx2qZ6IbbrZIS/82ss
         Fj1oCIPFsLkDUvMGfGhM9VGg5O4FB8RIobZLJh95ktlnHCinyP57WhS5+Oqye/V5Fd2F
         8dMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786547756; x=1787152556;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:subject:cc:to:from:message-id:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BdfscUOJ1exQbIKDJO8Fdd9Yw+KSm+j+ja1ZpjtoaZc=;
        b=MnJGHzPXcuUZHhSIEWGwfvjZE4iubI2jmIOgvz29LoSqWpTEWQaIvvPIm8VHCpNvCR
         Ywx+H7+7zbcxwZ46XBF497w4UeJo2Aqt8qyg9sm4RgU8S4zX0s/9654XXigR93tBVIJ6
         3CSUaugrXoL2gpCFvo3xfjaq7r70SW6rAD811WcSrPEJq0NDR0q51nBe0vT2IiDmSJbZ
         JQ68B6RDi7U2bgegKSTD+BJV0TnEjU15mDeA9Yz7FXoTqz7hKQlguYD9wm55tG0aT8zC
         pQe03rmmOKXdz+/I1I3C0CN9lG6tQzdbRpFrZhMEEfgBGnFSgk5Ui9LVCcu1khXOC7vh
         KBJg==
X-Gm-Message-State: AOJu0YzZkQtljRjk/dbA9AvaFfyKDpPTmsrpiAhFRWqQEp3vSGUZzZDu
	UlZkbyH/W6wWXC8PfKMbwRudW8c+cReql5op2+tCZmhUgiDwAs2pafXgIAehTpOnaDUpgTeIVUy
	yghHVLIYWbDUnPX9ZuqqjwhCBXblEheXjtlsuAUJM01d+1x7GbT/etFU=
X-Gm-Gg: AR+sD13NgfpR7gevNp6mRzHvetfyYPuyOLT2Wy38giHjc9V/4IH8gyLTnO1z7FlwtnB
	7nXHOxeJnYWlZK5/M659s7eqKxdK4ImdS5xSTEtTW3v0x87mksjpJFqCZKC0F+Dd3FhPGiuVVG5
	vhklaAkhhn4SjHnxd3s1vYARx8FGNaOAsZeHqZBq5xbzJW2XyO2Tm99i8yrkrS8apZNFTyGBxo2
	HZXgllHLCTsmYGUcH1oSXsYuL58fA5AlyZGLfglmCm99iJnZt8gyL2s+yBY0aTw7ZhRLDnVnzTR
	u4JjdIJX+pvKH7gyjQrNbjxliuVe2Pyltd2IyYIjPs6MSqXSbQpgyrklywI=
X-Received: by 2002:a17:903:37cd:b0:2ca:53e1:b915 with SMTP id d9443c01a7336-2d34560df46mr72972475ad.14.1786547756069;
        Wed, 12 Aug 2026 08:15:56 -0700 (PDT)
X-Received: by 2002:a17:903:37cd:b0:2ca:53e1:b915 with SMTP id d9443c01a7336-2d34560df46mr72971625ad.14.1786547755623;
        Wed, 12 Aug 2026 08:15:55 -0700 (PDT)
Received: from localhost ([2a12:a305:4::40fb])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d35219ee32sm8268495ad.38.2026.08.12.08.15.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 08:15:55 -0700 (PDT)
Date: Wed, 12 Aug 2026 11:15:52 -0400
Message-ID: <51d0105b39278f46def5b14d8d10103e.guodong.xu@oss.qualcomm.com>
From: Guodong Xu <guodong.xu@oss.qualcomm.com>
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org, robh@kernel.org, devicetree@vger.kernel.org,
        conor+dt@kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v5 15/17] riscv: cpufeature: Introduce ISA bases bitmap
 and rva23u64 detection
In-Reply-To: <20260701142230.A575F1F000E9@smtp.kernel.org>
References: <20260701-rva23u64-hwprobe-v2-v5-0-2c61f94a695a@gmail.com>
 <20260701-rva23u64-hwprobe-v2-v5-15-2c61f94a695a@gmail.com>
 <20260701142230.A575F1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-ORIG-GUID: ttPelgB1AoN8mIj7-E9hZrEv_OGo9y_N
X-Proofpoint-GUID: ttPelgB1AoN8mIj7-E9hZrEv_OGo9y_N
X-Authority-Analysis: v=2.4 cv=UfNhjqSN c=1 sm=1 tr=0 ts=6a7c8e2d cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=7NWRS0o-2Gl6raFx_5EA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDEyNCBTYWx0ZWRfX6PnS/eWvlDPB
 tb+bInI6gWVYJioWOV8ryoHbJ8ImqfQ6wIaSt2F7NYXJ0s19WtlLXveWkjQO8yNSo4zzC6//Sn+
 Ipq4rGwD+IUq+KMXH2iglkSEzJa39OU/Lkv1yGF/gQI6TpVLhn/z6Rfd8hCoyxugaoC6N3v3M73
 YHfYdO3ZKn3e1fyW5VPMqcQfRfj2rNHn5y7drAARm5n6aOcbBwR7hggdBIGMGNEqkx0pD2t793u
 M8SNHw9qiYZpTcUGcoBmuHtDSjEm1uKN7J8h3KbNhLp/yUlzDrOmxTbyDh4ztIo9y24nVE9hVyo
 /wWBTvItBk3yMe3h1VnaZXPh7UT2XIiOHbXcpXqFqhRyaEBaGy7Yc4haBMhBlpEveM6JpRzr7C4
 VbWdrRy06vctiUP5vFvZseditHO0wEOX9WcS4OPd/J6M4gFpi6knhp2k2taZIXkfygVVyqxtU3v
 lZhQLbD7rpYl31/CjCA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDEyNCBTYWx0ZWRfXyYhKFHj3O/Z9
 yP3gkg2AGrQqkpQYlVa6sI7HQWXcYdXrmK5+c5lFF67O87LACj43DXga1ZA3qUJAQu+CG7wGBbf
 6SY5OzOuewIKyQ0jK8X6AjijP96NhNU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 phishscore=0 spamscore=0 lowpriorityscore=0
 bulkscore=0 priorityscore=1501 suspectscore=0 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120124

On Wed, 01 Jul 2026 14:22:29 +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] The RVA23U64 base detection wrongly mandates the legacy broad `B` extension superset instead of its required bitmanip constituent extensions (`Zba`, `Zbb`, `Zbs`).
> --
>
> commit e73d8757f0ce7270b4b39989368d4e83e5a355fc
> Author: Guodong Xu <docular.xu@gmail.com>
>
> riscv: cpufeature: Introduce ISA bases bitmap and rva23u64 detection
>
> This commit introduces a per-hart and host-wide bitmap of conformant ISA
> profile bases, such as IMA and RVA23U64. The bitmap is computed during
> init by riscv_init_isa_bases() and registered as a subsys_initcall.
>
> > diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
> > index 4c3bf813af052..fa8471aef42ee 100644
> > --- a/arch/riscv/kernel/cpufeature.c
> > +++ b/arch/riscv/kernel/cpufeature.c
>
> [ ... ]
>
> > @@ -1304,3 +1307,90 @@ void __init_or_module riscv_cpufeature_patch_func(struct alt_entry *begin,
> >  	}
> >  }
> >  #endif
>
> [ ... ]
>
> > +	/* RVA23U64 */
> > +
> > +	/* Supm with PMLEN=7 */
> > +	if (!riscv_have_user_pmlen(7))
> > +		return;
> > +
> > +	__set_bit(RISCV_ISA_EXT_F, ext_mask);
> > +	__set_bit(RISCV_ISA_EXT_D, ext_mask);
> > +	__set_bit(RISCV_ISA_EXT_C, ext_mask);
> > +	__set_bit(RISCV_ISA_EXT_B, ext_mask);
>
> [Severity: Medium]
> Does this incorrectly mandate the legacy broad B extension for RVA23U64?
>
> If a RISC-V device tree advertises the RVA23U64 constituent bitmanip
> extensions (e.g., zba, zbb, zbs) but omits the legacy unratified 'b'
> string, it appears this check will fail because RISCV_ISA_EXT_B won't be
> synthesized. Should this instead check for the individual constituent
> extensions required by the profile?

No. This was raised and answered in the v2 and v3 rounds.

Guodong
