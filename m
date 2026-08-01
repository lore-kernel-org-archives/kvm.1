Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5551357D1D
	for <kvm@vger.kernel.org>; Sat,  1 Aug 2026 06:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785564826; cv=none; b=XH7q60TfBLPukM9r6E7ih/xktaPVmf6NAs5SLLziZRrddRiqMWnVI5+BQutlycljdgPzcGBDniGW3vb3jAzaxcxrWdZcUS0KM6ghWExew4P97b5P5QOFAGkjkX8tTS4kHElxKfiHAbNK73wQhLzfQN1sMN4xiUqbyKw0zyHSbnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785564826; c=relaxed/simple;
	bh=F/0TQKobzq9nRsArNLQM3n02a+QIDfwK7oyy7ZMcCJs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dTboTz9ARsMUkViVJBF8AK/jFHttogL66XW/Dvd43yw2E8psbcQHcgNL2d3S/AEsyHW34M3yRWvm61cnnyqUCIcmS1IQj+KG8H3arDyG6NBWTvmrbPHyMMcBe2DHx0o34n2fn53etFfJvhqEanAaISpXYQO8NUd5yGRvkVcWfmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k5rEHTyf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k5rEHTyf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C9871F00ACA
	for <kvm@vger.kernel.org>; Sat,  1 Aug 2026 06:13:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785564825;
	bh=Gk1flL7AiM6xla5vM/j5YFBuEUmKoPYV+2/r01MtSwc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=k5rEHTyf2eZCCzzPAs1OEg39hZ+OBSssrXDMpY2G40wijotKGQYo4IpoBWt219sJV
	 LPJW9OARlH4bnnOJCyvxlEZAfma2pZEEu+2UnzuZcxky+TlBz1zl+AvyqTAjktd+wF
	 kAZka4k0J34A77+vTLsBP7CtfU3csVuPbQOOxCLr49tuNRHVMhpcgvewUsJfDc5zPz
	 KS8cElzHVCNAJSQ7CAQApmbTorsh2VIanVvQ6YQg0fI1zV9QUmi48hK4Zy/MsmAG8o
	 jACWRevxUMTmRoV4nmAdVygRUpEQ/NFUQUkNMkuf5rsO+8ZVbxv8IrWsw0FctwJGWU
	 zOctHwzUi4ggw==
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-69c1220bd51so2807065a12.3
        for <kvm@vger.kernel.org>; Fri, 31 Jul 2026 23:13:45 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rp/d/DsK1v9jDdD075wbQowOWZe+odUPpBX2IrsncGjD3H/qtFWxCm5Ss3gj7BA4/mw1Ww=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2nxdrnz9qo1hPWOxNQbVpkT4JgIY3Utt/Jag8AKmOdx08ymXo
	5kAUYSfaWorD7jg7VukFhhxf6hahJXArcVNTYdqOKKMG//BGWg1yQ9k/h7n2J/IGIWNoez1x6kf
	5NWTfZk7/J0Uc2Nnil5Wep5opvtCm8wU=
X-Received: by 2002:a17:907:c14:b0:c15:b4f3:6d25 with SMTP id
 a640c23a62f3a-c1fe80ca46emr148750066b.19.1785564824192; Fri, 31 Jul 2026
 23:13:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260728003557.1136583-1-yosry@kernel.org> <20260728003557.1136583-4-yosry@kernel.org>
In-Reply-To: <20260728003557.1136583-4-yosry@kernel.org>
From: Yosry Ahmed <yosry@kernel.org>
Date: Fri, 31 Jul 2026 23:13:32 -0700
X-Gmail-Original-Message-ID: <CAO9r8zNxs-xLGqLL+4nja5UdRrhfM7NjLFZrSJW16a=44nEL_w@mail.gmail.com>
X-Gm-Features: AUfX_mxyN3tfn74RsCUuZ0xJQtiBqYT89GPCbgPOwOqZLfu2IQkXhoQxtiS5kpg
Message-ID: <CAO9r8zNxs-xLGqLL+4nja5UdRrhfM7NjLFZrSJW16a=44nEL_w@mail.gmail.com>
Subject: Re: [PATCH v1 03/28] KVM: VMX: Generalize VPID allocation to be vendor-neutral
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jim Mattson <jmattson@google.com>, 
	Maxim Levitsky <mlevitsk@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> @@ -8711,8 +8685,6 @@ __init int vmx_hardware_setup(void)
>         kvm_caps.has_bus_lock_exit = cpu_has_vmx_bus_lock_detection();
>         kvm_caps.has_notify_vmexit = cpu_has_notify_vmexit();
>
> -       set_bit(0, vmx_vpid_bitmap); /* 0 is reserved for host */
> -
>         if (enable_ept)
>                 kvm_mmu_set_ept_masks(enable_ept_ad_bits);
>         else
> @@ -8777,6 +8749,10 @@ __init int vmx_hardware_setup(void)
>
>         vmx_set_cpu_caps();
>
> +       r = init_vpids();
> +       if (r)
> +               return r;
> +

From internal Sashiko:
---
If tdx_hardware_setup() fails after vmx_hardware_setup() succeeds, will
this leak the dynamically allocated tlb_tags.bitmap?

Looking at vt_hardware_setup() in arch/x86/kvm/vmx/main.c:

arch/x86/kvm/vmx/main.c:vt_hardware_setup() {
        ...
        ret = vmx_hardware_setup();
        if (ret)
                return ret;
        return enable_tdx ? tdx_hardware_setup() : 0;
}

When tdx_hardware_setup() fails, it returns the error code directly without
calling vmx_hardware_unsetup(). KVM's core setup (kvm_x86_vendor_init)
expects vendor routines to handle their own partial initialization failures
and skips hardware_unsetup() if hardware_setup() fails.

Since this patch changes the VPID bitmap from a static array to a dynamic
allocation in init_vpids(), this error path will now leave tlb_tags.bitmap
permanently leaked on module initialization failure.

Does vt_hardware_setup() need to call vmx_hardware_unsetup() when TDX
setup fails to ensure the new dynamic allocations are freed?
---

I think this is a pre-existing issue. The allocations made by
nested_vmx_hardware_setup() are also not properly cleaned up.

>         /*
>          * Configure nested capabilities after core CPU capabilities so that
>          * nested support can be conditional on base support, e.g. so that KVM
> @@ -8784,8 +8760,10 @@ __init int vmx_hardware_setup(void)
>          */
>         if (nested) {
>                 r = nested_vmx_hardware_setup(kvm_vmx_exit_handlers);
> -               if (r)
> +               if (r) {
> +                       destroy_vpids();
>                         return r;
> +               }
>         }
>         vmx_nested_ops.enabled = nested;
>
