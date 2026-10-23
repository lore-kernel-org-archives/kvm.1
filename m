Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792780414;
	b=fUeZYC0dcHy0ePu8p1JGHijNlWdK3R0rrBgooqNHRsqMiZiEfEG+i1OWPNx+hPLLvwdS
	 P2Y32I0ubHIyIdMjBAk3qnacJqKUHHSsLXcIZq02qfzYENp8KX+Xaew1CdwpO8nK1JTfc
	 +X8SuBvBzckbU1iS8hWQe8LDvC8kLTBNniNoYg0qi5Ax/xOgkAp09/VO2ULz1t1ROoS+v
	 EU1E4RsRply+scLuHqU6m2HECvTfH37gLIPai/+WCqvdy896m3JphOwKLjdazPrk3yqwU
	 bZcWxyQNXVb5c47P4w/I+AAUCOKq+zS4kQUlSiiqM4g8Z8GsUBvhu6g4ipwaaCfgSew==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792780414;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=lJ/PTfv5RXcFCq/Fmv1kk7W2C7lDfDCOzu0A1tXDMGI=;
	b=Iis83yqZ7hcHB+Y7M85WjEwc4O064xmJS6f9qjS7ClPEBuPRSTg16NYIMAlKywdeiVOp
	 qdpelw1YAzVPQkw8mmT+aLxsM6g7V4Svq6ycTDOp6wilXxk2qzAY0vFmKQG/P6hum3StX
	 w/1+RwMawW1g6FT93CLnKbLzSc/sPIdkp1/hdvBb9Bi4Hh/PGZOQjGm5rBj6APTzsXv15
	 8IZFaimNdASWy58RI8lnDuoAtRSWBda4IZgVc6h9y4/2DMCED7SBSqwGETUeYNcq43HD3
	 Z1/DM6dT/xsEzDk0qqILITk8KxsTsgHe/pLwHpFof33QTGh16FcLC+w6pRJXkwQqvdg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=ouyVlE+t;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.45
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10120606A31F
	for <kvm@vger.kernel.org>; Fri, 23 Oct 2026 18:33:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 10120606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=ouyVlE+t
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6b1aa36fc0eso1780a12.0
        for <kvm@vger.kernel.org>; Fri, 23 Oct 2026 11:33:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792780412; cv=none;
        d=google.com; s=arc-20260327;
        b=OIXwURWydZQIpW5fbvLzL4CCoPmKWGL7QtMNVp0D0N5oYhP0iVBsaoDgArEUITmzqV
         ZjpNcUD8HbXv9RLTtVdep0vcFuwmNUsPL4KOhm+60Ml8HRnEhj/6yn9/uh2ucYNZ1KDI
         cG/GWrDWAqrGD99l9hV+sONVAQgu1feAaqr2bk5U6rA7AMy5KCcQ2twX4NyD0OU7bl6Z
         VGq8XrANxBxjijGY1hVcW4VyKK1ZxeC3Kawm3vc5oE7/AIW8TX0lunW3uQZyF9+mjHlh
         SJEz6WXMhWyTUY4KgFx66zrDtxlwTilAiqaAi/5fCLjY8iVWbwvQcsj7HMMXg2G95RGY
         PNFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lJ/PTfv5RXcFCq/Fmv1kk7W2C7lDfDCOzu0A1tXDMGI=;
        fh=tACTpY09ZYinGb8os2xl24ZVgO9SxVgKpebwUzIes3I=;
        b=HN2wVvF6E03kkQVro3rxsaq/tpY4fvHVwLVRFJaHj0Mk5eXtshYu1fkJ5MgQqO8o/b
         DXPJByOZKi7QnkkbX5WbKwHBdm70nQDZ3NUFidKE8R25qi/p3J53EiG+5QN4iWf0cuzb
         jIx9xUZgQhQYri/ls6oxrfOAief1zsdIJqYYyUPtegFGWerPRpvZr7tJ0tkRwXtlXnAk
         CnAGWc8n3gKgFqtU2xNG4KYMqpn4VYSndQUNb8+im2Xdt3OrAoMNGbKoq3DC2olihhNP
         GVJeZAyFizQNE6xTpn91PfHqowJsTDbmuJb1i6xISLbu8U39tD6ugZO4ogZnUE9e6fQ9
         2uLw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792780412; x=1793385212; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lJ/PTfv5RXcFCq/Fmv1kk7W2C7lDfDCOzu0A1tXDMGI=;
        b=ouyVlE+tjZggbTz9IPfAlCSRI9kRdKGAaLaDjGr+hBPcBH34MkLaa5erTh77aq4/7u
         hIP3wurytOhz05R0FADGgynVgyYfkOnS6Y8nwi0cEBnzQp+0Ru4boPB26Qx5Qb/tUaAH
         atCIKeHgnXxS3ViYZWy0YGWIGwTyVHA8y671I8YWfZI5C6coJKZHXTVKN3s23Wm5tCJV
         GYPi4cPKEzjidVSK1gFlBtNtkam7jykRz+KqU0P3ABF3kNU7w+VGjLJaNUutqoCqj/TP
         zJru9puV1P2oD9oUpIJsWFdNJPkye1y6QjeXZKa5x2/idGm7D122SUPvJmA4ejc60b9z
         ObDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792780412; x=1793385212;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lJ/PTfv5RXcFCq/Fmv1kk7W2C7lDfDCOzu0A1tXDMGI=;
        b=zg2jDcGD3+0mbFK1xSajeTQSm++qOyG6X9ORTmzXiSECKhiZLrTegwauFMlzW5tMzh
         qsZOmkR+ASp8YEA0BGg+7Ie9NnCkII9qo2vCFyfX8UeBX9CPdFXqD+k3KrOuj4wPM3BS
         DmVHR2ntYZs6Y+scOSdbVMUS5tkAvgoAqWn92AXDjZ/uC0imL2UDAArg1Osyj2qF01hY
         6C4rtEeK8h9UXjJn6K7HYLQITNO+xzGPF/jnR46XhnnYf3EC4zMfNMpLxVOXNMKzGwGa
         NGj6IbtVQFVfPjodv2m+uevMcEhXbs7TlQl2CM+2X/MIzYJnvnw6+zkt8keWvE2lwo0H
         NCIQ==
