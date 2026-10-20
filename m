Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792536989;
	b=EE72YbfQPPDA4cFBkwRqf4Ader73LVi5TCirTgzZmeTDvAbvfLXGcBGmN7Gs7ajPsyaT
	 tGZ4zq7i7EH+IHaYiogcmaD4tewgbGoWXmlboXl6Sbw4SaYWvyL/t0+FDsmVvhE0c54xF
	 T8nXKC+LL3F03mI7wQC2HZSNl0tzRVD1MyWNuzSrKGToC5i/j6rc9dPurwWK/kqKIHsYf
	 lGaTqrsLqWdsA4UZwfeOPjNJEdggkJGzKSkSMClxe97kwIsL2wixEW+Zi5WRpqQWbtAiZ
	 4/CmEFnyAMkDJv+fQW9lHQbLeDNkmwodWsSOCZS3qh1cE/pRCTc2vwP2tpluDCzzmfw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792536989;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=o9/1Vdfc6qItRdx7itjgEjHvEucc/+7NS14fKDuSA40=;
	b=Hf212iU8vab0xb+r7xoY4q6Buc2hnABhDxvvMzSrVEPMlioBy9tEfYuzGc78jben3kyr
	 IuGzu/BJDpipZy7fnQpW3T8lirvO4s4/sebht2zRXUY7tJ+DAxch0/eI3oKBbqPKSdoAJ
	 /WeieDF9GQZEA6cuq0l56hwCmqHmTbo8ediD7M06ERpbym/hZSLNJi93AHlR8EACXFk8j
	 Z4roNHvxmLoA1KmrzcKw8K8BhxZgzkj5mDcrdMeNudqrFOHFnQUD8DaXYKghgvsX4zoIu
	 zSLjABN5/DsZOF6GaNymfZoUisp5qmWsZ1dT8mY9uzNemG0RvVl9CPh05/OX8nlUAEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=cK5EQ2jj;
	arc=none smtp.remote-ip=209.85.216.72
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39760606A31E
	for <kvm@vger.kernel.org>; Tue, 20 Oct 2026 22:56:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 39760606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=cK5EQ2jj
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3aaf955db5fso278017a91.0
        for <kvm@vger.kernel.org>; Tue, 20 Oct 2026 15:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792536988; x=1793141788; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=o9/1Vdfc6qItRdx7itjgEjHvEucc/+7NS14fKDuSA40=;
        b=cK5EQ2jjmv9TWx/EpoTMgBjE7LLJsmO02wYj2udVbz2flT9O6R947nXSMaMF77NB9r
         RbJUuV5z6aihecDp5oVgDEJO60Zv8NPil9JIC7rQ8cUSMHuUGBm6fVzlpsb2+zpgZNJY
         hI9hzorpXnDaWUs0kqq6fnNqDPaU0UR5ueDnITpnx4YU+NY1mZyEgo75+STAojRxgkah
         ySntzSs0+SopWX5MDih7y0HEkgw5RblxL+rMioXxO1OlqzQDIh+tvPFIuaJgf/fBLNZD
         kRwzHsK5hZEb5y75BJaOWVbYvO4bbGymRbPEWX46sf507FGpcIsEbrxAT0lI2cNQkH71
         68+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792536988; x=1793141788;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=o9/1Vdfc6qItRdx7itjgEjHvEucc/+7NS14fKDuSA40=;
        b=NWXQ4ZqaVkjspspKZPlY7GhaIFBFkwu1nCQGtW2tCrECvUOR3oSLTXyYDtteDNvw6k
         EcPwbzGokclrl9fgU+RFq4lqG1FQM7dw0pgmVJnFFEX0EPmd0JiYA3WO8kNb7zsKaU86
         XWH0jCJ/XCHxWQzOFs4A8hmdJs39YF0Q1zuXRc2Cbmmg+TLm6+F8V6K6+XY3wTcBi9QA
         JIF5qfYihh8lBKUcWCchEcOdX1yifrgTh8j7GADDFXFobOkCRFN5Dg1lMLrrBg0KPl3B
         8ASYHdoX5spesPdPE8svrSFQfiVObkj3Y6UsTDdFyNsHlLNCddxM9KS3neu9Vh3QzUH3
         kzdQ==
X-Gm-Message-State: AFq9FYLHcloyT0Pxh6nEPKTPzCtEXdumRzlPuUatgZ411HnlOUEJmIhU
	V29ofa/WEchRDVa5jIP3gtlNr6nWr4ZQHqShgeJMreATItWwZwoot4jUewNzM/Dx39NEsUnCT8F
	gePCLmg==
X-Received: from pgww27.prod.google.com ([2002:a05:6a02:2c9b:b0:cd6:2185:e87e])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:39ac:b0:3a0:9640:8039
 with SMTP id 98e67ed59e1d1-3ad86f454d8mr261644a91.30.1792536988210; Tue, 20
 Oct 2026 15:56:28 -0700 (PDT)
