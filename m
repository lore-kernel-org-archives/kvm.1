Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F4F3B8D4F
	for <kvm@vger.kernel.org>; Mon, 29 Jun 2026 11:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782732534; cv=none; b=E0p/WOizf0dl+v2CXrw3Z+LrcRjBrlB4AWe+yMwLKyLelkIpJK0siqpsDqUXy95t/yUqGpaBndgPYfLq/CynqyFo5cjM2IrgjLtdjnm3jSxnR/lAYyHRSnVkbT0cSHVs1ORoqBWqy97PBt71mQiRnNZgwsVK5M9KQKUoZSXD1xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782732534; c=relaxed/simple;
	bh=GfWY4Gog4U1OL7v/9+lwrG9v8e0Vx/8dAgrsM4bcNhM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=peK9Xji6qsB2CiN6oIjxfcXc4gLM8NN5PxxtVkAhQxchTobcGG95+9+O5k3ZdSfXp1ElCiMlDldPgh0ssgcib7p6exwj+hCIW0YsJwC8ndDJmJwIyeKMyrNBOwMHDJiMWz3u+b34a9L3I+/VazciJUJRd3GrT7ZBklXMS/WbuW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=DkwgYctW; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="DkwgYctW"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65TAmHhT3181643;
	Mon, 29 Jun 2026 11:28:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=zDb8aJ
	S9rpe/kG9btdc9b3Blf+e1Jb6pSyjnZmLQ4X0=; b=DkwgYctWRkAyQkxfPFfAfW
	RWISSZ10zXHIxVG4TiB7SKvuXpQ9uR6i6r7GZWgj7sqguvkqx5xdUEBGcXFyHRYl
	vwqAz0ZQixeVYG/vdry+FPG1pOgGn2P/X3TzIr23a4g2QCb4DczblhRs5chzplGj
	ji/LT1I+D2pRVOP+2fVWCm4t1MRft1udfvb5Rq5x5Ju7SOkH0MMraLDz9o2/fj5i
	yd8x8VYL67lu4hooL3LzucP2AiYUFOyAisYSbogVPtwpFJYyFJc3Rre1mA3Eshwc
	7SK+IowjESSEIdEsSR+sqnWO5Ez/hXzGnzXYwKEUv7AGIdlLRSykAhPjg2+UXkXw
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26qfrynd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jun 2026 11:28:33 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65TBJftG010968;
	Mon, 29 Jun 2026 11:28:32 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f2uhy4we3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jun 2026 11:28:32 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65TBSSx336438392
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Jun 2026 11:28:28 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5D05E2004F;
	Mon, 29 Jun 2026 11:28:28 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AF50A2004B;
	Mon, 29 Jun 2026 11:28:23 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown [9.123.10.203])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 29 Jun 2026 11:28:23 +0000 (GMT)
Date: Mon, 29 Jun 2026 16:58:21 +0530
From: Aditya Gupta <adityag@linux.ibm.com>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
        Harsh Prateek Bora <harshpb@linux.ibm.com>,
        Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
        Shivang Upadhyay <shivangu@linux.ibm.com>,
        Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
        Sourabh Jain <sourabhjain@linux.ibm.com>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Miles Glenn <milesg@linux.ibm.com>, Fabiano Rosas <farosas@suse.de>,
        Laurent Vivier <lvivier@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>, devel@lists.libvirt.org,
        Misbah Anjum N <misanjum@linux.ibm.com>,
        Anushree Mathur <anushree.mathur@linux.ibm.com>,
        Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
        kvm@vger.kernel.org, Gautam Menghani <gautam@linux.ibm.com>,
        Chinmay Rath <rathc@linux.ibm.com>
Subject: Re: [PATCH v3 3/8] tests/qtest: Add Power11 chip & machine to qtests
Message-ID: <akJVIvDQ93unGLo5@li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com>
References: <20260629110411.3051274-1-adityag@linux.ibm.com>
 <20260629110411.3051274-4-adityag@linux.ibm.com>
 <32d7c4b1-dbb9-485b-8feb-df999532de60@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <32d7c4b1-dbb9-485b-8feb-df999532de60@redhat.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=RYqgzVtv c=1 sm=1 tr=0 ts=6a4256e1 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=5Jhv4GUsR7L25ZsIausA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDA5MiBTYWx0ZWRfX1O7iKoxfcBG0
 bGIOc+LSDbh1W855E6YcWExSqMXVw+QWYpu14DrJp/ypim3fR1wSco8G4rXRIc48vYq5pzP4QJY
 QsrFNGsCn+nPyoiWqeWZU0aCndOu9Rc=
