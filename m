Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35091423764
	for <kvm@vger.kernel.org>; Tue,  4 Aug 2026 07:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785828622; cv=none; b=JDqV1QjQ4/bkkazESNZh3ddfK+lo9gZzE5h5gMFpxCzZJiVmqLJh0qJ3tKgRL6fZePCRQUNZMAKTDxxWVRFgfYICYlUrbpNbzve5JFE20ok72CcKNe6TA2PFtCIqb5UY+MpIpthlGDAfFyiyeQMmMqpFepz7up9CCrK/2jq63w4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785828622; c=relaxed/simple;
	bh=VAzdkY0FhVatErfRtKHtfpFZ4GJe9PAo5SAMhtPg3dk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G7uRXr/H4guAgtUAa63mpkHVCOKvqlud2OW7Shh0r36ukh1bmubmc8QnSO5wbyAS21tMPmGSwKhIBlIiCgjzlBC0FQLqNMIInLFpDpYU4KfBwqRJGod8p1dmpKXxOgqs9sNYRta8d6gQWe+XVYFUu7blESe03Iak53WUpqvrpTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qDdKuz2Y; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qDdKuz2Y"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6741J4at3633768;
	Tue, 4 Aug 2026 07:30:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=VAzdkY0FhVatErfRtKHtfpFZ4GJe9P
	Ao5SAMhtPg3dk=; b=qDdKuz2YpnsKMpYjBNQnYWLGfNgvYOZJzdnKJCFn9UxpeI
	9oh/+SH8CSxLn4969LJx0Zh1n4q+nUi1Ju9TDxg4rkCc7VKI+RBOrtllNTQ/iJYS
	aA18EkOQSj77+CN0rn8VXghPlvWHg/GqE+9EbRmMJ1HfNI38X8/ZdOu7trDjwsn2
	VUrHYCwzXwT7Dtsha+A39PsUWbuWP9bP8gN4Jdr/ocrpJahOi5mZzKzCVFsxp7pk
	k87cGGcKmilsAFyQTs7Vmo/VsezG2AepniGV1ciyCR2yqw5KEs6twW1gkieW1ClF
	oHQvP3xSw+5li6C4frqCEHqepWh33F9DWXnWaQAQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8a3vp83-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Aug 2026 07:30:13 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6747QMbN016408;
	Tue, 4 Aug 2026 07:30:12 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsugw11n5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Aug 2026 07:30:12 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6747U8Rq31785304
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 4 Aug 2026 07:30:08 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0AD5F2004D;
	Tue,  4 Aug 2026 07:30:08 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AA51420043;
	Tue,  4 Aug 2026 07:30:03 +0000 (GMT)
Received: from Unknown_32:98:3c:96:ca:91 (unknown [9.39.29.19])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue,  4 Aug 2026 07:30:03 +0000 (GMT)
Date: Tue, 4 Aug 2026 13:00:00 +0530
From: Gautam Menghani <gautam@linux.ibm.com>
To: Amit Machhiwal <amachhiw@linux.ibm.com>
Cc: qemu-ppc@nongnu.org, Harsh Prateek Bora <harshpb@linux.ibm.com>,
        Vaibhav Jain <vaibhav@linux.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Chinmay Rath <rathc@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        qemu-devel@nongnu.org
Subject: Re: [PATCH v4 0/3] ppc/kvm: Handle CPU compatibility mode correctly
 for nested guests
Message-ID: <anGU-FnmEcxvXOsZ@Unknown_32:98:3c:96:ca:91>
References: <20260701052341.62289-1-amachhiw@linux.ibm.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260701052341.62289-1-amachhiw@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=E6P9Y6dl c=1 sm=1 tr=0 ts=6a719505 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=B_FdNE4XmUi8kz3hM70A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: 3vyM7DjiShDHmGkLCUf6-rgjguqOm3Jn
X-Proofpoint-GUID: Tc8di1H-Yy-fJ89SG5CDPY3qWhzA9YJu
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDA1NyBTYWx0ZWRfXyZKodADTpNu0
 GSrOHIhV1Moi6rNX46AcbhWQrMBUg5oM1Pk2dG4GR7ZGTcyVUlxJyOSJmvyCLM6rm43Wkhzsu7p
 Nx6X6wLXHuK00x4oktxB5eRyFwZiRao=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDA1NyBTYWx0ZWRfX4Ci6mcPP5Fb/
 ffjDtXbeG2g+BQS72lPCMDsg3Svt7rl8hywT4v6g1TPVuHSOCboZLV6QXw+xnDw0N5b+L1AD2Bl
 A7r0Uhi1/RFaOdj2rNqjATsffamK5MnSWhozd/BG/kOEJJKATLFADDNIUAWK5Ggf7IRpNSok1fw
 /YkpEfW1Fy61IjgxPz4dXsrr+zckspkd7MbGLvluOEM88ojT4wshW/eEVGVN4ejel1i7LX4w3o2
 HoedvijwTZlcvitaV5R3SlZnemTNWbXiJINQCMAy66xD4bC7M0olTTH0rFJeZ8FlL4l+aivV0//
 y2ZA/1yoAAYe9c6CS8BJLzxQboAH19kGtb5Rrr5kElBvljecrl85cVfLutkkKQAsJ4eAH5t/cjB
 KPFAQ3dpLKw9I4QO/iSTOEeySOI2eGrKimSs8RmzXMkvD9RQ4bH3e8qLtSuSKr0gxJ7t2K8WBCh
 0+tDp64uhOKD8/F7N+g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-04_01,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608040057

I tested this series with different compat mode settings for KVM on LPAR
and KVM on PowerNV.

Tested-by: Gautam Menghani <gautam@linux.ibm.com>
Reviewed-by: Gautam Menghani <gautam@linux.ibm.com>

Thanks,
Gautam
