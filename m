Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E693BC67E
	for <kvm@vger.kernel.org>; Mon, 13 Apr 2026 11:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776080240; cv=none; b=uxtraOUbcIK3EKbQcsuFSoHykF3y7pkp6DfTC+E70XjF7yw7VuYgrJ30i1OTiDUukopPbbfijRII2YiKfJ43zxNmbIAgXN+8gqd14xI8xOfBWCoU1Kwj3N30GLsM0MR1BpkZRKS0PW7Q1P3trcWnpzS8av4oorX4LSD9CB9AmUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776080240; c=relaxed/simple;
	bh=iiNmqTLrTVhIhjHWA3iAL5APsYYcoeEBZG72zgEjIzw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ePsX1mG0OzxVle4jW404HxETq3VWcgktrkEUpd6MkLnHFGLg6xdbrRnwCBQsnwPvfckRlAe33QVitW5iqgkh6LPUvbfiaPgNZZiMeiksiKanGqhVgfx3LiaxNXW2oJUMStlL/l6f9rjHs0pyhZsfC6YT7cx9754KdLsXTknDnQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ICxS+Txa; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ICxS+Txa"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63CLtcHV3213180;
	Mon, 13 Apr 2026 11:37:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=jHepOC
	uTklpTDiLS/v6IL9l8lsKTi9amvT8oND3QWcU=; b=ICxS+TxaQFa3D4Koypv2c2
	IIevRjPQNyI2YsmAJptoyzLV85Hi5LpUyn0ED2vlYkuoA8OcFxrk9zrTJzvsBYsy
	X/YvSeYzWu9xUNqYDQlBDnyUxufqfP5TMRNiCv/adD+Q7cq9S7UzDRgLVBoagXkt
	6nTRGQjCJGv6/ppov4dXtez8ohbgzWWoSNiyvvV5Oe+bRAEM0+D7TSSrREso6M1N
	t6xGNGImQwszfxyyPk63W5JhayIqttmM4Ut3vbOuOGvLsBUdDtaHEN4KHGukrCX3
	OUYIUtgrgQyjqZ2N8+2AnpQS/0McadiOWhX9mDzY/nII9BUefSK6QzXK6Eu2upjg
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dfbqkf950-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Apr 2026 11:37:02 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63D8vPb6003581;
	Mon, 13 Apr 2026 11:37:01 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dg1mn4xf4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Apr 2026 11:37:01 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63DBb0jf29360806
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Apr 2026 11:37:00 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3FCFA58043;
	Mon, 13 Apr 2026 11:37:00 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 586EF58053;
	Mon, 13 Apr 2026 11:36:57 +0000 (GMT)
Received: from [9.123.0.169] (unknown [9.123.0.169])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 13 Apr 2026 11:36:57 +0000 (GMT)
Message-ID: <0954ef7e-b04e-4542-89fb-796acc452068@linux.ibm.com>
Date: Mon, 13 Apr 2026 17:06:55 +0530
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 for-11.0] accel/kvm: return early from
 kvm_irqchip_create if kvm does not support irqchip
Content-Language: en-GB
To: Ani Sinha <anisinha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: peter.maydell@linaro.org, Misbah Anjum N <misanjum@linux.ibm.com>,
        Gautam Menghani <gautam@linux.ibm.com>,
        Fabiano Rosas <farosas@suse.de>, kvm@vger.kernel.org,
        qemu-devel@nongnu.org
References: <20260413112151.61261-1-anisinha@redhat.com>
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <20260413112151.61261-1-anisinha@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=I+9Vgtgg c=1 sm=1 tr=0 ts=69dcd55e cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=f7IdgyKtn90A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22
 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8 a=Y_7XUuprIgRBB3N_oLcA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: HoeGeDP2Q7PnjKqx4jI4OcKS71H9Iwb6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEzMDExMSBTYWx0ZWRfX96E9rF2Rp7dT
 P/j9riur638eRzmE1J0m68oG0HcIVlSAU9Tu5wudCBwrgim9IvpnRokqdUmJGKJtptQU8yBQJOp
 A6nwrV5NDojqy9DIwkyo0soes1vkF0IClysmOoh07woSBgCPrggjxlByeqMGdkY03fuNiGbDlx/
 3D2jrniiD2e0G8c+BOWQuMcN23xia8oBk3/S7awzc8/1v+XEik4TIFkn/rxlMyUTgCf1n//1Vfi
 Ya7dFz+PNQF9fihkWYmwXChb//H7B78EYRFlwtiQIxiAnb5COrwRscZ3J224hwRMB2SmZnwIbbz
 Ozon63WiEfYrdA+QMywbv7oKO1KW0OxKjTv3bfeDyni70eL0ZRG9xhIezUEl0yMRcC1Lf+Wypxm
 k+f2bgObK8Q897WT3H6zFLSJF+L9oNaqEhemOcPumZhS3Ym5srgU+gDd7LWUACIWNE1NPdlQJFq
 47JHZlnXY1X25MYzARQ==
