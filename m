Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A2A33FE33;
	Wed,  8 Apr 2026 01:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775610886; cv=none; b=evuaJyEDHOCJIxzLIFXXEwEMjGwgtq06TDxeVTAIFnyteWjhTEGl4lIlchbhixm2yIWhJTPa8yILqJH5QZF+QnYNxn7NAwoggOZHpb3EXQy6Jw1OwrdeFGJcyRCPc/+wAjiThT2x+41CUc/0URkYJLJSRkJ92Wr6TVL1gpeZg6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775610886; c=relaxed/simple;
	bh=FBbr5QT9Q1lL7CS1XFZk8+uxRve5R2a6Qp6bqH0izzA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rCr/EdVdMXLNHch5DP3klTiNs+7Py6iVH3TxBel3Y1Y7o5s1A1XtWmUrGCRnJrT8lDrV1hMB+GESj5Xog1ReB58Sa230DxslN7nCAMHZl8glfkfmQw/43CuPQ4IVE9efXWKVJ0NPEuEjT6p+Wf3THyWksGFlCrcKAXlU1gl28rM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=iTbc1YHx; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="iTbc1YHx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xry111.site;
	s=default; t=1775610879;
	bh=o+wFNziVmSsueTmbnE/n9IiV0CVdiO6PlmE9xDYNEYY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=iTbc1YHxXH5iXMuz35WQcPyV+vhlDjeoriGNDn88A1gBT70wqutqhqACNnPfl7KDM
	 x2V/oFZTIlX412J86ZPUcHQfgDBU0BExlBOWJEXF52Hv4XiMTnSpnmCDjTmZ8Sdoqq
	 IlNs8Amw1ykvJkwqv/mtoSecUNjjwk4jLFwS+u2M=
Received: from [IPv6:2409:8a4c:e10:180:5633:9efb:acb8:d769] (unknown [IPv6:2409:8a4c:e10:180:5633:9efb:acb8:d769])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (secp384r1) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id 117BA65992;
	Tue,  7 Apr 2026 21:14:36 -0400 (EDT)
Message-ID: <0da59fbbfbf8894d12a496b0038735016e6a9123.camel@xry111.site>
Subject: Re: [PATCH v2 0/6] LoongArch: KVM: Set max VM supported FPU type
 with FPU exception
