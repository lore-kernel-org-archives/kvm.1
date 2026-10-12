Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 706914D9F99
	for <kvm@vger.kernel.org>; Mon, 12 Oct 2026 21:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791840210; cv=pass; b=EigvjKj6UulliwZ7kT9jScnwWPf50z4JhWBWDoALYGq0B/Qi94d5jqJkN9p55JosMHC8IWrhrkSBOcm0mVk0iL4DDD0NiQUJUeDVSl17KnRz9ZJlWk9GBtyFgXq2Ru0MM6CtouhgcYJW9Sfeqwf3CiqXK+yn2fQI7oNssvwKMA4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791840210; c=relaxed/simple;
	bh=M/ThXiHN1P68R+1YhMAmr597pKOSWjt23LCQQNjErlw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JSdXLpjjFNSkCbpUCDjU/SOU5IDVD6RYA5AJE4WmneMrfNdVXsv2ox5lnzfs+ZpaoJc5BoUkRT+TBS8M3vzFrNzVjXHO/XcAC4h9oHA/TGivn9XQhcWRBwjwMUqvL3KHxguevk5zvmgRhWSFECBywjbpMs09DLekCE38pxiQ3qk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YxyjDzyY; arc=pass smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YxyjDzyY"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6afac79b3a3so17630a12.1
        for <kvm@vger.kernel.org>; Mon, 12 Oct 2026 14:23:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791840207; cv=none;
        d=google.com; s=arc-20260327;
        b=BeBBoYjAbLkTJ8mV+OdOul9WmIsP5cbCrGPnoWTUhf3y6pFrZt5eU1/jpTYlv0Bh+L
         dReilyZHt+cWZ/zVFoYAVJuhugub5Cd+yz73duUWrrwtwXosIv1zwN2xK0gwY2KkH1se
         wWPKOPhFUSdGyUa9EQB2jDTjc/kKRkuhjI4ZVYTwgQ8RSJ0eNRtIML12KbTP9CTd0GHF
         Y1LsxWwL8w5YP2ci4ViX8I63J8Rb0MMVLq2UlJq+SgWmEkV83ULPlWZrs8mepOcC5ZVF
         mwVhXDczIKNZwqzdHrb0QKGc7fTJBVc2wmaUTznxV0LApDETw5qw2kg9YW/y7zwMkIsn
         zxgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Ee4DfkcYbf3IOngkIJrGviVyrMh0yvV16mhd+eYxirU=;
        fh=KOW2I3kM5MsPOxThYg+YVNOV3PNnHXbIC9maheywIes=;
        b=gSMELl4dzeaDuxWcFZBFe7X7gTxZOf4ha0Fe+SVgV2UHnrVLnfyhsSBH0Iq3uNWF6x
         sY5wMsS6rveJdrhTGGSW/gtN38FK2ZhllgLJ0HFIVt5M7bRxjWLJkhPmWSXqulbo9mJ/
         qOZWXNq/TCah18beleLF78di42NBncvRgtioHZseFu4SXADIHVpk1NerlPL4vQHJiufm
         aJxF0gvxyt1GW/QdvkVV2yqlkfwYXBLy5lsExgEIxv/dc5xnxLkuR8hgkQ/QGh3l2pr3
         /PSLgEaWQQ0Ye9AIyF/AjtimPohOEF2Thyni8WgR9tKHQc7rcEKRj+/ZEJIjBehrEbha
         EnJg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791840207; x=1792445007; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Ee4DfkcYbf3IOngkIJrGviVyrMh0yvV16mhd+eYxirU=;
        b=YxyjDzyYf6cnh0FGlyV4iPCczRMiNCHVZdq6ohQBqN6eDGCRuRPUDnWlsXdkEHzwt0
         tS5s1EAYYZYZjZ8Zq8XnqwSc7MDU1+7WMrUR6eGLaR8fkT96LOrmcchgTDd4TDn90xc+
         QXZH+ewhwhNumewH0GMLanH1ZmpBL95gIELragGoWu1RVWJm7py86QkQo6MLlT9qDz/u
         VqmcK0H9c8KRoZJLR+8JzXoWVE1ET895yQ1dnQ5K+d1RRDNg1ReLwRdBNfXsV+8r1uAN
         dF9XOSVVpwM5qBr/T110MiMC5saFB1LwOC4ls0+pHu4d1tXvxpMgjlnwoVLSwL5Ls5CI
         5TXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791840207; x=1792445007;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ee4DfkcYbf3IOngkIJrGviVyrMh0yvV16mhd+eYxirU=;
        b=vgiFdTeW/ikAahJ0h5Me//7C3uYXGpj0B5JPcTBOcDUS8usXM+PNVSjPYWh1KBn5Kc
         XH/cr0LcW+cD/RbTP0I7qoI0grqRRn3xpeHvC5d+29A3LBtQ8qZsE7L3ATbBp40Obdm2
         yjtV2IqV1igHKEpdVprYeCpgRzSRKk/KLRHNt57LgV8rpJN1q8L0gcLJ4z/Lgj9u3EQc
         O41/ZnKb2SFmwtF36NpxMtHRLHto9XGDqpRh9577BtrsXZTwHsUJOK4bZutI2+3tXMaC
         ALnW7xqsnYjqgcw8oesVw4u/Ph8i6iN7bPACFSgS8nzPCBKBu8RQ7XTMtcw8QX3t8Gja
         6Efw==
