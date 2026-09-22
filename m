Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C70C04A3F0C
	for <kvm@vger.kernel.org>; Tue, 22 Sep 2026 19:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790105151; cv=none; b=SrRTVaZaMaI5oqYjfK0SDpcDci2Goe2qkOgkpPyy1Lj9SjFZu5BMgXrqypuqHC0Sw+Sk1Uquc1f+a9KzqtsmOoPpBOqRKuGOfkj+1kW5GBDMPezPzhvEZN13NYt97GQwxPCXBo7+gcPI9WenUYj2InhmF8kAF82y1QKe5HMMFXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790105151; c=relaxed/simple;
	bh=r98Q+kuvWzjCrx/8WWgWEzee71wpL1zD1M5HxGJqpjg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dJM1EcPkn0gRhRl8hnJ/u/zl1gT0eP4b9WN5jGqgNBC91vkgKpkWHbKypo41wdNhejqTCjMYPHHXthZqjiqh4XXKwwPYep0YTRDR20bzcK1BrYafpHQpgNXx2RdhQpNqesmBw74/EWwjiV1YCnZs6mij+PoKNt4q2zpO4N/D3yI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CbrcBypn; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=IKRNLFfn; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CbrcBypn";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IKRNLFfn"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68MIXPlr268302
	for <kvm@vger.kernel.org>; Tue, 22 Sep 2026 19:25:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	DpoZFkZdgs13xlkwMgnRw9MvGQ+ZQQ9iQmjkSWg2E4Q=; b=CbrcBypnVrO/fN+p
	CnXEsVZ6d9JTGpgRxJYCZkWWs7XrdTX3I3rFbDICopGo27Y9blozFkSFlYMAI3Rm
	pt+pa5m8ThJ0Dhp6hqxEJTUfTBbxHyHA/VDlbGsskz9u83yI4UMBBANB4DfZGDwf
	9CstNdBXE161t5jy06BnGL5uerZpZIHylqNk6EmwftpvsnkT6KIZwZlAgpXPCZ6N
	t9Tg9HmwaPw5q36tD5dkFbNWFOsOOUClaKAqc6n/DNVgWDpvxiuQSnvJ67n7Xsnf
	NWlCqM0E+561Lathorab64INAqC3bhnfN19mZq/P2as00f1nTWIYGXOYIEwLFI5T
	wdz0tw==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4guy2c07b5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Tue, 22 Sep 2026 19:25:48 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-32850005b6bso163786eec.0
        for <kvm@vger.kernel.org>; Tue, 22 Sep 2026 12:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790105147; x=1790709947; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=DpoZFkZdgs13xlkwMgnRw9MvGQ+ZQQ9iQmjkSWg2E4Q=;
        b=IKRNLFfnERfC83r9NvVFFyHYlLDG3jSbMwNm0ZOwq7SpaPG7W2w+Lk0Kq/ZDt2aUw2
         lMpNH5uTnobePznPQ5f0n+Dl/KfoSlaNu7ro9AaVC1kNwkFNEhXrHaKAFuifX1aJ4GSt
         WljCrp3uT1X9jmC98mu49uck/BAkCsdKxcXZclG9chSWO636GykrRNOf1/iTNo8tWRA3
         fKnUycIPw6/skyWNIFlUzJ8Lqu3gK//EDZSNKomBwMNpQi4FvYLmRVsuTUyZbbUY7ipV
         CbMCGrS12TGMFvhzHeIFCZjAuzbXXlDpKb1twtm6zqoeF4ls57/PHYXM8XrBA1Pu895u
         gy5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790105147; x=1790709947;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DpoZFkZdgs13xlkwMgnRw9MvGQ+ZQQ9iQmjkSWg2E4Q=;
        b=j6CfW+p/8j0Ww7FMxtYIkfQ/tFCvlKsdauSE4koIgBFQHNHWy37RRwfQwAafpGnPJk
         YrDYKEvsf62O7QUCWfEH/acYn9WZsWeVCrreN+U/xPKWhtWnuvkoki6BFnUZQQf1OCKj
         G8YBEZk7g6BzX/72gT13P1iqXUGmi6LDRB8es1Q1W7Yf5rQmrvMUiA9S09RTobeCAhg6
         pl11+Xzyd7W4M/61paQD0iaHJxMBBxmkcZ82v21a+LASj0g5wxvHe9mNq5GSTCteOVJ6
         cYCVtDty68bR+GD97Ufu3vP305rNWrzNGixmoWNi/bQDDNhCGXtUms47/9BYQpacM1j1
         NcVg==
