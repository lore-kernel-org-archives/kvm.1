Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B91FB390224
	for <kvm@vger.kernel.org>; Thu, 27 Aug 2026 17:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787852030; cv=none; b=lAqyvzBGbTP3x1SUPBkuN32DGuHIP7Q1aYq09cHtqr6MybViabzu/vQL8m6AAY4qudeLxoUnl0kdJri7SpjbAZL+tjhlJaa/SCzF5D+0+olMhEG9FqLJUBbvuWskWhGRJCw8AV9hWPeT/iDjdNDe8JsSMGbwMnFTSg82Rf2Zuso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787852030; c=relaxed/simple;
	bh=mQBC4ZInVAewkqG/uEXWTGggvkR3ICtM2BRnNn8cVvU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=awgJd7QVoGLoNNATcBPjXThohQGsndbIURifzojl0LODp6VsVVSDSNosbU1I+ukGIZ2KN8SrxwwUAmJpiydr+GijXhuVxP38SJwMGVd7+aEcMVuXVSCrO6rnjjQVtv6J8Me4ETA/xXLbxwVOUMhDM+3R1S0PpPLcU/I2sAw4HbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=n/TMbnQo; arc=none smtp.client-ip=209.85.215.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n/TMbnQo"
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cc1c057f480so155279a12.0
        for <kvm@vger.kernel.org>; Thu, 27 Aug 2026 10:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787852028; x=1788456828; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=A0Qync/lpbri7HzFIMP3cl9pdBpZkpuA/yuJrcyMO2s=;
        b=n/TMbnQoerCb/xA6HZywi0Wbc8OnPQ4N9bSILkh81hQXNmo6cNEflo97gBqFs8K8/7
         ekmoAbV9L1dAvZqtLdRyP7E1LQ+lcJRE/iwIV2k5fbb9gKMb225rQnD9ldB+J+1ri7A8
         yiZS1OX2+21IqkTNqFJOZsvzt67NEbLEu7bXA9gbVbiab2WkJbf3f/j1b3z+wlHElJb5
         piHftlkDyC5DnVbRV3SI/WSGjUsin6KAa8iKOm+GnyLo0onDc0AjBWa7UurZlZt1fhhF
         VetCQXjikWSNQ87YXGeoMwWT5kBnjcFWBuujJ49TWIb38m7QnEV1YX0pYtmNxJlEXPFO
         PTVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787852028; x=1788456828;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=A0Qync/lpbri7HzFIMP3cl9pdBpZkpuA/yuJrcyMO2s=;
        b=kbz8NtiRWd6x9vlRpT7sBDnRUBTHnMIfgrYpLT2alU4zYxG9aJz3Im99dsfW9psTSs
         N3+mn7LJU9/TK92xHEpKjmYMV80zpTpeYQLHJeIMO/euZW83MjRkbTA3RbIr/6zaPHO8
         nEwzw9Fj3Doy87KFPZ8JZnzP5jtURDy3aZAklEMKmC3fzl9Og+kzjolMPo4UWEYIES2g
         1lx+EFSNBz21h47HCkLM1TFWyGgaN4uJK0z2qssbWXF8KzVT2pnH1cMpbcBQBhnCiWCP
         NPwD7NyRZSFDHGPRvYtDJaUGpZZuTbsXvJEptu8BG/UGrSZjmxP0hjP2iAhaJp71vZ4d
         OMBw==
X-Forwarded-Encrypted: i=1; AHgh+Rr+i+PIQlGUWWklvN9wd8jXOKpe/wgbes2CZhdSXH0nKtNLuhe69Ur1xA6rY+sNQGtJYQ8=@vger.kernel.org
X-Gm-Message-State: AFuF++mC2RhrfJm4CqwVnydnjCWGg4cBVX4FGxktZyiwphGk2T4+35Tx
	Qu/KpnbcTF53S0QKftEmwhWebTEV+HeVe0U+riONPfpyj+H6L1FKu37hmj+YlLkS1w49vHMULSz
	hAwINYQ==
