Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20B4D3CFF5E
	for <kvm@vger.kernel.org>; Tue,  7 Apr 2026 16:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775580383; cv=pass; b=XVstqinypCBw/bAS8wcnWt59no5sCM5LYXWWJafqAENLTi20f70xGN4eHVOrAJstPIloINmfXHlDHeNvqcQQVX1VGRomnC80Asq863++w/ssJPmeg8I3POPytBNpvFDRP4nyCmjfgVxMEtRAxCUp+ceHqmXdSp0w24n80BlHdPg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775580383; c=relaxed/simple;
	bh=7agD+s2GVFy+3GJ+9lu9MNOej8X0LlPEbU6wsUyTSxI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BANBRUfNj/rZ32reNSbEr8VB2Ju+VIqdP4Bw+gA+3v/PxiOed/S4E2t3yEIn5tr4oY0aCcrNbDixLm4WWO+v/fKigsu2KVEAXzZIClt9Pm2myzhiRoEaMo02FxVMu3OZz7syqZJagvRlB1vglTmvqrn41Alj1q5kMw0QUlbRkb4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=k1iwIll7; arc=pass smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k1iwIll7"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-66bb7118c96so214a12.0
        for <kvm@vger.kernel.org>; Tue, 07 Apr 2026 09:46:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775580380; cv=none;
        d=google.com; s=arc-20240605;
        b=Zi2AyCg1tRkQK5+xcCcMW43Xiiw/MTlQO2OCnWHj0jdCoTuWcjqRPqG0dQtE2X2xjV
         JBX1NFak1HLPHxE69QdG1ltM5ftQ/Y7QahNJqurv7o74CNvUxMl6tiEXUcTC2SbNaYEw
         n+ILYymqhuwSGtf/PDdWHcEssHhR+NjeY+14xU3opfCIq7LUl7Yzb7mk0GxXb9JKiJeN
         /9eBr3wvxZOrLsaPXZvcajvwZwnroLCfrJ8tc0epXwqrblp7P2D0wJLxNOla5p/vCRDd
         +avacsqtZ42EvOkl3+JKMWO5neiCe3ov9RRoO1z20NX6GxhrZP9nbyUNv6rsHWfNUJ7U
         c8BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7agD+s2GVFy+3GJ+9lu9MNOej8X0LlPEbU6wsUyTSxI=;
        fh=147frtCcveW+l7jtmhyMCAoNmFqgwHK4/TY8EturMl8=;
        b=iPjX/JUoiAo1bmQ1ceoIcfgAhTgPNv6V/zb6SAS8+XvhkqxFdlLGW5tTt9SNfR5KhV
         cX4iJ3IEOR/HvMyxP/cE1mOaHWLKXArzcuAm0zToMBFLzLUxff2YWzuQ9O2OVKNJhpIS
         JkQcutN2EU68DpwX1+uWPgzX6abtO+bvC0NMEFjsB+4TBczjq+4XqqFF3IQw8M6nhlQA
         mFFxwRgkVO18tbqbNspeaKIm2je6iGpQULWZxMrEIjcu+V72lftOyYLxd+KszCp0Gq2q
         zwrxZTxcnkBzl0EP3snVVzMlZxw7YLlYT5Q7xRlGgPbuM9+phCjmaoJaKSXJHEWTAr0m
         uuag==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775580380; x=1776185180; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7agD+s2GVFy+3GJ+9lu9MNOej8X0LlPEbU6wsUyTSxI=;
        b=k1iwIll7s7MWVnBwB6US1VssQV1y+kSgffte48gmfDi5eZeYqjvlrktIkZzFmn4vW1
         0POU5UEc79j/+z1pTIa04fFcsvezE+kq+DpUhlpWqMqB6LTAkRUhRufM0HVNtNi/qMLN
         ZV6YXLnGTxGgGUw6MwnGgcQLVoWJA7Hc4VyOpaY5nA4XIw0O8R4A6KgAnsgpBB0IcPTZ
         nbyc6z+qfNORRG2MIUH4MSKNWyFdcOFQ1wMQpRpq5LouT+5MONKcisR7ErOeRaoDzFCX
         5IaXTu5B+OrQBK8TsGfZPUKIozyrnK8HEp97ZrUs9AP5TXbYajcDf3t23Jfjmva+61qM
         zZIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775580380; x=1776185180;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7agD+s2GVFy+3GJ+9lu9MNOej8X0LlPEbU6wsUyTSxI=;
        b=f6iGLxrpNatd0UFKGcxFDdfrROyCPqYfHNW21V+bzJQ4vHaU8vu5q//N1rgzRyNv1N
         H5Rfd9gSt0uWSyjplQDB+sdsfvRBeg/SE+9FDS4SCrDZpE8P7z3uAeypzFz7aSaZ0Uss
         S51o1q+nN57Tzk0C9YrM7oBXzLYMG0utpAm4hfeu3Ip1Ys5MiT1uZ7mrDwm1sic6zXZj
         en5AmeyCLEpWaiYwY8P0dRhHqrDAkKOEy80m7xEdKmCIAVDVUVWZVkoghlovKDB06gvB
         CKrocTOa35LuoojZeoz8SYNoGJb0I45lAe57bwvuhyoN6+FpnDayk6/w0qrIry2QEWqV
         imJg==
