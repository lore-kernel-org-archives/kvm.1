Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E193E833E
	for <kvm@vger.kernel.org>; Tue, 18 Aug 2026 11:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787051151; cv=none; b=oYUIX6fs7vM+PnEa4gZIpGboNo0W5kfyGIbsFD5Ok6iTxDQpeBRbHcFz9lxzeNfjuhg15oOqV8Tm9AuO3if0Y+l6g4k4xtpURCjqbDfKjDThhZTxXP2gyBQ4wLFEbELZ9+TGme84VWDH66ukzoyJOkjSvRTpRJjrJAJVR8V4MfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787051151; c=relaxed/simple;
	bh=WD21yXFVM+n9pplisTec1nEMwf75K4Ayj03WH1COswY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=beIvZrN8ww4aj2Fw/9OZd1MPUsq+t3ldAPp9bxv4TBQ85ZeDQhttcgOPu/T7Qjzb/Wi7WNyAJY3g0Ok5RylZu0Lr/79I4PvNCbV68hsJpDZUTRkkxs2BUVWoPk1EnR81zKjpxXq8B3Z4VJWLZfXO34Nu+y8N1TzgvYg1p4WiITU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fuVFn2HY; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=IrX6FxTG; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fuVFn2HY";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IrX6FxTG"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67IABG3o514936
	for <kvm@vger.kernel.org>; Tue, 18 Aug 2026 11:05:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=iYqV4IQW3pyNtGAkKKYZInsR
	EnU2tfnaz0FUufmmAqY=; b=fuVFn2HYd5cvh6McPla5E0KEh6NytzbOskTlJmKJ
	cQFPK1mnHrPH3aD6GpkTdObfr/C4Iu4uvHNkCR33iV+h8ut2OphptvfV2A3jYZJp
	keyH0rkdZ1yaLDo3iOlOOVgAW5JkgsQ+YTlx0j+wTeZ5aNopFFoYq9TXtxZo8Vm2
	DaZmQd3zOCbGuJ+Y8+DJhaPB4OruvAjBn78VtaSpOoi6bMMsfYr0LWIW3w4H1Gtc
	NPZtC4wk0HfInj7Q9z+qnUY0Ggba5jgTpG2aB9cP5df90phRcVSChQ0xs/etrlna
	LolEpM096LHuRu7tFZJoOJ8GEIzscp54F8qSFvQ0qIOqvA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4ea2j4u3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Tue, 18 Aug 2026 11:05:49 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-93494cce712so520971185a.3
        for <kvm@vger.kernel.org>; Tue, 18 Aug 2026 04:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787051148; x=1787655948; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=iYqV4IQW3pyNtGAkKKYZInsREnU2tfnaz0FUufmmAqY=;
        b=IrX6FxTGiLsiNGGQM7Gk5io78tG6xk5nTXvwELlwHybz6ND/qj+Cwf89cSxvrjk2PP
         7QX4FuRPkYY2G1fPjiWdcpWKdLjpK0vK4qbglXa3IblMOKag3RwAmVD0bDB74NL+7IMw
         0tE6sXwJgCovjDZx/vb8AC5Tr67Kx4sVn2Eu7zgmSW1hHNqQlbhzenaBRYBPFSfQSED2
         2IrnO8t3TGFcHtitIvsIChA88YhwamDulsrDPzDbrB521eaCsGCSHWyR/q5xHlPvqK2b
         FJydFUX0NjpgMjGYYT6jvAlfF5p8tA3bsHFkHyN9/Qkr7uifAERn/r5DDgPx6cXK8jQG
         Nypg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787051148; x=1787655948;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iYqV4IQW3pyNtGAkKKYZInsREnU2tfnaz0FUufmmAqY=;
        b=dIxxBbqid24HsF7ZneZetUy+e0/Aghamasuhf0KBAhObf8Oy7aFi44wKngIroEMH1g
         q2tnlqEXKj1C+3a9e+QBBksIJ6JJXsr57x2I6p7aLTuXgu0vOknYiZ7hTsYYOPxOr7ev
         Ed02aoTesFhFGGzKk0V+KDbpUjkjLVEvQKCFn3cVCrO79/X3rXmQggR2HrTK6sV+IA18
         C6xkQ53v3vPpa4gD0fZkkvHl9f22x7Xv2+SuErBmGP163388Jj4Zux2z3iUhhvhcAZzM
         HA/RhYXzRJEBa1lHSq/Q3fvwk6hrfgpJr4PWSy+LeIPmZFpEaLaYMvit19VHJzgW9xqu
         cq+A==
