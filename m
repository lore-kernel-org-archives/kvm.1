Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BF39354AFC
	for <kvm@vger.kernel.org>; Mon, 16 Mar 2026 08:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773648352; cv=pass; b=NbAz4/UOklXeXOoUQthAPgbQSdYF/ZMjqlcER1BFqdHhAFV9ZdBYERTqh2gZTSfuzvffodijHbr3tt4+KcYaaynEBdjwSAnYoemCCtOcL5gFHtYHLfKZDisD/L/8LJM5Cn+P4vMlb2xa/pHCYaWkcQvDtEUEJSmwnaw9hqRACCA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773648352; c=relaxed/simple;
	bh=bdScPVnsSaD+D5rBbEd4IKRSFhQUqItHVl2QejrINfM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IaRi1Ql/PDQfXulnIze8xHuyMo/OdUu0Viuih6hbTl3XYhoWi+n08rJgi1NH2pntzW0FM6Wn/7MNDxYBVXATvZyGwG96dA0IIpWteXM6z6ntuXoDeTpmTZEr+CwZEcbOe6Z4xrIxulbMgag4GP5MGmu29Y83WWWng8YRjRiJkBs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FuSwyXkl; arc=pass smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FuSwyXkl"
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-64ca2b32f46so3172084d50.3
        for <kvm@vger.kernel.org>; Mon, 16 Mar 2026 01:05:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773648350; cv=none;
        d=google.com; s=arc-20240605;
        b=R+ESE9LQ1ElfELupyZa+i9F7nazfsbfoq6b3aRYCucqFITzaVUF2HjFFyPaU+SCH5J
         GogRCVA2Z+7JHyvAivPzsMkW44NGU/QBMaiuIpLcul7firoHajEIQWh/AVUf87PtHyvW
         qrhv1DiBAdV1PGpcGilr2KeUWu90WU3lrC9hgs9kRkw5I6vucq0a1ud/vReExS82S6fN
         f6nuNOCJwppFYIPRTrRDSrboLZ/rBAP9ZgqMx9qE3C+Z70/oUwFhjoPbrdUen2nRYJYa
         T8cQwJzHWuSsHx3EwU8BF7NB0Lj3BiZ+wpq5Yl8wna8EvldA9kdCHnvxzOt/TMzEIEbW
         SaBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ntlsUflN+hnqA9YBuYkxoTPzbyNwVTClPHMLwCnFBWc=;
        fh=/biYiczltgny/eJZ7hRAMOUJco7EhQQDgYBAyFjseX4=;
        b=c5nFANOVcyEBw3wRnyzpc0ee/2wIwLX4oIoPgfTNYb7Je6qRGPskdUdjZ/UhKJ1SCO
         twJK/f0agy4Ii55pIIlOp/vL68wtM2mtn94po/2rovXDr1V+veYdsxIUpikqDaJI0fQj
         iZks8lVtU4Ock+XByvBMh8A5vcvWtKAzwRpXJwPiQfj/lRQlqtSsLs45Zycm/9MRZisv
         y86GMxmsqj5CJfZc/+CJqDpjbNpgtyRzYCWXV2lCBPqGXmSc0OuFl6Br3+2zPQN46Mjp
         jw9GJAmViLKdzwWtN+XYtsP7uMDGc7qmzbnCbnR4lbmGV3rsBq3zKkcyy5AMB0w9y17s
         1/jg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773648350; x=1774253150; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ntlsUflN+hnqA9YBuYkxoTPzbyNwVTClPHMLwCnFBWc=;
        b=FuSwyXklUE/poytXURUHX/DPQ1FTJfK6frPQRRVIrgta/Y4hU4hwwj03fNcY/ecnU3
         jb94vHMIWfZyrkiinHkoaIbYNa+Fy/gd6imhppOgtsa+JZX0pjUv2nP6WPaWa2NWjgot
         wk+Q6yzdnsXo8xIz+hFB4epdRP6LtLlxz57aX/MKn1ZjYrt4WeX11NhLidJ0wc4VXETO
         I3ekAmw2vKA2f7H813ZcK9uOgeTnKfImab4Z8Cqu7sqzyaSgNCKmteIYBCS3CFC6xMpW
         GWg40cQ1fm7wXAtKy4suZFX08HbRTvIaojdJ8ikAtoDE3pIAE5mhOZap4tvtkSUtqBMO
         oCGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773648350; x=1774253150;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ntlsUflN+hnqA9YBuYkxoTPzbyNwVTClPHMLwCnFBWc=;
        b=qU0/tL+ZlCVh8kO0xy13Wpm0mYtNXWuvDZl6hVsqK9LBSiuYF9WzHxSAeAqkOJ34X9
         j7w1+k66FBSIyHO/kd26uzSr+38OfQk49oLeHlmckf37DN+WNQtaQ4wTcPhqhzuEok2z
         JM9n8th+bToDO+nveGF4FpDkgbHaadgRhwHZ/MEg7/JlhkOujrUPs6H7CD0y5kQwSDHJ
         CYxwLD82n1/7FWXODw0+eFOe4nUYrKTlhh3879mTMqfEwaqg6f1xeIwEQccMQvNPhs+Z
         1t0BYWQ+FpgCyQiNsrWqj1PNfgkzTAFi5jBGF89xxJqNcxDhBOuIMHkWaBndd8HSBGJC
         +N/w==
