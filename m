Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B384642A9D
	for <kvm@vger.kernel.org>; Fri, 22 May 2026 00:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779409442; cv=none; b=ix4T84XToVUCKiXs9kX6EkT5iImdp31JLvPdBMNdanP4KDKslmPc6c2Z7i7qFUd5m5ZBsXg4SgfUwgB95MuUgQqQywhghabqTbYo0cUuCC6Hoc8Sd9urO1LtCJmQ8vY0QFpT1MKcXwMCY8wpY9/bsw7++6SmzZHAwIJqoGLMnfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779409442; c=relaxed/simple;
	bh=wi7cqdYrKb2mkehnu4o6zCS4mpRB39c7kfIK/qEPj48=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oKM8h2uJ1oV+syyVHJcGi7Ndoz/Mu1QjmgYU3r0djf6zU+DeKVjg3IxYMWFt0C+/IDCcbCOZ4470eFUiNDK6MtGRzrVgqD45jyO0TYHQFubhMqHRdrdR6rsWKcdBEjbSTAM6dV0qmm9ipZVaLTWaTx8Hm1YUVo0QyY3LVR9T72Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=j6nAgohe; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fhgVJSXX; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="j6nAgohe";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fhgVJSXX"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64LGn4t0187711
	for <kvm@vger.kernel.org>; Fri, 22 May 2026 00:23:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=5GSON/0hiBS5ycqET1N4+CsB
	MgT/hpoirbtpuxXnHDo=; b=j6nAgohe17YHjIEKj+Ihg75j5WfPN0JUsHLCk1Yq
	qZ8MVDyv7FkQ7tR4l+tgBPPk1MWRU8xCFncqEpb1b4dLnOm259YGHK7jP4Sddtlx
	Oqm2W+9Oqkw1P+V/m1Am5Xe1OPLUhgkFeGg5yqfrhBe3CMKR9fmBlqi5iPLIqLYs
	CPhAqK7fQnWrrGaIyklLESc2g2NS1FZyjwPOQduckxvVH7f0VhrxaG+01rdVBh3P
	H13GaMEw0iwD1Hrim42IcLFVC1wC40znGo4ksGamtn7JJCUnYMF75mPocrhkhBgj
	BB3Um+efwSOQk5LDGgxnZ3pfhujoC/ayHtKXhOc/5eyBcg==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e9wahv4xu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Fri, 22 May 2026 00:23:59 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-2bda35eab74so5676733eec.0
        for <kvm@vger.kernel.org>; Thu, 21 May 2026 17:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779409439; x=1780014239; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5GSON/0hiBS5ycqET1N4+CsBMgT/hpoirbtpuxXnHDo=;
        b=fhgVJSXXgsresypAmyC7V88tW5Rlo1Gw8vZu1zvXWh1RfBuBr0Q6Rx8QYqKF0YxVmz
         j+oQXuUVmw+QkD6+rJCCh+n9fqOIkC2Ye3RgdaCK3VtM8wFAet8ouD425/73ovkIf98E
         zQ3oh9DJezUuzujVLK9T6poSgSpFeUbAO2SaJ/0JqzCES+7/8gRBKdrY31MEFXAezql+
         yTjvsIhKOWUjPBs/ZcfFhj98m+n40K7hcRIwoJpCnbbSo4/iqFIE4u1uqChgrsNTi534
         csR7xP5gsBUOdx8MFTny8tKIEqd7QAmjR4qUWaIk6PjxCOjdQQXcjcaBUo7HKujaxccf
         fc5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779409439; x=1780014239;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5GSON/0hiBS5ycqET1N4+CsBMgT/hpoirbtpuxXnHDo=;
        b=fT4roWrgg6Q53n1TTB/w7ngUbexnpKYO/6Gb65RSnvccKCoFMPz6YUoARBGF4oxWp9
         g3wCZpsoP2fDC/D33AZlVrZ4h9GqNjBO2/JXCb2UacglbMVpuQj0QwoJqQlVnxO+EeZh
         hVat5jHPtWkl6i4aiKc/b+05wchebQr0/+ljiIyBRm+Px9bqm+1Yt3hKUjse0McD8S//
         yCIZM/93xqMCRQuh0x2s2kP5cFn6xNMJVHp3VTZKmQt/7bfwltDcVf0w60P7drOOQi+j
         BV+KfYh/gAcyCZZoexXyyZmE+u331suzsayR3pi1+FxQaBBLNDyjIJiG/x0kSVR5slS0
         i2rQ==
