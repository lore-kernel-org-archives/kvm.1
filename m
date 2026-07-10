Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBEDF427A0F
	for <kvm@vger.kernel.org>; Fri, 10 Jul 2026 12:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783688174; cv=none; b=pKTWFCpmHL9TLCVIVTB/tzvOZpyxqV28lD/pkmP+4E5u03ILB/cDufqiIWRfenz1jl2S3UmTLyngq7u3XCh8za1xE7TQCf7AcqAmink3fGjWg0nH5/QFgk6+K/Qpy802QAa2iC69Ff6GDvNevQ3ieDWHzQPdJIukFkBfgNesvAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783688174; c=relaxed/simple;
	bh=dROs3mxilaizqzveJZHxZmPO1X0SiQhvPnc2NMYNWv0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=H+F9NxVaTZ+5G6Pl4j/Y+ZC4w2rblthHFtrMJcrhgj1a44uespsitFqyGfXXrOuQd6KSOX+tlC1qDP5CUWcuaJVQQzaUf8sneSTqH3+ztLtmQSsDQMEUp0XbOzpt6briLvh5tAaIOwO8oDq+srvcv6WpVMI38/mhZqO50sGy7/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VyariwAR; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=dDcEyu6C; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VyariwAR";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="dDcEyu6C"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783688171;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Zgrul92LzXDHK43ZSxjoOOhS6v8EW9Phuwa0awVwF2Y=;
	b=VyariwARa6pwY+krVQE3TjqrjGg3M6Cu7Tzb4AJjj/WfNtCD6Oj3LZ7xIo6KR8gi72BVFZ
	TXk16qvLQO03RyceAwh+8S5oc7XVNqOZotI9Auh54C04IXeYWMMhwH6zZIRJYGP3ze2rW1
	DWo8b/fPrlht+/UUSm6Yt2k6bGZD008=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-180-w4ReKcaoOnaClWGoE3my8Q-1; Fri, 10 Jul 2026 08:56:09 -0400
X-MC-Unique: w4ReKcaoOnaClWGoE3my8Q-1
X-Mimecast-MFC-AGG-ID: w4ReKcaoOnaClWGoE3my8Q_1783688169
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-47f24a50f0cso635185f8f.3
        for <kvm@vger.kernel.org>; Fri, 10 Jul 2026 05:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1783688168; x=1784292968; darn=vger.kernel.org;
        h=content-type:mime-version:message-id:date:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Zgrul92LzXDHK43ZSxjoOOhS6v8EW9Phuwa0awVwF2Y=;
        b=dDcEyu6CyLSNxnjgcKUvT5STsN7iQblfm5Zn1hlLuAu8YdMto6Tlhk/VkLAmTFDJdp
         67dnngISDZZXlE1g2vaZa/WATH+KvDOWiB4nHSalMTuKTjMHXf/s96CovA/i4okZUcQL
         iMfDTlo5VCtGi9uX13SMym5m1pqLUn6ErgvkuedeH2w1UZfYK8s2IChXrhSv8f7JJ5Em
         RiwDMati3eFE1kkJK/73udokKt1C6XHeBTPbjiA4ajI4uCj9JZffAIAZcZN+2zYeDf3r
         0MNdbkTbTD+G2fKtvVhMih9gRgfBds7O1LBi9WiFo6xS0WPR0WZJj8xjJrN+8gwMhCKb
         jLaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783688168; x=1784292968;
        h=content-type:mime-version:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Zgrul92LzXDHK43ZSxjoOOhS6v8EW9Phuwa0awVwF2Y=;
        b=lvHDqSRpqyKFS6LWMALJ6VNW4Kf3EdH6LlFR7FjgjGFuWjgj/t7p96fOq8TMpSpjOP
         yHleWfal16qoF5KXyiurCw2OHtcCgN30KvdyZ+yalHgnsSSPiAnOkCyf9ei0gqVxhH1U
         K+TManQx7czFWxAk4bi9l7g0bPT4gwQHZV7PlhzZRSbP12O+2kaaBfj/OLoaz5sSRYMY
         TPyj7H71pIekzrZnN1rxEJe9S0mmoxgfYgAAiB2M7NW1y1Reu/b+8AjhWnGop0sWJkrq
         VYDsfKm2PeXhQHknnnXVC3DSbsgkdKzGJ7KBooGGN0wXA8Kx+4Q1Q1IjgsJeM9ykOpBS
         Zvbw==
