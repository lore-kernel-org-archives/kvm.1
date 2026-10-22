Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792709168;
	b=WUuEDq6CvBi3kCirhFaFpNHlhBf6LbHYP0xrga1Gc6/LgU1LpECbDywlZ1jybC+k9VbD
	 iWEyqBtz9EGuRfZNKWJ05kQVttvRu84x2ehWK/uUWmRqvNjqVexmvxBmkUivtM3bkRaI+
	 4AaXsDIz3BYb966IgRWEy3Hemd8tAGAf1t3qDzm8zwDvhC1WbmHcPoLIOBVpWrc1P9UJk
	 7js6lRMZHgB75Iny3ZCowBLs7rMe+QTAnrxJHNHjxCRsGDef5tWnnixF/0hdn9KURknjK
	 qvNaTawmh7iVAF8l7L5z8OrqWoiBmE5s/h1VM7pBDcKFRh2VcQSyX5vpXdCOofDwozQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792709168;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=bMkxoizRKty45Gu4zy23N2djLQKVUF82/geDTDbA6o4=;
	b=ykrPEp4+OUI7axXH+kt2d4xLVPoeiJUt1W/8IpCHbkIxae+8NFV92sWuhOhFDAoEzBg+
	 gqUQwPqSp9GABoH8xb/PFoJ0+Dhc3dVT+l4rm3OGGhtpk+l5qS4VyZ5rlTtPWnqtWI7se
	 tBYvkDJgfeX88OlocDVlPYhi9zXsP5FBdI1ZPl4VZ/k87ik6GBqkiumek81+AVQlixMe2
	 75bu8tJgGlAOzxyq/5lmfrUdP6HZPeFTp7su5Sws7cYRpyX5kuvYvgq/CN2EQLJgKeQg0
	 9DRF38lPeKAx+9sSshHQ2Ovoq3+X5YA3HLNvEADGjDjr5o1zXLzo7Bk3Q8GvCjuRcfg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I9dgdvWg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFCBC606A324
	for <kvm@vger.kernel.org>; Thu, 22 Oct 2026 22:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I9dgdvWg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E4AD1F031E2
	for <kvm@vger.kernel.org>; Thu, 22 Oct 2026 22:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792709167;
	bh=bMkxoizRKty45Gu4zy23N2djLQKVUF82/geDTDbA6o4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=I9dgdvWgJMLk71IrF6/czy516XNbjnQEbPJgoTkKubOLCI/ENm1WGaY9+unD/y6gY
	 JbLWfFMmQr/0qEb0yhtT/CgdHRar98GBKEyy9NARqKgAIt97U/cGEg0MCxYa/yseik
	 bp13YOHm8CAxFiOsM+R55SBfaHg3w/J0RKRgHczBSkfn0K+khG43fJRXdjBmBmPys9
	 /PpjyuU+G/n0hF/jakpQCllN6lCMaYrUXPo2T0x7oZAKwFPIgbuWQRzLd1U6B8R7Sl
	 eFNu2FW9Hv+LWpwYtKLCUNmDCYjd0cPzA1aONls8kqMquK3DmZpV8ACPziHLnYz6D7
	 npFhOD+judP/Q==
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c450ab1483cso40364066b.3
        for <kvm@vger.kernel.org>; Thu, 22 Oct 2026 15:46:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxr2fF8kBhKJ+jhwbOnECmn17cW3aYGzMKzocOEbp/RmsTjQyIwGkCc7TAHa1F8OAY0LAg=@vger.kernel.org
X-Gm-Message-State: AFq9FYJcuYukfkzQvKMVJc5onfjpbqSo4tA3QLhWkUdfFs8FoeP+befL
	+AOGRb3RQybmyqfx9AsnHtQqUKd+I/5k8o8ZWXgTslvQgIi1OSxZvUIDh1NkyNxhXPsAxE/AoJ/
	k4WRwwbelYIfM0MWWcVHEraupEIDeQ8g=
X-Received: by 2002:a17:907:da8:b0:c34:e9fe:82ed with SMTP id
 a640c23a62f3a-c46a92d5b5dmr77309966b.28.1792709166529; Thu, 22 Oct 2026
 15:46:06 -0700 (PDT)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261012233638.2546339-1-yosry@kernel.org> <20261012233638.2546339-27-yosry@kernel.org>
 <CALMp9eS8KDozNGT9J_uN69W32QEvTbg2JrtRqN0ESi00b_uq=A@mail.gmail.com> <atqRyeqSXViiNIk6@google.com>
In-Reply-To: <atqRyeqSXViiNIk6@google.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Thu, 22 Oct 2026 15:45:55 -0700
X-Gmail-Original-Message-ID: <CAO9r8zMqiW=3t7zRo_WAhKJfpYsDwuG3e=nK14GXhrq+foYnOw@mail.gmail.com>
X-Gm-Features: AclHuK_GBnQB00bajIT5OcgXNAjZtj7uyBg5FlfE90XA-YZvkKGNfsHzyVdTGQc
Message-ID: <CAO9r8zMqiW=3t7zRo_WAhKJfpYsDwuG3e=nK14GXhrq+foYnOw@mail.gmail.com>
Subject: Re: [PATCH v3 26/27] KVM: nSVM: Use different ASIDs for L1 and L2
To: Sean Christopherson <seanjc@google.com>
Cc: Jim Mattson <jmattson@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Maxim Levitsky <mlevitsk@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 22, 2026 at 3:44=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
>
> On Fri, Oct 16, 2026, Jim Mattson wrote:
> > On Mon, Oct 12, 2026 at 4:37=E2=80=AFPM Yosry Ahmed <yosry@kernel.org> =
wrote:
> > Moreover, does this change the semantics of PV TLB flush? In
> > record_steal_time(), we have:
> >
> > if (st_preempted & KVM_VCPU_FLUSH_TLB)
> >         kvm_vcpu_flush_tlb_guest(vcpu);
> >
> > IIUC, an idle vCPU that wakes into L2 will flush only L2's ASID. In
> > the past, with a shared ASID, L1's ASID was always flushed on emulated
> > VM-exit anyway. Now, L1's ASID will be unaffected. Though I can't find
> > any real documentation on PV TLB flush, it *seems* like the remote
> > vCPU would want L1's ASID to be flushed. OTOH, this change makes nSVM
> > behave just like nVMX.
>
> That's a bug that absolutely needs to be fixed, probably relatively urgen=
tly.  We
> should also document that passing through the steal_time shared informati=
on to L2
> to utilize PV TLB flushes for L2 is explicitly not supported.
>
> I hate to re-introduce deferred actions for L2 =3D> L1 things, but that s=
eems like
> the only sane way to handle this, because handling the !tdp_enabled case,=
 where
> KVM needs to sync the current root, requires knowing what MMU is going to=
 be in
> use when L1 regains control.  Yuck.

Are you implying that *you* will be re-introducing deferred actions? :P
