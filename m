Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09EA03AA1B6
	for <kvm@vger.kernel.org>; Thu,  6 Aug 2026 14:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786026663; cv=none; b=dOKnoL+yO2sgUqUwZrjrMRO0ASZs6aWLXuSRNlQuvPsHgVYjQHWeFbo+doc//D52aL0DUu2CNVPYGQVMJL/4sO2414EXp57Xin8ASKwk0fXbHO7sr7eVpQdlzNPrXI8Z9E3HdfBXBsPneJgRHr2aSjWzuwkvVCyf72RmB0fPq10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786026663; c=relaxed/simple;
	bh=SRzjip+qs2pYzBg8Y6FNsQVxNT+5RUMD0U2OziG0v0g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Jq4ElWAERUUE+nCD9/tPLLaa86k3OGlf/PpTU//bUtFQ6Y7Ovck4qpYjPb6vCOD6Wd+cvm6tNB4LQzvUc4pRAkiQIDbT+3y0YIaA1gIe8lVGh39B6WlP5ZVveyjy74+7BC9qlF1lDavUighh7L5sWgk9i7kxj71QSnyc8Gkfhfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=inpK2JYd; arc=none smtp.client-ip=209.85.210.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="inpK2JYd"
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-8487eb67173so3693459b3a.2
        for <kvm@vger.kernel.org>; Thu, 06 Aug 2026 07:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786026661; x=1786631461; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Qjt2glL7ixu+FlQa4aMWFeGpCQ+RwktDF7Vh1GaP9Vk=;
        b=inpK2JYdGouBiIOdobmvyjljaEBIx4n2S5/MgiqfjqZ0kvgz72t7cumP9lKiZaews3
         YXe5Af3pWlF7H4gsvDM0bbCdmyc+zsUx0YsxLFX87zGJJArT/d4KnfDoVpCbIDTd/2Za
         W5ecfJzKxjMNj+TrCV/py3VOvn+TCCsf4Hq4mk+apy1iGy4/8ulVHDi79+kyPEmUhM3R
         PVgukR6nMxHmPJZ1IesbFUFOe36WgYXL6CRUSXRILa0k6/zjjKyofe+ZNs4uv7B9IIIu
         gfcOXxa/Hd6sznTNUwkXiu/GIMd+Spzq8BCqDyfcBj0+GYVdoPssxBxw2mCnIOLz8dGb
         YWYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786026661; x=1786631461;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Qjt2glL7ixu+FlQa4aMWFeGpCQ+RwktDF7Vh1GaP9Vk=;
        b=mk/f3O29cPVkP++WX1mGbhfLsOBIKTVRKvK1elckCEju1OP6hQxX0skvmEPsmDk1f7
         cMaMjg+0wT7KwLLizHP0suQyUCTpMdN3YCcAUfeQZTMroSh4C8HouyRE/Y3YqKYEk3Qt
         5n1fAKW6dOAOnuh/eZCGn/ZvQnfj6wJBpo+I0VPmVjf7YzbnNTPjgqnjFFhVKlUvKPWr
         m5JSUBe/6I7/rDWU7+2nwVHQUT0ZyfezxgW33Njyci29kYVBdtQs/c8BcayR53P0gcAF
         0JnRboVBxcc77dE1AWzHsOrW/Rd8UfELDQqaz+3k8JoZjeldbKZg8bIXSpVGBKN7w4nD
         7EtA==
X-Forwarded-Encrypted: i=1; AHgh+RoBnGsBTkw2bLsxsL/K4gX5mdM31d+EpR0sPy5NvJBvmWS3cV/TsjKoTBQ87aQqDF/E2eU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRPFmz0MQCeIuG7i8AOAcfOzAz4o3PnJPuj1gHzimGy6zVRMid
	B6ms10Rr3GrD+J5YMqOxPomfs3NE5qtUj8ORKJPLQ69iETBcHA1W9vUO0SH6yGEK6MjLykBijnc
	XTmMO7A==
