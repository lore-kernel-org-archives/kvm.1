Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3FD41850A4
	for <kvm@vger.kernel.org>; Fri, 13 Mar 2026 00:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773361067; cv=none; b=aCVrgE5vRR/4otxDBr1MsFKatSK39CamV/Otxqfd3o7zed24zzN4eiYyDRTEMVXVx/ubqxVk5IPHstz1TvGl8S7TT93SM8xh7PMonljpFs/1c3RKQwfqIWMmljpGCg1M70Qs5vvacZ2/fA0g4g1fBcunXKaoEgl9EkRdKH0eICY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773361067; c=relaxed/simple;
	bh=KEIt7frDiYeU/yLW09U9cGpLUB/6cv+r8QCRBeIAezI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=I1Q4M7IgjhGZcKamwQqGgbgiTYXxw2F9PvibvHTsBpRfd2KXnXyXC+TosdgW08jLQlUfv6X+62uz7FY80oqy9JfOuohRky2H6Tk7cUFw3W6oU44fWI1clf/DNHYH99qxax4HX5S1VHK0ENWAqG3rZ4C3Ao3ctXdppOvJf1sqpEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Uti7dgtR; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Uti7dgtR"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-3598c05c806so1629188a91.0
        for <kvm@vger.kernel.org>; Thu, 12 Mar 2026 17:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773361066; x=1773965866; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=TokJZEWc5EP9WFvVwHbSHjwWCT061WWazNfutKot6bg=;
        b=Uti7dgtRB+eZsl1iAZJ4Vf2OhKf/RunGZTuDGpgbBUsE8lNoDnqvYO9eV/1CLMAd06
         lb1u8xzbzsv6QEkQUIrcoFAbb9L5+yjFXibKUNpZaf2bTs8t9ce0/eVjwTQBRTQDAKB6
         qOsfAWu24tklHf3wtkVCLc7W0jhRg5Y0FDie7xRwhlFDt5kDTOaaDCQmlkVOqU4SwnQh
         U1JTCgHsE4F+Hi8IgiNgwbMHOTHYGPMNpLTOlF9ZrFRBd/Wyug8x7wERdwu+lnOyz4mp
         HlWPrj1pU2eiPrPAV7HMhjIKKXFH/1kYIl/+FoNgZX7Y7K4bJ7wfr5Eojl9Lu8dYfgSO
         ZxUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773361066; x=1773965866;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TokJZEWc5EP9WFvVwHbSHjwWCT061WWazNfutKot6bg=;
        b=LepdWfJGY7gw9kXKGrEvwWrh/cTDB2UMX0pY9WU6eoJe1V++2WJEYhXBZBqmg3JJkF
         GZ80ls4B8cxLI4ljRftHQsmWfIYDzV/P9RY40TiRTntkC6J9I5c7yU3VF125zT2eDxjY
         ngbpVk8huGcBPAML9bPZ89GRwWn12Qhik6FMtZcfHArGaYi53WhnbrAGQ0HL/68WMOcW
         C+UZjIxT+9XXMn8uipJnC67LVmgk009DdHmfoY/gBZX2CHIalrP/x6MiUDANhd1cDz0d
         npjGMWCPVE1oTGv0pk1e3MZ10mAasvmvYopWXEn2X3zaqsApcpBz6JWwCaMSWjE9sCiP
         2SLg==
X-Forwarded-Encrypted: i=1; AJvYcCXD1WsQJl/eGsikdDVx4iykZ82s2sm25ODdAr3i43cLWVUayQEvULf8jA/J4zgvDi9TFFk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw20BQ+uorP2dQBTpFaRbgmR8TVnDUGGq4mUi2FbckDo1YxHkpY
	v7VNDdorM+8bM9uo3xmK67kqJdijMsTevq4zy+xGxCr8wqXjmdOm8jeB/hWkXgPUkFL/XGNsCLe
	S1Bptvg==
X-Received: from pjbiq4.prod.google.com ([2002:a17:90a:fb44:b0:359:92db:6c34])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4e86:b0:359:7b9a:2cec
 with SMTP id 98e67ed59e1d1-35a21c808f9mr1135410a91.0.1773361065987; Thu, 12
 Mar 2026 17:17:45 -0700 (PDT)