From: Xi Ruoyao <xry111@xry111.site>
To: Bibo Mao <maobibo@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>
Cc: kernel@xen0n.name, kvm@vger.kernel.org, loongarch@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Date: Wed, 08 Apr 2026 09:14:30 +0800
In-Reply-To: <61d0efa7-a15a-be48-3bca-5be5efd99acf@loongson.cn>
References: <20260330035832.2204720-1-maobibo@loongson.cn>
	 <CAAhV-H4Ws3Y89XfSXdGpm3BL5Pr5kTzC0NPdkDm17uy3ZEZJmA@mail.gmail.com>
	 <CAAhV-H7UP5TZh5zaqtkAboUt226-vGUBddksYXxafdKOioVngQ@mail.gmail.com>
	 <61d0efa7-a15a-be48-3bca-5be5efd99acf@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.0 
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-04-08 at 09:01 +0800, Bibo Mao wrote:
>=20
>=20
> On 2026/4/7 =E4=B8=8B=E5=8D=888:41, Huacai Chen wrote:
> > On Mon, Mar 30, 2026 at 6:00=E2=80=AFPM Huacai Chen <chenhuacai@kernel.=
org> wrote:
> > >=20
> > > Hi, Bibo,
> > >=20
> > >=20
> > > On Mon, Mar 30, 2026 at 11:58=E2=80=AFAM Bibo Mao <maobibo@loongson.c=
n> wrote:
> > > >=20
> > > > With FPU save and restore flow, the cost is the same with different
> > > > FPU width 8/16/32 bytes, whatever from CPU cycle and cache line imp=
action.
> > > >=20
> > > > Here is to enable FPU with max VM supported type, for example if
> > > > VM supports LASX instrction, enable FPU with LASX type even with FP=
U
> > > > exeception. So it can avoid possible LSX/LASX exception in future.
> > > >=20
> > > > With context switch microbench which may touch FPU and LASX, there =
is 9%
> > > > improvement when halt_poll_ns is disabled. The command is
> > > > "./context --test=3Dpipe" and source code located at:
> > > > =C2=A0=C2=A0 https://github.com/bibo-mao/context_switch/blob/main/c=
ontext.c
> > > >=20
> > > > Original=C2=A0=C2=A0=C2=A0=C2=A0 Wih patch=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 improvement
> > > > 75232=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 82440=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 9%
> > > >=20
> > > > Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> > > > ---
> > > > v1 ... v2:
> > > > =C2=A0=C2=A0 1. Enable FPU with max VM supported FPU type, rather t=
han max used type.
> > > > =C2=A0=C2=A0 2. Add new request bit KVM_REQ_LBT_LOAD for LBT restor=
e
> > > > =C2=A0=C2=A0 3. Rename KVM_REQ_AUX_LOAD with KVM_REQ_FPU_LOAD
> > > > =C2=A0=C2=A0 3. Remove aux_ldtype and KVM_LARCH_LSX/KVM_LARCH_LSX
> > > > =C2=A0=C2=A0 4. Remove middle FPU state handling in kvm_own_lsx() a=
nd kvm_own_lasx(),
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 directly enable LSX or LASX from FPU=
 none state.
> > > > ---
> > > > Bibo Mao (6):
> > > > =C2=A0=C2=A0 LoongArch: KVM: Add separate KVM_REQ_LBT_LOAD request =
bit
> > > > =C2=A0=C2=A0 LoongArch: KVM: Enable FPU with max VM supported FPU t=
ype
> > > > =C2=A0=C2=A0 LoongArch: KVM: Rename KVM_REQ_AUX_LOAD with KVM_REQ_F=
PU_LOAD
> > > Patch-1 add KVM_REQ_LBT_LOAD, then KVM_REQ_AUX_LOAD is only for FPU,
> > > so I think Patch-3 should be squashed into Patch-1.
> > >=20
> > > > =C2=A0=C2=A0 LoongArch: KVM: Remove some middle FPU states
> > > > =C2=A0=C2=A0 LoongArch: KVM: Use vm_guest_has_fpu API in kvm_lose_f=
pu()
> > > > =C2=A0=C2=A0 LoongArch: KVM: Remove KVM_LARCH_LASX and KVM_LARCH_LS=
X
> > > Patch-5 remove the consumer side of KVM_LARCH_LASX / KVM_LARCH_LSX an=
d
> > > Patch-6 remove the provider side of KVM_LARCH_LASX / KVM_LARCH_LSX, s=
o
> > > I think Patch-6 should be squashed into Patch-5, too.
> > And could you please test the power consumption where there are many
> > VMs that only use FPU rather than LSX/LASX? As far as I know, the
> Hi Huacai,
>=20
> Thanks for reviewing this patch
> Could you help me to test the power consumption with this patch?
> > power consumption of LASX is significantly more than FPU, which is a
> Could the describe the detail scenery wheree LASX instruction is=20
> frequently used by application or LASX=C2=A0 EUEN enabled?

FWIW in the most common real scenarios, the ifunc resolving mechanism of
glibc immediately invokes LASX on program startup if CPU supports LASX
(see _dl_runtime_resolve_lasx in glibc/sysdeps/loongarch/dl-
trampoline.h).  Thus for almost all user-space processes LASX is enabled
in EUEN as long as the CPU supports LASX.  Relying on disabling LASX in
EUEN for power-saving just doesn't work.


--=20
Xi Ruoyao <xry111@xry111.site>
