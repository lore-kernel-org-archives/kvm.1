Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD3F3D79F9;
	Fri, 10 Jul 2026 08:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783672529; cv=none; b=sY1DDL2+fyr+WhZQgyYyfd1/Ug0gctPp9tAPSuBx8q+ui0U9QTzbvZugeuTnanw5C1JqicHagDE7yfFS/pVRe9EEWXebKpBGid8g5QppUlZ7ZE8dAeonoJRO9kpZsTZ/4wjJ+edhyX5rN/z9XGyan7KCyygZkbk4M/axBUEDwRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783672529; c=relaxed/simple;
	bh=W6C4eWmDHnFu4uUTc7uvvI6pNqQHJpzuWIiTpUF4fwg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R8x+RsmAkwODKyuATOWO4lw+ZpHgV9l/eWy3ebPZHEBvBb9Ir9uxu/CHNUdZv0O0ZfkRD7piP49fdavWs3xN0O5IlzCQ+4Ih4rKZw8JbzqracFI9JveroR7ZMsOsDls9hAqKGJ4BHmwGtLyWYDVxG4BTNe6TN1JcImVdKD5ZRg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=KcJNIuDH; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="KcJNIuDH"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66A7molL4025692;
	Fri, 10 Jul 2026 08:35:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=7z4qY3ITfxP8oa1sl18c+DK/G6FFTx
	jZ6B0R9ZuOVKE=; b=KcJNIuDH0oj+mNcHWEFCF9W2NPHa4gkpaj+EjaIMfnULyJ
	o9JMQVShfmrVXBPA2rWcluwJi3zlQh0tAmi4EOjpoSJWVr7czWyKMNT1FecjX7mN
	WiFSiCzS1ynSqk503gtGOhV8ScUDH3BEqjUfftG0JCattr8MsxmVvk2C6054a7aj
	FIie8r8UMWnnsAotdt+jmS/TZKWS2KXTjIJJxAe5fLVjsRsq9Oj14gu/mGEOcygG
	bZY1F9wK1vMwH3dZDQ08fJovqv3EvkkhykFzOymL9i7rnQe7EgHSnUe4njTwYX2z
	YJKWFvZEVhY7HByP8w3CIIOJvX0HsLXVIHARFubw==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6rke61k4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Jul 2026 08:35:25 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66A8Z3w0010828;
	Fri, 10 Jul 2026 08:35:24 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f7f6ygtuv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Jul 2026 08:35:24 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66A8ZMX551904796
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 10 Jul 2026 08:35:22 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7F0852004B;
	Fri, 10 Jul 2026 08:35:22 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4B94220043;
	Fri, 10 Jul 2026 08:35:22 +0000 (GMT)
Received: from osiris (unknown [9.87.147.219])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 10 Jul 2026 08:35:22 +0000 (GMT)
Date: Fri, 10 Jul 2026 10:35:21 +0200
From: Steffen Eiden <seiden@linux.ibm.com>
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] KVM: Add missing debugfs cleanup in kvm_init error path
Message-ID: <20260710083521.984749-D-seiden@linux.ibm.com>
References: <20260709152154.235233-1-seiden@linux.ibm.com>
 <ak_R2YrPFRVVmX4P@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ak_R2YrPFRVVmX4P@google.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=M7J97Sws c=1 sm=1 tr=0 ts=6a50aecd cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=U2YhpocSpuPZoOkIZ0sA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDA4MCBTYWx0ZWRfXxp6BBu89GRkj
 oVMS27ivlCXqABdixEwEA6PTGZOnpCL2BpjAQcIPkCPjgoS8TTeM5gJCkguLmuVclYTOR1Gw6FZ
 CMUW5tmQ5NTa716VkghFYMY4OpSpj+c4ZDEnnZz/JtOVFx6+rHXUlR6skl5+usHZIknhfycL+z/
 TU1IisieKjWbK4u9wAE5aQ2XX48T6VSJo6kcmNlCx2JAWH7xCKlO7DB9XLgquTHhpBr3GxcTBAR
 e7M7tAo176Z0AbDMzHFyM2kS28071Neg80xjUPiERc1O6ESXvSL5mCbdewSfx2pRB5SAWIrZ1EQ
 u49TqIb7OvbN/x4uw5RljJlP8Og9lKAkG8ZbfPHYbuSmyuIqQyOmPaxCm3ldR0eOXXMB2N/un0o
 EDtvoVQ7C+6TRVHtQaJ78Aig5+/Ee+mnjwHFpKymOLCrMWpnORz5OJfktU9StErEL1WiGoyW9Nb
 bhPbq3afc2ttFLkMhBA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDA4MCBTYWx0ZWRfXwDU9osDuKb3f
 Wlx9O5OvYbNKgdMfsX7yhqIgHQx+1jX6Au2Fo4EURqW6VWvurfmnrS902B1yfjcnxOXX4Ub53e5
 DhlBWmisVQyGgJ2DKo5YaW6FioYOH2s=
X-Proofpoint-GUID: PzezDuY4JkSM9qYLqFFPlFAoFmgllDaN
X-Proofpoint-ORIG-GUID: d1IcSiBVDOE-mLK0xcTrdT4nu7x6C1Wi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_02,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015 adultscore=0
 priorityscore=1501 bulkscore=0 spamscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100080

On Thu, Jul 09, 2026 at 09:52:41AM -0700, Sean Christopherson wrote:
> On Thu, Jul 09, 2026, Steffen Eiden wrote:
> > If any initialization after kvm_init_debug() fails the cleanup code did
> > not remove the debugfs entries. Therefore, the corresponding debugfs
> > entries where still alive but the backing fops are already freed,
> > creating a use-after-free scenario. Fix this by removing the debugfs
> > entries if vfio init fails.
> 
> Already posted, and applied locally on my end.
> 
> https://lore.kernel.org/all/20260706095910.39798-1-leixiang%40kylinos.cn

Oh sorry, I missed that.
