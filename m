Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BB0F3B440E;
	Thu, 30 Jul 2026 05:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785390127; cv=none; b=obMERwycDZ7F/0bLoW3rmqq2rnyfmhqC4XVZc4g77frjGfYsWNm9WpE/1cGRidj0+BnAvj6+6lhtdjaWgtsn05mzL4q4sHI5qy/5p6iB4WZTxsNxfGu5ewCTIFrrbsh/RDMKnwUx2YsTcfsSkG7/ft3ktr2yoZ1wox4qvqazb+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785390127; c=relaxed/simple;
	bh=0JGnYjaJUXjD7TC8UnCMp7rodiRynlielhv+jryHhhQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L7k6RhOmM6PfSAnh7fjBiL6KJn4mMuBa5ZVUUYeiDrfRBgfodbPhHXOXFOkzVWQmTr7b2nObinglF5Dd4PcdH90MFnN2wYbZR7tRGbyftUkoko5zOwE10SS3gDa9YvvLDgp+hN7oS/T5uHhHS6r4DJ/TKAMWREid/jnWCiDFSN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=mulPILT+; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="mulPILT+"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66U3lhkt1933940;
	Thu, 30 Jul 2026 05:41:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=zO+kKL
	THSIWIieSIJ1wvyDHRb4rNeWyfVW5/euVdhWs=; b=mulPILT+c75ufburH2ztYe
	oiitT1ksIIVHLYnkHJK+vpfiib5EzuK59Tqet5SWL2uHB5h3SWnY+qWGTxp2hNdH
	oQjYp6DqTWlmD73NnoKxJHuVl4WNqOnEQjY4Y72aiTSgQY+e5BQATPjukLJsVW23
	4T5cfIQFpTw4fv02OyevJ3vPAuigVHJsHDP5slWunvdidfrOUABtEC9JQ1zFoKmb
	T7L+kRkbVSGGLpSAkkgKHfmD99P3ZRHF9fRQ3K0mKwVG2KnIwS+hhYVAZl6iq59g
	NMbAqCRgTNSuCCxWavhbzJXwRAaUBh9W4ka0p1pndANttOnit8TjKpdEiXIzf5sQ
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmv0xx7cp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jul 2026 05:41:57 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66U5fIeL027071;
	Thu, 30 Jul 2026 05:41:56 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fn7fqj45s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jul 2026 05:41:56 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66U5fqhj51052836
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Jul 2026 05:41:53 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D363B20040;
	Thu, 30 Jul 2026 05:41:52 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CD1A520043;
	Thu, 30 Jul 2026 05:41:50 +0000 (GMT)
Received: from Linuxdev.ibmuc.com (unknown [9.43.85.187])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 30 Jul 2026 05:41:50 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
        kvm-ppc@vger.kernel.org, Vaibhav Jain <vaibhav@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
        Anushree Mathur <anushree.mathur@linux.ibm.com>
Subject: Re: [PATCH 1/2] powerpc/pseries: Ensure vpa,slb_shadow & dtl are unregistered during crash
Date: Thu, 30 Jul 2026 11:11:49 +0530
Message-ID: <178538948384.1278583.17569895854995042280.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260708015802.274271-1-vaibhav@linux.ibm.com>
References: <20260708015802.274271-1-vaibhav@linux.ibm.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: p-L9qlClgLkOrwOgvbvvV0xiL3YoXpsf
X-Proofpoint-ORIG-GUID: p-L9qlClgLkOrwOgvbvvV0xiL3YoXpsf
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDAzMyBTYWx0ZWRfX4CHozPO0K8ZO
 ZJRBxalwPseIkm/FLAdOe8lEk7yvpMU8MrCgvkyZnESi1dKIpZBJNDL8Eeai5oaqq1rdMSRfVMX
 rbHD5TbKXa+TTfdI2UhvE7lIt7GjqmA=
X-Authority-Analysis: v=2.4 cv=dYuwG3Xe c=1 sm=1 tr=0 ts=6a6ae425 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=s8vH8uGDgdFwIMWCMQ4A:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDAzMyBTYWx0ZWRfX8ZDHGDd7HCtu
 6CBC8EqqsTnnmi1gvIh4gKNS7eb06E9tkeQPH7YHxPMI9HGerryBL7wWsGqqAUluGYtn6Z+SsCD
 s5/vxZMMvxbWg+I/WgObUNAIJu+B4pL/Y/R9h7cYVRJSxO4fBW2A0n3XUfqIO7A1GzGoa3rl52Z
 nU2J2WDG8tMuFjV8cnYJ9k+XvrvksnfHZhNmLrHO4O9xnu/1ZZUz1+f3mZqYklgkMJOGcGm/dLa
 SpZ4/WyYL4EZP+LaDCcvyDDkJFo+2frKA/d1u8/qUceXpHC8KCrLaZ8lav8pZJY+h8qM2i3VH25
 kj4CCpgoO/szsn4tsCND8ylnIbSXSrItrB7etwAR+9iSQyrmLoE5AkckZWFn5v02C99AJ6/uy5q
 AjR5+hNkXM+C7zqlL+fC30KfBAALd37I4LQBiCjrdKHOFDCWC+XhaIXodQYToeP3kJi60f6hnWI
 uy7ANvVk+UjEkeXJ1Yg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_01,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 clxscore=1011 phishscore=0 malwarescore=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607300033

On Wed, 08 Jul 2026 07:28:00 +0530, Vaibhav Jain wrote:
> Currently pseries_kexec_cpu_down() skips unregistering vpa, slb_shadow and
> dtl areas during a crash and kexec shutdown path. It was done to avoid
> doing an HCALL while crashing. However recently Anushree reported that
> during kernel crash while the kdump kernel was coming up, Hypervisor
> reported invalid values for 'vpa.yield_count' while it dispatching L2-KVM
> Guest vcpus. The error manifested as debug build Hypervisor assert
> triggering to indicate possible VPA corruption.
> 
> [...]

Applied to powerpc/fixes.

[1/2] powerpc/pseries: Ensure vpa,slb_shadow & dtl are unregistered during crash
      https://git.kernel.org/powerpc/c/810d07fb4cf7577847f85a6fd6273b69cad8d580

cheers
