Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89C99324B2C
	for <kvm@vger.kernel.org>; Sat,  6 Jun 2026 09:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780738255; cv=none; b=JW5wqZulW3pSf28vVaGJEVdcSUqGU6Lb9DmjndqCbXxOTJBtWVkCZGITr9Q4IVKDoYS3v+FIv78lpz/gJWMMo0mDBiAg6sm2GJac5FwN+DsS1k2AAe0BdahwUpEe3GEGtwkXTdeuwqeuAA+WfYkBzCw2pPfxm/mtkbmpMwBkdd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780738255; c=relaxed/simple;
	bh=F+XhGKiMdPICyh3Dd/vuQlSocHJM+HyGDKBQESk60aQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jqtEwVtxFMk1KjSgcGODIykZtICLlSqABCsImgeZPf73Opn5dIKzGCmffEuM3ro8e9oRIBGveO9SYRtbpyaMh2SGEsDWd4/bcd71sU6VkM5buuPtok8X2uJJCO8zmgz24cB5XlyzOPRtrX9dpeXZssCBn4DYQeat3KAnqrZZ7qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HMX7yxk3; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HMX7yxk3"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-490b8ac62baso25280845e9.0
        for <kvm@vger.kernel.org>; Sat, 06 Jun 2026 02:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780738246; x=1781343046; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4mrd5emMO53gUDIGTurx4veRGBVnKjMqx6MACNgSteE=;
        b=HMX7yxk3iFw3gk/rzdq/3LVer60jTWdIy9vU26wqu3tq5acO6xoYRMHboQD7okpqQB
         G08RUIQ+DZryF7nrMFhV6ILYbkEqJ8elEcotOIJdpJS1cqARLB6NQs+n9c1EXGVAylLq
         WXQMkSTdgVTE1i3kdF1ly3KzmsCmHWs4tRa1k94T5X71SJm7vruD8za7BcFBwCtVMeto
         +lW4XLJhCpS+yxNYvZ+QLV5Yrha055RSPLFhglTewXEw/QOubmg0jHtusII+6wesS5cL
         8h2+zPce9yiyQq7Do6emw8AILI+5pf6a4nUbGCqzTPIAhWNgMHrzGh3SmxCOzGhJ+N2S
         h7hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780738246; x=1781343046;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4mrd5emMO53gUDIGTurx4veRGBVnKjMqx6MACNgSteE=;
        b=W8BgQ9TfSQlgcIOCzFJcIJO/jBBN6VttKit0PGLq9o0ywGigFGnduBvBfyGtrkjfSE
         54T41c7Jkbz1gSmS+2ZyLLBK88PAHglhgBPMY0o6mGgLWnCgUgKWf4d7k+Vx9d6+KD3j
         S8roFT19RwomXPYqy3Ptu8TQCJkVJ9wjPW7kTc30E98t5b2+4n5hPvuHN7XcRUGB49bs
         J9XZqgcz8FAEzzm21ZuKGVcLrYA1MpNSpL6z5iz8VDUngAd8h5a8Sv6IxFli6Ga5JSM2
         JvhH1oztChJ0ltwVPrclo4ffNG9YKUUkWs+a/sapS+Xc8VRZVdXLGlNZrzEyNFP1KR+M
         aK8A==
X-Forwarded-Encrypted: i=1; AFNElJ/TOWVFe8GzMmMagCr8Ocr6PiNiQiGd+EPDFheNT7Qh8ggLx3TUvuDq0q6NtaSPjkg1GBU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0EpoaEBzUm97EFeCydMqH0lxD+zDiKDRcwRTXsbGsOuVxP2JS
	Xk09aeYLWz2KAA+6DG9kZ+oTjCGTqV7Z5ncBj3igXmFudpBcruyq+iNy
