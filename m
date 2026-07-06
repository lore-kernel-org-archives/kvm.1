Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ECEF437865
	for <kvm@vger.kernel.org>; Mon,  6 Jul 2026 21:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783371773; cv=none; b=JuHFwlqQuzx3N3txwmDJmOCtIzxHhGz7Ks7l0ij0LBybdIuVKjKHRdPH5Y+eH2FgFN9nKEKnCmKZedzsHclbWMzgvx4K5M/KvhJzhFS4OZ8i827GdW7FRkLmrXkqekvkhni6RYoQTNhCAETSS9/lGXU4TFA023M9IgdZa/gAIJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783371773; c=relaxed/simple;
	bh=zTXiXJfLd3I0qxI0c9+WLAaIt+ka+KmG6qU+/CRk2ek=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hmMbcGPH641DTDWh/nDaW/pIcnmKaCBzdq+igzqwuojnr7cTCftEFkVnpFVHuMCwjZZWzTfJxRWQxkYf6uFcPS97pEpZORZ5HWO9ddnx+l/pKDP9y91PLae+ox3YnqRw//4O4t0OKNk5IZOfhOWhmE9sNWKjFr4mkkxJMLvHDl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CNLu4P3v; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CNLu4P3v"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-845e3ede1f9so3908459b3a.0
        for <kvm@vger.kernel.org>; Mon, 06 Jul 2026 14:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783371768; x=1783976568; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=LnR6K9WmltPvXj/MyNsRXgC89oeJseuvf2YbIimKSE8=;
        b=CNLu4P3vBadC0GYoEgGnBn2CADiBR+R0lCSsGpBvwU32tD30N+qB6Em8NF3TbShXSE
         K4IV4j3jlY0hjjUeD/dKigMNudC9eKusDNI0MkMVwhfC0hCIDwOMNapQC4HWef9IzvZD
         mIbHVt4CQHgkoJ1hFHIxNGhZ7iUCNLwCFYOcTtEuCHhRZWXzQz2RgoE9frY9IWrYh8S4
         bLmdtFRoyn8YlRqvxWHZlNe9dTa0T8RFWBpuVGXQFVZNqv1SsYpRvwIXYS2lb9w2Twjw
         PuFc622eXB/trnq4nCwcOdsTAM4vfz4ixVC5qPMiAPAAHkMsVlX4rnL2+VTApGx1qUne
         0Izg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783371768; x=1783976568;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LnR6K9WmltPvXj/MyNsRXgC89oeJseuvf2YbIimKSE8=;
        b=FXUFf2qQVJy93f+qqRxMWurKklaCDgJiZ3VRBFVkaMcql03z/OnI4xINwqJ0RCjbhj
         nqH0+V1YEy6s+gzn7H6lnK7GITU4FOB0bv7mdSAle0SmD7XUNVqAgwsGUJcgEm6uY+GV
         eZ3ceaxKMYNU5OBJzVga5wMqKL71hQ6fP0+siZf2RV8ehNWtY/2uvlbbAzYY7sUPWPtX
         pQdEme+dlLPQ61ucHbNEMBhZ+KbmDXuAweRHlp2+7Zj2slBlb/UmgYh/q6pixFdkB3vA
         zNHpryOvxXd2NKS7cvs44iN7ic2R6XyorWcFkPhou67FqLB52ODlFOhbivEhV2bu6szL
         srtQ==
X-Forwarded-Encrypted: i=1; AHgh+Rp5+Rk7Y+tV1la6sUOrgfBLPX5irMWhCf8JhAXpGTjkq3FAYrs9YjNg0HBy74ju4Sbqemc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx02Gq7B0JLi7KMCXQN3TWwjgg8g5OPjYBf+qQBp2eT9IMktFaC
	rAzEGJcpk8gY+YazIkKsTlwmaNjK5SLPIAv0duEjHq6c5eTfX7BFCzFEwKt9s7nijfTFdG3ddmQ
	co1Rc6Q==
X-Received: from pgmh30.prod.google.com ([2002:a63:575e:0:b0:c80:296b:72cc])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:4612:b0:3bf:6c07:b2ed
 with SMTP id adf61e73a8af0-3c08eebb4d6mr2396075637.48.1783371767923; Mon, 06
 Jul 2026 14:02:47 -0700 (PDT)
Date: Mon, 6 Jul 2026 14:02:47 -0700
In-Reply-To: <2bdcc07d98df66954b9508be537b6f6a7c9f88de.camel@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260526023515.288829-1-rick.p.edgecombe@intel.com>
 <20260526023515.288829-10-rick.p.edgecombe@intel.com> <0c31fcdc-048c-4ff2-9e89-1ba112815c84@linux.intel.com>
 <2bdcc07d98df66954b9508be537b6f6a7c9f88de.camel@intel.com>
Message-ID: <akwX9wUS_C-lc-I8@google.com>
Subject: Re: [PATCH v6 09/11] KVM: TDX: Get/put PAMT pages when (un)mapping
 private memory
