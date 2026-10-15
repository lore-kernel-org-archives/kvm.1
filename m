Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C8952E5B2D
	for <kvm@vger.kernel.org>; Thu, 15 Oct 2026 22:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792102922; cv=pass; b=j1cvIATn+SO3OtiJ6qK0z2KlevU02NrFMWbG784GBcQnl96OrRncFmA9PqCtTUSegnt9wb0pJzFz/qb5JR0FkcLRNu3LrXRhFR7GrTCFbXrJ2sUHQA200RBH8ki6fm8C5zOyNG5PmJda2j33rI4ymiG6Z+kWuU2hg1qEdLEbHv0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792102922; c=relaxed/simple;
	bh=KkikMvxH3rj0L/VOvDtY/bRGTj4Z8RjW0M+5LNXlXjk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t5kF64MCH8S6f1b4nEGwk3HYJrcNWVlQKxtScmIKtPK7u9DD5epGL8TYsQ3jkyGI0zXQuucaQVuCbk186VzxMJ4TMc+zMZyYOAa1k1VG7nxDaEFL7ZQxq3gn2rlk4mQlHxP4uEf+0BYdKvSJXINoAXooRATPcqsEsZo4azjAEVo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EHqFSQWq; arc=pass smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EHqFSQWq"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-535f598d126so52161cf.1
        for <kvm@vger.kernel.org>; Thu, 15 Oct 2026 15:22:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792102920; cv=none;
        d=google.com; s=arc-20260327;
        b=kNRoA+t1k6DrvKG/42A5Q8JGq2r1njd5JvxFBNi3T4bkvUbN/ki5VQJD9OHxYc3tyD
         IbXzWmcrPyqcOe+VRdctrntpPNVOFBJLGyBLKeQxKArnAraXmLQtbDJR6cS7OEzzsQvD
         e9KmQlWYWcc2CAah5OIyJDJSZqiZLMOalmnjj20hlUc9Vk050N7jGgd8sVwFcmnpJBye
         22fVn7/vSE2ktVDV07fY3q5K519LJK+OaeEpPvr0Sj8jedWBKcDo1dfnpJOxnwZ09em3
         jSGbpKxMhw4n1lpjBIGVLfoyNzeotxHBsBf236fBSWBLbsZNxmPgSK1gB023VdIfl9In
         bVsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MBd6hEpKZ3r3K7vlYPpR9Slc2f6PtJ/lO71I2D8m3Vg=;
        fh=ET8FhOItBNjgB9h9Nv38QQ+P2f5xLhVmLOWYU0oTUNQ=;
        b=q+2vxPhmHet95BLgAKOXuLwnjfcOfAio71nMjiEjYpeF64oqhv8eKwwejpsIf8im5j
         FizSGlCXpASD9R74b47gDj6rRzACOrsmy5nLpPEk9wMnYa3GkkmdtSsPim2fcxOc9UI9
         iL91L3WhYGXpyJx+G1GFf4ZK5H6FUZtDg4GJf6/vfUicT6V+pHabZvfIcajrQ7Luk4WY
         Ajqz/7ScNkUrPCPw90WzGcEFrwIEvgP97nRmDdS+PdhEhzKqJcPaGDJ62yjp69XtmrWw
         LZHfWAm4f6lZJYm+403kuz5SoeVehZgk1EakZ4aB/b91iQLdlQxFmYZfy4IF3t904+ok
         vdyA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792102920; x=1792707720; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MBd6hEpKZ3r3K7vlYPpR9Slc2f6PtJ/lO71I2D8m3Vg=;
        b=EHqFSQWqJpC5N2wLj90e/qttXm3uHg9Qatv/SYQQFuty/RQ8TMquFHe1ZNoM1NmorP
         nC7YKlgnHqDefg/SkiQDoKt1b1imjP6iaJfRuO7tGM0nrIoPzWjDWkkrX1SaV3YpDXnA
         KaxU527o0yW54qJ2z7VRj/uYJslWqZ7tIt2TtUyEGnNgU/7cIHMy2Jgql0s3QzmcyFn7
         zOW9hng2R2fn6ZX9boa//nNxZA8Ej95uLLkzSxbDhqf8qpQPbVg+y/Fko/lyIcSqmAUv
         B//QA7qb8fx6Uj+MmhL+SrcpRcryEAV3jE6YAvKaZitc3E045jpQaWD8uyyaN2NLRfgO
         4m9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792102920; x=1792707720;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MBd6hEpKZ3r3K7vlYPpR9Slc2f6PtJ/lO71I2D8m3Vg=;
        b=1WXksJJ3oqFlWOdkO5o5LadPYQCcdui+98bjU0u1UuLRpTmL/rC4rhcFQGrLN+4V3G
         sTvmv60CnARPZlTCgK4mUVOXMLXLFE0+g+a+Mn0AtI6m1hWHakQZHdru0u5HpZlxvSzC
         nisrMs+nmJzcr1vvKbGXhoVN8KCe825in7d0l9LdP9fUCVogsaNeI8tz5NR5yVKpIq/Y
         pMq9551Xfww8YvwsvyAk3EdHvnP3ZtQyA7obN2frE8PT88lT+D22Ieib9VOSlWC8lwRs
         EtW0XcRZQV5h7kxkZuJlenQ6MewR7ixRbCEa2JtLGSvQ0Dvghk/Sfn6Qy9t0eO6CwWz+
         Qwug==
