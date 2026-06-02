Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EB162C11EE
	for <kvm@vger.kernel.org>; Tue,  2 Jun 2026 14:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780410171; cv=none; b=dBJ/ntt8mAT3Ed6KWMlBlXl0/Tvmp23h/E6Qhu2bsbzmFmkSSBAIPQN9n6x05bAtYJtnh5zHhv6vypAIykXJ4HU988VuAxRg3JzN+bbUOg0vh4Y4vrwgmIYo8qBYMONyESQaY2ZjCVHdelVS+Q4AuAh1XNet3+bzs5NWQyytlxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780410171; c=relaxed/simple;
	bh=HKdSbKDpsm9Aw3YPhdNfDglZwieGWQV9Xq8VLT999yY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EtaUgFXfvJpGEb3PH/hpXuZWMyoJ1xIGW8mYD8KSiIfndToenRPB8nFoYjMETV9urais9HQ6OIXJ1cUtRQ9ypQkbPdXs1Zokp7mN9Nqm0bkEzR8fPyl8TDOWPr49UB3Ioc7lbPJHwVI9C457Ot1m4KxXaWeM2j9x/XLSkjiT08g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WdlCfmL4; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=HqLaxbfd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WdlCfmL4";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="HqLaxbfd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780410169;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HPUtYnAidacASlWKlZb9mNzKPZTFgT+1ObiIw/PwpM4=;
	b=WdlCfmL4fPTw5rv8aqyZziaHfvvmJnBlOAmL2RsgO/pFiMidvGGOBZZup36+6nyTxvcvGU
	0VnLeCAXqgYQ6QXF3AnBJYtPcAn2n1OlKdxQRB8x7SYrudn0jOgufDpYqJQl7Eqyl4ii6/
	+UpcunH1pNW08vQzHLNTvUWSRDdutJE=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-134-S1yUx0uGPLqecCCtfBH58Q-1; Tue, 02 Jun 2026 10:22:48 -0400
X-MC-Unique: S1yUx0uGPLqecCCtfBH58Q-1
X-Mimecast-MFC-AGG-ID: S1yUx0uGPLqecCCtfBH58Q_1780410168
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-91576c147a4so357484785a.3
        for <kvm@vger.kernel.org>; Tue, 02 Jun 2026 07:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1780410168; x=1781014968; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HPUtYnAidacASlWKlZb9mNzKPZTFgT+1ObiIw/PwpM4=;
        b=HqLaxbfdMRho53bFA9N2FLW1QGo+EIgiapN2xKwQkeJxo5vhoxd1/rVoPCh5JVzdGB
         eWM7rrjkCTqRyBgdNFDycaOwHE+wDcvMQ3J6T73I16ioatPk4ijB1stB2GkmFbI2ViwR
         3mF6dHPXPbeuUCwohHQgAT2e9qWxCqfvBfABVqRWoMjA2CqaBZoJl/B4G6wC95E3GDNR
         iDZdHXV+e6MsGlUv0JlDV1+anVaF44r20YlAI5poRYoJqL4THneFAsChjZwA3knWrIZj
         KQ3+zuv0CSSyYxP2y6rhKyRXFQAXJ4Zo8h6XLABn66ufArKsuhw6ZITHv9chmdGHOcty
         LhNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780410168; x=1781014968;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HPUtYnAidacASlWKlZb9mNzKPZTFgT+1ObiIw/PwpM4=;
        b=o6n+XnqWCC9Hnk+BE8cOEu8kHMWr4HVSSkClpuRuSBZVEneXFJjW96ZULAgfs9h1iL
         wF8i4W84xDPaTfQbt5QBU+bHede1UTsjmtRJ/i7o1876iBvNVtV1H621ce4OoIC0JabK
         93xUSnyP0jklZ8Tj+m6p30PpnNP5nm+2EKaQLLpYsnPiXaQ1rNW5qGzPS8V1SC1siN2n
         sfXuj43Wcng9u1o8cY244EbISIRcbXbP0J738p5SWeL8XunxdUP24Cmup+fzOUByWbxu
         Nb1SgA1dfma0Ecxz8voJYUe6/4jFklsL6YqSuuwShEWb12h49sgjAh0QbKM8/ZUAQiCq
         RyYA==
X-Forwarded-Encrypted: i=1; AFNElJ9c5NcJWi2Uh4SIDiIrtzj1fyg0jPklesDeL0UtXW2rYh57eReoxvAtFHDnLs/wcSl4ZIM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWaN+b/cez0drfKKG2HugL/9mkRstuMYjIA0z1X3ukBuZZjRnA
	K/sxJw224ustoUxT1FBQ3gq/FPBUKC/suF4K1VZYVnCZweKWPrtTmTQVT4+jKYNdLW7m6dpw+xp
	jqwQhyeRAL4VTuUEfLVHvp9MebovzOOSigdA87RqMx/PWl5EMUqUy1w==
X-Gm-Gg: Acq92OGTFCzGGJce45nWi9Tf3pVQrv49BVeBAeCzzDPXJHjOGutIkJKOPXIVMHL00bC
	HRrSAVQY+8A+PkJuVUj3M+k+jiq3GQL4yTczXUKnUkolX4e6iYOlduSkdIw/fuwedIW8t+6hrPJ
	ayC5KeQkEknHV9givYBcitYhnEBe3WD9AUNG/15NmmgwXl7W579OzH239OykaY+RpVYKjgjTNRw
	SfkriKt/9M+EW/08HJP30fNMt0DtfvNth/bDeQap1zRkLsJ1V5Mur0ZUSIICzshKveCZwyV2fTI
	il/S40R+juAxYYDIwwi2mhBDGnOXNzUpknrHhNm6WFINmXtLNFqHPZWbCM9StJ+kKQmqKpkFEPR
	lbWJkAAfyUgrgkxDMVNDiZGcgBIc9/JyLvSi+zX4=
