Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0166940A929;
	Thu,  6 Aug 2026 16:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786032746; cv=none; b=W1h/qgfDcjKX/C3QAyQbVIAOuiSsmImRIO2XTIWdRdxzoY2UxHpHmkwCXhCauTLk9E576BmMZJ7NPMTeGT4unVX7SIIBho0FduPt2bVrwbOtof3+qOgFvP4ldQm4dUY5Gl7myhpo0PZ9mtszkRC8mlIfW5hy+CxzIyEnH+q1eR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786032746; c=relaxed/simple;
	bh=Q4HhE6XD70iKDYRD/I2MMehkx88oOzeEZcgo0T3R/W4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ngKubLdzA3UTNg599YV32CN/XfOGgFnywr5C8/F9x4wvwp3Kq6OeuaMCeVayjJFPslGqn/iak1bbjHox0zZJJ+I5MJOTs+7AOvfi27MH8SJnDmN88Ci5an5E31gN0+fK6XIqjhwUh11JOU9JWfox4msp5W88SWcwykLpjrsyYcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=fVj1ZPGF; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fVj1ZPGF"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 676Enro12867338;
	Thu, 6 Aug 2026 16:12:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=6rDKwf
	D5GSf1Sk/Gon0tFdsjy8UcaATvakhuDdlk1EY=; b=fVj1ZPGFfxErD7PSXOryFA
	hRm0jRW2YVCRxKOz65OPvE64KgsVNLL0Rs8tPeTq/0z2WKPWsDKji8FUtNp6rUCs
	z4O4DXyJFCBBhC5GRyIkXuRKntppWLFNV7A3SAFAflZag3rvTsyLh96g9bxJOkRY
	k/2/IIIO2OJGcQ1zsOkX+FgRg+gWxpOytk0mbJjUUYr+pX+KRKmUFk0Xeso0SlwL
	IEuWtXlzZrAYTJJBDTZlhqJIGFOCEHrVvSsREHteCCfpIWX7Auuq/ew+Bzn/l5jV
	4WLoC52v5y2mJFfe0Fc15p9WKcZG7GoiE/QuDEEDDo7mYeld6DY/Gn7AmsJjlEhg
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs77ggpcm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Aug 2026 16:12:22 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 676GBG6w013624;
	Thu, 6 Aug 2026 16:12:21 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fswtyup6x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Aug 2026 16:12:21 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 676GCHBp14680398
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 6 Aug 2026 16:12:18 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C440920043;
	Thu,  6 Aug 2026 16:12:17 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E4C7320040;
	Thu,  6 Aug 2026 16:12:16 +0000 (GMT)
Received: from fedora (unknown [9.5.7.39])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu,  6 Aug 2026 16:12:16 +0000 (GMT)
Date: Thu, 6 Aug 2026 21:43:06 +0530
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: sashiko-reviews@lists.linux.dev
Cc: Amit Machhiwal <amachhiw@linux.ibm.com>, kvm@vger.kernel.org
Subject: Re: [PATCH v6 3/4] KVM: PPC: Book3S HV: Add support for compat CPU
 capabilities for KVM on PowerNV
Message-ID: <20260806214117.8a2ca150-97-amachhiw@linux.ibm.com>
Mail-Followup-To: sashiko-reviews@lists.linux.dev, kvm@vger.kernel.org
References: <20260804180705.59160-1-amachhiw@linux.ibm.com>
 <20260804180705.59160-4-amachhiw@linux.ibm.com>
 <20260804182718.2B4581F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260804182718.2B4581F000E9@smtp.kernel.org>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDEyMiBTYWx0ZWRfX8jLl9UjXWqDh
 040h7BnbKCyxricanIqtAGKCMZ2hBS1aJNZiHK3K/p+rcNnBZG7ljXE63MAzaw58TxE1VijCTgu
 Ku/dav2x7svUz2bQF0o30wmM2s49g+twvDCiDnVmtsLMb1lWrHed1XYngDlFNl7JHjp2hb1z33Z
 E/4Nc4sw10MwNhLIU5ZEasoMp5zCrVp0+FhmW9oYnkD8KoxxBs/WjUV9sUBqjQ3jxltpsfTb5Yn
 PS2PHjz4NiUFham+7XYE9bp3y8J2PA95XbwNpmV7sWj/07cxHzz+r0fzd7IjSmEZi96NUJQMsMr
 127JHPaC6TMjqEYK7ubgTSxd5M6BK5Ya3x2fT5RZmzyp4unx6RDqzbQatZbtbjU5u602eMxsRFW
 yFWCDMDhj6NH5Pfm6i04a4ZdDGTNyyZ41kMIrliyMZrIAQrGbwT24ELmpPrD3W/58N/UmF0XsIF
 s3K7RCg6EpDzDe2mGmA==
