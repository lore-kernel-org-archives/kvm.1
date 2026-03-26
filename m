Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF043328E6
	for <kvm@vger.kernel.org>; Thu, 26 Mar 2026 19:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774551813; cv=none; b=JldkbEVZ6d/awtVLBBVoW7Z3tGd9vMYJHGxyqthSZSAQ/PLxrZI2aC+Ev1QkJViDM5Ii004ZAUTe3vdAU0EhXNWdnaU1412sX5opuchxGV1CWeBFiuIDW28tBPjji9PtuVXgXofnu0jaxSCPbxb+FgNDnUbPytfzzhSQT+eVUlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774551813; c=relaxed/simple;
	bh=H3ZANKprj/TgNWGd+SUawc9wkwCTzwy1BeR8pADdSwI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kVbsQd2JAJYLIOonRRHsgXQzmal2L25qmwq4yul3zWFDvG71RDxuxBYCj9gddDzogSt5rXDUNr9vZLHZaJSKVDmHy+TfQlETzDo3IJONv7gdqItvwjbfiFe5P/dfC+6V0yygvXSVIErl6AnFeuS80KfVdqzb+KM1YveSAeawg2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u97SDTgX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u97SDTgX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57BF1C116C6
	for <kvm@vger.kernel.org>; Thu, 26 Mar 2026 19:03:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774551813;
	bh=H3ZANKprj/TgNWGd+SUawc9wkwCTzwy1BeR8pADdSwI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=u97SDTgXTlzOMF+8m1DUlWk5+B5s05tTe7VXmdb8L06wfedBUbsvunVUdI1pLXAzP
	 u/5gAQ51s8CvSpqkgsWM+xtJvxJqtCelDJpqQPqlGIVbfigHsQGzSE8DyRKaZdEEic
	 MqAWh97TXPg85OTGbFuiYiJM4Fg09HdJKyHbj3yiX9OFwyEUX61+oCHbMkPhbWejzn
	 97Nm3UXaYQweEB92yACV3iJEajEF0rsOrDA6bYKpau5O74ICgPCb78frC1dlO7gWjj
	 NwbwBn3AzOuDAV/K270aDl+DHRcr32J2redoGF5me47guJvt+kff4HN+ctYAK64HR7
	 TEvk2bhrf6E1A==
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-66b1019bb55so650430a12.1
        for <kvm@vger.kernel.org>; Thu, 26 Mar 2026 12:03:33 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXFHbm6OqiYWwF8yX6gx4c2emoXP1iwE+ICkupJnJRDJkHYgld19Pd5HUDVh6DmWByMJxg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUjY4sr6o1/NqCxriMBCekwE+ewgQ9g+rjBBHjDQBUGG54FmXv
	9gR8CKPENBd4FdrGi/pjgvBm6RRXo7iJj2BHk/Zp7IX3R2PEmPkPCbUzHDvGYLp5sKGMiJyWlPr
	QfbnYd0n8dDrMPF/T/PsBFBwgDeEf0B4=
X-Received: by 2002:a17:906:eecd:b0:b98:36cd:7e0e with SMTP id
 a640c23a62f3a-b9a542737camr610146966b.45.1774551811888; Thu, 26 Mar 2026
 12:03:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260326174944.3820245-1-jmattson@google.com> <20260326174944.3820245-2-jmattson@google.com>
In-Reply-To: <20260326174944.3820245-2-jmattson@google.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Thu, 26 Mar 2026 12:03:20 -0700
X-Gmail-Original-Message-ID: <CAO9r8zMYdLjH8BuN_GWsS_BNrdE+Kbz=d6Y-Cxt3GTXMpdEM+w@mail.gmail.com>
X-Gm-Features: AQROBzDXNpZkaYQ2rFx8prlIgRpDL-u1SWDMIRceFjxW53ZNgIHOU49tyDb09oo
Message-ID: <CAO9r8zMYdLjH8BuN_GWsS_BNrdE+Kbz=d6Y-Cxt3GTXMpdEM+w@mail.gmail.com>
Subject: Re: [PATCH v6 01/10] KVM: x86: Define KVM_X86_QUIRK_NESTED_SVM_SHARED_PAT
To: Jim Mattson <jmattson@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Sean Christopherson <seanjc@google.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 26, 2026 at 10:50=E2=80=AFAM Jim Mattson <jmattson@google.com> =
wrote:
>
> Define a quirk to control whether nested SVM shares L1's PAT with L2
> (legacy behavior) or gives L2 its own independent gPAT (correct behavior
> per the APM).
>
> When the quirk is enabled (default), L2 shares L1's PAT, preserving the
> legacy KVM behavior. When userspace disables the quirk, KVM correctly
> virtualizes the PAT for nested SVM guests, giving L2 a separate gPAT as
> specified in the AMD architecture.
>
> Signed-off-by: Jim Mattson <jmattson@google.com>
> ---
>  Documentation/virt/kvm/api.rst  | 14 ++++++++++++++
>  arch/x86/include/asm/kvm_host.h |  3 ++-
>  arch/x86/include/uapi/asm/kvm.h |  1 +
>  arch/x86/kvm/svm/svm.h          |  7 +++++++
>  4 files changed, 24 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.=
rst
> index 032516783e96..2d56f17e3760 100644
> --- a/Documentation/virt/kvm/api.rst
> +++ b/Documentation/virt/kvm/api.rst
> @@ -8551,6 +8551,20 @@ KVM_X86_QUIRK_VMCS12_ALLOW_FREEZE_IN_SMM   By defa=
ult, KVM relaxes the consisten
>                                             bit to be cleared.  Note that=
 the vmcs02
