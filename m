Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6041037C10C
	for <kvm@vger.kernel.org>; Fri, 26 Jun 2026 14:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782483597; cv=none; b=QKDO4Me6pFjsjGS2C5/IVPRgAayQDVowcL3IGRsBaJJfYxuWIf7Xi2/8gHwJJuotwbBDe2ldwrOj6UgsrjrFYGW3I+KWRU5G7JZZt+2lwk0HpJfh7YjQdS3OIG+EUeG6WBy/2AvA6cdoX8qgStkH3BoSae4P9rCsuzEJL54Kzko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782483597; c=relaxed/simple;
	bh=qAEaykDtygaSoYnFmxE2YZNI+X4dYjPeG16wIErSTXs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Ilpz6bg/XjAJYHCp/MHOYXwhZEnHmhSJ8x8oxNSgf/BuCUmwbtz2btfOrJUAicmIIjFDl0VKoodM3yNMsN0D/tG/6q+xZb63YseShpA+JW9e5aGOETB7BZbquZGPXWUMothv6C9n010o4flje8EBRZgJ7VDAVMKdvOK3vF2dHYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uYJYpAwl; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uYJYpAwl"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c894c1c4aa9so574782a12.0
        for <kvm@vger.kernel.org>; Fri, 26 Jun 2026 07:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782483595; x=1783088395; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=grgJpjWYVMVO5CmpJCwranewTd9svoUmtrJ5rximOqA=;
        b=uYJYpAwlskqk0+JN00lG2kxUg0fT5RpfVeBbrheZsWe61Fkk0QIXhdQkVLcY18nK99
         MRcIPzLZ1x9RiJXe4BMmz0Ln/yiZEai/RaeriHlzGFXrAEsdspIoky4UuFZeo8kdAG4U
         vT0Z2AXA6tYrq6RbkHeqOTuGTRMI3Lf3STgIL5KHvISyXVrTDAmfKgEUUMQk6nCzqcqJ
         3NWAqwe3BBwNOfA7HHBjnBs+WNkdJ9PRaV50vC3IYvWY6dkAjXcx75jBAbrS7fuxOcn2
         fkUWKiH0rfNl57MNVnWG+jnxTCh7FHBPl1Fr/WYBH+/IoYLQubX/f5QTge4LOxV9R/U3
         4jpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782483595; x=1783088395;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=grgJpjWYVMVO5CmpJCwranewTd9svoUmtrJ5rximOqA=;
        b=qNnycd06vYspRguumVEjJ/NsLuQQ+1TbqHOF+zYVUR4sAqYQceBmvaxwsmlRPVR6G5
         HNZ7McilmStuEzDBqqJDi2bp1WSjI3vTUo/toGm+P0Bh5iVfjnLwz9li7UPtLc+zGh/u
         62qhEzIk2PvW6IY3gaVcvWF2/3BpE+ANJNdLidMNo2QoRcQHjmEl46eMho+PGyMcjeiG
         YsbCgC6TnjzmeAqYzyM/iu1JOeU0HubpRvYH9j51EJciXWicAP9w83q2N6T5lycfVp//
         NjU3Q3hyFhAOCBFdf1rMl2hPXhhn76LfyFC0el23/t2hyY32Glq2gcb9X90pfaSwU6YA
         +jgQ==
X-Forwarded-Encrypted: i=1; AHgh+RrRqJ/RfMD88PmGeBKWe/tvaoY/qVseTHS9GJzzyXMhnWE7MTwHg7v/jVLx2NxDZOI7f3g=@vger.kernel.org
X-Gm-Message-State: AOJu0YybEz52mAs3WifHYij8ZP2zD92mlFPclQshCrcQTRRAsbvbEqdD
	eWPrrcNoFAA/obziXv9TYoQ1rhUJ7YMTUv3Zp97nshZQT84wFOClLOQuF4hSDRIDB6aGqTiz5x4
	tWEW3gw==
X-Received: from pjblx10.prod.google.com ([2002:a17:90b:4b0a:b0:37d:8022:9ef5])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:d44f:b0:36b:9835:cf96
 with SMTP id 98e67ed59e1d1-37dfa1d4057mr6515782a91.2.1782483595335; Fri, 26
 Jun 2026 07:19:55 -0700 (PDT)
Date: Fri, 26 Jun 2026 07:19:54 -0700
In-Reply-To: <c574f7c48c2e4805fb63f38e7d31240ff4497aff.camel@infradead.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260625223623.3376478-1-seanjc@google.com> <20260625223623.3376478-6-seanjc@google.com>
 <c574f7c48c2e4805fb63f38e7d31240ff4497aff.camel@infradead.org>
