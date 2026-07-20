Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36E602D7393
	for <kvm@vger.kernel.org>; Mon, 20 Jul 2026 22:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784585862; cv=none; b=oxHd++uYKyqTp4vYuLDh9v7+OiOZ+2ZcMTiPQmsgPNZJ2r8wLthB0/P6hYRPw4gnMI3mk3sZY9TtMzw7/4FGgXDG6CkfE1YlNCMZMWdxLXBUW70FbvXPPmxSk/4mo3vzeUR7B8PG7mqrO+yBxM0tI+H81yAbwqUW2CrSRwN6G68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784585862; c=relaxed/simple;
	bh=3gVm6sLnIGS7I7TkY6TUWvlDcMMMhqT3wlmbOt0rOhE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UgniMI1VajSbLsKqpjAacJa6IrwocJK0358/J8DgyHttGut2wi2oh3Z7Ghp8IhpC182jfqEZ0JuKwaEm1mcRamjQ1ojR+8lnlnEo6mTvV8z2j17g1pVNsTcFfY95LOIobyoO+oFtkwfdq1rhTNGi/TECqDa200cGFEWnA6A/RBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=H5WZ/+Tj; arc=none smtp.client-ip=209.85.214.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H5WZ/+Tj"
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2cae455cf6dso150952425ad.2
        for <kvm@vger.kernel.org>; Mon, 20 Jul 2026 15:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784585860; x=1785190660; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Xat+SlpNKohDOGZp2KP8RF414SFOXwNv7F7LXoh0fQE=;
        b=H5WZ/+TjPHhcVGn0M/OVmW95f8GiGJCAmurDliYI2gbVbJ8321M2a+WMeBtu4HodsO
         phd6GsueTZQ87aksmSnEpfLyqeDTYpDYM9f+I2wS0aUWE+Hd4vf+RA2QJZFlOjZBJE65
         +sGiXSqKp3d5UwsI2FHOy2hKWW3feOIIJSb5SkVJYquGNBzaJeVJOU8rTwmxd9r7YWaV
         u+hN1MkJkAwKLhO035SjXb5ohvS+SBLOi7uxvcNc2zRA+W8jqUDsFgz3lbPja/WXxtGz
         o3/H0jQsaher5ESUPgfWj9EHWYmVrnbd+zGxTJOFUZgkd2Ee0+6e+pGXPDh//LorsenT
         fR1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784585860; x=1785190660;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Xat+SlpNKohDOGZp2KP8RF414SFOXwNv7F7LXoh0fQE=;
        b=QSau294opaZGmojF+gfcw+wa6bV2TlHh7/j2u9HhdCyClwlWoXb4QaccAv0HArRStO
         VRoocRDnLzt5BU/vwW/qatCiVG3sHdpcj14xQrAudEAzj+BmF733c3dMDvft3u4OGcTd
         gZcxY/9MUCHAHWPdbNlzxuAEX20NJmd8KTi/0samDDaT+YcUFBWmPbKa1goXREF3r2C2
         oIiw7Q7we9xPStsgcXJMW0lma6oxvxolKLlLm7eU0/L4fFUK3nT6CgPlilx8PwFmbC/J
         lAOWk704QFM+2UQwR8YzqKByD46Uvli3WNoMLVZ+uTSaDRpWrb43tJApq7KimkscwVkY
         BiVg==
X-Forwarded-Encrypted: i=1; AHgh+Rp85GgdBLTwACmHl+XR4mlhsQrtYghc7tOb/pojntwSHbOcM5ewvFkW+apMQ+c1QWJE8Ts=@vger.kernel.org
X-Gm-Message-State: AOJu0YzF5fnEu6o69e7FFWYTUvPhy4aPn8PjPnd2w0uhYCuCh1D8XKrg
	AtMl6nCgeKpDI2A3gDxGZSb3N2j9m2x0XSBp7g73JaKTqV/D1Wj4Q2LZxzhcssYWxB7Ix7MkJHg
	NuwSofw==
X-Received: from plbmb5.prod.google.com ([2002:a17:903:985:b0:2cc:824d:e4fb])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d2cb:b0:2c9:feea:4e4c
 with SMTP id d9443c01a7336-2cf34887d67mr162560885ad.15.1784585860280; Mon, 20
 Jul 2026 15:17:40 -0700 (PDT)
Date: Mon, 20 Jul 2026 15:17:39 -0700
In-Reply-To: <af8fc5537970157b693a9bcdf134e14b29b1f1ff.camel@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260716160801.3155582-1-dmaluka@chromium.org>
 <792366b7d918faca3f40bccab56bab965e7e34f5.camel@intel.com>
 <alpWONLi8h2T5WhZ@google.com> <af8fc5537970157b693a9bcdf134e14b29b1f1ff.camel@intel.com>
Message-ID: <al6eg7C-2sDBEAFD@google.com>
Subject: Re: [PATCH] KVM: VMX: Postpone IPIv setup after successful vCPU creation
From: Sean Christopherson <seanjc@google.com>
To: Kai Huang <kai.huang@intel.com>
Cc: "dmaluka@chromium.org" <dmaluka@chromium.org>, 
	"aashish@aashishsharma.net" <aashish@aashishsharma.net>, Chao Gao <chao.gao@intel.com>, 
	"guang.zeng@intel.com" <guang.zeng@intel.com>, "jaszczyk@chromium.org" <jaszczyk@chromium.org>, 
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, 
	"vineeth@bitbyteword.org" <vineeth@bitbyteword.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"pbonzini@redhat.com" <pbonzini@redhat.com>, Chuanxiao Dong <chuanxiao.dong@intel.com>
Content-Type: text/plain; charset="us-ascii"

On Fri, Jul 17, 2026, Kai Huang wrote:
> On Fri, 2026-07-17 at 18:20 +0200, Dmytro Maluka wrote:
> > On Fri, Jul 17, 2026 at 12:59:38PM +0000, Huang, Kai wrote:
> > > > 
> > > > An easy fix would be to clear the pid_table entry in vmx_vcpu_free().
> > > > However that would be still problematic, for the following reason:
> > > > userspace may try to create a vCPU with the same vcpu_id as an existing
> > > > one; vmx_vcpu_create() will succeed, and only after that
> > > > kvm_vm_ioctl_create_vcpu() will check for the duplicate vcpu_id and
> > > > fail with -EEXIST and then free the vCPU in the failure path. So in this
> > > > failure path, vmx_vcpu_free() would clear the pid_table entry for that
> > > > already existing good vCPU, i.e. effectively disable IPIv for that vCPU.
> > > 
> > > IMHO this seems a bit fragile?  If something similar to pid_table coming up in
> > > the future, we could end up with a similar problem.
> > > 
> > > The "duplicated vcpu_id check" seems the ones that should happen as early as
> > > possible.  Is it better to move the "duplicated vcpu_id check" earlier before
> > > vmx_vcpu_create(), e.g., even before the kvm_arch_vcpu_precreate()?  In this
> > > case we can do the pid_table cleanup in vmx_vcpu_free() I think.
> > 
> > Unfortunately it is not that simple. As I understand, the reason why the
> > "duplicated vcpu_id check" is done later is that it needs to be done
> > atomically together with inserting the vCPU into kvm->vcpu_array after
> > it, i.e. both the check and the insertion need to be done with kvm->lock
> > held (rather than releasing kvm->lock and taking it again between the
> > two operations).
> > 
> > IOW, if we just move the "duplicated vcpu_id check" earlier (before the
> > first unlock of kvm->lock), we have a race:
> > 
> > 1. vCPU A is being created but not installed in kvm->vcpu_array yet.
> > 2. vCPU B with the same vcpu_id is being created. It passes the
> >    duplicated vcpu_id check, since the check doesn't find vCPU A in
> >    kvm->vcpu_array.
> > 3. vCPU A is installed in kvm->vcpu_array, vCPU creation succeeds.
> > 4. vCPU B with the same vcpu_id is installed in kvm->vcpu_array, vCPU
> >    creation succeeds.
> > 
> > And we cannot just move the kvm->vcpu_array insertion earlier (before
> > the first unlock of kvm->lock), at least because the vCPU is not even
> > allocated at that point.
> 
> Hmm right, and AFACIT vCPU A needs to actually bump up the kvm->online_vcpus in
> order for the vCPU B to detect the vCPU of same vcpu_id has been created because
> kvm_get_vcpu_by_id() will only scan online vCPUs.
> 
> Thanks for pointing out!
> 
> > I guess we could track the used vcpu_ids separately in another xarray
> > (or a bitmap) which could be checked and updated by the early
> > "duplicated vcpu_id check" before the first unlock of kvm->lock. But do
> > we want to pay the memory price for that?

I'm comfortable paying the cost for a bitmap.  If a system can actually support
thousands of vCPU IDs, then burning a few hundred bytes per VM is all but
guaranteed to be a non-issue.  And for smaller systems, e.g. on arm64 where a
VM can have at most 512 vCPU IDs, the bitmap costs a measely 64 bytes.

And if the wastefulness of a persistent bitmap is a concern, we could easly use
an xarray to track only "pending" vCPUs, so that the steady state cost is ~zero.
Actually, given how easy that is (famous last words), unless removing from an
xarray doesn't free memory soon-ish, I'd say go straight to a semi-permanent
xarray to avoid bikeshedding over the cost of the bitmap.

> I don't think we should do that, and your approach is much safer:

I disagree.  I actually arrived at the bitmap solution before reading this.  My
concern isn't so much about IPI virtualization, it's about the lurking danger of
an unverified vcpu_id.  E.g. see Naveen's suggestion in this thread of simply
letting vcpu_load() initialize the per-VM table, which doesn't work because x86
calls vcpu_load() as part of vCPU creation.  I wouldn't be all that surprised if
there's another bug or two in KVM where colliding 

Ha!  Case in point, s390 had what is effectively the *exact* same bug and fixed
it in the *exact* same way (hooking vcpu_postcreate()) over a decade ago in
commit 255088244929 ("KVM: s390: fix SCA related races and double use"), and that
obviously did nothing to help x86 from repeating the same mistake.

In other words, I want to fix this entire class of bugs, not play a game of
whack-a-mole with bugs that humans are all but guaranteed to overlook.

My other concern with the proposed change is that the vCPU becomes reachable
before long before kvm_arch_vcpu_postcreate().  Which should be fine" for IPI
virtualization, but sets a precedence I'd rather not exist, because initializing
vCPU state _after_ it's reachable is rarely correct.  E.g. msr_kvm_poll_control
is initialized in postcreate for some reason, and that's technically buggy
because it's possible, albeit extremely unlikely, that MSR_KVM_POLL_CONTROL could
be written by userspace before postcreate() runs.

E.g. for the xarray approacy (sketch only, completely untested):

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index fdbd697d0337..e34ca5920393 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -791,6 +791,7 @@ struct kvm {
        /* The current active memslot set for each address space */
        struct kvm_memslots __rcu *memslots[KVM_MAX_NR_ADDRESS_SPACES];
        struct xarray vcpu_array;
+       struct xarray pending_vcpu_ids;
        /*
         * Protected by slots_lock, but can be read outside if an
         * incorrect answer is acceptable.
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 2df8ee9ecf6c..8bc4f7ffd76d 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -4179,6 +4179,12 @@ static int kvm_vm_ioctl_create_vcpu(struct kvm *kvm, unsigned long id)
                return r;
        }
 
+       r = xa_insert(&kvm->pending_vcpu_ids, id, xa_mk_value(id), GFP_KERNEL);
+       if (r) {
+               mutex_unlock(&kvm->lock);
+               return r;
+       }
+
        kvm->created_vcpus++;
        mutex_unlock(&kvm->lock);
 
@@ -4249,6 +4255,7 @@ static int kvm_vm_ioctl_create_vcpu(struct kvm *kvm, unsigned long id)
         */
        smp_wmb();
        atomic_inc(&kvm->online_vcpus);
+       xa_erase(&kvm->pending_vcpu_ids, id);
        mutex_unlock(&vcpu->mutex);
 
        mutex_unlock(&kvm->lock);
@@ -4273,6 +4280,7 @@ static int kvm_vm_ioctl_create_vcpu(struct kvm *kvm, unsigned long id)
 vcpu_decrement:
        mutex_lock(&kvm->lock);
        kvm->created_vcpus--;
+       xa_erase(&kvm->pending_vcpu_ids, id);
        mutex_unlock(&kvm->lock);
        return r;
 }


or if that doesn't work, the more naive bitmap approach:

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index fdbd697d0337..eadde580e27f 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -791,6 +791,8 @@ struct kvm {
        /* The current active memslot set for each address space */
        struct kvm_memslots __rcu *memslots[KVM_MAX_NR_ADDRESS_SPACES];
        struct xarray vcpu_array;
+       DECLARE_BITMAP(vcpu_ids, KVM_MAX_VCPU_IDS);
+
        /*
         * Protected by slots_lock, but can be read outside if an
         * incorrect answer is acceptable.
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 2df8ee9ecf6c..c735698e76cf 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -4179,6 +4179,11 @@ static int kvm_vm_ioctl_create_vcpu(struct kvm *kvm, unsigned long id)
                return r;
        }
 
+       if (__test_and_set_bit(id, kvm->vcpu_ids)) {
+               mutex_unlock(&kvm->lock);
+               return -EEXIST;
+       }
+
        kvm->created_vcpus++;
        mutex_unlock(&kvm->lock);
 
@@ -4213,7 +4218,7 @@ static int kvm_vm_ioctl_create_vcpu(struct kvm *kvm, unsigned long id)
 
        mutex_lock(&kvm->lock);
 
-       if (kvm_get_vcpu_by_id(kvm, id)) {
+       if (WARN_ON_ONCE(kvm_get_vcpu_by_id(kvm, id))) {
                r = -EEXIST;
                goto unlock_vcpu_destroy;
        }
@@ -4273,6 +4278,7 @@ static int kvm_vm_ioctl_create_vcpu(struct kvm *kvm, unsigned long id)
 vcpu_decrement:
        mutex_lock(&kvm->lock);
        kvm->created_vcpus--;
+       __clear_bit(id, kvm->vcpu_ids);
        mutex_unlock(&kvm->lock);
        return r;
 }
