Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5734C3F1AC6
	for <kvm@vger.kernel.org>; Sun,  4 Oct 2026 22:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791152432; cv=pass; b=ObkEAo55sSuJMhokXhfyq2xPqkEZAMlgQhTlz3VSwqMbkHV+XCjWqJXjgxIBs0l3TihT1k37Mk9l770KGHxHl8KZkiS7Dzcjh9qJREw6NebkoyYofPuvMZ7DEkZZdjtUHmCyRknn3sDUJ+n0/lfpPGsgH5Pd2CShpqdBXgdgBqM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791152432; c=relaxed/simple;
	bh=XgFf0V3Zwk70tdgQVOzBVGpxn9WfToTnVVb8pOQ7a/Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GyriS4+z3ui6W5ChkAodfOOdKkbmjTptu4W1FVMXZcgLKyQ5tGcqYBZnU2ByHcKg8jWThEfOq1JUvn/T43ClmzwKdsEziQNtKRJGbOwhiMatGxg6z29NWjq1gPpQYEL3b7FloS+MnZrzIpinA44kcD5+RlgvFCJrtv1SjOMPlJk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=s2TpqMbz; arc=pass smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s2TpqMbz"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5ba429b64c5so4283e87.1
        for <kvm@vger.kernel.org>; Sun, 04 Oct 2026 15:20:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791152425; cv=none;
        d=google.com; s=arc-20260327;
        b=XhazrEEauzEJtSKTmN8DP2gVnyJC0/iKIo6gA3zkPJsbzKKdeBrX+ZLSpwwPIU0hc5
         9PIZV5gyo96/TE0q276vGqYvWq3XtZjpy/y1ZC2L1+ev/QpDuqs9dQfjDpQHas5VwKNK
         Y0rDLQUdbPqMZ+O2QoesWYDmSMqkVBkEeqqdtiPq/xY37g0dBtjZvUYMIIJKIDFpvBx5
         ytcwuClOeDW3Ud9O6OqvT+Bp4gIuxRQ7DLJ4Wh8Rjx/QKwk4OLAjuAyXY5DgGrW3aRdz
         2FHAD2RXrO5jWXcTvZtosJOhduYIDMeY+Bj/gHh6G5ZCAK9kO31VqgcI826Mf8WpsigN
         DYfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=57r++D/W5FdfNaHzmVXc+jEW9QTol9obBS4Hemyq/Zo=;
        fh=oXP6ZxyexAxDBicWz1UyL8ox9CI3kOBAAHuEbCiUTn4=;
        b=WBLx4J2wXC2ijzM71FxUMGy+xBGMaqbO7jWoXLmm4eoer7yNoxIdwYWCHkvr6UyvQF
         aOqDpHy1CoPr8zzjhqWaWt09k9gyeIFbvlvBkrxsZQHkO55LKlhPGQJRUDewygwCwbtz
         iAR6fxZzUS0tqMJGFV6LBGDSgNR8Zao0270LZcZHc6Sjog8yhSMw23b2LaSAWQ8jOygt
         Peu1gIfMDO6/qD3IJTHFbd1hPOtnsqjr1rExQhHmwWHdtXxbrjp4e6Ie8DcA0OILtCNL
         9hgtttyLwOz7paw8H9gOwdiQQ8r3BthZSbR8z2LOhWkdx9P24k27DEusua27oI7MupyH
         DY8w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791152425; x=1791757225; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=57r++D/W5FdfNaHzmVXc+jEW9QTol9obBS4Hemyq/Zo=;
        b=s2TpqMbzNr0IdbxeGuoxlQBYiTJk0CgxdaPBdYQ1gdi/yEPNAtfeDKV8BPLtskXmt3
         bfGtFz1bvErtKi6ZjS0G2eX0JVJ1kvIGF2eaYanjI+a1mprivWFyqbMw0QR/ENyiAnQK
         DGdiw8BiYQO8hG3b3ruNAeLPZQdddWBzYUCgvyV3bYkNpMZxc0RwmvTR1OrxNMZhNEZ+
         jOk5etXV9s6KYxXSescT6JpwQNI9vidC0/ShUYBQosNctmkzQvigHBfpYvIw9C/E7X0r
         7dEPh+/TsQRHUqnUrEBvqjtH56YOh23KQUAjw87Cy/Mm25VshPeSiZvQvHqp7OUWmttW
         LquA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791152425; x=1791757225;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=57r++D/W5FdfNaHzmVXc+jEW9QTol9obBS4Hemyq/Zo=;
        b=LAwN6cyfB9NQfARmTBYgrrdO1f9vbt5A1dFCtmWZnJpKfZos2tMUbjWjRQFkxHgt/j
         p8Swc6jFUHcx2cVOpzYqpsaFo1ikO4b0uIrfww1FDf+9pIF2TFOn9ZCQp0pUb+bIHU9k
         SGY3nRkrXXG2jOqqs3k94R0fdXhcD5NLebeVeZdT9U6pV4rilMh+LMhaeTFoHYITxvxP
         5sjbXXC07rrEz9MB+YSmXGq/slLiziVi3TUUUi7xl6A9EorPwJpFFP73rA1a7tGKu41s
         JNHbJGilWol6utq9q8HyKSCBF/Fi5BTX86IXfqUcSLkfuTOnypfuStppFvz8sORXsBel
         QKnw==
