Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1343540DFC3
	for <kvm@vger.kernel.org>; Fri,  3 Apr 2026 18:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775239825; cv=pass; b=cnqGUsMiyXe67BHgx3+7Q34oJ3/N9VO4sbpBkWbGtL3vVuBXOh7gfGBHQbYHlXU/QZaaMzw3BUQYFHmeFoVbqk6+t5q6hvmntS3xqsBEOn2V8oXVcHmvDtjnEQUxR744m7R/Bw+r1CLBIFKFEH/plJVY+OG+2F/3fEe8lOJRYOY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775239825; c=relaxed/simple;
	bh=4wnkiw01drsb1mOeb4vmjM1GYWviZqJrvrwioV4gc0w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=okwsfGAUKIM6y+AfwrbIW5rO0pZFzV5xVXdshdIlQZ1hjUboaET9i3Lc/1gXMEW34Yc/oXQIebxphIGcEsfLrrIegT4grRdhQJpfx2jFRs/LrpnyxII33+HpI1i9LMrngAFSFRW9TZwb93sROV4A8jHCrzxxwk7HF7rzvNoEM8A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nEkp1iN2; arc=pass smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nEkp1iN2"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-509069a7a7fso650191cf.0
        for <kvm@vger.kernel.org>; Fri, 03 Apr 2026 11:10:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775239823; cv=none;
        d=google.com; s=arc-20240605;
        b=l11OeLHOJa/3um4dLKRLjb2cWfTXsEP4MgtBHZOqNz9NI8uxnJy9RsYAHhrkIELB12
         rRx2v0r3tTXXzuwnhabH6+EprsvvKVC+meYHQcax3eMUw0u07Rw18YQZK3pr1POH7FNH
         /PSg1GErIwME93GwEEDTFnhnK5K4gqJ0gkZAcGmRtEZg7GflCpdpnq2RCNZJOIXKu4GO
         7McC3hat0sw26NDwkS3qiSFcpEuYT77ai1mqNiF3U8AFP1kyYuhu76qlSuZfd1fwnd9s
         I/l81X+WVMSaa3ALzIcALlQ6OHkWmhpV6IHWLKZRswOmT4SrTqcHuqXHKDlaImxqzbps
         lB/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=D3wHWIST+Psa9goPXbHlA48/ILBuz3wG5otAi6JiaL0=;
        fh=Wh+4SUVcW1AjeuixI7nXlBdnBurCZTInrD3Iq9eVYOE=;
        b=A5pqPzvflv203+VYrypCc9ehplEwjvmV75ECsgq6G1SMnsgiwMIIMk18WNqM8MQRzZ
         6W9IFGeVTqHRselClSLi55UiXK0lkasZ33PQ8gLAzLIqSkH4OkiFQVHqOsww42Hvj9ds
         3TiqI92UzuQGMn5N3+vn4hVxrlr2tNZfMBGuSFvbMtg0OXYF+JtjpHo+tfip7mChLlIW
         8zm1LHba0RE0fUZ63/5WB4thnn5pQZ7uOzlQy7mUnAPdfXy8It7STBxNPVXXpE8E4I+e
         3/GGvoztdk+vVSNYhaRGlWczz8xPA4LTiJkytCbG1GGU2R/Dqc4E7tGGQsOsmE677ZE9
         PLaw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775239823; x=1775844623; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D3wHWIST+Psa9goPXbHlA48/ILBuz3wG5otAi6JiaL0=;
        b=nEkp1iN2jyvw0DdQVmSe7j7ZXK37mB9ritAXbGlVoKn373Hph2yg3uVQpgw/kAv5jJ
         QfqwJ0yAoPwN4aoHjuvxrhas9rm3bgGR8FtX5CRpF0PMcF5mjX53WBKzLCKp6E/K/tWO
         pCENK0HP63nEta7+7Cu0f0FApSDOdCES8fRsJMVP73Xg+aJDuOkTzDyt70+f+aM2uuyg
         MFCkgM/RZJBsfbYoLIQX36HHq+PsL6gbq31R9pNDbn+6jHXUMYaRyumxYhMyZxnN58AB
         YQV200Wu2HfzoFSbxrj69c+B/9V/cl9pAejHgyFAlAAnrOBa9RrpYqZr/DH2FzJNvws6
         uIcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775239823; x=1775844623;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=D3wHWIST+Psa9goPXbHlA48/ILBuz3wG5otAi6JiaL0=;
        b=a2cG2N+L6bB4r4NBwqUoWnhHj5pJKHmmPy818jCqKBnWBJsZbSIdgAwcchtD02cKA2
         MYd3fcWqduz5grIOw0thRoeAv61eufS2XNoLhCc3BAdMt/NaekSfsTcQ4tL2AJbhMmc7
         ywoUIOtCLFqqQLyVIlIafZqtDX2xdWU3eR/Y3d+/ijbDYF0Qr/M9gQNx/8L5abNcqOzF
         fWaZdNtU7UhTfNBi9qBSSAFAOtApdZC8G+52Prs6yy84p3TKt9Cl0XkKFYyiOOFZTMjQ
         9CMkMZzCSqSxLAQ2SzQkYiI8kUEixj/ugp3AQj4pZiDszXdQU5Gd71YFvaU58JemqpIb
         mivQ==
