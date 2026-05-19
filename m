Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4235D3403F4
	for <kvm@vger.kernel.org>; Tue, 19 May 2026 13:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779198839; cv=pass; b=uFNLQpn9RsNOa+0XlYcjrj4GwUMYrcMrNC/2M4e5xFJU5Mz6xdjnyKwXKSBCqNw5YgL/MrI900V7gUpzJaPj4VgqNlEaaZrupjtBnoeeFnXhIesBIS0B+qBTdHJ2NEzYmJv6K5G2lUclXdJGZ6x1Ai4CmPW2WI/0/MQSBWiUVEY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779198839; c=relaxed/simple;
	bh=YzdHAhYUrbTCX46WUv58l87g2Iwam1VpditQTACnMS0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T8BQ9PcN1bCHw3FjJ3zzdi3zjoUosEBRRH7HDZOsDuTQo4vNfpLqACE8BuQ2iWOCho8y0ylkYjBhJNnGpkYWczhKjtFG95RaPIbHbSW+p8d35tiCtOXLWuy+Y6UOdHojN3/t/mIul+cNi5gjHFz/pFlVbN4Eht+GJcf4mcdPiiU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bJxyrxX9; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Lf+bsMZA; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bJxyrxX9";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lf+bsMZA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779198834;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gMJunAX4GgTUnfdlT58BrIL66UezK+YQZcmeEHYrE2w=;
	b=bJxyrxX9/PAKsOJJAaEElb9fM6ieL2xmcNkvPgImSq5W/ExtYIGrRX30pg2BiEYi8cIlFT
	PK4Dh3uvo0fu/SUuVpw6vxvgW2XmW7NDu/8ySXR7KMCbiWH74TFdnyafypoXiQhh3PwHHy
	MlweNlBBMo2vK8svw2UBSIDX1bojKqk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-530-plfqGHofPLmvOWocTXHf7g-1; Tue, 19 May 2026 09:53:47 -0400
X-MC-Unique: plfqGHofPLmvOWocTXHf7g-1
X-Mimecast-MFC-AGG-ID: plfqGHofPLmvOWocTXHf7g_1779198826
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-48a589c7879so30396845e9.1
        for <kvm@vger.kernel.org>; Tue, 19 May 2026 06:53:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779198826; cv=none;
        d=google.com; s=arc-20240605;
        b=h7XSri+s+j+bYtFp/kpc5xtf/R5nwbfkK2okbZ63X4Iv2zgftfgRMYa1bJL5EnL01/
         4uaHPUPkikduXU+5cjyx/BZKt3npvEs7TaUvN/iFH/LmPdqiw7fIYr3nF4OyF8kcmkO+
         p6p88yS8A68S0y8jrFHh81VgM+HMsFBlsntgAvtL6YyHjnaG/hpPeSJ6h071Aq1xdCZ8
         mkrPERcwq5W0mPC6BpJYtsVNTzlEVVUfOTNrLFEYQhXTggeiweKY4dEm/6MBlV4qImPG
         +866rrIEpcc4YkfMD3a0ffq4teCD/teQ+93j2wZHkw8YUyTzagi2xMmqw+ggo+3FyJep
         GKXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gMJunAX4GgTUnfdlT58BrIL66UezK+YQZcmeEHYrE2w=;
        fh=+POemsyOFRr6IoxFH42DVNxRFTqXZGc90axBNomb1G4=;
        b=X1GCpXUFjTc/gbVo9rTakPBoQfIPY/8dL/8rdf8tekOaQabOrqWBBaqItCKOT7Z51C
         QOatatDbOteA/7LvucuqfKXSoYcbMR9iuFcwRNxGiw5+DUgKZcWlrXCtI/ZHKChdJ2s9
         3T51Qxs5dMI0pPr1lhOm3pTuYRHE3xs0fvHd7+lK+lD6Gqbhjedw+K5O3TKrwnUxV6h5
         sRuJa+3x9WEloShinma4vhdP6M02WvocRXgArupJK2wG02Asv0UiWQ12PcTSr/r2dglU
         OVwE0RF5zIulm3EGnfbdr4ZPw+j73jDpOHR/YiLelXBUg/H7t0heGW9qRJ9W6OwibQ5V
         q79w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1779198826; x=1779803626; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gMJunAX4GgTUnfdlT58BrIL66UezK+YQZcmeEHYrE2w=;
        b=Lf+bsMZAXbnC39c7RHH+LcfzXLWB49fqiRtduik4NRRfs8PaWKKVq+l5ZPVCCigUw8
         6BNamJIPAnXG1pkfQ00cr3rv0p8XNdh2K9Dw0V0+N77TxcRPbtblKE2LX2/k3L/7ij3/
         toEXYxggaxGyelUcnJ0F1z5kfA6M9UxKXBvfXx5jWqjBBjMzSCXpXavrZBm2umlegWCh
         Jc2RKEanpHA7ijDxwwzL1CYS3Fa/qlyQl+N+SleJpudgXWStQxf6YhRs2JbcvyZft+Vj
         ePtLbFk6/psX41kk5+e+X4U2vdft13b+9Y8bBi7QPH+JZ+sQh3SUbbwzkIOrNby4Uknb
         hFAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779198826; x=1779803626;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gMJunAX4GgTUnfdlT58BrIL66UezK+YQZcmeEHYrE2w=;
        b=FhcLCnIoWw8/1Xi3mseRz2gsTZFnjScKYob84FPlNbdowgaXnt0HSyto6ZlzY2lExu
         GzyoKPBnOEtZHVrMXdrZrbb/nbfpiAQotGxLQaLm7W/2QdFncl2sAb5Kcg7rwLHqVvHZ
         KKS2WH30cHV9yIPke+YT9As/y1rb3JfeOw8YecSSGhoiW8pRwTR4s09YRWMC5+HPp8Op
         tWdVDodwuUDwa6OfKbkS6mdjroTfg1y0+gF+BywYWXSO3upcKnwRsj6Zd2pIN32Sb99Z
         /3UhJe4EfDhj03WiUUA4oqZTGVylGsQKB7iUJIoWZYwcDOe6PtdZkWHwUprjs5NeI0u/
         rJSg==
