Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE7D4772B7
	for <kvm@vger.kernel.org>; Thu, 27 Aug 2026 16:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787848859; cv=none; b=aqJJ889S63kIMhpbkK5uSGML2knKmYfnJSXKVvPSLmMDhCvIN4u7RQy0kj9VClRexPHLGmEJlawbBCWKyYvsG7R5JZSOwVuRQ23AoHZyxSWM8D8eFigkRi6YRKWzDYhwENLlgo/U/dPIiGcBqd8ALwNiuoUyhBPuiwJymdrkDSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787848859; c=relaxed/simple;
	bh=3RgWJPqR+k2kAyb+h26t7VLBS/Y8cHOim0OG+ifIW/A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GIR0YWiKQGXxQ8ACaIZPJ+1Uyf4Lp/76xAIFdIJnvelmqWVgpuvS3vaIYzuGHHci4TYYwY0Ms32VvWy5EajLG47tt0ik6oq2c3szgeqUwc6dy9sJBb2nvVQQ61fXhG2UMWv86cWnKy3e6aA8vfLa2fzrjHY2yM6w5jn5Itu9YZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XN5UQnY5; arc=none smtp.client-ip=209.85.214.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XN5UQnY5"
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2d6df0a1e18so487435ad.1
        for <kvm@vger.kernel.org>; Thu, 27 Aug 2026 09:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787848858; x=1788453658; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=EXTcnuR86zTqexqR/SscPdSfeGGfX0bPmu2TCfahQQ4=;
        b=XN5UQnY5tn4uxiPpTm/sHjbsWwm7W4KjW+eN8JRZ60YQvF8ZDgtC7aGxr9PWD+RIdl
         x0wJSNpnAEmFoQ9FeWhDpKb1NMHUqAg/E0pDMftITVkTxjvCmYAOUJO8GOiNYGt0HiQA
         n+TrEkQr3vB6vH/jVoo/FS9VP+E5pyYp9fFB+8GTOTkLc9k4EVFnIGk86q20GQzVE1jw
         NThU5k2TR8Hc8xXiA6qFEUVb69KeMKABL84ltDG1afAvpHhAcYeuGTHmylr92Ox92AgC
         Gqg/faki9i0V2fCTebkBDnTe5zonb0uxY1+3VTBON1wtubaXiDpqmdYxchOTiSkurclv
         vTkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787848858; x=1788453658;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EXTcnuR86zTqexqR/SscPdSfeGGfX0bPmu2TCfahQQ4=;
        b=GXJPyD3E+TvMzd9OMWHvECVEMH+PiyKhJrLJqpHujJVJTvcQCE0uPbeUZbv8hyKyiB
         Wv3bIDi8vf5OG57/z+ci1lWGomEswu9RMOuB9UF/iu3Lk2z7gVl1PjyhzihD7B+S3URS
         ZJ7noZHd0djTIfOrJR+UtHnztC0Y8NHEGrn4JcytXuqjMCOBHzpR0ZgBv2tMoOrr+6Qv
         CMB+gLJKdlF15lCUwav8J0WgyixszpJoL4+Zh6dMR3rz3gxEXrCGnkFsIzsUWHyiEaYl
         4XO1sSqZsL5kGMrb6xlxFhMVhub36jhEduFTqcQgmUNzngD8ihnwkDiP7EnSAP3ikJOt
         8fvg==
X-Forwarded-Encrypted: i=1; AHgh+RoVAaqNsGUSHqs0vC7byoV4mSivHm0uQl75HoAoVPW3aVtyMUa/mV8plr8dS46VzZ/5uWY=@vger.kernel.org
X-Gm-Message-State: AFuF++k7rq7vcEBzoJ92oAVSncWWpH8X/wVivAisKfJjHl+4C4KA/9Ad
	e4yCu8Wf1aQPC9spxUwy5qtjfX8fQgKNw9fQsO1Gwnw9qhy6qPa89HVSH0EdA9d72rDiHRx2+Vw
	9k+usSA==
