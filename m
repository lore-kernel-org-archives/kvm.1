Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795541573;
	b=zaRbixJgciqZM8juJ837P6ARqfw8X9uJX02gP3bfpVSj2VrEA8/CBBcIgrLxPpK6FrL9
	 VmITcFByjCOacoUH6W84voxHj3+a2Z9RPn3K1nk022Pebf3ZKNx+RCSrgmE/+paSF69jS
	 swCeUpvdOHuwis+fMxjJWODdgmXEOsrqx1zym3Tj93rpVPlmnjdMdGcn2rSXW/RRNVFqD
	 Tzce82CXQ/wB62auZh2Tt0uAk26AfEy7F/PQ33Rxdd3aiS1CKys3M9mTJoXgv7oac9ppv
	 fmQbp7Ej9STtmayCgq7tR1U04B2LdhCACLn6fHwXTKWMdRZTaq/ybaRXHKXnY7H3+wg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795541573;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Subject:From:To:Date:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:User-Agent:
	 MIME-Version;
	bh=OKHHL1EZ/+cFBzRlCdCFp5e4KQB3PH59TU0PApZ9Byk=;
	b=vNrDwuwOCfGM+lKOLQRbrtVrpPTsa6Rfq/jqO4gYS7rRwnxDKwIWiOEmZj2SL9iopSPq
	 JwKjYSr6CVqnc7z5I632A7t8it8/iVf0+qRfd8oW5Swv2jjOT8V5niQbsS63PZBEw+ygt
	 9WAu6w+0BeBDwRg8nWH1Pocyqnr7J2GpQGTvdMq+SNc4zzlWRvQJLd+7Ya7T1UutVTNB9
	 J6hJ/P0421oGHTli531eA6/4y7akco+q/AjDVGOqjO//dnKGPat0qXOPW20t9GjlG6hHv
	 MQCYjTyWABHsLu81Q87Hje6QrXefkY7iJsnwHCf2wA29xUT1wBDWaK/MVwDn4J0sEDw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=SnFLoaAM;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=iT9VMDOo;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7C49606A693
	for <kvm@vger.kernel.org>; Tue, 24 Nov 2026 17:32:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E7C49606A693
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=SnFLoaAM;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=iT9VMDOo
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795541572;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OKHHL1EZ/+cFBzRlCdCFp5e4KQB3PH59TU0PApZ9Byk=;
	b=SnFLoaAMJFsbjTLjDtVN+ckypruew/oT6dqNOoCDh5E+WRZ14TZJOdsgNCp0JBIyhCQtzF
	DQ6s/0OjPJ8Obd6v8V5lEaW1ralqFOOJt/jwnVBiPsLfjgIv+2SBe1Vly15G6jYgFX1Tl4
	rafJI+iWLYPwjqPw1f2o3khQ6/LHd3U=