X-Forwarded-Encrypted: i=1; AFNElJ8IsImAVlMJlpGoYtMbeizg+/O5tPgZI0m8vsOP43xgRDBaYJJtZYgwytcQ2qSpjSsDZnU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvlgZiHNmy6fQF/sfJ+KWAY9Z7i41wf0wRzs9TxzYYmr7/Ocu/
	y0wDO/eXFzk4sO26JzpAHg72/zPz3Pjs1JxPCv51A24DT1qPKGOrcs++n4IThWu2DnkKmLJYaQy
	gplxKtn3a3eJk9RqLBwrXG1z39ATIlh8PRgXJnc/958mMhEYa7vZ0Cfslb3dZtJFzp0aaOnbx98
	/VCOMQ6wci3Y5Dwvhkb/6L73hrXrp9
X-Gm-Gg: Acq92OFK4/J3wDFb6mWoJNTOoiMuRpVjP0XbahE8kx1v6pfnxpShLkCOmq+doBFtbgr
	/7q5AEPfnUMaDUcWrGpjSFIW+102InmA7L0cHeWyAouJ+HB2GLxav8oBYgAwFQn7zA1r01vzwlR
	qaMUn4DTm3vsaY72V5KayRzIu5XhiQX7MRQp8TtmxTw9G5xQF9kG6PTidWMzQE0AR9uGGXLxAsa
	yWw5kebSW6+iyuvGFHKU0DOaVFlkr0eBnFAuTelzwz/rB3AXJmrDDWgYmImkiYc8mtrUCuZN7nj
	rrQfMg==
X-Received: by 2002:a05:600c:4851:b0:48a:79d8:a8d6 with SMTP id 5b1f17b1804b1-48feea99dc7mr159587175e9.7.1779198826419;
        Tue, 19 May 2026 06:53:46 -0700 (PDT)