X-Received: from pgah16.prod.google.com ([2002:a05:6a02:4e90:b0:cc1:d46e:147a])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:b7a7:b0:3be:b0b3:3962
 with SMTP id adf61e73a8af0-3d268ef9e07mr994999637.9.1787852027735; Thu, 27
 Aug 2026 10:33:47 -0700 (PDT)
Date: Thu, 27 Aug 2026 10:33:47 -0700
In-Reply-To: <CAO9r8zOLJs_fm9ixxCRV=uz5qwpOS67=oz5ATGtB=w2Yd2vtOw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260826233919.998904-1-seanjc@google.com> <20260826233919.998904-13-seanjc@google.com>
 <CAO9r8zOuD+wU1Q80z077WHHpFBWvKomLk=TaXjH3gVnqj=mqFQ@mail.gmail.com>
 <apBomFOn1ZqHEnAQ@google.com> <CAO9r8zP3O_80Lr=4eKL6v-OaM9etMXPsNzADizf6ztB6YBuLHA@mail.gmail.com>
 <apBxMrqEkl_7khix@google.com> <CAO9r8zOLJs_fm9ixxCRV=uz5qwpOS67=oz5ATGtB=w2Yd2vtOw@mail.gmail.com>
Message-ID: <apB0-xly771CU7m_@google.com>
Subject: Re: [PATCH v3 12/13] KVM: selftests: Dedup assembly code for VMLAUNCH
 and VMRESUME
From: Sean Christopherson <seanjc@google.com>
To: Yosry Ahmed <yosry@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	f734222792@gmail.com, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Sashiko Bot <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 27, 2026, Yosry Ahmed wrote:
> On Thu, Aug 27, 2026 at 10:17=E2=80=AFAM Sean Christopherson <seanjc@goog=
le.com> wrote:
> > eVMCS is a memory operand, i.e. it's MOV RSP, [evmcs->host_rip].  The e=
xisting
> > evmcs_{vmresume,vmlaunch}() code is rather stupid and loads the address=
 into a
> > register, and then manually encodes MOV RSP, [<reg>].
>=20
> Can't we keep it as a register operand just to avoid vmwrite_operand?
> Does it actually hurt in any way?

...

> > diff --git tools/testing/selftests/kvm/lib/x86/vmx.c tools/testing/self=
tests/kvm/lib/x86/vmx.c
> > index 1a8515de42b0..b5efd10950c7 100644
> > --- tools/testing/selftests/kvm/lib/x86/vmx.c
> > +++ tools/testing/selftests/kvm/lib/x86/vmx.c
> > @@ -179,7 +179,10 @@ void load_vmcs(struct vmx_pages *vmx)
> >         vmclear(vmx->shadow_vmcs_gpa);
> >  }
> >
> > -#define __BUILD_VMX_VM_ENTRY_HELPER(insn, prefix, vmwrite_insn, vmwrit=
e_operand,       \
> > +const u64 HOST_RSP_ENCODING =3D HOST_RSP;
> > +const u64 HOST_RIP_ENCODING =3D HOST_RIP;
> > +
> > +#define __BUILD_VMX_VM_ENTRY_HELPER(insn, prefix, vmwrite_insn,       =
 \
> >                                     __host_rsp, __host_rip)            =
                 \
> >  static int __##prefix##_##insn(void)                                  =
                 \
> >  {                                                                     =
                 \
> > @@ -196,16 +199,17 @@ static int __##prefix##_##insn(void)             =
                                         \
> >                              VMX_SWITCH_GPRS_ASM                       =
                 \
> >                              "pop %%rax;"                              =
                 \
> >                              : [ret]"=3D&a"(ret)                       =
                   \
> > -                            : [host_rsp]__stringify(vmwrite_operand)(_=
_host_rsp),      \
> > -                              [host_rip]__stringify(vmwrite_operand)(_=
_host_rip),      \
> > +                            : [host_rsp]"m"(__host_rsp),              =
                 \
> > +                              [host_rip]"m"(__host_rip),              =
                 \
>=20
> I suppose we can use "r" here though?

No, because then the encoding for VMWRITE needs to be:

  vmwrite %%rsp, %[host_rsp]

but for MOV/eVMCS needs to be:

  mov %%rsp, (%[host_rsp])

Have fun feeding the '(' and ')' into the asm blob :-)
