Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 668B733ADA0
	for <kvm@vger.kernel.org>; Wed, 20 May 2026 15:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779291378; cv=none; b=QfoyDsDGezzZtp7LokxPwqwR95XZeZj2M4FKxdbIdjrulYg7qI0mI63bjCm7mMcNtV0ghfvcaJIYzir7vj0bjBI7NCtzZmpOHBU4+aUPjVXT23Y5MN/W1XQx6KC1w2siI4gDVEsUNy2WyIfCswmO+6KwPFuxccKSlKSiA2de3UE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779291378; c=relaxed/simple;
	bh=9pNwd+Wy3/fRFaXrGPSHIDObpYDsHwUj/iGsrNgTHeo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Gj80Jia6jYONetYLdwKiC7O/EWNEaA1/hM2JQcDvod6SSV+9YkulQeHyPDmWMX7Lw4UhCs+qv5MTIwJwh8b5WwMQdL5lUMRh0aMxO37cHXqKE6EKzc4I3IUkIAPqx7JQ4BtAvhKmLBsNVSOiLFQIeCjW6VPrtakNJeeXCRVV1y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JJmwvChG; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JJmwvChG"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2ba268cb5e6so51928205ad.1
        for <kvm@vger.kernel.org>; Wed, 20 May 2026 08:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779291377; x=1779896177; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=zOaR3KhtByvkV/ZXK0i0RHv1Sn7RvIHKRxyfenEcrQU=;
        b=JJmwvChGIY5hEe32L+Xx85ibao6cVJtNwjNUeFX1+60F86LvScj/qmGY1kzJlozi4w
         piAIKMmbhz5eoI6pvDf5D9DNnUtOM527v5cax18Shy1bdD8PlRr4LyGRhGZ3PP/dmUmY
         Tt+IItwQBUtWTLHQQ5f320olFioeiGbmfdB+nekpOOnz+1JJisvQR3NB2upUmlaNMjy3
         v7pKsbQuvpt4DQz02JKlBkBrjjvx7aMsomn2S2L2MKLVhpo+ZFl6jYhtRwFUAEc4mL6C
         RYH9w3iHCR6sAYpi89iqnce0GYwEqEK/WqAT97W5h3EsbXyhCqCE4RSvyxtCkT5hSmau
         dvMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779291377; x=1779896177;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zOaR3KhtByvkV/ZXK0i0RHv1Sn7RvIHKRxyfenEcrQU=;
        b=mL6QC3leNBE62tZVHVxsdVDSSWNHcjvikrLppMEDfTP4IYgGJeyN+nBdnM+V2tUjpO
         QpkFVBThLLQaII+O1xsRzisSNZz3DMFFZ9D9bZ0R05x/2H33RW0BeJxvDLSIAQcUye6r
         E2QteX4tFdshEDKHAESfFFWdWJ2Em2hVmmNCe+1uZ6baPgIKMZTeckfWZJRfMuPAlrE/
         2Gv3wvPPmR5/r03eF93qMpfsFjXoQjABEuIGKbDsNgh7KUwYmWadOF8EVk/D0+SrmRZK
         kLA9vfvAp+ca3uDEHpHr/qtXqeZ/wlxfuNU3DKp+R9pOhBGobZEY8nhGVgfETihO2ZX4
         7MbQ==
X-Forwarded-Encrypted: i=1; AFNElJ/iD9Fre6BVSWSCfvFqAqz/X8+Nm1nkZsxT/DiX+K+L+i8uIKwQ4YDZ/+lqMsw09pzbQxY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLdfb3b0WlTX5xlEWKOVmNwAO8MtRiKM6RTairevjRIpsZCOPa
	DRhCSaGk1Sey6u3gsh5Z8mVQe8jjbe95z0hYc7Xw7y8iOzvYZzQAZEke+WbNgATS4l7BHfPqLwM
	ZGfRG4g==
X-Received: from plbl12.prod.google.com ([2002:a17:902:eb0c:b0:2b0:aef9:a5a2])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1b25:b0:2b2:5515:661c
 with SMTP id d9443c01a7336-2bd7e8ca3d7mr349840855ad.31.1779291376624; Wed, 20
 May 2026 08:36:16 -0700 (PDT)