>                                             bit is still completely contr=
olled by the
>                                             host, regardless of the quirk=
 setting.
> +
> +KVM_X86_QUIRK_NESTED_SVM_SHARED_PAT        By default, KVM for nested SV=
M guests
> +                                           shares the IA32_PAT MSR betwe=
en L1 and
> +                                           L2. This is legacy behavior a=
nd does
> +                                           not match the AMD architectur=
e
> +                                           specification. When this quir=
k is
> +                                           disabled and nested paging (N=
PT) is
> +                                           enabled for L2, KVM correctly
> +                                           virtualizes a separate guest =
PAT
> +                                           register for L2, using the g_=
pat
> +                                           field in the VMCB. When NPT i=
s
> +                                           disabled for L2, L1 and L2 co=
ntinue
> +                                           to share the IA32_PAT MSR reg=
ardless
> +                                           of the quirk setting.
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D   =3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
>  7.32 KVM_CAP_MAX_VCPU_ID
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_h=
ost.h
> index d3bdc9828133..0809d8f28208 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -2511,7 +2511,8 @@ int memslot_rmap_alloc(struct kvm_memory_slot *slot=
, unsigned long npages);
>          KVM_X86_QUIRK_SLOT_ZAP_ALL |           \
>          KVM_X86_QUIRK_STUFF_FEATURE_MSRS |     \
>          KVM_X86_QUIRK_IGNORE_GUEST_PAT |       \
> -        KVM_X86_QUIRK_VMCS12_ALLOW_FREEZE_IN_SMM)
> +        KVM_X86_QUIRK_VMCS12_ALLOW_FREEZE_IN_SMM       \

There is a missing "|" here, it's fixed in patch 3, but I think it
should be fixed up here (maybe when applied).

> +        KVM_X86_QUIRK_NESTED_SVM_SHARED_PAT)
>
>  #define KVM_X86_CONDITIONAL_QUIRKS             \
>         (KVM_X86_QUIRK_CD_NW_CLEARED |          \
> diff --git a/arch/x86/include/uapi/asm/kvm.h b/arch/x86/include/uapi/asm/=
kvm.h
> index 5f2b30d0405c..3ada2fa9ca86 100644
> --- a/arch/x86/include/uapi/asm/kvm.h
> +++ b/arch/x86/include/uapi/asm/kvm.h
> @@ -477,6 +477,7 @@ struct kvm_sync_regs {
>  #define KVM_X86_QUIRK_STUFF_FEATURE_MSRS       (1 << 8)
>  #define KVM_X86_QUIRK_IGNORE_GUEST_PAT         (1 << 9)
>  #define KVM_X86_QUIRK_VMCS12_ALLOW_FREEZE_IN_SMM (1 << 10)
> +#define KVM_X86_QUIRK_NESTED_SVM_SHARED_PAT    (1 << 11)
>
>  #define KVM_STATE_NESTED_FORMAT_VMX    0
>  #define KVM_STATE_NESTED_FORMAT_SVM    1
> diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
> index ff1e4b4dc998..67aa5d34332e 100644
> --- a/arch/x86/kvm/svm/svm.h
> +++ b/arch/x86/kvm/svm/svm.h
> @@ -616,6 +616,13 @@ static inline bool nested_npt_enabled(struct vcpu_sv=
m *svm)
>         return svm->nested.ctl.misc_ctl & SVM_MISC_ENABLE_NP;
>  }
>
> +static inline bool l2_has_separate_pat(struct vcpu_svm *svm)
> +{
> +       return nested_npt_enabled(svm) &&
> +               !kvm_check_has_quirk(svm->vcpu.kvm,
> +                                    KVM_X86_QUIRK_NESTED_SVM_SHARED_PAT)=
;
> +}
> +
>  static inline bool nested_vnmi_enabled(struct vcpu_svm *svm)
>  {
>         return guest_cpu_cap_has(&svm->vcpu, X86_FEATURE_VNMI) &&
> --
> 2.53.0.1018.g2bb0e51243-goog
>