X-Forwarded-Encrypted: i=1; AJvYcCVpiy7Eku6YQytaUmYASw7YEv0z/x95CTMv+2Af8BzgRMdN3xWYHheLZ+Z2lmUJ1Wbsb2k=@vger.kernel.org
X-Gm-Message-State: AOJu0YymthQlg3QzNlmfIq5kVzS1MDh1dpKYnnnjyF5adrMtJRvW91pv
	drWoSEK64FwakwbtoCW+9YlBve1peLIZ+q8OzpHRSaEoFbIsRllhkSwk+LR3qGe1/hlIoy/WDXR
	k/Hj0oYZ8b9qQELBGYhXtUqwobPMJZLw=
X-Gm-Gg: ATEYQzzskrP6dz+fqA+zm60A87cheLl729UFdYaNNaxbOYxhoWkyP0IzC00hcT6J14P
	88rH4U/XoqalQkjM7fW9IypOCmWYpGNXtfiaCjnuDBymjpAaQQQr36nscCNvWujhT4MXk0KpoS+
	c+iNSSKO5rORUjhuyTx3nFLuyNWAIZOvHZM/NUHDcYLidE1ehi/9wcDGQPKUSj6k1vrxThq24K6
	4MZJq6UWqXZdONP0HvDy1uScb5evtTGdpiEOO1/EB2q3tMxthEBReR5Vz8pons5IyB1u3G1Tou+
	S8reYlmVsQm6LkbXZ/5uo2fKX1WLcJlm398W0nXphRzmJ4YT3LTe1vyk8f5M4gyQCP0J9Qyg
X-Received: by 2002:a05:690c:c50f:b0:79a:3cea:9153 with SMTP id
 00721157ae682-79a3cea9472mr55394387b3.13.1773648350077; Mon, 16 Mar 2026
 01:05:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260306171815.3160826-5-rppt@kernel.org> <abe1FHyYinvfLYnw@hyeyoo>
 <abe15T7cA1B9lG4F@hyeyoo>
In-Reply-To: <abe15T7cA1B9lG4F@hyeyoo>
From: Deepanshu Kartikey <kartikey406@gmail.com>
Date: Mon, 16 Mar 2026 13:35:38 +0530
X-Gm-Features: AaiRm53AvxoTI5kbBO9SnbBGaJXcRPFivylwR41z7fGjYuzu7XmFh4zaFD0j-wk
Message-ID: <CADhLXY5ydBZL5gUQZCJnSTgc=8U0Xhaj_BtvgdBtPSmWh3NTEA@mail.gmail.com>
Subject: Re: [PATCH v2 4/15] userfaultfd: introduce mfill_get_vma() and mfill_put_vma()
To: Harry Yoo <harry.yoo@oracle.com>
Cc: "Mike Rapoport (Microsoft)" <rppt@kernel.org>, Andrea Arcangeli <aarcange@redhat.com>, 
	Axel Rasmussen <axelrasmussen@google.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	David Hildenbrand <david@kernel.org>, Hugh Dickins <hughd@google.com>, 
	James Houghton <jthoughton@google.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Michal Hocko <mhocko@suse.com>, 
	Muchun Song <muchun.song@linux.dev>, Nikita Kalyazin <kalyazin@amazon.com>, 
	Oscar Salvador <osalvador@suse.de>, Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>, 
	Sean Christopherson <seanjc@google.com>, Shuah Khan <shuah@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>, Edward Adam Davis <eadavis@qq.com>, 
	kvm@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 16, 2026 at 1:19=E2=80=AFPM Harry Yoo <harry.yoo@oracle.com> wr=
