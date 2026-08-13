Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44693480DEC
	for <kvm@vger.kernel.org>; Thu, 13 Aug 2026 14:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786630256; cv=none; b=aLB3VTyvLJlNGpARCg4QPFJp+KapM/aWRla0D/VwqPe8xcyDI5hc5MS3QJbzzO8lPsEd3jUmKGr7C7GYJVejcRoH5iMR/Ya+RNB8hZHD4PUFwkOXiAvot31N/T/zCM7QBGZM/DTPKIKytNA4+jLgMYr+Gw1hy3o1h1S6voPbAd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786630256; c=relaxed/simple;
	bh=XPPQhlrE0bO8IfDnjPs/cSwx0flsvJaogoL5jJ9Sa9E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qvRUnaTrS15oxFAC3KNHXjYbFfK+lP+kQNwNsK6bofZ7SOh58GI4QLh43oS3u09eAc1dJ5M4UGS2a7BzDDkIOV3Oty0IRL1/Q7AztHTXozem+ZZ3ttYpG/lO++0vqvUdJIbtjiM7cG4TU5FNIKLy8NVtWvDg6FHGFfbbXQl3czU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=F1pcNEgO; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NJr3cxbu; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="F1pcNEgO";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NJr3cxbu"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67DCJwm92414574
	for <kvm@vger.kernel.org>; Thu, 13 Aug 2026 14:10:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=nnrhxChuvUvmnhUjftdL+cEY
	05K58EtTFKjpp0G3HSU=; b=F1pcNEgOoZ3yp0g3uucPc/lGIbIftg4yj93eVVG9
	G8Cygm5t09wMBysVSE1jAhc9qeIaD341KZ6skiYE1bu6JsYTZo51omzlUHy95+uq
	MoMH9vnOU3lwMQBNxRVVcs9Iuo3mpk+lRg4N9Q87INoIKyQfR9LVJpSoDYUyfF6Z
	CjrBiDuwKyLlSulMnczEQPzBn+aWtW6Tarv3FmBnNUwXEwpVA4g1zeIsZ2ltk9lh
	4tOcckJwORwstjwVy5QeYF5AWgQDjlGLYowb1HPMFOpCmRTbZHbUHui0y4hGqi5L
	9kQ9eHIEUZctP86420PdCrEbooubRFj8vhiS7WYeUxLgjA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g143htuwt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Thu, 13 Aug 2026 14:10:52 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-38e1118e4abso1194781a91.0
        for <kvm@vger.kernel.org>; Thu, 13 Aug 2026 07:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786630252; x=1787235052; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nnrhxChuvUvmnhUjftdL+cEY05K58EtTFKjpp0G3HSU=;
        b=NJr3cxbujxHxrUekJ8u7C047ybLp8dS+PLJU3cvvlptm0Vi5lFuxfbpFK4/cGEU2TP
         kGaxzIJHMilPnrOpDRun52kjFsUdFN0uc8UxyMExolr/3y6FmygdhCWGso/vWGjtUHwl
         A61H4PDDuWPJASeybUhN9L94S84oQN7bcxtzf5V/lXBsD8Fy1WOF0q3i8mz5rACjgfKb
         GdkHP2eOIVlfnT2Xrbpp2d2eMOnHuYeh8X7lCVeuPosulc3uttLPRS3wGnrV/rJ+Ikim
         P1IVZjv4tf6q/Dq8Pql18WcgN2YYfRwBkL3lLQ24DimPE5JFgeCRc6vgpKYYxEB1b2XT
         7A0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786630252; x=1787235052;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nnrhxChuvUvmnhUjftdL+cEY05K58EtTFKjpp0G3HSU=;
        b=ofg9NfsjgO9wdWjaVW+fsm5UIcmkat80TEXC2Uwzkw5upLz1wgsnF5Ld3zE8m2rFpn
         DDuFDznKRUzawzk3paFhPD1OKFU7Vmjhc9VT5qxS3YVVHhpqoRmU4eaellP55BpzxT/f
         kw6HaNGlEHEgBzAfeGUsOvItFLsTyZJ4VzOnAdDndPBoW7N8AYdt7VaLkYg8ZBTiYdVu
         bdLWa6NJ1WpKoqr1sZJcAcBX1Wd6BLOtp7YD1480PAqx6AJ/KKBUX1AbYWUzqj/UlkMg
         p775xkHAKwN/oH2s3nbRc7iKfPIQQlUcmu8eLqsUJiW4Ob2kWFo8h6qN+SpCdzBCSkHp
         4uyg==
