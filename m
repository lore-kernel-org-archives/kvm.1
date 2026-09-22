Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14E3B52F284
	for <kvm@vger.kernel.org>; Tue, 22 Sep 2026 22:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790116721; cv=none; b=aX3K1ZfyQR9efM7WICOU633L9oSBBhXOO2DgmmoYNxBo4yzulfH9QniYsACLPOlVyyccrPYpoNvt/NRFbTsOc1gR980xlLBXwx31lSJU1GDaCf2Fib6HaWusQmnO1daymD0ggjtN6o9X7n97No8rQnxnUEeU0RYSsF1mUp36XAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790116721; c=relaxed/simple;
	bh=3/dkNKPPZhwKNFM+qynUyX6vwgw0I5X2dRSwnLFGk2s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ef+QoV3l1MHMF1OdenZne2GWyu3k/0RVDMJq26U4g8DghnG7nOQdF/6PjXuV5LXa4qnySa1+ljFcEN5Tr+zgYjpsgQc33iU7no/+TUbryxzVi6tv+73qOQzcMqhz6eL9zdfFtI2MONOLdff511ZS/wiTac5J8BpGgS9Z0YX2Mpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=l2rd/8n+; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FOv3Q6kA; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="l2rd/8n+";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FOv3Q6kA"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68MI74Gn1509190
	for <kvm@vger.kernel.org>; Tue, 22 Sep 2026 22:38:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	tJNsu2FLCP1qcNEgoJs+KWNxYkGyFkvDNQdnRnSNx7A=; b=l2rd/8n+B47hSsLp
	dm9rKeJBloJJpWBYD9tTfVg5N4yZY3zxA2FdiNYnkn2Pdi87lB1r2vkiI6CIntcY
	biQPC3m8sZaHuOy7q40XCHL9Eu3dJhllRZVG1gkzMxduv4bmkRXqNqxjwd7NKhys
	3Rpp23gtahCeBn43yLdo/u9zoSqDZqDiOS5Ik187wrsvc9W47NQCEh0qUiMsp55k
	3Yx+arcyLIFHBbKIOoTtiZNno87NlNTaIbJU/9rLur+mUeXT+yxNW+sZA2VdfgCH
	aXxsrFn+XMTr0DD5H6dnQsmljDDhoIQnpYM1cJfupuhReouDDrKxqnQc7Xcl3ppU
	nmvQog==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gux7xse27-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Tue, 22 Sep 2026 22:38:32 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-334f782d1abso676253eec.0
        for <kvm@vger.kernel.org>; Tue, 22 Sep 2026 15:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790116711; x=1790721511; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=tJNsu2FLCP1qcNEgoJs+KWNxYkGyFkvDNQdnRnSNx7A=;
        b=FOv3Q6kAG8ZHpzbv9WSJZxd7e4ptg4ZyR3qXBnZIqoPoF1Ds1hhzLl3BK7byKRyC0l
         nq3+/aVo2THzHyldLKu8D1AR1YmatFQ/jbplBFCcQhij5QSHZID6hUTvsOa2vxfkHpyz
         N9lY5Zzk5l29J6ZNGiSTwMufZYOKRvNM7dZoI5cZkjrvtE9ozeO1hk5mikBYmqlAJSgt
         o6FHijaAH0NjVr+SBOEwdRuN9BQVe3xiWmk93mcpimikCCVsdN+Qpx95vXResfl2iU/l
         JfSEIgJJ0SNUWoxjhYT6jVld3+Ibp0P017dk+yTw4YSbioIgB4OCjcZU+uECOu3344Mp
         yStg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790116711; x=1790721511;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tJNsu2FLCP1qcNEgoJs+KWNxYkGyFkvDNQdnRnSNx7A=;
        b=2Xebh1wqoRCxmCLE6whTaWU1P/0fKT8r2yNOPRbBnRvF/zqv28L3GaAyg1ggfea+Gp
         q55VpwvQql41ZN2IFCm0O+h7M9HFRNNHC+j2DQlfCTc0VTRNVvPzZw66aa/K8jst4qw5
         GuKsTCBzRz2uuZm14jNrSQHCMSe2KCu6JsfbIiG5Rou/rtiVRliLE0DjNdk9qc5ZuUMb
         n10FMYbGhoAcOLqupmQOaqyWb3M0uUC3DsW+cxoqCGYWZsMrQjfJvJbHfBFkTL2sAf8u
         m2Z+PEkdH+e7IdE485D2LzDUNyeYoJpfRX0aVBPXYPBl2bs84075V70lmQ8d3AddoT5k
         VIPw==
