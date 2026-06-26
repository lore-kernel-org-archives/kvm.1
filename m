Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE2F303CAE
	for <kvm@vger.kernel.org>; Fri, 26 Jun 2026 18:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782497562; cv=none; b=H9xUx2A5Lh8+/wCpizwqlqaTT8fkyrXUxy/Nm3o2RF8i8b61ovC/SQtGDHqAouB70EKBrCo4yZUIGC3qTCIaww2odMBfhXawY7oF+4HMmjgYickEzC6mifpKaR49lQPsI9c2pJgnr1UPDvXGvzPItOlRJuvs99dXVoylA4NsxP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782497562; c=relaxed/simple;
	bh=fs3A10aDXdMl8Lfh2BaU4hraJiP4la1QfA/aQRyXM7M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sYhqeGpOWXyHTTWRSQ+C6MmEKGBn9oEHu0BYg8kh/3JCRDqsKVnqLeq7mRMQh9ShiAZxSMNFEsVvvBw5+ex3SGgeMc+cXfbi1VyjOVkfnVrol7DbGtFsmfHU5koAk7GVlUh6kI8fWbPXEnva7aroA42WDhcaUZbCjW3G24KJegQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PMzuw1UT; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PMzuw1UT"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-36d8719bae6so1038752a91.3
        for <kvm@vger.kernel.org>; Fri, 26 Jun 2026 11:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782497559; x=1783102359; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gLVK1WZR0iDfScSkTqtApjN1rB6pMsaHoZ3NQbVYEXo=;
        b=PMzuw1UTK8wo0LXUQBcRkUpB3t5nuO69BtK9A3MdeiwK6QP+1bF5LgaRl9PA6b6ZKj
         E4d2PbalE5Dn55VV/Vfl0y2TLkeXxa9zf42BiKVf16PqtJncKji+3ubhnzoi7sW+yiza
         OKkYa22e/qnKkgS6OnaxXrn1iD1/tWl6OU+8tGV9AQdUXfALK295ro7QLASJYTE3p7q5
         hScKBbj1v2d+W0WxBWLkSuVJpPdJGyBxps+wcoyjRJhOg42NNDnDo7ttK443HKohjblm
         vtGvzgJm4GRc/mye9JZREED8tCbZReKiqJSwk8G0py0eZ8GM7GlGZ2y/zmcMa4BCHD66
         rqUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782497559; x=1783102359;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gLVK1WZR0iDfScSkTqtApjN1rB6pMsaHoZ3NQbVYEXo=;
        b=bWPaAOIbaQy2Q3ZfmxAHeSFBSNA1Si5zWcOJnQtwbDVp5w5uD7w1JiJfZ7izzX4+xM
         o9JRofJmYEqW5QcmF6IcTIcn7vR6hC5jRiuxcHOYWmgADMO87LLBZt1xxUTAeMsRkjq+
         QhnMK7kJZ5ZIH+SIiLdEDghe4Io3FG9ej+TajYAlGQ1CkdT/n4NFHKhbokRA7cDShWBV
         vNLk06rLIrDYIZfv96kv2YPbMZCp7OVOfWbLGJci0tPloNPSY5LQqMZO51h6TPtWHXnc
         4VJOmu96qIXbAFbfrITF2kFt4pBTUTSJqkwvER1qkuPYCu2nWrrp1kO0I28cBYPDMzI1
         tM/Q==
X-Forwarded-Encrypted: i=1; AHgh+RoM2udC7WHDdHZJX/MjGWZ2bLaz/rRFBVwNOkB039iB2k7Ot6E6f6BJCsVb1cmrgL3t6Ks=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyq9l5aEdI6FU+J6boz48R3k5WSIZDRBA199+rcaCc+ytfihQYN
	wmW5g61NddLNI4ZmBxgYiVDBkLO79aR9L3Cxh/lIgqf1L0PXqSDnwHKd/RqgsaJg7b/GJyaaS53
	iIOCf4g==
X-Received: from pgu9.prod.google.com ([2002:a63:1449:0:b0:c85:88eb:3619])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2ccc:b0:37d:f614:dbf
 with SMTP id 98e67ed59e1d1-37dfa17332amr6876722a91.10.1782497558938; Fri, 26
 Jun 2026 11:12:38 -0700 (PDT)
