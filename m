Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 407B524CEEA
	for <kvm@vger.kernel.org>; Tue, 26 May 2026 17:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779815136; cv=none; b=Yr++jTNei/h9So1/dcAN1mmJqvX+39C+T5vV8Ysq7+zmpqQkV/1AEyHNge1AMKW1CZlEQ+X61YwEg7XPLFz6cuIKhD32HtJ6ysnMFsOEZLvPg9oBxyXtxAYTdnAgYjHn736KGxZVAIFBzYJxPUL6DmGtBFriDf0KVO0B3wySMlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779815136; c=relaxed/simple;
	bh=Af37uu6qJbTzEUzIv3CRpRglMIvVDZzHvPqpJxuYF+s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VNG27sLU3mG+lhvp0EtTxJWJCUBqIORJt5Wezuh9W5Y2f1RBZf65yF1QEKzXG6CZs85u2gk/0ht49pueRcR1GS3BlsNHERd9Hujptz7xQaCG8zlXUZ+yRkFa8IwOQ6pazZgVHvPLsFaSt21B9xrETJWWehVimuEMzR6O8OxUqSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=lUaZT/yY; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="lUaZT/yY"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64Q9gf7f3031882;
	Tue, 26 May 2026 17:05:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=p8jCAXsmkvIC/i4ObA5lY/GJs3BfBg
	JX1OmSP0SPcm0=; b=lUaZT/yYfKhucJzdNHsmlth4dp6ddjN2Pn1cd3PzAGMqad
	vlghpHDnxRcb+kqWR+HUd/9sfNQNCh70BGcoBVacJyhieCOzXmWWXPqEEppzofuT
	OygNTBolKaTnPh0l8D3htOmRTISRHfzzwLj1YIP73SktRWbxM+E3t4iSDB79tvPq
	XOtsGVNbjtZcfHj+bo+jWR0BM9fTYFyxEFxDHCkSxJ476KAvgMSHG2HtGHTom8Hv
	AmpCSOezQMOnIudV987+cxv2xBG5JA7LrOf7kkfuam4VRp1hnM+io9sEItT57W1o
	JqHe8eFU1h+WmgGMumFEwPDEn58GtXwVrBOlbtRQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eb4nc4ajx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 May 2026 17:05:30 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64QGs6NP006273;
	Tue, 26 May 2026 17:05:29 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ebqjjtcm1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 May 2026 17:05:29 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64QH5Pt226345818
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 26 May 2026 17:05:25 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B6D192004D;
	Tue, 26 May 2026 17:05:25 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 920A42004B;
	Tue, 26 May 2026 17:05:25 +0000 (GMT)
Received: from osiris (unknown [9.52.216.133])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 26 May 2026 17:05:25 +0000 (GMT)
Date: Tue, 26 May 2026 19:05:24 +0200
From: Steffen Eiden <seiden@linux.ibm.com>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Andreas Grapentin <gra@linux.ibm.com>,
        Nina Schoetterl-Glausch <nsg@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>, kvm@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 1/2] kvm: rework memory prefault
Message-ID: <20260526170524.185462-A-seiden@linux.ibm.com>
References: <20260526125220.1560451-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260526125220.1560451-1-arnd@kernel.org>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=VvYTxe2n c=1 sm=1 tr=0 ts=6a15d2da cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=klqDRX_zH8uQnmrxto0A:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: R6rYCEcjygVTByXBqlpqkFqXeGlojEsd
X-Proofpoint-GUID: R6rYCEcjygVTByXBqlpqkFqXeGlojEsd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI2MDE0NCBTYWx0ZWRfX8cT0DiCxEO42
 IOcNvxdo8jmp9dspeDFsp0kiwVixE6nYASXhdW04tl8mlCo86VWPM5mBt5uWTYIlOusS9Ud3349
 j4Yb5sk7VnRhvMRmfNhGwTLkHfLet9rIHWYV/romVaPLJHH1O4y5Li5J26jd84SYp5EkkzFT+IF
 4L/UjpdACAp2ejWDuX09rgLO3KgXZJeC6Ai4hF25Yuh1iCJsnNSGvC5JfmOKymV8aU30NojWR2i
 51HmyHHujnadnMZMv5nlYb6IPRkqc1MUv8YbTUF1AnnpGnM0izlAVDtsLfloc2lFyhrlRMz6Rb+
 qiFfjsb0tvRbC3jT9pk2BjeS734fsGIk+M5ym4jK96AeSanUN2Xvxts6I850PPJ+/zkkO+qPm/6
 gAQGnlRsuwvn9snBlV+onskaOgqhFFp5cyG0n+MyaSIqjgOXURjdVPZ+m3ITSHWTYNkYHq3viKg
 V6LJt8FpTiWhy4nEntA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-26_04,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 priorityscore=1501 spamscore=0 adultscore=0
 lowpriorityscore=0 malwarescore=0 impostorscore=0 clxscore=1011 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605260144

On Tue, May 26, 2026 at 02:52:19PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> When both s390 and arm64 KVM modules are enabled on s390,
> the latter fails to link against the s390 version of
> kvm_arch_vcpu_pre_fault_memory():
> 
> ERROR: modpost: "kvm_arch_vcpu_pre_fault_memory" [arch/s390/kvm/arm64/kvm-arm64.ko] undefined!
> 
> Change the logic to reference this based on a target
> specific macro rather than a global Kconfig symbol.
> 
> Fixes: f67bba50ef56 ("KVM: s390: arm64: Enable KVM_ARM64 config and Kbuild")
> Fixes: 927ce4dee94f ("KVM: s390: Implement KVM_PRE_FAULT_MEMORY")
> 

Thanks for looking into this.

An alternative solution could be for the kvm-arm64 module to just implement the
function as well. The s390 implementation is purely gmap based and has no
dependencies to s390-kvm beside that. arm on s390 kvm could use the exact same
implementation as well. 

I guess this is probably dead code as (I assume) qemu-aarch64 does not use the feature.
But I saw some proposals regarding this feature for KVM/arm64 on the list.

> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> This is not yet an actual problem, but will be when both
> the experimental 'sae' branch and the 7.2 contents from
> current linux-next are merged.
> 
> Not sure who should carry this patch in the meantime, but
> it would be possible to add it to kvm-next already in
> preparation for the upcoming sae support.

I would prefer if you put it in next now. Less patches to carry around.

But If that is not feasible I can add it to series 1 once Claudios patches are
in 7.2.

	Steffen

