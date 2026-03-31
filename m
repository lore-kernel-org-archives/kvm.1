Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA2221C861A
	for <kvm@vger.kernel.org>; Tue, 31 Mar 2026 16:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774974636; cv=none; b=fzHG1GXe7BG/0vkk4xMxLqbwsaOmmmlfE61G6fPWbMRlqo/HbziuC0eeVzgM3YOaYEam5Y5+g82+YJJh06uhRxwITUrWIlnGW20OQBPVtXGeVTwXYzHWB/Q1lP6MaF2VPdd/vOa01Qk5Ufnq9v4ZqeoLp9yb1SSKxecupa+jrR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774974636; c=relaxed/simple;
	bh=CdBjvEzpUocvcxh0YKxf7fUVSpGAsUpaZnuGce87UZA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OqC6zCPt3pY6uDGjJ75dHIpVcEfKTM8gcwZLySGGQ9t6aIP7TfFoMd1a7ZVaGbqp9kHGjr0+YUj/VrcAMRMF9G63JFlkl+SClYrJf1NsYoy5ba55CerCmB7qRsCLXsDbVhXVgRN8E+R87GVlR14HyosanOqMpekDs2vh2y+mgbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fLqslXQk; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fLqslXQk"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-82ce50e6e28so256985b3a.2
        for <kvm@vger.kernel.org>; Tue, 31 Mar 2026 09:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774974635; x=1775579435; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=AD8bl9IEgHy+FwFcKmB0BBQSvmSTvxitY0eHF+wpmeY=;
        b=fLqslXQktpLSUpCRiwzvnWl+uG8rTsJBt91g/2a3tElQKg35mCkAXShrI1vw4U2p2P
         OJLriMN8FvjQTn3hm5ALwSn0ALq0HW33FN6cyeG26rbFaTzygFlzWewzfHGudEfTt0KT
         J4EKvybP/DZGPXCBg0QJOl/aeMqmgaIMJ+yFDmp79NlQ34R89vjvPMt/nlyq6S4HFwE5
         ayEM6ndNbXaag4NM5e//S76slHDQCaWVk6j1hrOjkD1l1LXV/ApxYGGEesiXqyZ+g+c9
         F+DGDqv+6Kkx5LKd6i0v1uCg70mV2QjQdCRVgb1ILcwx6mF3LUjzF6fqxrQZ1KhelQo2
         tFBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774974635; x=1775579435;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AD8bl9IEgHy+FwFcKmB0BBQSvmSTvxitY0eHF+wpmeY=;
        b=nWzHh/4ZhJODtTvlVxp3nhi/pjyJhNGX/q7ph1egt1UO9bIa0Pqc4XTscUdfJm3S8c
         cizSnbBWvnymxy/Sr6STbOv5eXOW+RMgGYT398bHRYnA0+nizkUNrR/+r8MeJn+t/tIj
         MqqkLsm6oIB5OVBI81YaucjKlToheoPGBNWHNDBRrzE7sn35xqDs5t7DxUcEjHIhj3q+
         +1rqOwWXfZa0dae3FsDPHYDWQy7Ok8lGC/nm9knfCE4u2XU90Di62trV1b+KNICeTf/a
         eDpCpwvln5MxcwgVg9ZTdgCxwdOlb/9CZSkB5gT0gImRZY43IBjxOuLGVncp0w4wsZp2
         ikXA==
X-Forwarded-Encrypted: i=1; AJvYcCV75rSWbxkQKkFiocGV3pGOAeLvDKqt/XXs07t2a0sflCDo46FBt4Xm/7XYUMU8FZ9idqM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOVXmk0Sze6STeP7/fb6hg3R7ZBrKAFH8ViHFEuLPn+LjUZdSP
	jzUVPHKJzjCrhKrr44EI//aFRTUdMPJNiEknk61sM98jJ4mnQ2QYWzPtG67QxOk/K91VcwLAZ9M
	I5L1arg==
X-Received: from pfbg26.prod.google.com ([2002:a05:6a00:ae1a:b0:829:8ed3:28ba])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3c84:b0:82c:d7c4:4c6b
 with SMTP id d2e1a72fcca58-82ce88d81f8mr277929b3a.11.1774974634714; Tue, 31
 Mar 2026 09:30:34 -0700 (PDT)