X-Gm-Message-State: AFuF++npYlhormxmAB6tVyt1IBoISh1CKOaTL276QstS8jCff0EtuRCM
	1lTDuj6grEGNHW6mcU/8/YbzT7g0GLOs/sfpeUNvsNg3mxomrbe1Avs293TKXD61RnRiCgfwNKT
	q/muKn/PbXmK7rd1oY+oO+GCNXoZ1YbsVT06I3x9SWK+uJ+zNWFp6p44=
X-Gm-Gg: AYBFou2xG1xHPfwxsr3TdmML2rPekPmBDSo+9WBiFic10ufCpoeFboljznjQPtVY2EY
	mrnE/SUp0uxX4UdDTBPktNjYBrIu8ab2/zXTVDOwB453Gw5PQlNTiu1PZTLqO4I5B78ObStPH5G
	D337ya6QVR0SCqtmM4sJAtoyAMZdKpbOY/sGAgn8om8ESHsYyM0/FDtoa2bqGOEtVP6LYoDFG7Q
	j09AlX5hIkHBJbbkyH3PaZ6Mv7oqAF9EKjyrdl+iy4g1AE8+S92p+u2cbfnbDrOvfGpEZIoQse0
	j200ky3M5oBLBkX1Clqp/5F7Z9cZSol2fY9h4YYdbF5DMRhqoI7K91UMmhG5ct+XDdVT7csc4XL
	+1JOdkJcU/Rwq43SY61CJVlqXO2KIxie0LdFcXPjXkCcAkWbpYzTRIg==
X-Received: by 2002:a05:7300:fb0a:b0:339:66ff:51b3 with SMTP id 5a478bee46e88-33e8e2b67b8mr229581eec.37.1790105147352;
        Tue, 22 Sep 2026 12:25:47 -0700 (PDT)
X-Received: by 2002:a05:7300:fb0a:b0:339:66ff:51b3 with SMTP id 5a478bee46e88-33e8e2b67b8mr229545eec.37.1790105146727;
        Tue, 22 Sep 2026 12:25:46 -0700 (PDT)