X-Gm-Message-State: AFuF++l14fNAc1B2ecmgPM0L99SI+Hynd0k5eGMJRxRR7EQ2FctZflpR
	zawiPlB0n5K/sTA8Thf2b+G9ineu9Em6zK3XPt3rQbUX8tRui/Q+Xt+7J2Xo4MOhdRvi8sa68HV
	qCUhGmklIctAzeRX9NtxEK/oXvvzBpeUaJTw6TC3yC1kA1ZUm86wL2Uk=
X-Gm-Gg: AYBFou3+0/tUXiNXlqUlwpUxHqPPZBs7Gt85KCgNENQqABuVRH8OoTCaHOBNTLApM77
	Bvgs2AFT21FzcdQMN16gwiMksyjZIU0O4YWtFUgUkWtRAoUpwzlqZvBadOaBlyUHpVCQX8egN1R
	FY4eQ0dLZTPhfrXX7EEUcI3y9Nzr8WAwkp+iow0E81RS9QmJUrMOwy6q/Lcegx8Y1JrMq3hoB0c
	DIY9kNZH+Lrhob40wdLMhPQ5oRVr1iFuhnIKxC1nSR4NiX6jw9WgtoKgAUK+MnnMJCHFCsOHYgv
	DoMk5rAvEfOsNW2mMrpRTEQxY9VpgQMLEZFAgURDc44vcBmDrNgJpwLeXEV85UH5VWIcjVos06q
	Ymb11ZKaYp4MWrpv0DLqw8Kmd3ZZq+62OFR+lhSLgkCpgVnO/yoAl0w==
X-Received: by 2002:a05:693c:4187:10b0:338:5bf5:d005 with SMTP id 5a478bee46e88-33e8ddc7604mr710469eec.28.1790116711126;
        Tue, 22 Sep 2026 15:38:31 -0700 (PDT)
X-Received: by 2002:a05:693c:4187:10b0:338:5bf5:d005 with SMTP id 5a478bee46e88-33e8ddc7604mr710439eec.28.1790116710604;
        Tue, 22 Sep 2026 15:38:30 -0700 (PDT)
