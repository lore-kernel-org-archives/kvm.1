Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD566258CD0
	for <kvm@vger.kernel.org>; Wed, 13 May 2026 13:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778680337; cv=none; b=Dyqz/R68FLr7zyXWLFZQwly9g1QjbtKSeupc0na2afMqOe5pXgtydWin9/gWwu8gv8tPnYBV313LdWgM6+frfm3eJBgNaw1igrIAsTvAl8OfuvA3sdSALJeK2wmGfb2R7jfHjR/XaRE+ReNxQNBLhad8V38Ku5Pc58JxxJSGEkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778680337; c=relaxed/simple;
	bh=X+zQTAkwFG4eQIJ2OFu3Tfmpd6S4Es/WmHvgusJTuik=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GSoVlMpCOirjb8KoBBSFey0jg+rA874a6tAdxFG9ql6DYqr6oRQufrrN5aI+6m+noECgTaUWLOPVdoLbrHceDKYarZGH+MJZe0KASv7uChIPFUIIY7ajBrNDyJOUYjVtX3FdlEryHXE/WYoISvgh7lq3Unp5LjTyIz8yOiO9C/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DJmDRP3q; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DJmDRP3q"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c8271fb43d0so2589519a12.1
        for <kvm@vger.kernel.org>; Wed, 13 May 2026 06:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778680335; x=1779285135; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fZ26r4X5jfVq6A2+/ceMGSKMXoCrvOMhrTX7zo3uG2I=;
        b=DJmDRP3qAD2ILfYO1Oe8/nhiuz4Ktfc2zFNt/ARVMzHA5Wm1yv06gGo+3QUZmjIooC
         6p1dG+DolG4/7XKVkyDZ1kpPHHOmOwbJG/8NmS4LlZ6n5XoMyeP++J8rQBpSj+ZBpFlg
         TEupzbkgF7HM6LLfk9E7K4W43zlXi0NiSjSerzetNSq7RTWw86NHUmuro71Ud4t/cB8y
         ipH/acIYwJam2W0lSrEMVBu37nese8cJVOnkQ6w+yZwRmB0WsTtVHT8TPMFRsdQswDc6
         FBYd4vgUM2B88lvDaGVELETfLnOdfz4BC3GSELDd49+c1lap6u571rmUKnSZfCuP+wW4
         6mJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778680335; x=1779285135;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fZ26r4X5jfVq6A2+/ceMGSKMXoCrvOMhrTX7zo3uG2I=;
        b=Jq2b/TXsIrIi8ONfxe3j3qqVwhexPSmbXsnoS9vayZyM6ZTgP16A7eTAdLfmWY7kjM
         GUTGzdXEsoGQUoqF/IO7FIgbeGFyx0bzJ4sNHZ2dq4yCZS/TfP2f+E0jM5ZewZex10OG
         uEIVuOisCsPkQgcJLMZdpKFLAWBeMwZRaUiYdYnPmC09/PL1H/CcojIOe53Qfa03UYN5
         RVZI+drW5ZOCvdaNY/NvJhGQrzcObzT/TySxBMbx4MdQj6dediKM0uVySPwzmm6gYZ6w
         yTDuROpUFA12jh+MFeQyJHdYDWAzjo1zeOkM4bVJB/dQrUNKDpX6+x1ArUKr3isu2Z+T
         nqbw==
X-Forwarded-Encrypted: i=1; AFNElJ8h3QhhvaatQsfxk5LzZAkS18P9LYE9cBQ0C9TquUDNFiLZjK97YTaahpJindKSvGRVpB0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOEj+2VdEx7jaFkigmN/obXnEuEHMiljW5xUsyg34Bd1SDMcB5
	Ww1DUvQo302SYuUxAvWs8D27YVjTQq05YsxuJZIzN2QpU0VVeSIjfn+HNy1i43XPlg6VPvExvle
	d64/p0Q==
X-Received: from pfbly26.prod.google.com ([2002:a05:6a00:759a:b0:82f:a4cc:2fb3])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2e90:b0:835:5557:31fa
 with SMTP id d2e1a72fcca58-83f042ff9afmr3568898b3a.46.1778680334716; Wed, 13
 May 2026 06:52:14 -0700 (PDT)
Date: Wed, 13 May 2026 06:52:14 -0700
In-Reply-To: <1a5a115e-3bf3-e2bf-475a-b49f5b6e308f@loongson.cn>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260508015013.4108345-1-maobibo@loongson.cn> <agO6oLqQYQG14x6D@google.com>
 <1a5a115e-3bf3-e2bf-475a-b49f5b6e308f@loongson.cn>
Message-ID: <agSCDrazxEvStSuI@google.com>
Subject: Re: [PATCH] KVM: selftests: Check guest memfd validity with flags
From: Sean Christopherson <seanjc@google.com>
To: Bibo Mao <maobibo@loongson.cn>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Oliver Upton <oupton@kernel.org>, 
	Marc Zyngier <maz@kernel.org>, kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Fuad Tabba <tabba@google.com>, 
	Ackerley Tng <ackerleytng@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

+Ackerley and Fuad

