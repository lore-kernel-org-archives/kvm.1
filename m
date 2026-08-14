Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 933303F075A
	for <kvm@vger.kernel.org>; Fri, 14 Aug 2026 08:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786697153; cv=none; b=CJcbktba/cTGupLHzdpEgkphK84rmfjsJ480u+o2Y8K+090WEZ7hlgdf9jZOypiJYdcBOlSNXEabOyuf92Lf015WvbDfzzDNTldCsLJYCS8mLdlPB5tkihKtUxq/UiULXiHPKPcLVsJjUUV/3Wd+TYwuUdr56e3m5PlMqDArMhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786697153; c=relaxed/simple;
	bh=i1c8AJsS/6BsMSz6FYSuta5r13xz+bKehed37J4V0no=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cPTej+ke87Ht9IECxQMg4Qa6KzZ3Y47LcuWpdJZ7t0gaoUUKstIukNhhsrXhP8Jfpdwigpv+pM0zhBl5cC8b6BFEjBHC4xmEmryOmlrtGEKkxe8AJADAc3t/KKLIOxEm4EoJtKX82RZKMmVpUoBYvJyxTP6drdxqQiIdsxUXw/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ADAGnN/k; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MzrXRA9D; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ADAGnN/k";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MzrXRA9D"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67E7fbdI2166355
	for <kvm@vger.kernel.org>; Fri, 14 Aug 2026 08:45:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=EVIasMr6ok/pt36pC50hDKA8
	cdlBEv5jazPUbRxQ61M=; b=ADAGnN/knxZwKwlqppLvR3DFXAywgoljCOl+bDim
	5OT8g8p1fI+jfG4Tv7QmaNjNoeROItyK5SqhEbWTo+zwlTjzwWTP3rVzs7ks7eIY
	a9/wsuMj/CE+x6BLqTjGCH8HL1HkoDlnDzR10GS+cDQhgoiRg3jkBzXjfZSAJ8kG
	+fjd4JynOdTTM2sRCQ1iC9vxldRXmga4ert1Llf1Nf4q2HqFf6ttwkmJ21iRqLLv
	+Bv1jYNq+LORKb8xk1UyJBCgl4rnQTu0k4KEDFcJ70xHPUngeLqlZrjkMMvD0PbN
	dCCT9KOOgCVVZF9bS+tojskYCm9xmevmrwLRAEJpHfgm3g==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g1j2nk521-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Fri, 14 Aug 2026 08:45:51 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-c9fe4c5eb39so527721a12.1
        for <kvm@vger.kernel.org>; Fri, 14 Aug 2026 01:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786697151; x=1787301951; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=EVIasMr6ok/pt36pC50hDKA8cdlBEv5jazPUbRxQ61M=;
        b=MzrXRA9DF6+UOrwvYcgqqvQPHWlC6bZlBCsAPN14n0/kHJRcUVL1+cbFNmOOrQ+ETl
         lMqYy60qaZazRd37kRLmzoSKpiLhnA83tfxRdnFyo7kc2+vedDjabKZf5eeQtQY2LH6A
         4RUgM9vp1QmxkUarbznMCnsw9uXVadVPuyXv4hiEncHo7FvG1C8nkgnyXwJ+0eIXm8hY
         nDtx09wY3BQn/RpUsJ6Md6qs48DcmrRgARP4X67md7hpSYEvVTjOlZxCJhCSnEigP1gr
         Grx4V28O6eA7UrNjkIdqtwcRk4AXPiavrVtovJzuwaBfKgNz05aLnGpUnUsOASsKTVHz
         vGeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786697151; x=1787301951;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EVIasMr6ok/pt36pC50hDKA8cdlBEv5jazPUbRxQ61M=;
        b=n6sp4HS0GmOSbUlSMdZUTYT7SYuA/ZdXglue7kDDLrUk+mKJuAvPXxIdDrSYwyF1ZT
         xN8tCgVLu+hnmdkJ8Cz/ikU2DHYP3b9yF5j9Jb6f7ibUoBBU70nzwjaIEXhDH4gWYQEH
         QdUAWxKj+DRt97tlrddBR0+rstqepNLknhB+T53qvQL9Zp8SMGWRuUMFZjA1rp8kuras
         AZkqGBHHDXlFNt3aHIDO6Dmgn+KL4cTpEi/wtxZJPg+jrqxs8XbOAhD3LAcBInD3KDyU
         K9/MBi19EffAS6RTGYxNU9MLHlCYvtNT4qCEaMsGSpBrvreET7EJVbTLBmGDYZ+EYpJV
         rAhw==