X-Forwarded-Encrypted: i=1; AHgh+RrZfAmzZF2lC2XflVLcT5DYM228UZ2Ng3FXdDuyoNn4bXyQJe2bAZrwBV8GqrLFi7tdA7M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdNeMTgzNfdD7vThf5bA88pp3StlFGHFG2f4bh92+g5V22C/d6
	6xL3IstvboOHVQXoPp865moihyNL2lDqir8q4moUikX5G0So4QJkMl3blLO00Tt3PQgPDlUDzd4
	Iyqdvbv70uCEX6Pt2IKI6cb6ArOXEJmWwmUAfB3Humr8/5SxtV7ccFfQ=
X-Gm-Gg: AR+sD13wIMTS2T2ubRXxkgyVx9LDP1pDzREuhSqyoQuBTx5IGGjcdGLlYj7MH+XXYo8
	qJ357FAO66OiPuRmEvaQEeh2oaAPm1MPExjxhqagQMB9uvNZ1UxKm1dHkRNj9xR6yZ8hP9IYeTb
	wFAqbVgTI7ZiYQEA4bWl+6FdoehDIwdpuyx1+gORHKZMrJnNfsKhFzmau+fBBUsfC/NRWsNxo1Y
	eBczc0aNp0P2KQV3SiQmCE6/EJBGeFXCi29MyeueK0YDzHxfmSCzlx8RtV0WP0nk3MFrE8lbDnd
	E618YFr484z9yHjFWAgG03Hw+N49O5rmNKe0mt8qVZlkvs9TbsGO6GoTm/MKDubQkFJq03c9P0u
	jSMPXq+95xawOnNO1fu8XjuwBqQeNJIlLDw==
X-Received: by 2002:a17:90b:4fc4:b0:38f:57f3:4dc6 with SMTP id 98e67ed59e1d1-3931e304a76mr7286851a91.21.1786630252115;
        Thu, 13 Aug 2026 07:10:52 -0700 (PDT)
X-Received: by 2002:a17:90b:4fc4:b0:38f:57f3:4dc6 with SMTP id 98e67ed59e1d1-3931e304a76mr7286722a91.21.1786630251469;
        Thu, 13 Aug 2026 07:10:51 -0700 (PDT)
Received: from hu-pkondeti-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31ec082633fsm8518276eec.28.2026.08.13.07.10.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 07:10:51 -0700 (PDT)
Date: Thu, 13 Aug 2026 19:40:41 +0530
From: Pavan Kondeti <pavan.kondeti@oss.qualcomm.com>
To: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
        Pavan Kondeti <pavan.kondeti@oss.qualcomm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Steven Price <steven.price@arm.com>, kvm@vger.kernel.org,
        kvmarm@lists.linux.dev, Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Oliver Upton <oliver.upton@linux.dev>,
        Zenghui Yu <yuzenghui@huawei.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Joey Gouly <joey.gouly@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Christoffer Dall <christoffer.dall@arm.com>,
        Fuad Tabba <tabba@google.com>, linux-coco@lists.linux.dev,
        Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>,
        Gavin Shan <gshan@redhat.com>,
        Shanker Donthineni <sdonthineni@nvidia.com>,
        Alper Gun <alpergun@google.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@kernel.org>,
        Emi Kisanuki <fj0570is@fujitsu.com>,
        Vishal Annapurve <vannapurve@google.com>, WeiLin.Chang@arm.com,
        Lorenzo Pieralisi <lpieralisi@kernel.org>
Subject: Re: [PATCH v16 07/45] arm64: mm: Handle Granule Protection Faults
 (GPFs)
Message-ID: <8db602b8-7fd3-4c11-8fbd-3b8251648eb8@quicinc.com>
References: <20260803134403.80630-1-steven.price@arm.com>
 <20260803134403.80630-8-steven.price@arm.com>
 <ans1ZSwMEKeT9Gfz@arm.com>
 <d4bdecca-517a-4b4b-bf67-cef6b09bc8c1@arm.com>
 <7d4e5920-aa20-40cd-954e-037631bd0d6c@quicinc.com>
 <anx6YbPMVz3OlpA5@arm.com>
 <an2YN7kxB7bjCd2s@willie-the-truck>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <an2YN7kxB7bjCd2s@willie-the-truck>
