Received: from mail-ed2-f12.google.com (mail-ed2-f12.google.com [74.125.228.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F6B39E18E
	for <kvm@vger.kernel.org>; Mon, 14 Sep 2026 19:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789413464; cv=pass; b=IYHvbMWzTi29VZRcmcOQzhcCrK07hH83CP3+hrzHjduYDq15MI0FFVeAjYrCuR/QaMOZWZocVC0cwpzw+Or9LtRj3QhvOsVKJQozn1+oUb8nqD95uyqPfkF0uBMrLTbDLoXbPRYqWp+jm1eFFv5QcSwjAUXdrXCJTxeRa3OK6MY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789413464; c=relaxed/simple;
	bh=I70R/0YWeF0y09zlTpACQii1qrXFuiFewaTsH+8kBNo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P8Z87c6DpegdUOJKn1PoTM2xZDtb1OOr1rEsNtu/Ulvj9VLU07TrysURdlZmFCdr16Zt0VUuPBw2wqP4Nm0iDBici3QdLETTTwGPmCYeaGxMIxT3mfh82VSeBVMeK+RiO99nhUxTeUNfP+O4D+/yg6naGlKgl6TCciHBwYLL3AI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=T0axpJWS; arc=pass smtp.client-ip=74.125.228.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="T0axpJWS"
Received: by mail-ed2-f12.google.com with SMTP id 4fb4d7f45d1cf-6a613a6bcd8so16555a12.0
        for <kvm@vger.kernel.org>; Mon, 14 Sep 2026 12:17:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789413460; cv=none;
        d=google.com; s=arc-20260327;
        b=LhZJtIjD/VHk8pVk+MxPMCC11WUVSJ64i0saEB/Qd/DA2qN/Xb6X/DYIjaqJJdz3OH
         3qZQzEHPV8ohHaDfNrMxZA0IeJCU6PIbywxve6A+InuiaXpD5l7sNk6YSQJdboiYxtev
         lfyaf7/cdbumfMSEt+nsYF2jGugPz+ppbTv5OQmpgHyLBBYzPeJaLej7H72vLAY1vs3i
         NsJq/0XCJZFcqFSv34GVn9qvT9X4fLYZ3jJ4ylKqMHOlLKsolOv9CmNXARv3dQrzDaB3
         AiuCLtIkLZk1PDQPlpDxXT2LK5kw4PmVSvKP5qwdXmQtBNGDosPDgl4X3nMqM1A7Gwda
         4lAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=myrSaQTa4vHBu2omtc5agr+BkgMWLQGN5WekDwWEnao=;
        fh=y9b0SohZn/iA1/45Kd4hWeHnVhgd8YLlN9Yk8KyNFUo=;
        b=SG8EG/HdDE+RPuZhzSYJ4NEhIx6lb3Lm0/gnDwSbNZPRHrW4+4Ju/m5TvAxdLq5D1v
         kKTdrCfLhFeVMkCS5MpxsFwIP8rXx7WclgtM9jbjxNrgd4MULrH5IbKhIj/X1NJePHz0
         M77Qc7Q3FJu0ojxVNr2s8ZI1So/KCQ4wGRwoSb6jfbHLMwX4vCAou/4UQlvml0U7Vm3F
         VOH2bROyKItKLzLl4LJ2T1mMZLnB0cE5rRk6TurTMvsQM55LZsFV0Zk/XQOqFQKy6CPG
         8U4TMU38o+ZntcPx9kCMSk+m9Ole7HH+8du3fUBPBcCfEuOBf8M7uUdaoJ8T/xLoh7nF
         Y4yw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789413460; x=1790018260; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=myrSaQTa4vHBu2omtc5agr+BkgMWLQGN5WekDwWEnao=;
        b=T0axpJWSk2XvqBX5ng9MHBtx3WjHmA3UjvcoCp+HbbWqSyB50puhUo2gV2ZVzeAyxJ
         DP0PvhpBPkDSWLKQlTa6sP7Tv2JBpMhvUc+p6TY62u91BI0qtBEsb16n93WXxkD6UzZq
         3ikdC062nh/5V346G2IQc2WBQPyOEhwAmi0fcQlvAS9d+TGVSFLONyzrrHVXiMrTWiQk
         +aXu0QQAEjtFWC8zYmY7PvA0QKnH6bz31c4UVYPv6NZOlitG2fH/5/We22EWehU4uKP/
         d+zmoKnT9aCMeZe58dNdVf+hEX4MSqozpzZs3WptX3a1XBl6ZGqjwjEgvyi/yfWhl8wO
         y1Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789413460; x=1790018260;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=myrSaQTa4vHBu2omtc5agr+BkgMWLQGN5WekDwWEnao=;
        b=a7rzYrdxmFLAAJkp88GKuZ6DT9wGI4tVhNONl7kz1BrEVQb6KR4xD5BPvKWSYx3cq1
         4Bf6SuPmIkiuDgDBYwhWW5e/3fqh42itOS+Xp1vLRfm7+kO3DdLFuMg4KZZD9LQ88Vfy
         T6DVff2iQW/R8slpOUTONwkYSQdDVmo1iiXNJo4SM8GoDDq+3ICTz9Te2SsGjHg8qOSF
         PB+gDqDeHpWryPWt5OVb8LTY2xlzoIWogOINJrdR4+U9KV8drwDlbZRuyJeMg3iVJwXQ
         Abo+vwvBwv9N5lARuBROntGQL2uYzdu2D8JNT7LM1pATP1BsyL18UVh8vwTqDspA9NGP
         c3Rw==
X-Forwarded-Encrypted: i=1; AKwUvBxrdzLokF4OnyFzCF2NpjqM8QyS9SK6Gh3Pra6aJiHsTvgAkc/MM/d9vE/aZbtQxBQdRy8=@vger.kernel.org
X-Gm-Message-State: AFuF++mNQLyXJTRjrpkj8ZEl1Fpee5k/uiAFO30cCdzC8I5w3cgO01sc
	fdQ1EZlMafkAK8oFSJksHhZhVKysyEvQtAdrevvAA3Rc3inJDlvMr+M5IUGMZv9ZxzmxccvMXzN
	7NplCp3/GvnSix46ggVX/Db+Fra5HaS+mjfdoMGvj
X-Gm-Gg: AYBFou1imeMtI2wgmrb3FH8t1RWeYJYJWwWT2VWfbKRz+fWFFVompVeJVZQvEBNjg1T
	VEnMQh8cQxqFdfm7Xi6myRa2rrh46/Cvfwaxl+0H+oSd2DuqJvbXEzs7EhtGqlOWErenlMI1pV2
	dG5KepNS9OwzHp2b3w0zeFFIc3yb+8iAkkU4N6yXK0BewYqYAVNY5wFlAaJkYw0NqlEEy5z+yYD
	bsr4ibzl44ZnFgpN9a3w/iZzUZeXo8JYEW0pcwd+adIMULCp+IHP8jXnxnmV8h9wl8ySWZ/jGwK
	JnsLnkjiw7q6vpZuxifSMhpR4BjH4Zk2NElYUVh6on26u4G/M5/nj1yWjX/E2Gx3tA==
X-Received: by 2002:aa7:cd18:0:b0:6a4:abe:b08c with SMTP id
 4fb4d7f45d1cf-6aa043d1f1fmr13883a12.12.1789413459616; Mon, 14 Sep 2026
 12:17:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1789281096.git.zhang_wei@open-hieco.net> <37a1f336c303c78bbf942b1babcde828899968f6.1789281096.git.zhang_wei@open-hieco.net>
In-Reply-To: <37a1f336c303c78bbf942b1babcde828899968f6.1789281096.git.zhang_wei@open-hieco.net>
From: Jim Mattson <jmattson@google.com>
Date: Mon, 14 Sep 2026 12:17:27 -0700
X-Gm-Features: AcwNN1VzS9Vin9kOzYrPdaEV4UDdLP1p-qtdqTYgtpYlaZGFsre3kVUF8nVDPxU
Message-ID: <CALMp9eQbk4i3jMz4U7cTy_CNKCs6FfU+2fMLW4WDj612YdDfCA@mail.gmail.com>
Subject: Re: [PATCH v6 3/8] KVM: nSVM: Track valid hardware DecodeAssist bytes
To: Tina Zhang <zhang_wei@open-hieco.net>
Cc: Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, zhouyanjing@hygon.cn, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 12, 2026 at 11:44=E2=80=AFPM Tina Zhang <zhang_wei@open-hieco.n=
et> wrote:
>
> VMCB02 instruction bytes are valid only for the hardware VM-Exit that
> populated them.  Track whether VMCB02 contains instruction bytes for the
> data #PF or #NPF currently being reflected to L1 so that stale bytes are
> not copied to VMCB12.
>
> Invalidate VMCB02's instruction-byte state when preparing VMCB02,
> normally in response to an emulated VMRUN.  Mark the bytes as valid only
> when the current VMCB02 exit is a data #PF or #NPF.  Opcode exits and
> instruction-fetch faults are excluded by inspecting the exit state.
>
> A subsequent change will use this state when propagating hardware
> DecodeAssist instruction bytes to VMCB12.
>
> Signed-off-by: Tina Zhang <zhang_wei@open-hieco.net>
> ---
>  arch/x86/kvm/svm/nested.c | 38 +++++++++++++++++++++++++++++++++++++-
>  arch/x86/kvm/svm/svm.h    |  3 +++
>  2 files changed, 40 insertions(+), 1 deletion(-)
>
> diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
> index 73f37b050d0a..1cc3af8247f2 100644
> --- a/arch/x86/kvm/svm/nested.c
> +++ b/arch/x86/kvm/svm/nested.c
> @@ -35,6 +35,35 @@
>
>  #define CC KVM_NESTED_VMENTER_CONSISTENCY_CHECK
>
> +static void nested_svm_invalidate_insn_bytes(struct vmcb *vmcb)
> +{
> +       vmcb->control.insn_len =3D 0;
> +}
> +
> +static bool nested_svm_vmexit_supports_insn_bytes(const struct vmcb *vmc=
b)
> +{
> +       u64 exit_code =3D vmcb->control.exit_code;
> +
> +       if (exit_code !=3D SVM_EXIT_NPF &&
> +           exit_code !=3D SVM_EXIT_EXCP_BASE + PF_VECTOR)
> +               return false;
> +
> +       return !(vmcb->control.exit_info_1 & PFERR_FETCH_MASK);
> +}
> +
> +static void nested_svm_set_vmcb02_insn_bytes_valid(struct vcpu_svm *svm)
> +{
> +       svm->nested.vmcb02_insn_bytes_valid =3D
> +               static_cpu_has(X86_FEATURE_DECODEASSISTS) &&
> +               nested_svm_vmexit_supports_insn_bytes(svm->nested.vmcb02.=
ptr);
> +}
> +
> +static void nested_svm_invalidate_vmcb02_insn_bytes(struct vcpu_svm *svm=
)
> +{
> +       nested_svm_invalidate_insn_bytes(svm->nested.vmcb02.ptr);
> +       svm->nested.vmcb02_insn_bytes_valid =3D false;
> +}
> +
>  static void nested_svm_inject_npf_exit(struct kvm_vcpu *vcpu,
>                                        struct x86_exception *fault,
>                                        bool from_hardware)
> @@ -68,6 +97,10 @@ static void nested_svm_inject_npf_exit(struct kvm_vcpu=
 *vcpu,
>                                     (fault->error_code & ~PFERR_GUEST_FAU=
LT_STAGE_MASK);
>         vmcb->control.exit_info_2 =3D fault->address;
>
> +       if (from_hardware)
> +               nested_svm_set_vmcb02_insn_bytes_valid(svm);
> +       else
> +               svm->nested.vmcb02_insn_bytes_valid =3D false;

For consistency, should the line above be:

nested_svm_invalidate_vmcb02_insn_bytes(svm);

>         nested_svm_vmexit(svm);
>  }
>
> @@ -869,6 +902,7 @@ static void nested_vmcb02_prepare_control(struct vcpu=
_svm *svm)
>          * Filled at exit: exit_code, exit_info_1, exit_info_2, exit_int_=
info,
>          * exit_int_info_err, next_rip, insn_len, insn_bytes.
>          */
> +       nested_svm_invalidate_vmcb02_insn_bytes(svm);
>
>         if (guest_cpu_cap_has(vcpu, X86_FEATURE_VGIF) &&
>             (vmcb12_ctrl->int_ctl & V_GIF_ENABLE_MASK))
> @@ -1649,8 +1683,10 @@ int nested_svm_exit_handled(struct vcpu_svm *svm)
>
>         vmexit =3D nested_svm_intercept(svm);
>
> -       if (vmexit =3D=3D NESTED_EXIT_DONE)
> +       if (vmexit =3D=3D NESTED_EXIT_DONE) {
> +               nested_svm_set_vmcb02_insn_bytes_valid(svm);
>                 nested_svm_vmexit(svm);
> +       }
>
>         return vmexit;
>  }
> diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
> index e958943b8162..1e12ef1105c0 100644
> --- a/arch/x86/kvm/svm/svm.h
> +++ b/arch/x86/kvm/svm/svm.h
> @@ -243,6 +243,9 @@ struct svm_nested_state {
>          * on its side.
>          */
>         bool force_msr_bitmap_recalc;
> +
> +       /* True if VMCB02 has instruction bytes for the current nested ex=
it. */
> +       bool vmcb02_insn_bytes_valid;
>  };
>
>  struct vcpu_sev_es_state {
> --
> 2.43.7
>
