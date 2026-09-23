Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27591387375
	for <kvm@vger.kernel.org>; Wed, 23 Sep 2026 16:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790182296; cv=none; b=KBerfwcBYVUyz8pVdbVX/BNf8+0+stjepX2rGV7fJ4Kjk1LvGZvxVMMipWMtsjcfVnT3/R+6rAlbojSaXfTpsn5bkwfe28bAE33Hytv4CdDSeAPHhKd5H2XoEHhjAwjrqjA+FAAHAeb5GLSw5cBm4qVzZJh9l7Gelpa8xFH/NL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790182296; c=relaxed/simple;
	bh=5uQE2nAN6JX8QjSvUav79qHnjIuloRrBM4/qaaznXm0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Okphi42uZv0ah+cibANyk8niKXhOW5eG/8MWQ6VuIZReGdVDdpjWfOQaoXFEl4ALw24hmTzC3NiJeKIhc4X6ypaUaII8UYK4JQNN7c+sSYWCqjVYzGHVOeU5wlBFh+TzAZ3il87AiOCq/1tQdyKJqPOD19RHwNrm2RkBImneK1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=i9oRYKy3; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MRT/Ty/q; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="i9oRYKy3";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MRT/Ty/q"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68NGUDxE3281261
	for <kvm@vger.kernel.org>; Wed, 23 Sep 2026 16:51:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PBQUzucMPHhE43vcKCEgSbYL6NQCAu/bzyKeHz+O5EA=; b=i9oRYKy3vL47wL3Z
	TQiRtvSmmPuInfzryvrI89KQN+dcSf+ocCQvznV+sZqK2iSvtcq7BXyS401jaGhT
	zcGov9ln9gi/I7/ZYoQ/0o8keNSHp6Urwj3f6RXjyJYxmyCUBVijSDP0+K5VDMNq
	rzDkITKd+6gVSxn5bpeWejr6OUPWFfTzlpnq9t4fxXp6UZuty8fwK9UrEXehmIZb
	XUbz5eza6OybsyPp9UvlDbrkxWrQ194e83mOMXXPU0lmFAgm0qGatu1o/9U3yyLm
	U++9FQu8kXv4higPKiI06eI6bFqf5wPHXQab6mqq91q/D4mDzOCDArwOW5GhxxVV
	4IfuUw==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gv9bqjqe2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Wed, 23 Sep 2026 16:51:33 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-8716b158692so536992b3a.3
        for <kvm@vger.kernel.org>; Wed, 23 Sep 2026 09:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790182293; x=1790787093; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=PBQUzucMPHhE43vcKCEgSbYL6NQCAu/bzyKeHz+O5EA=;
        b=MRT/Ty/qJGvln5uOilb6NYTsUJk4Mb4xhMqMmBmuSdTs5hwnjxpkiyDjOhAqSoJW1e
         goQJKVxXDQzhS0HBr5wmP9V9+fBzSNBx7n2rqsh1F5KsSvmypcXna+iHKk2d+LXR5CVi
         FEJvGQCcEJZBCEeUzuuuxS7yI6Wh4kFCLDhagtn7uQYZaLTlPUSqMIt5SpZZ3uUICU9m
         fwA5FKTvNvAJaHqnQY+dURgC4hPDQgnx2v+NyHkHhm/Q2DJd4TbX7WDs9vMNp6Dm8059
         2m5E42Gud4CCkPSvWF2I2ITbXQDuJIoRIN3BVybf86WqrQ/+mABf+A7vqsuRjvTiCAJ2
         +ntg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790182293; x=1790787093;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PBQUzucMPHhE43vcKCEgSbYL6NQCAu/bzyKeHz+O5EA=;
        b=QhOExN21HitBTcKN3GK4vCw3Y+0TMjaQdOHapqIE5fNsiDTHPPgPwqec9nvvB3x5zp
         BM0o7Sxo8zNE+OfvF0aJGrui92BA7nbhREZ6E2cIJSd1v+Oki5chiWHT63xVn6aGs8Rp
         nSvtCNHXfLoCD4s5GWhQ5q337CcMHHKpoaE+qBO1PEXcJNlhWDWrKr+I0ZwK8iTjw4IA
         L4a1uAnTwXcxX67Z/iBTaM1F9eNimbYaW3Sk/2V6BoasYGS/32TmBYyaKqZdTkkSXDiX
         VkSdZMPkKjBPmIkMGYCBDrqda3AMP7ZGVBCN4lIHuPiV6MueLjVukY+O3iXUtvaN/Fde
         BVoA==
