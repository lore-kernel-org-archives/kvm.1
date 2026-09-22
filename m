Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A031A4A49B3
	for <kvm@vger.kernel.org>; Tue, 22 Sep 2026 19:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790107050; cv=none; b=Gg6om0ttc+XeBxvW+kyTb38mKWSdeSn/R43BORsd1OFtJndoXTUcBkF/G9xeDiCqZeetq2OVHfEv8O++Nto0XQGmQ4Hb4O7fkzUeFQzRe6ez/Z2h925B5tizZo43f9g7JNH1jkKfUHky/rZNXEuVAFtzHPBTGQvCgfpLDlCviHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790107050; c=relaxed/simple;
	bh=9JvbDLSyQrfrPc2pw153E2x+FuYYskw3Od9BLkW7on4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hbOqvjm+bqQH1aCLHMntSWVPNA6XJkhrvU9DU9St6wRHVB6EWM1XoTXGQlgs5iscR5aIC36fVxF791RTV0J/EsY188h9afyB0WG9VElXzWTqwUYi2BgZFm070OsQRrOv+urfGgBxiBC4UL/M3wlQNo38+3l7CemtteR5rVqqZ8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=d0uPXZoH; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=kGVprdqs; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="d0uPXZoH";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kGVprdqs"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68MI76tB2033335
	for <kvm@vger.kernel.org>; Tue, 22 Sep 2026 19:57:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+kCerQCZAd/icfcStrsOSRarPahcPdmJx1Sv0aBlf8A=; b=d0uPXZoHzbyscvk9
	Fui+SId+pi+/38DYBmJ4SUmJj3TBIOl02UaIYHzThs7bokVlSzJZkfGbSRFsL68/
	cZ/uP/7WOGeXAlcTU4vmV+HflDvNyN5Z0fnAcM7nU/XcvaTETkXOUSJ2f1ZojAc4
	0zLDZ8ltivPnVLqpPWKKeqfPg3JacgZQKAOB6RcwGV524NRBSIUWLShhBgtt/L5r
	7FvnTgzpCnyqgX+bp9PyoWBEh/mB7BrjGXjBo4j1BWeuUZUdClE0HfyiaD9y3FRZ
	4UMgUMuzREVwjn8607kyf0+UyBgezQRsBNMpLq9Jd/sUhd3kjkArdqLJu7ivd9Kp
	BNfMeA==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gux8c0nwm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Tue, 22 Sep 2026 19:57:27 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id a92af1059eb24-14373747468so245540c88.1
        for <kvm@vger.kernel.org>; Tue, 22 Sep 2026 12:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790107047; x=1790711847; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=+kCerQCZAd/icfcStrsOSRarPahcPdmJx1Sv0aBlf8A=;
        b=kGVprdqsLJE/kF6PcWZCAvzY0M1iKvhixxMmog5XQTIL2HOLrVo8Gaj149gaKhExy0
         Fi4HnT5h38lwlwco4ha+/isdJJN4vus+x2CGHyyZThzJUc6GuZk6UyzxNZVCQeZYHcTx
         zf41eqJGPrSEjTnzbnhlDPLZzh45aBufynWkt4Sc7Hw+R2zetIf3J00Jt40Jc2MasH7/
         IBPPqD+63YVs3LTo2RGjUIcE4nXoY7b1bkyWrKuqZ7cWLgOZSKRLH5sfPACmxLg9Xg2S
         dJd+r8cDRy2LIbxBvCQhln0fiks9ruBnfs0NTgiT1KrChjCT/I5x0I+XGbCnIwYIulUM
         P4Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790107047; x=1790711847;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+kCerQCZAd/icfcStrsOSRarPahcPdmJx1Sv0aBlf8A=;
        b=WpDRsOkg85Q4xywpBJqFMGMJNUvMkuyJCZ5NgkTRzQsbUE/mAUAl9hWhcPKa85VcbM
         YTi6WksNmGnmTjGdVTuvZVaTAB8PWb30vDD2WIaU+6V3oSSKSTd1Q4vk2jqR1Z9e1nxv
         i8M0Q9ZHCQ+CnyvkN3DmgR+twNPtZZaUipK/smbfOTczDCF8ITNp3+vfTKXkccsPwdnq
         7rTn85avD+BMIGxC+SQcV6wxIreqEj07LxNlIDwEjT+ahlcUODMh0x6/+YvIvyFOzift
         TI+Gq4SZ0xafKF7KKnBTLBm/ckwHAsemujIfiv4aUMmJedFu7NOajxFxqoT08pr/wM1E
         VJDg==
