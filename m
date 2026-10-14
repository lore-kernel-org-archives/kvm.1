Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 604224ED199
	for <kvm@vger.kernel.org>; Wed, 14 Oct 2026 23:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792022056; cv=pass; b=uBLTwDLHQguRuuhxOJh3wfegFmboKzZ3kUlUprn2mwEm30lOoz64wOyygMkhwKs4Ydwuwj4HwbSV9qV2vmicEqwUdT68SAUtbZAeqek5uOghw5UuihGSqhyEiax9PgCEZeVoA8wpcuK/NFjgg6iO/L/7K6wSCUmseEUyX/cg/PE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792022056; c=relaxed/simple;
	bh=4H0Bgva3Ydel0kL3mvgFhxMi1gLUgRSwy7ED0ZLa5xA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AupAY0HEfwsZ6uaIC2kxhXIqUYLW+fvivtX19b/qHFvYWynGfWLTTzyNaqXJaPPIDWeqEIXudK4fIpIvc+KHji6LVJFpWIr6WN+Soa+vFuVQhgaO3wcRIx5x+NE56KPIBfLEiQmRxc+Yvb1FAgXQSEFhmFytbMlYRt5FO7ybhHI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=X/mNh6m9; arc=pass smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="X/mNh6m9"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6afac79b3a3so1229a12.1
        for <kvm@vger.kernel.org>; Wed, 14 Oct 2026 16:54:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792022051; cv=none;
        d=google.com; s=arc-20260327;
        b=P87nYdYcsUelEU8gRvh/sLAmn5/xzRYj8z8N4ipeStnJP0TJ2diCOTCUih8zGe9+tx
         cmGA6suX75lQBVBQojA6WeZ/oxgi7a7y0gv8ZmULWB7R/iReckCaAFQQh45eYWZ6Ewu6
         uA1LMrXQJzKYSSFFZm9uNpF7pkl/P0gDjPzS3247WY8IFCx/04huVyjMaHjTFJaHzFQC
         8Miy4ilHsg37XgqZQJx57K2APNDC+x9vTkarpZky+gVWwp9dBh2B/bEFGaRTDiX+5k8b
         ZJZbWEobaPe6rCpUQiddTv7RAIVDhXVb0rCrqibrP1cWA9nPHyl1h8/Cf1wba6cwQVuK
         HHwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=03x45p4Sm/ofaAJEtxKDi9izKZVyf4Piq/s/1arfqh8=;
        fh=m8Iqm5mfcU4eBNEgOmQSJ9Wc/bZpQ4mNUAScZ4uRvCI=;
        b=KQbyiD05p2Q0M6XlTdlxYizZH0nI/YwISAa60GGwDusOgmGos+X8EDgt90yHLErisG
         KNRTp6iDdtmr7krh/8dsXTpCnxzrMhHdjO+0YDWdgbdGXL2T8LZJ20qV0pjxIAYId7ny
         /9tuN2Bq+Mq4gkiL4LokwrsLM81u8qUtyNS8G64ZxAl6ig1xFmPhk7BNTqyIAGck+xzR
         0oXdAgzR2w2afMbaMs0UAg/VX0YP12VDT7zohVyt/TH4bWS7e0ygMsCSpo/M6wg9il8z
         bHTyMTWc5GnivUXmCFd/I5miUNj+KSec1OZxgSFrkaZypj/ev8SFyK3xz85gFdqMuO6y
         wCdQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792022051; x=1792626851; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=03x45p4Sm/ofaAJEtxKDi9izKZVyf4Piq/s/1arfqh8=;
        b=X/mNh6m9o1A4Kg52ztKPG2Q0b1vwmhmjFPabBoSig0SbT0EqnwmAPEJxc4/XbO7RWN
         nMuZ+Q+Og/cj74I/qlxdPXyxVfarmKf5BLy0eZhHYsINwMcfVtuIGxdaVuA/vpsLFpNO
         CObGolVO8+ixXs7zTVUX5Bfc7MSFgjg+7FLCOe2cvrzkcZjAYOJVNfJcfnlMoJrj4bUC
         HHwprheWCMTPXKpU4yv4FkefxubG+RXouA0ddlE10vXgTZmsuveb8ehtmLorZAIpqqNR
         SNa5DDAj7u+TM9wODSsd5ZUKvg7WyrHc+LLlViaPjqgsdwqkmdD5Ec5gGN/Sz7QKPZr8
         JVKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792022051; x=1792626851;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=03x45p4Sm/ofaAJEtxKDi9izKZVyf4Piq/s/1arfqh8=;
        b=2bfZ26xc/MlOnFl3eizod0yj3ytIy37b/i1ufqHgX61T95e4XzfRmJ1IIsNMS3ZvLx
         y5ZW+s3cS9bbVWO4RMt2YviAXGLzZrhnV9GYTd3z4qpaZTBCvxgrkrjgvq4gA3L1ihT2
         jur0HpEhk+LUAHOTepohMM1A0Pji6eizBNuTcVCfYZ//uRbWj3aSFO5WNMf8URPq0fHl
         7ycnj3saYSvmw6WHGk1cqO59NMcVSUCQj5g4cePAskuaok8NWo7Tx7EEtjXDCBWf0MYS
         jFiXBsnStVr5a/V0YvBmRJZDkf65TagNq5zztkOG5Dw3u4RtGBlWxTtiNJf9xZnhpHB3
         WbaQ==