ote:
>
> > It seems there's another attempt to fix the syzbot report from
> > Deepanshu Kartikey [2], which I didn't take a deeper look.
> >
> > At first look [2] looks a bit wrong way to fix to me though,
> > because it allows operating only on a single VMA nothing should really =
split
> > or shrink the VMA if somebody is holding the VMA lock in read mode
> > (and the validation of the range is done while holding the lock).
> >
> > [2] https://lore.kernel.org/linux-mm/20260316070039.549506-1-kartikey40=
6@gmail.com
> >

Harry,

You are correct that once vm_refcnt > 0, nobody can split the VMA.
However the split can happen in the race window BEFORE vm_refcnt++
in vma_start_read(), and CHECK 2 can miss this if mmap_write_unlock()
completes before CHECK 2 runs.

Here is the exact race:

vma_start_read():

    /* CHECK 1 */
    if (READ_ONCE(vma->vm_lock_seq) =3D=3D READ_ONCE(mm->mm_lock_seq.sequen=
ce))
        goto err;

    /*
     * RACE WINDOW: vm_refcnt is still 0 here!
     * UFFDIO_UNREGISTER can run:
     *
     *   mmap_write_lock()    -> mm_lock_seq =3D 11
     *   vma_start_write(vma) -> vm_lock_seq =3D 11
     *   __split_vma()        -> vma->vm_end =3D 0x4ca000
     *   mmap_write_unlock()  -> mm_lock_seq =3D 12
     *
     * writer completes entirely before vm_refcnt++!
     */

    __refcount_inc_not_zero_limited_acquire(&vma->vm_refcnt, ...);
    /* vm_refcnt =3D 1 now, but vma->vm_end already modified! */

    /* CHECK 2 */
    if (unlikely(vma->vm_lock_seq =3D=3D raw_read_seqcount(&mm->mm_lock_seq=
)))
    /*
     * vm_lock_seq(11) =3D=3D mm_lock_seq(12)?
     * NO! writer already finished and unlocked!
     * mm_lock_seq incremented to 12 (even=3Dunlocked)
     * CHECK 2 MISSES the race!
     */

    return vma;
    /*
     * returns split vma with vm_end=3D0x4ca000
     * but vm_refcnt=3D1 (lock held)
     */

Now mfill_atomic loop runs with split vma:

    while (state.src_addr < src_start + len) {

        /* iteration 1 to N: dst_addr =3D 0x1b1000 to 0x4c9000
         * all within vma->vm_end(0x4ca000)
         */

        /* iteration N+1: dst_addr =3D 0x4ca000 */
        err =3D mfill_atomic_pte(&state);
            mfill_atomic_install_pte(state->vma, dst_addr=3D0x4ca000)
                folio_add_new_anon_rmap(vma, 0x4ca000)
                    VM_WARN_ON_ONCE(address < vma->vm_start ||
                        address + (nr << 12) > vma->vm_end);
                    /* 0x4ca000 >=3D vma->vm_end(0x4ca000) -> WARN! */
    }

Without my fix:
    CRASH at folio_add_new_anon_rmap

With my fix:
    if (state.dst_addr < state.vma->vm_start ||
        state.dst_addr >=3D state.vma->vm_end) {
            mfill_put_vma(&state);
            state.dst_start =3D state.dst_addr;
            state.len =3D dst_start + len - state.dst_addr;
            err =3D mfill_get_vma(&state);
            if (err)
                break;
    }
    /* catches split, re-lookups correct VMA safely */

So both fixes are needed:

Harry's fix (state.len):
    fixes state.len uninitialized
    mfill_get_vma validates correct range
    in the first call before loop

My fix (bounds check):
    catches split VMA that slipped
    through CHECK 2 during loop
    because writer finished before
    CHECK 2 ran
