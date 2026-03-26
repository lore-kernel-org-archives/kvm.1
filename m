Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0365E322A00
	for <kvm@vger.kernel.org>; Thu, 26 Mar 2026 21:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774562220; cv=pass; b=uV4/WSkUtH2fhkBwBX3wMWdS9VQizMiw62ryLWqC/fFgxhQAHrEKCbeZVPrEEI2Jo86sOxrkGuKHIm3pD0XABPdbSpt+xzD0n+J1iHcVaItHrNzYNv0MAGYKw0E4XsodJ/RlfmreDoOoulrvhrfN1S3Aib4AU09n17QGRA6IDOs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774562220; c=relaxed/simple;
	bh=vbWIOEfqSbsqmebzcidRuMdnREb+FHm0JupshMflAjg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jUUBXJj6NfpwpmYmh7PtyB/gCN2dTEjGuFiVYdc5A1nYqWiDLlwKSfOOLquy5XsqZZ63PDXDSTIdIFC3MHhvconBWjfhG2fbaEE8eM1hmn6tH2axa0nzHaDWjMjkjYEGoZTzqP8wZUfXHMGowK5eAAzTI4l5oRO7urtVm0TOKGM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EYR6T130; arc=pass smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EYR6T130"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-661ce258878so3863a12.0
        for <kvm@vger.kernel.org>; Thu, 26 Mar 2026 14:56:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774562217; cv=none;
        d=google.com; s=arc-20240605;
        b=Q5r1yItL23bMgMbAXZRmnphx2LFI7D6U4dWLKE2PXc3vI0KnC6wye7tvJWvKfiGJ02
         wLQAWVj0Ifz93Bvg/XmH1n5pzcaHzg5ziwDcwdKrHXWVX0nNQrfjTZ8nHg0mplYXvdSO
         IjWv3CzMl+U/Y6czoPeIx4+5u2ju5qIAJMI3+DymlZYJv5uZ5fjH8BNrtLZQn0TV0V6m
         VWNJhAMudA9U9poPU7WwuPPLewQ+c+v/GM2d2mPm982xA+zZ+HY3HlyYw08wEoQzFzIK
         oPGpp0dnluZmdLZAgJneMUHFr77d2b7fkQa9hjO+Jo0+qvfM4CsH0zKs+gsU2NvRV6S0
         gicQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MEmcE5ZcVNzsLkYYvvz4gjReNb+1g33mjp+MWnHjCUo=;
        fh=9uYmSCFqs5rotygwQMTGb5yZS9soLr6l1q8dcw9kLcc=;
        b=CdloVTQkIekvuiWWLcUFh6yEtSkel3rCrqOfFQobunzcB8uEdtLhOr2L17qX9qxyd9
         8m/EaWXDbPiAn1nhIlBOWImfySyyart+NtmVIXqc8b+OKoLtDn2x2l8+MutbqVBLs+Qb
         o42cWfeEWKVsU19nj7RICUkAMceG4GfIlqNf2NGSXGVqCtRKciVYxCWgmxasnEfB2GNJ
         lp3IJWHJDBv4efyfKz5KJkMzCP5JYbXI3G7C0in9HFW/tfrR4a0+eawvefSUv/c0yYBJ
         r41YoC774kb8B8aYnwz3tiikJZ7fEoc7FOzPpYpWPQr1iNmidrOTFGIJ3ee9D/TM17/H
         BP9A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774562217; x=1775167017; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MEmcE5ZcVNzsLkYYvvz4gjReNb+1g33mjp+MWnHjCUo=;
        b=EYR6T130QGrlYd/rzeTGvEqJSf5mN3SQIu4wZpbG8gFJ1D9LIpl1MUcAkQBxe99soq
         NTdqIJEw45auvuQEPSQJBLMe2wQYZ3OJc5W6C4jKLRiABdwifwRYqxpdWP6iGQMtEhKR
         E4TqE5JqaIC9mIfxipAdogWB7B5F69QXslS42mlAOZrMVucEzbu2ShJUhIOWPMtImn4Z
         bOP0KhZ2cQSYDMbHhQz8Wd1PUP4kti1Em2esxGGaFHyvO7sTCPWfTRQFi4/uqiI45uOJ
         yOldmbbr0bZVFi/zdkumJB7HzMECizO9Izb+8ErfY+OgvTZ5R3h1n5r2qd/DjjzV5Ui2
         d/vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774562217; x=1775167017;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MEmcE5ZcVNzsLkYYvvz4gjReNb+1g33mjp+MWnHjCUo=;
        b=I8d2WJG23A8aR/TGYm/a1m/cJ/YFn+2ijl3si5/S0m8OEFx8E9ERzdNEdekAJsix+H
         SsojKU4ftTjPhOUUGu2rDk/Oeh1x27wVM3f+qfE1r3iLbBPS6F6rxdeK6Cr7Wpu2r7na
         oCvYz7HzUCR1TV0qpeCK/pfUhcj3x6xwOBmO0TM/pjGcMfcpgTkQJ1oDpGSsTfBrO5Uk
         NcqFaavlSADz0+s0qgV1pm1c8FyDIipwKSIxELw1fcl7dZaTu5I+ITjXRdbr2qvw5YRP
         s4jpeiQ/dUb5k+VnBcek9N2Gv9BzsVmHgyYEK8n086CXTPWjFIUx5ShjsAFOzZQjGtVW
         Q1kw==
