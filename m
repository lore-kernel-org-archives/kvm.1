Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 561BD3148DD
	for <kvm@vger.kernel.org>; Thu, 26 Mar 2026 22:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774562406; cv=none; b=YZty0ac9CkS9Q9jINj2h8W6pRvbJh3xJOfZDrj0uMfh00wsgx+zq24Bx7qbG5DwMPYI4dQCwzuUuChrncWlKP15gs4Jpj9glpRALeHRoPyeY7gzsBf82FZPoEVOxcaiwt2QoswrTRab6DDF5AIKsW1Ve3ZaA4zpm+aAwXMeR//0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774562406; c=relaxed/simple;
	bh=LKbOUXD76E/X7J7tMmhUieh7kXj7AnqWmQDxhTruCps=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RF5bBz0rKsTQUcvCxVgRbxW9NFMI7S/mmvDotWmesXV6YgF6uE8xPC51y0M6l0JS8z2tILuMgYcR8K8plWXjpE2qyZsRuNJSRX5AwUh8pInxQqUSFVvVKwvDKO7n/CJTTfZOHU+jo5l+1vfPKZ1RDmW6gxn5tZQoVE2vHWMbATI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QMfI5X9L; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QMfI5X9L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E629BC116C6
	for <kvm@vger.kernel.org>; Thu, 26 Mar 2026 22:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774562405;
	bh=LKbOUXD76E/X7J7tMmhUieh7kXj7AnqWmQDxhTruCps=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=QMfI5X9LMCPxyA1/5zvKHEnrXbELQqzhkTdpJb1X5h6lhei+uqZTaXz1TKAY1Nzil
	 o1oa4wyB5cDZHCMNQXLit8sBWMvbvXCkSowjWIEoNjH4ZyxjHaG0m9b3DPHk6AmVFY
	 W+IaJSzKWTnwSL8q6vBBaZfnA5EJBIByBeKzJlsoZBJobWYzPu88l8gvVg20lGOwGU
	 1xZyULALtkwvFxF2J3yvdKg4wuGsJfwEQJUOIlLdoFtXQSb6Gh+5tQQN2PNpZqmeO1
	 QUWCfSGgp7lu1Wnyv27bx7NYSv9CYS7+YZwwl7sg0b2bmbzPPXZxARLbDI/+DCYtfp
	 eS7B+zYA1Tgww==
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b97ba4c2be2so201715866b.1
        for <kvm@vger.kernel.org>; Thu, 26 Mar 2026 15:00:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVSpsm25vW2/1Uko4JRiYZQ8ka+N1uneikdgPUaQ6iFX2/vuQXggAtvLYJapQkkh8fh7W4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeARDeQUlulR5QMYzzVFLGpE95JYwI3g8BZ/PcASU0dBsExDqF
	82yrCMsPUdFaAFUDM37KExU6WBy56OcqQ0MjeYDDpxSjO0gaSD1NqSPrqdk250lbMDOsV7YbZpx
	uA+7KDLd2HM8pNzQkWE6gGRR6aji6VDk=
X-Received: by 2002:a17:907:928d:b0:b94:1d92:7eb with SMTP id
 a640c23a62f3a-b9b5034a383mr7125166b.18.1774562404777; Thu, 26 Mar 2026
 15:00:04 -0700 (PDT)
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
 <CAO9r8zPwT3cZjvPaqBjFtZDd72Ffjomb6J=QjnXr3V8LkASCHg@mail.gmail.com> <CALMp9eRp-fp7RaULeLZ7itAJBKH=LMRqgUJ-H=ks7K0rjN9wCw@mail.gmail.com>
In-Reply-To: <CALMp9eRp-fp7RaULeLZ7itAJBKH=LMRqgUJ-H=ks7K0rjN9wCw@mail.gmail.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Thu, 26 Mar 2026 14:59:53 -0700
X-Gmail-Original-Message-ID: <CAO9r8zPNacrz4fFaZRE6XrshyVZJ7B8qRRX0SrdcWJJeh0p=fQ@mail.gmail.com>
X-Gm-Features: AQROBzDiKXPz3k1kp9p_A7NTffUMZZ61zalRGDjfWGLrzF678WX_ZanGbQ0A6xE
Message-ID: <CAO9r8zPNacrz4fFaZRE6XrshyVZJ7B8qRRX0SrdcWJJeh0p=fQ@mail.gmail.com>
Subject: Re: [PATCH v4 4/8] KVM: x86: nSVM: Redirect IA32_PAT accesses to
 either hPAT or gPAT
To: Jim Mattson <jmattson@google.com>
Cc: Sean Christopherson <seanjc@google.com>, Yosry Ahmed <yosry.ahmed@linux.dev>, 
	Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Shuah Khan <shuah@kernel.org>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 26, 2026 at 2:57=E2=80=AFPM Jim Mattson <jmattson@google.com> w=
rote:
>
> On Thu, Mar 26, 2026 at 2:26=E2=80=AFPM Yosry Ahmed <yosry@kernel.org> wr=
ote:
> >
> > On Thu, Mar 26, 2026 at 2:19=E2=80=AFPM Jim Mattson <jmattson@google.co=
m> wrote:
> > >
> > > On Tue, Feb 17, 2026 at 3:27=E2=80=AFPM Sean Christopherson <seanjc@g=
oogle.com> wrote:
> > >
> > > > Side topic, either as a prep patch (to duplicate code) or as a foll=
ow-up patch
> > > > (to move the PAT handling in x86.c to vmx.c), the "common" handling=
 of PAT should
> > > > be fully forked between VMX and SVM.  As of this patch, it's not ju=
st misleading,
> > > > it's actively dangerous since calling kvm_get_msr_common() for SVM =
would get the
> > > > wrong value.
> > >
> > > Though I included this change in v5 and v6, TIL that TDX calls
> > > kvm_[gs]et_msr_common(MSR_IA32_CR_PAT), so the common handling is not
> > > fully forked.
> >
> > Do you plan to drop this patch or add PAT handling in
> > tdx_{get/set}_msr()? If you'll drop it, maybe add a warning if
> > kvm_[gs]et_msr_common(MSR_IA32_CR_PAT) is called from SVM?
>
> I plan to leave the MSR_IA32_CR_PAT code in kvm_[gs]et_msr_common().
> Replicating the code in tdx.c seems like the wrong direction to go.
>
> There's no precedent that I can see for checking the vendor module in
> common code (though we do have kvm_x86_ops.name). I could add a
> warning if invoked with (vcpu->arch.efer & EFER_SVME). WDYT?

Yeah this should work. I assume Sean can decide to drop it when
applying if he dislikes it, but given that he said the code is
misleading and it would be dangerous if we end up calling from SVM --
I personally think the warning will act as documentation for the
former and safeguard for the latter.
