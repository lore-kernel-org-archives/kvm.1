Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794992542;
	b=ORuQw3Qeofjx/dhQujHERehdJkZFHGqSItxQuW1lwW/RdoTTxu5QylPYbkGJykKksmts
	 OpNRvG9odD6jDw84AfUwUnuTG6BUdjYARTPzl8DCrbGlZJV6h8OVyHH75T4cRdphllicm
	 XMHboJdm1AbvmiYs8TIbcXkUDfhEiI9/REFy8GxWmbSBnuWRLWZ7s0I+gfQlijwgc5EU9
	 keHgLRqMJZ/lMYPEmDE9G84kVIJGup0JonT3/KFXTRdRXeLu/5h9onPCsLAv/PQVhtwHn
	 J6oaKBxup2i96htVwwDJDrDGwF9S424BGW7m9k+p7dE10F5OVOjXTh8CtuyC8qk4oZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794992542;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=yyZLaNLsFBfc0JqArcrGxcWEFwZyPv7YYEvEtfwd+rk=;
	b=wWNt8AwpMhqOA+gv19kNRGDmnIe7Fug1MmcUok/IGN0JhXNw4pPh5z781zYZ5Iiku04l
	 Y501kUcPPRpFoROPuvEKcB9vW0zS6+r+l1HGI6LQYfBg8xYtD7crMyKCGAmNmZQ3eg/JJ
	 TnPIFvpZnphJ7wWJTFj8R2LGLmKldNREruy+UHyUItCYzyg1z9jBWtILBNrvz7gfcw0b+
	 QWOowZSpUFHpU5Texs8haxs+W9lxeZo127iuCznan6ATAkDy414kZR5E9VsoNjV3mi+GA
	 kBgCS9jqZe+246YJXh33D9hDOuWmoyKlt5B6EUMAOnCucxLosfb1aAVnSIrtMUiKlyg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b="Fa/9Iryi";
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b="R/qJa7Vs";
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A71F7606A330
	for <kvm@vger.kernel.org>; Wed, 18 Nov 2026 09:02:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A71F7606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Fa/9Iryi;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=R/qJa7Vs
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AI8WKI92383027
	for <kvm@vger.kernel.org>; Wed, 18 Nov 2026 09:02:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=yyZLaNLsFBfc0JqArcrGxcWE
	FwZyPv7YYEvEtfwd+rk=; b=Fa/9IryizRttAHlUczN/6wai6NYxknNzBYBuBmRe
	NDt4VFh45iJ7hI+MPeJ4R2GM9riVStt4nxDR4y7MF60N1Ilg1hozREdZGUO/fea6
	FRVcg/9sS6c4ubwFp60b1dTvcV7OO09I89EJoCIRlrBZ0+ZFgUyV9SbuDmcZSYYo
	rzmubtC6D0DlMC9+7Ql+yf8bUi8vhMzgK4fl0sJ+nkqlv4xYprIv+z6ZrM0V9DBK
	mP4Pr19Ez5j2LwV4H58BGr/7PMfNz48w1KDCre8iWrNi1C0KtSXiJOvjs05senUV
	px8XfQEY9nsOAUQGfpxynRuWxEeFTTKo2d33wfGYtWyGxA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j0yvat78x-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Wed, 18 Nov 2026 09:02:20 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93f26dd2165so214286585a.3
        for <kvm@vger.kernel.org>; Wed, 18 Nov 2026 01:02:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794992540; x=1795597340; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yyZLaNLsFBfc0JqArcrGxcWEFwZyPv7YYEvEtfwd+rk=;
        b=R/qJa7VsEeZkDq9aUm5JDwLdXSB2zBjyBAeM6nnrtbt7+a0tzhCn8Adn5HF2LlMDX+
         8lo7VNmtzMYSjsGU6IgxZ/Xkrg/+m+Epjx4Y+FTgy3wS4YkNx2dJ5woG/5sSoE5pxLEc
         oeVzuCBnZXq0KjHxEUqbqAVIUPjcjzmEoqZwfwkNvZjK+HeTiXdrpfxX/52dTQxzd+Si
         TDhKfpSmKdbXMBXzuE9ZjgXlAH03xSRYxGW1GAxo8b/PYdhrayQ2U028fqdYNGxnqML/
         NFKhP2N6Bcmo8VkeAkV/mx5d4i1UzLq6YfTsV7NmAfaFM6610SE4wO2vXoztAvqkLHjR
         Unpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794992540; x=1795597340;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yyZLaNLsFBfc0JqArcrGxcWEFwZyPv7YYEvEtfwd+rk=;
        b=0ViVMN9FYk7WV++8d5Qn3CDeCoch2vZXfHr1HkjE1fCdqWfrK+OqAykhk9qN3O2TZ1
         l+wdrSOfpYbkzOe+XoAsdOmBrz2tzJ+a5wcmuIQcdNzuaoRHT6RcNMIMwNiNc8ce7Thi
         ubDm4xvpO9hkommTtcLVyIw89bKvHNIOh/j24D0YRKF7oJDvz198CuZNAguuHA1EEywl
         ROdRAkMkGGcDkq3AFtmIxRPbtyYAItu0dKxwU5xc4CPxLAGQfupz1ULf51z8k1M51U9R
         zkJ2pWDMjA9WUpyJDwDmyTk+ZW0ZmOwXqGBCmYupM6yL67RCvjt3OMg90oVhH6j5rXij
         7liA==
