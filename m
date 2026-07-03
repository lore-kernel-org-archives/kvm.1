Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FED63AE187
	for <kvm@vger.kernel.org>; Fri,  3 Jul 2026 09:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783070143; cv=none; b=smviAwCnVGvUyk3qmdNt/z0RjcYSJzbNOxHc8wz4iXqQVdG6lV6cYjRTYrQeD40zwr8u5OrbDhbw7ile+tjNpNTj0Ija7k4S5Of9gftVmaH+F25DUgqEr4BVdKOyTeNtkrGeG0BX4X4TmxQOSk38ZBJq/xDihnrroQLd7lWYb2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783070143; c=relaxed/simple;
	bh=ni2p+6hQxi9gj1jNTiWf7lwZKlMl0ChQh0YlhgjDN3s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fr+A0Ux43ySQPMJToiGgnqX2a8tO4MTmHOrZ6vBt1YU9QuiD2VTJ6R+ooc/I4uJJ4U5HC5t8r97uH8WpUT4a/m9JZphvELuurIz0aLeB4XxKy3yNFhptmLaUUvoQYSMS4ww5sZPmnm+QnUmHJU9mQoVvcMLqiZph5G5avu9YsqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=D0lKoil5; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="D0lKoil5"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6636IBgl1930444;
	Fri, 3 Jul 2026 09:15:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=3tbBQs
	MYUv1mO4u/Dzz1Dbo3TxiGu2Fjia/ijhGetHI=; b=D0lKoil5kCoi7gz8VAJdLY
	QV83mQVwEq4nn4jRqvO+ME/OIIKS2WpJXOhwBTqF8mjRbwdRb3mBYlAyCUnN41qi
	bDsLInPmLWT3CBuPf059NMiAz+jxdzALEv1E5oj+ktneoqkTywxgPhVjRH4UZzjd
	4WSoaxIkCu75SlwoafiWDzSJevaXn1iT+6UvEsbMMEwmouxIPziUXlmC4+MUaKUb
	9IY8uMeM06zaOnNoQBB7T1hEi9rEyg+hKS6URBURH20b/AyEjz35oUQYNS+mqdJG
	0DQwaj93VbucdHxjaQ1c2LrmZ7P4xgfqv0gzL5hIXeTabYMX8bI3CMGM94nn/yWQ
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26peegas-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 03 Jul 2026 09:15:26 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66394bWA014961;
	Fri, 3 Jul 2026 09:15:25 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f2u2gqy2w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 03 Jul 2026 09:15:25 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6639FOlT30540518
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 3 Jul 2026 09:15:25 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ABBB45804E;
	Fri,  3 Jul 2026 09:15:24 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DAE0958062;
	Fri,  3 Jul 2026 09:15:14 +0000 (GMT)
Received: from [9.39.22.184] (unknown [9.39.22.184])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  3 Jul 2026 09:15:14 +0000 (GMT)
Message-ID: <0712c1d5-12bb-467e-80a7-dfb516cd0bc6@linux.ibm.com>
Date: Fri, 3 Jul 2026 14:45:12 +0530
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 RESEND 8/8] MAINTAINERS: Add self as maintainer for
 PowerNV
Content-Language: en-GB
To: Aditya Gupta <adityag@linux.ibm.com>, qemu-devel@nongnu.org,
        qemu-ppc@nongnu.org
Cc: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
        =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
        Shivang Upadhyay <shivangu@linux.ibm.com>,
        =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
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
        Chinmay Rath <rathc@linux.ibm.com>,
        BALATON Zoltan <balaton@eik.bme.hu>,
        Nikhil Kumar Singh <nikhilks@linux.ibm.com>
References: <20260703085955.2318600-1-adityag@linux.ibm.com>
 <20260703085955.2318600-9-adityag@linux.ibm.com>
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <20260703085955.2318600-9-adityag@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: 7yK957c3BtcJN8HGpfKDET05hm62NInD
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDA4MyBTYWx0ZWRfX8oZKocDqatiM
 fggNpsAPjDZ8IEKwo0GdHrElHM52gROm/SprrDhKOedR9NN2JxkSFAfNNeadGn99ePBpO1XecfJ
 TbVJRUSpZQDfdJHNfc8q+FdzkrJE9uw=
X-Authority-Analysis: v=2.4 cv=edsNubEH c=1 sm=1 tr=0 ts=6a477daf cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=f7IdgyKtn90A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22
 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8 a=69wJf7TsAAAA:8 a=k8VJCrWnqjn4nz9fRZ0A:9
 a=QEXdDO2ut3YA:10 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDA4MyBTYWx0ZWRfX4VRab6r2FqOR
 OdZlCVAAoywhY5dousTB9VWFi9XSw0aerWU88q4aYgIoEvNf5RSNr5+mqwlpcBI6laymAjdBAic
 YCry5/Wo94GGHcAB/tc/yGwkaNTiVy3jSSta30s8IKlzTwDT4ePXIaGVHELb48cdtfDLk7NrAK2
 rQZEA5f+suNxCtBMU1NRC68zx5kd+xtDGLskC6OYnekrtufbqQEPCvS/EFsX+OylsmUvvGcJi75
 g07ncv+GkyDdnPlxmuR58BSreVUgF81PScIXGJrOp1Bw30WHH4P5PVC71rvjIudjRcv+TurFQZU
 b3s3neNrWgrcjTgQQtmhIwZoeYZfvKqJrWTNbiCUyi0CzlCsuucrFKGrwAOvvxw/3Kp0rWJ07eS
 MRpCzgvbIPALLPG8IQnbTQIvf0ciU/+i0OspIJTHDjHEFPjpPw/KolxRnOPjGOFb2kgyapsUelA
 GD6clAOoqBr3+w2G70g==
X-Proofpoint-ORIG-GUID: Mi9rRut6CmiXDwluaUP-WceOSp8fPFnQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 adultscore=0 impostorscore=0 bulkscore=0
 spamscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030083

Hi Aditya,

On 03/07/26 2:29 pm, Aditya Gupta wrote:
> Add myself as maintainer for PowerNV machine, and remove the
> reviewer entry
> 
> Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
> ---
>   MAINTAINERS | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 97dcc78ded61..537b5cd895a2 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1663,7 +1663,7 @@ F: tests/functional/ppc64/test_tuxrun.py
>   
>   PowerNV (Non-Virtualized)
>   M: Nicholas Piggin <npiggin@gmail.com>
> -R: Aditya Gupta <adityag@linux.ibm.com>
> +M: Aditya Gupta <adityag@linux.ibm.com>

Thanks for helping co-maintain PowerNV!

Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>

Hi Cedric,
Any further review comments on the series or would be happy to provide 
an ack?

regards,
Harsh

>   R: Glenn Miles <milesg@linux.ibm.com>
>   R: Harsh Prateek Bora <harshpb@linux.ibm.com>
>   L: qemu-ppc@nongnu.org