X-Forwarded-Encrypted: i=1; AJvYcCWaygITcNZIow1nAqlsHS77EEddj4AcEbOv37Q8XG3UOpOrDXIug3nR6H7NEzSTRFFGf8M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEQpCp+GdywZwmRZslDu0xnpHMdzfb1WDa9lF20hrqe4h5AhtM
	g1r2oY/vO/t61amDDHtU5mdU8WDgjjOZ+6U5MQ/JxspAubzBBsEIv61NKHwwGVvRqwtCeUW0269
	QQOLYHMomXfTmZk9qir+1HMBRbq/NAKX1Y4aljwgH
X-Gm-Gg: ATEYQzyNxbIlKfpUVluSbSsekufxNWYVR/mQiStbhRD5TrcPCyHQ0wzAWtTNe/2T+yC
	tMYTZrvSpWg5NX7YWtOmrGNtQkDSIAlpYqZ8GKOEWtTRS+CBeDtZOcaq0D20CBOozEdaHts9gzv
	diO/bsDDcwJ1nZ6VhWU4w8N4jsOt/EWNP5HPkhIg3xjiufmn/wlmaM5Zn1JI3x8I7lbld8G+wSJ
	2B++s8t9FBrjWjc1MW/HSyGO+owRzSabAvksXkzPZtFqmJtQVFTPnLCDSiQS8Motz3mJk71os7y
	LzMu0Kc=
X-Received: by 2002:a05:622a:5c9b:b0:509:15b6:f69f with SMTP id
 d75a77b69052e-50d63eb1e2amr16678631cf.2.1775239822510; Fri, 03 Apr 2026
 11:10:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260402-vmscape-bhb-v9-0-94d16bc29774@linux.intel.com> <20260402-vmscape-bhb-v9-2-94d16bc29774@linux.intel.com>
In-Reply-To: <20260402-vmscape-bhb-v9-2-94d16bc29774@linux.intel.com>
From: Jim Mattson <jmattson@google.com>
Date: Fri, 3 Apr 2026 11:10:08 -0700
X-Gm-Features: AQROBzCyrNR-vZ6JoZC9tdSShIePKIwW7s9m_Ym-DzdZtKevzbTyUKkIE4TY_-E
Message-ID: <CALMp9eSLVvr00mJ0J2f2_SPeCW-VS58kxMcxHgUW6etML+_+QA@mail.gmail.com>
Subject: Re: [PATCH v9 02/10] x86/bhi: Make clear_bhb_loop() effective on
 newer CPUs
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc: x86@kernel.org, Jon Kohler <jon@nutanix.com>, Nikolay Borisov <nik.borisov@suse.com>, 
	"H. Peter Anvin" <hpa@zytor.com>, Josh Poimboeuf <jpoimboe@kernel.org>, David Kaplan <david.kaplan@amd.com>, 
	Sean Christopherson <seanjc@google.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, KP Singh <kpsingh@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, David Laight <david.laight.linux@gmail.com>, 
	Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	David Ahern <dsahern@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Asit Mallick <asit.k.mallick@intel.com>, Tao Zhang <tao1.zhang@intel.com>, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 2, 2026 at 5:32=E2=80=AFPM Pawan Gupta