Received: from localhost (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33e96d497e1sm1162630eec.25.2026.09.22.15.38.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 15:38:30 -0700 (PDT)
Date: Tue, 22 Sep 2026 15:38:26 -0700
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
Subject: Re: [PATCH v19 10/20] KVM: arm64: Abstract out memory abort
 handling
Message-ID: <20260922153826.000044fb@oss.qualcomm.com>
In-Reply-To: <20260920212845.707-11-suzuki.poulose@arm.com>
References: <20260920212845.707-1-suzuki.poulose@arm.com>
	<20260920212845.707-11-suzuki.poulose@arm.com>
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
X-Proofpoint-GUID: wCsXvNWyIDEyjzV544TNmlRpeL7No7rR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDMwMyBTYWx0ZWRfX052dkpghwtdV
 UztZ55qJkai+N2gN2F4P1HAwKoRbSgtBxFf8TDoR0ebEhkjHABvTR2zTdi8W9GqR5zQVQH5XnOt
 l/pDxqOm6jq6mjvKJTMg8C4j6mdbLA0CZ+8S3dW+DdSCEYVTIwZ0jrGM6wT38JTs3v9iyVgBisw
 71yh+uTzXsgdbHyuKFmBIfV39KSKlAg7rjCl87enMF/8t/oJdD8g9yrselXuODZaWxkVPCqU3Vu
 TIRCAPm41TzfkR5Va3y/lDiAWOFq5yAfN15ZxOGCRV8WQnL6Bj0/i2kN4Hk/5ijG/fnM9XMEJzr
 i6o+OYIS8BmGLGJ2mV2RElW+/iuYQ5IGgqr0HvWM4/CvlC5V0vIDidFVQUWRho78sf+cmeECCXb
 TuxzF802QTitAQEekHosDVGByRv1pgjBOXughleRWqRmYsYdTMLAwwkMWKi7RoWBM7i3SHmL7rY
 5g4mJv+XmLwTStSyTvw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDMwMyBTYWx0ZWRfX+WfnrU5sqHr9
 9b6ZWQKK0oythNly35jmHHF4w9oIH8In7P/ATPAHkZPpevdLVqbdbUvcfP16w7w4wwGCz6XqEyZ
 cWdsXRPrDE2a3EAZIF/hTJx0nCp4Gy0=
X-Authority-Analysis: v=2.4 cv=QsDLTlyd c=1 sm=1 tr=0 ts=6ab30368 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=7CQSdrXTAAAA:8 a=rbqOqaJmvRITx-_xyQwA:9 a=CjuIK1q_8ugA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-ORIG-GUID: wCsXvNWyIDEyjzV544TNmlRpeL7No7rR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-22_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 lowpriorityscore=0 phishscore=0 bulkscore=0
 suspectscore=0 impostorscore=0 adultscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609220303

On Sun, 20 Sep 2026 22:28:35 +0100
Suzuki K Poulose <suzuki.poulose@arm.com> wrote:

> Move the memory abort handling under VM specific s2 operation.
> 
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>

Trivial comment + request to follow through on adding the local
variable for kvm. I think the other places that can be used
survive the other changes in this patch set.

> diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
> index d97a4a1bca23f..cf293d09e940a 100644
> --- a/arch/arm64/kvm/mmu.c
> +++ b/arch/arm64/kvm/mmu.c


> +static int kvm_vm_mem_abort(const struct kvm_s2_fault_desc *s2fd)
> +{
> +	int ret;
> +	struct kvm_vcpu *vcpu = s2fd->vcpu;
> +
> +	VM_WARN_ON_ONCE(kvm_vcpu_trap_is_permission_fault(vcpu) &&
> +			!kvm_is_write_fault(vcpu) &&
> +			!kvm_vcpu_trap_is_exec_fault(vcpu));
> +
> +	if (kvm_slot_has_gmem(s2fd->memslot))
> +		ret = gmem_abort(s2fd);
> +	else
> +		ret = user_mem_abort(s2fd);
> +	return ret;

Personal preference but I'd just do
		return gmem_abort(s2fd);
	else
		return user_mem_abort(s2fd);

and save a couple of lines. I'd keep the else to make it clear it is
an either / or choice rather than an if something true one.

> +}
> +
>  /* Resolve the access fault by making the page young again. */
>  static void handle_access_fault(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa)
>  {
> @@ -2287,6 +2303,7 @@ int kvm_handle_guest_sea(struct kvm_vcpu *vcpu)
>  int kvm_handle_guest_abort(struct kvm_vcpu *vcpu)
>  {
>  	struct kvm_s2_trans nested_trans, *nested = NULL;
> +	struct kvm *kvm = vcpu->kvm;

If introducing this, also use it for the other places vcpu->kvm is used
in this function.  Separate patch though to keep down noise.
Looks like that's mostly to shorten the chain of dereferences in the
locks.


>  	unsigned long esr;
>  	phys_addr_t fault_ipa; /* The address we faulted on */
>  	phys_addr_t ipa; /* Always the IPA in the L1 guest phys space */
> @@ -2448,19 +2465,7 @@ int kvm_handle_guest_abort(struct kvm_vcpu *vcpu)
>  		.hva		= hva,
>  	};
>  
> -	if (kvm_vm_is_protected(vcpu->kvm)) {
> -		ret = pkvm_mem_abort(&s2fd);
> -	} else {
> -		VM_WARN_ON_ONCE(kvm_vcpu_trap_is_permission_fault(vcpu) &&
> -				!write_fault &&
> -				!kvm_vcpu_trap_is_exec_fault(vcpu));
> -
> -		if (kvm_slot_has_gmem(memslot))
> -			ret = gmem_abort(&s2fd);
> -		else
> -			ret = user_mem_abort(&s2fd);
> -	}
> -
> +	ret = kvm->arch.vm_s2_ops->vm_mem_abort(&s2fd);
>  	if (ret == 0)
>  		ret = 1;
>  out:


