Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 921BF1A285
	for <kvm@vger.kernel.org>; Wed,  8 Apr 2026 18:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775673774; cv=none; b=iCSh1+Ta5fYRp30PgLUER+eSdYkWlJ0iJjyz1C/XuqbI4N0fsdmM6R5KfeLaRPITemum3eSqBJxsUHSLCoW1D9XjDgRO6obpA4FzfnUNOE9v0qE3Hp4XBnM6QDDk+5I2GUA67mM1G7HKERr4uFbmpbXZcUiWEAtq0NgfWWnOJ8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775673774; c=relaxed/simple;
	bh=jx7AcgbvCU056YRKgIHGpeR0qsbQUXRmXso8TPkM0uY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XIoSK0tphffUEjS7L/475qb6Rc3MBnn05VIL7a7TbFi/TNazLikjy8t/WjOHe3dO6x8qhOLRYdFcuH1GJzcwHRvh8uWhg4Ctqr0L4jxWxeUpMsPoPILBu19N4deIYfBo4Ci7P3cdXRf3I3/CqcWF4sx/vOgtAgEdj8NBJP2+XII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UfuPLwCB; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UfuPLwCB"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-35da97f6a6dso170681a91.0
        for <kvm@vger.kernel.org>; Wed, 08 Apr 2026 11:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775673772; x=1776278572; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=XLWDdn2roHjZrnP49XeGQ3Vpz77A2z8sgq/bNU9KFWk=;
        b=UfuPLwCB1NQRhJtiPAyeR1qLfAoxm2FgcgtvKWHHNIB7DCwpbst+EfmhUAB+VBPZWB
         Jieje4XYaIUqWzP57iNxXbQqtbXMPaleU8rhcRbTWiZweZa/QniyrRyX/ahSXU5+dTGf
         aec4CepvRbI7aZWGOsDy6H9OzH1b42s5/KPJF1PKIp34ii7FkH8e8cndaMc5+bu77fHv
         jKx3eyBrtBvv1J4EDy4qdROA/ewVRcqpOmnQa+Wfhl4QX+9Fd9XuVScZ0lJTMBHUzZhm
         vuC3OpQa4gMlA8ZLkaEMvH/h0RqYrTfSY8qRHSTlg0eMRFPOfeKxpbH42mli/inDoA3R
         4XLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775673772; x=1776278572;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XLWDdn2roHjZrnP49XeGQ3Vpz77A2z8sgq/bNU9KFWk=;
        b=VDDH4V9QY1AY2R3v4d2t3AkTSTJ8B2cgzqgXsP02Jet0tSCKcDLrpypeCKo1q1OdRJ
         XYgTzqdEN5QQPytc6X7iQd17ihSBb2nsjC/RBucuHG8+go0hu7jSYJZtbyCEDGNDoAFn
         1cCLHAlYQsX/7U61hE83B9q0zOaAW288cu7/Ye26Q+bawEtxblN0vjyVcBTcfs51Wuvj
         Cir8/7NbaLj7wW//d6QV+JvMxHypOKboXEaHeMYQXzYcsJ3ZGIQbfETBVvjbEZ7U2NuQ
         b7mBtSHEnRZFlZzw5mmvYPeTcf0bfOn1gWN6vAtgqjIv+qLFbpEtF7JLFHsy5oZXSYCo
         IfBw==
X-Forwarded-Encrypted: i=1; AJvYcCVjPnYdMIYPhipwsaFqCBWqFiPKV9KhFizyIvMr3NrmwbD2XwzkUd7LMbX0L57sIfyTgA0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9Rs1ltia0xmRTH9ILsX0daU36go45VEhqyROJFJxWps5Abt2s
	yPgemfB+Jpzuq9vwQfxJshxXMobt7BmTLGHOYJNtHCJZLyEIHWf/l2M1Kc3awtAgpgNYFJNoo7v
	ov3E0cA==
X-Received: from pjg13.prod.google.com ([2002:a17:90b:3f4d:b0:35d:a732:d4e9])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:6cd:b0:35d:9560:3f09
 with SMTP id 98e67ed59e1d1-35de69a5c3fmr19996330a91.24.1775673771793; Wed, 08
 Apr 2026 11:42:51 -0700 (PDT)
Date: Wed, 8 Apr 2026 11:42:50 -0700
In-Reply-To: <177b405e-87f7-400f-a783-adc7c20bef89@amd.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260310234829.2608037-1-seanjc@google.com> <20260310234829.2608037-6-seanjc@google.com>
 <177b405e-87f7-400f-a783-adc7c20bef89@amd.com>
