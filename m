Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F01893CB542
	for <kvm@vger.kernel.org>; Wed, 15 Jul 2026 19:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784142787; cv=none; b=A7ZbhPWfV4PHeggqYivsEmxslmbwYdwsFQhwYf+XhsWrJRNEKxp+tRfkuchHy7KKSmIr7hJi1ThZkbqbYU4EAs/eQf7PW+uqlYcb2qdgWholTFfdGZaVxOph0m6eVYTHXYBUqLjcnqFD5/oyDMvmqn1sgCCjNm1BWWNaX0woSg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784142787; c=relaxed/simple;
	bh=gz7tUSByq1tD49kFS0Ljgf7UvGXeVha/vkbt5ciSuKk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i1XH9qRxTlU5Fyx8vewy3B19Gt8t7TbevlNEhdea+TTwtJ+S7+1r7jtmCH2F4FKN9VZoi8xkhxzm62errSxaDrvTDIBI9XFGAu0t5rv1ZpGPEMQMa8UMPai7MxFEybc2SUX9K/ExHG9i1+IyWUHAqRXZGovwJIlZPXAIe16FgeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VZ8qgZEj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VZ8qgZEj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A7731F00ACF
	for <kvm@vger.kernel.org>; Wed, 15 Jul 2026 19:12:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784142771;
	bh=j1j6l8MtuogCupTQcxeq3XrYuDjq9to6D8rqrZbCIiw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=VZ8qgZEjhIsPqb/chMNyUhYczbydMGAxsW9wPfgPzrWah6I1xJt7Dj1pWiSIJ7XWw
	 ruolQh4sWafCiM25Drday6fDMFzx1YCY136XHsadk4K4i+ZP8ghWJXjwA01ZYhwGy3
	 LTq06cIQvsXxFW8hKSDKUp6O30dVCtoZx8BbjRc850ZVO1l6HDbPWTRDyCgotQJ3mm
	 1BKJx2WXf1Kna+GI1ilu6dZ58v+naOY0R1gHFV8+4wSmT1aqGDAolL8DY1kRr4hPbp
	 Fpks8BeFIZmHU25BhyQCRIAhHXOuA8LCYJVX30cz0eQd0X5RaYr9dEz7mU6CzbN4WT
	 L443i97HOdGsA==
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c15cb6f5c12so997453566b.0
        for <kvm@vger.kernel.org>; Wed, 15 Jul 2026 12:12:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RrKQZinTvSQ2RpRp/lsg3iPV0h89zv5cB2Gr7Hq2Gcmyia/k3tgmtY0xN5IhW9O6sKznRA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQ+sHjZrcE/kpnokfdamqnSTcHE4vj+TOGc44SQ/E2AFfDhR1f
	iwae5WAI/vjcF25mk7R6DWmCiFtEB9gL/3rFDCXKGEEeQCyLyCe4vGCSGAvyjDPkYRC6V7zObYJ
	i4zDE5NhQlQkUEcepfOJZIwsMlPmJpyQ=
X-Received: by 2002:a17:907:3c8e:b0:bfe:ed06:5a20 with SMTP id
 a640c23a62f3a-c16794d13f7mr278226266b.53.1784142770399; Wed, 15 Jul 2026
 12:12:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260616004155.1435766-1-yosry@kernel.org> <20260616004155.1435766-3-yosry@kernel.org>
 <CAO9r8zPnXM1rypG8=YVsb7bir3J084Sza-0onnNX3s=uPK-JWg@mail.gmail.com>
 <CALMp9eT2W-oPtMpFdHZi1=F5MwVpx1YWKTh4n+O=STz7N=F_qg@mail.gmail.com>
 <CAO9r8zNso+8iKgiHc_VnCnTLKor-mGsFEV1U1N=RVLdn=FPNUQ@mail.gmail.com>
 <albJNb-akQJ97Yor@google.com> <CALMp9eRGx=K+UBp76A=dZ=bD_Txonq7j8pSn9HVczdtyyuAs3Q@mail.gmail.com>
 <CAO9r8zMYDn_zY47p5Fe-tbHk2Cij1eZJ8u5w8taGoZEusm2Gjg@mail.gmail.com> <CALMp9eQVeEdaaZGEeXJ3S7Ycmc+s35uQykMyirnMc=7hCogBqQ@mail.gmail.com>