X-Forwarded-Encrypted: i=1; AHgh+RqJYiLJ0EF6+zqfFQCzKKspthjl/r3syx0lMnyIdnyzDTXF+JTtTw/1XCTjb2Sm/KoWBB0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzcdf3oHtuNfkr+mGaskdscxvVPvvqyn2NQNjdfVG4lDLBVlhp7
	lMzDhzd/GELup2s+h9GTxJ+NLGAxDYmYrVkVZcP8urOpFIZs6Q3C/3IujQwtT1YL1CZXM7xuLWj
	MiOQWM56izOHymdmqACCgxbo/l4sd5h67ZWUpecY7HxEfyktU8M9riBQ=
X-Gm-Gg: AR+sD11Z1Wjfsfxo7nVvTQBnrFYFaSePAQlozaMuQ5QaqU3zR8Q/9hzkEHH522/Isbq
	s0banZwTD7RMJaCRLCDoFCjQ0SOZ9tyfH3M6F1PIruhoc+oSRRctcZPKqjWpn4K3q4C+MM+/oC4
	2MD1rg6JYJl6qywFI0Ug8OrAWu8gP3bioAnGb2bZ3Bp1IbH2o2TT5lu5Vo8xtRhd2cwKmMZ6Ci5
	7gByzAh1DrTfxnG+nsiEIiLRTTGwe/HUMJ7OBlVqU0p7CO1rNOcRehqt/bgFROwoy5KmixdXq5L
	PoxfzkwqQvWdigYJcKNbCHBOsv1NLJ4n5Z0lZWSDgNofB3F9MwJA2AAoXKH3f0D2GvJKwmuTNh5
	BIOD31yJC0P6e0E+yI6cEXvQLzyB+O7jMmDY=
X-Received: by 2002:a05:620a:319a:b0:92e:f41d:4730 with SMTP id af79cd13be357-93704acbe5cmr619384085a.5.1787051148465;
        Tue, 18 Aug 2026 04:05:48 -0700 (PDT)
X-Received: by 2002:a05:620a:319a:b0:92e:f41d:4730 with SMTP id af79cd13be357-93704acbe5cmr619378185a.5.1787051148018;
        Tue, 18 Aug 2026 04:05:48 -0700 (PDT)
