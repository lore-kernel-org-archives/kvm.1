Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 836B61CAA79
	for <kvm@vger.kernel.org>; Thu, 26 Mar 2026 21:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774560380; cv=none; b=Ahx9mZrlNwdJPX8C6h3AXotpJwfMf2hx97epWlSpk71wTlPXgYw6lX1Oh9BMtVccdThuc+2PyFHr0NsS1wHlzhMpB+YYxYREBlikxIwEfXBQutoD4x4heSt5HXDuNfTNTCOy08HJKdTWycNGsfhxayNiQ/zxSUL3WaccnwM+B64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774560380; c=relaxed/simple;
	bh=+2s0u0MJ4ZAgfA01TsqB8IElWD6undAXaa2wrGN9P7Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W1AV57ux9l7MEoyOHCcN+SNl20HxbBncZyiNk0hf/miJ9PQdqkgiVogHa9r2G3PUtU8I3KZTk68ahcV5fvLxNdROkanvbY5ULBquhG8m2VezHGWuZfQvu2IceFm4qDhDd87Bx27dUAMBxnlD1kYh946DHDaL8eKRsxXghaxwFBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Op/SzVk2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Op/SzVk2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5116AC2BCB1
	for <kvm@vger.kernel.org>; Thu, 26 Mar 2026 21:26:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774560380;
	bh=+2s0u0MJ4ZAgfA01TsqB8IElWD6undAXaa2wrGN9P7Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Op/SzVk2WWLNEuovA9TPknwvHpus5Xv3Gf+wvs0ecHugrSGaVYt2r5SwKNmnfF7we
	 OX48jbMvEY0ZteOI8Qr/bebnNtHX07drDIdw5PGduPdwKdAZU0Cd4kRbiku5rR5HvX
	 jRGszCVW7hshDQgUyjFHIz1PFb0QkERj24AjQduRQQecgQ/fwI/yp/n9W/HFDdi1Al
	 6mzBqrPpVv+WmbvrlO2sof5czOP9lmJnXhkpK/ydle/HJ8CagK7PwvvOaSA7za6xCF
	 ZbHeVT/xB5dXkHWrLVKDuh9r7YhrsCya73WrjXRRbZ53p9tet4d63+xkj8UnIhGPd4
	 gPGgxiKnz5h9A==
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-667de793310so2497432a12.0
        for <kvm@vger.kernel.org>; Thu, 26 Mar 2026 14:26:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXrXo4r5H5mYUmj/RJvM1V+7U89n5rdCxby6U7C5ZEefhZIUVyQ+vunvKTiTgoQucz3+OA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywoh7ZJrt29CY6oI+Y4TBNHwo77Gh+ZiFZ51QLbpGlRAbyrjOhJ
	nWQbFlkAPaOhp8Rcvd6URf4mUxzI58Fvzocz9XL+xtJ+K4AmH0CCIeLz4vF5elDho5iwDYLGKn1
	PSi7uMe87RH3mbRnOvUKOl2uZUbN1YRo=
X-Received: by 2002:a17:907:3f23:b0:b98:6926:13cb with SMTP id
 a640c23a62f3a-b9b503001bfmr2363966b.9.1774560378961; Thu, 26 Mar 2026
 14:26:18 -0700 (PDT)
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
In-Reply-To: <CALMp9eSMLwiE7JPs53w8Nyq2HB-Thmv3wNiRkMV1zrJmJeoZag@mail.gmail.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Thu, 26 Mar 2026 14:26:06 -0700
X-Gmail-Original-Message-ID: <CAO9r8zPwT3cZjvPaqBjFtZDd72Ffjomb6J=QjnXr3V8LkASCHg@mail.gmail.com>
X-Gm-Features: AQROBzDaPWvJShxX4gTRvs5SEmPilhYd4SWkFN5mvA_Yd6F7WzSGu9XiAKAiAp4
Message-ID: <CAO9r8zPwT3cZjvPaqBjFtZDd72Ffjomb6J=QjnXr3V8LkASCHg@mail.gmail.com>
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

On Thu, Mar 26, 2026 at 2:19=E2=80=AFPM Jim Mattson <jmattson@google.com> w=
rote:
>
> On Tue, Feb 17, 2026 at 3:27=E2=80=AFPM Sean Christopherson <seanjc@googl=
e.com> wrote:
>
> > Side topic, either as a prep patch (to duplicate code) or as a follow-u=
p patch
> > (to move the PAT handling in x86.c to vmx.c), the "common" handling of =
PAT should
> > be fully forked between VMX and SVM.  As of this patch, it's not just m=
isleading,
> > it's actively dangerous since calling kvm_get_msr_common() for SVM woul=
d get the
> > wrong value.
>
> Though I included this change in v5 and v6, TIL that TDX calls
> kvm_[gs]et_msr_common(MSR_IA32_CR_PAT), so the common handling is not
> fully forked.

Do you plan to drop this patch or add PAT handling in
tdx_{get/set}_msr()? If you'll drop it, maybe add a warning if
kvm_[gs]et_msr_common(MSR_IA32_CR_PAT) is called from SVM?