X-Forwarded-Encrypted: i=1; AKwUvBwl1u81mzUtdot0JLa/uIfKAi2+I1x2GwuvLuuvTLBqGgWLg7L1kcxtqrmTrHHQZ1D8aJg=@vger.kernel.org
X-Gm-Message-State: AFq9FYJrIlPoRWF5/76AwcmEHJJTRMO0+nRjvYtRYx9QTLaeZn1GoJkc
	TzUwTEVjRCLUe1EZOhEV0lnxB+Tm2nseJcvqbrTrYETlysv445g35PA57gxyEBpXevGj5hUx4o1
	sTT7Mf+7NbPqRoklXW70Dgn/0Smt1mXI0hSjzDxwC
X-Gm-Gg: AYBFou0sifLY/FqEvvV60MCadRjPmy8ekdufkxqWpFSbxSEnPMssfaqOxwWKqkLwbOa
	NkynwrAPYGra3RnpkXUF+Y/Qfb5HEHPv0LsnrvShzfPWeWYmxaYWlFwowUcU0Gn+SF0iNwLD9IP
	zXZElmvr5EZbmnxQ9OYhmWQq+xD4bRDj0AosgwDOwv4ogDvBDJseh35cpwg99UlMc0OoErtfmFx
	KM0syG5T97AgrgIdX0+tulS2ZdQ7T2ygMb0Fs06oibg7j+FactmG7ADla95T8xLzuEp6WGqyb/D
	x52W4Pkn3IYXOUr/tZQKbpspW0CntMkuWwqfJbzxEdDdC66uF7/uqyAeCmYrAFKai42QT8TqveL
	Ign1oOWLACuaw1Cj0Rs4eO0cNPPTfUaGtFg3vUTVL5Iw9v52mcTxVl7D+Zg==
X-Received: by 2002:a05:6402:1488:b0:6b4:18f4:94a0 with SMTP id
 4fb4d7f45d1cf-6b44260476amr7317a12.1.1792780411407; Fri, 23 Oct 2026 11:33:31
 -0700 (PDT)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260918193937.569414-1-zide.chen@intel.com> <20260918193937.569414-8-zide.chen@intel.com>
In-Reply-To: <20260918193937.569414-8-zide.chen@intel.com>
From: Jim Mattson <jmattson@google.com>
Date: Fri, 23 Oct 2026 11:33:19 -0700
X-Gm-Features: AclHuK_CT9diReeX_afaBUV3QEArYKCd0k-Zn51egC-a7l25vS2kQ6aRFfZD0_Q
Message-ID: <CALMp9eT-vAspszOpGu8Y=tj61Ed9NFre-fho_uHN7YGqbpnXSg@mail.gmail.com>
Subject: Re: [PATCH v9 07/12] KVM: x86/pmu: Emulate RDPMC on performance metrics
To: Zide Chen <zide.chen@intel.com>
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, kvm@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, 
	Stephane Eranian <eranian@google.com>, linux-kernel@vger.kernel.org, 
	Mingwei Zhang <mizhang@google.com>, Das Sandipan <Sandipan.Das@amd.com>, 
	Shukla Manali <Manali.Shukla@amd.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	Xudong Hao <xudong.hao@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 18, 2026 at 12:50=E2=80=AFPM Zide Chen <zide.chen@intel.com> wr=
ote:
>
> If the host has the PERF_METRICS capability but it's not present on
> the guest, RDPMC interception must be enabled and KVM should inject
> an #GP when the guest attempts a PERF_METRICS RDPMC.
>
> If the guest has PERF_METRICS but RDPMC interception is enabled for
> other reasons, KVM needs to emulate RDPMC with type 0x2000.
>
> Signed-off-by: Zide Chen <zide.chen@intel.com>
> Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Reviewed-by: Jim Mattson <jmattson@google.com>
