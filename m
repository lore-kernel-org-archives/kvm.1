Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C25783A1687
	for <kvm@vger.kernel.org>; Mon,  6 Apr 2026 23:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775519287; cv=none; b=s2VfTaY3dI6JNF73/l4N5HWNOrLd2TWWOn890JMLfxJtgM8JKrs3O++P8PIYciiusgR8UZ1oZzPu2n/uDcqsqOE4gC+D0375CP/3kRgP+ap29D7sPOo8/7H9hrTI16hdgffn0m3o4JNqSf25Vb4JZFmgZfX14W626TuoeR6KnFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775519287; c=relaxed/simple;
	bh=x8NG4mfnBIGaHvidp37eSv1frVOu1FSrxdYuqYUhhkE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=trdBZVA1IXQwXempw0KJ7RfDJoDfRg1lpudN7hKl6bXb88nHIDvvMvcK3Q6/M0Uc1rKRI59iuBBS1D6ansAlgoHYY3EcJIxU45yxXUJ8bKH05QjL6/JT6bM7XN7dyIwrkBl6IJoq4mb3SGOw5GkNwJpFmZa8at24bSrjvmQKTUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RlOdkhg5; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RlOdkhg5"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c7651644975so2744277a12.1
        for <kvm@vger.kernel.org>; Mon, 06 Apr 2026 16:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775519278; x=1776124078; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hwcEAbY2bOvu6u/DfZ78E/6y5JAOUHxIU/exu8Slvng=;
        b=RlOdkhg588nOfN1W1XRJAe5zNNUXAoHDM6cS8/vGfCvFRq0opVtIvHkJyGKhsG09Mg
         8XCYEMBmroxFu4LD3sEZjH5V5yjxBFofjpRehY6CKFmr8w9/I88RMcFRQbf2Z8y33gUs
         7tn+RIX/GJXDB+a8J7a05mbV7Gh+vq+JWNCF2aWPSHmeEG6uMBF52RuvkGUWyOGF7hu8
         tAVF9gC2QuOCLJ2BH+HI57DaOH8kFZWxeBLNoXwSDuhw56r9L8GGHdAA6bFzvzXcFIol
         t5aTC8j4Q6M5sJIGvvxnEEgNre3KAHLoiP8AfDECQYnuV9eyyidhbk0NN3fGvQiRZBBX
         sWbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775519278; x=1776124078;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hwcEAbY2bOvu6u/DfZ78E/6y5JAOUHxIU/exu8Slvng=;
        b=A7TlniDouSvPLESaAr7Yuk04cbK6O8H+v/rdxp6e9K8P8MSYavRdnEoiQj1J+zUn9k
         Cjs9jkKuLY8pqeG4JT0XDx+qKSakdAd7QAMSQcCc39qwmLBgR9mPQJBbbUFdHMsMfUV9
         LvwixO7i6KLavq3nEr2q02hV3UkEz13EAswz63kuJ81OfBriSJOoD/X/5Hq0LhFOjvJ2
         r+UoyLRs4ns0As5mjipjkly0YVLm6KuK/ogQdFUeFX37ChC9tc8kAV17jB8m8aKbex3p
         pW9NVUTKRh36GG8MxeaiKdAIvF5HnD0pJYZEnYfF5qbche9R/qGzy4nVUEOTAMw9XoQ/
         rViA==
X-Forwarded-Encrypted: i=1; AJvYcCUnckkA+ALh4Y0KTj5wzmu2QlsNctwVvm6qRaQUyIFX8ckf2qZYry5W/Lk6v/uSvJZ1+e4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqIABY6vEGpNIsHdCEU1qn6pcpZQKOTlSPHVpGUPjYnyigIx8l
	BUh8t3f7lAsyHUeMQdLO6IRSWAim/JTgXhWCxaeb3gtoTX2Bive3XjqVd7hK1eGXxJwz076z//k
	oFG2jbw==
