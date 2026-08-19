Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C19339A07E
	for <kvm@vger.kernel.org>; Wed, 19 Aug 2026 00:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787101164; cv=none; b=CsZFTaLfAlgOsSJSOpPJGQ2DA0Dbo2+YSXEhMDiTM9qo3wed2ZxQZU3GPtTyUb3TGTsKW5CKjr/GHa3fGCoNaXXFReHQ8cYmsZZR0TO8h0tMGJtqe+n7bkV/bTc9wfvEYzjjTGMLoxO2p9u0x0f+GRq2v8Gd7WJEA6feNuissg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787101164; c=relaxed/simple;
	bh=GyouiGOmNTQvPktkHcJEUPcHSogtQf7nbTA5ndzWO9g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QAgaI9SyuynSTntAmf+NrjjC2VSTTw+9OoN/zmHjVPJBUnKAWYBfjEbzPcoO1PbhvFPP7N4m1IYA1uOzg+51LN30jdjG0bA+l59Bb3Cz195UbOw7lrsqOaAqTs5eN5dE/Xx+CqoRUFzE2vrISSQYl8pA31G4aCxGAUjPpAVUGYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OMSE4lk5; arc=none smtp.client-ip=209.85.215.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OMSE4lk5"
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cbedf6e8a42so471782a12.1
        for <kvm@vger.kernel.org>; Tue, 18 Aug 2026 17:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787101163; x=1787705963; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Dhl2eRLiO5/bn/LIPtiBlJ8uhG2VgyTZzI1e3qAyPjI=;
        b=OMSE4lk5GCFzlK4QK1pN8nB0mrufawuhTLX8xGc6rvzQnArqwmmuLCysbc7jO3eC/Y
         4G9gy5NkKq3IM2plMigGO/G7N6/hf+53XmiKYbEISG4YHxGfs3fcpt3papcYRtHf3u9+
         pmZo/qSEWj2FfMAePc8h2ByEqnIVywoPTdajDRGB7XH2zgkwIaXmN96PX41D6NWPBt6N
         P5pe2Tf2l5JKHerA6huQCm7jqjZfQN7zkAxfP1aEdHZWOydH5xcL0MxMZ557x6JMU9u6
         HAJoSXEVXH4cHyYJFT/1qlLAcqPGJXbQjCR4d1590rjHK8t1DQ6XOGeTRJuy4I9AnGlY
         3HNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787101163; x=1787705963;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Dhl2eRLiO5/bn/LIPtiBlJ8uhG2VgyTZzI1e3qAyPjI=;
        b=hASuDCFHQo6jdVL9zV0NJ5rkCQRGk7w0eR+19pYgbjSlYdound4Vv2JXRb/hPKwFFb
         0TlMtkcykjLx1Te+iaaobhlOxx7ZXhhJ9AhsH//kAn0FW8eBUh3E7yPhG6zChceKxNvp
         vuOohfegwmbBlDBfjKk21ggUTAylNhHrgAD66iFIzZj68c4Eqz1A4CigV27Y67U85Pyx
         gwEPxqCyOr2YfcHC7tXYnsCn5FbpOlOF7V1ZowbOJe3WE099RTQ8XoV1m5W4Mrqkguyz
         +09mR/jYQGLCBkoo+oNEv06bw4bTCl8wNvw6u4uR1cu5bvxFjUxAqYMERijUFkNCYWAQ
         /Ghw==
X-Forwarded-Encrypted: i=1; AHgh+RqbjGhqoe0phJDqeYqcsNJJK9llUDWaK6EdpygnB3Fiuu+VXYTM7HhIqprFKiuA81pTNik=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrOWVV2viPvPTwUYZiiFnqvh0/CKMuAQmwFPWo71h8Pl7wSe2n
	+EwA4TKo+x04DDr7yH0X1blrDxQXqSaC1NkwOO2cEGmMUwraEJs9FrQoZyqijGVnpyT4DoWLGAk
	qQwHHDQ==