From: Sean Christopherson <seanjc@google.com>
To: Rick P Edgecombe <rick.p.edgecombe@intel.com>
Cc: "binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>, Kai Huang <kai.huang@intel.com>, 
	Dave Hansen <dave.hansen@intel.com>, Yan Y Zhao <yan.y.zhao@intel.com>, 
	"kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>, "kas@kernel.org" <kas@kernel.org>, 
	"mingo@redhat.com" <mingo@redhat.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>, 
	"nik.borisov@suse.com" <nik.borisov@suse.com>, 
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "hpa@zytor.com" <hpa@zytor.com>, 
	"tglx@kernel.org" <tglx@kernel.org>, Vishal Annapurve <vannapurve@google.com>, "bp@alien8.de" <bp@alien8.de>, 
	Chao Gao <chao.gao@intel.com>, "x86@kernel.org" <x86@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 06, 2026, Rick P Edgecombe wrote:
> On Fri, 2026-07-03 at 11:15 +0800, Binbin Wu wrote:
> > > @@ -1669,16 +1683,29 @@ static struct page *tdx_spte_to_sept_pt(struc=
t kvm
> > > *kvm, gfn_t gfn,
> > > =C2=A0 static int tdx_sept_map_nonleaf_spte(struct kvm *kvm, gfn_t gf=
n,
> > > =C2=A0=C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0 enum pg_level level, u64 new=
_spte)
> > > =C2=A0 {
> > > +	struct kvm_vcpu *vcpu =3D kvm_get_running_vcpu();
> > > +	struct vcpu_tdx *tdx =3D to_tdx(vcpu);
> >=20
> > Nit:
> > Is it better to move this after checking vcpu is not NULL?
> > Although tdx is not dereferenced in between, if vcpu is NULL,
> > it means container_of() does arithmetic to a NULL pointer.
>=20
> Personally I'm on the fence. I'm going to leave it, because Sean did it t=
hat
> way:
> https://lore.kernel.org/kvm/20260129011517.3545883-23-seanjc@google.com/

Heh, because of course I'm omnipotent and never make mistakes.

I agree with the nit in the sense that this isn't a great pattern to encour=
age,
but IMO the root of the ugly pattern is the use of kvm_get_running_vcpu() (=
which
is sadly the lesser evil in this case).  I.e. I'm not terribly concerned ab=
out
this code leading to more "problems" in the future.  And I don't really wan=
t to
grab "tdx" later on because that deviates from the standard patterns in KVM=
 and
incorrectly suggests there _is_ a need to pre-check for a non-NULL vCPU.

All that said, we can get the bost of both words by simply not caching "tdx=
";
there's only one use anyways.

diff --git arch/x86/kvm/vmx/tdx.c arch/x86/kvm/vmx/tdx.c
index ee073cacafbe..f53bac52449b 100644
--- arch/x86/kvm/vmx/tdx.c
+++ arch/x86/kvm/vmx/tdx.c
@@ -1684,7 +1684,6 @@ static int tdx_sept_map_nonleaf_spte(struct kvm *kvm,=
 gfn_t gfn,
                                     enum pg_level level, u64 new_spte)
 {
        struct kvm_vcpu *vcpu =3D kvm_get_running_vcpu();
-       struct vcpu_tdx *tdx =3D to_tdx(vcpu);
        gpa_t gpa =3D gfn_to_gpa(gfn);
        u64 err, entry, level_state;
        struct page *sept_pt;
@@ -1697,7 +1696,7 @@ static int tdx_sept_map_nonleaf_spte(struct kvm *kvm,=
 gfn_t gfn,
        if (!sept_pt)
                return -EIO;
=20
-       ret =3D tdx_pamt_get(page_to_pfn(sept_pt), &tdx->pamt_cache);
+       ret =3D tdx_pamt_get(page_to_pfn(sept_pt), &to_tdx(vcpu)->pamt_cach=
e);
        if (ret)
                return ret;
=20
@@ -1721,7 +1720,6 @@ static int tdx_sept_map_leaf_spte(struct kvm *kvm, gf=
n_t gfn, enum pg_level leve
        struct kvm_vcpu *vcpu =3D kvm_get_running_vcpu();
        struct kvm_tdx *kvm_tdx =3D to_kvm_tdx(kvm);
        kvm_pfn_t pfn =3D spte_to_pfn(new_spte);
-       struct vcpu_tdx *tdx =3D to_tdx(vcpu);
        int ret;
=20
        if (KVM_BUG_ON(!vcpu, kvm))
@@ -1733,7 +1731,7 @@ static int tdx_sept_map_leaf_spte(struct kvm *kvm, gf=
n_t gfn, enum pg_level leve
=20
        WARN_ON_ONCE((new_spte & VMX_EPT_RWX_MASK) !=3D VMX_EPT_RWX_MASK);
=20
-       ret =3D tdx_pamt_get(pfn, &tdx->pamt_cache);
+       ret =3D tdx_pamt_get(pfn, &to_tdx(vcpu)->pamt_cache);
        if (ret)
                return ret;
