Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0CAD72602
	for <kvm@vger.kernel.org>; Mon, 28 Sep 2026 13:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790602231; cv=none; b=FQQxgMBmgyjyVSnXc6qUIfQLAySM7dbDXcFpysShri+0u8/xXB7JHlH8vcbRNsL1vpwE1MD0I4cvonfWTRbi9iK2mD0kpbHqS7pLa8dv4WDKFDtGz+b5bh+plHok5+H3RdHiIzxuOZqvQBDfnDlooHu32Qo2LXaRE3aKw9RI21E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790602231; c=relaxed/simple;
	bh=u4F+lc3vx+jYByWGzH3MQLi5+iszxVz9Dw6kvDqbkF0=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-version:Content-type; b=OHpLAM/s12ixmYV5mWkrJQPpPxXlYcMTEA68HpMWC4JgH2oXbIJILl1swt3IsK9/7AvFxyColneclAQforH49Ji+QCF5uY6nr2bMQYQ0/pthMMaAyQ9PMhCHLclM1bAK+yKzXFqGsA9/883fASzmNxFQp0xoR0MLqTCB68h2aLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OmSc98IM; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OmSc98IM"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-93a40a9a01aso395799285a.0
        for <kvm@vger.kernel.org>; Mon, 28 Sep 2026 06:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790602228; x=1791207028; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :message-id:date:in-reply-to:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Xh2NHRfJCMfylFQd8bfgqsz1kSEX8TvOZMy0ZzkkjyY=;
        b=OmSc98IMwTbS851H3loPXr1beBPQHd2EwqQ8sBka8n1OHuCh+qyUyBI2Hw8n3PeT6Y
         sORdU5JZQVHSa3kn26OeLxd9Bnvs0h39MlNU6i1E1/GG+ywQePYTu8ltW1V0YpPj6Ri8
         9/mDUkB1OfQlzdameZRWPMcBIRazT41OM50kU8xnpbOfrGlJLARBwKXGXAakJur+y/ei
         vTSdBUxbsfY1cjkeylXAhM38fulz1EVLf1EWBDEmsfaOgaNbARnN8pkjJdb6uhKLGqMd
         K/t+E6Tb3LPMnZWpup8izZN2yMfrM+Htq+QMvwTaFK+s3hEOxigM0IIH7r7ZeLjJtorU
         rDtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790602228; x=1791207028;
        h=content-transfer-encoding:content-type:mime-version:references
         :message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Xh2NHRfJCMfylFQd8bfgqsz1kSEX8TvOZMy0ZzkkjyY=;
        b=AyeP8k1qTnjSRgvSxYe5rclPLrgka+TfB0/5k78putSHhx7PMnzYlzZffW66jlN32X
         1DiJ3pSFG9AB8U7ETuL555sQUUfPqSYE4n2J0ndwWPLfEwOS9o1ut5Camn+m34c8jNTl
         rh/jk2FUeRdyvvMV9fB99LGcaonTIsdMlX0pPbGgRApxhTtXKOzLyI8KELzT4DSX06vv
         6iUpYLK07zOg+HC/g5wk66XlFmZMZ0P2RLptMAiBnYCR4W9FG8ESctjheSi2JQ0vKfYy
         OwDTCQ8FD95nGDDDfK4Xiyoflu+Ilklp7iA5+BGkK0W7Rwq1MkZDdEd6YbA3B/fD5GoX
         EKpg==
X-Forwarded-Encrypted: i=1; AKwUvByHP9wI6ZCtK/CWTJDL1HjwzCgfTxZAbFUvhm0A22MEtmbPFGPinhJIreo44Sn5YMwTeWg=@vger.kernel.org
X-Gm-Message-State: AFuF++muxkoVrRBBnYmZBOPutiWGoixmxliSTNXFSNMr/IhjJdv4iPb8
	/+tdb4O81FKsJegRo0qM3+fHt7xD27s/qML2mG5Siht0CB+we6G7Cp3F
