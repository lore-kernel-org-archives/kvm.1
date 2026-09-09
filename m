Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B1D4C6803;
	Wed,  9 Sep 2026 13:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788961790; cv=none; b=BDCc/kG9JOuO/P0t3q9UOiNdy329jLfL6xKa0DFjJXEOxzP9x8OW8iaWuiNPbysObAEmZqAOLLhvxDXrtINVjlaZuasLUYRWsJiFFW6sTok5r68QnXjVTQLrgqgN5UUoUYrlZXLg5VZZcQ+P27oWLwOPCYiTQG14pymd+0Q7GU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788961790; c=relaxed/simple;
	bh=zk9O1VqUlvMmQYkzykXwrVyV+D3jQkGLOctPSxrK0jE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ItYtpZz7P8Hb+jvvLCyPNSPlKuXRWtyTVGDSMCunQBy70+I2BsE/UydoRRgvLuF9C4p288YFaJk/NGQls6DIllONNtgHJEmg5+eiYBAclJQ47e4gujrkDg4OrAgwZCA9VX37f1G2eaczTm3VWo+GLITl8sd1K5ywmTZ3UVIUKXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=STuk0Q4p; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="STuk0Q4p"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 689B1Rdn3817360;
	Wed, 9 Sep 2026 13:49:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=SDN1bSm78JYtcqk6dQqOPb7tN9F8Iw
	EZknd0GXW6KaM=; b=STuk0Q4pFL8YHkUE2Ux7YdUsiFxNTBq7ultO335soE+88u
	dT+gMNefwHAM2S0E0qUpITdIMvazav5o2i5dB+c6wT8HMXMcpKftAvUbND/RXmrp
	VLqaa01fOevhOons9sD6/Xv181JzuIXTb6DwRJfv49mJL5UhoP5dpVKu1zSMe+21
	f9I0sTwfZsm4qnYrjQAhBgCG2oHXSBdWQay12Ar7bAyreKXqQ61QVRd1zSqdI0h/
	G1p4pmrPzfx7JR+LNOSxM8fr3Li+noWePOLb5XdQG1aZvWSvHFe5aJVBJsv6vvCy
	1hIj9ww+tjJ9xGPHhyGLR3Ed9ibnIehQqxRN+2jw==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ggbf4679q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Sep 2026 13:49:45 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 689DfObq004987;
	Wed, 9 Sep 2026 13:49:44 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ggwdqjq5s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Sep 2026 13:49:44 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 689DnfoU42664418
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 9 Sep 2026 13:49:42 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CF26D2004B;
	Wed,  9 Sep 2026 13:49:41 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E1B4020043;
	Wed,  9 Sep 2026 13:49:39 +0000 (GMT)
Received: from Gautams-MacBook-Pro.local (unknown [9.39.30.71])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed,  9 Sep 2026 13:49:39 +0000 (GMT)
Date: Wed, 9 Sep 2026 19:19:36 +0530
From: Gautam Menghani <gautam@linux.ibm.com>
To: Chaithanya Lagisetty <nagachaithanya9911@gmail.com>
Cc: pbonzini@redhat.com, seanjc@google.com, shuah@kernel.org,
        kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests: kvm: Fix transposed calloc() arguments in the
 uffd helper
Message-ID: <aqFj8Iu7cUM7koH0@Gautams-MacBook-Pro.local>
References: <20260904052033.3648259-1-nagachaithanya9911@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260904052033.3648259-1-nagachaithanya9911@gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: 9eICNbdAGc1dM7c0EPq-6akPTP0aYTzK
X-Proofpoint-GUID: zlMKD7G2Lt4LzMLjtdKJ-Eu_gCZ78Clh
X-Authority-Analysis: v=2.4 cv=DbEnbPtW c=1 sm=1 tr=0 ts=6aa163f9 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=pGLkceISAAAA:8
 a=VnNF1IyMAAAA:8 a=q2RsVZR9PaoYCt8hnh0A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA5MDE1MSBTYWx0ZWRfX7+ZjmaZWHxxl
 sYhBwAvghoPW2UT3D7sTHr1bU4FETF/tTOZVsO3z0E7cCN5XxxR6nshOyhyCXOxgn5Yk96oTgj0
 mRdaKrkXFwjdshA9HvO2AZG1zIqu3cFiVhMVedBZiKaHuFridWG+se3nT6TEA2kEjNBPtZuN5Ei
 C8yWJV8XZHN0Z5V0IM8pPErmzclGW0NQhHapcXuFmpCfu3Dv2AW/xhK8uV2Csk+ck2Jqg/6kApw
 tkH0KDtM/arTtKEXBCNoIgDRk6ssTwj2ZJ+7e810jJ9DAILo1PdY4LZ04oc2F58HvG+85fxb4ak
 LssloLCGqLYElSfRYr9vATM/EHp9rXsCEHu7M25afw6s+DY634PwsErCo5DrJxLN1kX/TF1z7Ua
 38ph3rIVheBvpnRXIgOZK915piOQTrIFR6Mgy1LzLFEiU5pAtLT3V2or5uW3EyKa7BkOXV1A15i
 Pm7hVSQaQTwk8mL0o5A==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA5MDE1MSBTYWx0ZWRfXwzzDhPtnVcrX
 DixBrJw+n2P0TIjTjmyglJK+Phev2BUcFGeuhZ5D73xBHeeWgJZEd15YKsCiqzqNpp69hrGOJEO
 VnYXfmTt3INbV3nUfiMID5Ffue0wOH0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 impostorscore=0 adultscore=0 spamscore=0
 clxscore=1011 suspectscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609090151

On Fri, Sep 04, 2026 at 05:20:33AM +0000, Chaithanya Lagisetty wrote:
> uffd_setup_demand_paging() passes the element size as the first argument
> to calloc() and the element count as the second:
> 
> 	uffd_desc->pipefds = calloc(sizeof(int), num_readers);
> 
> calloc() expects the number of elements first and the size of each element
> second. The product, and therefore the allocation size, is the same either
> way, so this is not a functional change, but the arguments are misleading
> and GCC 14 diagnoses them with -Wcalloc-transposed-args, which is enabled
> by -Wextra.
> 
> Swap the arguments to match the calloc() prototype.
> 
> Signed-off-by: Chaithanya Lagisetty <nagachaithanya9911@gmail.com>
> ---
>  tools/testing/selftests/kvm/lib/userfaultfd_util.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/lib/userfaultfd_util.c b/tools/testing/selftests/kvm/lib/userfaultfd_util.c
> index f7ce5a6ddcc2..49eff05b7d39 100644
> --- a/tools/testing/selftests/kvm/lib/userfaultfd_util.c
> +++ b/tools/testing/selftests/kvm/lib/userfaultfd_util.c
> @@ -119,13 +119,13 @@ struct uffd_desc *uffd_setup_demand_paging(int uffd_mode, useconds_t delay,
>  	uffd_desc = malloc(sizeof(struct uffd_desc));
>  	TEST_ASSERT(uffd_desc, "Failed to malloc uffd descriptor");
>  
> -	uffd_desc->pipefds = calloc(sizeof(int), num_readers);
> +	uffd_desc->pipefds = calloc(num_readers, sizeof(int));
>  	TEST_ASSERT(uffd_desc->pipefds, "Failed to alloc pipes");
>  
> -	uffd_desc->readers = calloc(sizeof(pthread_t), num_readers);
> +	uffd_desc->readers = calloc(num_readers, sizeof(pthread_t));
>  	TEST_ASSERT(uffd_desc->readers, "Failed to alloc reader threads");
>  
> -	uffd_desc->reader_args = calloc(sizeof(struct uffd_reader_args), num_readers);
> +	uffd_desc->reader_args = calloc(num_readers, sizeof(struct uffd_reader_args));
>  	TEST_ASSERT(uffd_desc->reader_args, "Failed to alloc reader_args");
>  
>  	uffd_desc->num_readers = num_readers;
> -- 
> 2.43.0
> 

Good catch
Reviewed-by: Gautam Menghani <gautam@linux.ibm.com>