X-Gm-Message-State: AFq9FYILuL4YrPEPLmKIvpwVAKHZ7Dx8QJtdM3YD+uVtvRsvG9iDqMbd
	L+ikmIPLZ2XDy/qux6S6/Ilmhvm3wdL0yr/gpjb2uxCSCt0OAlmd+G7wNZ+jakch4CN+uCPqLYl
	o05wmxtURMNLAnTpQb+VwGY+x3MczmEnELt0REw/85CAhidH/sVZVRfs3rU8=
X-Gm-Gg: AYBFou0hRerr5aKjy5Ul/fR9daMZmQH+wjSiKa4X6tg7oau9gp+XIGPDvxnxyVq4IDi
	LmFR70si0O+2A+dgboC8LUJt+hsEL91vaTJ5yL1fl7DG/u8GSTaa0VUlXg2X+uuEKQBAAHrBy9S
	ji57weuK2UZM6BalRBbHXby776ztw7oEHtJsiyUVFtt9/z0rhZm7DzbMBjieVKBPHQNmYY7caVA
	HSVlfhpgfajLZoVxR4O53M7ziBOkId6Td1ClVwhuIm8oDfwP02iOxd5zj9WDRLeYXalVJKE+dJt
	hdtiLeAPL5M/6RX87tn+XRVShwbUWxu+AvZ70aMVqegP0mJ/oBUz7EE=
X-Received: by 2002:a05:6402:a203:20b0:6a9:f353:ef65 with SMTP id
 4fb4d7f45d1cf-6b1988db8e0mr99917a12.5.1791840206242; Mon, 12 Oct 2026
 14:23:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261005192431.87317-1-hmushi@amazon.co.uk> <20261005192431.87317-4-hmushi@amazon.co.uk>
In-Reply-To: <20261005192431.87317-4-hmushi@amazon.co.uk>
From: Jim Mattson <jmattson@google.com>
Date: Mon, 12 Oct 2026 14:23:12 -0700
X-Gm-Features: AclHuK_0KBTsLrSFa-h9vss0cVbmlNZ4lJ9qkYRPDWcihjTkz5_I3EkMbPan9w4
Message-ID: <CALMp9eQz2ouQvFhBYv_R33_sUQ+ehxv__-f5iZ=_3aA2Guwy5w@mail.gmail.com>
Subject: Re: [PATCH 3/3] KVM: x86: hyper-v: Implement HvCallRestorePartitionTime
To: Mushahid Hussain <hmushi@amazon.co.uk>
Cc: kvm@vger.kernel.org, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	"K . Y . Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, linux-hyperv@vger.kernel.org, 
	linux-kernel@vger.kernel.org, nh-open-source@amazon.com, mushi.shar@gmail.com, 
	Todd Frederick <tfred@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 5, 2026 at 12:26=E2=80=AFPM Mushahid Hussain <hmushi@amazon.co.=