X-Gm-Message-State: AOJu0YxGJYdcSyX8kP44vVX1lBuM/ObkYvL3YkFXHGCJr8An7ovp/vhB
	TfDKr6QtFhvN60Y2+kf2dqVJ5zqob6cMagPDGyODz5/0onr4XM/xzIh7MrGLVdjcyhzT9pC6cGr
	7cyMXNldmkiYhe6Dz5X/0MshcpaaXf6zYuIsYUVDFAYI89bh+U5Eh3g==
X-Gm-Gg: AfdE7ckDr09aRlClAd1Y5RvBNrt+eiOuxg1tP/ePVdirYkitXUYXdc1Q63KQGiPBAmy
	4NnSJM48hcKxnqZpF7duCAaKNaw4FaOjfQ5FxsHbMy1VMdVKGQxC34Z8z3plb8Y3ItpxpiWOuvS
	J1LgpoZ2wQj9GQaiN3jCuKQENRzoTTYrPB4dJNWC5Y4SaN0NfZS0oycZLvcwVWOIuT8UIRH9dEK
	na9BpDseIklC1/0kppgXnpQMlQXvNcek8oJE1snIkUc6q0rnHWJ9TfpJDw+4BNvS+i3Xgm94M+H
	y62jz4S1mdhTKuGRdAsD8QV4zLGbrA0zbVw3mTKLszzmAiKCwcfi/lpIETlxqAEakuYNvBjp+xb
	q2qY=
X-Received: by 2002:a05:6000:29cd:b0:47e:96f6:6d99 with SMTP id ffacd0b85a97d-47e96f67108mr3686176f8f.18.1783688168597;
        Fri, 10 Jul 2026 05:56:08 -0700 (PDT)
X-Received: by 2002:a05:6000:29cd:b0:47e:96f6:6d99 with SMTP id ffacd0b85a97d-47e96f67108mr3686160f8f.18.1783688168218;
        Fri, 10 Jul 2026 05:56:08 -0700 (PDT)
Received: from fedora ([91.219.240.20])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa0f213e8sm58123582f8f.34.2026.07.10.05.56.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 05:56:07 -0700 (PDT)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini
 <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] KVM: x86: Reject nested CAP enablement if nested
 virtualization is disabled
In-Reply-To: <20260630202828.440724-2-seanjc@google.com>
References: <20260630202828.440724-1-seanjc@google.com>
 <20260630202828.440724-2-seanjc@google.com>
Date: Fri, 10 Jul 2026 14:56:07 +0200
Message-ID: <87qzlbf1g8.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Sean Christopherson <seanjc@google.com> writes:

> Add a flag to explicitly track if nested virtualization is enabled, and use
> it enumerate that various nested CAPs are unsupported, and to reject
> enablement of said CAPs.  When the nested ops hooks were moved to their
> own structure, KVM's NULL-by-default behavior was deliberately dropped,
> with the changelog asserting that all was well.  That wasn't quite true;
> there is no danger to KVM, but now KVM is over-reporting support for
> KVM_CAP_NESTED_STATE and KVM_CAP_HYPERV_ENLIGHTENED_VMCS.
>
> Fixes: 33b22172452f ("KVM: x86: move nested-related kvm_x86_ops to a separate struct")
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  arch/x86/include/asm/kvm_host.h |  2 ++
>  arch/x86/kvm/hyperv.c           |  3 ++-
>  arch/x86/kvm/svm/svm.c          |  1 +
>  arch/x86/kvm/vmx/vmx.c          |  1 +
>  arch/x86/kvm/x86.c              | 12 +++++++-----
>  5 files changed, 13 insertions(+), 6 deletions(-)
>
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index b517257a6315..36de689a579c 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -1906,6 +1906,8 @@ struct kvm_x86_ops {
>  };
>  
>  struct kvm_x86_nested_ops {
> +	bool enabled;
> +
>  	void (*leave_nested)(struct kvm_vcpu *vcpu);
>  	bool (*is_exception_vmexit)(struct kvm_vcpu *vcpu, u8 vector,
>  				    u32 error_code);
> diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
> index 1ee0d23f8949..7184622992d0 100644
> --- a/arch/x86/kvm/hyperv.c
> +++ b/arch/x86/kvm/hyperv.c
> @@ -2787,7 +2787,8 @@ int kvm_get_hv_cpuid(struct kvm_vcpu *vcpu, struct kvm_cpuid2 *cpuid,
>  	};
>  	int i, nent = ARRAY_SIZE(cpuid_entries);
>  
> -	if (kvm_x86_ops.nested_ops->get_evmcs_version)
> +	if (kvm_x86_ops.nested_ops->enabled &&
> +	    kvm_x86_ops.nested_ops->get_evmcs_version)
>  		evmcs_ver = kvm_x86_ops.nested_ops->get_evmcs_version(vcpu);
>  
>  	if (cpuid->nent < nent)
> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index ef69a51ab27f..163440fca59f 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
> @@ -5646,6 +5646,7 @@ static __init int svm_hardware_setup(void)
>  		if (r)
>  			return r;
>  	}
> +	svm_nested_ops.enabled = nested;
>  
>  	/*
>  	 * KVM's MMU doesn't support using 2-level paging for itself, and thus
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index 3681d565f177..ef9e1bc39edb 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -8786,6 +8786,7 @@ __init int vmx_hardware_setup(void)
>  		if (r)
>  			return r;
>  	}
> +	vmx_nested_ops.enabled = nested;
>  
>  	kvm_set_posted_intr_wakeup_handler(pi_wakeup_handler);
>  
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 0626e835e9eb..cd9a5ff47f6f 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -2346,7 +2346,7 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
>  			r &= ~KVM_X2APIC_ENABLE_SUPPRESS_EOI_BROADCAST;
>  		break;
>  	case KVM_CAP_NESTED_STATE:
> -		r = kvm_x86_ops.nested_ops->get_state ?
> +		r = kvm_x86_ops.nested_ops->enabled ?
>  			kvm_x86_ops.nested_ops->get_state(NULL, NULL, 0) : 0;
>  		break;
>  #ifdef CONFIG_KVM_HYPERV
> @@ -2354,7 +2354,8 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
>  		r = kvm_x86_ops.enable_l2_tlb_flush != NULL;
>  		break;
>  	case KVM_CAP_HYPERV_ENLIGHTENED_VMCS:
> -		r = kvm_x86_ops.nested_ops->enable_evmcs != NULL;
> +		r = kvm_x86_ops.nested_ops->enabled &&
> +		    kvm_x86_ops.nested_ops->enable_evmcs != NULL;
>  		break;
>  #endif
>  	case KVM_CAP_SMALLER_MAXPHYADDR:
> @@ -3366,7 +3367,8 @@ static int kvm_vcpu_ioctl_enable_cap(struct kvm_vcpu *vcpu,
>  			uint16_t vmcs_version;
>  			void __user *user_ptr;
>  
> -			if (!kvm_x86_ops.nested_ops->enable_evmcs)
> +			if (!kvm_x86_ops.nested_ops->enabled ||
> +			    !kvm_x86_ops.nested_ops->enable_evmcs)
>  				return -ENOTTY;
>  			r = kvm_x86_ops.nested_ops->enable_evmcs(vcpu, &vmcs_version);
>  			if (!r) {
> @@ -3732,7 +3734,7 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
>  		u32 user_data_size;
>  
>  		r = -EINVAL;
> -		if (!kvm_x86_ops.nested_ops->get_state)
> +		if (!kvm_x86_ops.nested_ops->enabled)
>  			break;
>  
>  		BUILD_BUG_ON(sizeof(user_data_size) != sizeof(user_kvm_nested_state->size));
> @@ -3762,7 +3764,7 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
>  		int idx;
>  
>  		r = -EINVAL;
> -		if (!kvm_x86_ops.nested_ops->set_state)
> +		if (!kvm_x86_ops.nested_ops->enabled)
>  			break;
>  
>  		r = -EFAULT;

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly

