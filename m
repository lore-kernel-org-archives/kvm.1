Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7322A325704
	for <kvm@vger.kernel.org>; Fri, 10 Apr 2026 03:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775793025; cv=pass; b=X1PyojtovONGsBNNnDrd9TKbhPFBYruPadyhrq6DenvSrPUEBbJVMOfEQVQsA1Sfr6+tZX2T5Zm3V6BsDSbasas5ClJxZ/LAuGxsw7j7Hbxo/TZFjVtUVXySfDrFzjOMkxWAvGyazct3oCZ0uQwQZV3edrTZ5tv9J673vLBf/xY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775793025; c=relaxed/simple;
	bh=QFDtnUQPk5gEHDUsVIkKs5j9DY4EdvDqYEWsAMEddMY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qeVJsrbFZ4zr6ZGekO3+M5IdQNYo6AWGB+piP+9cN/d3H+urVwCdsJ7OAV3yEX+DR90tnjt7iznzGrAghzXZpPF9bmZv2AzH8YRMnaiNltc3pgMsQgiZgXVwgeLGGl4CNHYLoE6jrdmbR6sYnQOsRrGv+V//39WCGS8zHpY2SaE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cU/XSOx8; arc=pass smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cU/XSOx8"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-67070d9ba4dso4979a12.0
        for <kvm@vger.kernel.org>; Thu, 09 Apr 2026 20:50:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775793020; cv=none;
        d=google.com; s=arc-20240605;
        b=EAJ8+ixv19WUlYqIXbZjYSCC8TK95EGIr+qbT9SxbUpcaRiQwnNBor5BW1vuPKLWr7
         S0Hjj3gb4jxtiZUz0dvvSKiCM+jF00AtI93DLPRl8vKtgOJVQrXIn0aLDnKwFiOS47nT
         4x0okmvLgfgR44Bn2XAhoPvo6CG2L3bx56jxSYnh5AjFpOkgzp919a3brwqvSOFaMNR7
         gPLcin2qz3lBiK7Qxstqov7aAmyhHdyQ27Pwyh15evbHQkBMpiIkOvEUKt4jFhDxzN9Q
         PNuROISxMt3fdfZbRM/Q+EghLT+XoKeLY4ns2FBfvHn4PrXvGxU2535DEGyWNJlwuST1
         yH1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DrC22ug17k70UseF89ggW/5LKWrpVK8ivC7K6E40Ln0=;
        fh=60bk3NWli9+9bPY50J5fkwJ924Lux+go0gNWdgK+HcQ=;
        b=Ed37p9O9yF3dT+j7HBHPt9XUfaGp4WZQFGIsEhoV/TnY2IKGa1hzs7kpnooMedpaXt
         jRlU3cm9oEuDGYEId7POaMqbb493pqxzrwc/wCOX4BnMRtra4vaC7rYYRtjccwVBqdrl
         8FTTJFLbXauLw44weKfN/9ZylstwwuWk6zGHSpnFR1bdqIoPuy4VZ7dHmnOA68kfJRJZ
         gtILb7KyYT/rfUIYiA2c5jldrZbDhAogQvh5h/qBomfPFERRt9LttJsxo5smTaZyLIAS
         ZkuSLb035WdyEx0LXgDwmVl8nDz6B08wfGnVm39a+ur+5QTQ8MqJBZjYzso9/a/t5MIs
         kbFA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775793020; x=1776397820; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DrC22ug17k70UseF89ggW/5LKWrpVK8ivC7K6E40Ln0=;
        b=cU/XSOx8YHp6VN8nSqN2Fh+tT1yYW4P3zoELRkdW0aCHF1HQAuJkdfK7Xrgx75eCzw
         EIOurEAvn9N4s3Vz7ii9feyhhQx+NB0aExdboj8USt/8AaxBzASXa5xJBrEFHdiHVPF9
         OQSu7T5thAhuQ9mS9d9MaTChEz2tyxRx3rJG1vHPUL1gVF7CXPmmGtU/S67MxFAlX7a7
         eYnREl1io0gICxrMsqvmsloHJ5BxA0lLJIVFqzQxzj2APmMBuFdnFYC3cFsHldbYL+wX
         d3zwlvpdA4JsqJ07jdf7qNBtrS+aSQ4UqqHfXi2MXli3TgRhCHl6cIl81r5SKdLLbcLt
         DpSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775793020; x=1776397820;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DrC22ug17k70UseF89ggW/5LKWrpVK8ivC7K6E40Ln0=;
        b=a2Mrlpfgsgm72e2PiusbInF1j//EIi8V6oglAQf1O/AFNinYoMT5iXVFPBoTdp23vP
         k/CtHMn6J85xhtESnuPNBIQgXKl0wde83lJDwJKoxsrf9/uJrrBIZih5Yl1nl9qeL1Bv
         5C4LeNR8OWxTUw5ZTzwBPhDHl49HR5LE1RlnkrwK9U6sMJb97D3c6AvQtbO0/3HctjFe
         KkrwKGxAtyFu95L5uSEh2merYsd2FPwdnUxYA9Zoy12GV5UEtOsU1iZVZ1pH5yiS0MVN
         ZgP12/TQtpylvFTHhJ9ZqZ38y7C+BcikYF0cmPmrNqZsOK9LQ7wghwQR5Oax4MMYbOVO
         qkZQ==