uk> wrote:
>
> A nested Hyper-V that sees the frequency MSRs lets its parent own
> the partition reference time. After a resume from hibernation it
> issues HvCallRestorePartitionTime (0x103) with the TSC and the
> reference counter it saved, and expects both clocks to continue
> from there. KVM rejected the hypercall. The guest time base stayed
> inconsistent and the root partition did not run.
>
> Restore both clocks in one pvclock update, so no vCPU runs with the
> new TSC and the old reference time. Each vCPU computes and writes its
> own TSC offset from the recorded step, so no other vCPU writes its
> TSC state. kvm_synchronize_tsc() writes the offset of the calling
> vCPU only. Mark the TSC page as changed by the guest, so it is
> recomputed even when TSC emulation control is set.
>
> The TLFS marks the hypercall, its input and CPUID 0x40000004 EAX
> bit 20 (RestoreTimeOnResume) as reserved. Microsoft's hvdef crate
> defines them (hypercall::RestorePartitionTime), and Microsoft's
> OHCL kernel carries the same C definitions in hvgdk_mini.h.
>
> Advertise bit 20 and gate the hypercall on it under
> KVM_CAP_HYPERV_ENFORCE_CPUID. Hyper-V offers hibernation to its root
> partition only when the parent sets this bit.
>
> Assisted-by: Claude:claude-fable-5.1
> Signed-off-by: Mushahid Hussain <hmushi@amazon.co.uk>
> ---

Aside from what Sashiko and David have already said...

> +static u64 kvm_hv_restore_partition_time(struct kvm_vcpu *vcpu,
> +                                        struct kvm_hv_hcall *hc)
> +{
> +       struct kvm_hv *hv =3D to_kvm_hv(vcpu->kvm);
> +       struct hv_input_restore_partition_time in;
> +
> +       BUILD_BUG_ON(sizeof(in) !=3D 32);
> +
> +       if (kvm_vcpu_read_guest(vcpu, hc->ingpa, &in, sizeof(in)))
> +               return HV_STATUS_INVALID_HYPERCALL_INPUT;

Nit: some validation checks are missing here. Per the TLFS, hypercall
input parameters must be 8-byte aligned and must not cross a page
boundary (cf. kvm_hvcall_signal_event()).

> +       if (in.reserved)
> +               return HV_STATUS_INVALID_HYPERCALL_INPUT;
> +       if (in.partition_id !=3D HV_PARTITION_ID_SELF)
> +               return HV_STATUS_INVALID_PARTITION_ID;
> +
> +       /* The guest asked for the step; recompute the TSC page as for it=
s own write. */
> +       mutex_lock(&hv->hv_lock);
> +       if (hv->hv_tsc_page & HV_X64_MSR_TSC_REFERENCE_ENABLE)
> +               hv->hv_tsc_page_status =3D HV_TSC_PAGE_GUEST_CHANGED;
> +       mutex_unlock(&hv->hv_lock);

I think there's a window here in which another vCPU can consume
HV_TSC_PAGE_GUEST_CHANGED before kvm_set_clock_and_tsc() steps the
clocks. If TSC emulation control is enabled,
kvm_hv_request_tsc_page_update() won't invalidate the resulting stale
TSC page.

> +       kvm_set_clock_and_tsc(vcpu->kvm, in.reference_time_in_100ns * 100=
, in.tsc);

When stepping the reference time forward, don't we have to recalculate
the hrtimer deadlines associated with armed synthetic timers?
Otherwise, those hrtimers will fire late.
