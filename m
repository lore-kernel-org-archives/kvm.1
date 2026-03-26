Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE9B641C72
	for <kvm@vger.kernel.org>; Thu, 26 Mar 2026 21:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774559940; cv=pass; b=LVbwKgIEGPqxDgVtgj4CNJHTlomEzgUiiRbO/p1lcFmekL2u94AGlFvS2JgXO4TvlMRTt73ZLqlDKuGLCMoWrlwapjEJ6jFST91CVkjKlMs08R1NrbpprzdpW2tIzNsF5sLcVJX1Olp6dlH+3AJDXorwOz7DNTuXVkiLciYcUJ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774559940; c=relaxed/simple;
	bh=LHXuVvweXDZuWeCrMV5tl7IRS4OHIF5ZwsqkAGrl3rc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HlqYRiCkWrN9VCBB7SgxkojntQMwNqaLqV1X1fTUR6FovnWcXiZclzCpUt0hQ5/T0QUljjKvvpXvBticGy3UBgzA61TO5IpRWKaeSTP93HCQ4BWdZYbE9N9hqrPuW4h590GTihLGJA1h6cG/9w16MrMC9KKJ2jjoJcNFESJAxAE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=llPpyUlU; arc=pass smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="llPpyUlU"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-661ce258878so3567a12.0
        for <kvm@vger.kernel.org>; Thu, 26 Mar 2026 14:18:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774559937; cv=none;
        d=google.com; s=arc-20240605;
        b=Cdr8/8lQxuIJTwCbtiiO7NgOblNRkIrRHZq9tV1nK1YioHZN8oEKkgGw7ga0WImBlG
         daQfd+xOSZbWafz25jgwgaFuUcT0pF1pfPkzQ3VJRmTVbgtXTP8X5o+1PJ4zQXwoCfHe
         0r+Wcqvt9xWy1BbmU24NpynJt8I0Z9i9niX4weHCgCXXk3+FCmWYkrlqy8yUa3hxbmPX
         xxHiYctSVxpc9po2ffiQuKZzT5079/5AB4BWk/BErFBa/S6VZNFgIx2AVTuNp0OfHnxT
         sY3tV+oFw6qIUglcE5XEI3GnJGQmWMO4kLMKNjqW+qotCicz8vlEFMTX/+ijROEgb3Hf
         zQhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XlLfO1cb/56+ur6tHTeZ+IQnj7HVuNrwyloRMOxQArc=;
        fh=kJZDKY8R00hl7MvHx7ul18Abx445mwmhZrv5ZlFwMrg=;
        b=Gga1jtt3amBYDxzrVMCcCPF3OYTZFasfzfWh5E008ZZGAhnx6jFHKpoFmYXDk/xsmq
         FhYndPcRArYvGBfxNCA+pCcE8WWXJqe85FRs0WskNUO9Jasa24nLbCLCQ8x8bZ26KIgX
         7Wa9uHiwFnTUGbur2LRXEjJ6PRzAVyI1KRboVPLkJyYABDEN/ILCNnv6udmFKNFxGlpz
         WYtP872cs++4yrz9DhDzEbEWUiqUavMLclmKwQjFdA2Mvywn9JsBohmt/NFAB6VbBK14
         8TNE+wdm7eTeAr4TLCzDjig8s/yExlfSMwXM8/pQHTk35oKjQ2W/eibRss0re4NrV8A3
         5Q8A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774559937; x=1775164737; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XlLfO1cb/56+ur6tHTeZ+IQnj7HVuNrwyloRMOxQArc=;
        b=llPpyUlUr0KStHgj7OEnr4yp5dllmuxGBCYCyqwSYnXBcQmFeX0JUD1SWRUArtVD6c
         y8FKnxOGMkIMBZ1ZKkFvCOJ0sSdHPoO9266DIgLFff8/4BmNQWloi2+mCfrp2OrnHNkb
         Ha64R3KUwv5fcnzJowesGQ4GBOG7GmM0NxvrEG4oOuH26EleySz8jcBSZQyXMJIVfVa1
         yDgg7P92XR0VJ0cvlDHocwTJicQTL/Mac+wUDJBh2i+/mlwj+VeySjvvEVaZsf6C4eN+
         updxwqNkDPxW2r2VZPdt+5T8Dk4yURTp0EWqI3mSr+GV4c6HjuaXt7Zo/7VtNrPN6o+O
         YzDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774559937; x=1775164737;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XlLfO1cb/56+ur6tHTeZ+IQnj7HVuNrwyloRMOxQArc=;
        b=s3ehyBC8hVTuxIwKP8eA7/BWLiAgWciLEltnLCB0PMWsbeVTNcotw/khCG9sazxBDa
         r599+U0eOYWRHqnKDbtJEpy1Fh5MDPvaq/fX2MTZHU5SuDm6A7fL9sd8EH9AupqsDr7x
         Fx5WyoRcMcc7qfejAj/Ck9ci+8PENXTZC4YBMrPHLiYNito+F5UswopAGMHcdfutEEJX
         dmw2l+aUNRL8wA6yryITQZW3N7xddm0BufKZmVQ7rrpdGz29i2FeWn22jsh4Hme75t2S
         2yq6lFpkXqfdzqR5/86KANZ6N+ubTFx8JC0m7xkz4CRKDsPoVJSRpAFD5rNM/IMkrlyb
         cyoA==
