Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55B8434A786
	for <kvm@vger.kernel.org>; Fri,  8 May 2026 14:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778251240; cv=none; b=qUheVs2dU2OLrMj8h8arVUHmS9LSCspdTzyHHrUn9PU3cVe0juaGM6zpMe0qLL0gbgaDSTgzwvAPRdndlZbvTIiHzTZoch7DpAshAZ4pQ46hztgnPwhov0sdtS8o/k1lZuC+x2wALBoONvaN9BvmsUjOtSRbdZKg5TF5EEWuOAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778251240; c=relaxed/simple;
	bh=xwZMji2Zx80akotCHZK4dz+Rspg6H0dz7mDTGb0nAps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ers2c5EIUFgUlnf3wYYf21sPrS5EkyvjzLvxpNZlIjBWmNtsFfHrzcWOdZsRVPJNSJUIhcEDoP1SbjlkdUAMtfOv2txBSrSyR1QOfzEzp7CZhYteJuIRowixWIEPl60VGRt1U4nM7hQQxXLA1RhBOiExFBBN1wh+sTz7BXKhTL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=FxRjuhDL; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="FxRjuhDL"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6489JWEJ1421455;
	Fri, 8 May 2026 14:40:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=UGQIJR35lOWQFPNEK3jXlvXWBID0LH
	7cMWoYwu1OCyM=; b=FxRjuhDLiXRO/j3jWXVabfOukC7biLH+w26wBqsnTxf5ih
	YqvB+ZVcSxs68Wb9lGMzviFTD+a00MPHoW1tIT+Q5NORIxNA+qA58PPphBzvAzft
	G79hQs0Q5DLmyIahen6aJuT48FTi+2KmDjKKcPWC6pvXkXnHecNJol8lGW0OFO6Q
	qdX6NoipYjVH+YSCb/7mImoZ3ANK4d0ZqoNAjkgwHwm7nKYg6R207JyyAF9psVRW
	4MvaWl7nTaouSPJptxVpvlZN11H4efF8z4TsU4zkiokR7luqngRAVtGZU/3wfkzB
	Tdtl8PbjaNMPEUcRFb+XZQDxTmhEIp2gBegNfgbA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9x546et-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 May 2026 14:40:31 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 648EdX0o000612;
	Fri, 8 May 2026 14:40:31 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dwx9yrah1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 May 2026 14:40:30 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 648EeRYP48103762
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 8 May 2026 14:40:27 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 86D7B20043;
	Fri,  8 May 2026 14:40:27 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9330120040;
	Fri,  8 May 2026 14:40:25 +0000 (GMT)
Received: from Gautams-MacBook-Pro.local (unknown [9.43.123.155])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri,  8 May 2026 14:40:25 +0000 (GMT)
Date: Fri, 8 May 2026 20:10:18 +0530
From: Gautam Menghani <gautam@linux.ibm.com>
To: Amit Machhiwal <amachhiw@linux.ibm.com>
Cc: Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-ppc@nongnu.org,
        Vaibhav Jain <vaibhav@linux.ibm.com>,
        Chinmay Rath <rathc@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
        kvm@vger.kernel.org
Subject: Re: [PATCH v2] target/ppc/kvm: Fix const violation when trimming CPU
 alias suffix
