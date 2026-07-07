Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 355444229D6
	for <kvm@vger.kernel.org>; Tue,  7 Jul 2026 13:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783432796; cv=none; b=O4tlVnXpLxJq/CKP9slNqt1gtecQiQ9eWlOTOy+v7+OrwDtQ4OvyBB9Nzl/BbiUdMTYmcK7l9E73Y20rV/hrOPr4UuHC8ecUNcpLxEGU7MCGVxHRFvE/jqEB6rVdOlieIt5gfe5Gg+U80fG6EDgtQLNDpZuPWLh8oYQL/tzcJOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783432796; c=relaxed/simple;
	bh=r+U6GOBTclrk2GAfMDDK3Y2wUrSOEY1HSZQPVt89F+s=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bl9LQXa3C7tsqTqifbW5BrnO89qbag5g7RyTWcyS6eBMo+muD3jlXju4mBB6X2Sb+yJTOl+e3lLqRAFlxgrswEWg0rVLzqGZbb4p4tAtYyke7n7rJuuChz/xq3GSvFi6H/ErSdr/2yS4XTJXr1n2Le2nOL0oxat0G9FlOreLvAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PKdp5nFF; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PKdp5nFF"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2cca3673560so35010015ad.1
        for <kvm@vger.kernel.org>; Tue, 07 Jul 2026 06:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783432794; x=1784037594; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+JjqhSCb2NqJ7vFBkKx2UXo9ZmgrCLkW3PMFAuA5hNM=;
        b=PKdp5nFF1gEEjq+zm1aTP/EznVvNzNDf4NkDiklb1bxA/lYEqU3MpljHYhr87igzVq
         DvGwjPSyeS65qq7RQnENHd81UcmLD/40CPynFPjVYfiIbq9GSE5FxfOBLBJOaA3frKQ8
         Womrg8klQG968vAGemVS5NRH7QmzBcUbq1gmFv/AHFRfR0rTfMyDKzI3NFaTadsFx74N
         tKxnVS+CpC8Y7EmOqO/E5Ci2JvR55uzUFhGmq+37V3IAwfRgkJYgstxDJzIW0DaXdH0a
         IIS7//v/866jbtEiLJNSbU6skz36gF9iAhOeNICzOoEKqTwakHb0dNMx4x9pbFdG5qbj
         fvRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783432794; x=1784037594;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+JjqhSCb2NqJ7vFBkKx2UXo9ZmgrCLkW3PMFAuA5hNM=;
        b=TGr0hUNTTI57kyw+8IqeJ1GlO6j1nGWvk8/Vh6SSzrTLO2mBRpi/2fI5+K0uJRPUz5
         G56t4BLJpth8Ml6xZP29rrYx1p++fvDyfnnR+KHEs6ZgwxfvuUjimTmDsgTdyZNREd/I
         U5adGOUOpKTSkQRwTxoYnrA+JzOJEZSFpECtgEew+np8sUHb+G+uNkj332qBWp4/5GT1
         ulU2tGwsmaO1VbtgrMF2bvXAppkE9d0MMOrR7KhXhSAdZkjoH3T8Vs2ppuKuuC+MrtEz
         LU11VOvmMZPixFxm7GnSJ+wIJKN92ev/4BSaZLfKG75GEZP8xLdF+1X+ME6B4r4c6Qlx
         cLpA==
X-Forwarded-Encrypted: i=1; AHgh+RpXTfx8gFy/CM4W5Qf7kj+lObbPwAYxmLJViLpuKrtzdKpFSC3qIj2gMyKbQz+ZfvibwZk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzae5Wy47Sj1SyRDD2AMkLIFodeJbnckWEy+gL6EhzuFelJ8EH9
	bnbuqZacVRYr1GWv3P6uC+CAYHHjJJx8/8g252vN/t/9K13SJ84YIMBGtvF/02rYu/HAbzx+gyf
	lNPzndg==
X-Received: from plsh7.prod.google.com ([2002:a17:902:b947:b0:2c9:a5a0:a677])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3e44:b0:387:e0cb:c8db
 with SMTP id 98e67ed59e1d1-387e0db2f85mr2951478a91.36.1783432794394; Tue, 07
 Jul 2026 06:59:54 -0700 (PDT)
Date: Tue, 7 Jul 2026 06:59:53 -0700
In-Reply-To: <2bd89e95-9c15-4a3a-916d-0d71a92d8b02@amd.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260701144543.39582-1-pankaj.gupta@amd.com> <1cc159b9-5f94-4524-8e03-efe91601ccfc@kernel.org>
 <db303a0c-98e3-4967-9b61-ccb711b776c8@amd.com> <46f19bd8-0d43-4b0e-a8ab-0ef9d3b8bd1a@kernel.org>
 <2bd89e95-9c15-4a3a-916d-0d71a92d8b02@amd.com>
Message-ID: <ak0GWRue6-S-BQEu@google.com>
Subject: Re: [PATCH] KVM: SEV: drop FOLL_LONGTERM for encrypted region registration
From: Sean Christopherson <seanjc@google.com>
To: Pankaj Gupta <pankaj.gupta@amd.com>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>, pbonzini@redhat.com, tglx@kernel.org, 
	mingo@redhat.com, dave.hansen@linux.intel.com, bp@alien8.de, x86@kernel.org, 
	thomas.lendacky@amd.com, hpa@zytor.com, yangge1116@126.com, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	"Lorenzo Stoakes (Oracle)" <ljs@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 07, 2026, Pankaj Gupta wrote:
> > > > IIRC, fsdax cannot tolerate unbounded pins. Is that the case we are=
 running into?
> > > Host side backend is regular file backed memory (no fsdax).
> > Okay, so we'll end up mapping an ordinary file into VM memory, and expo=
se that
> > to the VM as part of virtio-pmem device.
> >=20
> > That also means that vfio etc. won't be able to longterm-pin such devic=
e memory.
> > So this is not a problem isolated to SEV.

The problem that _is_ "isolated" to SEV though, is that this used to work :=
-/

> > Forbidding to longterm pin is actually the right thing to do if the fil=
esystem
> > relies on writenotify, as spelled out by Lorenzo's commit:
> >=20
> > "
> >      Writing to file-backed mappings which require folio dirty tracking=
 using
> >      GUP is a fundamentally broken operation, as kernel write access to=
 GUP
> >      mappings do not adhere to the semantics expected by a file system.
> >=20
> >      A GUP caller uses the direct mapping to access the folio, which do=
es not
> >      cause write notify to trigger, nor does it enforce that the caller=
 marks
> >      the folio dirty.
> >=20
> >      The problem arises when, after an initial write to the folio, writ=
eback
> >      results in the folio being cleaned and then the caller, via the GU=
P
> >      interface, writes to the folio again.
> > "
> >=20
> > Hmmm
>=20
> Yes. For file based mapping we don't allow long term pinning.
>=20
> If we take into account the fragmentation concerns for MIGRATE_CMA and
> ZONE_MOVABLE allocations
>=20
> solvable with=C2=A0FOLL_LONGTERM, I can think of two options(tested) to a=
llow
> file based mappings as well:
>=20
> 1. Fallback on FOLL_WRITE when FOLL_LONGTERM fails as suggested by Sean.
>=20
> 2. Explicitly restrict long-term pinning for file-backed mappings=C2=A0wi=
th a
> change like the patch below [1].
>=20
> David, Sean,
>=20
> Do you have a preference between these two approaches? I am leaning towar=
d
> towards option 2.

Option 1.  Option 2 has a TOCTOU bug (the VMA could be changed after droppi=
ng
mmap_lock), and I'd rather not bleed any more mm/ details into KVM than is
required: falling back to a non-FOLL_LONGTERM acknowledges that there are m=
apping
types that don't support WRITE+LONGTERM, but checking vma_is_anonymous() ta=
kes
things a few steps further by forcing KVM to know what types of mappings ar=
e
problematic.

> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> index 6c6a6d663e29..c4b53700f69e 100644
> --- a/arch/x86/kvm/svm/sev.c
> +++ b/arch/x86/kvm/svm/sev.c
> @@ -2743,6 +2743,29 @@ int sev_mem_enc_ioctl(struct kvm *kvm, void __user
> *argp)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 return r;
> =C2=A0}
>=20
> +static unsigned int sev_region_gup_flags(unsigned long uaddr, unsigned l=
ong
> ulen)
> +{
> +=C2=A0 =C2=A0 =C2=A0 =C2=A0struct mm_struct *mm =3D current->mm;
> +=C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned long end =3D uaddr + ulen;
> +=C2=A0 =C2=A0 =C2=A0 =C2=A0struct vm_area_struct *vma;
> +=C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int flags =3D FOLL_WRITE | FOLL_LONG=
TERM;
> +=C2=A0 =C2=A0 =C2=A0 =C2=A0VMA_ITERATOR(vmi, mm, uaddr);
> +
> +=C2=A0 =C2=A0 =C2=A0 =C2=A0if (ulen =3D=3D 0 || end < uaddr)
> +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return FOLL_WRITE=
;
> +
> +=C2=A0 =C2=A0 =C2=A0 =C2=A0mmap_read_lock(mm);
> +=C2=A0 =C2=A0 =C2=A0 =C2=A0for_each_vma_range(vmi, vma, end) {
> +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!vma_is_anony=
mous(vma)) {
> +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0flags =3D FOLL_WRITE;
> +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0break;
> +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> +=C2=A0 =C2=A0 =C2=A0 =C2=A0}
> +=C2=A0 =C2=A0 =C2=A0 =C2=A0mmap_read_unlock(mm);
> +
> +=C2=A0 =C2=A0 =C2=A0 =C2=A0return flags;
> +}
> +
> =C2=A0int sev_mem_enc_register_region(struct kvm *kvm,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct kvm_enc_region *range)
> =C2=A0{
> @@ -2764,7 +2787,7 @@ int sev_mem_enc_register_region(struct kvm *kvm,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -ENOMEM;
>=20
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 region->pages =3D sev_pin_memory(kvm, range->=
addr, range->size,
> &region->npages,
> -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 FOLL_WRITE |=
 FOLL_LONGTERM);
> + sev_region_gup_flags(range->addr, range->size));
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (IS_ERR(region->pages)) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D PTR_ERR(r=
egion->pages);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto e_free;
> (END)
> --=20
>=20
>=20
>=20
>=20