X-Received: from pfbc4.prod.google.com ([2002:a05:6a00:ad04:b0:848:478d:6efb])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:228e:b0:848:6c1c:17c0
 with SMTP id d2e1a72fcca58-84f2e026437mr17017883b3a.19.1786026660993; Thu, 06
 Aug 2026 07:31:00 -0700 (PDT)
Date: Thu, 6 Aug 2026 07:31:00 -0700
In-Reply-To: <20260806111923.1990562-3-xiaoyao.li@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260806111923.1990562-1-xiaoyao.li@intel.com> <20260806111923.1990562-3-xiaoyao.li@intel.com>
Message-ID: <anSapM1jrwRkojQs@google.com>
Subject: Re: [PATCH 2/3] KVM: x86: Reject enabling KVM_CAP_X86_BUS_LOCK_EXIT
 when !kvm_caps.has_bus_lock_exit
From: Sean Christopherson <seanjc@google.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Thu, Aug 06, 2026, Xiaoyao Li wrote:
> Return -EINVAL to reject the enabling of KVM_CAP_X86_BUS_LOCK_EXIT from
> userspace when kvm_caps.has_bus_lock_exit is false.
> 
> For KVM_BUS_LOCK_DETECTION_EXIT, if KVM doesn't support BUS LOCK EXIT,
> return error to userspace instead of success.
> 
> For KVM_BUS_LOCK_DETECTION_OFF, it seems OK to allow it when KVM doesn't
> support bus_lock_exit. But from an API perspective, it implies
> inconsistency that KVM_CAP_X86_BUS_LOCK_EXIT reports 0 but setting
> KVM_BUS_LOCK_DETECTION_OFF is allowed. To keep it consistent, also
> return error for KVM_BUS_LOCK_DETECTION_OFF when KVM doesn't support
> BUS LOCK EXIT.
> 
> Fixes: fe6b6bc802b4 ("KVM: VMX: Enable bus lock VM exit")
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> ---
> ---
>  arch/x86/kvm/x86.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index d94b59140c45..3d8422d1cd04 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -4058,8 +4058,10 @@ int kvm_vm_ioctl_enable_cap(struct kvm *kvm,
>  		    (cap->args[0] & KVM_BUS_LOCK_DETECTION_EXIT))
>  			break;
>  
> -		if (kvm_caps.has_bus_lock_exit &&
> -		    cap->args[0] & KVM_BUS_LOCK_DETECTION_EXIT)
> +		if (!kvm_caps.has_bus_lock_exit)
> +			break;

Yikes, we really botched this one.

KVM unfortunately made KVM_BUS_LOCK_DETECTION_OFF an explicit flag, not an absense
of flags, without actually honoring that flag.  E.g. doing KVM_BUS_LOCK_DETECTION_OFF
after KVM_BUS_LOCK_DETECTION_EXIT doesn't actually turn off detection.

I vote to get greedy and try dropping KVM_BUS_LOCK_DETECTION_OFF entirely, and
making it so that calling the CAP without any flags turns off detection.  Otherwise
we have to either rejec that case (also risks breaking userspace) or treat it as
"do nothing" (which is just stupid).  We'd want to reserve bit 0 to avoid really
bad breakage, i.e. so that we don't re-introduce bit 0 as something else, but
that's easy enough.

I'm thinking this over a few patches:

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index 1e64026d7c1e..b7c21675aa81 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -8379,7 +8379,6 @@ The valid mask flags are:
 
 Valid bits in args[0] are::
 
-  #define KVM_BUS_LOCK_DETECTION_OFF      (1 << 0)
   #define KVM_BUS_LOCK_DETECTION_EXIT     (1 << 1)
 
 Enabling this capability on a VM provides userspace with a way to select a
@@ -8393,8 +8392,8 @@ guest, irrespective whether or not the host has enabled split-lock detection
 intended to mitigate attacks where a malicious/buggy guest can exploit bus
 locks to degrade the performance of the whole system.
 