Date: Thu, 12 Mar 2026 17:17:44 -0700
In-Reply-To: <c73bc1f22fbdbd88efb21cb80eccdd98d2ea531a.camel@infradead.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <c73bc1f22fbdbd88efb21cb80eccdd98d2ea531a.camel@infradead.org>
Message-ID: <abNXqMq3wx9Yq94h@google.com>
Subject: Re: [PATCH v2] KVM: x86: Use gfn_to_pfn_cache for record_steal_time
From: Sean Christopherson <seanjc@google.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Carsten Stollmaier <stollmc@amazon.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

With some assistance from an AI review bot (well, more than "some").

On Wed, Mar 11, 2026, David Woodhouse wrote:
> @@ -3806,39 +3788,32 @@ static void record_steal_time(struct kvm_vcpu *vcpu)
>  				       st_preempted & KVM_VCPU_FLUSH_TLB);
>  		if (st_preempted & KVM_VCPU_FLUSH_TLB)
>  			kvm_vcpu_flush_tlb_guest(vcpu);
> -
> -		if (!user_access_begin(st, sizeof(*st)))
> -			goto dirty;
>  	} else {
> -		if (!user_access_begin(st, sizeof(*st)))
> -			return;
> -
> -		unsafe_put_user(0, &st->preempted, out);
> +		st->preempted = 0;

These should all be WRITE_ONCE(), correct?

>  		vcpu->arch.st.preempted = 0;
>  	}
>  
> -	unsafe_get_user(version, &st->version, out);
> +	version = st->version;

And then READ_ONCE()?

>  	if (version & 1)
>  		version += 1;  /* first time write, random junk */
>  
>  	version += 1;
> -	unsafe_put_user(version, &st->version, out);
> +	st->version = version;
>  
>  	smp_wmb();
>  
> -	unsafe_get_user(steal, &st->steal, out);
> +	steal = st->steal;
>  	steal += current->sched_info.run_delay -
>  		vcpu->arch.st.last_steal;
>  	vcpu->arch.st.last_steal = current->sched_info.run_delay;
> -	unsafe_put_user(steal, &st->steal, out);
> +	st->steal = steal;
>  
>  	version += 1;
> -	unsafe_put_user(version, &st->version, out);
> +	st->version = version;

And then here, doesn't there need to be an smp_wmb() before incrementing the
version again?  Because I believe making this all vanilla C means the compiler
can reorder those two.  Per the friendly bot:

  The previous code used unsafe_put_user(), which inherently acts as a
  compiler barrier due to its internal inline assembly

> +
> +	kvm_gpc_mark_dirty_in_slot(gpc);
>  
> - out:
> -	user_access_end();
> - dirty:
> -	mark_page_dirty_in_slot(vcpu->kvm, ghc->memslot, gpa_to_gfn(ghc->gpa));
> +	read_unlock(&gpc->lock);
>  }
>  
>  /*
> @@ -4173,8 +4148,12 @@ int kvm_set_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>  
>  		vcpu->arch.st.msr_val = data;
>  
> -		if (!(data & KVM_MSR_ENABLED))
> -			break;
> +		if (data & KVM_MSR_ENABLED) {

Curly braces aren't required.

> +			kvm_gpc_activate(&vcpu->arch.st.cache, data & ~KVM_MSR_ENABLED,
> +					sizeof(struct kvm_steal_time));
> +		} else {
> +			kvm_gpc_deactivate(&vcpu->arch.st.cache);
> +		}

...

> @@ -5266,20 +5244,28 @@ static void kvm_steal_time_set_preempted(struct kvm_vcpu *vcpu)
>  	if (unlikely(current->mm != vcpu->kvm->mm))
>  		return;
>  
> -	slots = kvm_memslots(vcpu->kvm);
> -
> -	if (unlikely(slots->generation != ghc->generation ||
> -		     gpa != ghc->gpa ||
> -		     kvm_is_error_hva(ghc->hva) || !ghc->memslot))
> -		return;
> +	read_lock_irqsave(&gpc->lock, flags);

I'm pretty sure this is going to make PROVE_LOCKING unhappy due to PREEMPT_RT
making rwlock_t sleepable (when called from kvm_sched_out()).  I've been content
to ignore the kvm_xen_set_evtchn_fast() warning[*] because I can't imagine anyone
is crazy enough to emulate Xen with an RT kernel, but I do know there are RT users
that run VMs, and so this path would be more than just a PROVE_LOCKING issue.

If we want to push the gpc stuff broadly, we need a solution to that (though I'm
still not 100% convinced using a gpc here is a net positive).

[*] https://lore.kernel.org/all/673f4bbc.050a0220.3c9d61.0174.GAE@google.com
