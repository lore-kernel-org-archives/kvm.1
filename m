Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A375E40B6D6
	for <kvm@vger.kernel.org>; Thu, 26 Mar 2026 16:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774540857; cv=none; b=P4MKjNfKyYR41fk6aFIcOHqEtoeEzHi2rjcPJiFwLAZHhPwmMngtQ3OgqTF7reg1KakuLxu/C8zHJ+LKTq8IdCQsJBvLcWIAWYgnXVfJcY4iDJcUqnIXEjTOsuSWn4IfPuXbdaGYkjrwviVlR1jXx7cf+Xd6bxzzUrMskbuE6j8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774540857; c=relaxed/simple;
	bh=7vpLCTUVAkDxR6bZEhiew0W9WLqy4jZ/4JMQSAqKAtk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L2cWENdgPoIgWkZ9LlCA6bMv77O1ft1jb8h93y6pQ50IrImbATlCp3JsD3MGB+YjXlbSPZjXY21Xe7JdRhRSHyMMjveQ+hHBb9dYCpwEuIfBwLom7uaSIG7Zvk7PcvsXaKbwU40eQ2mXQoHpbcyb5r7ArHFDIUgvCb2jbPOgSy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lqPnS6HB; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=T4yx8yyE; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lqPnS6HB";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="T4yx8yyE"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62QF9qIP481189
	for <kvm@vger.kernel.org>; Thu, 26 Mar 2026 16:00:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=ECC+K5fQgmcE5dkI04RZqYls
	9iR/vuOsXzyZFSZOHcs=; b=lqPnS6HBViB5u5fap46r619+PbuzdXnfZtMS4xU+
	igKtkDhfIWDYprk8wHEkHeYgrmkheml/hsZxOh2m9qpdRjPTrg2D2UpD7KPcBKdA
	Zpbb2hZkaVarLGOuG4zzAChhr8Y4MQhzoaq5XrkjfZl5D3lRdN8D2yCFUogyhW+x
	BcSeW8gLfwYymnLMAZfrlDbODT3G8ItOjo+eWwAxWFv7CIP55GVZUlfzy7bVVO9o
	aHZc5WMTOlOB8ZBCgSGoGXJ7WmawJWA/RMPmoVwuHXZ3gYM1lzE75iYQd5xkD1CD
	CdeWmlWWNiCRL0TP/7dRs+8xW7NQZtkK/wrZpwBwHCwXLQ==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d4pymkgy7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Thu, 26 Mar 2026 16:00:53 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-2c17e14e499so1101415eec.1
        for <kvm@vger.kernel.org>; Thu, 26 Mar 2026 09:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774540853; x=1775145653; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ECC+K5fQgmcE5dkI04RZqYls9iR/vuOsXzyZFSZOHcs=;
        b=T4yx8yyEIJzQkxMwixzXXNjMheI9uVAQMQLRpQAVTlGhFEOBDIMuYgKFuEDrn57rIn
         u3fU7/5NTIhVOQsF2OJBPjTUnnRlYGG1vo+EcvD5wTQy+lYq+8Q9I79O7kt6ACYUtusL
         8201CLvd1nl+7KXmw20/Dq+L8LdARI5zp6xaJ7TfvX26p1yUlmLMRK/avDTnJ6NCSO+c
         9UzoWFDhfK8R31oVYdSthVKqAGVOPLYD1V1wtwWhgyH0wLYvaldbR5vcKckTmoPEGo33
         oVnF7yU1FvF0BkLD5urlDqRwVhPxTXK+JUcWiZfFWaSBVJaR30HeIipLWX5BbnJa7n+b
         qhCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774540853; x=1775145653;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ECC+K5fQgmcE5dkI04RZqYls9iR/vuOsXzyZFSZOHcs=;
        b=d7REIdYKmpOHDmhUIW9NQpjoVC968uMHirrRgRBuXq8Medv1w2OTcYb748nFqSjh0o
         6/bQyxkWYS6r/YBbskvFH1K5kc+w6nWjuazTJ8WgSxeZfiGMQ4jZcRSV0rwp51zwvBNL
         1boIj6Gw5Q5CanH4pwWiNlSoFNOZyBIfXYKE8IwxBURP/Cho5YmHKanEXWNr5wOZ6VIw
         LdwG6Z2kNzFjhEQJrtZIkby9uA1QY63Wrq0e/nnnSWoC1mhHXDrZRjRwcCnyqb9S/4bK
         iwOba6mupnyelVLEFgTdAMC+75+1BLLCepC8lSgSm+qU9Hku2T+madk3TLCXUJchP0X1
         Cvwg==
