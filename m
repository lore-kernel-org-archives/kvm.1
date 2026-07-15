Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E68334ADD8D
	for <kvm@vger.kernel.org>; Wed, 15 Jul 2026 17:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784137531; cv=none; b=L97L6TNC22hEzJwlxX+YP+gzYUu5k30SNQ2yfoMEKfR/O/UnbAPwFOUbQr0wxHD10pwwM2cMe89diVz5Qe/T61dHBk8eSi2UE1qQjjiz9UisJBAF6/kh9TZcN4i/XhCaMwkaSparkQUh7ztPOXwyyCS9IePP1wcpcOO+KZT/YLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784137531; c=relaxed/simple;
	bh=MfkqCmlztoUKQwvo13E0kxRatjNB7rrBQYoxe1Xwjy4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oUlOo73F7pLT2lcZU3VU7Q7qrPPYIzHmHWFNTJKz4T524Kk99eEDNf0QfNf6fuxBSnCZK7eC7JxIeDBidqKCJ05h/2I5J/ffMmCeDmL1N/h1SPX+DczCs3jBKfz6oA0F3TkqhorEPwI/bRnNqDcsxtBrRx4bklkE8Z2fNDrFsvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hcVKiXUe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hcVKiXUe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9044D1F00ACF
	for <kvm@vger.kernel.org>; Wed, 15 Jul 2026 17:45:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784137529;
	bh=ag2dg7DtiP2kwWxNZsU6cB+ttovcvlWNPIRCwQ3kXFs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=hcVKiXUeTAXzZWLUBaviPU4CVP6Zmt3yXBhD/IQ0lJia58taikEZVJKLjBb1+ZVDF
	 +Mr02BsUv0r+z5IAa1FZvvrUkVB+X2kv+gQHifgviDju5yNLl+s8vRAfd7QyZtsEon
	 ++M1TG2F9Wvx9n71DMLSkgywtUV1aN4WYBNs65UeLMKv5bxMf8+gUKw8fSDRDs69vm
	 zwLb/9d/vaZyPD1YuNAhrtKcd0RJt3PhVucumEPs7lpCnp6UlNgGj7o9WVC/hh9q/m
	 b6nXZNGMRvWDTt2z5fB6qZ09jOvDEtJuiRN51d+Oxkm3DQSadopWJB+mpTDUPvPQps
	 foS6VBKP2MPGw==
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c15dd4b9132so834789266b.1
        for <kvm@vger.kernel.org>; Wed, 15 Jul 2026 10:45:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RqkDTfaUrilOY62xEvbRrISHoGpoZ1ssgKJR736aCBs5mWny4MNVNxgy8lBcDykzKEoOiY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzlcw5evRHQGK+MJWdiKX1MH2tm2EXCGvIOD3v5HPTT5h0jiqBJ
	Izfx82JXPYycQ/qmeafg2onGsTTSZeKJt1LyeDPgc/JQ71W8XkJvwjys477sytlid5h/31ph9oE
	rYeeblauXXlDb8rFRVeFg44EqEy/P58I=
X-Received: by 2002:a17:907:3d05:b0:c16:242a:471d with SMTP id
 a640c23a62f3a-c1667a4e3d0mr473861866b.33.1784137528517; Wed, 15 Jul 2026
 10:45:28 -0700 (PDT)
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
In-Reply-To: <CALMp9eRGx=K+UBp76A=dZ=bD_Txonq7j8pSn9HVczdtyyuAs3Q@mail.gmail.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Wed, 15 Jul 2026 10:45:14 -0700
X-Gmail-Original-Message-ID: <CAO9r8zMYDn_zY47p5Fe-tbHk2Cij1eZJ8u5w8taGoZEusm2Gjg@mail.gmail.com>
X-Gm-Features: AUfX_mw_fniAAcOHGEImYXS6vnDuGgCfTKQFk9p4OjpVT4lsgVRAQN_joZS6pVo
Message-ID: <CAO9r8zMYDn_zY47p5Fe-tbHk2Cij1eZJ8u5w8taGoZEusm2Gjg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 02/25] KVM: SVM: Passthrough the number of
 supported ASIDs
To: Jim Mattson <jmattson@google.com>
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Maxim Levitsky <mlevitsk@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 14, 2026 at 11:32=E2=80=AFPM Jim Mattson <jmattson@google.com> =
wrote:
>
> On Tue, Jul 14, 2026 at 4:41=E2=80=AFPM Sean Christopherson <seanjc@googl=
e.com> wrote:
>
> > What complications?  Advertise the lowest common feature set for the po=
ol, just
> > like userspace has to do for literally every other feature.
>
> The problem with passing through the number of host ASIDs to the guest
> is what to do when the combined host plus guest usage exceeds the
> number of available ASIDs, particularly when FlushByASID is not
> available.

I think that particular scenario is fine because they are two separate
domains. KVM assigns 1 ASIDs per vCPU for L2 (in this series),
regardless of what L1 assigns L2. We flush that ASID if L1 changes the
ASID it uses. We can use more than 1 ASID in the future, but I think
KVM will still allocate a certain number of ASIDs per L2 and the
domains will remain separate.

If your concern is the fact that without FlushByASID KVM will do a lot
of full flushes, you are right, and this series aggressively falls
back to full flushes when FlushByASID isn't available, rather than
using a different ASID like the current approach. My assumption has
been that we don't care about performance that much on these old CPUs.
