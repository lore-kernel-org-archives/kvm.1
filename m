Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF8C43DC878
	for <kvm@vger.kernel.org>; Tue, 30 Jun 2026 18:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782845591; cv=none; b=oLB1Xb4CsGxPeXbvtTEEv0+SNYZHU2/vMllGCRdA0J3QwAO2Ga5feMGxlMo/umPfVg4fdbj9bDX3B3AZJzjGA6EVUocQtqANYgGXMI7ZCNxroi4hVSCpoLR7Vp3xAJqp6LP1CIgtcH65n+fj+31CTdldtTQU18x5ZZfBbIXuNC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782845591; c=relaxed/simple;
	bh=7Sbn59UIu5eRk2jdLIl5tDl80SctFyoKALLBfjbVbz0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AaQM8WGIyTsf9otex078daOHJNso8OYTYTUKNHjCAoXmLbeSEOfwSuLwnqsV47M7uiZn01qbdaFjlMEYu1w2TWuknv9QGa0OwkxKP/M+BD5pid8Y2auv1AC7xuHs8qfVqdQhyKkIEwguHolqwlZffgU/rdch3TZwtaItqpZKIgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=D39M5k71; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="D39M5k71"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65UEIt8C2171482;
	Tue, 30 Jun 2026 18:53:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=SZxcmJ8sVqxXE92EroQt9nhh8FFQ8a
	lMun/haz5ohjM=; b=D39M5k71f6uckP9Id0FqQ6YlCB0lj4K1y/S4vkg8jV7W/u
	xYwr0duaY9M668PdNUyPMs3V+vQNBMtm8KTfDuqASn9LQVcLbPM9boJw3WKaJQxS
	lTIwLxittj18+VgSlFIMKw7MequTiBmaKvjvLCdAyLqPWYayY/WsLzRTMcIN7Xen
	AmAaNOIQp7Yr9Wa7NxWRg6fJy9mUZcDKKB3fgZc8UAtu1DhMdB1qSobZwrU8lEn1
	HuS0Kd6ZEoc1tjWDYVtcfh9edveoSltqS+aEgtofTY1TEmFwUd9rsioxj2USkzeW
	lTXDrTo4XfU9yWuZAphHmSqjSn0XiZyEJruFgfuw==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26rf09us-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jun 2026 18:53:00 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65UIneH2010612;
	Tue, 30 Jun 2026 18:52:59 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f2uhybhgv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jun 2026 18:52:59 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65UIqtnP38142296
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Jun 2026 18:52:55 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AB98820043;
	Tue, 30 Jun 2026 18:52:55 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F375320040;
	Tue, 30 Jun 2026 18:52:47 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown [9.39.22.35])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 30 Jun 2026 18:52:47 +0000 (GMT)
Date: Wed, 1 Jul 2026 00:22:45 +0530
From: Aditya Gupta <adityag@linux.ibm.com>
To: Nikhil Kumar Singh <nikhilks@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
        Harsh Prateek Bora <harshpb@linux.ibm.com>,
        =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
        Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
        Shivang Upadhyay <shivangu@linux.ibm.com>,
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
Subject: Re: [PATCH 2/8] tests/qtest/pnv_spi: Test Power11 PNV_SPI
Message-ID: <akQOQaFAKIMwJr2j@li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com>
References: <20260623141933.577981-1-adityag@linux.ibm.com>
 <20260623141933.577981-3-adityag@linux.ibm.com>
 <db95d79a-a6bd-40a1-bc08-f572cebe1641@linux.ibm.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <db95d79a-a6bd-40a1-bc08-f572cebe1641@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=a4kAM0SF c=1 sm=1 tr=0 ts=6a44108c cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=2MyuuRbPs5obn9458OoA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: CkvIOczE3un40AxUjJ2xS8ze1tU40Sg2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDE4MSBTYWx0ZWRfX3TKcsHkV9d3n
 MknEInP/HmTP2N+l7VTMB7Y9mKcmKLIYAv6sbvooh4k+iyCwqginO53w4MOHYCGs9GaGwMb86ao
 yDtXa9i8oX/tBDnanAj5BEqkSboTnKl89M4QtK8Pb1Pg0kt8/crHhGwLn56dbrWYzttuN8LtBfb
 f2krkHBBSkPm5a47RaWgUyGtJdTcnEIHoQGxmWSOMIIpZLo9BE5tEMgJKEd/NAOsaqNUaGUgqk8
 qOvpXQTKM7JhPRUhqDcQr7nE7UcWMlyCqnPX3WPbkLoJen0t9lbdedy4QSMxZnBZm9Rnsn/eeWf
 +FkeqJGnIZ5udJJLMi5v5CO9TIEQno1LXRWCPT1oqf1A3Fa3M6+mnWyt1b5v+DVz37tXRpq65xK
 2A+R2ipUMSuIdzmwgfDXk1OsM7dMitfKINJf/BJKHZFmwU6FrmJqiGjK4153lG9acQWlKUheE/Q
 rLDbLgfb4uoozLQZtgw==
X-Proofpoint-GUID: yt7xSrIawKoZgu4mUJvn-pkHIzdoOinh
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDE4MSBTYWx0ZWRfX/ZauVjHOsoSB
 Ay+S0e70r5tEO0y7XQKAVc3bX2xncK2An3OjOA/c4YrykFDV/uhIp1/k6yBJpksVwn/Naw5LD/9
 9Ptv15f+LNTgfhkp7g9hXkQOfdkDy/g=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_04,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0
 spamscore=0 priorityscore=1501 adultscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300181

On 26/06/30 09:55AM, Nikhil Kumar Singh wrote:
> Hi Aditya,
> 
> One comment below.
> 
> On 23/06/26 19:49, Aditya Gupta wrote:
> > @@ -77,6 +77,7 @@ static void test_spi_seeprom(const void *data)
> >       const PnvChip *chip = data;
> >       QTestState *qts = NULL;
> >       g_autofree char *tmp_path = NULL;
> > +    const char *machine = "powernv10";
> Would it make sense to introduce `pnv_get_machine_type()` in patch 2
> instead of patch 3? That would avoid hardcoding `"powernv10"` here and
> allow this patch to use the helper directly.

Could be done, but i will prefer to keep it in current state, as of this
patch, power11 wasn't added to this test, and the test only runs for
powernv10, later as powern11 gets added in next patch this is changed to
use pnv_get_machine_type.

If pnv_get_machine_type gets introduced in this patch, it makes sense to
modify all other tests also to use it, which is more than what this
patch intends to do (just remove hardcoded index in spi test).
To me, it seems okay to keep it as is, what do you say ?

> 
> Otherwise, the patch looks good to me.

Thanks for reviewing, Nikhil !

- Aditya G

> 
> Thanks,
> Nikhil
