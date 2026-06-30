Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FCF31E47C5
	for <kvm@vger.kernel.org>; Tue, 30 Jun 2026 22:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782859045; cv=none; b=IZMD7haXfvC4j5j9w275PcrbikVVmc8fXnIJJDdyPA0X22pBxfAMUGZD2Bb5l7OE2bm48jvp/gG1ccM0HhfUG4kfj3nyibNN9ISzo20cl/xjmwvkMuX/UNSeF2WAf6ByEqESZ0VRcC5AMBYltXxT/vOIznvUHlTCHkt8+qv/bD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782859045; c=relaxed/simple;
	bh=aWtuKFGzAuCNS/JHZrhHcatD/RguI5+JFKESa3LI7d8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RTUPGyu7ul29yAgFG+isyles0fVximiEhp457zGIviyK8edxmdMOfPDvTSfGDeNesxxBFAN2kYWnUHLwVp4M7Nr4777NLn5ps01dxxA/cWs071IX9VNHvwCkGzC+/09ls1bOLCf/RBWxMB/omSkyoAeMDMpPHu0iFbG1qbofQx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=b10WfLih; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b10WfLih"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2ca0d4fb061so317065ad.3
        for <kvm@vger.kernel.org>; Tue, 30 Jun 2026 15:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782859043; x=1783463843; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eljPZsDOaJcdbco2D0t3n+hqFqO7xvyA7T4+wpi5jV8=;
        b=b10WfLihvKgy69IPzAnLP/2FtMA/mcIpPY8MU742/wQq5GfFDnu2qbK8Taxv/wN5+a
         UEh4/1Ie710C38OE+QLMjYxwSe7AqwFYO50vamlJ0NiIcCIuo26dQg8h23Y71vpkQRRY
         msY7LiCZHXk58a1ozpCF4PSMmorkgq0FvAYf7Cx77iZ3KiPpJD4jAHyhUqXZ/CPQtb9m
         /GT3MwuKjAEuxftnYlg99tqo3Z2wORom+9PSVHUOPTmxMEGa1mzNzYQAx9DxVwiQwPCO
         LahCXf7k8qVSHQB8mogAyq6Ju7wEzRO7jxAqeW/QZxBvrP4QcE596ZkNpNX5uYJH/FO1
         vddQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782859043; x=1783463843;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=eljPZsDOaJcdbco2D0t3n+hqFqO7xvyA7T4+wpi5jV8=;
        b=eFOLq5JViG9xSK2wkcAM0cQt7TbQZ6SYN6u+N2iQ7Ihiq4IShAq1XUBTIUTJ9oTh9q
         cfsPwlaQBJtPzGl6b2lqg58OlmnKPZPRBGQX5N+BLfd60XMI0N2pgcvsHCHvxROhk8Rg
         xaXwLm7TBYF8SwWYRVubI3cwKBru7bbg4dyzdXUlUkvrtalmot+Mf2XYA++1R6deshXd
         Eq2IYwpNUW00WaPtZNFv0SBMCoFC/ev3ay1dHDtzIYV/9nwNC0Y9L+ztHkyWpj9tx+Nn
         e4xuT1b8Ul4RS1Zd88ieFIs+cLkv+I6NDxZ0Lnb0rVCPRI3jjd94KQknA75k8EWIIe9V
         MPng==
X-Gm-Message-State: AOJu0YzbMOSqAyWTXbcZtOtKIwENHKvhem4U3EPxfc3G5QB033RU4g59
	x4Oc7pFueij1/dDVeHD9HqH52GhrbNqaUI+7XN12WB/BoF63ijgUWH+SjWRX11eUarBzc9CB46e
	CZzyH6Q==
X-Received: from plzt6.prod.google.com ([2002:a17:902:bc46:b0:2b0:c9c5:109b])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:41d1:b0:2c9:9927:a060
 with SMTP id d9443c01a7336-2ca2ed3191emr45662975ad.24.1782859043137; Tue, 30
 Jun 2026 15:37:23 -0700 (PDT)
Date: Tue, 30 Jun 2026 15:37:22 -0700
In-Reply-To: <20260625225058.477381F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260625223623.3376478-1-seanjc@google.com> <20260625223623.3376478-5-seanjc@google.com>
 <20260625225058.477381F000E9@smtp.kernel.org>
Message-ID: <akRFIpV3ajPZeI39@google.com>
Subject: Re: [PATCH v3 04/10] KVM: x86/xen: Punt singleshot timer hcalls to
 userspace if Xen vCPU ID isn't set
From: Sean Christopherson <seanjc@google.com>
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 25, 2026, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issu=
e(s) to consider:
> >  	switch (cmd) {
> >  	case VCPUOP_set_singleshot_timer:
> >  		if (vcpu->arch.xen.vcpu_id !=3D vcpu_id) {
> [ ... ]
> > @@ -2299,7 +2303,7 @@ static bool kvm_xen_hcall_evtchn_send(struct kvm_=
vcpu *vcpu, u64 param, u64 *r)
> > =20
> >  void kvm_xen_init_vcpu(struct kvm_vcpu *vcpu)
> >  {
> > -	vcpu->arch.xen.vcpu_id =3D vcpu->vcpu_idx;
> > +	vcpu->arch.xen.vcpu_id =3D XEN_VCPU_ID_INVALID;
>=20
> [Severity: High]
> Does this initialization break live migration when the ID isn't configure=
d?

If userspace actually read the ID from KVM and migrated it blindly, but AFA=
IK
no VMM even uses KVM_GET_XEN_VCPU_ATTR to get the ID.

> When userspace calls KVM_GET_XEN_VCPU_ATTR, it retrieves the uninitialize=
d ID
> as XEN_VCPU_ID_INVALID (which is U32_MAX).
>=20
> On the destination host, attempting to restore this state fails because
> kvm_xen_vcpu_set_attr() explicitly rejects values >=3D KVM_MAX_VCPUS:
>=20
> arch/x86/kvm/xen.c:kvm_xen_vcpu_set_attr() {
>     ...
>     case KVM_XEN_VCPU_ATTR_TYPE_VCPU_ID:
>         if (data->u.vcpu_id >=3D KVM_MAX_VCPUS)
>             r =3D -EINVAL;
>         else {
>     ...
> }
>=20
> Will this cause KVM to unconditionally reject the valid state returned by
> GET_ATTR and return -EINVAL during live migration?
>=20
> >  	vcpu->arch.xen.poll_evtchn =3D 0;
> > =20
> >  	timer_setup(&vcpu->arch.xen.poll_timer, cancel_evtchn_poll, 0);
>=20
> --=20
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260625223623.33=
76478-1-seanjc@google.com?part=3D4
