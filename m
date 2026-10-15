Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71BE24E56C2
	for <kvm@vger.kernel.org>; Thu, 15 Oct 2026 23:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792105784; cv=pass; b=J7bgbvZkNw7SX7uumG+RN9Ldt+6l7IraFoAXulmaq6wjccBX4Bv4lDL4wQZ0t+ALGxguLr99aFiqIvIIQlAfU6c+/cjENeRyMAADkaBvCko6ftP2bXsjob/wbbnsdPFNFku9lA98ld5f1wu93j9x05LSRKAL7gKSQsQPaZVz214=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792105784; c=relaxed/simple;
	bh=zUbjl0cr2j/SM+XS1+leflyMjWShNVaXhhl3fNVkSVg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gnDa79mk8uAQe2vUEZpVB9NG34H5LLoh21G0sv8aHEfEYHikwHn5kZx5LsKwJ+s2lTf4oMxN6YrxCYP1u7HVwpNY4G+0nR5rs6zJatKTE3p9a3Afh9CcoBgtmRhTN3QNDlfbOAURy8LKDqq7ow0WLqngLR8C5UjRzTkMrhpQa3I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EugyFxbv; arc=pass smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EugyFxbv"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6ae14cdc63aso2389a12.1
        for <kvm@vger.kernel.org>; Thu, 15 Oct 2026 16:09:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792105781; cv=none;
        d=google.com; s=arc-20260327;
        b=C9EtB25fqRdphp4EJKcvDKUL/rI9pqFX/FnnUDCZ47eT9MqISCYgPQgk4SkQM5UuAT
         bCcrqYnwSS2ui+LmU21Fr5BW8+FKdT8SMP8pvIa0MDjs59j68QH+ruAFlutpNccIOOFt
         KI0r74XaOxSUgV64suFOeKoXldNyhgGpt22T/LjnCBvRBShc06UTls0x5I4AQkC0Sq7A
         r2jnsVEs8TSqMdvI4k+Vj928pyAdZVOeGaYaydYahyQIfMf7DFp4u5vG484iKHN8yv+5
         cdG4aarh/JAqgzKB0AyivBEO8kWvX32hNSCPcX9HKyehT+nTyJlQuG7clAWRDVD5yW0x
         h7UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2gAh1LE3Uytz1fFZ+ecGu7AVbqVWDFJvRMe4B+KimgI=;
        fh=JeMm6AjiMz6D8o4ykGwSkGAdH0LYG1Ee+P4pCC1I5ps=;
        b=WCgcUNu3eXFbL6TeiJR/8tefwrHsfg4HVpLhyJTaOBSNN21vZHRY2atIyM+aH4q09M
         TR/20leHA7rlllVrbLBeNwLt+VYXeDa1jVlsNvYa85GOTCZv+37se4Sk6jNlfJ+ih/5B
         vYH91hiaYqWT6mehz98q0KJFjbhT0E4p5kxc6pWSQemCe9ZRdjknI8FweRfGNIDtiZjH
         CyARgBc/vM+eBK51I0yCrJQPXHcUhMc1Y8kIdfNYtvoRFwCoWDty9sgpcG2hyHQ9V7wn
         DzpZXIbRfjbXcyHrTkpRa+QUMn6MrSxSe1lBHNjZYWEKVOs9cqS3zlbbofwUff0+QJgu
         W78g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792105781; x=1792710581; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2gAh1LE3Uytz1fFZ+ecGu7AVbqVWDFJvRMe4B+KimgI=;
        b=EugyFxbvNHYP/0ncbOux8m1LCUkjwMmi0TAyDBHqDnW4Au+W44QMTUmL6cYQKBahXe
         +gPtMv6xJnsc4tMqflh1qKZd7mCKK8BZOzaq5la07zVaRvURVU+lmBYxfB6Wt7jXh2LD
         Y4ANWHNqMOsRvc6DbMS+nosUnbWWvdEEcB8hv5xG8C9Wy4tZ58Z/CbN5HUoFxpPgDxC6
         8Pg6NS4gv/BPZKd2nYLKp5TqyoMtpQGYA2eCyINbwUipA7LpjGnZsIPfqqcw9XECakyJ
         11SXQvNyTYTOHFaBINNbJhKfhhb05a8BWWy8t7RFnKvPMqUtsxr1MUGhBxl+YFU7MPDl
         NgwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792105781; x=1792710581;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2gAh1LE3Uytz1fFZ+ecGu7AVbqVWDFJvRMe4B+KimgI=;
        b=SFyjJOyl4wHkqvHdeICqgN5ChSLx9YLFXxRpVYDsXQY8aURcUqbWw8Cbc3PUUEH1u7
         NKfEgAOgbFDrS3qrwO/LKDE1p2g81VUPifVPgUZ/QAYisPkF4q6j9UdSizweScLWnGqa
         uGB5nupstmUdjo9fTCXQqRc/l4EDctbp68Vi58mq1GkmueTENFxARAOPKpokWy41gifm
         dWgjYuiiLemWMLMW6ZuaP28rKs5rjILqehSsEFjxc01DqL3d57/w6qfnG25RvqwLn3po
         /zytUjKvb/I0jtshZvcwz4DvlC7qHQG6VwIcHf3ahWuv9NXT7wtDdJaQCJvR4F6ekAG1
         wN8g==