X-Forwarded-Encrypted: i=1; AL+hErH/rSmOEj8Mcr1sfShurEK/Jk+oqHWKH7nxp264HgBZUq3+SdkDm9lX1D2DVnrfK3KO66E=@vger.kernel.org
X-Gm-Message-State: APuU4Z+aEi/Pyx1QC4yTQr+MeBHK/MIyrAO6WUoGM4OhCDO5XAVl+N2e
	Y5/G6KL62k1N5g1kO8NZQsiJtJCSPQnQ6fLa1W022o5A8jkRh6KAUGtHgwdmij6359JAuuW6b/q
	bHTf7HtpJiQZe/WiLSvA6/lDxx+trvwNXflrYYua0QsZF1Y2zbjIn4mY=
X-Gm-Gg: AYBFou3d5ikvogGcvgv01pfGML+Yi2ax/zVrQx7mM3fMcwXyKR2dUCFFSbvwgnsUedX
	UlTX72k73a3JZMrXU3eLeT2JboI2mZwaBetTMN+IdpvFqkbLhssdzpgoU8OIfInk3JI83VxXl88
	mO3YdCETAPg7Im5W7vjzO+Os4JfQpse6RZiCuf9rfFs3QVvXV8VA9deayO0wsRCKQAc+TZsYqXn
	uTsdCZsfCS643dYofTT+stFD36kcJs55tf6JdTmW3xeZuD4KNyZs5fVDMEA364vuGdgfySc4MYg
	GWGj2DlRQ38BdkNcZrFwM/WQWlNg0JQU6sYTDzh61vtPcK/cbqi9oHcHhb+VFEq11hWb7wj2fFV
	16ufUS9qIqeHWleghYEByIYyJWGOsvUcY3hs619D2XmG6M72VO+QOWuuxTg+4Pl769eO53WhI/C
	a8d8qU7mQnO9tKGJu90KVsG+OSix9IpkNosgy4d6Z0RZDrm95nwEL4Wigi5xD8pA==
X-Received: by 2002:a05:620a:628b:b0:93f:2c95:658c with SMTP id af79cd13be357-9499957e6famr377682985a.14.1794992539371;
        Wed, 18 Nov 2026 01:02:19 -0800 (PST)
X-Received: by 2002:a05:620a:628b:b0:93f:2c95:658c with SMTP id af79cd13be357-9499957e6famr377675585a.14.1794992538630;
        Wed, 18 Nov 2026 01:02:18 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3ae67b429d7sm4551491fa.36.2026.11.18.01.02.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 01:02:16 -0800 (PST)
Date: Wed, 18 Nov 2026 11:02:12 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Cc: "Joerg Roedel (AMD)" <joro@8bytes.org>,
        Vasant Hegde <vasant.hegde@amd.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Jean-Philippe Brucker <jpb@kernel.org>, Rob Herring <robh@kernel.org>,
        Saravana Kannan <saravanak@kernel.org>,
        Tomasz Nowicki <tomasz.nowicki@caviumnetworks.com>,
        Eric Auger <eric.auger@redhat.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Joerg Roedel <jroedel@suse.de>,
        Srinath Mannam <srinath.mannam@broadcom.com>,
        Oza Pawandeep <quic_poza@quicinc.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alex Williamson <alex@shazbot.org>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
        devicetree@vger.kernel.org, kvm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
        Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Subject: Re: [PATCH v7 3/5] iommu/of: Make OF_IOMMU depend on OF_ADDRESS
