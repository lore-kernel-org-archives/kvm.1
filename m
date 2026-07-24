Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFDDF3F1678
	for <kvm@vger.kernel.org>; Fri, 24 Jul 2026 21:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784927846; cv=none; b=UN1Xmpp+XNchpO+OdALD9cML9eVGMtUNlVNXvePn2uzOQuoeFRKIr26KhzFk6i7FbA7dNdNBbBcmM9zDjkKW4WNTjfY9sjSwbq0xJn6a8RUnRdxrgMKVab+SYkMnAlX2AbjKkoGGRCYXI8y59ZkLNr/fUIGXXpePqJICqeZ9zCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784927846; c=relaxed/simple;
	bh=A1ohHqyasTrE7IFcPXT/Ay7uy/1GkA+zNxiSFGKkiR8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=F/I3ji7ZpcrIzo3xJXKrxhH6J2TbUWolLJHMxb79rIrxLDnj3Df7aV6wZDz8HGL5MwG3KCAzohbxlbdDnZUwDuxRj82UDObQvU4htEixBeFJCnsJDg2qnzgOV+6C+tvVdlbfZtEbkI9XRkNHYkNp7YYoVKTIsGg20XhiC3Y2zzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nsKiSGK4; arc=none smtp.client-ip=209.85.215.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nsKiSGK4"
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-ca7c1e22995so1299811a12.3
        for <kvm@vger.kernel.org>; Fri, 24 Jul 2026 14:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784927840; x=1785532640; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qaDJGo3QzvQFzPZvOWzcRrVUb5WUbdae9wGlen05sOY=;
        b=nsKiSGK4ssC1k/ErB/JZT6ulmC2uTc/+uMIeTJNFDwOHl49l2Il3ES/P5eI4eLTLzd
         ELXpFXbpjKEBQS2b/55aEDKDBcP0fzuPryJXcIn8opWa3uOAmlgMeI6w7mEytrtGjS76
         Bjo3zxUP+/Dk+Tu+zzRhamslDcEk4up7m4IqN4n9VWLJYZoKmDz7A9i/E+zKdMeUH4Zn
         lHbIdUt/ap6XBOnZ3Kn2j0Xyo+Vo97ZC30SSdgMmm4qaKzOFf8XQ88zu3d62b8ihTRJJ
         MRFvVqutTtSlnYPOkFyUDtvEIIivF/XPLdjebQzUtilviGCuxGme7Gd3+f0M6ghZWJIs
         Qujw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784927840; x=1785532640;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qaDJGo3QzvQFzPZvOWzcRrVUb5WUbdae9wGlen05sOY=;
        b=SYobpd6Clp6MYwz837mRRpPncrfcBf5mJnSTclCrnErT3vG8QPz0s38n0fxTnQh14L
         y0FJYbv5T+5UgHsNvs119Tzgb+76sY7u+3Z+J1iBiqZafFTGdLba346EMmGl6tPaG71d
         9Rp/qN4+C1tIaoQE47qTPfUn7LhNlqqhWZpWh/Roi0+EfL+1s2KOsgRV1IvOrgoBnKm9
         17eDmRV/jc2CGDw5XYjzGioSx9Gj60Tjq7Fojt+dJDcJP4ZUMVwUHGhZFMVpGxU19mPN
         Hqj68x09LWHXmGyW12mvnyo5VzTNo1610ve6o9uodBeomuOfvCpd2958M5Ilbu8dkpzI
         a+CA==
X-Forwarded-Encrypted: i=1; AHgh+RprwgUE3SrF/j2awQDRiJHCEsnM87yrD3Bres3QX+kd59oMKYbecHKTEwyQ6luBNQ+Dr9o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOFqOuifTv5vsFW4fe10aSneG2Sgcj5HyYvCn3en63pOPKsO2a
	oS7SL0frU89qJN3DD1Oy+PS+wMe9XDGlVcJK69bq7bXNb8iP9jDv18QXnKZdwX1wr+YleuGBt/E
	Jal6Xaw==
X-Received: from pgac25.prod.google.com ([2002:a05:6a02:2959:b0:c8d:62a8:ee35])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:3993:b0:3c0:9c19:65b4
 with SMTP id adf61e73a8af0-3c67e19bcedmr3486637.76.1784927839948; Fri, 24 Jul
 2026 14:17:19 -0700 (PDT)
Date: Fri, 24 Jul 2026 14:17:19 -0700
In-Reply-To: <20260703212145.343527-6-dwmw2@infradead.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260703212145.343527-1-dwmw2@infradead.org> <20260703212145.343527-6-dwmw2@infradead.org>
Message-ID: <amPWX8lKXw2KS_kZ@google.com>
Subject: Re: [PATCH v6 05/36] KVM: x86: Add KVM_[GS]ET_CLOCK_GUEST for
 accurate KVM clock migration