X-Received: from plbmb13.prod.google.com ([2002:a17:903:98d:b0:2d7:1639:625a])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:22ca:b0:2d6:fd55:3a9d
 with SMTP id d9443c01a7336-2d74dc111bcmr4867765ad.3.1787848857248; Thu, 27
 Aug 2026 09:40:57 -0700 (PDT)
Date: Thu, 27 Aug 2026 09:40:56 -0700
In-Reply-To: <CAO9r8zOuD+wU1Q80z077WHHpFBWvKomLk=TaXjH3gVnqj=mqFQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260826233919.998904-1-seanjc@google.com> <20260826233919.998904-13-seanjc@google.com>
 <CAO9r8zOuD+wU1Q80z077WHHpFBWvKomLk=TaXjH3gVnqj=mqFQ@mail.gmail.com>
Message-ID: <apBomFOn1ZqHEnAQ@google.com>
Subject: Re: [PATCH v3 12/13] KVM: selftests: Dedup assembly code for VMLAUNCH
 and VMRESUME
From: Sean Christopherson <seanjc@google.com>
To: Yosry Ahmed <yosry@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	f734222792@gmail.com, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Sashiko Bot <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 26, 2026, Yosry Ahmed wrote:
> On Wed, Aug 26, 2026 at 4:39=E2=80=AFPM Sean Christopherson <seanjc@googl=
e.com> wrote:
> >
> > Dedup the assembly code from VMLAUNCH vs. VMRESUME, the difference is
> > literally only the actual VM-Enter instruction.
>=20
> You couldn't resist macrofiying this too.

It's either that or throw a branch in the asm blob, which is surprisingly
difficult because VMX_SWITCH_GPRS_ASM subtly clobbers RFLAGS and obviously
clobbers GPRs.  Which basically leaves pushing the value on the stack, whic=
h is
totally doable, but still annoying, and needs to be done immediately, befor=
e
vmcs.HOST_RSP is loaded.  Branching at runtime also makes the generated cod=
e
harder to read, e.g. when debugging, as it's not immediately obvious which
instruction was actually attempted.

That said, looking at this again made me realize evmcs_{vmlaunch,vmresume}(=
) have
the same core copy+paste mess.  Blech.  Macrofying the standard flows but n=
ot the
eVMCS flows is rather silly.

Inlining these blobs *twice* (VMCS vs. eVMCS) at every VM-Enter is also rid=
iculous.
E.g. at a glance, it's responsible for something ~100k bytes of code in the=
 compiled
state_test.  While the code footprint of selftests isn't a priority, that's=
 still
absurd.

So instead of macrofying everything, how about this?  Depending on how one =
feels
about macro shenanigans, it's either horrific or amazing.  Or both.  But IM=
O it's
worth eliminating all of the copy+paste, and it makes the control flow much=
 easier
to read, which in practice is likely what most people care about?  At least=
 until
the entry/exit sequence fails and they have to debug macro hell :-)

vmx.c:

 =20
  #define __BUILD_VMX_VM_ENTRY_HELPER(insn, prefix, vmwrite_insn, vmwrite_o=
