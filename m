Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A773E3CF02B
	for <kvm@vger.kernel.org>; Mon, 20 Apr 2026 20:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776716193; cv=pass; b=ROjXR96Fwfz/G3oheRNaxy5tzOvLJG4JLXnN4J46O/tI8wlOMQgBRBLkxk/tar4X5Nme/d9zor3fpbobIVBzOJq4jc+6ciTsoBu352+5SswgypEmAQuo2JMzTBFjKOODFqn1TpiQaULv1j/DIFwoMchkE5wSQ5pdqwM8xofG+O8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776716193; c=relaxed/simple;
	bh=T2CbOfZfcHTYTTfWTmb6AIcYZZvXGVpPVSpTlqZSmuA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kxE3lZr3qIVwP/DMFx808w2SZHa1umTmbWp5IztYD0tY4XcEwRopy/IMsYmoj2o7v12N9wcYCwbyO2lwGBlhqPjG+O/EeRIW7SHt/ibxK6IhHM7lHykmTd/SsW0/bEzntgvl2Ea4AHyS/wJ+ji72s3V7FNkZCgxXf9Juk9p30Ys=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=A0kz6ZdF; arc=pass smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A0kz6ZdF"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-38e7d983f79so27413621fa.0
        for <kvm@vger.kernel.org>; Mon, 20 Apr 2026 13:16:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776716189; cv=none;
        d=google.com; s=arc-20240605;
        b=WFq/6xy8QLRCvQ2jsnyRhORIU9AlSm/HWFicIKS9K+KzELAoPm0Sg7hgc/lcNOBtna
         jXOd7MzmjRkmYakcR2p98+0wnOUKmgikvDG7mV3JMzbmmAAm1oIN/I8ONVfupgeItqrC
         N61yAk3Y17UqTvNjT9nKQ2EEO2270tEBz8MntLlBqMFRdZe16HMpSO7PvBxDuE0tbJKI
         UbtbW9YMqHUfEcUdN3MGBR+w/4UI4g01A0kC5QKE9qIoJd+wOeUWciGz7Ys88/4HgZAO
         /HTrP71sY6byjMi+HqepYsT2SKMFVqjQ86AIQ0/+ZyUD7iaKE3lPpP0/W0b+vapKkRio
         Wmdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uT/kFgtDJcz1r8Wwv13r6DbOoiLv2w0cC+Hfy6lE6eQ=;
        fh=KMuKahfpBTmx1d8uJ+dX8lr+Lk+UkKGZCYHghg3xrfE=;
        b=U9gDfOZrHsessHpMa3bPhAm/2/eUTvUD+U14TCw0V8ZKgTAiE3qeIhBwzA6hj4wcFU
         KXhPhD5hDMNUJt4LNH1nmTO/dPF0HweTM5vl4d0A1q/itQZaO3xwZYgMAg9Fy9xCfGZa
         d888OxCc+OrV1rKigwHdfXW/VIoabPFknoplvrd5AiSde9i+pRC6g/d1nlWR7gVYavmK
         Ccp59IDzGTGNIZHF/BzahsNbA09ohe9+JgqcPZNLgdpsc8iow00XOc58huNDUfLvweAv
         9zvYOc4pdgL3stkLnM7gO6guH1Vq7MZVQ0cIu51pX8HC4oBE0iBgSACJrK/JvAU8Mx9c
         n0vQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776716189; x=1777320989; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uT/kFgtDJcz1r8Wwv13r6DbOoiLv2w0cC+Hfy6lE6eQ=;
        b=A0kz6ZdFpUXcd8IqmoJYz51+uPaLogT2P6K49MbG2w96mfbJC77PkRjEAb6G/Ryvjt
         x3uvkwSq+mLYc9HSGrii1BlGbFAYGdz52TktuUnxCx4CN/72VOeRHwRs+n99i4SDNLup
         rwxcQPnf1+nwJ/RxITJzu5Gixk6/9YO7Lm+qZpLP3lVloG8H4ooKFW9AdOd2x/fFtwVe
         w2uAfH163m5piwAHuBnqcicePOWbeNb1lNawaAMC1eEE3c1k5Zbx0JjMzzcubFNodQKK
         IgtmdiE/tSLWgxYB86eh6EukVHRPQFz8QkcBquVj06y01E5vgZsmkS7+k4CAPR29pc/S
         XGkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776716189; x=1777320989;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uT/kFgtDJcz1r8Wwv13r6DbOoiLv2w0cC+Hfy6lE6eQ=;
        b=dg8q9co03tBHRZtP2LUzy4FDCFAJuYuyCv5X/eb/UN0HIxfdyPoj+4pZe3GGfYBiIZ
         I93tDE1ZebR59sBhVpZSpshdEPSP/cuOmXP860/yFlC+UucIWX1S3e5r9DV7EQi1AjiG
         AK8xo4x1dqFWDUljbDjmV3YmP/YSIsu/Vt/jDEfMQBVLei9x5QgHKf+Ye6QOHeFrLsg+
         YesN8MCor3Nh+iv6ToKsOYjhZaCFcDMqxXhFqNAubKH8+4E6+55OvRu156DIOtSO0dZt
         RSA4aecztDtFJDSpK6htII668c2X3qkCs3PcLdQp1PSQmfuI5s3KTmCgb7/QlTRDa1BW
         WWHA==