In-Reply-To: <CALMp9eQVeEdaaZGEeXJ3S7Ycmc+s35uQykMyirnMc=7hCogBqQ@mail.gmail.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Wed, 15 Jul 2026 12:12:38 -0700
X-Gmail-Original-Message-ID: <CAO9r8zO-n+YHyvgCBBcAT4a_h7_zLLtyVuH3K=a9uXtaeLF3zg@mail.gmail.com>
X-Gm-Features: AUfX_mxwCiuoq0Jpr_Fiz2dJCTRvxjU5rBGkrVxy0EV_Cu4T9F_HZe8A_RSAzlA
Message-ID: <CAO9r8zO-n+YHyvgCBBcAT4a_h7_zLLtyVuH3K=a9uXtaeLF3zg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 02/25] KVM: SVM: Passthrough the number of
 supported ASIDs
To: Jim Mattson <jmattson@google.com>
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Maxim Levitsky <mlevitsk@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 15, 2026 at 11:20=E2=80=AFAM Jim Mattson <jmattson@google.com> =
wrote:
>
> On Wed, Jul 15, 2026 at 10:45=E2=80=AFAM Yosry Ahmed <yosry@kernel.org> w=
rote:
> >
> > On Tue, Jul 14, 2026 at 11:32=E2=80=AFPM Jim Mattson <jmattson@google.c=
om> wrote:
> > >
> > > On Tue, Jul 14, 2026 at 4:41=E2=80=AFPM Sean Christopherson <seanjc@g=
oogle.com> wrote:
> > >
> > > > What complications?  Advertise the lowest common feature set for th=
e pool, just
> > > > like userspace has to do for literally every other feature.
> > >
> > > The problem with passing through the number of host ASIDs to the gues=
t
> > > is what to do when the combined host plus guest usage exceeds the
> > > number of available ASIDs, particularly when FlushByASID is not
> > > available.
> >
> > I think that particular scenario is fine because they are two separate
> > domains. KVM assigns 1 ASIDs per vCPU for L2 (in this series),
> > regardless of what L1 assigns L2. We flush that ASID if L1 changes the
> > ASID it uses. We can use more than 1 ASID in the future, but I think
> > KVM will still allocate a certain number of ASIDs per L2 and the
> > domains will remain separate.
>
> IIRC, Hyper-V uses two ASIDs per vCPU--or, at least, it used to. It
> might be worth checking to see if that is still the case.
>
> > If your concern is the fact that without FlushByASID KVM will do a lot
> > of full flushes, you are right, and this series aggressively falls
> > back to full flushes when FlushByASID isn't available, rather than
> > using a different ASID like the current approach. My assumption has
> > been that we don't care about performance that much on these old CPUs.
>
> ...until someone complains? :)

I am not sure how many people run VMs on pre-Bulldozer CPUs and care
about performance, but practically it's only a problem if the full
flush actually makes a difference. It is possible that the TLB is not
big enough; flushing the ASID vs flushing the entire TLB makes a
difference.

If we really care, it's a problem not specifically for nested, but for
assigning a fixed ASID to each vCPU in general (similar to VPIDs). It
is a nice simplification, but AFAICT it's not necessary, the very
first version of the RFC didn't have it [1], it was suggested by Sean
(well, we went to per-VM ASIDs first, then per-vCPU ASIDs).

[1]https://lore.kernel.org/lkml/20250205182402.2147495-1-yosry.ahmed@linux.=
dev/
