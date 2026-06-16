Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B4B212564
	for <kvm@vger.kernel.org>; Tue, 16 Jun 2026 00:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781569179; cv=pass; b=ZcQAc3gqf1X+clzhTmKaiHY5tyNXH20myE8OBBHbb7gY2S69ukfqF815n6TcwlzjLVvhVbJCIPL5047nUPGBz1poDra4eX7xzS1VP/7JICazQP796LgNYSU8naYZWH66MECv5NWjIfJHzl+cOBDniwO/3Hh01VPsYqj+/nwqNik=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781569179; c=relaxed/simple;
	bh=R7jkRHEbkI3KDNTdvpskkAftIPIp5keaE4wczIV0tng=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vpttk3gUac6+JqYvRcXwsft0+Mw1mOKLpcP5gFvy2AXSEUQNn7D1G8Nw8MfWWzDXgrbkNw4vCNlQnUzgR26uTVM+QTfZPaacQDugwFr1Ku/qRggy2mMIOLsqNhwYbgFCsn3xs/sErqErJcZ4uBpxPr9xZl8XHRlxH0QJ8DCREIA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=j4DeTZkP; arc=pass smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j4DeTZkP"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-490be29c1c5so42890445e9.2
        for <kvm@vger.kernel.org>; Mon, 15 Jun 2026 17:19:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781569176; cv=none;
        d=google.com; s=arc-20240605;
        b=DKUPX09SdgJ5Z0JalWPE4CtZkyYy+x2uXLkzmNcngxTyU1/eRJfwRMF5750aTeoN1g
         36L8fjwJq25tkR0Xzs45U4KdRXCqU+hYfTc3KTFdoZMglxLcGWMWUhnTo+tc5cM/msuL
         v2UAAJU8om9+XJ9dnwGeix3KGbSGu1Py364/DfQ56oEvI0pp5/B9dHPsYAlm46ohglBy
         84E4wd1EL4tHIXZ89VbKKuwoifyLgNhq4pDBhXHj4VKmo0D17YdOELor68bbk/y5dMHQ
         lDQms5bRg6tWe4sb8lthjfFFOcIfZJxksOGiOQs5M55NcA+nGWqcoY2yBFUolk0eFbgI
         lnow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5YLj9OAh9JKKkVKHgW/CHhfFo9P9VujzFSmDrvaSXGQ=;
        fh=rP+p2QsuNFwFuxIqpOuNaE8doOZqx+ffamN+qL9aA8c=;
        b=LyPyh+MnuandWfvhBV4kXwi2uWjSEL9ay6GkfDkyJKiNKEtKRoKY1WyPtB2bD+DV2x
         HHlPKQPh5NYoBM74R496xRSaDBurOQZg2oN5U925PiUWODizmpEI2Dpo/5+uYUzHXuaX
         ZH0SWeh41EH1IiJXcyTBaEb2PnIe8dimHlyp536tviYZyG3m9sgUPIP03q45tC9/36hv
         m3o52yMy4ytpBNVL07WIIt0VQhCFLA49IDmEet9z76HwxxWS38sFfGjP0AduVR+TgiDg
         X+swGJSKIZpAhRZ8VWFeJRGH/K3wRbpkfjDIRB6zD8DWOQALpMJFfI12Pi2XrIr5Jg4C
         Cc0g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781569176; x=1782173976; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5YLj9OAh9JKKkVKHgW/CHhfFo9P9VujzFSmDrvaSXGQ=;
        b=j4DeTZkPYxc53ijSLK/8KCiuz8NA5AKrZgBfEYUm6xcpKGKNqeng4BMvskJAPTp1vU
         CMbF3HXPawmyQneZysp+4YpEtL8WpjWocqBw6T+e/iMeCHpLZfH7uJCrvkukKRd+uOPh
         58Nu08Oq6tPojJgpxUIjiDOT5F0G9mJWcOZJ/wQu8lbaV3cHeU0Kp9aotlR10awvpzQ/
         6TZAF6sESLYkhdU6XtIDI//uQ9hzy/Bd+09rWz66OllW+92tha4I5i7gJIzkd/O91u2Q
         l/8N7BBKPmQEV2t+B9Yb0VZTPb0DgefG+5TnM/dlFdtO/Nq7EoCr6JEGMVldWRSyeBsL
         yqcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781569176; x=1782173976;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5YLj9OAh9JKKkVKHgW/CHhfFo9P9VujzFSmDrvaSXGQ=;
        b=b/5Kpx9bh293pGPuDrlWlXsJK5CDe3fm65M0yYaAzCLSivWBK+euPgkTUmqgjzAk6w
         +LMgWzK3w3ZI9o4Ecf+jIwGHLhGcBqsgJrPuZsZZNuTyFqMtw4UzHEXzHxU5b/dPTW4+
         12gjh+x3doezz1cPQZmaovYG79Cux1HqaYzBEEu7oAqi0hYMyUdsUDeU8ly9TZ+kPYC9
         /9DGo/N8mB+g7DkE0+KRp2O28B3OjD+cf5pELdFHEsLGhm3/1DsnCDFpnWxKLDXb0Ipw
         MJatG4xV0v6Ib2F9IY0l0nyRpA9klCY1huwahRjkyP5z4hMOtcK8dXLwmAhQGzodiYnt
         WAvQ==
