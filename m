Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795642005;
	b=GQDiMnw9ZYjyxslPYhjHJ0fvSTgeltxExUvIsSUa6XWYRZGdu+8f/doL9BPkQ1jzgsfX
	 Hmg81cvulDLhrvtQTLjrXlB1MKd3ayURFRHctO+Egxc9s9O9dTuZ8zCqNqw+mhAZ0qvBk
	 eHZ1gmK80jOV1VggC0+QBPs6k9bdpmJFZidRI2u3zPr1Vw5kml2VTZ0GBqXaCsWHROwAB
	 VqsjdGRJoFbC+iN7a0wllRHMFfKhKLwUsFD/xYiZ+J2O/nNZDa0SeUswsBwFlAep/YJVn
	 vEPmj5STsrXpBniZNjnD2BKCpgA5ppjYJPNh5AOF9Ji9typBJPLaRyrZ3f9ObRnpuRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795642005;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=guDPdAYNJbWbC6d5sTKqRJq9OmSRPmOCdNbIU1+Gch0=;
	b=sQnO6FzZku9eMHUR/ny7h2PTY7HB52gnEPAqYxej4o3Av/6uGP8G02AXXpGJGZq1EO4M
	 dzVRtuQNRGFocHjZrRlWFJ8MQIYzv1cSuwK1k16zNL/34Og07GK3Fge4WK8FlDKHCjELi
	 WFO44VNazjGMZzuwxl1oQqtXSTUYaJYi9rJqCujSx/94Su9/v/uTToM4zGVAouYoWSOfg
	 fo8F/LJyNRbZF9HiCrxHIIdSyDG1LDX+4XkWsmQcKGrplmEKl8eEPO0Qgf1SnlACRHphZ
	 0wCbIEl3rqT7GNbCrMWi4vCiM7uTrF5skPppi0Uz1lG+w0PnA7/ompc1fH7bWsQi2Eg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=euYshZwF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E649F606A335
	for <kvm@vger.kernel.org>; Wed, 25 Nov 2026 21:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=euYshZwF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECE1D1F000C0
	for <kvm@vger.kernel.org>; Wed, 25 Nov 2026 21:26:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795642004;
	bh=guDPdAYNJbWbC6d5sTKqRJq9OmSRPmOCdNbIU1+Gch0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=euYshZwFCWO8msiqlyp3g86AQLKD+Mp+LppuO3wwvhqdQXrj413xBIAYHTY2o8Hu0
	 Le2+VZ04LPhLXV4DPbgMH9C9c7RWlgRxgTB+OtuLW76pjkvCmL87ACVIkeSYyCP4DW
	 83vO8q9l2IzvfvOhuj8kAD9sG+wfOnAy6GjnLxoayo5bMFscLVuFGJuwwkK3vw+G1t
	 EMVxFoIUdJ5vafz6BbjN3fAc2j1JbbJMQQAQd9kpTUltEe2r3uAjkdxmT5+YJxn2Aj
	 oBznpSx2Yp0aUfeke2vgkHSo9zMrZgTFNdWMmu83/NMZO8OjiLBSdh9ETIy7Gh5pQz
	 SR02WqxNHki1A==
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-c4cb6834eaaso174498566b.2
        for <kvm@vger.kernel.org>; Wed, 25 Nov 2026 13:26:43 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErEmTwWvg2icsixc3zVYVtUw8Oq5K1MHbaJYz9m+vNi4+sHYNS2QHH3dc+F83waBS4fJRL8=@vger.kernel.org
X-Gm-Message-State: APuU4Z8FpW6fHW55QvSDDOF5PGGAyFKiRYBOcVG8F4t6iBeOALZVZ8VK
	QauPXOtSF+7tEhhYw55QvIEXoTVFTuHqh9tU0mKrtFkA3Tbb+bk8q7RvCvrHbknMqB/1jWBMtGB
	AUBmJCwKpqCL7YZbLKrpru70pv93B1iE=
X-Received: by 2002:a17:907:6ea9:b0:c46:a5bb:5740 with SMTP id
 a640c23a62f3a-c513a3a656cmr1716577266b.5.1795642002900; Wed, 25 Nov 2026
 13:26:42 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261117210934.7765-1-seanjc@google.com> <20261117210934.7765-2-seanjc@google.com>
In-Reply-To: <20261117210934.7765-2-seanjc@google.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Wed, 25 Nov 2026 13:26:30 -0800
X-Gmail-Original-Message-ID: <CAO9r8zNkyn4Ps7zE1nBvDOcfB8V2kqjBwuxuMhmsE3LcFbFx-g@mail.gmail.com>
X-Gm-Features: Aa3M54p2OfvxkLPbVRwbmW5CDmhyFk3PAAFu-ddqfZd9eKEX2ohUTX9VzuOtD5E
Message-ID: <CAO9r8zNkyn4Ps7zE1nBvDOcfB8V2kqjBwuxuMhmsE3LcFbFx-g@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] KVM: nSVM: Pre-check current (L2's) CR3 during KVM_SET_NESTED_STATE
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Stefan Teodorescu <fane@google.com>, Sashiko Bot <sashiko-bot@kernel.org>, 
	syzbot@syzkaller.appspotmail.com, Chris Mason <mason@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 17, 2026 at 1:09=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
>
> When loading nested state, explicitly check that the current CR3 is valid
> before loading any state, as a misbehaving userspace can muck with guest
> CPUID to make KVM think the current CR3 is invalid, and thus cause the la=
te
> "load" of CR3 to fail when initializing the guest's MMU.  If that happens=
,
> KVM will leave half-baked state in the vCPU, e.g. in L2 with L1's page
> walker, and if nested NPT is disabled, L1's PGD as well.
>
> Alternatively, KVM could try and unwind vCPU state if the late CR3 "load"
> fails, but that is subtly quite difficult as it would require snapshottin=
g
> and restoring the previous state.  Simply leaving nested on failure isn't
> an option either, because that too would leave the vCPU with half-baked
> state (in L1 with L2 state and a very stale MMU).
>
> Pre-checking CR3 will also allow hoisting the CR3 check out of
> nested_svm_load_cr3() entirely.
>
> WARN and bug the VM if the late CR3 load fails, as loading nested state
> never loads PDPTRs, i.e. failure is impossible, and KVM doesn't unwind on
> failure (see above).  I.e. if the impossible happens, KVM needs to block
> all operations on the half-baked vCPU.
>
> Fixes: e1779c2714c3 ("KVM: x86: nSVM: fix potential NULL derefernce on ne=
sted migration")
> Cc: stable@vger.kernel.org
> Reported-by: Stefan Teodorescu <fane@google.com>
> Reported-by: Sashiko Bot <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/all/sashiko-outbox-210535@kernel.org
> Closes: https://lore.kernel.org/all/sashiko-outbox-205939@kernel.org
> Closes: https://lore.kernel.org/all/sashiko-outbox-193903@kernel.org
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Reviewed-by: Yosry Ahmed <yosry@kernel.org>