X-Proofpoint-ORIG-GUID: HoeGeDP2Q7PnjKqx4jI4OcKS71H9Iwb6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-13_03,2026-04-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 bulkscore=0 suspectscore=0 adultscore=0
 lowpriorityscore=0 spamscore=0 malwarescore=0 clxscore=1011 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604130111



On 13/04/26 4:51 pm, Ani Sinha wrote:
> During refactoring of kvm_irqchip_create(), the refactored code was returning
> early from do_kvm_irqchip_create() function if the required capabilities were
> not present in KVM. This was not translating to an early return from
> kvm_irqchip_create() as was the case before refactoring. This is because,
> do_kvm_irqchip_create() did not have a means to notify the caller of the lack
> of kvm capabilities. Fix this by making do_notify_irqchip_create() return
> EOPNOTSUPP error when required capabilities are absent and then the caller
> can check the return code and return early.
> 
> Converted some calls to exit() to assertion checks in order to make it cleaner.
> 
> Fixes: 98884e0cc1 ("accel/kvm: add changes required to support KVM VM file descriptor change")
> Reported-by: Misbah Anjum N <misanjum@linux.ibm.com>
> Reported-by: Gautam Menghani <gautam@linux.ibm.com>
> Suggested-by: Fabiano Rosas <farosas@suse.de>
> Suggested-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
> Signed-off-by: Ani Sinha <anisinha@redhat.com>
> ---
>   accel/kvm/kvm-all.c | 29 ++++++++++++++++-------------
>   1 file changed, 16 insertions(+), 13 deletions(-)
> 
> changelog:
> v2: converted some exit() calls to assertions.
> 
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index 774499d34f..c78bf6a56f 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -2575,7 +2575,7 @@ void kvm_irqchip_set_qemuirq_gsi(KVMState *s, qemu_irq irq, int gsi)
>       g_hash_table_insert(s->gsimap, irq, GINT_TO_POINTER(gsi));
>   }
>   
> -static void do_kvm_irqchip_create(KVMState *s)
> +static int do_kvm_irqchip_create(KVMState *s)
>   {
>       int ret;
>       if (kvm_check_extension(s, KVM_CAP_IRQCHIP)) {
> @@ -2587,36 +2587,38 @@ static void do_kvm_irqchip_create(KVMState *s)
>               exit(1);
>           }
>       } else {
> -        return;
> +        /*
> +         * neither KVM_CAP_IRQCHIP nor KVM_CAP_S390_IRQCHIP capabilities are
> +         * present. Bail.
> +         */
> +        return -EOPNOTSUPP;
>       }
>   
> -    if (kvm_check_extension(s, KVM_CAP_IRQFD) <= 0) {
> -        fprintf(stderr, "kvm: irqfd not implemented\n");
> -        exit(1);
> -    }
> +    assert(kvm_check_extension(s, KVM_CAP_IRQFD));

again changing behaviour ?
previously it was doing exit(1) on returning non-zero.
Now, it will assert on returning zero ?
May be split the patch to keep the exit -> assert changes separate ?

>   
>       /* First probe and see if there's a arch-specific hook to create the
>        * in-kernel irqchip for us */
>       ret = kvm_arch_irqchip_create(s);
>       if (ret == 0) {
> -        if (s->kernel_irqchip_split == ON_OFF_AUTO_ON) {
> -            error_report("Split IRQ chip mode not supported.");
> -            exit(1);
> -        } else {
> -            ret = kvm_vm_ioctl(s, KVM_CREATE_IRQCHIP);
> -        }
> +        /* assert that split IRQ chip mode is supported. */
> +        assert(s->kernel_irqchip_split != ON_OFF_AUTO_ON);
> +        ret = kvm_vm_ioctl(s, KVM_CREATE_IRQCHIP);
>       }
>       if (ret < 0) {
>           fprintf(stderr, "Create kernel irqchip failed: %s\n", strerror(-ret));
>           exit(1);
>       }
> +
> +    return 0;
>   }
>   
>   static void kvm_irqchip_create(KVMState *s)
>   {
>       assert(s->kernel_irqchip_split != ON_OFF_AUTO_AUTO);
>   
> -    do_kvm_irqchip_create(s);
> +    if (do_kvm_irqchip_create(s) < 0) {
> +        return;
> +    }
>       kvm_kernel_irqchip = true;
>       /* If we have an in-kernel IRQ chip then we must have asynchronous
>        * interrupt delivery (though the reverse is not necessarily true)
> @@ -2835,6 +2837,7 @@ static int kvm_reset_vmfd(MachineState *ms)
>       }
>   
>       if (s->kernel_irqchip_allowed) {
> +        /* ignore return from this function */
>           do_kvm_irqchip_create(s);
>       }
>   

