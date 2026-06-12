Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E45815B971;
	Fri, 12 Jun 2026 09:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781257471; cv=none; b=skOLyxPiHmCJ1Xr0ziGqjRsvN3IlVCkNisLVdneBscl46J1pWgZ0/hIfgeM/xKsSuwavX9tVi4+cm5Tr3ntHi1YPrmmBmPLAR9XjUz3YxiOM5ijTWfp44D9QsBX9/qzJBTJGxq5E5/qjsvXT3FqxZl7hrezQcX2fkanCXyFfAsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781257471; c=relaxed/simple;
	bh=qE+TvY+tNy5J+9hDTjgArkie2Tc4WbesIG3aCda+3Bk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SGmOw4h6lRk+cilYFfATdtWtJWPiT1PlF1W4YwobJYprch/zkUhJgA7ekpQvmbQL/L7n48uvcLsRBkp6+TCf2YFaluPNQE8uvj1oZozVzKbqaNDZjIUF/EJxieWQsydghXBWG7P0zgPfyMIfnrU7cfxfrgSFDzsayhcj/LvS+Qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ikFwlNSc; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ikFwlNSc"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65BNYoNe677491;
	Fri, 12 Jun 2026 09:43:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=XYUv4E
	zF1jJEj0Bq6xIG3d7viUyK+GP/6tISNu9N7HI=; b=ikFwlNScrcyCFa5dYkjaMh
	KBFtT6PGNaky0azWPEUN+BOU61I5ITaiGdH+MdQJCtd/J6WVAK24Rn9XLGnAzIaA
	nzAXpiE95rsqCJrCVmrYi++bOHlJgSJaWMdS31zUa6R8F1//2N9A0TSVNy62bWPn
	LVO7cAi/X1rp1G2jlw29fO+DDuwhYrfdJEEpg/FtQvxCcycbfLjryN0r9lmh2MvZ
	vJPKqNRWZx55aFlBux2HefTb6yxZnvtjw1BBoNQAb9UdTXVeVj4K6IANsc9gDN+g
	hpqOZGywLGitJv30UJ4fW7jZxoBHfhp2tA6EtyALnp+SsLLKRoR2xp8vBP65WxkA
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eqe8aqxa5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Jun 2026 09:43:46 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65C9Yalg000567;
	Fri, 12 Jun 2026 09:43:45 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4eqe08y7m8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Jun 2026 09:43:45 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65C9hfAN49611166
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Jun 2026 09:43:41 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 980092004B;
	Fri, 12 Jun 2026 09:43:41 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5383420040;
	Fri, 12 Jun 2026 09:43:37 +0000 (GMT)
Received: from [9.39.29.202] (unknown [9.39.29.202])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 12 Jun 2026 09:43:37 +0000 (GMT)
Message-ID: <feba3338-1b1d-40ea-83f7-54328712a71d@linux.ibm.com>
Date: Fri, 12 Jun 2026 15:13:36 +0530
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/10] sched/fair, KVM: Semantics-aware directed yield
 for oversubscribed KVM
To: Wanpeng Li <kernellwp@gmail.com>
Cc: K Prateek Nayak <kprateek.nayak@amd.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, Wanpeng Li <wanpengli@tencent.com>,
        Richie Buturla <richie@linux.ibm.com>,
        Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>
References: <20260612013355.59231-1-kernellwp@gmail.com>
Content-Language: en-US
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <20260612013355.59231-1-kernellwp@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: 38aQu0V4A06bmCcDx61RmKTvajf7pr3y
X-Authority-Analysis: v=2.4 cv=TdKmcxQh c=1 sm=1 tr=0 ts=6a2bd4d2 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=GvQkQWPkAAAA:8 a=dLX7AjkPyFth-2rxqAkA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEyMDA4NiBTYWx0ZWRfX6dLnxyHAH1+g
 sjYQQQ8daYCx0G1DIICHpMfI6s5IgalLRwZYLw+cpZj34vQQy/051JE6fW0PK6mxKGpWlh5rPET
 A+5pkmujPnntKUhqY43ciXVLS402D5MHcjj7zx+q+tRDXBd5ivrEEiAd7Zf1OldUmbjwyz87lB/
 dbpdlMU2OG0kOlczWssVB9lZi0ZTwTqTPdfFIWDv9XFt04WNZjaAjNL4Xbv4bnnRkASkRkWsJQi
 msiMSFzrjG3biFKnvIfC747N0tQ/2aLXBhhWbVxcuogOZk79JcjiA3BmyTYzhTH3/u0yV+uk9JN
 tg0Qtzyw0ThcKYK4jGkVhbj3tj2DrPWvOMsTnfu1bEZKzBj55CfPrDOPQiLZ1090ETkU5wLrtRg
 Ce32hAzJLwRtX4k5qrCvl5sB4mawV3TJYio3NwMiwJ+dNPa2pjhcpTJS40Ze/OAYrNungz4y/9e
 gx26Bv9Xuo+umas+WOw==
X-Proofpoint-GUID: Z7qOhL-NPrbkCeJDj-DaeabpLNQledXg
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjEyMDA4NiBTYWx0ZWRfX7Po8+yadh8Cn
 F8hkvY+PRNIJXDuwfR6XKWeeQsMhQPjL+5kk276FtesGWJZ5fl2Rkry8aBD74kILBpJaS9QdJvs
 v6akaT+jO0SI0XgjCxWvxsTWAro32ww=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-12_01,2026-06-11_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 clxscore=1011 impostorscore=0 adultscore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606120086

Hi Wanpeng.

On 6/12/26 7:03 AM, Wanpeng Li wrote:
> From: Wanpeng Li <wanpengli@tencent.com>
> 
> On overcommitted hosts, a spinning vCPU often calls yield_to() to let a
> lock holder or IPI receiver run.  The hint can be ineffective for two
> independent reasons: the scheduler may fail to select the nominated task,
> and KVM may nominate a task that is not the one the spinning vCPU is
> waiting for.
> 

I was curious to try this as we have been working on paravirt scheduling
which aims at reducing the vCPU preemption based on the steal time.
https://lore.kernel.org/all/20260514152204.481115-1-sshegde@linux.ibm.com/

I gave the patch series a try. With both real life workload(daytrader) and
micro-benchmarks (hackbench) I don't see any benefit. Note that it is running
the same workloads in all VM's at the same time.


I had thought about this series:
- Do you observe steal time when you run your workload? If yes, if you reduce the
   vCPU, IPI will natually move to reduced set and due to reduction in vCPU preemption
   yeild also may not be necessary.

- is there vCPU pinning? workload is pinned separately to explicit vCPUs.

- Is only a few vCPUs doing the locks in the workload you have mentioned in the
   cover-letter?