X-Gm-Gg: Acq92OFkK1YCOAzB69WBqCb2HrIIEkF6OeC/WcSnVZUOLjTND0Aq1zWd973oJUdzq8V
	EAeKrMZAY82W14RGAw8NdwqwfZCDMPoBfjDz2/W1DUPIcFbh1EHaTH6sACIOEVxydaYIe8b0ml1
	BpiXN83h9Js8VvZjSBC21K9RYfMbAb/8qUijxRJtg6Hn4b35u45Jp8ggm4qI7ILpPEMYBU8/RAL
	pWo/OOLq/hGeHzP/0Q6+gWOoORdcX3T2zmWxyYb4JPpg2Rgvi6SMPg/SYTAdXlItckz/ITLMNza
	+Fr/k+x4YMCkFsTWg4yrJo/ZlG+IUS7dfRS+um1ERpjGGFT1It5ddQcvFm91+rG0bJnIYEVWPuS
	MzDeUZbT22RyJkrG+7l6sxWqu/+xWCiW4n6iHnHEozFZx31kDkLDc8wbf3VmWH6TM5VGGG6N6QJ
	TM8kZmqvxNhXn2uqfl9WdShvw2kwclhzhBcJ9hYZyj/34eZDr73hY2MoWMpOztYMw/ogm0xEg=
X-Received: by 2002:a05:600c:3588:b0:490:4b89:5372 with SMTP id 5b1f17b1804b1-490c2cf5433mr104864815e9.11.1780738245450;
        Sat, 06 Jun 2026 02:30:45 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490c2c9ea37sm197550235e9.0.2026.06.06.02.30.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jun 2026 02:30:45 -0700 (PDT)
Date: Sat, 6 Jun 2026 10:30:43 +0100
From: David Laight <david.laight.linux@gmail.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Sean Christopherson <seanjc@google.com>, Paul Durrant <paul@xen.org>,
 Hyunwoo Kim <imv4bel@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav
 Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/8] KVM: x86/xen: Introduce kvm_xen_has_64bit_shinfo()
 macro
Message-ID: <20260606103043.0d9a4baf@pumpkin>
In-Reply-To: <20260605143034.3603-3-dwmw2@infradead.org>
References: <20260605143034.3603-1-dwmw2@infradead.org>
	<20260605143034.3603-3-dwmw2@infradead.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  5 Jun 2026 15:17:27 +0100
David Woodhouse <dwmw2@infradead.org> wrote:

> From: David Woodhouse <dwmw@amazon.co.uk>
> 
> Add a kvm_xen_has_64bit_shinfo() helper macro to replace the repeated
> pattern of 'IS_ENABLED(CONFIG_64BIT) && kvm->arch.xen.long_mode'
> throughout the Xen emulation code. The macro uses READ_ONCE() to
> ensure a consistent snapshot of the flag, which can be changed by
> another vCPU at any time.

If another vCPU changes the flag then isn't it all broken?
The code seems to need the value to be stable.

-- David