<pawan.kumar.gupta@linux.intel.com> wrote:
>
> As a mitigation for BHI, clear_bhb_loop() executes branches that overwrit=
e
> the Branch History Buffer (BHB). On Alder Lake and newer parts this
> sequence is not sufficient because it doesn't clear enough entries. This
> was not an issue because these CPUs use the BHI_DIS_S hardware mitigation
> in the kernel.
>
> Now with VMSCAPE (BHI variant) it is also required to isolate branch
> history between guests and userspace. Since BHI_DIS_S only protects the
> kernel, the newer CPUs also use IBPB.
>
> A cheaper alternative to the current IBPB mitigation is clear_bhb_loop().
> But it currently does not clear enough BHB entries to be effective on new=
er
> CPUs with larger BHB. At boot, dynamically set the loop count of
> clear_bhb_loop() such that it is effective on newer CPUs too. Use the
> X86_FEATURE_BHI_CTRL feature flag to select the appropriate loop count.
>
> Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
> Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
> ---
>  arch/x86/entry/entry_64.S            |  8 +++++---
>  arch/x86/include/asm/nospec-branch.h |  2 ++
>  arch/x86/kernel/cpu/bugs.c           | 13 +++++++++++++
>  3 files changed, 20 insertions(+), 3 deletions(-)
>
> diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
> index 3a180a36ca0e..bbd4b1c7ec04 100644
> --- a/arch/x86/entry/entry_64.S
> +++ b/arch/x86/entry/entry_64.S
> @@ -1536,7 +1536,9 @@ SYM_FUNC_START(clear_bhb_loop)
>         ANNOTATE_NOENDBR
>         push    %rbp
>         mov     %rsp, %rbp
> -       movl    $5, %ecx
> +
> +       movzbl    bhb_seq_outer_loop(%rip), %ecx
> +
>         ANNOTATE_INTRA_FUNCTION_CALL
>         call    1f
>         jmp     5f
> @@ -1556,8 +1558,8 @@ SYM_FUNC_START(clear_bhb_loop)
>          * This should be ideally be: .skip 32 - (.Lret2 - 2f), 0xcc
>          * but some Clang versions (e.g. 18) don't like this.
>          */
> -       .skip 32 - 18, 0xcc
> -2:     movl    $5, %eax
> +       .skip 32 - 20, 0xcc
> +2:     movzbl  bhb_seq_inner_loop(%rip), %eax
>  3:     jmp     4f
>         nop
>  4:     sub     $1, %eax
> diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/=
nospec-branch.h
> index 70b377fcbc1c..87b83ae7c97f 100644
> --- a/arch/x86/include/asm/nospec-branch.h
> +++ b/arch/x86/include/asm/nospec-branch.h
> @@ -548,6 +548,8 @@ DECLARE_PER_CPU(u64, x86_spec_ctrl_current);
>  extern void update_spec_ctrl_cond(u64 val);
>  extern u64 spec_ctrl_current(void);
>
> +extern u8 bhb_seq_inner_loop, bhb_seq_outer_loop;
> +
>  /*
>   * With retpoline, we must use IBRS to restrict branch prediction
>   * before calling into firmware.
> diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
> index 83f51cab0b1e..2cb4a96247d8 100644
> --- a/arch/x86/kernel/cpu/bugs.c
> +++ b/arch/x86/kernel/cpu/bugs.c
> @@ -2047,6 +2047,10 @@ enum bhi_mitigations {
>  static enum bhi_mitigations bhi_mitigation __ro_after_init =3D
>         IS_ENABLED(CONFIG_MITIGATION_SPECTRE_BHI) ? BHI_MITIGATION_AUTO :=
 BHI_MITIGATION_OFF;
>
> +/* Default to short BHB sequence values */
> +u8 bhb_seq_outer_loop __ro_after_init =3D 5;
> +u8 bhb_seq_inner_loop __ro_after_init =3D 5;
> +
>  static int __init spectre_bhi_parse_cmdline(char *str)
>  {
>         if (!str)
> @@ -3242,6 +3246,15 @@ void __init cpu_select_mitigations(void)
>                 x86_spec_ctrl_base &=3D ~SPEC_CTRL_MITIGATIONS_MASK;
>         }
>
> +       /*
> +        * Switch to long BHB clear sequence on newer CPUs (with BHI_CTRL
> +        * support), see Intel's BHI guidance.
> +        */
> +       if (cpu_feature_enabled(X86_FEATURE_BHI_CTRL)) {
> +               bhb_seq_outer_loop =3D 12;
> +               bhb_seq_inner_loop =3D 7;
> +       }
> +

How does this work for VMs in a heterogeneous migration pool that
spans the Alder Lake boundary? They can't advertise BHI_CTRL, because
it isn't available on all hosts in the migration pool, but they need
the long sequence when running on Alder Lake or newer.

Previously, I considered such a migration pool infeasible, because of
the change in MAXPHYADDR, but I now predict that I will lose that
battle.


>         x86_arch_cap_msr =3D x86_read_arch_cap_msr();
>
>         cpu_print_attack_vectors();
>
> --
> 2.34.1
>
>
>