Message-ID: <adahqilc9IrIpIvr@google.com>
Subject: Re: [PATCH 05/21] KVM: SEV: Lock all vCPUs when synchronzing VMSAs
 for SNP launch finish
From: Sean Christopherson <seanjc@google.com>
To: Srikanth Aithal <sraithal@amd.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jethro Beekman <jethro@fortanix.com>, Alexander Potapenko <glider@google.com>, 
	"Carlos =?utf-8?B?TMOzcGV6?=" <clopez@suse.de>, Thomas Lendacky <Thomas.Lendacky@amd.com>
Content-Type: text/plain; charset="us-ascii"

On Wed, Apr 08, 2026, Srikanth Aithal wrote:
> On 3/11/2026 5:18 AM, Sean Christopherson wrote:
> > Lock all vCPUs when synchronizing and encrypting VMSAs for SNP guests, as
> > allowing userspace to manipulate and/or run a vCPU while its state is being
> > synchronized would at best corrupt vCPU state, and at worst crash the host
> > kernel.
> > 
> > Opportunistically assert that vcpu->mutex is held when synchronizing its
> > VMSA (the SEV-ES path already locks vCPUs).
> > 
> > Fixes: ad27ce155566 ("KVM: SEV: Add KVM_SEV_SNP_LAUNCH_FINISH command")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > ---
> >   arch/x86/kvm/svm/sev.c | 16 +++++++++++++---
> >   1 file changed, 13 insertions(+), 3 deletions(-)
> > 
> > diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> > index 5de36bbc4c53..c10c71608208 100644
> > --- a/arch/x86/kvm/svm/sev.c
> > +++ b/arch/x86/kvm/svm/sev.c
> > @@ -882,6 +882,8 @@ static int sev_es_sync_vmsa(struct vcpu_svm *svm)
> >   	u8 *d;
> >   	int i;
> > +	lockdep_assert_held(&vcpu->mutex);
> > +
> >   	if (vcpu->arch.guest_state_protected)
> >   		return -EINVAL;
> > @@ -2456,6 +2458,10 @@ static int snp_launch_update_vmsa(struct kvm *kvm, struct kvm_sev_cmd *argp)
> >   	if (kvm_is_vcpu_creation_in_progress(kvm))
> >   		return -EBUSY;
> > +	ret = kvm_lock_all_vcpus(kvm);
> > +	if (ret)
> > +		return ret;
> > +
> >   	data.gctx_paddr = __psp_pa(sev->snp_context);
> >   	data.page_type = SNP_PAGE_TYPE_VMSA;
> > @@ -2465,12 +2471,12 @@ static int snp_launch_update_vmsa(struct kvm *kvm, struct kvm_sev_cmd *argp)
> >   		ret = sev_es_sync_vmsa(svm);
> >   		if (ret)
> > -			return ret;
> > +			goto err;
> >   		/* Transition the VMSA page to a firmware state. */
> >   		ret = rmp_make_private(pfn, INITIAL_VMSA_GPA, PG_LEVEL_4K, sev->asid, true);
> >   		if (ret)
> > -			return ret;
> > +			goto err;
> >   		/* Issue the SNP command to encrypt the VMSA */
> >   		data.address = __sme_pa(svm->sev_es.vmsa);
> > @@ -2479,7 +2485,7 @@ static int snp_launch_update_vmsa(struct kvm *kvm, struct kvm_sev_cmd *argp)
> >   		if (ret) {
> >   			snp_page_reclaim(kvm, pfn);
> > -			return ret;
> > +			goto err;
> >   		}
> >   		svm->vcpu.arch.guest_state_protected = true;
> > @@ -2494,6 +2500,10 @@ static int snp_launch_update_vmsa(struct kvm *kvm, struct kvm_sev_cmd *argp)
> >   	}
> >   	return 0;
> > +
> > +err:
> > +	kvm_unlock_all_vcpus(kvm);
> > +	return ret;

/facepalm

With an assist from lockdep (see below), I forgot to actually unlock in the
*success* path.  The failure manifested as a "guest" hang instead of a deadlock
by pure dumb luck: kvm_vcpu_ioctl() uses mutex_lock_killable() so killing QEMU
still works.