X-Forwarded-Encrypted: i=1; AJvYcCUe8gpnYKlL8fvZ6CrhsYsavU5iksSaXrURm9xfikbrjUQPW4+uaSzQ3OzM60/VqMti/i4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxSGk86+fnW7aRjFFFkeAXDmpw+METM6EJcGpLHIvi3aiTtlI8
	DJUpKmi+snaFLv/frQHMY3RlDdIPoA9EDPEyi/SpaeiRaJEit0NhlN3c3vpZke/Brdeh8LFxFvK
	o5eP68odx1hWzGpbi0GoFCnQd9+11pIr2FxWlvpbt
X-Gm-Gg: AeBDiesfPMbD9Y+H7A8Wvo31WWxsT6aGlus02ivdsBr3RebbmA60uOkX7SR5PkI0Ylu
	S9FRR1VP+g1247CmPUC26xMDceQ7GispRe0QCWsOWbKZ1fIxGMfrPxiDuXcxNH8Q2YtXhnpi3WR
	xG0vce4mUsy0e5SyO5deu6AL8zFiHHO49oLQngV3tlO4bo3BNu3536C6gv9ugUn2qO5xAFcgfCC
	D3wh844iTvwyNpOwUCD9x9XmaPNlZfKDE1zIxbUbzr8MHRyMTWHB7fGk8ntGZ4NpRD1eUn6bGNt
	mS9y2Cs=
X-Received: by 2002:a50:fa85:0:b0:66b:b4da:a8b0 with SMTP id
 4fb4d7f45d1cf-66e4136b3b3mr175238a12.8.1775580380060; Tue, 07 Apr 2026
 09:46:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260403213445.xzb4rxbfbg5un7li@desk> <CALMp9eSXfJvR=PHtttbqm3q3nH436T1eH4YdpVqxQeP-cxEPsA@mail.gmail.com>
 <20260403231608.zopnhnypdclzqlx7@desk> <CALMp9eT2vJBdLPY2uBYrPgVrhS_aYmfGfdXe6MZXG_gyryLHVA@mail.gmail.com>
 <20260403233329.fb2ppifgwm3um6ny@desk> <CALMp9eTpsenqsWjzmpXLEubn9uNjgZgzgrMwtZ72HDuV_2xgfg@mail.gmail.com>
 <20260404002149.wtayv6a64vzuppgp@desk> <CALMp9eSqgL5q-MY1xpjqR5oRn5_cb=mfEhNFWusNneS=Mx8UMg@mail.gmail.com>
 <20260404034954.t7iapenzvhdpagxp@desk> <CALMp9eR70eE2U63gzNzTiic0PqJVGv3CBBuVUOVbi3nqbWKZkQ@mail.gmail.com>
 <20260407163943.y6tkh26z2rfktn3y@desk>
In-Reply-To: <20260407163943.y6tkh26z2rfktn3y@desk>
From: Jim Mattson <jmattson@google.com>
Date: Tue, 7 Apr 2026 09:46:07 -0700
X-Gm-Features: AQROBzDrMOkL8K_5s_beeAF8mzcDjUMut0mXG4FWeqy0pjkeXMr6K1KiSjqSI94
Message-ID: <CALMp9eTA3cXxuOT4dq=6y1hx52gPH1ywwTEmPQ5-fA-vz6r3VQ@mail.gmail.com>
Subject: Re: [PATCH v9 02/10] x86/bhi: Make clear_bhb_loop() effective on
 newer CPUs
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc: x86@kernel.org, Jon Kohler <jon@nutanix.com>, Nikolay Borisov <nik.borisov@suse.com>, 
	"H. Peter Anvin" <hpa@zytor.com>, Josh Poimboeuf <jpoimboe@kernel.org>, David Kaplan <david.kaplan@amd.com>, 
	Sean Christopherson <seanjc@google.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, KP Singh <kpsingh@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, David Laight <david.laight.linux@gmail.com>, 
	Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	David Ahern <dsahern@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Asit Mallick <asit.k.mallick@intel.com>, Tao Zhang <tao1.zhang@intel.com>, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, linux-doc@vger.kernel.org, chao.gao@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 7, 2026 at 9:40=E2=80=AFAM Pawan Gupta
<pawan.kumar.gupta@linux.intel.com> wrote:
>
> On Mon, Apr 06, 2026 at 07:23:25AM -0700, Jim Mattson wrote:
> > Yes, but the guest needs a way to determine whether the hypervisor
> > will do what's necessary to make the short sequence effective. And, in
> > particular, no KVM hypervisor today is prepared to do that.
> >
> > When running under a hypervisor, without BHI_CTRL and without any
> > evidence to the contrary, the guest must assume that the longer
> > sequence is necessary. At the very least, we need a CPUID or MSR bit
> > that says, "the short BHB clearing sequence is adequate for this
> > vCPU."
>
> After discussing this internally, the consensus is that the best path
> forward is to add virtual SPEC_CTRL support to KVM, which also aligns wit=
h
> Intel's guidance. In the long term, virtual SPEC_CTRL can benefit future
> mitigations as well. As with many other mitigations (e.g. microcode), the
> guest would rely on the host to enforce the appropriate protections.

I don't think it's reasonable for the guest to rely on a future
implementation to enforce the appropriate protections.

This is already a problem today. If a guest sees that BHI_CTRL is
unavailable, it will deploy the short BHB clearing sequence and
declare that the vulnerability is mitigated. That isn't true if the
guest is running on Alder Lake or newer.