X-Forwarded-Encrypted: i=1; AFNElJ9787RazyLpqtfn1al8Jj7gwM8YFeB/0yjfSnAH/FM9E/PZ47DvTJSqz7rDiDJST4wTOcc=@vger.kernel.org
X-Gm-Message-State: AOJu0YydwfEaTEPCe0CQSaXBXN8J0p0LSmDXH8KFFgscpRKL++kRlNwK
	l63/8n16NnaedeJAa9qhvBYoY8RIcWnNMZF5f8Eq58BKnlJvmsrjoYJC0cmmzymSuLhbKY7KJK4
	2EMSsy91rNVrGn9F/jU/IJqEb9na0IStn2zh4cC6j
X-Gm-Gg: AeBDievOrH/hfRFr9PbFN02Zg4oVz0zsCJpUXDaJ5wrG2tGMIxwMaoeb3iDDcmTNeuK
	zxKaQ1OMRiqwsjzqmYLZlnMU1I0nA+FxWgclkZtA2AiNCm9VzHJEM6t7EzPE45uSz2ciNGawTR/
	Jz2wXuV3nyMKqWlRLPU4glbaHilmqik2/onoDyFkKfibIo6HZtE+U7FB8C8LiMBrDAm5NeEv1bL
	6Y5KL0NT9h5+HysSu2cS8KjMNy+RRStCT3ySBbJKoiWQ3Oey8E5PEndzg+K7u8Rt1q8WmkAEt8t
	Lse/o+4bC23xUd0nK5xImw96OEt3tX4aQ8A7mQRQ
X-Received: by 2002:a05:651c:400e:b0:38e:76c2:dc8f with SMTP id
 38308e7fff4ca-38ec7ae0487mr32714001fa.25.1776716188389; Mon, 20 Apr 2026
 13:16:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260220004223.4168331-1-dmatlack@google.com> <20260220004223.4168331-2-dmatlack@google.com>
 <aeaHPYwzs0dhwX9-@google.com>
In-Reply-To: <aeaHPYwzs0dhwX9-@google.com>
From: David Matlack <dmatlack@google.com>
Date: Mon, 20 Apr 2026 13:15:59 -0700
X-Gm-Features: AQROBzA7QaU-uTclKNPqPjm7N83BGZYqy9MhPcyoyTd2bRZSTk_SV3WPxct_hj8
Message-ID: <CALzav=dvNr2s3UzDKPyxS3JUcaWykKNvYPJUW+8g21DA9SzJLw@mail.gmail.com>
Subject: Re: [PATCH v2 01/10] KVM: selftests: Use gva_t instead of vm_vaddr_t
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Ackerley Tng <ackerleytng@google.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
	Andrew Jones <ajones@ventanamicro.com>, Anup Patel <anup@brainfault.org>, 
	Atish Patra <atish.patra@linux.dev>, Bibo Mao <maobibo@loongson.cn>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, 
	Colin Ian King <colin.i.king@gmail.com>, David Hildenbrand <david@kernel.org>, Fuad Tabba <tabba@google.com>, 
	Huacai Chen <chenhuacai@kernel.org>, James Houghton <jthoughton@google.com>, 
	Janosch Frank <frankja@linux.ibm.com>, Joey Gouly <joey.gouly@arm.com>, kvmarm@lists.linux.dev, 
	kvm-riscv@lists.infradead.org, kvm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org, 
	Lisa Wang <wyihan@google.com>, loongarch@lists.linux.dev, 
	Marc Zyngier <maz@kernel.org>, Maxim Levitsky <mlevitsk@redhat.com>, Nutty Liu <nutty.liu@hotmail.com>, 
	Oliver Upton <oupton@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <pjw@kernel.org>, 
	"Pratik R. Sampat" <prsampat@amd.com>, Rahul Kumar <rk0006818@gmail.com>, Shuah Khan <shuah@kernel.org>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Tianrui Zhao <zhaotianrui@loongson.cn>, 
	Wu Fei <wu.fei9@sanechips.com.cn>, Yosry Ahmed <yosry.ahmed@linux.dev>, 
	Zenghui Yu <yuzenghui@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 20, 2026 at 1:06=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
