Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A4535A3B8
	for <kvm@vger.kernel.org>; Fri, 12 Jun 2026 07:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781248870; cv=none; b=gwsWGqVgEL0e1meCsf0+Q0P2RC/xGz5Htk/G2NDgWT0ds8qWCbNZHhIE12r3bySPoJoPViwVTIwQ6LzlpmIOUTNbWFUBRRkzhfXR3Bplt8OsvacZy+AtD8q1w7cuF4GVD7rmOkXbVTb6qo3Iw4Jd9fnn1zAZQCY45wz57g20jPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781248870; c=relaxed/simple;
	bh=Epz5zCxScq1/us4X0c/Fz31V9w84r8Z/mAufB9G17gk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jvcnvhGOixrNYzideNtCfA/4Gvahia+2cTyCzMh9GQxnFRxous8aiP2gAczhGkPWPpSRy2UKR4jQ6e20QtzgqoF3UR/XIDTYsu+/qisUqxX+DLW4ulvAuwWsoAgSKIxSw8u1J+50dKJoC94NEQlm3KIsl/8sJrSkLR9Vq4dVMRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=E3LbRZya; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="E3LbRZya"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65BNU5Vu4146539;
	Fri, 12 Jun 2026 07:20:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Edx9mg
	LO5DnsSqO31NffKKxiZeGgcRggL3RU8RsPKdY=; b=E3LbRZya3Zq9ppNE/Q7tyG
	N0E5vojhe/HnCP4ZQg2ghHA47zrlkVF8oOgm2ayaG0vP3cWWKuCp0P0ad+FgrAFp
	hyo0SOsOsCJfeObJPrq7j213XuXZ2L7fsIB30m9AkLeURFlwSZg8OYdEuXiqmaTR
	7CMOs6xQvr790REGbRJ7SpISQ7xSO4oFtRcr7FcTnpkAEWMIlxobjQTkdwh8A1Vx
	WJ+kNooJEMXcE4SIb3HGYQwSfvpxLO+yDdU/mB+p6EuHAedVO4BWVbFtYsOkRSVF
	9MSaTFleWcwHcG1mVEB+aTushEycVfrkUXcruqS5dSWjvWqPIKDiRx6r55AekPLg
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eqe8c7qx1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Jun 2026 07:20:55 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65C7K0Bh003778;
	Fri, 12 Jun 2026 07:20:54 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4eqe09xrxc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Jun 2026 07:20:54 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65C7KoMY50332156
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Jun 2026 07:20:50 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C16E820043;
	Fri, 12 Jun 2026 07:20:50 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BBB0120040;
	Fri, 12 Jun 2026 07:20:45 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown [9.124.211.181])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 12 Jun 2026 07:20:45 +0000 (GMT)
Date: Fri, 12 Jun 2026 12:50:42 +0530
From: Aditya Gupta <adityag@linux.ibm.com>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
        Harsh Prateek Bora <harshpb@linux.ibm.com>,
        Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Miles Glenn <milesg@linux.ibm.com>, Fabiano Rosas <farosas@suse.de>,
        Laurent Vivier <lvivier@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>, devel@lists.libvirt.org,
        kvm@vger.kernel.org, Misbah Anjum N <misanjum@linux.ibm.com>,
        Shivang Upadhyay <shivangu@linux.ibm.com>
Subject: Re: [PATCH 4/4] ppc/pnv: Remove Power8E and Power8NVL CPUs
Message-ID: <aiuy1bOIZfwnWLCx@li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com>
References: <20260610090800.3672832-1-adityag@linux.ibm.com>
 <20260610090800.3672832-5-adityag@linux.ibm.com>
 <c3abad18-a3dc-4cf8-b552-18946b1dab64@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c3abad18-a3dc-4cf8-b552-18946b1dab64@redhat.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjEyMDA2MiBTYWx0ZWRfX9JYAosxA4sb9
 IPa0vcA5rwQrsUnr0/OVU1/WpBlmnTMHkvx7P8q/EUaPbYIeXNQaF/nw9YRjHkDLsdmPSEytkHs
 +AndwTmGH3foXUNBzQ3sqI6LHVW3Pjk=
X-Authority-Analysis: v=2.4 cv=AYCB2XXG c=1 sm=1 tr=0 ts=6a2bb357 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=pfJ4YV6O0BFcPFKEksUA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: _ARuWuQGQFMj-wjS2hjCv8AVnXJrRUbs
X-Proofpoint-ORIG-GUID: grC5IVX-iXAiUoTsSLTx66I9ShIa-Tlv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEyMDA2MiBTYWx0ZWRfX25mmb75noNL5
 ef0T5Mh2mFOC/4MCR1F0J+tYjuReZWzcSKIWybWqoXTPqC4t7jTmE+tPdPiS6n8tE3+z2pt279g
 GzTrqFoeCAM0OKlqjDnHDX7CSG0Xx7ymGk6V7DJ/ucPDNKg7NLHdziW9IKblt6E1svYofgemjnX
 StokhiGV0txBMsKiVQAnLwH/8O2BSimpbi2lSTSoqJk5Fhu8i72gDQs60ZRSAS8HATKPF1OIuBz
 P4kOsDYdWWTNzN5jeW3OVDlSfiKjKfOisCi3SLybTssWXc7TWNPyo07Bk1wqiL6sf0iY9aI+xKB
 vZYcM64dV0ZB48ZVp9w8Fjotl+DES5Metm8IsgGvMeD5b8+m0L9/coDvyqn2kO6rE5Syp97NLLm
 v+iXXT9eVviyKz/gl+P+cHUVhCirBtwXjRf+FF2dOn+WqMDlfKqgvsf4frUf5tpsrbjTthhgQgI
 4foIxy5GCQXI+Zt4psQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-12_01,2026-06-11_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 malwarescore=0 spamscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 priorityscore=1501 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606120062

On 26/06/12 09:16AM, Cédric Le Goater wrote:
> On 6/10/26 11:08, Aditya Gupta via Devel wrote:
> <...snip...>
> > --- a/docs/about/deprecated.rst
> > +++ b/docs/about/deprecated.rst
> > @@ -215,15 +215,6 @@ embedded 405 for power management (OCC) and other internal tasks, it
> >   is theoretically possible to use QEMU to model them. Let's keep the
> >   CPU implementation for a while before removing all support.
> > -Power8E and Power8NVL CPUs and corresponding Pnv chips (since 10.1)
> > -'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
> > -
> > -The Power8E and Power8NVL variants of Power8 are not really useful anymore
> > -in qemu, and are old and unmaintained now.
> > -
> > -The CPUs as well as corresponding Power8NVL and Power8E PnvChips will also
> > -be considered deprecated.
> > -
> 
> docs/about/removed-features.rst needs an update too.

Sure cédric, will update it

Thanks,
- Aditya G

> 
> C.