X-Forwarded-Encrypted: i=1; AKwUvBxb+RABQyXX+Kuq9cDsPJeE0wbUsAigGR/j2L7liT0X1D00BNMkeLVVZHshT4lnnA/emIM=@vger.kernel.org
X-Gm-Message-State: AFq9FYIebhwgswKBK/4lYrmIDGx5ULX/h3Cd1lnLLFyOfaEdrwFOIAd5
	EaBeo6A1Za9EknEQZrjBJHyu1J+Ow5wDWzWGwz1bUy/s4LykzeMVrvV3sA9SPw7M9UMC26hitSa
	c6gboaMe6dax8n9ADu95V6eCJHUr1stjvGWmknJvw
X-Gm-Gg: AYBFou34nrFHC3EicO6rtDyxUjbvdRqUrP5wFpMzy/Tg50BXKM6ZAmqPFbEqoRc4Wqt
	LLm+LF64Cf0Puhkh5EFX7Fk7v5D1KJsC4n+zHhOaPDDLPpntXvZO/EFK+BmzDPFroWOS6LNXMm0
	O9dHP2tzFH0QGUn4lyUQRfcsYNHl7ESjzw5zLZaRz8ZSMcl13vModgBc9LQvZHHsHXRHcehLMB2
	NJ/q1jn4OO5ism4W1a+4nFXOGPtnIgaBoUHnB4G/lYg0z1O7sa29xDLhW5S2zl4aI7oNg09Wem6
	PMRMUwei4Av0HB+Z72K0/XeR7Xn2bmPkUTGotRPXuPHNY1fpCJIBuGQ=