X-Forwarded-Encrypted: i=1; AJvYcCVSwm0e/GHoQUb87GhugM/xsaiTaXVZG9TenB5b6kTfMhIBLKFhX7cp5Np2SWsXh986ja0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyF4//2B4DHJ4kE8hgmgseI2vlhXLhnRZGL+UBFQlPh3SdLmkp5
	c67hnO2JWB8z8wTCdL0p9j9ZU+EByd8Vt2IZpCrCasS+WoRFwr84ez4vSirFPRkBrRr1zubwQHJ
	yu/i91oWi/sYP4i0u2qQPjuRR7e1ayFzQtoHm///S4daEsZ7+bOLq3YyU
X-Gm-Gg: ATEYQzyEa3TWIfq4KdxCpUhsvSb+NYeyJpAuouGE5fWyq02sGLcsXTTbv3d4z4TYdGi
	Si81sHjgC8XVtQ24vfHAEKv847uvkaJ7mw2VR5hnjlENr2+yshx3Pj1FesgWmReK/3uuTgpVtEm
	sSDPXdDLRACe7//5lRj8BkZf6AXE5iv4jL7A8YskJKaCMnGaCtvarmKF66NnJfD9dbvo1XDymQM
	KPHD0M3stALxDxcUsivGKlWdf5MZh7sPdEXiE16lF2IV8n37NLB9zj4DtMG9n56m+NiOYDEeOQb
	z5OcYXY=
X-Received: by 2002:a05:6402:524e:b0:660:efc9:900a with SMTP id
 4fb4d7f45d1cf-66b19d7cdc5mr18822a12.10.1774559936890; Thu, 26 Mar 2026
 14:18:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260212155905.3448571-1-jmattson@google.com> <20260212155905.3448571-5-jmattson@google.com>
 <gqj4y6awen5dfxy32lbskcxw6xdv4xiiouycyftjacndjinhvp@7p4dtgdh6tjw>
 <aY9BPKhzgxo4UuHB@google.com> <CALMp9eR4ayj_gwsDQVH8pQvzqgEYVB6ExWp3aFgJXRWikLEikw@mail.gmail.com>
 <aY-jViitsLQm9B83@google.com> <CALMp9eTnXW9=0=+RxQjeXfA++UP3MX0LzXo5qwUP-dCCQjOLVQ@mail.gmail.com>
 <aZT5eldlkLpRm7OD@google.com>
In-Reply-To: <aZT5eldlkLpRm7OD@google.com>
From: Jim Mattson <jmattson@google.com>
Date: Thu, 26 Mar 2026 14:18:45 -0700
X-Gm-Features: AQROBzClx4xb_etceN2ElQB1z6O88taXT4sIAxaMd0Q0vu_Cb_3vGIogkatkpLE
Message-ID: <CALMp9eSMLwiE7JPs53w8Nyq2HB-Thmv3wNiRkMV1zrJmJeoZag@mail.gmail.com>
Subject: Re: [PATCH v4 4/8] KVM: x86: nSVM: Redirect IA32_PAT accesses to
 either hPAT or gPAT
To: Sean Christopherson <seanjc@google.com>
Cc: Yosry Ahmed <yosry.ahmed@linux.dev>, Paolo Bonzini <pbonzini@redhat.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Shuah Khan <shuah@kernel.org>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 17, 2026 at 3:27=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:

> Side topic, either as a prep patch (to duplicate code) or as a follow-up =
patch
> (to move the PAT handling in x86.c to vmx.c), the "common" handling of PA=
T should
> be fully forked between VMX and SVM.  As of this patch, it's not just mis=
leading,
> it's actively dangerous since calling kvm_get_msr_common() for SVM would =
get the
> wrong value.

Though I included this change in v5 and v6, TIL that TDX calls
kvm_[gs]et_msr_common(MSR_IA32_CR_PAT), so the common handling is not
fully forked.
