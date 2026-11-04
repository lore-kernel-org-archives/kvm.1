Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793825732;
	b=BpVP2zkqdAG7ncxs5rk2yOhP677ccP6BCM72+xAcH/U4o5obNvze7cfscuAcvc2jWkcV
	 112TSP1fgRpU0nJus3r2PBHLUXFkeS40gkhMalvMbJZRzX303sMWMtci6uROsGQqHU6dG
	 I+Nl//UqDOzeG6hOhQl8EbougsHqggk092MdWWFeiI7YG4IioiprONMjGz5CrG1JJuyec
	 Y27qPeazdp5xlDC/FhVtlrLRSUR+lNL/WuQ9Ch6VDRH3kvvSpFPpxzbcSaoeTEc2kKp6G
	 Cds0geWFP1H0Iyh1mcSx+qRuioR4k6qdAWjU2ks6hvZBonQud293zTDsFM5eJENW7ig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793825732;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type:
	 Content-Transfer-Encoding;
	bh=nqmtpTylBeemZ9sXvm4RoTldTKYD0S9LlWDnxIkCY/A=;
	b=o3L0qMes27SKtiCXRtN5Gyd2mvXXUgFHz+bFd0fo+rMw+yr1BqFcAW3GYcmNC222Pou+
	 FkKAE9LiHvmCWu/IsNURpkC/0/UP5ogN2QxzmhH0le7AFIlG8bnKGQUmkrrnnxCjjhWnX
	 LTfpYxUUsxL1z/CsjYNpP5NIHUhvSgu2NkoOyKB63gvIxitG1K7AZSeWDO3b4vaJitBZM
	 73pEotBfMA9/MhiG5WIuqzmFii7UyRMt/OhU2PMpyd60xMbJNkxjKUvX2UUuvgGQed+0/
	 zXVTLv+27NBlbHl8TMORBbbIpmmN1WQypncotyhffdzAQ4NJgDEDPrlWfSpoPQYJJgg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="OhgCA7/e";
	arc=none smtp.remote-ip=209.85.214.198
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F135607873D
	for <kvm@vger.kernel.org>; Wed,  4 Nov 2026 20:55:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3F135607873D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=OhgCA7/e
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2e9501034c4so17579205ad.0
        for <kvm@vger.kernel.org>; Wed, 04 Nov 2026 12:55:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793825731; x=1794430531; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=nqmtpTylBeemZ9sXvm4RoTldTKYD0S9LlWDnxIkCY/A=;
        b=OhgCA7/eDy+wHi5EZlS4L7p3GIFl2IKNbRg1sogaykoMNjhMjGwT76scmha4eC4gtP
         FP+uLlDMDZfqyLspLTaTcNoIo43VxYq6JvSB2gBunX1nuzEt7KhY3YGOd+dvcDOgO83d
         jPdh+vnt4salXJuZztjEX67KxyzcQz5DxYu9XCFpdv2nx4qBH2LxBl8PUABp5uk3d3gg
         UeXOi/mfs1X09e8mfbTS96oDfsMMlE0J2b7xZ0kqxYT/m8p5p8a3jwnvr+7HX/AeM3UQ
         kNlOYXeuE4D1JAKO7B0WMJ5z0tiZkHJkkwuYsmUvv90qKlu27V8RFsQh30Ae/lsLU9Zx
         C8xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793825731; x=1794430531;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nqmtpTylBeemZ9sXvm4RoTldTKYD0S9LlWDnxIkCY/A=;
        b=HtIRhnl3m99+aHDovfHry+qvAGU21ITRPAM7KxAzc3tSmxpuQ+ypJQ6r5WEdH6wIEu
         q5D49gQ5gIhPJwt2t1w1pF/k5qYfvNuLBtnX7HIHaE/eH/JXkTHtxYmOn/Pw7tvxCpK9
         Bufhi5DdF4JLS/Yq1Ng/ZizNc6gN2k9QEscGdBXdLXoAcpXeUc8Jkng9DKyCgi23BpOw
         4bZ2kqD/CjC55yZuavulPX8+0VGWCQS6uKQNiZ5PjfpAMjiY/oRhF180Z3zzPDVKVGi1
         9YQThfBOs5vF/7fcL4woL5feEvRLmqgBBVuZjZtc4zlg6kWjqHb/2X9bc1cYXCc/EdIW
         KOnA==
X-Forwarded-Encrypted: i=1; AKwUvByZNo2yHLQUleEOmejwilvqjpbHct3UTxol3HYvFFZgzVkO1CfhOWEin4mNGK/Tb98RD6I=@vger.kernel.org
X-Gm-Message-State: APuU4Z9i4a8xYcom3K2EFj+FK4TrDphmsW/fihrbcwCP4xewSTF/hfyZ
	RmSOEZqHmwYZNEYc4u6EIHZqjSa9AXEnuhL3yodcHC1gVQRFlXjqku+tQzuzYnoPOc4ZQ3jcNdY
	3df3yCQ==
X-Received: from plbbf12.prod.google.com ([2002:a17:902:b90c:b0:2e9:5442:b91a])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:26cf:b0:2e9:b7ca:cd5e
 with SMTP id d9443c01a7336-2eb36523137mr166930145ad.62.1793825730369; Wed, 04
 Nov 2026 12:55:30 -0800 (PST)
Date: Wed, 4 Nov 2026 12:55:29 -0800
In-Reply-To: <CAO9r8zNy+r=dZFYthHQzOprD2xnMZ0OuC1SG_xJt10fs5iMjmw@mail.gmail.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261020234535.3182385-1-jmattson@google.com> <20261020234535.3182385-2-jmattson@google.com>
 <CAO9r8zNy+r=dZFYthHQzOprD2xnMZ0OuC1SG_xJt10fs5iMjmw@mail.gmail.com>