X-Forwarded-Encrypted: i=1; AJvYcCXKkOPC6daxPmN4OamkOgSvT0bzeJ4bsxaZDfWYVn5HFvNJxWV2hTwjbeG+hgqp2GZTXEA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjXErp+D2vNj+/ZiDfZzDpU1erpAHo9pXYsI/SLvQeLLRj6fvj
	xUR2bysXmCmShuo68J9yxB6dyD7Zpd1cdJ5Ibr1OE0E+2bB6/s1yV6DVpOIVAfCNoFnDaoYzr81
	Ys7Lch1vikdPNGp9ixuAsaxLecOGxeuUSUY3btt/p
X-Gm-Gg: AeBDietISS40ASWdQZVaEGuC2oQ2fjS2pqfP2gweMcnRKtBja/rag0+ZwDJajqmVrc+
	J977daWaJ/MCExLjVw745yD7SvNMCeGCRAZX7WzhhXAErccOJVP0WZAvaY/L0irvDYqZ+AXrWbO
	KyXfM8P1hrrZi8G80BQCdYujHEcGVKQH/uk0Va30UM8+HVNLlUAzbkvlqw+NTtYZtGz4Cb31jD+
	MUwmlzi7zT0h+C6sEbKPt4hs5gsmNsevouYlOYkF+wIi6nUU3G00/HcEsDe9M8kg1H1XkAhF8iu
	mRzt5S9wRHfrZVAwWg==
X-Received: by 2002:aa7:d5c7:0:b0:670:7177:94df with SMTP id
 4fb4d7f45d1cf-67071779575mr15522a12.6.1775793020070; Thu, 09 Apr 2026
 20:50:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260326031150.3774017-1-yosry@kernel.org> <20260326031150.3774017-5-yosry@kernel.org>
 <CALMp9eRk8O-kGixdXC0Lb0=PgSVE5eFnLLXOZYqMsb=FTczZTA@mail.gmail.com>
 <adfgPwgXz1iQHpVS@google.com> <CALMp9eRLpZtpmdH4LJGdNkFO_hdJFw0i9MS94Ou1_GKHADq13w@mail.gmail.com>
 <adfmVXRwzZkvRSnj@google.com> <CALMp9eTvH1Pg0Eb-KCcX7LLJPFgS1xTSR0DzeA8xo4Re7=p=7w@mail.gmail.com>
 <adfyKU5WUiW4OnUg@google.com> <adgYSnE-I1Z19fCY@google.com>
In-Reply-To: <adgYSnE-I1Z19fCY@google.com>
From: Jim Mattson <jmattson@google.com>
Date: Thu, 9 Apr 2026 20:50:07 -0700
X-Gm-Features: AQROBzB_CuAgMlZ1uVt_ThQxCy-3JTTnKSV4YW_aTVWML0PBS1psMcdNZMEVE_U
Message-ID: <CALMp9eSjAoVYk2f_j=b_X=EngJ935J=W7YS-C0nDS7b1j2Y4Og@mail.gmail.com>
Subject: Re: [PATCH v4 4/6] KVM: x86/pmu: Re-evaluate Host-Only/Guest-Only on
 nested SVM transitions
