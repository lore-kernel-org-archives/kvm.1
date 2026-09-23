Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 316EA4E323D
	for <kvm@vger.kernel.org>; Wed, 23 Sep 2026 17:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790183624; cv=none; b=nCdhUocfAWtfzigU7bFjRmS91RtvLO6nb0KtxkqRqrBhhoU0Is9YBp+CsGxnnp0r4shN2vnqPPQ8MjA/LssDjyXncZTXQlyzdclt5F+66tZXHDYT+TmF+07U/hoCM2sPcHAm37MA7MjFy3XQs+b0q1f7DJ2OHBeAzJph8eTkLuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790183624; c=relaxed/simple;
	bh=j25IDjqnZ2B+O9BFrffaf2s+85pCbwoElmfY2yAkYvw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gSNZ5vDzPwlLMRIMGPsKb1CaLpGnIYyN1b0n9qsor28MKNzaEWFedlsn9NaeqogOLlL7CvxZ6ET/483A5XW/Mrc2VcCpvszLm7nMbu59xNinwyvZ4E6pun2FCcBiXYqlaU8jTRUXCr7kMFl645GvHMeyGX+oCnbx4oLviUjkAlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DzzkHNOr; arc=none smtp.client-ip=209.85.216.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DzzkHNOr"
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-398dcfabbf8so2586681a91.0
        for <kvm@vger.kernel.org>; Wed, 23 Sep 2026 10:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790183622; x=1790788422; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=DfGbxY9fQpk1HNaK1cUtE5h3XKD5TipRYi2NYb+dVLk=;
        b=DzzkHNOrsQqiJFA42KYj3F7lTtJyH1POJm7v0juwHJ+y1fv2D2Z3NGC76mchH8UxWI
         Jtv8r012HqDMQHOJh/6a8EeEAcdiOcMRDOx6oLNNNlETRyfqMMXf47CHODhXsDAhsbrU
         h+zJfPVm3ORu7QtsDmlTur5aWlQnTn87wR8rF4Zu+W91oJlFdNNkXuXndxZlSsot/Z7l
         OR3RE/3Rq4eOrbk+avnxHUC7WGFL6wEfoZjuIK4EGlzZcTzAPdMPyifNyTcUUh87bPxU
         YMi1uLetPNAwM/qSEB7phDnlXiVY6/bgIhsZhS5U+9u+iSOWaY/L82CjRUao0Wo2XdDh
         3m7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790183622; x=1790788422;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DfGbxY9fQpk1HNaK1cUtE5h3XKD5TipRYi2NYb+dVLk=;
        b=tlz0Tq0FOOTjx535jjjEl7AmOWFYw1p2khdHBhAj00HBAzSmE/DJqN84Atq2Am6FTc
         HcrPj0yrd0DGCrBYfIGVSZSwA+k3vXmOpgoEtzLLqevLNWP+c0MPZpXRRrkf+SDBaslN
         a76BoX+wJZLyX7WaPmmZt9j4zP5OpKHh1Iznycdf7I3QJ4QZ7Lq+ti/c/pc/g4TPwAUV
         gbA9kEJ5fxOEs0yoaC8ruE1vgVhVUUbdklg9EfAgrsSjFAB1uInfImAeNMoydLtpSgFy
         Smvoy0u5IDX3Ldx0aJ8Hc8RQbzOS1GUQR25x0QODQfQBbl3jSmo8ibhxnk6jrQHpSVsv
         6pww==
X-Gm-Message-State: AFuF++l3Mf0rKhwMmawK+jLlvulHLLTdOdE2SpZKqhVnmD2sWcc9FRzC
	ZOl1+5x6H2KxdgOMgv1qwZ2JCDnSoMZngiiisbwWmOi5KsS6n2KZpwQA5/VJnZCbIZb+Zku4+Qt
	tcLrN7Q==
X-Received: from plar5.prod.google.com ([2002:a17:902:c7c5:b0:2dd:c066:f5c4])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f693:b0:2dd:b20b:76c8
 with SMTP id d9443c01a7336-2df69d3aae3mr29300185ad.16.1790183622104; Wed, 23
 Sep 2026 10:13:42 -0700 (PDT)
Date: Wed, 23 Sep 2026 10:13:41 -0700
In-Reply-To: <20260923164348.2DB2D1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260923163315.1580860-1-seanjc@google.com> <20260923164348.2DB2D1F000FF@smtp.kernel.org>
Message-ID: <arQIxfjw-2s-vsVL@google.com>
Subject: Re: [PATCH] KVM: TDX: Synthesize SHUTDOWN instead of returning -EIO
 on unhandled EPT violation
From: Sean Christopherson <seanjc@google.com>
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 23, 2026, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [High] kvm: tdx: host log spam via repeated KVM_RUN on unhandled EPT vi=
olation
> --
>=20
> commit 8eacf1c465f7e8b6cb99f1f4dae3c4af3bcde33c
> Author: Sean Christopherson <seanjc@google.com>
>=20
> KVM: TDX: Synthesize SHUTDOWN instead of returning -EIO on unhandled EPT =
violation
>=20
> This commit synthesizes a triple fault instead of returning -EIO when KVM
> encounters an EPT Violation from a guest accessing a pending page. This g=
ives
> userspace the option to keep the VM alive or reboot it, rather than treat=
ing
> the situation as a fatal KVM bug.
>=20
> > diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
> > index 7173ef3fc398e..eb82f739a7c04 100644
> > --- a/arch/x86/kvm/vmx/tdx.c
> > +++ b/arch/x86/kvm/vmx/tdx.c
> [ ... ]
> > @@ -1938,8 +1938,8 @@ static int tdx_handle_ept_violation(struct kvm_vc=
pu *vcpu)
> >  		if (tdx_is_sept_violation_unexpected_pending(vcpu)) {
> >  			pr_warn("Guest access before accepting 0x%llx on vCPU %d\n",
> >  				gpa, vcpu->vcpu_id);
> > -			kvm_vm_dead(vcpu->kvm);
> > -			return -EIO;
> > +			kvm_make_request(KVM_REQ_TRIPLE_FAULT, vcpu);
> > +			return 1;
>=20
> [Severity: High]
> Will this change allow a malicious or buggy userspace VMM to flood the ho=
st
> kernel log?

Well, a malicious VMM could already spam the logs, e.g. by creating a new V=
M or
or spinning up a huge number of VMs.  I.e. this is a pre-existing issue.  B=
ut I
agree that it should be ratelimited (or maybe converted to vcpu_debug_ratel=
imited()?).

> By replacing kvm_vm_dead() with KVM_REQ_TRIPLE_FAULT and returning 1, KVM
> will clear the request during vcpu_enter_guest() and exit to userspace wi=
th
> KVM_EXIT_SHUTDOWN. If the VMM ignores this exit and repeatedly calls KVM_=
RUN
> without resetting the vCPU, KVM will immediately re-enter the guest.
>=20
> The guest will hit the exact same unexpected SEPT violation in
> tdx_handle_ept_violation(), triggering this unconditional pr_warn() again=
.
> This can create an infinite loop that spams dmesg.
>=20
> >  		}
> >  		/*
> >  		 * Always treat SEPT violations as write faults.  Ignore the
> [ ... ]
>=20
> --=20
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923163315.15=
80860-1-seanjc@google.com?part=3D1