I'll squash this (assuming it fixes the problem you're seeing), and omit this
entire series from the initial 7.1 pull requests.  If everything looks good, I'll
plan on sending a second pull request for this series after it's had more time to
soak in -next.

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 2010b157e288..770f7dfc0e5c 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -2512,12 +2512,12 @@ static int snp_launch_update_vmsa(struct kvm *kvm, struct kvm_sev_cmd *argp)
 
                ret = sev_es_sync_vmsa(svm);
                if (ret)
-                       goto err;
+                       goto out;
 
                /* Transition the VMSA page to a firmware state. */
                ret = rmp_make_private(pfn, INITIAL_VMSA_GPA, PG_LEVEL_4K, sev->asid, true);
                if (ret)
-                       goto err;
+                       goto out;
 
                /* Issue the SNP command to encrypt the VMSA */
                data.address = __sme_pa(svm->sev_es.vmsa);
@@ -2526,7 +2526,7 @@ static int snp_launch_update_vmsa(struct kvm *kvm, struct kvm_sev_cmd *argp)
                if (ret) {
                        snp_page_reclaim(kvm, pfn);
 
-                       goto err;
+                       goto out;
                }
 
                svm->vcpu.arch.guest_state_protected = true;
@@ -2540,9 +2540,7 @@ static int snp_launch_update_vmsa(struct kvm *kvm, struct kvm_sev_cmd *argp)
                svm_enable_lbrv(vcpu);
        }
 
-       return 0;
-
-err:
+out:
        kvm_unlock_all_vcpus(kvm);
        return ret;
 }

> >   }
> >   static int snp_launch_finish(struct kvm *kvm, struct kvm_sev_cmd *argp)
> 
> 
> I am seeing an SNP guest boot failure starting with linux-next tag
> next-20260406 [1].
>
> The SNP guest hangs during boot.

...

> There are no error messages on either the host or guest serial console when
> this happens.

 WARNING: Nested lock was not taken
 7.0.0-smp--36ad607330fb-snp #112 Tainted: G     U  W  O       
 ----------------------------------
 qemu/39235 is trying to lock:
 ffff8d0e590c00b0 (&vcpu->mutex){+.+.}-{4:4}, at: kvm_lock_all_vcpus+0xab/0x180 [kvm]
 
              but this task is not holding:
 &kvm->lock
 
              stack backtrace:
 CPU: 123 UID: 0 PID: 39235 Comm: qemu Tainted: G     U  W  O        7.0.0-smp--36ad607330fb-snp #112 PREEMPTLAZY 
 Tainted: [U]=USER, [W]=WARN, [O]=OOT_MODULE
 Hardware name: Google, Inc.                                                       Arcadia_IT_80/Arcadia_IT_80, BIOS 34.86.0-102 01/25/2026
 Call Trace:
  <TASK>
  dump_stack_lvl+0x54/0x70
  __lock_acquire+0x7b9/0x2900
  reacquire_held_locks+0x107/0x160
  lock_release+0x177/0x360
  __mutex_unlock_slowpath+0x3c/0x2b0
  sev_mem_enc_ioctl+0x3c9/0x400 [kvm_amd]
  kvm_vm_ioctl+0x57c/0x5d0 [kvm]
  __se_sys_ioctl+0x6d/0xb0
  do_syscall_64+0xe8/0x920
  entry_SYSCALL_64_after_hwframe+0x4b/0x53
  </TASK>
 
              other info that might help us debug this:
 no locks held by qemu/39235.
 
              stack backtrace:
 CPU: 123 UID: 0 PID: 39235 Comm: qemu Tainted: G     U  W  O        7.0.0-smp--36ad607330fb-snp #112 PREEMPTLAZY 
 Tainted: [U]=USER, [W]=WARN, [O]=OOT_MODULE
 Hardware name: Google, Inc.                                                       Arcadia_IT_80/Arcadia_IT_80, BIOS 34.86.0-102 01/25/2026
 Call Trace:
  <TASK>
  dump_stack_lvl+0x54/0x70
  __lock_acquire+0x7de/0x2900
  reacquire_held_locks+0x107/0x160
  lock_release+0x177/0x360
  __mutex_unlock_slowpath+0x3c/0x2b0
  sev_mem_enc_ioctl+0x3c9/0x400 [kvm_amd]
  kvm_vm_ioctl+0x57c/0x5d0 [kvm]
  __se_sys_ioctl+0x6d/0xb0
  do_syscall_64+0xe8/0x920
  entry_SYSCALL_64_after_hwframe+0x4b/0x53
  </TASK>