X-Forwarded-Encrypted: i=1; AKwUvBySY9Wg2op3XFYph5qff/f69W9qzeeIMGQ6OyzFbtSyQRXzPCvgsYdezEtzTxCOLkHhWn4=@vger.kernel.org
X-Gm-Message-State: AFq9FYLap5NZcL/OBCOa9dafGc3xfrsUH5mG2Zz855G1Q/YwVzqn1lvY
	9PtAV6VgklCeJAVTBYNwbwUI4pzcxYtdM17j93/+f0XEpo4Kqa0T4OKgZlmJEPBw0Zq2hySELrR
	2T+jsWWx+eZJgsICz4a2ns8HUuAX3yZOsCpZKtlyp
X-Gm-Gg: AYBFou3ZYrJGmR/tfr20Sn7KeXai6EBnh1lHh73EkC2rvd0ZmBoXCq9KCw28c24lABh
	UDo7TuG+9gHLFm8WSG/nHmtnhhNEPmHsm9ITn2rMhSVWapQ3lV2zhRfMGkoBHc2tOelc/EPTJxp
	i0O9V4ipUsiqJEVXT90jt+/4tungHatJcoTurYxwTXYGqPMITCLonXW+3RbJpl5p84XxxtbeYyx
	PH1bbDZR7ICq4jq5CTvQMQA9imTWu4Pu7LEWcCJddvRXnvKfbfMNmbimlIRGqIRqzzv/r3hv48P
	BuwPpa4x5LwjhkGCGJPypbkesfNaHgfN3223Utp2C4cOSqX8WFH3yGHAvOFGNTZ2HcqJ7gM3VXT
	5w5Y8HO0e
X-Received: by 2002:a05:6512:12cc:b0:5b8:c932:f056 with SMTP id
 2adb3069b0e04-5bcb62a9caamr122163e87.7.1791152424823; Sun, 04 Oct 2026
 15:20:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <e61df396-356f-4ef2-9c3a-db3c05cb5c52@linux.alibaba.com> <asA7ixFlhNJpANoR@google.com>
In-Reply-To: <asA7ixFlhNJpANoR@google.com>
From: Josh Don <joshdon@google.com>
Date: Mon, 5 Oct 2026 00:20:13 +0200
X-Gm-Features: AclHuK_mrhmx5Nw1OfCHCYw_l507ZApaU7MPipokAeot-vC-4w_HOGNToVZP06A
Message-ID: <CABk29Nu5rnd3wZq8XR5Q3BA2dQzT68hHSv1JihxT3V6GTSyRHw@mail.gmail.com>
Subject: Re: [PATCH v2] x86/kvm: introduce pv idle time
To: Sean Christopherson <seanjc@google.com>
Cc: He Rongguang <herongguang@linux.alibaba.com>, pbonzini@redhat.com, tglx@kernel.org, 
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, 
	vkuznets@redhat.com, geert@linux-m68k.org, sammiee5311@gmail.com, 
	lirongqing@baidu.com, schuster.simon@siemens-energy.com, kai.huang@intel.com, 
	shannon.zhao@linux.alibaba.com, x86@kernel.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Vineeth Pillai <vineeth@bitbyteword.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 3, 2026 at 1:17=E2=80=AFAM Sean Christopherson <seanjc@google.c=