perand,	\
  				    __host_rsp, __host_rip)				\
  static int __##prefix##_##insn(void)							\
  {											\
  	int ret;									\
  											\
  	__asm__ __volatile__("push $0;"							\
  			     __stringify(vmwrite_insn) " %%rsp, %[host_rsp];"		\
  			     "lea 1f(%%rip), %%rax;"					\
  			     __stringify(vmwrite_insn) " %%rax, %[host_rip];"		\
  			     VMX_SWITCH_GPRS_ASM					\
  			     __stringify(insn)";"					\
  			     "incq (%%rsp);"						\
  			     "1: ;"							\
  			     VMX_SWITCH_GPRS_ASM					\
  			     "pop %%rax;"						\
  			     : [ret]"=3D&a"(ret)						\
  			     : [host_rsp]__stringify(vmwrite_operand)(__host_rsp),	\
  			       [host_rip]__stringify(vmwrite_operand)(__host_rip),	\
  			       GUEST_REGS_OFFSETS					\
  			     : "memory", "cc");						\
  	return ret;									\
  }
 =20
  #define BUILD_VMX_VM_ENTRY_HELPER(insn) \
  	__BUILD_VMX_VM_ENTRY_HELPER(insn, _, vmwrite, r, (u64)HOST_RSP, (u64)HOS=
T_RIP)	\
  	__BUILD_VMX_VM_ENTRY_HELPER(insn, __evmcs, mov, m,				\
  				    current_evmcs->host_rsp, current_evmcs->host_rip)
 =20
  BUILD_VMX_VM_ENTRY_HELPER(vmlaunch)
  BUILD_VMX_VM_ENTRY_HELPER(vmresume)
 =20
  int __vmlaunch(void)
  {
  	if (enable_evmcs) {
  		current_evmcs->hv_clean_fields =3D 0;
  		return ____evmcs_vmlaunch();
  	}
 =20
  	return ____vmlaunch();
  }
 =20
  int __vmresume(void)
  {
  	if (enable_evmcs) {
  		/* HOST_RIP */
  		current_evmcs->hv_clean_fields &=3D ~HV_VMX_ENLIGHTENED_CLEAN_FIELD_HOS=
T_GRP1;
  		/* HOST_RSP */
  		current_evmcs->hv_clean_fields &=3D ~HV_VMX_ENLIGHTENED_CLEAN_FIELD_HOS=
T_POINTER;
  		return ____evmcs_vmresume();
  	}
 =20
  	return ____vmresume();
  }

vmx.h:

  int __vmlaunch(void);
  int __vmresume(void);
 =20
  static inline int vmlaunch(void)
  {
  	return __vmlaunch();
  }
 =20
  static inline int vmresume(void)
  {
  	return __vmresume();
  }

And then the next patch becomes:

    KVM: selftests: Assert success in vmlaunch() and vmresume()
   =20
    Assert success in the "outer" APIs for VMLAUNCH and VMRESUME to dedup a
    pile of code, and switch to the double-underscores versions as necessar=
y,
    to make it more obvious which paths expect VM-Enter *failure*.
   =20
    Signed-off-by: Sean Christopherson <seanjc@google.com>

diff --git tools/testing/selftests/kvm/include/x86/vmx.h tools/testing/self=
tests/kvm/include/x86/vmx.h
index d0ac8e128d98..1419043b41dd 100644
--- tools/testing/selftests/kvm/include/x86/vmx.h
+++ tools/testing/selftests/kvm/include/x86/vmx.h
@@ -362,14 +362,14 @@ static inline u64 vmptrst(void)
 int __vmlaunch(void);
 int __vmresume(void);
=20
-static inline int vmlaunch(void)
+static inline void vmlaunch(void)
 {
-	return __vmlaunch();
+	__GUEST_ASSERT(!__vmlaunch(), "vmlaunch hit VM-Fail");
 }
=20
-static inline int vmresume(void)
+static inline void vmresume(void)
 {
-	return __vmresume();
+	__GUEST_ASSERT(!__vmresume(), "vmresume hit VM-Fail");
 }
=20
 static inline void vmcall(void)

> > +#define BUILD_VMX_VM_ENTRY_HELPERS(insn)                              =
 \
>=20
> s/HELPERS/HELPER?
>=20
> or maybe better: DEFINE_VMX_VM_ENTRY_HELPER()?

Because after the next patch, there are two helpers for each instruction, v=
mresume()
and __vmresume(), and churning the macros to add the 'S' felt silly.  But, =
with the
above, this is a moot point.

> With the rename:
>=20
> Reviewed-by: Yosry Ahmed <yosry@kernel.org>
>=20
> (Who's f734222792@gmail.com?)

An anonymous bug reporter: https://bugzilla.kernel.org/show_bug.cgi?id=3D22=
1841