X-Received: from pgh3.prod.google.com ([2002:a05:6a02:4e03:b0:c73:8e3c:d0d9])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:9389:b0:398:7d6e:27f1
 with SMTP id adf61e73a8af0-39f2ee005c5mr14221162637.9.1775519277748; Mon, 06
 Apr 2026 16:47:57 -0700 (PDT)
Date: Mon, 6 Apr 2026 16:47:56 -0700
In-Reply-To: <20260327234023.2659476-9-jmattson@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260327234023.2659476-1-jmattson@google.com> <20260327234023.2659476-9-jmattson@google.com>
Message-ID: <adRGLPrmBpX-3DdX@google.com>
Subject: Re: [PATCH v7 8/9] KVM: x86: nSVM: Save/restore gPAT with KVM_{GET,SET}_NESTED_STATE
From: Sean Christopherson <seanjc@google.com>
To: Jim Mattson <jmattson@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Yosry Ahmed <yosry@kernel.org>
Content-Type: text/plain; charset="us-ascii"

On Fri, Mar 27, 2026, Jim Mattson wrote:
> @@ -1918,6 +1921,7 @@ static int svm_set_nested_state(struct kvm_vcpu *vcpu,
>  	struct vmcb_save_area_cached save_cached;
>  	struct vmcb_ctrl_area_cached ctl_cached;
>  	unsigned long cr0;
> +	bool use_separate_l2_pat;

Land this above "cr0" to preserve the inverted fir tree.

>  	int ret;
>  
>  	BUILD_BUG_ON(sizeof(struct vmcb_control_area) + sizeof(struct vmcb_save_area) >
> @@ -1993,6 +1997,18 @@ static int svm_set_nested_state(struct kvm_vcpu *vcpu,
>  	    !nested_vmcb_check_save(vcpu, &save_cached, false))
>  		goto out_free;
>  
> +	/*
> +	 * Validate gPAT when the shared PAT quirk is disabled (i.e. L2
> +	 * has its own gPAT). This is done separately from the
> +	 * vmcb_save_area_cached validation above, because gPAT is L2
> +	 * state, but the vmcb_save_area_cached is populated with L1 state.
> +	 */
> +	use_separate_l2_pat =
> +		(ctl_cached.misc_ctl & SVM_MISC_ENABLE_NP) &&
> +		!kvm_check_has_quirk(vcpu->kvm,
> +				     KVM_X86_QUIRK_NESTED_SVM_SHARED_PAT);

I vote for either:

	use_separate_l2_pat = (ctl_cached.misc_ctl & SVM_MISC_ENABLE_NP) &&
			      !kvm_check_has_quirk(vcpu->kvm,
						   KVM_X86_QUIRK_NESTED_SVM_SHARED_PAT);

or

	use_separate_l2_pat = (ctl_cached.misc_ctl & SVM_MISC_ENABLE_NP);
	if (kvm_check_has_quirk(vcpu->kvm, KVM_X86_QUIRK_NESTED_SVM_SHARED_PAT))
		use_separate_l2_pat = false;


> +	if (use_separate_l2_pat && !kvm_pat_valid(kvm_state->hdr.svm.gpat))
> +		goto out_free;
>  
>  	/*
>  	 * All checks done, we can enter guest mode. Userspace provides
> @@ -2017,6 +2033,10 @@ static int svm_set_nested_state(struct kvm_vcpu *vcpu,
>  	nested_copy_vmcb_control_to_cache(svm, ctl);
>  
>  	svm_switch_vmcb(svm, &svm->nested.vmcb02);
> +
> +	if (use_separate_l2_pat)
> +		vmcb_set_gpat(svm->vmcb, kvm_state->hdr.svm.gpat);
> +
>  	nested_vmcb02_prepare_control(svm);
>  
>  	/*
> -- 
> 2.53.0.1018.g2bb0e51243-goog
> 
