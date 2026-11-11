Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794402157;
	b=BgVfENulT/Co310RyZXiRgPlXfPJ2M99JJPrNa42J3r2TQf3QEpNb0Dzk12MWyPHsNCX
	 SKeaTwWZEBEhFytmK6xve+q7/m2m8HsVrdIq6BfRSAoPspOu8GfGRxh5au4IKi3YstZtt
	 9lTNvWGPHyaahmgu1zmRIAsCMJnrZwb8reReFNVqLmPwMboaqvHULMkUdFu1ym9cJpriz
	 sZMFLnN0NSRkAOWoVv/7G6cdLrswsFGccpUNxn6qQN8XF44KskAjtmgflen6pegO2FFxx
	 7CkTs4D5NF/eioXYoo22xhi8jW9KvCkviHZxVJIhxdSUiwV59879RmRrJmpwlU4MjJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794402157;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=gL7PRluqOkzpLiN/UK7bTD43fl5T1IxvJlK3ZPRyK2w=;
	b=o1C04f9lg2MDGQgUsG2gKAR/kfP8HeY8kgDI46lxEBSnNDDXbvcd9bmcVxopKPZ8Mv6C
	 JgciCLkYpAjLmr3xcdm2wgtgKi743nYbfPKMwHhwc7QejPx6cwgPUdJGdl5An2G+/mVXJ
	 T7qGTBTtFJSJE3naTY8E3qW4go2J8cuYiSOxyeQMidDhn3yUChvrcZ2lV7e/HhkNQEEsN
	 +Z9+EqkQVhmJPMpyMHJYcTGqvKc5Gh92kjBUXKq62cr2SDjsAuYyewSDvmE/4rb37pU4q
	 ESgKCzs3DVs6fPmSqC28sPpBxAwtAK+Wh82cXgjamqEWVd4dbrm+24ah1B2jZhqOA3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=EMYvY7ez;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=bZuShfxc;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CACEC606A8A2
	for <kvm@vger.kernel.org>; Wed, 11 Nov 2026 13:02:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CACEC606A8A2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=EMYvY7ez;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=bZuShfxc
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ABCYvv33291897
	for <kvm@vger.kernel.org>; Wed, 11 Nov 2026 13:02:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=gL7PRluqOkzpLiN/UK7bTD43
	fl5T1IxvJlK3ZPRyK2w=; b=EMYvY7ezmzJ0k40Xt1ZuHaDmzZ3tilOwId0a9hlK
	AQFxTU37UV7LI9UXhgIZXO+CS4P1RpIm31tkGUjuTadL6oV/3qq5WgSSD226R9jq
	qbuJpilJYMz5hu+B4t0TpR9eAGf0kyGl6OxeDSpq33jzWKKYVKt79BbIX4u1X0qP
	cJm3uxvBWcuaQzBZtQiXE3DtrPa7XqBEy1P3zNquohvHnQRdxZEtl8aP4O8ghzH7
	uRH0iP7kni+J5wq4twsVr3vu5IRzq71lqawbB3iNG2K8r+T+a3vPWopy/oXK/jEt
	GJr5A2ke5Kkqx9r8eJKJwPyt0NYJlJ0rwoN4LJOSqulQGQ==
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com [209.85.221.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hvdnp2k1x-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Wed, 11 Nov 2026 13:02:34 +0000 (GMT)
Received: by mail-vk1-f200.google.com with SMTP id 71dfb90a1353d-5eacd2f2229so3551827e0c.0
        for <kvm@vger.kernel.org>; Wed, 11 Nov 2026 05:02:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794402154; x=1795006954; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gL7PRluqOkzpLiN/UK7bTD43fl5T1IxvJlK3ZPRyK2w=;
        b=bZuShfxcAnDXihKmV6NZOlW0JhFuxnBRGMS16+chGl/HRrzhkJEmqP4uO6T+uoCh92
         /48tV2jeBN8k2MV/S0n+e8Vp5JuYVS5JGCi3niBhahbKeZcKPVojNv8P3mLOrAZ4X08v
         yuhok4t95QqzPG4PhjQG1hs38oAJK+/9H3InmTxdFC45vlHkeEQ1KvwilLoUZFYGLv71
         AU2dfI6zSA/ANkB1GlzglY93eTm2w90k8B5Zi8BR1GCYOq/o1wB3grtMiVFoHpkrbPNn
         kyITVPwCXx0rQxZegCLHq8bJpQ/ivNKdj9snwFil3xbG8OWnBlmkjHvHvQcvu80mgt9Y
         J2sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794402154; x=1795006954;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gL7PRluqOkzpLiN/UK7bTD43fl5T1IxvJlK3ZPRyK2w=;
        b=Eg8dfPL9Y2E18Wjf2u/SgaG7CU7fZgBKYHJa8vKJvGo33KjaD4KigWpFtqQhXfowSJ
         gHv8V95cm+dO1Ux5wWoNB2k8vf3H8b10WklLBgjFv89dcVticiTN8FeWJQLkxtb71bR8
         TSW9iYfZFLzUTOMcO8wfiQNS7//zazP0UELjgKw4gg7yJoFuC0VL3iLu4xgKq1WKfWJ7
         s1dqC9d/6ZGXtw5jU37oZeLTuSQsoXK6sOD8iCxT61OJLIEBSzpqrMFjLI0/+K9zepkv
         Xgoa4Jm0IBhfs5Uohd0a4PRoCSoPq7sWZOfsGl6GMA7aVU1daR/8U1BaHvM1aba3t/MI
         1aCQ==
X-Forwarded-Encrypted: i=1; AL+hErGe6vgmOEKms5EJSOPQ+pk2nrHJagDKxBe4lQFtmLz4GzIP+RcmyVCNY+C+lB1HgW2RDmg=@vger.kernel.org
X-Gm-Message-State: APuU4Z82SJe4d0kA2mjbwxbxeMvlhEEFJ8tg/HGz9p1JU1eV4py+ubx3
	a2k21i3u4f9vhuuAUwugGZlyFO24DiOdxdS4R8662TV7ZbwDj4aI/d+t1rNJ+q6oqcCVNqysD/+
	rDuzwn2C2p18v1ZUo1XByC9waBQ2ATMbnMZuk2UEFPagEXCyR2++72pQ=
X-Gm-Gg: AYBFou2V/jnN4krtjFV7Jp1Q+PbcITn3mfj64CUqzCpu+RodY+gKYnjz0NW4KoYkz3S
	QpnD3Demgnh7w8Cyx5DuczNH0TplLospte58Lnw2QgoQuw1bhHK3PPbDgehVtja0Kj/aLDPlH3C
	P48VKs3gd7wBwRMC0nGHLTgc6oh1WMYNBOPPkql8dhB5vIjIK7+BYFomaGXM+ApZcwsJXJey8KJ
	B+za0K0iFejfwzaiOcDFd4RBsbQOw8pW/orZHGoZMJocL6n4ZegrrfOZrzq5i3yUza6QBJaVubQ
	A6HKV8MNyJqzOltcNMh0QjG1Hpt+qe8pV8OCQzunP1jptIdG5PuJKJNxqTy+5me5SS0bWYNlG7z
	vUDrNEahfbmGo896X0Pp8hE3McDiwHEMlUCX/sSMqBCRNSKEqAMTLtSPCL4z03kqZnURrRrZyJF
	gxqv4+61ROHYNOigcetVVBukCrdVkTSPZ0/0dj2DMAjgNAHqSJwpuCwwYpvhGMdg==
X-Received: by 2002:a05:6122:e248:b0:5ec:c180:e1a1 with SMTP id 71dfb90a1353d-5ee1c292c8bmr762390e0c.2.1794402153813;
        Wed, 11 Nov 2026 05:02:33 -0800 (PST)
X-Received: by 2002:a05:6122:e248:b0:5ec:c180:e1a1 with SMTP id 71dfb90a1353d-5ee1c292c8bmr762282e0c.2.1794402153278;
        Wed, 11 Nov 2026 05:02:33 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5c157baba35sm933313e87.46.2026.11.11.05.02.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 05:02:32 -0800 (PST)
Date: Wed, 11 Nov 2026 15:02:30 +0200
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
        Sashiko <sashiko-bot@kernel.org>, stable@vger.kernel.org,
        Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Subject: Re: [PATCH v7 2/5] iommu: Use resource_size_t for reserved region
 length
Message-ID: <hn7dczsvgtq6siyikoaf6y5stlacmdyq53eg4mhyonugjhujlp@7k4cxflzuu56>
References: <20261106-add_iommu_ranges-v7-0-5c0f72083e52@oss.qualcomm.com>
 <20261106-add_iommu_ranges-v7-2-5c0f72083e52@oss.qualcomm.com>
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
In-Reply-To: <20261106-add_iommu_ranges-v7-2-5c0f72083e52@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDA1MSBTYWx0ZWRfX1MJCvlxoK5Lv
 I1oZTlJ/UfBiLHu1ropjxiu7JHjtRw+gBj8Toov1XEpVYFADZxM12f211r2HUXWxITamjEgmd87
 l3zJ3YFavDjYlh7kgTnQ/5QvgZhIIaWTihXQHTTgGhR8slSIPs2tp7UObvUddv9cqA3HLQ27qYr
 WpFYsFZpe2lmxEsZfn7XBv29KgUhjL0g4BNK/5TODLzhu/BPyohqSYhv+loM2Rzl6cdbI8jfeLE
 0WYAOfizqu+0dmjVU9H6BknzS1uieccRtGaeGonmHFBeVF4K3CQZaIlTjYbEZdDwjqNN7Ta8vCu
 KQmIldbf13UcXad5bMFmL/QLAduqmWfn0D/Q3gZuLhTM/O+kXc75NGQ72v1Q2k7rlR1OzdxkzNI
 K0ZlqTlL7HOND55GMh7ewlNLW0KrVKqqkAq+CBZw6I1Ycy+lmwNPv0UUVMDSYQFA9MuPp7HQVEt
 z7CdAM6ZbQsp8uZj4rw==
X-Proofpoint-GUID: 56UPWDJZlzWhzCWgP9CW8JC5fCaPAphS
X-Proofpoint-ORIG-GUID: 56UPWDJZlzWhzCWgP9CW8JC5fCaPAphS
X-Authority-Analysis: v=2.4 cv=NK1AaE6g c=1 sm=1 tr=0 ts=6af4676a cx=c_pps
 a=wuOIiItHwq1biOnFUQQHKA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=EE9pRYFAw_fItPXnlVYA:9 a=CjuIK1q_8ugA:10
 a=XD7yVLdPMpWraOa8Un9W:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDA1MSBTYWx0ZWRfX4YVN+S1ON2wH
 Msh5kzC6aJuWSvpj6RSK0ZDD2o8ylkXmO96TP4H5qqLVJqKyTCrFU3EvQMDzLg7+nZ8frxb3QPh
 KkXaiaBWLCeJ4BvlcEhuSy5eUa4w+0o=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_02,2026-11-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 clxscore=1011 suspectscore=0 lowpriorityscore=0
 adultscore=0 malwarescore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611110051

On Fri, Nov 06, 2026 at 10:44:25PM +0530, Vikash Garodia wrote:
> On 32-bit systems with LPAE, physical addresses are 64-bit. A reserved
> region can be larger than 4GiB, but its length is stored as size_t,
> which is only 32-bit there. The length gets truncated.
> Use resource_size_t for the length so it matches the width of
> phys_addr_t and holds the full size of the region.
> 
> Fixes: 2b20cbba3390 ("iommu: iommu_alloc_resv_region")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/all/d223ee9f-b262-408a-a201-8b16d310bbe0@oss.qualcomm.com
> Cc: stable@vger.kernel.org
> Co-developed-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
> Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
> Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
> ---
>  drivers/iommu/amd/iommu.c       | 2 +-
>  drivers/iommu/intel/iommu.c     | 2 +-
>  drivers/iommu/iommu.c           | 2 +-
>  drivers/iommu/of_iommu.c        | 4 ++--
>  drivers/iommu/virtio-iommu.c    | 2 +-
>  drivers/of/address.c            | 2 +-
>  drivers/vfio/vfio_iommu_type1.c | 2 +-
>  include/linux/iommu.h           | 4 ++--
>  include/linux/of_address.h      | 2 +-
>  9 files changed, 11 insertions(+), 11 deletions(-)
> 

Thanks!


Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>



-- 
With best wishes
Dmitry