X-Forwarded-Encrypted: i=1; AHgh+RqVEM63SvVh/FYNG1DN70wDtSQlV5CDFbZatsVR8AxgQfXuk1mTScJ8uXvGfnj8/XOlco0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZXK9Pw2ptf2WmUJWpuQMPQ8xgveyd/NSNHND5wv+/ItRVJtY4
	bf3sGSA7hE/YmpPJwI3v1t+PSPA+RI8ZmDTtzviKGf9+mgJtKf0LasVnswp9tOXwKFZtyvYB6A6
	pvNo7/cykldGIG5P6I9sZiCuguI57zm/FV73ZehpgwVwhcceKLUMLL0Y=
X-Gm-Gg: AR+sD1071yeXlBiYCMpx7aA9S6NykPH7alDCGlj+KvJi3OHeb6Y0Sh8vDJKiqdaYozA
	aeP/BWWpAufP6Lu2jLAX0pVe+U72infkP8FdEmE1B+8vLrwwp0qy4kRU+fhxwrnRjUrvQlOKW5x
	3ciBOxbYRDsZJlX0/ZKlD8b90XllfMFW47TBU7W6TRZ75W9r7VJlz/Bq4YHrNXPu/L9VA0OJ9TE
	a/JfiLMGarg6YCuWy4xamqKPDiObmSqs/j9PjoNsXpNCm8Nb3v77GDP/4fjowhLpHGlz3wmNJmF
	0xMYYZjw/ClyYM3cGC0eIZmuFCQncuHhRv8SUrY/LYpE14FOIWaTkFZxSmfwffla6+aTq1Qb69s
	tVAeeRoVuDcg1E+lfCCfL6biA4XbHQaUHQA==
X-Received: by 2002:a05:6a20:430d:b0:3c3:bbe6:95de with SMTP id adf61e73a8af0-3cc71d533c0mr4527068637.6.1786697150988;
        Fri, 14 Aug 2026 01:45:50 -0700 (PDT)
X-Received: by 2002:a05:6a20:430d:b0:3c3:bbe6:95de with SMTP id adf61e73a8af0-3cc71d533c0mr4527037637.6.1786697150586;
        Fri, 14 Aug 2026 01:45:50 -0700 (PDT)
Received: from hu-pkondeti-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-320e9df03d4sm1808869eec.15.2026.08.14.01.45.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 01:45:50 -0700 (PDT)
Date: Fri, 14 Aug 2026 14:15:39 +0530
From: Pavan Kondeti <pavan.kondeti@oss.qualcomm.com>
To: Will Deacon <will@kernel.org>
Cc: Pavan Kondeti <pavan.kondeti@oss.qualcomm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
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
Message-ID: <5b557560-7664-4336-9e5f-86de8dcd6d90@quicinc.com>
References: <20260803134403.80630-1-steven.price@arm.com>
 <20260803134403.80630-8-steven.price@arm.com>
 <ans1ZSwMEKeT9Gfz@arm.com>
 <d4bdecca-517a-4b4b-bf67-cef6b09bc8c1@arm.com>
 <7d4e5920-aa20-40cd-954e-037631bd0d6c@quicinc.com>
 <anx6YbPMVz3OlpA5@arm.com>
 <an2YN7kxB7bjCd2s@willie-the-truck>
 <8db602b8-7fd3-4c11-8fbd-3b8251648eb8@quicinc.com>
 <an3ihGk3znnk8TWV@willie-the-truck>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <an3ihGk3znnk8TWV@willie-the-truck>
X-Authority-Analysis: v=2.4 cv=ApXeGu9P c=1 sm=1 tr=0 ts=6a7ed5bf cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VwQbUJbxAAAA:8 a=vggBfdFIAAAA:8 a=KKAkSRfTAAAA:8 a=oGdhJ8GHBgxCdCDN5qoA:9
 a=CjuIK1q_8ugA:10 a=_Vgx9l1VpLgwpw_dHYaR:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: c-e2puN_gUoZCp0ALUUJa7AO_lJchFJs
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE0MDA2NiBTYWx0ZWRfX9LbVVz5bIvXd
 OI7riu1LC3ZkYhZ5lVYIx/d/LDtzTCpg24I0pgqa/YTrJ92DUMnBQQ6+hI7dwhdD4dbAIi9Z7Eg
 YAqNcWUCZH5mC26a8z9SYVnPCa+F0Yw=
