Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C4B48E0CB
	for <kvm@vger.kernel.org>; Wed,  7 Oct 2026 11:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791373660; cv=none; b=eaACe6DYj5LJLUTZjXRLQG2y5mOlqdSTLtX4tip/YPrgphs5kHSOzVXbaqb0nZqfTelAob3iXSiB0g0rupCyVtNs2PJd8IVpFzZjsjzh9ZRIsT7Jal4xWLKHx+1YWu3qowoEDngqjnLcs6jWow9JCKE3CjPrzx1gDoAd5wV8GPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791373660; c=relaxed/simple;
	bh=4ad8P5yUT2vDVFJ0Bf3341ppGJihi0EpaQ68YhWsB+M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t7A3Er8sfL6/+SAtzYE3KCcYJMTY5ACdhPD+L0ybXTo0IQlxXvlKyIQJEtJ/fDg3wu7ZLih5/zy/gB91TYQa0dRzthy0f4/MillqVXKPQm01TtQ41XOYLrQZMmx2I7x7uRKapzO81wVoGqEvA/zdjFnwr/OjIjAbikhDRtnJE+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=dXHbJnqS; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="dXHbJnqS"
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4j0BFB3kWhzKnVD;
	Wed, 07 Oct 2026 13:47:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1791373646;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ff4I1Q51XBGNedTJ+V3+3eHnozyzalu5+4jPORD6yKE=;
	b=dXHbJnqS//EOamI/rJolbaJCGlwFfuS/DDI2/5VySSQUlygxBfcjnokPCGK0fKuZAbX7xT
	PNqWcddazftOTAErwWbkgAadqHoEcEUeFzozGeO0uPESRNFS0aEW8ddgn6NH+q2AEtu0cA
	mzV5Ppny52y0FgSXWIp0RhLD2yrfoq1wt+JZOOh0ULiA+z9/gEngB/lsuco+HuoDJ6Cp54
	YELYuEkpc1VlBZCsvDP3opg7byoBptEsZzl0KLApgeiFWFvi1WZWummuWV/CRDY31JnjoS
	1KDIOAZs2vrltwziwgMuh4z30Rt3zMYB0sW/5wrlHyRS6MbDludb9SWzUyctBg==
Date: Wed, 7 Oct 2026 13:47:18 +0200
From: SimonP <simonp.git@mailbox.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org
Subject: Re: [REGRESSION 7.2, BISECTED] KVM: x86: Starting Windows guest
 triggers UBSAN: array-index-out-of-bounds
Message-ID: <asYw47C3kHRtrzk8@mailbox.org>
References: <asUqYEisPp9MJ8mQ@rika.bernkas.tel>
 <CABgObfah3a03qwB8vsVNA67ffiHAYRHGjgCxydZzgqpWeXqduA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CABgObfah3a03qwB8vsVNA67ffiHAYRHGjgCxydZzgqpWeXqduA@mail.gmail.com>
X-MBO-RS-ID: ed65e9438258abf9ab3
X-MBO-RS-META: z9urek3zxpyg6eofcbo4ngz8ipow9f1h

On Wed, Oct 07, 2026 at 01:16:32PM +0200, Paolo Bonzini wrote:
> On Tue, Oct 6, 2026 at 7:37=E2=80=AFPM SimonP <simonp.git@mailbox.org> wr=
ote:
> > Hello,
> >
> > See subject. Happens in permission_fault() on line:
> >
> >         fault =3D (mmu->permissions[index] >> pte_access) & 1;
> >
> > Some output from a printk I added, not spammed but keeps happening:
> >
> > kvm: permission_fault(): pfec =3D 70, index =3D 35, not_smap =3D 0
>=20
> Can you confirm you are using nested virtualization, and if so what is
> the L1 hypervisor and L2 guest combination? Also what is the processor
> model?
>=20
> The issue is weird; it is caused by the SS bit which is apparently set
> in the #NPF exitcode; but it shouldn't be unless bit 4 is set in the
> misc_ctl field, and KVM never sets it. Can you check if the attached
> patch fixes it (modulo the fact that it shouldn't happen in the first
> place)?
>=20
> Thanks,
>=20
> Paolo
>=20