Date: Fri, 26 Jun 2026 11:12:38 -0700
In-Reply-To: <5838fbf9c799d135b06ba61b7879a231e314f7b5.camel@infradead.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260625223623.3376478-1-seanjc@google.com> <20260625223623.3376478-6-seanjc@google.com>
 <c574f7c48c2e4805fb63f38e7d31240ff4497aff.camel@infradead.org>
 <aj6KireObWQXDF-8@google.com> <5838fbf9c799d135b06ba61b7879a231e314f7b5.camel@infradead.org>
Message-ID: <aj7BFl5gzyS9n6zZ@google.com>
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
> On Fri, 2026-06-26 at 07:19 -0700, Sean Christopherson wrote:
> > On Fri, Jun 26, 2026, David Woodhouse wrote:
> > > On Thu, 2026-06-25 at 15:36 -0700, Sean Christopherson wrote:
> > > > Hoist the checks on the Xe
>=20
> +	if (vcpu->arch.xen.vcpu_id =3D=3D XEN_VCPU_ID_INVALID)
> > > > +		return false;n vCPU ID when handling set_singleshot_timer and
> > > > stop_singleshot_timer hypercalls out of their individual case-state=
ments,
> > > > so that both checks on the ID are in common code.=C2=A0 kvm_xen_hca=
ll_vcpu_op()
> > > > is already doubly committed to handling only singleshot timer hyper=
calls,
> > > > and even if that were to change in the future, the function could s=
imply
> > > > be renamed and turned into a helper specifically for timer hypercal=
ls.
> > > >=20
> > > > No functional change intended.
> > >=20
> > > Makes sense. In fact these hypercalls are the *only* VCPUOP_xxx calls
> > > for which Xen has that restriction (otherwise it would be pointless t=
o
> > > have the vcpu argument at all). Which is why we did the check in the
> > > individual cases.
> >=20
> > Sashiko pointed out that the patch is broken as-is, because the effecti=
ve
> > "default" case will reject hypercalls if the vcpu_id doesn't match inst=
ead of
> > routing those to userspace.=C2=A0 The easiest way to deal with that is =
to pull the
> > cmd check out of the switch-statement, e.g.
> >=20
> > 	struct vcpu_set_singleshot_timer oneshot;
> > 	struct x86_exception e;
> >=20
> > 	if (cmd !=3D VCPUOP_set_singleshot_timer &&
> > 	=C2=A0=C2=A0=C2=A0 cmd !=3D VCPUOP_stop_singleshot_timer)
> > 		return false;
> >=20
> > 	if (!kvm_xen_timer_enabled(vcpu))
> > 		return false;
> >=20
>=20
> You dropped the=20
>=20
> +	if (vcpu->arch.xen.vcpu_id =3D=3D XEN_VCPU_ID_INVALID)
> +		return false;
>=20
> part. Although that's kind of fair since I did ask you to put this
> patch first, before that.

Heh, it's still there, I just didn't include it in this snippet.

> But really, while this rearrangement you propose would work... this
> patch was intended as a cosmetic cleanup, and this seems less pretty
> than what we had before.

I disagree.  The old code uses a common check for kvm_xen_timer_enabled(), =
which
is confusing and actively dangerous, as evidenced by my goof, because it's =
easy
to miss that the only reason KVM can bail early for !kvm_xen_timer_enabled(=
) is
because it returns false.  Punting hypercalls that are never accelerated by=
 KVM
because some other hypercall happens to be disabled is nasty.

> How about keeping your patch 4 which just returns false for invalid
> vcpu_id, and dropping patch 5 completely? Or if you really want to
> tackle it, start with this...
>=20
> --- a/arch/x86/kvm/xen.c
> +++ b/arch/x86/kvm/xen.c
> @@ -1745,8 +1745,10 @@ int kvm_xen_hypercall(struct kvm_vcpu *vcpu)
>                                                  params[1], &r);
>                 break;
>         case __HYPERVISOR_vcpu_op:
> -               handled =3D kvm_xen_hcall_vcpu_op(vcpu, longmode, params[=
0], params[1],
> -                                               params[2], &r);
> +               if (params[0] =3D=3D VCPUOP_set_singleshot_timer ||
> +                   params[0] =3D=3D VCPUOP_stop_singleshot_timer)
> +                       handled =3D kvm_xen_hcall_vcpu_op(vcpu, longmode,=
 params[0], params[1],
> +                                                       params[2], &r);