X-Received: by 2002:a05:600c:4851:b0:48a:79d8:a8d6 with SMTP id
 5b1f17b1804b1-48feea99dc7mr159586875e9.7.1779198826081; Tue, 19 May 2026
 06:53:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6856b269d2af706eae397e0cf9c1231f89d9a932.camel@infradead.org>
 <6afc4b95-3c15-4d71-877d-19b84e91ce05@redhat.com> <57bc082f4824d6114d3156744c25986effc29aca.camel@infradead.org>
 <baff82ca-6321-4b16-aa61-b2d6d60b6535@redhat.com> <86h5obya2r.wl-maz@kernel.org>
 <48b06e5655d56ff6eda30e563b34894fa0eb2f07.camel@infradead.org>
 <ba08dfe9-932b-40c3-9fdf-fc891d52e1d8@redhat.com> <d9d4471a7f5ec1e297b3ca07f42a59090aa91e15.camel@infradead.org>
 <CABgObfaM-JtNn2MuYXaiadQnLfAhTEaoHAcTG9=J6LkMcQCJ3A@mail.gmail.com>
 <3f9d731c3d26b0367600f1069e6425099bc34eac.camel@infradead.org>
 <agxFbniU_6eQ98t2@willie-the-truck> <cf429f2082e863571595f74d1d3dedc3e6a82964.camel@infradead.org>
 <CABgObfacAYexR25SMi1kSZMRnHx3EDGj8=E84V1DumER66ibnQ@mail.gmail.com>
 <86qzn7wp3y.wl-maz@kernel.org> <593a782c50f3c8656e13b36dfb975a67d43a908e.camel@infradead.org>
In-Reply-To: <593a782c50f3c8656e13b36dfb975a67d43a908e.camel@infradead.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 19 May 2026 15:53:19 +0200
X-Gm-Features: AVHnY4J8OrpUxEzodEMJc7lM9sDn1bgq4nXZ_hmQu7D8CU-GrOTBpsMt27h0TJk
Message-ID: <CABgObfbS-z3OphDna5W_JQPvw+OK=yXJurVMHp1ANZ5uGEgVhQ@mail.gmail.com>
Subject: Re: [PATCH] Documentation: KVM: Document guest-visible compatibility expectations
To: David Woodhouse <dwmw2@infradead.org>
Cc: Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, kvm <kvm@vger.kernel.org>, 
	Linux Doc Mailing List <linux-doc@vger.kernel.org>, 
	"Kernel Mailing List, Linux" <linux-kernel@vger.kernel.org>, Sean Christopherson <seanjc@google.com>, 
	Jim Mattson <jmattson@google.com>, Oliver Upton <oupton@kernel.org>, Joey Gouly <joey.gouly@arm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Raghavendra Rao Ananta <rananta@google.com>, 
	Eric Auger <eric.auger@redhat.com>, Kees Cook <kees@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Nathan Chancellor <nathan@kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, 
	kvmarm@lists.linux.dev, linux-kselftest <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 19, 2026 at 3:00=E2=80=AFPM David Woodhouse <dwmw2@infradead.or=
g> wrote:
> Or some guest configurations which have only ever been tested under KVM
> could have a bug where they *rely* on the registers not being writable,
> and write values which are inconsistent with the rest of their
> configuration. Which breaks the moment those registers become writable.

Yeah, just having guests that worked by utter chance - but you still
don't want to break them - is the case that is most likely. Crappy
code that runs only under emulation/virtualization appears with
probability 1 over time.

Is this likely in this specific case---probably not, honestly.
Christoffer's patch dates back to 2018 (commit d53c2c29ae0d); *back
then* KVM/Arm was a lot less mature, and people developing for Arm on
vanilla upstream kernels have moved on from Linux 4.19.

I would still lean towards accepting the code considering the limited
complexity of the addition (in fact I like it more now that it uses
IIDR instead of v2_groups_user_writable, but that's taste).  However,
there's a huge difference between setting expectations based on 2018
vs 2026 maturity, and perhaps that's why Marc overall is inclined to
put this in the category of pointless bug for bug compatibility?

In any case, there's no arguing over this documentation patch, which
is already a good thing to know.

Thanks,

Paolo

> And those hypothetical cases *do* happen. All of the time. There's a
> massive zoo of guest operating systems; not just the major players like
> Linux, FreeBSD and Windows but a whole bunch of embedded home-grown and
> network appliance kernels.
>
> Nobody is claiming that we shouldn't fix any bug ever.