X-Proofpoint-GUID: ev6GHI-Bpo748DLpzD_YgZnndGJc6g5H
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDA5MiBTYWx0ZWRfXxADHdNHETAZY
 bIXtVOvilYvSYFvZ8dAmNqLKdyqqF4wc0xDBipgueCeGxMft8ja7NTKOoYnz3e7uhPglN1PEu5q
 A5MwqmesOfn9acWRNODVqHeLiho8xJ6McTgv6YC7DZ6pPhJGpYxWm6cza0ilHYaZXs2UjxqiwVi
 g24akTbJ0hOsjznK5nZLRblU4UCxFjFilXWFNn4NCgl22aN+wokrmpZnPwBcrId0mZjs7sr2flh
 GVKC8IsnC82R5LQYAePUOzX9uf157QZBJNAKEVtwBZdfW9dW+R81xMfl3JYi7xSfxxJNzSPssCN
 SAxuqeaSfGuKNrdxEosQyZ5WrBMD/2+mYX2bNtoaMimHzLvljD+XGGAjeR1t8agr/nqQSkpv6Km
 gBSKTNtYQDFH4K3vX7OR4KZr+bwpG9C2pRoTIpJRzbpmRR00t2615t8dhkp0StTTsqGxdVnSWJs
 XAarD+Kd32fFiFfuglQ==
X-Proofpoint-ORIG-GUID: SZy29s1SN9BzXO2VOVrwL8Abq1ZqXq0h
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 adultscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290092

On 26/06/29 01:18PM, Cédric Le Goater wrote:
> On 6/29/26 13:04, Aditya Gupta wrote:
> > <...snip...>
> > --- a/tests/qtest/pnv-host-i2c-test.c
> > +++ b/tests/qtest/pnv-host-i2c-test.c
> > @@ -402,15 +402,14 @@ static void reset_all(QTestState *qts, const PnvChip *chip)
> >   static void test_host_i2c(const void *data)
> >   {
> >       const PnvChip *chip = data;
> > +    const char *machine = pnv_get_machine_type(chip->chip_type);
> >       QTestState *qts;
> > -    const char *machine = "powernv8";
> >       PnvI2cCtlr ctlr;
> >       PnvI2cDev pca9552;
> >       PnvI2cDev pca9554;
> > -    if (chip->chip_type == PNV_CHIP_POWER9) {
> > -        machine = "powernv9";
> > -    } else if (chip->chip_type == PNV_CHIP_POWER10) {
> > +    /* i2c is initialised for rainier in case of P10 */
> > +    if (chip->chip_type == PNV_CHIP_POWER10) {
> >           machine = "powernv10-rainier";
> 
> Is that true for all tests ? in that case, pnv_get_machine_type()
> could return "powernv10-rainier".
> 

No this i2c test is the only test which specifically requires rainier,
other tests like pnv-spi-seeprom-test and pnv-xscom-test.

> > <...snip...>
> >
> > diff --git a/tests/qtest/pnv-xscom.h b/tests/qtest/pnv-xscom.h
> > index 5aa1701ea768..eefe206a2007 100644
> > --- a/tests/qtest/pnv-xscom.h
> > +++ b/tests/qtest/pnv-xscom.h
> > @@ -9,6 +9,9 @@
> >   #ifndef PNV_XSCOM_H
> >   #define PNV_XSCOM_H
> > +#include <stdint.h>
> > +#include <assert.h>
> 
> 
> Seems unrelated. Why do you need these includes ?

Not really cedric, i had added stdint.h since PnvChip used uint64_t, and
assert.h since i used assert in v1 & v2, which is not the case now.
I can remove these in v4.

Thanks for the reviews Cedric !

> 
> Thanks,
> 
> C.

