Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B6003806D5
	for <kvm@vger.kernel.org>; Wed, 15 Jul 2026 15:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784131183; cv=pass; b=X1peCxGIXD0ClT72b/BdMkb+LkTy4RYhdZTW+bufUHUfNolx2HprME0BFX16H1cl38CIBwNK7Eo2HV5Lp/VQm8v1e9F3b/A6T7uqgJmcT+uqy5gsBbxDGNhxOwL08L75J5HnIy0kj70+ru09EZH1EzehWcyel1KRYbxS3P+HviQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784131183; c=relaxed/simple;
	bh=TyXS7pUiDmzE7t8/0teviSeFSxE7IhseHpRKW3BuP1o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=qs1Zxdqm5Px8CAEf289YqMKUlrMlLp8/atiPcRDMNwDhC2ZCOe/baVUloic22Cn7ySXzo6x6EZ42ytV7LloWKgfexp9FOQ8y0pZ8UUJIDEgxEaHU2/qvltgKp1GeZ1vKB3ldTRvoQ13gUf8MwyEXkZs0Y5nIZby9ORyTyN+IgAw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=allelesecurity.com; spf=pass smtp.mailfrom=allelesecurity.com; dkim=pass (1024-bit key) header.d=allelesecurity.com header.i=@allelesecurity.com header.b=hm28C01v; arc=pass smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=allelesecurity.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=allelesecurity.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=allelesecurity.com header.i=@allelesecurity.com header.b="hm28C01v"
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-5bf9466412fso1406551e0c.1
        for <kvm@vger.kernel.org>; Wed, 15 Jul 2026 08:59:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784131180; cv=none;
        d=google.com; s=arc-20260327;
        b=EbODTqwm1ZWNQtuFlD/D8oTsh0MpuP3R26nlFLqfH4w8CSgoTDC2FnRYX3vyDeFJCG
         DVN8nBbtrRo7J54izwT/ATYxOu0KtPREUTxwHW87S28eK2KVps7XF2RghSsK9h/7ImCA
         /NEIXHFwYpqLSod4DNg07IVUm1MOmDA01UOy/nCZyB9rxa46+GAoMrSb70aLCiRYNJeK
         /ideXOIkIuBsOJFTuhKO017vulnHof+odCcWWiAD6ke9b7N4Ruy5P8bTF3jqMRp978gT
         2rGAcgHya9SQc09ZxlZihnsvQDCnUChT+KgdCwUsvu1nbR15N5VkG3Zz+2NhpFEZqrat
         sPRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zGnxGAET//9Y4WKMnCX3s20e63rd8ucTUvBb9i7O1uI=;
        fh=a1ountz0TdWs5QJD+O62XjyurXny3JpFVuTjnI497c4=;
        b=a7qd5FyTEhfOQeOz/iGvtOC32inxtr3dl//LRnFb4n1/mwSNic//PIQsvDb9xApqzX
         N9oIFJxlwjeiwGuw0kttu+OP9Y6EG7YeS3zaf72TUqyl9wzv7q+BpXm4pAqGk76Y11a8
         P0Q/gptg79wn6AuEwJGB85Zt1JzS1zFeCu/2dZ49aIs3OOXsrpk/shVD/pxVRIn98Bnj
         C06UOS6pmbHaZG/lZZ0qDHTESD8BHUj83UjEUAnE5mwBXPpaZsUOPEcQVlnTUzMzDl+U
         GcJVsB1D8ZxrWFpIfGEUw9NiWfIs+dnmMqDfGoPBv+ZvOSk7JWXtpSTcz2u7ne4g9Xa2
         MI/Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=allelesecurity.com; s=google; t=1784131180; x=1784735980; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zGnxGAET//9Y4WKMnCX3s20e63rd8ucTUvBb9i7O1uI=;
        b=hm28C01veI5LOlmRkEaKo4mxGPBFzQBXRpC68DgCDDlgQ2KFPCx30LykxuDzK69qoS
         Lu+Sxlhw5PRtMdY/GS3+UD9H9WksQclStUbtrcJQQGTYhjitt8yvJPA4rVXDsFPEvjL4
         3HrrOp+VwFn4TDw4sMlgCcRxfOyQ/pyfEuNT0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784131180; x=1784735980;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=zGnxGAET//9Y4WKMnCX3s20e63rd8ucTUvBb9i7O1uI=;
        b=JeNcuQmPLXgT3/7sNq8I4WQIwhfh+EVsrgRf1h1nTX6Dj9pYQoIbvxhC+f9c07qPZg
         o4CIzeKgUnLyHABnNP5praR+D8Z2bEW1ojkPDqGDzUxNll3ihrsCBKaKxlRqGcQJn72Y
         1D78ysMVTCTAUZv5bTyCJGNiTTowHS1ra/uiQBX1VSdMoiPFLaLrmbAmWK81pJjpwoeP
         RutadcjmbxbNN0eW28rdZ2EGYBqfFNAHu3p/4h2ze/nUmRi18ycuEQwOWPN5rZHI/QB3
         IMwQBNMokGcoteVbZq/+5+IBqtJ8Fr/GnTaUxdsj1brsmJWVLc4uMQlV5KM9PaOGOlEJ
         Ryzw==