X-Received: by 2002:a05:620a:1a09:b0:912:c0b3:7d99 with SMTP id af79cd13be357-9153d9caf64mr2520410385a.2.1780410167666;
        Tue, 02 Jun 2026 07:22:47 -0700 (PDT)
X-Received: by 2002:a05:620a:1a09:b0:912:c0b3:7d99 with SMTP id af79cd13be357-9153d9caf64mr2520406485a.2.1780410167139;
        Tue, 02 Jun 2026 07:22:47 -0700 (PDT)
Received: from intellaptop.lan ([2607:fea8:fc01:88aa:f1de:f35:7935:804f])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-91532628f87sm1312508085a.35.2026.06.02.07.22.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 07:22:46 -0700 (PDT)
Message-ID: <37a72b78565edf3e602d914820b5ee30e0ffd189.camel@redhat.com>
Subject: Re: [PATCH 08/28] KVM: x86/mmu: separate more EPT/non-EPT
 permission_fault()
From: mlevitsk@redhat.com
To: Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org
Cc: d.riley@proxmox.com, jon@nutanix.com
Date: Tue, 02 Jun 2026 10:22:45 -0400
In-Reply-To: <20260505195226.563317-9-pbonzini@redhat.com>
References: <20260505195226.563317-1-pbonzini@redhat.com>
	 <20260505195226.563317-9-pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-05-05 at 21:52 +0200, Paolo Bonzini wrote:
> Move more of EPT handling entirely in the existing "if (!ept)"
> conditional.=C2=A0 Use a new "rf" variable instead of uf for read permiss=
ions
> for clarity.
>=20
> Merge smepf and ff into a single variable because EPT's "SMEP" (actually
> MBEC) is defined differently and does not need smepf.
>=20
> Tested-by: David Riley <d.riley@proxmox.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
> =C2=A0arch/x86/kvm/mmu/mmu.c | 26 +++++++++++++++-----------
> =C2=A01 file changed, 15 insertions(+), 11 deletions(-)
>=20
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index d94a488db79d..fc34536c536b 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -5584,24 +5584,28 @@ static void update_permission_bitmask(struct kvm_=
mmu *mmu, bool ept)
> =C2=A0 * that causes a fault with the given PFEC.
> =C2=A0 */
> =C2=A0
> + /* Faults from reads to non-readable pages */
> + u8 rf =3D 0;
> =C2=A0 /* Faults from writes to non-writable pages */
> =C2=A0 u8 wf =3D (pfec & PFERR_WRITE_MASK) ? (u8)~w : 0;
> =C2=A0 /* Faults from user mode accesses to supervisor pages */
> - u8 uf =3D (pfec & PFERR_USER_MASK) ? (u8)~u : 0;
> - /* Faults from fetches of non-executable pages*/
> - u8 ff =3D (pfec & PFERR_FETCH_MASK) ? (u8)~x : 0;
> - /* Faults from kernel mode fetches of user pages */
> - u8 smepf =3D 0;
> + u8 uf =3D 0;

I am thinking: maybe call this usf?
Just an idea, I am not sure that it will be better that current name.

> + /* Faults from fetches of non-executable pages */
> + u8 ff =3D 0;
> =C2=A0 /* Faults from kernel mode accesses of user pages */
> =C2=A0 u8 smapf =3D 0;
> =C2=A0
> - if (!ept) {
> + if (ept) {
> + rf =3D (pfec & PFERR_USER_MASK) ? (u8)~u : 0;
> + ff =3D (pfec & PFERR_FETCH_MASK) ? (u8)~x : 0;
> + } else {
> =C2=A0 /* Faults from kernel mode accesses to user pages */
> =C2=A0 u8 kf =3D (pfec & PFERR_USER_MASK) ? 0 : u;

And rename this to suf?

> =C2=A0
> - /* Not really needed: !nx will cause pte.nx to fault */
> - if (!efer_nx)
> - ff =3D 0;
> + uf =3D (pfec & PFERR_USER_MASK) ? (u8)~u : 0;
> +
> + if (efer_nx)
> + ff =3D (pfec & PFERR_FETCH_MASK) ? (u8)~x : 0;
> =C2=A0
> =C2=A0 /* Allow supervisor writes if !cr0.wp */
> =C2=A0 if (!cr0_wp)
> @@ -5609,7 +5613,7 @@ static void update_permission_bitmask(struct kvm_mm=
u *mmu, bool ept)
> =C2=A0
> =C2=A0 /* Disallow supervisor fetches of user code if cr4.smep */
> =C2=A0 if (cr4_smep)
> - smepf =3D (pfec & PFERR_FETCH_MASK) ? kf : 0;
> + ff |=3D (pfec & PFERR_FETCH_MASK) ? kf : 0;
> =C2=A0
> =C2=A0 /*
> =C2=A0 * SMAP:kernel-mode data accesses from user-mode
> @@ -5630,7 +5634,7 @@ static void update_permission_bitmask(struct kvm_mm=
u *mmu, bool ept)
> =C2=A0 smapf =3D (pfec & (PFERR_RSVD_MASK|PFERR_FETCH_MASK)) ? 0 : kf;
> =C2=A0 }
> =C2=A0
> - mmu->permissions[index] =3D ff | uf | wf | smepf | smapf;
> + mmu->permissions[index] =3D ff | uf | wf | rf | smapf;
> =C2=A0 }
> =C2=A0}
> =C2=A0

Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
Best regards,
	Maxim Levitsky