X-Forwarded-Encrypted: i=1; AJvYcCWI6xdm04KZmCGKrwMysq1OiGfsulWXxbGA0qYVJNH+CrlT18Px4MQFZyYRmOmOpd407zE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9e1SHrjdkYOxeC+s83BIIaMilPyNzC6qtJYiERr7SytBjUQie
	VTtQOGQ9A/EQMW8I/R74/dggHpV2Hh0apH6bTr+w8UZ+9ggywSx9BHzQn8biJNm9mzqp74BLeIO
	XCae8GuE0ehyY/JkdYAzRhAn97ZbixGaTt1NpEhCwo6+7wtZ6m5JkR0Q=
X-Gm-Gg: ATEYQzxEnJa/Kl6/CRQoo/8GLGDGTU33q9N3tnsoLgkNrT/UqJjVlyf8YHnr4N9dGNS
	qVFcLPbQ7kt/z7JiftAEf33NPEEtSvN9LSHtxPa9dSj65zZf75/slbR772Wehr3WAz/NvtreI9Y
	2/+4yBGUW3pjC8CtIpRbWXQFZUVb+J/lSVtDPpcbsJ/e1Se3ZQvkTnn0pTAsxG0jS9MgaBlPfCu
	NjgT6zbBAFAeAdAftqAWODTC172J27HrTODFmghElrRDmPkeihWKCHCz+A775nQ6FO0aJy1vnzF
	LxzF1LDGgIYJUtrPGxpwRPPRcoxRpPnDIi9x5yMaC82mbEeS4p8rdTR5/0asT9dlS3PM/RWtNRV
	ALsrtTQf8IDY6CE4toIkOY0hSIN28z3U=
X-Received: by 2002:a05:7022:402:b0:11d:f89d:85a0 with SMTP id a92af1059eb24-12a96ed3fa1mr4307350c88.27.1774540852808;
        Thu, 26 Mar 2026 09:00:52 -0700 (PDT)
X-Received: by 2002:a05:7022:402:b0:11d:f89d:85a0 with SMTP id a92af1059eb24-12a96ed3fa1mr4307304c88.27.1774540852061;
        Thu, 26 Mar 2026 09:00:52 -0700 (PDT)
Received: from localhost ([140.82.166.162])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12aa6513e9bsm4989209c88.0.2026.03.26.09.00.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 09:00:51 -0700 (PDT)
Date: Thu, 26 Mar 2026 11:00:49 -0500
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: Jiakai Xu <xujiakai2025@iscas.ac.cn>
Cc: kvm-riscv@lists.infradead.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
        Andrew Jones <ajones@ventanamicro.com>,
        Anup Patel <anup@brainfault.org>, Atish Patra <atish.patra@linux.dev>,
        Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <pjw@kernel.org>,
        Jiakai Xu <jiakaiPeanut@gmail.com>
Subject: Re: [PATCH] RISC-V: KVM: Fix double-free of sdata in
 kvm_pmu_clear_snapshot_area()
Message-ID: <2bepmdibreb2mkxxgmrbenfl5tnx4jgxddzvsd4h6ii6myqw6v@tuqenrqdfutj>
References: <20260318092956.708246-1-xujiakai2025@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260318092956.708246-1-xujiakai2025@iscas.ac.cn>
X-Proofpoint-ORIG-GUID: 5btJVt5mha6u03ZVRk4945e5gUoW3mOi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI2MDExMiBTYWx0ZWRfX93wczeOApfPl
 SYt7D6kSloHNTSBvrMxltfk37NEPZFQDbigzsWRZucc3w4c/b3BhEQU7JZewZPhKpf7qCjmHP77
 yxvSr2J0eZKdB4dVhR5VHWA/NTKeB8doTSpPWO4uPH7j+sw5wZpo289jsZ2en4CkI4anA0f8Q+6
 mc+3/dcJgV2LCS47d7H0GL7KLe3sJhqSznTuz96YAOpmhEGOSbwd3kj4W3c11yXRDtqw1lv/4od
 2uRUqC3rFmI/wa53ASNwswNXYhJc1aSEHVdfkNx6pDHcaoqGi5i0WUtXclXWBvjJh1EYe6ghjl4
 TNE/fh7H6ptjq5CtmVg7tWo1Oo1ItSwiTmmmHygnApTumpkSzvbriiQUrepgXvTig96d8PaF56L
 PXjJJbElXTZJGrt5T+B3H7GJcRjFNCrL7LvoHbOMqdb8BJ4qlrWmfGEGvsII818iqftqrFhuzRT
 Lf2icBJ2yP8mxoMorEQ==