X-Forwarded-Encrypted: i=1; AHgh+RrJcJJcSTDAFjwuw8dDvzCFV9JPLuBHHRDEenkpl5FttPUWOzieRJakWxsc4kO34elAidQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzR06Po18K0SFgIp30M8q7yunprV58A157MoHaInEtGeunNuHuJ
	YRUlKD4UY6IHA+Rl6DCYIFyh/sMyDx5DV4G2cbOvw7u5zljlxcntrR738X37eCwfwbwWTo2dQ6O
	DJ4WwGr7CeiKFiaocSnpUuWbhoURMujPJamNysj3n+g==
X-Gm-Gg: AfdE7cmzyM6ZXRtFXWpyK8YntkZ3MGdBJRrxokN7j4bFOpR55W60A3I5kpHa/rHPjCB
	b6zzYPqOhS4l6e5pFB/+TggHhDPMlB8E70+PELKJnnQ3RFpvVDtOZLIQEERQy8E2NxljcRXLul9
	ogEU5OsfK8D4/JxIwB89PNu6nsfMKSo62i8I+S7FADfMpRiwBBgh6DSEsRgXhlVttR2IoAjCPjm
	ZCF/A9A4d6HyKAJQ+koul0YLcCk+OeTz0rmMFbB2YwniMqPbyeLjOb+3TCDZSvxEF7zGL5UyMM=
X-Received: by 2002:a05:6122:83f2:b0:5bd:ecad:8f9c with SMTP id
 71dfb90a1353d-5bfbf172175mr10635021e0c.6.1784131180332; Wed, 15 Jul 2026
 08:59:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260602140348.774203-1-anderson@allelesecurity.com>
 <20260602140348.774203-2-anderson@allelesecurity.com> <CAPhRvkygtCgfHaD5eHT-aFKSnQ1OA9-YBDOFNNwX+SukYFrhPA@mail.gmail.com>
In-Reply-To: <CAPhRvkygtCgfHaD5eHT-aFKSnQ1OA9-YBDOFNNwX+SukYFrhPA@mail.gmail.com>
From: Anderson Nascimento <anderson@allelesecurity.com>
Date: Wed, 15 Jul 2026 12:59:29 -0300
X-Gm-Features: AUfX_mwmwtPYmQoqSteupvHqXSL1ozAcd3PCwNoeSxprkSlYvVt9OGA1dlMAwtA
Message-ID: <CAPhRvkw2xtE2n5q4cA=0CBxMM_CMdw2n_Z_c6ZdtEJMXhwy6BA@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] target/i386: Add support for KVM APERF/MPERF passthrough
To: qemu-devel@nongnu.org, kvm@vger.kernel.org, pbonzini@redhat.com, 
	zhao1.liu@intel.com, mtosatti@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

ping