But then kvm_xen_hcall_vcpu_op() is a misleading name, and this also splits=
 the
checks on @cmd.  E.g. even with this:

		if (params[0] !=3D VCPUOP_set_singleshot_timer &&
		    params[0] !=3D VCPUOP_stop_singleshot_timer)
			break;

		handled =3D kvm_xen_hcall_single_shot_timer(vcpu, longmode, params[0],
							  params[1], params[2], &r);
		break;

Then kvm_xen_hcall_single_shot_timer() either looks flawed if it does:

	if (cmd =3D=3D VCPUOP_set_singleshot_timer) {
		...

		kvm_xen_start_timer(vcpu, oneshot.timeout_abs_ns, false);
	} else {
		kvm_xen_stop_timer(vcpu);
	}

because it doesn't explicitly check that cmd is set_singleshot_timer or
stop_singleshot_timer.  We could do:

	if (cmd =3D=3D VCPUOP_set_singleshot_timer) {
		...

		kvm_xen_start_timer(vcpu, oneshot.timeout_abs_ns, false);
	} else {
		WARN_ON_ONCE(cmd !=3D VCPUOP_stop_singleshot_timer);

		kvm_xen_stop_timer(vcpu);
	}

but that's rather ridiculous given that there's exactly one path to this co=
de.

IMO, this:

	struct vcpu_set_singleshot_timer oneshot;
	struct x86_exception e;

	if (cmd !=3D VCPUOP_set_singleshot_timer &&
	    cmd !=3D VCPUOP_stop_singleshot_timer)
		return false;

	if (!kvm_xen_timer_enabled(vcpu))
		return false;

	if (vcpu->arch.xen.vcpu_id =3D=3D XEN_VCPU_ID_INVALID)
		return false;

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

is logically more sound and easier to read than what we currently have:

	struct vcpu_set_singleshot_timer oneshot;
	struct x86_exception e;

	if (!kvm_xen_timer_enabled(vcpu))
		return false;

	switch (cmd) {
	case VCPUOP_set_singleshot_timer:
		if (vcpu->arch.xen.vcpu_id !=3D vcpu_id) {
			*r =3D -EINVAL;
			return true;
		}

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
		*r =3D 0;
		return true;

	case VCPUOP_stop_singleshot_timer:
		if (vcpu->arch.xen.vcpu_id !=3D vcpu_id) {
			*r =3D -EINVAL;
			return true;
		}
		kvm_xen_stop_timer(vcpu);
		*r =3D 0;
		return true;
	}

	return false;

especially once the "vcpu->arch.xen.vcpu_id =3D=3D XEN_VCPU_ID_INVALID" che=
ck comes
along, because while this technically works, it's even more confusing becau=
se
vcpu->arch.xen.vcpu_id isn't necessarily check for the other ops, e.g. if @=
vcpu_id
targets a different vCPU.

	struct vcpu_set_singleshot_timer oneshot;
	struct x86_exception e;

	if (!kvm_xen_timer_enabled(vcpu))
		return false;

	if (vcpu->arch.xen.vcpu_id =3D=3D XEN_VCPU_ID_INVALID)
		return false;

	switch (cmd) {
	case VCPUOP_set_singleshot_timer:
		if (vcpu->arch.xen.vcpu_id !=3D vcpu_id) {
			*r =3D -EINVAL;
			return true;
		}

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
		*r =3D 0;
		return true;

	case VCPUOP_stop_singleshot_timer:
		if (vcpu->arch.xen.vcpu_id !=3D vcpu_id) {
			*r =3D -EINVAL;
			return true;
		}
		kvm_xen_stop_timer(vcpu);
		*r =3D 0;
		return true;
	}

	return false;
