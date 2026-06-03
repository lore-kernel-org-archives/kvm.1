Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40AF03ED3A9
	for <kvm@vger.kernel.org>; Wed,  3 Jun 2026 16:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780505152; cv=none; b=tQry5g9+daauEGfFJ6ILkH0wpaguLZxP9+AoalJJ6zhppWN4ArJ60uHXBctctDKIRlyXHgVWOcv0d6ZEFs2xgtqpdaQlG8VPHcsV8DFf/u0lM4ipDflviMRnRQzi95cyjx5hUjOw+Ng0PQ6MPPCjLMvH5gZEozf0p03OvlbpcAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780505152; c=relaxed/simple;
	bh=pCptqsHzB54T4rm0Er4EFyVHuszS0WkY7ywKOYLCM5Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KOz+XVOJ3pJ7v8tD1tjTnEUEw0+YZApujHufOS7GoOg4MspQa/QYxIEmf6ids6HYoawEdQXnjm5xOqA6/VXtL9K6Wm+Vn6EUEt53HGB/+mWGBf2Qk6FrNnaCBU5GZ4KAQN6KggRvXcjI0YS4ZnXRXtOLkl5eIY/S+wSewkzZ6ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JBoZqlRy; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JBoZqlRy"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c85a2ed88c8so4573748a12.3
        for <kvm@vger.kernel.org>; Wed, 03 Jun 2026 09:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780505150; x=1781109950; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Yio5VBr229AwcfpuP70zgCX2ykYb87bx4MRDQdu02AI=;
        b=JBoZqlRyB2sO3FENkP3QEdj3umkoWYB9aB3ckB3+GjiS1lRkoaLvQ+TRZyuM7WP/L4
         wZLoU0mCZOqfFYCI2SVwCXuWZ9lknG8YrhgJNumy7et43T5kRgpEh9zuF5sWW+De9qJ4
         w4oEeuaudLdQPpNdPG0dULicmXTNYHGYyyM0wNALc3RAnqLoSffpZMT1EypteNHR+qv5
         GxQudOuWhLHeTMcPFxsOyvf+jeOPF6uH4lDF1+XDY0gZjxhgdvwEozlJ4kBdL3K6lF9k
         hB1Gc/MfwdveTS62xfsYuClPiwc0En7lKBcMvSQ6Xr0g1p+MPEPYdbUtEcoacXSZQBmt
         QY4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780505150; x=1781109950;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Yio5VBr229AwcfpuP70zgCX2ykYb87bx4MRDQdu02AI=;
        b=Afv5ML9fYYHa8JZqcTmWm/v5B+hEzGyLHN7u5swfT1fTQz5I4etCkH5mr8sij52x2v
         iB0dv6gSDM7LyYTSyMgm6oE1RhxoNu/htkBso/Y48Xekdk5URazAdzQk24pHjhiTrUMe
         jk8ot8tsDXNG29/7ffj7j3NT4fLXe8cP/o8mVMThNLTOjozKPA60uw+UKbSt+FVGbXCG
         8xXGc+X7iGvxrixBkKVgqzT2Sh546QutxCtGr5EAMje8W+2d1WUKC/vYibhsAUtX1gXi
         WcxfIiNep4ow/rBtVNge4nqTYPRIxPF10Lcfv2KPFflOU55Jc/eXkDSOd9p58zjR+uzG
         auqA==
X-Gm-Message-State: AOJu0YxnDC2OXwgInLTOcZCCBga48/FguotsLHU63AIed2v8d2dpmboD
	/KecjOooMVNXF+7x7HmKssp/DmMkJPEuvYoGGk7cyCQqgSwJoT52Q0MH985graKNExoqXCTUsxf
	aHpem6Q==
X-Received: from pgbbx2.prod.google.com ([2002:a05:6a02:502:b0:c85:dc1c:c8ea])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:d708:b0:3a2:e26b:2940
 with SMTP id adf61e73a8af0-3b49722bd0cmr4886460637.0.1780505150285; Wed, 03
 Jun 2026 09:45:50 -0700 (PDT)
Date: Wed, 3 Jun 2026 09:45:49 -0700
In-Reply-To: <ah7uzuAHyQh2GI7T@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260601133320.91479-2-clopez@suse.de> <ah7uzuAHyQh2GI7T@google.com>
Message-ID: <aiBaPdVL1R4z-xm_@google.com>
Subject: Re: [PATCH] KVM: x86: fix #GP check in em_dr_write()
From: Sean Christopherson <seanjc@google.com>
To: "Carlos =?utf-8?B?TMOzcGV6?=" <clopez@suse.de>
Cc: kvm@vger.kernel.org, pbonzini@redhat.com, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, 
	"maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, 
	"open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 02, 2026, Sean Christopherson wrote:
> On Mon, Jun 01, 2026, Carlos L=C3=B3pez wrote:
> > The practical impact is limited, as check_dr_write() already checks DR6
> > and DR7 manually. However, it misses DR4/DR5, which alias DR6/DR7 when
> > CR4.DE=3D0.
>=20
> *sigh* (not at your patch, at the existing code)
>=20
> Which, after digging into *why* check_dr_write() checks DR6/DR7, highligh=
ts that
> this fix is incomplete.  em_dr_write() can't rely on ->set_dr() for #GP c=
hecks,
> because unfortunately for us, the #GP check has priority over DR intercep=
ts on
> SVM, and over DR7.GD (General Detect) #DBs.

And testing fail.  The DR7.GD #DB has priority, I forgot that DR7.GD is cle=
ared
by the CPU on delivery of the #DB.