X-Proofpoint-GUID: c-e2puN_gUoZCp0ALUUJa7AO_lJchFJs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE0MDA2NiBTYWx0ZWRfX2sfD0b7c47n1
 uaX1pSURUJ/VSydiKKIAw1XZrWisCbKVmytJXQa8odK/cFNTDBIB7QMhmaMXc3DdMD7BIKmlW/+
 WofFL2Iyh1RCQw/E2KLCM+W/ZIY+bycy6ApnLsc4sMMUsimF+41QD1BHvJgJIMc4r0L+cmWC5T/
 2hvj/TmUkDNEfFB94kqaBsDwFDxxTFYlX3Cz7KZQW+KxwfASpJoNz4EP80uE9ERE2B8m67t1+tJ
 eyqQue36he2O+QOBVAz35iJ6RLN+ppsR8wlk33qpEFmcRK5VY7eSqYi4pcE175zuzlUyQeYHfam
 TMqOEIXuWzgLdJdUbiUwC5jE180lCuxxvmLXzjIvHBszK7GStCTwZfgozcbjIl9T73re5OgAzua
 ijeMK5yqnUIoZexV3MHAxCwDOfM9EGvW4UWhRgtDadcnBVbiJa5QAnse05zYQjdm+FPiqPHxt6L
 gDD5tn8ZrB72T82H9Hw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-14_03,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 impostorscore=0 clxscore=1015 adultscore=0
 suspectscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608140066

On Thu, Aug 13, 2026 at 04:28:04PM +0100, Will Deacon wrote:
> On Thu, Aug 13, 2026 at 07:40:41PM +0530, Pavan Kondeti wrote:
> > On Thu, Aug 13, 2026 at 11:11:03AM +0100, Will Deacon wrote:
> > > On Wed, Aug 12, 2026 at 02:51:29PM +0100, Catalin Marinas wrote:
> > > > On Wed, Aug 12, 2026 at 06:12:09PM +0530, Pavan Kondeti wrote:
> > > > > There is a valid case for fixup_exception() to be needed here in GPF
> > > > > handling.
> > > > > 
> > > > > -000 |load_unaligned_zeropad(inline)
> > > > > -000 |hash_name(inline)
> > > > > -000 |link_path_walk()
> > > > > -001 |path_lookupat()
> > > > > -002 |filename_lookup()
> > > > > -003 |vfs_statx()
> > > > > -004 |vfs_fstatat()
> > > > > 
> > > > > We observed this in Android running Gunyah when the page is mapped in
> > > > > EL1 but unmapped at EL2. path_lookupat() can actually handle this
> > > > > via fixup_exeption() when a word load crosses the page boundary.
> > > > > However, Gunyah injects a Synchronous External Abort and we have
> > > > > a downstream patch [1] that adds fixup_exception() in do_sea(). pKVM
> > > > > injects [2] such faults back to EL1 and fixup_exception() is taken care.
> > > > 
> > > > Ah, good point, completely forgot about load_unaligned_zeropad(). Since
> > > > we don't unmap the linear map for delegated pages, we'll need the
> > > > fixup_exception(). And I guess warning in this case is not desirable
> > > > either. We could limit it to EX_TYPE_KACCESS_ERR_ZERO and
> > > > EX_TYPE_LOAD_UNALIGNED_ZEROPAD, though not sure it's worth it.
> > > 
> > > Alternatively, I think the series to unmap guest memory from the linear
> > > map would solve that for gmem:
> > > 
> > > https://lore.kernel.org/all/20260410151746.61150-1-kalyazin@amazon.com/
> > > 
> > 
> > Thanks Will for sharing this information.
> > 
> > There are use cases outside gmem like FF-A lend to Secure Partition.
> > we may not be enforcing all such memory to be unmapped at EL1, correct?
> 
> If you leave the cacheable linear alias of memory intact across an
> NS -> S transition, then you're in for a bad time [1].
> 
> Will
> 
> [1] https://lore.kernel.org/all/20221114110329.68413-1-manivannan.sadhasivam@linaro.org/

Thanks for the reply. In the above case, XPU does not like the speculative fetches. I am
not sure if there is a hard requirement for unmap of FF_A memory lent to secure
partition managed under Root with GPT.

Thanks,
Pavan