To: Sean Christopherson <seanjc@google.com>
Cc: Yosry Ahmed <yosry@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 9, 2026 at 2:21=E2=80=AFPM Sean Christopherson <seanjc@google.c=
om> wrote:
>
> On Thu, Apr 09, 2026, Sean Christopherson wrote:
> > On Thu, Apr 09, 2026, Jim Mattson wrote:
> > > On Thu, Apr 9, 2026 at 10:48=E2=80=AFAM Sean Christopherson <seanjc@g=
oogle.com> wrote:
> > > > On Thu, Apr 09, 2026, Jim Mattson wrote:
> > > > > > > In general, this deferral is misguided. The G/H bits should b=
e
> > > > > > > re-evaluated before we call kvm_pmu_instruction_retired() for=
 an
> > > > > > > emulated instruction.
> > > > > > >
> > > > > > > > ...
> > > > > > > > diff --git a/arch/x86/kvm/x86.h b/arch/x86/kvm/x86.h
> > > > > > > > index f1c29ac306917..966e4138308f6 100644
> > > > > > > > --- a/arch/x86/kvm/x86.h
> > > > > > > > +++ b/arch/x86/kvm/x86.h
> > > > > > > > @@ -9,6 +9,7 @@
> > > > > > > >  #include "kvm_cache_regs.h"
> > > > > > > >  #include "kvm_emulate.h"
> > > > > > > >  #include "cpuid.h"
> > > > > > > > +#include "pmu.h"
> > > > > > > >
> > > > > > > >  #define KVM_MAX_MCE_BANKS 32
> > > > > > > >
> > > > > > > > @@ -152,6 +153,8 @@ static inline void enter_guest_mode(str=
uct kvm_vcpu *vcpu)
> > > > > > > >  {
> > > > > > > >         vcpu->arch.hflags |=3D HF_GUEST_MASK;
> > > > > > > >         vcpu->stat.guest_mode =3D 1;
> > > > > > > > +
> > > > > > > > +       kvm_pmu_handle_nested_transition(vcpu);
> > > > > > > >  }
> > > > > > >
> > > > > > > This happens too late for VMRUN, since we have already called
> > > > > > > kvm_pmu_instruction_retired() via kvm_skip_emulated_instructi=
on(), and
> > > > > > > VMRUN counts as a *guest* instruction.
> > > > > >
> > > > > > It's just VMRUN that's problematic though, correct?  I.e. the s=
cheme as a whole
> > > > > > is fine, we just need to special case VMRUN due to SVM's erratu=
m^Warchitecture.
> > > > > > Alternatively, maybe we could get AMD to document the silly VMR=
UN behavior as an
> > > > > > erratum, then we could claim KVM is architecturally superior. :=
-D
> > > > >
> > > > > Here, it's just VMRUN. Above, it's WRMSR(EFER).
> > > >
> > > > But clearing EFER.SVME while in the guest generates architecturally=
 undefined
> > > > behavior.  I don't see any reason to complicate PMU virtualization =
for that
> > > > scenario, especially now that KVM synthesizes triple fault for L1.
> > >
> > > L1 can clear the virtual EFER.SVME. That is well-defined.
> >
> > Gah, I forgot that the H/G bits are ignored when EFER.SVME=3D0.  That's=
 really
> > annoying.
>
> What do you think about having two flavors of kvm_pmu_handle_nested_trans=
ition()?
> One that defers via a request, and a "special" (SVM-only?) version that d=
oes
> direct updates.

When would we use the deferred version? As far as the Intel PMU is
concerned. there's nothing special about a nested transition.

> Poking into PMU state in arbitrary contexts makes me nervous.  E.g. when =
calling
> svm_leave_nested(), odds are good EFER isn't even correct, and the update=
 *needs*
> to be deferred.
>
> I definitely don't love having two separate update mechanisms, but it see=
ms like
> the safest option in this case.