X-Forwarded-Encrypted: i=1; AKwUvBzf9Z2Z3bDciBqAlKnW0UMjPNBd18upiO4s3wanM9RR3V1oZsNDCrGMc/gR8p+ndjl/fQc=@vger.kernel.org
X-Gm-Message-State: AFq9FYIjZwRbWGK6Dr5ctOF1C4ZO9zerNrXrMQE8PKKLqms6/zCUyTTn
	EUM24QqnxSOfYULKxF+NjP9/GXJ6l4SZ3Ka2jZURsg1oo0pUZCUzDYlKPCJ1FrRHbjh2kXugNZ1
	r8XiAw1tz3D/0NJooa/y8CzmcutKRnlKiuFqWGSCD
X-Gm-Gg: AYBFou3ruTmygjHFz+5woH67GM38AxH0PShsMaW3oIj5ZFjISlekP0dpuAGSRXoCSfb
	7JEJaq7xuvk0+u0MNRvynKMMRezKTe6/Blsx2RhADz0WshMaWDH406O7pIjyqWg7aB6CRFmLob+
	+N9i0m46jbTfT6cfUiIJMQkB30jOJx8Hm7eMGRk4G498fKqWzHkI+4Qbxd88/8o/7Q+2mwkXCRk
	XZ00Y56z3CATP7KzBUdN57YtG+UVuzcPaE6a1AvsNGTjWoGKfPGWusW4Q5hnJZ0w7hpRLgcbP6Q
	XIDvsiBhev79Tjix36LnXitQe3ZSKItw9q2MhP9tNIajadOPR2ytJbc=
X-Received: by 2002:ac8:5ace:0:b0:534:b7b2:634f with SMTP id
 d75a77b69052e-5362b38a8fbmr3075541cf.8.1792102919565; Thu, 15 Oct 2026
 15:21:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261012233638.2546339-1-yosry@kernel.org> <20261012233638.2546339-14-yosry@kernel.org>
 <CALMp9eSV0ikZ8CDoah_vCKYFXEm5syYh_sCMQ8wXhGB0+E=vcg@mail.gmail.com> <CAO9r8zOUjXMvhmK7TBmgKkbs+JjFMEmcLgW589_N_smC6k-hrw@mail.gmail.com>
In-Reply-To: <CAO9r8zOUjXMvhmK7TBmgKkbs+JjFMEmcLgW589_N_smC6k-hrw@mail.gmail.com>
From: Jim Mattson <jmattson@google.com>
Date: Thu, 15 Oct 2026 15:21:44 -0700
X-Gm-Features: AclHuK9oby-Dpii1wjubWP9C6KcK5dMj-1Uqq3YqdbPUbcRMGTZKMun0ZwqmmKg
Message-ID: <CALMp9eQ_RJV4-+FKewTFdFacY=LJbn7Pd2T-ET_cDU+-HXHd7g@mail.gmail.com>
Subject: Re: [PATCH v3 13/27] KVM: nSVM: Add a placeholder ASID for L2
To: Yosry Ahmed <yosry@kernel.org>
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Maxim Levitsky <mlevitsk@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 15, 2026 at 3:10=E2=80=AFPM Yosry Ahmed <yosry@kernel.org> wrot=
e:
>
> On Thu, Oct 15, 2026 at 2:55=E2=80=AFPM Jim Mattson <jmattson@google.com>=
 wrote:
> >
> > On Mon, Oct 12, 2026 at 4:36=E2=80=AFPM Yosry Ahmed <yosry@kernel.org> =
wrote:
> > >
> > > In preparation for introducing a separate ASID for L2, introduce a
> > > 'placeholder' ASID that is still the same as L1's ASID. This will
> > > facilitate future changes that need to distinguish L1 and L2's ASIDs,
> > > before actually using a different ASID for L1 and L2.
> > >
> > > On SEV VM migration, copy the new SEV ASID into asid02 and vmcb02, in
> > > case nested was already initialized on the destination vCPU before
> > > migration.
> > >
> > > No functional change intended.
> > >
> > > Signed-off-by: Yosry Ahmed <yosry@kernel.org>
> > > ---
> > >  arch/x86/kvm/svm/nested.c | 5 +++--
> > >  arch/x86/kvm/svm/sev.c    | 9 +++++++++
> > >  arch/x86/kvm/svm/svm.h    | 2 ++
> > >  3 files changed, 14 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
> > > index bfb297b7d71ab..780132725bb79 100644
> > > --- a/arch/x86/kvm/svm/nested.c
> > > +++ b/arch/x86/kvm/svm/nested.c
> > > @@ -701,7 +701,6 @@ static void nested_svm_transition_tlb_flush(struc=
t kvm_vcpu *vcpu)
> > >          *  - Honor L1's request to flush an ASID on nested VMRUN
> > >          *  - Sync nested NPT MMU on VMRUN that flushes L2's ASID[*]
> > >          *  - Don't crush a pending TLB flush in vmcb02 on nested VMR=
UN
> > > -        *  - Flush L1's ASID on KVM_REQ_TLB_FLUSH_GUEST
> >
> > Um...How does this patch either do this TODO or render it moot?
>
> L1 now has a separate ASID from L2, and it's the one we're already
> flushing with KVM_REQ_TLB_FLUSH_GUEST. It's kinda already moot because
> we already flush L1's ASID on KVM_REQ_TLB_FLUSH_GUEST.. or maybe it's
> actually *wrong* because KVM_REQ_TLB_FLUSH_GUEST needs to flush the
> current ASID, not always L1's ASID.
>
> I can drop it separately if that helps.

You could just explain it in the commit message.
