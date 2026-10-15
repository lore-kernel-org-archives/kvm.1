Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4506C4CE68E
	for <kvm@vger.kernel.org>; Thu, 15 Oct 2026 23:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792106592; cv=none; b=fPbvl8MNbdfoHakY4rsKkQebbaRDuMDMfZEvZQN2DJ0IZODfljIH6SBMhVr4Z9yDAuuhi0shnZW1VcQoA1nWhvGmjsW6OtMrYFDOdhQZR2OVkFWzFowm9xu4XykadgclITmxkStcckXOY22i4qvwmKU2TYovh+H/I7r4xgKJrSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792106592; c=relaxed/simple;
	bh=88d23hl2u4nE+QByMY/+cT6s27MMOTxeyFDnS9wiczk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iBVZFInpcHfzWeR+C/P4AN/5JOKqnVJw2Obu204PBaeTIxxpPs2JFuWW/WjM8on3M9Knv/Z5D/k5tC1J1jZRadOd1m5iT1zoUGVUOUD9Fy9CfRs8WXOoIbm2MThTRLXPZ7VC/NlBbnTX234e5BAmw0Bna/IuIdNUTCtfDeJUx8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dnC8w+k3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dnC8w+k3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBAD91F000C9
	for <kvm@vger.kernel.org>; Thu, 15 Oct 2026 23:23:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792106589;
	bh=88d23hl2u4nE+QByMY/+cT6s27MMOTxeyFDnS9wiczk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=dnC8w+k3glVnO9kOiu5XYfGQdqNGOk0spgL0A8lx73S282kKLpghx2xZ3jASaSBzf
	 r87UpJXEmK/u7FwHfV1E+hA1Vk8iKOhdGYJfMCsWa6daTdVXsNyPM+ONakddR4OMSY
	 K2BGiOKxmRuJOHv0WMwlmd4RSPBBJ4+Kpa5hVDT4iMaBBCmZqk9qTrLcbGj5c6luey
	 Qtvj6/B8iD/bt95q3UmswDMTEDdc+OfmvIGgo2c37PyMKZY1YOFuG75Fx7DW3WcjlK
	 XieqEZUR0OdtJqo05GTBbGqWdKuIoy3g0UBin2XF8ggFf7Wx89kCjKZcGuu/eaQfP4
	 EkNS6vd/Nvhyw==
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-c315729ad50so950460266b.0
        for <kvm@vger.kernel.org>; Thu, 15 Oct 2026 16:23:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBy+SQC5fjegJKFO/4gL2AezkeRKhZQKR+o3aabfJe1/xawk+86/ySBuLiHL7X82ZDoFNFQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYIlDK4uo4wXextRE2UZksb+ZpHzSyJ5bLA6A/CvX+7rGdwRuxFy
	7e3uPjQpVsAkUEhNKRRipvf/7vE9Fw4NbhL3X1KrLt3c7P7r77tJSWhiBf0LR9900wD3BwYP2pn
	IzWY8GthKZwQ3OLc37jDzWCOeE9Yf/e4=
X-Received: by 2002:a17:907:7212:b0:c2d:bd95:874a with SMTP id
 a640c23a62f3a-c31a9fd3559mr1864392966b.17.1792106588785; Thu, 15 Oct 2026
 16:23:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261012233638.2546339-1-yosry@kernel.org> <20261012233638.2546339-24-yosry@kernel.org>
 <CALMp9eSZkbSEMkrbFDsWU962AuLVMMe-Uo_gesqrU7Nb_V+ezA@mail.gmail.com>
In-Reply-To: <CALMp9eSZkbSEMkrbFDsWU962AuLVMMe-Uo_gesqrU7Nb_V+ezA@mail.gmail.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Thu, 15 Oct 2026 16:22:56 -0700
X-Gmail-Original-Message-ID: <CAO9r8zM0xy_-uU+r-2tMsGpaujHqYksOwuV8AF-2vDoAknWSdA@mail.gmail.com>
X-Gm-Features: AclHuK-vHPqGlBEI-T4MKWTyAl44e0wx1CvdtZYhWSnyusVUp47ZVHCTCX5DtuY
Message-ID: <CAO9r8zM0xy_-uU+r-2tMsGpaujHqYksOwuV8AF-2vDoAknWSdA@mail.gmail.com>
Subject: Re: [PATCH v3 23/27] KVM: nSVM: Do not reset TLB_CONTROL in vmcb02 on
 nested VM-Enter
To: Jim Mattson <jmattson@google.com>
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Maxim Levitsky <mlevitsk@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 15, 2026 at 4:16=E2=80=AFPM Jim Mattson <jmattson@google.com> w=
rote:
>
> On Mon, Oct 12, 2026 at 4:36=E2=80=AFPM Yosry Ahmed <yosry@kernel.org> wr=
ote:
> >
> > Stop clearing TLB_CONTROL when preparing the control area of vmcb02, as
> > this potentially undoes pending TLB flushes for L2 (e.g. through
> > KVM_REQ_TLB_FLUSH while L1 is running), and remove the associated TODO
> > comment.
> >
> > This is currently harmless, because nested_svm_entry_tlb_flush() always
> > requests KVM_REQ_TLB_FLUSH_CURRENT on nested VM-Enter, which sets
> > TLB_CONTROL again before L2 is actually run. However, always flushing
> > will soon go away with proper TLB handling for L2, at which point alway=
s
> > clearing TLB_CONTROL would be a bug.
> >
> > Clearing TLB_CONTROL on nested VM-Enter was probably done because
> > TLB_CONTROL is not cleared by the CPU on VM-Exit. However, KVM always
> > clears TLB_CONTROL in the active VMCB after a successful VMRUN. Hence,
> > at nested VM-Enter, TLB_CONTROL in vmcb02 can only be non-zero if a TLB
> > flush is queued for L2 while L1 is running (i.e. KVM_REQ_TLB_FLUSH), an=
d
>
> Nit: s/i.e./e.g./

Ack.

>
> > that should never be ignored.
> >
> > Signed-off-by: Yosry Ahmed <yosry@kernel.org>
> Reviewed-by: Jim Mattson <jmattson@google.com>