Received: from mail-yx1-f72.google.com (mail-yx1-f72.google.com
 [74.125.224.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-421-bUe0ZiOSNsuhbtxEc3wnHA-1; Tue, 24 Nov 2026 17:32:49 +0000
X-MC-Unique: bUe0ZiOSNsuhbtxEc3wnHA-1
X-Mimecast-MFC-AGG-ID: bUe0ZiOSNsuhbtxEc3wnHA_1795541569
Received: by mail-yx1-f72.google.com with SMTP id 956f58d0204a3-6790b1d37e7so50812d50.0
        for <kvm@vger.kernel.org>; Tue, 24 Nov 2026 09:32:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1795541569; x=1796146369; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:to:from:subject:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=OKHHL1EZ/+cFBzRlCdCFp5e4KQB3PH59TU0PApZ9Byk=;
        b=iT9VMDOom6wEOa+01cKUMsaY3+KS3UGCbAdKqt3PgAiFlDXysmKwa4p12H9oZpep+g
         IF1APhOcrj6RptDSPLr8xWjQyjwlbgPLF5zoTL2QwkJEWNS7UK0Hni210EH2WXTKM+Fi
         GAGOGB/e6DGfFAk4qoOFEaXo1h0qsAw9dPD8E3ZR/aGiIonPULZBxDRCPaLQ8dHsM86b
         BZJtGEAFi9NRKsHq0qg7URy7AY0Cd1FSq1vHEekRvLDz77xNCBAqe0nfTXHwNTVw0T1H
         ZP/DhK0f03d6L5BrKqqie7Ksp4hbeMeMYiwU3nJCIQrAMau+56huaIABvv5pfSIWxjra
         Qh2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795541569; x=1796146369;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OKHHL1EZ/+cFBzRlCdCFp5e4KQB3PH59TU0PApZ9Byk=;
        b=WlX4tebwBUe1rNdkd2LTTkPeAX/D6albJMi4i8925ZGALypDUOZQH7iMi5oevSjgfW
         yjBbJXmq3EY6qg0BCi+5J0mBrVO1yhU9MpALVBo8vT5cykO29XM6Y+fsH3w4ZjBcAh2Z
         mDPVikJtTWKOBjbwanEW11/6mv5uym+lRqy6vvLHcQAPRX0d/rx+2atdpzSe18se1HzP
         n05PwLvAG11g/xI069CriYPeCthAIrjWDA1QI6EDOx/eje/HnWybNAF9W/We0iE0OLqC
         72CyV6pJkZSh2pzhBXdxT29DWYboBvycJH9itL6zyQo6BR5cW3BDMLnwSoQCviGZQxGn
         nV8w==
X-Forwarded-Encrypted: i=1; AL+hErEWek10s6VAjILxoEyE50m15jEjKmTB80XO/W9pwrKclqXwzk+TKl5C/qwiPJyIoFSC3WU=@vger.kernel.org
X-Gm-Message-State: APuU4Z/M/QXAbH/GhTbEDm9F8jN0sKwwsSURWJSvKKkl6bOYb2dX2ue0
	xAx28FH4iHEWvlHMb7qiY7aDhxOUTYpu8Tkn/JDvFQT1bSddLTopB1a96AKcFoXw0RIfpXGEw+g
	3s1NQsJ5H/k6D/NkzZwMdU6OurmOh5/H+m2PpfgRaZ93dygorkaDJ4Tpee3cwYw==
X-Gm-Gg: AZFdTZcoJvI1FSIgvxnlZx/84oR+E0OGgHxAylMjLqdsatx4nAJ2aaa6oiJlWKlFCez
	GhD8N/ivW8TmvMtHLQLkTOIxHO/scYUS029wQggTUoIY7JqYfKU3iO3JYiU5uScJCJ1sgehLQk+
	I9UbJgNmTZpjoH0m9PKlsWxOO4DYHQ0HNfDGRCSqjSZHFXzCwT0AagTsHEFt90efXEg/+td2LOY
	v50i4JkqEBUvOO3uaTg8kAziQbpPIsSRJaGNkoJra5S5yeFBzibuYc3wQrU1bZk9g1hgAqg7qEq
	KBs6qjLW9anPL5rYdKiyrPMiDB1d4pAaz8PzEt4kuQktmJhf+FyliEz8HzSodgYjz5Z1H7GzKHo
	vWOAvYPgCF5sVsv6kw7HJE6oEZyodPsymOOgS6AJLDGNWAQZaKDDFVlIhqRMYNp6iulSW2cFY35
	dEkYQyB7s=
X-Received: by 2002:a05:690e:14c6:b0:679:cc49:55dc with SMTP id 956f58d0204a3-67df44e0fabmr6736179d50.92.1795541569029;
        Tue, 24 Nov 2026 09:32:49 -0800 (PST)
X-Received: by 2002:a05:690e:14c6:b0:679:cc49:55dc with SMTP id 956f58d0204a3-67df44e0fabmr6736167d50.92.1795541568570;
        Tue, 24 Nov 2026 09:32:48 -0800 (PST)
Received: from mlevitsk-thinkpadt14gen3.ibmmarkh.csb ([209.103.33.216])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67df33d64a0sm7635009d50.22.2026.11.24.09.32.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 09:32:48 -0800 (PST)
Message-ID: <431679ef5fac99ad9dd0eab04a081c6de4f728ac.camel@redhat.com>
Subject: Re: [PATCH v3 2/5] KVM: x86: split vcpu->arch.hflags into
 nested_guest_mode and smm_mode
From: "mlevitsk@redhat.com" <mlevitsk@redhat.com>
To: sashiko-reviews@lists.linux.dev, kvm@vger.kernel.org
Date: Tue, 24 Nov 2026 12:32:47 -0500
In-Reply-To: <sashiko-outbox-229793@kernel.org>
References: <20261123175512.80438-1-mlevitsk@redhat.com>
	 <20261123175512.80438-3-mlevitsk@redhat.com>
	 <sashiko-outbox-229793@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-3.fc44) 
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Mon, 2026-11-23 at 18:03 +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential
> issues to consider:
> - [High] KVM: x86: build failure in kvm_vcpu_reset() when
> =C2=A0 CONFIG_KVM_SMM=3Dn
> - [Low] KVM: x86: commit log names nested_guest_mode instead of
> =C2=A0 nested_guest_state
> --
>=20
> commit f779a065108faeca6cdd5ce21f760f2b6bdeb40c
> Author: Maxim Levitsky <mlevitsk@redhat.com>
>=20
> KVM: x86: split vcpu->arch.hflags into nested_guest_mode and smm_mode
>=20
> This commit replaces vcpu->arch.hflags with separate nested_guest_state
> and smm_mode fields in struct kvm_vcpu_arch.
>=20
> > diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm=
_host.h
> > index 683bb8bf43a94..17308713a2904 100644
> > --- a/arch/x86/include/asm/kvm_host.h
> > +++ b/arch/x86/include/asm/kvm_host.h
> > @@ -735,7 +735,6 @@ struct kvm_vcpu_arch {
> > =C2=A0	unsigned long cr8;
> > =C2=A0	u32 host_pkru;
> > =C2=A0	u32 pkru;
> > -	u32 hflags;
> > =C2=A0	u64 efer;
> > =C2=A0	u64 host_debugctl;
> > =C2=A0	u64 apic_base;
> > @@ -755,6 +754,16 @@ struct kvm_vcpu_arch {
> > =C2=A0	u64 arch_capabilities;
> > =C2=A0	u64 perf_capabilities;
> > =C2=A0
> > +#define KVM_NESTED_IN_GUEST	BIT(8)
> > +	/* Non zero when the guest is executing another guest */
> > +	u16 nested_guest_state;
>=20
> [Severity: Low]
> This isn't a bug, but the commit subject and message call this field
> nested_guest_mode while the code names it nested_guest_state.
Will fix.
>=20
> > +
> > +#ifdef CONFIG_KVM_SMM
> > +#define SMM_MASK		BIT(0)
> > +#define SMM_INSIDE_NMI_MASK	BIT(1)
> > +	/* Non zero when the guest is in SMM*/
> > +	u16 smm_mode;
> > +#endif
> > =C2=A0	/*
> > =C2=A0	 * Paging state of the vcpu
> > =C2=A0	 *
>=20
> [ ... ]
>=20
> > diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> > index aad065d035fbb..4e515bcdc85cb 100644
> > --- a/arch/x86/kvm/x86.c
> > +++ b/arch/x86/kvm/x86.c
>=20
> [ ... ]
>=20
> > @@ -9558,7 +9558,8 @@ void kvm_vcpu_reset(struct kvm_vcpu *vcpu, bool i=
nit_event)
> > =C2=A0	kvm_lapic_reset(vcpu, init_event);
> > =C2=A0
> > =C2=A0	WARN_ON_ONCE(is_guest_mode(vcpu) || is_smm(vcpu));
> > -	vcpu->arch.hflags =3D 0;
> > +	vcpu->arch.smm_mode =3D 0;
> > +	vcpu->arch.nested_guest_state =3D 0;
> > =C2=A0
> > =C2=A0	vcpu->arch.smi_pending =3D 0;
> > =C2=A0	vcpu->arch.smi_count =3D 0;
>=20
> [Severity: High]
> Does this break the build when CONFIG_KVM_SMM is disabled?=C2=A0 smm_mode=
 in
> struct kvm_vcpu_arch is guarded by #ifdef CONFIG_KVM_SMM, but
> kvm_vcpu_reset() clears vcpu->arch.smm_mode unconditionally.
Will fix.