X-Gm-Gg: AYBFou25//r5V2K6rzQmU5Fn5fu+tqYvkpKTe4QwlRv4KBbuJb8HMM1Z1tl4TbThilr
	nnITRksZKt4r4zGloOOqhG77qqGwBLPZU8O4v5lB8uljlA/4+b++mU+dHxHo/jc8U4vnPlLCFoO
	L7UL7iG24xxUs8otVyDWziKXP/5Zj65nhPeYtbV0dpRK/+SKUEDXTMe1EpwayxVM5MEfsDBhuPW
	GFG0+IpRWHC2H9C5oLso5FfV4MJn8Uj/5Oe4HR8K0JWRy0ai6ywdsW+g80hAcrC/Mv7k6QhHrDb
	V13ww3/BXhhvEEpaCWyOj4AhcR5swUjeOxArJSgB5jk6/ks26a8FiROu26yLMSpVx2nBPSXSb/g
	dWjNy3JwJPYRTbcy7TPo0Sb2IBQPk7HPonhgMld/FNT508DHyPoCnrd/Vzk8+QhRwUNEfZLrP5r
	/VH8rZwG0XL/yluO68mzqI3K9if9ZXXhDcaeBDuA2QfwdvjCCxReQB8rhZ9NF7fghn5huITTQna
	bzZt7dDjrTsC5uG2bQPVnz+2CollGYFf0jL5AUw8LFR18w8929IRw==
X-Received: by 2002:a05:620a:2888:b0:93a:ea:b00e with SMTP id af79cd13be357-93c43d9e0eemr2013943785a.30.1790602206503;
        Mon, 28 Sep 2026 06:30:06 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93c813a443fsm151650285a.12.2026.09.28.06.29.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 06:30:05 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Amit Machhiwal <amachhiw@linux.ibm.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: Amit Machhiwal <amachhiw@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Shrikanth Hegde <sshegde@linux.ibm.com>, kvm-ppc@vger.kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, Gautam Menghani <gautam@linux.ibm.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>, R Nageswara Sastry <rnsastry@linux.ibm.com>, Alexander Graf <agraf@suse.de>, linux-hardening@vger.kernel.org, stable@vger.kernel.org, Avi Kivity <avi@redhat.com>
Subject: Re: [RESEND PATCH 1/3] KVM: PPC: Book3S HV: Add SRCU protection for virtual-mode HPT hcalls
In-Reply-To: <20260928122837.8782-2-amachhiw@linux.ibm.com>
Date: Mon, 28 Sep 2026 18:57:16 +0530
Message-ID: <v77pjykr.ritesh.list@gmail.com>
References: <20260928122837.8782-1-amachhiw@linux.ibm.com> <20260928122837.8782-2-amachhiw@linux.ibm.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Amit Machhiwal <amachhiw@linux.ibm.com> writes:

> The virtual-mode HPT hcall handlers (H_ENTER, H_REMOVE, H_BULK_REMOVE,
> H_CLEAR_REF, H_CLEAR_MOD) call into book3s_hv_rm_mmu.c, which accesses
> memslots via kvm_memslots_raw().  kvm_memslots_raw() uses
> rcu_dereference_raw_check() to bypass SRCU lockdep annotation checking.
> This is safe in real mode because the entire guest entry/exit is wrapped
> in srcu_read_lock/unlock inside kvmppc_run_core() and
> kvmhv_run_single_vcpu().
>
> However, since commit 6165d5dd99db ("KVM: PPC: Book3S HV: add virtual
> mode handlers for HPT hcalls and page faults"), these same handlers are
> also executed in virtual mode via kvmppc_pseries_do_hcall(), which runs
> after SRCU has already been released on guest exit.
>
> A concurrent KVM_SET_USER_MEMORY_REGION deletion or move can therefore
> call synchronize_srcu_expedited() — which does not wait for this thread —
> and then kfree(slot) and vfree(slot->arch.rmap) while the hcall handler
> still holds a raw pointer to the memslot.  lock_rmap() then writes to
> freed vmalloc memory, leading to use-after-free and memory corruption.
> Because kvm_memslots_raw() suppresses lockdep checks, this race is
> entirely silent.
>
> Fix this by factoring out the 7 HPT hcall handlers (H_REMOVE, H_ENTER,
> H_READ, H_CLEAR_MOD, H_CLEAR_REF, H_PROTECT, H_BULK_REMOVE) into a
> helper function, kvmppc_pseries_do_hpt_hcall(), and wrapping its call
> site in srcu_read_lock(&kvm->srcu) / srcu_read_unlock(&kvm->srcu, idx).
> Targeting only the HPT hcalls avoids wrapping non-HPT hcalls that sleep
> (such as H_CONFER, H_REGISTER_VPA, H_PAGE_INIT) or handlers that already
> acquire SRCU internally (such as H_RTAS).
>
> Fixes: 6165d5dd99db ("KVM: PPC: Book3S HV: add virtual mode handlers for HPT hcalls and page faults")
> Cc: stable@vger.kernel.org # v5.14+
> Suggested-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
> ---
>  arch/powerpc/kvm/book3s_hv.c | 70 ++++++++++++++++++------------------
>  1 file changed, 35 insertions(+), 35 deletions(-)

I had looked at this path in depth earlier itself. LGTM.
Please feel free to add:

Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
