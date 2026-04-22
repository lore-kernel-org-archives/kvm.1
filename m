Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A86163D093B
	for <kvm@vger.kernel.org>; Wed, 22 Apr 2026 12:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776861804; cv=none; b=hIyDvrW08ngcQpWDK+tdPpgj5oJ3NucLBP61dnjNwCceaeeNHLXPfh6wgtZIpOHh6PPQjnZcQfY27Gawf0NsqTuGmFWOj+Zgw/K4NLrQxVAwrXJjAfFr7i885riOrvb9ggbFlhj9xWFSR8j/geQhVoGviYDsVQ4mibTttVHV8X4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776861804; c=relaxed/simple;
	bh=5K6jn7Z1uJOQElGR/HuWCs+kpM3wGahMNNkkXFxuEvE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Mime-Version; b=OsHb4ukMcrcchK0/dq/2apaxqnPrkiyqSg3glYnHrgGY/UD6xf9vPJoeCt3dzDoWI1SZOh0vz0PDLsoGdyD7KeAr1JdOfn9Y/4Wslq1YcXqwXcAKs/4KswVE97D+0kItctmmKtFribwGUQOKr+wlV7qmOQjws2Mbl0iN2gVrHgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=gDpeb+w/; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="gDpeb+w/"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63MCXYGL1018829;
	Wed, 22 Apr 2026 12:43:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=pp1;
	 bh=7XjU6IjYXvokyeCkUlmllwrl/vHyY/smkDITM74PZMI=; b=gDpeb+w/iH0j
	wHVecOy4F2hVlS64ZgiiMwDlbMgTAkT/VBLUyRyjWVIuDoduvoUDPY14GlQOxLEg
	5ajqQ00fjjrunoo2syiNrLg2REA8oXlNHYUqG2kWZsT9i66fYUpuWGe+mDaiFVhP
	cln6zxi5dn1nFQX1qP0zw2JgUbFb8d4JiG5bAiqbJiPC2GZUTOPRzv0TmHYAE1+p
	Tm9UzBEx13nH7RhCCMLgxOesFEFz1c7ej1mifCWLptAR5dOluHavxpNuqsdxd9sN
	3Q+nasf/Zn+UT34S6wZZTj9YQhmAdMyIuKlVPMhaBt/Kdu5ta0x51gEDuQfHzvt+
	Kfja+4Ipuw==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dphfravjc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Apr 2026 12:43:04 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63MCZJF8009692;
	Wed, 22 Apr 2026 12:43:04 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dpjkxt81d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Apr 2026 12:43:04 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63MCgabd22413932
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Apr 2026 12:42:36 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 31F4C58052;
	Wed, 22 Apr 2026 12:43:02 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 971D558065;
	Wed, 22 Apr 2026 12:43:01 +0000 (GMT)
Received: from mambor8.rchland.ibm.com (unknown [9.10.239.198])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 22 Apr 2026 12:43:01 +0000 (GMT)
Message-ID: <1addbe9f865c49c14d46934e69faa2fbce2938e8.camel@linux.ibm.com>
Subject: Re: [PATCH 5/8] target/ppc/mmu: Replace legacy ld/st_phys() ->
 address_space_ld/st()
From: Miles Glenn <milesg@linux.ibm.com>
Reply-To: milesg@linux.ibm.com
To: Harsh Prateek Bora <harshpb@linux.ibm.com>,
        Philippe
	=?ISO-8859-1?Q?Mathieu-Daud=E9?=
	 <philmd@linaro.org>,
        BALATON Zoltan <balaton@eik.bme.hu>,
        Chinmay Rath
	 <rathc@linux.ibm.com>
Cc: qemu-devel@nongnu.org, Anton Johansson <anjo@rev.ng>,
        Paolo Bonzini
 <pbonzini@redhat.com>,
        Nicholas Piggin <npiggin@gmail.com>, kvm@vger.kernel.org,
        qemu-ppc@nongnu.org, Pierrick Bouvier
 <pierrick.bouvier@linaro.org>