X-Forwarded-Encrypted: i=1; AFNElJ80+/YQCqQU9d/MzioubyxMmakDw7TocX5m7WifQSoZ48TPSxFkvhi4mw5vVYQrHeoaljk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz51i3gQib99OHWEkZwdewGBR85vu1AqhkXQP7LKa3Q22tPTQhg
	EaNE5pKJ/Xfpp5VqdxzDaaqDMYBseaIwtoJ2d2jb5rcukAGAGUZzsW+bmTTiy5Ol5lakKrQkWGR
	QQ9s7l4rGqrVAJfHvASyNlI137Bhz7bX0fHwkK9QA
X-Gm-Gg: Acq92OGA4Kfae/Pp1Ct4BBCSZF7XL5Lm4+We+A3i/ldmLvkJfzioOmhNQ3eEAuPHV/x
	nz4YLJ00EpOS8A4H1piwppQFqULBty1j5BqneFux4K5Lo8jz1F6StQ2lEG7wgI8VSWZIVWJND38
	NSoZOf2OP5giPNpfXpsAtp3536xfLQ3/MtbSog4t1Zw05ExdoBQ9QgdjnQ/fYTPj9X2bYprDXIk
	StGrGkg78sx3EBW76mORzyMbJxCVHoWKd3QOYtg9MtaXrmXLKXfjmDHHSimXfdK0pS8LxdFexCU
	vEiVGE+JsvEpviNxSJUwnoQQt8GIuGWWDOt4
X-Received: by 2002:a05:6000:4716:b0:461:a15f:700a with SMTP id
 ffacd0b85a97d-461a15f70a6mr573337f8f.9.1781569175315; Mon, 15 Jun 2026
 17:19:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260601-sev_snp_fixes-v2-1-611891b28a86@meta.com>
 <20260601231728.C67C51F00893@smtp.kernel.org> <33dccdf4-45f7-40b5-a0cf-3f99b26d46f1@linux.dev>
 <2ae6f15d-695e-44d7-b2ab-905f83e78a6f@amd.com> <CAJ5mJ6jVX++74H2o=ZFcQbppHoNTWD0a52wOycYL4En3_dUWeQ@mail.gmail.com>
In-Reply-To: <CAJ5mJ6jVX++74H2o=ZFcQbppHoNTWD0a52wOycYL4En3_dUWeQ@mail.gmail.com>
From: Jacob Xu <jacobhxu@google.com>
Date: Mon, 15 Jun 2026 17:19:23 -0700
X-Gm-Features: AVVi8CduKs6ypAk7r23RxbnbCi_yifSdOfmekAY59pAbw-267Uo-nPzuRXtiWko
Message-ID: <CAJ5mJ6j54GG5A_n8+4azeZ4BUAWbYEdv40AY3JbPCcT_dDZ+0g@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] KVM: SEV: Do not allow intra-host
 migration/mirroring of SNP VMs
To: Tom Lendacky <thomas.lendacky@amd.com>, joerg.roedel@amd.com
Cc: Atish Patra <atish.patra@linux.dev>, sashiko-reviews@lists.linux.dev, 
	Peter Gonda <pgonda@google.com>, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

oops, wrong email, corrected.