Message-ID: <aj6KireObWQXDF-8@google.com>
Subject: Re: [PATCH v3 05/10] KVM: x86/xen: Consolidate checks on Xen vCPU ID
 for singleshot timer hypercalls
From: Sean Christopherson <seanjc@google.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Paul Durrant <paul@xen.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+5b32c49cd8f005e65654@syzkaller.appspotmail.com, 
	syzbot+5d2b94b77112148d1744@syzkaller.appspotmail.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 26, 2026, David Woodhouse wrote:
> On Thu, 2026-06-25 at 15:36 -0700, Sean Christopherson wrote:
> > Hoist the checks on the Xen vCPU ID when handling set_singleshot_timer =
and
> > stop_singleshot_timer hypercalls out of their individual case-statement=
s,
> > so that both checks on the ID are in common code.=C2=A0 kvm_xen_hcall_v=
cpu_op()
> > is already doubly committed to handling only singleshot timer hypercall=
s,
> > and even if that were to change in the future, the function could simpl=
y
> > be renamed and turned into a helper specifically for timer hypercalls.
> >=20
> > No functional change intended.
>=20
> Makes sense. In fact these hypercalls are the *only* VCPUOP_xxx calls
> for which Xen has that restriction (otherwise it would be pointless to
> have the vcpu argument at all). Which is why we did the check in the
> individual cases.

Sashiko pointed out that the patch is broken as-is, because the effective
"default" case will reject hypercalls if the vcpu_id doesn't match instead =
of
routing those to userspace.  The easiest way to deal with that is to pull t=
he
cmd check out of the switch-statement, e.g.

	struct vcpu_set_singleshot_timer oneshot;
	struct x86_exception e;

	if (cmd !=3D VCPUOP_set_singleshot_timer &&
	    cmd !=3D VCPUOP_stop_singleshot_timer)
		return false;

	if (!kvm_xen_timer_enabled(vcpu))
		return false;

	if (vcpu->arch.xen.vcpu_id !=3D vcpu_id) {
		*r =3D -EINVAL;
		return true;
	}

	if (cmd =3D=3D VCPUOP_set_singleshot_timer) {
		/*
		 * The only difference for 32-bit compat is the 4 bytes of
		 * padding after the interesting part of the structure. So
		 * for a faithful emulation of Xen we have to *try* to copy
		 * the padding and return -EFAULT if we can't. Otherwise we
		 * might as well just have copied the 12-byte 32-bit struct.
		 */
		BUILD_BUG_ON(offsetof(struct compat_vcpu_set_singleshot_timer, timeout_ab=
s_ns) !=3D
			     offsetof(struct vcpu_set_singleshot_timer, timeout_abs_ns));
		BUILD_BUG_ON(sizeof_field(struct compat_vcpu_set_singleshot_timer, timeou=
t_abs_ns) !=3D
			     sizeof_field(struct vcpu_set_singleshot_timer, timeout_abs_ns));
		BUILD_BUG_ON(offsetof(struct compat_vcpu_set_singleshot_timer, flags) !=
=3D
			     offsetof(struct vcpu_set_singleshot_timer, flags));
		BUILD_BUG_ON(sizeof_field(struct compat_vcpu_set_singleshot_timer, flags)=
 !=3D
			     sizeof_field(struct vcpu_set_singleshot_timer, flags));

		if (kvm_read_guest_virt(vcpu, param, &oneshot, longmode ? sizeof(oneshot)=
 :
					sizeof(struct compat_vcpu_set_singleshot_timer), &e)) {
			*r =3D -EFAULT;
			return true;
		}

		kvm_xen_start_timer(vcpu, oneshot.timeout_abs_ns, false);
	} else {
		kvm_xen_stop_timer(vcpu);
	}

	*r =3D 0;
	return true;

> But these are *also* the only VCPUOP calls we're ever likely to
> accelerate in the kernel, so that's actually fine. I would prefer to
> see a comment above the check though.

This?

	/*
	 * Reject the hypercall if the guest is trying to start/stop the timer
	 * for a different vCPU.  Xen per-vCPU hypercalls take a target vCPU as
	 * a common parameter, as all per-vCPU hypercalls *except* single-shot
	 * timer updates can be cross-vCPU.
	 */
	if (vcpu->arch.xen.vcpu_id !=3D vcpu_id) {
		*r =3D -EINVAL;
		return true;
	}

> And let's move your patch 4 to come *after* this semantic change.

Agreed.