Date: Wed, 20 May 2026 08:36:15 -0700
In-Reply-To: <9f1ba406-7638-44e5-bf0d-8aa27be24a59@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250811063035.12626-1-chenyi.qiang@intel.com>
 <20250811063035.12626-3-chenyi.qiang@intel.com> <9f1ba406-7638-44e5-bf0d-8aa27be24a59@intel.com>
Message-ID: <ag3U77kKME3LM6at@google.com>
Subject: Re: [kvm-unit-tests PATCH 2/2] nVMX: Test IA32_DEBUGCTLMSR behavior
 on set and cleared save/load debug controls
From: Sean Christopherson <seanjc@google.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Chenyi Qiang <chenyi.qiang@intel.com>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Mon, Aug 11, 2025, Xiaoyao Li wrote:
> On 8/11/2025 2:30 PM, Chenyi Qiang wrote:
> > Besides the existing DR7 test on debug controls, introduce a similar
> > separate test for IA32_DEBUGCTLMSR.
> > 
> > Previously, the IA32_DEBUGCTLMSR was combined with the DR7 test. However,
> > it attempted to access the LBR and BTF bits in the MSR which can be
> > invalid. Although KVM will exempt these two bits from validity check,
> > they will be cleared and resulted in the unexpected MSR value.
> 
> Initially, LBR (bit 0) and BTF(bit 1) have been allowed to write by the
> guest but the value are dropped, as the workaround to not break some OS that
> writes to the MSR unconditionally.
> 
> BTF never gets supported by KVM. While LBR gained support but it depends on
> PMU and LBR being exposed to the guest, which requires additional parameters
> to the test configuration.
> 
> On the other hand, DEBUGCTLMSR_BUS_LOCK_DETECT chosen by this patch doesn't
> require additional parameter, but it requires the hardware support of the
> feature. IIRC, it needs to be SPR and later. So it has less coverage of
> hardwares than LBR.
> 
> I'm not sure the preference of Sean/Paolo. Let's see what they would say.

I would say add dedicated tests (for BUS_LOCK_DETECT and LBR), and get any coverage
for KVM's handling of DEBUGCTL reads and writes as a side effect.

> > In this new test, access a valid bit (DEBUGCTLMSR_BUS_LOCK_DETECT, bit 2)
> > based on the enumration of Bus Lock Detect.
> > 
> > Signed-off-by: Chenyi Qiang <chenyi.qiang@intel.com>
> > ---
> >   x86/vmx_tests.c | 88 +++++++++++++++++++++++++++++++++++++++++++++++++
> >   1 file changed, 88 insertions(+)
> > 
> > diff --git a/x86/vmx_tests.c b/x86/vmx_tests.c
> > index 1832bda3..9a2e598f 100644
> > --- a/x86/vmx_tests.c
> > +++ b/x86/vmx_tests.c
> > @@ -1944,6 +1944,92 @@ static int dbgctls_dr7_exit_handler(union exit_reason exit_reason)
> >   	return VMX_TEST_VMEXIT;
> >   }
> > +static int dbgctls_msr_init(struct vmcs *vmcs)
> > +{
> > +	/* Check for DEBUGCTLMSR_BUS_LOCK_DETECT(bit 2) in IA32_DEBUGCTLMSR */
> > +	if (!(cpuid(7).c & (1 << 24))) {

	if (this_cpu_has(X86_FEATURE_BUS_LOCK_DETECT))

> > +		report_skip("%s : \"Bus Lock Detect\" not supported", __func__);
> > +		return VMX_TEST_VMSKIP;
> > +	}
> > +
> > +	msr_bmp_init();
> > +	wrmsr(MSR_IA32_DEBUGCTLMSR, 0x0);
> > +	vmcs_write(GUEST_DEBUGCTL, 0x4);

Please add #defines, i.e. don't use open coded magic literals.

> > +	vmcs_write(ENT_CONTROLS, vmcs_read(ENT_CONTROLS) | ENT_LOAD_DBGCTLS);
> > +	vmcs_write(EXI_CONTROLS, vmcs_read(EXI_CONTROLS) | EXI_SAVE_DBGCTLS);