X-Authority-Analysis: v=2.4 cv=WIFPmHsR c=1 sm=1 tr=0 ts=6a74b266 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=c92rfblmAAAA:8
 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8 a=dZd95PsC8Njksj5HCb0A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-GUID: EFcQcwbvhBSTcs4QEpCkGJfXdAisWu6l
X-Proofpoint-ORIG-GUID: EFcQcwbvhBSTcs4QEpCkGJfXdAisWu6l
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDEyMiBTYWx0ZWRfXxk+B2xEpKns3
 ibGUbVaXCN+fnDd972rtHS+D/KWyE9VIibcPZ3mXtSw7d6V3nV2bqXso/OnqUci17fzP/frlDfb
 dCoStFR7RXplVAY116VYB3SRIcXXxa4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-06_01,2026-08-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 suspectscore=0 clxscore=1015 impostorscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608060122

On 2026/08/04 06:27 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] `kvmppc_get_compat_caps()` incorrectly returns `-EINVAL` when the 'cpu-version' property is absent, breaking the `KVM_CAP_PPC_COMPAT_CAPS` contract.
> --
> 
> --- Patch [3]: [PATCH v6 3/4] KVM: PPC: Book3S HV: Add support for compat CPU capabilities for KVM on PowerNV ---
> commit b4de9c28bb9d6eeb95ed5310169709b332b6f664
> Author: Amit Machhiwal <amachhiw@linux.ibm.com>
> 
> KVM: PPC: Book3S HV: Add support for compat CPU capabilities for KVM on PowerNV
> 
> This commit extends host CPU compatibility capability reporting to support
> nested virtualization on PowerNV systems. For nested API v1, it derives
> compatibility capabilities from the L1 guest by reading the cpu-version
> property from the device tree and maps it to the corresponding compatibility
> capability bitmap.
> 
> > diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
> > index 8799124b80960..77558f6eed864 100644
> > --- a/arch/powerpc/kvm/book3s_hv.c
> > +++ b/arch/powerpc/kvm/book3s_hv.c
> 
> [ ... ]
> 
> >  static int kvmppc_get_compat_caps(struct kvm_ppc_compat_caps *host_caps)
> >  {
> > +	struct device_node *np;
> >  	unsigned long capabilities = 0;
> >  	long rc = -EINVAL;
> > +	u32 cpu_version = 0;
> >  
> >  	if (kvmhv_on_pseries()) {
> >  		if (kvmhv_is_nestedv2()) {
> >  			WARN_ON_ONCE(!nested_capabilities);
> >  			capabilities = nested_capabilities;
> >  			rc = 0;
> > +		} else {
> > +			for_each_node_by_type(np, "cpu") {
> > +				if (!of_property_read_u32(np, "cpu-version",
> > +							  &cpu_version)) {
> > +					of_node_put(np);
> > +					break;
> > +				}
> > +			}
> > +			if (!cpu_version)
> > +				return -EINVAL;
> 
> [Severity: High]
> If an L1 guest is booted in native mode (e.g. without a 'compat=' setting in
> QEMU), the cpu-version property is intentionally omitted from the device
> tree.
> 
> Doesn't returning -EINVAL here cause KVM_PPC_GET_COMPAT_CAPS to fail,
> thereby breaking nested virtualization initialization for native-mode L1
> guests?
> 
> Could this fall back to deriving capabilities from the physical native PVR
> instead of returning an error?

The premise is incorrect for the context where this code runs. This code
path is guarded by kvmhv_on_pseries(), which is true only when the
kernel is running as a PAPR guest (under PHYP or KVM on PowerNV acting
as L0). In that context, the `cpu-version` property in the guest DT is
always populated by the hypervisor (PHYP or QEMU) with a logical PVR
value including for native-mode guests. This is standard PAPR firmware
behavior and is documented in the PAPR specification.

For KVM on PowerNV (L0), the L1 guest's DT is built by QEMU which sets
cpu-version to the negotiated CPU version. For PHYP-managed LPARs, PHYP
always provides cpu-version regardless of whether the guest is in compat
mode or native mode.

The `if (!cpu_version) return -EINVAL` guard handles only the case where
of_property_read_u32() fails and leaves cpu_version at its 0
initialisation value — which would indicate an unexpected firmware or DT
construction error, not a normal native-mode guest scenario.

> 
> > +			rc = kvmppc_map_compat_capabilities(cpu_version,
> > +							    &capabilities);
> >  		}
> >  	}
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260804180705.59160-1-amachhiw@linux.ibm.com?part=3
