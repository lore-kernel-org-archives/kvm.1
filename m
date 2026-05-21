Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93C213769E3
	for <kvm@vger.kernel.org>; Thu, 21 May 2026 20:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779394374; cv=none; b=ZWVUNXsQpjDDHsZj6vyRxLzUSROcnxxaGd1b8UpHp7e01+2HRdI143N+yKyGlnHWWQj5Vqa2jJyFSuSQkssrKfWlM7yEGs78/WcP9Af+Ezr660uILAG1/T1hrkQ9KWXVembKJOycELeMJoEDx0XjziJl8KVdgkx9mmuzhEFFjnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779394374; c=relaxed/simple;
	bh=nF02n4d0zo6XAeoaFC7kFCatJjgNrNlUhsqWsFfaKcE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uTOJH1ktTPT7HwACO5eyQA4EbQvoFjwNCukpU0o1FFQQpTIQ9PPMRCHmSKqwuttdBp2At+YLw/ck0/M7zlRA844eUgrRoZ2e3CN4De1Eym9Rml11K6I0fJACmHUQciEeC9jXzk7zMMiQUnBExAoXAMkEAJQJjmxqsj7ZDg7/gdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=JV9rKCmH; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="JV9rKCmH"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64LApQtq2818971;
	Thu, 21 May 2026 20:12:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=nF02n4
	d0zo6XAeoaFC7kFCatJjgNrNlUhsqWsFfaKcE=; b=JV9rKCmHg6hIVdGRlF4quk
	EQArWGzspYtqYq7uf07oO+4uMcq4904vZZOJqJ5s4KutvgX5fbgGXBffq3GSq8nU
	ujh59JLnRnuc6Fpv6NCjll9Hv5a3L4aalc+Wtg2bmQiWs8+uk7SwKfX0bh5x2hRl
	Qc2PSF/h+shypKocA+AwhTLrexYCKzXSawLNVcy81iWwTPBdY41N3SZLlcChMExd
	tgnkFeb5Xxw4w2VTNK+YnVI0w+L+T0CqMuSA/ANmA1+cVnVGAQuKZxbFIeLGjaKr
	sxsjmMBbVhBdrdPuEoNXfCnFOV5EdKSdwn4uLPY44hDgeuOtxQlb3BaDyer3ratw
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6h9y8ybx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 May 2026 20:12:44 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64LK97MA019676;
	Thu, 21 May 2026 20:12:43 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e739w61xn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 May 2026 20:12:42 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64LKCdHf31326622
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 May 2026 20:12:39 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0B53520043;
	Thu, 21 May 2026 20:12:39 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B2AC620040;
	Thu, 21 May 2026 20:12:32 +0000 (GMT)
Received: from [9.39.29.116] (unknown [9.39.29.116])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 21 May 2026 20:12:32 +0000 (GMT)
Message-ID: <cfe1b8d9-8468-462c-af10-174af2746565@linux.ibm.com>
Date: Fri, 22 May 2026 01:41:26 +0530
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] Fix GCC 16 const-correctness violations
To: Amit Machhiwal <amachhiw@linux.ibm.com>,
        Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-ppc@nongnu.org
Cc: Vaibhav Jain <vaibhav@linux.ibm.com>, Nicholas Piggin
 <npiggin@gmail.com>,
        Chinmay Rath <rathc@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>,
        Laurent Vivier <lvivier@redhat.com>,
        Shivaprasad G Bhat <sbhat@linux.ibm.com>,
        Gautam Menghani <gautam@linux.ibm.com>, qemu-devel@nongnu.org,
        kvm@vger.kernel.org
References: <20260518172517.12466-1-amachhiw@linux.ibm.com>
Content-Language: en-US
From: Aditya Gupta <adityag@linux.ibm.com>
In-Reply-To: <20260518172517.12466-1-amachhiw@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDIwMiBTYWx0ZWRfX+qis8VDyIr57
 Qamt6tZyL6tFCQnQYsFs2cYSZTaYFU99MGMRWcvJP6upl426GgmeWMk61XzgpnqQbKO93QpSipi
 ZK+A8UbLxoaDqkrjrWYNMJdGy5IedFVkUwb7BLkd23r+JayUb4XeKECDerOzmbVHVm/VuKHqvrW
 S2yQcHcCfqId7ZbG5Ceymi1Pfu9jNb2KNFvU86zv1HFDtMX7KWUzbF+MasGw2H4MkI9OaiH+Ioe
 61WF3vLOhjHFtMvoZ11DUeRmNEI2HsWv/KVyISmBBJnrZIPvkC9k/sEsCKegteqyBt4jnzlZq5n
 ghRrnWVBZfH49xAN1YNkd62vONz01iEjp9yhc0+vod6iQcAtnQjlVp+vrGtpYpZqvvtCaefctg8
 UvmXc6h26rmHKYiJBHn50h7QPIEjb8GpBEud7He+zh/xe1vAN+Tl6WRSEYpUoTr7HbLXhkqBFMy
 OOQlzd5nZTxnpl7OaCQ==
X-Authority-Analysis: v=2.4 cv=BNuDalQG c=1 sm=1 tr=0 ts=6a0f673c cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=k0V8wgQb6Tt_Ug5EG9gA:9 a=QEXdDO2ut3YA:10 a=zgiPjhLxNE0A:10
X-Proofpoint-ORIG-GUID: cc9C8jTBvKFN1YsAtllm0sWql6xXbEXa
X-Proofpoint-GUID: iDkejnIFiR6NXeWA2lxqEnUgRuXtozmx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-21_04,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 malwarescore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605210202

On 18/05/26 22:55, Amit Machhiwal wrote:

> GCC 16 has tightened const-correctness checking and now correctly
> rejects attempts to modify or assign const-qualified pointers without
> proper qualification. This series fixes two such violations that cause
> build failures with GCC 16 when using -Werror=discarded-qualifiers.

The patches fixes qemu build for me, and looks good to me.

Reviewed-by: Aditya Gupta <adityag@linux.ibm.com>


Thanks Amit !