On Mon, Jun 15, 2026 at 5:18=E2=80=AFPM Jacob Xu <jacobhxu@google.com> wrot=
e:
>
> >  Could this silently
> > drop important execution features for SEV-ES mirrors?
>
> f43c887cb7cb5 "KVM: SEV: Update svm_vm_copy_asid_from for SEV-ES"
> notes in its description
> ```
> For mirroring SEV-ES the mirror VM will need more then just the ASID.
>     The FD and the handle are required to all the mirror to call psp
>     commands. The mirror VM will need to call KVM_SEV_LAUNCH_UPDATE_VMSA =
to
>     setup its vCPUs' VMSAs for SEV-ES.
> ```
>
> This seems to assume QEMU (or whichever VMM being used, i haven't
> checked QEMU) syncs this for us by calling the other ioctl on the
> target VM. Notably Joerg sent out a patchset that directly sets VMSA
> from userspace (https://lkml.org/lkml/2026/6/11/1200), so we may want
> to coordinate this a bit.
>
> Adding Joerg to the thread as FYI, we'll also be wanting to support
> copyless migration for planes which replicates more state.
>
>
> On Wed, Jun 3, 2026 at 6:15=E2=80=AFAM Tom Lendacky <thomas.lendacky@amd.=
com> wrote:
> >
> > On 6/2/26 16:55, Atish Patra wrote:
> > >
> > > On 6/1/26 4:17 PM, sashiko-bot@kernel.org wrote:
> > >> Thank you for your contribution! Sashiko AI review found 3 potential
> > >> issue(s) to consider:
> >
> > Adding @Peter Gonda who knows this code better than I do!
> >
> > Thanks,
> > Tom
> > >>
> > >> Pre-existing issues:
> > >> - [High] Missing `kvm->arch.vm_type` validation in
> > >> `sev_vm_copy_enc_context_from` allows creating structurally
> > >> inconsistent mirror VMs.
> > >> - [High] Missing `vmsa_features` copy in
> > >> `sev_vm_copy_enc_context_from` breaks SEV-ES mirror VMs that use
> > >> features like `DEBUG_SWAP`.
> > >> - [High] Concurrent list modification of `owner_sev_info->mirror_vms=
`
> > >> without holding the owner VM's lock during mirror VM migration.
> > >> --
> > >>
> > >> commit 5adb8a893221b0569310f07fd9fc7abca8088651
> > >> Author: Atish Patra <atishp@meta.com>
> > >>
> > >> KVM: SEV: Do not allow intra-host migration/mirroring of SNP VMs
> > >>
> > >> This commit rejects SNP source VMs in migration/mirroring until prop=
er
> > >> SNP
> > >> state transfer is implemented.
> > >>
> > >>> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> > >>> --- a/arch/x86/kvm/svm/sev.c
> > >>> +++ b/arch/x86/kvm/svm/sev.c
> > >>> @@ -2142,7 +2142,8 @@ int sev_vm_move_enc_context_from(struct kvm
> > >>> *kvm, unsigned int source_fd)
> > >>>           return ret;
> > >>>         if (kvm->arch.vm_type !=3D source_kvm->arch.vm_type ||
> > >>> -        sev_guest(kvm) || !sev_guest(source_kvm)) {
> > >>> +        sev_guest(kvm) || !sev_guest(source_kvm) ||
> > >>> +        sev_snp_guest(source_kvm)) {
> > >> [Severity: High]
> > >> This is a pre-existing issue, but I noticed a potential locking race=
 when
> > >> an existing mirror VM is migrated via sev_vm_move_enc_context_from()=
.
> > >>
> > >> Locks are only acquired for the source mirror (source_kvm) and
> > >> destination
> > >> VM (kvm):
> > >>
> > >> arch/x86/kvm/svm/sev.c:sev_vm_move_enc_context_from() {
> > >>      ...
> > >>      ret =3D sev_lock_two_vms(kvm, source_kvm);
> > >>      if (ret)
> > >>          return ret;
> > >>      ...
> > >> }
> > >>
> > >> Later, in sev_migrate_from(), it updates its owner's list of mirrors=
:
> > >>
> > >> arch/x86/kvm/svm/sev.c:sev_migrate_from() {
> > >>      ...
> > >>      if (is_mirroring_enc_context(dst_kvm)) {
> > >>          struct kvm_sev_info *owner_sev_info =3D
> > >>              to_kvm_sev_info(dst->enc_context_owner);
> > >>
> > >>          list_del(&src->mirror_entry);
> > >>          list_add_tail(&dst->mirror_entry, &owner_sev_info->mirror_v=
ms);
> > >>      }
> > >>      ...
> > >> }
> > >>
> > >> Since the required lock for enc_context_owner is omitted entirely, c=
ould
> > >> this concurrently modify the owner_sev_info->mirror_vms linked list =
if
> > >> userspace creates a new mirror via sev_vm_copy_enc_context_from(), w=
hich
> > >> locks the owner VM? Would this result in kernel list corruption?
> > >
> > > It looks possible for SEV VMs looking at the code but I don't the kno=
w
> > > code path
> > > or the mirroring/migration use case well enough to judge how likely t=
his
> > > scenario
> > > in real world.
> > >
> > >>>           ret =3D -EINVAL;
> > >>>           goto out_unlock;
> > >>>       }
> > >>> @@ -2865,6 +2866,7 @@ int sev_vm_copy_enc_context_from(struct kvm
> > >>> *kvm, unsigned int source_fd)
> > >>>        * created after SEV/SEV-ES initialization, e.g. to init
> > >>> intercepts.
> > >>>        */
> > >>>       if (sev_guest(kvm) || !sev_guest(source_kvm) ||
> > >>> +        sev_snp_guest(source_kvm) ||
> > >>>           is_mirroring_enc_context(source_kvm) || kvm->created_vcpu=
s) {
> > >> [Severity: High]
> > >> This isn't a bug introduced by this patch, but this block seems to b=
e
> > >> missing the kvm->arch.vm_type !=3D source_kvm->arch.vm_type check th=
at
> > >> exists in sev_vm_move_enc_context_from().
> > >>
> > >> Does this omission allow creating structurally inconsistent mirror V=
Ms?
> > >> Userspace could potentially create a destination VM as KVM_X86_SNP_V=
M and
> > >> mirror a source VM of type KVM_X86_SEV_VM into it. Since KVM's core =
MMU
> > >> would treat the new VM as an SNP VM (due to arch.vm_type), but the S=
EV
> > >> code treats it as a legacy SEV VM (because ____sev_snp_guest evaluat=
es
> > >> to false), could this produce an inconsistent internal state and all=
ow
> > >> attaching guest_memfd to standard SEV VMs?
> > > NA. They don't have to be same vm type as per my understanding from t=
he
> > > selftest code.
> > >>>           ret =3D -EINVAL;
> > >>>           goto e_unlock;
> > >> [Severity: High]
> > >> This is a pre-existing issue, but I noticed another detail in
> > >> sev_vm_copy_enc_context_from() just below this diff.
> > >>
> > >> The initialization block for the mirror VM omits copying vmsa_featur=
es:
> > >>
> > >> arch/x86/kvm/svm/sev.c:sev_vm_copy_enc_context_from() {
> > >>      ...
> > >>      mirror_sev->enc_context_owner =3D source_kvm;
> > >>      mirror_sev->active =3D true;
> > >>      mirror_sev->asid =3D source_sev->asid;
> > >>      mirror_sev->fd =3D source_sev->fd;
> > >>      mirror_sev->es_active =3D source_sev->es_active;
> > >>      mirror_sev->need_init =3D false;
> > >>      mirror_sev->handle =3D source_sev->handle;
> > >>      ...
> > >> }
> > >>
> > >> This omits mirror_sev->vmsa_features =3D source_sev->vmsa_features.
> > >>
> > >> Since SEV-ES VMs use vmsa_features to track capabilities like
> > >> SVM_SEV_FEAT_DEBUG_SWAP, would a mirrored SEV-ES VM incorrectly
> > >> initialize its vmsa_features to 0? When vCPUs are instantiated,
> > >> sev_es_init_vmcb() checks sev_vcpu_has_debug_swap(), which would eva=
luate
> > >> to false, resulting in misconfigured VMCB intercepts. Could this sil=
ently
> > >> drop important execution features for SEV-ES mirrors?
> > >
> > > As per my understanding, that is intentional as well.
> > > Is it common to mirror SEV VMs with SVM_SEV_FEAT_DEBUG_SWAP enabled ?
> > >
> > > @tom: Please let me know if any of the above statements are not true.
> > >
> > >
> >
> >