X-Authority-Analysis: v=2.4 cv=R5oz39RX c=1 sm=1 tr=0 ts=6a7dd06d cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=vggBfdFIAAAA:8 a=dIWtD5pVMjQwIhOhhukA:9 a=CjuIK1q_8ugA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEzMDEwMSBTYWx0ZWRfXw8SXLkDUcWZK
 q99fJu3UzuPXxx3yrKy2rpZ3Li92QHFFX+7hGwP1hwQlZkoiOqmPppI/vTiHRFq/EYhswP52IBP
 B2a/PHH0Jt1TiEMh2wcGtORjJ6gdY/vqXbIi4SthVP8Gr/WnOGbB2+m5hSIOau7iBIf1i+04V01
 sZEGiWkh/d2rX3TqtxG3oO4ISklQ5svO6CxQfXs/PzXfRCfdIL25Ig8cmB5Cs+Ny6MC0QXm7aP7
 4IsB5b/fYQ+2zSJspsVDVZk4KW/opGISfzepDEHhVBtT9qw4QGoIwKnqGI1a8sCJ14HDxsJcC4K
 VTTRVc0J7mXc64XT3oDB7L/Xzdi7VAxiDftXB1mzU+Dgj2qiWyoITJr7fcJwyJ0OSsQXf+pb0ER
 RnEFixnjpdXaL6zKGwyhOV57PpSDKsq7IL+adNyUns8e+QxsxUUmavj+MPHzQyxvPoea0DkDxyo
 zCT3AR10jYA2vFyCduw==
X-Proofpoint-GUID: F63eIo9ggnGjEqwvvqZLCEmRo4W74ypQ
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEzMDEwMSBTYWx0ZWRfX0YUzs0zREbDv
 8w5SwETqF3P1zBTTZmp/9Eb05R9KDv+gr4JBDVEvQqSFBB7z8x9Dd8XbT+ycy0echLiFVqqlBsz
 jNB3AhsLGL3gctrXCvzwbcV9L81Cmi4=
X-Proofpoint-ORIG-GUID: F63eIo9ggnGjEqwvvqZLCEmRo4W74ypQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-13_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 adultscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 phishscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608130101

On Thu, Aug 13, 2026 at 11:11:03AM +0100, Will Deacon wrote:
> On Wed, Aug 12, 2026 at 02:51:29PM +0100, Catalin Marinas wrote:
> > On Wed, Aug 12, 2026 at 06:12:09PM +0530, Pavan Kondeti wrote:
> > > There is a valid case for fixup_exception() to be needed here in GPF
> > > handling.
> > > 
> > > -000 |load_unaligned_zeropad(inline)
> > > -000 |hash_name(inline)
> > > -000 |link_path_walk()
> > > -001 |path_lookupat()
> > > -002 |filename_lookup()
> > > -003 |vfs_statx()
> > > -004 |vfs_fstatat()
> > > 
> > > We observed this in Android running Gunyah when the page is mapped in
> > > EL1 but unmapped at EL2. path_lookupat() can actually handle this
> > > via fixup_exeption() when a word load crosses the page boundary.
> > > However, Gunyah injects a Synchronous External Abort and we have
> > > a downstream patch [1] that adds fixup_exception() in do_sea(). pKVM
> > > injects [2] such faults back to EL1 and fixup_exception() is taken care.
> > 
> > Ah, good point, completely forgot about load_unaligned_zeropad(). Since
> > we don't unmap the linear map for delegated pages, we'll need the
> > fixup_exception(). And I guess warning in this case is not desirable
> > either. We could limit it to EX_TYPE_KACCESS_ERR_ZERO and
> > EX_TYPE_LOAD_UNALIGNED_ZEROPAD, though not sure it's worth it.
> 
> Alternatively, I think the series to unmap guest memory from the linear
> map would solve that for gmem:
> 
> https://lore.kernel.org/all/20260410151746.61150-1-kalyazin@amazon.com/
> 

Thanks Will for sharing this information.

There are use cases outside gmem like FF-A lend to Secure Partition.
we may not be enforcing all such memory to be unmapped at EL1, correct?

Thanks,
Pavan
