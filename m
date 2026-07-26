Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4C153D6465
	for <kvm@vger.kernel.org>; Sun, 26 Jul 2026 17:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785087885; cv=pass; b=Kto97zhw7Ttfc8XG0/umo8iDklrvkv1OtwrwuCdfPL3JeXRlHauqemVTtjo7YfsWjYM4HjLoEr6hldh1FMWeeQldHYBU2sHtkQniKpwoy0fLxdLniUhd7HO+tBQbluJS8wg1Zgf4yvDrU6p3Lr0QoczZvUCt9PenkCEEUDgJSE0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785087885; c=relaxed/simple;
	bh=BP/KhghQOKGxKJzZj2KUQUHzXAFYbyV+K4KVpvKYDLI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tki9mRcvBaaokQ8oXzCHYfsdbHN8w5OUQF6wIwLe4JotYnknaprFdZ3ipflAtRGlrUg5RfimBIpBRd/dZCYKSyumytUfsCsNcLUIP4CRVVtoISU5BdtKzQvvOGslhJdjnzYHGLybLHeurU/TLVO/iJ8VrAY7VJwLGT19LAmFrHU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=allelesecurity.com; spf=pass smtp.mailfrom=allelesecurity.com; dkim=pass (1024-bit key) header.d=allelesecurity.com header.i=@allelesecurity.com header.b=nKVPQovF; arc=pass smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=allelesecurity.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=allelesecurity.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=allelesecurity.com header.i=@allelesecurity.com header.b="nKVPQovF"
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-5bfb5e20a90so1228938e0c.2
        for <kvm@vger.kernel.org>; Sun, 26 Jul 2026 10:44:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785087880; cv=none;
        d=google.com; s=arc-20260327;
        b=IxYOVWqeoGhy6cSoLriDOUKxFNO0yHnmMz10cDcnBX4NWWbH9qESEfmw0Yjdz76IB1
         Rn3xRqkfaOmPq8ZrnnxBv6m36IdQuNDL4bc+rwmSWFH6a+NNFoEjXxrYyE2uj1da6R53
         fA9x06iMqzdKTPeYkg0OZbcrCFOn83JtWvPRCKPJIgTnEGyhUR3+8rFuH1SJ14HtkAsY
         3uyWDYhonrwNYZz/qn4+VG50nIWIJz2Mano0FUGG/gJLN6fPKFFCwGp25bhmo1hXOquI
         owwGa8Av91P5uiwc4dv+1tUDRJWJ7hxaWefLDNsRZwqHJTJ/f/TSHLxZ1uvQrnPpVifF
         D3kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lBazFeGPDjya1ziFJmG/VIjSjBZuYkaa8woZCk5IgWU=;
        fh=7jnjKETOkrTgyl44DtI3Acg/Cz7nSBShV8Y9WoybY/o=;
        b=KusFTG+0bU566jUjquHMc/98i4fRj/hszjIFcnExf31dd10IAxGWfs/B+lpQqeoJoW
         4ka5sSf+0/oPLmREEX+ZbexnGO01sx7w6nb9OvsHqsGvtIzgxqpEWqUAV6e9G3bOoUJE
         nxdcivTzS3NOXTK5fX8E5FFX+iEIYOG+BX0EWHZqjzzHc/n2aG8N9NJ3dktnkIlfzlzi
         58rWqxH+HoWebUQvvvbgwrG6vr8e8Cicr70q6SAP67/ycIplub3XCjM72v5/0A0RGOmW
         +0j6sZRkAgaHhpgJVLjl4D15Tpi7f7KvxSe2wxd9L6ZrSz227yPjY1M/RbT9EKcKT6Vt
         mQaw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=allelesecurity.com; s=google; t=1785087880; x=1785692680; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lBazFeGPDjya1ziFJmG/VIjSjBZuYkaa8woZCk5IgWU=;
        b=nKVPQovFNojgqC2drA1zrrpCA+jWVjfTkdPdTD60domqHsp8wjzkrICDVg5u2O30Fv
         YiX6YTCdtGq4HgIVJaHg/zN5Ax32welf8K4KTUieN2Sdnp8820aYQhV+5XTmoAPft8CY
         p/WXYQGgkpb8ct/CczHHJD01qVVOXlZsfsOBw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785087880; x=1785692680;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lBazFeGPDjya1ziFJmG/VIjSjBZuYkaa8woZCk5IgWU=;
        b=ijBOkz67AzwzzAZWogfPn5MCf9UcnkUn6VikanQf6PT89Hu5mb1vif3Ykx0irMUTCL
         8tAvbVrRrA/Cg9yIrfzAPpCJJZx7nbXlvd/K8H8AMBvOr8CtQW0HImH5UaslJg9CZTrt
         8uAA9Not1Va7aIu5PiatBRbYfywwNLH+EWgFVzPzyFEWR+VjuQwFxxEDrPEvfheYdYsd
         NOndc+g88H5082dJs0JkoJzYNi/QUwh8ZDQNAqFjrIVzAliZ9qR346HRMopxP7ksg7iB
         o4OlRCw5onSkMwE/Xi0El3oGozc8nwN0eFcd1XTTO2t5+8lxzu3LCD4RMHYWUIvRmaSh
         e8eA==