X-Received: from pgch28.prod.google.com ([2002:a05:6a02:509c:b0:c8d:62a8:ee35])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:d48c:b0:3cc:2552:ddd7
 with SMTP id adf61e73a8af0-3cd00e246aemr2544333637.5.1787101162592; Tue, 18
 Aug 2026 17:59:22 -0700 (PDT)
Date: Tue, 18 Aug 2026 17:59:21 -0700
In-Reply-To: <3a622cdb03b553cc9f8ce55b6df3c0091b3b06b9.camel@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260814224509.2342760-1-seanjc@google.com> <3a622cdb03b553cc9f8ce55b6df3c0091b3b06b9.camel@intel.com>
Message-ID: <aoT_6cnARCAYTrYG@google.com>
Subject: Re: [PATCH] KVM: VMX: Explicitly track TDX VMs' root level instead of
 guessing it from CPUID
From: Sean Christopherson <seanjc@google.com>
To: Rick P Edgecombe <rick.p.edgecombe@intel.com>
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>, "kas@kernel.org" <kas@kernel.org>, 
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, Kai Huang <kai.huang@intel.com>, 
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>, Xiaoyao Li <xiaoyao.li@intel.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Yan Y Zhao <yan.y.zhao@intel.com>, 
	"x86@kernel.org" <x86@kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 19, 2026, Rick P Edgecombe wrote:
> On Fri, 2026-08-14 at 15:45 -0700, Sean Christopherson wrote:
> > Explicitly track the root level for TDX VMs instead of trying to infer =
the
> > depth of the paging tree based on an individual vCPU's CPUID informatio=
n.
> > Applying KVM's existing logic to select the root level to TDX is flawed=
 as
> > nothing *requires* userspace to fill in the correct guest.MAXPHYADDR fo=
r a
> > vCPU's CPUID.=C2=A0 Guessing at the correct root level is also ridiculo=
us given
> > that userspace has already told KVM the root level during TD initializa=
tion.
> >=20
> > Relying on userspace to set the expected/correct CPUID lets a misbehavi=
ng
> > userspace trip the KVM_BUG_ON() in tdx_load_mmu_pgd() by configuring gu=
est
> > CPUID to use an "incorrect" guest.MAXPHYADDR.
>=20
> Hmm, yea. But to me the text is a little ambiguous what "configuring gues=
t
> CPUID" means. There are the two configurations of CPUID that happen and t=
he goof
> was due to forgetting that there is no enforcement between the first "dir=
ectly
> configurable bits" (where "userspace has already told KVM the root level =
during
> TD initialization" happens), and the second that happens via normal SET_C=
PUID.
>=20
> Doing a KVM_BUG_ON() if tdx code sees a different level than what was pro=
cessed
> in setup_tdparams_eptp_controls() seems good to me.
>=20
> >=20
> > Keep gfn_direct_bits even though it can be trivially derived from
> > mirror_root_level as saving a whole eight bytes per VM is meaningless, =
and
> > the value is queried fairly often and in hot paths.
>=20
> gfn_direct_bits comes directly from the the initial configuration, so why=
 do we
> need to add mirror_root_level in this patch? The old code calculated shar=
ed bit
> with a conditional, so we could easily compute level with an inverted
> conditional. The mirror_root_level caching is then a separate
> cleanup/enhancments.
>=20
> Ohhh, because to calculate it kvm_mmu_get_tdp_level() would embed some TD=
X
> specifics there.
>=20
> Wait, no, this knowledge embeds in kvm_mmu_set_mirror_root_level() anyway=
. So
> I'd think to just have the below.=20

I started with that, but I didn't like bleeding that level of detail into t=
he
MMU.  Or rather, I didn't like baking in the assumption that there is exact=
ly
one "direct bits", that the one bit is a pivot between normal and mirror ro=
ot,
and that the pivot bit is the most significant bit of the effective GPA spa=
ce.

On the other hand, the MMU already knows about mirror roots, and needs to k=
now
that mirror roots can have predetermined levels, so explicitly storing that=
 level
doesn't add new assumptions.

> If comparing gfn_direct_bits to gfn_direct_bits doesn't make sense, then
> let's just drop the KVM_BUG_ON().

Why?  Defense in depth is often useful.
