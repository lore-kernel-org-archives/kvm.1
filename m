Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D21C43F4C4
	for <kvm@vger.kernel.org>; Tue, 21 Jul 2026 09:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784625986; cv=none; b=RRirMXwbKlTK3kqCdy48643ei/cex09Tr34Rn3EzEqBzzgBFTxCzWtvyc8bxaI0uYVLfOwZAHkLV2b+K9H9enu+cUz0LsztRns4yKxhY5rwzW0ejGvoddtvmSwxeB1NZH1ajd3pEhYRLgg4A9iNTFEWpsjhtZFPtxfS9AOQHV0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784625986; c=relaxed/simple;
	bh=D2LPDU1mKCm/ShzKI4g5/fm/HCjB61bHMEM/m9KzM6k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EoU0KX/KQwdfYyRwYwV743fcSDM/0BvVhpKn1QA9sIlsCRoL4UwxOUdk6trrIIqqI/iZ/S1K8vKphD37XyBqHGu9NxuivEaLctPqUXfPDi+7M9ZQg3AJi8Jgb+699nK/areEyUTYi/cODjooREZ/Q+d0ipPnsjxNT6yLfKgZKRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Z1QXL4mU; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Z1QXL4mU"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-47f785467faso1274301f8f.2
        for <kvm@vger.kernel.org>; Tue, 21 Jul 2026 02:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1784625982; x=1785230782; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Ze/Y0aIte68XGw/Ra4pjOMdADxK9RihVh1QhdPFs/VM=;
        b=Z1QXL4mUf3Qwjh3nGuh/K7oq8O3Yyh5xOB7HanEjjk1CCPCfKCqdgFRZEIdBoff7OL
         dNdQjlTkJs0kSmyHIt43ttPQ5XzO5Ux0Dmaa7I3Rq8iqIEI0lZrv7WJTrtkCygl4npnX
         t2S+noelHOK4qs7irJpyDm6XIUunIxnCd4RQI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784625982; x=1785230782;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ze/Y0aIte68XGw/Ra4pjOMdADxK9RihVh1QhdPFs/VM=;
        b=il20B9GxfJaIX9e9qM5nt8bYd0yp4itfPnklRyg3aJTo1Ta8/MzEkIzlcNcqicUcXU
         7jXiLe63J5zRvuwN+kqS8iGWTng0hH7+0YMONnPX/10Oji0jAQ7vNbjO2ldooGOOP1mt
         EyrshbF62kGoz53xIyJ+8NOsHRPI4JkjMiV3oJz/Cg3Dqxy8nnbUpcZZpz/6cppfVCDY
         DYsjs+xNAhHzUdTRlC681IWfvVpxJKSE2e/xrIs3rV05EWaNJQvVbhUmACNbSCTOi2kT
         80y7f950Wn3mFU8x/Q/maXCBNlhftmtt0hxfnpL8QRRVTFVZClaNF1AkZ2XDRbOdPcSy
         0DxQ==
X-Forwarded-Encrypted: i=1; AHgh+RrIRbr06yH3c6pEajGt2nxREOb9wZ6xtYcY8xYLzoXSxsEKagIYSJnE+hj4xqNc6V/uSiw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6wlV1ejs6Ldi1x0Zrx1aZuaYV+vFqz7y3p4mSZ7ctUZB5oPy+
	F7dAlUoyUcM2dcZArwv/1y/tpcdK7FHS0qIUIy00buZRMTHN7wslDT0fZzDuUdSWcA==
X-Gm-Gg: AR+sD11nTl9V015wiDq7UoDA/3BQGY5Z1GCxrW2BTb832QeP37XfbZ5CvNeru4DhWoM
	ED8az/LTgkA2csb968r7OPqN+KXa+8BorZtPppJ2iAWAeboHKnudZTXel1fo+1IK8RFNl+lxPgQ
	l/BxTP2S2C8iCKlLK7kjuJlS2QzZ/k4xwOzHuqsXSmWc6iLgB8KUirtYmV/eVT6VlaPwPnNSUvS
	Mt5PXyEJIjfxXPis+mCg/MKpTahiRy7lTkqWRzjmOcJ2M/Ppci2qQevcbOcnxSQ1QicaS7/gbNk
	DPet/Yhhr7ZNIxXH7Pt1m5hA/KxNJZSZctkxSAYlQNDKQEm1VMh7+CIWJF9gOIixx9n3Lv4k65n
	GuFIqR4kt4lafGDH6VmqoAw9OYcnEz78hL9oWorjWQ73MaId88YRikrKGhMuxxEkjgx3QWs7J41
	7jlAzV
X-Received: by 2002:a05:6000:40cf:b0:472:d154:fac6 with SMTP id ffacd0b85a97d-47f62328243mr21672654f8f.35.1784625982279;
        Tue, 21 Jul 2026 02:26:22 -0700 (PDT)
Received: from google.com ([2a02:a31b:20c3:6680:b1b:fba2:d699:8d6b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f63eea8afsm39266157f8f.33.2026.07.21.02.26.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 02:26:21 -0700 (PDT)
Date: Tue, 21 Jul 2026 11:26:14 +0200
From: Dmytro Maluka <dmaluka@chromium.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Kai Huang <kai.huang@intel.com>,
	"aashish@aashishsharma.net" <aashish@aashishsharma.net>,
	Chao Gao <chao.gao@intel.com>,
	"guang.zeng@intel.com" <guang.zeng@intel.com>,
	"jaszczyk@chromium.org" <jaszczyk@chromium.org>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"vineeth@bitbyteword.org" <vineeth@bitbyteword.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>,
	Chuanxiao Dong <chuanxiao.dong@intel.com>
Subject: Re: [PATCH] KVM: VMX: Postpone IPIv setup after successful vCPU
 creation
Message-ID: <al87Nh8fde9iAuXy@google.com>
References: <20260716160801.3155582-1-dmaluka@chromium.org>
 <792366b7d918faca3f40bccab56bab965e7e34f5.camel@intel.com>
 <alpWONLi8h2T5WhZ@google.com>
 <af8fc5537970157b693a9bcdf134e14b29b1f1ff.camel@intel.com>
 <al6eg7C-2sDBEAFD@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <al6eg7C-2sDBEAFD@google.com>

On Mon, Jul 20, 2026 at 03:17:39PM -0700, Sean Christopherson wrote:
> On Fri, Jul 17, 2026, Kai Huang wrote:
> > On Fri, 2026-07-17 at 18:20 +0200, Dmytro Maluka wrote:
> > > I guess we could track the used vcpu_ids separately in another xarray
> > > (or a bitmap) which could be checked and updated by the early
> > > "duplicated vcpu_id check" before the first unlock of kvm->lock. But do
> > > we want to pay the memory price for that?
> 
> I'm comfortable paying the cost for a bitmap.  If a system can actually support
> thousands of vCPU IDs, then burning a few hundred bytes per VM is all but
> guaranteed to be a non-issue.  And for smaller systems, e.g. on arm64 where a
> VM can have at most 512 vCPU IDs, the bitmap costs a measely 64 bytes.

I was just a bit concerned that, for example, on my laptop, even though
there is only a dozen of physical CPUs, there is still
CONFIG_KVM_MAX_NR_VCPUS=4096 in my Debian's default kernel config, and
KVM_VCPU_ID_RATIO is still hardcoded to 4, so the bitmap size would be
4096 * 4 / 8 = 2KB which just feels "disproportionate" for such a corner
case as this sanity check.

But yeah, that doesn't seem to be a real problem (it's not like we
routinely run thousands of VMs on such systems).

> And if the wastefulness of a persistent bitmap is a concern, we could easly use
> an xarray to track only "pending" vCPUs, so that the steady state cost is ~zero.
> Actually, given how easy that is (famous last words), unless removing from an
> xarray doesn't free memory soon-ish, I'd say go straight to a semi-permanent
> xarray to avoid bikeshedding over the cost of the bitmap.

After some thinking, I think I prefer the bitmap. The pending_vcpu_ids
xarray feels like a premature optimization.

> > I don't think we should do that, and your approach is much safer:
> 
> I disagree.  I actually arrived at the bitmap solution before reading this.  My
> concern isn't so much about IPI virtualization, it's about the lurking danger of
> an unverified vcpu_id.  E.g. see Naveen's suggestion in this thread of simply
> letting vcpu_load() initialize the per-VM table, which doesn't work because x86
> calls vcpu_load() as part of vCPU creation.  I wouldn't be all that surprised if
> there's another bug or two in KVM where colliding 
> 
> Ha!  Case in point, s390 had what is effectively the *exact* same bug and fixed
> it in the *exact* same way (hooking vcpu_postcreate()) over a decade ago in
> commit 255088244929 ("KVM: s390: fix SCA related races and double use"), and that
> obviously did nothing to help x86 from repeating the same mistake.
> 
> In other words, I want to fix this entire class of bugs, not play a game of
> whack-a-mole with bugs that humans are all but guaranteed to overlook.
> 
> My other concern with the proposed change is that the vCPU becomes reachable
> before long before kvm_arch_vcpu_postcreate().  Which should be fine" for IPI
> virtualization, but sets a precedence I'd rather not exist, because initializing
> vCPU state _after_ it's reachable is rarely correct.  E.g. msr_kvm_poll_control
> is initialized in postcreate for some reason, and that's technically buggy
> because it's possible, albeit extremely unlikely, that MSR_KVM_POLL_CONTROL could
> be written by userspace before postcreate() runs.

Yeah, agree on both points. I myself was a bit uncomfortable with my
vcpu_postcreate approach implying some unwritten ill-defined rules on
what things _must_ be done in vcpu_postcreate (rather than in
vcpu_create) and what things _must not_ be done in it.

> E.g. for the xarray approacy (sketch only, completely untested):
> 
> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index fdbd697d0337..e34ca5920393 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -791,6 +791,7 @@ struct kvm {
>         /* The current active memslot set for each address space */
>         struct kvm_memslots __rcu *memslots[KVM_MAX_NR_ADDRESS_SPACES];
>         struct xarray vcpu_array;
> +       struct xarray pending_vcpu_ids;
>         /*
>          * Protected by slots_lock, but can be read outside if an
>          * incorrect answer is acceptable.
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 2df8ee9ecf6c..8bc4f7ffd76d 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -4179,6 +4179,12 @@ static int kvm_vm_ioctl_create_vcpu(struct kvm *kvm, unsigned long id)
>                 return r;
>         }
>  
> +       r = xa_insert(&kvm->pending_vcpu_ids, id, xa_mk_value(id), GFP_KERNEL);
> +       if (r) {
> +               mutex_unlock(&kvm->lock);
> +               return r;
> +       }
> +
>         kvm->created_vcpus++;
>         mutex_unlock(&kvm->lock);
>  
> @@ -4249,6 +4255,7 @@ static int kvm_vm_ioctl_create_vcpu(struct kvm *kvm, unsigned long id)
>          */
>         smp_wmb();
>         atomic_inc(&kvm->online_vcpus);
> +       xa_erase(&kvm->pending_vcpu_ids, id);
>         mutex_unlock(&vcpu->mutex);
>  
>         mutex_unlock(&kvm->lock);
> @@ -4273,6 +4280,7 @@ static int kvm_vm_ioctl_create_vcpu(struct kvm *kvm, unsigned long id)
>  vcpu_decrement:
>         mutex_lock(&kvm->lock);
>         kvm->created_vcpus--;
> +       xa_erase(&kvm->pending_vcpu_ids, id);
>         mutex_unlock(&kvm->lock);
>         return r;
>  }
> 
> 
> or if that doesn't work, the more naive bitmap approach:
> 
> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index fdbd697d0337..eadde580e27f 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -791,6 +791,8 @@ struct kvm {
>         /* The current active memslot set for each address space */
>         struct kvm_memslots __rcu *memslots[KVM_MAX_NR_ADDRESS_SPACES];
>         struct xarray vcpu_array;
> +       DECLARE_BITMAP(vcpu_ids, KVM_MAX_VCPU_IDS);
> +
>         /*
>          * Protected by slots_lock, but can be read outside if an
>          * incorrect answer is acceptable.
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 2df8ee9ecf6c..c735698e76cf 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -4179,6 +4179,11 @@ static int kvm_vm_ioctl_create_vcpu(struct kvm *kvm, unsigned long id)
>                 return r;
>         }
>  
> +       if (__test_and_set_bit(id, kvm->vcpu_ids)) {
> +               mutex_unlock(&kvm->lock);
> +               return -EEXIST;
> +       }
> +
>         kvm->created_vcpus++;
>         mutex_unlock(&kvm->lock);
>  
> @@ -4213,7 +4218,7 @@ static int kvm_vm_ioctl_create_vcpu(struct kvm *kvm, unsigned long id)
>  
>         mutex_lock(&kvm->lock);
>  
> -       if (kvm_get_vcpu_by_id(kvm, id)) {
> +       if (WARN_ON_ONCE(kvm_get_vcpu_by_id(kvm, id))) {
>                 r = -EEXIST;
>                 goto unlock_vcpu_destroy;
>         }
> @@ -4273,6 +4278,7 @@ static int kvm_vm_ioctl_create_vcpu(struct kvm *kvm, unsigned long id)
>  vcpu_decrement:
>         mutex_lock(&kvm->lock);
>         kvm->created_vcpus--;
> +       __clear_bit(id, kvm->vcpu_ids);
>         mutex_unlock(&kvm->lock);
>         return r;
>  }