X-Forwarded-Encrypted: i=1; AFNElJ8P00Wmj5Ildlj1ZXrZqjPBwQUn/P8HMEGioiyCGJO60wnjbqw+qJjcu41ERYp8PISBQ7Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxj2vC+vDntEaf1c7fqBae8XltUjH23GGVCBFHVO2YteQJFolvh
	yeBqh1mtrm6igjW1Mr8Rhewtpill906U02h9cFyAg3cvglIGyzOM35m2FxXw9PWLN8inWvI62cX
	4mQUNpQ/FjgE52hCIvOPZ5yUy+Fy6Q/A9aKPVpZSLGZjKucbcT1wKasE=
X-Gm-Gg: Acq92OHeHyDNLDbANueYv87kp3pMSH7MzxoPEZQy0VvZEm+e5xZiW1zeSYvUy911gIk
	K8v9a0v/NRq3y+8XL2IrNW4eV6HWL1ttWkUoaFRWNG6n3Uie+0XAe6bsCPcK+FFSxso/I9yCldm
	LdTwB8DjoICvEq41+mLhhxjCcE+DcqrlmOPn1Ex4FUkvyX5pchwuamofwKzNfepdlWP9Gwry8NS
	d3WIWjnltR7Niht0E8mj7iLUaZXyXblwOw1EdQEpkjpvzd8EEqA1X26Op6z21W5vwzBzS+srnFR
	UKGCtpYchsyiZnL1D1YsPWIEtEu4Xtk8sjeFpmhuJwhKmjNnbfJaKzBOH8DsL1CQHCOiHM4ljss
	YQCSP/3Q1zKRfnfQYoFXf1st8cT+XUi0=
X-Received: by 2002:a05:7300:230d:b0:2d2:d5a3:e97c with SMTP id 5a478bee46e88-30430e40401mr2728642eec.12.1779409438524;
        Thu, 21 May 2026 17:23:58 -0700 (PDT)
X-Received: by 2002:a05:7300:230d:b0:2d2:d5a3:e97c with SMTP id 5a478bee46e88-30430e40401mr2728626eec.12.1779409437908;
        Thu, 21 May 2026 17:23:57 -0700 (PDT)
Received: from localhost ([140.82.166.162])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3044b6d16f9sm804742eec.2.2026.05.21.17.23.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 17:23:57 -0700 (PDT)
Date: Thu, 21 May 2026 19:23:56 -0500
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: Jiakai Xu <xujiakai2025@iscas.ac.cn>
Cc: kvm-riscv@lists.infradead.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
        Andrew Jones <ajones@ventanamicro.com>,
        Anup Patel <anup@brainfault.org>, Atish Patra <atish.patra@linux.dev>,
        Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <pjw@kernel.org>,
        Jiakai Xu <jiakaiPeanut@gmail.com>
Subject: Re: [PATCH] RISC-V: KVM: Fix TOCTOU race in SBI system suspend
 handler
Message-ID: <yirnowpcfq6wqru3jshbbaicqftfj4ef3dcss65jdtuon6nzml@iyv45tnmmfha>
References: <20260521142030.1560861-1-xujiakai2025@iscas.ac.cn>
 <zfvysxe5eqyogy3cesmp53omigq6a7cjajs3ffbrfyqq7huph4@bbfw7ro5zz7l>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <zfvysxe5eqyogy3cesmp53omigq6a7cjajs3ffbrfyqq7huph4@bbfw7ro5zz7l>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDAwMiBTYWx0ZWRfX5rnu1b2W29GC
 2MJZkxAir21QJS/OFXZePAMwM73epQ10Y8YJ7hcliiA3mTEVKgu0A215/PWl/YBs+ydILjhmmRR
 Sdotz/hYs+KYgGvWfncsMOWHzFFty+y5mDZlNnK6l0bJS2W9KuLS+zAmLfa35aDADT7TTiP1yAX
 dXGVlbe47i0PL/ejpd44wjM2Rwwf+0VipsSih3YPx3exaLlGgkXeYzeK9e58Xi9CW6huI4Q5DZE
 CnrSkzJIvNuWdYe4zKXaq6pMp137kaFUgb9fcQNQo+BKLI7PfPH1CDPqOWAB+OhWbuQx0QAdREJ
 sNayd5qZF7qlnC3O/E2TkT7Khy1zx9tWirAqfpUYS8QxiAqU4gB3wJJyinZ8ekTTWdv8eS8RO55
 7iQ+QXDuyce+KB3GMAVeDSCLOZ1ora69N/UFWDW9mtTJ8lqhb3uf5K13wIlvUnKwOY2LTC3IKHo
 phCKI9bNNIpwjVa4aMg==