>
> On Fri, Feb 20, 2026, David Matlack wrote:
> > Replace all occurrences of vm_vaddr_t with gva_t to align with KVM code
> > and with the conversion helpers (e.g. addr_gva2hva()). Also replace
> > vm_vaddr in function names with gva to align with the new type name.
>
> ...
>
> > @@ -716,22 +716,22 @@ void vm_mem_region_move(struct kvm_vm *vm, uint32=
_t slot, uint64_t new_gpa);
> >  void vm_mem_region_delete(struct kvm_vm *vm, uint32_t slot);
> >  struct kvm_vcpu *__vm_vcpu_add(struct kvm_vm *vm, uint32_t vcpu_id);
> >  void vm_populate_vaddr_bitmap(struct kvm_vm *vm);
> > -vm_vaddr_t vm_vaddr_unused_gap(struct kvm_vm *vm, size_t sz, vm_vaddr_=
t vaddr_min);
> > -vm_vaddr_t vm_vaddr_alloc(struct kvm_vm *vm, size_t sz, vm_vaddr_t vad=
dr_min);
> > -vm_vaddr_t __vm_vaddr_alloc(struct kvm_vm *vm, size_t sz, vm_vaddr_t v=
addr_min,
> > -                         enum kvm_mem_region_type type);
> > -vm_vaddr_t vm_vaddr_alloc_shared(struct kvm_vm *vm, size_t sz,
> > -                              vm_vaddr_t vaddr_min,
> > -                              enum kvm_mem_region_type type);
> > -vm_vaddr_t vm_vaddr_alloc_pages(struct kvm_vm *vm, int nr_pages);
> > -vm_vaddr_t __vm_vaddr_alloc_page(struct kvm_vm *vm,
> > -                              enum kvm_mem_region_type type);
> > -vm_vaddr_t vm_vaddr_alloc_page(struct kvm_vm *vm);
> > +gva_t gva_unused_gap(struct kvm_vm *vm, size_t sz, gva_t vaddr_min);
> > +gva_t gva_alloc(struct kvm_vm *vm, size_t sz, gva_t vaddr_min);
> > +gva_t __gva_alloc(struct kvm_vm *vm, size_t sz, gva_t vaddr_min,
> > +               enum kvm_mem_region_type type);
> > +gva_t gva_alloc_shared(struct kvm_vm *vm, size_t sz,
> > +                    gva_t vaddr_min,
> > +                    enum kvm_mem_region_type type);
> > +gva_t gva_alloc_pages(struct kvm_vm *vm, int nr_pages);
> > +gva_t __gva_alloc_page(struct kvm_vm *vm,
> > +                    enum kvm_mem_region_type type);
> > +gva_t gva_alloc_page(struct kvm_vm *vm);
>
> The existing vm_vaddr_alloc() and friends are pretty bad names.  gva_allo=
c() is
> far, far worse.  The APIs aren't just allocation a guest virtual address,=
 they're
> allocating guest physical memory, finding a usable virtual address, and c=
reating
> mappings.
>
> I don't see any reason to have vaddr or gva in the name.  E.g. malloc() i=
sn't
> virt_malloc().  But I do think they need to be explicitly scoped to KVM, =
and to
> a VM.  I'll drop API renames from this patch, and rename them to vm_alloc=
() and
> friends in a separate patch.  Amusingly, that naming scheme will still wo=
rk if
> "vm" is misconstrued as "virtual memory" instead of "virtual machine".

Sounds good to me.

> P.S. This is a great example of why I insist on one logical change per pa=
tch, with
> judicious exemptions for opportunistic cleanups/changes.  If this has bee=
n a
> separate patch, it would have taken me all of two seconds to unwind.  As =
it was,
> I spent a good 10-15 minutes dealing with this.  In large part because I =
kept
> making goofs, but that's the whole point: there was no reason to put me i=
n a
> position to make goofs.
>
> The other argument against these sorts of "Also do xyz" add-ons is that o=
f a
> slippery slope.  Why rename these APIs in this patch, but not the myriad =
vaddr
> variables?  Then after a few "I'll just clean this up too" changes, there=
's an
> entire series in what is purportedly just a typedef rename.

You're right, the API rename should have been split off into its own patch.
Thanks for the guidance!