X-Forwarded-Encrypted: i=1; AHgh+Rp3ZP3vM/vtT4L57jLIZjzqUsE5c3Jvf4EsS1nwNWPak6buleUreNmXUCmc26RMAvbRWQs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzE2ehoznruH+CkUAMKNUBLu1G3o2s6un46t51jHawbwmDJc32Y
	uznJzfnXIy90HYA+0bQo4IeVTdA/wL7AdObNGOtTx9WYJz4wuN6+48BMAgtyfxmbFZPKAumiV4Y
	SKYAz/8bfE3i08HDEzb4/HG5t2pdBhBUWLMMXpYbH3ywyoi4RshdONvSMcg==
X-Gm-Gg: AR+sD12TxQSqn9wJeedhZMWwKQVBv8ohxQ/XZnncgCOnQ4ppfH5dqpS0yHI0avDUDgW
	E2bL6Myiml5WfbmPizjy+irNI/puPaShHSM1jb29xdIWJRvhwPbVfnIxC1WzXRkIyPt1sRem2kG
	OBUPbixl0999U7HrbdatUMtWrykXgtufhcShhojds4pxYHWuFbPrVFgS4Tr6V1u+iOdFswB/rb/
	aRRvku+bS6dsG0G4gWh35NTwKyYkwByNbUAHo9GdnwO3GlKJxkqT9K0a7BxiMYz
X-Received: by 2002:a05:6122:e146:b0:5c2:c0de:d291 with SMTP id
 71dfb90a1353d-5c306d29141mr2758869e0c.9.1785087880421; Sun, 26 Jul 2026
 10:44:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260602140348.774203-1-anderson@allelesecurity.com>
 <20260602140348.774203-2-anderson@allelesecurity.com> <amHVTvcDeQXdrIbg@intel.com>
In-Reply-To: <amHVTvcDeQXdrIbg@intel.com>
From: Anderson Nascimento <anderson@allelesecurity.com>
Date: Sun, 26 Jul 2026 14:44:29 -0300
X-Gm-Features: AUfX_mwEM1sAVwfqQ9KFEyeMfXQrvaiScXIYhW_fw1yntHE0S9k3iwwVP-VnFrA
Message-ID: <CAPhRvkze0VmWDZb2+w0ZiDvT6rzkb6j3+sZe_tUM3p1-DRrk0Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] target/i386: Add support for KVM APERF/MPERF passthrough
To: Zhao Liu <zhao1.liu@intel.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, pbonzini@redhat.com, 
	mtosatti@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Zhao,

On Thu, Jul 23, 2026 at 5:48=E2=80=AFAM Zhao Liu <zhao1.liu@intel.com> wrot=
e:
>
> Hi Anderson,
>
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
>
> Considerring APER/MPERF passthrough have many specific restrictions
> (listed in KVM's api.rst, "7.13 KVM_CAP_X86_DISABLE_EXITS"), I think
> we also need not to enable it by default for max/host CPUs:
>
> .no_autoenable_flags =3D CPUID_6_ECX_APERFMPERF
>
> This indicates that users must manually enable this feature, and it is
> assumed that they are aware of its limitations and have implemented
> appropriate policies (such as no preemption, vCPU affinity, no idle or
> C state in the guest, etc.).
>

It makes sense! I didn't know that, thanks.

> > +    },
>
> ...
>
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
>
> if we bind this feature to cpu-pm, then we should check enable_cpu_pm
> before setting CPUID. Otherwise, if this CPUID is present but
> cpu-pm=3Doff, Guest may try to access related MSRs and triggers #GP.
>
>         if (enable_cpu_pm) {
>             int disable_exits =3D kvm_check_extension(s,
>                                                     KVM_CAP_X86_DISABLE_E=
XITS);
>
>             if (disable_exits & KVM_X86_DISABLE_EXITS_APERFMPERF) {
>                 ret |=3D CPUID_6_ECX_APERFMPERF;
>             }
>         }
>
> But on the other hande, maybe we don't need to bind this feature to
> cpu-pm?
>
> For example, a compute-intensive workload doesn't allow the Guest to
> enter idle, then it still seems make sense to estimate performance
> using aperf and mperf?
>

I had put it under the cpu-pm option because it seemed like the
easiest step to enable that feature, as it already talks to KVM to do
a few pass-throughs (MWAIT, PAUSE, and so on). But re-checking this
now, I agree that the aperf/mperf feature doesn't have much to do with
the other cpu-pm options. I'll try a v3 with it as a standalone
feature as soon as possible. If there's anything else, please let me
know. Thanks again!

> Thanks,
> Zhao
>

--
Anderson Nascimento
Allele Security Intelligence
https://www.allelesecurity.com