X-Forwarded-Encrypted: i=1; AKwUvByffUxy5X1vIBoIIl1jtueq8ln++AbEA2t85UG6D9qaW8xn5eU8aYqqtxREa7OrbjlKK6M=@vger.kernel.org
X-Gm-Message-State: AFq9FYLbrdpzVQz4dnffREkb4OL56hBBPqYP4A1xQDOrHdN/y0T4cAc2
	ZRI/D53vbVUwcbJf+DDplIKajilCnk8cC1rU1qp8SkGmuEYw44IGmy/lqQ4IGQdgpq3qhkFCXo3
	wFdCzmD3F0x8y0HHNvR93uldg8xwd+EKxXEngphzD
X-Gm-Gg: AYBFou2sXG1EP1oDyCWrFERg4wGPRpZS+eavKaVIaW+3F7t193NMi9tqz6CaxdM3uem
	vszrxOWVUzQYwonE6/biz47VZajSApYYPSEAoiFjsIc3O0PflRkavkRB45fg1VSAOloWJt2VI8S
	cHApztaT69bSaqaBy+vVhkRhGRmHs4yvY3i2xJuRqmuJ+y8OR/HAi0b8/7uanua/5NZGlOj+sIP
	fsz86Tcu8/XGGVlvMMexNQnTNwDoa7WiCtVjE8ge0chVF1A08qIR3CeS3e2tkmkBWJpmOKb0JRC
	10VfQ63LvFcihWzlU7PG/Dt12zTzOHDvA75MKuhxAaUXXtJki04dYPA5PQ/5E4XT4Q==
X-Received: by 2002:a05:6402:a2cf:10b0:6b1:bce6:1220 with SMTP id
 4fb4d7f45d1cf-6b38c5bebb5mr13497a12.12.1792105780206; Thu, 15 Oct 2026
 16:09:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261012233638.2546339-1-yosry@kernel.org> <20261012233638.2546339-23-yosry@kernel.org>
In-Reply-To: <20261012233638.2546339-23-yosry@kernel.org>
From: Jim Mattson <jmattson@google.com>
Date: Thu, 15 Oct 2026 16:09:28 -0700
X-Gm-Features: AclHuK-3WnnpL9zskmCDLgKncxTa4NxXNzR6dgZzJcSAYQThmRG_OB-LaJ7queg
Message-ID: <CALMp9eSv9a23si8rtWd_XGRJxVWE96aWdSzE_Ram5Bu6G_pb+w@mail.gmail.com>
Subject: Re: [PATCH v3 22/27] KVM: nSVM: Flush the TLB if L1 changes L2's ASID
 in vmcb12