X-Received: by 2002:a05:6402:a2c9:10b0:6ac:bd5c:9e2e with SMTP id
 4fb4d7f45d1cf-6b33387e2eemr4330a12.6.1792022051078; Wed, 14 Oct 2026 16:54:11
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261008001425.2458927-1-yosry@kernel.org> <20261008001425.2458927-11-yosry@kernel.org>
In-Reply-To: <20261008001425.2458927-11-yosry@kernel.org>
From: Jim Mattson <jmattson@google.com>
Date: Wed, 14 Oct 2026 16:53:58 -0700
X-Gm-Features: AclHuK8iHkRx3rLAQYnS_QgUQR8LswtkxfUo75oQKZHQFZ5tImcdhWen3PD54ok
Message-ID: <CALMp9eTE4DB7Ek4BiHheD-Jr_GjwhiFpcQNHco4uYKQvMbBvWQ@mail.gmail.com>
Subject: Re: [PATCH v2 10/29] KVM: SVM: Use a static ASID per vCPU
To: Yosry Ahmed <yosry@kernel.org>
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Maxim Levitsky <mlevitsk@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 7, 2026 at 5:14=E2=80=AFPM Yosry Ahmed <yosry@kernel.org> wrote=
:
>
> Switch from dynamic ASID allocation to a static per-vCPU ASID.  The
> dynamic ASID allocation logic is now only effectively used when running
> out of ASIDs on a CPU (uncommon on modern hardware), or switching CPUs.
>
> The per-VMCB ASID generation is initialized to 0, which never matches the
> per-CPU ASID generation (bumped every time a CPU is enabled for
> virtualization). This leads to a TLB flush of the ASID on the first VMRUN=
,
> allocating a new ASID, and bumping the per-VMCB generation to match the
> per-CPU generation. The ASID remains static until one of the following:
>
> - The vCPU runs on a new CPU, in which case KVM resets the generation of
>   both VMCBs to allocate a new ASID on the new CPU.
>
> - KVM hits the maximum ASID on a CPU and increments the per-CPU ASID
>   generation, at which point all vCPUs on this CPU will allocate a new
>   ASID.
>
> - The CPU is re-enabled for virtualization (e.g. after CPU hotplug), at
>   which point the per-CPU generation is bumped and all vCPUs that
>   previously ran on it will allocate a new ASID.
>
> Drop the complexity and make the ASID static for each vCPU.  This makes
> SVM's handling of ASIDs closer to VMX's handling of VPIDs, and
> simplifies the code. It also completely avoids full TLB flushes (i.e.
> TLB_CONTROL_FLUSH_ALL_ASID) on systems with FlushByAsid.  Full flushes
> previously happened when updating the generation, so not so common, but
> should generally be avoided as they cause a VMRUN to invalidate the TLB
> entries for other VMs as well as the host.
>
> When a vCPU is migrated to a new physical CPU, flush the (now static)
> ASID instead of allocating a new one. This might cause extra TLB flushes
> when switching CPUs (compared to just using a new ASID), but odds are
> that the TLB is cold on the new CPU anyway.
>
> Static ASIDs also make the following fixes to the dynamic ASID
> allocation scheme unnecessary, so drop them:
>
> - Bumping the per-CPU generation when enabling virtualization on a CPU,
>   added by commit 25f744ffa0c8 ("KVM: SVM: Bump asid_generation on CPU
>   online to avoid ASID collision after hotplug").  A vCPU can no longer
>   run with an ASID that is (re)assigned to another vCPU.
>
> - Resetting the generation of both VMCBs on a CPU switch, added by
>   commit bf260dc9e7b8 ("KVM: SVM: Trigger new ASID allocation in both
>   VMCBs on pCPU switch").  An ASID is now owned by the same vCPU on all
>   CPUs, so a VMCB that misses a CPU switch can no longer end up using an
>   ASID owned by another vCPU on that CPU.
>
> - Tracking a pending full flush per-CPU (i.e. flush_all_asids), added by
>   commit 60d93c27859f ("KVM: SVM: Preserve TLB control (i.e. pending TLB
>   flush) on failed VMRUN").  The full flush on generation wraparound was
>   needed on behalf of all vCPUs on the CPU, as their ASIDs were about to
>   be recycled, so it had to be tracked per-CPU instead of in the VMCB of
>   the vCPU that happened to trigger the wraparound.  With static ASIDs,
>   TLB flushes are only needed for the vCPU's own ASID, so tracking them i=
n
>   the VMCB is sufficient, and a pending flush in the VMCB is still
>   preserved on a failed VMRUN.
>
> As using ASIDs cannot be disabled like VPIDs, allocate a fallback ASID
> to be shared by all vCPUs after running out of ASIDs (and flushed on
> every vCPU run, for now).  If a fallback ASID cannot be allocated, fail
> vCPU creation (for non-SEV guests), but do not fail SVM initialization,
> to allow for allocating all ASIDs for SEV (if at all possible).
>
> For SEV, the same ASID continues to be used by all vCPUs in a VM. Move
> svm->asid initialization from SEV-specific VMCB initialization to vCPU
> creation, such that svm->asid is always initialized on vCPU creation for
> both SEV and non-SEV vCPUs. This makes the logic simpler to follow, and
> makes it easier to hide it in allocate_asid() and free_asid() helpers.
> Decide whether to free an ASID based on the ASID range rather than the
> VM type, as an SEV VM's vCPUs may stop being SEV vCPUs (or vice versa)
> as a result of SEV VM migration.
>
> Keep the ASID initialization in sev_init_vmcb(), even though it's
> already done in init_vmcb(), to handle SEV VM migration.  svm->asid is
> already reinitialized on destination SEV VMs during migration before
> VMCB initialization, so the ASID ends up correctly in the VMCB.
> Additionally, free any existing non-SEV ASID on the destination vCPU
> before overwriting it, to avoid leaking ASIDs when creating vCPUs then
> migrating an SEV VM onto them.
>
> Note: A nice side-effect is reading the min/max ASIDs once during
> initialization, instead of once per-CPU.
>
> Signed-off-by: Yosry Ahmed <yosry@kernel.org>
> ---
>  arch/x86/kvm/svm/nested.c |  4 +-
>  arch/x86/kvm/svm/sev.c    |  7 +++-
>  arch/x86/kvm/svm/svm.c    | 79 +++++++++++++++------------------------
>  arch/x86/kvm/svm/svm.h    | 25 +++++++++----
>  4 files changed, 55 insertions(+), 60 deletions(-)
>

[ ... ]

> @@ -1375,6 +1370,12 @@ static int svm_vcpu_create(struct kvm_vcpu *vcpu)
>                 goto error_free_avic;
>         }
>
> +       svm->asid =3D allocate_asid(vcpu);
> +       if (!svm->asid) {
> +               err =3D -EINVAL;

It seems like -ENOSPC is more appropriate, and would make triaging
this failure easier.

> +               goto error_free_msrpm;
> +       }