Received: from localhost (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33e96e48e3esm357539eec.26.2026.09.22.12.25.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 12:25:46 -0700 (PDT)
Date: Tue, 22 Sep 2026 12:25:42 -0700
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: kvm@vger.kernel.org, kvmarm@lists.linux.dev, maz@kernel.org,
        will@kernel.org, catalin.marinas@arm.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, steven.price@arm.com,
        aneesh.kumar@kernel.org, oupton@kernel.org, gshan@redhat.com,
        joey.gouly@arm.com, tabba@google.com, yuzenghui@huawei.com,
        linux-coco@lists.linux.dev, gankulkarni@os.amperecomputing.com,
        sdonthineni@nvidia.com, alpergun@google.com, fj0570is@fujitsu.com,
        WeiLin.Chang@arm.com, lpieralisi@kernel.org, enju.kohei@fujitsu.com
Subject: Re: [PATCH v19 01/20] KVM: arm64: protected VM: Handle user writes
 to CNTVCT_EL0/CNTPCT_EL0
Message-ID: <20260922122542.00006868@oss.qualcomm.com>
In-Reply-To: <20260920212845.707-2-suzuki.poulose@arm.com>
References: <20260920212845.707-1-suzuki.poulose@arm.com>
	<20260920212845.707-2-suzuki.poulose@arm.com>
Organization: Qualcomm
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 8JqlnNN18WUTBDJIf9-gel3rcSe67fE8
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDI4NSBTYWx0ZWRfX+POq5lOqykJq
 CDhiT/del5P+gPajTa1VHxTVFPncvbnL2PKuoE/M5fx3Itbv6ei9UU1BgwU3LvWZYwGOdrwexlC
 Vcx/S8Wxl5YZYHmUtRUI2cmpY+Rm+FI=
X-Authority-Analysis: v=2.4 cv=Zsh4uN7G c=1 sm=1 tr=0 ts=6ab2d63c cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=7CQSdrXTAAAA:8 a=wrk9ooTvwJDonXvhXhMA:9 a=CjuIK1q_8ugA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-ORIG-GUID: 8JqlnNN18WUTBDJIf9-gel3rcSe67fE8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDI4NSBTYWx0ZWRfX8on2IOkJ1EX9
 ja20WFFQM+02n3e/PYiAt765l0pQHXP+J5gKOQk355lxslAwTxj91OaahuXA/0j/j9SYdfyFBqW
 4pW4M+S4cuZr/Zzcgly8qFZKLFlLgnzEA5j3clKXDXiY8ysH8Q2QgaGcleeDNV5kIaC38r4Cu8z
 erdiAL0reiQ0JXnSTGDDg2m1h64dvJYdGTUMSph7u7sRQAoQn/rBJ7tg0NnezPApbLOL3EjaNSk
 AEv8WUI02IOJ3uU0ala+Z+UfwH1lXjgnu+79MM4P2WI0hEyWH0mdWUoioXvKpb+q27AAMfKpJq6
 rug9C/mzmWiImOR3jYupyim1X7Kt+TPN3nxIN+wpHOP0TIz1EbOR3DOtCKfdm2jL1YRW4lranhp
 Xw8WsuzOHhvxOXc+TSsHF+05cyg3Mk5Drqg87oHV5dOuc8e5NlZljnuONfUo/R4u2aH8r9Inf1S
 6kQGNIM2VeEAoLeZvog==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-22_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609220285

On Sun, 20 Sep 2026 22:28:26 +0100
Suzuki K Poulose <suzuki.poulose@arm.com> wrote:

Hi Suzuki,

> Protected VMs doesn't allow setting offsets for virtual and phyiscal

physical

> counters, as the offset is always fixed to 0. The VM ioclt is filtered

ioctl

> out based on the cap. However we don't prevent the userspace from trying
> to write to the CNTVCT/CNTPCT registers. This would lead to KVM triggering
> a WARN() in timer_set_offset() as the vm_offset pointer is set to NULL.
> 
> Fix this by always "fixing" the timer offsets to 0 and marking that the
> timer offset is set in the kvm->arch.flags at KVM init time for protected
> VMs. A userspace writing to the CNT*CT_EL0 would observe success, without
> any real effect. This was chosen over preventing the writes to these
> registers and returning -EPERM.

Why?  I don't mind the decision but telling us what was chosen is something
we can see in the code - patch description should give us the stuff we
can't see.

One comment on the comment below.  
> 
> Reported by Sashiko
> 
> Link: https://lore.kernel.org/all/20260908164641.416911F00A3A@smtp.kernel.org
> Fixes: f7d05ee84a6a ("KVM: arm64: Prevent host from managing timer offsets for protected VMs")
> Suggested-by: Marc Zyngier <maz@kernel.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
> Changes since v18:
>  - Retain NULL vm_offset for protected VMs to avoid host tampering with the
>    offset.
>  - Moved the flag setting into kvm_timer_init_vm(), where it should have been
>    in the first place
> ---
>  arch/arm64/kvm/arch_timer.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/kvm/arch_timer.c b/arch/arm64/kvm/arch_timer.c
> index 6ac3321f4c575..226cd5a495c8b 100644
> --- a/arch/arm64/kvm/arch_timer.c
> +++ b/arch/arm64/kvm/arch_timer.c
> @@ -1110,8 +1110,7 @@ void kvm_timer_vcpu_init(struct kvm_vcpu *vcpu)
>  		timer_context_init(vcpu, i);
>  
>  	/* Synchronize offsets across timers of a VM if not already provided */
> -	if (!vcpu_is_protected(vcpu) &&
> -	    !test_bit(KVM_ARCH_FLAG_VM_COUNTER_OFFSET, &vcpu->kvm->arch.flags)) {
> +	if (!test_bit(KVM_ARCH_FLAG_VM_COUNTER_OFFSET, &vcpu->kvm->arch.flags)) {
>  		timer_set_offset(vcpu_vtimer(vcpu), kvm_phys_timer_read());
>  		timer_set_offset(vcpu_ptimer(vcpu), 0);
>  	}
> @@ -1133,6 +1132,15 @@ void kvm_timer_init_vm(struct kvm *kvm)
>  	 */
>  	for (int i = 0; i < NR_KVM_TIMERS; i++)
>  		kvm->arch.timer_data.ppi[i] = get_vgic_ppi(kvm, default_ppi[i]);
> +
> +	/*
> +	 * Protected VMs don't allow any offset being set from userspace,
> +	 * either set via writes to the counters or using the dedicated
This sentence confused me.  Second clause isn't obviously the ways that
are being blocked. Maybe shorten to:

	Protected VMs don't allow the offset to be set from userspace,
	whether via writes to the counters or the dedicated ioctl.

> +	 * ioctl. Pretend the offset has already been set and rely on the
> +	 * default offset being 0.
> +	 */
> +	if (kvm_vm_is_protected(kvm))
> +		set_bit(KVM_ARCH_FLAG_VM_COUNTER_OFFSET, &kvm->arch.flags);
>  }
>  
>  void kvm_timer_cpu_up(void)