On Thu, Jun 25, 2026 at 9:50=E2=80=AFPM Anderson Nascimento
<anderson@allelesecurity.com> wrote:
>
> On Tue, Jun 2, 2026 at 11:05=E2=80=AFAM Anderson Nascimento
> <anderson@allelesecurity.com> wrote:
> >
> > Introduce support for exposing and enabling APERF/MPERF MSR passthrough
> > for x86 QEMU guests when running under KVM.
> >
> > The Linux kernel supports a KVM capability allowing the hypervisor to
> > disable read intercepts on the IA32_APERF and IA32_MPERF MSRs, enabling
> > guests to track effective frequency directly without VM-exits. QEMU
> > currently lacks a native way to request this capability or expose the
> > corresponding feature bit to the guest.
> >
> > This patch adds the `aperfmperf` feature flag via `FEAT_6_ECX`
> > (CPUID.06H:ECX[bit 0]). To ensure safe tracking across power states,
> > the flag ties into QEMU's existing host power management framework.
> > When host CPU power management is explicitly requested by the user
> > (via `-overcommit cpu-pm=3Don`) and the `+aperfmperf` flag is provided
> > to the CPU, QEMU will invoke the KVM ioctl to drop the APERF/MPERF
> > MSR read intercepts.
> >
> > This implementation allows guest operating systems (such as FreeBSD
> > or Linux) to dynamically calculate CPU utilization and turbo-boost
> > metrics without incurring performance overhead from hypervisor trap-and=
-
> > emulate loops.
> >
> > Signed-off-by: Anderson Nascimento <anderson@allelesecurity.com>
> > ---
> > Changes in v2
> > - Added migration flags
> > - Link to v1: https://lore.kernel.org/all/20260602022048.752453-1-ander=
son@allelesecurity.com/
> >
> >  target/i386/cpu.c     | 18 +++++++++++++++++-
> >  target/i386/cpu.h     |  2 ++
> >  target/i386/kvm/kvm.c |  5 ++++-
> >  3 files changed, 23 insertions(+), 2 deletions(-)
> >
> > diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> > index 8929a75c7c..544738d406 100644
> > --- a/target/i386/cpu.c
> > +++ b/target/i386/cpu.c
> > @@ -1544,6 +1544,22 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS]=
 =3D {
> >          .cpuid =3D { .eax =3D 6, .reg =3D R_EAX, },
> >          .tcg_features =3D TCG_6_EAX_FEATURES,
> >      },
> > +    [FEAT_6_ECX] =3D {
> > +        .type =3D CPUID_FEATURE_WORD,
> > +        .feat_names =3D {
> > +            "aperfmperf", NULL, NULL, NULL,
> > +            NULL, NULL, NULL, NULL,
> > +            NULL, NULL, NULL, NULL,
> > +            NULL, NULL, NULL, NULL,
> > +            NULL, NULL, NULL, NULL,
> > +            NULL, NULL, NULL, NULL,
> > +            NULL, NULL, NULL, NULL,
> > +            NULL, NULL, NULL, NULL,
> > +        },
> > +        .cpuid =3D { .eax =3D 6, .reg =3D R_ECX, },
> > +        .tcg_features =3D 0,
> > +        .unmigratable_flags =3D CPUID_6_ECX_APERFMPERF,
> > +    },
> >      [FEAT_XSAVE_XCR0_LO] =3D {
> >          .type =3D CPUID_FEATURE_WORD,
> >          .cpuid =3D {
> > @@ -8770,7 +8786,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t ind=
ex, uint32_t count,
> >          /* Thermal and Power Leaf */
> >          *eax =3D env->features[FEAT_6_EAX];
> >          *ebx =3D 0;
> > -        *ecx =3D 0;
> > +        *ecx =3D env->features[FEAT_6_ECX];
> >          *edx =3D 0;
> >          break;
> >      case 7:
> > diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> > index 67e2ecf325..87864969c7 100644
> > --- a/target/i386/cpu.h
> > +++ b/target/i386/cpu.h
> > @@ -700,6 +700,7 @@ typedef enum FeatureWord {
> >      FEAT_SVM,           /* CPUID[8000_000A].EDX */
> >      FEAT_XSAVE,         /* CPUID[EAX=3D0xd,ECX=3D1].EAX */
> >      FEAT_6_EAX,         /* CPUID[6].EAX */
> > +    FEAT_6_ECX,         /* CPUID[6].ECX */
> >      FEAT_XSAVE_XCR0_LO, /* CPUID[EAX=3D0xd,ECX=3D0].EAX */
> >      FEAT_XSAVE_XCR0_HI, /* CPUID[EAX=3D0xd,ECX=3D0].EDX */
> >      FEAT_ARCH_CAPABILITIES,
> > @@ -1232,6 +1233,7 @@ uint64_t x86_cpu_get_supported_feature_word(X86CP=
U *cpu, FeatureWord w);
> >  #define CPUID_XSAVE_XFD        (1U << 4)
> >
> >  #define CPUID_6_EAX_ARAT       (1U << 2)
> > +#define CPUID_6_ECX_APERFMPERF (1U << 0)
> >
> >  /* CPUID[0x80000007].EDX flags: */
> >  #define CPUID_APM_INVTSC       (1U << 8)
> > diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
> > index 9e352882c8..ca722ff9e9 100644
> > --- a/target/i386/kvm/kvm.c
> > +++ b/target/i386/kvm/kvm.c
> > @@ -498,6 +498,8 @@ uint32_t kvm_arch_get_supported_cpuid(KVMState *s, =
uint32_t function,
> >          }
> >      } else if (function =3D=3D 6 && reg =3D=3D R_EAX) {
> >          ret |=3D CPUID_6_EAX_ARAT; /* safe to allow because of emulate=
d APIC */
> > +    } else if (function =3D=3D 6 && reg =3D=3D R_ECX) {
> > +        ret |=3D CPUID_6_ECX_APERFMPERF;
> >      } else if (function =3D=3D 7 && index =3D=3D 0 && reg =3D=3D R_EBX=
) {
> >          /* Not new instructions, just an optimization.  */
> >          uint32_t ebx;
> > @@ -3291,7 +3293,8 @@ static int kvm_vm_enable_disable_exits(KVMState *=
s)
> >          disable_exits &=3D (KVM_X86_DISABLE_EXITS_MWAIT |
> >                            KVM_X86_DISABLE_EXITS_HLT |
> >                            KVM_X86_DISABLE_EXITS_PAUSE |
> > -                          KVM_X86_DISABLE_EXITS_CSTATE);
> > +                          KVM_X86_DISABLE_EXITS_CSTATE |
> > +                          KVM_X86_DISABLE_EXITS_APERFMPERF);
> >      }
> >
> >      return kvm_vm_enable_cap(s, KVM_CAP_X86_DISABLE_EXITS, 0,
> > --
> > 2.54.0
> >
>
> ping
>
> Is there anything I should do to get this patch applied?
>
> --
> Anderson Nascimento
> Allele Security Intelligence
> https://www.allelesecurity.com



--=20
Anderson Nascimento
Allele Security Intelligence
https://www.allelesecurity.com
