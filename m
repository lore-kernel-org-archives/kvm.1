Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11F9F2765D7
	for <kvm@vger.kernel.org>; Mon, 29 Jun 2026 11:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782733182; cv=none; b=G+CKV2YsK5Ar5502rmWWrf1RMQxHW42wbLv+jcfHdcdMaokFbNr+vKPZp89iIjbv72+mcHAW74bTdJyAIP1Yk8uezqF/FZ/3G0rKGfOphQ4JcpHJCbuTvg2jQsE75UDTWGEOkbXS75z+6CxafUC3KJEK1pSkp1XNYuL3XNCs9Oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782733182; c=relaxed/simple;
	bh=HhOWfBnwqM7+wwlbz3fzE7dJ7SqQVvk+P4dI56FAYI8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nM9okX6VpBPmYRSY2ibrK0nRDBZN7u6ZDSF47DdKz0S9OmntzTkz6MAH0L17KBR+CFyAWqP7rQixEUJhuAnc2X3LAM8Zv6Malu4GoBpRtbN3X8O5kyoyfZNEWjMtbpeM5FZt69PK2Vc6HXS/2KNthqZs7dsjeZP2TLEtORBnMo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qiLB2R3t; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qiLB2R3t"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65TAmCp73181299;
	Mon, 29 Jun 2026 11:39:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=JtwcWg
	PVayABFqkq+CLBjsdFFHHlWyH1GFWPrrmPzqc=; b=qiLB2R3tx8uqHAPRL58XWZ
	b1CR01Jia6f7fsvENhXWRu3I7W1qwDa8J43+iLtcO1GYBSY+/dW36JI7ERjubVhv
	dBtyKbFnL7x5NjkW3vwXYyd96KWZBDQAxcK6tBQZomc5PFcPsihfqGT1+Dl1EPER
	H8kdy1RPTVp3NCNUkvVJoO9SKvzZBuCzhdq9pcxntg5/78dP2EUakid+XS1puviB
	wqhUIRLn4wkBvSmW7aQWuhSLQlfc3RS66tKujMffUD2bDre1J0NsYmhD/gJVUF3E
	KMMUE8pCJQ7byPL8OFQcjG6Ho+2w9lcjRpAzaOh3to2bVRmgxrKnIr6LwfJoGwgw
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26qfs0xj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jun 2026 11:39:29 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65TBYir1016493;
	Mon, 29 Jun 2026 11:39:28 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f2ruq5cd0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jun 2026 11:39:28 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65TBdOfR49152310
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Jun 2026 11:39:24 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 627902004E;
	Mon, 29 Jun 2026 11:39:24 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6F24320040;
	Mon, 29 Jun 2026 11:39:20 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown [9.123.10.203])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 29 Jun 2026 11:39:20 +0000 (GMT)
Date: Mon, 29 Jun 2026 17:09:18 +0530
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
Subject: Re: [PATCH v3 1/8] tests/functional: Add remote interrupts test for
 PowerNV
Message-ID: <akJXAebIn7BHhPRS@li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com>
References: <20260629110411.3051274-1-adityag@linux.ibm.com>
 <20260629110411.3051274-2-adityag@linux.ibm.com>
 <71cffeef-3398-44e6-8e13-130266e789c1@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <71cffeef-3398-44e6-8e13-130266e789c1@redhat.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=RYqgzVtv c=1 sm=1 tr=0 ts=6a425971 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=7NDaL-D_JNWX0BNlmoEA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDA5MiBTYWx0ZWRfX326U21f3F5P3
 ZmjfQMqSJA1pni2y7/JEKqiLMng98KLseFKbpLg7UbVjNIRghJdMwo1nyCIzi2d/qZXHoekEzmT
 NP8ycmqZ/j4gFW5P5FDWyikeA3r6Z/Q=
X-Proofpoint-GUID: KnKkqMB-M5J5oHA9W-sjnD2imNfdkZ4m
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDA5MiBTYWx0ZWRfX9L9s3INCbU3y
 qGMJos97RJXSAka7a1lfqDsdEnOLPkNZq0E89/OXTyT2QXEimrDlXP22ywC/GeXEn3BiQuSp7Qj
 Gw3s5FdmVaFnfetLQY18IcQcHCpdYg42/Ou68Q1Ei5RJNvxI2t57ynVTI5qtMYraTyO3GETf54X
 R5hS1yVlHCdVC8cGjrv6dX7w8Fi3qh5lQARW9ZR9hC9xrwymvCtUlp5mJz+JYzgHFe0Fmche/tO
 ZaOWUkRH37+z6ZFpbSu2CZxMhzzsewzeKJwpB15NJma/Ko10Qwof1kpOhWTZWNY1Iws6Q8rKAa5
 W3lNLcK6N3jal4xT4Ea9YIlqXoFglYARYn/OJa6VRZEB0ArVocqx9AdMI4jV/KuHs3gznHS+2Cq
 uxX/vFrGsfFRQ8TYb9jYfBg8c0JJdF6V5tlWP3FuRf92oeUWhXtorOFg2ADN5TAMlo29/Eas01u
 dBouDnYsdzIP+BJJm2w==
X-Proofpoint-ORIG-GUID: m2y9ZQBwnscvKGIWyzf0BmB-lGtIUgS5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 adultscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290092

On 26/06/29 01:20PM, Cédric Le Goater wrote:
> On 6/29/26 13:04, Aditya Gupta wrote:
> > In the past there have been hard to recreate issues where XIVE changes
> > cause qemu crashes due to multi-socket interrupts such as in [1].
> > 
> > Add a functional test explicitly to test whether remote interrupts work.
> > 
> > The test can also work as additional boot test for multi-socket boot,
> > initrd boot test, as well as a check for e1000e to be working in powernv,
> 
> you should consider moving to a more modern nic model: igb, which
> has sr-iov support too.

yes, can do. with igb i see multiple irqs, so test will have to take sum
of all rx irqs, and compare:

	2026-06-29 17:00:46,288: cat /proc/interrupts | grep eth0
	2026-06-29 17:00:46,391: 135:          0          0          0  PNV-PCI-MSI 2416443392 Edge      eth0
	2026-06-29 17:00:46,393: 136:          0          6          0  PNV-PCI-MSI 2416443393 Edge      eth0-rx-0
	2026-06-29 17:00:46,394: 137:          0         14          0  PNV-PCI-MSI 2416443394 Edge      eth0-rx-1
	2026-06-29 17:00:46,395: 138:          0          4          0  PNV-PCI-MSI 2416443395 Edge      eth0-rx-2
	2026-06-29 17:00:46,397: 139:          0          4          0  PNV-PCI-MSI 2416443396 Edge      eth0-rx-3
	2026-06-29 17:00:46,398: 140:          0         16          0  PNV-PCI-MSI 2416443397 Edge      eth0-tx-0
	2026-06-29 17:00:46,399: 141:          0          6          0  PNV-PCI-MSI 2416443398 Edge      eth0-tx-1
	2026-06-29 17:00:46,399: 142:          0          6          0  PNV-PCI-MSI 2416443399 Edge      eth0-tx-2
	2026-06-29 17:00:46,400: 143:          0          4          0  PNV-PCI-MSI 2416443400 Edge      eth0-tx-3

I feel e1000e suffices for this test, should i stay with e1000e or use
igb here ?

Thanks,
- Aditya G