On Wed, May 13, 2026, Bibo Mao wrote:
> On 2026/5/13 =E4=B8=8A=E5=8D=887:41, Sean Christopherson wrote:
> > On Fri, May 08, 2026, Bibo Mao wrote:
> > > The type of guest_memfd in structure kvm_userspace_memory_region2
> > > is __u32, it is not correct to assign it with -1 and check whether
> > > it is smaller than 0. Here check flags with KVM_MEM_GUEST_MEMFD
> > > set.
> > >=20
> > > Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> > > ---
> > >   tools/testing/selftests/kvm/lib/kvm_util.c | 4 +---
> > >   1 file changed, 1 insertion(+), 3 deletions(-)
> > >=20
> > > diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testi=
ng/selftests/kvm/lib/kvm_util.c
> > > index 2a76eca7029d..9d3553f7e6a5 100644
> > > --- a/tools/testing/selftests/kvm/lib/kvm_util.c
> > > +++ b/tools/testing/selftests/kvm/lib/kvm_util.c
> > > @@ -817,7 +817,7 @@ static void __vm_mem_region_delete(struct kvm_vm =
*vm,
> > >   		kvm_munmap(region->mmap_alias, region->mmap_size);
> > >   		close(region->fd);
> > >   	}
> > > -	if (region->region.guest_memfd >=3D 0)
> > > +	if (region->region.flags & KVM_MEM_GUEST_MEMFD)
> >=20
> > Hmm, it's a bit gross, but this is probably more robust?
> >=20
> > 	if ((int)region->region.guest_memfd < 0)
> yes, this is more direct, only that some guys in the community do not lik=
e
> type conversion. Both are ok for me.
>=20
> >=20
> > E.g. if we somehow end up in a state where KVM_MEM_GUEST_MEMFD is eithe=
r stale
> > or the guest_memfd file was already closed.  I highly doubt either of t=
hose things
> > will happen, but logically it's the correct fix (the only reason guest_=
memfd is
> > a u32 is being it's part of the kernel's uAPI).
> Actually it probably will happen, how about something like this:
> -       if (region->region.guest_memfd >=3D 0)
> +       if ((int)region->region.guest_memfd >=3D 0) {

LOL, doh.  Yeah, that's what I meant.

>                 close(region->region.guest_memfd);
> +               region->region.guest_memfd =3D -1;

It's funny how these sorts of things seem to come in bunches.  Can you hold=
 off
on this specific change, and just send a v2 for the fix?  Invalidating gues=
t_memfd
isn't at all necessary here, because region itself is freed shortly thereaf=
ter.

But, Ackerley and Fuad want give kvm_vm_release() the same treatment[*], at=
 which
point there's no good reason not to be paranoid.  I want to do that in a de=
dicated
patch though, and harden "everything" in one shot.  I'll send something lik=
e the
below.

[*] https://lore.kernel.org/all/20260511113759.610924-3-tabba@google.com

diff --git tools/testing/selftests/kvm/lib/kvm_util.c tools/testing/selftes=
ts/kvm/lib/kvm_util.c
index 2a76eca7029d..2476167252a1 100644
--- tools/testing/selftests/kvm/lib/kvm_util.c
+++ tools/testing/selftests/kvm/lib/kvm_util.c
@@ -737,6 +737,12 @@ userspace_mem_region_find(struct kvm_vm *vm, u64 start=
, u64 end)
        return NULL;
 }
=20
+static void kvm_free_fd(int *fd)
+{
+       kvm_close(*fd);
+       *fd =3D -1;
+}
+
 static void kvm_stats_release(struct kvm_binary_stats *stats)
 {
        if (stats->fd < 0)
@@ -747,8 +753,7 @@ static void kvm_stats_release(struct kvm_binary_stats *=
stats)
                stats->desc =3D NULL;
        }
=20
-       kvm_close(stats->fd);
-       stats->fd =3D -1;
+       kvm_free_fd(&stats->fd);
 }
=20
 __weak void vcpu_arch_free(struct kvm_vcpu *vcpu)
@@ -777,7 +782,7 @@ static void vm_vcpu_rm(struct kvm_vm *vm, struct kvm_vc=
pu *vcpu)
=20
        kvm_munmap(vcpu->run, vcpu_mmap_sz());
=20
-       kvm_close(vcpu->fd);
+       kvm_free_fd(&vcpu->fd);
        kvm_stats_release(&vcpu->stats);
=20
        list_del(&vcpu->list);
@@ -793,8 +798,8 @@ void kvm_vm_release(struct kvm_vm *vmp)
        list_for_each_entry_safe(vcpu, tmp, &vmp->vcpus, list)
                vm_vcpu_rm(vmp, vcpu);
=20
-       kvm_close(vmp->fd);
-       kvm_close(vmp->kvm_fd);
+       kvm_free_fd(&vmp->fd);
+       kvm_free_fd(&vmp->kvm_fd);
=20
        /* Free cached stats metadata and close FD */
        kvm_stats_release(&vmp->stats);
@@ -815,10 +820,10 @@ static void __vm_mem_region_delete(struct kvm_vm *vm,
        if (region->fd >=3D 0) {
                /* There's an extra map when using shared memory. */
                kvm_munmap(region->mmap_alias, region->mmap_size);
-               close(region->fd);
+               kvm_free_fd(&region->fd);
        }
        if (region->region.guest_memfd >=3D 0)
-               close(region->region.guest_memfd);
+               kvm_free_fd((int *)&region->region.guest_memfd);
=20
        free(region);
 }