X-Gm-Message-State: AFuF++nyEJgNk8fZv538+3ec9qrR9UaKW0d7g4mfa4PWFcBgOi169CJT
	sSCwU/xbjFOsC20WVAEgIUJpiB0/7xE/4ElfM+4H1QsjXlmhG7Yphh//l9/hS4FMKKJGjBoqw9O
	MEfA0kK3gTd3bHMa+0OWisC1RKmk/ZIUStG6yBU1ueEwLfV6xwZnAQQk=
X-Gm-Gg: AYBFou234QwwEgegNvxBugCAcZdlJmN0Eb/5Q+zLEcqv8TbS9tFnXcoHHNVWnbsQxNK
	XWgi79vdW5NNcTc0iHgRXucdd23KJ9a7Lmn1g+xeqVURYV9mXB9G9LJ6Cl0Ly4wwH37UDNq2fGc
	MMMpwjf6EEoFCItYrPNY/+mPR+xOeGT9LvIXBjbt3qxXPEFA6BS1MioiK7QJi3La4lOneyJmix2
	wcNfAbfYpynWqQezI11uQf5C+574F6tmQCPNiM9O88WOCaJ2qiMuNajcQM077deWF7OaBKCmapA
	JZ3ipUq8PHCDsEjr/e9Ok3U6IjXzvcd0mXpbLJMTbt/rLnfb6y+5+kMJvw9wkVMLMPLu8hkMuQB
	g/+rl/HZ4+D7E5WClsuy/OV1otZK68Cwr+krq86A7KNTPMRy9rI6qXA==
X-Received: by 2002:a05:7022:1582:b0:144:dfc1:9aa with SMTP id a92af1059eb24-144f91372a3mr551673c88.10.1790107046990;
        Tue, 22 Sep 2026 12:57:26 -0700 (PDT)
X-Received: by 2002:a05:7022:1582:b0:144:dfc1:9aa with SMTP id a92af1059eb24-144f91372a3mr551637c88.10.1790107046436;
        Tue, 22 Sep 2026 12:57:26 -0700 (PDT)