-If KVM_BUS_LOCK_DETECTION_OFF is set, KVM doesn't force guest bus locks to VM
-exit, although the host kernel's split-lock #AC detection still applies, if
+If KVM_BUS_LOCK_DETECTION_EXIT is not set, KVM doesn't force guest bus locks to
+VM exit, although the host kernel's split-lock #AC detection still applies, if
 enabled.
 
 If KVM_BUS_LOCK_DETECTION_EXIT is set, KVM enables a CPU feature that ensures
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 1ac60628b4c0..67791d139615 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -150,8 +150,8 @@ EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_host);
        (KVM_X86_QUIRK_CD_NW_CLEARED |          \
         KVM_X86_QUIRK_IGNORE_GUEST_PAT)
 
-#define KVM_BUS_LOCK_DETECTION_VALID_MODE      (KVM_BUS_LOCK_DETECTION_OFF | \
-                                                KVM_BUS_LOCK_DETECTION_EXIT)
+/* Bit 0 is forever reserved to avoid breaking userspace in bad ways. */
+#define KVM_BUS_LOCK_DETECTION_VALID_MASK      (KVM_BUS_LOCK_DETECTION_EXIT & ~BIT(0))
 
 #define KVM_X86_NOTIFY_VMEXIT_VALID_BITS       (KVM_X86_NOTIFY_VMEXIT_ENABLED | \
                                                 KVM_X86_NOTIFY_VMEXIT_USER)
@@ -2381,8 +2381,7 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
                break;
        case KVM_CAP_X86_BUS_LOCK_EXIT:
                if (kvm_caps.has_bus_lock_exit)
-                       r = KVM_BUS_LOCK_DETECTION_OFF |
-                           KVM_BUS_LOCK_DETECTION_EXIT;
+                       r = KVM_BUS_LOCK_DETECTION_VALID_MASK;
                else
                        r = 0;
                break;
@@ -4051,17 +4050,18 @@ int kvm_vm_ioctl_enable_cap(struct kvm *kvm,
                break;
        case KVM_CAP_X86_BUS_LOCK_EXIT:
                r = -EINVAL;
-               if (cap->args[0] & ~KVM_BUS_LOCK_DETECTION_VALID_MODE)
+               if (!kvm_caps.has_bus_lock_exit)
                        break;
 
-               if ((cap->args[0] & KVM_BUS_LOCK_DETECTION_OFF) &&
-                   (cap->args[0] & KVM_BUS_LOCK_DETECTION_EXIT))
+               if (cap->args[0] & ~KVM_BUS_LOCK_DETECTION_VALID_MASK)
                        break;
 
-               if (kvm_caps.has_bus_lock_exit &&
-                   cap->args[0] & KVM_BUS_LOCK_DETECTION_EXIT)
-                       kvm->arch.bus_lock_detection_enabled = true;
-               r = 0;
+               mutex_lock(&kvm->lock);
+               if (!kvm->created_vcpus) {
+                       kvm->arch.bus_lock_detection_enabled = cap->args[0] & KVM_BUS_LOCK_DETECTION_EXIT;
+                       r = 0;
+               }
+               mutex_unlock(&kvm->lock);
                break;
 #ifdef CONFIG_X86_SGX_KVM
        case KVM_CAP_SGX_ATTRIBUTE: {
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 129d6f630325..08e5fe09e5c8 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -1542,7 +1542,6 @@ struct kvm_dirty_gfn {
        __u64 offset;
 };
 
-#define KVM_BUS_LOCK_DETECTION_OFF             (1 << 0)
 #define KVM_BUS_LOCK_DETECTION_EXIT            (1 << 1)
 
 #define KVM_PMU_CAP_DISABLE                    (1 << 0)


> +
> +		if (cap->args[0] & KVM_BUS_LOCK_DETECTION_EXIT)
>  			kvm->arch.bus_lock_detection_enabled = true;
>  		r = 0;
>  		break;
> -- 
> 2.43.0
> 
