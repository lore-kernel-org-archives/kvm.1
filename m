Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0393A583ACC;
	Wed,  9 Sep 2026 16:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788971983; cv=none; b=ANI5O0C818VfxwxNIMVIM76jh11EDpfwpWh8uG1o11ZemDvG5V+I6+rqgnWxlpoi1edvVgHh8bxlx0uvNnAbKd6DO7VCi/ORY42Sm01Eeqa+jMNZkLlsxsoVkrK+S3HDVK8whmEyc0O3VvR0yJhcRHKOoMgxOgfMsDPwWV9t7Og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788971983; c=relaxed/simple;
	bh=pIDXAc8n5rCwfY00O1emkjXRT0qj9W6LxzK1ndPe5cA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jleU9xaz+H69NnB+2qTsXauKXcZ6t+V7wFnE5SS2KFRZxbxLaw7Yx21JSO19Whe2kWVkukZCwOKrw9mK7wNu5gNhqYg22AQufs6OmfFrxUGSo0zPd5BR8KuCJgENUEWRFO2gGg33hdtp1gG4wbsW6OiYN3IObcC+BVs7RQerZBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=mbQ+o5Kc; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="mbQ+o5Kc"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 689B1iVY3839788;
	Wed, 9 Sep 2026 16:39:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=a5iJwZH/C5crXJxQS3Xb797pc9AYFK
	l4Bix9FKZMfpU=; b=mbQ+o5KcqSDdKEyiuYPhxzHbEoU+RnYhYbM7BxT1yMufW8
	cY6doDF9+58RjyZocf42SxyZPtKQ89nweF2cHYTwzDEYEj64Wk4pjBVP0D0YtNn5
	ilCvNxCdIXRoVvDyEJQwG5/dPk4rfYAMFvt+D2cC1BwRgfS7erAFp8IGa2LxSvlz
	243skpsfvwWkEAgp7yTMY2wc4YLtFdHhhvuwyeJCCrLLTmX9bvWlqt6tO42PfBxi
	erOy37k/U5RKGt/USmEvxyUzjVb8KWlApR9OSuS71aTYSTUX5lKWVRNKNrV0NNHB
	vsmBPRFxEEKLwiC41+dKDD7xZHAtVxBNzJ8DskOA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ggbhf6rrs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Sep 2026 16:39:37 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 689GQEOm023349;
	Wed, 9 Sep 2026 16:39:36 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gh03yk54f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Sep 2026 16:39:36 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 689GdYE747776028
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 9 Sep 2026 16:39:34 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7848B20043;
	Wed,  9 Sep 2026 16:39:34 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8BF3520040;
	Wed,  9 Sep 2026 16:39:32 +0000 (GMT)
Received: from Gautams-MacBook-Pro.local (unknown [9.39.30.71])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed,  9 Sep 2026 16:39:32 +0000 (GMT)
Date: Wed, 9 Sep 2026 22:09:29 +0530
From: Gautam Menghani <gautam@linux.ibm.com>
To: Chaithanya Lagisetty <nagachaithanya9911@gmail.com>
Cc: pbonzini@redhat.com, seanjc@google.com, shuah@kernel.org,
        kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: selftests: Fix the never-true negative UFFD delay
 check
Message-ID: <aqGLwQQZ9FQ5qCtG@Gautams-MacBook-Pro.local>
References: <20260907045246.3783304-1-nagachaithanya9911@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260907045246.3783304-1-nagachaithanya9911@gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: TQOT7jT9L61QURCLz4-YRtoazKCQrZva
X-Authority-Analysis: v=2.4 cv=RIaD2Yi+ c=1 sm=1 tr=0 ts=6aa18bca cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=pGLkceISAAAA:8
 a=VnNF1IyMAAAA:8 a=V1kCjGv-ZFlEZ27KLaEA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA5MDE4NCBTYWx0ZWRfX3V+KSTzTH8WD
 b2cduup5S192jBnOw1bNszzE/cTDG2Ay5RcOBEbhhRWRcjYeJhefAb01163hoWgUXF3zqyE9/Fy
 MM4NFe4UWtsCwTi+42ucxvTSmeIRPM8=
X-Proofpoint-ORIG-GUID: UNsCqmGcdIxFbDuYUo7aU4jokU66j3yD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA5MDE4NCBTYWx0ZWRfXz7r/lxPnEkwk
 fr7Vb1q8Ct15kSv1fvEpa166lrtjJWGWEDWNL1YYZy7e4DDQo7GuGXOarcEUmzOEkpio0KFCcqk
 SVooiR1+rrkzINsqyNamM7iVMBVk6S9GOTCwP7xb79I5NRwipsddOSwA+YIwL/G3QGDLPrVQ35M
 1i8/xNQ4SvyeuJ/oakOS4wZv09bndTr/F6JoWUCFXPWeldxD26iHVYO04yszBgvn1itzVgSAPx6
 5sDgefcH68yVAB0LzTgFy0LLPItxg43BsS6xD4td8hsz03ISL5CEu+U+NJKUHMOp3uGSnUOIyKJ
 ldrOJCvGPp4GxQi2Yiz0usfWsQh/3SagKboW2ndEuexpgLOF3WPmyhkEfBKR+mB0E9jKy2eh1Zw
 xRoC0ZFFm9RVosNlxuppBEhayjsl+G1iLp1V6CTgNX2qpuSH8+MMOnjjWIMjfZULJLjeP8cIatF
 Y4OS0AmFY26Ob9YCUDA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 malwarescore=0 priorityscore=1501 bulkscore=0
 adultscore=0 phishscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609090184

On Mon, Sep 07, 2026 at 04:52:46AM +0000, Chaithanya Lagisetty wrote:
> demand_paging_test parses the -d option with strtoul() and then asserts
> that the result is not negative:
> 
> 	p.uffd_delay = strtoul(optarg, NULL, 0);
> 	TEST_ASSERT(p.uffd_delay >= 0, "A negative UFFD delay is not supported.");
> 
> p.uffd_delay is a useconds_t, which is an unsigned type, so the comparison
> is always true and the assertion can never fire. GCC points this out with
> -Wtype-limits, which is enabled by -Wextra.
> 
> As a result, "-d -1" is accepted and converted to a very large unsigned
> delay, causing each demand paging fault to sleep for an unexpectedly long
> time in usleep() instead of rejecting the argument up front. The return
> value of strtoul() is not validated either, so a non-numeric argument
> such as "-d abc" is silently treated as a zero delay.
> 
> Use atoi_non_negative() instead. It rejects negative values, unparsable
> input, and trailing garbage. It is already used a few lines below for -v,
> and hexadecimal input keeps working because atoi_paranoid() also passes a
> base of 0 to strtol().
> 
> Fixes: 0119cb365c93 ("KVM: selftests: Add configurable demand paging delay")
> Signed-off-by: Chaithanya Lagisetty <nagachaithanya9911@gmail.com>
> ---
>  tools/testing/selftests/kvm/demand_paging_test.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/demand_paging_test.c b/tools/testing/selftests/kvm/demand_paging_test.c
> index f8b3d0b68830..619a0b2be45c 100644
> --- a/tools/testing/selftests/kvm/demand_paging_test.c
> +++ b/tools/testing/selftests/kvm/demand_paging_test.c
> @@ -297,8 +297,7 @@ int main(int argc, char *argv[])
>  			p.single_uffd = true;
>  			break;
>  		case 'd':
> -			p.uffd_delay = strtoul(optarg, NULL, 0);
> -			TEST_ASSERT(p.uffd_delay >= 0, "A negative UFFD delay is not supported.");
> +			p.uffd_delay = atoi_non_negative("UFFD delay", optarg);
>  			break;
>  		case 'b':
>  			guest_percpu_mem_size = parse_size(optarg);
> -- 
> 2.43.0
> 

With this patch applied, the test fails as intended:

# ./demand_paging_test -d -1
Random seed: 0x236c0ed9

==== Test Assertion Failure ====
  include/test_util.h:236: num >= 0
  pid=3674565 tid=3674565 errno=0 - Success
     1  0x00000000004010d0: atoi_non_negative at test_util.h:236
     2   (inlined by) main at demand_paging_test.c:300
     3  0x00007f907d9f05b4: ?? ??:0
     4  0x00007f907d9f0667: ?? ??:0
     5  0x0000000000401374: _start at ??:?
  UFFD delay must be non-negative, got '-1'


Tested-by: Gautam Menghani <gautam@linux.ibm.com>
Reviewed-by: Gautam Menghani <gautam@linux.ibm.com>