Message-ID: <vwg74npvbwdhepp4uownnzlj2ybpiknfktfvrpy6462rdw7snd@tj4vgnn3dtml>
References: <20261106-add_iommu_ranges-v7-0-5c0f72083e52@oss.qualcomm.com>
 <20261106-add_iommu_ranges-v7-3-5c0f72083e52@oss.qualcomm.com>
 <yvkcq3zirv5tz2amfbk52a7smbsqs7jrzdisq3qxzw6xkoxklu@rplx3gvxhcoz>
 <dd62aee3-4f23-4904-827c-7f776c4be60a@oss.qualcomm.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dd62aee3-4f23-4904-827c-7f776c4be60a@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=SMzXx+vH c=1 sm=1 tr=0 ts=6afd699c cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=ypECYpogRKzTefqxK8cA:9 a=CjuIK1q_8ugA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: UNRbN4Bpyif540uqWLFfwol8n3yK77D3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE4MDAzNSBTYWx0ZWRfXwoGTWvVGPkDK
 bLl7PPgVhgNIL7qCxHgifXubAuVlSC1rYrM1lu919FnWtLW3tmeXENFKxecIde+P+o2caePLy2V
 nIGxUO/0cDyCT2NlP18xus1O0A7XaXdPgVBHWewqHmpv6zIvScoIJuSImirEZkiYrLjFO1owEcc
 fcBHJ35SyLf2JEy8110zZwtC0hb1SqxlcQ94RbUFvHjeCKoW4FxDPBPEGhBYtkgCeCUHO4XQ57p
 h9CAJPabP+/2QHjV8AK+5GAPjkQkJftT+iIWcqoDEaoqetutB2kb7QVl0QUu+Ra0ObS8T09LP0O
 mnaEJKHd4WYBCveXbXX8lK24YwW9/jRe7DRsnjHy+9O8sbvdC+ktVgL+ukpeYSIVceSdMTcSDrc
 ZUzJSKVhjJXN7eqx2FRJY1EO3VSGXaKzqvUkHxtqLcq/ftECYthQuDPY0pcApO/wkcNl//I+LWc
 2QsgvEd04PHC06rYEiw==
X-Proofpoint-ORIG-GUID: UNRbN4Bpyif540uqWLFfwol8n3yK77D3
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE4MDAzNSBTYWx0ZWRfX85t5FoLO24s5
 dwIkG1x+Sa/Lrnvb2dsBevV5+vBsxG/FIvTl/Cj+/VX1QXI1+sBjPAA0cGZSDi2+cGiDee8grjP
 ymg8HiUPZTd3OV/mVEUnz6aG6UJOAws=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-18_01,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 lowpriorityscore=0 impostorscore=0 phishscore=0
 priorityscore=1501 suspectscore=0 bulkscore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611180035

On Thu, Nov 12, 2026 at 07:10:38PM +0530, Vikash Garodia wrote:
> 
> On 11/11/2026 6:33 PM, Dmitry Baryshkov wrote:
> > On Fri, Nov 06, 2026 at 10:44:26PM +0530, Vikash Garodia wrote:
> > > The OF_IOMMU code relies on OF address parsing helpers, but the
> > > dependency on OF_ADDRESS is not expressed in Kconfig. As a result,
> > > of_iommu.c contains CONFIG_OF_ADDRESS guards and a __maybe_unused
> > > annotation to handle configurations where OF_ADDRESS is disabled.
> > > 
> > > Make OF_IOMMU depend on OF_ADDRESS and remove the now unnecessary
> > > preprocessor guards and __maybe_unused annotation.
> > 
> > Why? What's the problem that you are solving? Why is the current code
> > bad?
> > 
> 
> The commit describes the problem as "The OF_IOMMU code relies on OF address
> parsing helpers, but the dependency on OF_ADDRESS is not expressed in
> Kconfig"...and instead the code had checks for config or __maybe_unused for
> cases like sparc.

What is wrong with this approach? What is the problem? There is one, but
please state it in the commit message. Something is wrong, otherwise you
wouldn't be fixing it.

> 
> It was discussed in prior rev
> https://lore.kernel.org/all/20261104160346.GD3951195-robh@kernel.org/

That's fine, but the reason must be capturedd

> 
> Regards,
> Vikash
> > > 
> > > The only architecture supporting OF without OF_ADDRESS is SPARC, which
> > > does not use OF_IOMMU, so no functional change is intended.
> > > 
> > > Suggested-by: Rob Herring <robh@kernel.org>
> > > Co-developed-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
> > > Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
> > > Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
> > > ---
> > >   drivers/iommu/Kconfig    | 2 +-
> > >   drivers/iommu/of_iommu.c | 4 +---
> > >   2 files changed, 2 insertions(+), 4 deletions(-)
> > > 
> > 
> 

-- 
With best wishes
Dmitry
