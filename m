Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2BF7375F88
	for <kvm@vger.kernel.org>; Tue, 23 Jun 2026 00:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782174426; cv=none; b=rO5hgJVmN8Tx/KXWyC+ew+A/wrErH2YfAYSdFuH3uhmjs955+355KFhO9ZpLVuG1VRNrwA6In+jvBc5VrOr+I+5ZtzWQt4BDP+hA3Y7g9kffbAE7ev6sp/oReOI3sCDGXgluXxRutZ641293s1FHRLJL1a52eDbIpOULg31ccPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782174426; c=relaxed/simple;
	bh=44b40FNP+GAQbQbXKQNOho2js7AD+VaXNZPF5DFDsMg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=AMDMkzcbTI0Wkx6OVwW20aCqxdXoBD/ixgAG5uD1Y6wqrgHEzoLbvSiau4iQBGssKDLag8HYjqubKEV27F47Pd8fz77gNAs7CuUJJSwEXKR4xZEZM/Iv20ci3fF1CP2+YljPTTS97Gw+Xud5SEw/6KATN0O2rPpv0U7mBh8I7Zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Loepo0Vw; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Loepo0Vw"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-8453031c567so3327357b3a.1
        for <kvm@vger.kernel.org>; Mon, 22 Jun 2026 17:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782174425; x=1782779225; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Aq/owXnFX88Pz3Pf4JSEwe3XNyjNB1kqyEi1wlombTc=;
        b=Loepo0Vws7++s5ujop9ShTMSi1iy2qvno/TiI5bU/cckm3LTfAM7qh3xUBDehIK/s5
         FEhUOspYhhyxshCoXK64CVf75X22RXsUcgGCt8I8EgqpMgAGIVgBND6TKl1PK6U6sEQh
         riBoifZeZsbdloBHYhTG2OtOoXUVWQoVIWB2m7cSH8ZmjLicH8DPYch1ZZHHrUgW8paB
         Pie33G8iSuBL6eWJ6XDdI0D01cyIcUPX8yEdK4z+DvtVTFE/SMX0o8n6tit0hfx//gqv
         2UMWXwRUQD/S++c1qYWlosxJ92aFaCwHlwrmNe8K2t1i22rIKduxGXdl3LbIR2kg8WY9
         Wc9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782174425; x=1782779225;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Aq/owXnFX88Pz3Pf4JSEwe3XNyjNB1kqyEi1wlombTc=;
        b=Nn5bkeDTPQp40Jzm7KXCE8IiPBYQiErUjOZJh6daZH9pPFSQwol7qWIxEI4kk7a5Ym
         /jtvpzlPZdoVQezPWWwfkrZWFoBXFdiPl+5RyRH66HoNMcdZU7aBYDIIDxnhHfk8atd0
         oo8lgBoJMV3C7pQpqLvsKZfr+hysFgg43DGLAhfF5WBYZgoEbAbmXv/l735ll2fyJHpH
         +c0BH6FzjokrAr5CRIJu2aOmcO/IXv9kfFiUd1R302X58FdFdOL5qzL1uA3xzceFubxT
         6V9j208j9vj/bMibzx4hBbGimm5m1/ilp3yRo+wjFmHG/OAfsMlq6ROouOIAJdCAd6NI
         iDUw==
X-Forwarded-Encrypted: i=1; AFNElJ/ywDPmhD5RfRp/yyupwpaslhGg9JcCqK3BZJ72aqVbSfsF+riql9Hgdw5NAVSEBSgUDno=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw064R82Ek2rSIgGTfRbxGfx2gN1z9DRbLcxV4+OhfziV5ArTAh
	bNySb0ECYQUzdnY+3pX2TGmclBdSF4I3sWpxebfjVlx2WWXp+K19E2igrePDwy0Y+kxv1aKQfL9
	5tV4JTQ==
X-Received: from pfwo4.prod.google.com ([2002:a05:6a00:1bc4:b0:845:47bc:59de])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:ccd:b0:842:5ea5:5fdd
 with SMTP id d2e1a72fcca58-84595440182mr611845b3a.40.1782174424841; Mon, 22
 Jun 2026 17:27:04 -0700 (PDT)
Date: Mon, 22 Jun 2026 17:27:04 -0700
In-Reply-To: <CA+EHjTzQhOi-qeiNGpn50o_ko2Cp05qzuKwhiZCgLPCyiwWhrw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260618-gmem-inplace-conversion-v8-0-9d2959357853@google.com>
 <20260618-gmem-inplace-conversion-v8-17-9d2959357853@google.com>
 <20260619005320.51A8F1F000E9@smtp.kernel.org> <CA+EHjTzQhOi-qeiNGpn50o_ko2Cp05qzuKwhiZCgLPCyiwWhrw@mail.gmail.com>
Message-ID: <ajnS2NmvfBtgLKky@google.com>
Subject: Re: [PATCH v8 17/46] KVM: guest_memfd: Advertise KVM_SET_MEMORY_ATTRIBUTES2
 ioctl
From: Sean Christopherson <seanjc@google.com>
To: Fuad Tabba <tabba@google.com>
Cc: sashiko-reviews@lists.linux.dev, 
	Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org>, kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Fri, Jun 19, 2026, Fuad Tabba wrote:
> On Fri, 19 Jun 2026 at 01:53, <sashiko-bot@kernel.org> wrote:
> >
> > Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> > - [Medium] Missing compat_ioctl handler for guest_memfd file operations causes KVM_SET_MEMORY_ATTRIBUTES2 to fail with -ENOTTY for 32-bit userspace.
> 
> guest_memfd is gated on 64-bit: x86 selects KVM_GUEST_MEMFD only under
> X86_64 (arch/x86/kvm/Kconfig:50), and arm64 is 64-bit only. Is 32-bit
> userspace with guest_memfd a supported configuration?

Good question, I genuinely have no idea.  My preference would be to do nothing
for now, and wait to add the (AIUI) one-liner "fix" until someone comes along
with a decent use case.