From: Sean Christopherson <seanjc@google.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, Juergen Gross <jgross@suse.com>, 
	Boris Ostrovsky <boris.ostrovsky@oracle.com>, Paul Durrant <paul@xen.org>, 
	Jonathan Cameron <jic23@kernel.org>, Sascha Bischoff <Sascha.Bischoff@arm.com>, 
	Marc Zyngier <maz@kernel.org>, Joey Gouly <joey.gouly@arm.com>, Jack Allister <jalliste@amazon.com>, 
	Dongli Zhang <dongli.zhang@oracle.com>, joe.jin@oracle.com, kvm@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	xen-devel@lists.xenproject.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Fri, Jul 03, 2026, David Woodhouse wrote:
> From: Jack Allister <jalliste@amazon.com>
> 
> In the common case (where kvm->arch.use_master_clock is true), the KVM
> clock is defined as a simple arithmetic function of the guest TSC, based
> on a reference point stored in kvm->arch.master_kernel_ns and
> kvm->arch.master_cycle_now.
> 
> The existing KVM_[GS]ET_CLOCK functionality does not allow for this
> relationship to be precisely saved and restored by userspace. All it can
> currently do is set the KVM clock at a given UTC reference time, which
> is necessarily imprecise.
> 
> So on live update, the guest TSC can remain cycle accurate at precisely
> the same offset from the host TSC, but there is no way for userspace to
> restore the KVM clock accurately.
> 
> Even on live migration to a new host, where the accuracy of the guest
> time-keeping is fundamentally limited by the accuracy of wallclock
> synchronization between the source and destination hosts, the clock jump
> experienced by the guest's TSC and its KVM clock should at least be
> *consistent*. Even when the guest TSC suffers a discontinuity, its KVM
> clock should still remain the *same* arithmetic function of the guest
> TSC, and not suffer an *additional* discontinuity.
> 
> To allow for accurate migration of the KVM clock, add per-vCPU ioctls
> which save and restore the actual PV clock info in
> pvclock_vcpu_time_info.
> 
> The restoration in KVM_SET_CLOCK_GUEST works by creating a new reference
> point in time just as kvm_update_masterclock() does, and calculating the
> corresponding guest TSC value. This guest TSC value is then passed
> through the user-provided pvclock structure to generate the *intended*
> KVM clock value at that point in time, and through the *actual* KVM
> clock calculation. Then kvm->arch.kvmclock_offset is adjusted to
> eliminate the difference.
> 
> Where kvm->arch.use_master_clock is false (because the host TSC is
> unreliable, or the guest TSCs are configured strangely), the KVM clock
> is *not* defined as a function of the guest TSC so KVM_GET_CLOCK_GUEST
> returns an error. In this case, as documented, userspace shall use the
> legacy KVM_GET_CLOCK ioctl. The loss of precision is acceptable in this
> case since the clocks are imprecise in this mode anyway.
> 
> On *restoration*, if kvm->arch.use_master_clock is false, an error is
> returned for similar reasons and userspace shall fall back to using
> KVM_SET_CLOCK. This does mean that, as documented, userspace needs to
> use *both* KVM_GET_CLOCK_GUEST and KVM_GET_CLOCK and send both results
> with the migration data (unless the intent is to refuse to resume on a
> host with bad TSC).

Please post this as a standalone mini-series.  AFAICT, the only dependency of
any kind is a minor conflict with the s/hw_tsc_khz/hw_tsc_hz change, and that's
trivial to sort out later on.

I'm comfortable stumbling my way through the clock fixes, but I want Paolo (and
others) eyeballs on new uAPI like this.  And because this series is plenty big
without this one :-)

> Co-developed-by: David Woodhouse <dwmw@amazon.co.uk>
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> Signed-off-by: Jack Allister <jalliste@amazon.com>
> Reviewed-by: Paul Durrant <paul@xen.org>
> Cc: Dongli Zhang <dongli.zhang@oracle.com>
> Tested-by: Dongli Zhang <dongli.zhang@oracle.com>
> ---
>  Documentation/virt/kvm/api.rst  |  37 +++++++
>  arch/x86/include/uapi/asm/kvm.h |   1 +
>  arch/x86/kvm/x86.c              | 171 ++++++++++++++++++++++++++++++++
>  include/uapi/linux/kvm.h        |   3 +
>  4 files changed, 212 insertions(+)
> 
> diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
> index 52bbbb553ce1..2268b4442df6 100644
> --- a/Documentation/virt/kvm/api.rst
> +++ b/Documentation/virt/kvm/api.rst
> @@ -6553,6 +6553,43 @@ KVM_S390_KEYOP_SSKE
>    Sets the storage key for the guest address ``guest_addr`` to the key
>    specified in ``key``, returning the previous value in ``key``.
>  
> +4.145 KVM_GET_CLOCK_GUEST
> +----------------------------
> +
> +:Capability: none

Why not add a CAP?  The check in the subsequent selftest is quite gross.