X-Forwarded-Encrypted: i=1; AJvYcCWYn8BvpDH/g+ZbE3+9dJBOweZH0sGsSNhprVb2gHpOILqzT4+2MiXVdOxYhWrxoS5R0cs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yye7HsImcziUMvV8L3DyOSTY9CYHJWtu8sHAPUyoLgqnje7GWOk
	cG9MtSl4RhwaNHB0Vm/PgTiDmZUG8JzbnmG9ZBW579yf18z8E2biGM1CsLUelZTp6jgA4P+yMnl
	OqExndLEc3KGkwpM68QAKIwrE0LDOcpm7Wp0SCUmG
X-Gm-Gg: ATEYQzwY53O8WMbArom2zk2h0034EhxRJ/9+ZWHe7AJ+W0DvMYshmRz/O/7SNC8fdb0
	8ELRocX7jtNXKwd8tRy5H9xEMG5sVS2klnfKtvEb5UPNU6HqPN+fXUPYB5bGF3kkdALxc7ySAgH
	sCFfoa2Br77bR1n1PRKYBWe1ZIJysbryYlbJn4n4PFtPRUDK8sNBxlrrozQvmltS3T5DFSdtXGx
	atyhBnf9Punh7pHzL7MWat6ncyWCCx/tgB7cJYoO0lOpA5dBmeAl6NWugPQAJluQwDq3EYJcqXy
	lEQW/PtZlGZenuD6Bw==
X-Received: by 2002:aa7:c757:0:b0:665:d39:4afc with SMTP id
 4fb4d7f45d1cf-66b19d7f94amr13694a12.6.1774562216825; Thu, 26 Mar 2026
 14:56:56 -0700 (PDT)
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
 <aZT5eldlkLpRm7OD@google.com> <CALMp9eSMLwiE7JPs53w8Nyq2HB-Thmv3wNiRkMV1zrJmJeoZag@mail.gmail.com>
 <CAO9r8zPwT3cZjvPaqBjFtZDd72Ffjomb6J=QjnXr3V8LkASCHg@mail.gmail.com>
In-Reply-To: <CAO9r8zPwT3cZjvPaqBjFtZDd72Ffjomb6J=QjnXr3V8LkASCHg@mail.gmail.com>
From: Jim Mattson <jmattson@google.com>
Date: Thu, 26 Mar 2026 14:56:45 -0700
X-Gm-Features: AQROBzB7NvOUANLJwQsGxY0UhtynaAQWyKZHYOlZO6Z3zZDd4zAlzCmoqi97Rss
Message-ID: <CALMp9eRp-fp7RaULeLZ7itAJBKH=LMRqgUJ-H=ks7K0rjN9wCw@mail.gmail.com>
Subject: Re: [PATCH v4 4/8] KVM: x86: nSVM: Redirect IA32_PAT accesses to
 either hPAT or gPAT
To: Yosry Ahmed <yosry@kernel.org>
Cc: Sean Christopherson <seanjc@google.com>, Yosry Ahmed <yosry.ahmed@linux.dev>, 
	Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Shuah Khan <shuah@kernel.org>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 26, 2026 at 2:26=E2=80=AFPM Yosry Ahmed <yosry@kernel.org> wrot=
e:
>
> On Thu, Mar 26, 2026 at 2:19=E2=80=AFPM Jim Mattson <jmattson@google.com>=
 wrote:
> >
> > On Tue, Feb 17, 2026 at 3:27=E2=80=AFPM Sean Christopherson <seanjc@goo=
gle.com> wrote:
> >
> > > Side topic, either as a prep patch (to duplicate code) or as a follow=
-up patch
> > > (to move the PAT handling in x86.c to vmx.c), the "common" handling o=
f PAT should
> > > be fully forked between VMX and SVM.  As of this patch, it's not just=
 misleading,
> > > it's actively dangerous since calling kvm_get_msr_common() for SVM wo=
uld get the
> > > wrong value.
> >
> > Though I included this change in v5 and v6, TIL that TDX calls
> > kvm_[gs]et_msr_common(MSR_IA32_CR_PAT), so the common handling is not
> > fully forked.
>
> Do you plan to drop this patch or add PAT handling in
> tdx_{get/set}_msr()? If you'll drop it, maybe add a warning if
> kvm_[gs]et_msr_common(MSR_IA32_CR_PAT) is called from SVM?

I plan to leave the MSR_IA32_CR_PAT code in kvm_[gs]et_msr_common().
Replicating the code in tdx.c seems like the wrong direction to go.

There's no precedent that I can see for checking the vendor module in
common code (though we do have kvm_x86_ops.name). I could add a
warning if invoked with (vcpu->arch.efer & EFER_SVME). WDYT?