X-Gm-Message-State: AFuF++kZAUQFjp73e5DpYI5/Oz6o7g/QJdPFgifoYfY9w7zSUDfSbB6S
	Etoa9lqJg0+00MgUKgXfBPWuzP1fQ4fyVSI1iVCPUHFHAkV7jtZEoSJwaW5+IdP2tVSGzcUDNYa
	Lu6Ww9lf7MOmZ2rxRe3jN2+2/8CRHmGM1QPiX6XfMpCIBUyhRCBuEItg=
X-Gm-Gg: AYBFou1Wi5cXkqSouz3jY5E3QzBK7P2BDxO9cY1ecG8VN+dyBm+JM+YIezPeF/O8Wky
	QFtOmWFuOCMXj9G0tzjdK2Y9aExMW3DBJLVXILTJmyG0jVUnyRRMUKYoWhAvEqNvc5TELcibwre
	HQvcMFcPmGRZzMFChzDUEgZJBo+dUbx5+TdxVlIy+FT4SmcrANRiS94GuDMRuCHG7mL3CSEn/Nf
	5XGpVcgi77nAv/0JvrQ79YQEGY06RDXA/juWp/2rtlo0LWPto8yg3ynlP9rVKLTnmdZvFvKe+B+
	tF1uQkORgFT1hQM8iDIOSx2xuwexNmm8Q43NQ/M+f94kxrNk4NEHzTpJCqFCUnSIph/Ja8u4kbi
	JBERZgx/It0iqGk4ppfiWDyR5fhUPLi6XcKr2A5zoQfgjVZirX4gSeA==
X-Received: by 2002:a05:6a00:3316:b0:874:705d:f648 with SMTP id d2e1a72fcca58-87d1c9ba6femr2832644b3a.42.1790182293060;
        Wed, 23 Sep 2026 09:51:33 -0700 (PDT)
X-Received: by 2002:a05:6a00:3316:b0:874:705d:f648 with SMTP id d2e1a72fcca58-87d1c9ba6femr2832601b3a.42.1790182292399;
        Wed, 23 Sep 2026 09:51:32 -0700 (PDT)
