Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE7F3392814
	for <kvm@vger.kernel.org>; Mon, 18 May 2026 20:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779137473; cv=none; b=BV3y7PlDWVqcF5mL4ePaO7tykK296yXfIeaHWe6SBNJHx8jrZiLpk778nMQyDFLMEB3JqQmMMgpmrQxyRbyBAQdyltdPTOOF4Aee8EtpxJGtHM4GUAX0eme27mxSWBViuszwDgnbqkzWblt7T+2+sbnbRUw/qiMSAqbyCa0yoOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779137473; c=relaxed/simple;
	bh=Y/k/A8rQYJuIoEDWTkWkJu7sDQNtQX63mbCefOQE59k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HXNq/vGmEbfZopJeWYNhOCzC1TUtIetZMYppJrgH1+w9FGdZfS+Hf2cYNo6iPRWtW33JM09EXq34yOTJj3qrK+UCKKmOFyGagm1iqI+Jmp7h+rOzfKrs7poE0VSgmhGEeDsXt9aGtGd0EEUIgoAGvRV45MepJ/F0nFRLQQrxsWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RZvyR1Ss; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RZvyR1Ss"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-82fa2165c3eso1730353b3a.0
        for <kvm@vger.kernel.org>; Mon, 18 May 2026 13:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779137471; x=1779742271; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xdrFK7KwVl/zk51lMHH0xrd4K1s2WYKbl4YNCQ/z3AA=;
        b=RZvyR1SsBVJJwWv4q0qhVcNrrN2qqlqmt2e+0iCyCsJaJxPgbvUek8ELdhbX5puHKl
         GWplAS9DflFJIpdZPcflbdm51CnPu9PPsycIcWDqhZmWtkPt23kUwPJ+WTYd4dcvCMEd
         jkDIBhp2jVi2Xjht/dxh5yRK4+b8dDj5hca+xvMZoNk4am3TLL1nyKGfncPcZmSD1b75
         Z9w/y6gh76NQcJAPW9DiJP4tlO2NefiF6fZRhGne7CbWFCRWPEu5krbUOqoC+DjvBDc8
         AyQxOqzvXLyvOnrrgMPboQsYXqc3v+jwHLsEHkxXkjWiRPEEo56sef9m6VvmhIZRd/eW
         3FIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779137471; x=1779742271;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xdrFK7KwVl/zk51lMHH0xrd4K1s2WYKbl4YNCQ/z3AA=;
        b=U9QaL2jeDZD/8MlUSl8zFXKVah5SMvB9/ZjpoxeYUnO6jUR/Ylct/92LbM0mUyizUW
         PQA2kl0ZEzxTyl+MYIil2kvE0WT7ROQwmVVrmZTnIrIJVtki75oM+niVnG57LQq3VnYR
         +l2fafDPW0Xyvt7ma44LvBAmI3/yeofGIFpByULSPIvNx5/7EIPiaKigWqHXZd4wnUSh
         VBeCP1p6yWwD0QOuGbLSAsemUT75hNHedEnn6i4A0NQAlLWb9//Q08+cjsntf0Y0U8Qc
         LonqvLnlatA4IzOQSC0Y9tignDfd05oO/7QjQGNZmel27cKR4AvGNdMgsid3oKFbOCnS
         intw==
X-Forwarded-Encrypted: i=1; AFNElJ9VbwrT32QvqvoL2v8QpWweMwzmp3KVzM5bpKZMOC6n7sW3u3jWyGqRRqyPZjXaKxsig4I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqODLFspLhsgYmG9UrAMAF00BkJtlBm3+Q0shCwFF1tB+cSAsT
	GvssX8xlHytVAAlDcBl3hEtCOG6VAhLsEdOM4DZJNO/J083Kxyf0Ho4r+Yr51h0JetHd/u6BEiH
	TEkvElg==
X-Received: from pfbg7.prod.google.com ([2002:a05:6a00:ae07:b0:837:c09c:9cce])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2793:b0:83e:26b:528c
 with SMTP id d2e1a72fcca58-83f33d26f67mr16065245b3a.28.1779137470943; Mon, 18
 May 2026 13:51:10 -0700 (PDT)
Date: Mon, 18 May 2026 13:51:10 -0700
In-Reply-To: <136d277dba2ac681ed7607a436f55e2fd1975ec5.camel@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260514215355.1648463-1-seanjc@google.com> <20260514215355.1648463-9-seanjc@google.com>
 <136d277dba2ac681ed7607a436f55e2fd1975ec5.camel@intel.com>
Message-ID: <agt7vnVL5rJJUVzo@google.com>
Subject: Re: [PATCH v2 08/15] KVM: x86: Add mode-aware versions of
 kvm_<reg>_{read,write}() helpers
From: Sean Christopherson <seanjc@google.com>
To: Kai Huang <kai.huang@intel.com>
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>, "kas@kernel.org" <kas@kernel.org>, 
	"vkuznets@redhat.com" <vkuznets@redhat.com>, "dwmw2@infradead.org" <dwmw2@infradead.org>, "paul@xen.org" <paul@xen.org>, 
	Rick P Edgecombe <rick.p.edgecombe@intel.com>, "x86@kernel.org" <x86@kernel.org>, 
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>, 
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "yosry@kernel.org" <yosry@kernel.org>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 18, 2026, Kai Huang wrote:
>=20
> > @@ -10413,29 +10413,30 @@ static int complete_hypercall_exit(struct kvm=
_vcpu *vcpu)
> > =C2=A0
> > =C2=A0	if (!is_64_bit_hypercall(vcpu))
> > =C2=A0		ret =3D (u32)ret;
> > -	kvm_rax_write(vcpu, ret);
> > +	kvm_rax_write_raw(vcpu, ret);
> > =C2=A0	return kvm_skip_emulated_instruction(vcpu);
> > =C2=A0}
> >=20
>=20
> Nit:  AFAICT if we use kvm_rax_write(vcpu, ret) instead of the "raw" vers=
ion
> here, we can then remove the
>=20
> 	if (!is_64_bit_hypercall(vcpu))
> 		ret =3D (u32)ret;

No, because sneakily, is_64_bit_hypercall() !=3D is_64_bit_mode(vcpu).  And=
 because
we also need to avoid calling is_64_bit_mode().  If we use kvm_rax_write(),=
 then
the unpacked code will be:

	WARN_ON_ONCE(vcpu->arch.guest_state_protected);

	if (is_long_mode(vcpu))
		kvm_x86_call(get_cs_db_l_bits)(vcpu, &cs_db, &cs_l);
	else
		cs_l =3D 0;

	if (cs_l)
		vcpu->arch.regs[VCPU_REGS_RAX] =3D ret;
	else=09
		vcpu->arch.regs[VCPU_REGS_RAX] =3D (u32)ret;

whereas the (correct) behavior here is:

	if (vcpu->arch.guest_state_protected)
		cs_l =3D 1;
	else if (is_long_mode(vcpu))
		kvm_x86_call(get_cs_db_l_bits)(vcpu, &cs_db, &cs_l);
	else
		cs_l =3D 0;

	if (cs_l)
		vcpu->arch.regs[VCPU_REGS_RAX] =3D ret;
	else=09
		vcpu->arch.regs[VCPU_REGS_RAX] =3D (u32)ret;

I.e. using the non-raw version will trigger the WARN_ON_ONCE(), and will in=
correctly
truncate "ret" whenever cs_l is stale (which might be always?).