> 
> This is the KVM equivalent of Xen's !has_32bit_shinfo().
> 
> Assisted-by: Kiro:claude-opus-4.6-1m
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> ---
>  arch/x86/kvm/xen.c | 16 ++++++++--------
>  arch/x86/kvm/xen.h |  5 +++++
>  2 files changed, 13 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/x86/kvm/xen.c b/arch/x86/kvm/xen.c
> index a7ab19f38b59..acd3cd87dd2f 100644
> --- a/arch/x86/kvm/xen.c
> +++ b/arch/x86/kvm/xen.c
> @@ -72,7 +72,7 @@ static int kvm_xen_shared_info_init(struct kvm *kvm)
>  	BUILD_BUG_ON(offsetof(struct shared_info, wc) != 0xc00);
>  	BUILD_BUG_ON(offsetof(struct shared_info, wc_sec_hi) != 0xc0c);
>  
> -	if (IS_ENABLED(CONFIG_64BIT) && kvm->arch.xen.long_mode) {
> +	if (kvm_xen_has_64bit_shinfo(kvm)) {
>  		struct shared_info *shinfo = gpc->khva;
>  
>  		wc_sec_hi = &shinfo->wc_sec_hi;
> @@ -390,7 +390,7 @@ static void kvm_xen_update_runstate_guest(struct kvm_vcpu *v, bool atomic)
>  	BUILD_BUG_ON(sizeof_field(struct vcpu_runstate_info, time) !=
>  		     sizeof(vx->runstate_times));
>  
> -	if (IS_ENABLED(CONFIG_64BIT) && v->kvm->arch.xen.long_mode) {
> +	if (kvm_xen_has_64bit_shinfo(v->kvm)) {
>  		user_len = sizeof(struct vcpu_runstate_info);
>  		times_ofs = offsetof(struct vcpu_runstate_info,
>  				     state_entry_time);
> @@ -661,7 +661,7 @@ void kvm_xen_inject_pending_events(struct kvm_vcpu *v)
>  	}
>  
>  	/* Now gpc->khva is a valid kernel address for the vcpu_info */
> -	if (IS_ENABLED(CONFIG_64BIT) && v->kvm->arch.xen.long_mode) {
> +	if (kvm_xen_has_64bit_shinfo(v->kvm)) {
>  		struct vcpu_info *vi = gpc->khva;
>  
>  		asm volatile(LOCK_PREFIX "orq %0, %1\n"
> @@ -978,7 +978,7 @@ int kvm_xen_vcpu_set_attr(struct kvm_vcpu *vcpu, struct kvm_xen_vcpu_attr *data)
>  		 * address, that's actually OK. kvm_xen_update_runstate_guest()
>  		 * will cope.
>  		 */
> -		if (IS_ENABLED(CONFIG_64BIT) && vcpu->kvm->arch.xen.long_mode)
> +		if (kvm_xen_has_64bit_shinfo(vcpu->kvm))
>  			sz = sizeof(struct vcpu_runstate_info);
>  		else
>  			sz = sizeof(struct compat_vcpu_runstate_info);
> @@ -1424,7 +1424,7 @@ static int kvm_xen_hypercall_complete_userspace(struct kvm_vcpu *vcpu)
>  
>  static inline int max_evtchn_port(struct kvm *kvm)
>  {
> -	if (IS_ENABLED(CONFIG_64BIT) && kvm->arch.xen.long_mode)
> +	if (kvm_xen_has_64bit_shinfo(kvm))
>  		return EVTCHN_2L_NR_CHANNELS;
>  	else
>  		return COMPAT_EVTCHN_2L_NR_CHANNELS;
> @@ -1446,7 +1446,7 @@ static bool wait_pending_event(struct kvm_vcpu *vcpu, int nr_ports,
>  		goto out_rcu;
>  
>  	ret = false;
> -	if (IS_ENABLED(CONFIG_64BIT) && kvm->arch.xen.long_mode) {
> +	if (kvm_xen_has_64bit_shinfo(kvm)) {
>  		struct shared_info *shinfo = gpc->khva;
>  		pending_bits = (unsigned long *)&shinfo->evtchn_pending;
>  	} else {
> @@ -1820,7 +1820,7 @@ int kvm_xen_set_evtchn_fast(struct kvm_xen_evtchn *xe, struct kvm *kvm)
>  	if (!kvm_gpc_check(gpc, PAGE_SIZE))
>  		goto out_rcu;
>  
> -	if (IS_ENABLED(CONFIG_64BIT) && kvm->arch.xen.long_mode) {
> +	if (kvm_xen_has_64bit_shinfo(kvm)) {
>  		struct shared_info *shinfo = gpc->khva;
>  		pending_bits = (unsigned long *)&shinfo->evtchn_pending;
>  		mask_bits = (unsigned long *)&shinfo->evtchn_mask;
> @@ -1861,7 +1861,7 @@ int kvm_xen_set_evtchn_fast(struct kvm_xen_evtchn *xe, struct kvm *kvm)
>  			goto out_rcu;
>  		}
>  
> -		if (IS_ENABLED(CONFIG_64BIT) && kvm->arch.xen.long_mode) {
> +		if (kvm_xen_has_64bit_shinfo(kvm)) {
>  			struct vcpu_info *vcpu_info = gpc->khva;
>  			if (!test_and_set_bit(port_word_bit, &vcpu_info->evtchn_pending_sel)) {
>  				WRITE_ONCE(vcpu_info->evtchn_upcall_pending, 1);
> diff --git a/arch/x86/kvm/xen.h b/arch/x86/kvm/xen.h
> index 59e6128a7bd3..3e8c9306eb89 100644
> --- a/arch/x86/kvm/xen.h
> +++ b/arch/x86/kvm/xen.h
> @@ -248,6 +248,11 @@ struct compat_shared_info {
>  #define COMPAT_EVTCHN_2L_NR_CHANNELS (8 *				\
>  				      sizeof_field(struct compat_shared_info, \
>  						   evtchn_pending))
> +
> +/* Latched VM-wide mode; the KVM equivalent of Xen's !has_32bit_shinfo(). */
> +#define kvm_xen_has_64bit_shinfo(kvm) \
> +	(IS_ENABLED(CONFIG_64BIT) && READ_ONCE((kvm)->arch.xen.long_mode))
> +
>  struct compat_vcpu_runstate_info {
>      int state;
>      uint64_t state_entry_time;

