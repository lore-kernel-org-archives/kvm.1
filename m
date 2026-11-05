Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793922307;
	b=aOKzrVmECA6Mgyrviru6mi2kwhY9rQYWVXLCvwuBx+JD/u0nLVjcdFhA0sUiGKhIQpkN
	 5iBGmMeweaqypDL9sIl+JH6F6TLNELVI/HbsdS4A1nocipCKDHXotMIWu7DvaBZ4pYF9/
	 ZualkCQpKcKDjPvGFBAa2lPD0OS/S1NKOiZg0EDAshKCYLd5Mj/UN1VVmY0dumX9xuWVQ
	 3kJTDNDOvAbCZCKCCycyVpSIY8uKWqhfFTzRRGbA2YzmeMWmS02dW6/ReBZOA6wB2d6Ze
	 O+8R3IyvPjKz/+P9KMudjNhAHI1KafWP1AnzOrnQJzEU05iR3ptlYRq9pMOikIiawmQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793922307;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=edDhKItRW8EtVkwe/i27bL1ObCBirO0fdgpw4KAmG2I=;
	b=ZB8hC2jh4R4t6hVcBpkq2wqCNSLoVUVCw9UXbeg9g8GY9OJKt/UHCgPS4wAD/Ma8UgSV
	 YymoDc+p5Ur4dopz+Llx9sNt2Wrb+/CKK27jc2z/1AN+W1lvaU4uGGANZP53+XPVjxqHi
	 LAfZ6zRnjJacwQT5g1FQ/ChD9ZosmiP7vK431LDHzinnFRsBwqi+6Ux8WXKHl7rmdg0io
	 wWcsjanRbdZFSMdIyfal44lqSleS16WZ7hCR5HWxpJ0lhwOU0TqeBjUVNr9jqXR+ckGA0
	 pFddxHr+6Z5+Wn+BWXSXaleisUpPcVivqHOXLAzGeU+I9ggpLbWYvksJgJPfv0DALqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=CqYWtumZ;
	arc=none smtp.remote-ip=209.85.216.72
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FDEF606A31B
	for <kvm@vger.kernel.org>; Thu,  5 Nov 2026 23:45:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1FDEF606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=CqYWtumZ
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3b0a519048eso73600a91.1
        for <kvm@vger.kernel.org>; Thu, 05 Nov 2026 15:45:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793922306; x=1794527106; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=edDhKItRW8EtVkwe/i27bL1ObCBirO0fdgpw4KAmG2I=;
        b=CqYWtumZZ1ITRU57DLGw7y9WVijuzDMk4TryaRhIEokgpbYf3Sb6MBi9WNNY9XStIp
         dcteAcQVyXvPQO2bE1T5jH3uhZy7Y+/Dv1K/d6iJ/tCyI3eVaP5izVmgkzE4F0AlgFC3
         qEN+4qJ6+KwgeaTtL0gxQjwb14i5sByrqJDy+oi1s4rcspj9T0sFwn2Lve9IhErKRlqp
         dQ4u9zPY4yYV1JbXyUd+cbfLh/ulUZPbX5UUJz2C25Jmcb0q6GJeeifAMUOYavQHnwkF
         6sXwZSmNuaSJFBFqCuhcbuq4SoV9NwVqY6QyhTYGnH90F922UVftXHMKNpwOPq9YSFA+
         NxeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793922306; x=1794527106;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=edDhKItRW8EtVkwe/i27bL1ObCBirO0fdgpw4KAmG2I=;
        b=WOSWW30fHWEkzoLuda6WnC6r0uGzfIBZIGZA5Jxs/HtiJ9TcsYi6/6xeofHwDHlzLa
         OrcmB0Gou+SO2bmi952VRs2TYpK6HHYrlO/JA9liHmL+gIt3dLNu5i0KWQ0Lixwx/2L4
         8AfV1WoP1qAUgOBmkp40SjVLbpzUPH52Mqt3Iu8H5KgMZY//ZhdzjxdzL8JLJ4ovQlGy
         yOX+lhZ2m/ftafo0rJi5ZV+z+LDCJwG6JtElnavRG+HhKeWcC7gJIYaA70Cepy0qr7Et
         Qd2TG7IORYwWVZlT8U+TNp7phgA1wRanzE2cAQhWGP8kcL11iMqLE7wx/MldbqVSXpL3
         OC/g==
X-Gm-Message-State: APuU4Z9g8vdEhjopYRq6v/LiWCKlVfvPJN8jqyVXyvgm8M9KrqzjjXUY
	Nr/qRzjGnA8A7HGZp+7ghvZSxIa/IPWLMnfS3Bem9LLu67+Icdub6OF1o4T/lssLS5DR+UDfhgL
	CCIYk6w==