Received: from localhost (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-87d1cfbbfb5sm1725238b3a.18.2026.09.23.09.51.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 09:51:31 -0700 (PDT)
Date: Wed, 23 Sep 2026 09:51:26 -0700
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
Message-ID: <20260923095126.0000241d@oss.qualcomm.com>
In-Reply-To: <fa2f4766-0795-464a-80ca-2f3fd1c5140b@arm.com>
References: <20260920212845.707-1-suzuki.poulose@arm.com>
	<20260920212845.707-2-suzuki.poulose@arm.com>
	<20260922122542.00006868@oss.qualcomm.com>
	<fa2f4766-0795-464a-80ca-2f3fd1c5140b@arm.com>
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
X-Proofpoint-GUID: ByheHp47AHu4GGqlyl0qnICcYXc_4057
X-Proofpoint-ORIG-GUID: ByheHp47AHu4GGqlyl0qnICcYXc_4057
X-Authority-Analysis: v=2.4 cv=WZuZ+EhX c=1 sm=1 tr=0 ts=6ab40396 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=7CQSdrXTAAAA:8 a=7RKtW5IRJYTtfXkaynwA:9 a=CjuIK1q_8ugA:10
 a=2VI0MkxyNR6bbpdq8BZq:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDA2NyBTYWx0ZWRfX7Y3OAeL7zSw6
 EfND/XZmYKF+Glwxol/8IyIbgA1dwFealCQoKKaehHU4DIQ+ge6vyxc5cn1SSpm9Em/3GplhYch
 oxdWLXcxLz/uTQ8uf3Z9Ry6oPMlM40k=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDA2NyBTYWx0ZWRfX6w664o6jA5Nn
 /61JUCRmuvgxSMoM8v82UdOGFjgpqAzx6yVJxWt8vp3paSI9PAKPNmFTQrG+GIp8eSeOAUlznyZ
 mchhjw5Qe7l44oG3xKQ+9diDgsuKqly0O4YSieau1cD9m1195dAkROi0OgXhZeiP+I4oqsoTn/z
 Z4A4E0gdPz+G+yn67VpNXtf7snRwS4v8GAyZ9VomI9pvr0vWa8U1fqUELchZ/apfI7f5RS2qBUm
 nqZITu5pWUm1Mpc8NHDgYbsvN+pG91DaxR/gFH9yhDecF3NK4CE+q2boHVa9GXl4Fvf0Jd8cuwz
 BcHgz39FnsQo/jaLb22SDOHHUx9Sc/Ei6pKlBd7T4HoWfr+YMILtLL4wa7ww70xV0zrNxYZEEdY
 LOJip4qHVdygJfBbD/Fbz0plYYgsWMWEquVZPCpOinz6jfJSrPl90N4wVjdJPNApNZrkvm0shUu
 8Su7sLm5laXr7y+TDpw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_06,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0 priorityscore=1501
 suspectscore=0 clxscore=1015 impostorscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609230067

On Tue, 22 Sep 2026 23:04:42 +0100
Suzuki K Poulose <suzuki.poulose@arm.com> wrote:

> On 22/09/2026 20:25, Jonathan Cameron wrote:
> > On Sun, 20 Sep 2026 22:28:26 +0100
> > Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
> > 
> > Hi Suzuki,
> >   
> >> Protected VMs doesn't allow setting offsets for virtual and phyiscal  
> > 
> > physical
> >   
> >> counters, as the offset is always fixed to 0. The VM ioclt is filtered  
> > 
> > ioctl
> >   
> >> out based on the cap. However we don't prevent the userspace from trying
> >> to write to the CNTVCT/CNTPCT registers. This would lead to KVM triggering
> >> a WARN() in timer_set_offset() as the vm_offset pointer is set to NULL.
> >>
> >> Fix this by always "fixing" the timer offsets to 0 and marking that the
> >> timer offset is set in the kvm->arch.flags at KVM init time for protected
> >> VMs. A userspace writing to the CNT*CT_EL0 would observe success, without
> >> any real effect. This was chosen over preventing the writes to these
> >> registers and returning -EPERM.  
> > 
> > Why?  I don't mind the decision but telling us what was chosen is something
> > we can see in the code - patch description should give us the stuff we
> > can't see.
> > 
> > One comment on the comment below.  
> >>
> >> Reported by Sashiko
> >>
> >> Link: https://lore.kernel.org/all/20260908164641.416911F00A3A@smtp.kernel.org
> >> Fixes: f7d05ee84a6a ("KVM: arm64: Prevent host from managing timer offsets for protected VMs")
> >> Suggested-by: Marc Zyngier <maz@kernel.org>
> >> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> >> ---
> >> Changes since v18:
> >>   - Retain NULL vm_offset for protected VMs to avoid host tampering with the
> >>     offset.
> >>   - Moved the flag setting into kvm_timer_init_vm(), where it should have been
> >>     in the first place
> >> ---
> >>   arch/arm64/kvm/arch_timer.c | 12 ++++++++++--
> >>   1 file changed, 10 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/arch/arm64/kvm/arch_timer.c b/arch/arm64/kvm/arch_timer.c
> >> index 6ac3321f4c575..226cd5a495c8b 100644
> >> --- a/arch/arm64/kvm/arch_timer.c
> >> +++ b/arch/arm64/kvm/arch_timer.c
> >> @@ -1110,8 +1110,7 @@ void kvm_timer_vcpu_init(struct kvm_vcpu *vcpu)
> >>   		timer_context_init(vcpu, i);
> >>   
> >>   	/* Synchronize offsets across timers of a VM if not already provided */
> >> -	if (!vcpu_is_protected(vcpu) &&
> >> -	    !test_bit(KVM_ARCH_FLAG_VM_COUNTER_OFFSET, &vcpu->kvm->arch.flags)) {
> >> +	if (!test_bit(KVM_ARCH_FLAG_VM_COUNTER_OFFSET, &vcpu->kvm->arch.flags)) {
> >>   		timer_set_offset(vcpu_vtimer(vcpu), kvm_phys_timer_read());
> >>   		timer_set_offset(vcpu_ptimer(vcpu), 0);
> >>   	}
> >> @@ -1133,6 +1132,15 @@ void kvm_timer_init_vm(struct kvm *kvm)
> >>   	 */
> >>   	for (int i = 0; i < NR_KVM_TIMERS; i++)
> >>   		kvm->arch.timer_data.ppi[i] = get_vgic_ppi(kvm, default_ppi[i]);
> >> +
> >> +	/*
> >> +	 * Protected VMs don't allow any offset being set from userspace,
> >> +	 * either set via writes to the counters or using the dedicated  
> > This sentence confused me.  Second clause isn't obviously the ways that
> > are being blocked. Maybe shorten to:
> > 
> > 	Protected VMs don't allow the offset to be set from userspace,
> > 	whether via writes to the counters or the dedicated ioctl.  
> 
> LLM suggests:
> 
> 
>     * Protected VMs don't allow userspace to set counter offsets,
>     * either via counter register writes or the dedicated ioctl.

Hmm.  I'd not combine a negative with either.  Still good enough I think!
Our Booker prize may be a way off yet :)

> 
> Have updated the comment.
> 
> Cheers
> Suzuki
> 
> >   
> >> +	 * ioctl. Pretend the offset has already been set and rely on the
> >> +	 * default offset being 0.
> >> +	 */
> >> +	if (kvm_vm_is_protected(kvm))
> >> +		set_bit(KVM_ARCH_FLAG_VM_COUNTER_OFFSET, &kvm->arch.flags);
> >>   }
> >>   
> >>   void kvm_timer_cpu_up(void)  
> >   
> 