X-Authority-Analysis: v=2.4 cv=SvedKfO0 c=1 sm=1 tr=0 ts=69c55835 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=cvcws7F5//HeuvjG1O1erQ==:17
 a=kj9zAlcOel0A:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=FA8e0eGMvKrdCSP4i1MA:9 a=CjuIK1q_8ugA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-GUID: 5btJVt5mha6u03ZVRk4945e5gUoW3mOi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_03,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0 phishscore=0
 clxscore=1015 adultscore=0 impostorscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603260112

On Wed, Mar 18, 2026 at 09:29:56AM +0000, Jiakai Xu wrote:
> In kvm_riscv_vcpu_pmu_snapshot_set_shmem(), when kvm_vcpu_write_guest()
> fails, kvpmu->sdata is freed but not set to NULL. This leaves a dangling
> pointer that will be freed again when kvm_pmu_clear_snapshot_area() is
> called during vcpu teardown, triggering a KASAN double-free report.
> 
> First free occurs in kvm_riscv_vcpu_pmu_snapshot_set_shmem():
>  kvm_riscv_vcpu_pmu_snapshot_set_shmem arch/riscv/kvm/vcpu_pmu.c:443
>  kvm_sbi_ext_pmu_handler arch/riscv/kvm/vcpu_sbi_pmu.c:74
>  kvm_riscv_vcpu_sbi_ecall arch/riscv/kvm/vcpu_sbi.c:608
>  kvm_riscv_vcpu_exit arch/riscv/kvm/vcpu_exit.c:240
>  kvm_arch_vcpu_ioctl_run arch/riscv/kvm/vcpu.c:1008
>  kvm_vcpu_ioctl virt/kvm/kvm_main.c:4476
> 
> Second free (double-free) occurs in kvm_pmu_clear_snapshot_area():
>  kvm_pmu_clear_snapshot_area arch/riscv/kvm/vcpu_pmu.c:403 [inline]
>  kvm_riscv_vcpu_pmu_deinit.part arch/riscv/kvm/vcpu_pmu.c:905
>  kvm_riscv_vcpu_pmu_deinit arch/riscv/kvm/vcpu_pmu.c:893
>  kvm_arch_vcpu_destroy arch/riscv/kvm/vcpu.c:199
>  kvm_vcpu_destroy virt/kvm/kvm_main.c:469 [inline]
>  kvm_destroy_vcpus virt/kvm/kvm_main.c:489
>  kvm_arch_destroy_vm arch/riscv/kvm/vm.c:54
>  kvm_destroy_vm virt/kvm/kvm_main.c:1301 [inline]
>  kvm_put_kvm virt/kvm/kvm_main.c:1338
>  kvm_vm_release virt/kvm/kvm_main.c:1361
> 
> Fix it by setting kvpmu->sdata to NULL after kfree() in
> kvm_riscv_vcpu_pmu_snapshot_set_shmem(), so that the subsequent
> kfree(NULL) in kvm_pmu_clear_snapshot_area() becomes a safe no-op.
> 
> This bug was found by fuzzing the KVM RISC-V PMU interface.
> 
> Fixes: c2f41ddbcdd756 ("RISC-V: KVM: Implement SBI PMU Snapshot feature")
> Signed-off-by: Jiakai Xu <jiakaiPeanut@gmail.com>
> Signed-off-by: Jiakai Xu <xujiakai2025@iscas.ac.cn>
> ---
>  arch/riscv/kvm/vcpu_pmu.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/riscv/kvm/vcpu_pmu.c b/arch/riscv/kvm/vcpu_pmu.c
> index e873430e596b2..ac1b9a91a19db 100644
> --- a/arch/riscv/kvm/vcpu_pmu.c
> +++ b/arch/riscv/kvm/vcpu_pmu.c
> @@ -441,6 +441,7 @@ int kvm_riscv_vcpu_pmu_snapshot_set_shmem(struct kvm_vcpu *vcpu, unsigned long s
>  	/* No need to check writable slot explicitly as kvm_vcpu_write_guest does it internally */
>  	if (kvm_vcpu_write_guest(vcpu, saddr, kvpmu->sdata, snapshot_area_size)) {
>  		kfree(kvpmu->sdata);
> +		kvpmu->sdata = NULL;
>  		sbiret = SBI_ERR_INVALID_ADDRESS;
>  		goto out;
>  	}
> -- 
> 2.34.1
>

Reviewed-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
