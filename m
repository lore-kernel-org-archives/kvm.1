Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795464780;
	b=TKZjqg9Iv1l6b8gVmMaF9zwPEfQvL1RpnTPJFZ/PzhV2Qasyg6lXf1naA/FZrVkW1m1U
	 9IGHDAQbFf1q1P0sXnfU7dg1EE+tAymktXh8dluV7P4fLUsD0kjHW7f6fCCamW1YjrGpv
	 XO1G6zm5pntOjm4jE5woAFpMyfgK5ica5m0UxZKi5zNUbmZVuKG7n6PvaHR67lTkZmygA
	 +81T1LlQucQm6AXmTH8DrqbHAEi43aSvldKUhAo/JerhRVCJxF0k4pRkX1m0WJHnNxKLi
	 xt8H81hvlArusp4kggENPLGgjP5w3Gc8+l7XZ/BSzz7zV2fkLo4NDlul5Sgp5KKCmew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795464780;
	h=Received:DKIM-Signature:Received:X-Gm-Message-State:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:
	 X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=CNc/KOkXsRj0PuEADpl0UNIGdLORhq3KFyrcUn7+NFg=;
	b=0HMtmi6iZutIvpPlk/usTarR2U6n3nfWNrwcHfvWsYdr0ahI4V8WJ3zhFxRMgU+IytAF
	 muwZuoJcFegD8/QrDfsTVLsY2o6FySnQ1UBNvvw2FdS4krIB/+HZJU3v5kPWTusGcfBHg
	 l9r6ZiNBIK89Jex+Mdw61OmU7ArMFMYtuARl0nhQHecHDW4c2vmq2YPwkZFRdKu+f8HmS
	 dOZv66Vm+8FnMEQlPicPnm3u9hy2yWdhfHVLqaot+iq4UfwDm7hFQ3w7ZTX3DKjGRV0TD
	 gyaQAzpzszh6jGyLOB92qMVD48rf3fH0NxQBNqvZ8FgwQDOSW7a0TopxYq48NzIYbHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oeY8rSd6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF35606A31E
	for <kvm@vger.kernel.org>; Mon, 23 Nov 2026 20:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oeY8rSd6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60B0B1F000D0
	for <kvm@vger.kernel.org>; Mon, 23 Nov 2026 20:12:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795464779;
	bh=CNc/KOkXsRj0PuEADpl0UNIGdLORhq3KFyrcUn7+NFg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=oeY8rSd6iwwQTtMH9dOHtd1HQ2fQ38kXgnVbX4D+j91Tny0M8DcNQqyb/fpWnLC+p
	 3VFlIcJTa7C1TxeFhjFhuOo2MzqSxYnCJs8ebtAMGLvXSvMxpHsFjdNzHxLi2fuKG6
	 36+6aSi5om6PQ/oirkv36ExRKGURcuvA0TGq6Ac5M0Tnc86pMSNf4GrkKlE2hzdZee
	 8ubsmxjy3w8RRta+SHLoJ+Ykorlgr5rsfnchRMtz8n+3t3LQKgAIo9ZfyNE4MZHU2L
	 BD8Y4mPilZ6Fyri+BBrubkK/KWtGiCg0SmZjERsFNa2ex3PWuD1IftEWP7HVqY158E
	 blNHIeKHtqy7g==
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-c5188e17487so126891266b.2
        for <kvm@vger.kernel.org>; Mon, 23 Nov 2026 12:12:59 -0800 (PST)
X-Gm-Message-State: APuU4Z8KLd6K0KK+oPuWLpMfGNCFqc737HTIa+SHwJIWKa1EU4FKC0CU
	HlSqgENjKaD6uoyQSaN39ZMw+rhsf60E+VTsMDIA2Pp9iuBPC7euHPAQi5ZMZw461K/y2wTGd00
	QaPkbdwbOyGImKnvFk5opRZH/wkEFFSg=
X-Received: by 2002:a17:906:8a63:b0:c1c:4a80:30c4 with SMTP id
 a640c23a62f3a-c513a99a66amr779228666b.11.1795464778363; Mon, 23 Nov 2026
 12:12:58 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260312200308.3089379-1-chengkev@google.com> <CAO9r8zOEqpVwLnpT6DQMboA4m4cPZ7rztpy=nj6VR8b4pd88Vw@mail.gmail.com>
In-Reply-To: <CAO9r8zOEqpVwLnpT6DQMboA4m4cPZ7rztpy=nj6VR8b4pd88Vw@mail.gmail.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Mon, 23 Nov 2026 12:12:47 -0800
X-Gmail-Original-Message-ID: <CAO9r8zOv70Mjw1pSMcWyVPaLVSe0UpaZSuZJxMQr4RCxoQz3yw@mail.gmail.com>
X-Gm-Features: Aa3M54reprCs0VYNOLAspyC3_zSlBSylhxMmpUpd14ZxLYVT4uLpWvXK7T9Xb4U
Message-ID: <CAO9r8zOv70Mjw1pSMcWyVPaLVSe0UpaZSuZJxMQr4RCxoQz3yw@mail.gmail.com>
Subject: Re: [kvm-unit-tests PATCH v3 00/10] Improve test parity between SVM
 and VMX
To: seanjc@google.com, pbonzini@redhat.com
Cc: kvm@vger.kernel.org, andrew.jones@linux.dev, thuth@redhat.com, 
	Kevin Cheng <chengkev@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 21, 2026 at 12:32=E2=80=AFPM Yosry Ahmed <yosry@kernel.org> wro=
te:
>
> On Thu, Mar 12, 2026 at 1:03=E2=80=AFPM Kevin Cheng <chengkev@google.com>=
 wrote:
> >
> > This series introduces numerous tests for features that VMX testing
> > covers but current SVM testing lacks.
> >
> > I went through all VMX tests and identified which ones could have an
> > equivalent test written for SVM.
> >
> > This series also includes some canonicalization and consistency check
> > tests as defined by the AMD APM.
>
> Friendly ping for this series :)

Friendly ping on previous ping :P
