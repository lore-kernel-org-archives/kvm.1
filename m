Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6717A3655D1
	for <kvm@vger.kernel.org>; Thu, 15 Oct 2026 22:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792101822; cv=none; b=SUiQUtLZVMPRJ0ICKpX5Oe9YCdpygnS0VSbg/bewTnqMkV9fDcoxF7MKvVt+vHmEIW1/iSZhw/8m3I3fJMMBvqSoYGaSeKQa7S83ks5jW92ujQgkLtekccOjLMYnIpDIaWR0w6hDxg4U1lTDZ/GHkx/ZTefC0MvGcVh+u6HQGn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792101822; c=relaxed/simple;
	bh=s3dXUz45EzO2P5I0Nz1U/b470aeu6VCQWjDE3vztG2Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e2N8m2Rl7K0WO7wxCsoZvaU7xFo+WfJPsK3K58vvh7xCaBE7Ldp6QP/hUqzgFVQenuolvqIMUDY1cn5QNihmL1uILKdec1+rFIT63MzwayQWFzDDj7EwpYszBe7jbh2M0v0p8mBXcgjXJc4nQse43mmzzJIXAgA/4wrJWtoLInI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sj7d6HS9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sj7d6HS9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 166F41F000C4
	for <kvm@vger.kernel.org>; Thu, 15 Oct 2026 22:03:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792101821;
	bh=szlDPdzPaGIGQG7woB97i+5i/rT45eyotmz+Dy8N+BE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Sj7d6HS9R50FkJgtSLAUpJ0ZXfwXE19qSMCiGUiDq2Io1yxcuekQSG4Dc0KweOF6Q
	 kD1q17SGXbk6I8eZ/eEZASEOD6TaxZxqVG0ZcDoxbQ3vF8JM3pj8a7YspEq355JiyZ
	 iCCxpPY2G3QoKVSDWyi+WOP/sk839VfAzoKR15X/T2Laf7amf0aJr7b8/Qc2MWuUhH
	 NXUBHkufMQFNqWuG63no32Javyu6+MrTiBIjFaI+dzkNkOWm3/VJwx0TGL+CzleLfa
	 QDn6jCVj24fttozRcW2B+YKJ1v2Or17dSykdfmImlXOmeOE8DmmL2HZo+0DNzmJEPH
	 GZ+55DkR/x+Bg==
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-c4086e892a4so13409966b.2
        for <kvm@vger.kernel.org>; Thu, 15 Oct 2026 15:03:41 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxvC+xVEjJSbPlVyKuI/3nWFOR44tkzUwOkbLsk/9akNnm0Zht7dBa72bOhRBkLQ9NFsPc=@vger.kernel.org
X-Gm-Message-State: AFq9FYI0n+uDYsZ8IKOuP+EahAUDctLGLD/TpcFAWl4QvI6Evi1G/Ged
	JD7sWP3RV/1NTmWae5WFWn5qWUbB2Ck1Y6frpUZwdTi4T7TVZiFnXUYhS4KVuhm/jYZwk6Q37vR
	TIJSsXa61FOe+Z6t40IyODm0bAA3RMO0=
X-Received: by 2002:a17:907:9816:b0:c2e:378c:8ceb with SMTP id
 a640c23a62f3a-c31a9fa39abmr1902029866b.36.1792101819932; Thu, 15 Oct 2026
 15:03:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261012233638.2546339-1-yosry@kernel.org> <20261012233638.2546339-12-yosry@kernel.org>
 <CALMp9eThakVB_zqPQX=fQLrKh13BR33jmGg__rncOLDa2ZkXWw@mail.gmail.com>
In-Reply-To: <CALMp9eThakVB_zqPQX=fQLrKh13BR33jmGg__rncOLDa2ZkXWw@mail.gmail.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Thu, 15 Oct 2026 15:03:28 -0700
X-Gmail-Original-Message-ID: <CAO9r8zPHA2Xbwqm5sL1uymCy+T65LKLWDh6CKvV83euHhxPWTg@mail.gmail.com>
X-Gm-Features: AclHuK_nYUz9DoTohym6xnQnqjBpTxs8Sx40XHV9H2I5Nees_hkNp0dDHJuXMRo
Message-ID: <CAO9r8zPHA2Xbwqm5sL1uymCy+T65LKLWDh6CKvV83euHhxPWTg@mail.gmail.com>
Subject: Re: [PATCH v3 11/27] KVM: SVM: Only flush the fallback ASID when used
 by a different vCPU
To: Jim Mattson <jmattson@google.com>
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Maxim Levitsky <mlevitsk@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 15, 2026 at 2:44=E2=80=AFPM Jim Mattson <jmattson@google.com> w=
rote:
>
> On Mon, Oct 12, 2026 at 4:36=E2=80=AFPM Yosry Ahmed <yosry@kernel.org> wr=
ote:
> >
> > Instead of always flushing the fallback ASID on every vCPU run, only
> > flush it if the last vCPU that used it on the pCPU changes. This avoids
> > constant TLB flushing on a vCPU using the fallback ASID if no other
> > vCPUs that use the same ASID ran on the same pCPU.
> >
> > Note that checking (and flushing) the current ASID on vCPU load is not
> > sufficient, as it is possible that a vCPU is using the fallback ASID
> > only for L1 or only for L2. To do this correctly on vCPU load, both L1
> > and L2 ASIDs would need to be checked, and the respective VMCB would
> > need to be flushed. This would not be much simpler, and would perform
> > unnecessary flushes in some cases (e.g.  loading a vCPU that uses the
> > fallback ASID for L2, but L2 doesn't actually run until the vCPU is
> > unloaded).
> >
> > Another alternative is always flushing on vCPU load if the current ASID
> > is the fallback ASID, and flushing on nested transitions if the new ASI=
D
> > is the fallback ASID. Again, this is not much simpler and also incurs
> > unnecessary flushes in some cases.
> >
> > Do the logical thing and track the vCPU using the fallback ASID instead=
.
>
> Wouldn't it be simpler to track the VMCB associated with the fallback
> ASID on each pCPU? Then, you avoid any confusion regarding whether L1,
> L2, or both have been assigned the fallback ASID.

It would be if we went with checking the ASID on vCPU and nested
transitions. But since we're checking in pre_svm_run(), I don't think
it simplifies things. Oh, I guess it doesn't simplify this specific
patch, but we don't need to check if both L1 and L2 use the fallback
ASID on nested transitions.. but we have to check if they both use the
same ASID anyway for SEV.

OTOH, it would make cleanup more complicated, as we'd need to do it in
both vCPU freeing and nested freeing.

Did I miss something?
