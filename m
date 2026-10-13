Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17EA53CB2DC
	for <kvm@vger.kernel.org>; Tue, 13 Oct 2026 14:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791901528; cv=none; b=VqHj9neuDRYPlYQh+qSVSq0FSFrOaQ5oOrZs/niYdgzeEwxd9oaSWfEiYOSLvjN79+9LkkeBAxooq0HYEUB8pT3ASCJjaxeXUhCYb+LH4bTQ2znwnNE/niLAv1Y36V4zSGua+SdxICGLcaIswClXWwUqkZqMxnpfDq8zOoCT2e0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791901528; c=relaxed/simple;
	bh=W/jSc+WrS1ATArodzscBQo4guiiRlHRB+HWRJS+e0pY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ggGE/OJcbTEsQw+tHkWoGeY15JhAM25bvblyUmwy1ay2LGgtXFflC5xZ0e+X4mdzkLrWuGiR7q5PhX3oz4IwlYmo14pJGdReGP8Rwd03TWTS5qX45YjEcTmdNupUmomhI7BsWoZlaAhjs4vWIcaZWSl82Ga1eOB4ROYDrtOwD1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WKMtzjbJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WKMtzjbJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B94FC1F000FF
	for <kvm@vger.kernel.org>; Tue, 13 Oct 2026 14:25:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791901526;
	bh=88+HFEK0E176EzbC4QEVRjmLfytSU2OlquqEF4DJOMA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=WKMtzjbJSNNJ1SVL9L1NKLqqkQnmDX9JXNTj1JtwCbqQWCOJolfN/QlntsSGE6zaZ
	 UL5zOcrdSc2/gWROSIVlFzg3f3TS5fA5QlmFjFr0sT6fq3dPOEfbJRkYlZA+OcY0KJ
	 dS3PMXjrafcvAmQbOAwynx1b33lnwcGY+lmKP33VFcDVHhGUPpwWZ744ef/FxFd0To
	 bmlO5SALhO5h8bW4lQwiWfHIEWvIh74YhTAKuvcgwUNPfYenOdQ1TYAumD9JcYBpwj
	 +Ih7vTGfPOxyWAs7onK/YbfE6sDMQRRL2usiYyaPPxEN2tgM3gD/SqstMRGAgekB4U
	 CJ+8WIW1Z8Nbg==
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6b1dae0febeso2145198a12.2
        for <kvm@vger.kernel.org>; Tue, 13 Oct 2026 07:25:26 -0700 (PDT)
X-Gm-Message-State: AFq9FYJmFv/NcJnTf+D7q7mt2LAFbWnB+MUo/43RfdIRVeDovyxx+1N2
	8PWNDEme1mCM9x5Onk0cJNr1TLwfgQUFWco2olGvvbqgIApEYwqgQDoQaEfbLZKEp3oFbEIyYKE
	TyiWw0cfKEUy/HNEHAEKDBi/OPdaMmPI=
X-Received: by 2002:a17:907:d27:b0:c2e:801e:48c8 with SMTP id
 a640c23a62f3a-c31a9a04df1mr1215213666b.5.1791901525645; Tue, 13 Oct 2026
 07:25:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261012233638.2546339-1-yosry@kernel.org> <20261012233638.2546339-14-yosry@kernel.org>
 <sashiko-outbox-168763@kernel.org>
In-Reply-To: <sashiko-outbox-168763@kernel.org>
From: Yosry Ahmed <yosry@kernel.org>
Date: Tue, 13 Oct 2026 07:25:12 -0700
X-Gmail-Original-Message-ID: <CAO9r8zM-MTNYcAcT_v4gb1YJi+YduSFBudkK6nB9gDoeq-Q8zw@mail.gmail.com>
X-Gm-Features: AclHuK8UCS2S1Vamwa_ZokuqDc2aH1k3NkAFdmQpRzhMH4KOK2K87H-0Py9YSys
Message-ID: <CAO9r8zM-MTNYcAcT_v4gb1YJi+YduSFBudkK6nB9gDoeq-Q8zw@mail.gmail.com>
Subject: Re: [PATCH v3 13/27] KVM: nSVM: Add a placeholder ASID for L2
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 12, 2026 at 5:01=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [High] kvm: nSVM: missing vmcb_mark_dirty() when updating L2 ASID in SE=
V migration
> --
>
> commit c8f241845a6790f522df58195167e95ce8fea046
> Author: Yosry Ahmed <yosry@kernel.org>
>
> KVM: nSVM: Add a placeholder ASID for L2
>
> This commit adds a placeholder ASID for L2 to prepare for future changes
> where L1 and L2 will use different ASIDs. It also updates the SEV migrati=
on
> path to copy the new ASID into asid02 and vmcb02 if nested is already
> initialized on the destination vCPU.
>
> > diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> > index 99577859e1aab..b2e6acfbb081f 100644
> > --- a/arch/x86/kvm/svm/sev.c
> > +++ b/arch/x86/kvm/svm/sev.c
> [ ... ]
> > @@ -2041,6 +2041,15 @@ static void sev_vcpu_migrate_asid(struct vcpu_sv=
m *dst_svm,
> >        */
> >       free_asid(dst_svm->asid);
> >       dst_svm->asid =3D asid;
> > +
> > +     /*
> > +      * If nested is already initialized on the destination vCPU, also=
 update
> > +      * the nested ASID to match the new SEV ASID.
> > +      */
> > +     if (dst_svm->nested.vmcb02.ptr) {
> > +             dst_svm->nested.asid02 =3D asid;
> > +             dst_svm->nested.vmcb02.ptr->control.asid =3D asid;
>
> [Severity: High]
> Does this code need a call to vmcb_mark_dirty(dst_svm->nested.vmcb02.ptr,=
 VMCB_ASID)?
>
> If userspace creates a non-SEV VM, runs it in nested SVM (allocating vmcb=
02
> and caching it on a physical CPU), and then uses it as the destination fo=
r
> an intra-host migration, the migration path updates the ASID here.
>
> If the vCPU is scheduled back onto the same physical CPU, pre_svm_run() s=
kips
> vmcb_mark_all_dirty(). Since the VMCB_ASID clean bit might still be set f=
rom
> the last exit from L2, could the CPU ignore the new ASID in memory and
> incorrectly reuse the old non-SEV ASID from its internal VMCB cache?

If the migrated SEV has nested enabled, restoring the nested state
should mark vmcb02 dirty in svm_set_nested_state(). But yeah we should
probably mark VMCB_ASID dirty here. Not sure if this is worth
respinning for it tho.