Will test the patch when I can but for now increment the weird counter
because there is no nesting, this is on a bare-metal hypervisor. The
guest is Windows 11. $(lscpu) is below.

Regards,
Simon

Architecture:                            x86_64
CPU op-mode(s):                          32-bit, 64-bit
Address sizes:                           48 bits physical, 48 bits virtual
Byte Order:                              Little Endian
CPU(s):                                  32
On-line CPU(s) list:                     0-31
Vendor ID:                               AuthenticAMD
Model name:                              AMD Ryzen 9 5950X 16-Core Processor
CPU family:                              25
Model:                                   33
Thread(s) per core:                      2
Core(s) per socket:                      16
Socket(s):                               1
Stepping:                                0
Microcode version:                       0xa201030
Frequency boost:                         disabled
CPU(s) scaling MHz:                      86%
CPU max MHz:                             5086.1812
CPU min MHz:                             582.1540
BogoMIPS:                                6799.84
Flags:                                   fpu vme de pse tsc msr pae mce cx8=
 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall =
nx mmxext fxsr_opt pdpe1gb rdtscp lm constant_tsc rep_good nopl xtopology n=
onstop_tsc cpuid extd_apicid aperfmperf rapl pni pclmulqdq monitor ssse3 fm=
a cx16 sse4_1 sse4_2 x2apic movbe popcnt aes xsave avx f16c rdrand lahf_lm =
cmp_legacy svm extapic cr8_legacy abm sse4a misalignsse 3dnowprefetch osvw =
ibs skinit wdt tce topoext perfctr_core perfctr_nb bpext perfctr_llc mwaitx=
 cat_l3 cdp_l3 hw_pstate ssbd mba ibrs ibpb stibp vmmcall fsgsbase bmi1 avx=
2 smep bmi2 erms invpcid cqm rdt_a rdseed adx smap clflushopt clwb sha_ni x=
saveopt xsavec xgetbv1 xsaves cqm_llc cqm_occup_llc cqm_mbm_total cqm_mbm_l=
ocal user_shstk clzero irperf xsaveerptr rdpru wbnoinvd arat npt lbrv svm_l=
ock nrip_save tsc_scale vmcb_clean flushbyasid decodeassists pausefilter pf=
threshold avic v_vmsave_vmload vgif v_spec_ctrl umip pku ospke vaes vpclmul=
qdq rdpid overflow_recov succor smca fsrm debug_swap
Virtualization:                          AMD-V
L1d cache:                               512 KiB (16 instances)
L1i cache:                               512 KiB (16 instances)
L2 cache:                                8 MiB (16 instances)
L3 cache:                                64 MiB (2 instances)
NUMA node(s):                            1
NUMA node0 CPU(s):                       0-31
Vulnerability Gather data sampling:      Not affected
Vulnerability Ghostwrite:                Not affected
Vulnerability Indirect target selection: Not affected
Vulnerability Itlb multihit:             Not affected
Vulnerability L1tf:                      Not affected
Vulnerability Mds:                       Not affected
Vulnerability Meltdown:                  Not affected
Vulnerability Mmio stale data:           Not affected
Vulnerability Old microcode:             Not affected
Vulnerability Reg file data sampling:    Not affected
Vulnerability Retbleed:                  Not affected
Vulnerability Spec rstack overflow:      Mitigation; Safe RET
Vulnerability Spec store bypass:         Mitigation; Speculative Store Bypa=
ss disabled via prctl
Vulnerability Spectre v1:                Mitigation; usercopy/swapgs barrie=
rs and __user pointer sanitization
Vulnerability Spectre v2:                Mitigation; Retpolines; IBPB condi=
tional; IBRS_FW; STIBP always-on; RSB filling; PBRSB-eIBRS Not affected; BH=
I Not affected
Vulnerability Srbds:                     Not affected
Vulnerability Tsa:                       Mitigation; Clear CPU buffers
Vulnerability Tsx async abort:           Not affected
Vulnerability Vmscape:                   Mitigation; IBPB before exit to us=
erspace