om> wrote:
>
> +Vineeth and Josh
>
> On Tue, Jul 21, 2026, He Rongguang wrote:
> > Hi, this patch introduces a PV mechanism for guests to publish their
> > vCPU idle state and accumulated idle time to the host. This allows
> > the host to efficiently determine whether a vCPU is currently in its
> > idle loop, and knows vCPU idled for how long. QEMU patch and ARM64
> > support patch will follow in a subsequent series.
> >
> > The guest writes a GPA pointing to a struct kvm_idle_time via
> > MSR_KVM_PV_IDLE_TIME. When entering idle, the guest sets the flag field
> > to KVM_PV_VCPU_IDLE. On idle exit, it clears the flag back to
> > KVM_PV_VCPU_RUNNING and adds the elapsed idle duration to idle_accum
> > (in nanoseconds).
> >
> > The host can read the flag at any time through
> > kvm_arch_is_vcpu_pv_idle() to make better scheduling or resource
> > allocation decisions. For example, host may overcommit those vCPUs
> > which are mostly idle. An in-guest agent may be absent, or may not
> > report the status in time.
> >
> > The accumulated idle time provides visibility into per-vCPU usage for
> > monitoring purposes. An in-guest agent can report VM CPU usage, but
> > this PV mechanism allows the host to obtain guest CPU usage even when
> > no agent is installed. This is especially helpful when the hypervisor
> > enables exitless-hlt/mwait (for better guest performance) or when the
> > guest uses idle halt-polling, both of which make QEMU vCPU thread usage
> > deviate from the actual in-guest vCPU usage.
> >
> > This feature is advertised via KVM_FEATURE_PV_IDLE_TIME in CPUID leaf
> > 0x40000001. Guests enable it by writing the appropriate MSR during
> > initialization, similar to the existing steal time mechanism.
> >
> > Signed-off-by: He Rongguang <herongguang@linux.alibaba.com>
> > ---
> > v2:
> > - grab kvm->srcu in kvm_arch_is_vcpu_pv_idle() before calling into
> >   kvm_read_guest_offset_cached().
> > - return KVM_MSR_RET_UNSUPPORTED instead of 1 in MSR handling if
> >   !guest_pv_has(feature).
> > - in set MSR handling, set vcpu->arch.pv_idle_time.msr_val after
> >   kvm_gfn_to_hva_cache_init() return success.
> > - in kvm_arch_is_vcpu_pv_idle(), remove ghc->memslot check, let
> >   kvm_read_guest_offset_cached() handle it.
> > - in kvm_arch_is_vcpu_pv_idle(), no need to use struct kvm_idle_time
> >   local variable, it is too big, just use __u64 flag is enough.
> > - remove some straightforward code comments.
> >
> > v1:
> > -
> > https://lore.kernel.org/kvm/36863cf7-61b9-4885-946d-1608179fcab4@linux.=
alibaba.com/T/#u
> > ---
> >  arch/x86/include/asm/kvm_host.h      |  7 +++
> >  arch/x86/include/asm/kvm_para.h      | 19 ++++++++
> >  arch/x86/include/uapi/asm/kvm_para.h | 24 ++++++++++
> >  arch/x86/kernel/kvm.c                | 68 +++++++++++++++++++++++++++
> >  arch/x86/kernel/process.c            |  7 +++
> >  arch/x86/kvm/cpuid.c                 |  3 +-
> >  arch/x86/kvm/x86.c                   | 69 ++++++++++++++++++++++++++++
> >  7 files changed, 196 insertions(+), 1 deletion(-)
>
> I really, really, reaaaaally don't want to take on any (more) PV scheduli=
ng ABI
> in KVM, if possible.  And I definitely don't want to take a bunch of one-=
off
> hooks, e.g. for idle tracking and then for something else a few months/ye=
ars
> later.
>
> Vineeth and Josh are working on PV scheduling via sched_ext and I assume =
additional
> communication channels.  I'm guessing idle state is one of the things tha=
t'll get
> communicated to the host?  I don't know the exact status of their work, b=
ut they've
> got a slot in the sched_ext MC at LPC:
>
> https://lpc.events/event/20/contributions/2482

Thanks Sean, yea this looks achievable though the pvsched framework.
Note that usage of sched_ext is not a requirement. For something like
this idle time tracking, it would be trivial to extend the pvsched
guest component, which already tracks guest scheduling state changes
via guest context switch.