Received: from localhost (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33e96258204sm448771eec.11.2026.09.22.12.57.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 12:57:26 -0700 (PDT)
Date: Tue, 22 Sep 2026 12:57:22 -0700
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
Subject: Re: [PATCH v19 06/20] KVM: arm64: Refactor the vcpu_load to allow
 for VM specific callbacks
Message-ID: <20260922125722.00006b2e@oss.qualcomm.com>
In-Reply-To: <20260920212845.707-7-suzuki.poulose@arm.com>
References: <20260920212845.707-1-suzuki.poulose@arm.com>
	<20260920212845.707-7-suzuki.poulose@arm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDI5MSBTYWx0ZWRfX4h5U1GOxSPEu
 p49vQ6bi7oyltUA74FGlmLbdUlbfuj+3y9ytFzJe3fns25ccmlkO0qZoHW8lYBVaIC0+zaKyNzL
 noQCstv1id/cnKR5kwb1cGtHpsecOrhKjK/OGkLRV8NXLPbx2Xg+mF4V1PLMvOV9rhCxPGcVjjp
 YBPW5+D5tvRiHT5Qe5m75zHIhFeAarzwi2jY2PtpCdwzB+PvY7WZpklTnglTvSG2o60nih8/Ee9
 eWYSB6WQoKFGZHcnd5VYUZVPtB6l2cC+zlwTz2doDIxHqDvOf269Utjg+8giEejxP4fRY9L4obS
 vh2ceviOYecS9/3MdYdg5b3S9M14gf5Pe7Lan/hiJksaXWOCxzaK2jjk/uGNM2b3nkbrbcEaL56
 W6cRZKqnFRpkDQmy2eh8G/0h3G+D2PE5y5gQLpK5TBZCzfGne/HsX4sdU6Db+5FQ1qA6RPWg5H+
 6giXwie10TO9/PC2sww==
X-Authority-Analysis: v=2.4 cv=P9evFSAu c=1 sm=1 tr=0 ts=6ab2dda7 cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=7CQSdrXTAAAA:8 a=20KFwNOVAAAA:8 a=X9DOVUd_aP98ggfEJksA:9 a=CjuIK1q_8ugA:10
 a=vBUdepa8ALXHeOFLBtFW:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-ORIG-GUID: QYsfGOD3PzxqjQSmCDNg42BtllsYG_l6
X-Proofpoint-GUID: QYsfGOD3PzxqjQSmCDNg42BtllsYG_l6
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDI5MSBTYWx0ZWRfXxGxIA0NbZb2X
 KJSIOG1dSKv+cDhNnId5sxi+PsF3nJ7qvz7b78LaO2cb1qanFfXFMxVuZmpW1OjpjOT9OKCJ5Zn
 uKSYDJtVv3UCR4DB7EGwBGwk9mndusk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-22_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 clxscore=1015 bulkscore=0 suspectscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609220291

On Sun, 20 Sep 2026 22:28:31 +0100
Suzuki K Poulose <suzuki.poulose@arm.com> wrote:

> To keep the VCPU load/put handling cleaner with the different kinds of VM
> types, we are about to introduce VM specific callbacks to do just the right
> thing. In preparation for that, make some refactoring to add the change
> easier.
> 
> No functional changes intended. Based on a work by Marc Zyngier.
> 
> Reviewed-by: Gavin Shan <gshan@redhat.com>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>

Trivial stuff inline + maybe one blob that should be in previous patch?


> ---
>  arch/arm64/kvm/arm.c | 48 ++++++++++++++++++++++++++------------------
>  1 file changed, 29 insertions(+), 19 deletions(-)
> 
> diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
> index 8c784b266a8e8..c74706ed9a531 100644
> --- a/arch/arm64/kvm/arm.c
> +++ b/arch/arm64/kvm/arm.c

> +
> +static void vcpu_set_wfx_traps(struct kvm_vcpu *vcpu)
> +{
> +	if (kvm_vcpu_should_clear_twe(vcpu))
> +		vcpu->arch.hcr_el2 &= ~HCR_TWE;
> +	else
> +		vcpu->arch.hcr_el2 |= HCR_TWE;
> +
> +	if (kvm_vcpu_should_clear_twi(vcpu))
> +		vcpu->arch.hcr_el2 &= ~HCR_TWI;
> +	else
> +		vcpu->arch.hcr_el2 |= HCR_TWI;

You could use FIELD_MODIFY() for these but maybe not worth it.

> +}
> +
> +static void vcpu_load_pvtime(struct kvm_vcpu *vcpu)
> +{
> +	if (kvm_arm_is_pvtime_enabled(&vcpu->arch))
> +		kvm_make_request(KVM_REQ_RECORD_STEAL, vcpu);
> +}
> 
> @@ -772,7 +782,7 @@ void kvm_arch_vcpu_put(struct kvm_vcpu *vcpu)
>  		kvm_call_hyp_nvhe(__pkvm_vcpu_put);
>  
>  		/* __pkvm_vcpu_put implies a sync of the state */
> -		if (!kvm_vm_is_protected(vcpu->kvm))
> +		if (kvm_vm_is_unprotected_pkvm(vcpu->kvm))
>  			vcpu_set_flag(vcpu, PKVM_HOST_STATE_DIRTY);

Why in this patch?

>  	}
>  