Message-ID: <auubwbLDZLy8ZkjR@google.com>
Subject: Re: [PATCH 1/4] KVM: SVM: Always update LBR MSR intercepts on full
 MSR intercept recalc
From: Sean Christopherson <seanjc@google.com>
To: Yosry Ahmed <yosry@kernel.org>
Cc: Jim Mattson <jmattson@google.com>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Like Xu <likexu@tencent.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 20, 2026, Yosry Ahmed wrote:
> On Tue, Oct 20, 2026 at 4:45=E2=80=AFPM Jim Mattson <jmattson@google.com>=
 wrote:
> > diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> > index fe0cba4731b2..55b3ee840365 100644
> > --- a/arch/x86/kvm/svm/svm.c
> > +++ b/arch/x86/kvm/svm/svm.c
> > @@ -721,14 +721,11 @@ void *svm_alloc_permissions_map(unsigned long siz=
e, gfp_t gfp_mask)
> >         return pm;
> >  }
> >
> > -static void svm_recalc_lbr_msr_intercepts(struct kvm_vcpu *vcpu)
> > +static void svm_set_lbr_msr_intercepts(struct kvm_vcpu *vcpu)
> >  {
> >         struct vcpu_svm *svm =3D to_svm(vcpu);
> >         bool intercept =3D !(svm->vmcb->control.misc_ctl2 & SVM_MISC2_E=
NABLE_V_LBR);
> >
> > -       if (intercept =3D=3D svm->lbr_msrs_intercepted)
> > -               return;
> > -
> >         svm_set_intercept_for_msr(vcpu, MSR_IA32_LASTBRANCHFROMIP, MSR_=
TYPE_RW, intercept);
> >         svm_set_intercept_for_msr(vcpu, MSR_IA32_LASTBRANCHTOIP, MSR_TY=
PE_RW, intercept);
> >         svm_set_intercept_for_msr(vcpu, MSR_IA32_LASTINTFROMIP, MSR_TYP=
E_RW, intercept);
> > @@ -740,6 +737,22 @@ static void svm_recalc_lbr_msr_intercepts(struct k=
vm_vcpu *vcpu)
> >         svm->lbr_msrs_intercepted =3D intercept;
>=20
> Hmm I was going to ask if we can set svm->lbr_msrs_intercepted based
> on whether or not svm_set_intercept_for_msr() actually set the
> intercept, so that it also captures intercepts due to MSR filtering. I
> assume that we didn't do this because MSR filters can result in
> different interception status for different LBR MSRs, and we don't
> want to track them individually?

NAK.  In the past, KVM had a bitmap to do exactly that, and it was a trainw=
reck.

> Hmm even if we do track them individually (e.g. as a bitmap), it would
> add a bit of complexity here because we'll need to plumb that into
> svm_set_intercept_for_msr(), right?
>=20
> I suppose if we go with "lbr_msrs_intercepted just means KVM wants to
> intercept", then we should probably rename it accordingly?

Probably, but that can be done on top.  And I'd like to change all of these=
 flags
(all two of them?) to be consistent.

> >  }
> >
> > +static void svm_recalc_lbr_msr_intercepts(struct kvm_vcpu *vcpu)
> > +{
> > +       struct vcpu_svm *svm =3D to_svm(vcpu);
> > +       bool intercept =3D !(svm->vmcb->control.misc_ctl2 & SVM_MISC2_E=
NABLE_V_LBR);

Eww.  The naming is all kinda of funky, and I strongly dislike the duplicat=
e code.
E.g. svm_set_lbr_msr_intercepts() recalcs, it's not a pure "set".  I'd much=
 rather
pass a @force param, e.g.

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index e6b8c0423813..2d70fb37103e 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -728,12 +728,12 @@ void *svm_alloc_permissions_map(unsigned long size, g=
fp_t gfp_mask)
 	return pm;
 }
=20
-static void svm_recalc_lbr_msr_intercepts(struct kvm_vcpu *vcpu)
+static void __svm_recalc_lbr_msr_intercepts(struct kvm_vcpu *vcpu, bool fo=
rce)
 {
 	struct vcpu_svm *svm =3D to_svm(vcpu);
 	bool intercept =3D !(svm->vmcb->control.misc_ctl2 & SVM_MISC2_ENABLE_V_LB=
R);
=20
-	if (intercept =3D=3D svm->lbr_msrs_intercepted)
+	if (intercept =3D=3D svm->lbr_msrs_intercepted && !force)
 		return;
=20
 	svm_set_intercept_for_msr(vcpu, MSR_IA32_LASTBRANCHFROMIP, MSR_TYPE_RW, i=
ntercept);
@@ -747,6 +747,11 @@ static void svm_recalc_lbr_msr_intercepts(struct kvm_v=
cpu *vcpu)
 	svm->lbr_msrs_intercepted =3D intercept;
 }
=20
+static void svm_recalc_lbr_msr_intercepts(struct kvm_vcpu *vcpu)
+{
+	__svm_recalc_lbr_msr_intercepts(vcpu, false);
+}
+
 void svm_vcpu_free_msrpm(void *msrpm)
 {
 	__free_pages(virt_to_page(msrpm), get_order(MSRPM_SIZE));
@@ -803,7 +808,7 @@ static void svm_recalc_msr_intercepts(struct kvm_vcpu *=
vcpu)
 #endif
=20
 	if (lbrv)
-		svm_recalc_lbr_msr_intercepts(vcpu);
+		__svm_recalc_lbr_msr_intercepts(vcpu, true);
=20
 	if (cpu_feature_enabled(X86_FEATURE_IBPB))
 		svm_set_intercept_for_msr(vcpu, MSR_IA32_PRED_CMD, MSR_TYPE_W,