X-Received: from pjp16.prod.google.com ([2002:a17:90b:55d0:b0:3a8:1de3:a20e])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:ec87:b0:3ac:a1c7:20fd
 with SMTP id 98e67ed59e1d1-3b0db5edad3mr586400a91.4.1793922306059; Thu, 05
 Nov 2026 15:45:06 -0800 (PST)
Date: Thu, 5 Nov 2026 15:45:05 -0800
In-Reply-To: <58dcd595e3187d335e103a042d196cb7@panayotis.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <58dcd595e3187d335e103a042d196cb7@panayotis.com>
Message-ID: <au0VAbk3tXDy0p0W@google.com>
Subject: Re: nVMX: Windows 11 with nested Hyper-V fails to boot when MBEC is
 exposed to L1 (7.2)
From: Sean Christopherson <seanjc@google.com>
To: Panayotis Katsaloulis <panayotis@panayotis.com>
Cc: kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="us-ascii"

On Thu, Nov 05, 2026, Panayotis Katsaloulis wrote:
> Hi,
> 
> After updating the host from 7.1.13 to 7.2.9, a Windows 11 guest that
> runs its own hypervisor (VBS / Hyper-V, hypervisorlaunchtype Auto) no
> longer boots. It fails very early (no bugcheck, no minidump, bootstat
> not updated) and ends in Automatic Repair ("Your device ran into a
> problem and couldn't be repaired"). Startup Repair reports no root
> cause.
> 
> Hiding MBEC from the guest is enough to make it boot again:
> 
>   -cpu host,migratable=on,vmx=on,vmx-mbec=off,hv-...
> 
> Host:
>   CPU:      Intel Core i9-13900 (Raptor Lake)
>   Kernel:   7.2.9 (distro kernel, Manjaro), kvm_intel nested=Y, mbec=Y
>   QEMU:     11.1.2 (also reproduced with 11.1.1)
>   libvirt:  12.8.0
>   OVMF:     edk2 202608, Secure Boot, swtpm 0.10.2 (TPM 2.0, CRB)
>   Machine:  pc-q35-9.2

Paolo was theorizing that might be related to Hyper-V expecting PFEC_SS to be
set[1] (Hyper-V appears to enable CET if and only if MBEC/GMET is available).

And IIRC, the host and guest hangs from an early bug report[2] were due to bugs
in the host's handling of hrtimers that affected only KVM VMX, but I don't think
we ever explained the outright failure to boot.

Paolo, do we have any patches to try out, or more concrete ideas/theories?

[1] https://lore.kernel.org/all/20261012165651.130826-1-pbonzini@redhat.com
[2] https://lore.kernel.org/all/85548beb-1486-40f9-beb4-632c78e3360b@proxmox.com

> Guest:
>   Windows 11 24H2 (build 26100), UEFI + Secure Boot, VBS enabled,
>   hypervisorlaunchtype Auto, 8 GiB, host-passthrough CPU.
>   Hyper-V enlightenments: relaxed, vapic, spinlocks, vpindex, runtime,
>   synic, stimer, frequencies, tlbflush, ipi, evmcs, avic, hypervclock.
> 
> Results (host kernel 7.2.9 in all cases):
> 
>   vmx  vmx-mbec  hv-evmcs  QEMU    result
>   on   default   on        11.1.2  fails (Automatic Repair)
>   off  n/a       on        11.1.2  boots
>   on   default   on        11.1.1  fails
>   on   off       on        11.1.1  boots
>   on   default   off       11.1.1  fails
> 
> The same guest, with an identical QEMU command line (compared from the
> libvirt log; only fds/ids differ), last booted fine on 2026-10-23 on
> 7.1.13 with QEMU 11.1.1. So disabling eVMCS does not help, and QEMU
> and libvirt do not seem to be involved; the only difference that
> matters is whether MBEC is offered to L1.
> 
> What I could not test:
>   - 7.1.x with the exact same setup again (no longer installable here)
>   - latest 7.2.y / 7.3.y
>   - kvm_intel.mbec=0 (I expect it to behave like vmx-mbec=off)
> 
> Someone else reports the same symptom (7.1.8 works, 7.2.x fails,
> Windows 11 26100 with nested Hyper-V), without a root cause:
> https://discuss.cachyos.org/t/windows-11-kvm-guest-with-nested-hyper-v-boot-loops-on-linux-cachyos-7-2-x-works-on-7-1-8/36134
> 
> I can test patches or collect traces if that helps.
> 
> Thanks,
> Panayotis
> 
