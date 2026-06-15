Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0B64403129;
	Mon, 15 Jun 2026 15:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781536812; cv=none; b=lW1K5ohoubdieckNXuMw0R3FkBHc1aOvreKuj4EVcObtTAsQ94n8WIjW6ygQkSW+kWC7+vIBo4VHQzwmi8N4mSV3fiLUiqGhmfvh9fvNldWkkaHSH1bhC4xbEIusSUiBjNEEERmeSU2mhi+uBCh+gOW1zdYGAWoqvUWMkPbzbTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781536812; c=relaxed/simple;
	bh=gMW76pVV2WRg1aePs+89QWyYb0X4X6cm5c6OIRnMJT8=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WZyvmjI7XxB9VyRqufynsuR4d80Yi69GVA11zyOW5V20lVep3MahA3LRXGYevmw4QlQ1Ojmv9hHQrJO7tSRHUUy73I/yENzY0APda1ollbB37p1zAuRN2z9ihn+jSzyYPJvRPTrR6FGJta7ASRM+8sQtPq8n7IZQ1UTzwgZCvQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b=jXKCVtnt; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b="jXKCVtnt"
Received: from pps.filterd (m0528008.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65FEZk552334449;
	Mon, 15 Jun 2026 08:20:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=s2048-2025-q2; bh=gMW76pVV2WRg1aePs+89
	QWyYb0X4X6cm5c6OIRnMJT8=; b=jXKCVtntn9ReKj2R7V+QLiHyszgRzZHn7tWe
	qc7z77YtQoI7QtoU/r9A9n2sgfB+No64LwnXFLSoALU6il1a8QA7G/4oYoxzmpj9
	fgKpNzY+DCNnZQSmNmkc2WaB2bR/qyysSawA46oFqLgJN/k4cxLtB0VcLUtPPLdS
	8lpsEAVr9GBgmJWNrEr72xC0jcVK73+MveQlmjFDd0aBT19NaOFw1uKdOd2GVLmB
	PmX17JMDtZNA1TBR40GBfhC32U7DVckKsxSN7qP4qlfe2yrZE3mgX/kxIaFMer2/
	tsmb8QmAXpIib9AE1daEdHAPGEvmMNpB9q+cjB60VkJOC6R/Ww==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4esuthnf0r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 15 Jun 2026 08:20:02 -0700 (PDT)
Received: from devgpu015.cco6.facebook.com (2620:10d:c0a8:1b::30) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.41; Mon, 15 Jun 2026 15:19:59 +0000
Date: Mon, 15 Jun 2026 08:19:54 -0700
From: Alex Mastro <amastro@fb.com>
To: Vipin Sharma <vipinsh@google.com>
CC: David Matlack <dmatlack@google.com>, Alex Williamson <alex@shazbot.org>,
        Shuah Khan <shuah@kernel.org>,
        Raghavendra Rao Ananta <rananta@google.com>, <kvm@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH] selftests/vfio: avoid VLAs
Message-ID: <ajAYGj43yceamSxf@devgpu015.cco6.facebook.com>
References: <20260612-scratch-amastro-vfio-selftests-avoid-vlas-v1-1-ba3acb635f0a@fb.com>
 <20260612234154.GA667942.vipinsh@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260612234154.GA667942.vipinsh@google.com>
X-Proofpoint-GUID: nInslF4jnKH25IhWSPvsFzauXCNLx0CM
X-Proofpoint-ORIG-GUID: nInslF4jnKH25IhWSPvsFzauXCNLx0CM
X-Authority-Analysis: v=2.4 cv=SY3HsPRu c=1 sm=1 tr=0 ts=6a301822 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=7x6HtfJdh03M6CCDgxCd:22 a=_1IyUuN4QrATX339ibzo:22 a=OJ4mlx5pWCXamJuR_qYA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDE2MSBTYWx0ZWRfX/8XTyEhpgjzV
 LbaS+u+tBB92JPrkgjwF03tI0nGwqVXjFSV0suyDhyJkF7Lt8fHg1L9IUpBg29gpVtxNOxlCf13
 A74MGwCFMklBLdRgGXLeK//sZhTkLtSzGH97edwEtlGmkt91IpXXds+pW5KhFdIczi83TMcKY7i
 sJhxg1GZdxiq5NY4vH3K0cl9tXErwHfHVOTtI+gPvxYhXpBGsYY4l5VPAGjFUwBN33jR8gD+evd
 krhBq/ewzIi0sozPbPckEtlN8ZGHnzdRpMadJ5BZodfsoB3iwCxLIRXmJJb3RPjCinO+WhYaxDX
 gOVTLaGIVP1n86bLieeUlWIYa5flhkn8ikJXxg1nuRFIcypSPGVutfa1vBGw0zFRMaecYglHrae
 whtp4CkGsEJSDu19oO7CVzSFxrytvQZ3iUvo05dnAd/WxTacHwFhusueQRN3+xIL2LcVqveCNXo
 UsOxHP3P8UED25o5Krw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDE2MSBTYWx0ZWRfX0B63Hczh6rHV
 LokJZ3RjMemMRxzGsu/yh6IKPrRSSAGwKOxN5KV41q73/o7F3sVLegocZy5ME9MvVJQSeQISUcb
 AkSaOtzcRUMNCGrPqsxH/3i4p7eqPLo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_03,2026-06-15_03,2025-10-01_01

On Fri, Jun 12, 2026 at 04:45:43PM -0700, Vipin Sharma wrote:
> Nit: Can you change it to Reverse Fir Tree style? Same for the other
> change.

Yep, no problem, thanks for reviewing!