Date: Tue, 20 Oct 2026 15:56:27 -0700
In-Reply-To: <f1f39118-2e1b-476b-9a84-ef7d56412bdc@tum.de>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <f1f39118-2e1b-476b-9a84-ef7d56412bdc@tum.de>
Message-ID: <atfxm7Tj7nYB_6Kr@google.com>
Subject: Re: [PATCH] x86/hyper-v: Don't WARN on VM-Enter if eVMCS sees
 VMFUNC[63:32] != 0
From: Sean Christopherson <seanjc@google.com>
To: Manuel Andreas <manuel.andreas@tum.de>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, pbonzini@redhat.com, 
	Vitaly Kuznetsov <vkuznets@redhat.com>
Content-Type: text/plain; charset="us-ascii"

On Tue, Oct 20, 2026, Manuel Andreas wrote:
> With the necessary Hyper-V extensions for eVMCS enabled, an L1 guest can
> trivially fire a WARN_ON_ONCE in nested_evmcs_check_controls.
> While vmcs12->vm_function_control is technically already sanity checked in
> nested.c, that check is only performed if VMFUNC functionality is at all enabled
> in the secondary processor controls of vmcs12.
> 
> vmcs12->vm_function_control seems to only be utilized in the handling
> of a VMFUNC initiated from L2, but here a function other than 0 will
> just end up in a failure case either way, regardless of whether or not
> it is permissive in vmcs12->vm_function_control.
> Therefore, the check has no reason to trigger a warning at all.
> 
> This patch simply removes the WARN_ON_ONCE and keeps the check.
> 
> Fixes: 3ff8a13d41b2 ("KVM: nVMX: WARN once and fail VM-Enter if eVMCS sees VMFUNC[63:32] != 0")
> Signed-off-by: Manuel Andreas <manuel.andreas@tum.de>
> ---
>  arch/x86/kvm/vmx/hyperv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/vmx/hyperv.c b/arch/x86/kvm/vmx/hyperv.c
> index fa41d036acd4..008a06924eb4 100644
> --- a/arch/x86/kvm/vmx/hyperv.c
> +++ b/arch/x86/kvm/vmx/hyperv.c
> @@ -186,7 +186,7 @@ int nested_evmcs_check_controls(struct vmcs12 *vmcs12)
>  	 * controls in bits 63:32, i.e. dropping those bits on the consistency
>  	 * check is intentional.
>  	 */
> -	if (WARN_ON_ONCE(vmcs12->vm_function_control >> 32))

I think the WARN is correct, this code is broken.  Unless I'm missing some eVMCS
magic/quirk, this, and the secondary controls check, should be conditioned on the
field actually being used.

This, over two patches?

diff --git a/arch/x86/kvm/vmx/hyperv.c b/arch/x86/kvm/vmx/hyperv.c
index fa41d036acd4..a1daf8f2ec5a 100644
--- a/arch/x86/kvm/vmx/hyperv.c
+++ b/arch/x86/kvm/vmx/hyperv.c
@@ -169,7 +169,8 @@ int nested_evmcs_check_controls(struct vmcs12 *vmcs12)
 					       vmcs12->cpu_based_vm_exec_control)))
 		return -EINVAL;
 
-	if (CC(!nested_evmcs_is_valid_controls(EVMCS_2NDEXEC,
+	if (nested_cpu_has(vmcs12, CPU_BASED_ACTIVATE_SECONDARY_CONTROLS) &&
+	    CC(!nested_evmcs_is_valid_controls(EVMCS_2NDEXEC,
 					       vmcs12->secondary_vm_exec_control)))
 		return -EINVAL;
 
@@ -186,11 +187,10 @@ int nested_evmcs_check_controls(struct vmcs12 *vmcs12)
 	 * controls in bits 63:32, i.e. dropping those bits on the consistency
 	 * check is intentional.
 	 */
-	if (WARN_ON_ONCE(vmcs12->vm_function_control >> 32))
-		return -EINVAL;
-
-	if (CC(!nested_evmcs_is_valid_controls(EVMCS_VMFUNC,
-					       vmcs12->vm_function_control)))
+	if (nested_cpu_has_vmfunc(vmcs12) &&
+	    (WARN_ON_ONCE(vmcs12->vm_function_control >> 32) ||
+	     CC(!nested_evmcs_is_valid_controls(EVMCS_VMFUNC,
+						vmcs12->vm_function_control))))
 		return -EINVAL;
 
 	return 0;


> +	if (vmcs12->vm_function_control >> 32)
>  		return -EINVAL;
>  
>  	if (CC(!nested_evmcs_is_valid_controls(EVMCS_VMFUNC,