To: Yosry Ahmed <yosry@kernel.org>
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Maxim Levitsky <mlevitsk@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 12, 2026 at 4:36=E2=80=AFPM Yosry Ahmed <yosry@kernel.org> wrot=
e:
>
> KVM uses a single ASID for L2 guests per-vCPU. Hence, when L1 changes
> L2's ASID in vmcb12 (e.g. due to switching to a different L2
> vCPU or simply to avoid flushing an existing ASID), KVM needs to flush
> the L2 ASID to correctly emulate different ASIDs as different TLB
> domains.
>
> Additionally, the nested NPT needs to be resync'd, as the MMU context
> is not tagged by ASID, and KVM cannot reuse nested NPT entries across
> different L2 ASIDs.
>
> Essentially, L1 switching L2's ASID is treated exactly the same as L1
> flushing L2's ASID, which is consistent with the APM:
>
>   Software may effectively flush the guest's TLB entries by allocating a
>   new ASID for the guest and not reusing the old ASID until the entire
>   TLB has been flushed at least once.
>
> This is similar to nVMX's handling of last_vpid, except that when L1
> changes VPID12, KVM does *not* need to resync the nested EPT, because
> VMX VPIDs, unlike SVM ASIDs, do not tag guest-physical translations
> (i.e. nGPA to GPA translations).
>
> Reset last_asid when nested VMRUN fails to force a flush and sync on the
> next nested VMRUN. The TLB flush request survives the failure, but the
> request to sync the nested NPT does not, as it ends up being serviced in
> L1's MMU context after the synthesized VM-Exit.
>
> Drop the commentary about vmcb12's ASID being copied around only for the
> consistency checks, as they no longer apply, and opportunistically fix
> whitespace alignment.
>
> This is currently functionally a noop, as a full flush and sync is
> triggered on every nested transition, but is a step toward eliminating
> that.
>
> Signed-off-by: Yosry Ahmed <yosry@kernel.org>
> ---
>  arch/x86/kvm/svm/nested.c | 29 +++++++++++++++++++++++------
>  arch/x86/kvm/svm/svm.h    |  2 ++
>  2 files changed, 25 insertions(+), 6 deletions(-)
>
> diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
> index e04cc4f7669ea..8e4686b0d603a 100644
> --- a/arch/x86/kvm/svm/nested.c
> +++ b/arch/x86/kvm/svm/nested.c
> @@ -556,10 +556,8 @@ void __nested_copy_vmcb_control_to_cache(struct kvm_=
vcpu *vcpu,
>         to->nested_cr3          =3D from->nested_cr3;
>         to->pause_filter_count  =3D from->pause_filter_count;
>         to->pause_filter_thresh =3D from->pause_filter_thresh;
> -
> -       /* Copy asid here because nested_vmcb_check_controls() will check=
 it */
> -       to->asid           =3D from->asid;
> -       to->clean =3D from->clean;
> +       to->asid                =3D from->asid;
> +       to->clean               =3D from->clean;
>
>  #ifdef CONFIG_KVM_HYPERV
>         /* Hyper-V extensions (Enlightened VMCB) */
> @@ -691,23 +689,35 @@ static void nested_save_pending_event_to_vmcb12(str=
uct vcpu_svm *svm,
>  static void nested_svm_entry_tlb_flush(struct kvm_vcpu *vcpu)
>  {
>         struct vcpu_svm *svm =3D to_svm(vcpu);
> +       bool new_asid =3D false;
>
>         /* Handle pending Hyper-V TLB flush requests */
>         kvm_hv_nested_transtion_tlb_flush(vcpu, npt_enabled);
>
> +       if (svm->nested.ctl.asid !=3D svm->nested.last_asid) {
> +               svm->nested.last_asid =3D svm->nested.ctl.asid;
> +               new_asid =3D true;
> +       }

To make sure we don't miss a flush after restore, do we need to clear
last_asid in svm_set_nested_state()?