Received: from localhost (ip-86-49-251-7.bb.vodafone.cz. [86.49.251.7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482a5b816f7sm10484724f8f.34.2026.08.18.04.05.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 04:05:46 -0700 (PDT)
Date: Tue, 18 Aug 2026 13:05:45 +0200
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: fangyu.yu@linux.alibaba.com
Cc: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, pjw@kernel.org,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
        tjeznach@rivosinc.com, jgg@ziepe.ca, kevin.tian@intel.com,
        baolu.lu@linux.intel.com, vasant.hegde@amd.com, anup@brainfault.org,
        atish.patra@linux.dev, skhawaja@google.com, jgg@nvidia.com,
        guoren@kernel.org, kvm@vger.kernel.org, iommu@lists.linux.dev,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 07/10] iommu/riscv: Add domain_alloc_paging_flags
 for second-stage domain
Message-ID: <rzvdgmjkk5rzn4qehsoajmbak7jpssqancyn3mfvpnzf6wyvsc@alyg5a4c2scx>
References: <20260507113706.11400-1-fangyu.yu@linux.alibaba.com>
 <20260507113706.11400-8-fangyu.yu@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260507113706.11400-8-fangyu.yu@linux.alibaba.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDA4MSBTYWx0ZWRfX1yHjq/k6aWta
 ZBwZ2ciidNxhz4fADsVXhnFXkiniawZ5bPb4kwkNFZoQX04x90u4seLHleYW9AAsv16OyKjYN34
 zYBIgOEtFpZMLu5kYy5DJ9QZuaxGebEwdmyg2BSq9HSH070sEGB6Y9LbW1s7v0Xm4bot2KLwg7y
 l005fYJnZq0C4a8NwGpccO+k1cHLYmqAJ6CFah/AClR87XnhcEL4m9KduuRCK7lIwbuGKczGOv+
 9fp8pLCOQxOcLxQ89wOFt79zanB3zCjkgum3N8BusbTBjUgNsu2kdakDyy7B4fP3AgFjhrx5KST
 3X+wwkXytJLpfT7h4C1hmkBzQNLiyiu9S9IGHVI999KtE0BJ9BBpwJXAmqdBsMMILKPnq5tThUo
 Uo9alYCZX3yU2Q+1PrGn9LvvLZnVV8adXMT+QNhfrQZT1OR4dHrQoRYYiiFInK68UoTVCt5KZ1u
 4VwjZrCpZxpDOvOkJcA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDA4MSBTYWx0ZWRfX39ESe4kz3pdB
 EWV+J3EuJpCDQ2nIGf7RZ3zy6vobOLtUh6ekUpL+6T4uqBk9E8z+Tlw+tqixW1FnyQX1hvEnRhz
 j4CEGQeuVC5gz6ULbcNDRMi11w3lrUY=
X-Authority-Analysis: v=2.4 cv=XtfK/1F9 c=1 sm=1 tr=0 ts=6a843c8d cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=on9AXyaqQ0RhfYpiXjjEXA==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=SRrdq9N9AAAA:8 a=GzsiVtujlViO_AMaDHUA:9 a=CjuIK1q_8ugA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-ORIG-GUID: sEK4r-vE0KtaP6Aq2tejHE5jpWN6qybo
X-Proofpoint-GUID: sEK4r-vE0KtaP6Aq2tejHE5jpWN6qybo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_01,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 impostorscore=0 spamscore=0 lowpriorityscore=0
 phishscore=0 clxscore=1015 suspectscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608180081

On Thu, May 07, 2026 at 07:37:03PM +0800, fangyu.yu@linux.alibaba.com wrote:
...
> +	case IOMMU_HWPT_ALLOC_NEST_PARENT:
> +	case IOMMU_HWPT_ALLOC_DIRTY_TRACKING:
> +	case IOMMU_HWPT_ALLOC_DIRTY_TRACKING | IOMMU_HWPT_ALLOC_NEST_PARENT:
> +		/*
> +		 * Second-stage (iohgatp) page table for KVM VFIO device
> +		 * pass-through and dirty tracking. The GPA space is 2 bits
> +		 * wider than the corresponding first-stage VA space (x4 root
> +		 * page table), so hw_max_vasz_lg2 values are 41/50/59.
> +		 */
> +		if (iommu->caps & RISCV_IOMMU_CAPABILITIES_SV57X4) {
> +			cfg.common.hw_max_vasz_lg2 = 59;
> +		} else if (iommu->caps & RISCV_IOMMU_CAPABILITIES_SV48X4) {
> +			cfg.common.hw_max_vasz_lg2 = 50;
> +		} else if (iommu->caps & RISCV_IOMMU_CAPABILITIES_SV39X4) {
> +			cfg.common.hw_max_vasz_lg2 = 41;
> +		} else {
> +			ret = -ENODEV;
> +			goto err_free;
> +		}
> +		domain->gscid = ida_alloc_range(&riscv_iommu_gscids, 1,
> +						RISCV_IOMMU_MAX_GSCID, GFP_KERNEL);
> +		if (domain->gscid < 0) {
> +			ret = -ENOMEM;
> +			goto err_free;
> +		}
> +		cfg.common.features |= BIT(PT_FEAT_RISCV_S2);

cfg.common.features currently has PT_FEAT_SIGN_EXTEND which isn't correct
for the second stage. So it needs to removed and then added back in for
the first stage. riscv_64_kunit_fmt_cfgs[] in the kunit test will then
need to also be updated.

Thanks,
drew
