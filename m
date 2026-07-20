Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE0E43803D
	for <kvm@vger.kernel.org>; Mon, 20 Jul 2026 15:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784562751; cv=none; b=uIBg3ATLtw4kh1jqJm7HnzwxuveIJCzFwHQvPGcONcMeEns1LJFPvrSrYklaRqZFXBktwr27bzScezSM+2Df5dktewPfGu/T0p95bDQMVTdAjrkwHZzcaHCN3Q2AF01zkRbVbdrH9qyAaRMoaw6oVVCl70wkqvBt9lYDoFMBh7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784562751; c=relaxed/simple;
	bh=q8IKDZFN3XHBjNxs6JTdILHgbuEWdlYWC7sZBIHFoOI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VLt8cMLVD9AF5RQQTsDGiXno55vQBZa4dEO4CssKh24E/v+pmbN8/2drQjBubuzr2TuE/woTgygb+EkazjA8vwWiD/vCJjvx1nyU4JVMFPWh7czIhHMMiuFp+oyUZDooVuYnf0I6+jUZyx26M/kjhcdBhFUhdflwoL5jzThdn1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pC5StrWK; arc=none smtp.client-ip=209.85.214.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pC5StrWK"
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2cee1ec30f2so94462375ad.3
        for <kvm@vger.kernel.org>; Mon, 20 Jul 2026 08:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784562749; x=1785167549; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yjFnn0IRKPkB9mfObc9RuyZNVxFyPF2whZGfyx26/w8=;
        b=pC5StrWKVLEyyRRNIKNbm7+hhQqjhV0QCulJUm+fjJDEr20Ksvn0g0QqWH9HO3wAVy
         QMqEpA+1z5QVjrHlZ6gFXiZg14N0O9kal6o+Uc71yx3c0bv37GPYVtsnjdHAHhjoV4vA
         855wVyHOKuqcCfQOvRe1plDzumuAR7TxzfhTiemPS2fqzECxZUe5+gYm3aHchRbvDbvj
         jkB9pcU9bVl4lBFvR093m/b3LGsP9Bz/O8t/rpGATAA3hKU8U0rCsxPMWYT6XVV72Q2b
         d1kZu2OlxXqk8u51gZHwDh1mhzNIlAcaZP2wOn68opDdwgxKpqqptTqltmBrCXTPZW9M
         uLvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784562749; x=1785167549;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yjFnn0IRKPkB9mfObc9RuyZNVxFyPF2whZGfyx26/w8=;
        b=RKeV8pP/++vcf0B0478cp8rgv0M0somC8tHSxdShplniR7h6k5DHu79ba1a5BOmfJ0
         eDSysnQlkVnmX1Y95rR3Bjjj2tA7ykoxPJvrSdGW/wZxIMkH5+/P3U/6JDcd8YgWcPy/
         Qh6Qqg0oehNsAdylTLaNr+Bq/7FbZex+llt0Q9eux0IYJmPuYQ5iEyqqRWa2uVNd67ps
         ZIG6wVkPidFeGOYfMrSN1hZ0H7L1NtuZAjayTwl7EVbaIpLg8iFec8FqsXxpxfDEEtJJ
         uoXmTZlMoJlRI/ZFdO1J92x8ltUPP1pQnTuB+mC486jaU7xN+bJLQR486vQWxVTKfKri
         0NSw==
X-Forwarded-Encrypted: i=1; AHgh+RoZ9j6UaQKu0nBDTAz+xa6Q60Yz+atBfy5hDvF3E/J/asAj/1cVEr2D/ChxcxgxxRWuVNQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaRvrqKhD62nQrZu1rCopHKa/1omNHyrQo+/+Uf15LIe3k4Cu7
	7hGKYFsYYoziC61Ef0F41uBRBgDCRZd3jZR8JNB3nEwA3XR/04J75dg0TxKWc/xQrTiJsV6yppD
	SknRBRg==
X-Received: from plda5.prod.google.com ([2002:a17:902:ee85:b0:2cb:97da:d8ed])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:3550:b0:2c9:97a8:aff1
 with SMTP id d9443c01a7336-2cf349f76b7mr152744045ad.42.1784562748691; Mon, 20
 Jul 2026 08:52:28 -0700 (PDT)
Date: Mon, 20 Jul 2026 08:52:28 -0700
In-Reply-To: <20260717230542.3555587-2-jmattson@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260717230542.3555587-1-jmattson@google.com> <20260717230542.3555587-2-jmattson@google.com>
Message-ID: <al5EPBD0KQDpbNiA@google.com>
Subject: Re: [PATCH v2 1/3] KVM: SVM: Configure ALLOW_LARGER_RAP in svm_vcpu_after_set_cpuid()
From: Sean Christopherson <seanjc@google.com>
To: Jim Mattson <jmattson@google.com>
Cc: amit.shah@amd.com, kvm@vger.kernel.org, pbonzini@redhat.com, 
	venkateshs@google.com, yosry@kernel.org
Content-Type: text/plain; charset="us-ascii"

On Fri, Jul 17, 2026, Jim Mattson wrote:
> On initial vCPU creation, init_vmcb() is called before userspace configures
> guest CPUID via KVM_SET_CPUID2. Consequently, ERAP_CONTROL_ALLOW_LARGER_RAP
> is never set during initial vCPU creation. If an AP later receives an INIT
> signal after CPUID has been set, init_vmcb() would set the bit for that AP,
> but the BSP would be left with ALLOW_LARGER_RAP clear.
> 
> Configure ALLOW_LARGER_RAP in svm_vcpu_after_set_cpuid() to handle the BSP.
> 
> Keep the code in init_vmcb() to restore ALLOW_LARGER_RAP after the VMCB has
> been cleared on the VCPU triple-fault reset path.
> 
> Fixes: db5e82496492 ("KVM: SVM: Virtualize and advertise support for ERAPS")
> Assisted-by: Gemini:Gemini-Next
> Signed-off-by: Jim Mattson <jmattson@google.com>
> ---
>  arch/x86/kvm/svm/svm.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index 4d2bacd00ec4..bf868da14cd2 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
> @@ -4736,6 +4736,11 @@ static void svm_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
>  	if (guest_cpuid_is_intel_compatible(vcpu))
>  		guest_cpu_cap_clear(vcpu, X86_FEATURE_V_VMSAVE_VMLOAD);
>  
> +	if (guest_cpu_cap_has(vcpu, X86_FEATURE_ERAPS))
> +		svm->vmcb01.ptr->control.erap_ctl |= ERAP_CONTROL_ALLOW_LARGER_RAP;
> +	else
> +		svm->vmcb01.ptr->control.erap_ctl &= ~ERAP_CONTROL_ALLOW_LARGER_RAP;

If we handle ERAPS here, can't we drop the code in init_vmcb()?  In the context
of PML enablement, AMD is updating the APM to clarify that the control area remains
valid after shutdown, i.e. KVM doesn't need to re-initialize erap_ctl when
synthesizing INIT from shutdown_interception().

  "After an intercepted shutdown, the VMCB control area is valid (with the
   exception of offsets 60h, 61h, and 68h) and the VMCB state save area is
   undefined."

https://lore.kernel.org/all/6688fe2e-c723-404a-80e1-3f4c5f5cc4c6@amd.com


> +
>  	if (is_sev_guest(vcpu))
>  		sev_vcpu_after_set_cpuid(svm);
>  }
> -- 
> 2.55.0.229.g6434b31f56-goog
> 