Message-ID: <af310sWYO_VGZAVB@Gautams-MacBook-Pro.local>
References: <20260508081416.1014-1-amachhiw@linux.ibm.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260508081416.1014-1-amachhiw@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA4MDE1MCBTYWx0ZWRfX9HRruvHJ53mK
 AD1fW3m873fjBAWIZ+HMJNeh2JkfWdEXYAJQT2AR9pXdNeYZiAjcOEwCpIa5Y2UC4LNpJE5LHN0
 zNxiOIC8KJge3RpYRD5BuPCn1H77qB8i8jQKj0cf3tTEL8qm/niaPXIKNIWETSe3VoVk1L3gx/I
 eTmzJSbID6lc8wTiDctCGaUwXpcQszNNxjgGjM/laH4HktifLpBZbk9kNF0Eme6aMSuEQCxs+QT
 X7yt5nobC5ltlru7lo10HnBCoyx23ehcyEb3dw+QedXT7vgWEH39Vx++gJim9++Z6QNv7FnjE2F
 XQBNxx+MVwsxFF7QFovrkTLre+YE/dPoRq9CFC3QAPz+bIflJtTsuLNApBCFePY6/tCuVESCHiI
 f1SszqZjaluwCtAD79HBMvJ5YsxqiUeIgHUoW4vcPpNGm5MaVLtZVaINF57IJZkLl2NIpWan4ca
 XtJogw8njTQTp1lyZNg==
X-Proofpoint-ORIG-GUID: u3cIkF83GjxwtAgkYCFsiipcXZjQ-2iF
X-Proofpoint-GUID: JwRJlAL-d3wjrXbI_QUNjXkKtDtygl1c
X-Authority-Analysis: v=2.4 cv=W7UIkxWk c=1 sm=1 tr=0 ts=69fdf5e0 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=XwvHTvS55sOcZ4le1skA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_02,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 spamscore=0 clxscore=1015 phishscore=0 bulkscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605080150

On Fri, May 08, 2026 at 01:44:16PM +0530, Amit Machhiwal wrote:
> GCC 16 tightens diagnostics around const correctness and now correctly
> rejects attempts to modify strings referenced through const-qualified
> pointers. In kvm_ppc_register_host_cpu_type(), ppc_cpu_aliases[i].model
> is declared as const char *, but the code was using strstr() on it and
> then modifying the returned pointer in place to strip
> POWERPC_CPU_TYPE_SUFFIX.
> 
> This results in a write through a pointer derived from const data,
> triggering a build failure with GCC 16:
> 
>   error: assignment discards 'const' qualifier from pointer target type [-Werror=discarded-qualifiers]
>         suffix = strstr(ppc_cpu_aliases[i].model, POWERPC_CPU_TYPE_SUFFIX);
>                ^
> 
> Fix this by duplicating the model string into a mutable buffer using
> g_strdup(), trimming the suffix on that temporary buffer, and only then
> storing it in the alias table.
> 
> This preserves the existing behavior while avoiding modification of
> const data and ensures compatibility with newer compilers.
> 
> No functional change intended.
> 
> Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
> ---
> Changes in v2:
>   * trim the duplicated buffer before assigning it to ppc_cpu_aliases[i].model
> ---
> 
>  target/ppc/kvm.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> index 25c28ad089c6..c2843b1421cb 100644
> --- a/target/ppc/kvm.c
> +++ b/target/ppc/kvm.c
> @@ -2654,13 +2654,14 @@ static int kvm_ppc_register_host_cpu_type(void)
>      dc = DEVICE_CLASS(ppc_cpu_get_family_class(pvr_pcc));
>      for (i = 0; ppc_cpu_aliases[i].alias != NULL; i++) {
>          if (g_ascii_strcasecmp(ppc_cpu_aliases[i].alias, dc->desc) == 0) {
> -            char *suffix;
> +            char *model, *suffix;
>  
> -            ppc_cpu_aliases[i].model = g_strdup(object_class_get_name(oc));
> -            suffix = strstr(ppc_cpu_aliases[i].model, POWERPC_CPU_TYPE_SUFFIX);
> +            model = g_strdup(object_class_get_name(oc));
> +            suffix = strstr(model, POWERPC_CPU_TYPE_SUFFIX);
>              if (suffix) {
>                  *suffix = 0;
>              }
> +            ppc_cpu_aliases[i].model = model;
>              break;
>          }
>      }
> 


Reviewed-by: Gautam Menghani <gautam@linux.ibm.com>

> base-commit: ee7eb612be8f8886d48c1d0c1f1c65e495138f83
> -- 
> 2.50.1 (Apple Git-155)
> 
> 
