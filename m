Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8768A3E51E8
	for <kvm@vger.kernel.org>; Wed, 11 Mar 2026 18:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773253918; cv=none; b=V51y+K6ox+vM5xcmE3QJwfHS+x1Bw7cbp25B2spDJw/444vJyyCitvItjaSKVc5SO/gsWlMD7SQkkPlwMfhpkr9KXDDzfhblnuaaqxlCbYs8W09sVFTQ39WvFp+2tN6E6wEXPvpfB2HCQWTn6THjhrA7T7e2yQU38g05sDbmSR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773253918; c=relaxed/simple;
	bh=tDu4FrIr8+meBzay36U/ohs7zAxAfyBs8jb/79Bt09E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A6Fv7g3uHUqk9iZeaUTH0cyIQQDua80ChiFWNrGo+Aemeno6dQFJOGZTOjdauKQULEGOPhif7gm619XoEuJpjwd2XSODAi4fDC4Szyqn+daiyG/+NtXniR8mpZCcQEKGX60SdTPIBmGxl6aSvo1uKPyUJtC3zTNbfg5PmUlDvuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y1APhNnQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y1APhNnQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43AC9C4CEF7
	for <kvm@vger.kernel.org>; Wed, 11 Mar 2026 18:31:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773253918;
	bh=tDu4FrIr8+meBzay36U/ohs7zAxAfyBs8jb/79Bt09E=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Y1APhNnQs+YPFBwn3PHkf/aU5KLvRaWxaRMHQRUIHUDH9X2bZEdoBx/2s+u3UlmB6
	 uJfUVWahQCgccVD2X/rVXj0lzpQszbX0WeNm/EsvWtqr0IFJ5sVPbxDzRcLKvnkgS8
	 fusPYVV7vknC013w5oVfFHBE43el1DMfU9ZAwPEamagEgXJVofZgT/LrcczamAafjS
	 eV2U9kPEeLjU6Poz4WF0o9A2JT20CGsMOGm7WPJbHzyol5legzfG2UHWXuk4XLfLZv
	 0o7XdR2RQuakaWS0wwkn3r1VJd4cL+rnD1l/3OhGToF0fEHAGKtgYDmNO3b/oUlKU0
	 z3COwAKwM0QoA==
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b96da7b2e2eso17090866b.2
        for <kvm@vger.kernel.org>; Wed, 11 Mar 2026 11:31:58 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWXQWtaAf8vW0sb0HaQWDXtBpCPyXw01v+q4drBIvdkSesZYrBrh20EOQxs8Dy4vqZhkHc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlPaDzULTo4ZM0SDtYzb8dpoGebdojqSB1JNHquj+JT/EwYDzm
	lctpVY0pubgZsvpwVEPWBo5jEwASWieTm4MP9tiPRvGKuwgnsl2vVBCN/iE7zK0k/5snztOjEFK
	FGf01estJpl4M+KEwz5ryiN7cqjP+e2A=
X-Received: by 2002:a17:907:2d8e:b0:b97:3db:c7da with SMTP id
 a640c23a62f3a-b972e56cb28mr187150266b.42.1773253917137; Wed, 11 Mar 2026
 11:31:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260306210900.1933788-1-yosry@kernel.org> <20260306210900.1933788-2-yosry@kernel.org>
 <CALMp9eRWwPwUSyQmizy8i2tF1CVO4iLY6x0vX1OoPUiRdCm4NQ@mail.gmail.com>
 <CAO9r8zOhaDeYWq_6TNdPGyEE323o_8xsWTozGdro9Oni8310kA@mail.gmail.com>
 <CALMp9eScswzFak+PMOcaDXM-W+cXtkG7fQ=jadq__+5JeqYcTQ@mail.gmail.com>
 <CAO9r8zOK5+xmkf3FsWRz2wHcUCN30GJ9kfZx-K7DAa1HNGhRVA@mail.gmail.com> <aatyIPwz9ePKdzJx@google.com>
In-Reply-To: <aatyIPwz9ePKdzJx@google.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Wed, 11 Mar 2026 11:31:45 -0700
X-Gmail-Original-Message-ID: <CAO9r8zMxk9yUiYoosnDygr_oeeRYHz3f7hWLm23c5Q0m-DXnWA@mail.gmail.com>
X-Gm-Features: AaiRm52rdDWXwFYYQeK5kbvM430jLhe4XYmTJbYvY9giV7NFbL_qJ-zEcamv6kw
Message-ID: <CAO9r8zMxk9yUiYoosnDygr_oeeRYHz3f7hWLm23c5Q0m-DXnWA@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] KVM: SVM: Use maxphyaddr in emulator RAX check for VMRUN/VMLOAD/VMSAVE
To: Sean Christopherson <seanjc@google.com>
Cc: Jim Mattson <jmattson@google.com>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 6, 2026 at 4:32=E2=80=AFPM Sean Christopherson <seanjc@google.c=
om> wrote:
>
> On Fri, Mar 06, 2026, Yosry Ahmed wrote:
> > > > Right, but I am trying to have the #GP check for VMLOAD/VMSAVE beha=
ve
> > > > consistently with vls=3D1, whether it's done by the hardware or the
> > > > emulator.
> > >
> > > Consistency should not be an issue, since VLS cannot be enabled when
> > > the MAXPHYADDRs differ. VLS doesn't work in that scenario.
> >
> > Why? It's only broken if VMLOAD/VMSAVE is executed with a GPA that
> > exceeds the guest's MAXPHYADDR, but not the host's, right? So only
> > broken if the guest is misbehaving.
> >
> > Taking a step back, I am not disagreeing that VLS should not be used
> > with different MAXPHYADDRs, I am just saying it might be.
>
> KVM straight up doesn't support that (see my other reply).

Sean, I intend to send a new version today with 2 main diffs:
- Use cpuid_maxphyaddr() here instead of  kvm_host.maxphyaddr.
- Use a common helper for checking RAX for SVM instructions for both
the emulator and gp_interception() (see response on patch 4).

Holler if you want me to wait for further feedback.