Date: Wed, 22 Apr 2026 07:43:01 -0500
In-Reply-To: <61318a9d-578d-438c-ac76-e7579f0eb743@linux.ibm.com>
References: <20260319111936.68041-1-philmd@linaro.org>
	 <20260319111936.68041-6-philmd@linaro.org>
	 <0749ae60-f6df-3cb8-bc5d-b46f4c20995c@eik.bme.hu>
	 <d64dff93-7129-4c39-bf9f-d2a8cf2ee4fb@linaro.org>
	 <61318a9d-578d-438c-ac76-e7579f0eb743@linux.ibm.com>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-27.el8_10) 
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: B7pw6W0YUzff9g1c6JKOjSXKO_yJ1_GC
X-Proofpoint-ORIG-GUID: pRaE14Z_xgBRZ90aIsF9K3O8qLetJtpX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIyMDExOCBTYWx0ZWRfX83orUeRWvSXu
 n2uNut6TPzKMMbXqqv/tgw3m2J0smZ1JlPp+6y5ijjszuvuuSOX7jQ8sxP+3wMtP5vCVEGemHy4
 IqquPadWQlsLmrWSpwPQp0+3GtRwI3ZKgbEbYNizFNix3qs7oHSZKC6YObVnHHylsF4JT06aOIR
 b/cQwyTpXFrh2FVFyXiBY/IFJ8S3HWjXpzFf3t8e3DuV4KsZDoN4ZZZNvc9A4hpB+aRTVFg6xUA
 gGABrwL1J4Ou5Tpd+8Mn+dKn2dpVIKzDKYZIsAX8mMQ4zyQXssDtBFIOFHMO6akOY636I0HDPBg
 8dHN8eH9OFPw4taGchXs5DLDvZFBYwjaMVeK/GEw+netU+xDKuSlqfy5GlnbGOMAIjUltmj8Ceg
 Kl9kEH19Kd0xBz/s9ybdCuQXuu07q08loD33G39C9dkl40hMB0xJDTBnO0sgR3DwyO4UJNGCQrQ
 Zudj1O5nA44qXe+JIfw==
X-Authority-Analysis: v=2.4 cv=SJxykuvH c=1 sm=1 tr=0 ts=69e8c259 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=15XlJfaKZFHMnxYhEdIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-22_01,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 lowpriorityscore=0 phishscore=0 clxscore=1011 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604220118

On Wed, 2026-04-22 at 12:42 +0530, Harsh Prateek Bora wrote:
> 
> On 19/04/26 9:40 pm, Philippe Mathieu-Daudé wrote:
> > On 19/3/26 13:59, BALATON Zoltan wrote:
> > > On Thu, 19 Mar 2026, Philippe Mathieu-Daudé wrote:
> > > > Prefer the address_space_ld/st API over the legacy ld_phys()
> > > > because it allow checking for bus access fault.
> > > > 
> > > > This code however doesn't check for fault, so we simply inline
> > > > the calls (not specifying any memory transaction attribute nor
> > > > expecting transation result) per the definition in
> > > > "system/memory_ldst_phys_endian.h.inc":
> 
> Nit: "include/system/memory_ldst_phys_endian.h.inc"
> 
> > > Recently when trying to remove _nomigrate memory region functions I 
> > > was told if some convenience function has more than 1 use it's 
> > > probably worth to keep it. This looks like similar case even more so 
> > > as the replacement is unnecessarily more complicated. So what's the 
> > > problem with ld_phys in the first place and why do you want to replace 
> > > it with a less convenient function? If there's a reason maybe say that 
> > > in the commit message.
> > 
> > We want to remove the legacy API because it does not "allow checking
> > for bus access fault." The cases where we can safely ignore it are
> > rare, and often ignoring it led to subtle bugs.
> 
> It would be nice to have an ack from BALATON or Glenn as well since rest 
> of the patches are specific to pegasos/ppc32, although no funtional 
> change intended here.
> 
> If we do not have any further comments from them/others, could you
> please post v2 addressing the comment in patch 2/8 reg keeping 
> declaration within !CONFIG_USER_ONLY block? It  could be moved to one of 
> the existing block as well.
> 
> Thanks
> Harsh

Makes sense to me.

Acked-by: Glenn Miles <milesg@linux.ibm.com>

Thanks,

Glenn