Date: Tue, 31 Mar 2026 09:30:33 -0700
In-Reply-To: <95c13b532d2958977d176e965efc433f1f4793c4.camel@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <1774322860-25106-1-git-send-email-18341265598@163.com> <95c13b532d2958977d176e965efc433f1f4793c4.camel@intel.com>
Message-ID: <acv2jIBRxKp94oP5@google.com>
Subject: Re: [PATCH] vmx/nested: Set the SGX feature flag only when hardware supported.
From: Sean Christopherson <seanjc@google.com>
To: Kai Huang <kai.huang@intel.com>
Cc: "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "bp@alien8.de" <bp@alien8.de>, 
	"hpa@zytor.com" <hpa@zytor.com>, "mingo@redhat.com" <mingo@redhat.com>, "tglx@kernel.org" <tglx@kernel.org>, 
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "18341265598@163.com" <18341265598@163.com>, 
	"hanht2@chinatelecom.cn" <hanht2@chinatelecom.cn>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"weixq1@chinatelecom.cn" <weixq1@chinatelecom.cn>, 
	"zhangzg12@chinatelecom.cn" <zhangzg12@chinatelecom.cn>
Content-Type: text/plain; charset="us-ascii"

On Tue, Mar 24, 2026, Kai Huang wrote:
> On Tue, 2026-03-24 at 11:27 +0800, 18341265598@163.com wrote:
> > From: "zhaoge.zhang" <zhangzg12@chinatelecom.cn>
> > 
> > If the hardware does not support the SGX feature and we set the
> > corresponding flag, when the L1 hypervisor enables the corresponding
> > feature in VMCS12, the VM entry will fail.
> > 
> > Reported-by: wei xiaoqiong <weixq1@chinatelecom.cn>
> > Signed-off-by: zhaoge.zhang <zhangzg12@chinatelecom.cn>
> > Reviewed-by: Huaitong Han <hanht2@chinatelecom.cn>
> > ---
> >  arch/x86/kvm/vmx/nested.c |  2 +-
> >  arch/x86/kvm/vmx/vmx.c    | 11 -----------
> >  arch/x86/kvm/vmx/vmx.h    | 11 +++++++++++
> >  3 files changed, 12 insertions(+), 12 deletions(-)
> > 
> > diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
> > index 937aeb4..396ac07 100644
> > --- a/arch/x86/kvm/vmx/nested.c
> > +++ b/arch/x86/kvm/vmx/nested.c
> > @@ -7278,7 +7278,7 @@ static void nested_vmx_setup_secondary_ctls(u32 ept_caps,
> >  		msrs->secondary_ctls_high |=
> >  			SECONDARY_EXEC_VIRTUALIZE_APIC_ACCESSES;
> >  
> > -	if (enable_sgx)
> > +	if (enable_sgx && cpu_has_sgx())
> >  		msrs->secondary_ctls_high |= SECONDARY_EXEC_ENCLS_EXITING;
> >  }
> 
> Are you seeing the case where enable_sgx is true but cpu_has_sgx() reports
> false?
> 
> It's quite strange because during KVM load, if cpu_has_sgx() is false,
> enable_sgx is guaranteed to be false.
> 
> The only case that I can think of is after KVM loads somehow machine check
> happens, which "soft disables" SGX (CPUID reports SGX1 as 0).
> 
> Is this the case you are meeting?

It's a moot point (unless I'm getting -ENOCOFFEE, which is very possible at the
moment), because "enable_sgx" is cleared if ENCLS-exiting isn't supported.

	if (!cpu_has_vmx_encls_vmexit())
		enable_sgx = false;

Where cpu_has_vmx_encls_vmexit() is peeking at vmcs_config.cpu_based_2nd_exec_ctrl:

  static inline bool cpu_has_vmx_encls_vmexit(void)
  {
	return vmcs_config.cpu_based_2nd_exec_ctrl &
		SECONDARY_EXEC_ENCLS_EXITING;
  }

And thus already incorporates this code:

	if (!cpu_has_sgx())
		_cpu_based_2nd_exec_control &= ~SECONDARY_EXEC_ENCLS_EXITING;


I suppose the #MC could happen between setup_vmcs_config() and
nested_vmx_setup_ctls_msrs(), but at that point, KVM is hosed no matter what.