X-Proofpoint-ORIG-GUID: EeNRTtBDszG1MftU51I2-yQmtN8XGXlz
X-Proofpoint-GUID: EeNRTtBDszG1MftU51I2-yQmtN8XGXlz
X-Authority-Analysis: v=2.4 cv=H8LrBeYi c=1 sm=1 tr=0 ts=6a0fa21f cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=cvcws7F5//HeuvjG1O1erQ==:17
 a=kj9zAlcOel0A:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=c92rfblmAAAA:8 a=pGLkceISAAAA:8 a=xEbelNxs-k07UTx3eFkA:9 a=CjuIK1q_8ugA:10
 a=bBxd6f-gb0O0v-kibOvt:22 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-21_05,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 adultscore=0 suspectscore=0
 lowpriorityscore=0 spamscore=0 impostorscore=0 malwarescore=0 bulkscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605220002

On Thu, May 21, 2026 at 06:47:26PM -0500, Andrew Jones wrote:
> On Thu, May 21, 2026 at 02:20:30PM +0000, Jiakai Xu wrote:
> > The SBI SUSP handler kvm_sbi_ext_susp_handler() checks that all other
> > vCPUs are stopped before entering system suspend, but it does not hold
> > mp_state_lock during the iteration. A concurrent HSM HART_START from
> > another vCPU can start a target vCPU after the SUSP handler has already
> > checked it, violating the invariant that all vCPUs must be stopped
> > before suspend.
> > 
> > Fix this with a two-phase approach:
> > 1. Set a VM-wide suspend_in_progress flag before the iteration to block
> >    concurrent HSM HART_START. The HSM start handler checks this flag
> >    under its existing mp_state_lock, closing the race.
> > 2. Hold mp_state_lock during each per-vCPU stopped check so that
> >    mp_state reads are ordered against concurrent power_on/power_off
> >    writes on the other side of the lock.
> > 
> > The flag is self-clearing: it resets when any vCPU re-enters
> > kvm_arch_vcpu_ioctl_run after the suspend-resume cycle completes.
> > 
> > Fixes: 023c15151fbb ("RISC-V: KVM: Add SBI system suspend support")
> > Signed-off-by: Jiakai Xu <jiakaiPeanut@gmail.com>
> > Signed-off-by: Jiakai Xu <xujiakai2025@iscas.ac.cn>
> > Assisted-by: YuanSheng:DeepSeek-V3.2
> > ---
> >  arch/riscv/include/asm/kvm_host.h |  3 +++
> >  arch/riscv/kvm/vcpu.c             |  8 ++++++++
> >  arch/riscv/kvm/vcpu_sbi_hsm.c     | 11 +++++++++++
> >  arch/riscv/kvm/vcpu_sbi_system.c  | 10 ++++++++++
> >  4 files changed, 32 insertions(+)
> > 
> > diff --git a/arch/riscv/include/asm/kvm_host.h b/arch/riscv/include/asm/kvm_host.h
> > index 75b0a951c1bc6..c4e710ec40f90 100644
> > --- a/arch/riscv/include/asm/kvm_host.h
> > +++ b/arch/riscv/include/asm/kvm_host.h
> > @@ -93,6 +93,9 @@ struct kvm_arch {
> >  
> >  	/* KVM_CAP_RISCV_MP_STATE_RESET */
> >  	bool mp_state_reset;
> > +
> > +	/* Set by SBI SUSP to block concurrent HSM HART_START during system suspend */
> > +	bool suspend_in_progress;
> >  };
> >  
> >  struct kvm_cpu_trap {
> > diff --git a/arch/riscv/kvm/vcpu.c b/arch/riscv/kvm/vcpu.c
> > index a73690eda84b5..ea6f14244addb 100644
> > --- a/arch/riscv/kvm/vcpu.c
> > +++ b/arch/riscv/kvm/vcpu.c
> > @@ -838,6 +838,14 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
> >  	/* Mark this VCPU ran at least once */
> >  	vcpu->arch.ran_atleast_once = true;
> >  
> > +	/*
> > +	 * Clear stale suspend flag from a previous suspend-resume cycle.
> > +	 * The flag was set by kvm_sbi_ext_susp_handler() and persists
> > +	 * across the userspace exit; clearing it here ensures subsequent
> > +	 * HSM HART_START operations are not blocked after resume.
> > +	 */
> > +	WRITE_ONCE(vcpu->kvm->arch.suspend_in_progress, false);
> > +
> >  	kvm_vcpu_srcu_read_lock(vcpu);
> >  
> >  	switch (run->exit_reason) {
> > diff --git a/arch/riscv/kvm/vcpu_sbi_hsm.c b/arch/riscv/kvm/vcpu_sbi_hsm.c
> > index f26207f84bab6..2f88d93768bc8 100644
> > --- a/arch/riscv/kvm/vcpu_sbi_hsm.c
> > +++ b/arch/riscv/kvm/vcpu_sbi_hsm.c
> > @@ -31,6 +31,17 @@ static int kvm_sbi_hsm_vcpu_start(struct kvm_vcpu *vcpu)
> >  		goto out;
> >  	}
> >  
> > +	/*
> > +	 * Reject HART_START while a system suspend is in progress.
> > +	 * kvm_sbi_ext_susp_handler() sets this flag before checking
> > +	 * that all vCPUs are stopped; checking it here under
> > +	 * mp_state_lock closes the race.
> > +	 */
> > +	if (READ_ONCE(target_vcpu->kvm->arch.suspend_in_progress)) {
> > +		ret = SBI_ERR_DENIED;
> > +		goto out;
> > +	}
> > +
> >  	kvm_riscv_vcpu_sbi_request_reset(target_vcpu, cp->a1, cp->a2);
> >  
> >  	__kvm_riscv_vcpu_power_on(target_vcpu);
> > diff --git a/arch/riscv/kvm/vcpu_sbi_system.c b/arch/riscv/kvm/vcpu_sbi_system.c
> > index c6f7e609ac794..b79c1cff7a996 100644
> > --- a/arch/riscv/kvm/vcpu_sbi_system.c
> > +++ b/arch/riscv/kvm/vcpu_sbi_system.c
> > @@ -35,13 +35,23 @@ static int kvm_sbi_ext_susp_handler(struct kvm_vcpu *vcpu, struct kvm_run *run,
> >  			return 0;
> >  		}
> >  
> > +		/*
> > +		 * Set the VM-wide flag to block concurrent HSM HART_START
> > +		 * from racing with the per-vCPU stopped checks below.
> > +		 */
> > +		WRITE_ONCE(vcpu->kvm->arch.suspend_in_progress, true);
> > +
> >  		kvm_for_each_vcpu(i, tmp, vcpu->kvm) {
> >  			if (tmp == vcpu)
> >  				continue;
> > +			spin_lock(&tmp->arch.mp_state_lock);
> >  			if (!kvm_riscv_vcpu_stopped(tmp)) {
> > +				spin_unlock(&tmp->arch.mp_state_lock);
> > +				WRITE_ONCE(vcpu->kvm->arch.suspend_in_progress, false);
> >  				retdata->err_val = SBI_ERR_DENIED;
> >  				return 0;
> >  			}
> > +			spin_unlock(&tmp->arch.mp_state_lock);
> >  		}
> >  
> >  		kvm_riscv_vcpu_sbi_request_reset(vcpu, cp->a1, cp->a2);
> > -- 
> > 2.34.1
> >
> 
> I'm not a big fan of this approach and I see sashiko found it has gaps[1].
> I'd rather we introduce a mutex to kvm_arch to serialize cross-vcpu

Eh, not sure why I said 'introduce' here. We can just use kvm->lock.

> mp-state operations. So it'd be taken in SUSP, HART_START, and also SRST

And, even though SRST doesn't really need it - why not... Consistency has
its merits.

> (anywhere that reads or modifies another vcpu's mp-state). Operations that
> only modify the calling vcpu's own state would still only use the per-vcpu
> mp_state_lock.
> 
> [1] https://sashiko.dev/#/patchset/20260521142030.1560861-1-xujiakai2025%40iscas.ac.cn
> 

Thanks,
drew
